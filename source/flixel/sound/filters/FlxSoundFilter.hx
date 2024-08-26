package flixel.sound.filters;

import flixel.util.FlxDestroyUtil;
#if lime_openal
import lime.media.openal.AL;
import lime.media.openal.ALFilter;
import lime.media.openal.ALSource;
#end
import flixel.sound.FlxSound;
import flixel.FlxBasic;

/**
 * An object that can be used to apply audio filters to a `FlxSound` object.
 * A `FlxSoundFilter` contains a single Direct filter and a list of Auxiliary effects. 
 */
class FlxSoundFilter extends FlxBasic
{
	/**
	 * The type of direct filter used on the sound.
	 * 
	 * `LOWPASS` will allow for the volume of high frequency sounds to be reduced.
	 * 
	 * `HIGHPASS` will allow for the volume of low frequency sounds to be reduced.
	 * 
	 * `BANDPASS` will allow for the volume of both low and high frequency sounds to be reduced individually.
	 */
	public var filterType:FlxSoundFilterType = NONE;
	
	/**
	 * Adjusts the gain/volume of the sound. (0.0 - 1.0)
	 * Used with any `filterType` besides for `NONE`
	 */
	public var gain:Float = 1.0;

	/**
	 * Adjusts the gain/volume of high frequency sounds. (0.0 - 1.0)
	 * Used with `filterType` `LOWPASS` and `BANDPASS`.
	 */
	public var gainHF:Float = 1.0;

	/**
	 * Adjusts the gain/volume of low frequency sounds. (0.0 - 1.0)
	 * Used with `filterType` `HIGHPASS` and `BANDPASS`.
	 */
	public var gainLF:Float = 1.0;

	/**
	 * Determines if the filter should be automatically destroyed whenever a `FlxFilteredSound` with this filter is destroyed.
	 */
	public var destroyWithSound:Bool = true;

	#if lime_openal
	private var _filter:ALFilter;
	#end
	private var _effects:Array<FlxSoundBaseEffect> = [];
	private var _dirtyEffectsCount:Int = -1;
	
	public function new()
	{
		super();
		#if lime_openal
		_filter = AL.createFilter();
		#end
	}

	/**
	 * Applies the current filter settings onto a `FlxSound`.
	 * If not updated constantly, the sound may lose its filter after unfocusing the game window.
	 * @param sound The sound to apply filters to.
	 */
	public function applyFilter(sound:FlxSound)
	{
		#if lime_openal
		var soundSource:ALSource = getSoundSource(sound);
		if (soundSource == null) return;

		if (_dirtyEffectsCount != -1)
		{
			//need to remove first because the amount of effects has lowered
			for (i in 0..._dirtyEffectsCount)
			{
				AL.removeSend(soundSource, i);
			}
			_dirtyEffectsCount = -1;
		}

		AL.filteri(_filter, AL.FILTER_TYPE, filterType);
		switch(filterType)
		{
			case NONE:
			case LOWPASS:
				AL.filterf(_filter, AL.LOWPASS_GAIN, gain);
				AL.filterf(_filter, AL.LOWPASS_GAINHF, gainHF);
			case HIGHPASS:
				AL.filterf(_filter, AL.HIGHPASS_GAIN, gain);
				AL.filterf(_filter, AL.HIGHPASS_GAINLF, gainLF);
			case BANDPASS:
				AL.filterf(_filter, AL.BANDPASS_GAIN, gain);
				AL.filterf(_filter, AL.BANDPASS_GAINLF, gainLF);
				AL.filterf(_filter, AL.BANDPASS_GAINHF, gainHF);
		}
		AL.sourcei(soundSource, AL.DIRECT_FILTER, _filter);

		for (i in 0..._effects.length)
		{
			_effects[i].updateEffect();
			AL.source3i(soundSource, AL.AUXILIARY_SEND_FILTER, _effects[i]._auxSlot, i, AL.EFFECT_NULL);
		}
		#end
	}

	/**
	 * Removes the filter/effects of this from a `FlxSound`.
	 * This assumes the sound already has the same filters applied! If the sound currently has a larger amount of effects enabled it may not remove them all! 
	 * @param sound The sound to remove filters from.
	 */
	public function removeFilter(sound:FlxSound)
	{
		#if lime_openal
		var soundSource:ALSource = getSoundSource(sound);
		if (soundSource == null) return;

		AL.removeDirectFilter(soundSource);
		for (i in 0..._effects.length)
		{
			AL.removeSend(soundSource, i);
		}
		#end
	}

	private inline function getSoundSource(sound:FlxSound)
	{
		#if lime_openal
		var soundSource:ALSource = null;
		
		@:privateAccess
		if (sound != null && sound._channel != null)
		{
			soundSource = sound._channel.__audioSource.__backend.handle;
		}			

		return soundSource;
		#else
		return null;
		#end
	}

	/**
	 * Adds an auxiliary effect to the filter.
	 * @param effect The effect to add.
	 */
	public function addEffect(effect:FlxSoundBaseEffect)
	{
		_effects.push(effect);
	}

	/**
	 * Removes an auxiliary effect from the filter. This does not destroy the effect!
	 * @param effect The effect to remove.
	 */
	public function removeEffect(effect:FlxSoundBaseEffect)
	{
		if (_dirtyEffectsCount == -1) _dirtyEffectsCount = _effects.length;
		_effects.remove(effect);
	}

	/**
	 * Clears any existing effects added to this filter.
	 * @param destroy changes if effects should be destroyed or not.
	 */
	public function clearEffects(destroy:Bool = true)
	{
		if (_dirtyEffectsCount == -1) _dirtyEffectsCount = _effects.length;
		if (destroy) FlxDestroyUtil.destroyArray(_effects);
		_effects = [];
	}

	/**
	 * Returns the effect stored at the specified index
	 */
	public function getEffectAt(index:Int) 
	{ 
		return _effects[index]; 
	}

	override public function destroy()
	{
		FlxDestroyUtil.destroyArray(_effects);
		#if lime_openal
		_filter = null;
		#end
	}
}
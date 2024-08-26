package flixel.sound.filters;

#if lime_openal
import lime.media.openal.AL;
import lime.media.openal.ALEffect;
import lime.media.openal.ALAuxiliaryEffectSlot;
#end

import flixel.FlxBasic;

/**
 * Base effect used for `FlxSoundFilter`.
 */
class FlxSoundBaseEffect extends FlxBasic
{
	#if lime_openal
	@:allow(flixel.sound.filters.FlxSoundFilter)
	private var _auxSlot:ALAuxiliaryEffectSlot;
	private var _effect:ALEffect;
	#end

	public function new()
	{
		super();
		#if lime_openal
		_auxSlot = AL.createAux();
		_effect = AL.createEffect();
		#end
	}
	
	@:allow(flixel.sound.filters.FlxSoundFilter)
	private function updateEffect()
	{
		#if lime_openal
		AL.auxi(_auxSlot, AL.EFFECTSLOT_EFFECT, _effect);
		#end
	}

	override public function destroy()
	{
		#if lime_openal
		_auxSlot = null;
		_effect = null;
		#end
	}
}
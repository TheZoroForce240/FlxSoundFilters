package flixel.sound.filters.effects;

import flixel.sound.filters.FlxSoundBaseEffect;
#if lime_openal
import lime.media.openal.AL;
#end

/**
 * Flanger effect
 * 
 * See [here](https://openal-soft.org/misc-downloads/Effects%20Extension%20Guide.pdf) for specific details on each value
 * 
 * Use `FlxSoundFilter` to add this onto a `FlxSound` (use `addEffect()`)
 */
class FlxSoundFlangerEffect extends FlxSoundBaseEffect
{
	public var waveform:Int = 1;
	public var phase:Int = 0;
	public var rate:Float = 0.27;
	public var depth:Float = 1.0;
	public var feedback:Float = -0.5;
	public var delay:Float = 0.002;

	override private function updateEffect()
	{
		#if lime_openal
		AL.effecti(_effect, AL.EFFECT_TYPE, AL.EFFECT_FLANGER);

		AL.effecti(_effect, AL.FLANGER_WAVEFORM, waveform);
		AL.effecti(_effect, AL.FLANGER_PHASE, phase);
		AL.effectf(_effect, AL.FLANGER_RATE, rate);
		AL.effectf(_effect, AL.FLANGER_DEPTH, depth);
		AL.effectf(_effect, AL.FLANGER_FEEDBACK, feedback);
		AL.effectf(_effect, AL.FLANGER_DELAY, delay);

		#end

		super.updateEffect();
	}
}
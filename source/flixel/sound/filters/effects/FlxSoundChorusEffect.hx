package flixel.sound.filters.effects;

import flixel.sound.filters.FlxSoundBaseEffect;
#if lime_openal
import lime.media.openal.AL;
#end

/**
 * Chorus effect
 * 
 * See [here](https://openal-soft.org/misc-downloads/Effects%20Extension%20Guide.pdf) for specific details on each value
 * 
 * Use `FlxSoundFilter` to add this onto a `FlxSound` (use `addEffect()`)
 */
class FlxSoundChorusEffect extends FlxSoundBaseEffect
{
	public var waveform:Int = 1;
	public var phase:Int = 0;
	public var rate:Float = 1.1;
	public var depth:Float = 0.1;
	public var feedback:Float = 0.25;
	public var delay:Float = 0.016;

	override private function updateEffect()
	{
		#if lime_openal
		AL.effecti(_effect, AL.EFFECT_TYPE, AL.EFFECT_CHORUS);

		AL.effecti(_effect, AL.CHORUS_WAVEFORM, waveform);
		AL.effecti(_effect, AL.CHORUS_PHASE, phase);
		AL.effectf(_effect, AL.CHORUS_RATE, rate);
		AL.effectf(_effect, AL.CHORUS_DEPTH, depth);
		AL.effectf(_effect, AL.CHORUS_FEEDBACK, feedback);
		AL.effectf(_effect, AL.CHORUS_DELAY, delay);

		#end

		super.updateEffect();
	}
}
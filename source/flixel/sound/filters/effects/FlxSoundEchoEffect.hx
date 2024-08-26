package flixel.sound.filters.effects;

import flixel.sound.filters.FlxSoundBaseEffect;
#if lime_openal
import lime.media.openal.AL;
#end

/**
 * Echo effect
 * 
 * See [here](https://openal-soft.org/misc-downloads/Effects%20Extension%20Guide.pdf) for specific details on each value
 * 
 * Use `FlxSoundFilter` to add this onto a `FlxSound` (use `addEffect()`)
 */
class FlxSoundEchoEffect extends FlxSoundBaseEffect
{
	public var delay:Float = 0.1;
	public var lrDelay:Float = 0.1;
	public var damping:Float = 0.5;
	public var feedback:Float = 0.5;
	public var spread:Float = -1.0;

	override private function updateEffect()
	{
		#if lime_openal
		AL.effecti(_effect, AL.EFFECT_TYPE, AL.EFFECT_ECHO);

		AL.effectf(_effect, AL.ECHO_DELAY, delay);
		AL.effectf(_effect, AL.ECHO_LRDELAY, lrDelay);
		AL.effectf(_effect, AL.ECHO_DAMPING, damping);
		AL.effectf(_effect, AL.ECHO_FEEDBACK, feedback);
		AL.effectf(_effect, AL.ECHO_SPREAD, spread);

		#end

		super.updateEffect();
	}
}
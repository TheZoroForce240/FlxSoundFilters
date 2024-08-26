package flixel.sound.filters.effects;

import flixel.sound.filters.FlxSoundBaseEffect;
#if lime_openal
import lime.media.openal.AL;
#end

/**
 * Distortion effect
 * 
 * See [here](https://openal-soft.org/misc-downloads/Effects%20Extension%20Guide.pdf) for specific details on each value
 * 
 * Use `FlxSoundFilter` to add this onto a `FlxSound` (use `addEffect()`)
 */
class FlxSoundDistortionEffect extends FlxSoundBaseEffect
{
	public var edge:Float = 0.2;
	public var gain:Float = 0.05;
	public var lowpassCutoff:Float = 8000.0;
	public var eqCenter:Float = 3600.0;
	public var eqBandwidth:Float = 3600.0;

	override private function updateEffect()
	{
		#if lime_openal
		AL.effecti(_effect, AL.EFFECT_TYPE, AL.EFFECT_DISTORTION);

		AL.effectf(_effect, AL.DISTORTION_EDGE, edge);
		AL.effectf(_effect, AL.DISTORTION_GAIN, gain);
		AL.effectf(_effect, AL.DISTORTION_LOWPASS_CUTOFF, lowpassCutoff);
		AL.effectf(_effect, AL.DISTORTION_EQCENTER, eqCenter);
		AL.effectf(_effect, AL.DISTORTION_EQBANDWIDTH, eqBandwidth);

		#end

		super.updateEffect();
	}
}
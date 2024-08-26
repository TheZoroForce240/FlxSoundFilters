package flixel.sound.filters.effects;

import flixel.sound.filters.FlxSoundBaseEffect;
#if lime_openal
import lime.media.openal.AL;
#end
/**
 * Pitch Shifter effect
 * 
 * (Note: sound quality gets bad when using this!)
 * 
 * See [here](https://openal-soft.org/misc-downloads/Effects%20Extension%20Guide.pdf) for specific details on each value
 * 
 * Use `FlxSoundFilter` to add this onto a `FlxSound` (use `addEffect()`)
 */
class FlxSoundPitchShifterEffect extends FlxSoundBaseEffect
{
	public var coarseTune:Int = 0;
	public var fineTune:Int = 0;

	override private function updateEffect()
	{
		#if lime_openal
		AL.effecti(_effect, AL.EFFECT_TYPE, AL.EFFECT_PITCH_SHIFTER);

		AL.effecti(_effect, AL.PITCH_SHIFTER_COARSE_TUNE, coarseTune);
		AL.effecti(_effect, AL.PITCH_SHIFTER_FINE_TUNE, fineTune);

		#end

		super.updateEffect();
	}
}
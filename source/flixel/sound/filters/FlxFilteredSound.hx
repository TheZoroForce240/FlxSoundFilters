package flixel.sound.filters;

import flixel.util.FlxDestroyUtil;
import flixel.sound.FlxSound;

/**
 * A type of `FlxSound` that can have a `FlxSoundFilter` attached and automatically update it.
 */
class FlxFilteredSound extends FlxSound
{
	/**
	 * The audio filter used for this sound.
	 */
	public var filter(default, set):FlxSoundFilter;

	private function set_filter(value:FlxSoundFilter)
	{
		if (filter == value) 
			return filter; //no change

		if (filter != null) 
			filter.removeFilter(this); //remove existing filter

		if (value != null) 
			value.applyFilter(this); //apply new filter

		return filter = value;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (filter != null)
			filter.applyFilter(this);
	}

	override public function destroy()
	{
		if (filter != null && filter.destroyWithSound)
			FlxDestroyUtil.destroy(filter);

		super.destroy();
	}
}
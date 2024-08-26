package flixel.sound.filters;

enum abstract FlxSoundFilterType(Int) from Int to Int
{
	var NONE = 0x0000;
	var LOWPASS = 0x0001;
	var HIGHPASS = 0x0002;
	var BANDPASS = 0x0003;
}
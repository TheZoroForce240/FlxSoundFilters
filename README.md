# FlxSoundFilters
 
Adds easy support for OpenAL filters and effects on FlxSounds.

Only works when using OpenAL! (so no HTML or Flash I think)

Not all OpenAL effects have been implemented yet!

## Installation
* Run this command to install the haxelib
```
haxelib git flxsoundfilters https://github.com/TheZoroForce240/FlxSoundFilters
```
* Add "flxsoundfilters" to the project.xml
```xml
<haxelib name="flxsoundfilters" />
```

## Example Usage

Using FlxFilteredSound (auto updates and stores filter)
```haxe
var sound = new FlxFilteredSound();
sound.loadEmbedded("flixel/sounds/flixel.ogg");
FlxG.sound.list.add(sound);
FlxG.sound.defaultSoundGroup.add(sound);
sound.play();

sound.filter = new FlxSoundFilter();
sound.filter.filterType = FlxSoundFilterType.LOWPASS;
sound.filter.gainHF = 0.2;
```
Using regular FlxSound
```haxe

var sound:FlxSound;
var filter:FlxSoundFilter;

function create()
{
    super.create();
    sound = FlxG.sound.play("assets/music/test.ogg");

    filter = new FlxSoundFilter();
    filter.filterType = FlxSoundFilterType.BANDPASS;
    filter.gainLF = 0.05;
    add(filter); //add so the filter will be destroyed automatically by the state (or destroy manually when not needed)
}

function update(elapsed:Float)
{
    super.update(elapsed);
    if (sound != null && sound.playing)
    {
         filter.applyFilter(sound);
    }
}

```
Adding an effect to a filter
```haxe
var reverb = new FlxSoundReverbEffect();
sound.filter.addEffect(reverb);
reverb.decayTime = 3.5;
```

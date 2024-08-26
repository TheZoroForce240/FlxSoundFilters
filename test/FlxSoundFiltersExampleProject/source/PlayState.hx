package;

import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUIDropDownMenu;
import flixel.text.FlxText;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.FlxGraphic;
import flixel.system.FlxAssets;
import flixel.sound.filters.*;
import flixel.sound.filters.effects.*;
import flixel.addons.ui.FlxSlider;
import flixel.ui.FlxButton;

import flixel.util.FlxStringUtil;

using StringTools;

class PlayState extends FlxState
{
	var sound:FlxFilteredSound;
	var reverb:FlxSoundReverbEffect;

	var timeText:FlxText;
	
	override public function create()
	{
		super.create();

		sound = new FlxFilteredSound();
		sound.loadEmbedded("flixel/sounds/flixel.ogg");
		FlxG.sound.list.add(sound);
		FlxG.sound.defaultSoundGroup.add(sound);
		sound.play();
		
		sound.filter = new FlxSoundFilter();
		sound.filter.filterType = FlxSoundFilterType.BANDPASS;

		reverb = new FlxSoundReverbEffect();
		sound.filter.addEffect(reverb);
		reverb.decayTime = 3.5;

		timeText = new FlxText(5,5,	FlxG.width,"", 32);
		timeText.alignment = CENTER;
		add(timeText);

		setupDirectFilterUI();
		setupReverbUI();

		var playButton = new FlxButton(0, 50, "Play Sound", function() { sound.play(); }); add(playButton); playButton.screenCenter(X);
	}

	inline function setupDirectFilterUI()
	{
		var filterText = new FlxText(25,100,0, "Direct Filter", 24);
		filterText.alignment = CENTER;
		add(filterText);

		var gainSlider = new FlxSlider(sound.filter, "gain", 50, 150, 0, 1, 100, 10, 10, 0xFF1274FE); add(gainSlider);
		var gainLFSlider = new FlxSlider(sound.filter, "gainLF", 50, 200, 0, 1, 100, 10, 10, 0xFF1274FE); add(gainLFSlider);
		var gainHFSlider = new FlxSlider(sound.filter, "gainHF", 50, 250, 0, 1, 100, 10, 10, 0xFF1274FE); add(gainHFSlider);

		var directFilterTypeNames = ["NONE", "LOWPASS", "HIGHPASS", "BANDPASS"];
		var directFilters = [FlxSoundFilterType.NONE, FlxSoundFilterType.LOWPASS, FlxSoundFilterType.HIGHPASS, FlxSoundFilterType.BANDPASS];
		var filterDropDown = new FlxUIDropDownMenu(50, 300, FlxUIDropDownMenu.makeStrIdLabelArray(directFilterTypeNames, true), function(id)
		{
			sound.filter.filterType = directFilters[Std.parseInt(id)];

			gainSlider.active = gainSlider.visible = sound.filter.filterType != NONE;
			gainLFSlider.active = gainLFSlider.visible = sound.filter.filterType == BANDPASS || sound.filter.filterType == HIGHPASS;
			gainHFSlider.active = gainHFSlider.visible = sound.filter.filterType == BANDPASS || sound.filter.filterType == LOWPASS;
		});
		filterDropDown.selectedLabel = "BANDPASS";
		add(filterDropDown);
	}

	inline function createReverbSlider(x, y, name, min, max)
	{
		var slider = new FlxSlider(reverb, name, x, y, min, max, 100, 10, 10, 0xFF9012FE); 
		add(slider);
	}

	inline function setupReverbUI()
	{
		var reverbText = new FlxText(400,100,0, "Reverb Effect", 24);
		reverbText.alignment = CENTER;
		add(reverbText);

		createReverbSlider(360, 150, "density", 0, 1);
		createReverbSlider(490, 150, "diffusion", 0, 1);
		createReverbSlider(360, 200, "gain", 0, 1);
		createReverbSlider(490, 200, "gainHF", 0, 1);
		createReverbSlider(360, 250, "decayTime", 0.1, 20.0);
		createReverbSlider(490, 250, "decayHFRatio", 0.1, 2.0);
		createReverbSlider(360, 300, "reflectionsGain", 0.0, 3.16);
		createReverbSlider(490, 300, "reflectionsDelay", 0.0, 0.3);
		createReverbSlider(360, 350, "lateGain", 0.0, 10);
		createReverbSlider(490, 350, "lateDelay", 0.0, 0.1);
		createReverbSlider(360, 400, "airAbsorptionGainHF", 0.892, 1.0);
		createReverbSlider(490, 400, "roomRolloff", 0.0, 10);

		var decayHFLimit = new FlxUICheckBox(240, 400, null, null, "Decay HF Limit", 100, null, null);
		var callback = function()
		{
			if (decayHFLimit.checked)
				reverb.decayHFLimit = 1;
			else
				reverb.decayHFLimit = 0;
		}
		decayHFLimit.callback = callback;
		decayHFLimit.checked = reverb.decayHFLimit == 1;
		add(decayHFLimit);
	}

	override public function update(elapsed)
	{
		super.update(elapsed);

		if (sound != null && sound.playing)
			timeText.text = FlxStringUtil.formatTime(sound.time/1000) + " / " + FlxStringUtil.formatTime(sound.length/1000);
	}
	
}

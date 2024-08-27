package flixel.sound.filters.extensions;

#if (lime_cffi && lime_openal)
import lime.media.openal.AL;
import lime.media.openal.ALFilter;
import lime._internal.backend.native.NativeCFFI;
import lime.media.openal.ALEffect;
import lime.media.openal.ALAuxiliaryEffectSlot;
import flixel.sound.filters.extensions.NativeCFFIExt;


@:access(flixel.sound.filters.extensions.NativeCFFIExt)
class ALExtension {
	public static function deleteEffect(cl:Class<AL>, buffer:ALEffect):Void {
		#if (lime_cffi && lime_openal && !macro)
		NativeCFFIExt.lime_al_delete_effect(buffer);
		#end
	}

	public static function deleteFilter(cl:Class<AL>, buffer:ALFilter):Void {
		#if (lime_cffi && lime_openal && !macro)
		NativeCFFIExt.lime_al_delete_filter(buffer);
		#end
	}

	public static function deleteAux(cl:Class<AL>, buffer:ALAuxiliaryEffectSlot):Void {
		#if (lime_cffi && lime_openal && !macro)
		NativeCFFIExt.lime_al_delete_auxiliary_effect_slot(buffer);
		#end
	}
}

#end
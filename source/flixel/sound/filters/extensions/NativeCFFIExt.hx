package flixel.sound.filters.extensions;

#if (!lime_doc_gen || lime_cffi)
import lime.system.CFFI;
import lime.system.CFFIPointer;
#end

#if (lime_doc_gen && !lime_cffi)
typedef CFFI = Dynamic;
typedef CFFIPointer = Dynamic;
#end

class NativeCFFIExt {
	#if (lime_cffi && !macro && lime_openal)
	#if (cpp && !cppia)
	#if (disable_cffi || haxe_ver < "3.4.0")
	@:cffi private static function lime_al_delete_effect(buffer:CFFIPointer):Void;

	@:cffi private static function lime_al_delete_filter(buffer:CFFIPointer):Void;

	@:cffi private static function lime_al_delete_auxiliary_effect_slot(slot:CFFIPointer):Void;
	#else
	private static var lime_al_delete_effect = new cpp.Callable<cpp.Object->cpp.Void>(cpp.Prime._loadPrime("lime", "lime_al_delete_effect", "ov", false));
	private static var lime_al_delete_filter = new cpp.Callable<cpp.Object->cpp.Void>(cpp.Prime._loadPrime("lime", "lime_al_delete_filter", "ov", false));
	private static var lime_al_delete_auxiliary_effect_slot = new cpp.Callable<cpp.Object->cpp.Void>(cpp.Prime._loadPrime("lime", "lime_al_delete_auxiliary_effect_slot", "ov", false));
	#end
	#end
	#if (neko || cppia)
	private static var lime_al_delete_effect = CFFI.load("lime", "lime_al_delete_effect", 1);
	private static var lime_al_delete_filter = CFFI.load("lime", "lime_al_delete_filter", 1);
	private static var lime_al_delete_auxiliary_effect_slot = CFFI.load("lime", "lime_al_delete_auxiliary_effect_slot", 1);
	#end

	#if hl
	@:hlNative("lime", "lime_al_delete_effect") private static function lime_al_delete_effect(buffer:CFFIPointer):Void {}

	@:hlNative("lime", "lime_al_delete_filter") private static function lime_al_delete_filter(buffer:CFFIPointer):Void {}

	@:hlNative("lime", "lime_al_delete_auxiliary_effect_slot") private static function lime_al_delete_auxiliary_effect_slot(slot:CFFIPointer):Void {}
	#end
	#end
}

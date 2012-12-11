/*!-
 * Native language names extension for the jQuery Translate plugin 
 * Version: 1.4.7
 * http://code.google.com/p/jquery-translate/
 */
;(function($){
$.translate.extend({

	toNativeLanguage: function(lang){ 
		return $.translate.nativeLanguages[ lang ] || 
			$.translate.nativeLanguages[ $.translate.toLanguageCode(lang) ];
	},
	
	nativeLanguages: {
		"af":"Afrikaans",
		"be":"��������������������",
		"is":"��slenska",
		"ga":"Gaeilge",
		"mk":"��������������������",
		"ms":"Bahasa Melayu",
		"sw":"Kiswahili",
		"cy":"Cymraeg",
		"yi":"������������",
		
		"sq":"Shqipe",
		"ar":"��������������",
		"bg":"������������������",
		"ca":"Catal��",
		"zh":"������",
		"zh-CN":"������������",
		"zh-TW":"������������",
		"hr":"Hrvatski",
		"cs":"��e��tina",
		"da":"Dansk",
		"nl":"Nederlands",
		"en":"English",
		"et":"Eesti",
		"tl":"Tagalog",
		"fi":"Suomi",
		"fr":"Fran��ais",
		"gl":"Galego",
		"de":"Deutsch",
		"el":"����������������",
		"iw":"����������",
		"hi":"������������������",
		"hu":"Magyar",
		"id":"Bahasa Indonesia",
		"it":"Italiano",
		"ja":"���������",
		"ko":"���������",
		"lv":"Latvie��u",
		"lt":"Lietuvi��",
		"mt":"Malti",
		"no":"Norsk",
		"fa":"����������",
		"pl":"Polski",
		"pt-PT":"Portugu��s",
		"ro":"Rom��n",
		"ru":"��������������",
		"sr":"������������",
		"sk":"Slovensk��",
		"sl":"Slovenski",
		"es":"Espa��ol",
		"sv":"Svenska",
		"th":"���������",
		"tr":"T��rk��e",
		"uk":"��������������������",
		"vi":"Ti���ng Vi���t"
	}

});

})(jQuery);

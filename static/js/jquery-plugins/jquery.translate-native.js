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
		"be":"ıııııııııııııııııııı",
		"is":"ııslenska",
		"ga":"Gaeilge",
		"mk":"ıııııııııııııııııııı",
		"ms":"Bahasa Melayu",
		"sw":"Kiswahili",
		"cy":"Cymraeg",
		"yi":"ıııııııııııı",
		
		"sq":"Shqipe",
		"ar":"ıııııııııııııı",
		"bg":"ıııııııııııııııııı",
		"ca":"Catalıı",
		"zh":"ıııııı",
		"zh-CN":"ıııııııııııı",
		"zh-TW":"ıııııııııııı",
		"hr":"Hrvatski",
		"cs":"ııeııtina",
		"da":"Dansk",
		"nl":"Nederlands",
		"en":"English",
		"et":"Eesti",
		"tl":"Tagalog",
		"fi":"Suomi",
		"fr":"Franııais",
		"gl":"Galego",
		"de":"Deutsch",
		"el":"ıııııııııııııııı",
		"iw":"ıııııııııı",
		"hi":"ıııııııııııııııııı",
		"hu":"Magyar",
		"id":"Bahasa Indonesia",
		"it":"Italiano",
		"ja":"ııııııııı",
		"ko":"ııııııııı",
		"lv":"Latvieııu",
		"lt":"Lietuviıı",
		"mt":"Malti",
		"no":"Norsk",
		"fa":"ıııııııııı",
		"pl":"Polski",
		"pt-PT":"Portuguııs",
		"ro":"Romıın",
		"ru":"ıııııııııııııı",
		"sr":"ıııııııııııı",
		"sk":"Slovenskıı",
		"sl":"Slovenski",
		"es":"Espaııol",
		"sv":"Svenska",
		"th":"ııııııııı",
		"tr":"Tıırkııe",
		"uk":"ıııııııııııııııııııı",
		"vi":"Tiıııng Viıııt"
	}

});

})(jQuery);

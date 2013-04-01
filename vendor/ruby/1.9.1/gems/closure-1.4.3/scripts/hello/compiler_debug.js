var $goog$global$$ = this;
Math.floor(Math.random() * 2147483648).toString(36);
function $goog$string$compareElements_$$($left$$2$$, $right$$2$$) {
  if($left$$2$$ < $right$$2$$) {
    return-1
  }else {
    if($left$$2$$ > $right$$2$$) {
      return 1
    }
  }
  return 0
}
;var $goog$userAgent$detectedOpera_$$, $goog$userAgent$detectedIe_$$, $goog$userAgent$detectedWebkit_$$, $goog$userAgent$detectedGecko_$$;
function $goog$userAgent$getUserAgentString$$() {
  return $goog$global$$.navigator ? $goog$global$$.navigator.userAgent : null
}
$goog$userAgent$detectedGecko_$$ = $goog$userAgent$detectedWebkit_$$ = $goog$userAgent$detectedIe_$$ = $goog$userAgent$detectedOpera_$$ = !1;
var $ua$$inline_5$$;
if($ua$$inline_5$$ = $goog$userAgent$getUserAgentString$$()) {
  var $navigator$$inline_6$$ = $goog$global$$.navigator;
  $goog$userAgent$detectedOpera_$$ = $ua$$inline_5$$.indexOf("Opera") == 0;
  $goog$userAgent$detectedIe_$$ = !$goog$userAgent$detectedOpera_$$ && $ua$$inline_5$$.indexOf("MSIE") != -1;
  $goog$userAgent$detectedWebkit_$$ = !$goog$userAgent$detectedOpera_$$ && $ua$$inline_5$$.indexOf("WebKit") != -1;
  $goog$userAgent$detectedGecko_$$ = !$goog$userAgent$detectedOpera_$$ && !$goog$userAgent$detectedWebkit_$$ && $navigator$$inline_6$$.product == "Gecko"
}
var $goog$userAgent$IE$$ = $goog$userAgent$detectedIe_$$, $goog$userAgent$GECKO$$ = $goog$userAgent$detectedGecko_$$, $goog$userAgent$WEBKIT$$ = $goog$userAgent$detectedWebkit_$$, $goog$userAgent$VERSION$$;
a: {
  var $version$$inline_13$$ = "", $re$$inline_14$$;
  if($goog$userAgent$detectedOpera_$$ && $goog$global$$.opera) {
    var $operaVersion$$inline_15$$ = $goog$global$$.opera.version, $version$$inline_13$$ = typeof $operaVersion$$inline_15$$ == "function" ? $operaVersion$$inline_15$$() : $operaVersion$$inline_15$$
  }else {
    if($goog$userAgent$GECKO$$ ? $re$$inline_14$$ = /rv\:([^\);]+)(\)|;)/ : $goog$userAgent$IE$$ ? $re$$inline_14$$ = /MSIE\s+([^\);]+)(\)|;)/ : $goog$userAgent$WEBKIT$$ && ($re$$inline_14$$ = /WebKit\/(\S+)/), $re$$inline_14$$) {
      var $arr$$inline_16$$ = $re$$inline_14$$.exec($goog$userAgent$getUserAgentString$$()), $version$$inline_13$$ = $arr$$inline_16$$ ? $arr$$inline_16$$[1] : ""
    }
  }
  if($goog$userAgent$IE$$) {
    var $docMode$$inline_17$$, $doc$$inline_54$$ = $goog$global$$.document;
    $docMode$$inline_17$$ = $doc$$inline_54$$ ? $doc$$inline_54$$.documentMode : void 0;
    if($docMode$$inline_17$$ > parseFloat($version$$inline_13$$)) {
      $goog$userAgent$VERSION$$ = String($docMode$$inline_17$$);
      break a
    }
  }
  $goog$userAgent$VERSION$$ = $version$$inline_13$$
}
var $goog$userAgent$isVersionCache_$$ = {};
function $goog$userAgent$isVersion$$($version$$8$$) {
  if(!$goog$userAgent$isVersionCache_$$[$version$$8$$]) {
    for(var $order$$inline_33$$ = 0, $v1Subs$$inline_34$$ = String($goog$userAgent$VERSION$$).replace(/^[\s\xa0]+|[\s\xa0]+$/g, "").split("."), $v2Subs$$inline_35$$ = String($version$$8$$).replace(/^[\s\xa0]+|[\s\xa0]+$/g, "").split("."), $subCount$$inline_36$$ = Math.max($v1Subs$$inline_34$$.length, $v2Subs$$inline_35$$.length), $subIdx$$inline_37$$ = 0;$order$$inline_33$$ == 0 && $subIdx$$inline_37$$ < $subCount$$inline_36$$;$subIdx$$inline_37$$++) {
      var $v1Sub$$inline_38$$ = $v1Subs$$inline_34$$[$subIdx$$inline_37$$] || "", $v2Sub$$inline_39$$ = $v2Subs$$inline_35$$[$subIdx$$inline_37$$] || "", $v1CompParser$$inline_40$$ = RegExp("(\\d*)(\\D*)", "g"), $v2CompParser$$inline_41$$ = RegExp("(\\d*)(\\D*)", "g");
      do {
        var $v1Comp$$inline_42$$ = $v1CompParser$$inline_40$$.exec($v1Sub$$inline_38$$) || ["", "", ""], $v2Comp$$inline_43$$ = $v2CompParser$$inline_41$$.exec($v2Sub$$inline_39$$) || ["", "", ""];
        if($v1Comp$$inline_42$$[0].length == 0 && $v2Comp$$inline_43$$[0].length == 0) {
          break
        }
        $order$$inline_33$$ = $goog$string$compareElements_$$($v1Comp$$inline_42$$[1].length == 0 ? 0 : parseInt($v1Comp$$inline_42$$[1], 10), $v2Comp$$inline_43$$[1].length == 0 ? 0 : parseInt($v2Comp$$inline_43$$[1], 10)) || $goog$string$compareElements_$$($v1Comp$$inline_42$$[2].length == 0, $v2Comp$$inline_43$$[2].length == 0) || $goog$string$compareElements_$$($v1Comp$$inline_42$$[2], $v2Comp$$inline_43$$[2])
      }while($order$$inline_33$$ == 0)
    }
    $goog$userAgent$isVersionCache_$$[$version$$8$$] = $order$$inline_33$$ >= 0
  }
}
var $goog$userAgent$isDocumentModeCache_$$ = {};
function $goog$userAgent$isDocumentMode$$() {
  return $goog$userAgent$isDocumentModeCache_$$[9] || ($goog$userAgent$isDocumentModeCache_$$[9] = $goog$userAgent$IE$$ && document.documentMode && document.documentMode >= 9)
}
;!$goog$userAgent$IE$$ || $goog$userAgent$isDocumentMode$$();
!$goog$userAgent$GECKO$$ && !$goog$userAgent$IE$$ || $goog$userAgent$IE$$ && $goog$userAgent$isDocumentMode$$() || $goog$userAgent$GECKO$$ && $goog$userAgent$isVersion$$("1.9.1");
$goog$userAgent$IE$$ && $goog$userAgent$isVersion$$("9");
$goog$userAgent$IE$$ && $goog$userAgent$isVersion$$(8);
var $goog$userAgent$jscript$DETECTED_HAS_JSCRIPT_$$;
($goog$userAgent$jscript$DETECTED_HAS_JSCRIPT_$$ = "ScriptEngine" in $goog$global$$ && $goog$global$$.ScriptEngine() == "JScript") && ($goog$global$$.ScriptEngineMajorVersion(), $goog$global$$.ScriptEngineMinorVersion(), $goog$global$$.ScriptEngineBuildVersion());
function $goog$string$StringBuffer$$($opt_a1$$, $var_args$$48$$) {
  this.$buffer_$ = $goog$userAgent$jscript$DETECTED_HAS_JSCRIPT_$$ ? [] : "";
  $opt_a1$$ != null && this.append.apply(this, arguments)
}
$goog$userAgent$jscript$DETECTED_HAS_JSCRIPT_$$ ? ($goog$string$StringBuffer$$.prototype.$bufferLength_$ = 0, $goog$string$StringBuffer$$.prototype.append = function $$goog$string$StringBuffer$$$$append$($a1$$, $opt_a2$$, $var_args$$49$$) {
  $opt_a2$$ == null ? this.$buffer_$[this.$bufferLength_$++] = $a1$$ : (this.$buffer_$.push.apply(this.$buffer_$, arguments), this.$bufferLength_$ = this.$buffer_$.length);
  return this
}) : $goog$string$StringBuffer$$.prototype.append = function $$goog$string$StringBuffer$$$$append$($a1$$1$$, $opt_a2$$1$$, $var_args$$50$$) {
  this.$buffer_$ += $a1$$1$$;
  if($opt_a2$$1$$ != null) {
    for(var $i$$59$$ = 1;$i$$59$$ < arguments.length;$i$$59$$++) {
      this.$buffer_$ += arguments[$i$$59$$]
    }
  }
  return this
};
$goog$string$StringBuffer$$.prototype.clear = function $$goog$string$StringBuffer$$$$clear$() {
  $goog$userAgent$jscript$DETECTED_HAS_JSCRIPT_$$ ? this.$bufferLength_$ = this.$buffer_$.length = 0 : this.$buffer_$ = ""
};
$goog$string$StringBuffer$$.prototype.toString = function $$goog$string$StringBuffer$$$$toString$() {
  if($goog$userAgent$jscript$DETECTED_HAS_JSCRIPT_$$) {
    var $str$$69$$ = this.$buffer_$.join("");
    this.clear();
    $str$$69$$ && this.append($str$$69$$);
    return $str$$69$$
  }else {
    return this.$buffer_$
  }
};
var $soy$esc$$0$0ESCAPE_MAP_FOR_ESCAPE_HTML__AND__NORMALIZE_HTML__AND__ESCAPE_HTML_NOSPACE__AND__NORMALIZE_HTML_NOSPACE_$$ = {"\x00":"&#0;", '"':"&quot;", "&":"&amp;", "'":"&#39;", "<":"&lt;", ">":"&gt;", "\t":"&#9;", "\n":"&#10;", "\u000b":"&#11;", "\u000c":"&#12;", "\r":"&#13;", " ":"&#32;", "-":"&#45;", "/":"&#47;", "=":"&#61;", "`":"&#96;", "\u0085":"&#133;", "\u00a0":"&#160;", "\u2028":"&#8232;", "\u2029":"&#8233;"};
function $soy$esc$$0$0REPLACER_FOR_ESCAPE_HTML__AND__NORMALIZE_HTML__AND__ESCAPE_HTML_NOSPACE__AND__NORMALIZE_HTML_NOSPACE_$$($ch$$6$$) {
  return $soy$esc$$0$0ESCAPE_MAP_FOR_ESCAPE_HTML__AND__NORMALIZE_HTML__AND__ESCAPE_HTML_NOSPACE__AND__NORMALIZE_HTML_NOSPACE_$$[$ch$$6$$]
}
var $soy$esc$$0$0MATCHER_FOR_ESCAPE_HTML_$$ = /[\x00\x22\x26\x27\x3c\x3e]/g;
function $myapp$legume$hello$$($opt_data$$3$$) {
  var $output$$1$$ = new $goog$string$StringBuffer$$;
  $output$$1$$.append("\tHello ", typeof $opt_data$$3$$.$subject$ === "object" && $opt_data$$3$$.$subject$ && $opt_data$$3$$.$subject$.$contentKind$ === 0 ? $opt_data$$3$$.$subject$.content : String($opt_data$$3$$.$subject$).replace($soy$esc$$0$0MATCHER_FOR_ESCAPE_HTML_$$, $soy$esc$$0$0REPLACER_FOR_ESCAPE_HTML__AND__NORMALIZE_HTML__AND__ESCAPE_HTML_NOSPACE__AND__NORMALIZE_HTML_NOSPACE_$$), "!");
  return $output$$1$$.toString()
}
;function $opt_object$$inline_60$$($subject$$) {
  document.write($myapp$legume$hello$$({$subject$:$subject$$}))
}
var $parts$$inline_61$$ = "hello".split("."), $cur$$inline_62$$ = $goog$global$$;
!($parts$$inline_61$$[0] in $cur$$inline_62$$) && $cur$$inline_62$$.execScript && $cur$$inline_62$$.execScript("var " + $parts$$inline_61$$[0]);
for(var $part$$inline_63$$;$parts$$inline_61$$.length && ($part$$inline_63$$ = $parts$$inline_61$$.shift());) {
  !$parts$$inline_61$$.length && $opt_object$$inline_60$$ !== void 0 ? $cur$$inline_62$$[$part$$inline_63$$] = $opt_object$$inline_60$$ : $cur$$inline_62$$ = $cur$$inline_62$$[$part$$inline_63$$] ? $cur$$inline_62$$[$part$$inline_63$$] : $cur$$inline_62$$[$part$$inline_63$$] = {}
}
;

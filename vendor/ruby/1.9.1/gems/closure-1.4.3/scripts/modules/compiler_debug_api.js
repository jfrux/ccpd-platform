$example$App$$.prototype.$setMessage$ = $JSCompiler_unstubMethod$$(1, function($message$$11$$) {
  $goog$dom$getElementsByTagNameAndClass_$$(this.$dom_$.$document_$, "span", this.$getElement$())[0].innerHTML = $goog$string$htmlEscape$$($message$$11$$)
});
$goog$debug$LogRecord$$.prototype.$setMessage$ = $JSCompiler_unstubMethod$$(0, function($msg$$6$$) {
  this.$msg_$ = $msg$$6$$
});
$goog$exportPath_$$("example.api.setMessage", function($message$$14$$) {
  $example$App$instance_$$.$setMessage$($message$$14$$)
});
$JSCompiler_StaticMethods_setLoaded$$($goog$module$ModuleManager$$.$getInstance$(), "api");


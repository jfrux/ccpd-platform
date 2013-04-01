$goog$ui$Component$$.prototype.$getDomHelper$ = $JSCompiler_unstubMethod$$(2, $JSCompiler_get$$("$dom_$"));
function $example$Settings$$($dom$$4$$) {
  $goog$ui$Component$$.call(this, $dom$$4$$)
}
$goog$inherits$$($example$Settings$$, $goog$ui$Component$$);
$example$Settings$$.prototype.$createDom$ = function $$example$Settings$$$$$createDom$$() {
  $example$Settings$$.$superClass_$.$createDom$.call(this);
  this.$getElement$().innerHTML = "This is the settings component."
};
var $app$$ = $example$App$instance_$$, $child$$inline_578$$ = new $example$Settings$$($app$$.$getDomHelper$()), $index$$inline_579$$ = $app$$.$children_$ ? $app$$.$children_$.length : 0;
$child$$inline_578$$.$inDocument_$ && $JSCompiler_alias_THROW$$(Error("Component already rendered"));
($index$$inline_579$$ < 0 || $index$$inline_579$$ > ($app$$.$children_$ ? $app$$.$children_$.length : 0)) && $JSCompiler_alias_THROW$$(Error("Child component index out of bounds"));
if(!$app$$.$childIndex_$ || !$app$$.$children_$) {
  $app$$.$childIndex_$ = {}, $app$$.$children_$ = []
}
if($child$$inline_578$$.getParent() == $app$$) {
  var $key$$inline_580$$ = $child$$inline_578$$.$getId$();
  $app$$.$childIndex_$[$key$$inline_580$$] = $child$$inline_578$$;
  $goog$array$remove$$($app$$.$children_$, $child$$inline_578$$)
}else {
  var $obj$$inline_581$$ = $app$$.$childIndex_$, $key$$inline_582$$ = $child$$inline_578$$.$getId$();
  $key$$inline_582$$ in $obj$$inline_581$$ && $JSCompiler_alias_THROW$$(Error('The object already contains the key "' + $key$$inline_582$$ + '"'));
  $obj$$inline_581$$[$key$$inline_582$$] = $child$$inline_578$$
}
$JSCompiler_StaticMethods_setParent$$($child$$inline_578$$, $app$$);
(function($arr$$42$$, $index$$55$$, $howMany$$, $var_args$$35$$) {
  $goog$asserts$assert$$($arr$$42$$.length != $JSCompiler_alias_NULL$$);
  $goog$array$ARRAY_PROTOTYPE_$$.splice.apply($arr$$42$$, $goog$array$slice$$(arguments, 1))
})($app$$.$children_$, $index$$inline_579$$, 0, $child$$inline_578$$);
if($child$$inline_578$$.$inDocument_$ && $app$$.$inDocument_$ && $child$$inline_578$$.getParent() == $app$$) {
  var $contentElement$$inline_583$$ = $app$$.$element_$;
  $contentElement$$inline_583$$.insertBefore($child$$inline_578$$.$getElement$(), $contentElement$$inline_583$$.childNodes[$index$$inline_579$$] || $JSCompiler_alias_NULL$$)
}else {
  $app$$.$element_$ || $app$$.$createDom$();
  var $sibling$$inline_584$$ = $app$$.$children_$ ? $app$$.$children_$[$index$$inline_579$$ + 1] || $JSCompiler_alias_NULL$$ : $JSCompiler_alias_NULL$$;
  $JSCompiler_StaticMethods_render_$$($child$$inline_578$$, $app$$.$element_$, $sibling$$inline_584$$ ? $sibling$$inline_584$$.$element_$ : $JSCompiler_alias_NULL$$)
}
$JSCompiler_StaticMethods_setLoaded$$($goog$module$ModuleManager$$.$getInstance$(), "settings");


<cfparam name="Attributes.ActivityID" default="" />
<cfparam name="Attributes.PubComponentID" default="" />
<cfparam name="Attributes.DisplayName" default="" />
<cfparam name="Attributes.Description" default="" />

<script>
$(document).ready(function() {
	$("#DisplayName").select();
});
</script>

<cfoutput>
<form class="form-horizontal js-component-form" name="frmComp" id="frmComp" action="#Application.Settings.RootPath#/_com/ajax_Builder.cfc" method="post">
<input type="hidden" name="PubComponentID" value="#Attributes.PubComponentID#" />
<input type="hidden" name="method" value="SaveComponent" />
<input type="hidden" name="ActivityID" value="#Attributes.ActivityID#" />
<input type="hidden" name="ComponentID" value="16" />
<input type="hidden" name="returnformat" value="plain" />
<div class="control-group">
		<div class="controls"><input type="text" name="DisplayName" id="DisplayName" value="#Attributes.DisplayName#" style="width:440px;" /></div>
</div>
</form>
</cfoutput>
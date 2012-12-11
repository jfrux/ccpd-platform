<cfparam name="Attributes.Instance" default="">
<cfparam name="Attributes.Label" default="Untitled">
<cfparam name="Attributes.TableName" default="">
<cfparam name="Attributes.DefaultID" default="0">
<cfparam name="Attributes.DefaultName" default="">
<cfparam name="Attributes.Filter" default="">
<cfparam name="Attributes.Width" default="200">
<cfparam name="Attributes.CheckType" default="0">
<cfparam name="Attributes.AllowAdd" default="Y">
<cfparam name="Attributes.OnChange" default="">
<cfquery name="qGetOptions" datasource="#Application.Settings.DSN#">
	SELECT #Attributes.Instance#ID As StandardID,Name FROM #Attributes.TableName# WHERE 0=0 #PreserveSingleQuotes(Attributes.Filter)#
</cfquery>
<cfoutput>
<script type="text/javascript">
function set#Attributes.Instance#(sValue) {
	$("###Attributes.Instance#Name").val($.ListGetAt(sValue,2,"|"));
	$("###Attributes.Instance#ID").val($.ListGetAt(sValue,1,"|"));
	$("##PersonWindow#Attributes.Instance#").dialog("close");
}

$(document).ready(function() {
	$("##PersonWindow#Attributes.Instance#").dialog({ 
		title:"Person Finder &raquo; #Attributes.Instance#",
		modal: true, 
		overlay: { 
			opacity: 0.5, 
			background: "black" 
		} ,
		autoOpen: false,
		height:350,
		width:650,
		resizable: false
	});

	$("###Attributes.Instance#Name").click(function() {
		$("##PersonWindow#Attributes.Instance#").dialog("open");
	});
});
</script>
<select name="#Attributes.Instance#ID" id="#Attributes.Instance#ID" class="ComboBox">
	<cfloop query="qGetOptions">
	<option value="#qGetOptions.StandardID#">#qGetOptions.Name#</option>
	</cfloop>
</select><cfif Attributes.AllowAdd EQ "Y"><a href="javascript:void(0);" id="NewLink#Attributes.Instance#" class="ComboLink"><img src="#Application.Settings.RootPath#/_images/combo_add.gif" border="0" class="ComboAdd" alt="Add New #Attributes.Label#" /></a></cfif>
</cfoutput>

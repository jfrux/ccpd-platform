<cfparam name="Attributes.EmailStyleID" default="0" />
<cfparam name="Attributes.Subject" default="" />
<cfparam name="Attributes.TemplateHTML" default="" />
<cfparam name="Attributes.TemplatePlain" default="" />
<script>
tinyMCE.init({
	verify_html : false,
	cleanup : false,
	mode : "exact",
	elements : "TemplateHTML",
	theme : "advanced"
});
</script>
<cfoutput>
<h1>#Request.Page.Title#</h1>
<form action="#myself#Admin.EmailStyle?EmailStyleID=#Attributes.EmailStyleID#" method="post" name="frmEmailStyle">
<div style="clear:both;">
<h3>Subject</h3>
<input type="text" name="Subject" value="#Attributes.Subject#" style="width:600px;" />
</div>
<div style="height:10px;"></div>
<div style="float:left;">
<h3>Template HTML</h3>
<textarea name="TemplateHTML" id="TemplateHTML" style="width:500px;height:350px;">
#Attributes.TemplateHTML#
</textarea>
</div>
<div style="float:left;">
<h3>Template Plain Text</h3>
<textarea name="TemplatePlain" id="TemplatePlain" style="width:400px;height:350px;">
#Attributes.TemplatePlain#
</textarea>
</div>
<div style="clear:both;">
<input type="hidden" name="Submitted" value="1" /><input type="submit" value="Save Template" name="submit" class="button" /> <a href="#myself#Admin.EmailStyles">Cancel</a></div>
</form>
</cfoutput>
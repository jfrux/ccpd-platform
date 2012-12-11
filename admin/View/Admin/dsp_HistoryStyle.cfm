<cfparam name="Attributes.HistoryStyleID" default="0" />
<cfparam name="Attributes.Title" default="" />
<cfparam name="Attributes.TemplateFrom" default="" />
<cfparam name="Attributes.IconImg" default="" />
<cfparam name="Attributes.HistoryType" default="" />

<script>
tinyMCE.init({
	verify_html : false,
	cleanup : false,
	mode : "exact",
	elements : "TemplateFrom",
	theme : "advanced"
});

$(document).ready(function() {
	$(".IconChoice").click(function() {
		var $ImgSrc = $(this).attr('src').replace('/_images/icons/','')
		$("#IconImg").val($ImgSrc);
		$("#ImageFilePreview").attr('src','/_images/icons/' + $ImgSrc);
		$("#ImageFileName").html($ImgSrc);
		
		$("#IconChooser").hide();
	});
	$(".IconChoice").hover(function() {
		$(this).css('border','3px solid GREEN');
	},function() {
		$(this).css('border','3px solid transparent');
	});
	
	$("#ChangeIconLink").click(function() {
		$("#IconChooser").show();
	});
	
	<cfif Attributes.HistoryType GT 0>
		$("#HistoryType").val(<cfoutput>#Attributes.HistoryType#</cfoutput>);
	</cfif>
});
</script>
<cfoutput>
<h1>#Request.Page.Title#</h1>
<form action="#myself#Admin.HistoryStyle?HistoryStyleID=#Attributes.HistoryStyleID#" method="post" name="frmHistoryStyle">
<div style="clear:both;">
<h3>Title</h3>
<input type="text" name="Title" value="#Attributes.Title#" style="width:600px;" />
</div>
<div style="height:10px;"></div>
<h3>Template HTML</h3>
<textarea name="TemplateFrom" id="TemplateFrom" style="width:500px;height:200px;">
#Attributes.TemplateFrom#
</textarea>
<div style="height:10px;"></div>
<h3>History Type</h3>
<select name="HistoryType" id="HistoryType" style="width:150px;">
	<option value="1">Activity</option>
	<option value="2">Person</option>
	<option value="3">All To's</option>
</select>
<div style="height:10px;"></div>
<h3>Icon Image</h3>
<div style="padding:4px;clear:both;"><img id="ImageFilePreview" src="/admin/_images/icons/#Attributes.IconImg#" border="0" /> <span id="ImageFileName">#Attributes.IconImg#</span> <a href="javascript:void(0);" id="ChangeIconLink">Change Icon</a></div>
<input type="hidden" name="IconImg" id="IconImg" value="#Attributes.IconImg#" />
<div style="height:250px; width:850px; overflow:auto; display:none;" id="IconChooser">
	<cfdirectory directory="#ExpandPath('/admin/_images/icons/')#" filter="*.png" name="qIcons">
	<cfloop query="qIcons"><img src="/admin/_images/icons/#qIcons.Name#" border="0" class="IconChoice" style="border:3px solid transparent" /></cfloop>
</div>
<div style="clear:both;">
<input type="hidden" name="Submitted" value="1" /><input type="submit" value="Save Template" name="submit" class="button" /> <a href="#myself#Admin.HistoryStyles">Cancel</a></div>

</form>
</cfoutput>
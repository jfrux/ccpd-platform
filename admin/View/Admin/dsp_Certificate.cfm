<cfparam name="Attributes.HistoryStyleID" default="0" />
<cfparam name="Attributes.Title" default="" />
<cfparam name="Attributes.TemplateFrom" default="<div style='position: absolute; left: 187px; top: 236px; width: 653px; height: 75px; text-align: center;'><span style='font-size: x-large;'>%ActivityTitle%</span></div>" />
<cfparam name="Attributes.IconImg" default="" />
<cfparam name="Attributes.HistoryType" default="" />
<cfset backgroundImg = "/admin/_images/certificate.jpg">
<script>
// Creates a new plugin class and a custom listbox
tinymce.create('tinymce.plugins.Certificate', {
    createControl: function(n, cm) {
        switch (n) {
            case 'certfields':
                var mlb = cm.createListBox('certfields', {
                     title : 'Certificate Fields',
                     onselect : function(v) {
                         tinyMCE.activeEditor.windowManager.alert('Value selected:' + v);
                     }
                });

                // Add some values to the list box
                mlb.add('Some item 1', 'val1');
                mlb.add('some item 2', 'val2');
                mlb.add('some item 3', 'val3');

                // Return the new listbox instance
                return mlb;
			
            case 'certbtns':
                var c = cm.createSplitButton('certbtns', {
                    title : 'Certificate',
                    image : 'img/example.gif',
                    onclick : function() {
                        tinyMCE.activeEditor.windowManager.alert('Button was clicked.');
                    }
                });

                c.onRenderMenu.add(function(c, m) {
                    m.add({title : 'Certificate', 'class' : 'mceMenuItemTitle'}).setDisabled(1);

                    m.add({title : 'Change Background', onclick : function() {
                        tinyMCE.activeEditor.windowManager.alert('Some  item 1 was clicked.');
                    }});

                    m.add({title : 'Preview', onclick : function() {
                        tinyMCE.activeEditor.windowManager.alert('Some  item 2 was clicked.');
                    }});
                });

                // Return the new splitbutton instance
                return c;
        }

        return null;
    }
});

// Register plugin with a short name
tinymce.PluginManager.add('example', tinymce.plugins.ExamplePlugin);


var editorOptions = {
	// General options
	mode:"textareas",
	theme : "advanced",
	plugins : "pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,advlist",

	// Theme options
	theme_advanced_buttons1 : "save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,styleselect,formatselect,fontselect,fontsizeselect",
	theme_advanced_buttons2 : "tablecontrols,|,bullist,numlist,|,undo,redo,|,image,cleanup,code,|,forecolor,backcolor,|,removeformat,visualaid,|,charmap,|,fullscreen,|,insertlayer,moveforward,movebackward,absolute,|,styleprops,|,template",
	theme_advanced_toolbar_location : "top",
	theme_advanced_toolbar_align : "left",
	theme_advanced_statusbar_location : "bottom",
	theme_advanced_resizing : true,

	// Example content CSS (should be your site CSS)
	content_css : "/admin/_styles/cert_editor.css",

	// Drop lists for link/image/media/template dialogs
	template_external_list_url : "lists/template_list.js",
	external_link_list_url : "lists/link_list.js",
	external_image_list_url : "lists/image_list.js",
	media_external_list_url : "lists/media_list.js",
};

var certEditor = new tinymce.Editor('TemplateFrom',editorOptions);

function loadPreview() {
	var currentContent = certEditor.getContent();
	mywindow = window.open (
		"/admin/_com/report/cert.cfc?method=preview&htmlcontent=" + encodeURIComponent(currentContent) + '&seed=' + Math.random(),
	  	"mywindow",
		"location=1,status=1,scrollbars=1,width=650,height=500");
	  mywindow.moveTo(0,0);
}

function setBackground(bgpath) {
	certEditor.$("body").css('background-image','url(' + bgpath + ')')
}

certEditor.onClick.add(function(ed, e) {

});

certEditor.onInit.add(function(ed, e) {
	setBackground('<cfoutput>#backgroundImg#</cfoutput>');
});

$(document).ready(function() {
	certEditor.render();
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
<form action="#myself#admin.certificate?certid=#Attributes.certid#" method="post" id="frmCert" name="frmCert">
<div style="clear:both;">
<h3>Title</h3>
<input type="text" name="Title" value="#Attributes.Title#" style="width:600px;" />
</div>
<div style="height:10px;"></div>
<h3>Template HTML</h3>
<input type="button" name="previewBtn" value="Preview PDF" onClick="loadPreview();" />
<textarea name="TemplateFrom" id="TemplateFrom" style="width:1027px;height:794px;">
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
	<cfdirectory directory="#ExpandPath('/_images/icons/')#" filter="*.png" name="qIcons">
	<cfloop query="qIcons"><img src="/admin/_images/icons/#qIcons.Name#" border="0" class="IconChoice" style="border:3px solid transparent" /></cfloop>
</div>
<div style="clear:both;">
<input type="hidden" name="Submitted" value="1" /><input type="submit" value="Save Template" name="submit" class="button" /> <a href="#myself#Admin.HistoryStyles">Cancel</a></div>

</form>
</cfoutput>
<div class="MultiFormRight_SectTitle">What can I do?</div>
<div class="clear">
<cfoutput>
#jButton("Save","javascript:void(0);","accept","SubmitForm(document.frmUpload);")#
#jButton("Cancel","#myself##Attributes.Mode#.Docs?#Attributes.Mode#ID=#Attributes.ModeID#","delete","")#
</cfoutput>
</div>
<cfoutput>
<div class="MultiFormRight_SectTitle">What can I do?</div>
<cfinclude template="#Application.Settings.RootPath#/View/Activity/Includes/dsp_OtherLinkList.cfm" />
<div class="MultiFormRight_LinkList">
</div>
<div class="MultiFormRight_SectBody">
	<div class="clear">
		#jButton("Save","javascript:void(0);","accept","SubmitForm(document.frmOther);")#
	</div>
</div>
</cfoutput>
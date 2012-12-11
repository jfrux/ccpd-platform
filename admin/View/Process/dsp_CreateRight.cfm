<cfoutput>
<div class="MultiFormRight_SectTitle">What can I do?</div>
<div class="MultiFormRight_SectBody">
	<div class="clear"> 
		<cfoutput>
			#jButton("Save","javascript:void(0);","accept","SubmitForm(document.frmCreate);")#
			#jButton("Cancel","#myself#Process.Home","delete","")#
		</cfoutput>
	</div>
</div>
</cfoutput>
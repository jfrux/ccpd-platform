<div class="MultiFormRight_SectTitle">What can I do?</div>
<div class="clear">
<cfoutput>
#jButton("Scan Now","javascript:void(0);","scan","btnScan_onclick();")#

</div>
<div class="MultiFormRight_SectSubTitle">Document Info</div>
Save File As:<br />
<input type="text" name="FileName" id="FileName" /><br />
Brief Description:<br />
<input type="text" name="FileCaption" id="FileCaption" /><br />
Document Type:<br />
<cfloop query="qFileTypeList">
		<cfif qFileTypeList.Description NEQ "People">
			<div><input type="radio" name="FileType" id="FileType#qFileTypeList.FileTypeID#" class="FileTypeRadios" value="#qFileTypeList.FileTypeID#"<cfif Attributes.FileType EQ qFileTypeList.FileTypeID> Checked</cfif> /> <label for="FileType#qFileTypeList.FileTypeID#">#qFileTypeList.Name#</label></div>
		</cfif>
	</cfloop>

#jButton("Save","javascript:void(0);","accept","btnUpload_onclick();")#
#jButton("Cancel","#myself##Attributes.Mode#.Docs?#Attributes.Mode#ID=#Attributes.ModeID#","delete","")#
</cfoutput>
</div>
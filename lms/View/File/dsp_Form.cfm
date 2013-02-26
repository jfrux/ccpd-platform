<cfparam name="Attributes.FileCaption" default="">
<cfparam name="Attributes.FileType" default="">

<!--- Gets the Page type through GetToken from the Fuseaction and Capitalizes the first letter and lowercases the rest --->
<cfset PageType = UCase(Left(GetToken(Attributes.Fuseaction,2,"."),1)) & LCase(Right(GetToken(Attributes.Fuseaction,2,"."),Len(GetToken(Attributes.Fuseaction,2,"."))-1))>
<cfoutput>
<div class="ViewSection">
<form name="frmUpload" id="frmFileUpload" action="#Myself#file.upload?mode=#Attributes.Mode#&modeid=#Attributes.ModeID#<cfif isDefined("Attributes.ActivityID")>&activityid=#Attributes.ActivityID#</cfif>&submitted=1" method="post" enctype="multipart/form-data">
	<table cellspacing="1" cellpadding="2" border="0">
		<cfif NOT Attributes.Fuseaction EQ "File.Edit">
			<tr>
				<td><input name="FileField" type="file" style="width:200px;" /><input type="hidden" name="Submitted" value="1" /></td>
			</tr>
		</cfif>
		<cfif Attributes.Mode NEQ "PublishActivity">
		<tr>
			<td><strong>Brief Caption</strong><br /><textarea name="FileCaption" style="width:200px;height:40px;">#Attributes.FileCaption#</textarea></td>
		</tr>
		<tr>
			<td><strong>File Type</strong><br />
            	<cfif Attributes.Mode EQ "Activity">
                    <cfloop query="qFileTypeList">
                        <cfif qFileTypeList.Description EQ "No People">
                            <div><input type="radio" name="FileType" id="FileType#qFileTypeList.FileTypeID#" value="#qFileTypeList.FileTypeID#"<cfif Attributes.FileType EQ qFileTypeList.FileTypeID> Checked</cfif> /> <label for="FileType#qFileTypeList.FileTypeID#">#qFileTypeList.Name#</label></div>
                        </cfif>
                    </cfloop>
                <cfelse>
                    <cfloop query="qFileTypeList">
                        <cfif qFileTypeList.Description EQ "People">
                            <div><input type="radio" name="FileType" id="FileType#qFileTypeList.FileTypeID#" value="#qFileTypeList.FileTypeID#"<cfif Attributes.FileType EQ qFileTypeList.FileTypeID> Checked</cfif> /> <label for="FileType#qFileTypeList.FileTypeID#">#qFileTypeList.Name#</label></div>
                        </cfif>
                    </cfloop>
               	</cfif>
			</td>
		</tr>
		<cfelse>
			<input type="hidden" name="FileCaption" value="#Attributes.FileCaption#" />
			<input type="hidden" name="FileType" value="8" /><!--- PublishedFile --->
		</cfif>
	</table>
</form>
</div>
</cfoutput>
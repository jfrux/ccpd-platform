<cfparam name="qFiles.FileUpdated" default="" />

<script>
$(document).ready(function() {
	<cfif qFileList.RecordCount EQ 0>
	$(".upload-add").bind("click", this, function() {
		$.post(sMyself + "File.Upload", { Mode: "Person", ModeID: nPerson },
			function(data) {
				$("#doc-uploader").html(data);
		});
		
		$("#doc-uploader").dialog("open");
	});
	</cfif>
	
	/* REMOVE ONLY CHECKED */
	$("#RemoveChecked").bind("click",function() {
		if(confirm("Are you sure you want to remove the checked documents from this Person?")) {
			var result = "";
			var cleanData = "";
			$(".DocCheckbox:checked").each(function () {
				result = $.ListAppend(result,$(this).val(),",");
			});
			
			$.post(sRootPath + "/_com/File/FileAjax.cfc", { method: "removeChecked", DocList: result, PersonID: nPerson, returnFormat: "plain" },
			function(returnData) {
				cleanData = $.trim(returnData);
				status = $.ListGetAt(cleanData,1,"|");
				statusMsg = $.ListGetAt(cleanData,2,"|");
				
				if(status == 'Success') {
					window.location= sMyself + 'Person.Docs?PersonID=' + nPerson + '&Message=' + statusMsg;
				} else {
					addError(statusMsg,250,6000,4000);
				}
			});
		}
	});
	
	/* REMOVE ALL FILES FROM Person */
	$("#RemoveAll").bind("click",function() {
		if(confirm("WARNING!\nYou are about to remove ALL files from this Person!\nAre you sure you wish to continue?")) {
			var cleanData = "";

			$.post(sRootPath + "/_com/File/FileAjax.cfc", { method: "removeAll", PersonID: nPerson, returnFormat: "plain" },
			function(returnData) {
				cleanData = $.trim(returnData);
				status = $.ListGetAt(cleanData,1,"|");
				statusMsg = $.ListGetAt(cleanData,2,"|");
				
				if(status == 'Success') {
					window.location= sMyself + 'Person.Docs?PersonID=' + nPerson + '&Message=' + statusMsg;
				} else {
					addError(statusMsg,250,6000,4000);
				}
			});
		}
	});
	
	$("#CheckAll").click(function() {
		if($("#CheckAll").attr("checked")) {
			$(".DocCheckbox").each(function() {
				$(this).attr("checked",true);
			});
		} else {
			$(".DocCheckbox").each(function() {
				$(this).attr("checked",false);
			});
		}
	});
});
</script>
<cfoutput>
	<cfif qFileList.RecordCount GT 0>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ViewSectionGrid">
        <cfscript>
        function FileType(path)
        {
        Var fso = CreateObject("COM", "Scripting.FileSystemObject");
        Var theFile = fso.GetFile(path);
        Return theFile.Type;
        }
        </cfscript>
        <cfset FilePath = "#ExpandPath("./_uploads/PersonFiles/#Attributes.PersonID#/")#">
        
            <tbody>
            <cfloop query="qFileList">
                <cfset FileType = Right(qFileList.FileName,Len(qFileList.FileName)-Find(".",qFileList.FileName))>
                <tr id="DocRow#qFileList.FileID#" class="AllDocs">
                    <td valign="top" style="padding-top:7px;" width="16"><input type="checkbox" name="Checked" class="DocCheckbox" id="Checked#qFileList.FileID#" value="#qFileList.FileID#" /></td>
                    <td valign="top" style="padding-top:7px;" width="16"><img src="#Application.Settings.RootPath#/_images/file_icons/#FileType#.png" /></td>
                    <td>
                        <a href="#Myself#File.Download?Mode=Person&ModeID=#Attributes.PersonID#&ID=#qFileList.FileID#" style="text-decoration:none; font-size:15px;"><strong>#qFileList.FileName#</strong></a>
                        <div style="font-size:10px; color:##555;">
                            "#qFileList.FileCaption#"<br />
                            <strong>Document Type:</strong> #qFileList.FileTypeName#<br />
                            <strong>Uploaded By:</strong> #qFileList.CreatedByFName# #qFileList.CreatedByLName#
                        </div>
                    </td>
                    <td align="center"><a href="#Myself#File.Download?Mode=Person&ModeID=#Attributes.PersonID#&ID=#qFileList.FileID#" title="Download Document"><img src="#Application.Settings.RootPath#/_images/icons/Disk.png" /></a><a href="#Myself#File.Edit&Mode=Person&ModeID=#Attributes.PersonID#&ID=#qFileList.FileID#" title="Edit Details"><img src="#Application.Settings.RootPath#/_images/icons/Pencil.png" /></a></td>
                </tr>
            </cfloop>
        </tbody>
    </table>
    <cfelse>
    <div style="background-image:url(/_images/Sample_Documents.jpg); font-size:18px; text-align:center; height:250px; width:100%;">
        <div style="padding:25px 20px;">You have not uploaded any documents.<br />Click '<a href="javascript://" class="upload-add">Upload Document</a>' on the right to begin.</div>
    </div>
    </cfif>
</cfoutput>
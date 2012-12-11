<cfoutput>
<script>
	$(document).ready(function() {
		sCommentType= "#Attributes.CommentType#";
			
		$(".ApproveComment").click(function() {
			nCommentID = $.Replace(this.id,"Approve","");
			updateComment("approveComment", nCommentID);
		});
		
		$(".DenyComment").click(function() {
			nCommentID = $.Replace(this.id,"Deny","");
			updateComment("denyComment", nCommentID);
		});
	});
</script>

<cfswitch expression="#Attributes.CommentType#">
	<cfcase value="P">
		<cfif qComments.RecordCount NEQ 0>
            <table width="100%" cellspacing="0" cellpadding="0" border="0" class="DataGrid">
                <thead>
                    <th><a href="javascript:void(0);">Activity Title</a></th>
                    <th><a href="javascript:void(0);">Comment</a></th>
                    <th><a href="javascript:void(0);">Approve?</a></th>
                </thead>
                <tbody>
                <cfloop query="qComments">
                <tr>
                    <td>#qComments.ActivityTitle#</td>
                    <td>#qComments.Comment#</td>
                    <td align="center">
                        <img src="#Application.Settings.RootPath#/_images/icons/tick.png" class="ApproveComment" id="Approve#qComments.CommentID#" />
                        <img src="#Application.Settings.RootPath#/_images/icons/cross.png" class="DenyComment" id="Deny#qComments.CommentID#" />
                    </td>
                </tr>
                </cfloop>
                </tbody>
            </table>
        <cfelse>
            <div>There are no comments to list</div>
        </cfif>
    </cfcase>
	<cfcase value="A">
		<cfif qComments.RecordCount NEQ 0>
            <table width="100%" cellspacing="0" cellpadding="0" border="0" class="DataGrid">
                <thead>
                    <th><a href="javascript:void(0);">Activity Title</a></th>
                    <th><a href="javascript:void(0);">Comment</a></th>
                    <th><a href="javascript:void(0);">Deny?</a></th>
                </thead>
                <tbody>
                <cfloop query="qComments">
                <tr>
                    <td>#qComments.ActivityTitle#</td>
                    <td>#qComments.Comment#</td>
                    <td align="center">
                        <img src="#Application.Settings.RootPath#/_images/icons/cross.png" class="DenyComment" id="Deny#qComments.CommentID#" />
                    </td>
                </tr>
                </cfloop>
                </tbody>
            </table>
        <cfelse>
            <div>There are no comments to list</div>
        </cfif>
    </cfcase>
	<cfcase value="D">
		<cfif qComments.RecordCount NEQ 0>
            <table width="100%" cellspacing="0" cellpadding="0" border="0" class="DataGrid">
                <thead>
                    <th><a href="javascript:void(0);">Activity Title</a></th>
                    <th><a href="javascript:void(0);">Comment</a></th>
                    <th><a href="javascript:void(0);">Approve?</a></th>
                </thead>
                <tbody>
                <cfloop query="qComments">
                <tr>
                    <td>#qComments.ActivityTitle#</td>
                    <td>#qComments.Comment#</td>
                    <td align="center">
                        <img src="#Application.Settings.RootPath#/_images/icons/tick.png" class="ApproveComment" id="Approve#qComments.CommentID#" />
                    </td>
                </tr>
                </cfloop>
                </tbody>
            </table>
        <cfelse>
            <div>There are no comments to list</div>
        </cfif>
    </cfcase>
</cfswitch>
</cfoutput>
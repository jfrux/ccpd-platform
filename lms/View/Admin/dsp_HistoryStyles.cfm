<cfquery name="qStyles" datasource="#Application.Settings.DSN#">
SELECT     S.HistoryStyleID, T.Name As TypeName, S.Title, S.IconImg
FROM         ce_Sys_HistoryStyle AS S INNER JOIN
                      ce_Sys_HistoryType AS T ON S.HistoryTypeID = T.HistoryTypeID
WHERE     (0 = 0)
ORDER BY T.Name,S.HistoryStyleID
</cfquery>

<!---<script>
$(document).ready(function() {
	$("#customerTable tbody td:last-child").each(function() {
		ZeroClipboard.setMoviePath('/_styles/ZeroClipboard.swf');
		//Create a new clipboard client
		var clip = new ZeroClipboard.Client();
		
		//Cache the last td and the parent row    
		var lastTd = $(this);
		var parentRow = lastTd.parent("tr");
	
		//Glue the clipboard client to the last td in each row
		clip.glue(lastTd[0]);
	
		//Grab the text from the parent row of the icon
		var txt = $.trim($("td:first-child", parentRow).text()) + "\r\n" + $.trim($("td:nth-child(2)", parentRow).text()) + "\r\n" +
		$.trim($("td:nth-child(3)", parentRow).text()) + "\r\n" + $.trim($("td:nth-child(4)", parentRow).text());
		clip.setText(txt);
	
		//Add a complete event to let the user know the text was copied
		clip.addEventListener('complete', function(client, text) {
			alert("Copied text to clipboard:\n" + text);
		});
	});
	
	//set path
	ZeroClipboard.setMoviePath('http://davidwalsh.name/dw-content/ZeroClipboard.swf');
	//create client
	var clip = new ZeroClipboard.Client();
	//event
	clip.addEventListener('mousedown',function() {
		clip.setText(document.getElementById('box-content').value);
	});
	clip.addEventListener('complete',function(client,text) {
		alert('copied: ' + text);
	});
	//glue it to the button
	clip.glue('copy');
});
</script>
<cfset Application.History.Add(
	HistoryStyleID=35,
	FromPersonID=,
	ToPersonID=
)>--->
<cfoutput>
<h1>#Request.Page.Title#</h1>
<strong><a href="#myself#Admin.HistoryStyle">Create History Style</a></strong>
<table width="400" cellspacing="1" cellpadding="1" border="0">
	<thead>
		<tr>
			<th style="width:20px;"></th>
			<th style="width:20px;"></th>
			<th style="width:200px; text-align:left;">Title</th>
			<th>Type</th>
			<th></th>
		</tr>
	</thead>
	<tbody>
		<cfloop query="qStyles">
		<tr>
			<td style="text-align:right;font-size:13px;font-weight:bold;"><a href="#myself#Admin.HistoryStyle?HistoryStyleID=#qStyles.HistoryStyleID#" style="text-decoration:none;">#qStyles.HistoryStyleID#</a></td>
			<td><a href="#myself#Admin.HistoryStyle?HistoryStyleID=#qStyles.HistoryStyleID#" style="text-decoration:none;"><img src="/admin/_images/icons/#IconImg#" border="0" style="margin-right:3px;" /></a></td>
			<td><a href="#myself#Admin.HistoryStyle?HistoryStyleID=#qStyles.HistoryStyleID#">#qStyles.Title#</a></td>
			<td><a href="#myself#Admin.HistoryStyle?HistoryStyleID=#qStyles.HistoryStyleID#">#qStyles.TypeName#</a></td>
			<td></td>
		</tr>
		</cfloop>
	</tbody>
</table>
</cfoutput>
<!---<script>
function generateTranscript(dtDate1, dtDate2, nCredit) {
	$("#TranscriptTitle").fadeIn();
	$("#frmTranscript").fadeIn();
	
	// GET RANDOM KEY FOR TRANSCRIPT REGENERATION
	$.post(sRootPath + "/_com/AJAX_UDF.cfc", { Method: "getRandomString", returnFormat: "plain" }, 
		function(data) {
			var cleanData = $.Trim(data);
			var tempURL = "<cfoutput>#application.settings.apiurl#/users/#session.person.getPersonID()#</cfoutput>/transcript?startdate=" + encodeURIComponent(dtDate1) + "&enddate=" + encodeURIComponent(dtDate2) + "&rand=" + encodeURIComponent(cleanData);
	});
}

$(document).ready(function() {
	/* TRANSCRIPT FUNCTIONS START */
		// GENERATE TRANSCRIPT FUNCTION
		$("#GenerateTranscript").bind("click", this, function() {
			if($("#new-date1").val() && $("#new-date2").val()) {			// CHECK IF DATE RANGE IS NOT BLANK
			 	generateTranscript($("#new-date1").val(),$("#new-date2").val(),$("#CreditID").val());
			}
		});
		
		$("#TranscriptGenerator input").keyup(function(e) { 
			if(e.keyCode == 13) {
			 	generateTranscript($("#new-date1").val(),$("#new-date2").val(),$("#CreditID").val());
			}
		});
	/* TRANSCRIPT FUNCTIONS END */
});
</script>
--->
<cfoutput>
<div class="ContentBlock">
	<h1>My Transcript</h1>
    <table width="100%" cellspacing="0" cellpadding="0" border="0">
		<tr>
			<td valign="top" style="padding-right:4px;">
				<h2 class="Head Gray">Create/Print Transcript</h2>
				<p>You can generate your transcript by modifying the criteria to the right and pressing the &quot;Generate&quot; button.<br />
				<br />
				This tool requires that you have Adobe Reader installed.<br />
				<a href="http://www.adobe.com/products/acrobat/readstep2.html">
				<img alt="Get Adobe Reader" src="http://www.adobe.com/images/shared/download_buttons/get_adobe_reader.gif" border="0" />
				</a></p>
				<h2 class="Head LightGray" id="TranscriptTitle" style="display:none;">Your Transcript</h2>
				<!--- <iframe src="" name="frmTranscript" id="frmTranscript" height="550" width="100%" style="display:none;" frameborder="0"></iframe> --->
			</td>
			<td valign="top" width="250">
				<h2 class="Head Red">Criteria</h2>
				<!---<p>
					<strong>Type of credit:</strong><br />
					<select name="CreditID" id="CreditID" multiple="multiple" style="font-size:11px;">
						<option value="" SELECTED>Select one...</option>
						<option value="<cfloop query='qCredits'>#qCredits.CreditID#<cfif qCredits.RecordCount GT qCredits.CurrentRow>,</cfif></cfloop>">All credit types</option>
						<cfloop query="qCredits">
						<option value="#qCredits.CreditID#">#qCredits.Name#</option>
						</cfloop>
					</select>
				</p>--->
				<form method="get" action="#application.settings.apiurl#/users/#session.person.getPersonID()#/transcript">
					
				<p id="TranscriptGenerator">
					<strong>Transcript Dates:</strong><br />
					<em>Start Date</em>
					<input type="text" id="new-date1" name="startdate" style="width:80px;" value="01/01/2012" /><br />
					<em>End Date</em>
					<input type="text" id="new-date2" name="enddate" style="width:80px;" value="#DateFormat(now(),"mm/dd/yyyy")#" />
					
				</p>
				<p>
					<input type="submit" value="Generate" id="GenerateTranscript" />
				</p>
				</form>
			</td>
		</tr>
	</table>
</div>
</cfoutput>

<cfparam name="Attributes.StartDate" default="">
<cfparam name="Attributes.EndDate" default="">

<!---<script>
	function generateReport() {
	sPrepend = "";
	
	$.blockUI({ message: '<h1>Generating Report...</h1>'});
	$.post(sRootPath + "/_com/Report/ContainerSummary.cfc", 
		{ method: "Run", CategoryID: $("#CategoryID").val(), StartDate: $("#date1").val(), EndDate: $("#date2").val(), returnFormat: "plain" },
		function(returnData) {
			cleanData = $.trim(returnData);
			status = $.ListGetAt(cleanData,1,"|");
			statusMsg = $.ListGetAt(cleanData,2,"|");
			
			if(status == 'Success') {
				window.location="<cfoutput>#myself#</cfoutput>Report.ContainerSummary?Message=" + statusMsg;
			} else if(status == 'Fail') {
				addError(statusMsg,250,6000,4000);
				$.unblockUI();
			}
		});
	}
</script>
--->
<cfoutput>
<div class="MultiFormRight_SectTitle">What can I do?</div>
<div class="MultiFormRight_LinkList">
</div>
<div class="MultiFormRight_SectBody">
	<table>
		<form name="frmACCMEData" method="post" action="#Application.Settings.RootPath#/_com/Report/ContainerSummary.cfc">
        <input tabindex="hidden" name="method" value="Run" />
		<input type="hidden" name="Submitted" value="1">
		<input type="hidden" name="ReportID" value="4">
		<tr>
			<td colspan="2" align="center">Report Generator</td>
		</tr>
        <tr>
        	<td colspan="2">
            	Container 
                <select name="CategoryID" id="CategoryID">
                	<option value="">Select one...</option>
                    <cfloop query="qCats">
                	<option value="#qCats.CategoryID#">#Left(qCats.Name,25)#<cfif Len(qCats.Name) GT 25>...</cfif></option>
                    </cfloop>
                </select>
            </td>
        </tr>
		<tr>
			<td>Start Date</td>
			<td><input type="text" name="StartDate" id="date1" value="#Attributes.StartDate#" style="font-size:10pt;width:80px;" /></td>
		</tr>
		<tr>
			<td>End Date</td>
			<td><input type="text" name="EndDate" id="date2" value="#Attributes.EndDate#" style="font-size:10pt;width:80px;" /></td>
		</tr>
		</form>
	</table>
	<div class="clear">
		#jButton("Generate Report","javascript:void(0)","accept","generateReport();")#
	</div>
</div>
</cfoutput>
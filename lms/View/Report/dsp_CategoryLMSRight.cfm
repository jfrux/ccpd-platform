
<cfparam name="Attributes.StartDate" default="">
<cfparam name="Attributes.EndDate" default="">

<cfoutput>
<div class="MultiFormRight_SectTitle">What can I do?</div>
<div class="MultiFormRight_LinkList">
</div>
<div class="MultiFormRight_SectBody">
	<table border="0" cellspacing="1" cellpadding="0">
		<form name="frmCategoryLMS" method="get" action="#Application.Settings.RootPath#/_com/Report/ActivityByCategory.cfc">
		<input type="hidden" name="Submitted" value="1">
		<input type="hidden" name="ReportID" value="#Attributes.ReportID#">
		<input type="hidden" name="method" value="Run" />
        <tr>
			<td>Start Date</td>
			<td><input type="text" name="StartDate" id="date1" value="#Attributes.StartDate#" style="font-size:10pt;width:80px;" class="fieldinput" /></td>
		</tr>
		<tr>
			<td>End Date</td>
			<td><input type="text" name="EndDate" id="date2" value="#Attributes.EndDate#" style="font-size:10pt;width:80px;" class="fieldinput" /></td>
		</tr>
		
		<tr>
        	<td colspan="2">Categories (ctrl+click)</td>
		</tr>
		<tr>
			<td colspan="2">
				<cfquery name="Categories" datasource="#Application.Settings.DSN#">
					SELECT     CategoryID, Name, Description
					FROM         ce_Sys_CategoryLMS
					ORDER BY Name
				</cfquery>
                <select name="Categories" size="5" multiple="multiple" class="fieldinput" id="CategoryID" style="width:150px; height:80px;">
                    <cfloop query="Categories">
					<option value="#Categories.CategoryID#">#Categories.Name#</option>
					</cfloop>
                </select>
            </td>
        </tr>
		
		<tr>
			<td></td>
			<td><input type="submit" value="Download" class="button" /></td>
		</tr>
		</form>
	</table>
</div>
</cfoutput>
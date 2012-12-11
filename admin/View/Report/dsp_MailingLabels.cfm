<div class="ViewSection">
	<cfoutput>
	<h3>#ActivityBean.getTitle()# - Attendees</h3>
	
	<form action="#myself#Report.MailingLabels" method="post" target="_blank">
		<input type="hidden" name="ActivityID" value="#Attributes.ActivityID#" />
        <cfif IsDefined("Attributes.SelectedMembers")>
			<input type="hidden" name="SelectedMembers" value="#Attributes.SelectedMembers#" />
       	</cfif>
		<input type="hidden" name="Print" value="1" />
	<table width="100%" cellspacing="1" cellpadding="3" border="0" class="ViewSectionGrid">
		<tr>
			<td valign="top"><input type="radio" name="ReportID" value="3" CHECKED /></td>
			<td valign="top">All Information</td>
			<td valign="top"><img src="#Application.Settings.RootPath#/_images/reports/BadgesLogoFirstLast.jpg" width="182" height="133" /></td>
		</tr>
	</table>
		<input type="submit" value="Print" />
	</form>
	</cfoutput>
</div>
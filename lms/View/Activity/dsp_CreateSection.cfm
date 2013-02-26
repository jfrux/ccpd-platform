<cfparam name="Attributes.StartDate" default="">
<cfparam name="Attributes.StartTime" default="">
<cfparam name="Attributes.EndDate" default="">
<cfparam name="Attributes.EndTime" default="">

<form action="<cfoutput>#myself#</cfoutput>Activity.CreateSection&ActivityID=<cfoutput>#Attributes.ActivityID#</cfoutput>&FormSubmit=1" name="frmCreateSection" method="post">
<table width="486" cellspacing="2" cellpadding="3" border="0">
	<tr>
		<td width="97">Start Date:</td>
		<td width="389"><input type="text" name="StartDate" id="date1" value="<cfoutput>#Attributes.StartDate#</cfoutput>" /></td>
	</tr>
	<tr>
		<td>Start Time:</td>
		<td><input type="text" name="StartTime" id="time1" value="<cfoutput>#Attributes.StartTime#</cfoutput>" /></td>
	</tr>
	<tr>
		<td width="97">End Date:</td>
		<td width="389"><input type="text" name="EndDate" id="date2" value="<cfoutput>#Attributes.EndDate#</cfoutput>" /></td>
	</tr>
	<tr>
		<td>End Time:</td>
		<td><input type="text" name="EndTime" id="time2" value="<cfoutput>#Attributes.EndTime#</cfoutput>" /></td>
	</tr>
</table>
<cfoutput>#jButton("Save","javascript:void(0);","accept.gif","SubmitForm(document.frmCreateSection);")##jButton("Cancel","#Myself#Activity.Sections&ActivityID=#Attributes.ActivityID#","delete.gif")#</cfoutput>
</form>


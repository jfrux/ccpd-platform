<cfparam name="Attributes.StartDate" default="">
<cfparam name="Attributes.StartTime" default="">
<cfparam name="Attributes.EndDate" default="">
<cfparam name="Attributes.EndTime" default="">

<cfif IsDefined("Errors") AND Errors NEQ "">
	<div class="Errors">
		<cfset arrErrors = ListToArray(Errors,",")>
		<ul>
		<cfloop index="i" from="1" to="#arrayLen(arrErrors)#">
			<li><cfoutput>#arrErrors[i]#</cfoutput></li>
		</cfloop>
		</ul>
	</div>
</cfif>

<form action="<cfoutput>#myself#</cfoutput>Activity.EditSection&ActivityID=<cfoutput>#Attributes.ActivityID#</cfoutput>&ActivitiesectionID=<cfoutput>#Attributes.ActivitiesectionID#</cfoutput>&FormSubmit=1" name="frmCreateSection" method="post">
<table width="486" cellspacing="2" cellpadding="3" border="0">
	<tr>
		<td width="97">Start Date:</td>
		<td width="389"><input type="text" name="StartDate" id="StartDate" value="<cfoutput>#Attributes.StartDate#</cfoutput>" /></td>
	</tr>
	<tr>
		<td>Start Time:</td>
		<td><input type="text" name="StartTime" id="StartTime" value="<cfoutput>#Attributes.StartTime#</cfoutput>" /></td>
	</tr>
	<tr>
		<td width="97">End Date:</td>
		<td width="389"><input type="text" name="EndDate" id="EndDate" value="<cfoutput>#Attributes.EndDate#</cfoutput>" /></td>
	</tr>
	<tr>
		<td>End Time:</td>
		<td><input type="text" name="EndTime" id="EndTime" value="<cfoutput>#Attributes.EndTime#</cfoutput>" /></td>
	</tr>
</table>
<cfoutput>#jButton("Save","javascript:void(0);","accept.gif","SubmitForm(document.frmCreateSection);")##jButton("Cancel","#Myself#Activity.Sections&ActivityID=#Attributes.ActivityID#","delete.gif")#</cfoutput>
</form>


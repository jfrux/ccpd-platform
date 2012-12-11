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

<form action="<cfoutput>#myself#</cfoutput>Activity.CreateCommittee&ActivityID=<cfoutput>#Attributes.ActivityID#</cfoutput>&FormSubmit=1" name="frmCreateCommittee" method="post">
<table width="486" cellspacing="2" cellpadding="3" border="0">
	<tr>
		<td width="97">Start Date:</td>
		<td width="389"><input type="text" name="StartDate" id="StartDate" value="<cfoutput>#Attributes.StartDate#</cfoutput>" /></td>
	</tr>
</table>
<cfoutput>#jButton("Save","javascript:void(0);","accept.gif","SubmitForm(document.frmCreateCommittee);")##jButton("Cancel","#Myself#Activity.Committee&ActivityID=#Attributes.ActivityID#","delete.gif")#</cfoutput>
</form>


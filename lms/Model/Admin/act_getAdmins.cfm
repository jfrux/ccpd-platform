<cfquery name="qGetAdmins" datasource="#Application.Settings.DSN#">
SELECT     P.firstname, P.middlename, P.lastname, P.password, P.Email
FROM         ce_person AS P INNER JOIN
			  ceschema.ce_Account AS A ON P.personid = A.PersonID
</cfquery>
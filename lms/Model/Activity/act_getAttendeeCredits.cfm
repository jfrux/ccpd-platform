<!--- ATTENDEE DETAIL --->
<cfset AttendeeBean = CreateObject("component","#Application.Settings.Com#Attendee.Attendee").Init(ActivityID=Attributes.ActivityID,PersonID=Attributes.PersonID)>
<cfset AttendeeBean = Application.Com.AttendeeDAO.Read(AttendeeBean)>

<!--- ATTENDEECREDIT DETAIL --->
<cfset qAttendeeCredits = Application.Com.AttendeeCreditGateway.getByAttributes(AttendeeID=Attributes.AttendeeID)>

<!--- ACTIVITYCREDIT DETAIL --->
<cfset qActivityCredits = Application.Com.ActivityCreditGateway.getByViewAttributes(ActivityID=Attributes.ActivityID)>

<!--- CREATE ARRAY VARS --->
<cfset aCredits = ArrayNew(2)>
<cfset RowCount = 1>

<!--- BUILD ARRAY --->
<cfloop query="qActivityCredits">
    <!--- GET MAX CREDIT AMOUNT --->
    <cfquery name="qPersonCredit" dbtype="query">
    	SELECT Amount
        FROM qAttendeeCredits
        WHERE CreditID = <cfqueryparam value="#qActivityCredits.CreditID#" cfsqltype="cf_sql_integer" />
    </cfquery>
    
    <!--- CHECK IF ANY RECORDS WERE RETURNED FROM qPERSONCREDIT --->
    <cfif qPersonCredit.RecordCount EQ 0>						<!--- SET Attendee Credit Amount --->
		<cfset aCredits[RowCount][1] = "0">
    <cfelse>
		<cfset aCredits[RowCount][1] = qPersonCredit.Amount>
    </cfif>
	<cfset aCredits[RowCount][2] = qActivityCredits.Amount>		<!--- Total Amount of Credit Allowed --->
	<cfset aCredits[RowCount][3] = qActivityCredits.CreditName>	<!--- Type of Credit --->
	<cfset aCredits[RowCount][4] = qActivityCredits.CreditID>	<!--- CreditID --->
    
	<cfset RowCount = RowCount + 1>
</cfloop>
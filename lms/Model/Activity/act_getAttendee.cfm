<cfparam name="Attributes.ActivityID" default="" />
<cfparam name="attributes.attendeeStatusId" default="0" />
<cfparam name="attributes.attendeeId" default="0" />
<cfparam name="attributes.deletedFlag" default="Y" />
<cfparam name="Session.PersonID" default="" />

<cfif Session.PersonID GT 0 AND Attributes.ActivityID NEQ "">
	<cfset AttendeeBean = CreateObject("component","#Application.Settings.Com#Attendee.Attendee").Init(PersonID=Session.PersonID,ActivityID=Attributes.ActivityID,DeletedFlag="N")>
    <cfset AttendeeExists = Application.Com.AttendeeDAO.Exists(AttendeeBean)>
    
    <cfif AttendeeExists>
    	<cfset AttendeeBean = Application.Com.AttendeeDAO.Read(AttendeeBean)>
        
        <cfif AttendeeBean.getStatusID() EQ 3>
        	<cfset AttendeeBean.setStatusID(2)>
            <cfset AttendeeSaved = Application.Com.AttendeeDAO.Update(AttendeeBean)>
        </cfif>
        
        <cfset Attributes.AttendeeID = AttendeeBean.getAttendeeID()>
        <cfset Attributes.AttendeeStatusID = AttendeeBean.getStatusID()>
        <cfset Attributes.TermsFlag = AttendeeBean.getTermsFlag()>
        <cfset attributes.deletedFlag = attendeeBean.getDeletedFlag()>
		<cfquery name="AttendeeDetail" datasource="#Application.Settings.DSN#">
			SELECT	S.Name AS Status, S.Code AS StatusCode, A.TermsFlag, A.PaymentFlag, A.Created, A.Updated
			FROM	ce_Attendee AS A 
            INNER JOIN ce_Sys_AttendeeStatus AS S ON A.StatusID = S.AttendeeStatusID
			WHERE A.AttendeeID=<cfqueryparam value="#Attributes.AttendeeID#" cfsqltype="cf_sql_integer" /> AND A.DeletedFlag='N'
		</cfquery>
    </cfif>
</cfif>
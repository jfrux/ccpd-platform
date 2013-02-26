<cfparam name="Attributes.Submitted" default="0" />
<cfparam name="CreditChangeCount" default="0" />

<cfif Attributes.Submitted EQ 1>
	<!--- ACTIVITYCREDIT DETAIL --->
    <cfset qActivityCredits = Application.Com.ActivityCreditGateway.getByViewAttributes(ActivityID=Attributes.ActivityID)>
    
	<cfloop query="qActivityCredits">
    	<!--- SET PARAMS --->
        <cfparam name="Attributes.Amount#qActivityCredits.CreditID#" default="0" />
        <cfparam name="Attributes.CreditID#qActivityCredits.CreditID#" default="" />
        <cfparam name="Attributes.ReferenceNo#qActivityCredits.CreditID#" default="" />
        
    	<!--- DEFINE VARIABLES --->
    	<cfset Attributes.Amount = Evaluate("Attributes.Amount#qActivityCredits.CreditID#")>
        <cfset Attributes.CreditID = Evaluate("Attributes.CreditID#qActivityCredits.CreditID#")>
        <cfset Attributes.ReferenceNo = Evaluate("Attributes.ReferenceNo#qActivityCredits.CreditID#")>
		
        <!--- CHECK IF CREDIT AMOUNT IS GREATER THAN ZERO --->
        <cfif isNumeric(Attributes.Amount)>
			<!--- ATTENDEE DETAIL --->
            <cfset AttendeeBean = CreateObject("component","#Application.Settings.Com#Attendee.Attendee").Init(ActivityID=Attributes.ActivityID,PersonID=Attributes.PersonID)>
            <cfset AttendeeBean = Application.Com.AttendeeDAO.Read(AttendeeBean)>
            
            <!--- ATTENDEECREDIT DETAILS --->
            <cfset AttendeeCreditBean = CreateObject("component","#Application.Settings.Com#AttendeeCredit.AttendeeCredit").Init(AttendeeID=AttendeeBean.getAttendeeID(),CreditID=qActivityCredits.CreditID)>
            <cfset AttendeeCreditExists = Application.Com.AttendeeCreditDAO.Exists(AttendeeCreditBean)>
            
            <cfif AttendeeCreditExists>
				<cfset AttendeeCreditBean = Application.Com.AttendeeCreditDAO.Read(AttendeeCreditBean)>
            <cfelse>
            	<cfset AttendeeCreditBean.setCreatedBy(Session.Person.getPersonID())>
				<cfset AttendeeCreditBean.setCreditID(Attributes.CreditID)>
            </cfif>
            
            <!--- CHECK IF CREDIT TYPE NEEDS UPDATED --->
            <cfif Attributes.Amount NEQ AttendeeCreditBean.getAmount() AND Attributes.Amount LTE qActivityCredits.Amount>
            	<!--- UPDATE CREDITCHANGECOUNT --->
				<cfset CreditChangeCount = CreditChangeCount + 1>
                
				<!--- FILL BEAN WITH NEW VARIABLES --->
				<cfset AttendeeCreditBean.setAmount(Attributes.Amount)>
                                
				<!--- SAVE ATTENDEECREDIT BEAN --->
				<cfset AttendeeCreditBean = Application.Com.AttendeeCreditDAO.Save(AttendeeCreditBean)>
            <cfelse>
            	<!--- CREDIT AMOUNT EXCEEDED TOTAL AMOUNT --->
            	<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please enter a credit amount less than or equal to the total available.","|")>
            </cfif>
        </cfif>
    </cfloop>
    
    <!--- DETERMINE IF ANY CREDITS WERE UPDATED --->
    <cfif CreditChangeCount GT 0>
		<!--- PERSON DETAIL --->
        <cfset PersonBean = CreateObject("component","#Application.Settings.Com#Person.Person").Init(PersonID=Attributes.PersonID, ActivityID=Attributes.ActivityID)>
        <cfset PersonBean = Application.Com.PersonDAO.Read(PersonBean)>
        
        <!--- ACTIVITY DETAIL --->
        <cfset ActivityBean = CreateObject("component","#Application.Settings.Com#Activity.Activity").init(ActivityID=Attributes.ActivityID)>
        <cfset ActivityBean = Application.Com.ActivityDAO.read(ActivityBean)>
        
        <!--- FILL ACTIONBEAN --->
        <cfset ActionBean = CreateObject("component","#Application.Settings.Com#Action.Action").init()>
        <cfset ActionBean.setPersonID(Attributes.PersonID)>
        <cfset ActionBean.setActivityID(Attributes.ActivityID)>
        <cfset ActionBean.setCode("CRA")>
        <cfset ActionBean.setShortName("Changed attendee credit info.")>
        <cfset ActionBean.setLongName("Changed attendee credit information for '<a href=""#myself#Person.Detail?PersonID=#PersonBean.getPersonID()#"">#PersonBean.getFirstName()# #PersonBean.getLastName()#</a>' on activity '<a href=""/index.cfm/event/Activity.Detail?ActivityID=#Attributes.ActivityID#"">#ActivityBean.getTitle()#</a>'.")>
        <cfset ActionBean.setCreatedBy(Session.Person.getPersonID())>
        <cfset Application.Com.ActionDAO.Create(ActionBean)>
    	<!---<cflocation url="#Myself#Activity.AdjustCredits?ActivityID=#Attributes.ActivityID#&PersonID=#Attributes.PersonID#&AttendeeID=#Attributes.AttendeeID#" addtoken="no">--->
    </cfif>
</cfif>
<!--- On form submission, run this code --->
<cfif IsDefined("Attributes.Submitted") AND Attributes.Submitted EQ 1>
	<!--- Creates CreditType List and sets up the Attributes.Credits var --->
	<cfset qCredits = Application.Com.CreditGateway.getByAttributes()>
	<cfparam name="Attributes.Credits" default="" />
	
	<!--- Creates all CreditType variables as well as CreditAmount variables --->
	<cfloop query="qCredits">
		<cfparam name="Attributes.CreditAmount#qCredits.CreditID#" default="0" />
		<cfparam name="Attributes.ReferenceNo#qCredits.CreditID#" default="0" />
	</cfloop>

	<cfset Request.Status.Errors = "">
	
	<!--- Loops through the Error Checking --->
	<cfloop query="qCredits">
		<!--- Checks if there is a check mark with no amount entered --->
		<cfif ListFind(Attributes.Credits,qCredits.CreditID,",") AND Evaluate("Attributes.CreditAmount#qCredits.CreditID#") EQ 0>
			<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please set a Credit Amount for #Name# Credit Type.","|")>
		<!--- Checks if there is an amount but no check mark --->
		<cfelseif NOT ListFind(Attributes.Credits,qCredits.CreditID,",") AND Evaluate("Attributes.CreditAmount#qCredits.CreditID#") GT 0>
			<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please check the #Name# Credit Type.","|")>
		<!--- Checks if there is an amount but no check mark --->
		<cfelseif ListFind(Attributes.Credits,qCredits.CreditID,",") AND qCredits.ReferenceFlag EQ "Y" AND Evaluate("Attributes.ReferenceNo#qCredits.CreditID#") EQ "">
			<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"The #Name# Reference Number is required.","|")>
		</cfif>
	</cfloop>
	
	<cfif Request.Status.Errors EQ "">
		<!--- DELETE EXISTING --->
		<cfquery name="qDelete" datasource="#Application.Settings.DSN#">
			DELETE ce_Activity_Credit
			WHERE ActivityID=<cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" />
		</cfquery>
		
		<cfloop query="qCredits">
			<!--- if the CreditAmount Field is not empty it saves those values to the DB --->
			<cfif ListFind(Attributes.Credits,qCredits.CreditID) AND Evaluate("Attributes.CreditAmount#qCredits.CreditID#") GT 0>
				<!--- Creates the Create Bean --->
				<cfset CreateCreditsBean = CreateObject("component","#Application.Settings.Com#ActivityCredit.ActivityCredit").Init()>
				
				<!--- Fill the Create Bean --->
				<cfset CreateCreditsBean.setActivityID(Attributes.ActivityID)>
				<cfset CreateCreditsBean.setCreditID(qCredits.CreditID)>
				<cfset CreateCreditsBean.setAmount(Evaluate("Attributes.CreditAmount#qCredits.CreditID#"))>
                
				<cfif  qCredits.ReferenceFlag EQ "Y">
					<cfset CreateCreditsBean.setReferenceNo(Evaluate("Attributes.ReferenceNo#qCredits.CreditID#"))>
                </cfif>
				
				<cfset CreateCreditsBean = Application.Com.ActivityCreditDAO.Create(CreateCreditsBean)>
				
				<!--- Read Credit Info --->
				<cfset CreditInfo = CreateObject("component","#Application.Settings.Com#System.Credit").init(CreditID=qCredits.CreditID)>
				<cfset CreditInfo = Application.Com.CreditDAO.read(CreditInfo)>
				
				<!--- ACTION UPDATER --->
                <cfset Application.History.add(
                            HistoryStyleID=24,
                            FromPersonID=Session.PersonID,
                            ToActivityID=attributes.activityId,
							ToCreditID=qCredits.creditId
						)>
							
				<!---<cfset ActionBean = CreateObject("component","#Application.Settings.Com#Action.Action").init()>
				<cfset ActionBean.setActivityID(Attributes.ActivityID)>
				<cfset ActionBean.setCode("CRA")>
				<cfset ActionBean.setShortName("Added credit.")>
				<cfset ActionBean.setLongName("Added '#CreditInfo.getName()#' credit to activity '<a href=""#myself#Activity.Detail?ActivityID=#ActivityBean.getActivityID()#"">#ActivityBean.getTitle()#</a>'")>
				<cfset ActionBean.setCreatedBy(Session.Person.getPersonID())>
				<cfset Application.Com.ActionDAO.Create(ActionBean)>--->
			</cfif>
		</cfloop>
		
		<cflocation url="#Myself#Activity.Credits?ActivityID=#Attributes.ActivityID#&Message=Credits Saved Successfully!" addtoken="no">
	</cfif>
</cfif>
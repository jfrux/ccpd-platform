<cfparam name="Request.Status.Errors" default="">

<cfinclude template="/_com/_UDF/isMD.cfm" />

<cfif Form.Submitted EQ 1>	
	<!--- CHECK FOR GENDER, ETHNICITY, OMBEthnicity TO MAKE SURE ATTENDEECDC RECORD IS CREATED --->
    <cfif Form.Gender EQ "">
        <cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please select a gender.","|")>
    </cfif>
    
    <cfif Form.Ethnicity EQ "">
        <cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please select an ethnicity.","|")>
    </cfif>
    
   	<cfif Form.OMBEthnicity EQ "">
        <cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please select a racial background.","|")>
    </cfif>
    
    <cfif Form.WorkState EQ "">
        <cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please select a state.","|")>
    </cfif>
    
    <cfif Form.WorkZip EQ "">
        <cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please enter a zip code.","|")>
    </cfif>
	
	<cfif Form.OccClassID EQ "">
		<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"You must select an answer for question <strong><u>4. Occupational Classification</u></strong>","|")>
	<cfelse>
		<cfswitch expression="#form.OccClassID#">
			<cfcase value="1">
				<cfif Form.ProfCID EQ "">
					<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"You must select an answer for question <strong><u>5. Your Profession</u></strong>","|")>
				</cfif>
			</cfcase>
			<cfcase value="2">
				<cfif Form.ProfNID EQ "">
					<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"You must select an answer for question <strong><u>5. Your Profession</u></strong>","|")>
				</cfif>
			</cfcase>
		</cfswitch>
	</cfif>
    
	<!--- PRIMARY PROGRAMMATIC FOCUS --->
	
	<cfif Form.PrinEmpID EQ "">
		<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"You must select an answer for question <strong><u>8. Principal Employment Setting</u></strong>","|")>
	<cfelse>
		<cfif Form.PrinEmpID EQ 1>
			<cfif Form.CBOFundID EQ "">
				<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please select a Community-Based Organization funding.","|")>
			</cfif>
		<cfelseif Form.PrinEmpID EQ 12>
			<cfif Form.CBAFundID EQ "">
				<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please select a Capacity-Building and Technical Assistance funding.","|")>
			</cfif>
		</cfif>
	</cfif>
    
    
	<cfif NOT IsDefined("form.ActivityID") OR IsDefined("form.ActivityID") AND Form.ActivityID EQ "">
        <cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please select an activity.","|")>
	</cfif>
    
    <cfif Request.Status.Errors EQ "">
    	<cfset nAttendeeCDCId = 0>
		<cfset nAttendeeID = addAttendee(ActivityID=form.ActivityID,PersonID=Session.PersonID)>
        
		<cfif nAttendeeID NEQ 0>
			<cfquery name="qUpdatePerson" datasource="#Application.Settings.DSN#">
				UPDATE ce_Person
				SET 
                	Gender=<cfqueryparam value="#Form.Gender#" cfsqltype="cf_sql_varchar" />,
                    EthnicityID = <cfqueryparam value="#Form.Ethnicity#" cfsqltype="cf_sql_integer" />,
					OMBEthnicityID = <cfqueryparam value="#Form.OMBEthnicity#" cfsqltype="cf_sql_integer" />
				WHERE PersonID=#Session.PersonID#
			</cfquery>
            
			<cfset CDCBean = CreateObject("component","#Application.Settings.Com#Attendee.AttendeeCDC").init(attendeeId=nAttendeeID)>
            <cfif application.com.attendeeCDCDAO.exists(CDCBean)>
            	<cfset CDCBean = application.com.attendeeCDCDAO.read(CDCBean)>
            </cfif>
            
            <cfset CDCBean.setAttendeeID(nAttendeeID)>
            <cfset CDCBean.setCBAFundID(Form.CBAFundID)>
            <cfset CDCBean.setCBACDC(Form.CBACDC)>
            <cfset CDCBean.setCBAOth(Form.CBAOth)>
            
            <cfset CDCBean.setCBOFundID(Form.CBOFundID)>
            <cfset CDCBean.setCBOCDC(Form.CBOCDC)>
            <cfset CDCBean.setCBOOth(Form.CBOOth)>
            
            <cfset CDCBean.setProfCId(Form.ProfCId)>
            <cfset CDCBean.setProfCSp(Form.ProfCOther)>
            <cfset CDCBean.setProfNId(Form.ProfNId)>
            <cfset CDCBean.setProfNSp(Form.ProfNOther)>
            
            <cfset CDCBean.setFunRCId(Form.FunRCId)>
            <cfset CDCBean.setFunRCSp(Form.FunRCOther)>
            <cfset CDCBean.setFunRNId(Form.FunRNId)>
            <cfset CDCBean.setFunRNSp(Form.FunRNOther)>
            
            <cfset CDCBean.setOccClassID(Form.OccClassID)>
            <cfset CDCBean.setOrgTypeID(Form.OrgTypeID)>
            <cfset CDCBean.setTspecify(Form.OrgTypeOther)>
            
            <cfset CDCBean.setPrinEmpID(Form.PrinEmpID)>
            <cfset CDCBean.setPrinEmpSp(Form.PrinEmpOther)>
            
            <cfset CDCBean.setWorkState(Form.WorkState)>
            <cfset CDCBean.setWorkZip(Form.WorkZip)>
            
            <cfset CDCBean.setFocSTD(Form.Focus1)>
            <cfset CDCBean.setFocHIV(Form.Focus2)>
            <cfset CDCBean.setFocWRH(Form.Focus3)>
            <cfset CDCBean.setFocGen(Form.Focus4)>
            <cfset CDCBean.setFocAdol(Form.Focus5)>
            <cfset CDCBean.setFocMH(Form.Focus6)>
            <cfset CDCBean.setFocSub(Form.Focus7)>
            <cfset CDCBean.setFocEm(Form.Focus8)>
            <cfset CDCBean.setFocCor(Form.Focus9)>
            <cfset CDCBean.setFocOth(Form.Focus10)>
            <cfset CDCBean.setFocSpec(Form.FocusOther)>
            
            <cfset CDCBean.setPopGen(Form.SpecialPop1)>
            <cfset CDCBean.setPopAdol(Form.SpecialPop2)>
            <cfset CDCBean.setPopGLB(Form.SpecialPop3)>
            <cfset CDCBean.setPopTran(Form.SpecialPop4)>
            <cfset CDCBean.setPopHome(Form.SpecialPop5)>
            <cfset CDCBean.setPopCorr(Form.SpecialPop6)>
            <cfset CDCBean.setPopPreg(Form.SpecialPop7)>
            <cfset CDCBean.setPopSW(Form.SpecialPop8)>
            <cfset CDCBean.setPopAA(Form.SpecialPop9)>
            <cfset CDCBean.setPopAs(Form.SpecialPop10)>
            <cfset CDCBean.setPopNH(Form.SpecialPop11)>
            <cfset CDCBean.setPopAIAN(Form.SpecialPop12)>
            <cfset CDCBean.setPopHisp(Form.SpecialPop13)>
            <cfset CDCBean.setPopImm(Form.SpecialPop14)>
            <cfset CDCBean.setPopSub(Form.SpecialPop15)>
            <cfset CDCBean.setPopIDU(Form.SpecialPop16)>
            <cfset CDCBean.setPopHIV(Form.SpecialPop17)>
            <cfset CDCBean.setPopOth(Form.SpecialPop18)>
            <cfset CDCBean.setPopSpec(Form.SpecialPopOther)>
            
            <cfset CDCBean.setMarketId(Form.MarketID)>
            <cfset CDCBean.setMspecify(Form.MarketOther)>
            <cfset CDCBean.setUpdates(Form.ContactUpdates)>
            <cfset CDCBean.setEval(Form.ContactEval)>
            <cfset CDCBean.setTrainingAlert(Form.PTCAlert)>
            <cfset CDCBean.setCurrentlyEnrolled(Form.CurrentlyEnrolled)>
            <cfset CDCBean.setRelevantTraining(Form.PTCTraining)>
            <cfset CDCBean.setMotivationTraining(Form.PrimaryMotivation)>
            <cfset CDCBean.setDeletedFlag("N")>
            
            <!--- Set who updated the info --->
            <cfif CDCBean.getAttendeeCDCID() EQ "">
            	<cfset CDCBean.setCreatedBy(Session.PersonID)>
            <cfelse>
            	<cfset CDCBean.setUpdated(Now())>
            	<cfset CDCBean.setUpdatedBy(Session.PersonID)>
            </cfif>
            
            <cfset aErrors = CDCBean.validate()>
            <!--- Submits the Bean for data saving --->
            <cfif ArrayLen(aErrors) GT 0>
                <cfdump var="#aErrors#">
                <cfabort>
            </cfif>
            
            <cfset CDCSaved = Application.Com.AttendeeCDCDAO.save(CDCBean)>
            
            <cflocation url="#Request.RootPath#/cdc_reg.cfm" addtoken="no" />
		<cfelse>
            <cfset Request.Status.Errors = ListAppend(Request.Status.Errors, "You have already registered for this activity.", "|")>
        </cfif>
    </cfif>
</cfif>

<cffunction name="addAttendee" access="private" returntype="any" output="true">
	<cfargument name="ActivityID" required="yes" type="string">
	<cfargument name="PersonID" required="yes" type="string">
    
	<cfset var nAttendeeID = 0>
	
	<cfquery name="qFindAttendee" datasource="#Application.Settings.DSN#">
		SELECT DeletedFlag, AttendeeID
		FROM ce_Attendee
		WHERE 
        	PersonID = <cfqueryparam value="#Arguments.PersonID#" CFSQLType="cf_sql_integer" /> AND 
        	ActivityID = <cfqueryparam value="#Arguments.ActivityID#" CFSQLType="cf_sql_integer" />
	</cfquery>
    
	<cfif qFindAttendee.RecordCount LTE 0>
		<!--- CHECK IF MD --->
		<cfif isMD(Arguments.PersonID)>
			<cfset MDFlag = "Y">
		<cfelse>
			<cfset MDFlag = "N">
		</cfif>
		
		<cfquery name="addAttendee" datasource="#Application.Settings.DSN#" result="CreateResult">
			INSERT INTO ce_Attendee
				(
				ActivityID,
				PersonID,
                StatusID,
                RegisterDate,
				DeletedFlag,
				CreatedBy,
				MDFlag
				)
				VALUES
				(
				<cfqueryparam value="#Arguments.ActivityID#" CFSQLType="cf_sql_integer" />,
				<cfqueryparam value="#Arguments.PersonID#" CFSQLType="cf_sql_integer" />,
                <cfqueryparam value="3" cfsqltype="cf_sql_integer" />,
				<cfqueryparam value="#Now()#" CFSQLType="cf_sql_timestamp" />,
				<cfqueryparam value="N" CFSQLType="cf_sql_char" />,
				#Session.PersonID#,
				'#MDFlag#'
				); SELECT @@IDENTITY AS nAttendeeID
		</cfquery>
        
        <cfset nAttendeeID = AddAttendee.nAttendeeID>
		
		<!--- PERSON DETAIL --->
		<cfset PersonBean = CreateObject("component","#Application.Settings.Com#Person.Person").init(PersonID=Arguments.PersonID)>
		<cfset PersonBean = Application.Com.PersonDAO.read(PersonBean)>
        
		<!--- ACTIVITY DETAIL --->
		<cfset ActivityBean = CreateObject("component","#Application.Settings.Com#Activity.Activity").init(ActivityID=Arguments.ActivityID)>
		<cfset ActivityBean = Application.Com.ActivityDAO.read(ActivityBean)>
		
		<!--- ACTIVITY STATS --->
		<cfset ActivityBean.setStatAttendees(ActivityBean.getStatAttendees()+1)>
		
		<cfif MDFlag EQ "Y">
			<cfset ActivityBean.setStatMD(ActivityBean.getStatMD()+1)>
		<cfelse>
			<cfset ActivityBean.setStatNonMD(ActivityBean.getStatNonMD()+1)>
		</cfif>

		<!--- Check if activity is a Parent Activity --->
		<cfif ActivityBean.getParentActivityID() NEQ "">
			<!--- Update ParentActivity StatAttendees --->
			<cfset ParentActivityBean = CreateObject("component","#Application.Settings.Com#Activity.Activity").Init(ActivityID=ActivityBean.getParentActivityID())>
			<cfset ParentActivityBean = Application.Com.ActivityDAO.Read(ParentActivityBean)>
			<cfset ParentActivityBean.setStatAttendees(ParentActivityBean.getStatAttendees()+1)>
			<cfif MDFlag EQ "Y">
				<cfset ParentActivityBean.setStatMD(ParentActivityBean.getStatMD()+1)>
			<cfelse>
				<cfset ParentActivityBean.setStatNonMD(ParentActivityBean.getStatNonMD()+1)>
			</cfif>
			<cfset ParentActivityBean = Application.Com.ActivityDAO.Update(ParentActivityBean)>
		</cfif>
		
		<cfset Application.Com.ActivityDAO.Update(ActivityBean)>
                
		<cfset Application.History.Add(
                    HistoryStyleID=20,
                    ToPersonID=Arguments.PersonID,
                    FromPersonID=Arguments.PersonID,
                    ToActivityID=Arguments.ActivityID)>
		
		<cfset Status = "Success|#PersonBean.getFirstName()# #PersonBean.getLastName()# has been added.">
		
		
	<cfelse>
		<!--- Checks if there was a record for the person already --->
		<cfif qFindAttendee.RecordCount EQ 1 AND qFindAttendee.DeletedFlag EQ 'Y'>
			<!--- If a record exists but DeletedFlag EQ Y then it is updated to N --->
			<!--- CHECK IF MD --->
			<cfif isMD(Arguments.PersonID)>
				<cfset MDFlag = "Y">
			<cfelse>
				<cfset MDFlag = "N">
			</cfif>
			
			<cfquery name="qGetAttendee" datasource="#Application.Settings.DSN#">
				SELECT AttendeeID 
                FROM ce_Attendee
				WHERE PersonID = <cfqueryparam value="#PersonID#" CFSQLType="cf_sql_integer" /> AND ActivityID = <cfqueryparam value="#Arguments.ActivityID#" CFSQLType="cf_sql_integer" />	
			</cfquery>
			
			<cfset nAttendeeID=qGetAttendee.AttendeeID>
			
			<cfquery name="qUpdateDeletedFlag" datasource="#Application.Settings.DSN#">
				UPDATE ce_Attendee
				SET MDFlag='#MDFlag#',
                	StatusID=3,
                	RegisterDate = <cfqueryparam value="#Now()#" CFSQLType="cf_sql_timestamp" />,
                    DeletedFlag = <cfqueryparam value="N" cfsqltype="cf_sql_char" />
				WHERE AttendeeID=<cfqueryparam value="#qGetAttendee.AttendeeID#" cfsqltype="cf_sql_integer" />
			</cfquery>
			
			<!--- PERSON DETAIL --->
			<cfset PersonBean = CreateObject("component","#Application.Settings.Com#Person.Person").init(PersonID=Arguments.PersonID)>
			<cfset PersonBean = Application.Com.PersonDAO.read(PersonBean)>
			
			<!--- ACTIVITY DETAIL --->
			<cfset ActivityBean = CreateObject("component","#Application.Settings.Com#Activity.Activity").init(ActivityID=Arguments.ActivityID)>
			<cfset ActivityBean = Application.Com.ActivityDAO.read(ActivityBean)>
			
			<!--- ACTIVITY STATS --->
			<cfset ActivityBean.setStatAttendees(ActivityBean.getStatAttendees()+1)>
			
			<cfif MDFlag EQ "Y">
				<cfset ActivityBean.setStatMD(ActivityBean.getStatMD()+1)>
			<cfelse>
				<cfset ActivityBean.setStatNonMD(ActivityBean.getStatNonMD()+1)>
			</cfif>

			<!--- Check if activity is a Parent Activity --->
			<cfif ActivityBean.getParentActivityID() NEQ "">
				<!--- Update ParentActivity StatAttendees --->
				<cfset ParentActivityBean = CreateObject("component","#Application.Settings.Com#Activity.Activity").Init(ActivityID=ActivityBean.getParentActivityID())>
				<cfset ParentActivityBean = Application.Com.ActivityDAO.Read(ParentActivityBean)>
				<cfset ParentActivityBean.setStatAttendees(ParentActivityBean.getStatAttendees()+1)>
				<cfset ParentActivityBean = Application.Com.ActivityDAO.Update(ParentActivityBean)>
			</cfif>
			
			<cfset Application.Com.ActivityDAO.Update(ActivityBean)>
                
			<cfset Application.History.Add(
                        HistoryStyleID=20,
                        FromPersonID=Arguments.PersonID,
                        ToPersonID=Arguments.PersonID,
                        ToActivityID=Arguments.ActivityID)>
			
			<cfset Status = "Success|#PersonBean.getFirstName()# #PersonBean.getLastName()# has been added.">
		<cfelse>
			<cfset Status = "Fail|Attendee already exists.">
		</cfif>
	</cfif>
	
	<cfreturn nAttendeeID />
</cffunction>
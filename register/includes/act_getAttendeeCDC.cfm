<!--- GET CDC --->
<cfparam name="Form.CBAFundID" default="">
<cfparam name="Form.CBACDC" default="">
<cfparam name="Form.CBAOth" default="">

<cfparam name="Form.CBOFundID" default="">
<cfparam name="Form.CBOCDC" default="">
<cfparam name="Form.CBOOth" default="">

<cfparam name="Form.ProfCId" default="99">
<cfparam name="Form.ProfCOther" default="">
<cfparam name="Form.ProfNId" default="99">
<cfparam name="Form.ProfNOther" default="">

<cfparam name="Form.FunRCId" default="99">
<cfparam name="Form.FunRCOther" default="">
<cfparam name="Form.FunRNId" default="99">
<cfparam name="Form.FunRNOther" default="">

<cfparam name="Form.OccClassID" default="0">
<cfparam name="Form.OrgTypeId" default="0">
<cfparam name="Form.OrgTypeOther" default="">

<cfparam name="Form.PrinEmpID" default="0">
<cfparam name="Form.PrinEmpOther" default="">

<cfparam name="Form.WorkState" default="0">
<cfparam name="Form.WorkZip" default="">

<cfparam name="Form.Focus1" default="N">
<cfparam name="Form.Focus2" default="N">
<cfparam name="Form.Focus3" default="N">
<cfparam name="Form.Focus4" default="N">
<cfparam name="Form.Focus5" default="N">
<cfparam name="Form.Focus6" default="N">
<cfparam name="Form.Focus7" default="N">
<cfparam name="Form.Focus8" default="N">
<cfparam name="Form.Focus9" default="N">
<cfparam name="Form.Focus10" default="N">
<cfparam name="Form.FocusOther" default="">

<cfparam name="Form.SpecialPop1" default="N">
<cfparam name="Form.SpecialPop2" default="N">
<cfparam name="Form.SpecialPop3" default="N">
<cfparam name="Form.SpecialPop4" default="N">
<cfparam name="Form.SpecialPop5" default="N">
<cfparam name="Form.SpecialPop6" default="N">
<cfparam name="Form.SpecialPop7" default="N">
<cfparam name="Form.SpecialPop8" default="N">
<cfparam name="Form.SpecialPop9" default="N">
<cfparam name="Form.SpecialPop10" default="N">
<cfparam name="Form.SpecialPop11" default="N">
<cfparam name="Form.SpecialPop12" default="N">
<cfparam name="Form.SpecialPop13" default="N">
<cfparam name="Form.SpecialPop14" default="N">
<cfparam name="Form.SpecialPop15" default="N">
<cfparam name="Form.SpecialPop16" default="N">
<cfparam name="Form.SpecialPop17" default="N">
<cfparam name="Form.SpecialPop18" default="N">
<cfparam name="Form.SpecialPopOther" default="">

<cfparam name="Form.MarketID" default="0">
<cfparam name="Form.MarketOther" default="">
<cfparam name="Form.ContactUpdates" default="Y">
<cfparam name="Form.ContactEval" default="Y">
<cfparam name="Form.PTCAlert" default="Y">
<cfparam name="Form.CurrentlyEnrolled" default="FALSE">
<cfparam name="Form.PTCTraining" default="FALSE">
<cfparam name="Form.PrimaryMotivation" default="FALSE">

<cfquery name="qGetLatest" datasource="CCPD_Prod">
	SELECT     TOP (1) AttendeeID
	FROM         ce_Attendee
	WHERE     (PersonID = <cfqueryparam value="#Session.PersonID#" cfsqltype="cf_sql_integer" />) AND DeletedFlag='N'
	ORDER BY Created DESC
</cfquery>

<!--- CHECK IF AN ATTENDEE RECORD WAS FOUND FOR THIS PERSON --->
<cfif qGetLatest.RecordCount GT 0>
	<!--- PULL INFO BASED ON QGETLATEST.ATTENDEEID --->
	<cfset CDCBean = CreateObject("component","#Application.Settings.Com#Attendee.AttendeeCDC").init(AttendeeID=qGetLatest.AttendeeID)>
    
    <cfif Application.Com.AttendeeCDCDAO.Exists(CDCBean)>
        
        <cfset CDCBean = Application.Com.AttendeeCDCDAO.read(CDCBean)>
        
        <cfif Form.Submitted EQ "">
            <cfset Form.CBAFundID = CDCBean.getCBAFundID()>
            <cfset Form.CBACDC = CDCBean.getCBACDC()>
            <cfset Form.CBAOth = CDCBean.getCBAOth()>
            
            <cfset Form.CBOFundID = CDCBean.getCBOFundID()>
            <cfset Form.CBOCDC = CDCBean.getCBOCDC()>
            <cfset Form.CBOOth = CDCBean.getCBOOth()>
            
            <cfset Form.ProfCId = CDCBean.getProfCId()>
            <cfset Form.ProfCOther = CDCBean.getProfCSp()>
            <cfset Form.ProfNId = CDCBean.getProfNId()>
            <cfset Form.ProfNOther = CDCBean.getProfNSp()>
            
            <cfset Form.FunRCId = CDCBean.getFunRCId()>
            <cfset Form.FunRCOther = CDCBean.getFunRCSp()>
            <cfset Form.FunRNId = CDCBean.getFunRNId()>
            <cfset Form.FunRNOther = CDCBean.getFunRCSp()>
            
            <cfset Form.OccClassID = CDCBean.getOccClassID()>
            <cfset Form.OrgTypeId = CDCBean.getOrgTypeId()>
            <cfset Form.OrgTypeOther = CDCBean.getTspecify()>
            
            <cfset Form.PrinEmpID = CDCBean.getPrinEmpID()>
            <cfset Form.PrinEmpOther = CDCBean.getPrinEmpSp()>
            
            <cfset Form.WorkState = CDCBean.getWorkState()>
            <cfset Form.WorkZip = CDCBean.getWorkZip()>
            
            <cfset Form.Focus1 = CDCBean.getFocSTD()>
            <cfset Form.Focus2 = CDCBean.getFocHIV()>
            <cfset Form.Focus3 = CDCBean.getFocWRH()>
            <cfset Form.Focus4 = CDCBean.getFocGen()>
            <cfset Form.Focus5 = CDCBean.getFocAdol()>
            <cfset Form.Focus6 = CDCBean.getFocMH()>
            <cfset Form.Focus7 = CDCBean.getFocSub()>
            <cfset Form.Focus8 = CDCBean.getFocEm()>
            <cfset Form.Focus9 = CDCBean.getFocCor()>
            <cfset Form.Focus10 = CDCBean.getFocOth()>
            <cfset Form.FocusOther = CDCBean.getFocSpec()>
            
            <cfset Form.SpecialPop1 = CDCBean.getPopGen()>
            <cfset Form.SpecialPop2 = CDCBean.getPopAdol()>
            <cfset Form.SpecialPop3 = CDCBean.getPopGLB()>
            <cfset Form.SpecialPop4 = CDCBean.getPopTran()>
            <cfset Form.SpecialPop5 = CDCBean.getPopHome()>
            <cfset Form.SpecialPop6 = CDCBean.getPopCorr()>
            <cfset Form.SpecialPop7 = CDCBean.getPopPreg()>
            <cfset Form.SpecialPop8 = CDCBean.getPopSW()>
            <cfset Form.SpecialPop9 = CDCBean.getPopAA()>
            <cfset Form.SpecialPop10 = CDCBean.getPopAs()>
            <cfset Form.SpecialPop11 = CDCBean.getPopNH()>
            <cfset Form.SpecialPop12 = CDCBean.getPopAIAN()>
            <cfset Form.SpecialPop13 = CDCBean.getPopHisp()>
            <cfset Form.SpecialPop14 = CDCBean.getPopImm()>
            <cfset Form.SpecialPop15 = CDCBean.getPopSub()>
            <cfset Form.SpecialPop16 = CDCBean.getPopIDU()>
            <cfset Form.SpecialPop17 = CDCBean.getPopHIV()>
            <cfset Form.SpecialPop18 = CDCBean.getPopOth()>
            <cfset Form.SpecialPopOther = CDCBean.getPopSpec()>
            
            <cfset Form.MarketID = CDCBean.getMarketId()>
            <cfset Form.MarketOther = CDCBean.getMspecify()>
            <cfset Form.ContactUpdates = CDCBean.getUpdates()>
            <cfset Form.ContactEval = CDCBean.getEval()>
            <cfset Form.PTCAlert = CDCBean.getTrainingAlert()>
            <cfset Form.CurrentlyEnrolled = CDCBean.getCurrentlyEnrolled()>
            <cfset Form.PTCTraining = CDCBean.getRelevantTraining()>
            <cfset Form.PrimaryMotivation = CDCBean.getMotivationTraining()>
        </cfif>
	</cfif>
</cfif>
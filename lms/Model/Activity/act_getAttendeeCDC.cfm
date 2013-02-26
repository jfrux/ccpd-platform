<!--- GET ATTENDEE --->
<cfset AttendeeBean = CreateObject("component","#Application.Settings.Com#Attendee.Attendee").init(ActivityID=Attributes.ActivityID,PersonID=Attributes.PersonID)>
<cfset AttendeeBean = Application.Com.AttendeeDAO.read(AttendeeBean)>

<!--- GET CDC --->
<cfparam name="Attributes.AttendeeID" default="#AttendeeBean.getAttendeeID()#">
<cfparam name="Attributes.CBAFundID" default="">
<cfparam name="Attributes.CBACDC" default="">
<cfparam name="Attributes.CBAOth" default="">

<cfparam name="Attributes.CBOFundID" default="">
<cfparam name="Attributes.CBOCDC" default="">
<cfparam name="Attributes.CBOOth" default="">

<cfparam name="Attributes.ProfCId" default="99">
<cfparam name="Attributes.ProfCOther" default="">
<cfparam name="Attributes.ProfNId" default="99">
<cfparam name="Attributes.ProfNOther" default="">

<cfparam name="Attributes.FunRCId" default="99">
<cfparam name="Attributes.FunRCOther" default="">
<cfparam name="Attributes.FunRNId" default="99">
<cfparam name="Attributes.FunRNOther" default="">

<cfparam name="Attributes.OccClassID" default="0">
<cfparam name="Attributes.OrgTypeId" default="0">
<cfparam name="Attributes.OrgTypeOther" default="">

<cfparam name="Attributes.PrinEmpID" default="0">
<cfparam name="Attributes.PrinEmpOther" default="">

<cfparam name="Attributes.WorkState" default="0">
<cfparam name="Attributes.WorkZip" default="">

<cfparam name="Attributes.Focus1" default="N">
<cfparam name="Attributes.Focus2" default="N">
<cfparam name="Attributes.Focus3" default="N">
<cfparam name="Attributes.Focus4" default="N">
<cfparam name="Attributes.Focus5" default="N">
<cfparam name="Attributes.Focus6" default="N">
<cfparam name="Attributes.Focus7" default="N">
<cfparam name="Attributes.Focus8" default="N">
<cfparam name="Attributes.Focus9" default="N">
<cfparam name="Attributes.Focus10" default="N">
<cfparam name="Attributes.FocusOther" default="">

<cfparam name="Attributes.SpecialPop1" default="N">
<cfparam name="Attributes.SpecialPop2" default="N">
<cfparam name="Attributes.SpecialPop3" default="N">
<cfparam name="Attributes.SpecialPop4" default="N">
<cfparam name="Attributes.SpecialPop5" default="N">
<cfparam name="Attributes.SpecialPop6" default="N">
<cfparam name="Attributes.SpecialPop7" default="N">
<cfparam name="Attributes.SpecialPop8" default="N">
<cfparam name="Attributes.SpecialPop9" default="N">
<cfparam name="Attributes.SpecialPop10" default="N">
<cfparam name="Attributes.SpecialPop11" default="N">
<cfparam name="Attributes.SpecialPop12" default="N">
<cfparam name="Attributes.SpecialPop13" default="N">
<cfparam name="Attributes.SpecialPop14" default="N">
<cfparam name="Attributes.SpecialPop15" default="N">
<cfparam name="Attributes.SpecialPop16" default="N">
<cfparam name="Attributes.SpecialPop17" default="N">
<cfparam name="Attributes.SpecialPop18" default="N">
<cfparam name="Attributes.SpecialPopOther" default="">

<cfparam name="Attributes.MarketID" default="0">
<cfparam name="Attributes.MarketOther" default="">
<cfparam name="Attributes.ContactUpdates" default="Y">
<cfparam name="Attributes.ContactEval" default="Y">
<cfparam name="Attributes.PTCAlert" default="Y">
<cfparam name="Attributes.CurrentlyEnrolled" default="FALSE">
<cfparam name="Attributes.PTCTraining" default="FALSE">
<cfparam name="Attributes.PrimaryMotivation" default="FALSE">

<cfset CDCBean = CreateObject("component","#Application.Settings.Com#Attendee.AttendeeCDC").init(AttendeeID=AttendeeBean.getAttendeeID())>

<cfif Application.Com.AttendeeCDCDAO.Exists(CDCBean)>
	
	<cfset CDCBean = Application.Com.AttendeeCDCDAO.read(CDCBean)>
	
	<cfif Attributes.Submitted EQ "">
		<cfset Attributes.CBAFundID = CDCBean.getCBAFundID()>
		<cfset Attributes.CBACDC = CDCBean.getCBACDC()>
		<cfset Attributes.CBAOth = CDCBean.getCBAOth()>
		
		<cfset Attributes.CBOFundID = CDCBean.getCBOFundID()>
		<cfset Attributes.CBOCDC = CDCBean.getCBOCDC()>
		<cfset Attributes.CBOOth = CDCBean.getCBOOth()>
		
		<cfset Attributes.ProfCId = CDCBean.getProfCId()>
		<cfset Attributes.ProfCOther = CDCBean.getProfCSp()>
		<cfset Attributes.ProfNId = CDCBean.getProfNId()>
		<cfset Attributes.ProfNOther = CDCBean.getProfNSp()>
		
		<cfset Attributes.FunRCId = CDCBean.getFunRCId()>
		<cfset Attributes.FunRCOther = CDCBean.getFunRCSp()>
		<cfset Attributes.FunRNId = CDCBean.getFunRNId()>
		<cfset Attributes.FunRNOther = CDCBean.getFunRCSp()>
		
		<cfset Attributes.OccClassID = CDCBean.getOccClassID()>
		<cfset Attributes.OrgTypeId = CDCBean.getOrgTypeId()>
		<cfset Attributes.OrgTypeOther = CDCBean.getTspecify()>
		
		<cfset Attributes.PrinEmpID = CDCBean.getPrinEmpID()>
		<cfset Attributes.PrinEmpOther = CDCBean.getPrinEmpSp()>
		
		<cfset Attributes.WorkState = CDCBean.getWorkState()>
		<cfset Attributes.WorkZip = CDCBean.getWorkZip()>
		
		<cfset Attributes.Focus1 = CDCBean.getFocSTD()>
		<cfset Attributes.Focus2 = CDCBean.getFocHIV()>
		<cfset Attributes.Focus3 = CDCBean.getFocWRH()>
		<cfset Attributes.Focus4 = CDCBean.getFocGen()>
		<cfset Attributes.Focus5 = CDCBean.getFocAdol()>
		<cfset Attributes.Focus6 = CDCBean.getFocMH()>
		<cfset Attributes.Focus7 = CDCBean.getFocSub()>
		<cfset Attributes.Focus8 = CDCBean.getFocEm()>
		<cfset Attributes.Focus9 = CDCBean.getFocCor()>
		<cfset Attributes.Focus10 = CDCBean.getFocOth()>
		<cfset Attributes.FocusOther = CDCBean.getFocSpec()>
		
		<cfset Attributes.SpecialPop1 = CDCBean.getPopGen()>
		<cfset Attributes.SpecialPop2 = CDCBean.getPopAdol()>
		<cfset Attributes.SpecialPop3 = CDCBean.getPopGLB()>
		<cfset Attributes.SpecialPop4 = CDCBean.getPopTran()>
		<cfset Attributes.SpecialPop5 = CDCBean.getPopHome()>
		<cfset Attributes.SpecialPop6 = CDCBean.getPopCorr()>
		<cfset Attributes.SpecialPop7 = CDCBean.getPopPreg()>
		<cfset Attributes.SpecialPop8 = CDCBean.getPopSW()>
		<cfset Attributes.SpecialPop9 = CDCBean.getPopAA()>
		<cfset Attributes.SpecialPop10 = CDCBean.getPopAs()>
		<cfset Attributes.SpecialPop11 = CDCBean.getPopNH()>
		<cfset Attributes.SpecialPop12 = CDCBean.getPopAIAN()>
		<cfset Attributes.SpecialPop13 = CDCBean.getPopHisp()>
		<cfset Attributes.SpecialPop14 = CDCBean.getPopImm()>
		<cfset Attributes.SpecialPop15 = CDCBean.getPopSub()>
		<cfset Attributes.SpecialPop16 = CDCBean.getPopIDU()>
		<cfset Attributes.SpecialPop17 = CDCBean.getPopHIV()>
		<cfset Attributes.SpecialPop18 = CDCBean.getPopOth()>
		<cfset Attributes.SpecialPopOther = CDCBean.getPopSpec()>
		
		<cfset Attributes.MarketID = CDCBean.getMarketId()>
		<cfset Attributes.MarketOther = CDCBean.getMspecify()>
		<cfset Attributes.ContactUpdates = CDCBean.getUpdates()>
		<cfset Attributes.ContactEval = CDCBean.getEval()>
		<cfset Attributes.PTCAlert = CDCBean.getTrainingAlert()>
		<cfset Attributes.CurrentlyEnrolled = CDCBean.getCurrentlyEnrolled()>
		<cfset Attributes.PTCTraining = CDCBean.getRelevantTraining()>
		<cfset Attributes.PrimaryMotivation = CDCBean.getMotivationTraining()>
	</cfif>
	
</cfif>
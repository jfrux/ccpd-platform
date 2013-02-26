<cfparam name="Attributes.Submitted" default ="">
<cfparam name="Attributes.AttendeeID" default="0">
<cfparam name="attributes.CBAFundID" default ="">
<cfparam name="attributes.CBACDC" default ="">
<cfparam name="attributes.CBAOth" default ="">
<cfparam name="attributes.CBOFundID" default ="">
<cfparam name="attributes.CBOCDC" default ="">
<cfparam name="attributes.CBOOth" default ="">
<cfparam name="attributes.ProfCId" default ="">
<cfparam name="attributes.ProfCOther" default ="">
<cfparam name="attributes.ProfNId" default ="">
<cfparam name="attributes.ProfNOther" default ="">
<cfparam name="attributes.FunRCId" default ="">
<cfparam name="attributes.FunRCOther" default ="">
<cfparam name="attributes.FunRNId" default ="">
<cfparam name="attributes.FunRNOther" default ="">
<cfparam name="attributes.OccClassID" default ="">
<cfparam name="attributes.OrgTypeID" default ="">
<cfparam name="attributes.OrgTypeOther" default ="">
<cfparam name="attributes.PrinEmpID" default ="">
<cfparam name="attributes.PrinEmpOther" default ="">
<cfparam name="attributes.WorkState" default ="">
<cfparam name="attributes.WorkZip" default ="">
<cfparam name="attributes.Focus1" default ="">
<cfparam name="attributes.Focus2" default ="">
<cfparam name="attributes.Focus3" default ="">
<cfparam name="attributes.Focus4" default ="">
<cfparam name="attributes.Focus5" default ="">
<cfparam name="attributes.Focus6" default ="">
<cfparam name="attributes.Focus7" default ="">
<cfparam name="attributes.Focus8" default ="">
<cfparam name="attributes.Focus9" default ="">
<cfparam name="attributes.Focus10" default ="">
<cfparam name="attributes.FocusOther" default ="">
<cfparam name="attributes.SpecialPop1" default ="">
<cfparam name="attributes.SpecialPop2" default ="">
<cfparam name="attributes.SpecialPop3" default ="">
<cfparam name="attributes.SpecialPop4" default ="">
<cfparam name="attributes.SpecialPop5" default ="">
<cfparam name="attributes.SpecialPop6" default ="">
<cfparam name="attributes.SpecialPop7" default ="">
<cfparam name="attributes.SpecialPop8" default ="">
<cfparam name="attributes.SpecialPop9" default ="">
<cfparam name="attributes.SpecialPop10" default ="">
<cfparam name="attributes.SpecialPop11" default ="">
<cfparam name="attributes.SpecialPop12" default ="">
<cfparam name="attributes.SpecialPop13" default ="">
<cfparam name="attributes.SpecialPop14" default ="">
<cfparam name="attributes.SpecialPop15" default ="">
<cfparam name="attributes.SpecialPop16" default ="">
<cfparam name="attributes.SpecialPop17" default ="">
<cfparam name="attributes.SpecialPop18" default ="">
<cfparam name="attributes.SpecialPopOther" default ="">
<cfparam name="attributes.MarketID" default ="">
<cfparam name="attributes.MarketOther" default ="">
<cfparam name="attributes.ContactUpdates" default ="">
<cfparam name="attributes.ContactEval" default ="">
<cfparam name="attributes.PTCAlert" default ="">
<cfparam name="attributes.CurrentlyEnrolled" default ="">

<cfif Attributes.Submitted EQ 1>
	<cfif isEditable>
	<cfset PersonBean = Application.Com.PersonDAO.Read(PersonBean)>
	<cfset PersonBean.setEthnicityID(Attributes.Ethnicity)>
	<cfset PersonBean.setOMBEthnicityID(Attributes.OMBEthnicity)>
	<cfset Application.Com.PersonDAO.Update(PersonBean)>
	</cfif>
	
	<cfset CDCBean = CreateObject("component","#Application.Settings.Com#Attendee.AttendeeCDC").init(AttendeeID=Attributes.AttendeeID)>
	<cfif Application.Com.AttendeeCDCDAO.exists(CDCBean)>
	<cfset CDCBean = Application.Com.AttendeeCDCDAO.read(CDCBean)>
	</cfif>
	<cfset CDCBean.setCBAFundID(Attributes.CBAFundID)>
	<cfset CDCBean.setCBACDC(Attributes.CBACDC)>
	<cfset CDCBean.setCBAOth(Attributes.CBAOth)>
	
	<cfset CDCBean.setCBOFundID(Attributes.CBOFundID)>
	<cfset CDCBean.setCBOCDC(Attributes.CBOCDC)>
	<cfset CDCBean.setCBOOth(Attributes.CBOOth)>
	
	<cfset CDCBean.setProfCId(Attributes.ProfCId)>
	<cfset CDCBean.setProfCSp(Attributes.ProfCOther)>
	<cfset CDCBean.setProfNId(Attributes.ProfNId)>
	<cfset CDCBean.setProfNSp(Attributes.ProfNOther)>
	
	<cfset CDCBean.setFunRCId(Attributes.FunRCId)>
	<cfset CDCBean.setFunRCSp(Attributes.FunRCOther)>
	<cfset CDCBean.setFunRNId(Attributes.FunRNId)>
	<cfset CDCBean.setFunRNSp(Attributes.FunRNOther)>
	
	<cfset CDCBean.setOccClassID(Attributes.OccClassID)>
	<cfset CDCBean.setOrgTypeID(Attributes.OrgTypeID)>
	<cfset CDCBean.setTspecify(Attributes.OrgTypeOther)>
	
	<cfset CDCBean.setPrinEmpID(Attributes.PrinEmpID)>
	<cfset CDCBean.setPrinEmpSp(Attributes.PrinEmpOther)>
	
	<cfset CDCBean.setWorkState(Attributes.WorkState)>
	<cfset CDCBean.setWorkZip(Attributes.WorkZip)>
	
	<cfset CDCBean.setFocSTD(Attributes.Focus1)>
	<cfset CDCBean.setFocHIV(Attributes.Focus2)>
	<cfset CDCBean.setFocWRH(Attributes.Focus3)>
	<cfset CDCBean.setFocGen(Attributes.Focus4)>
	<cfset CDCBean.setFocAdol(Attributes.Focus5)>
	<cfset CDCBean.setFocMH(Attributes.Focus6)>
	<cfset CDCBean.setFocSub(Attributes.Focus7)>
	<cfset CDCBean.setFocEm(Attributes.Focus8)>
	<cfset CDCBean.setFocCor(Attributes.Focus9)>
	<cfset CDCBean.setFocOth(Attributes.Focus10)>
	<cfset CDCBean.setFocSpec(Attributes.FocusOther)>
	
	<cfset CDCBean.setPopGen(Attributes.SpecialPop1)>
	<cfset CDCBean.setPopAdol(Attributes.SpecialPop2)>
	<cfset CDCBean.setPopGLB(Attributes.SpecialPop3)>
	<cfset CDCBean.setPopTran(Attributes.SpecialPop4)>
	<cfset CDCBean.setPopHome(Attributes.SpecialPop5)>
	<cfset CDCBean.setPopCorr(Attributes.SpecialPop6)>
	<cfset CDCBean.setPopPreg(Attributes.SpecialPop7)>
	<cfset CDCBean.setPopSW(Attributes.SpecialPop8)>
	<cfset CDCBean.setPopAA(Attributes.SpecialPop9)>
	<cfset CDCBean.setPopAs(Attributes.SpecialPop10)>
	<cfset CDCBean.setPopNH(Attributes.SpecialPop11)>
	<cfset CDCBean.setPopAIAN(Attributes.SpecialPop12)>
	<cfset CDCBean.setPopHisp(Attributes.SpecialPop13)>
	<cfset CDCBean.setPopImm(Attributes.SpecialPop14)>
	<cfset CDCBean.setPopSub(Attributes.SpecialPop15)>
	<cfset CDCBean.setPopIDU(Attributes.SpecialPop16)>
	<cfset CDCBean.setPopHIV(Attributes.SpecialPop17)>
	<cfset CDCBean.setPopOth(Attributes.SpecialPop18)>
	<cfset CDCBean.setPopSpec(Attributes.SpecialPopOther)>
	
	<cfset CDCBean.setMarketId(Attributes.MarketID)>
	<cfset CDCBean.setMspecify(Attributes.MarketOther)>
	<cfset CDCBean.setUpdates(Attributes.ContactUpdates)>
	<cfset CDCBean.setEval(Attributes.ContactEval)>
	<cfset CDCBean.setTrainingAlert(Attributes.PTCAlert)>
	<cfset CDCBean.setCurrentlyEnrolled(Attributes.CurrentlyEnrolled)>
	<cfset CDCBean.setRelevantTraining(Attributes.PTCTraining)>
	<cfset CDCBean.setMotivationTraining(Attributes.PrimaryMotivation)>
		
	<!--- Set who updated the info --->
	<cfif NOT Application.Com.AttendeeCDCDAO.exists(CDCBean)>
	<cfset CDCBean.setCreatedBy(Session.Person.getPersonID())>
	<cfelse>
	<cfset CDCBean.setUpdatedBy(Session.Person.getPersonID())>
	</cfif>
	
	<cfset aErrors = CDCBean.validate()>
	<!--- Submits the Bean for data saving --->
	<cfset CDCBean = Application.Com.AttendeeCDCDAO.Save(CDCBean)>
	
	<cflocation url="#myself#Activity.AttendeeCDC?ActivityID=#Attributes.ActivityID#&PersonID=#Attributes.PersonID#&Saved=1" addtoken="no" />
</cfif>
<cfset ResultBean = CreateObject("component","#Application.Settings.Com#AssessResult.AssessResult").Init(PersonID=Session.PersonID,AssessmentID=url.AssessmentID)>
<cfset ResultExists = Application.Com.AssessResultDAO.Exists(ResultBean)>
<cfif ResultExists>
	<cfset ResultBean = Application.Com.AssessResultDAO.Read(ResultBean)>
    
    <cflocation url="evaluation.cfm?aid=#URL.AID#&assessmentid=#URL.AssessmentID#&ResultID=#ResultBean.getResultID()#" addtoken="no" />
<cfelse>
	<cfset ResultBean.setResultStatusID("2")>
	<cfset NewResultID = Application.Com.AssessResultDAO.Create(ResultBean)>
    
    <cflocation url="evaluation.cfm?aid=#URL.AID#&assessmentid=#URL.AssessmentID#&ResultID=#NewResultID#" addtoken="no" />
</cfif>
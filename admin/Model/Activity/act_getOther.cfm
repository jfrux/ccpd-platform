<cfset ActivityOtherBean = CreateObject("component","#Application.Settings.Com#ActivityOther.ActivityOther").Init(ActivityID=#Attributes.ActivityID#)>

<cfset activityOtherExists = application.com.activityOtherDAO.exists(activityOtherBean)>

<cfset attributes.competenceDesign = 0 />
<cfset attributes.competenceEval = 0 />
<cfset attributes.performanceDesign = 0 />
<cfset attributes.performanceEval = 0 />
<cfset attributes.outcomesDesign = 0 />
<cfset attributes.outcomesEval = 0 />

<cfif activityOtherExists>
	<cfset activityOtherBean = application.com.activityOtherDAO.read(activityOtherBean)>
	
	<cfset attributes.competenceDesign = activityOtherBean.getCompetenceDesign()>
	<cfset attributes.competenceEval = activityOtherBean.getCompetenceEval()>
	<cfset attributes.performanceDesign = activityOtherBean.getPerformanceDesign()>
	<cfset attributes.performanceEval = activityOtherBean.getPerformanceEval()>
	<cfset attributes.outcomesDesign = activityOtherBean.getOutcomesDesign()>
	<cfset attributes.outcomesEval = activityOtherBean.getOutcomesEval()>
</cfif>
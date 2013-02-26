<cfparam name="Attributes.QuestionTypeID" default="1" />
<cfparam name="Attributes.LabelText" default="" />
<cfparam name="Attributes.DetailText" default="" />
<cfparam name="Attributes.RequiredFlag" default="N" />
<cfparam name="Attributes.VC1" default="" />
<cfparam name="Attributes.VC2" default="" />
<cfparam name="Attributes.VC3" default="" />
<cfparam name="Attributes.VC4" default="" />
<cfparam name="Attributes.VC5" default="" />
<cfparam name="Attributes.VC6" default="" />
<cfparam name="Attributes.VC7" default="" />
<cfparam name="Attributes.VC8" default="" />
<cfparam name="Attributes.VC9" default="" />
<cfparam name="Attributes.VC10" default="" />
<cfparam name="Attributes.CorrectField" default="VC1" />
<cfparam name="Attributes.Submitted" default="" />

<cfif Attributes.Submitted NEQ "">
	<cfif NOT isDefined("QuestionBean")>
		<cfset QuestionBean = CreateObject("component","#Application.Settings.Com#AssessQuestion.AssessQuestion").init(QuestionID=0)>
	</cfif>
	
	<cfset QuestionBean.setQuestionTypeID(Attributes.QuestionTypeID)>
	<cfset QuestionBean.setLabelText(Attributes.LabelText)>
	<cfset QuestionBean.setDetailText(Attributes.DetailText)>
	<cfset QuestionBean.setRequiredFlag(Attributes.RequiredFlag)>
	<cfset QuestionBean.setVC1(Attributes.VC1)>
	<cfset QuestionBean.setVC2(Attributes.VC2)>
	<cfset QuestionBean.setVC3(Attributes.VC3)>
	<cfset QuestionBean.setVC4(Attributes.VC4)>
	<cfset QuestionBean.setVC5(Attributes.VC5)>
	<cfset QuestionBean.setVC6(Attributes.VC6)>
	<cfset QuestionBean.setVC7(Attributes.VC7)>
	<cfset QuestionBean.setVC8(Attributes.VC8)>
	<cfset QuestionBean.setVC9(Attributes.VC9)>
	<cfset QuestionBean.setVC10(Attributes.VC10)>
	<cfset QuestionBean.setAssessmentID(Attributes.AssessmentID)>
	<cfset QuestionBean.setCorrectField(Attributes.CorrectField)>
	<!--- Validate Bean --->
	<cfset aErrors = QuestionBean.Validate()>
	
	<!--- Fill Request.Status.Errors --->
	<cfloop from="1" to="#ArrayLen(aErrors)#" index="i">
		<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,aErrors[i].Message,"|")>
	</cfloop>
	
	<cfif Request.Status.Errors EQ "">
		<cfset QuestionBean = Application.Com.AssessQuestionDAO.Save(QuestionBean)>
		<cflocation url="#myself#Assessment.Questions?AssessmentID=#Attributes.AssessmentID#&Message=Question saved!" addtoken="no" />
	</cfif>
</cfif>
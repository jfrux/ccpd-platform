<cfparam name="Attributes.QuestionID" />


<cfif Attributes.QuestionID GT 0>
	<cfset QuestionBean = CreateObject("component","#Application.Settings.Com#AssessQuestion.AssessQuestion").init(QuestionID=Attributes.QuestionID)>
	<cfset QuestionBean = Application.Com.AssessQuestionDAO.Read(QuestionBean)>
	<cfparam name="Attributes.LabelText" default="#QuestionBean.getLabelText()#" />
	<cfparam name="Attributes.DetailText" default="#QuestionBean.getDetailText()#" />
	<cfparam name="Attributes.RequiredFlag" default="#QuestionBean.getRequiredFlag()#" />
	<cfparam name="Attributes.VC1" default="#QuestionBean.getVC1()#" />
	<cfparam name="Attributes.VC2" default="#QuestionBean.getVC2()#" />
	<cfparam name="Attributes.VC3" default="#QuestionBean.getVC3()#" />
	<cfparam name="Attributes.VC4" default="#QuestionBean.getVC4()#" />
	<cfparam name="Attributes.VC5" default="#QuestionBean.getVC5()#" />
	<cfparam name="Attributes.VC6" default="#QuestionBean.getVC6()#" />
	<cfparam name="Attributes.VC7" default="#QuestionBean.getVC7()#" />
	<cfparam name="Attributes.VC8" default="#QuestionBean.getVC8()#" />
	<cfparam name="Attributes.VC9" default="#QuestionBean.getVC9()#" />
	<cfparam name="Attributes.VC10" default="#QuestionBean.getVC10()#" />
	<cfparam name="Attributes.CorrectField" default="#QuestionBean.getCorrectField()#" />
	<cfparam name="Attributes.QuestionTypeID" default="#QuestionBean.getQuestionTypeID()#" />
</cfif>
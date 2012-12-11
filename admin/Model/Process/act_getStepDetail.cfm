<cfparam name="Attributes.StepID" default="0">

<cfset StepBean = CreateObject("component","#Application.Settings.Com#ProcessStep.ProcessStep").init()>
<cfif Attributes.StepID GT 0>
	<cfset StepBean.setStepID(Attributes.StepID)>
	<cfset StepBean = Application.Com.ProcessStepDAO.read(StepBean)>
	<cfset Attributes.ProcessID = StepBean.getProcessID()>
	<cfset Attributes.Name = StepBean.getName()>
	<cfset Attributes.Description = StepBean.getDescription()>
	<cfset Attributes.Instructions = StepBean.getInstructions()>
	<cfset Attributes.DueDateSetting = StepBean.getDueDateSetting()>
	<cfset Attributes.DueDate = StepBean.getDueDate()>
	<cfset Attributes.RelativeDays = StepBean.getRelativeDays()>
	<cfset Attributes.WaitingDays = StepBean.getWaitingDays()>
	<cfset Attributes.NotifyFlag = StepBean.getNotifyFlag()>
</cfif>
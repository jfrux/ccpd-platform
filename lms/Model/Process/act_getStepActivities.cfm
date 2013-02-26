<cfparam name="Attributes.StepID" default="0">

<cfset qStepActivities = Application.Com.ProcessStepActivityGateway.getByViewAttributes(StepID=Attributes.StepID,DeletedFlag='N',OrderBy='DueDate DESC')>
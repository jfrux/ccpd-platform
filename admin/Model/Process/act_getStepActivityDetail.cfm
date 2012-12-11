<cfparam name="Attributes.StepID" default="0">
<cfparam name="Attributes.ActivityID" default="0">
<cfset qStepActivityDetail = Application.Com.ProcessStepActivityGateway.getByViewAttributes(StepID=Attributes.StepID,ActivityID=Attributes.ActivityID,DeletedFlag='N')>
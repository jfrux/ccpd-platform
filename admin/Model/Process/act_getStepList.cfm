<cfparam name="Attributes.ProcessID" default="0">

<cfset qStepList = Application.Com.ProcessStepGateway.getByAttributes(ProcessID=Attributes.ProcessID,DeletedFlag='N')>

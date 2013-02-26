<cfparam name="Attributes.Submitted" default="0" />
<cfparam name="Attributes.StepID" default="0" />
<cfparam name="Attributes.ProcessID" default="0" />
<cfparam name="Attributes.Name" default="" />
<cfparam name="Attributes.Description" default="" />
<cfparam name="Attributes.Instructions" default="" />
<cfparam name="Attributes.DueDateSetting" default="" />
<cfparam name="Attributes.RelativeDays" default="" />
<cfparam name="Attributes.WaitingDays" default="" />
<cfparam name="Attributes.DueDate" default="" />
<cfparam name="Attributes.NotifyFlag" default="N" />

<cfif Attributes.Submitted GT 0>
	<!--- Create the bean --->
	<cfset StepSave = CreateObject("component","#Application.Settings.Com#ProcessStep.ProcessStep").Init()>
	
	<cfif Attributes.StepID GT 0>
		<cfset StepSave.setStepID(Attributes.StepID)>
		<cfset StepSave = Application.Com.ProcessStepDAO.read(StepSave)>
		
		<cfset StepSave.setUpdatedBy(Session.Person.getPersonID())>
	<cfelse>
		<cfset StepSave.setSort(1)>
		<cfset StepSave.setCreatedBy(Session.Person.getPersonID())>
	</cfif>
	
	<cfset StepSave.setProcessID(Attributes.ProcessID)>
	<cfset StepSave.setName(Attributes.Name)>
	<cfset StepSave.setDescription(Attributes.Description)>
	<cfset StepSave.setInstructions(Attributes.Instructions)>
	<cfset StepSave.setDueDateSetting(Attributes.DueDateSetting)>
	<cfset StepSave.setRelativeDays(Attributes.RelativeDays)>
	<cfset StepSave.setWaitingDays(Attributes.WaitingDays)>
	<cfset StepSave.setDueDate(Attributes.DueDate)>
	<cfset StepSave.setNotifyFlag(Attributes.NotifyFlag)>
	
	<cfset aErrors = StepSave.validate()>

	<cfloop from="1" to="#ArrayLen(aErrors)#" index="i">
		<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,aErrors[i].Message,"|")>
	</cfloop>
	
	<cfif ArrayLen(aErrors) EQ 0>
		<!--- Uses the Bean to submit data into the database --->
		<cfif Attributes.StepID GT 0>
			<cfset Saved = Application.Com.ProcessStepDAO.Update(StepSave)>
		<cfelse>
			<cfset NewID = Application.Com.ProcessStepDAO.Create(StepSave)>
			<cfif isNumeric(NewID)>
				<cfset Attributes.StepID = NewID>
			</cfif>
		</cfif>		

		<cflocation url="#myself#Process.StepDetail&StepID=#Attributes.StepID#" addtoken="no" />
	</cfif>
</cfif>
<cfparam name="Attributes.Submitted" default="0" />
<cfparam name="Attributes.ProcessID" default="0" />
<cfparam name="Attributes.Title" default="" />
<cfparam name="Attributes.HiddenFlag" default="N" />

<cfif Attributes.Submitted GT 0>
	<!--- Create the bean --->
	<cfset ProcessBean = CreateObject("component","#Application.Settings.Com#Process.Process").Init()>
	
	<cfif Attributes.ProcessID GT 0>
		<cfset ProcessBean.setProcessID(Attributes.ProcessID)>
		<cfset ProcessBean = Application.Com.ProcessDAO.read(ProcessBean)>
		
		<cfset ProcessBean.setUpdatedBy(Session.Person.getPersonID())>
	<cfelse>
		<cfset ProcessBean.setCreatedBy(Session.Person.getPersonID())>
	</cfif>

	<cfset ProcessBean.setTitle(Attributes.Title)>
	<cfset ProcessBean.setHiddenFlag(Attributes.HiddenFlag)>
	
	<cfset aErrors = ProcessBean.validate()>

	<cfloop from="1" to="#ArrayLen(aErrors)#" index="i">
		<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,aErrors[i].Message,"|")>
	</cfloop>
	
	<cfif ArrayLen(aErrors) EQ 0>
		<!--- Uses the Bean to submit data into the database --->
		<cfif Attributes.ProcessID GT 0>
			<cfset Saved = Application.Com.ProcessDAO.Update(ProcessBean)>
		<cfelse>
			<cfset NewID = Application.Com.ProcessDAO.Create(ProcessBean)>
			<cfif isNumeric(NewID)>
				<cfset Attributes.ProcessID = NewID>
			</cfif>
		</cfif>		

		<cflocation url="#myself#Process.Detail&ProcessID=#Attributes.ProcessID#" addtoken="no" />
	</cfif>
</cfif>
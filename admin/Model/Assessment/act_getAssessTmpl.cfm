<cfparam name="Attributes.AssessmentID" default="0">
<cfparam name="TemplatedAssessments" default="" />
<cfswitch expression="#Attributes.Fuseaction#">
    <cfcase value="Activity.BuilderASPO">
        <cfset qTemplates = Application.Com.AssessTmplGateway.getByAttributes(AssessTypeID=2,DeletedFlag="N",CreatedBy=Session.Person.getPersonID(),OrderBy="Name")>
    </cfcase>
    <cfcase value="Activity.BuilderASPR">
        <cfset qTemplates = Application.Com.AssessTmplGateway.getByAttributes(AssessTypeID=3,DeletedFlag="N",CreatedBy=Session.Person.getPersonID(),OrderBy="Name")>
    </cfcase>
    <cfcase value="Activity.BuilderASEV">
        <cfset qTemplates = Application.Com.AssessTmplGateway.getByAttributes(AssessTypeID=1,DeletedFlag="N",CreatedBy=Session.Person.getPersonID(),OrderBy="Name")>
    </cfcase>
</cfswitch>

<!--- CREATE LIST OF ASSESSMENTS THAT HAVE BEEN TEMPLATED --->
<cfif Attributes.AssessmentID GT 0>    
	<cfloop query="qTemplates">
    	<cfset TemplatedAssessments = ListAppend(TemplatedAssessments, qTemplates.AssessmentID,",")>
    </cfloop>
</cfif>
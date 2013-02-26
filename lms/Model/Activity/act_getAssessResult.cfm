<cfparam name="Attributes.AssessmentID" default="0" />
<cfparam name="Attributes.ResultID" default="0" />

<cfif Attributes.ResultID EQ 0>
	<cfset ResultBean = CreateObject("component","#Application.Settings.Com#AssessResult.AssessResult").Init(ResultID=0,AssessmentID=Attributes.AssessmentID,PersonID=Attributes.PersonID,ResultStatusID=2,DeletedFlag="N")>
    <cfset ResultSaved = Application.Com.AssessResultDAO.Create(ResultBean)>
    
    <cfif isNumeric(ResultSaved)>
        <cfset Attributes.ResultID = ResultSaved>
    </cfif>
</cfif>
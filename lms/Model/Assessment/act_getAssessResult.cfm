<cfparam name="Attributes.AssessmentID" default="" />
<cfparam name="Attributes.PersonID" default="110111" />

<cfset AssessResultBean = CreateObject("component","#Application.Settings.Com#AssessResult.AssessResult").Init(AssessmentID=Attributes.AssessmentID,PersonID=Attributes.PersonID,DeletedFlag="N")>

<cfif Application.Com.AssessResultDAO.Exists(AssessResultBean)>
	<cfset AssessResultBean = Application.Com.AssessResultDAO.ReadOpenPostTest(AssessResultBean)>
    
    <!--- SET ATTRIBUTES SCOPE --->
    <cfset Attributes.PersonID = AssessResultBean.getPersonID()>
    <cfset Attributes.ResultStatusID = AssessResultBean.getResultStatusID()>
</cfif>
<cfparam name="Attributes.ActivityID" default="" />

<cfset qAssessments = Application.Com.ActivityPubComponentGateway.getByViewAttributesLMS(ComponentIDin="11,12,5",ActivityID=Attributes.ActivityID,DeletedFlag="N",OrderBy="apc.ComponentID")>

<cfloop query="qAssessments">IN<cfabort>
	<cfset AssessmentBean = CreateObject("component","#Application.Settings.Com#Assessment.Assessment").Init(AssessmentID=qAssessments.AssessmentID)>
    <cfset AssessmentExists = Application.Com.AssessmentDAO.Exists(AssessmentBean)>
	
    <cfif NOT AssessmentExists>
    	<cfset Attributes.ExclusionList = ListAppend(Attributes.ExclusionList, qAssessments.ComponentID, ",")>
    </cfif>
</cfloop>

<cfif Attributes.ExclusionList NEQ "">
	<cfset qAssessments = Application.Com.ActivityPubComponentGateway.getByViewAttributesLMS(ComponentIDin="11,12,5",ActivityID=Attributes.ActivityID,DeletedFlag="N",ExclusionList=Attributes.ExclusionList,OrderBy="apc.ComponentID")>
</cfif>
<cfif NOT IsDefined("Attributes.Submitted")>
	<cfset ActivityOtherBean = CreateObject("component","#Application.Settings.Com#ActivityOther.ActivityOther").Init(ActivityID=Attributes.ActivityID)>
	<cfset ActivityOtherExists = Application.Com.ActivityOtherDAO.Exists(ActivityOtherBean)>
	
	<cfif ActivityOtherExists>
		<cfset ActivityOtherBean = Application.Com.ActivityOtherDAO.Read(ActivityOtherBean)>
		
		<cfset Attributes.CollabAgencyFlag = ActivityOtherBean.getCollabAgencyFlag()>
		<cfset Attributes.CollabAgencySpecify = ActivityOtherBean.getCollabAgencySpecify()>
		<cfset Attributes.CollabPTCFlag = ActivityOtherBean.getCollabPTCFlag()>
		<cfset Attributes.CollabPTCSpecify = ActivityOtherBean.getCollabPTCSpecify()>
		<cfset Attributes.DidacticHrs = ActivityOtherBean.getDidacticHrs()>
		<cfset Attributes.ExperimentalHrs = ActivityOtherBean.getExperimentalHrs()>
		<cfset Attributes.OtherID = ActivityOtherBean.getOtherID()>
		<cfset Attributes.SecClinSiteFlag = ActivityOtherBean.getSecClinSiteFlag()>
	</cfif>
</cfif>
<cfif Attributes.Submitted NEQ 1 AND Attributes.PersonEducationID GT 0>
	<cfset EducationBean = CreateObject("component","#Application.Settings.Com#PersonEducation.PersonEducation").Init(PersonEducationID=Attributes.PersonEducationID)>
	<cfset EducationBean = Application.Com.PersonEducationDAO.Read(EducationBean)>
	
	<cfset Attributes.PersonEducationID = EducationBean.getPersonEducationID()>
	<cfset Attributes.EducationID = EducationBean.getEducationID()>
	<cfset Attributes.HighestDegreeFlag = EducationBean.getHighestDegreeFlag()>
	<cfset Attributes.EndYear = EducationBean.getEndYear()>
	<cfset Attributes.InstitutionID = EducationBean.getInstitutionID()>
</cfif>
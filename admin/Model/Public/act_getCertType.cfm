<cfparam name="Attributes.ActivityID" default="" />
<cfparam name="Attributes.PersonID" default="" />
<cfparam name="Attributes.SelectedMembers" default="#Attributes.PersonID#" />

<cfset CertType = Application.ActivityPeople.getCertType(ActivityID=Attributes.ActivityID,PersonID=Attributes.PersonID)>

<cfset CurrCreditID = getToken(CertType,1,"|")>
<cfset CertType = getToken(CertType,2,"|")>

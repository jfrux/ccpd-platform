<cfparam name="AttendeeCertificateType" default="" />

<!--- FIND OUT WHAT TYPE OF CERTIFICATE IS NEEDED FOR THE ATTENDEE --->
<cfset AttendeeCertificateType = CreateObject("component","#Application.Settings.Com#CertificateData").getCertificateType(ActivityID=Attributes.ActivityID,PersonID=Session.PersonID)>
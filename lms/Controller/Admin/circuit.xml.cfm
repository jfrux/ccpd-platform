<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!-- Activity -->
<circuit access="public">
	<prefuseaction callsuper="true">
		<set name="Request.NavItem" value="5" />
    </prefuseaction>
	
	<fuseaction name="Categories">
        <do action="mActivity.getCategories" />
		<set name="Request.Page.Title" value="Categories" />
		<do action="vAdmin.Categories" contentvariable="Request.Page.Body" />
		
		<do action="vLayout.Default" />
	</fuseaction>
    
	<fuseaction name="Category">
		<set name="Request.Page.Title" value="Categories" />
		<do action="vAdmin.Category" contentvariable="Request.Page.Body" />
		
		<do action="vLayout.Default" />
	</fuseaction>
	
    <fuseaction name="Comments">
		<set name="Request.Page.Title" value="Comments" />
		
        <set name="Request.Page.Breadcrumbs" value="Administration|Admin.Home,Comments|Admin.Comments" />
        
		<do action="mPage.ParseCrumbs" />
		
		<do action="vAdmin.Comments" contentvariable="Request.MultiFormContent" />
		<do action="vAdmin.CommentsRight" contentvariable="Request.MultiFormRight" />
		
        <do action="vLayout.Sub_MultiForm" contentvariable="Request.Page.Body" />
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="CommentsAHAH">
		<do action="mAdmin.getComments" />
		<do action="vAdmin.CommentsAHAH" />
	</fuseaction>
	
	<fuseaction name="EmailStyles">
		<set name="Request.Page.Title" value="Email Styles" />
		<do action="vAdmin.EmailStyles" contentvariable="Request.Page.Body" />
		
		<do action="vLayout.Default" />
	</fuseaction>
    
	<fuseaction name="EmailStyle">
		<do action="mAdmin.getEmailStyle" />
		<do action="mAdmin.saveEmailStyle" />
		
		<set name="Request.Page.Title" value="Email Styles" />
		<do action="vAdmin.EmailStyle" contentvariable="Request.Page.Body" />
		
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="HistoryStyles">
		<set name="Request.Page.Title" value="History Styles" />
		<do action="vAdmin.HistoryStyles" contentvariable="Request.Page.Body" />
		
		<do action="vLayout.Default" />
	</fuseaction>
    
	<fuseaction name="HistoryStyle">
		<do action="mAdmin.getHistoryStyle" />
		<do action="mAdmin.saveHistoryStyle" />
		
		<set name="Request.Page.Title" value="History Styles" />
		<do action="vAdmin.HistoryStyle" contentvariable="Request.Page.Body" />
		
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="Certificates">
		<set name="Request.Page.Title" value="Certificates" />
		<do action="vAdmin.Certificates" contentvariable="Request.Page.Body" />
		
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="Certificate">
		<do action="mAdmin.getCertificate" />
		<do action="mAdmin.saveCertificate" />
		
		<set name="Request.Page.Title" value="Certificate" />
		<do action="vAdmin.Certificate" contentvariable="Request.Page.Body" />
		
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="HelpTicketsList">
		<do action="mAdmin.HelpTicketsList" />
        
		<set name="Request.Page.Title" value="Help Tickets List" />
		<set name="HelpTicketsList" value="#Application.Com.HelpTicketGateway.getByAttributes(DeletedFlag='N')#" />
        <set name="Request.Page.Breadcrumbs" value="Welcome|Main.Welcome,Help Tickets|Admin.HelpTicketsList" />
        
		<do action="mPage.ParseCrumbs" />
		
		<do action="vAdmin.HelpTicketsList" contentvariable="Request.Page.Body" />
        
        <do action="vLayout.Default" />
	</fuseaction>
	
    <fuseaction name="Home">
		<set name="Request.Page.Title" value="Administration" />
		
        <set name="Request.Page.Breadcrumbs" value="Administration|Admin.Home" />
        
		<do action="mPage.ParseCrumbs" />
		
		<do action="vAdmin.Home" contentvariable="Request.MultiFormContent" />
		<do action="vAdmin.HomeRight" contentvariable="Request.MultiFormRight" />
		
        <do action="vLayout.Sub_MultiForm" contentvariable="Request.Page.Body" />
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="Specialties">
        <do action="mActivity.getSpecialties" />
		<set name="Request.Page.Title" value="Specialties" />
		<do action="vAdmin.Specialties" contentvariable="Request.Page.Body" />
		
		<do action="vLayout.Default" />
	</fuseaction>
    
	<fuseaction name="Specialty">
		<set name="Request.Page.Title" value="Specialties" />
		<do action="vAdmin.Specialty" contentvariable="Request.Page.Body" />
		
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="Message">
		<do action="mAdmin.getAdmins" />
		<do action="mAdmin.sendMessage" />
		
		<set name="Request.Page.Title" value="Send Admin Message" />
		
		<set name="Request.Page.Breadcrumbs" value="Administration|Admin.Home,Send Email|Admin.Message" />
		<do action="mPage.ParseCrumbs" />
		
		<do action="vAdmin.Message" contentvariable="Request.MultiFormContent" />
		<do action="vAdmin.MessageRight" contentvariable="Request.MultiFormRight" />
		
        <do action="vLayout.Sub_MultiForm" contentvariable="Request.Page.Body" />
		<do action="vLayout.Default" />
	</fuseaction>
</circuit>
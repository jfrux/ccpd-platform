<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!-- Person -->
<circuit access="public">
	<prefuseaction callsuper="true">
	<set name="Request.NavItem" value="3" />
	<if condition="isDefined('Attributes.PersonID')">
		<true>
			<if condition="Attributes.Fuseaction NEQ 'Person.Detail'">
				<true>
					<do action="mPerson.getPerson" />
				</true>
			</if>
			<set name="Request.ActionsLimit" value="4" />
			<do action="mPerson.getActions" />
		</true>
	</if>
	</prefuseaction>
	
	<fuseaction name="Actions">
		<set name="Request.Page.Title" value="#Attributes.FirstName# #Attributes.LastName#" />
		
		<set name="Request.Page.Breadcrumbs" value="People|Person.Home,#Attributes.FirstName# #Attributes.LastName#|Person.Detail?PersonID=#Attributes.PersonID#,Actions|Person.Actions?PersonID=#Attributes.PersonID#" />
		<do action="mPage.ParseCrumbs" />
		<do action="mPerson.TabControl" />
		
		<do action="mPerson.getAllActions" />
		<do action="vPerson.Actions" contentvariable="Request.MultiFormContent" />
        <do action="vPerson.ActionsRight" contentvariable="Request.MultiFormRight" />
		<if condition="#isDefined('url.Mini')#">
			<true>
				<do action="vLayout.Sub_PersonMini" contentvariable="Request.Page.body" />
				<do action="vLayout.None" />
			</true>
			<false>
				<do action="vLayout.Sub_Person" contentvariable="Request.Page.body" />
				<do action="vLayout.Default" />
			</false>
		</if>
	</fuseaction>
    
	<fuseaction name="ActionsShort">
		<do action="vPerson.ActionsShort" />
	</fuseaction>
	
	<fuseaction name="Activities">
		<do action="mPerson.getPerson" />
		<do action="mPerson.getActivities" />
		<do action="mPerson.TabControl" />
        
		<set name="Request.Page.Title" value="#Attributes.FirstName# #Attributes.LastName#" />
        <set name="Request.Page.Breadcrumbs" value="People|Person.Home,#Attributes.FirstName# #Attributes.LastName#|Person.Detail?PersonID=#Attributes.PersonID#,Activities|Person.Activities?PersonID=#Attributes.PersonID#" />
        
		<do action="mPage.ParseCrumbs" />
		        
		<set name="Request.MultiFormTitle" value="Registered Activities" />
		
		<do action="vPerson.Activities" contentvariable="Request.MultiFormContent" />
        <do action="vPerson.ActivitiesRight" contentvariable="Request.MultiFormRight" />
        <if condition="#isDefined('url.Mini')#">
			<true>
				<do action="vLayout.Sub_PersonMini" contentvariable="Request.Page.body" />
				<do action="vLayout.None" />
			</true>
			<false>
				<do action="vLayout.Sub_Person" contentvariable="Request.Page.body" />
				<do action="vLayout.Default" />
			</false>
		</if>
	</fuseaction>
	
	<fuseaction name="Address">
		<do action="mPerson.TabControl" />
        
		<set name="Request.Page.Title" value="#Attributes.FirstName# #Attributes.LastName#" />
        <set name="Request.Page.Breadcrumbs" value="People|Person.Home,#Attributes.FirstName# #Attributes.LastName#|Person.Detail?PersonID=#Attributes.PersonID#,Address Info|Person.Address?PersonID=#Attributes.PersonID#" />
        
		<do action="mPage.ParseCrumbs" />
		        
		<set name="Request.MultiFormTitle" value="Address Info" />
		
		<do action="vPerson.Address" contentvariable="Request.MultiFormContent" />
        <do action="vPerson.AddressRight" contentvariable="Request.MultiFormRight" />
        <if condition="#isDefined('url.Mini')#">
			<true>
				<do action="vLayout.Sub_PersonMini" contentvariable="Request.Page.body" />
				<do action="vLayout.None" />
			</true>
			<false>
				<do action="vLayout.Sub_Person" contentvariable="Request.Page.body" />
				<do action="vLayout.Default" />
			</false>
		</if>
	</fuseaction>
	
	<fuseaction name="AddressAHAH">
		<do action="mPerson.getAddresses" />
		<do action="vPerson.AddressAHAH" />
	</fuseaction>
	
    <fuseaction name="Create">
		<do action="mPerson.Create" />

		<set name="Request.Page.Title" value="Create Person" />
        <set name="Request.Page.Breadcrumbs" value="People|Person.Home,Create Person|Person.Create" />

		<do action="mPage.ParseCrumbs" />
		
		<xfa name="FrmSubmit" value="Person.Create" />
		
		<switch expression="#Attributes.Mode#">
			<case value="Default">
				<do action="vPerson.CreateRight" contentvariable="Request.MultiFormRight" />
				<do action="vPerson.CreatePerson" contentvariable="Request.MultiFormContent" />
				<do action="vLayout.Sub_MultiForm" contentvariable="Request.Page.Body" />
				<do action="vLayout.Default" />
			</case>
			<case value="Insert">
				<do action="vPerson.CreatePerson" contentvariable="Request.Page.Body" />
				<do action="vLayout.None" />
			</case>
		</switch>
	</fuseaction>
    
    <fuseaction name="Credentials">
    	<do action="mPerson.getCredentials" />
    	<do action="vPerson.Credentials" />
    </fuseaction>
	
	<fuseaction name="Detail">
		<do action="mPerson.getPerson" />
		<do action="mPerson.TabControl" />
        
		<set name="Request.Page.Title" value="#Attributes.FirstName# #Attributes.LastName#" />
        <set name="Request.Page.Breadcrumbs" value="People|Person.Home,#Attributes.FirstName# #Attributes.LastName#|Person.Detail?PersonID=#Attributes.PersonID#,Edit General Info|Person.Detail?PersonID=#Attributes.PersonID#" />
        
		<do action="mPage.ParseCrumbs" />
		
		<xfa name="FrmSubmit" value="Person.Detail" />
		        
		<set name="Request.MultiFormTitle" value="General Info" />
		
		<do action="vPerson.Edit" contentvariable="Request.MultiFormContent" />
        <do action="vPerson.EditRight" contentvariable="Request.MultiFormRight" />
		
		<if condition="#isDefined('url.Mini')#">
			<true>
				<do action="vLayout.Sub_PersonMini" contentvariable="Request.Page.body" />
				<do action="vLayout.None" />
			</true>
			<false>
				<do action="vLayout.Sub_Person" contentvariable="Request.Page.body" />
				<do action="vLayout.Default" />
			</false>
		</if>
		
		
	</fuseaction>
	
	<fuseaction name="Docs">
		<do action="mPerson.TabControl" />
        
		<set name="Request.Page.Title" value="#Attributes.FirstName# #Attributes.LastName#" />
        <set name="Request.Page.Breadcrumbs" value="People|Person.Home,#Attributes.FirstName# #Attributes.LastName#|Person.Detail?PersonID=#Attributes.PersonID#,Documents|Person.Docs?PersonID=#Attributes.PersonID#" />
        
		<do action="mPage.ParseCrumbs" />
		        
		<set name="Request.MultiFormTitle" value="Other Info" />
		
		<do action="vPerson.Docs" contentvariable="Request.MultiFormContent" />
        <do action="vPerson.DocsRight" contentvariable="Request.MultiFormRight" />
		   <if condition="#isDefined('url.Mini')#">
				<true>
					<do action="vLayout.Sub_PersonMini" contentvariable="Request.Page.body" />
					<do action="vLayout.None" />
				</true>
				<false>
					<do action="vLayout.Sub_Person" contentvariable="Request.Page.body" />
					<do action="vLayout.Default" />
				</false>
			</if>
	</fuseaction>
	
	<fuseaction name="DocsAHAH">
		<do action="mPerson.getDocs" />
		<do action="vPerson.DocsAHAH" />
	</fuseaction>
	
	<fuseaction name="EditAddress">
		<do action="mPerson.getPerson" />
		<do action="mPerson.getAddress" />
		
		<xfa name="FrmSubmit" value="Person.EditAddress" />
		
		<do action="vPerson.EditAddress" contentvariable="Request.Page.Body" />
        <do action="vLayout.Blank" />
	</fuseaction>
    
    <fuseaction name="Email">
		<do action="mPerson.getPerson" />
        
		<do action="mPerson.TabControl" />
        
		<set name="Request.Page.Title" value="#Attributes.FirstName# #Attributes.LastName#" />
        <set name="Request.Page.Breadcrumbs" value="People|Person.Home,#Attributes.FirstName# #Attributes.LastName#|Person.Detail?PersonID=#Attributes.PersonID#,Emails|Person.Email?PersonID=#Attributes.PersonID#" />
        
		<do action="mPage.ParseCrumbs" />
		        
		<set name="Request.MultiFormTitle" value="Emails" />
		
		<do action="vPerson.Email" contentvariable="Request.MultiFormContent" />
        <do action="vPerson.EmailRight" contentvariable="Request.MultiFormRight" />
        <if condition="#isDefined('url.Mini')#">
			<true>
				<do action="vLayout.Sub_PersonMini" contentvariable="Request.Page.body" />
				<do action="vLayout.None" />
			</true>
			<false>
				<do action="vLayout.Sub_Person" contentvariable="Request.Page.body" />
				<do action="vLayout.Default" />
			</false>
		</if>
    </fuseaction>
	
	<fuseaction name="EmailAHAH">
		<do action="mPerson.getEmails" />
		<do action="vPerson.EmailAHAH" />
	</fuseaction>
	
	<fuseaction name="Home">
		<xfa name="SearchSubmit" value="Person.Home" />
		<do action="mPerson.Search" />
        
		<set name="Request.Page.Title" value="Search People" />
        <set name="Request.Page.Breadcrumbs" value="People|Person.Home" />
        
		<do action="mPage.ParseCrumbs" />
		
		<xfa name="FrmSubmit" value="person.home" />
		<do action="vPerson.Search" contentvariable="Request.Page.Body" />
        <do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="Finder">
		<xfa name="SearchSubmit" value="Person.Finder" />
		<do action="mPerson.Search" />
        
		<set name="Request.Page.Title" value="Search People" />
        <set name="Request.Page.Breadcrumbs" value="People|Person.Home" />
        
		<do action="mPage.ParseCrumbs" />
		
		<xfa name="FrmSubmit" value="Person.Home" />
		<do action="vPerson.Search" contentvariable="Request.Page.Body" />
        
        <do action="vLayout.None" />
	</fuseaction>
	
	<fuseaction name="Notes">
		<do action="mPerson.getNotes" />
		
		<set name="Request.Page.Title" value="#Attributes.PersonID#" />
        
		<set name="Request.Page.Breadcrumbs" value="People|Person.Home,#Attributes.FirstName# #Attributes.LastName#|Person.Detail?PersonID=#Attributes.PersonID#,Notes|Person.Notes?PersonID=#Attributes.PersonID#" />
		<do action="mPage.ParseCrumbs" />
		
		<set name="Request.MultiFormTitle" value="Notes" />
		
		<do action="vPerson.Notes" contentvariable="Request.Page.Body" />
        
		<do action="vLayout.None" />
	</fuseaction>
	
	<fuseaction name="PhotoUpload">
		<do action="mPerson.PhotoUpload" />
		<do action="vPerson.PhotoUpload" contentvariable="Request.Page.Body" />
		<do action="vLayout.None" />
	</fuseaction>
	
	<fuseaction name="Preferences">
		<do action="mPerson.getPerson" />
		<do action="mPerson.TabControl" />
        
		<set name="Request.Page.Title" value="#Attributes.FirstName# #Attributes.LastName#" />
        <set name="Request.Page.Breadcrumbs" value="People|Person.Home,#Attributes.FirstName# #Attributes.LastName#|Person.Detail?PersonID=#Attributes.PersonID#,Preferences|Person.Preferences?PersonID=#Attributes.PersonID#" />
        
		<do action="mPage.ParseCrumbs" />
		        
		<set name="Request.MultiFormTitle" value="Education Info" />
		
		<do action="vPerson.Preferences" contentvariable="Request.MultiFormContent" />
        <do action="vPerson.PreferencesRight" contentvariable="Request.MultiFormRight" />
        <if condition="#isDefined('url.Mini')#">
			<true>
				<do action="vLayout.Sub_PersonMini" contentvariable="Request.Page.body" />
				<do action="vLayout.None" />
			</true>
			<false>
				<do action="vLayout.Sub_Person" contentvariable="Request.Page.body" />
				<do action="vLayout.Default" />
			</false>
		</if>
	</fuseaction>
	
	<fuseaction name="PreferencesAHAH">
		<do action="mPerson.getPersonDegree" />
		<do action="vPerson.PreferencesAHAH" />
	</fuseaction>
	
	<fuseaction name="history">
		
		<do action="mPerson.TabControl" />
		<do action="vPerson.history" contentvariable="Request.MultiFormContent" />
		
		<set name="Request.Page.Title" value="#Attributes.FirstName# #Attributes.LastName#" />
        <set name="Request.Page.Breadcrumbs" value="People|Person.Home,#Attributes.FirstName# #Attributes.LastName#|Person.Detail?PersonID=#Attributes.PersonID#,Preferences|Person.Preferences?PersonID=#Attributes.PersonID#" />
        
		<do action="mPage.ParseCrumbs" />
		        
		<set name="Request.MultiFormTitle" value="History" />
		   <if condition="#isDefined('url.Mini')#">
				<true>
					<do action="vLayout.Sub_PersonMini" contentvariable="Request.Page.body" />
					<do action="vLayout.None" />
				</true>
				<false>
					<do action="vLayout.Sub_Person" contentvariable="Request.Page.body" />
					<do action="vLayout.Default" />
				</false>
			</if>
	</fuseaction>
	
	<fuseaction name="vCard">
		<do action="mPerson.getPerson" />
		<do action="mPerson.getAddresses" />
        
		<set name="Request.Page.Title" value="#Attributes.FirstName# #Attributes.LastName#" />
        <set name="Request.Page.Breadcrumbs" value="People|Person.Home,#Attributes.FirstName# #Attributes.LastName#|Person.Detail?PersonID=#Attributes.PersonID#,Other Info|Person.Other?PersonID=#Attributes.PersonID#" />
        
		<do action="mPage.ParseCrumbs" />
        <do action="vPerson.vCard" contentvariable="Request.Page.body" />
		
		<do action="vLayout.Blank" />
	</fuseaction>
</circuit>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!-- Main -->
<circuit access="public" xmlns:cs="coldspring/">
    
	<fuseaction name="Welcome">
		<do action="mMain.Welcome" />
        <set name="Request.Page.Title" value="Welcome!" />
		<set name="Request.Page.Desc" value="Welcome to University of Cincinnati Ohio CCPD - Continuous Professional Development for Physicians, Nurses, Pharmacists.  AMA Category 1 Credit, ACPE Credit, ANCC Credit, CME Credit, CNE Credit, CPE Credit, and more." />
        <do action="vMain.Welcome" contentvariable="Request.Page.Body" />
        <set name="Request.Page.Breadcrumbs" value="" />
        <do action="mPage.ParseCrumbs" />
        <do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="About">
		<set name="Request.Page.Title" value="What is this?" />
		<set name="Request.Page.Desc" value="Everything you need to know about the University of Cincinnati Ohio CCPD - Continuous Professional Development for Physicians, Nurses, Pharmacists.  AMA Category 1 Credit, ACPE Credit, ANCC Credit, CME Credit, CNE Credit, CPE Credit, and more." />
		<do action="vMain.About" contentvariable="Request.Page.Body" />
		
        <set name="Request.Page.Breadcrumbs" value="" />
        <do action="mPage.ParseCrumbs" />
        <do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="grants">
		<set name="Request.Page.Title" value="2010 Grant Applications" />
		<set name="Request.Page.Desc" value="The Center for Continuous Professional Development 2010 Grant Applications" />
		<do action="vMain.grants" contentvariable="Request.Page.Body" />
		
        <set name="Request.Page.Breadcrumbs" value="" />
        <do action="mPage.ParseCrumbs" />
        <do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="Support">
		<set name="Request.Page.Title" value="Support" />
		<set name="Request.Page.Desc" value="Technical support for the University of Cincinnati Ohio CCPD - Continuous Professional Development for Physicians, Nurses, Pharmacists.  AMA Category 1 Credit, ACPE Credit, ANCC Credit, CME Credit, CNE Credit, CPE Credit, and more." />
    	<do action="mMain.Support" />
		<do action="vMain.Support" contentvariable="Request.Page.Body" />
		
        <set name="Request.Page.Breadcrumbs" value="" />
        <do action="mPage.ParseCrumbs" />
		
		<if condition="#attributes.display# EQ 'Default'">
			<true>
        <do action="vLayout.Default" />
		</true>
		<false>
		 <do action="vLayout.None" />
		</false>
		</if>
	</fuseaction>
    
    <fuseaction name="Login">
		<set name="Request.Page.Title" value="Member Login" />
		<set name="Request.Page.Desc" value="Member Login for UC CCPD LMS" />
		<xfa name="Authenticate" value="Main.doLogin" />
        <do action="vMain.Login" contentvariable="Request.Page.Body" />
        <do action="vLayout.Default" />
    </fuseaction>
	
	<fuseaction name="Register">
		<set name="Request.Page.Title" value="Member Signup" />
		<set name="Request.Page.Desc" value="Signup to gain access to UC CCPD LMS" />
		<do action="mMain.doSignup" />
		
		<switch expression="#Attributes.Step#">
			<case value="ThankYou">
				<set name="Attributes.Username" value="#NewPersonInfo.username#" />
				<set name="Attributes.Password" value="#NewPersonInfo.password#" />
				<do action="mMain.doLogin" />
				<do action="vMain.RegisterTY" contentvariable="Request.Page.Body" />
			</case>
			<case value="AlreadyExist">
				<do action="vMain.RegisterAE" contentvariable="Request.Page.Body" />
			</case>
			<defaultcase>
				<do action="vMain.Register" contentvariable="Request.Page.Body" />
			</defaultcase>
		</switch>
		
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="ForgotPW">
		<set name="Request.Page.Title" value="Forgot Password" />
		<do action="vMain.ForgotPW" contentvariable="Request.Page.Body" />
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="doLogin">
		<do action="mMain.doLogin" />
	</fuseaction>
	
	<fuseaction name="doLogout">
        <do action="mMain.doLogout" />
    </fuseaction>
    
    <fuseaction name="VerifyEmail">
    	<do action="vMain.verifyEmail" contentvariable="Request.Page.Body" />
        <do action="vLayout.Default" />
    </fuseaction>
</circuit>
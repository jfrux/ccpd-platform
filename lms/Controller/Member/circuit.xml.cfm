<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!-- Member -->
<circuit access="public" xmlns:cs="coldspring/">
	
	<fuseaction name="Account">
		<set name="Request.Page.Title" value="Preferences" />
		<do action="mMember.savePrefs" />
		<do action="mMember.getEmails" />
		<do action="mMember.getPrefs" />
		<do action="vMember.Account" contentvariable="Request.Page.Body" />
		
        <set name="Request.Page.Breadcrumbs" value="" />
        <do action="mPage.ParseCrumbs" />
        <do action="vLayout.Default" />
	</fuseaction>
    
    <fuseaction name="Confirm">
		<set name="Request.Page.Title" value="Confirm your Credentials" />
        <do action="mMember.Confirm" />
		<do action="vMember.Confirm" contentvariable="Request.Page.Body" />
		
        <set name="Request.Page.Breadcrumbs" value="" />
        <do action="mPage.ParseCrumbs" />
        <do action="vLayout.Default" />
    </fuseaction>
	
	<fuseaction name="Curriculum">
		<set name="Request.Page.Title" value="Curriculum" />
    	<do action="mMember.getActivities" />
		<do action="vMember.Curriculum" contentvariable="Request.Page.Body" />
		
        <set name="Request.Page.Breadcrumbs" value="" />
        <do action="mPage.ParseCrumbs" />
        <do action="vLayout.Default" />
	</fuseaction>
    
    <fuseaction name="DeleteEmail">
    	<do action="mMember.deleteEmail" />
    </fuseaction>
    
    <fuseaction name="GenerateTranscript">
    	<do action="mMember.getPerson" />
    	<do action="mMember.getTranscript" />
        <do action="vMember.buildTranscript" />
    </fuseaction>
    
	<fuseaction name="Home">
		<set name="Request.Page.Title" value="My CCPD" />
		<do action="mMember.getActivities" />
		<do action="vMember.Home" contentvariable="Request.Page.Body" />
		
        <set name="Request.Page.Breadcrumbs" value="" />
        <do action="mPage.ParseCrumbs" />
        <do action="vLayout.Default" />
	</fuseaction>
    
    <fuseaction name="PrimaryEmail">
    	<do action="mMember.primaryEmail" />
    </fuseaction>
	
	<fuseaction name="Transcripts">
		<set name="Request.Page.Title" value="Transcript" />
    	<do action="mMember.getCredits" />
		<do action="vMember.Transcripts" contentvariable="Request.Page.Body" />
		
        <set name="Request.Page.Breadcrumbs" value="" />
        <do action="mPage.ParseCrumbs" />
        <do action="vLayout.Default" />
	</fuseaction>
	
</circuit>
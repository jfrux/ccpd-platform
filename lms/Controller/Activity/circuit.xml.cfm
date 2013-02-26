<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!-- Activity -->
<circuit access="public" xmlns:cs="coldspring/">
    
	<fuseaction name="Browse">
		<set name="Request.Page.Title" value="Browse Activities" />
    	<do action="mActivity.getActivities" />
    	
        <do action="vActivity.Browse" contentvariable="Request.Page.Body" />
		
        <set name="Request.Page.Breadcrumbs" value="" />
        <do action="mPage.ParseCrumbs" />
        <do action="vLayout.Default" />
	</fuseaction>
    
    <fuseaction name="Cert">
    	<do action="mActivity.getCertInfo" />
    	<do action="mActivity.getCertData" />
    	
        <do action="vActivity.Cert" contentvariable="Request.Page.Body" />
		
        <set name="Request.Page.Breadcrumbs" value="" />
        <do action="mPage.ParseCrumbs" />
        <do action="vLayout.None" />
    </fuseaction>
    
    <fuseaction name="Cert2">
    	<do action="mActivity.getCertInfo" />
    	<do action="mActivity.getCertData" />
    	
        <do action="vActivity.Certificate" contentvariable="Request.Page.Body" />
        <do action="vLayout.None" />
    </fuseaction>
	
	<fuseaction name="Comments">
        <!-- USED TO DETERMINE IF PRETEST WAS TAKEN YET -->
		<do action="mActivity.getAssessmentStatuses" />
        
		<do action="mActivity.getAttendee" />
		<do action="mActivity.getComments" />
		<do action="vActivity.Comments" />
	</fuseaction>
    
	<fuseaction name="Detail">
    	<do action="mActivity.getActivity" />
		<do action="mActivity.getActivityAlsoTaken" />
        <do action="mActivity.getStatements" />
		<set name="Request.Page.Title" value="#Attributes.Title#" />
		<set name="Request.Page.Desc" value="#PubGeneralBean.getOverview()#" />
    	<do action="mActivity.getActivityPubComponents" />
    	<do action="mActivity.getActivityPubGeneral" />
		<do action="mActivity.getAllowCommentStatus" />
        <do action="mActivity.getAttendee" />
    	
        <do action="vActivity.Detail" contentvariable="Request.Page.Body" />
		
        <set name="Request.Page.Breadcrumbs" value="" />
        <do action="mPage.ParseCrumbs" />
        <do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="Links">
        <!-- USED TO DETERMINE IF PRETEST WAS TAKEN YET -->
		<do action="mActivity.getAssessmentStatuses" />
        
		<do action="mActivity.getAttendee" />
		<do action="mActivity.getLinks" />
		<do action="vActivity.Links" />
	</fuseaction>
	
	<fuseaction name="link">
		
        <do action="mActivity.getActivity" />
		<do action="mActivity.getLink" />
		<set name="request.page.title" value="#qGetLink.DisplayName#" />
		<do action="vActivity.link" contentvariable="request.page.body" />
		
		<do action="vLayout.None" />
	</fuseaction>
	
	<fuseaction name="Materials">
        <!-- USED TO DETERMINE IF PRETEST WAS TAKEN YET -->
		<do action="mActivity.getAssessmentStatuses" />
        
		<do action="mActivity.getAttendee" />
		<do action="mActivity.getMaterials" />
		<do action="vActivity.Materials" />
	</fuseaction>
	
	<fuseaction name="Assessments">
		<do action="mActivity.getAttendee" />
		<do action="mActivity.getAssessmentStatuses" />
		<do action="vActivity.Assessments" />
	</fuseaction>
	
	<fuseaction name="Status">
        <!-- USED TO DETERMINE IF PRETEST WAS TAKEN YET -->
		<do action="mActivity.getAssessmentStatuses" />
    	<do action="mActivity.getActivityPubGeneral" />
        
    	<do action="mActivity.getActivity" />
		<do action="mActivity.getAttendee" />
		<do action="mActivity.getStatus" />
		<do action="vActivity.Status" />
	</fuseaction>
    
	<fuseaction name="Start">
    	<do action="mActivity.getActivity" />
    	<do action="mActivity.getActivityPubGeneral" />
        <do action="vActivity.Start" />
	</fuseaction>
    
	<fuseaction name="Test">
    	
        <do action="vActivity.Testpage" contentvariable="Request.Page.Body" />
		
        <set name="Request.Page.Breadcrumbs" value="" />
        <do action="mPage.ParseCrumbs" />
        <do action="vLayout.Default" />
	</fuseaction>	
</circuit>
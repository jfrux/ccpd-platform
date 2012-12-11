<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!-- Report -->
<circuit access="public">
	<prefuseaction callsuper="true">
		<set name="Request.NavItem" value="4" />
    </prefuseaction>
	
	<fuseaction name="cpdEvals">
		<set name="Request.Page.Title" value="Legacy CPD Evaluations" />
		
		<set name="Request.Page.Breadcrumbs" value="Reports|report.home,Legacy CPD Evaluations|report.cpdEvals" />
		<do action="mPage.ParseCrumbs" />
		
		<do action="vReport.cpdEvals" contentvariable="Request.Page.Body" />
		<do action="vLayout.Default" />
	</fuseaction>
    
	<fuseaction name="cpdEvalsAHAH">
		<do action="vReport.cpdEvalsAHAH" />
	</fuseaction>
    
    <fuseaction name="custom">
		<set name="Request.Page.Title" value="Custom Activity Report" />
		
		<set name="Request.Page.Breadcrumbs" value="Reports|report.home,Legacy Survey Builder Results|report.legacySurvey" />
		<do action="mPage.ParseCrumbs" />
        
		<do action="vReport.customActivity" contentvariable="Request.Page.Body" />
		<do action="vLayout.Default" />
    </fuseaction>
    
	<fuseaction name="legacySurvey">
		<set name="Request.Page.Title" value="Legacy Survey Builder Results" />
		
		<set name="Request.Page.Breadcrumbs" value="Reports|report.home,Legacy Survey Builder Results|report.legacySurvey" />
		<do action="mPage.ParseCrumbs" />
		
		<do action="vReport.legacySurvey" contentvariable="Request.Page.Body" />
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="legacySurveyAHAH">
		<do action="vReport.legacySurveyAHAH" />
	</fuseaction>
	
	<fuseaction name="ACCMEPrep">
		<set name="Request.Page.Title" value="ACCME Prep Report" />
		
		<set name="Request.Page.Breadcrumbs" value="Reports|report.home,ACCME Prep|report.accmeprep" />
		<do action="mPage.ParseCrumbs" />
		
		<do action="vReport.ACCMEPrep" contentvariable="Request.Page.Body" />
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="ACCMEPrepAHAH">
		<do action="vReport.ACCMEPrepAHAH" />
	</fuseaction>
	
	<fuseaction name="ACCMEPrep-Mod">
		<set name="Request.Page.Title" value="ACCME Prep Modified Report" />
		
		<set name="Request.Page.Breadcrumbs" value="Reports|report.home,ACCME Prep|report.accmeprep-mod" />
		<do action="mPage.ParseCrumbs" />
		
		<do action="vReport.ACCMEPrep-Mod" contentvariable="Request.Page.Body" />
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="ACCMEPrep-ModAHAH">
		<do action="vReport.ACCMEPrep-ModAHAH" />
	</fuseaction>
    
    <fuseaction name="AdvancedActivity">
		<set name="Request.Page.Title" value="Advanced Activity Report" />
		
		<set name="Request.Page.Breadcrumbs" value="Reports|report.home,Advanced Activity Report|report.advancedactivity" />
		<do action="mPage.ParseCrumbs" />
		
		<do action="vReport.AdvancedActivity" contentvariable="Request.MultiFormContent" />
        <do action="vReport.AdvancedActivityRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Multiform" contentvariable="Request.Page.Body" />
		<do action="vLayout.Default" />
    </fuseaction>
	
	<fuseaction name="Issues">
		<do action="mReport.getIssues" />
		<set name="Request.Page.Title" value="Activity Issues" />
        
		<set name="Request.Page.Breadcrumbs" value="Reports|Report.Home,Activity Issues|Report.Issues" />
		<do action="mPage.ParseCrumbs" />
		
		<set name="Request.MultiFormTitle" value="Activity Issues" />
		
		<do action="vReport.Issues" contentvariable="Request.MultiFormContent" />
        <do action="vReport.IssuesRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Multiform" contentvariable="Request.Page.Body" />
        
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="ACCMEDetail">
		<set name="Request.Page.Title" value="ACCME Detail" />
        
		<set name="Request.Page.Breadcrumbs" value="Reports|Report.Home,ACCME Detail|Report.ACCMEDetail" />
		<do action="mPage.ParseCrumbs" />
		
		<set name="Request.MultiFormTitle" value="ACCME Detail" />
		
		<do action="vReport.ACCMEDetail" contentvariable="Request.Page.Body" />
        
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="ACCMEDetailAHAH">
		<do action="vReport.ACCMEDetailAHAH" />
	</fuseaction>
	
	<fuseaction name="ACCMESummary">
		<set name="Request.Page.Title" value="ACCME Summary" />
        
		<set name="Request.Page.Breadcrumbs" value="Reports|Report.Home,ACCME Summary|Report.ACCMESummary" />
		<do action="mPage.ParseCrumbs" />
		
		<set name="Request.MultiFormTitle" value="ACCME Summary" />
		
		<do action="vReport.ACCMESummary" contentvariable="Request.MultiFormContent" />
        <do action="vReport.ACCMESummaryRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Multiform" contentvariable="Request.Page.Body" />
        
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="ACCMESummaryAHAH">
		<do action="vReport.ACCMESummaryAHAH" />
	</fuseaction>
	
	<fuseaction name="TestingSummary">
		<set name="Request.Page.Title" value="Activity Testing Report" />
        
		<set name="Request.Page.Breadcrumbs" value="Reports|Report.Home,Activity Testing Report|Report.TestingSummary" />
		<do action="mPage.ParseCrumbs" />
		
		<set name="Request.MultiFormTitle" value="Activity Testing Report" />
		
		<do action="mReport.getTestingActivities" />
		<do action="vReport.TestingSummary" contentvariable="Request.MultiFormContent" />
        <do action="vReport.TestingSummaryRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Multiform" contentvariable="Request.Page.Body" />
        
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="TestingSummaryAHAH">
		<do action="mReport.getTestingSummaryResults" />
        <do action="mActivity.getActivity" />
		<do action="vReport.TestingSummaryAHAH" />
	</fuseaction>
	
	<fuseaction name="CMECert">		
		<do action="mReport.getCMECertData" />
		<set name="Request.Page.Title" value="CME Certificate" />
        
		<set name="Request.Page.Breadcrumbs" value="Reports|Report.Home,ACCME Report|Report.ACCME" />
		<do action="mPage.ParseCrumbs" />
		
		<do action="mReport.getDetail" />
		<do action="vReport.ReportGen" />
        
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="CNECert">		
		<do action="mReport.getCNECertData" />
		<set name="Request.Page.Title" value="CNE Certificate" />
        
		<set name="Request.Page.Breadcrumbs" value="Reports|Report.Home,CME Certificate|Report.CNECert" />
		<do action="mPage.ParseCrumbs" />
		
		<do action="mReport.getDetail" />
		<do action="vReport.ReportGen" />
        
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="Attendance">
		<set name="Request.Page.Title" value="Attendance Report" />
        
		<set name="Request.Page.Breadcrumbs" value="Reports|Report.Home,Attendance Report|Report.Attendance" />
		<do action="mPage.ParseCrumbs" />
		
		<set name="Request.MultiFormTitle" value="Activity Attendance Report" />
		
		<do action="mReport.getActivities" />
        <do action="mReport.getCategories" />
		<do action="vReport.Attendance" contentvariable="Request.MultiFormContent" />
        <do action="vReport.AttendanceRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Multiform" contentvariable="Request.Page.Body" />
        
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="AttendanceAHAH">
		<do action="vReport.AttendanceAHAH" />
	</fuseaction>
	
	<fuseaction name="CDCPIF">
		<set name="Request.Page.Title" value="CDC PIF Report" />
        
		<set name="Request.Page.Breadcrumbs" value="Reports|Report.Home,CDC PIF Report|Report.CDCPIF" />
		<do action="mPage.ParseCrumbs" />
		
		<set name="Request.MultiFormTitle" value="CDC Reports" />
		
		<do action="mReport.getCDCActivities" />
		<do action="vReport.CDCPIF" contentvariable="Request.MultiFormContent" />
        <do action="vReport.CDCPIFRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Multiform" contentvariable="Request.Page.Body" />
        
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="CDCPIFAHAH">
		<do action="vReport.CDCPIFAHAH" />
	</fuseaction>
	
	<fuseaction name="activityByContainerAHAH">
		<do action="vReport.activityByContainerAHAH" />
	</fuseaction>
	
	<fuseaction name="Assessment">
		<set name="Request.Page.Title" value="Activity Assessment Report" />
        
		<set name="Request.Page.Breadcrumbs" value="Reports|Report.Home,Activity Assessment Report|Report.Assessment" />
		<do action="mPage.ParseCrumbs" />
		
		<set name="Request.MultiFormTitle" value="Activity Assessment Reports" />
		
		<do action="mReport.getActivities" />
		<do action="mReport.getCategories" />
		<do action="vReport.Assessment" contentvariable="Request.MultiFormContent" />
        <do action="vReport.AssessmentRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Multiform" contentvariable="Request.Page.Body" />
        
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="AssessmentAHAH">
		<do action="vReport.AssessmentAHAH" />
	</fuseaction>
	
	<fuseaction name="AssessmentListAHAH">
    	<do action="mReport.getActivityAssessments" />
		<do action="vReport.AssessmentListAHAH" />
	</fuseaction>
	
	<fuseaction name="AssessSingle">
		<set name="Request.Page.Title" value="Individual Assessment Report" />
        
		<set name="Request.Page.Breadcrumbs" value="Reports|Report.Home,Individual Assessment Report|Report.AssessSingle" />
		<do action="mPage.ParseCrumbs" />
		
		<set name="Request.MultiFormTitle" value="Individual Assessment Report" />
		
		<do action="mReport.getActivities" />
		<do action="mReport.getCategories" />
		<do action="vReport.AssessSingle" contentvariable="Request.MultiFormContent" />
        <do action="vReport.AssessSingleRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Multiform" contentvariable="Request.Page.Body" />
        
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="AssessSingleAHAH">
		<do action="vReport.AssessSingleAHAH" />
	</fuseaction>
	
	<fuseaction name="AttendeeListAHAH">
		<do action="mReport.getAttendees" />
		<do action="vReport.AttendeeListAHAH" />
	</fuseaction>
	
	<fuseaction name="ResultsListAHAH">
		<do action="mReport.getAssessResults" />
		<do action="vReport.ResultsListAHAH" />
	</fuseaction>
	
	<fuseaction name="CDCOverview">
		<set name="Request.Page.Title" value="CDC Overview Report" />
        
		<set name="Request.Page.Breadcrumbs" value="Reports|Report.Home,CDC Overview Report|Report.CDCOverview" />
		<do action="mPage.ParseCrumbs" />
		
		<set name="Request.MultiFormTitle" value="CDC Reports" />
		
		<do action="vReport.CDCOverview" contentvariable="Request.MultiFormContent" />
        <do action="vReport.CDCOverviewRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Multiform" contentvariable="Request.Page.Body" />
        
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="CDCOverviewAHAH">
		<do action="vReport.CDCOverviewAHAH" />
	</fuseaction>
	
	<fuseaction name="CDCPIFTally">
		<set name="Request.Page.Title" value="CDC PIF Tally Report" />
        
		<set name="Request.Page.Breadcrumbs" value="Reports|Report.Home,CDC PIF Tally|Report.CDCPIFTally" />
		<do action="mPage.ParseCrumbs" />
		
		<set name="Request.MultiFormTitle" value="CDC PIF Tally Report" />
		
		<do action="vReport.CDCPIFTally" contentvariable="Request.Page.Body" />
        
		<do action="vLayout.Default" />
	</fuseaction>
    
	<fuseaction name="CDCPIFTallyAHAH">
		<do action="vReport.CDCPIFTallyAHAH" />
	</fuseaction>
	
	<fuseaction name="CDCReport">
		<set name="Request.Page.Title" value="CDC Activity/Student Report" />
        
		<set name="Request.Page.Breadcrumbs" value="Reports|Report.Home,CDC Reports|Report.CDCReport" />
		<do action="mPage.ParseCrumbs" />
		
		<set name="Request.MultiFormTitle" value="CDC Activity/Student Report" />
		
		<do action="vReport.CDCReport" contentvariable="Request.MultiFormContent" />
        <do action="vReport.CDCReportRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Multiform" contentvariable="Request.Page.Body" />
        
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="CDCStateAttendeeCount">
		<set name="Request.Page.Title" value="CDC Attendee Count for Activity Type by State Report" />
        
		<set name="Request.Page.Breadcrumbs" value="Reports|Report.Home,CDC Attendee Count for Activity Type by State Report|Report.CDCStateAttendeeCount" />
		<do action="mPage.ParseCrumbs" />
		
		<set name="Request.MultiFormTitle" value="CDC Reports" />
		
		<do action="vReport.CDCStateAttendeeCount" contentvariable="Request.MultiFormContent" />
        <do action="vReport.CDCStateAttendeeCountRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Multiform" contentvariable="Request.Page.Body" />
        
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="ContainerSummary">
		<set name="Request.Page.Title" value="Activities by Container" />
        
		<set name="Request.Page.Breadcrumbs" value="Reports|Report.Home,Activities by Container|Report.ContainerSummary" />
		<do action="mPage.ParseCrumbs" />

		<do action="vReport.ContainerSummary" contentvariable="Request.Page.Body" />
        
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="CategoryLMS">
		<set name="Request.Page.Title" value="Activities by Category (LMS)" />
        
		<set name="Request.Page.Breadcrumbs" value="Reports|Report.Home,Activities by Category|Report.CategoryLMS" />
		<do action="mPage.ParseCrumbs" />
		
		<set name="Request.MultiFormTitle" value="Activities by Category" />
		
		<do action="vReport.CategoryLMS" contentvariable="Request.MultiFormContent" />
        <do action="vReport.CategoryLMSRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Multiform" contentvariable="Request.Page.Body" />
        
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="Home">
		<set name="Request.Page.Title" value="Reports" />
		<set name="Request.Page.Breadcrumbs" value="Reports|Report.Home" />
		<do action="mPage.ParseCrumbs" />
		<do action="vReport.Home" contentvariable="Request.MultiFormContent" />
        <do action="vReport.HomeRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Multiform" contentvariable="Request.Page.Body" />
		
		<do action="vLayout.Default" />
	</fuseaction>
		
	<fuseaction name="MailingLabels">
		<do action="mActivity.getActivity" />
		<set name="Request.Page.Title" value="Mailing Labels" />
		<if condition="isDefined('Attributes.Print')">
			<true>
				<do action="mReport.getAttendees" />
				<do action="mReport.getDetail" />
				<do action="vReport.ReportGen" />
			</true>
			<false>
				<do action="vReport.MailingLabels" contentvariable="Request.MultiFormContent" />
				<do action="vReport.MailingLabelsRight" contentvariable="Request.MultiFormRight" />
				<do action="vLayout.Sub_Multiform" contentvariable="Request.Page.Body" />
				
				<do action="vLayout.Default" />
			</false>
		</if>
	</fuseaction>
		
	<fuseaction name="NameBadges">
		<do action="mReport.getAttendees" />
		<do action="mActivity.getActivity" />
		<set name="Request.Page.Title" value="Name Badges" />
		<if condition="isDefined('Attributes.Print')">
			<true>
				<do action="mReport.getDetail" />
				<do action="vReport.ReportGen" />
			</true>
			<false>
				<do action="vReport.NameBadges" contentvariable="Request.MultiFormContent" />
				<do action="vReport.NameBadgesRight" contentvariable="Request.MultiFormRight" />
				<do action="vLayout.Sub_Multiform" contentvariable="Request.Page.Body" />
				
				<do action="vLayout.Default" />
			</false>
		</if>
	</fuseaction>
	
	<fuseaction name="SigninSheet">		
		<do action="mActivity.getActivity" />
		<do action="mReport.getSigninSheetData" />
		<set name="Request.Page.Title" value="Signup-in Sheet" />
        
		<set name="Request.Page.Breadcrumbs" value="Reports|Report.Home,Sign-in Sheet|Report.SigninSheet" />
		<do action="mPage.ParseCrumbs" />
		
		<do action="mReport.getDetail" />
		<do action="vReport.ReportGen" />
        
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="SpecialtyLMS">
		<set name="Request.Page.Title" value="Activities by Specialty (LMS)" />
        
		<set name="Request.Page.Breadcrumbs" value="Reports|Report.Home,Activities by Specialty|Report.SpecialtyLMS" />
		<do action="mPage.ParseCrumbs" />
		
		<set name="Request.MultiFormTitle" value="Activities by Specialty" />
		
		<do action="vReport.SpecialtyLMS" contentvariable="Request.MultiFormContent" />
        <do action="vReport.SpecialtyLMSRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Multiform" contentvariable="Request.Page.Body" />
        
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="Overview">
		<set name="Request.Page.Title" value="Activity Overview Report" />
        
		<set name="Request.Page.Breadcrumbs" value="Reports|Report.Home,Overview Report|Report.Overview" />
		<do action="mPage.ParseCrumbs" />
		
		<set name="Request.MultiFormTitle" value="Activity Reports" />
		
		<do action="vReport.Overview" contentvariable="Request.MultiFormContent" />
        <do action="vReport.OverviewRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Multiform" contentvariable="Request.Page.Body" />
        
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="Transcript">
    	<do action="mPerson.getPerson" />
    	<do action="mReport.getTranscript" />
        
		<set name="Request.Page.Title" value="Transcript for #Attributes.FirstName# #Attributes.LastName#" />
		
		<do action="vReport.Transcript" contentvariable="Request.Page.Body" />
		<do action="vLayout.None" />
	</fuseaction>
</circuit>
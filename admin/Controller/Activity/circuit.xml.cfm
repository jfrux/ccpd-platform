<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!-- Activity -->
<circuit access="public">
	<prefuseaction callsuper="true">
		<set name="Request.NavItem" value="2" />
		
		<if condition="isDefined('Attributes.ActivityID')">
			<true>
				<set name="Request.MultiFormEditLabel" value="Edit this activity" />
				<do action="mActivity.getActivity" />
				<do action="mActivity.getSubActivities" />
				<do action="mActivity.getLiveGroupings" />
        <do action="mActivity.getActivityTypes" />
				<set name="Request.ActionsLimit" value="4" />

				<set name="Request.Page.Title" value="#ActivityBean.getTitle()#" />
        
				<set name="ActivityTitleShort" value="#midLimit(Attributes.ActivityTitle,50)# // #DateFormat(ActivityBean.getStartDate(),'mm/dd/yyyy')#" />
				
				<do action="mActivity.getActions" />
				<set name="Request.MultiFormEditLink" value="#myself#Activity.Detail?ActivityID=#Attributes.ActivityID#" />
			</true>
		</if>
    </prefuseaction>
	
	<!-- AHAH pages -->
	<fuseaction name="ActivityList">
		<do action="vActivity.ActivityList" />
	</fuseaction>
    
	<fuseaction name="ActionsShort">
		<do action="vActivity.ActionsShort" />
	</fuseaction>
	
	<fuseaction name="Container">
		<do action="vActivity.Container" />
	</fuseaction>
	
	<fuseaction name="Stats">
    	<do action="mActivity.getActivity" />
		<do action="vActivity.Stats" />
	</fuseaction>
	
	<fuseaction name="Import">
		<do action="vActivity.Import" />
		
		<do action="vLayout.None" contentvariable="Request.Page.Body" />
	</fuseaction>
	<!-- //END AHAH pages -->
	
	<fuseaction name="ACCME">
		
		<set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,ACCME Information|Activity.accme?ActivityID=#Attributes.ActivityID#" />
		<do action="mPage.ParseCrumbs" />
		<do action="mActivity.TabControl" />
        
		<do action="mActivity.getOther" />
        
		<do action="vActivity.ACCME" contentvariable="Request.MultiFormContent" />
        <do action="vActivity.ACCMERight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Activity" contentvariable="Request.Page.Body" />
        
		<do action="vLayout.Default" />
    </fuseaction>
	
	<fuseaction name="Actions">
		
		<set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Actions|Activity.actions?ActivityID=#Attributes.ActivityID#" />
		<do action="mPage.ParseCrumbs" />
		<do action="mActivity.TabControl" />
		
		<do action="mActivity.getAllActions" />
		<do action="vActivity.Actions" contentvariable="Request.MultiFormContent" />
        <do action="vActivity.ActionsRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Activity" contentvariable="Request.Page.Body" />
        
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="AdjustCredits">
    	<do action="mActivity.saveAttendeeCredits" />
		<do action="mActivity.getAttendeeCredits" />
		<do action="vActivity.AdjustCredits" />
	</fuseaction>
    
    <fuseaction name="Agenda">
		<do action="mActivity.TabControl" />
        
		<set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Other|Activity.Other?ActivityID=#Attributes.ActivityID#,Agenda|Activity.Agenda?ActivityID=#Attributes.ActivityID#" />
		<do action="mPage.ParseCrumbs" />
		
		<do action="vActivity.Agenda" contentvariable="Request.MultiFormContent" />
        <do action="vActivity.AgendaRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Activity" contentvariable="Request.Page.Body" />
        
        <do action="vLayout.Default" />
	</fuseaction>
    
    <fuseaction name="AgendaAHAH">
    	<do action="vActivity.AgendaAHAH" />
    </fuseaction>
	
	<fuseaction name="AgendaForm">
		<do action="mActivity.getAgendaItem" />
		<do action="vActivity.AgendaForm" contentvariable="Request.Page.Body" />
		<do action="vLayout.Blank" />
	</fuseaction>
	
    <fuseaction name="Application">
		<do action="mActivity.getApplication" />
		<do action="mActivity.TabControl" />
							
		<set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Other|Activity.Other?ActivityID=#Attributes.ActivityID#,Application|Activity.Application?ActivityID=#Attributes.ActivityID#" />
		<do action="mPage.ParseCrumbs" />
		
		<do action="vActivity.Application" contentvariable="Request.MultiFormContent" />
        <do action="vActivity.ApplicationRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Activity" contentvariable="Request.Page.Body" />
        
        <do action="vLayout.Default" />
	</fuseaction>
    
    <fuseaction name="Assessment">
    	<do action="mActivity.getAssessments" />
        <do action="mActivity.getAssessResult" />
    	<do action="vActivity.Assessment" />
    </fuseaction>
	
	<fuseaction name="Assessments">
		<do action="mActivity.getAssessments" />
		<do action="mActivity.TabControl" />
		
        
		<set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Assessments|Activity.Assessments?ActivityID=#Attributes.ActivityID#" />
		<do action="mPage.ParseCrumbs" />
		
		<set name="Request.MultiFormTitle" value="Assessments" />
		
		<do action="vActivity.Assessments" contentvariable="Request.MultiFormContent" />
        <do action="vActivity.AssessmentsRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Activity" contentvariable="Request.Page.Body" />
        
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="AssessmentsAHAH">
		<do action="mActivity.getAssessments" />
		<do action="vActivity.AssessmentsAHAH" />
	</fuseaction>
	
	<fuseaction name="AttendeeCDC">
		<do action="mPerson.getPerson" />
		<do action="mActivity.getAttendeeCDC" />
		<do action="mActivity.saveAttendeeCDC" />
		
		<set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Needs Assessment|Activity.Needs?ActivityID=#Attributes.ActivityID#" />
		<do action="mPage.ParseCrumbs" />
		
		<set name="Request.MultiFormTitle" value="Needs Assessment" />
		
		<do action="vActivity.AttendeeCDC" />
	</fuseaction>
	
	<fuseaction name="AttendeeDetailAHAH">
    	<do action="mPerson.getPerson" />
		<do action="mActivity.getAttendeeDetails" />
		<do action="vActivity.AttendeeDetailAHAH" />
	</fuseaction>
	
	<fuseaction name="Attendees">
		<do action="mActivity.getAttendees" />
        <do action="mActivity.getCredits" />
        <do action="mActivity.getAttendeeStatuses" />
		<do action="mActivity.TabControl" />
		
		<set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Attendees|Activity.Attendees?ActivityID=#Attributes.ActivityID#" />
		<do action="mPage.ParseCrumbs" />
		
		<set name="Request.MultiFormTitle" value="Needs Assessment" />
		
		<do action="vActivity.Attendees" contentvariable="Request.MultiFormContent" />
        <do action="vActivity.AttendeesRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Activity" contentvariable="Request.Page.Body" />
        
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="AttendeesAHAH">
		<do action="mActivity.getAttendees" />
        <do action="mActivity.getCredits" />
		<do action="vActivity.AttendeesAHAH" />
	</fuseaction>
	
	<fuseaction name="Attendees2">
		<do action="mActivity.getAttendees" />
        <do action="mActivity.getCredits" />
        <do action="mActivity.getAttendeeStatuses" />
		<do action="mActivity.TabControl" />
		
		<set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Attendees|Activity.Attendees?ActivityID=#Attributes.ActivityID#" />
		<do action="mPage.ParseCrumbs" />
		
		<set name="Request.MultiFormTitle" value="Needs Assessment" />
		
		<do action="vActivity.Attendees2" contentvariable="Request.MultiFormContent" />
        <do action="vActivity.Attendees2Right" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Activity" contentvariable="Request.Page.Body" />
        
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="Attendees2AHAH">
		<do action="mActivity.getAttendees" />
        <do action="mActivity.getCredits" />
		<do action="vActivity.Attendees2AHAH" />
	</fuseaction>
    
	<fuseaction name="CDCInfo">
		<do action="mActivity.saveCDCInfo" />
		<do action="mActivity.getCDCInfo" />
		<do action="mActivity.TabControl" />
							
		<set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Other|Activity.Other?ActivityID=#Attributes.ActivityID#,CDC Info|Activity.CDCInfo?ActivityID=#Attributes.ActivityID#" />
		<do action="mPage.ParseCrumbs" />
		
		<do action="vActivity.CDCInfo" contentvariable="Request.MultiFormContent" />
        <do action="vActivity.CDCInfoRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Activity" contentvariable="Request.Page.Body" />
        
        <do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="Committee">
		<do action="mActivity.TabControl" />
        <do action="mActivity.getRoles" />
		<do action="mActivity.getActivityCommittee" />
		
		<set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Committee|Activity.Committee?ActivityID=#Attributes.ActivityID#" />
		<do action="mPage.ParseCrumbs" />
		
		<set name="Request.MultiFormTitle" value="Planning Committee Members" />
		<do action="vActivity.Committee" contentvariable="Request.MultiFormContent" />
        <do action="vActivity.CommitteeRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Activity" contentvariable="Request.Page.Body" />
        
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="CommitteeAHAH">
		<do action="mActivity.getActivityCommittee" />
		<do action="vActivity.CommitteeAHAH" />
	</fuseaction>
	
	<fuseaction name="Create">
		<do action="mActivity.getActivityTypes" />
        <do action="mActivity.getLiveGroupings" />
        <do action="mActivity.getEMGroupings" />
		<do action="mActivity.createActivity" />
		
		<set name="Request.Page.Title" value="Create Activity" />
        
		<set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,Unsaved Activity|Activity.Create" />
        
		<do action="mPage.ParseCrumbs" />
		
		<do action="vActivity.CreateRight" contentvariable="Request.MultiFormRight" />
		<do action="vActivity.Create" contentvariable="Request.MultiFormContent" />
		<do action="vLayout.Sub_MultiForm" contentvariable="Request.Page.Body" />
        
        <do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="Credits">
		<do action="mActivity.saveCredits" />
		
		<do action="mActivity.getCredits" />
		<do action="mActivity.TabControl" />
		
		<set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Credits|Activity.Credits?ActivityID=#Attributes.ActivityID#" />
		<do action="mPage.ParseCrumbs" />
		
		<set name="Request.MultiFormTitle" value="Credit &amp; Points" />
		
		<do action="vActivity.Credits" contentvariable="Request.MultiFormContent" />
        <do action="vActivity.CreditsRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Activity" contentvariable="Request.Page.Body" />
        
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="Detail">
		<do action="mActivity.TabControl" />
		
		<set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#" />
		<do action="mPage.ParseCrumbs" />
		
		<do action="vActivity.Edit" contentvariable="Request.MultiFormContent" />
        <do action="vActivity.EditRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Activity" contentvariable="Request.Page.Body" />
        
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="Docs">
		<do action="mActivity.getDocTypes" />
		<do action="mActivity.getDocs" />
		<do action="mActivity.TabControl" />
		
		<set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Documents|Activity.Docs?ActivityID=#Attributes.ActivityID#" />
		<do action="mPage.ParseCrumbs" />
		
		<set name="Request.MultiFormTitle" value="Documents &amp; Materials" />
		
		<do action="vActivity.Docs" contentvariable="Request.MultiFormContent" />
        <do action="vActivity.DocsRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Activity" contentvariable="Request.Page.Body" />
        
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="DocsAHAH">
		<do action="mActivity.getDocs" />
		<do action="vActivity.DocsAHAH" />
	</fuseaction>
	
	<fuseaction name="EditCurrSupport">	
		<do action="mActivity.getSupporters" />
		<do action="mActivity.getSupportTypes" />
		<do action="mActivity.saveCurrSupport" />
		<do action="mActivity.getCurrSupport" />		
		<do action="vActivity.EditCurrSupport" contentvariable="Request.Page.Body" />
        <do action="vLayout.None" />
	</fuseaction>
	
	<fuseaction name="EditSupporter">
		<do action="mActivity.saveSupporter" />		
		<do action="mActivity.getSupporter" />		
		<do action="vActivity.EditSupporter" contentvariable="Request.Page.Body" />
        <do action="vLayout.None" />
	</fuseaction>
    
    <fuseaction name="emailCert">
    	<do action="vActivity.emailCert" contentvariable="Request.Page.Body" />
        <do action="vLayout.None" />
    </fuseaction>
	
	<fuseaction name="Faculty">
		<do action="mActivity.TabControl" />
        <do action="mActivity.getRoles" />
		
		<set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Faculty|Activity.Faculty?ActivityID=#Attributes.ActivityID#" />
		<do action="mPage.ParseCrumbs" />
		
		<set name="Request.MultiFormTitle" value="Faculty" />
		<do action="vActivity.Faculty" contentvariable="Request.MultiFormContent" />
        <do action="vActivity.FacultyRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Activity" contentvariable="Request.Page.Body" />
        
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="FacultyAHAH">
		<do action="mActivity.getActivityFaculty" />
        
		<do action="vActivity.FacultyAHAH" />
	</fuseaction>
	
	<fuseaction name="FileUpload">
		<do action="mActivity.getDocTypes" />
		<do action="mActivity.FileUpload" />
		<do action="vActivity.FileUpload" />
	</fuseaction>
	
	<fuseaction name="Finances">
		<do action="mActivity.getFinOverview" />
		<do action="mActivity.TabControl" />
		
		
        
		<set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Finances|Activity.Finances?ActivityID=#Attributes.ActivityID#" />
		<do action="mPage.ParseCrumbs" />
		
		<set name="Request.MultiFormTitle" value="Finances" />
		<do action="vActivity.Finances" contentvariable="Request.MultiFormContent" />
        <do action="vActivity.FinancesRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Activity" contentvariable="Request.Page.Body" />
        
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="FinBudget">
		<do action="mActivity.saveFinBudget" />
		<do action="mActivity.TabControl" />
		
		
        
		<set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Finances|Activity.Finances?ActivityID=#Attributes.ActivityID#,Budget|Activity.FinBudget?ActivityID=#Attributes.ActivityID#" />
		<do action="mPage.ParseCrumbs" />
		
		<set name="Request.MultiFormTitle" value="Finances" />
		<do action="vActivity.FinBudget" contentvariable="Request.MultiFormContent" />
        <do action="vActivity.FinBudgetRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Activity" contentvariable="Request.Page.Body" />
        
		<do action="vLayout.Default" />
	</fuseaction>
    
    <fuseaction name="FinBudgetAHAH">
		<do action="mActivity.getEntryTypes" />
		<do action="mActivity.getFinBudgets" />
        <do action="vActivity.FinBudgetAHAH" />
    </fuseaction>
	
	<fuseaction name="FinFees">
		<do action="mActivity.TabControl" />
		
		
        
		<set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Finances|Activity.Finances?ActivityID=#Attributes.ActivityID#,Fees|Activity.FinFees?ActivityID=#Attributes.ActivityID#" />
		<do action="mPage.ParseCrumbs" />
		
		<set name="Request.MultiFormTitle" value="Finances" />
		<do action="vActivity.FinFee" contentvariable="Request.MultiFormContent" />
        <do action="vActivity.FinFeeRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Activity" contentvariable="Request.Page.Body" />
        
		<do action="vLayout.Default" />
	</fuseaction>
    
    <fuseaction name="FinFeesAHAH">
		<do action="mActivity.getFinFees" />
		<do action="mActivity.getFinFee" />
    	<do action="vActivity.FinFeeAHAH" />
    </fuseaction>
	
	<fuseaction name="FinLedger">
		<do action="mActivity.TabControl" />
		
		
        
		<set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Finances|Activity.Finances?ActivityID=#Attributes.ActivityID#,General Ledger|Activity.FinLedger?ActivityID=#Attributes.ActivityID#" />
		<do action="mPage.ParseCrumbs" />
		
		<set name="Request.MultiFormTitle" value="Finances" />
		<do action="vActivity.FinLedger" contentvariable="Request.MultiFormContent" />
        <do action="vActivity.FinLedgerRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Activity" contentvariable="Request.Page.Body" />
        
		<do action="vLayout.Default" />
	</fuseaction>
    
    <fuseaction name="FinLedgerAHAH">
		<do action="mActivity.getEntryTypes" />
		<do action="mActivity.getFinLedgers" />
        <do action="vActivity.FinLedgerAHAH" />
    </fuseaction>
	
	<fuseaction name="FinSupport">
		<do action="mActivity.getFinSupporters" />
		<do action="mActivity.getSupporters" />
		<do action="mActivity.getSupportTypes" />
		<do action="mActivity.TabControl" />
		
		
        
		<set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Finances|Activity.Finances?ActivityID=#Attributes.ActivityID#,Supporters|Activity.FinSupport?ActivityID=#Attributes.ActivityID#" />
		<do action="mPage.ParseCrumbs" />
		
		<set name="Request.MultiFormTitle" value="Finances" />
		<do action="vActivity.FinSupport" contentvariable="Request.MultiFormContent" />
        <do action="vActivity.FinSupportRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Activity" contentvariable="Request.Page.Body" />
        
		<do action="vLayout.Default" />
	</fuseaction>
    
    <fuseaction name="FinSupportAHAH">
		<do action="mActivity.getFinSupporters" />
        <do action="vActivity.FinSupportAHAH" />
    </fuseaction>
	
	<fuseaction name="History">
		<do action="mActivity.TabControl" />
		
		
        
		<set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Credits|Activity.Credits?ActivityID=#Attributes.ActivityID#" />
		<do action="mPage.ParseCrumbs" />
		
		<set name="Request.MultiFormTitle" value="History" />
		
		<do action="vActivity.History" contentvariable="Request.MultiFormContent" />
		<do action="vLayout.Sub_Activity" contentvariable="Request.Page.Body" />
        
		<do action="vLayout.Default" />
	</fuseaction>
    
	<fuseaction name="home">
		<do action="mActivity.getActivities" />
		<do action="mActivity.getActivityTypes" />
        <do action="mActivity.getLiveGroupings" />
        <do action="mActivity.getEMGroupings" />
        
		<set name="Request.Page.Title" value="Activities" />
        <set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home" />
        
		<do action="mPage.ParseCrumbs" />
		
		<do action="vActivity.List" contentvariable="Request.Page.Body" />
        
        <do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="home2">
		<set name="Request.Page.Title" value="Activities" />
        <set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home" />
        
		<do action="mPage.ParseCrumbs" />
		
		<do action="vActivity.Home" contentvariable="Request.Page.Body" />
        
        <do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="Meals">
		<do action="mActivity.TabControl" />
							
		
        
		<set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Other|Activity.Other?ActivityID=#Attributes.ActivityID#,Meals|Activity.Meals?ActivityID=#Attributes.ActivityID#" />
		<do action="mPage.ParseCrumbs" />
		
		<do action="vActivity.Other" contentvariable="Request.MultiFormContent" />
        <do action="vActivity.OtherRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Activity" contentvariable="Request.Page.Body" />
        
        <do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="NoteCreate">
		<do action="mActivity.saveNote" />
		
		<do action="mActivity.TabControl" />
			
		
        
		<set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Notes|Activity.Notes?ActivityID=#Attributes.ActivityID#,New Note|Activity.CreateNote+ActivitiesectionID=2" />
		<do action="mPage.ParseCrumbs" />
		
		<set name="Request.MultiFormTitle" value="Create A Activity Note" />
		<do action="vActivity.NoteCreate" contentvariable="Request.MultiFormContent" />
        <do action="vActivity.NoteCreateRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_MultiForm" contentvariable="Request.Page.Body" />
        
        <do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="NoteDelete">
		<do action="mActivity.deleteNote" />
	</fuseaction>
	
	<fuseaction name="Notes">
		<do action="mActivity.TabControl" />
		
		<do action="mActivity.getNotes" />
		
		
        
		<set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Notes|Activity.Notes?ActivityID=#Attributes.ActivityID#" />
		<do action="mPage.ParseCrumbs" />
		
		<set name="Request.MultiFormTitle" value="Notes" />
		
		<do action="vActivity.Notes" contentvariable="Request.MultiFormContent" />
		<do action="vLayout.Sub_Activity" contentvariable="Request.Page.Body" />
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="Other">
		<do action="mActivity.TabControl" />
							
		
        
		<set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Other|Activity.Other?ActivityID=#Attributes.ActivityID#" />
		<do action="mPage.ParseCrumbs" />
		
		<do action="vActivity.Other" contentvariable="Request.MultiFormContent" />
        <do action="vActivity.OtherRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Activity" contentvariable="Request.Page.Body" />
        
        <do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="Overview">
		<do action="mActivity.getActivityTypes" />
		<do action="mActivity.getDocTypes" />
		<do action="mActivity.getDocs" />
		<do action="mActivity.getCredits" />
		<do action="mActivity.getCDCInfo" />
		<do action="mActivity.getFinOverview" />
		<do action="mActivity.getSupporters" />
		<do action="mActivity.getSupportTypes" />
		<do action="mActivity.getFinSupporters" />
		<do action="mActivity.getActivityFaculty" />
		<do action="mActivity.getActivityCommittee" />
		<do action="mActivity.getAttendees" />
		
		<do action="vActivity.Overview" />
	</fuseaction>
	
	<fuseaction name="PubPrereqs">
		<do action="mActivity.TabControl" />
							
		
        
		<set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Publish|Activity.Publish?ActivityID=#Attributes.ActivityID#,Prerequisites|Activity.PubPrereqs?ActivityID=#Attributes.ActivityID#" />
		<do action="mPage.ParseCrumbs" />
		
		<do action="vActivity.PubPrereqs" contentvariable="Request.MultiFormContent" />
        <do action="vActivity.PublishRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Activity" contentvariable="Request.Page.Body" />
        
        <do action="vLayout.Default" />
	</fuseaction>
    
    <fuseaction name="PubPrereqsAHAH">
    	<do action="mActivity.getPrereqs" />
    	<do action="vActivity.PubPrereqsAHAH" />
    </fuseaction>
	
	<fuseaction name="Publish">
		<do action="mActivity.TabControl" />
							
		
        
		<set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Publish|Activity.Publish?ActivityID=#Attributes.ActivityID#" />
		<do action="mPage.ParseCrumbs" />
		
		<do action="vActivity.Publish" contentvariable="Request.MultiFormContent" />
        <do action="vActivity.PublishRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Activity" contentvariable="Request.Page.Body" />
        
        <do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="PubGeneral">
		<do action="mActivity.TabControl" />
		<do action="mActivity.getPubGeneral" />
		
		<set name="Attributes.ThisUpdated" value="#ActivityPubGeneral.getUpdated()#" />
		
        
		<set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Publish|Activity.Publish?ActivityID=#Attributes.ActivityID#,General|Activity.PubGeneral?ActivityID=#Attributes.ActivityID#" />
		<do action="mPage.ParseCrumbs" />
		
		<do action="vActivity.PubGeneral" contentvariable="Request.MultiFormContent" />
        <do action="vActivity.PubGeneralRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Activity" contentvariable="Request.Page.Body" />
        
        <do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="PubComponents">
		<do action="mActivity.getPubComponents" />
		<do action="vActivity.PubComponents" />
	</fuseaction>
	
	<fuseaction name="PubSites">
		<do action="mActivity.TabControl" />
        <do action="mActivity.getActivityPubSites" />
		
		
        
		<set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Publish|Activity.Publish?ActivityID=#Attributes.ActivityID#,Sites|Activity.PubSites?ActivityID=#Attributes.ActivityID#" />
		<do action="mPage.ParseCrumbs" />
		
		<do action="vActivity.PubSites" contentvariable="Request.MultiFormContent" />
        <do action="vActivity.PubSitesRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Activity" contentvariable="Request.Page.Body" />
        
        <do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="PubSpecialty">
		<do action="mActivity.TabControl" />
		
		
        
		<set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Publish|Activity.Publish?ActivityID=#Attributes.ActivityID#,Specialties|Activity.PubSpecialty?ActivityID=#Attributes.ActivityID#" />
		<do action="mPage.ParseCrumbs" />
		
		<do action="vActivity.PubSpecialty" contentvariable="Request.MultiFormContent" />
        <do action="vActivity.PubSpecialtyRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Activity" contentvariable="Request.Page.Body" />
        
        <do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="PubSpecialtyAHAH">
        <do action="mActivity.getSpecialties" />
        <do action="mActivity.getActivitySpecialties" />
		<do action="vActivity.PubSpecialtyAHAH" />
	</fuseaction>
	
	<fuseaction name="PublishBar">
    	<do action="mActivity.getActivity" />
		<do action="mActivity.getPubGeneral" />
    	<do action="mActivity.getPublishInfo" />
		<do action="vActivity.PublishBar" />
	</fuseaction>
	
	<fuseaction name="PubCategory">
		<do action="mActivity.TabControl" />
		
		
        
		<set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Publish|Activity.Publish?ActivityID=#Attributes.ActivityID#,Categories|Activity.PubCategory?ActivityID=#Attributes.ActivityID#" />
		<do action="mPage.ParseCrumbs" />
		
		<do action="vActivity.PubCategory" contentvariable="Request.MultiFormContent" />
        <do action="vActivity.PubCategoryRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Activity" contentvariable="Request.Page.Body" />
        
        <do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="PubCategoryAHAH">
        <do action="mActivity.getCategories" />
        <do action="mActivity.getActivityCategories" />
		<do action="vActivity.PubCategoryAHAH" />
	</fuseaction>
	
	<fuseaction name="PubBuilder">
		<do action="mActivity.getComponents" />
		<do action="mActivity.TabControl" />

		
        
		<set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Publish|Activity.Publish?ActivityID=#Attributes.ActivityID#,Builder|Activity.PubBuilder?ActivityID=#Attributes.ActivityID#" />
		<do action="mPage.ParseCrumbs" />
		
		<do action="vActivity.PubBuilder" contentvariable="Request.MultiFormContent" />
        <do action="vActivity.PubBuilderRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Activity" contentvariable="Request.Page.Body" />
        
        <do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="Reports">
		<do action="mActivity.TabControl" />
		
		
        
		<set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Reports|Activity.Reports" />
		<do action="mPage.ParseCrumbs" />
		
		<set name="Request.MultiFormTitle" value="Needs Assessment" />
		
		<do action="vActivity.Reports" contentvariable="Request.MultiFormContent" />
		<do action="vActivity.ReportsRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Activity" contentvariable="Request.Page.Body" />
        
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="BuilderFileUploader">
		<do action="mFile.getFileInfo" />
		<do action="vActivity.BuilderFileUploader" />
	</fuseaction>
	
	<fuseaction name="BuilderTX">
		<do action="mActivity.getPubComponent" />
		<do action="vActivity.BuilderTX" />
	</fuseaction>
	
	<fuseaction name="BuilderASEV">
		<do action="mActivity.getPubComponent" />
        <do action="mAssessment.getAssessTmpl" />
		<do action="mAssessment.getDetail" />
		<do action="vActivity.BuilderASEV" />
	</fuseaction>
	
	<fuseaction name="BuilderQ">
		<do action="mAssessment.getQuestion" />
		<do action="mAssessment.getDetail" />
		<do action="vActivity.BuilderQ" />
	</fuseaction>
	
	<fuseaction name="BuilderQList">
		<do action="mAssessment.getQuestions" />
		<do action="mAssessment.getDetail" />
		<do action="vActivity.BuilderQList" />
	</fuseaction>
	
	<fuseaction name="BuilderASPR">
		<do action="mActivity.getPubComponent" />
        <do action="mAssessment.getAssessTmpl" />
		<do action="mAssessment.getDetail" />
		<do action="vActivity.BuilderASPR" />
	</fuseaction>
	
	<fuseaction name="BuilderASPO">
		<do action="mActivity.getPubComponent" />
        <do action="mAssessment.getAssessTmpl" />
		<do action="mAssessment.getDetail" />
		<do action="vActivity.BuilderASPO" />
	</fuseaction>
	
	<fuseaction name="BuilderAUD">
		<do action="mActivity.getPubComponent" />
		<do action="vActivity.BuilderAUD" />
	</fuseaction>
	
	<fuseaction name="BuilderFD">
		<do action="mActivity.getPubComponent" />
		<do action="vActivity.BuilderFD" />
	</fuseaction>
	
	<fuseaction name="BuilderFV">
		<do action="mActivity.getPubComponent" />
		<do action="vActivity.BuilderFV" />
	</fuseaction>
	
	<fuseaction name="BuilderHD1">
		<do action="mActivity.getPubComponent" />
		<do action="vActivity.BuilderHD1" />
	</fuseaction>
	
	<fuseaction name="BuilderHD2">
		<do action="mActivity.getPubComponent" />
		<do action="vActivity.BuilderHD2" />
	</fuseaction>
	
	<fuseaction name="BuilderHD3">
		<do action="mActivity.getPubComponent" />
		<do action="vActivity.BuilderHD3" />
	</fuseaction>
	
	<fuseaction name="BuilderEC">
		<do action="mActivity.getPubComponent" />
		<do action="vActivity.BuilderEC" />
	</fuseaction>
	
	<fuseaction name="BuilderST">
		<do action="mActivity.getPubComponent" />
		<do action="vActivity.BuilderST" />
	</fuseaction>
	
	<fuseaction name="BuilderVID">
		<do action="mActivity.getPubComponent" />
		<do action="vActivity.BuilderVID" />
	</fuseaction>
	
	<fuseaction name="BuilderPAY">
		<do action="mActivity.getPubComponent" />
		<do action="vActivity.BuilderPAY" />
	</fuseaction>
	
	<fuseaction name="BuilderTA">
		<do action="mActivity.getPubComponent" />
		<do action="vActivity.BuilderTA" />
	</fuseaction>
</circuit>
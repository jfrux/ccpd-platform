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
          <do action="mActivity.TabControl" />
          <set name="Request.ActionsLimit" value="4" />
          <set name="Request.Page.Title" value="#ActivityBean.getTitle()#" />
          <set name="request.page.action" value="#listLast(attributes.fuseaction,'.')#" />
          <set name="ActivityTitleShort" value="#midLimit(Attributes.ActivityTitle,50)# // #DateFormat(ActivityBean.getStartDate(),'mm/dd/yyyy')#" />
          <do action="mActivity.getActions" />
          <set name="Request.MultiFormEditLink" value="#myself#Activity.Detail?ActivityID=#Attributes.ActivityID#" />
        </true>
      </if>
    </prefuseaction>
    <postfuseaction>
      <if condition="#structKeyExists(attributes,'activityid')# AND attributes.activityID GT 0">
        <true>
          <do action="mActivity.getActivity" />
        </true>
      </if>
      <if condition="isPjax()">
        <true>
          <if condition="#structKeyExists(attributes,'activityid')# AND attributes.activityID GT 0">
            <true>
              <if condition="#request.currentTab.hasToolbar#">
                <true>
                  <invoke object="myFusebox" 
                          methodcall="do('vActivity.#request.page.action#right','multiformright')" />
                </true>
              </if>
              <invoke object="myFusebox" 
                      methodcall="do('vActivity.#request.page.action#','multiformcontent')" />
            </true>
          </if>
          <do action="vLayout.Blank" />
        </true>
         <false>
            <if condition="isAjax()">
              <true>
                <do action="vLayout.Blank" />
              </true>
              <false>
                  <if condition="#structKeyExists(attributes,'activityid')# AND attributes.activityID GT 0">
                    <true>
                      <if condition="#request.currentTab.hasToolbar#">
                        <true>
                          <invoke object="myFusebox" 
                                  methodcall="do('vActivity.#request.page.action#right','multiformright')" />
                        </true>
                      </if>
                      <invoke object="myFusebox" 
                              methodcall="do('vActivity.#request.page.action#','multiformcontent')" />
                      <do action="vLayout.Sub_Activity" contentvariable="request.page.body" />
                    </true>
                  </if>
                 
                 <do action="vLayout.Default" />
              </false>
            </if>
        </false>
      </if>
    </postfuseaction>
    <!-- AHAH pages -->
    <fuseaction name="ActivityList">
      <do action="vActivity.ActivityList" contentvariable="request.page.body" />
    </fuseaction>
    <fuseaction name="Container">
      <do action="vActivity.Container" contentvariable="request.page.body" />
    </fuseaction>
    <fuseaction name="Stats">
      <do action="vActivity.Stats" contentvariable="request.page.body" />
    </fuseaction>
    <fuseaction name="Import">
      <do action="vActivity.Import" />
    </fuseaction>


    <!-- //END AHAH pages -->
    <fuseaction name="ACCME">
      <do action="mActivity.getOther" />
    </fuseaction>

    <fuseaction name="Actions">
      <set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Actions|Activity.actions?ActivityID=#Attributes.ActivityID#" />
      <do action="mPage.ParseCrumbs" />
      <do action="mActivity.getAllActions" />

    </fuseaction>

    <fuseaction name="AdjustCredits">
      <do action="mActivity.saveAttendeeCredits" />
      <do action="mActivity.getAttendeeCredits" />
      <do action="vActivity.AdjustCredits" />
    </fuseaction>

  <fuseaction name="Agenda">
   
	</fuseaction>

	<fuseaction name="EmailLogs">
		<do action="mActivity.TabControl" />
							
		<set name="Request.Page.Title" value="#ActivityTitleShort#" />
        
		<set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Other|Activity.Other?ActivityID=#Attributes.ActivityID#,Email Logs|Activity.EmailLogs?ActivityID=#Attributes.ActivityID#" />
		<do action="mPage.ParseCrumbs" />
		<do action="mActivity.getEmailLogs" />
		<do action="vActivity.EmailLogs" contentvariable="Request.MultiFormContent" />
    <do action="vActivity.EmailLogsRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Activity" contentvariable="Request.Page.Body" />
    <do action="vLayout.Default" />
	</fuseaction>

    <fuseaction name="AgendaAHAH">
      <do action="vActivity.AgendaAHAH" contentvariable="request.page.body" />
    </fuseaction>

    <fuseaction name="AgendaForm">
      <do action="mActivity.getAgendaItem" />
      <do action="vActivity.AgendaForm" contentvariable="Request.Page.Body" />
    </fuseaction>

    <fuseaction name="Application">
      <do action="mActivity.getApplication" />
      <set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Other|Activity.Other?ActivityID=#Attributes.ActivityID#,Application|Activity.Application?ActivityID=#Attributes.ActivityID#" />
      <do action="mPage.ParseCrumbs" />
    </fuseaction>
    <fuseaction name="Assessment">
      <do action="mActivity.getAssessments" />
      <do action="mActivity.getAssessResult" />
      <do action="vActivity.Assessment" />
    </fuseaction>
    <fuseaction name="Assessments">
      <do action="mActivity.getAssessments" />
      <set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Assessments|Activity.Assessments?ActivityID=#Attributes.ActivityID#" />
      <do action="mPage.ParseCrumbs" />
      <set name="Request.MultiFormTitle" value="Assessments" />

      
    </fuseaction>
    <fuseaction name="AssessmentsAHAH">
      <do action="mActivity.getAssessments" />
      <do action="vActivity.AssessmentsAHAH" contentvariable="request.page.body" />
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
      <do action="vActivity.AttendeeDetailAHAH" contentvariable="request.page.body" />
    </fuseaction>

    <fuseaction name="Attendees">
      <do action="mActivity.getAttendees" />
      <do action="mActivity.getCredits" />
      <do action="mActivity.getAttendeeStatuses" />
      
      <set name="Request.Page.Breadcrumbs" 
           value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Attendees|Activity.Attendees?ActivityID=#Attributes.ActivityID#" />
      
      <do action="mPage.ParseCrumbs" />
      
      <set name="Request.MultiFormTitle" value="Needs Assessment" />


          
    </fuseaction>
    <fuseaction name="AttendeesAHAH">
      <do action="mActivity.getAttendees" />
      <do action="mActivity.getCredits" />
      <do action="vActivity.AttendeesAHAH" contentvariable="request.page.body" />
    </fuseaction>
    <fuseaction name="Attendees2">
      <do action="mActivity.getAttendees" />
      <do action="mActivity.getCredits" />
      <do action="mActivity.getAttendeeStatuses" />
      <set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Attendees|Activity.Attendees?ActivityID=#Attributes.ActivityID#" />
      <do action="mPage.ParseCrumbs" />
      <set name="Request.MultiFormTitle" value="Needs Assessment" />
      
    </fuseaction>
    <fuseaction name="Attendees2AHAH">
      <do action="mActivity.getAttendees" />
      <do action="mActivity.getCredits" />
      <do action="vActivity.Attendees2AHAH" contentvariable="request.page.body" />
    </fuseaction>
    <fuseaction name="CDCInfo">
      <do action="mActivity.saveCDCInfo" />
      <do action="mActivity.getCDCInfo" />
      <set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Other|Activity.Other?ActivityID=#Attributes.ActivityID#,CDC Info|Activity.CDCInfo?ActivityID=#Attributes.ActivityID#" />
      <do action="mPage.ParseCrumbs" />
      
    </fuseaction>
    <fuseaction name="Committee">
      <do action="mActivity.getRoles" />
      <do action="mActivity.getActivityCommittee" />
      <set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Committee|Activity.Committee?ActivityID=#Attributes.ActivityID#" />
      <do action="mPage.ParseCrumbs" />
      <set name="Request.MultiFormTitle" value="Planning Committee Members" />
      
    </fuseaction>
    <fuseaction name="CommitteeAHAH">
      <do action="mActivity.getActivityCommittee" />
      <do action="vActivity.CommitteeAHAH" contentvariable="request.page.body" />
    </fuseaction>
    <fuseaction name="Create">
      <do action="mActivity.getActivityTypes" />
      <do action="mActivity.getLiveGroupings" />
      <do action="mActivity.getEMGroupings" />
      <do action="mActivity.createActivity" />
      <set name="Request.Page.Title" value="Create Activity" />
      <set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,Unsaved Activity|Activity.Create" />
      <do action="mPage.ParseCrumbs" />
      <do action="vLayout.Sub_MultiForm" contentvariable="Request.Page.Body" />
      
    </fuseaction>
    <fuseaction name="Credits">
      <do action="mActivity.saveCredits" />
      <do action="mActivity.getCredits" />
      <set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Credits|Activity.Credits?ActivityID=#Attributes.ActivityID#" />
      <do action="mPage.ParseCrumbs" />
      <set name="Request.MultiFormTitle" value="Credit &amp; Points" />
      
    </fuseaction>
    <fuseaction name="Detail">
      <set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#" />
      <do action="mPage.ParseCrumbs" />
    </fuseaction>
    <fuseaction name="Docs">
      <do action="mActivity.getDocTypes" />
      <do action="mActivity.getDocs" />
      <set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Documents|Activity.Docs?ActivityID=#Attributes.ActivityID#" />
      <do action="mPage.ParseCrumbs" />
      <set name="Request.MultiFormTitle" value="Documents &amp; Materials" />
      
    </fuseaction>
    <fuseaction name="DocsAHAH">
      <do action="mActivity.getDocs" />
      <do action="vActivity.DocsAHAH" contentvariable="request.page.body" />
    </fuseaction>

    <fuseaction name="EditCurrSupport">
      <do action="mActivity.getSupportTypes" />
      <do action="mActivity.saveCurrSupport" />
      <do action="mActivity.getCurrSupport" />
      <do action="mActivity.getSupporter" />
      <do action="vActivity.EditCurrSupport" contentvariable="Request.Page.Body" />
    </fuseaction>

    <fuseaction name="EditSupporter">
      <do action="mActivity.saveSupporter" />
      <do action="mActivity.getSupporter" />
      <do action="vActivity.EditSupporter" contentvariable="Request.Page.Body" />
    </fuseaction>

    <fuseaction name="emailCert">
      <do action="vActivity.emailCert" contentvariable="Request.Page.Body" />
      <do action="vLayout.None" />
    </fuseaction>
    <fuseaction name="Faculty">
      <do action="mActivity.getRoles" />
      <set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Faculty|Activity.Faculty?ActivityID=#Attributes.ActivityID#" />
      <do action="mPage.ParseCrumbs" />
      <set name="Request.MultiFormTitle" value="Faculty" />
      
    </fuseaction>
    <fuseaction name="FacultyAHAH">
      <do action="mActivity.getActivityFaculty" />
      <do action="vActivity.FacultyAHAH" contentvariable="request.page.body" />
    </fuseaction>
    <fuseaction name="FileUpload">
      <do action="mActivity.getDocTypes" />
      <do action="mActivity.FileUpload" />
      <do action="vActivity.FileUpload" />
    </fuseaction>
    <fuseaction name="Finances">
      <do action="mActivity.getFinOverview" />
      <set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Finances|Activity.Finances?ActivityID=#Attributes.ActivityID#" />
      <do action="mPage.ParseCrumbs" />
      <set name="Request.MultiFormTitle" value="Finances" />
      
    </fuseaction>
    <fuseaction name="FinBudget">
      <do action="mActivity.saveFinBudget" />
      <set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Finances|Activity.Finances?ActivityID=#Attributes.ActivityID#,Budget|Activity.FinBudget?ActivityID=#Attributes.ActivityID#" />
      <do action="mPage.ParseCrumbs" />
      <set name="Request.MultiFormTitle" value="Finances" />
      
    </fuseaction>
    <fuseaction name="FinBudgetAHAH">
      <do action="mActivity.getEntryTypes" />
      <do action="mActivity.getFinBudgets" />
      <do action="vActivity.FinBudgetAHAH" contentvariable="request.page.body" />
    </fuseaction>

    <fuseaction name="FinFees">
      <set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Finances|Activity.Finances?ActivityID=#Attributes.ActivityID#,Fees|Activity.FinFees?ActivityID=#Attributes.ActivityID#" />
      <do action="mPage.ParseCrumbs" />
      <set name="Request.MultiFormTitle" value="Finances" />
    </fuseaction>

    <fuseaction name="FinFeesAHAH">
      <do action="mActivity.getFinFees" />
      <do action="mActivity.getFinFee" />
      <do action="vActivity.FinFeesAHAH" contentvariable="request.page.body" />
    </fuseaction>
    <fuseaction name="FinLedger">
      <set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Finances|Activity.Finances?ActivityID=#Attributes.ActivityID#,General Ledger|Activity.FinLedger?ActivityID=#Attributes.ActivityID#" />
      <do action="mPage.ParseCrumbs" />
      <set name="Request.MultiFormTitle" value="Finances" />
      
    </fuseaction>
    <fuseaction name="FinLedgerAHAH">
      <do action="mActivity.getEntryTypes" />
      <do action="mActivity.getFinLedgers" />
      <do action="vActivity.FinLedgerAHAH" contentvariable="request.page.body" />
    </fuseaction>
    <fuseaction name="FinSupport">
      <do action="mActivity.getFinSupporters" />
      <do action="mActivity.getSupporters" />
      <do action="mActivity.getSupportTypes" />
      <set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Finances|Activity.Finances?ActivityID=#Attributes.ActivityID#,Supporters|Activity.FinSupport?ActivityID=#Attributes.ActivityID#" />
      <do action="mPage.ParseCrumbs" />
      <set name="Request.MultiFormTitle" value="Finances" />
      
    </fuseaction>
    <fuseaction name="FinSupportAHAH">
      <do action="mActivity.getFinSupporters" />
      <do action="vActivity.FinSupportAHAH" contentvariable="request.page.body" />
    </fuseaction>
    <fuseaction name="History">
      <set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Credits|Activity.Credits?ActivityID=#Attributes.ActivityID#" />
      <do action="mPage.ParseCrumbs" />
      <set name="Request.MultiFormTitle" value="History" />
      
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
      
    </fuseaction>
    <fuseaction name="home2">
      <set name="Request.Page.Title" value="Activities" />
      <set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home" />
      <do action="mPage.ParseCrumbs" />
      <do action="vActivity.Home" contentvariable="Request.Page.Body" />
      
    </fuseaction>
    <fuseaction name="Meals">
      <set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Other|Activity.Other?ActivityID=#Attributes.ActivityID#,Meals|Activity.Meals?ActivityID=#Attributes.ActivityID#" />
      <do action="mPage.ParseCrumbs" />
      
    </fuseaction>
    <fuseaction name="NoteCreate">
      <do action="mActivity.saveNote" />
      <set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Notes|Activity.Notes?ActivityID=#Attributes.ActivityID#,New Note|Activity.CreateNote+ActivitiesectionID=2" />
      <do action="mPage.ParseCrumbs" />
      <set name="Request.MultiFormTitle" value="Create A Activity Note" />
      <do action="vLayout.Sub_MultiForm" contentvariable="Request.Page.Body" />
      
    </fuseaction>
    <fuseaction name="NoteDelete">
      <do action="mActivity.deleteNote" />
    </fuseaction>
    <fuseaction name="Notes">
      <do action="mActivity.getNotes" />
      <set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Notes|Activity.Notes?ActivityID=#Attributes.ActivityID#" />
      <do action="mPage.ParseCrumbs" />
      <set name="Request.MultiFormTitle" value="Notes" />
      
    </fuseaction>
    <fuseaction name="Other">
      <set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Other|Activity.Other?ActivityID=#Attributes.ActivityID#" />
      <do action="mPage.ParseCrumbs" />
      
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
      <set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Publish|Activity.Publish?ActivityID=#Attributes.ActivityID#,Prerequisites|Activity.PubPrereqs?ActivityID=#Attributes.ActivityID#" />
      <do action="mPage.ParseCrumbs" />
      
    </fuseaction>
    <fuseaction name="PubPrereqsAHAH">
      <do action="mActivity.getPrereqs" />
      <do action="vActivity.PubPrereqsAHAH" contentvariable="request.page.body" />
    </fuseaction>
    <fuseaction name="Publish">
      <set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Publish|Activity.Publish?ActivityID=#Attributes.ActivityID#" />
      <do action="mPage.ParseCrumbs" />
      
    </fuseaction>
    <fuseaction name="PubGeneral">
      <do action="mActivity.getPubGeneral" />
      <set name="Attributes.ThisUpdated" value="#ActivityPubGeneral.getUpdated()#" />
      <set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Publish|Activity.Publish?ActivityID=#Attributes.ActivityID#,General|Activity.PubGeneral?ActivityID=#Attributes.ActivityID#" />
      <do action="mPage.ParseCrumbs" />
      
    </fuseaction>
    <fuseaction name="PubComponents">
      <do action="mActivity.getPubComponents" />
      <do action="vActivity.PubComponents" />
    </fuseaction>
    <fuseaction name="PubSites">
      <do action="mActivity.getActivityPubSites" />
      <set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Publish|Activity.Publish?ActivityID=#Attributes.ActivityID#,Sites|Activity.PubSites?ActivityID=#Attributes.ActivityID#" />
      <do action="mPage.ParseCrumbs" />
    </fuseaction>
    <fuseaction name="PubSpecialty">
      <set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Publish|Activity.Publish?ActivityID=#Attributes.ActivityID#,Specialties|Activity.PubSpecialty?ActivityID=#Attributes.ActivityID#" />
      <do action="mPage.ParseCrumbs" />
      
    </fuseaction>
    <fuseaction name="PubSpecialtyAHAH">
      <do action="mActivity.getSpecialties" />
      <do action="mActivity.getActivitySpecialties" />
      <do action="vActivity.PubSpecialtyAHAH" contentvariable="request.page.body" />
    </fuseaction>
    <fuseaction name="PublishBar">
      <do action="mActivity.getActivity" />
      <do action="mActivity.getPubGeneral" />
      <do action="mActivity.getPublishInfo" />
      <do action="vActivity.PublishBar" />
    </fuseaction>
    <fuseaction name="PubCategory">
      <set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Publish|Activity.Publish?ActivityID=#Attributes.ActivityID#,Categories|Activity.PubCategory?ActivityID=#Attributes.ActivityID#" />
      <do action="mPage.ParseCrumbs" />
      
    </fuseaction>
    <fuseaction name="PubCategoryAHAH">
      <do action="mActivity.getCategories" />
      <do action="mActivity.getActivityCategories" />
      <do action="vActivity.PubCategoryAHAH" contentvariable="request.page.body" />
    </fuseaction>
    <fuseaction name="PubBuilder">
      <do action="mActivity.getComponents" />
      <set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Publish|Activity.Publish?ActivityID=#Attributes.ActivityID#,Builder|Activity.PubBuilder?ActivityID=#Attributes.ActivityID#" />
      <do action="mPage.ParseCrumbs" />
      
    </fuseaction>
    <fuseaction name="Reports">
      <set name="Request.Page.Breadcrumbs" value="Activities|Activity.Home,#ActivityTitleShort#|Activity.Detail?ActivityID=#Attributes.ActivityID#,Reports|Activity.Reports" />
      <do action="mPage.ParseCrumbs" />
      <set name="Request.MultiFormTitle" value="Needs Assessment" />
      
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
      <do action="vActivity.BuilderQ" contentvariable="request.page.body" />
    </fuseaction>
    <fuseaction name="BuilderQList">
      <do action="mAssessment.getQuestions" />
      <do action="mAssessment.getDetail" />
      <do action="vActivity.BuilderQList" contentvariable="request.page.body" />
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

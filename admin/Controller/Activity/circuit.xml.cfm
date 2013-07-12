<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
  <!-- Activity -->
  <circuit access="public">
    <prefuseaction callsuper="true">
      <set name="Request.NavItem" value="2" /><if condition="isDefined('Attributes.ActivityID')">
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
          <set name="Request.editlink" value="#myself#Activity.Detail?ActivityID=#Attributes.ActivityID#" />
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
              <invoke object="myFusebox" 
                    methodcall="do('vActivity.#params.action#','multiformcontent')" />
              <if condition="#request.currentTab.hasToolbar#">
                <true>
                  <invoke object="myFusebox" 
                          methodcall="do('vActivity.#params.action#right','multiformright')" />
                </true>
              </if>
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
                      <do action="vLayout.Hub" contentvariable="request.page.body" />
                    </true>
                    <false>
                      <if condition="NOT structKeyExists(attributes,'activityid') OR (structKeyExists(attributes,'activityid') AND attributes.activityID LTE 0)">
                        <true>
                          <invoke object="myFusebox" 
                            methodcall="do('vActivity.#params.action#','multiformcontent')" />
                          <do action="vLayout.sub_slim" contentvariable="request.page.body" />
                        </true>
                      </if>
                    </false>
                  </if>
                 
                 <do action="vLayout.Application" />
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
        
		
		<do action="mActivity.getEmailLogs" />
		<do action="vActivity.EmailLogs" contentvariable="Request.MultiFormContent" />
    <do action="vActivity.EmailLogsRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_Activity" contentvariable="request.page.body" />
    <do action="vLayout.Default" />
	</fuseaction>

    <fuseaction name="AgendaAHAH">
      <do action="vActivity.AgendaAHAH" contentvariable="request.page.body" />
    </fuseaction>

    <fuseaction name="AgendaForm">
      <do action="mActivity.getAgendaItem" />
      <do action="vActivity.AgendaForm" contentvariable="request.page.body" />
    </fuseaction>

    <fuseaction name="Application">
      <do action="mActivity.getApplication" />
      
    </fuseaction>
    <fuseaction name="Assessment">
      <do action="mActivity.getAssessments" />
      <do action="mActivity.getAssessResult" />
      <do action="vActivity.Assessment" />
    </fuseaction>

    <fuseaction name="Assessments">
      <do action="mActivity.getAssessments" />
      <set name="title" value="Assessments" />
    </fuseaction>

    <fuseaction name="AssessmentsAHAH">
      <do action="mActivity.getAssessments" />
      <do action="vActivity.AssessmentsAHAH" contentvariable="request.page.body" />
    </fuseaction>

    <fuseaction name="AttendeeCDC">
      <do action="mPerson.getPerson" />
      <do action="mActivity.getAttendeeCDC" />
      <do action="mActivity.saveAttendeeCDC" />
      <set name="title" value="Needs Assessment" />
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
      <set name="title" value="Needs Assessment" /> 
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
      <set name="title" value="Needs Assessment" />
    </fuseaction>
    
    <fuseaction name="Attendees2AHAH">
      <do action="mActivity.getAttendees" />
      <do action="mActivity.getCredits" />
      <do action="vActivity.Attendees2AHAH" contentvariable="request.page.body" />
    </fuseaction>
    
    <fuseaction name="CDCInfo">
      <do action="mActivity.saveCDCInfo" />
      <do action="mActivity.getCDCInfo" />
    </fuseaction>
    
    <fuseaction name="Committee">
      <do action="mActivity.getRoles" />
      <do action="mActivity.getActivityCommittee" />
      <set name="title" value="Planning Committee Members" />
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
    </fuseaction>
    <fuseaction name="Credits">
      <do action="mActivity.saveCredits" />
      <do action="mActivity.getCredits" />
      
      <set name="title" value="Credit &amp; Points" />
      
    </fuseaction>

    <fuseaction name="Detail">
      
    </fuseaction>

    <fuseaction name="Docs">
      <do action="mActivity.getDocTypes" />
      <do action="mActivity.getDocs" />
      <set name="title" value="Documents &amp; Materials" />
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
      <do action="vActivity.EditCurrSupport" contentvariable="request.page.body" />
    </fuseaction>

    <fuseaction name="EditSupporter">
      <do action="mActivity.saveSupporter" />
      <do action="mActivity.getSupporter" />
      <do action="vActivity.EditSupporter" contentvariable="request.page.body" />
    </fuseaction>

    <fuseaction name="emailCert">
      <do action="vActivity.emailCert" contentvariable="request.page.body" />
      <do action="vLayout.None" />
    </fuseaction>

    <fuseaction name="Faculty">
      <do action="mActivity.getRoles" />
      <set name="title" value="Faculty" />
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
      <set name="title" value="Finances" />
    </fuseaction>
    <fuseaction name="FinBudget">
      <do action="mActivity.saveFinBudget" />
      
      <set name="title" value="Finances" />
      
    </fuseaction>

    <fuseaction name="FinBudgetAHAH">
      <do action="mActivity.getEntryTypes" />
      <do action="mActivity.getFinBudgets" />
      <do action="vActivity.FinBudgetAHAH" contentvariable="request.page.body" />
    </fuseaction>

    <fuseaction name="FinFees">
      <set name="title" value="Finances" />
    </fuseaction>

    <fuseaction name="FinFeesAHAH">
      <do action="mActivity.getFinFees" />
      <do action="mActivity.getFinFee" />
      <do action="vActivity.FinFeesAHAH" contentvariable="request.page.body" />
    </fuseaction>
    <fuseaction name="FinLedger"><set name="title" value="Finances" />
      
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
      <set name="title" value="Finances" />
    </fuseaction>

    <fuseaction name="FinSupportAHAH">
      <do action="mActivity.getFinSupporters" />
      <do action="vActivity.FinSupportAHAH" contentvariable="request.page.body" />
    </fuseaction>

    <fuseaction name="History">
      <set name="title" value="History" />
    </fuseaction>

    
    <fuseaction name="NoteCreate">
      <do action="mActivity.saveNote" />
      <set name="title" value="Create A Activity Note" />
      <do action="vLayout.Sub_MultiForm" contentvariable="request.page.body" />
      
    </fuseaction>

    <fuseaction name="NoteDelete">
      <do action="mActivity.deleteNote" />
    </fuseaction>

    <fuseaction name="Notes">
      <do action="mActivity.getNotes" />
      <set name="title" value="Notes" />
      
    </fuseaction>

    <fuseaction name="Other">

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
  
    <fuseaction name="PhotoUpload">
      <do action="vActivity.PhotoUpload" contentvariable="Request.Page.Body" />
    </fuseaction>

    <fuseaction name="PubPrereqs">
    </fuseaction>
    <fuseaction name="PubPrereqsAHAH">
      <do action="mActivity.getPrereqs" />
      <do action="vActivity.PubPrereqsAHAH" contentvariable="request.page.body" />
    </fuseaction>
    <fuseaction name="Publish">
    </fuseaction>
    
    <fuseaction name="PubGeneral">
      <do action="mActivity.getPubGeneral" />
      <set name="Attributes.ThisUpdated" value="#ActivityPubGeneral.getUpdated()#" />
      
    </fuseaction>

    <fuseaction name="PubComponents">
      <do action="mActivity.getPubComponents" />
      <do action="vActivity.PubComponents" />
    </fuseaction>
    <fuseaction name="PubSites">
      <do action="mActivity.getActivityPubSites" />
      
    </fuseaction>
    <fuseaction name="PubSpecialty">
      <do action="mActivity.getSpecialties" />
      <do action="mActivity.getActivitySpecialties" />
    </fuseaction>
    
    <fuseaction name="PublishBar">
      <do action="mActivity.getActivity" />
      <do action="mActivity.getPubGeneral" />
      <do action="mActivity.getPublishInfo" />
      <do action="vActivity.PublishBar" />
    </fuseaction>
    <fuseaction name="PubCategory">
      <do action="mActivity.getCategories" />
      <do action="mActivity.getActivityCategories" />
    </fuseaction>
    
    <fuseaction name="PubBuilder">
      <do action="mActivity.getComponents" />
    </fuseaction>
    <fuseaction name="Reports"><set name="title" value="Needs Assessment" />
      
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

<cfparam name="Attributes.ActivityID" default="" />
<cfparam name="Attributes.ExclusionList" default=0 />
<cfparam name="PretestStatus" default="1" />
<cfparam name="PretestExists" default="false" />
<cfparam name="PostTestStatus" default="1" />
<cfparam name="PostTestExists" default="false" />
<cfparam name="Session.PersonID" default="" />

<cfset qAssessments = Application.Com.ActivityPubComponentGateway.getByViewAttributesLMS(ComponentIDin="11,12,5",ActivityID=Attributes.ActivityID,DeletedFlag="N",OrderBy="apc.ComponentID DESC")>

<!--- CHECK IF USER IS LOGGED IN --->
<cfif Session.PersonID GT 0>
	<!--- CHECK IF THERE IS A PRETEST --->
    <cfquery name="qGetPretest" dbtype="query">
        SELECT AssessmentID
        FROM qAssessments
        WHERE ComponentID = 12 AND DeletedFlag = 'N'
    </cfquery>
    
	<!--- CHECK IF A PRETEST WAS FOUND --->
	<cfif qGetPretest.RecordCount GT 0>
    	<!--- CHECK IF A PRETEST RESULT IS FOUND --->
    	<cfset PretestBean = CreateObject("component","#Application.Settings.Com#AssessResult.AssessResult").Init(AssessmentID=qGetPretest.AssessmentID,PersonID=Session.PersonID,DeletedFlag="N")>
        <cfset PretestResultExists = Application.Com.AssessResultDAO.Exists(PretestBean)>
        <cfset PretestExists = true>
        <cfif PretestResultExists>
			<cfset PretestBean = Application.Com.AssessResultDAO.Read(PretestBean)>
	        
            <!--- SET PRETESTSTATUS --->
            <cfset PretestStatus = PretestBean.getResultStatusID()>
        <cfelse>
        	<cfset PretestStatus = 3>
        </cfif>
    </cfif>
    
	<!--- CHECK IF THERE IS A POST TEST --->
    <cfquery name="qGetPosttest" dbtype="query">
        SELECT AssessmentID
        FROM qAssessments
        WHERE ComponentID = 11 AND DeletedFlag = 'N'
    </cfquery>
    
    <!--- CHECK IF A POST TEST WAS FOUND --->
    <cfif qGetPostTest.RecordCount GT 0>
        <!--- GET ASSESSMENT INFO --->
        <cfset AssessBean = CreateObject("component","#Application.Settings.Com#Assessment.Assessment").Init(AssessmentID=qGetPostTest.AssessmentID)>
        <!--- CHECK IF ASSESSMENT EXISTS --->
		<cfset AssessExists = Application.Com.AssessmentDAO.Exists(AssessBean)>
        <cfset PostTestExists = true>
        <cfif AssessExists>
			<cfset AssessBean = Application.Com.AssessmentDAO.Read(AssessBean)>
            
            <!--- GET ASSESSRESULT INFO --->
            <cfset PostTestBean = CreateObject("component","#Application.Settings.Com#AssessResult.AssessResult").Init(AssessmentID=qGetPostTest.AssessmentID,PersonID=Session.PersonID,DeletedFlag="N")>
            <cfset PostTestResultExists = Application.Com.AssessResultDAO.Exists(PostTestBean)>
            
            <cfif AssessBean.getRequiredFlag() EQ "Y">
                <cfif PostTestResultExists>
                    <cfset PostTestBean = Application.Com.AssessResultDAO.readPosttest(PostTestBean)>
                    
                    <!--- SET PRETESTSTATUS --->
                    <cfset PostTestStatus = PostTestBean.getResultStatusID()>
                <cfelse>
                    <cfset PostTestStatus = 3>
                </cfif>
            </cfif>
        <cfelse>
        	<cfset PostTestStatus = 3>
        </cfif>
    </cfif>
</cfif>
<cfparam name="Attributes.Title" default="">
<cfparam name="Attributes.ActivityID" default="0">
<cfparam name="Attributes.ActivityType" default="1">
<cfparam name="Attributes.StartDate" default="">
<cfparam name="Attributes.StartTime" default="">
<cfparam name="Attributes.EndDate" default="">
<cfparam name="Attributes.EndTime" default="">
<cfparam name="Attributes.Description" default="">
<cfparam name="Attributes.Location" default="">
<cfparam name="Attributes.Address1" default="">
<cfparam name="Attributes.Address2" default="">
<cfparam name="Attributes.City" default="">
<cfparam name="Attributes.State" default="">
<cfparam name="Attributes.Province" default="">
<cfparam name="Attributes.Country" default="230">
<cfparam name="Attributes.PostalCode" default="">
<cfparam name="Attributes.Sessions" default="1">
<cfparam name="Attributes.SessionType" default="S">
<cfparam name="Attributes.Sponsor" default="">
<cfparam name="Attributes.Sponsorship" default="D">
<cfparam name="Attributes.ExternalID" default="">
<cfparam name="Attributes.ReleaseDate" default="#DateFormat(Now(),"MM/DD/YYYY")#">
<cfparam name="Attributes.UpdatedBy" default="">

<cfset qLiveGroupings = Application.Com.GroupingGateway.getByAttributes(ActivityTypeID=1)>
<cfset qEMGroupings = Application.Com.GroupingGateway.getByAttributes(ActivityTypeID=2)>

<cfinclude template="#Application.Settings.RootPath#/View/Includes/SaveJS.cfm" />
<script>
<cfoutput>
var LiveOptions = <cfloop query="qLiveGroupings">"<option value=\"#qLiveGroupings.GroupingID#\">#qLiveGroupings.Name#</option>"<cfif qLiveGroupings.RecordCount NEQ qLiveGroupings.CurrentRow> + </cfif></cfloop>;
var EMOptions = <cfloop query="qEMGroupings">"<option value=\"#qEMGroupings.GroupingID#\">#qEMGroupings.Name#</option>"<cfif qEMGroupings.RecordCount NEQ qEMGroupings.CurrentRow> + </cfif></cfloop>;
var nActivityType = #Attributes.ActivityTypeID#;
var nGrouping = #Attributes.GroupingID#;
var sSessionType = "#Attributes.SessionType#";
var nCountryId = #attributes.country#
</cfoutput>


App.module("Activity.GeneralInfo").start();
</script>
<cfquery name="qModified" datasource="#Application.Settings.DSN#">
	SELECT     
		A.CreatedBy AS CreatedByID, 
		LEFT(P1.firstname, 1) + '. ' + P1.lastname AS CreatedByName, 
		A.UpdatedBy AS UpdatedByID, 
		LEFT(P2.firstname, 1) + '. ' + P2.lastname AS UpdatedByName
	FROM         ce_Activity AS A 
	LEFT OUTER JOIN
		ce_person AS P2 ON A.UpdatedBy = P2.personid 
	LEFT OUTER JOIN
		ce_person AS P1 ON A.CreatedBy = P1.personid
	WHERE A.ActivityID=<cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" />
</cfquery>
<cfoutput>
<div class="ViewContainer">
<div class="ViewSection">
	<form action="#Application.Settings.RootPath#/_com/AJAX_Activity.cfc" method="post" class="form-horizontal formstate js-formstate js-form-generalinfo" name="frmEditActivity">
    	<!--- ADDED Attributes.SessionType HIDDEN FIELD FOR SAVING PURPOSES [Attributes.SessionType must be passed to save StartDate/EndDate] --->
			<input type="hidden" value="saveActivity" name="Method" />
			<input type="hidden" value="plain" name="returnFormat" />
			<input type="hidden" value="#Attributes.ActivityID#" name="ActivityID" />
			<input type="hidden" value="#Attributes.SessionType#" name="SessionType" />
			<div class="control-group">
				<label class="control-label" for="Title">Title</label>
				<div class="controls">
					<textarea name="Title" rows="2" style="height:46px;" class="span23" id="Title">#HTMLSafe(Attributes.Title)#</textarea>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="ActivityType">Type</label>
				<div class="controls">
					<select name="ActivityTypeID" id="ActivityType" disabled="disabled">
						<cfloop query="qActivityTypeList">
							<option value="#qActivityTypeList.ActivityTypeID#" <cfif Attributes.ActivityTypeID EQ qActivityTYpeList.ActivityTypeID> SELECTED</cfif>>#qActivityTypeList.Name#</option>
						</cfloop>
					</select>
				</div>
			</div>
			<div class="control-group" id="Groupings">
				<label class="control-label" for="Grouping">Sub Type</label>
				<div class="controls">
					<select name="Grouping" id="Grouping" disabled="disabled"></select>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="SessionType">Session Type</label>
				<div class="controls">
					<select name="SessionType" id="SessionType" disabled="disabled">
						<option value="S"<cfif Attributes.SessionType EQ "S"> SELECTED</cfif>>Stand-alone</option>
						<option value="M"<cfif Attributes.SessionType EQ "M"> SELECTED</cfif>>Multi-session</option>
					</select>
				</div>
			</div>
			<div class="control-group" style="display:none;">
				<label class="control-label" for="ReleaseDate">Release Date</label>
				<div class="controls">
					<input type="text" name="ReleaseDate" id="ReleaseDate" value="#Attributes.ReleaseDate#" class="DatePicker" />
				</div>
			</div>
			<div class="divider"><hr></div>
			<div class="control-group sponsorship-fields">
				<label class="control-label" for="Sponsorship">Sponsorship</label>
				<div class="controls">
					<div data-toggle="buttons-radio" class="btn-group">
						<a class="btn btn-default js-sponsorship-toggle js-sponsorship-D">Directly</a>
						<a class="btn btn-default js-sponsorship-toggle js-sponsorship-J">Jointly</a>
					</div>
					<span class="hide" id="JointlyTextFld">
						<input type="text" value="#Attributes.Sponsor#" id="Sponsor" name="Sponsor">
					</span>
					<input type="text" name="Sponsorship" class="Sponsorship hide" id="Sponsorship" value="#attributes.sponsorship#" />
				</div>
			</div>
			<div class="divider"><hr></div>
			<div class="control-group date-range">
				<label class="control-label" for="StartDate">Event Dates</label>
				<div class="controls">
					<input type="text" value="#Attributes.StartDate#" placeholder="Start Date"  id="StartDate" name="StartDate" class="DatePicker span5 text-center">
					<input type="text" name="EndDate" id="EndDate" placeholder="End Date" value="#Attributes.EndDate#" class="DatePicker span5 text-center" />
				</div>
			</div>
			<div class="divider"><hr></div>
			<div class="control-group Location">
				<label class="control-label" for="Location">Location</label>
				<div class="controls">
					<input type="text" name="Location" id="Location" placeholder="Example Hotel" value="#Attributes.Location#" />
				</div>
			</div>
			<div class="control-group Location">
				<label class="control-label" for="Address1">Mailing Address</label>
				<div class="controls">
					<input type="text" name="Address1" id="Address1" placeholder="1234 Example Blvd." value="#Attributes.Address1#" />
					<input type="text" name="Address2" id="Address2" placeholder="Street Line 2" value="#Attributes.Address2#" />
				</div>
			</div>
			<div class="control-group Location">
				<label class="control-label" for="City">City</label>
				<div class="controls">
					<input type="text" name="City" id="City" placeholder="City" value="#Attributes.City#" />
				</div>
			</div>
			<div class="control-group Location stateField">
				<label class="control-label" for="State">State</label>
				<div class="controls">
				<select id="State" name="State">
					<option value="0">Select one...</option>
					<cfloop query="Application.List.States">
						<option value="#trim(Application.List.States.StateId)#"<cfif Attributes.State EQ trim(Application.List.States.StateId)> Selected</cfif>>#Name#</option>
					</cfloop>
				</select>
				</div>
			</div>
			<div class="control-group Location provinceField">
				<label class="control-label" for="Province">State / Province</label>
				<div class="controls">
				<input type="text" name="Province" id="Province" value="#Attributes.Province#" />
				</div>
			</div>
       <div class="control-group Location">
        	<label class="control-label" for="Country">Country</label>
          <div class="controls">
					<select id="Country" name="Country">
						<option value="0">Select one...</option>
						<cfloop query="Application.List.Countries">
							<option value="#trim(Application.List.Countries.CountryID)#"<cfif Attributes.Country EQ trim(Application.List.Countries.CountryID) OR Attributes.Country EQ "" AND trim(Application.List.Countries.Name) EQ "United States of America"> Selected</cfif>>#Name#</option>
						</cfloop>
					</select>
          </div>
      </div>
			<div class="control-group Location">
				<label class="control-label" for="PostalCode">Postal Code</label>
				<div class="controls">
				<input type="text" name="PostalCode" id="PostalCode" value="#Attributes.PostalCode#" />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="ExternalID">External ID</label>
				<div class="controls">
				<input type="text" name="ExternalID" id="ExternalID" value="#Attributes.ExternalID#" />
				</div>
			</div>
			<div class="control-group hide">
				Created By

					<a href="#myself#Person.Detail?PersonID=#qModified.CreatedByID#">#qModified.CreatedByName#</a> (#DateFormat(ActivityBean.getCreated(),"mm/dd/yyyy")# #TimeFormat(ActivityBean.getCreated(),"hh:mmTT")#)
			</div>
			<cfif Attributes.UpdatedBy NEQ "">
				<div class="control-group hide">
				Updated By
					
						<a href="#myself#Person.Detail?PersonID=#qModified.UpdatedByID#">#qModified.UpdatedByName#</a> (#DateFormat(ActivityBean.getUpdated(),"mm/dd/yyyy")# #TimeFormat(ActivityBean.getUpdated(),"hh:mmTT")#)
					
				</div>
			</cfif>
			<div class="divider"><hr></div>
			
				<cfinclude template="#Application.Settings.RootPath#/View/Includes/SaveInfo.cfm" />
		
  	</form>
</div>
</div>
</cfoutput>

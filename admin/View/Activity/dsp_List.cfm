<cfoutput>
<div class="clearfix headerTop">
<div class="action_bar" style="float:right;">
	<a href="#myself#activity.create?id=0" class="btn" bindpoint="root" style="text-decoration: none; float: right;"><i style="background-position: -4px -361px;" class="img"></i>
	  <span>Create Activity</span>
	</a>
</div>
<div><h1>Activities<span>Manage your activities, view history, and change subscriptions.</span></h1></div>
</div>
</cfoutput>

<div class="ContentBody">
	<div class="ViewSection">
	<h3>Find an activity <span style="font-size:13px; float:right; font-weight:normal;"><a href="<cfoutput>#myself#</cfoutput>activity.home?clear=1" style="text-decoration: none; color: rgb(255, 255, 255); font-size: 12px;" title="Clear search filter"><img src="<cfoutput>#Application.Settings.RootPath#</cfoutput>/_images/icons/delete.png" style="float: left; margin-right: 3px;" /> Clear Search</a></span></h3>
	<!---
	4/14/2010 UNUSED BELOW
	<cfquery name="qCreatedByList" datasource="#Application.Settings.DSN#">
	SELECT DISTINCT C.CreatedBy, P.lastname + ', ' + P.firstname AS Name
	FROM         ce_Activity AS C INNER JOIN
						  dbo.pd_person AS P ON C.CreatedBy = P.personid
	WHERE     (C.CreatedBy <> '')
	</cfquery>
	<cfquery name="qUpdatedByList" datasource="#Application.Settings.DSN#">
		SELECT DISTINCT C.UpdatedBy, P.lastname + ', ' + P.firstname AS Name
		FROM ce_Activity AS C 
		INNER JOIN
			dbo.pd_person AS P ON C.UpdatedBy = P.personid
		WHERE (C.UpdatedBy <> '')
	</cfquery>--->
	<script>
		<cfoutput>
		var sTitle = "#Attributes.Title#";
		</cfoutput>
		$(document).ready(function() {
			
		});
		
		<cfoutput>
		var searchSettings = {};
		searchSettings.liveOptions = "<option value=\"0\">Any Grouping</option>" + <cfloop query="qLiveGroupings">"<option value=\"#qLiveGroupings.GroupingID#\"<cfif qLiveGroupings.GroupingID EQ Attributes.GroupingID> SELECTED</cfif>>#qLiveGroupings.Name#</option>"<cfif qLiveGroupings.RecordCount NEQ qLiveGroupings.CurrentRow> + </cfif></cfloop>;
		searchSettings.EMOptions = "<option value=\"0\">Any Grouping</option>" + <cfloop query="qEMGroupings">"<option value=\"#qEMGroupings.GroupingID#\"<cfif qEMGroupings.GroupingID EQ Attributes.GroupingID> SELECTED</cfif>>#qEMGroupings.Name#</option>"<cfif qEMGroupings.RecordCount NEQ qEMGroupings.CurrentRow> + </cfif></cfloop>;
		searchSettings.NoOptions = "<option value=\"0\">Any Grouping</option>";
		</cfoutput>
		
		App.Activity.Search.start(searchSettings);
		function setActivityType(nActivity) {
			if(nActivity == 1) {
				$("#Grouping").html(LiveOptions);
				$("#Grouping").attr("disabled",false);
			} else if(nActivity == 2) {
				$("#Grouping").html(EMOptions);
				$("#Grouping").attr("disabled",false);
			} else {
				$("#Grouping").html(NoOptions);
				$("#Grouping").attr("disabled",true);
			}
		}
	</script>
	<cfoutput>
	<form name="frmSearch" method="get" action="#myself#Activity.Home">
	<fieldset class="horiz-form">
		<table width="100%" cellspacing="0" cellpadding="0" border="0">
			<tr>
				<td colspan="2" class="FieldFloater">
					<span><input type="text" name="Title" id="Title" value="#Attributes.Title#" style="width:239px;" /><label for="Title">Activity Title</label></span>
					<span id="StartDate">
						<input type="text" name="StartDate" id="ReleaseDate" value="#DateFormat(Attributes.StartDate,'MM/DD/YYYY')#" style="width:67px;" />
						<label for="StartDate">Start Date</label>
					</span>
					<span>
						<select name="ActivityTypeID" id="ActivityTypeID" style="width:131px;">
							<option value="0">Any Type</option>
							<cfloop query="qActivityTypeList">
								<option value="#qActivityTypeList.ActivityTypeID#"<cfif Attributes.ActivityTypeID EQ qActivityTypeList.ActivityTypeID> Selected</cfif>>#qActivityTypeList.Name#</option>
							</cfloop>
						</select>
						<label for="ActivityTypeID">Activity Type</label>
					 </span>
					<span id="groupings">
						<select name="GroupingID" id="Grouping" disabled="true" style="width:173px;"></select>
						<label for="GroupingID">Grouping</label>
					</span>
					
					<cfset qCategories = Application.Com.CategoryGateway.getByAttributes(OrderBy="Name")>
					<cfset qPersonalCats = Application.Com.CategoryGateway.getByCookie(TheList=Cookie.USER_Containers,OrderBy="Name")>
					<span>
					<select name="CategoryID" id="CategoryID" style="width:254px;">
						<option value="0">Any Container</option>
						<cfif qPersonalCats.RecordCount GT 0>
						<option value="0">---- Your Containers ----</option>
							<cfloop query="qPersonalCats">
							<option value="#qPersonalCats.CategoryID#"<cfif Attributes.CategoryID EQ qPersonalCats.CategoryID> Selected</cfif>>#qPersonalCats.Name#</option>
							</cfloop>
						<option value="0">--- All Other Containers ----</option>
						</cfif>
						
						<cfloop query="qCategories">
							<cfif NOT ListFind(Cookie.USER_Containers,qCategories.CategoryID,",")>
							<option value="#qCategories.CategoryID#"<cfif Attributes.CategoryID EQ qCategories.CategoryID> Selected</cfif>>#qCategories.Name#</option>
							</cfif>
						</cfloop>
					</select>
					<label for="CategoryID">Container</label></span>
					
					<span><input type="submit" name="Submit" value="Search" class="btn" /></span>
					
					<input type="hidden" name="Search" value="1" />
					<div style="clear:both;"></div>
				</td>
			</tr>
		</table>
	</fieldset>
	</form>
	</cfoutput>
	<cfif isDefined("qActivities") AND qActivities.RecordCount GT 0 >
	<cfif ActivityPager.getTotalNumberOfPages() GT 1><div><cfoutput>#ActivityPager.getRenderedHTML()#</cfoutput></div></cfif>
	<table border="0" width="100%" cellpadding="0" cellspacing="0" class="ViewSectionGrid">
		<tbody>
			<cfoutput query="qActivities" startrow="#ActivityPager.getStartRow()#" maxrows="#ActivityPager.getMaxRows()#">
				<tr>
					<td>
						<img src="#Application.Settings.RootPath#/_images/icons/Status#qActivities.StatusID#.png" border="0" style="float: left; margin-right: 4px;" /> <a href="#myself#Activity.Detail?ActivityID=#ActivityID#"<cfif qActivities.ParentActivityID EQ ""> style="font-weight: bold; float: left;"<cfelse> style="font-weight:normal;"</cfif>>#Title#</a><cfif qActivities.ParentActivityID EQ ""> <img align="absmiddle" src="#Application.Settings.RootPath#/_images/icons/book_open.png" style="float: left; margin-left: 4px;" /></cfif>
						<div style="color:##999;font-size:10px;font-style:italic; padding-left:19px; clear:both;"><cfif Created NEQ "">Created on #DateFormat(Created,"mm/dd/yyyy")#<cfif CreatedBy NEQ ""> by #CreatedByName#</cfif></cfif></div>
						<div style="color:##999;font-size:10px;font-style:italic; padding-left:19px;"><cfif Updated NEQ "">Updated on #DateFormat(Updated,"mm/dd/yyyy")#<cfif UpdatedBy NEQ ""> by #UpdatedByName#</cfif></cfif></div>
						<div style="color:##999;font-size:10px;font-style:italic; padding-left:19px;">Start Date: #DateFormat(StartDate,"M/DD/YYYY")# | <cfif ActivityTypeName NEQ ""><strong>Activity Type</strong>: <a href="#Myself#Activity.Home?Title=#Attributes.Title#&ActivityTypeID=#qActivities.ActivityTypeID#&GroupingID=#Attributes.GroupingID#&CategoryID=#Attributes.CategoryID#&Submit=1&Search=1" style="color:##999;font-size:10px;font-style:italic;">#ActivityTypeName#</a></cfif> <cfif GroupingName NEQ "">| <strong>Grouping</strong>: <a href="#Myself#Activity.Home?Title=#Attributes.Title#&ActivityTypeID=#qActivities.ActivityTypeID#&GroupingID=#qActivities.GroupingID#&CategoryID=#Attributes.CategoryID#&Submit=1&Search=1" style="color:##999;font-size:10px;font-style:italic;">#GroupingName#</a></cfif></div>
					</td>
				</tr>
			</cfoutput>
		</tbody>
	</table>
	<cfif ActivityPager.getTotalNumberOfPages() GT 1><div><cfoutput>#ActivityPager.getRenderedHTML()#</cfoutput></div></cfif>
	<cfelse>
		<!---<cfquery name="qList" datasource="#application.settings.dsn#">
			/* MOST RECENTLY MODIFIED ACTIVITIES */
			WITH CTE_MostRecent AS (
			SELECT H.ToActivityID,MAX(H.Created) As MaxCreated
			FROM ce_History H
			WHERE H.FromPersonID=<cfqueryparam value="#session.personid#" cfsqltype="cf_sql_integer" /> AND isNull(H.ToActivityID,0) <> 0
			GROUP BY H.ToActivityID
			) SELECT * FROM CTE_MostRecent M INNER JOIN ce_Activity A  ON A.ActivityID=M.ToActivityID
			WHERE A.DeletedFlag='N'
			ORDER BY M.MaxCreated DESC
		</cfquery>
	<cfoutput>
	<h3 style="background-color:##555;">Your Recent Activities</h3>
	<table border="0" width="100%" cellpadding="0" cellspacing="0" class="ViewSectionGrid">
		<tbody>
			<cfloop query="qList">
				<tr>
					<td style="height:30px; vertical-align:middle;">
						 <a href="#myself#Activity.Detail?ActivityID=#qList.ActivityID#"<cfif qList.ParentActivityID EQ ""> style="font-weight: bold;font-size: 12px; display: block; position: relative; padding-left: 20px; line-height: 24px;"<cfelse> style="font-weight: normal; font-size: 12px; display: block; position: relative; padding-left: 20px; line-height: 24px;"</cfif>>
						 	<img src="#Application.Settings.RootPath#/_images/icons/Status#qList.StatusID#.png" border="0" style="margin-right: 4px; position: absolute; left: 0pt; top: 4px;" />
							#qList.Title#
							<cfif qList.ParentActivityID EQ "">
							<img src="#Application.Settings.RootPath#/_images/icons/book_open.png" style="position: relative; top: 4px; left: 3px;" />
							</cfif>
							</a>
					</td>
				</tr>
			</cfloop>
		</tbody>
	</table>
	</cfoutput>--->
	</cfif>
	</div>
</div>

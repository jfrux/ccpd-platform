<cfcomponent displayname="daily email">
	<cffunction name="sendAll" access="remote" output="no" returntype="any" returnformat="plain">
		<cfquery name="qAccounts" datasource="#application.settings.dsn#">
			SELECT    P.PersonID, P.DisplayName, P.Email
			FROM         ceschema.ce_Account AS A INNER JOIN
				  ceschema.ce_Person AS P ON A.PersonID = P.PersonID
			WHERE     (A.AuthorityID >= 2)
		</cfquery>
		
		<cfloop query="qAccounts">
			<cfset send(qAccounts.PersonID)>
		</cfloop>
		
		<cflog text="Daily Report script ran successfully." file="ccpd_script_log">
	</cffunction>
	
	<cffunction name="send" access="remote" output="no" returntype="any" returnformat="plain">
		<cfargument name="personid" type="numeric" required="yes" />
		<cfargument name="date" type="string" required="no" default="#dateformat(now(),'mm/dd/yyyy')#" />
		
		<cfset var items = "">
		<cfset var qGet = "">
		<cfset var aQry = arrayNew(1)>
		<cfset var qPerson = "">
		<cfset var outputHTML = "">
		<cfset var outputTEXT = "">
		<cfcontent type="text/html">
		<cfquery name="qPerson" datasource="#application.settings.dsn#">
			SELECT Displayname,Email FROM ce_Person
			WHERE PersonID=<cfqueryparam value="#arguments.personid#" cfsqltype="cf_sql_integer" />
		</cfquery>
		
		<cfquery name="qGet" datasource="#Application.settings.dsn#">
			/* NAME: ALL RELEVANT ACTIVITY HISTORY BY PERSON ID */
			DECLARE @Person int
			DECLARE @DateStart datetime
			DECLARE @DateEnd datetime
			
			SET @Person = <cfqueryparam value="#arguments.personid#" cfsqltype="cf_sql_integer" />;
			SET @DateStart = <cfqueryparam value="#arguments.date# 00:00:00" cfsqltype="cf_sql_timestamp" />;
			SET @DateEnd = <cfqueryparam value="#arguments.date# 23:59:59" cfsqltype="cf_sql_timestamp" />;
			
			WITH CTE_ActivityHistoryByOwner AS (
			SELECT H.HistoryStyleID,H.ToActivityID,MIN(H.HistoryID) AS LeastRecentID, 
									MIN(H.Created) AS LeastRecentDate,
									MAX(H.HistoryID) AS MostRecentID, 
									MAX(H.Created) AS MostRecentDate 
			FROM ceschema.ce_History AS H 
			INNER JOIN ceschema.ce_Sys_HistoryStyle AS HS ON H.HistoryStyleID = HS.HistoryStyleID
			INNER JOIN (SELECT  DISTINCT A.ActivityID
						FROM         ceschema.ce_Activity AS A FULL OUTER JOIN
											  ceschema.ce_Activity_Faculty AS AF ON A.ActivityID = AF.ActivityID FULL OUTER JOIN
											  ceschema.ce_Activity_Committee AS AC ON A.ActivityID = AC.ActivityID
						WHERE     (A.CreatedBy = @Person) OR
											  (A.UpdatedBy = @Person) OR
								  (AC.PersonID = @Person) OR
								  (AF.PersonID = @Person))
						As Act ON Act.ActivityID=H.ToActivityID
			WHERE H.Created BETWEEN @DateStart AND @DateEnd
			GROUP BY H.HistoryStyleID,H.ToActivityID
			)
			SELECT H.* FROM CTE_ActivityHistoryByOwner CTE
			INNER JOIN ceschema.view_history H ON H.HistoryID=CTE.MostRecentID
			ORDER BY MostRecentDate DESC
		</cfquery>
		
		<cfif qGet.RecordCount GT 0>
			
			<!--- ACTIVITY LIST --->
			<cfquery name="qActivities" dbtype="query">
				SELECT DISTINCT ToActivityID As ActivityID,
				ToActivityTitle As ActivityTitle,
				ToActivityDate As ActivityDate
				FROM qGet
				ORDER BY ToActivityTitle
			</cfquery>
			<!--- HISTORY COUNT --->
			<cfquery name="qStatHistory" dbtype="query">
				SELECT Count(HistoryID)
				FROM qGet
			</cfquery>
			<!--- STAT NUMBERS --->
			<cfquery name="qStats" datasource="#application.settings.dsn#">
				DECLARE @PersonID int;
				DECLARE @DateStart datetime;
				DECLARE @DateEnd datetime;
				
				SET @PersonID = <cfqueryparam value="#arguments.personid#" cfsqltype="cf_sql_integer" />;
				SET @DateStart = <cfqueryparam value="#arguments.date# 00:00:00" cfsqltype="cf_sql_timestamp" />;
				SET @DateEnd = <cfqueryparam value="#arguments.date# 23:59:59" cfsqltype="cf_sql_timestamp" />;
				
				SELECT     'Attendees Added' AS StatName, COUNT(AttendeeID) AS StatCount
				FROM         ceschema.ce_Attendee
				WHERE     (CreatedBy = @PersonID) AND (Created BETWEEN @DateStart AND @DateEnd)
				
				UNION
				
				SELECT     'People Created' AS StatName, COUNT(PersonID) AS StatCount
				FROM         ceschema.ce_Person
				WHERE     (CreatedBy = @PersonID) AND (Created BETWEEN @DateStart AND @DateEnd)
				
				UNION
				
				SELECT     'Activities Created' AS StatName, COUNT(ActivityID) AS StatCount
				FROM         ceschema.ce_Activity
				WHERE     (CreatedBy = @PersonID) AND (Created BETWEEN @DateStart AND @DateEnd)
				
				UNION
				
				SELECT     'Faculty Added' AS StatName, COUNT(ActivityID) AS StatCount
				FROM         ceschema.ce_Activity_Faculty
				WHERE     (CreatedBy = @PersonID) AND (Created BETWEEN @DateStart AND @DateEnd)
				
				/*UNION
				SELECT     'Committee Members Added' AS StatName, COUNT(ActivityID) AS StatCount
				FROM         ceschema.ce_Activity_Committee
				WHERE     (CreatedBy = @PersonID) AND (Created BETWEEN @DateStart AND @DateEnd)*/
			</cfquery>
			
						
			<cfsavecontent variable="outputHTML">
			<style type="text/css">
				#emailBody { font-family:Arial, Helvetica, sans-serif; font-size:11px; }
				.emailTitleBar {background-color:#1E568A;
	border:1px solid #000000;
	color:#FFFFFF;
	padding:6px 13px; }
				.emailStats {
				border-color:#000000;
				border-style:solid;
				border-width:0 1px 1px;
				background-color:#3F8FD3; }
				.emailTitle {font-size:18px;
				font-weight:bold;
				margin:0 0 1px;
				padding:0;
				text-transform:uppercase; }
							.emailSubTitle { font-size:13px;
	font-weight:normal;
	margin:0 0 3px;
	padding:0 0 3px;}
			.emailSubText {color:#EEEEEE;
	font-size:11px;
	margin:0;
	padding:0; }
				.emailDesc {color:#777777;
					font-size:11px;
					font-weight:normal;
					margin:0 0 5px;
					padding:0; }
					
				.emailAct { font-family:Arial,Helvetica,sans-serif;
	font-size:11px;
	margin-top:3px; }
								
				.emailActBox {margin-top:7px; }
				.emailActTitle { background-color:#EFEFEF;
	border-bottom:2px solid #777777;
	border-top:1px solid #999999;
	font-size:15px;
	font-weight:bold;
	padding:4px;}
				.emailActTitle a { color:#2A74BA;
	text-decoration:underline; }
				.emailActTitle div {clear:both;
	display:block;
	line-height:16px; }
				.emailActTitle div.email-actsubtitle { 
					color:#555555;
	display:block;
	font-size:11px;
	font-weight:normal;
	margin-bottom:5px;
	margin-top:3px;
				}
				.emailActItems {margin-bottom:5px;
	padding:5px 5px 5px 30px;}
				.statTotals {color:#FFFFFF;
	font-family:Arial,Helvetica,sans-serif;
	font-size:12px;
	height:19px; }
				.stat {
	font-weight:bold;
	margin:2px;
	padding:2px 8px;
	text-align:right;
	white-space:nowrap;
	width:140px; }
				.statcount { 
					background-color:#6AB8FA;
	margin-left:5px;
	padding:2px 8px;
	width:39px;
				}
				
				.subheader { background-color:#555555;
	border-color:#000000;
	border-style:solid;
	border-width:0 1px 1px;
	color:#FFFFFF;
	font-weight:bold;
	padding:3px 4px; }
				.history-item { border-bottom:1px solid #EEEEEE;
	border-left:1px solid #CCCCCC;
	clear:both;
	min-height:45px;
	padding:5px 2px 5px 11px; }
				.history-userphoto { float:left;
				height:45px;
				overflow:hidden;
				width:56px; }
				.history-userphoto img { width:50px; }
				.history-line { margin-top:1px;
	padding:0 2px; }
				.history-line p { padding:0; margin:0; }
				.history-item.userphoto .history-line { margin-left:55px; color:#888; }
				.history-line img { float:left;
					margin-right:5px;
					margin-top:0;
					display:none; }
				.history-line a {color:#555555;
	font-weight:bold;
	text-decoration:underline; }
				.history-line a:hover { text-decoration:underline; color:#0066CC }
				.history-subbox { 
	background-color:#EEEEEE;
	border:1px solid #CCCCCC;
	color:#555555;
	margin:5px 2px 5px 20px;
	padding:3px; }
				.history-subbox-title { 
				background-color:#F7F7F7;
				border:1px solid #CCCCCC;
				font-weight:bold;
				margin-bottom:1px;
				padding:1px 9px;
				text-transform:uppercase; }
				.history-subbox-item-meta { float:left; line-height:16px; }
				.history-subbox-item-detail { float:left;
				line-height:16px;
				width:486px;
				word-wrap:break-word;}
				.history-subbox-item { clear:both;
				font-size:10px;
				font-weight:normal;
				padding:1px 9px 2px; }
				.history-subbox-item strong,.history-subbox-item b { font-weight:normal; }
				.history-subbox-item span { display:block;
				float:left;
				font-size:11px;
				font-weight:bold;
				margin-right:5px;
				text-align:right;
				white-space:nowrap;
				width:87px; }
				.history-item.userphoto .history-subbox { margin-left:58px; }
				.history-meta { color:#777777;
				font-size:10px;
				padding:1px 2px 0;
				text-align:left; }
				.history-item.userphoto .history-meta { margin-top:3px;margin-left:55px; }
				
				.history-filter { 
				-moz-border-radius:3px 3px 3px 3px;
				background-color:#F7F7F7;
				border:1px solid #CCCCCC;
				margin-bottom:8px;
				padding:3px;
				}
				.history-filter ul { }
				.history-filter ul li { float:left; margin:0 1px; }
				.history-filter ul li a {-moz-border-radius:4px 4px 4px 4px;
				background-color:#DDDDDD;
				display:block;
				line-height:25px;
				padding:0 5px;
				text-decoration:none;
				border-style:solid;
				border-width:1px;
				border-color:#888; }
				.history-filter ul li a:hover {background-color:#EEE; }
				
				.history-filter ul li.current { }
				</style>
			<cfoutput>
			<div id="emailBody">
				<table width="720" cellspacing="0" cellpadding="0" class="emailAct">
					<tbody>
						<tr>
							<td class="emailTitleBar">
								<h1 class="emailTitle">Daily Activity Summary (#dateformat(arguments.date,'mm/dd/yyyy')#)</h1>
								<h2 class="emailSubTitle">For <strong>#qPerson.DisplayName#</strong> on <strong>#dateformat(arguments.date,'mmmm dd, yyyy')#</strong></h2>
								<h3 class="emailSubText">This report summarizes all actions taken on courses YOU manage or are associated with.</h3>
								
							</td>
						</tr>
						<tr>
							<td class="emailStats">
								<table class="statTotals" width="720" cellspacing="0" cellpadding="0" border="0">
									<tr>
										<cfloop query="qStats">
										<td class="stat">#qStats.StatName#</td>
										<td class="statcount">#qStats.StatCount#</td>
										</cfloop>
									</tr>
								</table>
							</td>
						</tr>
					<tr>
						<td height="4"></td>
					</tr>
					<tr>
						<td class="subheader">
							Activities modified today...
						</td>
					</tr>
				<tr>
						<td height="2"></td>
					</tr>
				<cfloop query="qActivities">
					<cfquery name="qHistory" dbtype="query">
						SELECT * FROM qGet
						WHERE ToActivityID=#qActivities.ActivityID#
						ORDER BY Created
					</cfquery>
					<cfset aQry = Application.UDF.QueryToStruct(qHistory)>
					<tr>
						<td class="emailActTitle">
							<div>
							<a href="http://ccpd.uc.edu/admin/activity.detail?activityid=#qActivities.ActivityID#">
							#qActivities.ActivityTitle#</a>
							</div>
							<div class="email-actsubtitle">Activity Date: #DateFormat(qActivities.ActivityDate,'mm/dd/yyyy')#</div>
						</td>
					</tr>
					<tr>
						<td class="emailActItems">
							<cfloop from="1" to="#arrayLen(aQry)#" index="i">
								#application.history.renderHTML(aQry[i])#
							</cfloop>
						</td>
					</tr>
				</cfloop>	
					</tbody>		
				</table>
			</div>
				</cfoutput>
			</cfsavecontent>
			
	<cfsavecontent variable="outputTEXT"><cfoutput>Daily Activity Summary (#dateformat(arguments.date,'mm/dd/yyyy')#)
	For #qPerson.DisplayName# on #dateformat(arguments.date,'mmmm dd, yyyy')#
	-------------------------------------------------------------------------<cfloop query="qActivities"><cfquery name="qHistory" dbtype="query">SELECT * FROM qGet WHERE ToActivityID=#qActivities.ActivityID# ORDER BY Created</cfquery><cfset aQry = Application.UDF.QueryToStruct(qHistory)>
	
	#qActivities.ActivityTitle# - #DateFormat(qActivities.ActivityDate,'mm/dd/yyyy')#
	=========================================================================
	<cfloop from="1" to="#arrayLen(aQry)#" index="i">#application.history.renderTEXT(aQry[i])#
	</cfloop></cfloop>
	</cfoutput>
	</cfsavecontent>
			<cfset request.email = createObject("component","_com.email").init() />
			<cfset request.email.send(
				EmailStyleID = 4,
				ToPersonID = arguments.personId,
				customBodyHTML = outputHTML,
				customBodyTEXT = outputTEXT,
				messageText = outputHTML
			) />
		 </cfif>
		 <cfreturn outputHTML />
	</cffunction>
</cfcomponent>
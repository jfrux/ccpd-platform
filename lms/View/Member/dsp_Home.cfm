<cfoutput>
<script>
$(document).ready(function() {
	$("##WelcomeHideLink").click(function() {
		$.post("/lms/_com/AJAX_System.cfc",{ method:'HideWelcome',returnformat:'plain' },function(data) {
			var StatusMsg = $.Trim(data);
			
			if(StatusMsg == 'success') {
			$("##WelcomeBox").slideUp();
			} else {
				alert('FAILED TO HIDE WELCOME!');
			}
		});
	});
});
</script>
<cfquery name="qCheckDegree" datasource="#Application.Settings.DSN#">
	SELECT Count(PersonDegreeID) As DegreeCount FROM ce_Person_Degree
	WHERE PersonID=<cfqueryparam value="#Session.PersonID#" cfsqltype="cf_sql_integer" /> AND DeletedFlag='N'
</cfquery>

<cfquery name="qCheckSpecialty" datasource="#Application.Settings.DSN#">
	SELECT Count(PersonSpecialtyID) As SpecialtyCount FROM ce_Person_SpecialtyLMS
	WHERE PersonID=<cfqueryparam value="#Session.PersonID#" cfsqltype="cf_sql_integer" /> AND DeletedFlag='N'
</cfquery>
<div class="ContentBlock">
	<h1>My CCPD</h1>
	<div id="WelcomeBox" style="background-color:##DDECFF;border:1px solid ##00508A;padding:7px;margin-top:5px;margin-bottom:4px;">
		<div style="font-size:18px;">Welcome to CCPD Online Continuing Education Portal!</div>
		<p>This is the 'My CCPD' home page.  
		It contains information about activities you're taking as well as 
		activities you might be interested in.  As you rate and complete activities we will be able to provide you with other activities.
	</p>
		<p>
		It's time to get started...
		<ul>
			<li><a href="#myself#Activity.Browse">Browse our catalog of activities &raquo;</a></li>
			<li><a href="#myself#Member.Account">Configure your personal preferences &raquo;</a></li>
		</ul>
		</p>
		- <a href="javascript:void(0);" id="WelcomeHideLink">Thank you and hide this box!</a>
	</div>
	<cfif qCheckDegree.DegreeCount EQ 0>
	<div class="Attention">
		<img src="/lms/_images/icons/bullet_error.png" align="absmiddle" /> Please specify your degree. <a href="#myself#Member.Account">Click here to set up</a>.
	</div>
	</cfif>
	<cfif qCheckSpecialty.SpecialtyCount EQ 0>
	<div class="Attention">
		<img src="/lms/_images/icons/bullet_error.png" align="absmiddle" /> We recommend configuring interests so that we may better assist you in finding activities. <a href="#myself#Member.Account">Click here to set up</a>.
	</div>
	</cfif>
	<table width="100%" cellspacing="0" border="0">
		<tr>
			<td valign="top" width="50%">
			
				<h2 class="Head Gray">Activities based on what you've rated</h2>
				<p>
					<cfquery name="qInterested" datasource="#Application.Settings.DSN#">
						SELECT     A.ActivityID, A.Title AS ActivityTitle, A.Updated, PG.LinkName, PG.PublishDate, PG.RemoveDate, PG.PaymentFlag, PG.TermsFlag, PG.StatViews, PG.StatVoteCount, 
							PG.StatVoteValue, PG.FeaturedFlag, PG.StatVoteCount, PG.StatVoteValue
						FROM         ce_Activity AS A INNER JOIN
						ce_Activity_PubGeneral AS PG ON A.ActivityID = PG.ActivityID
						WHERE     (A.ActivityID NOT IN
						(SELECT     ActivityID
						FROM          ce_Activity_Vote
						WHERE      (PersonID = <cfqueryparam value="#Session.PersonID#" cfsqltype="cf_sql_integer" />))) AND
						((SELECT     COUNT(ActivityID) AS Expr1
						FROM         ce_Activity_SpecialtyLMS AS ActS
						WHERE     (A.ActivityID = ActivityID) AND (SpecialtyID IN
											(SELECT     TOP (100) PERCENT S.SpecialtyID
											  FROM          ce_Activity_Vote AS V INNER JOIN
																	 ce_Activity_SpecialtyLMS AS S ON V.ActivityID = S.ActivityID
											  WHERE      (V.PersonID = <cfqueryparam value="#Session.PersonID#" cfsqltype="cf_sql_integer" />)
											  ORDER BY V.VoteValue DESC))) > 0)				
					</cfquery>
					
					<cfif qInterested.RecordCount GT 0>
						<cf_ActivityItem 
							ActivityID="#qInterested.ActivityID#" 
							Title="#qInterested.ActivityTitle#" 
							PaymentFlag="#qInterested.PaymentFlag#" 
							LastUpdated="#qInterested.Updated#" 
							AllowRating="Y"
							VoteCount="#qInterested.StatVoteCount#"
							VoteValue="#qInterested.StatVoteValue#"
							Instance="Rated"
							IconName="thumb_up"
							AllowHide="Y"
							Size="Small">
					<cfelse>
						No activities found.<br />
					</cfif>
					<div style="clear:both; padding:5px; font-size:10px; color:##555;">
					<em>As you rate other activities this list will grow to help us continue to provide you with the latest activiites that might interest you.</em></div>
				</p>
				<h2 class="Head Gray">Activities in your selected specialty interests</h2>
				<p>
					<cfquery name="qInterested" datasource="#Application.Settings.DSN#">
						SELECT     A.ActivityID, A.Title As ActivityTitle, A.Updated, ce_Activity_PubGeneral.LinkName, ce_Activity_PubGeneral.PublishDate, ce_Activity_PubGeneral.RemoveDate, 
						  ce_Activity_PubGeneral.PaymentFlag, ce_Activity_PubGeneral.TermsFlag, ce_Activity_PubGeneral.StatViews, ce_Activity_PubGeneral.FeaturedFlag, ce_Activity_PubGeneral.StatVoteCount, ce_Activity_PubGeneral.StatVoteValue
						FROM         ce_Activity AS A INNER JOIN
						  ce_Activity_PubGeneral ON A.ActivityID = ce_Activity_PubGeneral.ActivityID
						WHERE     (SELECT Count(PersonID) FROM ce_Person_Interest_Except PIE WHERE PIE.ActivityID=A.ActivityID AND PIE.PersonID=<cfqueryparam value="#Session.PersonID#" cfsqltype="cf_sql_integer" />) = 0 AND ((SELECT     COUNT(ASp.Activity_LMS_SpecialtyID) AS Expr1
							 FROM         ce_Person_SpecialtyLMS AS PSp INNER JOIN
												   ce_Activity_SpecialtyLMS AS ASp ON PSp.SpecialtyID = ASp.SpecialtyID
							 WHERE     (ASp.ActivityID = A.ActivityID) AND (PSp.PersonID = <cfqueryparam value="#Session.PersonID#" cfsqltype="cf_sql_integer" />) AND (ASp.DeletedFlag = 'N') AND (PSp.DeletedFlag = 'N')) > 0) AND (A.DeletedFlag = 'N')			
					</cfquery>
					
					<cfif qInterested.RecordCount GT 0>
						<cf_ActivityItem 
							ActivityID="#qInterested.ActivityID#" 
							Title="#qInterested.ActivityTitle#" 
							PaymentFlag="#qInterested.PaymentFlag#" 
							LastUpdated="#qInterested.Updated#" 
							AllowRating="Y"
							Instance="Specialty"
							VoteCount="#qInterested.StatVoteCount#"
							VoteValue="#qInterested.StatVoteValue#"
							IconName="thumb_up"
							AllowHide="Y"
							Size="Small">
					<cfelse>
						No activities found.<br />
					</cfif>
					<div style="clear:both; padding:5px; font-size:10px; color:##555;"><a href="#myself#Member.Account"> Preferences</a></div>
				</p>
			</td>
			<td valign="top" width="50%">
				<h2 class="Head Red">In Progress</h2>
				<p>
					<cfset qActivityList = Application.Com.ActivityGateway.getBySearchLMS(Limit=5,MyPersonID=Session.PersonID,PersonID=Session.PersonID,StatusID=2,PublishedFlag="Y", OrderBy="C.ReleaseDate DESC")>
					
					<cfif qActivityList.RecordCount GT 0>
						<cfloop query="qActivityList">
							<cf_ActivityItem 
								ActivityID="#qActivityList.ActivityID#" 
								Title="#qActivityList.Title#" 
								PaymentFlag="#qActivityList.PaymentFlag#" 
								RemoveDate="#qActivityList.RemoveDate#"
								AllowRating="Y"
								Instance="Featured"
								IconName="Flag_Blue"
								VoteCount="#qActivityList.StatVoteCount#"
								VoteValue="#qActivityList.StatVoteValue#"
								Size="Small"
								MyStatus="#qActivityList.MyStatus#">
						</cfloop> 
					<cfelse>
						No activities in progress.
					</cfif>
				</p>
				
				<h2 class="Head LightGray">Registered</h2>
				<p>
					<cfset qActivityList = Application.Com.ActivityGateway.getBySearchLMS(Limit=5,MyPersonID=Session.PersonID,PersonID=Session.PersonID,StatusID=3, OrderBy="C.ReleaseDate DESC")>
					
					<cfif qActivityList.RecordCount GT 0>
						<cfloop query="qActivityList">
							<cf_ActivityItem 
								ActivityID="#qActivityList.ActivityID#" 
								Title="#qActivityList.Title#" 
								PaymentFlag="#qActivityList.PaymentFlag#" 
								RemoveDate="#qActivityList.RemoveDate#"
								AllowRating="Y"
								Instance="Featured"
								IconName="Flag_Blue"
								VoteCount="#qActivityList.StatVoteCount#"
								VoteValue="#qActivityList.StatVoteValue#"
								Size="Small"
								MyStatus="#qActivityList.MyStatus#">
					</cfloop> 
					<cfelse>
						No activities registered.
					</cfif>
				</p>
				
				<h2 class="Head Green">Completed</h2>
				<p>
					<cfset qActivityList = Application.Com.ActivityGateway.getByCompletedList(PublishedFlag="N",MyPersonID=Session.PersonID,PersonID=Session.PersonID,StatusID=1, DeletedFlag="N", OrderBy="C.startDate DESC")>
					
					<cfif qActivityList.RecordCount GT 0>
						<cfloop query="qActivityList">
						
						<cf_ActivityItem 
							ActivityID="#qActivityList.ActivityID#" 
							Title="#qActivityList.Title#" 
							PaymentFlag="#qActivityList.PaymentFlag#" 
							RemoveDate="#qActivityList.RemoveDate#"
							AllowRating="Y"
							Instance="Featured"
							IconName="Flag_Blue"
							VoteCount="#qActivityList.StatVoteCount#"
							VoteValue="#qActivityList.StatVoteValue#"
							Size="Small"
							MyStatus="#qActivityList.MyStatus#">
					</cfloop> 
					<cfelse>
						No activities completed.
					</cfif>
				</p>
			</td>
		</tr>
	</table>
</div></cfoutput>
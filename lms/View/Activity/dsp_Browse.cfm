<cfimport taglib="/lms/_tags/" prefix="lms">
<cfparam name="Attributes.Title" default="" />
<cfparam name="Attributes.q" default="" />
<script>
	$(document).ready(function() {
		$("input").unbind("keyup");
		$("select").unbind("change");
		$("input").unbind("keydown");
		/*$("#Title").autocomplete('/lms/_com/AJAX_Activity.cfc?method=AutoComplete&returnformat=plain');
		
		*/
		$('.ActivityListing h3 a').each(function() { 
			$.highlight(this, '#Attributes.Title#');
		});
		
		$("#Title").focus();
		
		$("#MoreSpecialtyLink").click(function() {
			$("#MoreSpecialtyDiv").slideDown();
			$("#MoreSpecialtyLink").hide();
		});
		
		$("#MoreCategoryLink").click(function() {
			$("#MoreCategoryDiv").slideDown();
			$("#MoreCategoryLink").hide();
		});
	});
</script>

<style>
.notify {
	background-color: #FFFFCC;
	border: 5px solid #EEEE99;
	padding: 5px;
}
</style>
<cfset allactivities = Application.Com.ActivityGateway.getBySearchLMS(OrderBy="c.startDate DESC") />
<cfscript>
/**
* Limits a string from the center inserting &quot;...&quot;
*
* @param sString      string to use (Required)
* @param nLimit      max length of string to use (Required)
* @return Returns a string
* @author Joshua Rountree (joshua@remote-app.com)
* @version 0, May 9, 2009
*/
function midLimit(sString,nLimit) {
    var nLength = Len(sString);
    var nPercent = nLimit/nLength;
    var nStart = Round(nLimit * .5);
    var nRemoveCount = (nLength - nLimit);
    var sResult = "";
    
    if(nLength GT nLimit) {
        sResult = RemoveChars(sString,nStart,nRemoveCount+3);
        sResult = Insert("...",sResult,nStart-1);
    } else {
        sResult = sString;
    }
    
    return sResult;
}
</cfscript>

<div class="ContentBlock">
	<cfoutput><h1>#Request.Page.Title# <cfif Attributes.Category NEQ ""> <a href="/feeds/rss/category/#Attributes.Category#" target="_blank"><img src="/lms/_images/icon_rss.jpg" border="0" /></a></cfif><cfif Attributes.Specialty NEQ ""> <a href="/feeds/rss/specialty/#Attributes.Specialty#" target="_blank"><img src="/lms/_images/icon_rss.jpg" border="0" /></a></cfif></h1></cfoutput>
	<div id="ContentLeft">
        <div class="notify">Below you will find a list of our e-learning opportunities which give you the chance to earn your continuing education credit on the go.  If you are looking to attend a live educational activity, please visit our <b><a href="http://cme.uc.edu/activities.cfm">Live Activity List</a></b>. </div>
		<cfif isDefined("qActivities")>
		<cfoutput><h2 class="Head DarkGray">Activities (#qActivities.RecordCount#)<cfif Attributes.Title NEQ "">  <span style="font-size:14px;"><a href="#myself#Activity.Browse" style="text-decoration:none;"><img src="/lms/_images/icons/delete.png" style="padding-right:2px;padding-left:10px; border:0px;" align="absmiddle" />Clear Search</a></span></cfif></h2></cfoutput>
		<p>
		
		<cfif qActivities.RecordCount GT 0>
			<cfif ActivityPager.getTotalNumberOfPages() GT 1><div style="padding:0 0 4px 0;clear:both;"><cfoutput>#ActivityPager.getRenderedHTML()#</cfoutput></div></cfif>
			<cfoutput query="qActivities" startrow="#ActivityPager.getStartRow()#" maxrows="#ActivityPager.getMaxRows()#">
				<lms:ActivityItem 
						ActivityID="#qActivities.ActivityID#" 
						Title="#qActivities.Title#"
						Overview="#qActivities.Overview#" 
						PaymentFlag="#qActivities.PaymentFlag#" 
						LastUpdated="#qActivities.Updated#" 
						Published="#qActivities.PublishDate#"
						RemoveDate="#qActivities.RemoveDate#"
						AllowRating="Y"
						Instance="Search"
						VoteCount="#qActivities.StatVoteCount#"
						VoteValue="#qActivities.StatVoteValue#"
						Size="Large"
						MyStatus="#qActivities.MyStatus#"
						LinkName="#qActivities.LinkName#">
			</cfoutput>
			<cfif ActivityPager.getTotalNumberOfPages() GT 1><div style="padding:0 0 4px 0;clear:both;"><cfoutput>#ActivityPager.getRenderedHTML()#</cfoutput></div></cfif>
		<cfelse>
			<cfoutput>
			<em>No activities found<cfif len(attributes.q) gt 0> with "#attributes.q#"</cfif><cfif len(attributes.specialty) GT 0><cfif len(attributes.q) gt 0> AND</cfif> in this specialty</cfif><cfif len(attributes.category) GT 0> in this category</cfif>
			<br /><a href="#myself#activity.browse?q=#attributes.q#&submitted=1">Click here</a> to narrow your search to just "#attributes.q#"</em>
			</cfoutput>
		</cfif>
		</p>
		<cfelse>
		
		<cfset qFeatured = Application.Com.ActivityGateway.getBySearchLMS(Limit=5,MyPersonID=Session.PersonID,FeaturedFlag='Y',PublishedFlag='Y', OrderBy="C.ReleaseDate DESC")>
		<cfoutput>
		<h2 class="Head Red">Featured</h2>
		<cfif qFeatured.RecordCount GT 0>
			<cfloop query="qFeatured">
				<lms:ActivityItem 
						ActivityID="#qFeatured.ActivityID#" 
						Title="#qFeatured.Title#" 
						PaymentFlag="#qFeatured.PaymentFlag#" 
						LastUpdated="#qFeatured.Updated#" 
						Published="#qFeatured.PublishDate#"
						RemoveDate="#qFeatured.RemoveDate#"
						AllowRating="Y"
						Instance="Featured"
						IconName="Flag_Blue"
						VoteCount="#qFeatured.StatVoteCount#"
						VoteValue="#qFeatured.StatVoteValue#"
						Size="Large"
						MyStatus="#qFeatured.MyStatus#"
						LinkName="#qFeatured.LinkName#">
			</cfloop>
		<cfelse>
			There aren't any featured activities at this time.
		</cfif>
		<cfset qPopular = Application.Com.ActivityGateway.getBySearchLMS(Limit=5,MyPersonID=Session.PersonID,PublishedFlag='Y', OrderBy="StatRank DESC")>
		<h2 class="Head Green">Highest Rated</h2>
		<cfif qPopular.RecordCount GT 0>
			<cfloop query="qPopular">
				<lms:ActivityItem 
						ActivityID="#qPopular.ActivityID#" 
						Title="#qPopular.Title#" 
						PaymentFlag="#qPopular.PaymentFlag#" 
						LastUpdated="#qPopular.Updated#" 
						Published="#qPopular.PublishDate#"
						RemoveDate="#qPopular.RemoveDate#"
						AllowRating="Y"
						Instance="Popular"
						IconName="Star"
						VoteCount="#qPopular.StatVoteCount#"
						VoteValue="#qPopular.StatVoteValue#"
						Size="Large"
						MyStatus="#qPopular.MyStatus#"
						LinkName="#qPopular.LinkName#">
			</cfloop>
		<cfelse>
			No activities have been rated.
		</cfif>
		</cfoutput>
		</cfif>
		
	</div>
	<div id="ContentRight">
		<cfoutput>
		<h2 class="Head DarkGray">Activity Search</h2>
		<form name="frmSearch" id="frmSearch" method="get" action="#Myself#Activity.Browse">
			<input type="text" name="q" id="q" value="#Attributes.q#" style="width: 160px;" />
			<cfif Attributes.Category GT 0>
			<input type="hidden" name="Category" value="#Attributes.Category#" />
			<cfelseif Attributes.Specialty GT 0>
			<input type="hidden" name="Specialty" value="#Attributes.Specialty#" />
			</cfif>
			<input type="hidden" name="Submitted" value="1" />
			<input type="Submit" name="btnSubmit" id="btnSubmit" value="Search" />
		</form>
		<cfquery name="qSpecialties" datasource="#Application.Settings.DSN#">
			SELECT     
				SpecialtyID, 
				Name, 
				Description,
				
				/* ACTIVITY COUNT */
				(SELECT     COUNT(ActS.Activity_LMS_SpecialtyID) AS ActivityCount
				FROM          ce_Activity_SpecialtyLMS AS ActS INNER JOIN
								   ce_Activity AS A ON ActS.ActivityID = A.ActivityID INNER JOIN
								   ce_Activity_PubGeneral AS APG ON A.ActivityID = APG.ActivityID
				WHERE      (ActS.SpecialtyID = S.SpecialtyID) AND (ActS.DeletedFlag = 'N') AND (A.DeletedFlag = 'N') AND (APG.PublishDate <= GETDATE()) AND (APG.RemoveDate > GETDATE())
									AND (A.StatusID = 1) OR
								   (ActS.SpecialtyID = S.SpecialtyID) AND (ActS.DeletedFlag = 'N') AND (A.DeletedFlag = 'N') AND (APG.PublishDate <= GETDATE()) AND 
								   (APG.RemoveDate IS NULL) AND (A.StatusID = 1)) AS ActivityCount
			FROM         ce_Sys_SpecialtyLMS AS S
			WHERE     
				((SELECT     COUNT(ActS.Activity_LMS_SpecialtyID) AS ActivityCount
				FROM         ce_Activity_SpecialtyLMS AS ActS INNER JOIN
				   ce_Activity AS A ON ActS.ActivityID = A.ActivityID INNER JOIN
				   ce_Activity_PubGeneral AS APG ON A.ActivityID = APG.ActivityID
				WHERE     (ActS.SpecialtyID = S.SpecialtyID) AND (ActS.DeletedFlag = 'N') AND (A.DeletedFlag = 'N') AND (APG.PublishDate <= GETDATE()) AND (APG.RemoveDate > GETDATE()) 
				   AND (A.StatusID = 1) OR
				   (ActS.SpecialtyID = S.SpecialtyID) AND (ActS.DeletedFlag = 'N') AND (A.DeletedFlag = 'N') AND (APG.PublishDate <= GETDATE()) AND 
				   (APG.RemoveDate IS NULL) AND (A.StatusID = 1)) > 0)
			ORDER BY Name
		</cfquery>
		<h2 class="Head DarkGray">Specialties <a href="/feeds/rss/specialty" target="_blank"><img src="/lms/_images/icon_rss.jpg" border="0" /></a></h2>
			<ul>
				<li><a href="#Application.Settings.RootPath#/browse?submitted=1" title="All Activities" style="text-decoration:none; font-weight:bold;">All Activities (#allactivities.recordcount#) <img src="/lms/_images/icons/bullet_go.png" align="absmiddle" border="0" /></a></li>
			<cfloop query="qSpecialties">
				<li><a href="#Application.Settings.RootPath#/browse?specialty=#qSpecialties.SpecialtyID#&submitted=1" title="#qSpecialties.Name#" style="text-decoration:none;">#midLimit(qSpecialties.Name,30)# (#qSpecialties.ActivityCount#) <img src="/lms/_images/icons/bullet_go.png" align="absmiddle" border="0" /></a></li>
			</cfloop>
			</ul>
			<cfquery name="qCategories" datasource="#Application.Settings.DSN#">
				SELECT     
					CategoryID, 
					Name, 
					Description,
					/* ACTIVITY COUNT */
					(SELECT
						COUNT(ActS.Activity_LMS_CategoryID) AS ActivityCount
					FROM          
						ce_Activity_CategoryLMS AS ActS 
					INNER JOIN
						ce_Activity AS A ON ActS.ActivityID = A.ActivityID 
					INNER JOIN
						ce_Activity_PubGeneral AS APG ON A.ActivityID = APG.ActivityID
					WHERE      (ActS.CategoryID = S.CategoryID) AND (ActS.DeletedFlag = 'N') AND (A.DeletedFlag = 'N') AND (APG.PublishDate <= GETDATE()) AND (APG.RemoveDate > GETDATE())
					AND (A.StatusID = 1) OR
					(ActS.CategoryID = S.CategoryID) AND (ActS.DeletedFlag = 'N') AND (A.DeletedFlag = 'N') AND (APG.PublishDate <= GETDATE()) AND 
					(APG.RemoveDate IS NULL) AND (A.StatusID = 1)) AS ActivityCount
					FROM         ce_Sys_CategoryLMS AS S
					WHERE     
					((SELECT     COUNT(ActS.Activity_LMS_CategoryID) AS ActivityCount
					FROM         ce_Activity_CategoryLMS AS ActS INNER JOIN
					ce_Activity AS A ON ActS.ActivityID = A.ActivityID INNER JOIN
					ce_Activity_PubGeneral AS APG ON A.ActivityID = APG.ActivityID
					WHERE     (ActS.CategoryID = S.CategoryID) AND (ActS.DeletedFlag = 'N') AND (A.DeletedFlag = 'N') AND (APG.PublishDate <= GETDATE()) AND (APG.RemoveDate > GETDATE()) 
					AND (A.StatusID = 1) OR
					(ActS.CategoryID = S.CategoryID) AND (ActS.DeletedFlag = 'N') AND (A.DeletedFlag = 'N') AND (APG.PublishDate <= GETDATE()) AND 
					(APG.RemoveDate IS NULL) AND (A.StatusID = 1)) > 0)
					ORDER BY Name
		</cfquery>
		<cfif qCategories.recordCount GT 0>
		<h2 class="Head DarkGray">Categories <a href="/lms/feeds/rss/category" target="_blank"><img src="/lms/_images/icon_rss.jpg" border="0" /></a></h2>
		
			<ul>
			<li><a href="#Application.Settings.RootPath#/browse?submitted=1" title="All Activities" style="text-decoration:none; font-weight:bold;">All Activities (#allactivities.recordcount#) <img src="/lms/_images/icons/bullet_go.png" align="absmiddle" border="0" /></a></li>
			<cfloop query="qCategories">
			<li><a href="#Application.Settings.RootPath#/browse?category=#qCategories.CategoryID#&submitted=1" title="#qCategories.Name#" style="text-decoration:none;">#midLimit(qCategories.Name,30)# (#qCategories.ActivityCount#) <img src="/lms/_images/icons/bullet_go.png" align="absmiddle" border="0" /></a></li>
			</cfloop>
			</ul>
		</cfif>
		<h2 class="Head DarkGray">Tags</h2>
		<cfquery name="qTags" cachedwithin="#createTimeSpan(0,1,0,0)#" datasource="#Application.Settings.DSN#">
			SELECT     
				id, 
				Name, 
				
				/* ACTIVITY COUNT */
				(SELECT     COUNT(ActS.activityid) AS ActivityCount
				FROM          ceschema.ce_activity_tag_relates AS ActS INNER JOIN
								   ceschema.ce_Activity AS A ON ActS.ActivityID = A.ActivityID INNER JOIN
								   ceschema.ce_Activity_PubGeneral AS APG ON A.ActivityID = APG.ActivityID
				WHERE      (ActS.tagid = S.id) AND S.hideflag=0 AND S.tagcount > 20 AND (A.DeletedFlag = 'N') AND (APG.PublishDate <= GETDATE()) AND (APG.RemoveDate > GETDATE())
									AND (A.StatusID = 1) OR
								   (ActS.tagid = S.id) AND S.hideflag=0 AND S.tagcount > 20 AND (A.DeletedFlag = 'N') AND (APG.PublishDate <= GETDATE()) AND 
								   (APG.RemoveDate IS NULL) AND (A.StatusID = 1)) AS ActivityCount
			FROM         ceschema.ce_activity_tags AS S
			WHERE     
				((SELECT     COUNT(ActS.activityid) AS ActivityCount
				FROM         ceschema.ce_activity_tag_relates AS ActS INNER JOIN
				   ceschema.ce_Activity AS A ON ActS.ActivityID = A.ActivityID INNER JOIN
				   ceschema.ce_Activity_PubGeneral AS APG ON A.ActivityID = APG.ActivityID
				WHERE     (ActS.tagid = S.id) AND S.hideflag=0 AND S.tagcount > 20 AND (A.DeletedFlag = 'N') AND (APG.PublishDate <= GETDATE()) AND (APG.RemoveDate > GETDATE()) 
				   AND (A.StatusID = 1) OR
				   (ActS.tagid = S.id) AND S.hideflag=0 AND S.tagcount > 20  AND (A.DeletedFlag = 'N') AND (APG.PublishDate <= GETDATE()) AND 
				   (APG.RemoveDate IS NULL) AND (A.StatusID = 1)) > 0)
			ORDER BY Name
		</cfquery>
			<ul>
			<li><a href="#Application.Settings.RootPath#/browse?submitted=1" title="All Activities" style="text-decoration:none; font-weight:bold;">All Activities (#allactivities.recordcount#) <img src="/lms/_images/icons/bullet_go.png" align="absmiddle" border="0" /></a></li>
			<cfloop query="qTags">
			<li><a href="#Application.Settings.RootPath#/browse?tag=#qTags.id#&submitted=1" title="#qTags.Name#" style="text-decoration:none;">#midLimit(qTags.Name,30)# (#qTags.ActivityCount#) <img src="/lms/_images/icons/bullet_go.png" align="absmiddle" border="0" /></a></li>
			</cfloop>
			</ul>
			</cfoutput>
			
			
		</div>
		
		
	
</div>

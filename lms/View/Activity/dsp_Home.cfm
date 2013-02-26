<cfparam name="Attributes.show" default="mycars">
<cfparam name="Attributes.q" default="" />
<cfparam name="Attributes.make" default="" />
<cfparam name="Attributes.model" default="" />
<cfparam name="Attributes.yearstart" default="1902" />
<cfparam name="Attributes.yearend" default="#Year(now())+1#" />
<cfparam name="Attributes.category" default="" />
<script>
<!---var sHomeType = "Activity";
var sSearchBoxText = "Search for " + sHomeType + "s";
--->
function getActivities(params) {
	$(".result-block").find(".result").remove();
	$.ajax({
		url:'/admin/_com/ajax_list.cfc?method=activities',
		data:params,
		dataType:'json',
		type:'get',
		success:function(data) {
			if(data.length) {
				$.each(data,function(i,item) {
					$.tmpl("resultActivity",item).appendTo(".result-block");
				});
			} else {
				$(".result-block").append("<div class=\"result\">No activities available for this criteria.</div>");
			}
		}
		});
}

function setSort(sortby) {
	switch (sortby) {
		case 'recent':
			getActivities({
				sortby:'recent',
				person:169841
			});
			
			$(".result-block h3").html("Your most recently modified activities.");
			
		break;
		case 'upcoming':
			getActivities({
				sortby:'upcoming',
				person:169841
			});
			$(".result-block h3").html("Your upcoming activities.");
		break;
		case 'active':
			getActivities({
				sortby:'active'
			});
			$(".result-block h3").html("Globally modified activities.");
		break;
		case 'search':
			getActivities({
				sortby:'search',
				q:''
			});
			$(".result-block h3").html("Search Results");
		break;
	}
	
	$(".filter-buttons .current").removeClass('current');
			$("#filter-" + sortby).parent().addClass('current');
}

$(document).ready(function() {
	$("#result-activity").template("resultActivity");
	
	$(".filter-buttons a").click(function() {
		var sortby = $(this).attr('id').replace('filter-','');
		
		setSort(sortby);
		
		return false;
	});
	
	setSort('recent');
	
	$("#ReleaseDate").mask("99/99/9999");

	
	$("#Title").unbind("keydown");
	
	$("#Title").autocomplete(sRootPath + '/_com/AJAX_Activity.cfc?method=AutoComplete&returnformat=plain');
	
	
	$('.ActivityListing h3 a').each(function() { 
		$.highlight(this, sTitle);
	});
	
	$("#Title").focus();
	
	setActivityType($("#ActivityTypeID").val());
	
	
	$("#ActivityTypeID").bind("change", this, function() {
		setActivityType($(this).val());
	});
});
</script><!---
<script type="text/javascript" src="/_scripts/home.js"></script>--->
<div class="home-container">
	<div class="home-left">
		<h1>Activities <span>Manage your activities, view history, and change subscriptions.</span></h1>
		<cfoutput>
		<div class="filterbar">
			<div class="sorter">
			
			</div>
		</div>
		
		<div class="home-optionbar">
			<div class="home-optionbar-filters">
			<ul class="filter-buttons">
				<li<cfif Attributes.show EQ "recent"> class="current"</cfif>><a href="#myself#activity.home?show=recent" id="filter-recent">My Recent</a></li>
				<li<cfif Attributes.show EQ "upcoming"> class="current"</cfif>><a href="#myself#activity.home?show=recentr" id="filter-upcoming">My Upcoming</a></li>
				<li<cfif Attributes.show EQ "active"> class="current"</cfif>><a href="#myself#activity.home?show=recent" id="filter-active">All Active</a></li>
				<li<cfif Attributes.show EQ "search"> class="current"</cfif>><a href="#myself#activity.home?show=search" id="filter-search">Search</a></li>
			</ul>
			</div>
			<div class="home-optionbar-search">
				
			</div>
			<div class="home-optionbar-buttons">
				<button class="button-gray" style="margin-left:10px;" id="btn-create">Create activity</button>
			</div>
		</div>
		</cfoutput>
		
		<div class="results">
			<div class="result-block">
			<cfoutput><h3>Your Most Recent</h3></cfoutput>
				<!---<div class="result">
				<div class="info">
				You have not created any activities.<br />
				<a href="#myself#activity.create">Create an activity</a>
				</div>
				</div>--->
			</div>
		</div>
	</div>
	<div class="home-right">
		<div style="height:26px;"></div>
		<div class="section">
			<h3>Find activities</h3>
			<form name="frmSearch" method="get" action="#myself#Activity.Home">
			<fieldset class="common-form">
				<ul>
					<li>
						<span>
							<label for="Search">Search</label>
							<input type="text" name="q" id="Search" value="" style="width:159px;" />
						</span>
						<span id="StartDate">
							<label for="StartDate">Start Date</label>
							<input type="text" name="StartDate" id="ReleaseDate" value="#DateFormat(Attributes.StartDate,'MM/DD/YYYY')#" style="width:67px;" />
						</span>
					</li>
					<li>
						<span>
						
						<label for="ActivityTypeID">Activity Type</label>
						<select name="ActivityTypeID" id="ActivityTypeID" style="width:172px;">
						<option value="0">Any Type</option>
						
						<option value=""></option>
						
						</select>
						</span>
					</li>
					<li>
						<span id="groupings">
						<label for="GroupingID">Grouping</label>
						<select name="GroupingID" id="Grouping" disabled="true" style="width:172px;"></select>
						
						</span>
					</li>
					<li>
						<span>
						<label for="CategoryID">Container</label>
						<select name="CategoryID" id="CategoryID" style="width:172px;">
						<option value="0">Any Container</option>
						
						<option value="0">---- Your Containers ----</option>
						
						<option value=""></option>
						
						<option value="0">--- All Other Containers ----</option>
						
						
						<option value=""></option>
						</select></span>
					</li>
					<li>
					<span><input type="submit" name="Submit" value="Search" class="btn" /></span>
					
					<input type="hidden" name="Search" value="1" />
					</li>
				</ul>
				<div style="clear:both;"></div>
			</fieldset>
			</form>
			<br style="height:0px;width:100%;clear:both;" />
		</div>
		
		<div class="section">
			<h3>Suggestions</h3>
			<p class="info">No suggestions yet!</p>
		</div>
	</div>
</div>

<script id="result-activity" type="text/x-jquery-tmpl">
	<div class="result">
		<div class="result-detail">
			<div class="result-link"><a href="/index.cfm/event/activity.detail?activityid=${ACTIVITYID}">${TITLE}</a></div>
			<div class="result-info">
				<ul>
					{{if STARTDATE}}
					<li>
					<div><span>Start Date:</span> ${STARTDATE}</div>
					</li>
					{{/if}}
					{{if UPDATED}}
					<li>
						<span>Last Updated:</span> ${UPDATED}
					</li>
					{{/if}}
					<li>
					
					</li>
			</div>
			
		</div>
		<div class="result-actions">
			<ul>
				<li><a href="/index.cfm/event/activity.detail?activityid=${ACTIVITYID}">Edit This Activity</a></li>
			</ul>
		</div>
	<br style="clear: both;height:0px;width:100%;"/>
	</div>
</script>
<style>
.home-group { 
-webkit-border-radius: 7px;
-moz-border-radius-bottomleft:7px;
-moz-border-radius-bottomright:7px;
-moz-border-radius-topleft:7px;
-moz-border-radius-topright:7px;
padding:1px;
}

.home-group h3 { 
-moz-border-radius-topleft:7px;
-moz-border-radius-topright:7px; margin:1px!important; }

.home-section { background-color:#EEE; border:1px solid #CCC; padding:8px; margin:4px;-webkit-border-radius: 7px;
-moz-border-radius-bottomleft:7px;
-moz-border-radius-bottomright:7px;
-moz-border-radius-topleft:7px;
-moz-border-radius-topright:7px; }
.home-section:hover { background-color:#F7F7F7; }

.home-section ul { margin-left:18px; margin-top:4px; }
.home-section li { list-style-type:circle; }
.home-section li a { padding:1px 1px; }
.home-section li a:hover {  }
.home-section li span { font-size:.95em; color:#555; font-style:italic; }

.home-section h4 { margin:0!important; padding:0!important; }
</style>

<script src="/static/js/jquery-plugins/jquery.autocomplete.js" type="text/javascript"></script>
 <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=true&amp;key=ABQIAAAAOco4Rixw9baR3XuJyGJuFRT0z713tVjdys7BXmvf8Auv5rjcOhTkSXSLroyEswiWNU5MoAt7rz-Wnw" type="text/javascript"></script>
<script src="/static/js/lib/uiInfoTable.js" type="text/javascript"></script>

<cfset pts = [] />
<script type="text/javascript">
		

<!---	<cfset qActCats = Application.Com.ActivityCategoryGateway.getByViewAttributes(ActivityID=Attributes.ActivityID,DeletedFlag='N')>
	var folders = <cfoutput>#serializeJSON(application.UDF.queryToStruct(qActCats))#</cfoutput>;--->
	$(document).ready(function() {
		var map = new GMap2(document.getElementById("map_canvas"));
		map.setCenter(new GLatLng(37.4419, -122.1419), 1);
		map.setUIToDefault();
		
		var points = {};
		<cfoutput>
		<cfloop query="points">
			points['#points.currentrow#'] = new GLatLng(#points.latitude#,#points.longitude#);
			map.addOverlay(new GMarker(points['#points.currentrow#']));
		</cfloop>
		</cfoutput>
		initialize();
		$("#Activity").uiTypeahead({
			watermarkText:'Select an activity...',
			queryParam:'q',
			ajaxSearchURL:"/admin/_com/ajax/typeahead.cfc",
			ajaxSearchType:"POST",
			ajaxSearchParams:{
				method:'search',
				type: 'activity',
				max:4
			},
			allowAdd:false
		});
		
	<!---	$("#CityState").uiTypeahead({
			watermarkText:'Enter city / state...',
			queryParam:'q',
			ajaxSearchURL:"/admin/_com/ajax/typeahead.cfc",
			ajaxSearchType:"POST",
			ajaxSearchParams:{
				method:'search',
				type: 'city',
				max:4
			},
			allowAdd:false
		});
		
		$("#Degree").uiTypeahead({
			watermarkText:'Type your highest degree...',
			queryParam:'q',
			ajaxSearchURL:"/admin/_com/ajax/typeahead.cfc",
			ajaxSearchType:"POST",
			ajaxSearchParams:{
				method:'search',
				type:'degrees',
				max:4
			},
			allowAdd:true,
			ajaxAddURL:"/admin/_com/ajax/typeahead.cfc",
			ajaxAddType:"post",
			ajaxAddParams:{
				method:'add',
				type:'degrees'
			}
		});
		
		$("#Occupation").uiTypeahead({
			watermarkText:'What is your occupation?',
			queryParam:'q',
			ajaxSearchURL:"/admin/_com/ajax/typeahead.cfc",
			ajaxSearchType:"POST",
			ajaxSearchParams:{
				method:'search',
				type:'occupation',
				max:4
			},
			allowAdd:true,
			ajaxAddURL:"/admin/_com/ajax/typeahead.cfc",
			ajaxAddType:"post",
			ajaxAddParams:{
				method:'add',
				type:'occupation'
			}
		});--->
		
		$("#Person").uiTypeahead({
			watermarkText:'Select a person...',
			queryParam:'q',
			ajaxSearchURL:"/admin/_com/ajax/typeahead.cfc",
			ajaxSearchType:"POST",
			ajaxSearchParams:{
				method:'search',
				type:'person',
				max:8
			},
			allowAdd:false
		});
		
		$("#SearchAll").uiTypeahead({
			watermarkText:'Type to search...',
			queryParam:'q',
			ajaxSearchURL:"/admin/_com/ajax/typeahead.cfc",
			ajaxSearchType:"POST",
			ajaxSearchParams:{
				method:'search',
				max:4
			},
			allowAdd:false
		});
		
	<!---	$("#Specialty").uiTypeahead({
			watermarkText:'Type your specialty...',
			queryParam:'q',
			ajaxSearchURL:"/admin/_com/ajax/typeahead.cfc",
			ajaxSearchType:"POST",
			ajaxSearchParams:{
				method:'search',
				type: 'specialties',
				max:4
			},
			allowAdd:true,
			ajaxAddURL:"/admin/_com/ajax/typeahead.cfc",
			ajaxAddType:"post",
			ajaxAddParams:{
				method:'add',
				type:'specialties'
			}
		});
		
		$("#Sponsor").uiTypeahead({
			watermarkText:'Type name of sponsoring entity...',
			
			queryParam:'q',
			ajaxSearchURL:"/admin/_com/ajax/typeahead.cfc",
			ajaxSearchType:"POST",
			ajaxSearchParams:{
				method:'search',
				type:'entities',
				max:4
			},
			allowAdd:true,
			ajaxAddURL:"/admin/_com/ajax/typeahead.cfc",
			ajaxAddType:"post",
			ajaxAddParams:{
				method:'add',
				type:'entities'
			}
		});
		
		$("#Wikipedia").uiTypeahead({
			watermarkText:'Add item from wikipedia...',
			queryParam:'q',
			ajaxSearchURL:"/admin/_com/ajax/typeahead.cfc",
			ajaxSearchType:"POST",
			ajaxSearchParams:{
				method:'wikipedia',
				max:4
			},
			allowAdd:false
		});--->
		
	});
</script>

<style>
.debugger {
	position:fixed;
	top:30px;
	right:30px;
	z-index:100;
	background-color:#FF0000;
	color:#FFFFFF;
	padding:25px;
}
</style>
<cfoutput>
<div>

<cfoutput>
	<!---<form action="#Application.Settings.RootPath#/_com/ajax_activity.cfc" method="post" name="frmEditActivity" id="EditForm" class="uiLiveForm">
		<!--- 
			ADDED Attributes.SessionType 
			HIDDEN FIELD FOR SAVING PURPOSES 
			[Attributes.SessionType must be passed to save StartDate/EndDate] 
		--->
		<input type="hidden" value="saveActivity" name="Method" />
		<input type="hidden" value="plain" name="returnFormat" />
		<input type="hidden" value="" name="ChangedFields" id="ChangedFields" />
		<input type="hidden" value="" name="ChangedValues" id="ChangedValues" />
		
		<table class="infoTable">
			<tbody>
				<!---<tr class="dataRow">
					<th class="label"></th>
					<td class=""><cfinclude template="#Application.Settings.RootPath#/View/Includes/SaveInfo.cfm" /></td>
				</tr>
				<tr class="dataRow">
					<th class="label"><label>Sponsor:</label></th>
					<td class="data"><input type="text" value="" name="Sponsor" id="Sponsor" class="form-Sponsor"  />
					</td>
				</tr>
				<tr class="dataRow">
					<th class="label"><label>Scraper:</label></th>
					<td class="data">
						<input type="text" name="Scraper" id="Scraper"  /><input type="button" name="check" id="btnScrape" />
						
						<div class="scapeResult">
							<div class="images">
							</div>
						</div>
					</td>
				</tr>
				<tr class="dataRow">
					<th class="label"><label>Occupation:</label></th>
					<td class="data"><input type="text" value="" name="Occupation" id="Occupation" class="form-Occupation"  />
					</td>
				</tr>
				<tr class="dataRow">
					<th class="label"><label>Specialty:</label></th>
					<td class="data"><input type="text" value="" name="Specialty" id="Specialty" class="form-Specialty"  />
					</td>
				</tr>
				<tr class="dataRow">
					<th class="label"><label>Degree:</label></th>
					<td class="data"><input type="text" value="" name="Degree" id="Degree" class="form-Degree"  />
					</td>
				</tr>
				<tr class="dataRow">
					<th class="label"><label>City / State:</label></th>
					<td class="data"><input type="text" value="" name="CityState" id="CityState" class="form-CityState"  />
					</td>
				</tr>
				<tr class="dataRow">
					<th class="label"><label>Wikipedia:</label></th>
					<td class="data"><input type="text" value="" name="Wikipedia" id="Wikipedia" class="form-Wikipedia"  />
					</td>
				</tr>--->
				<tr class="dataRow">
					<th class="label"><label>Activity:</label></th>
					<td class="data"><input type="text" value="" name="Activity" id="Activity" class="form-Activity"  />
					</td>
				</tr>
				<tr class="dataRow">
					<th class="label"><label>Person:</label></th>
					<td class="data"><input type="text" value="" name="Person" id="Person" class="form-Person"  />
					</td>
				</tr>
				<tr class="dataRow">
					<th class="label"><label>Search All:</label></th>
					<td class="data"><input type="text" value="" name="SearchAll" id="SearchAll" class="form-SearchAll"  />
					</td>
				</tr>
				<!---<tr class="dataRow">
					<th class="label"><label>Folders:</label></th>
					<td class="data">
					</td>
				</tr>--->
				<tr class="spacer">
					<td colspan="2"><hr /></td>
				</tr>
				<!---<tr class="dataRow">
					<th class="label"></th>
					<td class=""><cfinclude template="#Application.Settings.RootPath#/View/Includes/SaveInfo.cfm" />
					</td>
				</tr>--->
			</tbody>
		</table>
	</form>--->
</cfoutput>
<!---
	<div class="uiTokenizer clearfix">
		<div class="uiTypeahead">
		<input type="text" id="degrees" style="width:500px;height:20px;" />
		</div>
		<div class="uiTokenarea clearfix">
		
		</div>
	</div>
	
	<div class="uiTokenizer clearfix">
		<div class="uiTypeahead">
		<input type="text" id="specialties" style="width:500px;height:20px;" />
		</div>
		<div class="uiTokenarea clearfix">
		
		</div>
	</div>--->

</div>
<div class="ViewSection">
	<div class="home-group">
		<h3>System Customization</h3>
        <div class="home-section">
            <h4>Categories</h4>
			<ul>
				<li><a href="#Myself#admin.Categories">Manage Categories</a></li>
				<li><a href="#Myself#admin.Category">Create New</a></li>
			</ul>
		</div>
		<div class="home-section">
			<h4>Certificates</h4>
			<ul>
				<li><a href="#Myself#admin.certificates">Manage Certificates</a></li>
				<li><a href="#Myself#admin.certificate">Create New</a></li>
			</ul>
		</div>
		<div class="home-section">
			<h4>History Styles</h4>
			<ul>
				<li><a href="#Myself#admin.historystyles">Manage History Styles</a></li>
				<li><a href="#Myself#admin.historystyle">Create New</a></li>
			</ul>
		</div>
        <div class="home-section">
            <h4>Specialties</h4>
			<ul>
				<li><a href="#Myself#admin.Specialties">Manage Specialties</a></li>
				<li><a href="#Myself#admin.Specialty">Create New</a></li>
			</ul>
		</div>
	</div>
</div>

<!--- COMMENTS --->
<div class="ViewSection">
	<div class="home-group">
		<h3>Comments</h3>
		<div class="home-section">
			<h4>Approve/Deny Comments</h4>
			<ul>
				<li><a href="#Myself#admin.comments?CommentType=A">Approved Comments</a></li>
				<li><a href="#Myself#admin.comments?CommentType=D">Denied Comments</a></li>
				<li><a href="#Myself#admin.comments?CommentType=P">Pending Comments</a></li>
			</ul>
		</div>
	</div>
</div>

<!--- COMMUNICATION --->
<div class="ViewSection">
	<div class="home-group">
		<h3>Communication</h3>
		<div class="home-section">
			<h4>Email Styles</h4>
			<ul>
				<li><a href="#Myself#admin.emailstyles">Manage Email Styles</a></li>
				<li><a href="#Myself#admin.emailstyle">Create New</a></li>
			</ul>
		</div>
		
		<div class="home-section">
			<h4>Mass Mailing</h4>
			<ul>
				<li><a href="#myself#admin.message">Send email to admins</a></li>
			</ul>
		</div>
	</div>
	
	<div id="map_canvas" style="width:900px;height:600px;">
	
	</div>
</div>

<!--- PROCESS & QUEUES 
<div class="ViewSection">
	<div class="home-group">
		<h3>Processes &amp; Queues</h3>
		<div class="home-section">
			<h4>Management</h4>
			<ul>
				<li><a href="#Myself#process.home">Manage Existing</a></li>
				<li><a href="#Myself#process.create">Create a process</a></li>
			</ul>
		</div>
	</div>
</div>--->


</cfoutput>
<cfparam name="Attributes.type" default="all" />
<cfparam name="Attributes.YearStart" default="#Year(now())#" />
<cfparam name="Attributes.YearEnd" default="#Year(now())+1#" />
<cfparam name="Attributes.Make" default="0" />
<cfparam name="Attributes.Model" default="0" />
<cfparam name="Attributes.Category" default="" />
<cfparam name="Attributes.Location" default="By Location" />
<cfparam name="Attributes.DisplayName" default="By Name" />
<cfparam name="Attributes.Email" default="By Email" />
<script>
$(document).ready(function() {
	
	$(".formSearch").submit(function() {
		$("#userarea-searchcontent .results").html("");
		$("#userarea-searchloading").show(); 
		$("#refine-q").val($('#searchbox-main').val());
		$(this).ajaxSubmit({ 
				url: sMyself + "main.searchResults",
				success: function(responseText,statusText) {
					$("#userarea-searchloading").hide(); 
					$("#userarea-searchcontent").html(responseText);
				}
		}); 
		
		return false; 
	});
	
	$("a.page,a.first,a.last,a.next,a.previous").click(function() {
		nPageNo = $.Mid(this.href,$.Find("page=",this.href)+5,$.Len(this.href)-$.Find("page=",this.href)+4);
		$("#userarea-searchcontent .results").html("");
		$("#userarea-searchloading").show(); 

		$.get($(this).attr("href"),function(data) {
			$("#userarea-searchloading").hide(); 
			$("#userarea-searchcontent").html(data);
		});
		return false;
	});
});
</script>

<cfswitch expression="#Attributes.type#">
	<cfcase value="all">
		<cfset TotalRecords = 0>
		<cfset TotalRecords = qSearchActivities.RecordCount + qSearchPeople.RecordCount>
		<div class="results">
			<!--- ACTIVITIES (top 3) --->
			<cfif qSearchActivities.RecordCount GT 0>
			<div class="result-block">
				<h3><img src="/admin/_images/icons/book.png" border="0" /><cfoutput>Activities<span>#qSearchActivities.RecordCount# results</span></cfoutput></h3>
				<cfoutput query="qSearchActivities" maxrows="3">
					#Application.SearchResult.Activity(Application.UDF.QueryToStruct(qSearchActivities,qSearchActivities.CurrentRow),'search')#
				</cfoutput>
			</div>
			<cfoutput><div class="results-meta"><a href="#myself#main.search?type=activities&q=#Attributes.q#">View All Activity Results &raquo;</a></div></cfoutput>
			</cfif>
				
			
			<!--- PEOPLE (top 3) --->
			<cfif qSearchPeople.RecordCount GT 0>
			<div class="result-block">
			<h3><img src="/admin/_images/icons/user.png" border="0" /><cfoutput>People<span>#qSearchPeople.RecordCount# results</span></cfoutput></h3>
			<cfoutput query="qSearchPeople" maxrows="3">
				<div class="result">
					<!---<div class="result-photo">
						<cfset Photo = StructNew()>
						<cfset Photo.PhotoID = UserPhotoID>
						<cfset Photo.PhotoExt = UserPhotoExt>
						#Application.Photo.RenderHTML(Photo,'c','t',false)#
					</div>--->
					<div class="result-detail">
						<div class="result-link"><a href="/#URLName#">#DisplayName#</a></div>
						<div class="result-info">
							<cfif City NEQ ""><span>Location:</span> #City#</cfif>
						</div>
					</div>
					<div class="result-actions">
						<ul>
							<li><a href="/#URLName#">View Owner Profile</a></li>
							<cfif NOT Compare(Session.UserID,qSearchPeople.UserID) EQ 0><li><a href="javascript://" id="star-garage-#qSearchPeople.UserID#-#qSearchPeople.StarCount#" class="star-garage"><cfif qSearchPeople.StarCount GT 0>Unstar<cfelse>Star</cfif> this garage</a></li></cfif>
						</ul>
					</div>
				
				</div>
			</cfoutput>
			</div>
			<cfoutput><div class="results-meta"><a href="#myself#main.search?type=owners&q=#Attributes.q#">View All Owner Results &raquo;</a></div></cfoutput>
			</cfif>
		</div>
	</cfcase>
	<cfcase value="activities">
		<cfparam name="Attributes.ActivityTypeID" default="0" />
		<cfparam name="Attributes.CategoryID" default="0" />
		<cfparam name="Attributes.ActivityTypeID" default="0" />
		<cfoutput>
		<form action="#myself#main.search" method="get" name="frmActivitySearch" id="frmActivitySearch" class="formSearch">
			<input type="hidden" name="q" id="refine-q" value="#Attributes.q#" />
			<input type="hidden" name="type" value="activities" />
		<div class="criteria">
			<div class="criteria-item">
				<input type="text" name="StartDate" id="ReleaseDate" value="#DateFormat(Attributes.StartDate,'MM/DD/YYYY')#" style="width:75px;" />
			</div>
			<div class="criteria-item">
				<cfset qActivityTypeList = Application.Com.ActivityTypeGateway.getByAttributes(DeletedFlag='N')>
				<select name="ActivityTypeID" id="ActivityTypeID" style="width:120px;">
					<option value="0">Any Type</option>
					<cfloop query="qActivityTypeList">
					<option value="#qActivityTypeList.ActivityTypeID#"<cfif Attributes.ActivityTypeID EQ qActivityTypeList.ActivityTypeID> Selected</cfif>>#qActivityTypeList.Name#</option>
					</cfloop>
				</select>
			</div>
			<div class="criteria-item">
				<select name="GroupingID" id="Grouping" disabled="true" style="width:120px;"></select>
			</div>
			<cfset qCategories = Application.Com.CategoryGateway.getByAttributes(OrderBy="Name")>
			<cfset qPersonalCats = Application.Com.CategoryGateway.getByCookie(TheList=Cookie.Settings.Containers,OrderBy="Name")>
			<div class="criteria-item">
				<select name="CategoryID" id="CategoryID" style="width:120px;">
                    <option value="0">Any Container</option>
					<cfif qPersonalCats.RecordCount GT 0>
					<option value="0">---- Your Containers ----</option>
						<cfloop query="qPersonalCats">
						<option value="#qPersonalCats.CategoryID#"<cfif Attributes.CategoryID EQ qPersonalCats.CategoryID> Selected</cfif>>#qPersonalCats.Name#</option>
						</cfloop>
					<option value="0">--- All Other Containers ----</option>
					</cfif>
					
                    <cfloop query="qCategories">
						<cfif NOT ListFind(Cookie.Settings.Containers,qCategories.CategoryID,",")>
                        <option value="#qCategories.CategoryID#"<cfif Attributes.CategoryID EQ qCategories.CategoryID> Selected</cfif>>#qCategories.Name#</option>
						</cfif>
                    </cfloop>
                </select>
			</div>
			<div class="criteria-item">
				<input type="submit" value="Refine Search" class="button" name="submit" />
			</div>
		</div>
		</form>
		</cfoutput>
		<div class="results">
		<cfif qSearchActivities.RecordCount GT 0>
			<cfoutput query="qSearchActivities" startrow="#SearchPager.getStartRow()#" maxrows="#SearchPager.getMaxRows()#">
				#Application.SearchResult.Activity(Application.UDF.QueryToStruct(qSearchActivities,qSearchActivities.CurrentRow),'search')#
			</cfoutput>
			<cfif SearchPager.getTotalNumberOfPages() GT 1><div style="clear:both;"><cfoutput>#SearchPager.getRenderedHTML()#</cfoutput></div></cfif>
		<cfelse>
			<cfoutput>
			<div class="error">No <strong>activities</strong> found with that criteria.</div>
			<div class="info"><b>Do you have an activity to enter?<div style="height:5px;"></div><button onClick="window.location='#myself#activity.create';">Create activity</button></b></div></cfoutput>
		</cfif>
		</div>
	</cfcase>
	<cfcase value="people">
		<cfif Attributes.q NEQ "">
		<script language="javascript" type="text/javascript" src="/_scripts/search/garages.js"></script>
		<cfoutput>
		<form action="#myself#main.search" method="get" name="frmOwnerSearch" id="frmOwnerSearch" class="formSearch">
			<input type="hidden" name="type" value="owners" />
			<input type="hidden" name="q" id="refine-q" value="#Attributes.q#" />
		<div class="criteria">
			<div class="criteria-item">
				<input type="text" name="Location" id="Location" value="#Attributes.Location#" />
			</div>
			<div class="criteria-item">
				<input type="submit" value="Refine Search" class="button" name="submit" />
			</div>
		</div>
		</form>
		</cfoutput>
		
		<div class="results">
		<cfif qSearchPeople.RecordCount GT 0>
			<cfoutput query="qSearchPeople" startrow="#SearchPager.getStartRow()#" maxrows="#SearchPager.getMaxRows()#">
				<div class="result">
					<div class="result-photo">
						<cfset Photo = StructNew()>
						<cfset Photo.PhotoID = UserPhotoID>
						<cfset Photo.PhotoExt = UserPhotoExt>
						#Application.Photo.RenderHTML(Photo,'c','t',false)#
					</div>
					<div class="result-detail">
						<div class="result-link"><a href="/#URLName#">#DisplayName#</a></div>
						<div class="result-info">
							<cfif City NEQ ""><span>Location:</span> #City#</cfif>
						</div>
					</div>
					<div class="result-actions">
						<ul>
							<li><a href="/#URLName#">View Owner Profile</a></li>
							<cfif NOT Compare(Session.UserID,qSearchPeople.UserID) EQ 0><li><a href="javascript://" id="star-garage-#qSearchPeople.UserID#-#qSearchPeople.StarCount#" class="star-garage"><cfif qSearchPeople.StarCount GT 0>Unstar<cfelse>Star</cfif> this garage</a></li></cfif>
						</ul>
					</div>
				
				</div>
			</cfoutput>
			<cfif SearchPager.getTotalNumberOfPages() GT 1><div style="clear:both;"><cfoutput>#SearchPager.getRenderedHTML()#</cfoutput></div></cfif>
		<cfelse>
			<div class="error">No <strong>owners</strong> found with that criteria.</div>
		</cfif>
		</div>
		</cfif>
	</cfcase>
</cfswitch>
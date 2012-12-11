<cfoutput>

<div class="ContentBlock">
	<h1>My Curriculum</h1>
	<p>
    	<div class="ActiveActivities">
        	<cfquery name="qActiveActivities" dbtype="query">
            	SELECT *
                FROM qActivities
                WHERE StatusID = 2
            </cfquery>

           
                <h2 class="Head Red">Activities In Progress</h2>
                    <p><cfif qActiveActivities.RecordCount GT 0>
					<cfloop query="qActiveActivities">
                    <a href="#Myself#Activity.Detail?ActivityID=#qActiveActivities.ActivityID#">#qActiveActivities.ActivityTitle#</a><br />
                    </cfloop> <cfelse>
					No activities in progress.
					 </cfif></p>
           
        </div>
        
    	<div class="RegisteredActivities">
        	<cfquery name="qRegisteredActivities" dbtype="query">
            	SELECT *
                FROM qActivities
                WHERE StatusID = 4
            </cfquery>
            
			<h2 class="Head Gray">Registered Activities</h2>
            <p><cfif qRegisteredActivities.RecordCount GT 0>
                     <cfloop query="qRegisteredActivities">
                   <a href="#Myself#Activity.Detail?ActivityID=#qRegisteredActivities.ActivityID#">#qRegisteredActivities.ActivityTitle#</a><br />
                    </cfloop>
			<cfelse>
				No registered activities.
            </cfif></p>
        </div>
        
        <div class="CompletedActivities">
        	<cfquery name="qCompletedActivities" dbtype="query">
            	SELECT *
                FROM qActivities
                WHERE StatusID = 4
            </cfquery>
            
			<h2 class="Head LightGray">Completed Activities</h2>
			<p>
			<cfif qCompletedActivities.RecordCount GT 0>
				<cfloop query="qCompletedActivities">
				<a href="#Myself#Activity.Detail?ActivityID=#qCompletedActivities.ActivityID#">#qCompletedActivities.ActivityTitle#</a><br />
				</cfloop>
			<cfelse>
				No completed activities.
			</cfif></p>
        </div>
    	<!---<cfset ActivityCount = 0>
        <div class="FailedActivities">
        	<h3>- Failed Activities</h3>
        	<p><strong>This section displays activities you have failed.</strong></p>
        	<cfloop query="qActivities">
            <cfif qActivities.StatusID EQ 3>
            <p><a href="#Myself#Activity.Detail?ActivityID=#qActivities.ActivityID#">#qActivities.ActivityTitle#</a></p>
            <cfelse>
    			<cfset ActivityCount = ActivityCount + 1>
            </cfif>
            </cfloop>
            <cfif ActivityCount EQ qActivities.RecordCount>
            	<p>There are no failed activities.</p>
            </cfif>
        </div>--->
	</p>
</div>
</cfoutput>
<cfcomponent displayname="Daily Attendee Status Changes" output="no">
	<cffunction name="Run" output="no" access="remote" returntype="string" returnformat="plain">
		<cfargument name="sendEmail" type="string" default="1" required="no" />
		
		<cfcontent type="text/javascript" />
		<cfset var returnData = createobject("component","_com.returnData.buildStruct").init() />
		<cfset var recordsUpdated = [] />
		<cfset returnData.setStatus(false) />
		<cfset returnData.setStatusMsg('failed for unknown reason') />

		<cfquery name="qUpdater" datasource="#Application.Settings.DSN#">
			SELECT Attendee.*,
				activity.startdate,activity.enddate+'23:59:59' As EndDate,Person.Email 
			FROM ce_Attendee As Attendee
			LEFT JOIN ce_person AS Person ON Person.personid = Attendee.personid
			LEFT JOIN ce_activity AS Activity ON Activity.activityID = attendee.activityid
			WHERE     
			( Attendee.AttendeeID IN
				(SELECT
					Att.AttendeeID
				FROM          
					ce_Attendee AS Att 
				INNER JOIN
					ce_Activity AS A ON Att.ActivityID = A.ActivityID
				WHERE      
					(A.StatusID IN (1, 2, 3)) AND 
					(A.ActivityTypeID <> 2) AND 
					(A.DeletedFlag = 'N') AND  
					(A.EndDate < GETDATE())))
			AND
				 Attendee.DeletedFlag='N'
				AND  
				Attendee.StatusID <> 1
			AND Attendee.created > '1/1/2008 00:00:00'
			
			OR
			
			(AttendeeID IN
				(SELECT
					Att.AttendeeID
				FROM          
					ce_Attendee AS Att 
				INNER JOIN
					ce_Activity AS A ON Att.ActivityID = A.ActivityID
				WHERE      
					(A.StatusID IN (1, 2, 3)) AND 
					(A.ActivityTypeID <> 2) AND
					(A.DeletedFlag = 'N') AND
					(A.EndDate < GETDATE())))
			AND
			 Attendee.DeletedFlag='N'
			AND Attendee.StatusID = 1
			AND  Attendee.CompleteDate NOT BETWEEN activity.startDate AND activity.endDate + '23:59:59'
			AND Attendee.created > '1/1/2007 00:00:00'
			ORDER BY activityId
		</cfquery>
		
		<cfloop query="qUpdater">
			<cfquery name="qUpdate" datasource="#application.settings.dsn#">
				UPDATE 
					ce_Attendee
				SET
					StatusID = 1, 
					CheckOut = GETDATE(),
					CompleteDate = #createODBCDateTime('#dateFormat(qUpdater.endDate,'mm/dd/yyyy')# 00:00:00')#,
					Updated=getDate(),
					UpdatedBy=169841
				WHERE attendeeId=#qUpdater.attendeeId#
			</cfquery>
			
			<cfif arguments.sendEmail GT 0>
				<cftry>
					<cfset application.email.send(EmailStyleID=5,ToAttendeeID=qUpdater.AttendeeID,ToActivityID=qUpdater.activityId,ToPersonID=qUpdater.PersonID,ToCreditID=1) />
					
					<cfcatch type="any">
					
					</cfcatch>
				</cftry>
			</cfif>
			<cfset recordsUpdated.add(QueryToStruct(qUpdater,qUpdater.currentRow)) />
		</cfloop>

		<cfset returnData.setStatus(true) />
		<cfset returnData.setStatusMsg("Successfully updated statuses.") />
		<cfset returnData.setPayload(recordsUpdated) />

		<cflog text="Status Updater ran successfully." file="ccpd_script_log">
		<cfreturn returnData.getJson() />
	</cffunction>
	<cffunction name="QueryToStruct" access="public" returntype="any" output="false"
	hint="Converts an entire query or the given record to a struct. This might return a structure (single record) or an array of structures.">

	<!--- Define arguments. --->
	<cfargument name="Query" type="query" required="true" />
	<cfargument name="Row" type="numeric" required="false" default="0" />

	<cfscript>

		// Define the local scope.
		var LOCAL = StructNew();

		// Determine the indexes that we will need to loop over.
		// To do so, check to see if we are working with a given row,
		// or the whole record set.
		if (ARGUMENTS.Row){

			// We are only looping over one row.
			LOCAL.FromIndex = ARGUMENTS.Row;
			LOCAL.ToIndex = ARGUMENTS.Row;

		} else {

			// We are looping over the entire query.
			LOCAL.FromIndex = 1;
			LOCAL.ToIndex = ARGUMENTS.Query.RecordCount;

		}

		// Get the list of columns as an array and the column count.
		LOCAL.Columns = ListToArray( ARGUMENTS.Query.ColumnList );
		LOCAL.ColumnCount = ArrayLen( LOCAL.Columns );

		// Create an array to keep all the objects.
		LOCAL.DataArray = ArrayNew( 1 );

		// Loop over the rows to create a structure for each row.
		for (LOCAL.RowIndex = LOCAL.FromIndex ; LOCAL.RowIndex LTE LOCAL.ToIndex ; LOCAL.RowIndex = (LOCAL.RowIndex + 1)){

			// Create a new structure for this row.
			ArrayAppend( LOCAL.DataArray, StructNew() );

			// Get the index of the current data array object.
			LOCAL.DataArrayIndex = ArrayLen( LOCAL.DataArray );

			// Loop over the columns to set the structure values.
			for (LOCAL.ColumnIndex = 1 ; LOCAL.ColumnIndex LTE LOCAL.ColumnCount ; LOCAL.ColumnIndex = (LOCAL.ColumnIndex + 1)){

				// Get the column value.
				LOCAL.ColumnName = LOCAL.Columns[ LOCAL.ColumnIndex ];

				// Set column value into the structure.
				LOCAL.DataArray[ LOCAL.DataArrayIndex ][ LOCAL.ColumnName ] = ARGUMENTS.Query[ LOCAL.ColumnName ][ LOCAL.RowIndex ];

			}

		}


		// At this point, we have an array of structure objects that
		// represent the rows in the query over the indexes that we
		// wanted to convert. If we did not want to convert a specific
		// record, return the array. If we wanted to convert a single
		// row, then return the just that STRUCTURE, not the array.
		if (ARGUMENTS.Row){

			// Return the first array item.
			return( LOCAL.DataArray[ 1 ] );

		} else {

			// Return the entire array.
			return( LOCAL.DataArray );

		}

	</cfscript>
</cffunction>
</cfcomponent>
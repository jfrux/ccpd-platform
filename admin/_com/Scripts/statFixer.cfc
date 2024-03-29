<cfcomponent displayname="Attendee Stat Fixer" output="no">
	<cffunction name="Run" output="no" access="remote" returntype="string" returnformat="plain">
		<cfargument name="ActivityID" type="numeric" required="no" default="0" />
		<cfargument name="mode" type="string" required="no" default="auto">
		<cfsetting requesttimeout="240" />
		<cfset var nUpdatedBy = 1 />
		<cfset var qSelector = "" />
		<cfset var qUpdater = "" />
		<cfset var returnData = createobject("component","_com.returnData.buildStruct").init() />
		<cfset var recordsUpdated = [] />
		<cfcontent type="text/javascript" />
		
		<cfset returnData.setStatus(false) />
		<cfset returnData.setStatusMsg('failed for unknown reason') />

		<cfswitch expression="#arguments.mode#">
			<cfcase value="auto">
				<cfset nUpdatedBy = 1 />
			</cfcase>
			<cfcase value="manual">
				<cfif structKeyExists(session,'personid') AND session.personid GT 0>
					<cfset nUpdatedBy = session.personid />
				</cfif>
			</cfcase>
			<cfdefaultcase>
				<cfset nUpdatedBy = 1 />
			</cfdefaultcase>
		</cfswitch>
		
		<cfquery name="qSelector" datasource="#Application.Settings.DSN#">
			SELECT
				A.ActivityID,
				A.StartDate,
				A.parentActivityId,
				EndDate = DATEADD(n, 1439, A.EndDate),
				StatHrs =
				isNull((CASE isNull(A.SessionType,'S')
					WHEN 'M' THEN 
						isNull((SELECT SUM(AC.Amount) AS TotalHours
								FROM ce_Activity_Credit AS AC 
								INNER JOIN ce_Activity AS A4 ON AC.ActivityID = A4.ActivityID
								WHERE (AC.CreditID = 1) AND (A4.ParentActivityID = A.ActivityID) AND AC.DeletedFlag='N' AND (A4.StatusID IN (1,2,3))),0)
					WHEN 'S' THEN 
						isNull((SELECT SUM(AC.Amount) AS TotalHours
								FROM ce_Activity_Credit AS AC 
								INNER JOIN ce_Activity AS A4 ON AC.ActivityID = A4.ActivityID
								WHERE (AC.CreditID = 1) AND (A4.ActivityID = A.ActivityID) AND AC.DeletedFlag='N' AND (A4.StatusID IN (1,2,3))),0)
				END),0),
				StatAttendees = 
					isNull((CASE isNull(A.SessionType,'S')
						WHEN 'M' THEN 
							CASE
								WHEN isNull(A.ParentActivityID,0) = 0 THEN
									(SELECT Count(Att.AttendeeID)
									 FROM ce_Attendee AS Att 
									 INNER JOIN ce_Activity AS A2 ON Att.ActivityID = A2.ActivityID
									 WHERE 
										(Att.StatusID = 1) AND (A2.ParentActivityID = A.ActivityID) AND (A2.StatusID IN (1,2,3)) AND (Att.CompleteDate BETWEEN A2.StartDate AND DATEADD(n, 1439, A2.EndDate)) AND (Att.DeletedFlag='N'))
								ELSE
									(SELECT Count(Att.AttendeeID)
									 FROM ce_Attendee AS Att 
									 INNER JOIN ce_Activity AS A2 ON Att.ActivityID = A2.ActivityID
									 WHERE 
										(Att.StatusID = 1) AND (A2.ActivityID = A.ActivityID) AND (A2.StatusID IN (1,2,3)) AND (Att.CompleteDate BETWEEN A2.StartDate AND DATEADD(n, 1439, A2.EndDate)) AND (Att.DeletedFlag='N'))
							END
						WHEN 'S' THEN
							(SELECT Count(Att.AttendeeID)
							 FROM ce_Attendee AS Att 
							 INNER JOIN ce_Activity AS A2 ON Att.ActivityID = A2.ActivityID
							 WHERE 
								(Att.StatusID = 1) AND (Att.ActivityID = a.ActivityID) AND (A2.StatusID IN (1,2,3)) AND (Att.CompleteDate BETWEEN A2.StartDate AND DATEADD(n, 1439, A2.EndDate)) AND (Att.DeletedFlag='N'))
					END),0),
					StatMD = 
					isNull((CASE isNull(A.SessionType,'S')
						WHEN 'M' THEN 
							CASE
								WHEN isNull(A.ParentActivityID,0) = 0 THEN
									(SELECT Count(Att.AttendeeID)
									 FROM ce_Attendee AS Att 
									 INNER JOIN ce_Activity AS A2 ON Att.ActivityID = A2.ActivityID
									 WHERE 
										(Att.StatusID = 1) AND (A2.ParentActivityID = A.ActivityID) AND (Att.MDflag = 'Y') AND (A2.StatusID IN (1,2,3)) AND (Att.CompleteDate BETWEEN A2.StartDate AND DATEADD(n, 1439, A2.EndDate)) AND (Att.DeletedFlag='N'))
								ELSE
									(SELECT Count(Att.AttendeeID)
									 FROM ce_Attendee AS Att 
									 INNER JOIN ce_Activity AS A2 ON Att.ActivityID = A2.ActivityID
									 WHERE 
										(Att.StatusID = 1) AND (A2.ActivityID = A.ActivityID) AND (Att.MDflag = 'Y') AND (A2.StatusID IN (1,2,3)) AND (Att.CompleteDate BETWEEN A2.StartDate AND DATEADD(n, 1439, A2.EndDate)) AND (Att.DeletedFlag='N'))
							END
						WHEN 'S' THEN
							(SELECT Count(Att.AttendeeID)
							 FROM ce_Attendee AS Att 
							 INNER JOIN ce_Activity AS A2 ON Att.ActivityID = A2.ActivityID
							 WHERE 
								(Att.StatusID = 1) AND (Att.ActivityID = a.ActivityID) AND (Att.MDflag = 'Y') AND (A2.StatusID IN (1,2,3)) AND (Att.CompleteDate BETWEEN A2.StartDate AND DATEADD(n, 1439, A2.EndDate)) AND (Att.DeletedFlag='N'))
					END),0),
					StatNonMD = 
					isNull((CASE isNull(A.SessionType,'S')
						WHEN 'M' THEN 
							CASE
								WHEN isNull(A.ParentActivityID,0) = 0 THEN
									(SELECT Count(Att.AttendeeID)
									 FROM ce_Attendee AS Att 
									 INNER JOIN ce_Activity AS A2 ON Att.ActivityID = A2.ActivityID
									 WHERE 
										(Att.StatusID = 1) AND 
										(A2.ParentActivityID = A.ActivityID) AND 
										(Att.MDflag = 'N') AND 
										(A2.StatusID IN (1,2,3)) AND 
										(Att.CompleteDate BETWEEN A2.StartDate AND DATEADD(n, 1439, A2.EndDate)) AND (Att.DeletedFlag='N'))
								ELSE
									(SELECT Count(Att.AttendeeID)
									 FROM ce_Attendee AS Att 
									 INNER JOIN ce_Activity AS A2 ON Att.ActivityID = A2.ActivityID
									 WHERE 
										(Att.StatusID = 1) AND 
										(A2.ActivityID = A.ActivityID) AND 
										(Att.MDflag = 'N') AND 
										(A2.StatusID IN (1,2,3)) AND 
										(Att.CompleteDate BETWEEN A2.StartDate AND DATEADD(n, 1439, A2.EndDate)) AND (Att.DeletedFlag='N'))
							END
						WHEN 'S' THEN
							(SELECT Count(Att.AttendeeID)
							 FROM ce_Attendee AS Att 
							 INNER JOIN ce_Activity AS A2 ON Att.ActivityID = A2.ActivityID
							 WHERE 
								(Att.StatusID = 1) AND (Att.ActivityID = a.ActivityID) AND (Att.MDflag = 'N') AND (A2.StatusID IN (1,2,3)) AND (Att.CompleteDate BETWEEN A2.StartDate AND DATEADD(n, 1439, A2.EndDate)) AND (Att.DeletedFlag='N'))
					END),0)+
					isNull((CASE isNull(A.SessionType,'S')
						WHEN 'M' THEN 
							CASE
								WHEN isNull(A.ParentActivityID,0) = 0 THEN
									(
									SELECT isNull(SUM(A2.statAddlAttendees),0)
									 FROM ce_Activity AS A2
									 WHERE 
										(A2.ParentActivityID = A.ActivityID) AND
										(A2.DeletedFlag='N') AND
										(A2.StatusID IN (1,2,3))
									)
								ELSE
									A.statAddlAttendees
							END
						WHEN 'S' THEN
							A.statAddlAttendees
					END),0)
					,
				StatSupporters = 
					isNull((CASE isNull(A.SessionType,'S')
						WHEN 'M' THEN 
							(SELECT     COUNT(FS.Amount)
							FROM         ce_Activity_FinSupport AS FS INNER JOIN
												  ce_Activity AS A5 ON FS.ActivityID = A5.ActivityID
							WHERE    
									(A5.ParentActivityID = A.ActivityID) AND 
									(A5.DeletedFlag='N') AND 
									(FS.SupportTypeID = 1) AND 
									(FS.DeletedFlag = 'N') AND
									(A5.StatusID IN (1,2,3))
								OR
									(A5.ActivityID = A.ActivityID) AND 
									(FS.DeletedFlag = 'N') AND 
									(A5.DeletedFlag = 'N') AND
									(FS.SupportTypeID = 1) AND 
									(A5.StatusID IN (1,2,3))
								OR
									(A5.ParentActivityID = A.ActivityID) AND 
									(A5.DeletedFlag='N') AND 
									(FS.DeletedFlag = 'N') AND 
									(FS.SupportTypeID = 1) AND 
									(A5.StatusID IN (1,2,3))
							)
						WHEN 'S' THEN
							(SELECT     COUNT(Amount) AS Expr1
							FROM         ce_Activity_FinSupport
							WHERE     (SupportTypeID = 1) AND (DeletedFlag = 'N') AND (ActivityID=a.ActivityID))
					END),0)
					,
					(CASE isNull((CASE isNull(A.SessionType,'S')
						WHEN 'M' THEN 
							(SELECT     COUNT(FS.Amount)
							FROM         ce_Activity_FinSupport AS FS INNER JOIN
												  ce_Activity AS A5 ON FS.ActivityID = A5.ActivityID
							WHERE 
									(A5.ParentActivityID = A.ActivityID) AND 
									(A5.DeletedFlag='N') AND 
									(FS.SupportTypeID = 1) AND 
									(FS.DeletedFlag = 'N') AND
									(A5.StatusID IN (1,2,3))
								OR
									(A5.ActivityID = A.ActivityID) AND 
									(FS.DeletedFlag = 'N') AND 
									(A5.DeletedFlag = 'N') AND
									(FS.SupportTypeID = 1) AND 
									(A5.StatusID IN (1,2,3))
								OR
									(A5.ParentActivityID = A.ActivityID) AND 
									(A5.DeletedFlag='N') AND 
									(FS.DeletedFlag = 'N') AND 
									(FS.SupportTypeID = 1) AND 
									(A5.StatusID IN (1,2,3))
							)
						WHEN 'S' THEN
							(SELECT     COUNT(Amount) AS Expr1
							FROM         ce_Activity_FinSupport
							WHERE     (SupportTypeID = 1) AND (DeletedFlag = 'N') AND (ActivityID=a.ActivityID))
					END),0)
						WHEN '0' THEN 'No'
						ELSE 'Yes'
					END) AS SupportReceived,
					StatSuppAmount = 
					isNull((CASE isNull(A.SessionType,'S')
						WHEN 'M' THEN 
							(SELECT     SUM(FS.Amount)
							FROM         ce_Activity_FinSupport AS FS INNER JOIN
										 ce_Activity AS A5 ON FS.ActivityID = A5.ActivityID
							WHERE     
								(A5.ParentActivityID = A.ActivityID) AND 
								(A5.DeletedFlag='N') AND 
								(FS.SupportTypeID = 1) AND 
								(FS.DeletedFlag = 'N') AND
								(A5.StatusID IN (1,2,3))
							OR
								(A5.ActivityID = A.ActivityID) AND 
								(FS.DeletedFlag = 'N') AND 
								(A5.DeletedFlag = 'N') AND
								(FS.SupportTypeID = 1) AND 
								(A5.StatusID IN (1,2,3))
							OR
								(A5.ParentActivityID = A.ActivityID) AND 
								(A5.DeletedFlag='N') AND 
								(FS.DeletedFlag = 'N') AND 
								(FS.SupportTypeID = 1) AND 
								(A5.StatusID IN (1,2,3))
							)
						WHEN 'S' THEN
							(SELECT     SUM(A6.Amount) AS Expr1
							FROM         ce_Activity_FinSupport As A6
							WHERE     (A6.SupportTypeID = 1) AND (A6.DeletedFlag = 'N') AND (A6.ActivityID=A.ActivityID))
					END),0)
			FROM 
				ce_Activity A
			WHERE
				0 = 0
				AND (A.DeletedFlag = 'N')
			<cfif Arguments.ActivityID GT 0>
				AND (A.ActivityID=<cfqueryparam value="#Arguments.ActivityID#" cfsqltype="cf_sql_integer" />)
			<cfelse>
				AND (A.startDate > '1/1/2007')
				AND (A.refreshFlag=1)
				AND (A.statusid IN (1,2,3))
			</cfif>
		</cfquery>
		
		<cfloop query="qSelector">
			#qSelector.activityId#,
			<cfquery name="qUpdater" datasource="#Application.Settings.DSN#">
				UPDATE ce_Activity
				SET 
					StatCMEHours=#qSelector.StatHrs#,
					StatAttendees=#qSelector.StatAttendees#,
					StatMD = #qSelector.StatMD#,
					StatNonMD = #qSelector.StatNonMD#,
					StatSupporters = #qSelector.StatSupporters#,
					StatSuppAmount =#qSelector.StatSuppAmount#,
					refreshFlag = 0,
					updated = getDate(),
					updatedBy = <cfqueryparam value="#nUpdatedBy#" cfsqltype="cf_sql_integer" />
				WHERE ActivityID=#qSelector.ActivityID#
			</cfquery>
			<cfset recordsUpdated.add(QueryToStruct(qSelector,qSelector.currentrow)) />
			<cfset Application.History.Add(
		          HistoryStyleID=114,
		          FromPersonID=1,
		          ToActivityID=qSelector.activityId
		    ) />
			<cfif qSelector.parentActivityId GT 0>
				<cfset run(qSelector.parentActivityId) />
			</cfif>
		</cfloop>

		<cfset returnData.setStatus(true) />
		<cfset returnData.setStatusMsg('Stats are up to date!') />
		<cfset returnData.setPayload(recordsUpdated) />
		<cflog text="Stat Fixer script ran successfully." file="ccpd_script_log">
		
		<cfreturn returnData.getJSON() />
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
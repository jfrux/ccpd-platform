<cfif Attributes.submitted>
	
		<!--- 
			Now that the form has beefn submitted, let's clean 
			up the data a little.
		--->
		<cfif Attributes.is_all_day>
			
			<!--- Make sure an all day event has no time. --->
			<cfset Attributes.time_started = "" />
			<cfset Attributes.time_ended = "" />
			
		</cfif>
		
		<!--- Make sure date contains only date. --->
		<cfif IsDate( Attributes.date_started )>
		
			<cfset Attributes.date_started = DateFormat(
				Fix( Attributes.date_started ),
				"mm/dd/yyyy"
				) />
			
		</cfif>
		
		<!--- Make sure date contains only date. --->
		<cfif IsDate( Attributes.date_ended )>
		
			<cfset Attributes.date_ended = DateFormat(
				Fix( Attributes.date_ended ),
				"mm/dd/yyyy"
				) />
			
		</cfif>
		
		<!--- Make sure time contains only time. --->
		<cfif IsDate( Attributes.time_started )>
		
			<cfset Attributes.time_started = TimeFormat(
				Attributes.time_started,
				"hh:mm TT"
				) />
			
		</cfif>
		
		<!--- Make sure time contains only time. --->
		<cfif IsDate( Attributes.time_ended )>
		
			<cfset Attributes.time_ended = TimeFormat(
				Attributes.time_ended,
				"hh:mm TT"
				) />
			
		</cfif>
		
		<!--- 
			Check to see if we have a "viewas" date. If we don't
			then, we have NO choice but to update the entire series.
		--->
		<cfif NOT Attributes.ViewAs>
		
			<!--- Update entire series. --->
			<cfset Attributes.update_type = 1 />
		
		</cfif>
	
		
		<!--- 
			Now that the form has been submitted, let's 
			validate the data.
		--->
		<cfif NOT Len( Attributes.EventName )>
			<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please enter an event name","|")>
		</cfif>
		
		<cfif NOT IsDate( Attributes.date_started )>
			<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please enter a start date","|")>
		</cfif>
		
		<cfif (
			Len( Attributes.date_ended ) AND 
			(NOT IsDate( Attributes.date_ended ))
			)>
			<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please enter a valid end date","|")>
		</cfif>
		
		<cfif (
			IsDate( Attributes.date_ended ) AND 
			IsDate( Attributes.date_started ) AND
			(Attributes.date_ended LT Attributes.date_started)
			)>
			<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please enter an end date that is greater to or equal to the start date.","|")>
		</cfif>
		
		<!--- We only need to check time if it is NOT an all day event. --->
		<cfif NOT Attributes.is_all_day>
		
			<cfif (
				(NOT Len( Attributes.time_started )) OR
				(NOT IsDate( Attributes.time_started ))
				)>
				<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please enter a valid start time","|")>
			</cfif>
			
			<cfif (
				(NOT Len( Attributes.time_ended )) OR
				(NOT IsDate( Attributes.time_ended ))
				)>
				<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please enter a valid end time","|")>
			</cfif>
			
			<cfif (
				IsDate( Attributes.time_ended ) AND 
				IsDate( Attributes.time_started ) AND
				(Attributes.time_ended LTE Attributes.time_started)
				)>
				<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please enter an end time that is greater than the start time.","|")>
			</cfif>
		
		</cfif>
		
		<!--- 
			Check for repeat type. We need it if we have 
			anything more than one day.
		--->
		<cfif (
			IsDate( Attributes.date_started ) AND
			IsDate( Attributes.date_ended ) AND
			(Fix( Attributes.date_started ) NEQ Fix( Attributes.date_ended )) AND
			(NOT Attributes.repeat_type)
			)>
			<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please select a repeat type for this event.","|")>		
		</cfif>
		
		<!--- Check to make sure are "Viewas" date is valid. --->
		<cfif (
			qEvent.RecordCount AND
			Attributes.ViewAs AND
			(
				(Attributes.ViewAs LT qEvent.date_started) OR
				(
					IsDate( qEvent.date_ended ) AND
					(Attributes.ViewAs GT qEvent.date_ended)
				)
			))>
			<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"The event date does not appear to be valid.","|")>		
		</cfif>
		
	
		<!--- Check to see if there are any form errors. --->
		<cfif NOT ListLen(Request.Status.Errors,"|")>
		
			<!--- Clean up the form data before update. --->
			<cfif NOT Attributes.repeat_type>
			
				<!--- Its a one-day event. --->
				<cfset Attributes.date_ended = Attributes.date_started />
			
			</cfif>
			
			<cfif (
				IsDate( Attributes.date_started ) AND 
				IsDate( Attributes.date_ended ) AND
				(Fix( Attributes.date_started ) EQ Fix( Attributes.date_ended ))
				)>
			
				<!--- No repeat date for single-day events. --->
				<cfset Attributes.repeat_type = 0 />
			
			</cfif>
			
			<!--- Make 24-hour times. --->
			<cfif IsDate( Attributes.time_started )>

				<cfset Attributes.time_started = TimeFormat( Attributes.time_started, "HH:mm" ) />
				
			</cfif>
			
			<!--- Make 24-hour times. --->
			<cfif IsDate( Attributes.time_ended )>

				<cfset Attributes.time_ended = TimeFormat( Attributes.time_ended, "HH:mm" ) />
				
			</cfif>
			
			
			<!--- Check to see if we are dealing with an existing event or a new event. --->
			<cfif qEvent.RecordCount>
			
				<!--- 
					We are dealing with an existing event. Now, we 
					have to be careful about the update type.
				--->
				<cfswitch expression="#Attributes.update_type#">
				
					<!--- All future instances in series. --->
					<cfcase value="2">
					
						<!--- 
							Since we are updating all future instances, we are 
							going to split this event in half. The previous half 
							will be all the days that prior to "viewas". The new 
							event will be everthing going forward.
						--->
						
						<!--- Update existing event. --->
						<cfquery name="qUpdate" datasource="#Application.Settings.DSN#">
							UPDATE
								ce_Event
							SET
								date_ended = <cfqueryparam value="#(Attributes.ViewAs - 1)#" cfsqltype="CF_SQL_TIMESTAMP" />,
								date_updated = <cfqueryparam value="#Now()#" cfsqltype="CF_SQL_TIMESTAMP" />
							WHERE
								id = <cfqueryparam value="#Attributes.EventID#" cfsqltype="CF_SQL_INTEGER" />						
						</cfquery>
						
						
						<!--- Now, let's insert the new event. --->
						<cfquery name="qInsert" datasource="#Application.Settings.DSN#">
							INSERT INTO ce_Event
							(
								name,
								description,
								date_started,
								date_ended,
								time_started,
								time_ended,
								is_all_day,
								repeat_type,
								color,
								date_updated,
								date_created,
								ActivityID
							) VALUES (
								<cfqueryparam value="#Attributes.EventName#" cfsqltype="CF_SQL_VARCHAR" />, 				<!--- name --->
								<cfqueryparam value="#attributes.EventDesc#" cfsqltype="CF_SQL_VARCHAR" />, 		<!--- description --->
								<cfqueryparam value="#Attributes.date_started#" cfsqltype="CF_SQL_TIMESTAMP" />, 		<!--- date_started --->
								<cfqueryparam value="#Attributes.date_ended#" cfsqltype="CF_SQL_TIMESTAMP" null="#NOT IsNumericDate( Attributes.date_ended )#" />, 		<!--- date_ended --->
								<cfqueryparam value="#Attributes.time_started#" cfsqltype="CF_SQL_VARCHAR" />, 		<!--- time_started --->
								<cfqueryparam value="#Attributes.time_ended#" cfsqltype="CF_SQL_VARCHAR" />, 			<!--- time_ended --->
								<cfqueryparam value="#Attributes.is_all_day#" cfsqltype="CF_SQL_TINYINT" />, 			<!--- is_all_day --->
								<cfqueryparam value="#Attributes.repeat_type#" cfsqltype="CF_SQL_TINYINT" />, 		<!--- repeat_type --->
								<cfqueryparam value="#Attributes.color#" cfsqltype="CF_SQL_VARCHAR" />, 				<!--- color --->
								<cfqueryparam value="#Now()#" cfsqltype="CF_SQL_TIMESTAMP" />, 					<!--- date_updated --->
								<cfqueryparam value="#Now()#" cfsqltype="CF_SQL_TIMESTAMP" /> , 					<!--- date_updated --->
								<cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" /> 
							); SELECT @@Identity As NewEventID;
						</cfquery>
					</cfcase>
					
					<!--- Just this instance. --->
					<cfcase value="3">
					
						<!--- 
							Since we are updating just this instance, we are 
							basically creating an event exception and a new event.
						--->
						
						<!--- Insert new, single-day event. --->
						<cfquery name="qInsert" datasource="#Application.Settings.DSN#">
							INSERT INTO ce_Event
							(
								name,
								description,
								date_started,
								date_ended,
								time_started,
								time_ended,
								is_all_day,
								repeat_type,
								color,
								date_updated,
								date_created,
								ActivityID
							) VALUES (
								<cfqueryparam value="#Attributes.EventName#" cfsqltype="CF_SQL_VARCHAR" />, 				<!--- name --->
								<cfqueryparam value="#attributes.EventDesc#" cfsqltype="CF_SQL_VARCHAR" />, 		<!--- description --->
								<cfqueryparam value="#Attributes.date_started#" cfsqltype="CF_SQL_TIMESTAMP" />, 		<!--- date_started --->
								<cfqueryparam value="#Attributes.date_ended#" cfsqltype="CF_SQL_TIMESTAMP" null="#NOT IsNumericDate( Attributes.date_ended )#" />, 		<!--- date_ended --->
								<cfqueryparam value="#Attributes.time_started#" cfsqltype="CF_SQL_VARCHAR" />, 		<!--- time_started --->
								<cfqueryparam value="#Attributes.time_ended#" cfsqltype="CF_SQL_VARCHAR" />, 			<!--- time_ended --->
								<cfqueryparam value="#Attributes.is_all_day#" cfsqltype="CF_SQL_TINYINT" />, 			<!--- is_all_day --->
								<cfqueryparam value="0" cfsqltype="CF_SQL_TINYINT" />, 							<!--- repeat_type --->
								<cfqueryparam value="#Attributes.color#" cfsqltype="CF_SQL_VARCHAR" />, 				<!--- color --->
								<cfqueryparam value="#Now()#" cfsqltype="CF_SQL_TIMESTAMP" />, 					<!--- date_updated --->
								<cfqueryparam value="#Now()#" cfsqltype="CF_SQL_TIMESTAMP" /> , 					<!--- date_updated --->
								<cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" />
							); SELECT @@Identity As NewEventID;
						</cfquery>
						
						<!--- Insert exception. --->
						<cfquery name="qInsertException" datasource="#Application.Settings.DSN#">
							INSERT INTO ce_Event_Exception
							(
								[date],
								event_id
							) VALUES (
								<cfqueryparam value="#Attributes.ViewAs#" cfsqltype="CF_SQL_TIMESTAMP" />,
								<cfqueryparam value="#Attributes.EventID#" cfsqltype="CF_SQL_INTEGER" />
							);
						</cfquery>
					
					</cfcase>
					
					<!--- All instances in series. --->
					<cfdefaultcase>
					
						<!--- Since this is a straight forward update, just update the record. --->
						<cfquery name="qUpdate" datasource="#Application.Settings.DSN#">
							UPDATE
								ce_Event
							SET
								name = <cfqueryparam value="#Attributes.EventName#" cfsqltype="CF_SQL_VARCHAR" />, 					<!--- name --->
								description = <cfqueryparam value="#attributes.EventDesc#" cfsqltype="CF_SQL_VARCHAR" />, 		<!--- description --->
								date_started = <cfqueryparam value="#Attributes.date_started#" cfsqltype="CF_SQL_TIMESTAMP" />, 	<!--- date_started --->
								date_ended = <cfqueryparam value="#Attributes.date_ended#" cfsqltype="CF_SQL_TIMESTAMP" null="#NOT IsNumericDate( Attributes.date_ended )#" />, 		<!--- date_ended --->
								time_started = <cfqueryparam value="#Attributes.time_started#" cfsqltype="CF_SQL_VARCHAR" />, 	<!--- time_started --->
								time_ended = <cfqueryparam value="#Attributes.time_ended#" cfsqltype="CF_SQL_VARCHAR" />, 		<!--- time_ended --->
								is_all_day = <cfqueryparam value="#Attributes.is_all_day#" cfsqltype="CF_SQL_TINYINT" />, 		<!--- is_all_day --->
								repeat_type = <cfqueryparam value="#Attributes.repeat_type#" cfsqltype="CF_SQL_TINYINT" />, 		<!--- repeat_type --->
								color = <cfqueryparam value="#Attributes.color#" cfsqltype="CF_SQL_VARCHAR" />, 					<!--- color --->
								date_updated = <cfqueryparam value="#Now()#" cfsqltype="CF_SQL_TIMESTAMP" /> 	,			<!--- date_updated --->
								ActivityID=<cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" />
							WHERE
								id = <cfqueryparam value="#Attributes.EventID#" cfsqltype="CF_SQL_INTEGER" />						
						</cfquery>
					
					</cfdefaultcase>
										
				</cfswitch>
			
			
			<cfelse>
			
			
				<!--- This is a new event. --->
			
				<!--- Insert event. --->
				<cfquery name="qInsert" datasource="#Application.Settings.DSN#">
					INSERT INTO ce_Event
					(
						name,
						description,
						date_started,
						date_ended,
						time_started,
						time_ended,
						is_all_day,
						repeat_type,
						color,
						date_updated,
						date_created,
						ActivityID
					) VALUES (
						<cfqueryparam value="#Left( Attributes.EventName, 80 )#" cfsqltype="CF_SQL_VARCHAR" />, 	<!--- name --->
						<cfqueryparam value="#attributes.EventDesc#" cfsqltype="CF_SQL_VARCHAR" />, 		<!--- description --->
						<cfqueryparam value="#Attributes.date_started#" cfsqltype="CF_SQL_TIMESTAMP" />, 		<!--- date_started --->
						<cfqueryparam value="#Attributes.date_ended#" cfsqltype="CF_SQL_TIMESTAMP" null="#NOT IsNumericDate( Attributes.date_ended )#" />, 		<!--- date_ended --->
						<cfqueryparam value="#Attributes.time_started#" cfsqltype="CF_SQL_VARCHAR" />, 		<!--- time_started --->
						<cfqueryparam value="#Attributes.time_ended#" cfsqltype="CF_SQL_VARCHAR" />, 		<!--- time_ended --->
						<cfqueryparam value="#Attributes.is_all_day#" cfsqltype="CF_SQL_TINYINT" />, 			<!--- is_all_day --->
						<cfqueryparam value="#Attributes.repeat_type#" cfsqltype="CF_SQL_TINYINT" />, 		<!--- repeat_type --->
						<cfqueryparam value="#Attributes.color#" cfsqltype="CF_SQL_VARCHAR" />, 				<!--- color --->
						<cfqueryparam value="#Now()#" cfsqltype="CF_SQL_TIMESTAMP" />, 					<!--- date_updated --->
						<cfqueryparam value="#Now()#" cfsqltype="CF_SQL_TIMESTAMP" /> , 					<!--- date_updated --->
								<cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" />
					); SELECT @@Identity As NewEventID;
				</cfquery>
			
			</cfif>
		
			<!--- Go to month view. --->
			<cfif Attributes.ViewAs>
			
				<cflocation
					url="#myself#Activity.Calendar&ActivityID=#Attributes.ActivityID#&Mode=Month&Date=#Attributes.ViewAs#"
					addtoken="false"
					/>
			
			<cfelse>
			
				<cflocation
					url="#myself#Activity.Calendar&ActivityID=#Attributes.ActivityID#&Mode=Month&Date=#Fix( Attributes.date_started )#"
					addtoken="false"
					/>
					
			</cfif>
		
		</cfif>
	
	<cfelse>
	
		<!---
			The form has not yet been submitted, so, if 
			we have an event, let's initialize the value.
		--->
		<cfif qEvent.RecordCount>
		
			<!--- Populate form fields. --->
			<cfset Attributes.EventName = qEvent.name />
			<cfset attributes.EventDesc = qEvent.description />
			<cfset Attributes.date_started = qEvent.date_started />
			<cfset Attributes.date_ended = qEvent.date_ended />
			<cfset Attributes.time_started = qEvent.time_started />
			<cfset Attributes.time_ended = qEvent.time_ended />
			<cfset Attributes.is_all_day = qEvent.is_all_day />
			<cfset Attributes.repeat_type = qEvent.repeat_type />
			<cfset Attributes.color = qEvent.color />
		
		<cfelse>
		
			<!--- Make sure we have no id set. --->
			<cfset Attributes.EventID = 0 />
						
			<!--- Default to all day event. --->
			<cfset Attributes.is_all_day = 1 />
			
			<!--- Check to see if we have a default date. --->
			<cfif Attributes.ViewAs>
				<cfset Attributes.date_started = DateFormat( Attributes.ViewAs, "mm/dd/yyyy" ) />
			<cfelse>
				<cfset Attributes.date_started = DateFormat( REQUEST.DefaultDate, "mm/dd/yyyy" ) />
			</cfif>
			
		</cfif>	
	
	</cfif>
<!--- 
		Check to see if we have a "Viewas" date. If we do,
		then we are goinna set that do be the default date.
	--->
	<cfif Attributes.ViewAs>
	
		<!--- This we be used when building the navigation. --->
		<cfset REQUEST.DefaultDate = Fix( Attributes.ViewAs ) />
		
	</cfif>
	
	
	<!--- 
		Loop over the form fields to make sure they are 
		display-ready. Without this, we might break out
		input fields with embedded quotes.
	--->
	<cfloop
		item="strKey"
		collection="#Attributes#">
		
		<!--- Escape values. --->
		<cfset Attributes[ strKey ] = HtmlEditFormat(
			Attributes[ strKey ]
			) />
		
	</cfloop>
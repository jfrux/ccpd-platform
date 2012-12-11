<!--- Kill extra output. --->
<cfsilent>

	<!--- Param the URL attributes. --->
	<cftry>
		<cfparam
			name="REQUEST.Attributes.date"
			type="numeric"
			default="#REQUEST.DefaultDate#"
			/>
			
		<cfcatch>
			<cfset REQUEST.Attributes.date = REQUEST.DefaultDate />
		</cfcatch>
	</cftry>
	
	<cftry>
		<cfparam
			name="URL.month"
			type="numeric"
			default="#Month( REQUEST.Attributes.date )#"
			/>
			
		<cfcatch>
			<cfset URL.month = Month( REQUEST.Attributes.date ) />
		</cfcatch>
	</cftry>
	
	
	<cftry>
		<cfparam
			name="URL.year"
			type="numeric"
			default="#Year( REQUEST.Attributes.date )#"
			/>
			
		<cfcatch>
			<cfset URL.year = Year( REQUEST.Attributes.date ) />
		</cfcatch>
	</cftry>

	
	<!---
		Based on the month and year, let's get the first 
		day of this month. In case the year or month are not
		valid, put this in a try / catch.
	--->
	<cftry>
		<cfset dtThisMonth = CreateDate( 
			URL.year, 
			URL.month, 
			1 
			) />
		
		<cfcatch>
		
			<!--- 
				If there was an error, just default the month 
				view to be the current month.
			--->
			<cfset dtThisMonth = CreateDate(
				Year( Now() ),
				Month( Now() ),
				1
				) />
				
		</cfcatch>
	</cftry>
	
	
	<!--- Get the next and previous months. --->
	<cfset dtPrevMonth = DateAdd( "m", -1, dtThisMonth ) />
	<cfset dtNextMonth = DateAdd( "m", 1, dtThisMonth ) />
	
	
	<!--- Get the last day of the month. --->
	<cfset dtLastDayOfMonth = (dtNextMonth - 1) />
	
	<!--- 
		Now that we have the first day of the month, let's get
		the first day of the calendar month - this is the first
		graphical day of the calendar page, which may be in the
		previous month (date-wise).
	--->
	<cfset dtFirstDay = (
		dtThisMonth - 
		DayOfWeek( dtThisMonth ) + 
		1
		) />
		
	<!--- 
		Get the last day of the calendar month. This is the last
		graphical day of the calendar page, which may be in the 
		next month (date-wise).
	--->
	<cfset dtLastDay = (
		dtLastDayOfMonth + 
		7 - 
		DayOfWeek( dtLastDayOfMonth )
		) />
		
	
	<!--- Get the events for this time span. --->
	<cfset objEvents = Application.Com.EventGateway.GetEvents(
		From=dtFirstDay,
		To=dtLastDay,
		ActivityID=Attributes.ActivityID
		) />
		
		
	<!--- 
		Check to see if this month contains the default date. 
		If not, then set the default date to be this month.
	--->
	<cfif (
		(Year( dtThisMonth ) NEQ Year( REQUEST.DefaultDate )) OR
		(Month( dtThisMonth ) NEQ Month( REQUEST.DefaultDate ))				
		)>
	
		<!--- This we be used when building the navigation. --->
		<cfset REQUEST.DefaultDate = Fix( dtThisMonth ) />
		
	</cfif>
	
</cfsilent>

<cfinclude template="Includes/dsp_Header.cfm">

<cfoutput>
	<p id="calendarcontrols">
		&laquo;
		<a href="#myself#Activity.Calendar&ActivityID=#Attributes.ActivityID#&Mode=Month&Date=#Fix( dtPrevMonth )#">#DateFormat( dtPrevMonth, "mmmm yyyy" )#</a> &nbsp;|&nbsp;
		<a href="#myself#Activity.Calendar&ActivityID=#Attributes.ActivityID#&Mode=Month&Date=#Fix( dtNextMonth )#">#DateFormat( dtNextMonth, "mmmm yyyy" )#</a>
		&raquo;
	</p>
	
	<form id="calendarform" action="#myself#Activity.Calendar" method="post">
		<input type="hidden" name="Mode" value="Month" />
		<input type="hidden" name="ActivityID" value="#Attributes.ActivityID#" />
	
		<select name="Month">
			<cfloop 
				index="intMonth" 
				from="1" 
				to="12"
				step="1">
				
				<option value="#intMonth#"
					<cfif (Month( dtThisMonth ) EQ intMonth)>selected="true"</cfif>
					>#MonthAsString( intMonth )#</option>
					
			</cfloop>
		</select>
		
		<select name="Year">
			<cfloop 
				index="intYear" 
				from="#(Year( dtThisMonth ) - 5)#" 
				to="#(Year( dtThisMonth ) + 5)#"
				step="1">
				
				<option value="#intYear#"
					<cfif (Year( dtThisMonth ) EQ intYear)>selected="true"</cfif>
					>#intYear#</option>
					
			</cfloop>		
		</select>
		
		<input type="submit" value="Go" />
		
	</form>
	
	
	<table id="calendar" width="100%" cellspacing="1" cellpadding="0" border="0">
	<colActivity>
		<col />
		<col width="10%" />
		<col width="16%" />
		<col width="16%" />
		<col width="16%" />
		<col width="16%" />
		<col width="16%" />
		<col width="10%" />
	</colActivity>
	<tr class="header">
		<td>
			<br />
		</td>
		<td>
			Sunday
		</td>
		<td>
			Monday
		</td>
		<td>
			Tuesday
		</td>
		<td>
			Wednesday
		</td>
		<td>
			Thursday
		</td>
		<td>
			Friday
		</td>
		<td>
			Saturday
		</td>
	</tr>
	
	<!--- Loop over all the days. --->
	<cfloop 
		index="dtDay"
		from="#dtFirstDay#"
		to="#dtLastDay#"
		step="1">
	
		<!--- 
			If we are on the first day of the week, then 
			start the current table fow.
		--->
		<cfif ((DayOfWeek( dtDay ) MOD 7) EQ 1)>
			<tr class="days">
				<td class="header">
					<a href="#myself#Activity.Calendar&ActivityID=#Attributes.ActivityID#&Mode=Week&Date=#dtDay#">&raquo;</a>
				</td>
		</cfif>
		
		<td 
			<cfif (
				(Month( dtDay ) NEQ Month( dtThisMonth )) OR
				(Year( dtDay ) NEQ Year( dtThisMonth ))
				)>
				class="other"
			<cfelseif (dtDay EQ Fix( Now() ))>
				class="today"
			</cfif>
			>
			<a 
				href="#myself#Activity.Calendar&ActivityID=#Attributes.ActivityID#&Mode=Day&Date=#dtDay#" 
				title="#DateFormat( dtDay, "mmmm d, yyyy" )#" 
				class="daynumber<cfif (Day( dtDay ) EQ 1)>full</cfif>"
				><cfif (Day( dtDay ) EQ 1)>#MonthAsString( Month( dtDay ) )#&nbsp;</cfif>#Day( dtDay )#</a>
							
			<!--- 
				Since query of queries are expensive, we 
				only want to get events on days that we 
				KNOW have events. Check to see if there 
				are any events on this day. 
			--->
			<cfif StructKeyExists( objEvents.Index, dtDay )>
				
				<!--- Query for events for the day. --->
				<cfquery name="qEventSub" dbtype="query">
					SELECT
						id,
						name,
						time_started,
						time_ended,
						color
					FROM
						objEvents.Events
					WHERE
						day_index = <cfqueryparam value="#dtDay#" cfsqltype="CF_SQL_INTEGER" />
					ORDER BY
						time_started ASC
				</cfquery>
			
				<!--- Loop over events. --->
				<cfloop query="qEventSub">
				
					<a 
						href="#myself#Activity.Event&ActivityID=#Attributes.ActivityID#&EventID=#qEventSub.id#&ViewAs=#dtDay#"
						<cfif Len( qEventSub.color )>
							style="border-left: 3px solid ###qEventSub.color# ; padding-left: 3px ;"
						</cfif>
						class="event"
						>#qEventSub.name#</a>
				
				</cfloop>
			</cfif>
		</td>				
		
		<!--- 
			If we are on the last day, then close the 
			current table row. 
		--->
		<cfif NOT (DayOfWeek( dtDay ) MOD 7)>
			</td>
		</cfif>
		
	</cfloop>
	
	<tr class="footer">
		<td colspan="8">
			<br />
		</td>
	</tr>
	</table>
		
</cfoutput>

<cfinclude template="Includes/dsp_Footer.cfm" />

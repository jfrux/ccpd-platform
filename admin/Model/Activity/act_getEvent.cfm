<!--- Param FORM values. --->
<cfparam
	name="Attributes.name"
	type="string"
	default=""
	/>
	
<cfparam
	name="Attributes.description"
	type="string"
	default=""
	/>
	
<cfparam
	name="Attributes.date_started"
	type="string"
	default=""
	/>
	
<cfparam
	name="Attributes.date_ended"
	type="string"
	default=""
	/>
	
<cfparam
	name="Attributes.time_started"
	type="string"
	default=""
	/>
	
<cfparam
	name="Attributes.time_ended"
	type="string"
	default=""
	/>
	
<cfparam
	name="Attributes.color"
	type="string"
	default=""
	/>
	
<!--- 
	The following parameters require type checking 
	and might throw errors.
--->
<cftry>
	<cfparam
		name="Attributes.is_all_day"
		type="numeric"
		default="0"
		/>
		
	<cfparam
		name="Attributes.repeat_type"
		type="numeric"
		default="0"
		/>
		
	<cfparam
		name="Attributes.update_type"
		type="numeric"
		default="1"
		/>
		
	<cfparam
		name="Attributes.submitted"
		type="numeric"
		default="0"
		/>

	<cfcatch>
		<cfset Attributes.is_all_day = 0 />
		<cfset Attributes.repeat_type = 0 />
		<cfset Attributes.update_type = 1 />
		<cfset Attributes.submitted = 0 />
	</cfcatch>
</cftry>


<!---
	When paraming the ID and ViewAs values, param the 
	Attributes since they might be coming from URL or 
	FORM scope.
--->
<cftry>
	<cfparam
		name="Attributes.EventID"
		type="numeric"
		default="0"
		/>
		
	<cfparam
		name="Attributes.ViewAs"
		type="numeric"
		default="0"
		/>
		
	<cfcatch>
		<cfset Attributes.EventID = 0 />
		<cfset Attributes.ViewAs = 0 />
	</cfcatch>
</cftry>


<!--- Set up an array to hold form errors. --->
<cfset arrErrors = ArrayNew( 1 ) />


<!--- 
	Get the event information. Get this before the 
	form processing because it will be used both during
	initialization as well as processing.
--->
<cfquery name="qEvent" datasource="#Application.Settings.DSN#">
	SELECT
		id,
		name,
		description,
		date_started,
		date_ended,
		time_started,
		time_ended,
		is_all_day,
		repeat_type,
		color
	FROM
		ce_Event e
	WHERE
		e.id = <cfqueryparam value="#Attributes.EventID#" cfsqltype="CF_SQL_INTEGER" />
</cfquery>


<!--- Loop over all form values to prevent HTML formatting. --->
<cfloop
	item="REQUEST.Key"
	collection="#FORM#">
	
	<!--- Escape values. --->
	<cfset FORM[ REQUEST.Key ] = HtmlEditFormat( FORM[ REQUEST.Key ] ) />
	
</cfloop>
<cfcomponent displayname="Send Email Process" output="no">
  <cffunction name="Run" output="no" access="remote" returntype="string" returnformat="plain">
    <cfcontent type="text/javascript" />
    <cfset var returnData = createobject("component","_com.returnData.buildStruct").init() />
    <cfset var recordsUpdated = [] />
    <cfset returnData.setStatus(false) />
    <cfset returnData.setStatusMsg('failed for unknown reason') />

    <cfquery name="qEmails" datasource="#Application.Settings.DSN#">
      SELECT     
        Attendee.attendeeid,
        Attendee.activityid,
        Attendee.personid,
        Attendee.statusid,
        Attendee.checkedinflag,
        Attendee.checkin,
        Attendee.checkedoutflag,
        Attendee.checkout,
        Attendee.mdflag,
        Attendee.termsflag,
        Attendee.paymentflag,
        Attendee.payamount,
        Attendee.payorderno,
        Attendee.paymentdate,
        Attendee.registerdate,
        Attendee.completedate,
        Attendee.termdate,
        Attendee.firstname,
        Attendee.middlename,
        Attendee.lastname,
        Person.email,
        Attendee.certname,
        Attendee.address1,
        Attendee.address2,
        Attendee.city,
        Attendee.stateprovince,
        Attendee.stateid,
        Attendee.countryid,
        Attendee.postalcode,
        Attendee.phone1,
        Attendee.phone1ext,
        Attendee.phone2,
        Attendee.phone2ext,
        Attendee.fax,
        Attendee.faxext,
        Attendee.entrymethod,
        Attendee.emailsentflag,
        Attendee.created,
        Attendee.createdby,
        Attendee.updated,
        Attendee.updatedby,
        Attendee.deleted,
        Attendee.deletedflag,
        Attendee.geonameid,
        Activity.startdate,
        Activity.enddate + '23:59:59' AS EndDate
      FROM         
        attendees AS Attendee 
      LEFT OUTER JOIN
        users AS Person ON Person.personid = Attendee.personid 
      LEFT OUTER JOIN
        activities AS Activity ON Activity.activityid = Attendee.activityid
      WHERE
      Activity.endDate < GETDATE()
      AND
      Activity.statusid IN (1,2,3)
      AND
      Attendee.statusid = 1
      AND
      Attendee.completedate BETWEEN dbo.fngetbeginofday(activity.startdate) AND dbo.fngetendofday(activity.enddate)
      AND
      Attendee.emailsentflag=0
      AND
      Person.email IS NOT NULL
      AND 
      Attendee.created > '1/1/2008'
      AND
      Activity.activitytypeid <> 2
      AND
      Attendee.deletedFlag='N'
      AND 
      activity.deletedFlag='N'
      ORDER BY Attendee.activityid
    </cfquery>
    
    <cfloop query="qEmails">
      <cfset application.email.send(EmailStyleID=5,ToAttendeeID=qEmails.AttendeeID,ToActivityID=qEmails.activityId,ToPersonID=qEmails.PersonID,ToCreditID=1) />

      <cfset recordsUpdated.add(QueryToStruct(qEmails,qEmails.currentRow)) />
    </cfloop>

    <cfset returnData.setStatus(true) />
    <cfset returnData.setStatusMsg("Successfully sent emails.") />
    <cfset returnData.setPayload(recordsUpdated) />

    <cflog text="Emailsender ran successfully." file="ccpd_script_log">
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
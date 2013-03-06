<cfcomponent name="attendee importer" output="no">
	<cffunction name="upload" access="remote" returnformat="plain" output="no">
		<cfargument name="activityid" type="string" required="yes" default="0" />
		<cfargument name="sendemail" type="string" required="no" default="0" />
		<cfargument name="filefield" />
		
		<cfset returnVar = createObject("component","_com.returnData.buildStruct").init() />
		<cfset returnVar.setStatus(false) />
		<cfset returnVar.setStatusMsg('Failed to import data') />
		
		<cfset baseDir = expandPath("/_uploads/imports/") />
		<cfset uploadDir = baseDir & "#arguments.activityId#" />
		<cfset fileName = "#dateFormat(now(),'yymmdd')##timeFormat(now(),'hhmmss')#_attendees.csv" />
		<cfset mdList = "MD,DO" />
		
		<cfif NOT directoryExists(uploadDir)>
			<cfdirectory action="create" directory="#uploadDir#">
		</cfif>
        
        <Cfset attendeeBean = createObject("component", "_com.attendee.attendee").init(activityId=arguments.activityId)>
        <Cfset activityBean = createObject("component", "_com.activity.activity").init(activityId=arguments.activityId)>
        <cfset activityBean = application.com.activityDAO.read(activityBean)>
		
		<cffile action="upload" filefield="#arguments.filefield#" destination="#uploadDir#\#fileName#" nameConflict="overwrite" result="fileResult">
		
		<cfset data = csvToArray(file='#uploadDir#\#fileName#') />
		
		<cfset historyOutput = '<table cellspacing="1" border="0" cellpadding="0">' />
		
		<cfoutput>
		<cfloop from="1" to="#arraylen(data)#" index="i">
			<cfset row = structNew() />
			<cfset row['FIRSTNAME'] = data[i][1] />
            
            <cfif data[i][2] NEQ 0>
				<cfset row['MIDDLENAME'] = data[i][2] />
            <cfelse>
				<cfset row['MIDDLENAME'] = "" />
            </cfif>
            
			<cfset row['LASTNAME'] = data[i][3] />
            
            <cfif len(trim(data[i][4])) GT 0>
				<cfset row['EMAIL'] = trim(data[i][4]) />
            <cfelse>
				<cfset row['EMAIL'] = "" />
            </cfif>
			<cfset row['CERTNAME'] = data[i][5] />
			<cfset row['DEGREE'] = data[i][6] />
			<cfset row['DEGREEID'] = 0 />
            <cfif isDate(data[i][7])>
				<cfset row['COMPLETEDATE'] = data[i][7] />
            <cfelse>
				<cfset row['COMPLETEDATE'] = activityBean.getEndDate() />
            </cfif>
			<cfset row['ADDRESS1'] = data[i][8] />
			<cfset row['ADDRESS2'] = data[i][9] />
			<cfset row['CITY'] = data[i][10] />
			<cfset row['STATE'] = data[i][11] />
			<cfset row['COUNTRY'] = data[i][12] />
			<cfset row['ZIPCODE'] = data[i][13] />
			<cfset row['PHONE1'] = data[i][14] />
			<cfset row['PHONE1EXT'] = data[i][15] />
			<cfset row['PHONE2'] = data[i][16] />
			<cfset row['PHONE2EXT'] = data[i][17] />
			<cfset row['FAX'] = data[i][18] />
			<cfset row['FAXEXT'] = data[i][19] />
			<cfif arrayLen(data[i]) EQ 20>
				<cfset row['HOURS'] = data[i][20] />
			<cfelse>
				<cfset row['HOURS'] = 0 />
			</cfif>
			<cfset row['ACCTSTATUS'] = false />
			<cfset row['ATTENDSTATUS'] = false />
			<cfset row['isPhysician'] = false />
			<cfset row['ACTION'] = '&nbsp;' />
			<cfset row['PERSONID'] = 0 />
			
			<cfif len(trim(row['CERTNAME'])) EQ 0>
				<cfset row['CERTNAME'] = row['FIRSTNAME'] />
				<cfif len(trim(row['MIDDLENAME'])) GT 0>
					<cfset row['CERTNAME'] = row.CERTNAME & " " & row.MIDDLENAME />
				</cfif>
				<cfset row.CERTNAME = row.CERTNAME & " " & row.LASTNAME />
				
				<cfif len(trim(row.DEGREE)) GT 0 AND row.DEGREE NEQ "Other">
					<cfset row.CERTNAME = row.CERTNAME & ", " & row.DEGREE />
				</cfif>
			</cfif>
			
			<cfif len(trim(row['FIRSTNAME'])) GT 0>
				<cfif len(row['COUNTRY']) GT 0>
					<cfquery name="qCountry" datasource="#application.settings.dsn#">
						SELECT     
							country.id, country.name, country.code, countryDetail.ISO, countryDetail.ISO3
						FROM         
							ce_Sys_Country AS country 
						INNER JOIN
							geonameCountryInfo AS countryDetail ON country.code = countryDetail.ISO
						WHERE     (countryDetail.ISO3 = <cfqueryparam value="#row['COUNTRY']#" cfsqltype="cf_sql_varchar" />)
					</cfquery>
					
					<cfif qCountry.recordCount>
						<cfset row['COUNTRY_ID'] = qCountry.id />
					<cfelse>
						<cfset row['COUNTRY_ID'] = 0 />
					</cfif>
				<cfelse>
					<cfset row['COUNTRY_ID'] = 0 />
				</cfif>
				
				<cfif len(row['STATE']) GT 0>
					<cfquery name="qState" datasource="#application.settings.dsn#">
						SELECT stateId
						FROM ce_sys_state
						WHERE code = <cfqueryparam value="#trim(row['STATE'])#" cfsqltype="cf_sql_varchar" />
					</cfquery>
					
					<cfif qState.recordCount>
						<cfset row['STATE_ID'] = qState.stateid />
					<cfelse>
						<cfset row['STATE_ID'] = 0 />
					</cfif>
				<cfelse>
					<cfset row['STATE_ID'] = 0 />
				</cfif>
				
				
				<cfif row['FIRSTNAME'] NEQ "FIRSTNAME">	
					<!--- CHECK FOR ACCOUNT BY EMAIL --->
					<cfquery  name="qCheckAcct" datasource="#application.settings.dsn#">
						SELECT personId FROM ce_person
						WHERE email=<cfqueryparam value="#row['EMAIL']#" cfsqltype="cf_sql_varchar" />
						AND deletedFlag='N'
					</cfquery>
					
					<cfif qCheckAcct.recordCount>
						<cfset row['PERSONID'] = qCheckAcct.personid />
						<cfset row['ACCTSTATUS'] = true />
					</cfif>
						
					<!--- CHECK FOR ATTENDEE RECORD BY EMAIL --->
					<cfquery  name="qCheckAtt" datasource="#application.settings.dsn#">
						SELECT attendeeId FROM ce_attendee
						WHERE 
							(activityid = #arguments.activityId#
						AND 
						email=<cfqueryparam value="#row['EMAIL']#" cfsqltype="cf_sql_varchar" />
						AND deletedFlag='N'
						)
						<cfif row['PERSONID'] GT 0>
						OR (
						activityid = #arguments.activityId#
						AND 
						personid=<cfqueryparam value="#row['PERSONID']#" cfsqltype="cf_sql_integer" />
						AND deletedFlag='N'
						)
						</cfif>
						
					</cfquery>
					<cfif qCheckAtt.recordCount>
						<cfset row['ATTENDSTATUS'] = true />
					</cfif>
					
					<!--- CHECK PHYSICIAN STATUS --->
					<cfset row['DEGREE'] = UCASE(stripAllBut(row['DEGREE'],'0123456789abcdefghijklmnopqrstuvwxyz',false)) />
					
					<cfquery name="qDegree" datasource="#application.settings.dsn#">
						SELECT degreeId FROm ce_sys_degree
						WHERE name=<cfqueryparam value="#row['DEGREE']#" cfsqltype="cf_sql_varchar" />
					</cfquery>
					
					<cfif qDegree.RecordCount>
						<cfset row['DEGREEID'] = qDegree.degreeId />
					</cfif>
					
					<cfif listFind(mdList,row['DEGREE'],',')>
						<cfset row['isPhysician'] = true />
					</cfif>
					
					<!--- CREATE ACCOUNT RECORD --->
					<cfif NOT row['ACCTSTATUS'] AND isEmail(row['EMAIL'])>
						<cfset savedPerson = application.person.savePerson(
							personId=0,
							FirstName=row['FIRSTNAME'],
							MiddleName=row['MIDDLENAME'],
							LastName=row['LASTNAME'],
							CertNameCustom=row['CERTNAME'],
							DisplayName=row['CERTNAME'],
							Email=trim(row['EMAIL']),
							suffix="",
							gender="",
							SSN="0000",
							password="3jf2ofjkl",
							birthdate="",
							checkDupes=false,
							verifiedEmail=true
						) />
						
						<cfquery  name="qPerson" datasource="#application.settings.dsn#">
							SELECT personId FROM ce_person
							WHERE email=<cfqueryparam value="#trim(row['EMAIL'])#" cfsqltype="cf_sql_varchar" />
							AND deletedFlag='N'
						</cfquery>
						<cfif qPerson.recordCount GT 0>
							<cfset row['PERSONID'] = qPerson.personId />
						</cfif>
						
						<cfif qPerson.personId GT 0>
							<cfset application.person.saveDegree(personId=row['PERSONID'],degreeId=row['DEGREEID']) />
							<cfset application.person.saveAddress(
								personId=row['PERSONID'],
								addressId=0,
								AddressTypeID=1,
								primaryFlag="Y",
								address1=row['address1'],
								address2=row['address2'],
								city=row['city'],
								state=row['state'],
								province=row['STATE'],
								country=row['country'],
								zipCode=row['ZIPCODE'],
								phone1=row['phone1'],
								phone1ext=row['phone1ext'],
								phone2=row['phone2'],
								phone2ext=row['phone2ext'],
								phone3=row['fax'],
								phone3ext=row['faxext']
							)/>
							<cfset row['ACTION'] = listAppend(row['ACTION'],'Created account.','|') />
						<cfelse>
							<cfset row['ACTION'] = listAppend(row['ACTION'],'Failed to create account.','|') />
						</cfif>
					</cfif>
                    
                    <!--- FILL IN BLANK DATES --->
                    <cfif len(trim(row['COMPLETEDATE'])) EQ 0>
                    	<cfset row['COMPLETEDATE'] = activityBean.getEndDate() />
                    </cfif>
					
					<!--- CREATE ATTENDEE RECORD --->
					<cfif NOT row['ATTENDSTATUS']>
						<cfset savedAttendee = application.ActivityAttendee.saveAttendee(
							activityId=arguments.activityId,
							personId=row['PERSONID'],
							MDFlag=LEFT(yesNoFormat(row['isPhysician']),1),
							firstname=row['firstname'],
							middlename=row['middlename'],
							lastname=row['lastname'],
							email=row['email'],
							certname=row['certname'],
							address1=row['address1'],
							address2=row['address2'],
							city=row['city'],
							stateId=row['STATE_ID'],
							stateProvince=row['STATE'],
							countryId=row['COUNTRY_ID'],
							postalCode=row['ZIPCODE'],
							phone1=row['phone1'],
							phone1ext=row['phone1ext'],
							phone2=row['phone2'],
							phone2ext=row['phone2ext'],
							fax=row['fax'],
							faxext=row['faxext'],
							registerDate=row['COMPLETEDATE'],
							statusId=1,
							hours=row['HOURS'],
							completeDate=row['COMPLETEDATE'],
							entryMethod="IMPORT"
						) />
                        
						<cfset savedStatus = listFirst(trim(savedAttendee),'|') />
						
						<cfif trim(savedStatus) EQ "Success">
							<cfif row['PERSONID'] GT 0>
                            	<cfset attendeeBean.setPersonId(row['PERSONID'])>
                                <cfset attendeeBean = application.com.attendeeDAO.read(attendeeBean)>
                                
								<cfset application.ActivityAttendee.updateStatuses(
									attendeeList=attendeeBean.getAttendeeId(),
									activityId=arguments.activityId,
									statusId=1,
									completeDate=row['completeDate'],
									sendemail=arguments.sendemail) />
							</cfif>
							<cfset row['ACTION'] = listAppend(row['ACTION'],'Created attendee record.','|') />
						<cfelse>
							<cfset row['ACTION'] = "#savedAttendee#" />
						</cfif>
					</cfif>
					
					<cfset row['ACTION'] = replace(row['ACTION'],'|','<br />') />
					
					<cfsavecontent variable="rowOutput">
					<tr>
						<td>#row.LASTNAME#, #row.FirstName# #row.MiddleName#</td>
						<td>#row.CERTNAME#</td>
						<td>#row.EMAIL#</td>
						<td>#row.DEGREE#</td>
						<td>#yesNoFormat(row['isPhysician'])#</td>
						<td>#yesNoFormat(row['ACCTSTATUS'])#</td>
						<td>#yesNoFormat(row['ATTENDSTATUS'])#</td>
						<td>#row['ACTION']#</td>
					</tr>
					</cfsavecontent>
					
					<cfset historyOutput = historyOutput & rowOutput />
					
				<cfelse>
					<cfsavecontent variable="rowOutput">
					<tr>
						<th>Name</th>
						<th>Cert Name</th>
						<th>Email</th>
						<th>Degree</th>
						<th>Is Physician?</th>
						<th>Has Account?</th>
						<th>Already Imported?</th>
						<th>Action Taken</th>
					</tr>
					</cfsavecontent>
					
					<cfset historyOutput = historyOutput & rowOutput />
				</cfif>
			</cfif>
		</cfloop>
		</table>
		</cfoutput>
		<cfset returnVar.setStatus(true) />
		<cfset returnVar.setStatusMsg('Import successful.') />
		
		<cfset Application.History.Add(HistoryStyleID=111,
                                FromPersonID=Session.PersonID,
                                ToActivityID=Arguments.ActivityID,
								ToContent=historyOutput)>
		<cfreturn "Import successful!" />
	</cffunction>
	
	<cffunction name="process" access="remote">
		
	</cffunction>
	<cfscript>
			function stripAllBut(str,strip) {
				var badList = "\";
				var okList = "\\";
				var bCS = true;
			
				if(arrayLen(arguments) gte 3) bCS = arguments[3];
			
				strip = replaceList(strip,badList,okList);
				
				if(bCS) return rereplace(str,"[^#strip#]","","all");
				else return rereplaceNoCase(str,"[^#strip#]","","all");
			}
		</cfscript>
	<cfscript>
function isEmail(str) {
return (REFindNoCase("^['_a-z0-9-\+]+(\.['_a-z0-9-\+]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*\.(([a-z]{2,3})|(aero|asia|biz|cat|coop|info|museum|name|jobs|post|pro|tel|travel|mobi))$",
arguments.str) AND len(listGetAt(arguments.str, 1, "@")) LTE 64 AND
len(listGetAt(arguments.str, 2, "@")) LTE 255) IS 1;
}
</cfscript>
	<cffunction
	name="csvToArray"
	access="public"
	returntype="array"
	output="false"
	hint="I take a CSV file or CSV data value and convert it to an array of arrays based on the given field delimiter. Line delimiter is assumed to be new line / carriage return related.">
 
	<!--- Define arguments. --->
	<cfargument
		name="file"
		type="string"
		required="false"
		default=""
		hint="I am the optional file containing the CSV data."
		/>
 
	<cfargument
		name="csv"
		type="string"
		required="false"
		default=""
		hint="I am the CSV text data (if the file argument was not used)."
		/>
 
	<cfargument
		name="delimiter"
		type="string"
		required="false"
		default=","
		hint="I am the field delimiter (line delimiter is assumed to be new line / carriage return)."
		/>
 
	<cfargument
		name="trim"
		type="boolean"
		required="false"
		default="true"
		hint="I flags whether or not to trim the END of the file for line breaks and carriage returns."
		/>
 
	<!--- Define the local scope. --->
	<cfset var local = {} />
 
	<!---
		Check to see if we are using a CSV File. If so, then all we
		want to do is move the file data into the CSV variable. That
		way, the rest of the algorithm can be uniform.
	--->
	<cfif len( arguments.file )>
 
		<!--- Read the file into Data. --->
		<cfset arguments.csv = fileRead( arguments.file ) />
 
	</cfif>
 
	<!---
		ASSERT: At this point, no matter how the data was passed in,
		we now have it in the CSV variable.
	--->
 
	<!---
		Check to see if we need to trim the data. Be default, we are
		going to pull off any new line and carraige returns that are
		at the end of the file (we do NOT want to strip spaces or
		tabs as those are field delimiters).
	--->
	<cfif arguments.trim>
 
		<!--- Remove trailing line breaks and carriage returns. --->
		<cfset arguments.csv = reReplace(
			arguments.csv,
			"[\r\n]+$",
			"",
			"all"
			) />
 
	</cfif>
 
	<!--- Make sure the delimiter is just one character. --->
	<cfif (len( arguments.delimiter ) neq 1)>
 
		<!--- Set the default delimiter value. --->
		<cfset arguments.delimiter = "," />
 
	</cfif>
 
 
	<!---
		Now, let's define the pattern for parsing the CSV data. We
		are going to use verbose regular expression since this is a
		rather complicated pattern.
 
		NOTE: We are using the verbose flag such that we can use
		white space in our regex for readability.
	--->
	<cfsavecontent variable="local.regEx">(?x)
		<cfoutput>
 
			<!--- Make sure we pick up where we left off. --->
			\G
 
			<!---
				We are going to start off with a field value since
				the first thing in our file should be a field (or a
				completely empty file).
			--->
			(?:
 
				<!--- Quoted value - GROUP 1 --->
				"([^"]*+ (?>""[^"]*+)* )"
 
				|
 
				<!--- Standard field value - GROUP 2 --->
				([^"\#arguments.delimiter#\r\n]*+)
 
			)
 
			<!--- Delimiter - GROUP 3 --->
			(
				\#arguments.delimiter# |
				\r\n? |
				\n |
				$
			)
 
		</cfoutput>
	</cfsavecontent>
 
	<!---
		Create a compiled Java regular expression pattern object
		for the experssion that will be parsing the CSV.
	--->
	<cfset local.pattern = createObject(
		"java",
		"java.util.regex.Pattern"
		).compile(
			javaCast( "string", local.regEx )
			)
		/>
 
	<!---
		Now, get the pattern matcher for our target text (the CSV
		data). This will allows us to iterate over all the tokens
		in the CSV data for individual evaluation.
	--->
	<cfset local.matcher = local.pattern.matcher(
		javaCast( "string", arguments.csv )
		) />
 
 
	<!---
		Create an array to hold the CSV data. We are going to create
		an array of arrays in which each nested array represents a
		row in the CSV data file. We are going to start off the CSV
		data with a single row.
 
		NOTE: It is impossible to differentiate an empty dataset from
		a dataset that has one empty row. As such, we will always
		have at least one row in our result.
	--->
	<cfset local.csvData = [ [] ] />
 
	<!---

		Here's where the magic is taking place; we are going to use
		the Java pattern matcher to iterate over each of the CSV data
		fields using the regular expression we defined above.
 
		Each match will have at least the field value and possibly an
		optional trailing delimiter.
	--->
	<cfloop condition="local.matcher.find()">
 
		<!---
			Next, try to get the qualified field value. If the field
			was not qualified, this value will be null.
		--->
		<cfset local.fieldValue = local.matcher.group(
			javaCast( "int", 1 )
			) />
 
		<!---
			Check to see if the value exists in the local scope. If
			it doesn't exist, then we want the non-qualified field.
			If it does exist, then we want to replace any escaped,
			embedded quotes.
		--->
		<cfif structKeyExists( local, "fieldValue" )>
 
			<!---
				The qualified field was found. Replace escpaed
				quotes (two double quotes in a row) with an unescaped
				double quote.
			--->
			<cfset local.fieldValue = replace(
				local.fieldValue,
				"""""",
				"""",
				"all"
				) />
 
		<cfelse>
 
			<!---
				No qualified field value was found; as such, let's
				use the non-qualified field value.
			--->
			<cfset local.fieldValue = local.matcher.group(
				javaCast( "int", 2 )
				) />
 
		</cfif>
 
		<!---
			Now that we have our parsed field value, let's add it to
			the most recently created CSV row collection.
		--->
		<cfset arrayAppend(
			local.csvData[ arrayLen( local.csvData ) ],
			local.fieldValue
			) />
 
		<!---
			Get the delimiter. We know that the delimiter will always
			be matched, but in the case that it matched the end of
			the CSV string, it will not have a length.
		--->
		<cfset local.delimiter = local.matcher.group(
			javaCast( "int", 3 )
			) />
 
		<!---
			Check to see if we found a delimiter that is not the
			field delimiter (end-of-file delimiter will not have
			a length). If this is the case, then our delimiter is the
			line delimiter. Add a new data array to the CSV
			data collection.
		--->
		<cfif (
			len( local.delimiter ) &&
			(local.delimiter neq arguments.delimiter)
			)>
 
			<!--- Start new row data array. --->
			<cfset arrayAppend(
				local.csvData,
				arrayNew( 1 )
				) />
 
		<!--- Check to see if there is no delimiter length. --->
		<cfelseif !len( local.delimiter )>
			<!---
				If our delimiter has no length, it means that we
				reached the end of the CSV data. Let's explicitly
				break out of the loop otherwise we'll get an extra
				empty space.
			--->
			<cfbreak />
 
		</cfif>
 
	</cfloop>
 
 
	<!---
		At this point, our array should contain the parsed contents
		of the CSV value as an array of arrays. Return the array.
	--->
	<cfreturn local.csvData />
</cffunction>
	
	<cfscript>
	/**
	 * Fixes a list by replacing null entries.
	 * This is a modified version of the ListFix UDF 
	 * written by Raymond Camden. It is significantly
	 * faster when parsing larger strings with nulls.
	 * Version 2 was by Patrick McElhaney (&#112;&#109;&#99;&#101;&#108;&#104;&#97;&#110;&#101;&#121;&#64;&#97;&#109;&#99;&#105;&#116;&#121;&#46;&#99;&#111;&#109;)
	 * 
	 * @param list 	 The list to parse. (Required)
	 * @param delimiter 	 The delimiter to use. Defaults to a comma. (Optional)
	 * @param null 	 Null string to insert. Defaults to "NULL". (Optional)
	 * @return Returns a list. 
	 * @author Steven Van Gemert (&#112;&#109;&#99;&#101;&#108;&#104;&#97;&#110;&#101;&#121;&#64;&#97;&#109;&#99;&#105;&#116;&#121;&#46;&#99;&#111;&#109;&#115;&#118;&#103;&#50;&#64;&#112;&#108;&#97;&#99;&#115;&#46;&#110;&#101;&#116;) 
	 * @version 3, July 31, 2004 
	 */
	function listFix(list) {
	var delim = ",";
	  var null = "NULL";
	  var special_char_list      = "\,+,*,?,.,[,],^,$,(,),{,},|,-";
	  var esc_special_char_list  = "\\,\+,\*,\?,\.,\[,\],\^,\$,\(,\),\{,\},\|,\-";
	  var i = "";
		   
	  if(arrayLen(arguments) gt 1) delim = arguments[2];
	  if(arrayLen(arguments) gt 2) null = arguments[3];
	
	  if(findnocase(left(list, 1),delim)) list = null & list;
	  if(findnocase(right(list,1),delim)) list = list & null;
	
	  i = len(delim) - 1;
	  while(i GTE 1){
		delim = mid(delim,1,i) & "_Separator_" & mid(delim,i+1,len(delim) - (i));
		i = i - 1;
	  }
	
	  delim = ReplaceList(delim, special_char_list, esc_special_char_list);
	  delim = Replace(delim, "_Separator_", "|", "ALL");
	
	  list = rereplace(list, "(" & delim & ")(" & delim & ")", "\1" & null & "\2", "ALL");
	  list = rereplace(list, "(" & delim & ")(" & delim & ")", "\1" & null & "\2", "ALL");
		  
	  return list;
	}
	</cfscript>
	<cfscript>
	/**
	* Transform a CSV formatted string with header column into a query object.
	*
	* @param cvsString      CVS Data. (Required)
	* @param rowDelim      Row delimiter. Defaults to CHR(10). (Optional)
	* @param colDelim      Column delimiter. Defaults to a comma. (Optional)
	* @return Returns a query.
	* @author Tony Brandner (tony@brandners.com)
	* @version 1, September 30, 2005
	*/
	function csvToQuery(csvString){
		var rowDelim = chr(10);
		var colDelim = ",";
		var numCols = 1;
		var newQuery = QueryNew("");
		var arrayCol = ArrayNew(1);
		var i = 1;
		var j = 1;
		
		csvString = trim(csvString);
		
		if(arrayLen(arguments) GE 2) rowDelim = arguments[2];
		if(arrayLen(arguments) GE 3) colDelim = arguments[3];
	
		arrayCol = listToArray(listFirst(csvString,rowDelim),colDelim);
		
		for(i=1; i le arrayLen(arrayCol); i=i+1) queryAddColumn(newQuery, arrayCol[i], ArrayNew(1));
		
		for(i=2; i le listLen(csvString,rowDelim); i=i+1) {
			queryAddRow(newQuery);
			for(j=1; j le arrayLen(arrayCol); j=j+1) {
				if(listLen(listGetAt(csvString,i,rowDelim),colDelim) ge j) {
					querySetCell(newQuery, arrayCol[j],listGetAt(listGetAt(csvString,i,rowDelim),j,colDelim), i-1);
				}
			}
		}
		return newQuery;
	}
	</cfscript>
	
	<cfinclude template="#Application.Settings.ComPath#/_UDF/isMD.cfm" />
</cfcomponent>
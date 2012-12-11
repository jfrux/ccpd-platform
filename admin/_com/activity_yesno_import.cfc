<cfcomponent name="activity importer">
	<cffunction name="createRecords" access="remote">
		<cfquery name="qOthers" datasource="#application.settings.dsn#">
			SELECT     act.ActivityID, act.Title, act.StartDate, oth.OtherID, oth.competenceDesign As q1, oth.performanceDesign As q2, oth.outcomesDesign As q3, oth.competenceEval As q4, 
				  oth.performanceEval As q5, oth.outcomesEval As q6
			FROM         ceschema.ce_Activity AS act LEFT OUTER JOIN
				  ceschema.ce_Activity_Other AS oth ON oth.ActivityID = act.ActivityID
			WHERE     (CAST(ISNULL(oth.competenceDesign, 0) AS nvarchar(10)) + ',' + CAST(ISNULL(oth.performanceDesign, 0) AS nvarchar(10)) 
				  + ',' + CAST(ISNULL(oth.outcomesDesign, 0) AS nvarchar(10)) + ',' + CAST(ISNULL(oth.competenceEval, 0) AS nvarchar(10)) 
				  + ',' + CAST(ISNULL(oth.performanceEval, 0) AS nvarchar(10)) + ',' + CAST(ISNULL(oth.outcomesEval, 0) AS nvarchar(10)) <> '1,0,0,1,0,0')  AND 
				  (ISNULL(act.ParentActivityID, 0) = 0) AND (oth.OtherID IS NULL)
		</cfquery>
		<cfloop query="qOthers">
			<cfquery name="qCreate" datasource="#application.settings.dsn#">
				INSERT INTO ce_activity_other
				(
					activityid,
					competenceDesign,
					performanceDesign,
					outcomesDesign,
					competenceEval,
					performanceEval,
					outcomesEval
				) VALUES (
					#qOthers.activityid#
					,1
					,0
					,0
					,1
					,0
					,0
				)
			</cfquery>
		</cfloop>
	</cffunction>
	<cffunction name="process" access="remote">
		<cfargument name="filename" type="string" required="yes" default="0" />
		
		<cfset baseDir = expandPath("/admin/_uploads/imports/activity/") />
		<cfset processDir = baseDir & "processed" />
		<cfset readFile = baseDir & arguments.filename />
		
		<cfset data = csvToArray(file=readFile) />
		
		<cfoutput>
		<table width="100%" border="1">
			<thead>
				<tr>
					<th>STATUS</th>
					<th>ID</th>
					<th>q1</th>
					<th>q2</th>
					<th>q3</th>
					<th>q4</th>
					<th>q5</th>
					<th>q6</th>
				</tr>
			</thead>
		<cfloop from="2" to="#arraylen(data)#" index="i">
			<cfset row = structNew() />
			<cfset row['status'] = "no status" />
			<cfset row['id'] = data[i][1] />
			<cfset row['q1'] = YesNoToInt(data[i][2]) />
			<cfset row['q2'] = YesNoToInt(data[i][3]) />
			<cfset row['q3'] = YesNoToInt(data[i][4]) />
			<cfset row['q4'] = YesNoToInt(data[i][5]) />
			<cfset row['q5'] = YesNoToInt(data[i][6]) />
			<cfset row['q6'] = YesNoToInt(data[i][7]) />
			
			<cfif isNumeric(row['id'])>
				<!--- ACTIVITY LOOKUP --->
				<cfquery name="activity" datasource="#application.settings.dsn#">
					SELECT * FROM ce_Activity
					WHERE activityId = <cfqueryparam value="#trim(row['id'])#" cfsqltype="cf_sql_integer" />
				</cfquery>
				
				<cfif activity.recordCount GT 0>
					<!--- check other record --->
					<cfquery name="other" datasource="#application.settings.dsn#">
						SELECT * FROM ce_Activity_Other
						WHERE activityId = <cfqueryparam value="#trim(row['id'])#" cfsqltype="cf_sql_integer" />
					</cfquery>
					
					<cfif other.recordCount GT 0>
						<cfquery name="qUpdate" datasource="#application.settings.dsn#">
							UPDATE ce_activity_other
							SET
								[competenceDesign] = #trim(row['q1'])#
								,[performanceDesign] = #trim(row['q2'])#
								,[outcomesDesign] = #trim(row['q3'])#
								,[competenceEval] = #trim(row['q4'])#
								,[performanceEval] = #trim(row['q5'])#
								,[outcomesEval] = #trim(row['q6'])#
							WHERE activityid=#trim(row['id'])#
						</cfquery>
						
						<cfset row['status'] = "update" />
					<cfelse>
						<cfquery name="qCreate" datasource="#application.settings.dsn#">
							INSERT INTO ce_activity_other
							(
								activityid,
								competenceDesign,
								performanceDesign,
								outcomesDesign,
								competenceEval,
								performanceEval,
								outcomesEval
							) VALUES (
								#trim(row['id'])#
								,#trim(row['q1'])#
								,#trim(row['q2'])#
								,#trim(row['q3'])#
								,#trim(row['q4'])#
								,#trim(row['q5'])#
								,#trim(row['q6'])#
							)
						</cfquery>
						<cfset row['status'] = "create" />
					</cfif>
					
					<tr>
						<td>#row.STATUS#</td>
						<td>#row.ID#</td>
						<td>#row.q1#</td>
						<td>#row.q2#</td>
						<td>#row.q3#</td>
						<td>#row.q4#</td>
						<td>#row.q5#</td>
						<td>#row.q6#</td>
					</tr>
				</cfif>
			</cfif>
				
		</cfloop>
		</table>
		</cfoutput>
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
		<cffunction name="yesNoToInt" access="public">
		<cfargument name="theValue" type="string" required="no" default="no" />
		
		<cfset var response = 0 />
		
		<cfif arguments.theValue EQ "yes">
			<cfset response = 1 />
		</cfif>
		
		<cfreturn response />
	</cffunction>
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
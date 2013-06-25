<cfcomponent displayname="UDF">
	<cffunction name="init" access="public" output="no" returntype="ccpdadmin._com.UDF">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="nameCase" access="public" returntype="string" output="false">
		<cfargument name="name" type="string" required="true" />
		<cfset arguments.name = ucase(arguments.name)>
		<cfreturn reReplace(arguments.name,"([[:upper:]])([[:upper:]]*)","\1\L\2\E","all") />
	</cffunction>

	
	<cffunction name="HowLongAgo" access="public" returntype="string">
		<cfargument name="DateTime" type="string" required="yes" />
		
		<cfset var Difference = DateDiff('s',Arguments.DateTime,now())>
		<cfset var r = "">
		<cfset var s = "">
		<cfset var TheInt = 0>
		
		<cfif Difference GTE 60*60*24*365> <!--- // if more than a year ago --->
			<cfset TheInt = Round((Difference / (60*60*24*365)))>
			<cfif TheInt GT 1>
				<cfset s = "s">
			<cfelse>
				<cfset s = "">
			</cfif> 
			<cfset r = Round(TheInt) & " year" & s & " ago">
		<cfelseif Difference GTE 60*60*24*7*5><!--- // if more than FIVE WEEKS ago --->
			<cfset TheInt = Round((Difference / (60*60*24*30)))>
			<cfif TheInt GT 1>
				<cfset s = "s">
			<cfelse>
				<cfset s = "">
			</cfif> 
			<cfset r = Round(TheInt) & " month" & s & " ago">
		<cfelseif Difference GTE 60*60*24*7><!--- // if more than a WEEK ago --->
			<cfset TheInt = Round((Difference / (60*60*24*7)))>
			<cfif TheInt GT 1>
				<cfset s = "s">
			<cfelse>
				<cfset s = "">
			</cfif> 
			<cfset r = Round(TheInt) & " week" & s & " ago">
		<cfelseif Difference GTE 60*60*24><!--- // // if more than a DAY ago --->
			<cfset TheInt = Round((Difference / (60*60*24)))>
			<cfif TheInt GT 1>
				<cfset s = "s">
			<cfelse>
				<cfset s = "">
			</cfif> 
			<cfset r = Round(TheInt) & " day" & s & " ago">
		<cfelseif Difference GTE 60*60><!--- // if more than an hour ago --->
			<cfset TheInt = Round((Difference / (60*60)))>
			<cfif TheInt GT 1>
				<cfset s = "s">
			<cfelse>
				<cfset s = "">
			</cfif> 
			<cfset r = Round(TheInt) & " hour" & s & " ago">
		<cfelseif Difference GTE 60><!---  // if more than a minute ago --->
			<cfset TheInt = Round((Difference / (60)))>
			<cfif TheInt GT 1>
				<cfset s = "s">
			<cfelse>
				<cfset s = "">
			</cfif> 
			<cfset r = Round(TheInt) & " minute" & s & " ago">
		<cfelse><!--- // // if less than a minute ago --->
			<cfset r = "moments ago">
		</cfif>
		
		<cfreturn r>
	</cffunction>
    
    <cffunction name="formatRulesCB" access="public" output="false" returntype="string">
    	<cfargument name="Rules" type="struct" required="true" />
        <cfargument name="Editable" type="string" required="false" default="false" />
        <cfargument name="CB" type="numeric" required="false" default="0" />
        
        <cfset var RuleOutput = ""> 
    
        <cfif Rules.YearStart NEQ "" AND Rules.YearEnd NEQ "">
            <cfset RuleOutput = RuleOutput & Rules.YearStart & "-" & Rules.YearEnd & " ">
        <cfelse>
            <cfset RuleOutput = RuleOutput & Rules.YearStart & Rules.YearEnd & " ">
        </cfif>
        
        <cfif Rules.CarMake NEQ "" OR Rules.CarModel NEQ "">
            <cfset RuleOutput = RuleOutput & Rules.CarMake & " " & Rules.CarModel & " ">
        </cfif>
        
        <cfif Rules.CategoryName NEQ "" AND Rules.SubCategoryName NEQ "">
            <cfset RuleOutput = RuleOutput & "with purpose " & Rules.CategoryName & ", specifically " & Rules.SubCategoryName & " ">
        <cfelseif Rules.CategoryName NEQ "" OR Rules.SubCategoryName NEQ "">
            <cfset RuleOutput = RuleOutput & "with purpose " & Rules.CategoryName & Rules.SubCategoryName & " ">
        </cfif>
        
        <cfset RuleOutput = REReplace(RuleOutput, ",$", "")>
        
        <cfreturn RuleOutput />
    </cffunction>
    
    <cffunction name="formatRulesKS" access="public" output="false" returntype="string">
		<cfargument name="Rules" type="struct" required="true" />
		<cfargument name="Editable" type="string" required="false" default="false" />
		<cfargument name="KS" type="numeric" required="false" default="0" />
		<cfargument name="Type" type="string" required="false" default="" />
		<cfargument name="TypeID" type="numeric" required="false" default="0" />
        
		<cfset var RultCount = 0> 
        <cfset var RuleOutput = ""> 
        <cfset var CurrRuleType = ""> 
        
		<cfset RuleCount = 1>
	
		<cfif Rules.YearStart NEQ "" AND Rules.YearEnd NEQ "">
			<cfset RuleOutput = RuleOutput & Rules.YearStart & "-" & Rules.YearEnd & " ">
		<cfelse>
			<cfset RuleOutput = RuleOutput & Rules.YearStart & Rules.YearEnd & " ">
		</cfif>
		
		<cfif Rules.CarMake NEQ "" OR Rules.CarModel NEQ "">
			<cfset RuleOutput = RuleOutput & Rules.CarMake & " " & Rules.CarModel & " ">
		</cfif>
		
		<cfif Rules.CategoryName NEQ "" AND Rules.SubCategoryName NEQ "">
			<cfset RuleOutput = RuleOutput & "with purpose " & Rules.CategoryName & ", specifically " & Rules.SubCategoryName & " ">
		<cfelseif Rules.CategoryName NEQ "" OR Rules.SubCategoryName NEQ "">
			<cfset RuleOutput = RuleOutput & "with purpose " & Rules.CategoryName & Rules.SubCategoryName & " ">
		</cfif>
		
		<cfif Rules.HPMin NEQ 0 OR Rules.HPMax NEQ 0 OR Rules.WeightMin NEQ 0 OR Rules.WeightMax NEQ 0 OR Rules.Zero60Min NEQ 0 OR Rules.Zero60Max NEQ 0 OR Rules.QuarterMileMin NEQ 0 OR Rules.QuarterMileMax NEQ 0>
			<cfif Rules.CarMake NEQ "" OR Rules.CarModel NEQ "">
				<cfset RuleOutput = RuleOutput & "with ">
			</cfif>
			
			<cfif Rules.HPMin NEQ 0 AND Rules.HPMax NEQ 0>
				<cfset RuleOutput = RuleOutput & "between " & Rules.HPMin & " to " & Rules.HPMax & " HP, ">
			<cfelseif Rules.HPMin NEQ 0 AND Rules.HPMax EQ 0>
				<cfset RuleOutput = RuleOutput & "at least " & Rules.HPMin & " HP, ">
			<cfelseif Rules.HPMin EQ 0 AND Rules.HPMax NEQ 0>
				<cfset RuleOutput = RuleOutput & "up to " & Rules.HPMax & " HP, ">
			</cfif>
			<cfif Rules.WeightMin NEQ 0 AND Rules.WeightMax NEQ 0>
				<cfset RuleOutput = RuleOutput & "weight between " & Rules.WeightMin & " to " & Rules.WeightMax & " lbs, ">
			<cfelseif Rules.WeightMin NEQ 0 AND Rules.WeightMax EQ 0>
				<cfset RuleOutput = RuleOutput & "weight at least " & Rules.WeightMin & " lbs, ">
			<cfelseif Rules.WeightMin EQ 0 AND Rules.WeightMax NEQ 0>
				<cfset RuleOutput = RuleOutput & "weight up to " & Rules.WeightMax & " lbs, ">
			</cfif>
			<cfif Rules.Zero60Min NEQ 0 AND Rules.Zero60Max NEQ 0>
				<cfset RuleOutput = RuleOutput & "0-60 MPH between " & Rules.Zero60Min & " and " & Rules.Zero60Max & " sec, ">
			<cfelseif Rules.Zero60Min NEQ 0 AND Rules.Zero60Max EQ 0>
				<cfset RuleOutput = RuleOutput & "at least 0-60 MPH in " & Rules.Zero60Min & " sec, ">
			<cfelseif Rules.Zero60Min EQ 0 AND Rules.Zero60Max NEQ 0>
				<cfset RuleOutput = RuleOutput & "up to 0-60 MPH in " & Rules.Zero60Max & " sec, ">
			</cfif>
			<cfif Rules.QuarterMileMin NEQ 0 AND Rules.QuarterMileMax NEQ 0>
				<cfset RuleOutput = RuleOutput & " 1/4 mi time between " & Rules.QuarterMileMin & " to " & Rules.QuarterMileMax & " sec.">
			<cfelseif Rules.QuarterMileMin NEQ 0 AND Rules.QuarterMileMax EQ 0>
				<cfset RuleOutput = RuleOutput & "1/4 mi time at least " & Rules.QuarterMileMin & " sec.">
			<cfelseif Rules.QuarterMileMin EQ 0 AND Rules.QuarterMileMax NEQ 0>
				<cfset RuleOutput = RuleOutput & "1/4 mi time up to " & Rules.QuarterMileMax & " sec.">
			</cfif>
		</cfif>
		<cfset RuleOutput = REReplace(RuleOutput, ",$", "")>
        <cfset RuleCount = RuleCount + 1>
        
        <cfreturn RuleOutput />
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
    
    <cffunction name="getRandomString" hint="Generates random string." access="public" output="false" returntype="string">
    	<cfargument name="case" type="string" default="mixed" hint="Whether upper, lower or mixed" />
        <cfargument name="format" type="string" default="alphanumeric" hint="Whether to generate numeric, string, alphanumeric or special (includes alphanumeric and special characters such as ! @ & etc)" />
        <cfargument name="invalidCharacters" type="string" default="" hint="List of invalid characters which will be excluded from the key. This overrides the default list" />
        <cfargument name="length" type="numeric" default="8" hint="The length of the key to generate" />
        <cfargument name="numericPrefix" type="numeric" default="0" hint="Number of random digits to start the key with (the rest of the key will be whatever the 'format' is)" />
        <cfargument name="numericSuffix" type="numeric" default="0" hint="Number of random digits to end the key with (the rest of the key will be whatever the 'format' is)" />
        <cfargument name="fixedPrefix" type="string" default="" hint="A prefix prepended to the generated key. The length of which is subtracted from the 'length' argument" />
        <cfargument name="fixedSuffix" type="string" default="" hint="A suffix appended to the generated key. The length of which is subtracted from the 'length' argument" />
        <cfargument name="specialChars" type="string" default="" hint="List of special chars to help generate key from. Overrides the default 'characterMap.special' list" />
        <cfargument name="debug" type="boolean" default="false" hint="Returns cfcatch information in the event of an error. Try turning on if function returns no value." />
    
        <cfscript>        
			var i = 0;
			var key = "";
			var keyCase = arguments.case;
			var keyLength = arguments.length;
			var uniqueChar = "";
			var invalidChars = "o,i,l,s,O,I,L,S";    //Possibly confusing characters we will remove
			var characterMap = structNew();
			var characterLib = "";
			var libLength = 0;
			
			try
			{
				
				characterMap.numeric = "0,1,2,3,4,5,6,7,8,9";
				characterMap.stringLower = "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z";
				characterMap.stringUpper = UCase(characterMap.stringLower);
				characterMap.stringCombined = listAppend(characterMap.stringLower, characterMap.stringUpper);
							
				if (len(trim(arguments.specialChars)))
					characterMap.special = arguments.specialChars;
				else
					characterMap.special = "!,@,##,$,%,^,&,*,(,),_,-,=,+,/,\,[,],{,},<,>,~";
	
				switch (arguments.format) {
					case "numeric":
						characterLib = characterMap.numeric;            
						break;
						
					case "string":
						if (keyCase EQ "upper")
						{
							characterLib = characterMap.stringUpper;
						}                
						else if (keyCase EQ "lower")
						{
							characterLib = characterMap.stringLower;
						}                
						else if (keyCase EQ "mixed")
						{
							characterLib = characterMap.stringCombined;
						}
						break;
						
					case "alphanumeric":
						invalidChars = invalidChars.concat(",0,1,5");        //Possibly confusing chars removed
						if (keyCase EQ "upper")
						{
							characterLib = listAppend(characterMap.numeric, characterMap.stringUpper);
						}
						else if (keyCase EQ "lower")
						{
							characterLib = listAppend(characterMap.numeric, characterMap.stringLower);
						}                
						else if (keyCase EQ "mixed")
						{
							characterLib = listAppend(characterMap.numeric, characterMap.stringCombined);
						}
						break;
						
					case "special":
						invalidChars = invalidChars.concat(",0,1,5");        //Possibly confusing chars removed
						if (keyCase EQ "upper")
						{
							characterLib = listAppend(listAppend(characterMap.numeric, characterMap.stringUpper), characterMap.special);
						}
						else if (keyCase EQ "lower")
						{
							characterLib = listAppend(listAppend(characterMap.numeric, characterMap.stringLower), characterMap.special);
						}                    
						else if (keyCase EQ "mixed")
						{
							characterLib = listAppend(listAppend(characterMap.numeric, characterMap.stringCombined), characterMap.special);
						}
						break;
				}
		
				if (len(trim(arguments.invalidCharacters)))
					invalidChars = arguments.invalidCharacters;
		
				if (len(trim(arguments.fixedPrefix))) {
					key = arguments.fixedPrefix;
					keyLength = keyLength - len(trim(arguments.fixedPrefix));
				}
				
				if (len(trim(arguments.fixedSuffix))) {
					keyLength = keyLength - len(trim(arguments.fixedSuffix));
				}
			
				libLength = listLen(characterLib);
		
				for (i = 1;i LTE keyLength;i=i+1) {
					do {
						if (arguments.numericPrefix GT 0 AND i LTE arguments.numericPrefix) {
							uniqueChar = listGetAt(characterMap.numeric, randRange(1, listLen(characterMap.numeric)));
						}
						else if (arguments.numericSuffix GT 0 AND keyLength-i LT arguments.numericSuffix) {
							uniqueChar = randRange(characterMap.numeric, randRange(1, listLen(characterMap.numeric)));
						}
						else {
							uniqueChar = listGetAt(characterLib, randRange(1, libLength));
						}
					}
					while (listFind(invalidChars, uniqueChar));                
					key = key.concat(uniqueChar);
				}
				
				if (len(trim(arguments.fixedSuffix)))
					key = key.concat(trim(arguments.fixedSuffix));
	
			}
			catch (Any e) {
				if (arguments.debug)
					key = e.message & " " & e.detail;
				else
					key = "";
			}
	
			return key;
    	</cfscript>
    </cffunction>
	
    <cffunction name="QueryToCSV" access="Public" returntype="string" output="false" hint="I take a query and convert it to a comma separated value string.">
        <cfargument name="Query" type="query" required="true" hint="I am the query being converted to CSV." />
        <cfargument name="Fields" type="string" required="true" hint="I am the list of query fields to be used when creating the CSV value." />
        <cfargument name="CreateHeaderRow" type="boolean" required="false" default="true" hint="I flag whether or not to create a row of header values." />
        <cfargument name="Delimiter" type="string" required="false" default="," hint="I am the field delimiter in the CSV value." />
         
        <!--- Define the local scope. --->
        <cfset var LOCAL = {} />
         
        <!---
        First, we want to set up a column index so that we can
        iterate over the column names faster than if we used a
        standard list loop on the passed-in list.
        --->
        <cfset LOCAL.ColumnNames = {} />
         
        <!---
        Loop over column names and index them numerically. We
        are going to be treating this struct almost as if it
        were an array. The reason we are doing this is that
        look-up times on a table are a bit faster than look
        up times on an array (or so I have been told).
        --->
        <cfloop index="LOCAL.ColumnName" list="#ARGUMENTS.Fields#" delimiters=",">
            <!--- Store the current column name. --->
            <cfset LOCAL.ColumnNames[ StructCount( LOCAL.ColumnNames ) + 1 ] = Trim( LOCAL.ColumnName ) />
        </cfloop>
         
        <!--- Store the column count. --->
        <cfset LOCAL.ColumnCount = StructCount( LOCAL.ColumnNames ) />
         
        <!---
        Now that we have our index in place, let's create
        a string buffer to help us build the CSV value more
        effiently.
        --->
        <cfset LOCAL.Buffer = CreateObject( "java", "java.lang.StringBuffer" ).Init() />
     
        <!--- Create a short hand for the new line characters. --->
        <cfset LOCAL.NewLine = (Chr( 13 ) & Chr( 10 )) />
     
        <!--- Check to see if we need to add a header row. --->
        <cfif ARGUMENTS.CreateHeaderRow>
            <!--- Loop over the column names. --->
            <cfloop index="LOCAL.ColumnIndex" from="1" to="#LOCAL.ColumnCount#" step="1">
                <!--- Append the field name. --->
                <cfset LOCAL.Buffer.Append(JavaCast("string","""#LOCAL.ColumnNames[ LOCAL.ColumnIndex ]#""")) />
                 
                <!--- Check to see which delimiter we need to add: field or line. --->
                <cfif (LOCAL.ColumnIndex LT LOCAL.ColumnCount)>
                    <!--- Field delimiter. --->
                    <cfset LOCAL.Buffer.Append(JavaCast( "string", ARGUMENTS.Delimiter )) />
                <cfelse>
                    <!--- Line delimiter. --->
                    <cfset LOCAL.Buffer.Append(JavaCast( "string", LOCAL.NewLine )) />
                </cfif>
            </cfloop>
        </cfif>
     
        <!---
        Now that we have dealt with any header value, let's
        convert the query body to CSV. When doing this, we are
        going to qualify each field value. This is done be
        default since it will be much faster than actually
        checking to see if a field needs to be qualified.
        --->
     
        <!--- Loop over the query. --->
        <cfloop query="ARGUMENTS.Query">
            <!--- Loop over the columns. --->
            <cfloop index="LOCAL.ColumnIndex" from="1" to="#LOCAL.ColumnCount#" step="1">
                <!--- Append the field value. --->
                <cfset LOCAL.Buffer.Append(JavaCast("string","""#ARGUMENTS.Query[ LOCAL.ColumnNames[ LOCAL.ColumnIndex ] ][ ARGUMENTS.Query.CurrentRow ]#""")) />
     
                <!--- Check to see which delimiter we need to add: field or line. --->
                <cfif (LOCAL.ColumnIndex LT LOCAL.ColumnCount)>
                    <!--- Field delimiter. --->
                    <cfset LOCAL.Buffer.Append(JavaCast( "string", ARGUMENTS.Delimiter )) />
                <cfelse>
                    <!--- Line delimiter. --->
                    <cfset LOCAL.Buffer.Append(JavaCast( "string", LOCAL.NewLine )) />
                </cfif>
            </cfloop>
        </cfloop>
     
        <!--- Return the CSV value. --->
        <cfreturn LOCAL.Buffer.ToString() />
    </cffunction>
    
	<cfscript>
	/**
	* Returns True if the date provided in the first argument lies between the two dates in the second and third arguments.
	*
	* @param dateObj      CF Date Object you want to test.
	* @param dateObj1      CF Date Object for the starting date.
	* @param dateObj2      CF Date Object for the ending date.
	* @return Returns a Boolean.
	* @author Bill King (bking@hostworks.com)
	* @version 1, November 29, 2001
	*/
	function IsDateBetween(dateObj, dateCompared1, dateCompared2) {
	   return YesNoFormat((DateCompare(dateObj, dateCompared1) gt -1) AND (DateCompare(dateObj, dateCompared2) lt 1));
	}

	/**
	* Convert the query into a CSV format using Java StringBuffer Class.
	*
	* @param query      The query to convert. (Required)
	* @param headers      A list of headers to use for the first row of the CSV string. Defaults to all the columns. (Optional)
	* @param cols      The columns from the query to transform. Defaults to all the columns. (Optional)
	* @return Returns a string.
	* @author Qasim Rasheed (qasimrasheed@hotmail.com)
	* @version 1, March 23, 2005
	*/
	function QueryToCSV2(query){
		var csv = createobject( 'java', 'java.lang.StringBuffer');
		var i = 1;
		var j = 1;
		var cols = "";
		var headers = "";
		var endOfLine = chr(13) & chr(10);
		if (arraylen(arguments) gte 2) headers = arguments[2];
		if (arraylen(arguments) gte 3) cols = arguments[3];
		if (not len( trim( cols ) ) ) cols = query.columnlist;
		if (not len( trim( headers ) ) ) headers = cols;
		headers = listtoarray( headers );
		cols = listtoarray( cols );
		
		for (i = 1; i lte arraylen( headers ); i = i + 1)
			csv.append( '"' & headers[i] & '",' );
		csv.append( endOfLine );
		
		for (i = 1; i lte query.recordcount; i= i + 1){
			for (j = 1; j lte arraylen( cols ); j=j + 1){
				if (isNumeric( query[cols[j]][i] ) )
					csv.append( query[cols[j]][i] & ',' );
				else
					csv.append( '"' & Application.UDF.StripAllBut(StripHTML(query[cols[j]][i]),"abcdefghijklmnopqrstuvwxyz0123456789/: .'-",false) & '",' );
				
			}
			csv.append( endOfLine );
		}
		return csv.toString();
	}

    /**
    * Removes HTML from the string.
    * v2 - Mod by Steve Bryant to find trailing, half done HTML.
    *
    * @param string      String to be modified. (Required)
    * @return Returns a string.
    * @author Raymond Camden (ray@camdenfamily.com)
    * @version 3, July 9, 2008
    */
    function stripHTML(str) {
        str = reReplaceNoCase(str, "<.*?>","","all");
        //get partial html in front
        str = reReplaceNoCase(str, "^.*?>","");
        //get partial html at end
        str = reReplaceNoCase(str, "<.*$","");
        return str;
    }
	</cfscript>

	<cffunction name="jsonencode" access="remote" returntype="string" output="No" hint="Converts data from CF to JSON format">
        <cfargument name="data" type="any" required="Yes" />
        <cfargument name="queryFormat" type="string" required="No" default="query" /> <!-- query or array -->
        <cfargument name="queryKeyCase" type="string" required="No" default="lower" /> <!-- lower or upper -->
        <cfargument name="stringNumbers" type="boolean" required="No" default=false >
        <cfargument name="formatDates" type="boolean" required="No" default=false >
        <cfargument name="columnListFormat" type="string" required="No" default="string" > <!-- string or array -->
    
        <!--- VARIABLE DECLARATION --->
        <cfset var jsonString = "" />
        <cfset var tempVal = "" />
        <cfset var arKeys = "" />
        <cfset var colPos = 1 />
        <cfset var i = 1 />
        <cfset var column = ""/>
        <cfset var datakey = ""/>
        <cfset var recordcountkey = ""/>
        <cfset var columnlist = ""/>
        <cfset var columnlistkey = ""/>
        <cfset var dJSONString = "" />
        <cfset var escapeToVals = "\\,\"",\/,\b,\t,\n,\f,\r" />
        <cfset var escapeVals = "\,"",/,#Chr(8)#,#Chr(9)#,#Chr(10)#,#Chr(12)#,#Chr(13)#" />
    
        <cfset var _data = arguments.data />

        <!--- BOOLEAN --->
        <cfif IsBoolean(_data) AND NOT IsNumeric(_data) AND NOT ListFindNoCase("Yes,No", _data)>
            <cfreturn LCase(ToString(_data)) />
            
        <!--- NUMBER --->
        <cfelseif NOT stringNumbers AND IsNumeric(_data) AND NOT REFind("^0+[^\.]",_data)>
            <cfreturn ToString(_data) />
        
        <!--- DATE --->
        <cfelseif IsDate(_data) AND arguments.formatDates>
            <cfreturn '"#DateFormat(_data, "medium")# #TimeFormat(_data, "medium")#"' />
        
        <!--- STRING --->
        <cfelseif IsSimpleValue(_data)>
            <cfreturn '"' & ReplaceList(_data, escapeVals, escapeToVals) & '"' />
        
        <!--- ARRAY --->
        <cfelseif IsArray(_data)>
            <cfset dJSONString = createObject('java','java.lang.StringBuffer').init("") />
            <cfloop from="1" to="#ArrayLen(_data)#" index="i">
                <cfset tempVal = jsonencode( _data[i], arguments.queryFormat, arguments.queryKeyCase, arguments.stringNumbers, arguments.formatDates, arguments.columnListFormat ) />
                <cfif dJSONString.toString() EQ "">
                    <cfset dJSONString.append(tempVal) />
                <cfelse>
                    <cfset dJSONString.append("," & tempVal) />
                </cfif>
            </cfloop>
            
            <cfreturn "[" & dJSONString.toString() & "]" />
        
        <!--- STRUCT --->
        <cfelseif IsStruct(_data)>
            <cfset dJSONString = createObject('java','java.lang.StringBuffer').init("") />
            <cfset arKeys = StructKeyArray(_data) />
            <cfloop from="1" to="#ArrayLen(arKeys)#" index="i">
                <cfset tempVal = jsonencode( _data[ arKeys[i] ], arguments.queryFormat, arguments.queryKeyCase, arguments.stringNumbers, arguments.formatDates, arguments.columnListFormat ) />
                <cfif dJSONString.toString() EQ "">
                    <cfset dJSONString.append('"' & arKeys[i] & '":' & tempVal) />
                <cfelse>
                    <cfset dJSONString.append("," & '"' & arKeys[i] & '":' & tempVal) />
                </cfif>
            </cfloop>
            
            <cfreturn "{" & dJSONString.toString() & "}" />
        
        <!--- QUERY --->
        <cfelseif IsQuery(_data)>
            <cfset dJSONString = createObject('java','java.lang.StringBuffer').init("") />
            
            <!--- Add query meta data --->
            <cfif arguments.queryKeyCase EQ "lower">
                <cfset recordcountKey = "recordcount" />
                <cfset columnlistKey = "columnlist" />
                <cfset columnlist = LCase(_data.columnlist) />
                <cfset dataKey = "data" />
            <cfelse>
                <cfset recordcountKey = "RECORDCOUNT" />
                <cfset columnlistKey = "COLUMNLIST" />
                <cfset columnlist = _data.columnlist />
                <cfset dataKey = "data" />
            </cfif>
            
            <cfset dJSONString.append('"#recordcountKey#":' & _data.recordcount) />
            <cfif arguments.columnListFormat EQ "array">
                <cfset columnlist = "[" & ListQualify(columnlist, '"') & "]" />
                <cfset dJSONString.append(',"#columnlistKey#":' & columnlist) />
            <cfelse>
                <cfset dJSONString.append(',"#columnlistKey#":"' & columnlist & '"') />
            </cfif>
            <cfset dJSONString.append(',"#dataKey#":') />
            
            <!--- Make query a structure of arrays --->
            <cfif arguments.queryFormat EQ "query">
                <cfset dJSONString.append("{") />
                <cfset colPos = 1 />
                
                <cfloop list="#_data.columnlist#" delimiters="," index="column">
                    <cfif colPos GT 1>
                        <cfset dJSONString.append(",") />
                    </cfif>
                    <cfif arguments.queryKeyCase EQ "lower">
                        <cfset column = LCase(column) />
                    </cfif>
                    <cfset dJSONString.append('"' & column & '":[') />
                    
                    <cfloop from="1" to="#_data.recordcount#" index="i">
                        <!--- Get cell value; recurse to get proper format depending on string/number/boolean data type --->
                        <cfset tempVal = jsonencode( _data[column][i], arguments.queryFormat, arguments.queryKeyCase, arguments.stringNumbers, arguments.formatDates, arguments.columnListFormat ) />
                        
                        <cfif i GT 1>
                            <cfset dJSONString.append(",") />
                        </cfif>
                        <cfset dJSONString.append(tempVal) />
                    </cfloop>
                    
                    <cfset dJSONString.append("]") />
                    
                    <cfset colPos = colPos + 1 />
                </cfloop>
                <cfset dJSONString.append("}") />
            <!--- Make query an array of structures --->
            <cfelse>
                <cfset dJSONString.append("[") />
                <cfloop query="_data">
                    <cfif CurrentRow GT 1>
                        <cfset dJSONString.append(",") />
                    </cfif>
                    <cfset dJSONString.append("{") />
                    <cfset colPos = 1 />
                    <cfloop list="#columnlist#" delimiters="," index="column">
                        <cfset tempVal = jsonencode( _data[column][CurrentRow], arguments.queryFormat, arguments.queryKeyCase, arguments.stringNumbers, arguments.formatDates, arguments.columnListFormat ) />
                        
                        <cfif colPos GT 1>
                            <cfset dJSONString.append(",") />
                        </cfif>
                        
                        <cfif arguments.queryKeyCase EQ "lower">
                            <cfset column = LCase(column) />
                        </cfif>
                        <cfset dJSONString.append('"' & column & '":' & tempVal) />
                        
                        <cfset colPos = colPos + 1 />
                    </cfloop>
                    <cfset dJSONString.append("}") />
                </cfloop>
                <cfset dJSONString.append("]") />
            </cfif>
            
            <!--- Wrap all query data into an object --->
            <cfreturn "{" & dJSONString.toString() & "}" />
        
        <!--- UNKNOWN OBJECT TYPE --->
        <cfelse>
            <cfreturn '"' & "unknown-obj" & '"' />
        </cfif>
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
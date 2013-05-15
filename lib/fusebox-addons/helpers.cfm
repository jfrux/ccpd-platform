<cfset request.cgi = CGI />
<cfset _ = createObject("component","lib.Underscore").init() />
<cfscript>
/**
 * Format a range of dates (&quot;August 3 - 11, 2003&quot;).
 * Small bug in last statement was losing end date. RKC
 * 
 * @param startDate    Initial date. Defaults to now. (Optional)
 * @param endDate    Ending date. Defaults to now. (Optional)
 * @param format   Either "long" or "short". Defaults to long. (Optional)
 * @return Returns a string. 
 * @author Bryan Buchs (&#98;&#98;&#117;&#99;&#104;&#115;&#64;&#109;&#97;&#99;&#46;&#99;&#111;&#109;) 
 * @version 1, June 8, 2004 
 */
function DateRangeFormat() {
  var format = "long";
  var longformat = "mmmm d, yyyy";
  var shortformat = "m/d/yy";
  var applyformat = longformat;
  var startDate = now();
  var endDate = now();
  var startFormat = DateFormat(startDate,format);
  var endFormat = DateFormat(endDate,format);
  var DateRangeFormat = startFormat;
  
  if (arrayLen(arguments) GTE 1) { startDate = arguments[1]; }
  if (arrayLen(arguments) GTE 2) { endDate = arguments[2]; }
  if (arrayLen(arguments) GTE 3) { format = arguments[3]; }
  
  if(format is not "long" and format is not "short") format = "long";
  if(format is not "long") applyformat = shortformat;
  
  //case one, same month and year
  if(year(startDate) is year(endDate) and month(startDate) is month(endDate)) {
    startFormat = dateFormat(startDate,ReplaceNoCase(applyformat,"y","","All"));
    if(format is "long") {
      endFormat = dateFormat(endDate,ReplaceNoCase(applyformat,"m","","All"));
    } else {
      endFormat = dateFormat(endDate,applyformat);
    }
  } else if(year(startDate) is year(endDate)) {
  //case two, same year
    startFormat = DateFormat(startDate,ReplaceNoCase(applyformat,"y","","All"));
    endFormat = DateFormat(endDate,applyformat);
  } else {
  //case three, different year and month, dont change anything
    startFormat = DateFormat(startDate,applyformat);
    endFormat = DateFormat(endDate,applyformat);
  }

  if (right(trim(startFormat),1) EQ "," or right(trim(startFormat),1) EQ "/") { 
    startFormat = trim(RemoveChars(startFormat,len(trim(startFormat)), 1)); 
  }

  if (arrayLen(arguments) GTE 2 AND startDate NEQ endDate) {
    DateRangeFormat = startFormat & " - " & endFormat;
  } else {
    DateRangeFormat = dateFormat(startDate,applyformat);
  }
  
  return trim(DateRangeFormat);
}
</cfscript>
<cffunction name="$createParams" returntype="struct" access="public" output="false">
  <cfargument name="path" type="string" required="true">
  <!--- <cfargument name="route" type="struct" required="true"> --->
  <cfargument name="formScope" type="struct" required="true">
  <cfargument name="urlScope" type="struct" required="true">
  <cfscript>
    var loc = {};

    loc.params = {};
    loc.params = $mergeURLAndFormScopes(loc.params, arguments.urlScope, arguments.formScope);
    // loc.params = $mergeRoutePattern(loc.params, arguments.route, arguments.path);
    // loc.params = $decryptParams(loc.params);
    // loc.params = $translateBlankCheckBoxSubmissions(loc.params);
    // loc.params = $translateDatePartSubmissions(loc.params);
    loc.params = $createNestedParamStruct(loc.params);
    /***********************************************
    * We now do the routing and controller
    * params after we have built all other params
    * so that we don't have more logic around
    * params in arrays
    ***********************************************/
    //loc.params = $ensureControllerAndAction(loc.params, arguments.route);
    // loc.params = $addRouteFormat(loc.params, arguments.route);
    // loc.params = $addRouteName(loc.params, arguments.route);
  </cfscript>
  <cfreturn loc.params>
</cffunction>
<cffunction name="$paramParser" returntype="struct" access="public" output="false">
  <cfargument name="pathInfo" type="string" required="false" default="#request.cgi.path_info#">
  <cfargument name="scriptName" type="string" required="false" default="#request.cgi.script_name#">
  <cfargument name="formScope" type="struct" required="false" default="#form#">
  <cfargument name="urlScope" type="struct" required="false" default="#url#">
  <cfscript>
    var loc = {};
    loc.path = $getPathFromRequest(pathInfo=arguments.pathInfo, scriptName=arguments.scriptName);
    
    return $createParams(path=loc.path, formScope=arguments.formScope, urlScope=arguments.urlScope);
  </cfscript>
</cffunction>
<cffunction name="$getPathFromRequest" returntype="string" access="public" output="false">
  <cfargument name="pathInfo" type="string" required="true">
  <cfargument name="scriptName" type="string" required="true">
  <cfscript>
    var returnValue = "";
    // we want the path without the leading "/" so this is why we do some checking here
    if (arguments.pathInfo == arguments.scriptName || arguments.pathInfo == "/" || arguments.pathInfo == "")
      returnValue = "";
    else
      returnValue = Right(arguments.pathInfo, Len(arguments.pathInfo)-1);
  </cfscript>
  <cfreturn returnValue>
</cffunction>
<cffunction name="$mergeURLAndFormScopes" returntype="struct" access="public" output="false"
  hint="merges the url and form scope into a single structure. url scope has presidence">
  <cfargument name="params" type="struct" required="true">
  <cfargument name="urlScope" type="struct" required="true">
  <cfargument name="formScope" type="struct" required="true">
  <cfscript>
    structAppend(arguments.params, arguments.formScope, true);
    structAppend(arguments.params, arguments.urlScope, true);
  
    // get rid of the fieldnames
    StructDelete(arguments.params, "fieldnames", false);
  </cfscript>
  <cfreturn arguments.params>
</cffunction>

<cffunction name="$createNestedParamStruct" returntype="struct" access="public" output="false">
  <cfargument name="params" type="struct" required="true" />
  <cfscript>
    var loc = {};
    for (loc.key in arguments.params)
    {
      if (Find("[", loc.key) && Right(loc.key, 1) == "]")
      {
        // object form field
        loc.name = SpanExcluding(loc.key, "[");
        
        // we split the key into an array so the developer can have unlimited levels of params passed in
        loc.nested = ListToArray(ReplaceList(loc.key, loc.name & "[,]", ""), "[", true);
        if (!StructKeyExists(arguments.params, loc.name))
          arguments.params[loc.name] = {};
        
        loc.struct = arguments.params[loc.name]; // we need a reference to the struct so we can nest other structs if needed
        loc.iEnd = ArrayLen(loc.nested);
        for (loc.i = 1; loc.i lte loc.iEnd; loc.i++) // looping over the array allows for infinite nesting
        {
          loc.item = loc.nested[loc.i];
          if (!StructKeyExists(loc.struct, loc.item))
            loc.struct[loc.item] = {};
          if (loc.i != loc.iEnd)
            loc.struct = loc.struct[loc.item]; // pass the new reference (structs pass a reference instead of a copy) to the next iteration
          else
            loc.struct[loc.item] = arguments.params[loc.key];
        }
        // delete the original key so it doesn't show up in the params
        StructDelete(arguments.params, loc.key, false);
      }
    }
  </cfscript>
  <cfreturn arguments.params />
</cffunction>
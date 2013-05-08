<cffunction name="$args" returntype="void" access="public" output="false">
  <cfargument name="args" type="struct" required="true">
  <cfargument name="name" type="string" required="true">
  <cfargument name="reserved" type="string" required="false" default="">
  <cfargument name="combine" type="string" required="false" default="">
  <cfargument name="required" type="string" required="false" default="">
  <cfscript>
    var loc = {};
    if (Len(arguments.combine))
    {
      loc.iEnd = ListLen(arguments.combine);
      for (loc.i=1; loc.i <= loc.iEnd; loc.i++)
      {
        loc.item = ListGetAt(arguments.combine, loc.i);
        loc.first = ListGetAt(loc.item, 1, "/");
        loc.second = ListGetAt(loc.item, 2, "/");
        loc.required = false;
        if (ListLen(loc.item, "/") > 2 || ListFindNoCase(loc.first, arguments.required))
        {
          loc.required = true;
        }
        $combineArguments(args=arguments.args, combine="#loc.first#,#loc.second#", required=loc.required);
      }
    }
    if (application.wheels.showErrorInformation)
    {
      if (ListLen(arguments.reserved))
      {
        loc.iEnd = ListLen(arguments.reserved);
        for (loc.i=1; loc.i <= loc.iEnd; loc.i++)
        {
          loc.item = ListGetAt(arguments.reserved, loc.i);
          if (StructKeyExists(arguments.args, loc.item))
            $throw(type="Wheels.IncorrectArguments", message="The `#loc.item#` argument cannot be passed in since it will be set automatically by Wheels.");
        }
      }
    }
    if (StructKeyExists(application.wheels.functions, arguments.name))
      StructAppend(arguments.args, application.wheels.functions[arguments.name], false);

    // make sure that the arguments marked as required exist
    if (Len(arguments.required))
    {
      loc.iEnd = ListLen(arguments.required);
      for (loc.i=1; loc.i <= loc.iEnd; loc.i++)
      {
        loc.arg = ListGetAt(arguments.required, loc.i);
        if(!StructKeyExists(arguments.args, loc.arg))
        {
          $throw(type="Wheels.IncorrectArguments", message="The `#loc.arg#` argument is required but not passed in.");
        }
      }
    }
  </cfscript>
</cffunction>
<cffunction name="$tag" returntype="string" access="public" output="false" hint="Creates a HTML tag with attributes.">
  <cfargument name="name" type="string" required="true" hint="The name of the HTML tag.">
  <cfargument name="attributes" type="struct" required="false" default="#StructNew()#" hint="The attributes and their values">
  <cfargument name="close" type="boolean" required="false" default="false" hint="Whether or not to close the tag (self-close) or just end it with a bracket.">
  <cfargument name="skip" type="string" required="false" default="" hint="List of attributes that should not be placed in the HTML tag.">
  <cfargument name="skipStartingWith" type="string" required="false" default="" hint="If you want to skip attributes that start with a specific string you can specify it here.">
  <cfscript>
    var loc = {};
    
    // start the HTML tag and give it its name
    loc.returnValue = "<" & arguments.name;
    
    // if named arguments are passed in we add these to the attributes argument instead so we can handle them all in the same code below
    if (StructCount(arguments) gt 5)
    {
      for (loc.key in arguments)
      {
        if (!ListFindNoCase("name,attributes,close,skip,skipStartingWith", loc.key))
        {
          arguments.attributes[loc.key] = arguments[loc.key];
        }
      }
    }
    
    // add the names of the attributes and their values to the output string with a space in between (class="something" name="somethingelse" etc)
    // since the order of a struct can differ we sort the attributes in alphabetical order before placing them in the HTML tag (we could just place them in random order in the HTML but that would complicate testing for example)
    loc.sortedKeys = ListSort(StructKeyList(arguments.attributes), "textnocase");
    loc.iEnd = ListLen(loc.sortedKeys);

    for (loc.i=1; loc.i lte loc.iEnd; loc.i++)
    {
      loc.key = ListGetAt(loc.sortedKeys, loc.i);
      // place the attribute name and value in the string unless it should be skipped according to the arguments or if it's an internal argument (starting with a "$" sign)
      if (!ListFindNoCase(arguments.skip, loc.key) && (!Len(arguments.skipStartingWith) || Left(loc.key, Len(arguments.skipStartingWith)) != arguments.skipStartingWith) && Left(loc.key, 1) != "$")
      {
        // replace boolean arguments for the disabled and readonly attributs with the key (if true) or skip putting it in the output altogether (if false)
        if (ListFindNoCase("disabled,readonly", loc.key) and IsBoolean(arguments.attributes[loc.key]))
        {
          if (arguments.attributes[loc.key])
          {
            loc.returnValue &= $tagAttribute(loc.key, LCase(loc.key));
          }
        }
        else
        {
          loc.returnValue &= $tagAttribute(loc.key, arguments.attributes[loc.key]);
        }
      }
    }

    // close the tag (usually done on self-closing tags like "img" for example) or just end it (for tags like "div" for example)
    if (arguments.close)
    {
      loc.returnValue &= " />";
    }
    else
    {
      loc.returnValue &= ">";
    }   
  </cfscript>
  <cfreturn loc.returnValue>
</cffunction>
<cffunction name="$createObjectFromRoot" returntype="any" access="public" output="false">
  <cfargument name="path" type="string" required="true">
  <cfargument name="fileName" type="string" required="true">
  <cfargument name="method" type="string" required="true">
  <cfscript>
    var returnValue = "";
    arguments.returnVariable = "returnValue";
    arguments.component = ListChangeDelims(arguments.path, ".", "/") & "." & ListChangeDelims(arguments.fileName, ".", "/");
    arguments.argumentCollection = Duplicate(arguments);
    StructDelete(arguments, "path");
    StructDelete(arguments, "fileName");
  </cfscript>
  <cfinvoke attributeCollection="#arguments#">
  <cfreturn returnValue>
</cffunction>
<cffunction name="$tagAttribute" returntype="string" access="public" output="false">
  <cfargument name="name" type="string" required="true">
  <cfargument name="value" type="string" required="true">
  <cfreturn ' #LCase(arguments.name)#="#arguments.value#"'>
</cffunction>

<cffunction name="$element" returntype="string" access="public" output="false">
  <cfargument name="name" type="string" required="true">
  <cfargument name="attributes" type="struct" required="false" default="#StructNew()#">
  <cfargument name="content" type="string" required="false" default="">
  <cfargument name="skip" type="string" required="false" default="">
  <cfargument name="skipStartingWith" type="string" required="false" default="">
  <cfscript>
    var returnValue = "";
    returnValue = arguments.content;
    StructDelete(arguments, "content");
    returnValue = $tag(argumentCollection=arguments) & returnValue & "</" & arguments.name & ">";
  </cfscript>
  <cfreturn returnValue>
</cffunction>

<cffunction name="$debugPoint" returntype="void" access="public" output="false">
  <cfargument name="name" type="string" required="true">
  <cfscript>
    var loc = {};
    if (!StructKeyExists(request.wheels, "execution"))
      request.wheels.execution = {};
    loc.iEnd = ListLen(arguments.name);
    for (loc.i=1; loc.i <= loc.iEnd; loc.i++)
    {
      loc.item = ListGetAt(arguments.name, loc.i);
      if (StructKeyExists(request.wheels.execution, loc.item))
        request.wheels.execution[loc.item] = GetTickCount() - request.wheels.execution[loc.item];
      else
        request.wheels.execution[loc.item] = GetTickCount();
    }
  </cfscript>
</cffunction>

<cffunction name="$cachedControllerClassExists" returntype="any" access="public" output="false">
  <cfargument name="name" type="string" required="true">
    <cfscript>
      var returnValue = false;
      if (StructKeyExists(application.wheels.controllers, arguments.name))
        returnValue = application.wheels.controllers[arguments.name];
    </cfscript>
  <cfreturn returnValue>
</cffunction>

<cffunction name="$fileExistsNoCase" returntype="boolean" access="public" output="false">
  <cfargument name="absolutePath" type="string" required="true">
  <cfscript>
    var loc = {};

    // break up the full path string in the path name only and the file name only
    loc.path = GetDirectoryFromPath(arguments.absolutePath);
    loc.file = Replace(arguments.absolutePath, loc.path, "");

    // get all existing files in the directory and place them in a list
    loc.dirInfo = $directory(directory=loc.path);
    loc.fileList = ValueList(loc.dirInfo.name);

    // loop through the file list and return true if the file exists regardless of case (the == operator is case insensitive)
    loc.iEnd = ListLen(loc.fileList);
    for (loc.i=1; loc.i <= loc.iEnd; loc.i++)
      if (ListGetAt(loc.fileList, loc.i) == loc.file)
        return true;

    // the file wasn't found in the directory so we return false
    return false;
  </cfscript>
</cffunction>

<cffunction name="$objectFileName" returntype="string" access="public" output="false">
  <cfargument name="name" type="string" required="true">
  <cfargument name="objectPath" type="string" required="true">
  <cfargument name="type" type="string" required="true" hint="Can be either `controller` or `model`." />
  <cfscript>
    var loc = {};
    loc.objectFileExists = false;

    // if the name contains the delimiter let's capitalize the last element and append it back to the list
    if (ListLen(arguments.name, "/") gt 1)
      arguments.name = ListInsertAt(arguments.name, ListLen(arguments.name, "/"), capitalize(ListLast(arguments.name, "/")), "/");
    else
      arguments.name = capitalize(arguments.name);

    // we are going to store the full controller path in the existing / non-existing lists so we can have controllers in multiple places
    loc.fullObjectPath = arguments.objectPath & "/" & arguments.name;

    if (!ListFindNoCase(application.wheels.existingObjectFiles, loc.fullObjectPath) && !ListFindNoCase(application.wheels.nonExistingObjectFiles, loc.fullObjectPath))
    {
      if (FileExists(ExpandPath("#loc.fullObjectPath#.cfc")))
        loc.objectFileExists = true;
      if (application.wheels.cacheFileChecking)
      {
        if (loc.objectFileExists)
          application.wheels.existingObjectFiles = ListAppend(application.wheels.existingObjectFiles, loc.fullObjectPath);
        else
          application.wheels.nonExistingObjectFiles = ListAppend(application.wheels.nonExistingObjectFiles, loc.fullObjectPath);
      }
    }
    if (ListFindNoCase(application.wheels.existingObjectFiles, loc.fullObjectPath) || loc.objectFileExists)
      loc.returnValue = arguments.name;
    else
      loc.returnValue = capitalize(arguments.type);
  </cfscript>
  <cfreturn loc.returnValue>
</cffunction>

<cffunction name="$createControllerClass" returntype="any" access="public" output="false">
  <cfargument name="name" type="string" required="true">
  <cfargument name="controllerPaths" type="string" required="false" default="#application.wheels.controllerPath#">
  <cfargument name="type" type="string" required="false" default="controller" />
  <cfscript>
    var loc = {};

    // let's allow for multiple controller paths so that plugins can contain controllers
    // the last path is the one we will instantiate the base controller on if the controller is not found on any of the paths
    for (loc.i = 1; loc.i lte ListLen(arguments.controllerPaths); loc.i++)
    {
      loc.controllerPath = ListGetAt(arguments.controllerPaths, loc.i);
      loc.fileName = $objectFileName(name=arguments.name, objectPath=loc.controllerPath, type=arguments.type);

      if (loc.fileName != "Controller" || loc.i == ListLen(arguments.controllerPaths))
      {
        application.wheels.controllers[arguments.name] = $createObjectFromRoot(path=loc.controllerPath, fileName=loc.fileName, method="$initControllerClass", name=arguments.name);
        loc.returnValue = application.wheels.controllers[arguments.name];
        break;
      }
    }
  </cfscript>
  <cfreturn loc.returnValue>
</cffunction>

<cffunction name="$addToCache" returntype="void" access="public" output="false">
  <cfargument name="key" type="string" required="true">
  <cfargument name="value" type="any" required="true">
  <cfargument name="time" type="numeric" required="false" default="#application.wheels.defaultCacheTime#">
  <cfargument name="category" type="string" required="false" default="main">
  <cfscript>
    var loc = {};
    if (application.wheels.cacheCullPercentage > 0 && application.wheels.cacheLastCulledAt < DateAdd("n", -application.wheels.cacheCullInterval, Now()) && $cacheCount() >= application.wheels.maximumItemsToCache)
    {
      // cache is full so flush out expired items from this cache to make more room if possible
      loc.deletedItems = 0;
      loc.cacheCount = $cacheCount();
      for (loc.key in application.wheels.cache[arguments.category])
      {
        if (Now() > application.wheels.cache[arguments.category][loc.key].expiresAt)
        {
          $removeFromCache(key=loc.key, category=arguments.category);
          if (application.wheels.cacheCullPercentage < 100)
          {
            loc.deletedItems++;
            loc.percentageDeleted = (loc.deletedItems / loc.cacheCount) * 100;
            if (loc.percentageDeleted >= application.wheels.cacheCullPercentage)
              break;
          }
        }
      }
      application.wheels.cacheLastCulledAt = Now();
    }
    if ($cacheCount() < application.wheels.maximumItemsToCache)
    {
      application.wheels.cache[arguments.category][arguments.key] = {};
      application.wheels.cache[arguments.category][arguments.key].expiresAt = DateAdd(application.wheels.cacheDatePart, arguments.time, Now());
      if (IsSimpleValue(arguments.value))
        application.wheels.cache[arguments.category][arguments.key].value = arguments.value;
      else
        application.wheels.cache[arguments.category][arguments.key].value = duplicate(arguments.value);
    }
  </cfscript>
</cffunction>

<cffunction name="$getFromCache" returntype="any" access="public" output="false">
  <cfargument name="key" type="string" required="true">
  <cfargument name="category" type="string" required="false" default="main">
  <cfscript>
    var loc = {};
    loc.returnValue = false;
    if (StructKeyExists(application.wheels.cache[arguments.category], arguments.key))
    {
      if (Now() > application.wheels.cache[arguments.category][arguments.key].expiresAt)
      {
        if (application.wheels.showDebugInformation)
          request.wheels.cacheCounts.culls = request.wheels.cacheCounts.culls + 1;
        $removeFromCache(key=arguments.key, category=arguments.category);
      }
      else
      {
        if (application.wheels.showDebugInformation)
          request.wheels.cacheCounts.hits = request.wheels.cacheCounts.hits + 1;
        if (IsSimpleValue(application.wheels.cache[arguments.category][arguments.key].value))
          loc.returnValue = application.wheels.cache[arguments.category][arguments.key].value;
        else
          loc.returnValue = Duplicate(application.wheels.cache[arguments.category][arguments.key].value);
      }
    }

    if (application.wheels.showDebugInformation && IsBoolean(loc.returnValue) && !loc.returnValue)
      request.wheels.cacheCounts.misses = request.wheels.cacheCounts.misses + 1;
  </cfscript>
  <cfreturn loc.returnValue>
</cffunction>

<cffunction name="$removeFromCache" returntype="void" access="public" output="false">
  <cfargument name="key" type="string" required="true">
  <cfargument name="category" type="string" required="false" default="main">
  <cfset StructDelete(application.wheels.cache[arguments.category], arguments.key)>
</cffunction>

<cffunction name="$cacheCount" returntype="numeric" access="public" output="false">
  <cfargument name="category" type="string" required="false" default="">
  <cfscript>
    var loc = {};
    if (Len(arguments.category))
    {
      loc.returnValue = StructCount(application.wheels.cache[arguments.category]);
    }
    else
    {
      loc.returnValue = 0;
      for (loc.key in application.wheels.cache)
        loc.returnValue = loc.returnValue + StructCount(application.wheels.cache[loc.key]);
    }
  </cfscript>
  <cfreturn loc.returnValue>
</cffunction>

<cffunction name="$clearCache" returntype="void" access="public" output="false">
  <cfargument name="category" type="string" required="false" default="">
  <cfscript>
    var loc = {};
    if (Len(arguments.category))
    {
      StructClear(application.wheels.cache[arguments.category]);
    }
    else
    {
      StructClear(application.wheels.cache);
    }
  </cfscript>
</cffunction>

<cffunction name="$createModelClass" returntype="any" access="public" output="false">
  <cfargument name="name" type="string" required="true">
  <cfargument name="modelPaths" type="string" required="false" default="#application.wheels.modelPath#">
  <cfargument name="type" type="string" required="false" default="model" />
  <cfscript>
    var loc = {};
    // let's allow for multiple controller paths so that plugins can contain controllers
    // the last path is the one we will instantiate the base controller on if the controller is not found on any of the paths
    for (loc.i = 1; loc.i lte ListLen(arguments.modelPaths); loc.i++)
    {
      loc.modelPath = ListGetAt(arguments.modelPaths, loc.i);
      loc.fileName = $objectFileName(name=arguments.name, objectPath=loc.modelPath, type=arguments.type);

      if (loc.fileName != arguments.type || loc.i == ListLen(arguments.modelPaths))
      {
        application.wheels.models[arguments.name] = $createObjectFromRoot(path=loc.modelPath, fileName=loc.fileName, method="$initModelClass", name=arguments.name);
        loc.returnValue = application.wheels.models[arguments.name];
        break;
      }
    }
  </cfscript>
  <cfreturn loc.returnValue>
</cffunction>

<!---
Used to announce to the developer that a feature they are using will be removed at some point.
DOES NOT work in production mode.

To use call $deprecated() from within the method you want to deprecate. You may pass an optional
custom message if desired. The method will return a structure containing the message and information
about where the deprecation occurrs like the called method, line number, template name and shows the
code that called the deprcated method.

Example:

Original foo()
<cffunction name="foo" returntype="any" access="public" output="false">
  <cfargument name="baz" type="numeric" required="true">
  <cfreturn baz++>
</cffunction>

Should now call bar() instead and marking foo() as deprecated
<cffunction name="foo" returntype="any" access="public" output="false">
  <cfargument name="baz" type="numeric" required="true">
  <cfset $deprecated("Calling foo is now deprecated, use bar() instead.")>
  <cfreturn bar(argumentscollection=arguments)>
</cffunction>

<cffunction name="bar" returntype="any" access="public" output="false">
  <cfargument name="baz" type="numeric" required="true">
  <cfreturn ++baz>
</cffunction>
 --->
<cffunction name="$deprecated" returntype="struct" access="public" output="false">
  <!--- a message to display instead of the default one. --->
  <cfargument name="message" type="string" required="false" default="You are using deprecated behavior which will be removed from the next major or minor release.">
  <!--- should you announce the deprecation. only used when writing tests. --->
  <cfargument name="announce" type="boolean" required="false" default="true">
  <cfset var loc = {}>
  <cfset loc.ret = {}>
  <cfset loc.tagcontext = []>
  <cfif not application.wheels.showDebugInformation>
    <cfreturn loc.ret>
  </cfif>
  <!--- set return value --->
  <cfset loc.data = []>
  <cfset loc.ret = {message=arguments.message, line="", method="", template="", data=loc.data}>
  <!---
  create an exception so we can get the TagContext and display what file and line number the
  deprecated method is being called in
   --->
  <cftry>
    <cfthrow type="Expression">
    <cfcatch type="any">
      <cfset loc.exception = cfcatch>
    </cfcatch>
  </cftry>
  <cfif StructKeyExists(loc.exception, "tagcontext")>
    <cfset loc.tagcontext = loc.exception.tagcontext>
  </cfif>
  <!---
  TagContext is an array. The first element of the array will always be the context for this
  method announcing the deprecation. The second element will be the deprecated function that
  is being called. We need to look at the third element of the array to get the method that
  is calling the method marked for deprecation.
   --->
  <cfif isArray(loc.tagcontext) and arraylen(loc.tagcontext) gte 3 and isStruct(loc.tagcontext[3])>
    <!--- grab and parse the information from the tagcontext. --->
    <cfset loc.context = loc.tagcontext[3]>
    <!--- the line number --->
    <cfset loc.ret.line = loc.context.line>
    <!--- the deprecated method that was called --->
    <cfif StructKeyExists(server, "railo")>
      <cfset loc.ret.method = rereplacenocase(loc.context.codePrintPlain, '.*\<cffunction name="([^"]*)">.*', "\1")>
    <cfelse>
      <cfset loc.ret.method = rereplacenocase(loc.context.raw_trace, ".*\$func([^\.]*)\..*", "\1")>
    </cfif>
    <!--- the user template where the method called occurred --->
    <cfset loc.ret.template = loc.context.template>
    <!--- try to get the code --->
    <cfif len(loc.ret.template) and FileExists(loc.ret.template)>
      <!--- grab a one line radius from where the deprecation occurred. --->
      <cfset loc.startAt = loc.ret.line - 1>
      <cfif loc.startAt lte 0>
        <cfset loc.startAt = loc.ret.line>
      </cfif>
      <cfset loc.stopAt = loc.ret.line + 1>
      <cfset loc.counter = 1>
      <cfloop file="#loc.ret.template#" index="loc.i">
        <cfif loc.counter gte loc.startAt and loc.counter lte loc.stopAt>
          <cfset arrayappend(loc.ret.data, loc.i)>
        </cfif>
        <cfif loc.counter gt loc.stopAt>
          <cfbreak>
        </cfif>
        <cfset loc.counter++>
      </cfloop>
    </cfif>
    <!--- change template name from full to relative path. --->
    <cfset loc.ret.template = listchangedelims(removechars(loc.ret.template, 1, len(expandpath(application.wheels.webpath))), "/", "\/")>
  </cfif>
  <!--- append --->
  <cfif arguments.announce>
    <cfset arrayappend(request.wheels.deprecation, loc.ret)>
  </cfif>
  <cfreturn loc.ret>
</cffunction>

<cffunction name="$loadRoutes" returntype="void" access="public" output="false">
  <cfscript>
    // clear out the route info
    ArrayClear(application.wheels.routes);
    StructClear(application.wheels.namedRoutePositions);

    // load developer routes first
    $include(template="#application.wheels.configPath#/routes.cfm");

    // add the wheels default routes at the end if requested
    if (application.wheels.loadDefaultRoutes)
      addDefaultRoutes();

    // set lookup info for the named routes
    $setNamedRoutePositions();
    </cfscript>
</cffunction>

<cffunction name="$setNamedRoutePositions" returntype="void" access="public" output="false">
  <cfscript>
    var loc = {};
    loc.iEnd = ArrayLen(application.wheels.routes);
    for (loc.i=1; loc.i <= loc.iEnd; loc.i++)
    {
      loc.route = application.wheels.routes[loc.i];
      if (StructKeyExists(loc.route, "name") && len(loc.route.name))
      {
        if (!StructKeyExists(application.wheels.namedRoutePositions, loc.route.name))
          application.wheels.namedRoutePositions[loc.route.name] = "";
        application.wheels.namedRoutePositions[loc.route.name] = ListAppend(application.wheels.namedRoutePositions[loc.route.name], loc.i);
      }
    }
    </cfscript>
</cffunction>

<cffunction name="$clearModelInitializationCache">
  <cfset StructClear(application.wheels.models)>
</cffunction>

<cffunction name="$clearControllerInitializationCache">
  <cfset StructClear(application.wheels.controllers)>
</cffunction>

<cffunction name="$checkMinimumVersion" access="public" returntype="boolean" output="false">
  <cfargument name="version" type="string" required="true">
  <cfargument name="minversion" type="string" required="true">
  <cfscript>
  var loc = {};

  arguments.version = ListChangeDelims(arguments.version, ".", ".,");
  arguments.minversion = ListChangeDelims(arguments.minversion, ".", ".,");

  arguments.version = ListToArray(arguments.version, ".");
  arguments.minversion = ListToArray(arguments.minversion, ".");

  // make version and minversion the same length pad zeros to the end
  loc.minSize = max(ArrayLen(arguments.version), ArrayLen(arguments.minversion));

  ArrayResize(arguments.version, loc.minSize);
  ArrayResize(arguments.minversion, loc.minSize);

  for(loc.i=1; loc.i LTE loc.minSize; loc.i++)
  {
    loc.version = 0;
    if(ArrayIsDefined(arguments.version, loc.i))
    {
      loc.version = val(arguments.version[loc.i]);
    }
    
    loc.minversion = 0;
    if(ArrayIsDefined(arguments.minversion, loc.i))
    {
      loc.minversion = val(arguments.minversion[loc.i]);
    }
    
    if(loc.version gt loc.minversion)
    {
      return true;
    }
    
    if(loc.version lt loc.minversion)
    {
      return false;
    }
  }

  return true;
  </cfscript>
  <cfreturn >
</cffunction>

<cffunction name="$loadPlugins" returntype="void" access="public" output="false">
  <cfscript>
  application.wheels.PluginObj = $createObjectFromRoot(
    path="wheels"
    ,fileName="Plugins"
    ,method="init"
    ,pluginPath="#application.wheels.webPath & application.wheels.pluginPath#"
  );
  
  application.wheels.plugins = application.wheels.PluginObj.getPlugins();
  application.wheels.incompatiblePlugins = application.wheels.PluginObj.getIncompatiblePlugins();
  application.wheels.dependantPlugins = application.wheels.PluginObj.getDependantPlugins();
  application.wheels.mixins = application.wheels.PluginObj.getMixins();
  </cfscript>
</cffunction>
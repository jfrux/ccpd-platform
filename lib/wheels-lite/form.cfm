<cffunction name="endFormTag" returntype="string" access="public" output="false" hint="Builds and returns a string containing the closing `form` tag."
  examples=
  '
    <!--- view code --->
    <cfoutput>
        ##startFormTag(action="create")##
            <!--- your form controls --->
        ##endFormTag()##
    </cfoutput>
  '
  categories="view-helper,forms-general" chapters="form-helpers-and-showing-errors" functions="URLFor,startFormTag,submitTag,textField,radioButton,checkBox,passwordField,hiddenField,textArea,fileField,select,dateTimeSelect,dateSelect,timeSelect">
  <cfscript>
    if (StructKeyExists(request.wheels, "currentFormMethod"))
      StructDelete(request.wheels, "currentFormMethod");
  </cfscript>
  <cfreturn "</form>">
</cffunction>

<cffunction name="startFormTag" returntype="string" access="public" output="false" hint="Builds and returns a string containing the opening form tag. The form's action will be built according to the same rules as `URLFor`. Note: Pass any additional arguments like `class`, `rel`, and `id`, and the generated tag will also include those values as HTML attributes."
  examples=
  '
    <!--- view code --->
    <cfoutput>
        ##startFormTag(action="create", spamProtection=true)##
            <!--- your form controls --->
        ##endFormTag()##
    </cfoutput>
  '
  categories="view-helper,forms-general" chapters="form-helpers-and-showing-errors" functions="URLFor,endFormTag,submitTag,textField,radioButton,checkBox,passwordField,hiddenField,textArea,fileField,select,dateTimeSelect,dateSelect,timeSelect">
  <cfargument name="method" type="string" required="false" hint="The type of method to use in the form tag. `get` and `post` are the options.">
  <cfargument name="multipart" type="boolean" required="false" default=false hint="Set to `true` if the form should be able to upload files.">
  <cfargument name="spamProtection" type="boolean" required="false" default=false hint="Set to `true` to protect the form against spammers (done with JavaScript).">
  <cfargument name="route" type="string" required="false" default="" hint="See documentation for @URLFor.">
  <cfargument name="controller" type="string" required="false" default="" hint="See documentation for @URLFor.">
  <cfargument name="action" type="string" required="false" default="" hint="See documentation for @URLFor.">
  <cfargument name="key" type="any" required="false" default="" hint="See documentation for @URLFor.">
  <cfargument name="params" type="string" required="false" default="" hint="See documentation for @URLFor.">
  <cfargument name="anchor" type="string" required="false" default="" hint="See documentation for @URLFor.">
  <cfargument name="onlyPath" type="boolean" required="false" hint="See documentation for @URLFor.">
  <cfargument name="host" type="string" required="false" hint="See documentation for @URLFor.">
  <cfargument name="protocol" type="string" required="false" hint="See documentation for @URLFor.">
  <cfargument name="port" type="numeric" required="false" hint="See documentation for @URLFor.">
  <cfscript>
    var loc = {};
    $args(name="startFormTag", args=arguments);

    // sets a flag to indicate whether we use get or post on this form, used when obfuscating params
    request.wheels.currentFormMethod = arguments.method;

    // set the form's action attribute to the URL that we want to send to
    if (!ReFindNoCase("^https?:\/\/", arguments.action))
      arguments.action = URLFor(argumentCollection=arguments);

    // make sure we return XHMTL compliant code
    arguments.action = toXHTML(arguments.action);

    // deletes the action attribute and instead adds some tricky javascript spam protection to the onsubmit attribute
    if (arguments.spamProtection)
    {
      loc.onsubmit = "this.action='#Left(arguments.action, int((Len(arguments.action)/2)))#'+'#Right(arguments.action, ceiling((Len(arguments.action)/2)))#';";
      arguments.onsubmit = $addToJavaScriptAttribute(name="onsubmit", content=loc.onsubmit, attributes=arguments);
      StructDelete(arguments, "action");
    }

    // set the form to be able to handle file uploads
    if (!StructKeyExists(arguments, "enctype") && arguments.multipart)
      arguments.enctype = "multipart/form-data";

    loc.skip = "multipart,spamProtection,route,controller,key,params,anchor,onlyPath,host,protocol,port";
    if (Len(arguments.route))
      loc.skip = ListAppend(loc.skip, $routeVariables(argumentCollection=arguments)); // variables passed in as route arguments should not be added to the html element
    if (ListFind(loc.skip, "action"))
      loc.skip = ListDeleteAt(loc.skip, ListFind(loc.skip, "action")); // need to re-add action here even if it was removed due to being a route variable above

    loc.returnValue = $tag(name="form", skip=loc.skip, attributes=arguments);
  </cfscript>
  <cfreturn loc.returnValue>
</cffunction>
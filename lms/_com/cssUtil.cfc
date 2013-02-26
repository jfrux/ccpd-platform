<cfcomponent displayname="CSS CFC" output="no">
	<cffunction name="init" access="public" output="no" returntype="ccpdadminnew._com.cssUtil">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="parseFile"  access="public" output="no" returntype="cssStructBuild">
		<cfargument name="csspath" type="string" required="yes" />
		<cfargument name="cfmapping" type="string" required="no" default="" />
		
		<cfset var filepath = "">
		<cfset var cfMapPath = "" />
		<cfset var returnVar = "" />
		
		<cfif structKeyExists(arguments,'cfmapping') AND len(arguments.cfmapping) GT 0>
			<cfset cfMapPath = replace(replace(arguments.cfmapping,'/','','ALL'),'\','','ALL')>
			<cfset cfMapPath = "/" & cfMapPath>
		</cfif>
		
		<cfset filepath = expandPath("#cfMapPath##arguments.csspath#")>
		
		<cfif fileExists(filepath)>
			<cffile action="read" file="#filepath#" variable="returnVar" />
		</cfif>
		
		<cfreturn cssStructBuild(returnVar) />
	</cffunction>
	
	<cffunction name="parseCSS" access="public" output="no" returntype="cssStruct">
		<cfargument name="css" type="string" required="yes" />
		
		<!--- ToDo: validate css data and return struct of errors --->
		
		<cfreturn cssStructBuild(arguments.css) />
	</cffunction>
	
	<cffunction name="cssStructBuild" access="public" returntype="any" output="yes">
		<cfargument name="css_data" type="string" required="yes">
		
		<!---Inspiration (and some code [all the regex]) from Ben Nadel http://www.bennadel.com/index.cfm?dax=blog:584.view
		MODIFIED BY: Joshua Rountree
		REASON: Added more expansive feature set on return variable.
					- returns an array of classes / ids
					- returns existing cssRules struct
		
		--->
		
		<!---Create the local scope--->
		<cfset var local = {}>
		
		<!--- NEW RETURN STRUCTURE --->
		<cfset var returnVar = 
			{
			rules={},
			rulesStr=[],
			classes=""
			}>
		
		<!--- This struct will hold all of the rules --->
		<cfset LOCAL.cssRules = []>
		
		<!--- Remove all line breaks. --->
		<cfset LOCAL.strCSSData = reReplace(arguments.css_data,"[\r\n]+", " ","all") />
		
		<!--- Strip out the CSS comments. --->
		<cfset LOCAL.strCSSData = reReplace(LOCAL.strCSSData,"/\*.*?\*/", " ", "all" ) />
		
		<!--- Create an array to hold all of the class names. --->
		<cfset LOCAL.arrClasses = ArrayNew( 1 ) />
		
		<cfloop index="LOCAL.strRule" list="#LOCAL.strCSSData#" delimiters="}">
			<cfset LOCAL.newRule = LOCAL.strRule & "}">

			<cfif Len( trim(LOCAL.newRule))>
				<cfset arrayAppend(LOCAL.arrClasses, LOCAL.newRule) />
			</cfif>
		</cfloop>
		
		<cfloop from="1" to="#arrayLen(LOCAL.arrClasses)#" index="i">
			<cfset classLine = LOCAL.arrClasses[i]>
			<cfset className = trim(listFirst(classLine,"{"))>
			<cfset classRule = trim(listLast(classLine,"{"))>
			
			<cfset LOCAL.cssRules[i]["#className#"] = {}>
			
			<cfloop list="#classRule#" delimiters=";" index="LOCAL.each_rule">
				<cfset LOCAL.cssEachRuleKey = trim(listFirst(LOCAL.each_rule,":"))>
				<cfset LOCAL.cssEachRuleValue = trim(listLast(LOCAL.each_rule,":"))>
				<cfset LOCAL.cssRules[i][className][LOCAL.cssEachRuleKey] = LOCAL.cssEachRuleValue>
			</cfloop>
			<cfset LOCAL.cssRules[i][className].ruleString = classLine>
		</cfloop>
		
		<!--- NEW RETURN VARIABLE --->
		<cfset returnVar.rules = LOCAL.cssRules>
		<cfset returnVar.classes = LOCAL.arrClasses>
		
		<cfdump var="#returnVar#"><cfabort>
		<cfreturn returnVar>
	</cffunction>
</cfcomponent>
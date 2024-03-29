
<cfcomponent displayname="AssessResult" output="false">
	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="_com.AssessResult.AssessResult" output="false">
		<cfargument name="ResultID" type="string" required="false" default="" />
		<cfargument name="PersonID" type="string" required="false" default="" />
		<cfargument name="AssessmentID" type="string" required="false" default="" />
		<cfargument name="ResultStatusID" type="string" required="false" default="" />
		<cfargument name="Score" type="string" required="false" default="" />
		<cfargument name="Created" type="string" required="false" default="" />
		<cfargument name="Updated" type="string" required="false" default="" />
		<cfargument name="Deleted" type="string" required="false" default="" />
		<cfargument name="DeletedFlag" type="string" required="false" default="" />
		
		<!--- run setters --->
		<cfset setResultID(arguments.ResultID) />
		<cfset setPersonID(arguments.PersonID) />
		<cfset setAssessmentID(arguments.AssessmentID) />
		<cfset setResultStatusID(arguments.ResultStatusID) />
		<cfset setScore(arguments.Score) />
		<cfset setCreated(arguments.Created) />
		<cfset setUpdated(arguments.Updated) />
		<cfset setDeleted(arguments.Deleted) />
		<cfset setDeletedFlag(arguments.DeletedFlag) />
		
		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setMemento" access="public" returntype="_com.AssessResult.AssessResult" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>

	<cffunction name="validate" access="public" returntype="array" output="false">
		<cfset var errors = arrayNew(1) />
		<cfset var thisError = structNew() />
		
		<!--- ResultID --->
		<cfif (len(trim(getResultID())) AND NOT isNumeric(trim(getResultID())))>
			<cfset thisError.field = "ResultID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ResultID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- PersonID --->
		<cfif (len(trim(getPersonID())) AND NOT isNumeric(trim(getPersonID())))>
			<cfset thisError.field = "PersonID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "PersonID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- AssessmentID --->
		<cfif (len(trim(getAssessmentID())) AND NOT isNumeric(trim(getAssessmentID())))>
			<cfset thisError.field = "AssessmentID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "AssessmentID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- ResultStatusID --->
		<cfif (len(trim(getResultStatusID())) AND NOT isNumeric(trim(getResultStatusID())))>
			<cfset thisError.field = "ResultStatusID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ResultStatusID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- Score --->
		<cfif (len(trim(getScore())) AND NOT isNumeric(trim(getScore())))>
			<cfset thisError.field = "Score" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Score is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- Created --->
		<cfif (len(trim(getCreated())) AND NOT isDate(trim(getCreated())))>
			<cfset thisError.field = "Created" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Created is not a date" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- Updated --->
		<cfif (len(trim(getUpdated())) AND NOT isDate(trim(getUpdated())))>
			<cfset thisError.field = "Updated" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Updated is not a date" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- Deleted --->
		<cfif (len(trim(getDeleted())) AND NOT isDate(trim(getDeleted())))>
			<cfset thisError.field = "Deleted" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Deleted is not a date" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- DeletedFlag --->
		<cfif (len(trim(getDeletedFlag())) AND NOT IsSimpleValue(trim(getDeletedFlag())))>
			<cfset thisError.field = "DeletedFlag" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "DeletedFlag is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getDeletedFlag())) GT 1)>
			<cfset thisError.field = "DeletedFlag" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "DeletedFlag is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfreturn errors />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setResultID" access="public" returntype="void" output="false">
		<cfargument name="ResultID" type="string" required="true" />
		<cfset variables.instance.ResultID = arguments.ResultID />
	</cffunction>
	<cffunction name="getResultID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ResultID />
	</cffunction>

	<cffunction name="setPersonID" access="public" returntype="void" output="false">
		<cfargument name="PersonID" type="string" required="true" />
		<cfset variables.instance.PersonID = arguments.PersonID />
	</cffunction>
	<cffunction name="getPersonID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.PersonID />
	</cffunction>

	<cffunction name="setAssessmentID" access="public" returntype="void" output="false">
		<cfargument name="AssessmentID" type="string" required="true" />
		<cfset variables.instance.AssessmentID = arguments.AssessmentID />
	</cffunction>
	<cffunction name="getAssessmentID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.AssessmentID />
	</cffunction>

	<cffunction name="setResultStatusID" access="public" returntype="void" output="false">
		<cfargument name="ResultStatusID" type="string" required="true" />
		<cfset variables.instance.ResultStatusID = arguments.ResultStatusID />
	</cffunction>
	<cffunction name="getResultStatusID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ResultStatusID />
	</cffunction>

	<cffunction name="setScore" access="public" returntype="void" output="false">
		<cfargument name="Score" type="string" required="true" />
		<cfset variables.instance.Score = arguments.Score />
	</cffunction>
	<cffunction name="getScore" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Score />
	</cffunction>

	<cffunction name="setCreated" access="public" returntype="void" output="false">
		<cfargument name="Created" type="string" required="true" />
		<cfset variables.instance.Created = arguments.Created />
	</cffunction>
	<cffunction name="getCreated" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Created />
	</cffunction>

	<cffunction name="setUpdated" access="public" returntype="void" output="false">
		<cfargument name="Updated" type="string" required="true" />
		<cfset variables.instance.Updated = arguments.Updated />
	</cffunction>
	<cffunction name="getUpdated" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Updated />
	</cffunction>

	<cffunction name="setDeleted" access="public" returntype="void" output="false">
		<cfargument name="Deleted" type="string" required="true" />
		<cfset variables.instance.Deleted = arguments.Deleted />
	</cffunction>
	<cffunction name="getDeleted" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Deleted />
	</cffunction>

	<cffunction name="setDeletedFlag" access="public" returntype="void" output="false">
		<cfargument name="DeletedFlag" type="string" required="true" />
		<cfset variables.instance.DeletedFlag = arguments.DeletedFlag />
	</cffunction>
	<cffunction name="getDeletedFlag" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DeletedFlag />
	</cffunction>


	<!---
	DUMP
	--->
	<cffunction name="dump" access="public" output="true" return="void">
		<cfargument name="abort" type="boolean" default="false" />
		<cfdump var="#variables.instance#" />
		<cfif arguments.abort>
			<cfabort />
		</cfif>
	</cffunction>

</cfcomponent>

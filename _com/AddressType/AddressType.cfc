<cfcomponent displayname="AddressType" output="false">
	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="_com.AddressType.AddressType" output="false">
		<cfargument name="AddressTypeID" type="string" required="false" default="" />
		<cfargument name="Name" type="string" required="false" default="" />
		<cfargument name="Description" type="string" required="false" default="" />
		<cfargument name="Code" type="string" required="false" default="" />
		
		<!--- run setters --->
		<cfset setAddressTypeID(arguments.AddressTypeID) />
		<cfset setName(arguments.Name) />
		<cfset setDescription(arguments.Description) />
		<cfset setCode(arguments.Code) />
		
		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setMemento" access="public" returntype="_com.AddressType.AddressType" output="false">
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
		
		<!--- AddressTypeID --->
		<cfif (len(trim(getAddressTypeID())) AND NOT isNumeric(trim(getAddressTypeID())))>
			<cfset thisError.field = "AddressTypeID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "AddressTypeID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- Name --->
		<cfif (NOT len(trim(getName())))>
			<cfset thisError.field = "Name" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "Name is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getName())) AND NOT IsSimpleValue(trim(getName())))>
			<cfset thisError.field = "Name" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Name is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getName())) GT 150)>
			<cfset thisError.field = "Name" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Name is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- Description --->
		<cfif (len(trim(getDescription())) AND NOT IsSimpleValue(trim(getDescription())))>
			<cfset thisError.field = "Description" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Description is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getDescription())) GT 63000)>
			<cfset thisError.field = "Description" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Description is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- Code --->
		<cfif (len(trim(getCode())) AND NOT IsSimpleValue(trim(getCode())))>
			<cfset thisError.field = "Code" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Code is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getCode())) GT 2)>
			<cfset thisError.field = "Code" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Code is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfreturn errors />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setAddressTypeID" access="public" returntype="void" output="false">
		<cfargument name="AddressTypeID" type="string" required="true" />
		<cfset variables.instance.AddressTypeID = arguments.AddressTypeID />
	</cffunction>
	<cffunction name="getAddressTypeID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.AddressTypeID />
	</cffunction>

	<cffunction name="setName" access="public" returntype="void" output="false">
		<cfargument name="Name" type="string" required="true" />
		<cfset variables.instance.Name = arguments.Name />
	</cffunction>
	<cffunction name="getName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Name />
	</cffunction>

	<cffunction name="setDescription" access="public" returntype="void" output="false">
		<cfargument name="Description" type="string" required="true" />
		<cfset variables.instance.Description = arguments.Description />
	</cffunction>
	<cffunction name="getDescription" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Description />
	</cffunction>

	<cffunction name="setCode" access="public" returntype="void" output="false">
		<cfargument name="Code" type="string" required="true" />
		<cfset variables.instance.Code = arguments.Code />
	</cffunction>
	<cffunction name="getCode" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Code />
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

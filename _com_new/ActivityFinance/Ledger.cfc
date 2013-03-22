
<cfcomponent displayname="Ledger" output="false">
	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="_com.ActivityFinance.Ledger" output="false">
		<cfargument name="EntryID" type="string" required="false" default="" />
		<cfargument name="ActivityID" type="string" required="false" default="" />
		<cfargument name="EntryDate" type="string" required="false" default="" />
		<cfargument name="Description" type="string" required="false" default="" />
		<cfargument name="Memo" type="string" required="false" default="" />
		<cfargument name="EntryTypeID" type="string" required="false" default="" />
		<cfargument name="Amount" type="string" required="false" default="" />
		<cfargument name="Created" type="string" required="false" default="" />
		<cfargument name="CreatedBy" type="string" required="false" default="" />
		<cfargument name="Updated" type="string" required="false" default="" />
		<cfargument name="UpdatedBy" type="string" required="false" default="" />
		<cfargument name="Deleted" type="string" required="false" default="" />
		<cfargument name="DeletedFlag" type="string" required="false" default="" />
		
		<!--- run setters --->
		<cfset setEntryID(arguments.EntryID) />
		<cfset setActivityID(arguments.ActivityID) />
		<cfset setEntryDate(arguments.EntryDate) />
		<cfset setDescription(arguments.Description) />
		<cfset setMemo(arguments.Memo) />
		<cfset setEntryTypeID(arguments.EntryTypeID) />
		<cfset setAmount(arguments.Amount) />
		<cfset setCreated(arguments.Created) />
		<cfset setCreatedBy(arguments.CreatedBy) />
		<cfset setUpdated(arguments.Updated) />
		<cfset setUpdatedBy(arguments.UpdatedBy) />
		<cfset setDeleted(arguments.Deleted) />
		<cfset setDeletedFlag(arguments.DeletedFlag) />
		
		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setMemento" access="public" returntype="_com.ActivityFinance.Ledger" output="false">
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
		
		<!--- EntryID --->
		<cfif (len(trim(getEntryID())) AND NOT isNumeric(trim(getEntryID())))>
			<cfset thisError.field = "EntryID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "EntryID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- ActivityID --->
		<cfif (NOT len(trim(getActivityID())))>
			<cfset thisError.field = "ActivityID" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "ActivityID is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getActivityID())) AND NOT isNumeric(trim(getActivityID())))>
			<cfset thisError.field = "ActivityID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ActivityID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- EntryDate --->
		<cfif (NOT len(trim(getEntryDate())))>
			<cfset thisError.field = "EntryDate" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "Entry Date is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getEntryDate())) AND NOT isDate(trim(getEntryDate())))>
			<cfset thisError.field = "EntryDate" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Entry Date is not a date" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- Description --->
		<cfif (NOT len(trim(getDescription())))>
			<cfset thisError.field = "Description" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "Description is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getDescription())) AND NOT IsSimpleValue(trim(getDescription())))>
			<cfset thisError.field = "Description" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Description is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getDescription())) GT 500)>
			<cfset thisError.field = "Description" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Description is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- Memo --->
		<cfif (len(trim(getMemo())) AND NOT IsSimpleValue(trim(getMemo())))>
			<cfset thisError.field = "Memo" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Memo is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getMemo())) GT 500)>
			<cfset thisError.field = "Memo" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Memo is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- EntryTypeID --->
		<cfif (NOT len(trim(getEntryTypeID())))>
			<cfset thisError.field = "EntryTypeID" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "Ledger Type is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- Amount --->
		<cfif (NOT len(trim(getAmount())))>
			<cfset thisError.field = "Amount" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "Amount is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getAmount())) AND NOT isNumeric(trim(getAmount())))>
			<cfset thisError.field = "Amount" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Amount is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- Created --->
		<cfif (len(trim(getCreated())) AND NOT isDate(trim(getCreated())))>
			<cfset thisError.field = "Created" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Created is not a date" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- CreatedBy --->
		<cfif (len(trim(getCreatedBy())) AND NOT isNumeric(trim(getCreatedBy())))>
			<cfset thisError.field = "CreatedBy" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "CreatedBy is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- Updated --->
		<cfif (len(trim(getUpdated())) AND NOT isDate(trim(getUpdated())))>
			<cfset thisError.field = "Updated" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Updated is not a date" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- UpdatedBy --->
		<cfif (len(trim(getUpdatedBy())) AND NOT isNumeric(trim(getUpdatedBy())))>
			<cfset thisError.field = "UpdatedBy" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "UpdatedBy is not numeric" />
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
	<cffunction name="setEntryID" access="public" returntype="void" output="false">
		<cfargument name="EntryID" type="string" required="true" />
		<cfset variables.instance.EntryID = arguments.EntryID />
	</cffunction>
	<cffunction name="getEntryID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.EntryID />
	</cffunction>

	<cffunction name="setActivityID" access="public" returntype="void" output="false">
		<cfargument name="ActivityID" type="string" required="true" />
		<cfset variables.instance.ActivityID = arguments.ActivityID />
	</cffunction>
	<cffunction name="getActivityID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ActivityID />
	</cffunction>

	<cffunction name="setEntryDate" access="public" returntype="void" output="false">
		<cfargument name="EntryDate" type="string" required="true" />
		<cfset variables.instance.EntryDate = arguments.EntryDate />
	</cffunction>
	<cffunction name="getEntryDate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.EntryDate />
	</cffunction>

	<cffunction name="setDescription" access="public" returntype="void" output="false">
		<cfargument name="Description" type="string" required="true" />
		<cfset variables.instance.Description = arguments.Description />
	</cffunction>
	<cffunction name="getDescription" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Description />
	</cffunction>

	<cffunction name="setMemo" access="public" returntype="void" output="false">
		<cfargument name="Memo" type="string" required="true" />
		<cfset variables.instance.Memo = arguments.Memo />
	</cffunction>
	<cffunction name="getMemo" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Memo />
	</cffunction>

	<cffunction name="setEntryTypeID" access="public" returntype="void" output="false">
		<cfargument name="EntryTypeID" type="string" required="true" />
		<cfset variables.instance.EntryTypeID = arguments.EntryTypeID />
	</cffunction>
	<cffunction name="getEntryTypeID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.EntryTypeID />
	</cffunction>

	<cffunction name="setAmount" access="public" returntype="void" output="false">
		<cfargument name="Amount" type="string" required="true" />
		<cfset variables.instance.Amount = arguments.Amount />
	</cffunction>
	<cffunction name="getAmount" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Amount />
	</cffunction>

	<cffunction name="setCreated" access="public" returntype="void" output="false">
		<cfargument name="Created" type="string" required="true" />
		<cfset variables.instance.Created = arguments.Created />
	</cffunction>
	<cffunction name="getCreated" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Created />
	</cffunction>

	<cffunction name="setCreatedBy" access="public" returntype="void" output="false">
		<cfargument name="CreatedBy" type="string" required="true" />
		<cfset variables.instance.CreatedBy = arguments.CreatedBy />
	</cffunction>
	<cffunction name="getCreatedBy" access="public" returntype="string" output="false">
		<cfreturn variables.instance.CreatedBy />
	</cffunction>

	<cffunction name="setUpdated" access="public" returntype="void" output="false">
		<cfargument name="Updated" type="string" required="true" />
		<cfset variables.instance.Updated = arguments.Updated />
	</cffunction>
	<cffunction name="getUpdated" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Updated />
	</cffunction>

	<cffunction name="setUpdatedBy" access="public" returntype="void" output="false">
		<cfargument name="UpdatedBy" type="string" required="true" />
		<cfset variables.instance.UpdatedBy = arguments.UpdatedBy />
	</cffunction>
	<cffunction name="getUpdatedBy" access="public" returntype="string" output="false">
		<cfreturn variables.instance.UpdatedBy />
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

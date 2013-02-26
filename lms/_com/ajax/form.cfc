<cfcomponent displayname="forms">
	<cffunction name="save" access="remote" output="no" returnformat="plain">
		
		<cfset var returnVar = createObject("component","_com.returnData.buildStruct").init() />
		<cfset var formBean = createObject("component","_com.objectFieldData.objectFieldData").init() />
		<cfset formBean.setDataKey_id(ARGUMENTS.dataKey_id) />
		<cfset formBean.setObjectForm_id(ARGUMENTS.f_id) />
		<cfset formBean.setObjectType_id(ARGUMENTS.objectType_id) />
		<cfset formBean.setID(ARGUMENTS.id) />
		
		<cfset returnVar.setStatus(false) />
		<cfset returnVar.setStatusMsg('Failed to save form.') />
		
		<cfif application.com.objectFieldDataDAO.exists(formBean)>
			<cfset formBean = application.com.objectFieldDataDAO.read(formBean) />
		</cfif>
		
		<cfquery name="formFields" datasource="#application.settings.dsn#">
			SELECT
				fld.id, 
				fld.objectForm_id, 
				fld.objectType_id, 
				fld.fieldIndex, 
				fld.fieldType,
				dataColumn = fld.fieldType + CAST(fld.fieldIndex As nvarchar(2)),
				fld.sort, 
				fld.columnLabel, 
				fld.displayLabel, 
				fld.displayShortLabel, 
				fld.created, 
				fld.createdBy, 
				fld.maxLength, 
				obj.simpleName, 
				obj.tableName, 
				obj.primaryKey, 
				style.template AS tagName, 
				style.hasOptions, 
				form.name AS formName
			FROM         
				ceschema.ce_objectField AS fld 
			LEFT OUTER JOIN
				ceschema.ce_objectForm AS form ON fld.objectForm_id = form.id 
			LEFT OUTER JOIN
				ceschema.ce_objectType AS obj ON fld.objectType_id = obj.objectTypeId 
			INNER JOIN
				ceschema.ce_objectFieldStyle AS style ON fld.fieldStyle_id = style.id
			WHERE
				fld.objectForm_id = <cfqueryparam value="#arguments.f_id#" cfsqltype="cf_sql_integer" />
			ORDER BY 
				fld.sort
		</cfquery>
		
		<cfloop query="formFields">
			<cfset field = {
				fieldName=formFields.dataColumn, 
				fieldValue=EVALUATE("arguments.#formFields.columnLabel#")
			} />
			
			<cfset EVALUATE("formBean.set#field.fieldName#(field.fieldValue)") />
		</cfloop>
		<!---<cfdump var="#formBean.getMemento()#"><cfabort>--->
		<cfset application.com.objectFieldDataDAO.save(formBean) />
		
		<!--- SAVE --->
		<cfset returnVar.setStatus(true) />
		<cfset returnVar.setStatusMsg('Successfully saved #formFields.formName# data.') />
		
		<cfreturn returnVar.getJSON() />		
	</cffunction>
</cfcomponent>
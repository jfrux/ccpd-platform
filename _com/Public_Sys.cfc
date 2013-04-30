<cfcomponent hint="Used for any ce_Sys table">
  <cffunction name="init" access="public" output="no" returntype="_com.Public_Sys">
    <cfreturn this />
  </cffunction>
    
  <cffunction name="deleteCategoryLMS" hint="deletes categories from system" access="Public" output="true" returntype="string">
    <cfargument name="CategoryID" type="numeric" required="no">
    <cfargument name="CategoryName" type="string" required="no">
        
        <cfset var Status = "">
        
        <cfif Arguments.CategoryID GT 0>
          <cfset CategoryBean = CreateObject("component","#Application.Settings.Com#CategoryLMS.CategoryLMS").Init(CategoryID=Arguments.CategoryID)>
      <cfset CategoryBean = Application.Com.CategoryLMSDAO.Delete(CategoryBean)>
                
            <cfset Status = "Success|Category has been deleted">
        <cfelseif Arguments.CategoryName NEQ "">
          <cfset CategoryBean = CreateObject("component","#Application.Settings.Com#CategoryLMS.CategoryLMS").Init(Name=Arguments.CategoryName)>
      <cfset CategoryBean = Application.Com.CategoryLMSDAO.Delete(CategoryBean)>
                
            <cfset Status = "Success|Category has been deleted">
        <cfelse>
          <cfset Status = "Fail|You must select a category to delete.">
        </cfif>
        
    <cfreturn Status>
  </cffunction>
    
  <cffunction name="deleteSpecialty" hint="deletes specialties to system" access="Public" output="false" returntype="string">
    <cfargument name="SpecialtyID" type="numeric" required="no">
    <cfargument name="SpecialtyName" type="string" required="no">
        
        <cfset var Status = "Fail|Cannot delete specialty for unknown reasons.">
        
        <cfif Arguments.SpecialtyID GT 0>
          <cfset SpecialtyBean = CreateObject("component","#Application.Settings.Com#Specialty.Specialty").Init(SpecialtyID=Arguments.SpecialtyID)>
      <cfset SpecialtyBean = Application.Com.SpecialtyDAO.Delete(SpecialtyBean)>
                
            <cfset Status = "Success|Specialty has been deleted">
        <cfelseif Arguments.SpecialtyName NEQ "">
          <cfset SpecialtyBean = CreateObject("component","#Application.Settings.Com#Specialty.Specialty").Init(Name=Arguments.SpecialtyName)>
      <cfset SpecialtyBean = Application.Com.SpecialtyDAO.Delete(SpecialtyBean)>
                
            <cfset Status = "Success|Specialty has been deleted">
        <cfelse>
          <cfset Status = "Fail|You must select a specialty to delete.">
        </cfif>
        
    <cfreturn Status />
  </cffunction>
    
    <cffunction name="getCategory" hint="Returns the name of the provided category." access="Public" output="false" returntype="string">
      <cfargument name="CategoryID" type="numeric" required="yes">
        
        <cfquery name="CategoryInfo" datasource="#Application.Settings.DSN#">
          SELECT Name
            FROM ce_Sys_CategoryLMS
            WHERE CategoryID = <cfqueryparam value="#Arguments.CategoryID#" cfsqltype="cf_sql_integer" />
        </cfquery>
        
        <cfif CategoryInfo.RecordCount GT 0>
          <cfreturn CategoryInfo.Name />
        </cfif>
    </cffunction>
    
    <cffunction name="getSpecialty" hint="Returns the name of the provided specialty." access="Public" output="false" returntype="string">
      <cfargument name="SpecialtyID" type="numeric" required="yes">
        
        <cfquery name="SpecialtyInfo" datasource="#Application.Settings.DSN#">
          SELECT Name
            FROM ce_Sys_SpecialtyLMS
            WHERE SpecialtyID = <cfqueryparam value="#Arguments.SpecialtyID#" cfsqltype="cf_sql_integer" />
        </cfquery>
        
        <cfif SpecialtyInfo.RecordCount GT 0>
          <cfreturn SpecialtyInfo.Name />
        </cfif>
    </cffunction>
    
  <cffunction name="HideWelcome" access="public" output="no">
    <cfcookie name="Pref.HideWelcome" value="true" />
  </cffunction>
    
  <cffunction name="saveCategoryLMS" hint="adds new categories to system" access="Public" output="true" returntype="string">
    <cfargument name="CategoryName" type="string" required="yes">
        
        <cfset var Status = "">
        
        <cfif Arguments.CategoryName NEQ "">
          <cfset CategoryBean = CreateObject("component","#Application.Settings.Com#CategoryLMS.CategoryLMS").Init(Name=Arguments.CategoryName)>
            <cfset CategoryExists = Application.Com.CategoryLMSDAO.Exists(CategoryBean)>
            
            <cfif NOT CategoryExists>
        <cfset CategoryBean = Application.Com.CategoryLMSDAO.Create(CategoryBean)>
                
                <cfset Status = "Success|Category has been saved">
            <cfelse>
            <cfset Status = "Fail|Category name already exists.">
            </cfif>
        <cfelse>
          <cfset Status = "Fail|You must enter a title to create a new category.">
        </cfif>
    <cfreturn Status>
  </cffunction>
    
  <cffunction name="saveSpecialty" hint="adds new specialties to system" access="Public" output="false" returntype="string">
    <cfargument name="SpecialtyName" type="string" required="yes">
        
        <cfset var Status = "">
        
        <cfif Arguments.SpecialtyName NEQ "">
          <cfset SpecialtyBean = CreateObject("component","#Application.Settings.Com#Specialty.Specialty").Init(Name=Arguments.SpecialtyName)>
            
            <cfif NOT Application.Com.SpecialtyDAO.Exists(SpecialtyBean)>
        <cfset SpecialtyBean = Application.Com.SpecialtyDAO.Save(SpecialtyBean)>
                
                <cfset Status = "Success|Specialty has been saved">
            <cfelse>
            <cfset Status = "Fail|Specialty name already exists.">
            </cfif>
        <cfelse>
          <cfset Status = "Fail|You must enter a title to create a new specialty.">
        </cfif>
    <cfreturn Status>
  </cffunction>
    
  <cffunction name="saveSupporter" access="Public" output="true" returntype="struct">
    <cfargument name="name" type="string" required="true">
    <cfargument name="description" type="string" required="false" default="">
    <cfargument name="original_name" type="string" required="true">
    
    <!--- Create variables needed to run function --->
    <cfset var returnVar = createObject("component", "#Application.Settings.Com#returnData.buildStruct").init()>
    <cfset var payload = {} />
    <cfset returnVar.setStatus(false)>
    <cfset returnVar.setStatusMsg("Could not save Supporter entry for unknown reasons.")>
    
    <!--- Check the arguments for blank values --->
    <cfif arguments.name EQ "">
      <cfset returnVar.setStatusMsg("Supporter Name is required")>
            <cfreturn returnVar.getJson() />
            <cfabort>
    </cfif>
     
    <!--- Query if the New Supporter already exists --->
    <!--- <cfquery name="qSupporter" datasource="#Application.Settings.DSN#">
        SELECT ContributorID, Name, DeletedFlag
        FROM ce_Sys_Supporter
        WHERE Name = <cfqueryparam value="#Arguments.original_name#" cfsqltype="cf_sql_varchar">
    </cfquery> --->
    <!--- Checks if this is a new supporter --->
    <!--- Runs new supporter code --->
        <!--- Creates the Bean --->
        <cfset SupporterBean = CreateObject("component","#Application.Settings.Com#System.Supporter").Init(ContributorID=0,Name=arguments.name,Description=arguments.description)>
        
        <!--- Save the new Supporter info --->
        <cfset SupporterID = Application.Com.SupporterDAO.Save(SupporterBean)>
        
        <!--- Set status to be successful --->
        <cfset returnVar.setStatus(true)>
        <cfset returnVar.setStatusMsg("'" & arguments.name & "' has created.")>
        <cfset payload = {
                            "id": #SupporterID#,
                            "name": arguments.name
                          } />
        <cfset returnVar.setPayload(payload) />
                          <!--- 
        <cfset returnVar.setData(aSupporter)> --->
    <!--- If the supporter exists but has been deleted, it undeletes them --->
    <!--- <cfelseif qSupporter.RecordCount EQ 1> --->
        <!--- Updates the DB record to have DeletedFlag=N --->
        <!--- <cfquery name="qUpdateSupporter" datasource="#Application.Settings.DSN#">
            UPDATE ce_Sys_Supporter
            SET name = <cfqueryparam value="#arguments.name#" cfsqltype="cf_sql_varchar">,
                DeletedFlag = <cfqueryparam value="N" cfsqltype="cf_sql_char">,
                Description = <cfqueryparam value="#arguments.description#" cfsqltype="cf_sql_varchar">
            WHERE contributorId = <cfqueryparam value="#qSupporter.contributorId#" cfsqltype="cf_sql_varchar">
        </cfquery>
        
        <!--- Set status to be successful --->
        <cfset returnVar.setStatus(true)>
        <cfset returnVar.setStatusMsg(arguments.name & " has been updated to the list.")>
       
        <cfset aSupporter = [{
            supporterId = qSupporter.ContributorID
            }] />
        <cfset returnVar.setData(aSupporter)> --->
    <!--- if the supporter exists but deletedflag does not equal Y --->
    <!--- <cfelse> --->
        <!--- Set status to be a failure --->
        <!--- <cfset returnVar.setStatus(false)>
        <cfset returnVar.setStatusMsg(arguments.name & " already exists in the list.")> --->
        <!--- <cfset aSupporter = [{
          supporterId = qSupporter.ContributorID
          }] /> ---><!--- 
        <cfset returnVar.setData(aSupporter)> --->
            
    <cfreturn returnVar />
  </cffunction>
    
  <cffunction name="updateCategoryLMS" hint="updates specialties to system" access="Public" output="true" returntype="string">
    <cfargument name="CategoryID" type="string" required="yes">
    <cfargument name="CategoryName" type="string" required="yes">
    <cfargument name="UpdatedCategoryName" type="string" required="yes">
        
        <cfset var Status = "Fail|Cannot update category name for unknown reasons.">
        
    <cfset CategoryBean = CreateObject("component","#Application.Settings.Com#CategoryLMS.CategoryLMS").Init(CategoryID=Arguments.CategoryID,Name=Arguments.CategoryName)>
        <cfset CategoryExists = Application.Com.CategoryLMSDAO.Exists(CategoryBean)>
        
        <cfif CategoryExists>
            <cfquery name="qUpdateCategory" datasource="#Application.Settings.DSN#">
                UPDATE ce_Sys_CategoryLMS
                SET Name = <cfqueryparam value="#Arguments.UpdatedCategoryName#" cfsqltype="cf_sql_varchar" />
                WHERE CategoryID = <cfqueryparam value="#Arguments.CategoryID#" cfsqltype="cf_sql_integer" />
            </cfquery>
            
            <cfset Status = "Success|Category has been updated">
    <cfelse>
            <cfset Status = "Fail|Category '" & Arguments.CategoryName & "' does not exist.">
        </cfif>
        
    <cfreturn Status>
  </cffunction>
    
  <cffunction name="updateSpecialty" hint="updates specialties to system" access="Public" output="true" returntype="string">
    <cfargument name="SpecialtyID" type="string" required="yes">
    <cfargument name="SpecialtyName" type="string" required="yes">
    <cfargument name="UpdatedSpecialtyName" type="string" required="yes">
        
        <cfset var Status = "">
        
    <cfset SpecialtyBean = CreateObject("component","#Application.Settings.Com#Specialty.Specialty").Init(Name=Arguments.SpecialtyName)>
        <cfset SpecialtyExists = Application.Com.SpecialtyDAO.Exists(SpecialtyBean)>
        
        <cfif SpecialtyExists>
            <cfquery name="qUpdateSpecialty" datasource="#Application.Settings.DSN#">
                UPDATE ce_Sys_SpecialtyLMS
                SET Name = <cfqueryparam value="#Arguments.UpdatedSpecialtyName#" cfsqltype="cf_sql_varchar" />
                WHERE SpecialtyID = <cfqueryparam value="#Arguments.SpecialtyID#" cfsqltype="cf_sql_integer" />
            </cfquery>
            
            <cfset Status = "Success|Specialty has been updated">
    <cfelse>
            <cfset Status = "Fail|Specialty '" & Arguments.SpecialtyName & "' does not exist.">
        </cfif>
        
    <cfreturn Status>
  </cffunction>
</cfcomponent>
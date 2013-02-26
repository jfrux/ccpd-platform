<cfcomponent>
	<cffunction name="shock" access="remote" returntype="string" returnFormat="plain" output="no">
    	<cfargument name="yell" type="string" required="no" default="empty">
        
		<cfset var status = createObject("component","_com.returnData.buildStruct").init()>
		<cfcontent type="text/javascript">
        <cfset status.setStatus(false)>
        <cfset status.setStatusMsg("The defibrillator is not working!")>
            
        <cfif arguments.yell EQ "clear">
        	<!--- FILL RETURN STRUCT --->
			<cfset status.setStatus(true)>
            <cfset status.setStatusMsg("Patient is alive!")>
        </cfif>
        
        
		<cfreturn status.getJSON() />
	</cffunction>
	
	<!---<cffunction name="test" access="remote" output="yes" returntype="string" returnformat="plain">
		<cfset var maxSleep = 55000>
		<cfset var currSleep = 0>
		<cfset var thread = CreateObject("java", "java.lang.Thread")>
		
		<cfif currSleep LTE maxSleep>
			<cfset goSleep(thread,currSleep)>
		</cfif>
		
	</cffunction>
	
	<cffunction name="goSleep" access="remote" output="yes" returntype="numeric">
		<cfargument name="thread" type="any" required="yes" />
		<cfargument name="currsleep" type="numeric" required="yes" />
		
		sleeping 5 seconds...<cfflush>
		<cfset arguments.thread.sleep(5000)>
	</cffunction>--->
</cfcomponent>
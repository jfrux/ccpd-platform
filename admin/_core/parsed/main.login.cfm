<cfsetting enablecfoutputonly="true" />
<cfprocessingdirective pageencoding="utf-8" />
<!--- circuit: Main --->
<!--- fuseaction: Login --->
<cftry>
<cfset myFusebox.thisPhase = "preProcess">
<cfset myFusebox.thisCircuit = "Main">
<cfset myFusebox.thisFuseaction = "Login">
<cfset myFusebox.thisPlugin = "prePP"/>
<cfoutput><cfinclude template="../plugins/Globals.cfm"/></cfoutput>
<cfset myFusebox.thisPhase = "requestedFuseaction">
<cfset Request.NavItem = "2" />
<!--- do action="mMain.TabControl" --->
<cfset myFusebox.thisCircuit = "mMain">
<cfset myFusebox.thisFuseaction = "TabControl">
<cftry>
<cfoutput><cfinclude template="../../Model/act_tabSetup.cfm"></cfoutput>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 16 and right(cfcatch.MissingFileName,16) is "act_tabSetup.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse act_tabSetup.cfm in circuit mMain which does not exist (from fuseaction mMain.TabControl).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
<cfset myFusebox.thisCircuit = "Main">
<cfset myFusebox.thisFuseaction = "Login">
<cfset layoutExceptions = "login,logout" />
<cfset request.page.action = "#listLast(attributes.fuseaction,'.')#" />
<cfset Request.Page.Title = "Login" />
<cfset xfa.Authenticate = "Main.doLogin" />
<!--- do action="vMain.Login" --->
<cfset myFusebox.thisCircuit = "vMain">
<cfsavecontent variable="Request.Page.Body">
<cftry>
<cfoutput><cfinclude template="../../View/dsp_Login.cfm"></cfoutput>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 13 and right(cfcatch.MissingFileName,13) is "dsp_Login.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse dsp_Login.cfm in circuit vMain which does not exist (from fuseaction vMain.Login).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
</cfsavecontent>
<!--- do action="vLayout.None" --->
<cfset myFusebox.thisCircuit = "vLayout">
<cfset myFusebox.thisFuseaction = "None">
<cftry>
<cfoutput><cfinclude template="../../View/Layout/lay_None.cfm"></cfoutput>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 12 and right(cfcatch.MissingFileName,12) is "lay_None.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse lay_None.cfm in circuit vLayout which does not exist (from fuseaction vLayout.None).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
<cfset myFusebox.thisCircuit = "Main">
<cfset myFusebox.thisFuseaction = "Login">
<cfif isPjax()>
<cfif #request.currentTab.hasToolbar#>
<cfset myFusebox.do('vMain.#request.page.action#right','multiformright') >
</cfif>
<cfset myFusebox.do('vMain.#request.page.action#','multiformcontent') >
<!--- do action="vLayout.Blank" --->
<cfset myFusebox.thisCircuit = "vLayout">
<cfset myFusebox.thisFuseaction = "Blank">
<cftry>
<cfoutput><cfinclude template="../../View/Layout/lay_Blank.cfm"></cfoutput>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 13 and right(cfcatch.MissingFileName,13) is "lay_Blank.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse lay_Blank.cfm in circuit vLayout which does not exist (from fuseaction vLayout.Blank).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
<cfset myFusebox.thisCircuit = "Main">
<cfset myFusebox.thisFuseaction = "Login">
<cfelse>
<cfif isAjax()>
<!--- do action="vLayout.Blank" --->
<cfset myFusebox.thisCircuit = "vLayout">
<cfset myFusebox.thisFuseaction = "Blank">
<cftry>
<cfoutput><cfinclude template="../../View/Layout/lay_Blank.cfm"></cfoutput>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 13 and right(cfcatch.MissingFileName,13) is "lay_Blank.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse lay_Blank.cfm in circuit vLayout which does not exist (from fuseaction vLayout.Blank).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
<cfset myFusebox.thisCircuit = "Main">
<cfset myFusebox.thisFuseaction = "Login">
<cfelse>
<cfif #request.currentTab.hasToolbar#>
<cfset myFusebox.do('vMain.#request.page.action#right','multiformright') >
</cfif>
<cfset myFusebox.do('vMain.#request.page.action#','multiformcontent') >
<cfif listFindNoCase(layoutExceptions,request.page.action) GT 0>
<cfset request.page.body = "#multiformcontent#" />
<!--- do action="vLayout.Default" --->
<cfset myFusebox.thisCircuit = "vLayout">
<cfset myFusebox.thisFuseaction = "Default">
<cftry>
<cfoutput><cfinclude template="../../View/Layout/lay_Default.cfm"></cfoutput>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 15 and right(cfcatch.MissingFileName,15) is "lay_Default.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse lay_Default.cfm in circuit vLayout which does not exist (from fuseaction vLayout.Default).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
<cfset myFusebox.thisCircuit = "Main">
<cfset myFusebox.thisFuseaction = "Login">
<cfelse>
<!--- do action="vLayout.Sub_User" --->
<cfset myFusebox.thisCircuit = "vLayout">
<cfset myFusebox.thisFuseaction = "Sub_User">
<cfsavecontent variable="request.page.body">
<cftry>
<cfoutput><cfinclude template="../../View/Layout/Sub\lay_User.cfm"></cfoutput>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 16 and right(cfcatch.MissingFileName,16) is "Sub\lay_User.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse Sub\lay_User.cfm in circuit vLayout which does not exist (from fuseaction vLayout.Sub_User).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
</cfsavecontent>
<!--- do action="vLayout.Default" --->
<cfset myFusebox.thisFuseaction = "Default">
<cftry>
<cfoutput><cfinclude template="../../View/Layout/lay_Default.cfm"></cfoutput>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 15 and right(cfcatch.MissingFileName,15) is "lay_Default.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse lay_Default.cfm in circuit vLayout which does not exist (from fuseaction vLayout.Default).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
<cfset myFusebox.thisCircuit = "Main">
<cfset myFusebox.thisFuseaction = "Login">
</cfif>
</cfif>
</cfif>
<cfcatch><cfrethrow></cfcatch>
</cftry>


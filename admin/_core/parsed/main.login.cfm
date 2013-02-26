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
<cfcatch><cfrethrow></cfcatch>
</cftry>


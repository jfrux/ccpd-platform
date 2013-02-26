<cfsetting enablecfoutputonly="true" />
<cfprocessingdirective pageencoding="utf-8" />
<!--- circuit: main --->
<!--- fuseaction: welcome --->
<cftry>
<cfset myFusebox.thisPhase = "preProcess">
<cfset myFusebox.thisCircuit = "main">
<cfset myFusebox.thisFuseaction = "welcome">
<cfset myFusebox.thisPlugin = "prePP"/>
<cfoutput><cfinclude template="../plugins/Globals.cfm"/></cfoutput>
<cfset myFusebox.thisPhase = "requestedFuseaction">
<cfset Request.NavItem = "1" />
<!--- do action="mMain.Welcome" --->
<cfset myFusebox.thisCircuit = "mMain">
<cftry>
<cfoutput><cfinclude template="../../Model/act_Welcome.cfm"></cfoutput>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 15 and right(cfcatch.MissingFileName,15) is "act_Welcome.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse act_Welcome.cfm in circuit mMain which does not exist (from fuseaction mMain.Welcome).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
<cfset myFusebox.thisCircuit = "main">
<cfset Request.Page.Title = "CE Dashboard" />
<!--- do action="vMain.Welcome" --->
<cfset myFusebox.thisCircuit = "vMain">
<cfsavecontent variable="Request.Page.Body">
<cftry>
<cfoutput><cfinclude template="../../View/dsp_Welcome.cfm"></cfoutput>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 15 and right(cfcatch.MissingFileName,15) is "dsp_Welcome.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse dsp_Welcome.cfm in circuit vMain which does not exist (from fuseaction vMain.Welcome).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
</cfsavecontent>
<cfset myFusebox.thisCircuit = "main">
<cfset Request.Page.Breadcrumbs = "" />
<!--- do action="mPage.ParseCrumbs" --->
<cfset myFusebox.thisCircuit = "mPage">
<cfset myFusebox.thisFuseaction = "ParseCrumbs">
<cftry>
<cfoutput><cfinclude template="../../Model/Page/act_ParseCrumbs.cfm"></cfoutput>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 19 and right(cfcatch.MissingFileName,19) is "act_ParseCrumbs.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse act_ParseCrumbs.cfm in circuit mPage which does not exist (from fuseaction mPage.ParseCrumbs).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
<!--- do action="vLayout.Default" --->
<cfset myFusebox.thisCircuit = "vLayout">
<cfset myFusebox.thisFuseaction = "Default">
<cftry>
<cfoutput><cfinclude template="../../View/Layout/lay_Default.cfm"></cfoutput>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 15 and right(cfcatch.MissingFileName,15) is "lay_Default.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse lay_Default.cfm in circuit vLayout which does not exist (from fuseaction vLayout.Default).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
<cfcatch><cfrethrow></cfcatch>
</cftry>


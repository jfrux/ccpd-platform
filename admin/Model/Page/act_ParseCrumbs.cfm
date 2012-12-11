<!--- actParseCrumbs.cfm --->
<cfinvoke component="#Application.Settings.Com#Page" method="ParseCrumbs" Crumbs="#Request.Page.Breadcrumbs#" returnvariable="Request.Page.Breadcrumbs">
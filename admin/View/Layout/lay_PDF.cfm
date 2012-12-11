<cfparam name="Request.Page.Title" default="Untitled Page">
<cfparam name="Request.Page.Body" default="No Body Found">
<cfparam name="Attributes.FileName" default="#GetToken(Attributes.Fuseaction,2,".")#">


<cfdocument Format="PDF"
			Orientation="Portrait"
			Overwrite="no"
			SaveAsName="#Attributes.FileName#_#DateFormat(Now(), "MM-DD-YYYY")#"
			margintop="0"
			marginright="0"
			marginbottom="0"
			marginleft="0">
	<cfoutput>
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>#Request.Page.Title# - #Application.Settings.AppName#</title>
	<cfinclude template="dsp_HeadGlobal.cfm" />
	</head>
	
	<body style="margin:0px;">
	#Request.Page.Body#
	</body>
	</html>
	</cfoutput>
</cfdocument>
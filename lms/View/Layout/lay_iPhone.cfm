<cfparam name="Request.Page.Title" default="Untitled Page">
<cfparam name="Request.Page.Body" default="No Body Found">
<cfoutput>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>#Request.Page.Title#</title>
<meta name="viewport" content="width=320"/>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
<link rel="stylesheet" type="text/css" href="/_styles/iPhone/CiUI.css" />
<script src="/lms/_scripts/iPhone/CiUI.js" type="text/javascript"></script>
</head>
<body>
<div id="iphone_header">
	<div id="iphone_backbutton"><a id="iphone_backbutton_text" href="##" class="go_back">#Request.Page.Title#</a></div>
	<div id="iphone_title"></div>
</div>
<div id="iphone_body" style="clear:both;">
	#Request.Page.Body#
</div>
<div id="iphone_footer">Powered by Remote-App.com</div>
<div id="iphone_loading_page">
	<div id='loading' class="info_msg"> <img src="/lms/_images/iPhone/loading.gif" /><br />
		loading... </div>
</div>
</body>
</html>
</cfoutput>
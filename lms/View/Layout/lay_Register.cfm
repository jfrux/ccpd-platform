<cfparam name="Request.Page.Title" default="Untitled Page">
<cfparam name="Request.Page.Body" default="No Body Found">
<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Online Registration - #ActivityBean.getTitle()# - #Application.Settings.AppName#</title>
<link href="#Application.Settings.RootPath#/_styles/Register.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.maskedinput-1.1.3.pack.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.cfjs.packed.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.dimensions.pack.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/Global.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.blockUI.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.jclock.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery-ui-1.6rc6.min.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.selectboxes.pack.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.form.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.dropshadow.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.tooltip.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.autocomplete.pack.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.ajaxQueue.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.print.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/thickbox-compressed.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.tools.min.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/Masks.js"></script>

<script>
	$(document).ready(function() {
		
	<cfswitch expression="#Attributes.Step#">
		<cfcase value="Signup">
			$("##FlowSignup").addClass('Current');
		</cfcase>
		<cfcase value="Login">
			
		</cfcase>
		<cfcase value="AddlInfo">
			
		</cfcase>
		<cfcase value="Payment">
			
		</cfcase>
		<cfcase value="Review">
			
		</cfcase>
		<cfcase value="Finished">
			
		</cfcase>
	</cfswitch>
	
	});
</script>

</head>

<body>
    <h1>Registration <span style="font-size:13px;text-decoration:underline;"><a href="/support">Having Trouble? Click here to contact support!</a></span></h1>
    <h2>#ActivityBean.getTitle()#</h2>
	#Request.Page.Body#
<!---    
    <cfdump var="#Session#">
    <cfdump var="#Attributes#">--->
</body>
</html>
</cfoutput>
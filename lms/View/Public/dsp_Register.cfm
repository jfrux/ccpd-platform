<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Online Registration</title>
<link href="#Application.Settings.RootPath#/_styles/Register.css" rel="stylesheet" type="text/css" />
</head>

<body>
<cfoutput>
<h1>Registration</h1>
<h2>#ActivityBean.getTitle()#</h2>
<div id="ProcessFlow">
	<a href="Signup" class="Complete">Sign-up</a><a href="Login" class="Complete">Login</a><a href="AddlInfo" class="Current">Add'l Info</a><a href="Payment">Payment</a><a href="Review">Review</a><a href="Finished">Finished</a>
</div>

</cfoutput>
</body>
</html>

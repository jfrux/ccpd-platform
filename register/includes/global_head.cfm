<cfoutput>
<link href="#Request.RootPath#/Styles/inc_styles.css" rel="stylesheet" type="text/css" />
<link href="#Request.RootPath#/Styles/Forms.css" rel="stylesheet" type="text/css" />
<script src="#Request.RootPath#/scripts/jquery-1.2.6.min.js" type="text/javascript"></script>
<script type="text/javascript" src="#Request.RootPath#/scripts/jquery.maskedinput-1.1.3.pack.js"></script>
<script type="text/javascript" src="#Request.RootPath#/scripts/jquery.cfjs.packed.js"></script>
<script type="text/javascript" src="#Request.RootPath#/scripts/jquery.dimensions.pack.js"></script>
<script type="text/javascript" src="#Request.RootPath#/scripts/Global.js"></script>
<script type="text/javascript" src="#Request.RootPath#/scripts/jquery.blockUI.js"></script>
<script type="text/javascript" src="#Request.RootPath#/scripts/jquery.highlight-2.js"></script>
<script type="text/javascript" src="#Request.RootPath#/scripts/jquery.timepicker.js"></script>
<script type="text/javascript" src="#Request.RootPath#/scripts/jquery-ui.js"></script>
<script type="text/javascript" src="#Request.RootPath#/scripts/jquery.selectboxes.pack.js"></script>
<script type="text/javascript" src="#Request.RootPath#/scripts/jquery.contextmenu.r2.packed.js"></script>
<script type="text/javascript" src="#Request.RootPath#/scripts/jquery.form.js"></script>

</cfoutput>
<script>
$(document).ready(function() {
	var CurrDate = new Date();
	$("#date1").mask("99/99/9999");
	$("#date1").datepicker({ 
		showOn: "button", 
		buttonImage: "/_images/calendar.gif", 
		buttonImageOnly: true ,
		yearRange: '1900:' + CurrDate.getFullYear()
	});
	$("#date2").mask("99/99/9999");
	$("#date2").datepicker({ 
		showOn: "button", 
		buttonImage: "/_images/calendar.gif", 
		buttonImageOnly: true 
	});
	$("#date3").mask("99/99/9999");
	$("#date3").datepicker({ 
		showOn: "button", 
		buttonImage: "/_images/calendar.gif", 
		buttonImageOnly: true 
	});
	$("#date4").mask("99/99/9999");
	$("#date4").datepicker({ 
		showOn: "button", 
		buttonImage: "/_images/calendar.gif", 
		buttonImageOnly: true 
	});
	$("#date5").mask("99/99/9999");
	$("#date5").datepicker({ 
		showOn: "button", 
		buttonImage: "/_images/calendar.gif", 
		buttonImageOnly: true 
	});
	$("#date6").mask("99/99/9999");
	$("#date6").datepicker({ 
		showOn: "button", 
		buttonImage: "/_images/calendar.gif", 
		buttonImageOnly: true 
	});
	$("#date7").mask("99/99/9999");
	$("#date7").datepicker({ 
		showOn: "button", 
		buttonImage: "/_images/calendar.gif", 
		buttonImageOnly: true 
	});
	$("#date8").mask("99/99/9999");
	$("#date8").datepicker({ 
		showOn: "button", 
		buttonImage: "/_images/calendar.gif", 
		buttonImageOnly: true 
	});
	$("#phone1").mask("(999) 999-9999");
	$("#phone2").mask("(999) 999-9999");
	$("#phone3").mask("(999) 999-9999");
	$("#phone4").mask("(999) 999-9999");
	$("#phone5").mask("(999) 999-9999");
	$("#phone6").mask("(999) 999-9999");
	$("#phone7").mask("(999) 999-9999");
	$("#phone8").mask("(999) 999-9999");
	$("#fax1").mask("(999) 999-9999");
	$("#fax2").mask("(999) 999-9999");
	$("#tin").mask("99-9999999");
	$("#ssn").mask("9999");
});
</script>
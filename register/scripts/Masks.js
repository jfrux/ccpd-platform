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
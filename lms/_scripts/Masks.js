$(document).ready(function() {
	var CurrDate = new Date();
	$("#date1").mask("99/99/9999");
	$("#date1").datepicker({ 
		showOn: "button", 
		buttonImage: "/lms/_images/calendar.gif", 
		buttonImageOnly: true,
		changeMonth: true,
		changeYear: true
	});
	$("#date2").mask("99/99/9999");
	$("#date2").datepicker({ 
		showOn: "button", 
		buttonImage: "/lms/_images/calendar.gif", 
		buttonImageOnly: true,
		changeMonth: true,
		changeYear: true
	});
	$("#date3").mask("99/99/9999");
	$("#date3").datepicker({ 
		showOn: "button", 
		buttonImage: "/lms/_images/calendar.gif", 
		buttonImageOnly: true,
		changeMonth: true,
		changeYear: true
	});
	$("#date4").mask("99/99/9999");
	$("#date4").datepicker({ 
		showOn: "button", 
		buttonImage: "/lms/_images/calendar.gif", 
		buttonImageOnly: true 
	});
	$("#date5").mask("99/99/9999");
	$("#date5").datepicker({ 
		showOn: "button", 
		buttonImage: "/lms/_images/calendar.gif", 
		buttonImageOnly: true 
	});
	$("#date6").mask("99/99/9999");
	$("#date6").datepicker({ 
		showOn: "button", 
		buttonImage: "/lms/_images/calendar.gif", 
		buttonImageOnly: true 
	});
	$("#date7").mask("99/99/9999");
	$("#date7").datepicker({ 
		showOn: "button", 
		buttonImage: "/lms/_images/calendar.gif", 
		buttonImageOnly: true 
	});
	$("#date8").mask("99/99/9999");
	$("#date8").datepicker({ 
		showOn: "button", 
		buttonImage: "/lms/_images/calendar.gif", 
		buttonImageOnly: true 
	});
	$("#date9").mask("99/99/9999");
	$("#date9").datepicker({ 
		showOn: "button", 
		buttonImage: "/lms/_images/calendar.gif", 
		buttonImageOnly: true 
	});
	$("#date10").mask("99/99/9999");
	$("#date10").datepicker({ 
		showOn: "button", 
		buttonImage: "/lms/_images/calendar.gif", 
		buttonImageOnly: true 
	});
	$("#date11").mask("99/99/9999");
	$("#date11").datepicker({ 
		showOn: "button", 
		buttonImage: "/lms/_images/calendar.gif", 
		buttonImageOnly: true 
	});
	$("#date12").mask("99/99/9999");
	$("#date12").datepicker({ 
		showOn: "button", 
		buttonImage: "/lms/_images/calendar.gif", 
		buttonImageOnly: true 
	});
	
	// THESE TWO MASKS WERE CREATED FOR AND ARE USED IN THE TRANSCRIPT START/END DATE TEXT BOXES - THE '/' NO LONGER WORKED // JS 01/10/2011
	$("#new-date1").mask("99/99/9999");
	$("#new-date1").datepicker({ 
		showOn: "button", 
		buttonImage: "/lms/_images/calendar.gif", 
		buttonImageOnly: true,
		changeMonth: true,
		changeYear: true
	});
	$("#new-date2").mask("99/99/9999");
	$("#new-date2").datepicker({ 
		showOn: "button", 
		buttonImage: "/lms/_images/calendar.gif", 
		buttonImageOnly: true,
		changeMonth: true,
		changeYear: true
	});
	
	$(".AppDate").mask("99/99/9999");
	
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
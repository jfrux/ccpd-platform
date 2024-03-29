function SubmitForm(oForm) {
	if(oForm) {
		oForm.submit();
	}
}

$(function(){
    $('input').keydown(function(e){
        if (e.keyCode == 13) {
            $(this).parents('form').submit();
            return false;
        }
    });
});

/* HISTORY OBJECT */
function historyList(properties) {
	/* SET DEFAULT VALUES */
	var $this = this;
	var settings = properties;
	var dataToSend = {
		personfrom:0,
		personto:0,
		activityto:0,
		startrow:1,
		maxrows:25
	};
	
	//console.log(settings);
	
	$this.setMode = function(mode) {
		settings.mode = mode;
	}
	
	$this.setStartRow = function(startrow) {
		settings.data.startrow = startrow;
	}
	
	$this.setMaxRows = function(maxrows) {
		settings.data.maxrows = maxrows;
	}
		
	$this.getList = function(clear,startTime,inject) {
		if(!inject) {
			inject = 'append';	
		}
		dataToSend = {
			personfrom:0,
			personto:0,
			startrow:1,
			maxrows:25,
			starttime:startTime
		};
		switch(settings.mode) {
			case 'activityTo':
				dataToSend.activityto = settings.data.activityto;
				
			break;
			
			case 'personTo':
				dataToSend.personto = settings.data.personto;
				
			break;
			
			case 'personFrom':
				dataToSend.personfrom = settings.data.personfrom;
				
			break;
			
			case 'personAll':
				dataToSend.personto = settings.data.personto;
				dataToSend.personfrom = settings.data.personfrom;
			break;
			
			case 'all':
			
			break;
		}
		dataToSend.startrow = settings.data.startrow;
		dataToSend.maxrows = settings.data.maxrows;
		
		//console.log(settings.mode);
		//console.log(dataToSend);
		
		if(clear) {
		settings.appendto.find('.history-item').remove();
		}
		listHistory(settings.appendto,dataToSend,inject);
	}
}

// Takes an ISO time and returns a string representing how
// long ago the date represents.
function prettyDate(time){
	var date = new Date((time || "").replace(/-/g,"/").replace(/[TZ]/g," ")),
		diff = (((new Date()).getTime() - date.getTime()) / 1000),
		day_diff = Math.floor(diff / 86400);
	if ( isNaN(day_diff) || day_diff < 0 || day_diff >= 31 )
		return $.DateFormat(date, "mmm dd, yyyy");
			
	return day_diff == 0 && (
			diff < 60 && "just now" ||
			diff < 120 && "1 minute ago" ||
			diff < 3600 && Math.floor( diff / 60 ) + " minutes ago" ||
			diff < 7200 && "1 hour ago" ||
			diff < 86400 && Math.floor( diff / 3600 ) + " hours ago") ||
		day_diff == 1 && "Yesterday" ||
		day_diff < 7 && day_diff + " days ago" ||
		day_diff < 31 && Math.ceil( day_diff / 7 ) + " weeks ago";
}

// If jQuery is included in the page, adds a jQuery plugin to handle it as well
if ( typeof jQuery != "undefined" )
	jQuery.fn.prettyDate = function(){
		return this.each(function(){
			var date = prettyDate(this.title);
			if ( date )
				jQuery(this).text( date );
		});
	};


function listHistory(appendTo,params,inject) {
	var output = '';
	$.ajax({
		url:"/admin/_com/ajax_history.cfc?method=list",
		dataType:'json',
		type:'GET',
		data:params,
		success:function(data, textStatus, XMLHttpRequest) 
			{
				//console.log(data);
				$.each(data.DATASET,function(i,item) {
					var $historyitem = '';
					if(inject == 'append') {
						appendTo.append(renderHistoryItem(item));
						$historyitem = $("#history-item-" + item.HISTORYID);
						$historyitem.show();
					} else if (inject == 'prepend') {
						appendTo.prepend(renderHistoryItem(item));
						$historyitem = $("#history-item-" + item.HISTORYID);
						$historyitem.fadeIn();
					}
					
					$historyitem.find(".history-meta a").prettyDate();
					$historyitem.find(".prettydate").prettyDate();
					setInterval(function(){ $historyitem.find(".history-meta a").prettyDate(); }, 5000);
					setInterval(function(){ $historyitem.find(".prettydate").prettyDate(); }, 5000);
				});
				
				
				//appendTo.find(".history-meta a").text();
			}
		});
}

function renderHistoryItem(row) {
	var re = /%[A-Za-z]+%/g;
	var ReturnContent = row.TEMPLATEFROM;
	
	var aFoundFields = ReturnContent.match(re);
	var sOutput = "";
	var ToContent = "";
	
	
	$.each(aFoundFields,function(i,item) {
		ReturnContent = ReturnContent.replace(item,item.toUpperCase());
		VarName = $.trim($.Replace(item,"%","","ALL")).toUpperCase();
		//console.log(item + " = " + VarName + " = " + eval("row." + VarName));
		//console.log(VarName);
		ReturnContent = $.Replace(ReturnContent,VarName,eval("row." + VarName.toUpperCase()),"ALL");
	});
	
	
	ReturnContent = $.Replace(ReturnContent,"/admin/index.cfm/event/",sMyself,"ALL");
	ToContent = $.Replace(row.TOCONTENT,"/index.cfm/event/",sMyself,"ALL");
	var $item = $("<div/>")
					.addClass('uiStoryItem')
					.attr({
						  id:"uiStoryItem-" + row.HISTORYID
						  });
			
	sOutput = "<div class=\"history-item clearfix\" id=\"history-item-" + row.HISTORYID + "\" style=\"display:none;\">" +
				"<div class=\"history-line clearfix\"><a class=\"uiImage-i\" href=\"/person/general?personId=" + row.FROMPERSONID + "\"><img src=\"" + row.FROMPERSONIMAGE + "\" border=\"0\" /></a>" + ReturnContent + "</div>";
	if(ToContent) {
		sOutput = sOutput + "<div class=\"mvm plm history-subbox\">" + 
			ToContent +
			"<div style=\"clear:both;\"></div>" +
			"</div>";
			
	}
	sOutput = sOutput + "<div class=\"history-meta\"><a title=\"" + row.CREATED + "\">" + row.CREATED + "</a></div>" +
			"</div>";
		
		sOutput = $.Replace(sOutput,"%","","ALL");
	
	return sOutput;
}

function announcer(data) {
	
}

var defibrillator = '';

function stopDefibrillator() {
	defibrillator.stop();
}

function defibrillate(thedata) {
	announcer(thedata);
}

function crashCart() {
	$.getJSON("/admin/defibrillator.cfc?method=shock&yell=clear",function(data) {
		defibrillate(data)
	});
}

function startDefibrillator() {
	defibrillator = $.PeriodicalUpdater('/admin/_com/defibrillator.cfc', {
			method: 'get',          // method; get or post
			  data: { method:'shock',yell:'clear' },                   // array of values to be passed to the page - e.g. {name: "John", greeting: "hello"}
			  minTimeout: 2000,       // starting value for the timeout in milliseconds
			  maxTimeout: 16000,       // maximum length of time between requests
			  multiplier: 2,          // if set to 2, timerInterval will double each time the response hasn't changed (up to maxTimeout)
			  type: 'json',           // response type - text, xml, json, etc.  See $.ajax config options
			maxCalls: 25,            // maximum number of calls. 0 = no limit.
			autoStop: 0             // automatically stop requests after this many returns of the same data. 0 = disabled.
		}, function(data) {
			defibrillate(data);	
		}
	);
}

function addMessage(text,delay,params) {
	var defaults = {
		sticky:false,
		life:3500,
		theme:'success',
		header:''
	};
	
	if(!params) {
		params = {};	
	}
	if(!text) {
		return;	
	} else {
		params.text = text;
	}
	
	if(!delay) {
		delay = null;
	} else {
		params.life = delay;
	}
	var settings = $.extend({},
							defaults,
							{ 
								'life':params.life
							}, 
							params);
	$.jGrowl(text,{
			 	'life':settings.life,
				'theme':settings.theme,
				'sticky':settings.sticky,
				'header':settings.header
			 });
}

function addError(text,delay) {
	$.jGrowl(text,
			 {
			 	theme:'error'
			 });
}

/* READY FUNCTION */
$(function(){
	
    $('input').keydown(function(e){
        if (e.keyCode == 13) {
            $(this).parents('form').submit();
            return false;
        }
    });
	/*if(loggedIn) {
		startDefibrillator();	
	}*/
	
	$("input.DatePicker").mask("99/99/9999");
	
	$("#date1").mask("99/99/9999");
	$("#date2").mask("99/99/9999");
	$("#date3").mask("99/99/9999");
	$("#date4").mask("99/99/9999");
	$("#date5").mask("99/99/9999");
	$("#date6").mask("99/99/9999");
	$("#date7").mask("99/99/9999");
	$("#date8").mask("99/99/9999");
	$("#date9").mask("99/99/9999");
	$("#date10").mask("99/99/9999");
	$("#date11").mask("99/99/9999");
	$("#date12").mask("99/99/9999");
	
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
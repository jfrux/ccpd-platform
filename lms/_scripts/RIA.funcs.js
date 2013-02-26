function showPersonFinder(sInstance) {
	$("#" + sInstance + "Window").show(250);
	$("input").unbind("keypress");
	eval(sInstance + "bindEnterPerson()");
	
	fixWindowPos(sInstance);
}

function hidePersonFinder(sInstance) {
	$("#" + sInstance + "Window").hide(250);
	bindEnterSubmit();
}

function addPerson(sInstance,nPersonID,sName) {
	$("#" + sInstance + "Name").attr("value",sName);
	$("#" + sInstance + "ID").attr("value",nPersonID);
	$("#" + sInstance + "Window").hide();
	bindEnterSubmit();
}

function setValue(sInstance,sItemID,nCheckType) {
	var nValueID = 0;
	var sValueName = '';
	nValueID = $.Replace(sItemID,sInstance,'','all');
	if(nValueID > 0) {
		sValueName = $("#" + sItemID)[0].innerHTML;
		$("#" + sInstance + "Name").attr("value",sValueName);
	} else {
		sValueName = $("#" + sInstance + "Name").val();
	}
	
	if(sValueName != '') {
	$.post("#Application.Settings.RootPath#/_com/Listing.cfc?method=checkExists&returnFormat=plain&CheckType=" + nCheckType + "&CheckValue=" + sValueName, 
		 function(data){
			 data = $.trim(data);
			 if (data == "false") {
				 /* IF THEY WANT TO ADD, THEN ADD IT */
				 if (confirm("'" + sValueName + "' is not currently in the system. Do you wish to add it?")) {
					$.post("#Application.Settings.RootPath#/_com/Listing.cfc?method=addItem&returnFormat=plain&CheckType=" + nCheckType + "&CheckValue=" + sValueName, 
						 function(data){
							 data = $.trim(data);
							 nValueID = data;
							$("#" + sInstance + "Menu").prepend("<div class=\"riaComboBoxItem\" id=\"" + sInstance + nValueID + "\">" + sValueName + "</div>");
							$(".riaComboBoxItem").hover(
								  function () {
									$(this).addClass("riaComboBoxItemOn");
								  }, 
								  function () {
									$(this).removeClass("riaComboBoxItemOn");
								  }
								);
							$(".riaComboBoxItem").bind("click", this, function(e) {
								setValue(sInstance,this.id,nCheckType);
							});
					});
				 } else {
					 $("#" + sInstance + "Name").attr("value","");
				 }
			 }
	});
	
	$("#" + sInstance + "ID").attr("value",nValueID);
	$("#" + sInstance + "Name").removeClass("riaComboBoxOn");
	$("#" + sInstance + "Name").addClass("riaComboBoxOff");
	$("#" + sInstance + "Menu").hide();
	}
}

function setMenuPos(InstanceName) {
	var TextBoxPosTop;
	var TextBoxPosLeft;
	var TextBoxHeight;
	var TextBoxWidth;
	var DivPosTop;
	var DivPosLeft;
	
	/* FIND TEXT BOX */
	TextBoxPosTop = $('#' + InstanceName + 'Name').position().top;
	TextBoxPosLeft = $('#' + InstanceName + 'Name').position().left;
	TextBoxHeight = $('#' + InstanceName + 'Name').height();
	TextBoxWidth = $('#' + InstanceName + 'Name').width();
	
	DivPosTop = TextBoxPosTop + TextBoxHeight + 4;
	DivPosLeft = TextBoxPosLeft;
	
	$("#" + InstanceName + "Menu").css({ position: "absolute", top: DivPosTop, left: DivPosLeft });	
}

function fixWindowPos(InstanceName) {
	var WindowWidth = $(window).width();
	var DivRight = ($('#' + InstanceName + 'Window').position().left + 400);
	//console.log("Window: " + WindowWidth);
	//console.log("DivRight: " + DivRight);
	var DivWinOffset = (WindowWidth - DivRight);
	//console.log("DivWinOffset: " + DivWinOffset);
	var NewDivLeft = $('#' + InstanceName + 'Window').position().left;
	if(DivWinOffset < 0) {
		NewDivLeft = (NewDivLeft+DivWinOffset);	
		//console.log(NewDivLeft);
		$('#' + InstanceName + 'Window').css('left',NewDivLeft + 'px');
	}
}
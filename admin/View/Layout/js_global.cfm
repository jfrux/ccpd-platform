<cfoutput>
<script>
<cfif session.loggedIn>
var fuseaction = '#attributes.event#';
var user = {
  firstName: '#session.person.getFirstName()#',
  lastName: '#session.person.getLastName()#',
  email: '#session.person.getEmail()#'
};
</cfif>

var loggedIn = false;
var StatusCount = 0;
var currPersonId = 0;
<cfif structKeyExists(session,'personid')>
currPersonId = <cfif isDefined("session.personId") AND len(trim(session.personId)) GT 0>#session.personid#<cfelse>0</cfif>;
</cfif>

$(document).ready(function() {

  //  $("##ajax-issue-button").click(function() {
  //    $("##ajax-issue").hide();
  //  });
  //  $.ajaxSetup({
  //    error:function(x,e){
  //      console.log(x);
  //      console.log(e);
  //      var sTitle = "Unexpected Error";
  //      var sMessage = "";
  //      if(x.status==0){
  //        //sMessage = "Connection to CCPD failed... please check your internet connection.";
  //      }else if(x.status==404){
  //        sMessage = "OOPS! An error occurred during your last request. Page not found!";
  //      }else if(x.status==500){
  //        errMsg = "500 Internal Server Error"
  //        sMessage = "OOPS! An error occurred during your last request.  We are sorry for the inconvenience.";
  //      }else if(e=="parsererror"){
  //        sMessage = "OOPS! An error occurred during your last request.  JSON parsing error.";
  //      }else if(e=="timeout"){
  //        sMessage = "OOPS! An error occurred during your last request.  REQUEST TIMED OUT";
  //      }else {
  //        sMessage = "OOPS! An error occurred during your last request. " + x.responseText;
  //      }
        
  //      $("##ajax-issue-title").html(sTitle);
  //      $("##ajax-issue-details").html(sMessage);

  //      BugLog.notifyService({
  //        message: "XHR: " + sMessage,
  //        error: JSON.stringify(x),
  //        severity: "ERROR"
  //      });

  //      $("##ajax-issue").show();
  //    }
  //  }); 
});

function addMessage(sStatus,nFadeIn,nFadeTo,nFadeOut) {
  App.Components.Status.addMessage(sStatus,nFadeIn,nFadeTo,nFadeOut);
  // $("##StatusBar").show();
  // StatusCount++;
  // $("##StatusBar").append("<div style=\"display:none;\" class=\"PageMessages\" id=\"StatusBox" + StatusCount + "\">" + sStatus + "</div>");
  // //console.log("Status: " + StatusCount);
  // $("##StatusBox" + StatusCount).show("slide",{direction: "down"},500).fadeTo(nFadeTo,.9).hide("slide",{direction: "down"},nFadeOut);
}

function addError(sStatus,nFadeIn,nFadeTo,nFadeOut) {
  App.Components.Status.addError(sStatus,nFadeIn,nFadeTo,nFadeOut);
  // $("##StatusBar").show();
  // StatusCount++;
  // $("##StatusBar").append("<div style=\"display:none;\" class=\"PageErrors\" id=\"StatusBox" + StatusCount + "\">" + sStatus + "</div>");
  // $("##StatusBox" + StatusCount).show("slide",{direction: "down"},500).fadeTo(nFadeTo,.9).hide("slide",{direction: "down"},nFadeOut);
}


jQuery().ready(function(){

//   
    
  $(".BreadcrumbIcon").attr("src","#Application.Settings.RootPath#/admin/_images/icons/bullet_go#Request.NavItem#.png");
  $("##PageStandard").hide();
  /* SESSION TIMEOUT REDIRECT */
  function sessionTimeout() {
    window.location='#myself#Main.Login';
  }
  <cfif NOT isDefined("Client.Login") OR Client.Login EQ "">
  window.setTimeout(sessionTimeout, 10800000);
  </cfif>
  
   LoadDocWidth = $(document).width();
  
<cfswitch expression="#Request.NavItem#">
  <cfcase value="1">
    $("##HeaderTab1").removeClass("HeaderTab");
    $("##HeaderTab1").addClass("HeaderTabOn");
    
  </cfcase>
  <cfcase value="2">
    $("##HeaderTab2").removeClass("HeaderTab");
    $("##HeaderTab2").addClass("HeaderTabOn");
  </cfcase>
  <cfcase value="3">
    $("##HeaderTab3").removeClass("HeaderTab");
    $("##HeaderTab3").addClass("HeaderTabOn");
  </cfcase>
  <cfcase value="4">
    $("##HeaderTab4").removeClass("HeaderTab");
    $("##HeaderTab4").addClass("HeaderTabOn");
  </cfcase>
  <cfcase value="5">
    $("##HeaderTab5").removeClass("HeaderTab");
    $("##HeaderTab5").addClass("HeaderTabOn");
  </cfcase>
  <cfcase value="6">
    $("##HeaderTab6").removeClass("HeaderTab");
    $("##HeaderTab6").addClass("HeaderTabOn");
  </cfcase>
</cfswitch>

  <cfparam name="Attributes.Message" default="">
  <cfif Attributes.Message NEQ "">
    <cfset Request.Status.Messages = Attributes.Message>
  </cfif>
  
  
  <cfif Request.Status.Errors NEQ "">
    <cfloop list="#Request.Status.Errors#" delimiters="|" index="err">
      addError("#err#",250,8000,3500);
    </cfloop>
  </cfif>
  <cfif Request.Status.Messages NEQ "">
    <cfloop list="#Request.Status.Messages#" delimiters="|" index="msg">
      addMessage("#msg#",250,6000,4000);
    </cfloop>
  </cfif>
  
  $(".PageErrors span a").unbind("click");
  $(".PageMessages span a").unbind("click");
  
  $(".PageErrors span img").bind("click", this, function() {
    var nId = $.Replace(this.id,'Status','');
    $("##StatusBox" + nId).fadeOut("fast");
  });
  
  
  
  $(".PageStandard").hide();
});
</script>
</cfoutput>
<script>
$(document).ready(function() {
  $("#q").uiTypeahead({
    watermarkText:'Type to search...',
    queryParam:'q',
    size:'full',
    bucketed:'true',
    allowViewMore:true,
    useExistingInput:true,
    ajaxSearchURL:"/admin/_com/ajax/typeahead.cfc",
    ajaxSearchType:"GET",
    ajaxSearchParams:{
      method:'search',
      max:4
    },
    allowAdd:false,
    clearOnSelect:true,
    onSelect:function(item) {
      if(item.link) {
      window.location=item.link;
      }
    }
  });
  
  $("#navSearch .calltoaction").live("click",function() {
    $(".gblSearchBtn").click();
  });
  
  $("#navSearch").submit(function() {
    var $gblInput = $("#navSearch").find('.ui-autocomplete-input');
    var gblQuery = $gblInput.val();
    
    if(gblQuery.length) {
      return true;
    } else {
      return false;
    }
  });
  
  $(".gblSearchBtn").click(function() {
    var qVal = $("#navSearch").find('.ui-autocomplete-input').val();
    var $qField = $("#navSearch").find("#q");
    
    $qField.val(qVal);
    
  });
});
</script>
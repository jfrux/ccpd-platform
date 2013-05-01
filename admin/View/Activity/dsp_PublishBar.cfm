<cfparam name="Attributes.PublishFlag" default="N" />
<cfparam name="FillPercentage" default="0" />

<script>
<cfoutput>
nFillPercent = #FillPercentage#;
nRoundedFillPercent = #Round(FillPercentage)#;
sFillColor = '#FillColor#';
</cfoutput>
$(document).ready(function() {
  $("#FillBar").css("width", nFillPercent + "%");
  $("#FillBar").css("background-color", "#" + sFillColor);
  $("#PublishPercent").html("&nbsp;" + nRoundedFillPercent + "%");

  if(nFillPercent == 100) {
    $("#PublishActivity").attr("disabled", "disabled");
  } else {
    $("#PublishActivity").on("click", function() {
      $.ajax({
        url:sRootPath + "/_com/AJAX_Activity.cfc", 
        dataType:'json',
        type:'post',
        data: {
          method: "publishActivity", 
          ActivityID: nActivity, 
          returnFormat: "plain" 
        },
        success: function(data){
          if(data.STATUS) {
            addMessage(data.STATUSMSG,250,6000,4000);
            $("#PublishActivity").addClass('disabled');
            //updateActions();
            updatePublishState();
          } else {
            addError(data.STATUSMSG,250,6000,4000);
          }
        }
      });
    }); 
  }
  

  

  <cfif Attributes.PublishFlag EQ "Y">
  $("#PublishActivity").val("Unpublish Activity");
  </cfif>
});
</script>
<cfoutput>
<div class="btn-toolbar clearfix">
<div class="btn-group">
<a class="btn btn-mini btn-publish-progress dropdown-toggle" data-toggle="dropdown" href="##">
Progress
<span class="caret"></span>
</a>
<ul class="dropdown-menu">
<li class="nav-header">PUBLISH PROGRESS</li>
<li class="nav-header">
<div id="PublishStateBar" class="progress progress-info">
<div id="FillBar" class="bar"></div>
</div>
</li>
<cfloop from="1" to="#arrayLen(PublishElementList)#" index="i">
<cfset elem = PublishElementList[i] />
<cfif elem.Show>
<li><a href="#elem.Link#"><i <cfif elem.image EQ 'tick'>style="color:green;"<cfelse>style="color:red;"</cfif>class="<cfif elem.image EQ 'tick'>icon-ok-circle<cfelse>icon-exclamation-sign</cfif>"></i> #elem.Field#</a></li>
</cfif>
</cfloop>
</ul>
</div>
<div class="btn-group">
<a class="btn btn-mini" id="PublishActivity" data-tooltip-title="Publish Activity"><i class="icon-globe"></i></a>
<a class="btn btn-mini" id="UnpublishActivity" data-tooltip-title="Unpublish Activity"><i class="icon-remove-circle"></i></a>
</div>
</div>
</cfoutput>
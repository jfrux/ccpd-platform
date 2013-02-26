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
	
	<cfif FillPercentage NEQ 100> 
		$("#PublishActivity").attr("disabled", "disabled");
	</cfif>
	
	$("#PublishActivity").bind("click", this, function() {
		$.getJSON(sRootPath + "/_com/AJAX_Activity.cfc", { method: "publishActivity", ActivityID: nActivity, returnFormat: "plain" },
					function(data){
						if(data.STATUS) {
							addMessage(data.STATUSMSG,250,6000,4000);
							updateActions();
							updatePublishState();
						} else {
							addError(data.STATUSMSG,250,6000,4000);
						}
				});
	});
	
	<cfif Attributes.PublishFlag EQ "Y">
		$("#PublishActivity").val("Unpublish Activity");
	</cfif>
});
</script>
<cfoutput>
<div class="MultiFormRight_SectSubTitle">Publish <cfif FillPercentage EQ 100><img src="#Application.Settings.RootPath#/_images/icons/<cfif Attributes.PublishFlag EQ "N">exclamation<cfelse>tick</cfif>.png" title="Publish Activity" /></cfif></div>
<div class="MultiFormRight_SectBody">
    <div id="PublishStateBar">
        <div id="FillBar"></div>
    </div>
    <div id="PublishPercent"></div>
    <div id="PublishElementList">
    <cfloop from="1" to="#arrayLen(PublishElementList)#" index="i">
        <cfif PublishElementList[i].Show>
            <img src="#Application.Settings.RootPath#/_images/icons/#PublishElementList[i].Image#.png" /> <a href="#PublishElementList[i].Link#">#PublishElementList[i].Field#</a><br />
        </cfif>
    </cfloop>
    <div><input type="button" name="btnPublish" id="PublishActivity" value="Publish Activity" /></div>
    </div>
</div>
</cfoutput>
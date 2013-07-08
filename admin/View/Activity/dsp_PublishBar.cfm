<cfparam name="Attributes.PublishFlag" default="N" />
<cfparam name="FillPercentage" default="0" />

<script>
<cfoutput>
  App.Activity.Publish.Bar.data = {
    nFillPercent: #FillPercentage#,
    nRoundedFillPercent: #Round(FillPercentage)#,
    sFillColor: '#FillColor#',
    publishState: '#attributes.publishFlag#'
  };
</cfoutput>
$(document).ready(function() {
  App.Activity.Publish.Bar.start();
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
<div id="PublishStateBar" class="progress progress-info js-progress-info-bar">
<div id="FillBar" class="bar js-progress-info-bar-fill"></div>
</div>
</li>
<cfloop from="1" to="#arrayLen(PublishElementList)#" index="i">
<cfset elem = PublishElementList[i] />
<cfif elem.Show>
<li><a href="#elem.Link#"><i <cfif elem.image EQ 'tick'>style="color:green;"<cfelse>style="color:red;"</cfif>class="<cfif elem.image EQ 'tick'>icon-ok-circle<cfelse>icon-attention-circle</cfif>"></i> #elem.Field#</a></li>
</cfif>
</cfloop>
</ul>
</div>
<div class="btn-group">
<a class="btn btn-mini js-publishactivity-btn" id="PublishActivity" data-tooltip-title="Publish Activity"><i class="icon-globe"></i></a>
<a class="btn btn-mini js-unpublishactivity-btn" id="UnpublishActivity" data-tooltip-title="Unpublish Activity"><i class="icon-cancel"></i></a>
</div>
</div>
</cfoutput>
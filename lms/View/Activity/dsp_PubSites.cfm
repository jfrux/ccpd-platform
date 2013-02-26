<cfparam name="Attributes.Overview" default="" />
<cfparam name="Attributes.Keywords" default="" />
<cfparam name="Attributes.Objectives" default="" />
<cfparam name="Attributes.Goals" default="" />
<cfparam name="Attributes.PublishDate" default="" />
<cfparam name="Attributes.RemoveDate" default="" />
<script>
$(document).ready(function() {
	$(".SiteCheck").bind("click", this, function() {
		nSite = $.Replace(this.id,"Site","");
			
		$.getJSON(sRootPath + "/_com/AJAX_Activity.cfc", { method: "PublishActivityToSite", ActivityID: nActivity, SiteID: nSite, returnFormat: "plain"},
			  function(data){	
				if(data.STATUS) {				
					addMessage(data.STATUSMSG,250,6000,4000);
				} else {
					addError(data.STATUSMSG,250,6000,4000);
				}
		  });
	});
});
</script>

<cfoutput>
<div class="ViewSection">
	<h3>Sites</h3>
	
	<cfset qSites = Application.Com.SiteGateway.getByAttributes(DeletedFlag='N')>
	
	<cfloop query="qSites">
	<input type="checkbox" name="Site" id="Site#qSites.SiteID#" value="#qSites.SiteID#" class="SiteCheck"<cfif ListFind(PublishedSitesList, qSites.SiteID, ",")> CHECKED</cfif> /> <label for="Site#qSites.SiteID#"><strong>#qSites.NameShort#</strong> #qSites.Name#</label>
	</cfloop>
</div>
</cfoutput>
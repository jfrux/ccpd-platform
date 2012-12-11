<script>
$(document).ready(function() {
	$("#email-subject").placeholder();
	$("#email-body").placeholder();
});
</script>
<cfoutput>
<div>
	<form name="frmEmailCert" id="frmEmailCert" method="post" action="#application.settings.rootPath#/_com/ajax_activity.cfc">
        <input type="hidden" name="method" value="emailCertificate" />
        <input type="hidden" name="activityId" value="#attributes.activityId#" />
        <input type="hidden" name="personId" value="#attributes.personId#" />
        <div class="fieldLabel">Subject:</div>
        <div class="fieldInput"><input type="text" name="subject" id="email-subject" style="width:365px;" placeholder="CCPD Activity Certificate"></div>
        <div class="fieldLabel">Body:</div>
        <div class="fieldInput"><textarea name="body" id="email-body" style="width:365px; height: 155px;" placeholder="Leave blank for default message."></textarea></div>
    </form>
</div>
</cfoutput>
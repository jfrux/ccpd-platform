<script type="text/javascript" src="scripts/jquery-1.2.6.min.js"></script>
<script type="text/javascript" src="scripts/jquery-ui.js"></script>
<script type="text/javascript" src="scripts/jquery.dimensions.pack.js"></script>
<script type="text/javascript" src="scripts/jquery.cfjs.packed.js"></script>
<script type="text/javascript" src="scripts/jquery.form.js"></script>
<script type="text/javascript" src="scripts/jquery.scrollTo-min.js"></script>
<script type="text/javascript" src="scripts/jquery.maskedinput-1.1.3.pack.js"></script>

<script>
<cfoutput>
var sRootPath = "#Request.RootPath#";
var StatusCount = 0;
</cfoutput>

function addError(sStatus,nFadeIn,nFadeTo,nFadeOut) {
	$("#StatusBar").show();
	StatusCount++;
	$("#StatusBar").append("<div style=\"display:none;\" class=\"PageErrors\" id=\"StatusBox" + StatusCount + "\">" + sStatus + "</div>");
	$("#StatusBox" + StatusCount).show("slide",{direction: "down"},500).fadeTo(nFadeTo,.9).hide("slide",{direction: "down"},nFadeOut);
}
</script>
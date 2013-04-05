<cfparam name="Attributes.ThisUpdated" default="">

<script>


var lastSavedDate = "<cfoutput><cfif DateDiff("d",Attributes.ThisUpdated,now()) GT 0>on #DateFormat(Attributes.ThisUpdated,'mm/dd/yyyy')#</cfif> at #TimeFormat(Attributes.ThisUpdated,'h:mm TT')#</cfoutput>";
var IsSaved = false;

<cfif Attributes.ThisUpdated NEQ "">
IsSaved = true;
</cfif>
</script>
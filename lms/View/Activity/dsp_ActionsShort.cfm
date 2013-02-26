
<script>
$(document).ready(function() {
	$("#ActionPersonDetail").dialog({ 
			title: "Person Detail",
			modal: true, 
			autoOpen: false,
			position:[40,40],
			height:550,
			width:730,
			resizable: false,
			dragStop: function(ev,ui) {
				
			},
			open:function() {
				$("#frmActionPerson").attr('src',sMyself + 'Person.Detail?PersonID=' + nPersonID + '&Mini=1');
			},
			close:function() {
				
			}
		});
		
		
	$(".ActionPersonLink").click(function() {
		nPersonID = $.ListGetAt(this.id,2,"|");
		sPersonName = $.ListGetAt(this.id,3,"|");

		$("#ActionPersonDetail").dialog("open");
		return false;
	});
});
</script>
<cfoutput>
<h3>History</h3>
<div class="ActionList">
<cfif qActions.RecordCount GT 0>
	<cfloop query="qActions">
	<div class="ActionShort">#qActions.ShortName#</div>
	<div class="ActionAuthor"><a href="#myself#Person.Detail?PersonID=#qActions.CreatedBy#" title="#qActions.FirstName# #qActions.LastName#" style="color:##999;" class="ActionPersonLink" id="View|#qActions.CreatedBy#|#qActions.FirstName# #qActions.LastName#">#qActions.username#</a> #DateFormat(qActions.Created,"mm/dd/yy")# #TimeFormat(qActions.Created,"hh:mmTT")#</div>
	</cfloop>
</cfif>
</div>
</cfoutput>
<div id="ActionPersonDetail">
	<iframe src="" width="700" height="500" frameborder="0" scrolling="auto" name="frmActionPerson" id="frmActionPerson"></iframe>
</div>
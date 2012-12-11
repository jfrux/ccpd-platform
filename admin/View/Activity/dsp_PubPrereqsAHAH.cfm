<script>
$(document).ready(function() {	
	$(".PrereqRemoveLink").click(function() {
		var CleanID = $.Replace(this.id,'PrereqRemove','','all');
		var PrereqID = $.ListGetAt(CleanID,1,"|");
		var PrereqName = $.ListGetAt(CleanID,2,"|");
		
		if (confirm('Are you sure you want to remove the prerequisite from this activity?')) {
			$.post(sRootPath + "/_com/ActivityPrereq/ActivityPrereqAjax.cfc", { method: "Remove", ActivityID: nActivity, PrereqID:PrereqID, returnFormat:"plain" },
			  function(data){
				var cleanData = $.trim(data);
				updateActions();
				addMessage("Prerequisite removed successfully!",250,6000,4000);
				updatePrereqs();
			  });
			$("#PrereqRow" + PrereqID).remove();
			$("#PrereqTitle").val("");
		}
	});
	
	$("#btnAddPrereq").click(function() {
		var sTitle = $("#PrereqTitle").val();
		
		if(sTitle == "") {
			addError("You must select an activity to add as a prerequisite.",250,6000,4000);
			return false;
		}
		
		$.post(sRootPath + "/_com/ActivityPrereq/ActivityPrereqAjax.cfc", { method: "Add", ActivityID: nActivity, Title: sTitle, returnFormat:"plain" },
			  function(data){
				var cleanData = $.trim(data);
				var Status = $.ListGetAt(cleanData, 1, "|");
				var StatusMsg = $.ListGetAt(cleanData, 2, "|");
				
				if(Status == "Success") {
					updatePrereqs();
					updateActions();
					addMessage(StatusMsg,250,6000,4000);
					$("#PrereqTitle").val("");
				} else {
					addError(StatusMsg,250,6000,4000);
				}
			});
	});
		
	$("#PrereqTitle").unbind("keydown");
	
	$("#PrereqTitle").autocomplete(sRootPath + '/_com/AJAX_Activity.cfc?method=AutoComplete&returnformat=plain');
});
</script>

<cfoutput>
<p>
    <span><label for="Title">Activity Title</label><input type="text" name="PrereqTitle" id="PrereqTitle" /></span>
    <input type="button" name="btnAddPrereq" id="btnAddPrereq" value="Add Prerequisite" />
</p>
<cfif PrereqList.RecordCount GT 0>
<h4>Current Prerequisites</h4>
<div class="prereqs">
    <div class="prereq-title">#Attributes.Title# <span>(Current activity)</span></div>
    <cfset CurrLevel = "">
    <cfloop query="PrereqList">
    	<cfif CurrLevel NEQ PrereqList.PrereqLevel>
        	<cfif CurrLevel LT PrereqList.PrereqLevel>
            	<ul class="prereqs-container" style="margin-left:#CurrLevel#0%;">
            <cfelseif CurrLevel GT PrereqList.PrereqLevel>
            	</ul>
           	</cfif>
            
        	<cfset CurrLevel = PrereqList.PrereqLevel>
        </cfif>
    	<li class="prereq" id="prereq-#PrereqList.PrereqID#">
            <div class="prereq-options">
                <a href="javascript:void(0);" class="PrereqRemoveLink" id="PrereqRemove#PrereqList.PrereqID#|#PrereqList.ActivityTitle#"><img src="#Application.Settings.RootPath#/_images/icons/delete.png" border="0" /></a>
            </div>
            <div class="prereq-title"><a href="#myself#activity.detail?activityid=#PrereqList.PrereqID#">#PrereqList.ActivityTitle#</a></div>
   		</li>
    </cfloop>
</div>
</cfif>
</cfoutput>
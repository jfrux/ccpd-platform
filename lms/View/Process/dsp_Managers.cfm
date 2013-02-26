<cfoutput>
<script>
	function saveManager() {
		$.blockUI({ message: '<h1>Adding Manager...</h1>'});
		$.post("#Application.Settings.RootPath#/_com/ProcessManager/ProcessManagerAjax.cfc", 
			{ method: "AddPerson", PersonID: $("##ManagersID").val(), ProcessID: #Attributes.ProcessID#, returnFormat: "plain" },
			function(returnData) {
				cleanData = $.trim(returnData);
				status = $.ListGetAt(cleanData,1,"|");
				statusMsg = $.ListGetAt(cleanData,2,"|");
				
				if(status == 'success') {
					window.location="#myself#Process.Managers?ProcessID=#Attributes.ProcessID#&Message=" + statusMsg;
				} else if(status == 'fail') {
					addError(statusMsg,250,6000,4000);
				}
			});

		$("##AttendeeID").val('');
		$("##AttendeeName").val('Click To Add Manager');
	}
	
	$(document).ready(function() {		
		$('##MembersList').ajaxForm();
		
		/* REMOVE ONLY CHECKED */
		$("##RemoveChecked").bind("click",function() {
			if(confirm("Are you sure you want to remove the checked managers from this process?\nALL process queues for these managers will be marked \"Unassigned\"")) {
				var result = "";
				var cleanData = "";
				$(".MemberCheckbox:checked").each(function () {
					result = $.ListAppend(result,$(this).val(),",");
				});
				
				$.post("#Application.Settings.RootPath#/_com/ProcessManager/ProcessManagerAjax.cfc", 
				{ method: "DeletePeople", PersonList: result, ProcessID: #Attributes.ProcessID#, returnFormat: "plain" },
				function(returnData) {
					cleanData = $.trim(returnData);
					
					if(cleanData == 'success') {
						window.location="#myself#Process.Managers&ProcessID=#Attributes.ProcessID#&Message=All Checked Managers have been removed.";
					} else {
						alert("Removal of people failed for unknown reason...");
					}
				});
			}
		});
		
		/* REMOVE ALL PEOPLE FROM PROCESS */
		$("##RemoveAll").bind("click",function() {
			if(confirm("WARNING!\nYou are about to remove ALL managers from this process!\nALL process queues for these managers will be marked \"Unassigned\"\nAre you sure you wish to continue?")) {
				var cleanData = "";

				$.post("#Application.Settings.RootPath#/_com/ProcessManager/ProcessManagerAjax.cfc", 
				{ method: "DeletePeople", PersonList: 0, DeleteAll: "Y", ProcessID: #Attributes.ProcessID#, returnFormat: "plain" },
				function(returnData) {
					cleanData = $.trim(returnData);
					
					if(cleanData == 'success') {
						window.location="#myself#Process.Managers&ProcessID=#Attributes.ProcessID#&Message=All Managers have been removed.";
					} else {
						alert("Removal of people failed for unknown reason...");
					}
				});
			}
		});
		
		$("##CheckAll").click(function() {
			if($("##CheckAll").attr("checked")) {
				$(".MemberCheckbox").each(function() {
					$(this).attr("checked",true);
				});
			} else {
				$(".MemberCheckbox").each(function() {
					$(this).attr("checked",false);
				});
			}
		}); 
	});
	
</script>
</cfoutput>
<form name="MembersList" method="post" id="MembersList">
<div class="ViewSection">
<cfif ManagerPager.getTotalNumberOfPages() GT 1><div><cfoutput>#ManagerPager.getRenderedHTML()#</cfoutput></div></cfif>
<table border="0" width="100%" cellpadding="3" cellspacing="1" class="ViewSectionGrid">
	<thead>
		<tr>
			<th style="padding:0px 4px;" width="15"><input type="checkbox" name="CheckAll" id="CheckAll" /></th>
			<th>Manager</th>
		</tr>
	</thead>
	<tbody>
		<cfoutput query="qManagers" startrow="#ManagerPager.getStartRow()#" maxrows="#ManagerPager.getMaxRows()#">
			<tr>
				<td><input type="checkbox" name="Checked" class="MemberCheckbox" id="Checked#PersonID#" value="#PersonID#" /></td>
				<td style="height:40px;">
					<a href="#myself#Person.Detail?PersonID=#PersonID#">#LastName#, #FirstName#</a>
				</td>
			</tr>
		</cfoutput>
	</tbody>
</table>
<cfif ManagerPager.getTotalNumberOfPages() GT 1><div><cfoutput>#ManagerPager.getRenderedHTML()#</cfoutput></div></cfif>
</div>
</form>
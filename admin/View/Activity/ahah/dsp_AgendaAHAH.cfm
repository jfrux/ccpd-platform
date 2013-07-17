<cfsetting showdebugoutput="no" />
<script>
$(document).ready(function (){
	var nAgendaID = 0;
	var sAddDate = '';
	
	function continueSaveAgenda() {
		$.post(sRootPath + "/_com/AJAX_Activity.cfc",
			{
				method: "saveAgendaItem",
				AgendaID: $("#frmSaveAgenda #AgendaID").val(),
				ActivityID: nActivity,
				Description: $("#frmSaveAgenda #Description").val(),
				EventDate: $("#frmSaveAgenda #EventDate").val(),
				StartTime: $("#frmSaveAgenda #StartTime").val(),
				EndTime: $("#frmSaveAgenda #EndTime").val(),
				returnFormat:"plain"
			},
			function(returnData) {
				cleanData = $.trim(returnData);
				status = $.ListGetAt(cleanData,1,"|");
				statusMsg = $.ListGetAt(cleanData,2,"|");
				if(status == 'Fail') {					
					addError(statusMsg,250,6000,4000);
				} else {
					$("#ItemDialog").dialog("close");
					updateAgenda();
					addMessage(statusMsg,250,6000,4000);
				}
			});
	};
	
	$("#ItemDialog").dialog({ 
		title:"Agenda Item",
		modal: true, 
		autoOpen: false,
		resizable: false,
		height:375,
		width:400,
		overlay: { 
		opacity: 0.5, 
		background: "black" 
	},
		buttons: { 
			Save:function() {
				continueSaveAgenda();
			}, 
			Cancel:function() {
				$("#ItemDialog").dialog("close");
			}
		},
		open:function() {
			$("#Loading").show();
			$.post(sMyself + "Activity.AgendaForm", { AgendaID: nAgendaID, EventDate: sAddDate  },
			  function(data){
				$("#FormArea").html(data);
				$("#Loading").hide();
			  });
			$("#ItemDialog").show();
		},
		close:function() {
			nAgendaID = 0;
			$("#ItemDialog").hide();
			$("#ItemDialog .WaitMessage").show();
			$("#ItemDialog .FormContainer").empty();
		}
	});
	
	$(".AddItemLink").click(function() {
		sAddDate = $(this).attr('id');
		$("#ItemDialog").dialog("open");
	});
	
	$(".AgendaEditLink").click(function() {
		nAgendaID = $.Replace($(this).attr('id'),'AgendaLink','');
		$("#ItemDialog").dialog("open");
	});
	
	$(".AgendaDeleteLink").click(function() {
		nAgendaID = $.Replace($(this).attr('id'),'AgendaDelete','');
		
		if(confirm('Are you sure you want to delete this agenda item?')) {
			$.getJSON(sRootPath + "/_com/AJAX_Activity.cfc", { method: "deleteAgendaItem", AgendaID: nAgendaID, returnFormat: "plain" },
				function(data){
			  		if(data.STATUS) {
						updateAgenda();
						addMessage(data.STATUSMSG,250,6000,4000);
					}
			});
		}
	});
	
});
</script>

<cfoutput>
<div class="ViewContainer">
<div class="ViewSection">
	<div class="ContentBody">
		<cfset StartDate = ActivityBean.getStartDate()>
        <cfset EndDate = ActivityBean.getEndDate()>
        
        <cfif StartDate EQ "" OR EndDate EQ "">
            <cfset StartDate = ActivityBean.getReleaseDate()>
            <cfset EndDate = ActivityBean.getReleaseDate()>
        </cfif>
        
        <cfloop from="#StartDate#" to="#EndDate#" index="i">
            <div style="font-size:15px; font-weight:bold; padding:8px 3px 3px 3px;">#DateFormat(i,'mmmm dd, yyyy')# </div>
            <cfset qItems = Application.Com.AgendaGateway.getByAttributes(ActivityID=Attributes.ActivityID,EventDate=i,OrderBy="StartTime,EndTime")>
            <cfif qItems.RecordCount GT 0>
            <table class="ViewSectionGrid table table-condensed table-bordered mbs">
                <cfloop query="qItems">
                <tr>
                    <td width="30%" style="vertical-align:middle; text-align:center;">#TimeFormat(qItems.StartTime,'h:mmTT')# - #TimeFormat(qItems.EndTime,'h:mmTT')#</td>
                    <td style="vertical-align:middle;">#qItems.Description#</td>
                    <td align="right" width="20%">
                    	<div class="btn-group" style="width:100%;">
                    		<a href="javascript:void(0);" id="AgendaLink#qItems.AgendaID#" class="AgendaEditLink btn btn-default btn-small" style="width:50%;"><i class="icon-pencil"></i></a>
                    		<a href="javascript:void(0);" id="AgendaDelete#qItems.AgendaID#" class="AgendaDeleteLink btn btn-default btn-small" style="width:50%;"><i class="icon-trash"></i></a>
                    	</div>
                    </td>
                </tr>
                </cfloop>
            </table>
            </cfif>
            <a href="javascript:void(0);" id="#DateFormat(i,'mm-dd-yyyy')#" class="AddItemLink btn btn-primary btn-small"><i class="icon-plus"></i> Add Event Time</a>
        </cfloop>
    </div>
</div>
</div>
</cfoutput>
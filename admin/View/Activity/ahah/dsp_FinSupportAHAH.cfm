<cfparam name="Attributes.TotalAmount" default="0">

<script>
<Cfoutput>
// BUILD SUPPORTER ARRAY
aSupporters = new Array();
<cfif qActivitySupportersList.RecordCount NEQ 0>
  <cfset i = 1>
  <cfloop query="qActivitySupportersList">
    <cfset Attributes.TotalAmount = Attributes.TotalAmount + qActivitySupportersList.Amount>
    aSupporters[#qActivitySupportersList.SupportID#] = #qActivitySupportersList.Amount#;
    <cfset i = i++>
  </cfloop>
  nTotalSupportAmount = #Attributes.TotalAmount#;
</cfif>
</cfoutput>
$(document).ready(function() {
  //EDIT DIALOG
  $editDialog = $("#EditSupportRecord");

  function getEditForm(supportId,callback) {
    var cb = callback;
    var editUri = sMyself + "Activity.EditCurrSupport";

    $.ajax({
      url:editUri,
      type:'get',
      data: {
        SupportID: supportId, 
        ActivityID: nActivity
      },
      success: function(data) {
        var $html = $(data);
        var $form = $html.find('form');
        var $fieldDefaultData = $form.find('.js-default-data');
        var $fieldDefaultSupporter = $form.find('.js-default-supporter');
        var support = $.parseJSON($fieldDefaultData.val());
        var supporter = $.parseJSON($fieldDefaultSupporter.val());
        var $supporterInput = $form.find('.js-supporter-typeahead');

        $editDialog.dialog({
          title:"Edit Support",
          modal: true, 
          autoOpen: false,
          resizable: false,
          height:500,
          width:475,
          open:function() {
            //$("#EditSupportRecord").show();
          },
          close:function() {
            App.Activity.Stats.recalc();
            updateSupporters();
          },
          buttons: { 
            Continue:function() {
              $form.submit();
            }, 
            Cancel:function() {
              $(this).dialog("close");
            }
          }
        });

        $form.submit(function() {
          $(this).ajaxSubmit({ 
            target:        '',
            dataType:'json',
            success: function(data) {
              if(data.STATUS) {
                $editDialog.dialog("close");
              } else {
                addError(statusMsg,250,2500,2500);
              }
            },
            url: sRootPath + '/_com/AJAX_Activity.cfc'
          }); 
          return false; 
        });
        

        var defaultVal = null

        if(supporter.id) {
          defaultVal = {
            "label":supporter.name,
            "value":supporter.id,
            "image":"/supporter.png"
          }
        }
        $supporterInput.uiTypeahead({
          showImage: false,
          watermarkText: "Supporter Name",
          ajaxAddURL: "/admin/_com/AJAX_System.cfc",
          ajaxAddParams: {
            method: "saveSupporter",
            returnformat: "plain"
          },
          ajaxSearchURL: "/admin/_com/ajax/typeahead.cfc",
          ajaxSearchParams: {
            method: "search",
            type: "supporters"
          },
          defaultValue: defaultVal
        });


        $editDialog.html($html)
        $editDialog.dialog("open");

        cb(data);
      }
    });
  }
  //END EDIT DIALOG

  function deleteSupport(supportId) {
    $.ajax({
      url:sRootPath + "/_com/AJAX_Activity.cfc",
      type:'post',
      dataType:'json',
      data: { 
        method: "deleteSupport", 
        SupportID: supportId, 
        ActivityID: nActivity, 
        returnFormat: "plain" 
      },
      success: function(data) {
        if(data.STATUS) {
          // if(nTotalSupportCount != 1) {
          //   nTotalSupportCount = nTotalSupportCount - 1;
          // } else {
          //   nTotalSupportCount = "0";
          // }
          
          // // GET TOTAL AMOUNT AND FORMAT NUMBER
          // nTotalSupportAmount = nTotalSupportAmount - aSupporters[nId];
          // TempSupportAmount = $.DollarFormat(nTotalSupportAmount);
          
          // UPDATE TOTAL ENTRIES AND TOTAL AMOUNT
          // $("#TotalSupportCount").html(nTotalSupportCount);
          // $("#TotalSupportAmount").html(TempSupportAmount);
          // $("#SupporterRow" + nId).hide();
          App.Activity.Stats.recalc();
          updateSupporters();
        } else {
          addError(data.STATUSMSG,250,6000,4000);
        }
      }
    });
  }

  $(".js-add-support").on("click",function() {
    getEditForm(0,function(markup) {
    
    });
  });

  //MAIN LOOP
  $(".SupporterRow").each(function() {
    var $row = $(this);
    var supportId = $row.data('key');
    var amount = $row.data('amount');
    var $editLink = $row.find('.EditCurrSupport');
    var $deleteLink = $row.find('.DeleteSupport');
    
    $editLink.on("click", function() {
      getEditForm(supportId,function(markup) {
      
      });
    });

    $deleteLink.on("click", function() {
      if(confirm('Are you sure you would like to delete this support?')) {
        deleteSupport(supportId)
      }
    });
  });
  // END MAIN LOOP
});
</script>

<cfoutput>
<div class="ViewContainer">
<div class="ViewSection">
<div class="ContentBody">
<table class="ViewSectionGrid finance-table DataGrid table table-condensed table-bordered mbs">
  <thead>
    <tr>
      <th class="finance-support-col-name">Name</th>
      <th class="finance-support-col-startdate">Type</th>
      <th class="finance-support-col-enddate">Amount</th>
      <th class="finance-support-col-options"><a href="javascript:void(0);" id="SupporterDialog" class="btn btn-small js-add-support" data-tooltip-title="Add Support"><i class="icon-plus"></i></a></th>
    </tr>
  </thead>
  <tbody>
  <cfloop query="qActivitySupportersList">
    <tr class="SupporterRow finance-table-row finance-support-row" data-key="#qActivitySupportersList.SupportID#" data-amount="#qActivitySupportersList.Amount#" id="SupporterRow#qActivitySupportersList.SupportID#">
      <td>
        #qActivitySupportersList.SupporterName#
      </td>
      <td>
        #qActivitySupportersList.SupportTypeName#
      </td>
      <td>
        #LSCurrencyFormat(qActivitySupportersList.Amount)#</td>
      <td>
        <div class="btn-group">
          <a class="btn btn-small EditCurrSupport" data-tooltip-title="Edit"><i class="icon-pencil"></i></a>
          <a class="btn btn-small DeleteSupport" data-tooltip-title="Delete"><i class="icon-trash"></i></a>
        </div>
      </td>
    </tr>
  </cfloop>
    <tr>
      <td><strong>Total Entries:</strong> <span id="TotalSupportCount">#qActivitySupportersList.RecordCount#</span></td>
      <td style="text-align:right;"><strong>Total:</strong></td>
      <td style="text-align:right;"><span id="TotalSupportAmount">#LSCurrencyFormat(Attributes.TotalAmount)#</span></td>
      <td>&nbsp;</td>
    </tr>
  </tbody>
</table>
</div>
</div>
</div>
</cfoutput>
<div id="EditSupporterContainer" style="display:none;">
  
</div>
<div id="EditSupportRecord" style="display:none;">
  
</div>
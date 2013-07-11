<cfparam name="Attributes.EntryDate" default="#DateFormat(Now(),'MM/DD/YYYY')#">
<cfparam name="Attributes.EntryType" default="">
<cfparam name="Attributes.LedgerDescription" default="">
<cfparam name="Attributes.Memo" default="">
<cfparam name="Attributes.Amount" default="">
<cfparam name="Attributes.TotalAmount" default="0">

<script>
  <cfoutput>
  var nId = #Attributes.LedgerID#;
  </cfoutput>
  $("#date3").mask("99/99/9999");
  
  function saveLedger() {var nError = 0;
    var dtEntryDate = $("#date3").val();
    var sLedgerDescription = $("#LedgerDescription").val();
    var sMemo = $("#Memo").val();
    var nEntryType = $("#EntryType").val();
    var nAmount = $("#Amount").val();
    
    if(!($.IsDate(dtEntryDate))) {
      addError("You must enter an Entry Date.",250,6000,4000);
      nError = nError + 1;
    }
    
    if(sLedgerDescription == "") {
      addError("You must enter a Description.",250,6000,4000);
      nError = nError + 1;
    }
    
    if(nEntryType == "") {
      addError("You must select an Entry Type.",250,6000,4000);
      nError = nError + 1;
    }
    
    if(nAmount == "" || nAmount == 0) {
      addError("You must enter an Amount.",250,6000,4000);
      nError = nError + 1;
    }
    
    if(nError > 0) {
      return false;
    }
  
    //$.blockUI( '<h1>Saving Ledger Entry...</h1>' );
    $.getJSON(sRootPath + "/_com/AJAX_Activity.cfc",
      { method: "saveLedger", EntryID: nId, ActivityID: nActivity, EntryDate: dtEntryDate, Description: sLedgerDescription, Memo: sMemo, EntryType: nEntryType, Amount: nAmount, returnFormat: "plain" },
        function(data) {
          if(data.STATUS) {
            //updateActions();
            //$.unblockUI();
            addMessage(data.STATUSMSG,250,6000,4000);
            updateLedger(nId);
          } else {
            addError(data.STATUSMSG,250,6000,4000);
            //$.unblockUI();
          }
        
    });
  }
  
$(document).ready(function() {
  $("#date3").focus();
  
  $("#LedgerInput td input,#LedgerInput td select").keyup(function(e) {
    if(e.keyCode == 13) {
      saveLedger();
    }
  });
  
  $("#Amount").keyup(function() {
    if($(this).val() > 0) {
      $("#AmountImg")
        .addClass('icon-arrow-up')
        .removeClass('icon-arrow-down icon-circle')
        .css({
          'color':'green'
        });
    } else if($(this).val() < 0) {
      $("#AmountImg")
        .addClass('icon-arrow-down')
        .removeClass('icon-arrow-up icon-circle')
        .css({
          'color':'red'
        });
    } else {
      $("#AmountImg")
      .addClass('icon-circle')
      .removeClass('icon-arrow-up icon-arrow-down')
      .css({
        'color':'gray'
      });
    }
  });
  
  <!--- Delete Method for the ledgers --->
  $(".DeleteLedger").bind("click", this, function() {
    nId = this.id;
    
    if(confirm('Are you sure you would like to delete this ledger entry?')) {
      //$.blockUI( '<h1>Deleting Ledger Entry...</h1>' );
      $.getJSON(sRootPath + "/_com/AJAX_Activity.cfc", { method: "deleteLedger", EntryID: nId, ActivityID: nActivity, returnFormat: "plain" },
        function(data) {
          if(data.STATUS) {
            $("#LedgerRow" + nId).hide();
            //updateActions();
            updateLedger(nId);
          } else {
            addError(data.STATUSMSG,250,6000,4000);
          }
          
          //$.unblockUI();
      });
    }
  });
  
  $("#SaveLedger").bind("click", this, function() {
    saveLedger();
  });
});
</script>

<style>
//tr.LedgerRow td { font-size:11px!important; }
</style>

<cfoutput>
<div class="ViewContainer">
<div class="ViewSection">
  <div class="ContentBody">
    <table class="ViewSectionGrid finance-table DataGrid table table-condensed table-bordered mbs">
      <thead>
        <tr>
          <th><a href="javascript:void(0);">Date</a></th>
          <th><a href="javascript:void(0);">Description</a></th>
          <th><a href="javascript:void(0);">Memo</a></th>
          <th><a href="javascript:void(0);">Type</a></th>
          <th><a href="javascript:void(0);">Amount</a></th>
          <th><a href="javascript:void(0);">&nbsp;</a></th>
          <th><a href="javascript:void(0);">&nbsp;</a></th>
        </tr>
      </thead>
      <tbody>
        <input type="hidden" name="LedgerID" id="LedgerID" value="#Attributes.LedgerID#" />
        <tr id="LedgerInput" class="finance-table-input finance-ledger-input">
            <td>
              <input name="EntryDate" class="ledger-date-input" type="text" id="date3" value="#Attributes.EntryDate#">
            </td>
            <td>
              <input name="LedgerDescription" class="ledger-desc-input" type="text" id="LedgerDescription" value="#Attributes.LedgerDescription#">
            </td>
            <td>
              <input name="Memo" class="ledger-memo-input" type="text" id="Memo" value="#Attributes.Memo#">
            </td>
            <td>
              <select name="EntryType" class="ledger-type-input" id="EntryType">
                  <option value="">Select one...</option>
                  <cfloop query="qEntryTypeList">
                      <option value="#qEntryTypeList.EntryTypeID#"<cfif Attributes.EntryType EQ qEntryTypeList.EntryTypeID> SELECTED</cfif>>#qEntryTypeList.Name#</option>
                  </cfloop>
              </select>
            </td>
            <td>
              <input name="Amount" class="ledger-amount-input finance-input-amount" type="text" id="Amount" value="#Attributes.Amount#">
            </td>
            <td>
              <i class="icon-circle" id="AmountImg"></i>
            </td>
            <td>
              <a href="javascript://" class="btn btn-default btn-small" id="SaveLedger">
                <i class="icon-plus"></i>
              </a>
            </td>
        </tr>
        <cfloop query="qFinLedgerList">
          <cfset Attributes.TotalAmount = Attributes.TotalAmount + qFinLedgerList.Amount>

          <tr class="LedgerRow finance-table-row" id="LedgerRow#qFinLedgerList.EntryID#">
            <td style="vertical-align:middle;text-align:center;">#DateFormat(qFinLedgerList.EntryDate,"MM/DD/YYYY")#</td>
            <td style="vertical-align:middle;text-align:center;">#qFinLedgerList.Description#</td>
            <td style="vertical-align:middle;text-align:center;">#qFinLedgerList.Memo#</td>
            <td style="vertical-align:middle;text-align:center;">#qFinLedgerList.EntryTypeName#</td>
            <td style="vertical-align:middle;text-align:right;color:<cfif qFinLedgerList.Amount GT 0>GREEN<cfelse>BLACK</cfif>;">#LSCurrencyFormat(qFinLedgerList.Amount)#</td>
            <td style="vertical-align:middle;text-align:center;"><cfif qFinLedgerList.Amount GT 0><i class="icon-arrow-up" style="color:green;"></i><cfelse><i class="icon-arrow-down" style="color:red;"></i></cfif></td>
            <td style="vertical-align:middle;text-align:center;"><a class="DeleteLedger btn btn-small" id="#qFinLedgerList.EntryID#" data-tooltip-title="Delete Entry"><i class="icon-trash"></i></a></td>
          </tr>
        </cfloop>
        <tr>
          <td colspan="3"><strong>Total Entries:</strong> #qFinLedgerList.RecordCount#</td>
          <td style="text-align:right;"><strong>Total:</strong></td>
          <td style="text-align:right;color:<cfif Attributes.TotalAmount GT 0>GREEN<cfelse>BLACK</cfif>;">#LSCurrencyFormat(Attributes.TotalAmount)#</td>
          <td><cfif Attributes.TotalAmount GT 0><i class="icon-arrow-up" style="color:green;"></i><cfelse><i class="icon-arrow-down" style="color:red;"></i></cfif></td>
          <td>&nbsp;</td>
        </tr>
      </tbody>
    </table>
  </div>
</div>
</div>
</cfoutput>
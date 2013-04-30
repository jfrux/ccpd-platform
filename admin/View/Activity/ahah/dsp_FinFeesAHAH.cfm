<cfparam name="Attributes.Name" default="">
<cfparam name="Attributes.FeeStartDate" default="">
<cfparam name="Attributes.FeeStartTime" default="">
<cfparam name="Attributes.FeeEndDate" default="">
<cfparam name="Attributes.FeeEndTime" default="">
<cfparam name="Attributes.Amount" default="">
<cfparam name="Attributes.TotalAmount" default="0">
<script>
  var nId = 0;
  
  function saveFee() {
    var nFee = $("#FeeID").val();
    var sName = $("#Name").val();
    var dtStartDate = $("#FeeStartDate").val();
    var dtEndDate = $("#FeeEndDate").val();
    var dtStartTime = $("#FeeStartTime").val();
    var dtEndTime = $("#FeeEndTime").val();
    var nAmount = $("#Amount").val();
    
    var params = { 
      method: "saveFee", 
      ActivityID: nActivity, 
      Name: $("#Name").val(), 
      StartDate: dtStartDate, 
      EndDate: dtEndDate, 
      StartTime: dtStartTime, 
      EndTime: dtEndTime, 
      Amount: nAmount, 
      returnFormat: "plain"
    }

    if(!!nFee) {
      params.feeid = nFee
    }

    $.ajax({
      url:sRootPath + "/_com/AJAX_Activity.cfc",
      type:'post',
      dataType:'json',
      data: params,
      success: function(data) {
        console.log(data);
        if(data.STATUS) {
          updateFees();
          addMessage(data.STATUSMSG,250,3000,3000);
        } else {
          addError(data.STATUSMSG,250,6000,4000);
        }
      }
    });
  }
  
  $(document).ready(function() {
    $("#FeeStartDate").mask("99/99/9999");
    $("#FeeStartTime").mask("99:99 aa");
    $("#FeeEndDate").mask("99/99/9999");
    $("#FeeEndTime").mask("99:99 aa");

    $("#FeeInput td input,#FeeInput td select").keyup(function(e) { 
      if(e.keyCode == 13) {
        saveFee();
      }
    });
    
    <!--- ADD METHOD FOR FEES --->
    $("#SubmitFee").bind("click", this, function() {
      saveFee();
    });
      
    <!--- CANCEL EDIT OF FEE --->
    $(".CancelEdit").bind("click", this, function() {
      updateFees();
    });
    
    <!--- EDIT METHOD FOR FEE --->
    $(".EditFee").bind("click", this, function() {
      updateFees(this.id);
    });
    
    <!--- DELETED METHOD FOR FEE --->
    $(".DeleteFee").bind("click", this, function() {
      nId = this.id;
      
      if(confirm('Are you sure you would like to delete this fee?')) {
        $.ajax({
          url:sRootPath + "/_com/AJAX_Activity.cfc",
          type:'post',
          dataType:'json',
          data: { 
            method: "deleteFee", 
            FeeID: nId, 
            ActivityID: nActivity, 
            returnFormat: "plain" 
          },
          success: function(data) {
            console.log(data);
            if(data.STATUS) {
              $("#FeeRow" + nId).hide();
              updateFees();
              addMessage(data.STATUSMSG,250,3000,3000);
            } else {
              addError(data.STATUSMSG,250,6000,4000);
            }
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
    <table class="ViewSectionGrid finance-table DataGrid table table-condensed table-bordered mbs">
      <thead>
        <tr>
          <th class="finance-fee-col-name"><a href="javascript:void(0);">Name</a></th>
          <th class="finance-fee-col-startdate"><a href="javascript:void(0);">Start Date/Time</a></th>
          <th class="finance-fee-col-enddate"><a href="javascript:void(0);">End Date/Time</a></th>
          <th class="finance-fee-col-amount"><a href="javascript:void(0);">Amount</a></th>
          <th class="finance-fee-col-options"><a href="javascript:void(0);">&nbsp;</a></th>
        </tr>
      </thead>
      <tbody>
          <input type="hidden" name="FeeID" id="FeeID" value="#Attributes.FeeID#" />
          <tr id="FeeInput" class="finance-table-input finance-fee-input">
            <td><input type="text" name="Name" id="Name" tabindex="1" value="#Attributes.Name#" placeholder="Fee Name"></td>
            <td class="finance-input-datetime">
                <input type="text" name="FeeStartDate" id="FeeStartDate" value="#Attributes.FeeStartDate#" placeholder="Start Date" tabindex="2" />
                <input type="text" name="FeeStartTime" id="FeeStartTime" class="TimePicker" tabindex="3" value="#Attributes.FeeStartTime#" placeholder="Time" />
            </td>
            <td class="finance-input-datetime">
                <input type="text" name="FeeEndDate" id="FeeEndDate" value="#Attributes.FeeEndDate#" tabindex="4" placeholder="End Date" />
                <input type="text" name="FeeEndTime" id="FeeEndTime" class="TimePicker" value="#Attributes.FeeEndTime#" tabindex="4" placeholder="Time" />
            </td>
            <td>
              <input name="Amount" class="finance-fee-amount finance-input-amount" type="text"  id="Amount" value="#Attributes.Amount#" placeholder="Amount" tabindex="5">
            </td>
            <td>
              <div class="btn-group">
              <cfif isNumeric(Attributes.FeeID)>
                <a href="javascript://" id="SubmitFee" class="SubmitFee btn btn-small"><i class="icon-ok-circle"></i></a>
                <a href="javascript://" id="CancelEdit" class="CancelEdit btn btn-small"><i class="icon-remove-circle"></i></a>
              <cfelse>
                <a href="javascript://" class="btn btn-small" id="SubmitFee" class="SubmitFee"><i class="icon-plus"></i></a>
              </cfif>
              </div>
            </td>
          </tr>
        <cfloop query="qFinFeeList">
          <cfset Attributes.TotalAmount = Attributes.TotalAmount + qFinFeeList.Amount>
          <tr class="FeeRow finance-table-row finance-fee-row" data-key="#qFinFeeList.FeeID#" id="FeeRow#qFinFeeList.FeeID#">
            <td>
              <cfset maxLengthName = 15>
              <cfif len(trim(qFinFeeList.name)) GT maxLengthName>
                <span data-tooltip-title="#qFinFeeList.Name#">#midLimit(qFinFeeList.Name,maxLengthName-3)#
              <cfelse>
                <span>#qFinFeeList.Name#</span>
              </cfif>
            </td>
            <td>#DateFormat(qFinFeeList.StartDate,"MM/DD/YYYY")# #TimeFormat(qFinFeeList.StartDate,"h:mmTT")#</td>
            <td>#DateFormat(qFinFeeList.EndDate,"MM/DD/YYYY")# #TimeFormat(qFinFeeList.EndDate,"h:mmTT")#</td>
            <td class="finance-table-row-amount">#LSCurrencyFormat(qFinFeeList.Amount)#</td>
            <td>
              <div class="btn-group">
                <a class="btn btn-small EditFee" data-tooltip-title="Edit">
                  <i class="icon-pencil"></i>
                </a>
                <a class="btn btn-small DeleteFee" data-tooltip-title="Delete">
                  <i class="icon-trash"></i>
                </a>
              </div>
            </td>
          </tr>
        </cfloop>
        <tr>
          <td colspan="2"><strong>Total Entries:</strong> #qFinFeeList.RecordCount#</td>
          <td style="text-align:right;"><strong>Total:</strong></td>
          <td style="text-align:right;">#LSCurrencyFormat(Attributes.TotalAmount)#</td>
          <td>&nbsp;</td>
        </tr>
      </tbody>
    </table>
    <div class="alert alert-info">
    Note: Fees only apply during the time period you provide.
    </div>
  </div>
</div>
</div>
</cfoutput>
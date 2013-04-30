<cfparam name="Attributes.Supporter" default="">
<cfparam name="Attributes.SupportType" default="">
<cfparam name="Attributes.Amount" default="0">
<cfparam name="Attributes.ContractNum" default="">
<cfparam name="Attributes.BudgetRequested" default="">
<cfparam name="Attributes.BudgetDueDate" default="">
<cfparam name="Attributes.BudgetSent" default="">
<cfparam name="Attributes.DateSent" default="">
<cfparam name="Attributes.FundsReturned" default="">

<script>
<cfoutput>
// var nActivity = #Attributes.ActivityID#;
// var nSupport = #Attributes.SupportID#;
// var nCurrSupporter = 0;
</cfoutput>
	
</script>
<cfoutput>

<div id="EditSupportRecord">
	<form name="formEditCurrSupport" class="form-horizontal" id="formEditCurrSupport" method="post">
		<input type="hidden" name="default_data" class="js-default-data" value='#serializeJson(attributes)#' />
		<input type="hidden" name="default_supporter" class="js-default-supporter" value='#serializeJson(attributes.supporter)#' />
    <input type="hidden" name="Method" value="saveSupport" />
    <input type="hidden" name="returnformat" value="plain" />
    <input type="hidden" name="ActivityID" value="#Attributes.ActivityID#" />
    <input type="hidden" name="SupportID" value="#Attributes.SupportID#" />
    <input type="hidden" name="Submitted" value="1" />

    <div class="control-group">
			<label class="control-label" for="Title">Supporter</label>
			<div class="controls">
				<input class="js-supporter-typeahead" type="text" name="Supporter" id="Supporter" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="">Support Type</label>
			<div class="controls">
				<select name="SupportType" id="SupportType">
					<option value="">Select one...</option>
					<cfloop query="qSupportTypeList">
						<option value="#qSupportTypeList.ContribTypeID#"<cfif Attributes.SupportType EQ qSupportTypeList.ContribTypeID> SELECTED</cfif>>#qSupportTypeList.Name#</option>
					</cfloop>
				</select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="">Amount</label>
			<div class="controls">
				<div class="input-prepend">
					<span class="add-on">$</span>
					<input type="text" name="Amount" id="Amount" class="input-small" value="#NumberFormat(Attributes.Amount,'0.00')#" /></td>
				</div>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="">Contract ##</label>
			<div class="controls">
				<input type="text" name="ContractNum" id="ContractNum" value="#Attributes.ContractNum#" /></td>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="">Budget requested</label>
			<div class="controls">
				<input type="radio" name="BudgetRequested" class="BudgetRequested" value="Y"<cfif Attributes.BudgetRequested EQ 'Y'> CHECKED</cfif> /> Yes <input type="radio" name="BudgetRequested" class="BudgetRequested" value="N"<cfif Attributes.BudgetRequested EQ 'N'> CHECKED</cfif> /> No</td>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="">Due day of budget</label>
			<div class="controls">
				<input type="text" name="BudgetDueDate" id="date1" value="#Attributes.BudgetDueDate#" /></td>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="">Budget sent</label>
			<div class="controls">
				<input type="text" name="BudgetSent" id="date2" value="#Attributes.BudgetSent#" /></td>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="">Date sent</label>
			<div class="controls">
				<input type="text" name="DateSent" id="date3" value="#Attributes.DateSent#" /></td>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="">Funds returned</label>
			<div class="controls">
				<input type="text" name="FundsReturned" id="FundsReturned" value="#Attributes.FundsReturned#" /></td>
			</div>
		</div>
	</form>
</div>
</cfoutput>
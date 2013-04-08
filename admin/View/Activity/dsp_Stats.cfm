<script>
//App.Activity.Stats.start()
</script>

<cfoutput>
<div id="stats-container">
	<div class="row-fluid">
		<table width="100%" class="mtm table table-condensed" cellspacing="0" cellpadding="0" border="0">
			<tr>
				<td class="span12 no-border-top text-right">Partic. Records</td>
				<td class="span12 no-border-top">#ActivityBean.getStatAttendees()#</td>
			</tr>
			<tr>
				<td nowrap="nowrap" class="text-right">Physician</td>
				<td>#ActivityBean.getStatMD()#</td>
			</tr>
			<tr>
				<td nowrap="nowrap" class="text-right">Non-Physician</td>
				<td>#ActivityBean.getStatNonMD()#
				</td>
			</tr>
			<tr class="stat_addlattendees">
				<td nowrap="nowrap" class="text-right">Additional Partic.</td>
				<td>#ActivityBean.getStatAddlAttendees()#
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" class="text-right">Supporter</td>
				<td>#ActivityBean.getStatSupporters()#</td>
			</tr>
			<tr>
				<td nowrap="nowrap" class="text-right">Support Dollar</td>
				<td>#LSCurrencyFormat(ActivityBean.getStatSuppAmount())#</td>
			</tr>
		</table>
	</div>
</div>
<div id="stats-loading" style="display:none;"><img src="/admin/_images/ajax-loader.gif"/></div>
</cfoutput>
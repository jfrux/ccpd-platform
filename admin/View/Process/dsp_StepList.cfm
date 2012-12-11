<cfoutput>
<div class="ViewSection">
	<h3>Queue List</h3>
	<p>
		<table width="100%" cellspacing="0" cellpadding="0" border="0" class="ViewSectionGrid">
			<tbody>
				<cfloop query="qStepList">
				<tr class="StepItem" id="StepItem#qStepList.StepID#">
					<td valign="top"><h4>#qStepList.CurrentRow#.</h4></td>
					<td valign="top" width="75%">
						<h4><a href="#myself#Process.StepDetail&StepID=#qStepList.StepID#">#qStepList.Name#</a></h4>
						<p>
							#qStepList.Description#
						</p>
					</td>
					<td valign="top" width="25%">
						<div class="ViewSectionGrid_Links">
							<a href="#myself#Process.StepEdit&StepID=#qStepList.StepID#">Edit</a>
						</div>
					</td>
				</tr>
				</cfloop>
			</tbody>
		</table>
	</p>
</div>
</cfoutput>
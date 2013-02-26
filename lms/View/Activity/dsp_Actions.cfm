<div class="ViewSection">
	<h3>History</h3>
	<cfif isDefined("qAllActions") AND qAllActions.RecordCount GT 0 >
	<cfif ActionPager.getTotalNumberOfPages() GT 1><div><cfoutput>#ActionPager.getRenderedHTML()#</cfoutput></div></cfif>
	<table border="0" width="100%" cellpadding="0" cellspacing="0" class="ViewSectionGrid">
		<tbody>
			<cfoutput query="qAllActions" startrow="#ActionPager.getStartRow()#" maxrows="#ActionPager.getMaxRows()#">
				<tr>
					<td width="16" valign="top" style="text-align:right;padding-top:5px;"><img src="#Application.Settings.RootPath#/_images/icons/Action#Trim(Code)#.png" border="0" /></td>
					<td valign="top"><a href="#myself#Person.Detail?PersonID=#CreatedBy#" title="#FirstName# #LastName#">#FirstName# #LastName#</a> #LongName#
						 <span style="color:##555;font-size:11px;">#DateFormat(Created,"mm/dd/yy")# #TimeFormat(Created,"hh:mmTT")#</span>
					</td>
				</tr>
			</cfoutput>
		</tbody>
	</table>
	<cfif ActionPager.getTotalNumberOfPages() GT 1><div><cfoutput>#ActionPager.getRenderedHTML()#</cfoutput></div></cfif>
	<cfelse>
		No actions found.
	</cfif>
</div>

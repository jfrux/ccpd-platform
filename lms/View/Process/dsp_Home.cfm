<cfif isDefined("qProcessList") AND qProcessList.RecordCount GT 0>
<div class="ViewSection">
<h3>Process List (<cfoutput>#qProcessList.RecordCount#</cfoutput>)</h3>
<cfif ProcessPager.getTotalNumberOfPages() GT 1><div><cfoutput>#ProcessPager.getRenderedHTML()#</cfoutput></div></cfif>
<table border="0" width="100%" cellpadding="0" cellspacing="0" class="ViewSectionGrid">
	<tbody>
		<cfoutput query="qProcessList" startrow="#ProcessPager.getStartRow()#" maxrows="#ProcessPager.getMaxRows()#">
			<tr>
				<td style="height:40px;">
					<a href="#myself#Process.Detail&ProcessID=#ProcessID#">#Title#</a>
				</td>
				<td valign="top"></td>
			</tr>
		</cfoutput>
	</tbody>
</table>
<cfif ProcessPager.getTotalNumberOfPages() GT 1><div><cfoutput>#ProcessPager.getRenderedHTML()#</cfoutput></div></cfif>
</div>
<cfelse>
	No processes yet.  Click Create Process to begin.
</cfif>

<div class="ContentTitle"><cfoutput>#Request.Page.Title#</cfoutput></div>
<div class="ContentBody">
	<div class="clear"> 
	     <cfoutput>
	    	#jButton("Search Help Tickets","#myself#Admin.SearchHelpTickets","magifier_zoom_out.gif")# 
		</cfoutput>
	</div>
	<div class="DataGridTitle">
		<img src="#Application.Settings.RootPath#/_images/application_view_columns.gif" border="0" align="absmiddle" />  Search Results(<cfoutput>#HelpTicketsList.RecordCount#</cfoutput>)
	</div>
	<table border="1" cellpadding="0" cellspacing="0" class="DataGrid">
		<thead>
			<tr>
			
				<th nowrap="nowrap"><a href="javascript:void(0);">Ticket ID</a></th>	
				<th nowrap="nowrap"><a href="javascript:void(0);">Subject</a></th>	
				<th nowrap="nowrap"><a href="javascript:void(0);">Comments</a></th>	
				<th nowrap="nowrap"><a href="javascript:void(0);">Person ID</a></th>	
				<th nowrap="nowrap"><a href="javascript:void(0);">Created</a></th>	
				<th nowrap="nowrap"><a href="javascript:void(0);">Updated</a></th>	
				<th nowrap="nowrap"><a href="javascript:void(0);">Deleted</a></th>	
				<th nowrap="nowrap"><a href="javascript:void(0);">Deleted Flag</a></th>	
				<th nowrap="nowrap"><a href="javascript:void(0);">Actions</a></th>
			</tr>
		</thead>
		<tbody>
			<cfoutput query="HelpTicketsList">
				<tr>
					<td>#TicketID#</td>
					<td>#Subject#</td>
					<td>#Comments#</td>
					<td>#PersonID#</td>
					<td>#DateFormat(Created, "MM/DD/YYYY")# @ #TimeFormat(Created, "hh:mm:ss tt")#</td>
					<td>#Updated#</td>
					<td>#Deleted#</td>
					<td>#DeletedFlag#</td>
					<td nowrap="nowrap"><div class="DataGridButton"><a href="#myself#Admin.EditHelpTicket&HelpTicketID=#TicketID#"><img src="#Application.Settings.RootPath#/_images/comment_edit.gif" border="0" align="absmiddle" /> Edit</a></div></td>
				</tr>
			</cfoutput>
		</tbody>
	</table>
	<div class="clear"> 
	     <cfoutput>
	    	#jButton("Search Help Tickets","#myself#Admin.SearchHelpTickets","magifier_zoom_out.gif")# 
		</cfoutput>
	</div>
</div>
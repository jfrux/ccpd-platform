<cfparam name="Attributes.Subject" type="String" default="">
<cfparam name="Attributes.Body" type="String" default="">
<cfoutput>
<div class="clearfix headerTop">
<div class="action_bar" style="float:right;">
	<a class="btn supportLink" style="text-decoration: none; float: right;"><i style="background-position: -4px -361px;" class="img"></i>
	  <span>New Ticket</span>
	</a>
</div>
<div><h1>Help &amp; Support<span>Get help by communicating with us directly.</span></h1></div>
</div>
</cfoutput>
<style>
.home-group { 
-webkit-border-radius: 7px;
-moz-border-radius-bottomleft:7px;
-moz-border-radius-bottomright:7px;
-moz-border-radius-topleft:7px;
-moz-border-radius-topright:7px;
padding:1px;
}

.home-group h3 { 
-moz-border-radius-topleft:7px;
-moz-border-radius-topright:7px; margin:1px!important; }

.home-section { background-color:#EEE; border:1px solid #CCC; padding:8px; margin:4px;-webkit-border-radius: 7px;
-moz-border-radius-bottomleft:7px;
-moz-border-radius-bottomright:7px;
-moz-border-radius-topleft:7px;
-moz-border-radius-topright:7px; }
.home-section:hover { background-color:#F7F7F7; }

.home-section ul { margin-left:18px; margin-top:4px; }
.home-section li { list-style-type:circle; }
.home-section li a { padding:1px 1px; }
.home-section li a:hover {  }
.home-section li span { font-size:.95em; color:#555; font-style:italic; }

.home-section h4 { margin:0!important; padding:0!important; }
</style>

<style>
.tickets { border:1px solid #DDD; }
.tickets tr th { background-color:#000; color:#FFF; padding:3px; border-left:1px solid #CCC; }
.tickets tr td { padding:3px; border-bottom:1px solid #CCC; background-color:#F7F7F7; border-left:1px solid #DDD;
 }
</style>
<cfquery name="all_tickets" datasource="ccpd_support">
SELECT * FROM ost_ticket
WHERE email=<cfqueryparam value="#session.person.getEmail()#" cfsqltype="cf_sql_varchar" />
</cfquery>

<cfquery name="open_tickets" dbtype="query">
SELECT * FROM all_tickets
WHERE status = 'open'
</cfquery>

<cfquery name="closed_tickets" dbtype="query">
SELECT * FROM all_tickets
WHERE status = 'closed'
</cfquery>
<div class="ViewSection">
	<h3>Your Tickets</h3>
	<h4>Currently Open</h4>
	<cfoutput>
	<table width="500" cellspacing="0" cellpadding="0" border="0" class="tickets">
		<thead>
			<tr>
				<th></th>
				<th>Subject</th>
				<th>Topic</th>
				<th>Status</th>
				<th>Last Message</th>
				<th>Date Opened</th>
			</tr>
		</thead>
		<tbody>
		<cfloop query="open_tickets">
		<tr>
			<td><form action="http://ccpd.uc.edu/support/login.php" method="post" target="supportView" name="ticketFrm#open_tickets.ticketid#" id="ticketFrm#open_tickets.ticketid#"><input type="hidden" name="lemail" value="#session.person.getEmail()#" /><input type="hidden" name="lticket" value="#open_tickets.ticketid#" /><input type="submit" name="submit" value="###open_tickets.ticketid#" class="btn" /></form></td>
			<td>#open_tickets.subject#</td>
			<td>#open_tickets.helptopic#</td>
			<td>#open_tickets.status#</td>
			<td>#open_tickets.lastmessage#</td>
			<td>#open_tickets.created#</td>
		</tr>
		</cfloop>
		</tbody>
	</table>
	</cfoutput>
	
	<h4>Closed</h4>
	<table width="500" cellspacing="0" cellpadding="0" border="0" class="tickets">
		<thead>
			<tr>
				<th></th>
				<th>Subject</th>
				<th>Topic</th>
				<th>Status</th>
				<th>Last Message</th>
				<th>Date Opened</th>
			</tr>
		</thead>
		<tbody>
		<cfloop query="closed_tickets">
		<tr>
			<td><form action="http://ccpd.uc.edu/support/login.php" method="post" target="supportView" name="ticketFrm#closed_tickets.ticketid#" id="ticketFrm#closed_tickets.ticketid#"><input type="hidden" name="lemail" value="#session.person.getEmail()#" /><input type="hidden" name="lticket" value="#closed_tickets.ticketid#" /><input type="submit" name="submit" value="###closed_tickets.ticketid#" class="btn" /></form></td>
			<td>#closed_tickets.subject#</td>
			<td>#closed_tickets.helptopic#</td>
			<td>#closed_tickets.status#</td>
			<td>#closed_tickets.lastmessage#</td>
			<td>#closed_tickets.created#</td>
		</tr>
		</cfloop>
		</tbody>
	</table>
</div>

<!--- COMMENTS --->

<div class="ViewSection">
	<div class="home-group">
		<cfoutput>
		<h3>Your Tickets (#session.person.getEmail()#)</h3>
		<div class="home-section">
			
		</div>
		<div class="home-section">
			
		</div>
		</cfoutput>
	</div>
</div>

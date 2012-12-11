
<div class="ContentTitle">Search Results</div>
<div class="ContentBody">

<table border="1" cellpadding="2" cellspacing="0">
	<thead>
		<tr>
		
			<th>personid</th>
		
			<th>ssn</th>	
			
			<th>birthdate</th>	
					
			<th>firstname</th>	
		
			<th>middlename</th>	
		
			<th>lastname</th>	
		
			<th>namesuffix</th>	
			
			<th>Email1</th>	
			
			<th>UCID</th>	
			
			<th>Edit</th>
		</tr>
	</thead>
	<tbody>
		<cfoutput query="PersonResults">
			<cfif currentRow Mod 2>
				<cfset class="odd">
			<cfelse>
				<cfset class="even">
			</cfif>
			
			<tr class="#class#">
			
				<td>#personid#</td>
				
				<td>#ssn#</td>
				
				<td>#DateFormat(birthdate, "MMM DD, YYYY")#</td>
			
				<td>#firstname#</td>
			
				<td>#middlename#</td>
			
				<td>#lastname#</td>
			
				<td>#namesuffix#</td>
			
				<td>#Email1#</td>
				
				<td>#UCID#</td>
			
				<td><a href="#myself#Person.Edit&PersonID=#Personid#">Edit</a></td>
			</tr>
		</cfoutput>
	</tbody>
</table>
<cfoutput>
[<a href="#myself#Person.Create">Add New Person</a>]</cfoutput>
</div>
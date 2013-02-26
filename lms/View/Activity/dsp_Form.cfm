<cfoutput>
<cfparam name="Attributes.EventName" default="" />
<cfparam name="Attributes.EventDesc" default="" />
<script>
function ToggleIsAllDay( blnChecked ){
	var objTimesTable = document.getElementById( "eventtimes" );
	var arrInput = objTimesTable.getElementsByTagName( "input" );
	var intInput = 0;
	
	// Loop over inputs to toggle.
	for (intInput = 0 ; intInput < arrInput.length ; intInput++){
		
		arrInput[ intInput ].disabled = blnChecked;
	
	}
}
</script>
<cfparam name="Attributes.Mode" default="Month">
<form action="#myself#Activity.Event&ActivityID=#Attributes.ActivityID#&EventID=#Attributes.EventID#&ViewAs=#Attributes.ViewAs#&Mode=#Attributes.Mode#" method="post" name="frmEvent">
<div class="FormSection" id="Sect2">
		<h3>Event Details</h3>
		<!--- The action of the page (so that we submit back to ourselves). --->
		<input type="hidden" name="Mode" value="#Attributes.Mode#" />
		
		<!--- The flag that the form was submitted. --->
		<input type="hidden" name="submitted" value="1" />
		
		<!--- The ID of the event we are editing (if any). --->
		<input type="hidden" name="EventID" value="#Attributes.EventID#" />		
		
		<!--- The date on which this instance is being viewed. --->
		<input type="hidden" name="viewas" value="#Attributes.viewas#" />
	
	
		<table width="100%" cellspacing="0">
		<colActivity>
			<col />
			<col width="100%" />
		</colActivity>
		<tr>
			<td class="FieldLabel" valign="top">
				<label for="Name">Name</label></td>
			<td class="FieldInput">
				<input type="text" id="name" name="EventName" value="#Attributes.EventName#" maxlength="100" class="large" /><br />				
				
				<!--- 
					Check to see if we are editing an eixsting event that 
					has a repeat type. This only matters if we also have 
					the "viewas" date. If we don't have that, then we won't
					know what instance we are dealing with.
				--->
				<cfif (
					qEvent.RecordCount AND
					qEvent.repeat_type AND
					Attributes.viewas
					)>
				
					<div class="instancenote">
				
						<strong class="warning">
							Viewing Instance: #DateFormat( Attributes.viewas, "mmmm dd, yyyy" )#
						</strong>
					
						<br />Update:<br />
						
						<input 
							type="radio" 
							name="update_type" 
							value="1" 
							<cfif (attributes.update_type EQ 1)>checked="true"</cfif> 
							/>
						Entire Series<br />
						
						<input 
							type="radio" 
							name="update_type" 
							value="2" 
							<cfif (attributes.update_type EQ 2)>checked="true"</cfif> 
							onclick="this.form.elements.date_started.value = '#DateFormat( Attributes.viewas, "mm/dd/yyyy" )#'; alert( 'Date has been changed' );"
							/>
						All Future Instances<br />
						
						<input 
							type="radio" 
							name="update_type" 
							value="3" 
							<cfif (attributes.update_type EQ 3)>checked="true"</cfif> 
							onclick="this.form.elements.date_started.value = this.form.elements.date_ended.value = '#DateFormat( Attributes.viewas, "mm/dd/yyyy" )#';  alert( 'Date has been changed' );"
							/> 
						Just This Instance<br />
				
					</div>
					
				</cfif>
			</td>
		</tr>
		<tr>
			<td class="FieldLabel">
				<label for="date_started">
					Date
				</label>
			</td>
			<td class="FieldInput">
				
				<table cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<input 
							type="text" 
							id="date1" 
							name="date_started" 
							value="<cfif IsDate( attributes.date_started )>#DateFormat( attributes.date_started, "mm/dd/yyyy" )#</cfif>" 
							maxlength="10" 
							class="date"  style="width:90px;"
							/><br />
					</td>
					<td valign="top" rowspan="2">
						&nbsp;&nbsp;-to-&nbsp;&nbsp;<br />
					</td>
					<td>
						<input 
							type="text" 
							id="date2" 
							name="date_ended" 
							value="<cfif IsDate( attributes.date_ended )>#DateFormat( attributes.date_ended, "mm/dd/yyyy" )#</cfif>" 
							maxlength="10" 
							class="date" style="width:90px;"
							/><br />
					</td>
				</tr>
				<tr class="fieldnote">
					<td>
						From <em>(mm/dd/yyyy)</em><br />
					</td>
					<td>
						To <em>(mm/dd/yyyy)</em><br />
					</td>
				</tr>
				</table>
				
			</td>
		</tr>
		<tr>
			<td class="FieldLabel">
				<label for="time_started">
					Time
				</label></td>
			<td class="FieldInput">
				
				<label for="is_all_day">
					<input type="checkbox" id="is_all_day" name="is_all_day" value="1" 
						<cfif attributes.is_all_day>checked="true"</cfif>
						onclick="ToggleIsAllDay( this.checked );"
						/>
					
					This Is An All Day Event
				</label>
								
				<table id="eventtimes" cellspacing="0" cellpadding="0" style="margin-top: 10px ;">
				<tr>
					<td>
						<input 
							type="text" 
							id="time_started"  style="width:90px;"
							name="time_started" 
							value="<cfif IsDate( attributes.time_started )>#TimeFormat( attributes.time_started, "hh:mm TT" )#</cfif>" 
							maxlength="8" 
							class="time" 
							<cfif attributes.is_all_day>disabled="true"</cfif>
							/><br />
					</td>
					<td valign="top" rowspan="2">
						&nbsp;&nbsp;-to-&nbsp;&nbsp;<br />
					</td>
					<td>
						<input 
							type="text" 
							id="time_ended"  style="width:90px;"
							name="time_ended" 
							value="<cfif IsDate( attributes.time_ended )>#TimeFormat( attributes.time_ended, "hh:mm TT" )#</cfif>" 
							maxlength="8" 
							class="time" 
							<cfif attributes.is_all_day>disabled="true"</cfif>
							/><br />
					</td>
				</tr>
				<tr class="fieldnote">
					<td>
						From <em>(h:mm AM/PM)</em><br />
					</td>
					<td>
						To <em>(h:mm AM/PM)</em><br />
					</td>
				</tr>
				</table>
				
			</td>
		</tr>
		<tr>
			<td class="FieldLabel">
				<label for="repeat_type">
					Repeat	
				</label>
			</td>
			<td class="FieldInput">
				<select id="repeat_type" name="repeat_type">
					<option value="0">No repeat</option>
					
					<cfloop query="REQUEST.RepeatTypes">
						<option value="#REQUEST.RepeatTypes.id#"
							<cfif (attributes.repeat_type EQ REQUEST.RepeatTypes.id)>selected="true"</cfif>
							>#REQUEST.RepeatTypes.name#</option>			
					</cfloop>
				</select><br />
			</td>
		</tr>
		<tr>
			<td class="FieldLabel">
				<label for="color">
					Color	
				</label>
			</td>
			<td class="FieldInput">
				<select id="color" name="color">
					<option value="">No Color</option>
					<cfloop 
						index="intI"
						from="1"
						to="#ArrayLen( arrColors )#"
						step="1">
						<option value="#arrColors[ intI ]#" 
							style="background-color: ###arrColors[ intI ]#; color:###arrColors[ intI ]#;"
							<cfif (attributes.color EQ arrColors[ intI ])>selected="true"</cfif>
							>#arrColors[ intI ]#</option>			
					</cfloop>
				</select><br />
			</td>
		</tr>
		<tr>
			<td class="FieldLabel" valign="top">
				<label for="description">
					Description		
				</label>
			</td>
			<td class="FieldInput">
				<textarea name="EventDesc" id="EventDesc" class="description" style="width:250px;height:100px;">#attributes.EventDesc#</textarea><br />				
			</td>
		</tr>
		</table>
		
		
		</div>
			
	</form>
</cfoutput>
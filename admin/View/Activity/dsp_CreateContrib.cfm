<cfparam name="Attributes.ContributorID" default="0">
<cfparam name="Attributes.ContributorName" default="">
<cfparam name="Attributes.ContributorDescription" default="">
<cfparam name="Attributes.TypeID" default="0">
<cfparam name="Attributes.Amount" default="">

<script>
  $(document).ready(function(){
  	if( $(".ContributorID").val() == '') {
    	$(".NewContributor").show("slow");
  	} else {
    	$(".NewContributor").hide("slow");
    }
    
    $(".ContributorID").bind("change", this, function(e) {
    	if (this.value == '') {
    		$(".NewContributor").show("slow");
    	} else {
    		$(".NewContributor").hide("slow");
    	}
    });

  });
  </script>

<cfif IsDefined("Errors") AND Errors NEQ "">
	<div class="Errors">
		<cfset arrErrors = ListToArray(Errors,",")>
		<ul>
		<cfloop index="i" from="1" to="#arrayLen(arrErrors)#">
			<li><cfoutput>#arrErrors[i]#</cfoutput></li>
		</cfloop>
		</ul>
	</div>
</cfif>

<form action="<cfoutput>#myself#</cfoutput>Activity.CreateContrib&ActivityID=<cfoutput>#Attributes.ActivityID#</cfoutput>&Submitted=1" method="post" name="frmCreateContrib">
	<table width="486" cellspacing="2" cellpadding="3" border="0">
	<tr>
		<td colspan="2">
			<table border="0">
				<tr>
					<td>Contributor:</td>
					<td><select name="Contributor" class="ContributorID">
							<option value="0">Select One...</option>
							<option value=""<cfif Attributes.ContributorID EQ ""> Selected</cfif>>New Contributor...</option>
							<cfloop query="Application.List.Contributors">
								<option value="<cfoutput>#ContributorID#</cfoutput>"<cfif Attributes.ContributorID EQ ContributorID> Selected</cfif>><cfoutput>#Name#</cfoutput></option>
							</cfloop>
						</select>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr class="NewContributor" style="display:none;">
		<td>
			<table>
				<tr>
					<td colspan="2"><strong>New Contributor</strong></td>
				</tr>
				<tr>
					<td>Contributor:</td>
					<td><input type="text" name="ContributorName" id="ContributorName" value="<cfoutput>#Attributes.ContributorName#</cfoutput>" /></td>
				</tr>
				<tr>
					<td>Description:</td>
					<td><textarea name="ContributorDescription" id="ContributorDescription"><cfoutput>#Attributes.ContributorDescription#</cfoutput></textarea></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<table border="0">
				<tr>
					<td>Type:</td>
					<td width="23">&nbsp;</td>
					<td><select name="TypeID" id="TypeID">
							<option value="0">Select One...</option>
							<cfloop query="Application.List.ContribTypes">
								<option value="<cfoutput>#ContribTypeID#</cfoutput>"<cfif Attributes.TypeID EQ ContribTypeID> Selected</cfif>><cfoutput>#Name#</cfoutput></option>
							</cfloop>
						</select>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<table border="0">
				<tr>
					<td>Amount:</td>
					<td width="10"></td>
					<td><input type="text" name="Amount" id="Amount" value="<cfoutput>#Attributes.Amount#</cfoutput>" /></td>
				</tr>
			</table>
		</td>
		
	</tr>
</table>
<cfoutput>#jButton("Save","javascript:void(0);","accept.gif","SubmitForm(document.frmCreateContrib);")##jButton("Cancel","#myself#Activity.Contrib&ActivityID=#Attributes.ActivityID#","delete.gif")#		</cfoutput>
 	</form>
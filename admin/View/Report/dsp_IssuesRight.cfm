<div class="MultiFormRight_SectTitle">What can I do?</div>
<div class="MultiFormRight_SectBody">
	<cfoutput>
	<select name="Reason" style="width:170px;">
		<cfloop query="qReasons">
		<option value="#qReasons.Reason#">#qReasons.Reason#</option>
		</cfloop>
	</select>
	</cfoutput>
</div>
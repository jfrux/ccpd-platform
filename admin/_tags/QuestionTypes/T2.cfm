<cfparam name="Attributes.QuestionID" default="">
<cfparam name="Attributes.QuestionNumber" default="1">
<cfparam name="Attributes.QuestionLabel" default="Undefined Question Label">
<cfparam name="Attributes.QuestionDetails" default="">
<cfparam name="Attributes.DefaultValue" default="">

<cfoutput>
<table width="100%" cellspacing="0" cellpadding="0" border="0">
	<tr>
		<td><strong>#Attributes.QuestionLabel#</strong></td>
	</tr>
	<cfif Attributes.QuestionDetails NEQ "">
	<tr>
		<td>
			#Attributes.QuestionDetails#
		</td>
	</tr>
	</cfif>
	<tr>
		<td>
			<textarea name="#Attributes.QuestionID#" style="width:450px;height:85px;" onBlur="saveAnswer(this.name,this.value,'A');">#Attributes.DefaultValue#</textarea>
		</td>
	</tr>
</table>
</cfoutput>

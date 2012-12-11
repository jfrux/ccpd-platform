<cfparam name="Attributes.QuestionID" default="">
<cfparam name="Attributes.Step" default="1">
<cfparam name="Attributes.QuestionLabel" default="Undefined Question Label">
<cfparam name="Attributes.QuestionDetails" default="">
<cfparam name="Attributes.Answer1" default="5 - Strongly Agree">
<cfparam name="Attributes.Answer2" default="4 - Agree">
<cfparam name="Attributes.Answer3" default="3 - Neutral">
<cfparam name="Attributes.Answer4" default="2 - Disagree">
<cfparam name="Attributes.Answer5" default="1 - Strongly Disagree">
<cfparam name="Attributes.Answer6" default="">
<cfparam name="Attributes.Answer7" default="">
<cfparam name="Attributes.Answer8" default="">
<cfparam name="Attributes.Answer9" default="">
<cfparam name="Attributes.Answer10" default="">
<cfparam name="Attributes.AnswerOrder" default="A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P">
<cfparam name="Attributes.DefaultValue" default="">

<cfoutput>
<div class="Question">
	<h4>#Attributes.Step#.) #Attributes.QuestionLabel#</h4>
	<cfif Attributes.QuestionDetails NEQ "">
	<p>#Attributes.QuestionDetails#</p>
	</cfif>
	<div class="Answers">
	<cfloop from="1" to="10" index="i">
	<cfif Evaluate('Attributes.Answer#i#') NEQ "">
	<div><input onClick="saveAnswer(this.name,this.value,'#GetToken(Attributes.AnswerOrder,i,",")#');" class="AnswerField" type="Radio" name="#Attributes.QuestionID#" id="#Attributes.QuestionID##i#" value="#Evaluate('Attributes.Answer#i#')#"<cfif Attributes.DefaultValue EQ Evaluate('Attributes.Answer#i#')> checked</cfif> /><label for="#Attributes.QuestionID##i#">#Evaluate('Attributes.Answer#i#')#</label></div>
	</cfif>
	</cfloop>
	</div>
</div>
</cfoutput>

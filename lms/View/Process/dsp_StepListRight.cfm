<cfoutput>
<div class="MultiFormRight_SectTitle">What can I do?</div>
<div class="MultiFormRight_SectBody">
	<div class="clear"> 
		<cfoutput>
			#jButton("Create a queue","#myself#Process.StepCreate&ProcessID=#Attributes.ProcessID#","add")#
		</cfoutput>
	</div>
</div>
<div class="MultiFormRight_LinkList">
	<a href="#myself#Process.Edit&ProcessID=#Attributes.ProcessID#">Edit this process</a>
</div>
</cfoutput>
<cfoutput>
<div class="MultiFormRight_SectTitle">What can I do?</div>
<div class="MultiFormRight_LinkList">
</div>
<div class="MultiFormRight_SectBody">
	<div class="clear"> 
		<cfoutput>
			#jButton("Done","#myself#Activity.Event&ActivityID=#Attributes.ActivityID#&EventID=#Attributes.EventID#&ViewAs=#Attributes.Date#","accept.gif")#
		</cfoutput>
	</div>
</div>
</cfoutput>
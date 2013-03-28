<cfoutput>

<div class="MultiFormRight_SectTitle">What can I do?</div>
<div class="MultiFormRight_LinkList">
	<a href="#myself#Activity.Calendar&ActivityID=#Attributes.ActivityID#&Mode=Year&Date=#REQUEST.DefaultDate#" <cfif (Attributes.Mode EQ "Year")>class="MultiFormRight_LinkListOn"</cfif>>Year View</a>
	<a href="#myself#Activity.Calendar&ActivityID=#Attributes.ActivityID#&Mode=Month&Date=#REQUEST.DefaultDate#" <cfif (Attributes.Mode EQ "Month")>class="MultiFormRight_LinkListOn"</cfif>>Month View</a>
	<a href="#myself#Activity.Calendar&ActivityID=#Attributes.ActivityID#&Mode=Week&Date=#REQUEST.DefaultDate#" <cfif (Attributes.Mode EQ "Week")>class="MultiFormRight_LinkListOn"</cfif>>Week View</a>
	<a href="#myself#Activity.Calendar&ActivityID=#Attributes.ActivityID#&Mode=Day&Date=#REQUEST.DefaultDate#" <cfif (Attributes.Mode EQ "Day")>class="MultiFormRight_LinkListOn"</cfif>>Day View</a>
	<a href="#myself#Activity.Event&ActivityID=#Attributes.ActivityID#&Date=#REQUEST.DefaultDate#">Add New Event</a>
</div>
<div class="MultiFormRight_SectBody">
</div>
</cfoutput>
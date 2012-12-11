<cfoutput>
<link href="#Application.Settings.RootPath#/_styles/StepStatus.css" rel="stylesheet" type="text/css" />
<div class="ViewSection">
	<h3>#StepBean.getName()#</h3>
	<p>
		<h4>#ActivityBean.getTitle()#</h4>
		<div>#Attributes.Description#</div>
	</p>
</div>
</cfoutput>
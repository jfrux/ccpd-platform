<cfoutput>
<div class="MultiFormRight_LinkList">
	<a href="#myself#Activity.Finances?ActivityID=#Attributes.ActivityID#"<cfif Attributes.Fuseaction EQ "Activity.Finances"> id="MultiFormRight_CurrentLink"</cfif>><img src="#Application.Settings.RootPath#/_images/icons/chart_line.png" align="absmiddle" style="padding-right:4px;" />Overview</a>
	<a href="#myself#Activity.FinLedger?ActivityID=#Attributes.ActivityID#"<cfif Attributes.Fuseaction EQ "Activity.FinLedger"> id="MultiFormRight_CurrentLink"</cfif>><img src="#Application.Settings.RootPath#/_images/icons/money_dollar.png" align="absmiddle" style="padding-right:4px;" />General Ledger</a>
	<a href="#myself#Activity.FinBudget?ActivityID=#Attributes.ActivityID#"<cfif Attributes.Fuseaction EQ "Activity.FinBudget"> id="MultiFormRight_CurrentLink"</cfif>><img src="#Application.Settings.RootPath#/_images/icons/page_white_gear.png" align="absmiddle" style="padding-right:4px;" />Budget</a>
	<a href="#myself#Activity.FinSupport?ActivityID=#Attributes.ActivityID#"<cfif Attributes.Fuseaction EQ "Activity.FinSupport"> id="MultiFormRight_CurrentLink"</cfif>><img src="#Application.Settings.RootPath#/_images/icons/money.png" align="absmiddle" style="padding-right:4px;" />Supporters</a>
	<a href="#myself#Activity.FinFees?ActivityID=#Attributes.ActivityID#"<cfif Attributes.Fuseaction EQ "Activity.FinFees"> id="MultiFormRight_CurrentLink"</cfif>><img src="#Application.Settings.RootPath#/_images/icons/page_lightning.png" align="absmiddle" style="padding-right:4px;" />Fees</a>
</div>
</cfoutput>
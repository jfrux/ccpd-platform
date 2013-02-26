<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!-- Support -->
<circuit access="public">
	<prefuseaction callsuper="true">
		<set name="Request.NavItem" value="6" />
    </prefuseaction>
	<fuseaction name="Home">
        <if Condition="IsDefined('Attributes.FormSubmit')">
			<true>
				<set name="HelpTicketID" value="-1" />
				<do action="mSupport.Request" />
			</true>
			<false>
			</false>
		</if>
		<set name="Request.Page.Title" value="Support Home" />
		<set name="Request.Page.Breadcrumbs" value="Welcome|Main.Welcome,Support Home|Support.Home" />
        
		<do action="mPage.ParseCrumbs" />
		
		<xfa name="FrmRequestSupportSubmit" value="Support.Home" />
		<do action="vSupport.Home" contentvariable="Request.Page.Body" />
        
        <do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="Request">
		<set name="HelpTicketID" value="-1" />
		<do action="mSupport.Request" />
		
		<set name="Request.Page.Title" value="Request Support" />
        
		<set name="Request.Page.Breadcrumbs" value="Welcome|Main.Welcome,Request Support|Support.Request" />
        
		<do action="mPage.ParseCrumbs" />
		
		<xfa name="FrmSubmit" value="Support.Request" />
		<do action="vSupport.Request" contentvariable="Request.Page.Body" />
        
        <do action="vLayout.none" />
	</fuseaction>
		
</circuit>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!-- mMain -->
<circuit access="internal">
    
	<fuseaction name="Welcome">
		<include template="act_Welcome" />
	</fuseaction>
	
    <fuseaction name="doLogin">
		<include template="act_doLogin" />
	</fuseaction>
	
	<fuseaction name="doLogout">
		<include template="act_doLogout" />
	</fuseaction>
	
	<fuseaction name="doSearch">
		<include template="act_doSearch" />
	</fuseaction>
	
	<fuseaction name="TabControl">
		<include template="act_tabSetup" />
	</fuseaction>
	
</circuit>
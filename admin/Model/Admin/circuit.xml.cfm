<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!-- mAdmin -->
<circuit access="internal">
	<fuseaction name="getAdmins">
		<include template="act_getAdmins" />
	</fuseaction>
    
	<fuseaction name="getComments">
		<include template="act_getComments" />
	</fuseaction>
	
	<fuseaction name="sendMessage">
		<include template="act_sendMessage" />
	</fuseaction>
	
	<fuseaction name="HelpTicketsList">
		
	</fuseaction>
	
	<fuseaction name="saveEmailStyle">
		<include template="act_saveEmailStyle" />
	</fuseaction>
	
	<fuseaction name="getEmailStyle">
		<include template="act_getEmailStyle" />
	</fuseaction>
	
	<fuseaction name="saveHistoryStyle">
		<include template="act_saveHistoryStyle" />
	</fuseaction>
	
	<fuseaction name="getHistoryStyle">
		<include template="act_getHistoryStyle" />
	</fuseaction>	
	
	<fuseaction name="saveCertificate">
		<include template="act_saveCertificate" />
	</fuseaction>
	
	<fuseaction name="getCertificate">
		<include template="act_getCertificate" />
	</fuseaction>
</circuit>
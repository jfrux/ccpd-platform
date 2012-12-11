<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!-- Member Model -->
<circuit access="internal">
	<fuseaction name="Confirm">
    	<include template="act_Confirm" />
    </fuseaction>
	<fuseaction name="deleteEmail">
    	<include template="act_deleteEmail" />
    </fuseaction>
    
	<fuseaction name="getActivities">
    	<include template="act_getActivities" />
    </fuseaction>
    
	<fuseaction name="getCredits">
    	<include template="act_getCredits" />
    </fuseaction>
    
    <fuseaction name="getEmails">
    	<include template="act_getEmails" />
    </fuseaction>
    
	<fuseaction name="getPerson">
    	<include template="act_getPerson" />
    </fuseaction>
	
	<fuseaction name="getPrefs">
    	<include template="act_getPrefs" />
    </fuseaction>
    
	<fuseaction name="getTranscript">
    	<include template="act_getTranscript" />
    </fuseaction>
    
	<fuseaction name="primaryEmail">
    	<include template="act_primaryEmail" />
    </fuseaction>
	
	<fuseaction name="savePrefs">
    	<include template="act_savePrefs" />
    </fuseaction>
</circuit>

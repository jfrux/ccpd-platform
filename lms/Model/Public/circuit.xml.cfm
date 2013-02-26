<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!-- mMain -->
<circuit access="internal">
    
	<fuseaction name="getDetail">
		<include template="act_getDetail" />
	</fuseaction>
	
	<fuseaction name="getFileInfo">
		<include template="act_getFileInfo" />
	</fuseaction>
	
	<fuseaction name="getCertData">
		<include template="act_getCertData" />
	</fuseaction>
	
	<fuseaction name="getCertType">
		<include template="act_getCertType" />
	</fuseaction>
    
    <fuseaction name="RegLogin">
    	<include template="act_RegLogin" />
    </fuseaction>
	
	 <fuseaction name="doSignup">
    	<include template="act_doSignup" />
    </fuseaction>
    
    <fuseaction name="RegPayment">
    	<include template="act_RegPayment" />
    </fuseaction>
	
	<fuseaction name="LookupActivity">
    	<include template="act_LookupActivity" />
    </fuseaction>
</circuit>
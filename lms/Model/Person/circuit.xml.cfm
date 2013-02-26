<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!-- mPerson -->
<circuit access="internal">
	
	<fuseaction name="checkDuplicates">
		<include template="act_checkDuplicates" />
	</fuseaction>
    
	<fuseaction name="Create">
		<include template="act_Create" />
	</fuseaction>
	
	<fuseaction name="getAddress">
		<include template="act_getAddress" />
	</fuseaction>
	
	<fuseaction name="getAddresses">
		<include template="act_getAddresses" />
	</fuseaction>
	
	<fuseaction name="getCredentials">
		<include template="act_getCredentials" />
	</fuseaction>
	
	<fuseaction name="getEducation">
		<include template="act_getEducation" />
	</fuseaction>
	
	<fuseaction name="getEmails">
		<include template="act_getEmails" />
	</fuseaction>
	
	<fuseaction name="getPerson">
		<include template="act_getPerson" />
	</fuseaction>
	
	<fuseaction name="getActivities">
		<include template="act_getActivities" />
	</fuseaction>
	
	<fuseaction name="getAllActions">
		<include template="act_getAllActions" />
	</fuseaction>
	
	<fuseaction name="getActions">
		<include template="act_getActions" />
	</fuseaction>
	
	<fuseaction name="getDocs">
		<include template="act_getDocs" />
	</fuseaction>
	
	<fuseaction name="getNotes">
		<include template="act_getNotes" />
	</fuseaction>
	
	<fuseaction name="getPersonDegree">
		<include template="act_getPersonDegree" />
	</fuseaction>
	
	<fuseaction name="Search">
		<include template="act_Search" />
	</fuseaction>
	
	<fuseaction name="PhotoUpload">
		<include template="act_PhotoUpload" />
	</fuseaction>
	
	<fuseaction name="TabControl">
		<set name="Request.MultiFormQS" value="?PersonID=#Attributes.PersonID#" />
		<set name="Request.MultiFormLabels" value="General,Emails,Locations,Preferences,Activities,History" />
		<set name="Request.MultiFormFuseactions" value="person.detail,person.email,person.address,person.preferences,person.activities,person.history" />
	</fuseaction>
	
</circuit>

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!-- mProcess -->
<circuit access="internal">
	<fuseaction name="Save">
		<include template="act_Save" />
	</fuseaction>
	
	<fuseaction name="StepSave">
		<include template="act_StepSave" />
	</fuseaction>
	
	<fuseaction name="getDetail">
		<include template="act_getDetail" />
	</fuseaction>
	
	<fuseaction name="getProcesses">
		<include template="act_getProcesses" />
	</fuseaction>
	
	<fuseaction name="getStepList">
		<include template="act_getStepList" />
	</fuseaction>
	
	<fuseaction name="getStepActivities">
		<include template="act_getStepActivities" />
	</fuseaction>
	
	<fuseaction name="getStepDetail">
		<include template="act_getStepDetail" />
	</fuseaction>
	
	<fuseaction name="getStepActivityDetail">
		<include template="act_getStepActivityDetail" />
	</fuseaction>
	
	<fuseaction name="getManagers">
		<include template="act_getManagers" />
	</fuseaction>
	
	<fuseaction name="TabControl">
		<set name="Request.MultiFormQS" value="&amp;ProcessID=#Attributes.ProcessID#" />
		<set name="Request.MultiFormLabels" value="Queues,Managers" />
		<set name="Request.MultiFormFuseactions" value="Process.Detail,Process.Managers" />
	</fuseaction>
</circuit>
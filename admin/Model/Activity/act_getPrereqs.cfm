<cfparam name="Attributes.ActivityID" default="0" />

<cfset PrereqList = CreateObject("component", "#Application.Settings.Com#.ActivityPrereq.ActivityPrereqAJAX").Get(ActivityID=Attributes.ActivityID)>
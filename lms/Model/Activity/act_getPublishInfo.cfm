<cfparam name="Attributes.ActivityID" default="" />
<cfparam name="Attributes.StartDate" default="" />
<cfparam name="Attributes.EndDate" default="" />
<cfparam name="Attributes.Objectives" default="" />
<cfparam name="Attributes.TermsFlag" default="" />
<cfparam name="Attributes.PublishDate" default="" />
<cfparam name="Attributes.RemoveDate" default="" />
<cfparam name="PublishElementCount" default="0" />
<cfparam name="CompletedCount" default="0" />
<cfparam name="PublishElementList" default="" />

<!--- ELEMENTS ARE CHECKED IF THEY HAVE CONTENT.  IF THEY HAVE CONTENT, COMPLETEDCOUNT INCREASES BY ONE.  
	  AS ELEMENTS ARE CHECKED, PUBLISHELEMENTCOUNT INCREASES BY ONE TO COUNT ALL THE ELEMENTS NEEDED FOR 
	  PUBLISHING --->
<!--- START DATE --->
<cfset PublishElementList = [{
	Field = "Start Date",
	Image = "delete",
	Link = Myself & "Activity.Detail?activityId=" & Attributes.ActivityId,
	Show = true
},{
	Field = "End Date",
	Image = "delete",
	Link = Myself & "Activity.Detail?activityId=" & Attributes.ActivityId,
	Show = true
},{
	Field = "Activity Status",
	Image = "delete",
	Link = "javascript://",
	Show = true
},{
	Field = "Objectives",
	Image = "delete",
	Link = Myself & "Activity.PubGeneral?activityId=" & Attributes.ActivityId,
	Show = true
},{
	Field = "Terms",
	Image = "delete",
	Link = Myself & "Activity.PubGeneral?activityId=" & Attributes.ActivityId,
	Show = false
},{
	Field = "Publish Date",
	Image = "delete",
	Link = Myself & "Activity.PubGeneral?activityId=" & Attributes.ActivityId,
	Show = true
},{
	Field = "Remove Date",
	Image = "delete",
	Link = Myself & "Activity.PubGeneral?activityId=" & Attributes.ActivityId,
	Show = true
}] />

<cfif Len(Attributes.StartDate) GT 0>
	<!--- UPDATE STATS --->
	<cfset CompletedCount = CompletedCount + 1>
	<cfset PublishElementCount = PublishElementCount + 1>
	
	<!--- UPDATE ELEMENT LIST --->
	<cfset PublishElementList[1].image = "tick">
<cfelse>
	<cfset PublishElementCount = PublishElementCount + 1>
</cfif>

<!--- END DATE --->
<cfif Len(Attributes.EndDate) GT 0>
	<!--- UPDATE STATS --->
	<cfset CompletedCount = CompletedCount + 1>
	<cfset PublishElementCount = PublishElementCount + 1>
	
	<!--- UPDATE ELEMENT LIST --->
	<cfset PublishElementList[2].image = "tick">
<cfelse>
	<cfset PublishElementCount = PublishElementCount + 1>
</cfif>

<!--- ACTIVITY STATUS --->
<cfif Len(ActivityBean.getStatusID()) GT 0 AND ActivityBean.getStatusID() EQ "1">
	<!--- UPDATE STATS --->
	<cfset CompletedCount = CompletedCount + 1>
	<cfset PublishElementCount = PublishElementCount + 1>
	
	<!--- UPDATE ELEMENT LIST --->
	<cfset PublishElementList[3].image = "tick">
<cfelse>
	<cfset PublishElementCount = PublishElementCount + 1>
</cfif>

<!--- OBJECTIVES --->
<cfif Len(Attributes.Objectives) GT 0>
	<!--- UPDATE STATS --->
	<cfset CompletedCount = CompletedCount + 1>
	<cfset PublishElementCount = PublishElementCount + 1>
	
	<!--- UPDATE ELEMENT LIST --->
	<cfset PublishElementList[4].image = "tick">
<cfelse>
	<cfset PublishElementCount = PublishElementCount + 1>
</cfif>

<!--- PUBLISH TERMS --->
<cfif Len(Attributes.TermsFlag) GT 0 AND Attributes.TermsFlag EQ "Y">
	<cfset PublishElementList[5].Show = true>
	
	<cfif Len(Attributes.TermsText) GT 0>
	<!--- UPDATE STATS --->
		<cfset CompletedCount = CompletedCount + 1>
		<cfset PublishElementCount = PublishElementCount + 1>
		<cfset PublishElementList[5].image = "tick">
	<cfelse>
		<cfset PublishElementCount = PublishElementCount + 1>
	</cfif>
</cfif>

<!--- PUBLISH DATE --->
<cfif Len(Attributes.PublishDate) GT 0>
	<!--- UPDATE STATS --->
	<cfset CompletedCount = CompletedCount + 1>
	<cfset PublishElementCount = PublishElementCount + 1>
	
	<!--- UPDATE ELEMENT LIST --->
		<cfset PublishElementList[6].image = "tick">
<cfelse>
	<cfset PublishElementCount = PublishElementCount + 1>
</cfif>

<!--- REMOVE DATE --->
<cfif Len(Attributes.RemoveDate) GT 0>
	<!--- UPDATE STATS --->
	<cfset CompletedCount = CompletedCount + 1>
	<cfset PublishElementCount = PublishElementCount + 1>
	
	<!--- UPDATE ELEMENT LIST --->
		<cfset PublishElementList[7].image = "tick">
<cfelse>
	<cfset PublishElementCount = PublishElementCount + 1>
</cfif>
<!--- CALCULATE THE AMOUNT OF FILLER FOR PUBLISH BAR --->
<cfset FillPercentage = (CompletedCount / PublishElementCount) * 100>

<!--- GET FILL COLOR --->
<cfif FillPercentage EQ 100>
	<cfset FillColor = "391">
<cfelseif FillPercentage GTE 66>
	<cfset FillColor = "DD0">
<cfelseif FillPercentage GTE 34>
	<cfset FillColor = "FA3">
<cfelse>
	<cfset FillColor = "B23">
</cfif>
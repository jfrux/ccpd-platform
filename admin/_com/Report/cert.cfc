<cfcomponent displayname="certs">
	<cfset encodingUtil = application.javaloader.create('EncodingUtil')>
	
	<cffunction name="generate" access="remote" output="no">
		<cfargument name="activityid" type="string" required="yes">
		<cfargument name="htmlcontent" type="string" required="no" default="" />
		
		<cfquery name="qcerts" datasource="#application.settings.dsn#">
			SELECT 	
				a.MDFlag,
				a.CheckIn,
				a.CompleteDate,
				act.StartDate AS activityStart,
				act.EndDate AS activityEnd,
				act.ActivityID,
				act.Title AS ActivityTitle,
				act.ActivityTypeID, 
				act.Location AS ActivityLocation, 
				act.Sponsorship,
				act.Sponsor,
				act.City,
				s.Name AS State,
				a.AttendeeID,
				p.CertName AS AttendeeName
				,ac.Amount AS ActivityCredit,
				(SELECT TOP 1 attc.Amount
				FROM ce_AttendeeCredit attc
				WHERE (attc.AttendeeID = a.AttendeeID) AND (attc.CreditID = 1)) AS AttendeeCredit,
				(SELECT TOP 1 attc.ReferenceNo
				FROM ce_AttendeeCredit attc
				WHERE (attc.AttendeeID = a.AttendeeID) AND (attc.CreditID = 1)) AS ReferenceNumber,
				sc.Name AS CreditType
			FROM ce_Attendee a
			INNER JOIN ce_Person p ON p.PersonID = a.PersonID
			INNER JOIN ce_Activity_Credit ac ON ac.ActivityID = a.ActivityID
			INNER JOIN ce_Sys_Credit sc ON sc.CreditID = ac.CreditID
			INNER JOIN ce_Activity act ON act.ActivityID = a.ActivityID
			LEFT JOIN ce_Sys_state s ON s.StateId = act.State
			WHERE 
			a.ActivityID = <cfqueryparam value="#arguments.activityid#" cfsqltype="cf_sql_integer" />
		</cfquery>
		
		<cfdocument
			format="PDF"
			pagetype="letter"
			margintop="0"
			orientation="landscape"
			marginbottom="0"
			marginright="0"
			marginleft="0"
			unit="in"
			fontembed="true"
			backgroundvisible="true"
			localurl="true">
			
			<cfloop query="qcerts">
			
			<cfdocumentsection>
			<cfoutput>#RenderHTML(application.udf.querytostruct(qcerts,qcerts.currentrow),urlDecode(arguments.htmlcontent))#</cfoutput>
			</cfdocumentsection>
			</cfloop>
		</cfdocument>
	</cffunction>
	
	<cffunction name="preview" access="remote" output="no">
		<cfargument name="htmlcontent" type="string" required="yes">
		
		<cfset var previewStruct = structNew()>
		<cfset previewStruct = { completeDate = '3/20/2010',
				activityStart = '1/1/2010',
				activityEnd = '12/31/2010',
				activityTitle = 'This is an example activity title',
				activityLocation = 'Cincinnati, OH', 
				activitySponsorship = 'jointly',
				activitySponsor = 'The Sponsor Group',
				activityCity = 'Cincinnati',
				activityState = 'Ohio',
				attendeeId = '169841',
				attendeeName = 'John C. Tester, MD',
				activityCredit = '1.0',
				attendeeCredit = '1.0',
				accreditedRefNumber = 'FJDK923923',
				creditType = 'CME'
		}>
		
		<cfdocument
			format="PDF"
			pagetype="letter"
			margintop="0"
			orientation="landscape"
			marginbottom="0"
			marginright="0"
			marginleft="0"
			unit="in"
			fontembed="true"
			backgroundvisible="true"
			localurl="true">
			
			
			<cfdocumentsection>
			<cfoutput>#RenderHTML(previewStruct,arguments.htmlcontent)#</cfoutput>
			</cfdocumentsection>
		</cfdocument>
	</cffunction>
	
	<cffunction name="design" access="remote" output="yes">
		<cfargument name="htmlcontent" type="string" required="yes" />
		
		<cfset var previewStruct = structNew()>
		<cfset previewStruct = { completeDate = '3/20/2010',
				activityStart = '1/1/2010',
				activityEnd = '12/31/2010',
				activityTitle = 'This is an example activity title',
				activityLocation = 'Cincinnati, OH', 
				activitySponsorship = 'jointly',
				activitySponsor = 'The Sponsor Group',
				activityCity = 'Cincinnati',
				activityState = 'Ohio',
				attendeeId = '169841',
				attendeeName = 'John C. Tester, MD',
				activityCredit = '1.0',
				attendeeCredit = '1.0',
				accreditedRefNumber = 'FJDK923923',
				creditType = 'CME'
		}>
		
		<cfoutput>#RenderHTML(previewStruct,arguments.htmlcontent)#</cfoutput>
	</cffunction>
	
	<cffunction name="RenderHTML" output="no" access="public">
		<cfargument name="QueryRow" type="struct" required="yes" />
		<cfargument name="htmltmpl" type="string" required="yes" />
		
		<cfset var htmlTemplate = arguments.htmltmpl>
		<cfset var returnHtml = "" />
		<cfset var aFoundFields = REMatchNoCase("{[A-Za-z]+}",htmlTemplate)>
		<cfset var Output = "">
		
		<cfloop from="1" to="#ArrayLen(aFoundFields)#" index="i">
			<cfset VarName = Trim(ReplaceNoCase(aFoundFields[i],"}","","ALL"))>
			<cfset VarName = Trim(ReplaceNoCase(VarName,"{","","ALL"))>
			
			<cfif isDate(Evaluate("QueryRow.#VarName#"))>
				<cfset "QueryRow.#VarName#" = DateFormat(Evaluate("QueryRow.#VarName#"),'mm/dd/yyyy') />
			</cfif>
			
			<!--- SPECIAL CASES --->
			<cfif isDefined("QueryRow.#VarName#")>
				<cfset htmlTemplate = ReplaceNoCase(htmlTemplate,VarName,Evaluate("QueryRow.#VarName#"),"ALL")>
			</cfif>
			
			<!---<cfset VarName = Trim(Replace(aFoundFields[i],"%","","ALL"))>--->
		</cfloop>
		<cfoutput>
		<cfsavecontent variable="returnHtml">
			<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
				<html>
				<head>
					<style type="text/css">
					@import('/admin/_styles/cert_pdf.css');
					</style>
				</head>
			<body style="background-image: url(certificate.jpg)">
				#htmlTemplate#
			</body>
			</html>
		</cfsavecontent>
		</cfoutput>
		
		<cfset returnHtml = replace(returnHtml,'{','','ALL')>
		<cfset returnHtml = replace(returnHtml,'}','','ALL')>
		
		<cfreturn returnHtml />
	</cffunction>
</cfcomponent>
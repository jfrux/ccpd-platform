<cfset hashKey = hash('#attributes.activityId#_#attributes.personId#_#dateFormat(now(),"yymmddhhmmss")#','MD5') />
<cfset fileName = "cme_#hashKey#.pdf">
<cfset filePath = expandPath('/lms/_dl/#fileName#') />
<cfset fileUrl = "http://www.getmycme.com/activities/#qReportData.activityId#/certificates?attendees=#qReportData.attendeeid#" />

<cfhttp getAsBinary="yes" url="http://www.getmycme.com/activities/#qReportData.activityId#/certificates?attendees=#qReportData.attendeeid#"></cfhttp>
<cfheader name="Content-Disposition" value="attachment;filename=#fileName#">
<cfcontent variable="#cfhttp.filecontent#" type="application/pdf">
<cfset hashKey = hash('#attributes.personId#_#dateFormat(now(),"yymmddhhmmss")#','MD5') />
<cfset fileName = "#attributes.activityId#_#hashKey#.pdf">
<cfset filePath = expandPath('/lms/_dl/#fileName#') />
<cfset fileUrl = "http://www.getmycme.com/activities/#qReportData.activityId#/certificates?attendees=#qReportData.attendeeid#" />

<cfhttp getAsBinary="yes" url="http://www.getmycme.com/activities/#qReportData.activityId#/certificates?attendees=#qReportData.attendeeid#"></cfhttp>
<cfheader name="Content-Disposition" value="attachment;filename=#fileName#">
<cfcontent variable="#cfhttp.filecontent#" type="application/pdf">
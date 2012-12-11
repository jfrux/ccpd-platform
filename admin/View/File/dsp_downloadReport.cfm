<cfparam name="Attributes.FileName" default="" />
<cfparam name="Attributes.ReportID" default="" />

<cfheader name="Content-Disposition" value="attachment;filename=#Replace(Attributes.FileName, " ","_","ALL")#">
<cfcontent type="application/vnd.ms-excel" file="#ExpandPath('#Application.Settings.RootPath#/_reports/#Attributes.ReportID#/#Attributes.FileName#')#">
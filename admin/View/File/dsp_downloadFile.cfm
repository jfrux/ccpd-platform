
<cfheader name="Content-Disposition" value="attachment;filename=#Replace(Attributes.FileName, " ","_","ALL")#">
<cfcontent file="#ExpandPath('/_uploads/#Attributes.Mode#Files/#Attributes.ModeID#/#Attributes.FileName#')#">
asdfadsffads
<cfparam name="Attributes.ProcessID" default="0">

<cfset ProcessBean = CreateObject("component","#Application.Settings.Com#Process.Process").init()>
<cfif Attributes.ProcessID GT 0>
	<cfset ProcessBean.setProcessID(Attributes.ProcessID)>
	<cfset ProcessBean = Application.Com.ProcessDAO.read(ProcessBean)>
	
	<cfset Attributes.Title = ProcessBean.getTitle()>
	<cfset Attributes.HiddenFlag = ProcessBean.getHiddenFlag()>
</cfif>
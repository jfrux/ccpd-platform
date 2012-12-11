<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!-- Process -->
<circuit access="public">
	<prefuseaction callsuper="true">
		<set name="Request.NavItem" value="5" />
    </prefuseaction>
	
	<fuseaction name="AddToQueue">
		<do action="mProcess.getProcesses" />
		<do action="mProcess.getManagers" />
		<do action="mProcess.getStepList" />
		<do action="vProcess.AddToQueue" contentvariable="Request.Page.Body" />
		<do action="vLayout.None" />
	</fuseaction>
	
    <fuseaction name="Home">
		<set name="Request.Page.Title" value="Processes &amp; Queues" />
        <set name="Request.Page.Breadcrumbs" value="Administration|Admin.Home,Processes &amp; Queues|Process.Home" />
		<do action="mPage.ParseCrumbs" />
		<do action="mProcess.getProcesses" />
		<do action="vProcess.Home" contentvariable="Request.MultiFormContent" />
		<do action="vProcess.HomeRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_MultiForm" contentvariable="Request.Page.Body" />
        <do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="Create">
		<set name="Request.Page.Title" value="Create Process" />
        <set name="Request.Page.Breadcrumbs" value="Administration|Admin.Home,Processes &amp; Queues|Process.Home,Create Process|Process.Create" />
		<do action="mPage.ParseCrumbs" />
		<do action="mProcess.Save" />
		<do action="vProcess.Create" contentvariable="Request.MultiFormContent" />
		<do action="vProcess.CreateRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_MultiForm" contentvariable="Request.Page.Body" />
        <do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="Edit">
		<do action="mProcess.Save" />
		<do action="mProcess.getDetail" />
		<set name="Request.Page.Title" value="Edit Process: #ProcessBean.getTitle()#" />
        <set name="Request.Page.Breadcrumbs" value="Administration|Admin.Home,Processes &amp; Queues|Process.Home,Edit Process: #ProcessBean.getTitle()#|Process.Edit&amp;ProcessID=#Attributes.ProcessID#" />
		<do action="mPage.ParseCrumbs" />
		
		<do action="mProcess.TabControl" />
		<do action="vProcess.Edit" contentvariable="Request.MultiFormContent" />
		<do action="vProcess.EditRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_MultiForm" contentvariable="Request.Page.Body" />
        <do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="Detail">
		<do action="mProcess.getDetail" />
		<do action="mProcess.getManagers" />
		<set name="Request.Page.Title" value="#ProcessBean.getTitle()#" />
        <set name="Request.Page.Breadcrumbs" value="Administration|Admin.Home,Processes &amp; Queues|Process.Home,#ProcessBean.getTitle()#|Process.Detail&amp;ProcessID=#Attributes.ProcessID#" />
		<do action="mPage.ParseCrumbs" />
		<do action="mProcess.TabControl" />
		<do action="mProcess.getStepList" />
		<do action="vProcess.StepList" contentvariable="Request.MultiFormContent" />
		<do action="vProcess.StepListRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_MultiForm" contentvariable="Request.Page.Body" />
        <do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="Managers">
		<do action="mProcess.getDetail" />
		<do action="mProcess.getManagers" />
		<set name="Request.Page.Title" value="#ProcessBean.getTitle()#" />
        <set name="Request.Page.Breadcrumbs" value="Administration|Admin.Home,Processes &amp; Queues|Process.Home,#ProcessBean.getTitle()#|Process.Detail&amp;ProcessID=#Attributes.ProcessID#,Managers|Process.Managers&amp;ProcessID=#Attributes.ProcessID#" />
		<do action="mPage.ParseCrumbs" />
		<do action="mProcess.TabControl" />
		<do action="vProcess.Managers" contentvariable="Request.MultiFormContent" />
		<do action="vProcess.ManagersRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_MultiForm" contentvariable="Request.Page.Body" />
        <do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="StepDetail">
		<do action="mProcess.getStepDetail" />
		<do action="mProcess.getDetail" />
		<do action="mProcess.getStepActivities" />
		
		<set name="Request.Page.Title" value="#ProcessBean.getTitle()#" />
		<set name="Request.MultiFormTitle" value="#StepBean.getName()#" />
        <set name="Request.Page.Breadcrumbs" value="Administration|Admin.Home,Processes &amp; Queues|Process.Home,#ProcessBean.getTitle()#|Process.Detail&amp;ProcessID=#Attributes.ProcessID#,#StepBean.getName()#|Process.StepDetail&amp;StepID=#Attributes.StepID#" />
		<do action="mPage.ParseCrumbs" />
		<do action="mProcess.TabControl" />
		
		<do action="vProcess.StepActivities" contentvariable="Request.MultiFormContent" />
		<do action="vProcess.StepActivitiesRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_MultiForm" contentvariable="Request.Page.Body" />
        <do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="StepActivity">
		<do action="mProcess.getStepDetail" />
		<do action="mProcess.getDetail" />
		<do action="mProcess.getStepActivityDetail" />
		<set name="Attributes.ActivityID" value="#qStepActivityDetail.ActivityID#" />	
		<do action="mActivity.getActivity" />
		<set name="Attributes.PersonID" value="#qStepActivityDetail.AssignedToID#" />
		<do action="mPerson.getPerson" />	
		<do action="mProcess.getManagers" />
		<set name="Request.Page.Title" value="#ProcessBean.getTitle()#" />
        <set name="Request.Page.Breadcrumbs" value="Administration|Admin.Home,Processes &amp; Queues|Process.Home,#ProcessBean.getTitle()#|Process.Detail&amp;ProcessID=#Attributes.ProcessID#,#StepBean.getName()#|Process.StepDetail&amp;StepID=#Attributes.StepID#,#ActivityBean.getTitle()#|Process.StepActivity&amp;StepID=#Attributes.StepID#&amp;ActivityID=#Attributes.ActivityID#" />
		<do action="mPage.ParseCrumbs" />
		<do action="mProcess.TabControl" />
		
		<do action="vProcess.StepActivityDetail" contentvariable="Request.MultiFormContent" />
		<do action="vProcess.StepActivityDetailRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_MultiForm" contentvariable="Request.Page.Body" />
        <do action="vLayout.Default" />
	</fuseaction>
</circuit>

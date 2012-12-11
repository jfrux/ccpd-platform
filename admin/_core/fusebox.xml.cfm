<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE fusebox>
<!--
	Example fusebox.xml control file. Shows how to define circuits, classes,
	parameters and global fuseactions.

	This is just a test namespace for the plugin custom attribute example
-->
<fusebox xmlns:test="test">
	<!--
		this is a model-view-controller application
		there is one public controller circuit (controller/, aliased to app)
		there is one internal model circuit (model/time/, aliased to time)
		there are two internal view circuits:
			view/display, aliased to display
			view/layout, aliased to layout
	-->
	<circuits>
		<!-- Model -->
		<circuit alias="mFile" path="../Model/File/" parent="" />
		<circuit alias="mImage" path="../Model/Image/" parent="" />
		<circuit alias="mMain" path="../Model/" parent="" />
		<circuit alias="mAjax" path="../Model/Ajax/" parent="" />
		<circuit alias="mAssessment" path="../Model/Assessment/" parent="" />
		<circuit alias="mAdmin" path="../Model/Admin/" parent="" />
		<circuit alias="mActivity" path="../Model/Activity/" parent="" />
        <circuit alias="mPage" path="../Model/Page/" parent="" />
        <circuit alias="mPerson" path="../Model/Person/" parent="" />
		<circuit alias="mProcess" path="../Model/Process/" parent="" />
		<circuit alias="mPublic" path="../Model/Public/" parent="" />
		<circuit alias="mReport" path="../Model/Report/" parent="" />
        <circuit alias="mSupport" path="../Model/Support/" parent="" />
		
		<!-- View -->
		<circuit alias="vFile" path="../View/File/" parent="" />
		<circuit alias="vImage" path="../View/Image/" parent="" />
		<circuit alias="vMain" path="../View/" parent="" />
		<circuit alias="vAssessment" path="../View/Assessment/" parent="" />
		<circuit alias="vAjax" path="../View/Ajax/" parent="" />
        <circuit alias="vAdmin" path="../View/Admin/" parent="" />
        <circuit alias="vActivity" path="../View/Activity/" parent="" />
		<circuit alias="vLayout" path="../View/Layout/" parent="" />
        <circuit alias="vPerson" path="../View/Person/" parent="" />
		<circuit alias="vProcess" path="../View/Process/" parent="" />
		<circuit alias="vPublic" path="../View/Public/" parent="" />
		<circuit alias="vReport" path="../View/Report/" parent="" />
        <circuit alias="vSupport" path="../View/Support/" parent="" />
		
		<!-- Controller -->
		<circuit alias="File" path="../Controller/File/" relative="true" />
		<circuit alias="Image" path="../Controller/Image/" relative="true" />
		<circuit alias="Main" path="../Controller/" relative="true" />
		<circuit alias="Assessment" path="../Controller/Assessment/" relative="true" />
		<circuit alias="Ajax" path="../Controller/Ajax/" relative="true" />
		<circuit alias="Admin" path="../Controller/Admin/" relative="true" />
		<circuit alias="Activity" path="../Controller/Activity/" relative="true" />
		<circuit alias="Person" path="../Controller/Person/" relative="true" />
		<circuit alias="Process" path="../Controller/Process/" relative="true" />
		<circuit alias="Public" path="../Controller/Public/" relative="true" />
		<circuit alias="Report" path="../Controller/Report/" relative="true" />
		<circuit alias="Support" path="../Controller/Support/" relative="true" />
	</circuits>

	<!--
	<classes>
		<class alias="MyClass" type="component" classpath="path.to.SomeCFC" constructor="init" />
	</classes>
	-->

	<parameters>
		<parameter name="defaultFuseaction" value="Main.Welcome" />
		<!-- you may want to change this to development-full-load mode: -->
		<parameter name="conditionalParse" value="true" />
		<!-- change this to something more secure: -->
		<parameter name="password" value="05125586" />
		<parameter name="strictMode" value="true" />
		<parameter name="debug" value="true" />
		<!-- we use the core file error templates -->
		<parameter name="errortemplatesPath" value="/_core/errortemplates/" />
		<parameter name="queryStringStart" value="/" />
		<parameter name="queryStringSeparator" value="/" />
		<parameter name="queryStringEqual" value="/" />
		<parameter name="fuseactionVariable" value="event" />
		<!--These are all default values that can be overridden:
        <parameter name="precedenceFormOrUrl" value="form" />
		<parameter name="scriptFileDelimiter" value="cfm" />
		<parameter name="maskedFileDelimiters" value="htm,cfm,cfml,php,php4,asp,aspx" />
		<parameter name="characterEncoding" value="utf-8" />
		<parameter name="strictMode" value="false" />
		<parameter name="allowImplicitCircuits" value="false" />
		-->
	</parameters>

	<globalfuseactions>
		<!--<appinit>
			<fuseaction action="mMain.coldSpringSetup" />
		</appinit>
		
        
		<preprocess>
			<fuseaction action="time.preprocess"/>
		</preprocess>
		<postprocess>
			<fuseaction action="time.postprocess"/>
		</postprocess>
		-->
	</globalfuseactions>

	<plugins>
		<phase name="preProcess">
			<plugin name="prePP" template="Globals" test:abc="123" />
		</phase>
		<!--
		<phase name="preFuseaction">
		</phase>
		<phase name="postFuseaction">
		</phase>
		<phase name="fuseactionException">
		</phase>
		<phase name="postProcess">
		</phase>
		<phase name="processError">
		</phase>
		-->
	</plugins>

</fusebox>

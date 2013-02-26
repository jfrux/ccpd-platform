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
		<circuit alias="mActivity" path="../Model/Activity/" parent="" />
		<circuit alias="mAssessment" path="../Model/Assessment/" parent="" />
		<circuit alias="mFile" path="../Model/File/" parent="" />
		<circuit alias="mPage" path="../Model/Page/" parent="" />
		<circuit alias="mMain" path="../Model/" parent="" />
		<circuit alias="mMember" path="../Model/Member/" parent="" />
		
		<!-- View -->
		<circuit alias="vActivity" path="../View/Activity/" parent="" />
		<circuit alias="vAssessment" path="../View/Assessment/" parent="" />
		<circuit alias="vFile" path="../View/File/" parent="" />
		<circuit alias="vLayout" path="../View/Layout/" parent="" />
		<circuit alias="vMain" path="../View/" parent="" />
		<circuit alias="vMember" path="../View/Member/" parent="" />
		
		<!-- Controller -->
		<circuit alias="Activity" path="../Controller/Activity/" relative="true" />
		<circuit alias="Assessment" path="../Controller/Assessment/" relative="true" />
		<circuit alias="File" path="../Controller/File/" relative="true" />
		<circuit alias="Main" path="../Controller/" relative="true" />
		<circuit alias="Member" path="../Controller/Member/" relative="true" />
	</circuits>

	<!--
	<classes>
		<class alias="MyClass" type="component" classpath="path.to.SomeCFC" constructor="init" />
	</classes>
	-->

	<parameters>
		<parameter name="defaultFuseaction" value="Main.Welcome" />
		<!-- you may want to change this to development-full-load mode: -->
		<parameter name="mode" value="development-circuit-load" />
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

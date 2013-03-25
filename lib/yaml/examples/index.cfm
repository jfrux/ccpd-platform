<!---
	* Author: Cristian Costantini
	* E-mail: cristian@millemultimedia.it
	* Version: 1.0.0 Alpha
	* Date: 6/9/2009 14:35:32
	* FileName: index.cfm 
	--->

<cfset o = createObject('component','it.millemultimedia.yaml.Yaml').init( expandPath( '/it/millemultimedia/yaml/lib/jyaml-1.3.jar' ) ) />

<cfset obj = o.load( expandPath( 'test.yaml' ) ) />

<cfdump var="#obj#" label="Yaml to Object">

<cfset d = o.dump( obj ) />

<cfset fileWrite( expandPath( 'Test2.yaml' ), d ) />

<cfdump var="#d#" label="Object To Yaml">


<cfset obj = o.load( expandPath( 'test2.yaml' ) ) />

<cfdump var="#obj#" label="Test 2">
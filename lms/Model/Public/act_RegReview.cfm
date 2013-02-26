<cfhttp url="https://developer.skipjackic.com/scripts/EvolvCC.dll?Authorize" method="post">

<!----contact info---->
<cfhttpparam type="formfield" name="sjname" value="#Session.RegCardName#">
<cfhttpparam type="formfield" name="Email" value="#Session.RegEmail#">
<cfhttpparam type="formfield" name="Shiptophone" value="<cfif isDefined('Session.RegPhone') AND Session.RegPhone NEQ ''>#Session.RegPhone#<cfelse>2319321500</cfif>">

<!----billing info---->
<cfhttpparam type="formfield" name="Streetaddress" value="#Session.RegAddress1#">
<cfhttpparam type="formfield" name="Streetaddress2" value="#Session.RegAddress2#">
<cfhttpparam type="formfield" name="City" value="#Session.RegCity#">
<cfhttpparam type="formfield" name="State" value="#Session.RegStateName#">
<cfhttpparam type="formfield" name="Country" value="#Session.RegCountryName#">
<cfhttpparam type="formfield" name="Zipcode" value="#Session.RegZip#">

<!----cc info---->
<cfhttpparam type="formfield" name="type" value="#Session.RegCardType#">
<cfhttpparam type="formfield" name="Month" value="#Session.RegCardExpireMonth#">
<cfhttpparam type="formfield" name="Year" value="#Session.RegCardExpireYear#">
<cfhttpparam type="formfield" name="Accountnumber" value="#Session.RegCardNumber#">

<!----shipping info---->
<cfhttpparam type="formfield" name="Shiptoname" value="#Session.RegFirstName# #Session.RegLastName#">
<cfhttpparam type="formfield" name="Shiptostreetaddress" value="#Session.RegAddress1#">
<cfhttpparam type="formfield" name="Shiptostreetaddress2" value="#Session.RegAddress2#">
<cfhttpparam type="formfield" name="Shiptocity" value="#Session.RegCity#">
<cfhttpparam type="formfield" name="Shiptostate" value="#Session.RegStateName#">
<cfhttpparam type="formfield" name="Shiptocountry" value="#Session.RegCountryName#">
<cfhttpparam type="formfield" name="Shiptozipcode" value="#Session.RegZip#">

<!----skip jack crap---->
<cfhttpparam type="formfield" name="Ordernumber" value="#DateFormat(now(),'mmddyyyy')##TimeFormat(now(),'hhmmss')#">               
<cfhttpparam type="formfield" name="Serialnumber" value="000885247011">
<cfhttpparam type="formfield" name="Transactionamount" value="#DecimalFormat(Trim(Session.RegFees))#">

<!----the order details---->
<cfhttpparam type="formfield" name="Orderstring" value="1~#Course.Name#~#Session.RegFees#~1~N~||">

</cfhttp>

<!----check what skipjack says & kick the user out of that is the case---->
<cfparam name="form.szIsApproved" default="">
<cfparam name="form.szTransactionFileName" default="">
<cfoutput>#CFHTTP.FileContent# #form.szIsApproved#</cfoutput>
<cfset ValList="-AUTHCODE,-szSerialNumber,-szTransactionAmount,-szAuthorizationDeclinedMessage,-szAVSResponseCode,-szAVSResponseMessage,-szOrderNumber,-szAuthorizationResponseCode,-szReturnCode">
<cfset VarList="strAuthCode,strSerialNumber,strTransactionAmount,strAuthorizationDeclinedMessage,strAVSResponseCode,strAVSResponseMessage,strOrderNumber,strAuthorizationResponseCode,strReturnCode">

<cfset loopcount = 0>
<cfloop list="#ValList#" index="Val_Name">
	<cfset loopcount = incrementvalue(loopcount)>
	<cfset length = Len(Val_Name)>
	<cfset start = FindNoCase(Val_Name, CFHTTP.FileContent, 1)+length+1>
	<cfset end = FindNoCase("-->", CFHTTP.FileContent, start)-start>
	<cfset Var_Name = #ListGetAt(VarList, loopcount, ",")#>
	<cfset a = #SetVariable(Var_name, "#Mid(CFHTTP.FileContent, start, end)#")#>
</cfloop>


<!--- Set Response Code and CC_OK --->
<cfif Len(#strAUTHORIZATIONRESPONSECODE#) EQ '6' AND #strRETURNCODE# EQ '1'> 
    <CFSET CC_OK = 1>
<CFELSE>
	<CFSET CC_OK = 0>
</CFIF>
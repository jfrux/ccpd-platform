<cfparam name="Form.Submitted" default ="">

<cfinclude template="includes/act_getPerson.cfm" />
<cfinclude template="includes/act_getAttendeeCDC.cfm" />
<cfinclude template="includes/act_saveAttendeeCDC.cfm" />

<cfparam name="Attributes.Saved" default="">
<cfparam name="Attributes.CBAFundID" default="#Form.CBAFundID#">
<cfparam name="Attributes.CBACDC" default="#Form.CBACDC#">
<cfparam name="Attributes.CBAOth" default="#Form.CBAOth#">

<cfparam name="Attributes.CBOFundID" default="#Form.CBOFundID#">
<cfparam name="Attributes.CBOCDC" default="#Form.CBOCDC#">
<cfparam name="Attributes.CBOOth" default="#Form.CBOOth#">

<cfparam name="Attributes.ProfCId" default="#Form.ProfCId#">
<cfparam name="Attributes.ProfCOther" default="#Form.ProfCOther#">
<cfparam name="Attributes.ProfNId" default="#Form.ProfNId#">
<cfparam name="Attributes.ProfNOther" default="#Form.ProfNOther#">

<cfparam name="Attributes.FunRCId" default="#Form.FunRCId#">
<cfparam name="Attributes.FunRCOther" default="#Form.FunRCOther#">
<cfparam name="Attributes.FunRNId" default="#Form.FunRNId#">
<cfparam name="Attributes.FunRNOther" default="#Form.FunRNOther#">

<cfparam name="Attributes.OccClassID" default="#Form.OccClassID#">
<cfparam name="Attributes.OrgTypeId" default="#Form.OrgTypeId#">
<cfparam name="Attributes.OrgTypeOther" default="#Form.OrgTypeOther#">

<cfparam name="Attributes.PrinEmpID" default="#Form.PrinEmpID#">
<cfparam name="Attributes.PrinEmpOther" default="#Form.PrinEmpOther#">

<cfparam name="Attributes.WorkState" default="#Form.WorkState#">
<cfparam name="Attributes.WorkZip" default="#Form.WorkZip#">

<cfparam name="Attributes.Focus1" default="#Form.Focus1#">
<cfparam name="Attributes.Focus2" default="#Form.Focus2#">
<cfparam name="Attributes.Focus3" default="#Form.Focus3#">
<cfparam name="Attributes.Focus4" default="#Form.Focus4#">
<cfparam name="Attributes.Focus5" default="#Form.Focus5#">
<cfparam name="Attributes.Focus6" default="#Form.Focus6#">
<cfparam name="Attributes.Focus7" default="#Form.Focus7#">
<cfparam name="Attributes.Focus8" default="#Form.Focus8#">
<cfparam name="Attributes.Focus9" default="#Form.Focus9#">
<cfparam name="Attributes.Focus10" default="#Form.Focus10#">
<cfparam name="Attributes.FocusOther" default="#Form.FocusOther#">

<cfparam name="Attributes.SpecialPop1" default="#Form.SpecialPop1#">
<cfparam name="Attributes.SpecialPop2" default="#Form.SpecialPop2#">
<cfparam name="Attributes.SpecialPop3" default="#Form.SpecialPop3#">
<cfparam name="Attributes.SpecialPop4" default="#Form.SpecialPop4#">
<cfparam name="Attributes.SpecialPop5" default="#Form.SpecialPop5#">
<cfparam name="Attributes.SpecialPop6" default="#Form.SpecialPop6#">
<cfparam name="Attributes.SpecialPop7" default="#Form.SpecialPop7#">
<cfparam name="Attributes.SpecialPop8" default="#Form.SpecialPop8#">
<cfparam name="Attributes.SpecialPop9" default="#Form.SpecialPop9#">
<cfparam name="Attributes.SpecialPop10" default="#Form.SpecialPop10#">
<cfparam name="Attributes.SpecialPop11" default="#Form.SpecialPop11#">
<cfparam name="Attributes.SpecialPop12" default="#Form.SpecialPop12#">
<cfparam name="Attributes.SpecialPop13" default="#Form.SpecialPop13#">
<cfparam name="Attributes.SpecialPop14" default="#Form.SpecialPop14#">
<cfparam name="Attributes.SpecialPop15" default="#Form.SpecialPop15#">
<cfparam name="Attributes.SpecialPop16" default="#Form.SpecialPop16#">
<cfparam name="Attributes.SpecialPop17" default="#Form.SpecialPop17#">
<cfparam name="Attributes.SpecialPop18" default="#Form.SpecialPop18#">
<cfparam name="Attributes.SpecialPopOther" default="#Form.SpecialPopOther#">

<cfparam name="Attributes.MarketID" default="#Form.MarketID#">
<cfparam name="Attributes.MarketOther" default="#Form.MarketOther#">
<cfparam name="Attributes.ContactUpdates" default="#Form.ContactUpdates#">
<cfparam name="Attributes.ContactEval" default="#Form.ContactEval#">
<cfparam name="Attributes.PTCAlert" default="#Form.PTCAlert#">
<cfparam name="Attributes.CurrentlyEnrolled" default="#Form.CurrentlyEnrolled#">
<cfparam name="Attributes.PTCTraining" default="#Form.PTCTraining#">
<cfparam name="Attributes.PrimaryMotivation" default="#Form.PrimaryMotivation#">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Cincinnati STD/HIV Prevention Training Center | Welcome Center</title>
<cfinclude template="includes/global_head.cfm" />
<script>
function setOccClass(nId) {
	if (nId == 1) {
		$(".Clinical").show();
		$(".NonClinical").hide();
		$("#ProfNOther").val("");
		$("#ProfNOther").hide();
		$("#FunRNOther").val("");
		$("#FunRNOther").hide();
		$(".NonClinical td input,.NonClinical td select").val("");
	} else if (nId == 2) {
		$(".NonClinical").show();
		$(".Clinical").hide();
		$("#ProfCOther").val("");
		$("#ProfCOther").hide();
		$("#FunRCOther").val("");
		$("#FunRCOther").hide();
		$(".Clinical td input,.Clinical td select").val("");
	} else {
		$(".Clinical").hide();
		$(".Clinical td input,.Clinical td select").val("");
		$("#ProfCOther").val("");
		$("#ProfCOther").hide();
		$("#FunRCOther").val("");
		$("#FunRCOther").hide();
		$(".NonClinical").hide();
		$("#ProfNOther").val("");
		$("#ProfNOther").hide();
		$("#FunRNOther").val("");
		$("#FunRNOther").hide();
		$(".NonClinical td input,.NonClinical td select").val("");
		
	}
	$("#OccClassID").val(nId);
}

function setProfC(nId) {
	if(nId == 7) {
		$("#ProfCOther").fadeIn();
	} else {
		$("#ProfCOther").fadeOut();
		$("#ProfCOther td input").val("");
	}
	$("#ProfCID").val(nId);
}

function setProfN(nId) {
	if(nId == 10) {
		$("#ProfNOther").fadeIn();
	} else {
		$("#ProfNOther").fadeOut();
		$("#ProfNOther td input").val("");
	}
	
	$("#ProfNID").val(nId);
}

function setFunRC(nId) {
	if(nId == 18) {
		$("#FunRCOther").fadeIn();
	} else {
		$("#FunRCOther").fadeOut();
		$("#FunRCOther td input").val("");
	}
	
	$("#FunRCID").val(nId);
}

function setFunRN(nId) {
	if(nId == 16) {
		$("#FunRNOther").fadeIn();
	} else {
		$("#FunRNOther").fadeOut();
		$("#FunRNOther td input").val("");
	}
	
	$("#FunRNID").val(nId);
}

function setOrgType(nId) {
	if(nId == 27) {
		$("#OrgTypeOther").fadeIn();
	} else {
		$("#OrgTypeOther").fadeOut();
		$("#OrgTypeOther td input").val("");
	}
	$("#OrgTypeID").val(nId);
}

function setPrinEmp(nId) {
	if(nId == 14) {
		$("#CBAFund").fadeOut();
		$("#CBOFund").fadeOut();
		
		$("#CBAFundID").val("");
		$("#CBOFundID").val("");
		
		$("#PrinEmpOther").fadeIn();
	} else if(nId == 1) {
		$("#CBAFund").fadeOut();
		$("#PrinEmpOther").fadeOut();
		
		$("#CBAFundID").val("");
		$("#PrinEmpOther td input").val("");
		
		$("#CBOFund").fadeIn();
	} else if(nId == 12) {
		$("#CBOFund").fadeOut();
		$("#PrinEmpOther").fadeOut();
		
		$("#CBOFundID").val("");
		$("#PrinEmpOther td input").val("");
		
		$("#CBAFund").fadeIn();
	} else {
		$("#CBAFund").fadeOut();
		$("#CBOFund").fadeOut();
		$("#PrinEmpOther").fadeOut();
		
		$("#CBOFundID").val("");
		$("#CBOFundID").val("");
		$("#PrinEmpOther td input").val("");
	}
	$("#PrinEmpID").val(nId);
}

function setMarket(nId) {
	if(nId == 9) {
		$("#MarketOther").fadeIn();
	} else {
		$("#MarketOther").fadeOut();
		$("#MarketOther td input").val("");
	}
	$("#MarketID").val(nId);
}

var nFocusCount = 0;
function setFocus(oFocus) {
	if($(oFocus).attr("checked")) {
		nFocusCount++;
		if($(oFocus).attr("id") == 'Focus10') {
			$("#FocusOther").attr("disabled",false);
		}
	} else {
		nFocusCount--;
		if($(oFocus).attr("id") == 'Focus10') {
			$("#FocusOther").attr("disabled",true);
		}
	}
	if(nFocusCount == 2) {
		$(".FocusBox").each(function() {
			if(!$(this).attr("checked")) {
				$(this).attr("disabled",true);
			}
		});
	} else {
		$(".FocusBox").attr("disabled",false);
	}
}

var nPopCount = 0;
function setPop(oPop) {
	if($(oPop).attr("checked")) {
		nPopCount++;
		if($(oPop).attr("id") == 'SpecialPop18') {
			$("#PopOther").attr("disabled",false);
		}
	} else {
		if($(oPop).attr("id") == 'SpecialPop18') {
			$("#PopOther").attr("disabled",true);
		}
		nPopCount--;
	}
	if(nPopCount == 3) {
		$(".PopBox").each(function() {
			if(!$(this).attr("checked")) {
				$(this).attr("disabled",true);
			}
		});
	} else {
		$(".PopBox").attr("disabled",false);
	}
}

$(document).ready(function() {	
	$(".FocusBox").click(function() {
		setFocus($(this));
	});
	
	$(".PopBox").click(function() {
		setPop($(this));
	});
	
	$("#OccClassID").change(function() {
		setOccClass($(this).val());
	});
	
	$("#ProfCID").change(function() {
		setProfC($(this).val());
	});
	
	$("#ProfNID").change(function() {
		setProfN($(this).val());
	});
	
	$("#FunRCID").change(function() {
		setFunRC($(this).val());
	});
	
	$("#FunRNID").change(function() {
		setFunRN($(this).val());
	});
	
	$("#OrgTypeID").change(function() {
		setOrgType($(this).val());
	});
	
	$("#PrinEmpID").change(function() {
		setPrinEmp($(this).val());
	});
	
	$("#MarketID").change(function() {
		setMarket($(this).val());
	});
	<cfoutput>
	<cfif Attributes.OccClassID NEQ "">
	setOccClass(#Attributes.OccClassID#);
	</cfif>
	<cfif Attributes.OrgTypeID NEQ "">
	setOrgType(#Attributes.OrgTypeID#);
	</cfif>
	<cfif Attributes.ProfNID NEQ "">
	setProfN(#Attributes.ProfNID#);
	</cfif>
	<cfif Attributes.ProfCID NEQ "">
	setProfC(#Attributes.ProfCID#);
	</cfif>
	<cfif Attributes.FunRCID NEQ "">
	setFunRC(#Attributes.FunRCID#);
	</cfif>
	<cfif Attributes.FunRNID NEQ "">
	setFunRN(#Attributes.FunRNID#);
	</cfif>
	<cfif Attributes.PrinEmpID NEQ "">
	setPrinEmp(#Attributes.PrinEmpID#);
	</cfif>
	<cfif Attributes.MarketID NEQ "">
	setMarket(#Attributes.MarketID#);
	</cfif>
	<cfif Attributes.WorkState NEQ "">
		$("##WorkState").val('#Attributes.WorkState#');
	</cfif>
	
	<!--- SET FOCUS DEFAULT --->
	$(".FocusBox:checked").each(function() {
		setFocus($(this));
	});
	
	$(".PopBox:checked").each(function() {
		setPop($(this));
	});
	</cfoutput>
	<cfif Attributes.Saved EQ 1>
		parent.addMessage("<cfoutput>#PersonBean.getFirstName()# #PersonBean.getLastName()#</cfoutput> PIF Form Saved!",250,6000,4000);
		parent.$("#pifForm").dialog("close");
	</cfif>
});
</script>
<style>
.FieldInput table tr td { font-size:10px!important;border-bottom:1px solid #EEE; }
.FieldInput select,.FieldInput input { font-size:14px!important; }
.FieldLabel { width:175px!important; font-size:14px!important; font-weight:bold; font-family:Verdana; background-color:#EEE; }
</style>
</head>

<body>
<cfinclude template="includes/inc_header.cfm">
<table width="770" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="nav_cell" valign="top">
			<cfinclude template="includes/inc_nav.cfm">
		</td>
		<cfoutput>
		<td class="content_cell" valign="top">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
            	<cfif IsDefined("Request.Status.Errors") AND Request.Status.Errors NEQ "">
                	
                    <div class="ErrorMsg">
                        <ul>
                            <cfloop list="#Request.Status.Errors#" index="Error" delimiters="|">
                            <li>#Error#</li>
                            </cfloop>
                        </ul>
                    </div>
                </cfif>
				<tr>
					<td class="content_title">Activity Registration </td>
				</tr>
				<tr>
					<td class="content_body">
                    	<cfset qActivities = Application.Com.ActivityCategoryGateway.getByPIFList(OrderBy="a.StartDate DESC")>
						<form action="#Request.RootPath#/cdc_pif.cfm?Submitted=1" method="post" name="frmCDC">
						<input type="hidden" name="Submitted" value="1">
						<table border="0" cellspacing="2" cellpadding="3">
							<tr>
                                <td class="FieldLabel" colspan="2">Select the activity you wish to register for...</td>
                            </tr>
                            <tr>
                                <td class="FieldInput" colspan="2">
                                    <select name="ActivityID" id="ActivityID" size="6" style="width:100%;">	
                                        <cfloop query="qActivities">
                                        <option value="#qActivities.ActivityID#">#DateFormat(qActivities.StartDate,'mm/dd/yyyy')# | #qActivities.Title#</option>
                                        </cfloop>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                            	<td class="FieldInput" colspan="2" style="border: 1px solid ##FF9999; background-color:##FFEEEE;"><strong>NOTE FOR <font color="##BB0000">RETURNING</font> USERS:</strong> Unless information needs updated, all you need to do is select an activity above and click Submit Registration at the bottom.</td>
                            </tr>
                            <tr>
                                <td class="FieldLabel">1. Gender: </td>
                                <td class="FieldInput"><input type="radio" name="Gender" value="M"<cfif PersonBean.getGender() EQ "M"> checked</cfif> /> Male <input type="radio" name="Gender" value="F"<cfif PersonBean.getGender() EQ "F"> checked</cfif> /> Female</td>
                            </tr>
                            <tr>
                                <td class="FieldLabel">2. Ethnicity: </td>
                                <td class="FieldInput">
                                    <select name="OMBEthnicity" id="OMBEthnicity">
                                        <option value=""></option>
                                        <cfset qOMBEthnicities = Application.List.OMBEthnicities>
                                        <cfloop query="qOMBEthnicities">
                                        <option value="#qOMBEthnicities.OMBEthnicityId#"<cfif PersonBean.getOMBEthnicityID() EQ qOMBEthnicities.OMBEthnicityId> selected</cfif>>#qOMBEthnicities.Description#</option>
                                        </cfloop>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="FieldLabel">3. Racial Background: </td>
                                <td class="FieldInput">
                                    <cfquery name="qEthnicity" datasource="#Application.Settings.DSN#">
                                        SELECT ethnicityid, description FROM ce_Sys_Ethnicity WHERE description <> 'Hispanic'
                                    </cfquery>
                                    <select name="Ethnicity" id="Ethnicity">
                                        <option value=""></option>
                                        <cfloop query="qEthnicity">
                                        <option value="#qEthnicity.ethnicityid#"<cfif PersonBean.getEthnicityID() EQ qEthnicity.ethnicityid> selected</cfif>>#Replace(qEthnicity.Description,', non-Hispanic','')#</option>
                                        </cfloop>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="FieldLabel" colspan="2">4. Occupational Classification: </td>
                            </tr>
                            <tr>
                                <td class="FieldInput" colspan="2">
                                <cfset qOccClass = Application.List.OccClass>
                                <select name="OccClassID" size="1" id="OccClassID">
                                    <option value="">Select Class</option>
                                    <cfloop query="qOccClass">
                                    <option value="#qOccClass.OccClassID#"<cfif Attributes.OccClassID EQ qOccClass.OccClassID> SELECTED</cfif>>#qOccClass.Name#</option>
                                    </cfloop>
                                </select>
                                </td>
                            </tr>
                            <tr class="Clinical" style="display:none;">
                                <td nowrap="nowrap" class="FieldLabel">5. Your Profession:</td>
                                <td class="FieldInput">
                                    <cfset qProfC = Application.List.ProfC>
                                    <select name="ProfCID" id="ProfCID">
                                        <option value=""></option>
                                        <cfloop query="qProfC">
                                        <option value="#qProfC.ProfCID#">#qProfC.Name#</option>
                                        </cfloop>
                                    </select>
                                </td>
                            </tr>
                            <tr id="ProfCOther" style="display:none;">
                                <td class="FieldLabel">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Profession, other:</td>
                                <td class="FieldInput"><input name="ProfCOther" type="text" value="#Attributes.ProfCOther#" maxlength="50" /></td>
                            </tr>
                            <tr class="Clinical" style="display:none;">
                                <td class="FieldLabel" colspan="2">6. Your primary functional role: </td>
                            </tr>
                            <tr class="Clinical" style="display:none;">
                                <td class="FieldInput" colspan="2">
                                <cfset qFunRC = Application.List.FunRC>
                                    <select name="FunRCID" id="FunRCID">
                                        <option value="">Select one...</option>
                                        <cfloop query="qFunRC">
                                        <option value="#qFunRC.FunRCID#">#qFunRC.Name#</option>
                                        </cfloop>
                                    </select>
                                </td>
                            </tr>
                            <tr id="FunRCOther" style="display:none;">
                                <td class="FieldLabel">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Primary role, other:</td>
                                <td class="FieldInput"><input name="FunRCOther" type="text" value="#Attributes.FunRCOther#" maxlength="50" /></td>
                            </tr>
                            <tr class="NonClinical" style="display:none;">
                                <td nowrap="nowrap" class="FieldLabel">5. Your Profession:</td>
                                <td class="FieldInput">
                                    <cfset qProfN = Application.List.ProfN>
                                    <select name="ProfNID" id="ProfNID">
                                        <option value=""></option>
                                        <cfloop query="qProfN">
                                        <option value="#qProfN.ProfNID#">#qProfN.Name#</option>
                                        </cfloop>
                                    </select>
                                </td>
                            </tr>
                            <tr id="ProfNOther" style="display:none;">
                                <td class="FieldLabel">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Profession, other:</td>
                                <td class="FieldInput"><input name="ProfNOther" type="text" value="#Attributes.ProfNOther#" maxlength="50" /></td>
                            </tr>
                            <tr class="NonClinical" style="display:none;">
                                <td class="FieldLabel" colspan="2">6. Your primary functional role: </td>
                            </tr>
                            <tr class="NonClinical" style="display:none;">
                                <td class="FieldInput" colspan="2">
                                <cfset qFunRN = Application.List.FunRN>
                                    <select name="FunRNID" id="FunRNID">
                                        <cfloop query="qFunRN">
                                        <option value="#qFunRN.FunRNID#">#qFunRN.Name#</option>
                                        </cfloop>
                                    </select>
                                </td>
                            </tr>
                            <tr id="FunRNOther" style="display:none;">
                                <td class="FieldLabel">Primary role, other:</td>
                                <td class="FieldInput"><input name="FunRNOther" type="text" value="#Attributes.FunRNOther#" maxlength="50" /></td>
                            </tr>
                            <tr>
                                <td nowrap="nowrap" class="FieldLabel">7. State:</td>
                                <td class="FieldInput">
                                <cfset qStates = Application.List.States>
                                    <select name="WorkState" id="WorkState">
                                        <option value=""></option>
                                        <cfloop query="qStates">
                                        <option value="#qStates.StateId#"<cfif Attributes.WorkState EQ qStates.Code OR Attributes.WorkState EQ qStates.StateID> SELECTED</cfif>>#qStates.Name#</option>
                                        </cfloop>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td nowrap="nowrap" class="FieldLabel">&nbsp;&nbsp;&nbsp;&nbsp;Zip Code:</td>
                                <td class="FieldInput"><input name="WorkZip" type="text" id="WorkZip" style="width:70px;" value="#Attributes.WorkZip#" /></td>
                            </tr>
                            <tr>
                                <td class="FieldLabel" colspan="2">8. Principal Employment Setting:</td>
                            </tr>
                            <tr>
                                <td class="FieldInput" colspan="2">
                                    <cfset qPrinEmp = Application.List.PrinEmp>
                                    <select name="PrinEmpID" id="PrinEmpID">
                                        <option value="">Select one...</option>
                                        <cfloop query="qPrinEmp">
                                        <option value="#qPrinEmp.PrinEmpID#">#qPrinEmp.Name#</option>
                                        </cfloop>
                                    </select></td>
                            </tr>
                            <tr id="PrinEmpOther" style="display:none;">
                                <td class="FieldLabel">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Employment setting, other:</td>
                                <td class="FieldInput"><input name="PrinEmpOther" type="text" value="#Attributes.PrinEmpOther#" maxlength="50" /></td>
                            </tr>
                            <tr id="CBAFund" style="display:none;">
                                <td class="FieldLabel">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Capacity-Building and Technical Assistance funding:</td>
                                <td class="FieldInput">
                                <cfset qCBAFund = Application.list.CBAFund>
                                    <select name="CBAFundID" id="CBAFundID">
                                        <option value="">Select one...</option>
                                        <cfloop query="qCBAFund">
                                        <option value="#qCBAFund.CBAFundID#"<cfif Attributes.CBAFundID EQ qCBAFund.CBAFundID> SELECTED</cfif>>#qCBAFund.Name#</option>
                                        </cfloop>
                                    </select>
                                </td>
                            </tr>
                            <tr id="CBOFund" style="display:none;">
                                <td class="FieldLabel">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Community Based Organization funding:</td>
                                <td class="FieldInput">
                                <cfset qCBOFund = Application.list.CBOFund>
                                    <select name="CBOFundID" id="CBOFundID">
                                        <option value="">Select one...</option>
                                        <cfloop query="qCBOFund">
                                        <option value="#qCBOFund.CBOFundID#"<cfif Attributes.CBOFundID EQ qCBOFund.CBOFundID> SELECTED</cfif>>#qCBOFund.Name#</option>
                                        </cfloop>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="FieldLabel" colspan="2">9. Primary programmatic focus: (select up to 2)</td>
                            </tr>
                            <tr>
                                <td class="FieldInput" colspan="2">
                                    <table border="0" cellpadding="1" cellspacing="0">
                                        <tr>
                                            <td width="20"><input name="Focus1" type="checkbox" id="Focus1" class="FocusBox" value="Y"<cfif Attributes.Focus1 EQ "Y"> checked</cfif> /></td>
                                            <td width="180" nowrap="nowrap"><label for="Focus1">STD</label></td>
                                            <td width="20"><input name="Focus2" type="checkbox" id="Focus2" class="FocusBox" value="Y"<cfif Attributes.Focus2 EQ "Y"> checked</cfif> /></td>
                                            <td width="225" nowrap="nowrap"><label for="Focus2">HIV/AIDS</label></td>
                                        </tr>
                                        <tr>
                                            <td><input name="Focus3" type="checkbox" id="Focus3" class="FocusBox" value="Y"<cfif Attributes.Focus3 EQ "Y"> checked</cfif> /></td>
                                            <td nowrap="nowrap"><label for="Focus3">Women's reproductive health</label></td>
                                            <td><input name="Focus4" type="checkbox" id="Focus4" class="FocusBox" value="Y"<cfif Attributes.Focus4 EQ "Y"> checked</cfif> /></td>
                                            <td nowrap="nowrap"><label for="Focus4">General medicine or Family practice</label></td>
                                        </tr>
                                        <tr>
                                            <td><input name="Focus5" type="checkbox" id="Focus5" class="FocusBox" value="Y"<cfif Attributes.Focus5 EQ "Y"> checked</cfif> /></td>
                                            <td nowrap="nowrap"><label for="Focus5">Adolescent/student health</label></td>
                                            <td><input name="Focus6" type="checkbox" id="Focus6" class="FocusBox" value="Y"<cfif Attributes.Focus6 EQ "Y"> checked</cfif> /></td>
                                            <td nowrap="nowrap"><label for="Focus6">Mental health</label></td>
                                        </tr>
                                        <tr>
                                            <td><input name="Focus7" type="checkbox" id="Focus7" class="FocusBox" value="Y"<cfif Attributes.Focus7 EQ "Y"> checked</cfif> /></td>
                                            <td nowrap="nowrap"><label for="Focus7">Substance use/addiction</label></td>
                                            <td><input name="Focus8" type="checkbox" id="Focus8" class="FocusBox" value="Y"<cfif Attributes.Focus8 EQ "Y"> checked</cfif> /></td>
                                            <td nowrap="nowrap"><label for="Focus8">Emergency medicine</label></td>
                                        </tr>
                                        <tr>
                                            <td><input name="Focus9" type="checkbox" id="Focus9" class="FocusBox" value="Y"<cfif Attributes.Focus9 EQ "Y"> checked</cfif> /></td>
                                            <td nowrap="nowrap"><label for="Focus9">Corrections</label></td>
                                            <td><input name="Focus10" type="checkbox" id="Focus10" class="FocusBox" value="Y"<cfif Attributes.Focus10 EQ "Y"> checked</cfif> /></td>
                                            <td nowrap="nowrap">
                                                <table border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td>Other</td>
                                                        <td><input name="FocusOther" type="text" id="FocusOther" value="#Attributes.FocusOther#" maxlength="50" /></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>					
                                </td>
                            </tr>
                            <tr>
                                <td class="FieldLabel" colspan="2">10. Special population(s) or target group(s) focused on: (select up to 3) </td>
                            </tr>
                            <tr>
                                <td class="FieldInput" colspan="2">
                                    <table border="0" cellpadding="1" cellspacing="0">
                                        <tr>
                                            <td width="20"><input name="SpecialPop1" type="checkbox" id="SpecialPop1" class="PopBox" value="Y"<cfif Attributes.SpecialPop1 EQ "Y"> checked</cfif> /></td>
                                            <td width="180" nowrap="nowrap"><label for="SpecialPop1">No target group/general</label></td>
                                            <td width="20"><input name="SpecialPop2" type="checkbox" id="SpecialPop2" class="PopBox" value="Y"<cfif Attributes.SpecialPop2 EQ "Y"> checked</cfif> /></td>
                                            <td width="225" nowrap="nowrap"><label for="SpecialPop2">Adolescents</label></td>
                                            </tr>
                                        <tr>
                                            <td><input name="SpecialPop3" type="checkbox" id="SpecialPop3" class="PopBox" value="Y"<cfif Attributes.SpecialPop3 EQ "Y"> checked</cfif> /></td>
                                            <td nowrap="nowrap"><label for="SpecialPop3">Gay/Lesbian/Bisexual/MSM</label></td>
                                            <td><input name="SpecialPop4" type="checkbox" id="SpecialPop4" class="PopBox" value="Y"<cfif Attributes.SpecialPop4 EQ "Y"> checked</cfif> /></td>
                                            <td nowrap="nowrap"><label for="SpecialPop4">Transgender</label></td>
                                            </tr>
                                        <tr>
                                            <td><input name="SpecialPop5" type="checkbox" id="SpecialPop5" class="PopBox" value="Y"<cfif Attributes.SpecialPop5 EQ "Y"> checked</cfif> /></td>
                                            <td nowrap="nowrap"><label for="SpecialPop5">Homeless</label></td>
                                            <td><input name="SpecialPop6" type="checkbox" id="SpecialPop6" class="PopBox" value="Y"<cfif Attributes.SpecialPop6 EQ "Y"> checked</cfif> /></td>
                                            <td nowrap="nowrap"><label for="SpecialPop6">Incarcerated individuals/parolees</label></td>
                                            </tr>
                                        <tr>
                                            <td><input name="SpecialPop7" type="checkbox" id="SpecialPop7" class="PopBox" value="Y"<cfif Attributes.SpecialPop7 EQ "Y"> checked</cfif> /></td>
                                            <td nowrap="nowrap"><label for="SpecialPop7">Pregnant women</label></td>
                                            <td><input name="SpecialPop8" type="checkbox" id="SpecialPop8" class="PopBox" value="Y"<cfif Attributes.SpecialPop8 EQ "Y"> checked</cfif> /></td>
                                            <td nowrap="nowrap"><label for="SpecialPop8">Sex workers</label></td>
                                        </tr>
                                        <tr>
                                            <td><input name="SpecialPop9" type="checkbox" id="SpecialPop9" class="PopBox" value="Y"<cfif Attributes.SpecialPop9 EQ "Y"> checked</cfif> /></td>
                                            <td nowrap="nowrap"><label for="SpecialPop9">African Americans</label></td>
                                            <td><input name="SpecialPop10" type="checkbox" id="SpecialPop10" class="PopBox" value="Y"<cfif Attributes.SpecialPop10 EQ "Y"> checked</cfif> /></td>
                                            <td nowrap="nowrap"><label for="SpecialPop10">Asians</label></td>
                                        </tr>
                                        <tr>
                                            <td><input name="SpecialPop11" type="checkbox" id="SpecialPop11" class="PopBox" value="Y"<cfif Attributes.SpecialPop11 EQ "Y"> checked</cfif> /></td>
                                            <td nowrap="nowrap"><label for="SpecialPop11">Native Hawaiian/Pacific Islanders</label></td>
                                            <td><input name="SpecialPop12" type="checkbox" id="SpecialPop12" class="PopBox" value="Y"<cfif Attributes.SpecialPop12 EQ "Y"> checked</cfif> /></td>
                                            <td nowrap="nowrap"><label for="SpecialPop12">American Indian/Alaska Native</label></td>
                                        </tr>
                                        <tr>
                                            <td><input name="SpecialPop13" type="checkbox" id="SpecialPop13" class="PopBox" value="Y"<cfif Attributes.SpecialPop13 EQ "Y"> checked</cfif> /></td>
                                            <td nowrap="nowrap"><label for="SpecialPop13">Hispanic/Latinos</label></td>
                                            <td><input name="SpecialPop14" type="checkbox" id="SpecialPop14" class="PopBox" value="Y"<cfif Attributes.SpecialPop14 EQ "Y"> checked</cfif> /></td>
                                            <td nowrap="nowrap"><label for="SpecialPop14">Recent immigrants/refugees</label></td>
                                        </tr>
                                        <tr>
                                            <td><input name="SpecialPop15" type="checkbox" id="SpecialPop15" class="PopBox" value="Y"<cfif Attributes.SpecialPop15 EQ "Y"> checked</cfif> /></td>
                                            <td nowrap="nowrap"><label for="SpecialPop15">Substance users</label></td>
                                            <td><input name="SpecialPop16" type="checkbox" id="SpecialPop16" class="PopBox" value="Y"<cfif Attributes.SpecialPop16 EQ "Y"> checked</cfif> /></td>
                                            <td nowrap="nowrap"><label for="SpecialPop16">IDU</label></td>
                                        </tr>
                                        <tr>
                                            <td><input name="SpecialPop17" type="checkbox" id="SpecialPop17" class="PopBox" value="Y"<cfif Attributes.SpecialPop17 EQ "Y"> checked</cfif> /></td>
                                            <td nowrap="nowrap"><label for="SpecialPop17">HIV+ individuals</label></td>
                                            <td><input name="SpecialPop18" type="checkbox" id="SpecialPop18" class="PopBox" value="Y"<cfif Attributes.SpecialPop18 EQ "Y"> checked</cfif> /></td>
                                            <td nowrap="nowrap">
                                            	<table border="0" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td style="padding-right:4px;">Other</td>
                                                        <td><input name="SpecialPopOther" type="text" id="PopOther" value="#Attributes.SpecialPopOther#" maxlength="50" /></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="FieldLabel" colspan="2">11. How did you hear about this course?</td>
                            </tr>
                            <tr>
                                <td class="FieldInput" colspan="2">
                                    <cfset qMarkets = Application.List.Market>
                                    <select name="MarketID" id="MarketID">
                                        <cfloop query="qMarkets">
                                            <option value="#qMarkets.MarketID#"<cfif Attributes.MarketID EQ qMarkets.MarketID> SELECTED</cfif>>#qMarkets.Name#</option>
                                        </cfloop>
                                    </select>
                                </td>
                            </tr>
                            <tr id="MarketOther" style="display:none;">
                                <td class="FieldLabel">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Specify, other:</td>
                                <td class="FieldInput"><input name="MarketOther" type="text" value="#Attributes.MarketOther#" maxlength="50" /></td>
                            </tr>
                            <tr>
                                <td nowrap="nowrap" class="FieldLabel" colspan="2">12. Do you consent to being contacted for:</td>
                            </tr>
                            <tr>
                                <td nowrap="nowrap">Updates?</td>
                                <td class="FieldInput">
                                	<table border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td><input name="ContactUpdates" type="radio" value="Y"<cfif Attributes.ContactUpdates EQ "Y"> checked</cfif> /></td>
                                            <td>Yes</td>
                                            <td><input name="ContactUpdates" type="radio" value="N"<cfif Attributes.ContactUpdates EQ "N"> checked</cfif> /></td>
                                            <td>No</td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td nowrap="nowrap">Evaluation Purposes?</td>
                                <td class="FieldInput">
                                    <table width="98" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="20"><input name="ContactEval" type="radio" value="Y"<cfif Attributes.ContactEval EQ "Y"> checked</cfif> /></td>
                                            <td width="30">Yes</td>
                                            <td width="20"><input name="ContactEval" type="radio" value="N"<cfif Attributes.ContactEval EQ "N"> checked</cfif> /></td>
                                            <td width="130">No</td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="FieldLabel" colspan="2">13. Do you wish to be added to the Cincinnati STD/HIV Prevention Training Center's Online Training Alert?</td>
                            </tr>
                            <tr>
                                <td nowrap="nowrap" class="FieldInput" colspan="2">
                                    <table width="98" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="20"><input name="PTCAlert" type="radio" value="Y"<cfif Attributes.PTCAlert EQ "Y"> checked</cfif> /></td>
                                            <td width="30">Yes</td>
                                            <td width="20"><input name="PTCAlert" type="radio" value="N"<cfif Attributes.PTCAlert EQ "N"> checked</cfif> /></td>
                                            <td width="130">No</td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="FieldLabel" colspan="2">14. Currently enrolled in any type of training program for clinical licensure?</td>
                            </tr>
                            <tr>
                                <td nowrap="nowrap" class="FieldInput" colspan="2">
                                    <table width="98" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="20"><input name="CurrentlyEnrolled" type="radio" value="1"<cfif Attributes.CurrentlyEnrolled EQ TRUE> checked</cfif> /></td>
                                            <td width="30">Yes</td>
                                            <td width="20"><input name="CurrentlyEnrolled" type="radio" value="0"<cfif Attributes.CurrentlyEnrolled EQ FALSE> checked</cfif> /></td>
                                            <td width="130">No</td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="FieldLabel" colspan="2">15. Is the PTC training relevant and does it contribute hours toward professional training program?</td>
                            </tr>
                            <tr>
                                <td nowrap="nowrap" colspan="2" class="FieldInput">
                                    <table width="98" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="20"><input name="PTCtraining" type="radio" value="1"<cfif Attributes.PTCtraining EQ TRUE> checked</cfif> /></td>
                                            <td width="30">Yes</td>
                                            <td width="20"><input name="PTCtraining" type="radio" value="0"<cfif Attributes.PTCtraining EQ FALSE> checked</cfif> /></td>
                                            <td width="130">No</td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="FieldLabel" colspan="2">16. Is your primary motivation to supplement your training rather than improve current practice?</td>
                            </tr>
                            <tr>
                                <td nowrap="nowrap" colspan="2" class="FieldInput">
                                    <table width="98" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="20"><input name="PrimaryMotivation" type="radio" value="1"<cfif Attributes.PrimaryMotivation EQ TRUE> checked</cfif> /></td>
                                            <td width="30">Yes</td>
                                            <td width="20"><input name="PrimaryMotivation" type="radio" value="0"<cfif Attributes.PrimaryMotivation EQ FALSE> checked</cfif> /></td>
                                            <td width="130">No</td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="FieldLabel">Organization Type:</td>
                                <td class="FieldInput">
                                    <cfset qOrgType = Application.List.OrgType>
                                    <select name="OrgTypeID" id="OrgTypeID">
                                        <cfloop query="qOrgType">
                                        <option value="#qOrgType.OrgTypeID#">#qOrgType.Name#</option>
                                        </cfloop>
                                    </select>
                                </td>
                            </tr>
                            <tr id="OrgTypeOther" style="display:none;">
                                <td class="FieldLabel">Organization type, other:</td>
                                <td class="FieldInput"><input name="OrgTypeOther" type="text" value="#Attributes.OrgTypeOther#" maxlength="50" /></td>
                            </tr>
                            <tr>
                                <td class="FieldInput"><input type="submit" value="Submit Registration" name="submit" /></td>
                            </tr>
						</table>
						</form>
						<div style="height:4px;"></div>
						<div id="info_box_blue">
						Public Burden Statement: The information on this form is collected under the authority of 42 U.S.C., Section 243 (CDC). The requested information is used only to process your training registration and will be disclosed only upon your written request. Continuing education credit can only be provided when all requested information is submitted. Furnishing the information requested on this form is voluntary.<br />
							<br />
							Public reporting burden of this collection of information is estimated to average 5 minutes per response, including the time for reviewing instructions, searching existing data sources, gathering and maintaining the data needed, and completing and reviewing the collection of information. An agency may not conduct or sponsor, and a person is not required to respond to a collection of information unless it displays a currently valid OMB control number. Send comments regarding this burden estimate or any other aspect of this collection of information, including suggestions for reducing burden to CDC/ATSDR Reports Clearance Officer; 1600 Clifton Road NE, MS D-74, Atlanta, Georgia 30333; ATTN: PRA (0920-0017).
						</div>
						<div style="height:20px;"></div>
					</td>
				</tr>
			</table>
		</td></cfoutput>
		
	</tr>
</table>
</body>
</html>
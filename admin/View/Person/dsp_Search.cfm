<cfparam name="Attributes.ActivityID" default="">
<cfparam name="Attributes.PersonID" default="">
<script>
	$(document).ready(function() {
		<cfif Attributes.PersonID NEQ "">
		<cfoutput>
		var nPerson = #Attributes.PersonID#;
		</cfoutput>
		</cfif>
		$("input").unbind("keyup");
		$("select").unbind("change");
		$("#LastName").focus();
		
		$(".PersonAdder").click(function() {
			parent.setPerson<cfoutput>#Attributes.Instance#</cfoutput>(this.id);
		});
		
		$("#KeepOpen").click(function() {
			if($("#KeepOpen").attr('checked')) {
				$.post(sRootPath + "/_com/UserSettings.cfc?method=setPersonFinderOpen&KeepOpen=true");
			} else {
				$.post(sRootPath + "/_com/UserSettings.cfc?method=setPersonFinderOpen&KeepOpen=false");
			}
		});
		
		<cfif Attributes.PersonID NEQ "">
			parent.setPerson<cfoutput>#Attributes.Instance#</cfoutput>(nPerson);
		</cfif>
		
		$("#PhotoUpload").dialog({ 
			title:"Upload Photo",
			modal: false, 
			autoOpen: false,
			height:120,
			width:450,
			resizable: false,
			open:function() {
				$("#PhotoUpload").show();
			}
		});
		
		$("img.PersonPhoto").click(function() {
			var nCurrPerson = $.Replace(this.id,"Photo","","ALL");
			$("#frmUpload").attr("src",sMyself + "Person.PhotoUpload?PersonID=" + nCurrPerson + "&ElementID=" + this.id);
			$("#PhotoUpload").dialog("open");
		});
	});
</script>
<cfif Attributes.Fuseaction EQ "Person.Finder">
<!--- person finder specific styles --->
<style type="text/css">
	.headerTop { display:none; }
	h1 { display:none; }
</style>
</cfif>


<cfoutput>
<div class="clearfix headerTop">
<div class="action_bar" style="float:right;">
	<a href="#myself#person.create?id=0" class="btn" bindpoint="root" style="text-decoration: none; float: right;"><i style="background-position: -4px -361px;" class="img"></i>
	  <span>New Person</span>
	</a>
</div>
	<div><h1>People<span>Manage person records, print transcripts, etc.</span></h1></div>
</div>
</cfoutput>
<div class="ContentBody">
	<div class="ViewSection">
		<cfif Attributes.Fuseaction NEQ "Person.Finder"><h3>Find a person</h3></cfif>
	<cfoutput>
	<form name="frmSearch" method="post" action="#myself##xfa.SearchSubmit#">
	<cfif Attributes.Fuseaction NEQ "Person.Finder"><fieldset class="horiz-form"></cfif>
		<table width="100%" cellspacing="0" cellpadding="0" border="0">
			<tr>
				<td colspan="2" class="FieldFloater">
					<span><input type="text" name="LastName" id="LastName" value="#Attributes.LastName#" style="width:70px;" /><label for="LastName">Last Name</label></span>
					<span><input type="text" name="FirstName" id="FirstName" value="#Attributes.FirstName#" style="width:70px;" /><label for="FirstName">First Name</label></span>
					<span><input type="text" name="SSN" id="SSN" maxlength="4" value="#Attributes.SSN#" style="width:35px;" /><label for="SSN">SSN(4)</label></span>
					<span><input type="text" name="Birthdate" id="date1" value="#Attributes.Birthdate#" style="width:70px;" /><label for="Birthdate">Birthdate</label></span>
					<span><input type="text" name="Email" id="Email" value="#Attributes.Email#" style="width:200px;" /><label for="Email">Email</label></span>
					<input type="hidden" name="ActivityID" value="#Attributes.ActivityID#" />
					<span><input type="submit" name="Submit" value="Search" class="btn" /></span>
					<cfif Attributes.Fuseaction NEQ "Person.Home"><span style="padding:4px;"><a href="#myself#Person.Create?Instance=#Attributes.Instance#&Mode=Insert&ActivityID=#Attributes.ActivityID#">Create a person</a></span></cfif>
					<input type="hidden" name="Search" value="1" /><input type="hidden" name="Instance" value="#Attributes.Instance#" />
				</td>
			</tr>
		</table>
	<cfif Attributes.Fuseaction NEQ "Person.Finder"></fieldset></cfif>
	</form>
	</cfoutput>
	<cfif isDefined("qPeople") AND qPeople.RecordCount GT 0>
	<cfif PeoplePager.getTotalNumberOfPages() GT 1><div><cfoutput>#PeoplePager.getRenderedHTML()#</cfoutput></div></cfif>
	<table border="0" width="100%" cellpadding="0" cellspacing="0" class="ViewSectionGrid">
		<tbody>
			<cfoutput query="qPeople" startrow="#PeoplePager.getStartRow()#" maxrows="#PeoplePager.getMaxRows()#">
				<tr>
					<cfif Attributes.Fuseaction EQ "Person.Finder">
					<td width="16"><a href="javascript:void(0);" class="PersonAdder" id="#qPeople.PersonID#|#LastName#, #FirstName# #MiddleName#"><img src="#Application.Settings.RootPath#/_images/icons/Add.png" border="0" /></a></td>
					<td width="220">#LastName#, #FirstName# #MiddleName# <span style="font-size:12px;color:##888;">(#DisplayName#)</span></td>
					<td><cfif Email NEQ "">#Email#<cfelse>&nbsp;</cfif></td>
					<td><cfif Birthdate NEQ "">#DateFormat(Birthdate,"mm/dd/yyyy")#</cfif></td>
					<cfelse>
					<td height="30" width="30" style="text-align:center;"><cfif FileExists(ExpandPath(".\_uploads\PersonPhotos\#PersonID#.jpg"))><img src="/_uploads/PersonPhotos/#PersonID#.jpg" id="Photo#PersonID#" class="PersonPhoto" style="width:30px;height:30px;" /><cfelse><img src="#Application.Settings.RootPath#/_images/icon_<cfif Gender EQ "F">female<cfelse>male</cfif>.gif" id="Photo#PersonID#" class="PersonPhoto" style="width:30px;height:30px;" /></cfif></td>
					<td class="ActivityListing">
						<h4 style="margin:2px 0px;font-size:15px;"><a href="#myself#Person.Detail?PersonID=#PersonID#">#LastName#, #FirstName# #MiddleName# <span style="font-size:12px;color:##888;">(#DisplayName#)</span></a></h4>
						<div style="font-size:12px; color:##555;">
						
						<div><cfif Email NEQ ""><strong>Email:</strong> <a href="mailto:#Email#" style="font-size:13px; font-weight:normal; text-decoration:none; color:##888;">#Email#</a></cfif><cfif Birthdate NEQ ""> <strong>Birthdate:</strong> #DateFormat(Birthdate,"mm/dd/yyyy")#</cfif></div>
						
						</div>
					</td>
					</cfif>
				</tr>
			</cfoutput>
		</tbody>
	</table>
	<cfif PeoplePager.getTotalNumberOfPages() GT 1><div><cfoutput>#PeoplePager.getRenderedHTML()#</cfoutput></div></cfif>
	<cfelse>
		<cfquery name="qList" datasource="#application.settings.dsn#">
			/* MOST RECENTLY MODIFIED ACTIVITIES */
			WITH CTE_MostRecent AS (
			SELECT H.ToPersonID,MAX(H.Created) As MaxCreated
			FROM ce_History H
			WHERE H.FromPersonID=<cfqueryparam value="#session.personid#" cfsqltype="cf_sql_integer" /> AND isNull(H.ToPersonID,0) <> 0
			GROUP BY H.ToPersonID
			) SELECT * FROM CTE_MostRecent M INNER JOIN ce_Person A  ON A.PersonID=M.ToPersonId
			WHERE A.DeletedFlag='N'
			ORDER BY M.MaxCreated DESC
		</cfquery>
	<cfoutput>
	<h3 style="background-color:##555;">Your Recent Persons</h3>
	<table border="0" width="100%" cellpadding="0" cellspacing="0" class="ViewSectionGrid">
		<tbody>
			<cfloop query="qList">
				<tr>
					<cfif attributes.fuseaction eq "person.finder">
					<td width="20"><a href="javascript:void(0);" class="PersonAdder" id="#qList.PersonID#|#LastName#, #FirstName# #MiddleName#"><img src="#Application.Settings.RootPath#/_images/icons/Add.png" border="0" /></a></td>
					
					</cfif>
					<td style="vertical-align:middle;">
						 <a href="#myself#person.detail?personid=#qList.personid#" style="font-weight: normal; font-size: 12px; display: block; position: relative; line-height: 24px;">
						#LastName#, #FirstName# #MiddleName# <span style="font-size:12px;color:##888;">(#DisplayName#)</span> modified on #DateFormat(MaxCreated,'mm/dd/yyyy')# at #TimeFormat(MaxCreated,'h:mm TT')#
						</a>
					</td>
				</tr>
			</cfloop>
		</tbody>
	</table>
	</cfoutput>
	</cfif>
	</div>
	<div id="PhotoUpload" style="display:none;">
		<iframe width="440" height="110" scrolling="no" src="" frameborder="0" id="frmUpload"></iframe>
	</div>
</div>
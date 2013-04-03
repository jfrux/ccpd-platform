<cfset UsedCats = "">
<cfset qActCats = Application.Com.ActivityCategoryGateway.getByViewAttributes(ActivityID=Attributes.ActivityID,DeletedFlag='N')>
<cfset qCats = Application.Com.CategoryGateway.getByAttributes(OrderBy="Name")>
<cfset qPersonalCats = Application.Com.CategoryGateway.getByCookie(TheList=Cookie.USER_Containers,OrderBy="Name")>
<cfset defaultValues = [] />
<cfloop query="qActCats">
	<cfset cat = {
		name: qActCats.Name,
		label: qActCats.Name,
		value:qActCats.categoryid
	} />

	<cfset defaultValues.add(cat) />
</cfloop>
<script>
$(document).ready(function() {
	var defaultValues = <cfoutput>#serializeJson(defaultValues)#</cfoutput>;
	App.activity.folders.init(defaultValues);
});
</script>

<cfoutput>

<h3><i class="fg fg-folder-horizontal"></i> Folders</h3>
<div class="box containerBox">
	<div class="row-fluid">
	<input type="text" class="js-ui-tokenizer js-tokenizer-list" style="width:157px;" name="folder-input" />
	
	</div>
<!--- 	<div style="position:relative;clear:both;display:block;height:30px;">
	<select name="CatAdder" id="CatAdder" class="CatAdder" style="position: absolute; left: 3px; width: 123px; top: -1px;">
		<option value="" selected>Add Folder</option>
		<cfif qPersonalCats.RecordCount GT 0>
		<option value="0">---- Your Folders ----</option>
			<cfloop query="qPersonalCats">
			<cfif NOT ListFind(UsedCats,qPersonalCats.CategoryID,",")><option value="#qPersonalCats.CategoryID#">#qPersonalCats.Name#</option></cfif>
			</cfloop>
		<option value="0">--- All Other Folders ----</option>
		</cfif>
		<cfloop query="qCats">
			<cfif NOT ListFind(Cookie.USER_Containers,qCats.CategoryID,",") AND NOT ListFind(UsedCats,qCats.CategoryID,",")><option value="#qCats.CategoryID#">#qCats.Name#</option></cfif>
		</cfloop>
	</select><a href="javascript://" id="NewCatLink" title="Create a new container..." style="position: absolute; right: 3px;"><img src="#Application.Settings.RootPath#/_images/icons/asterisk_orange.png" border="0" /></a>
	</div> --->
</div>
</cfoutput>
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
var defaultValues = <cfoutput>#serializeJson(defaultValues)#</cfoutput>;
App.module("Activity.Folders").start(defaultValues);
</script>

<cfoutput>
<h3><i class="fg fg-folder-horizontal"></i> Folders</h3>
<div class="box containerBox">
	<div class="row-fluid">
		<input type="text" class="js-ui-tokenizer js-tokenizer-list" style="width:157px;" name="folder-input" />
	</div>
</div>
</cfoutput>
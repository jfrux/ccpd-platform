<cfset UsedCats = "">
<cfset qActCats = Application.Com.ActivityCategoryGateway.getByViewAttributes(ActivityID=Attributes.ActivityID,DeletedFlag='N')>
<cfset qCats = Application.Com.CategoryGateway.getByAttributes(OrderBy="Name")>
<cfset qPersonalCats = Application.Com.CategoryGateway.getByCookie(TheList=Cookie.USER_Containers,OrderBy="Name")>
<cfset defaultValues = [

] />
<cfloop query="qActCats">
	<cfset cat = {
		name: qActCats.Name,
		label: qActCats.Name,
		value:qActCats.categoryid
	} />

	<cfset arrayAppend(defaultValues,cat) />
</cfloop>
<script>

function saveActCat(oCategory) {
	$.post(sRootPath + "/_com/AJAX_Activity.cfc", { 
		method: "saveCategory", 
		ActivityID: nActivity, 
		CategoryID:oCategory.ITEM_ID, 
		returnFormat:"plain" 
	},
		function(data){
			var cleanData = $.trim(data);
			status = $.ListGetAt(cleanData,1,"|");
			statusMsg = $.ListGetAt(cleanData,2,"|");
			
			if(status == 'Success') {
				addMessage(statusMsg,250,6000,4000);
				//$("#Containers").html("");
				//updateContainers();
				//updateActions();
			} else if(status == 'Fail') {
				addError(statusMsg,250,6000,4000);
				//$("#CatAdder").val("");
			}
	});
}

$(document).ready(function() {
	$(".js-tokenizer-list").uiTokenizer({
		listLocation:"top",
		type:"list",
		watermarkText:"Type to Add Folder",
		ajaxAddURL: "/admin/_com/AJAX_Activity.cfc",
		ajaxAddParams:{
			'method':'createCategory'
		},
		ajaxSearchURL:"/admin/_com/ajax/typeahead.cfc",
		ajaxSearchParams:{
			'method':'search',
			'type':'folders'
		},
		onSelect:function(i,e) {
			saveActCat(e);
			return true;
		}
		,
		onAdd:function(i,e) {
			//createNewCat(e);
			return true;
		},
		onRemove:function(i,e) {
			removeCat(e);
			return true;
		},
		defaultValue:<cfoutput>#serializeJson(defaultValues)#</cfoutput>
	});
<!---	<cfif request.browser DOES NOT CONTAIN "MSIE">
	$("[title]").mbTooltip({
		opacity : .90, //opacity
		wait:500, //before show
		ancor:"mouse", //"parent"
		cssClass:"default", // default = default
		timePerWord:70, //time to show in milliseconds per word
		hasArrow:false,
		color:"white",
		imgPath:"images/",
		shadowColor:"black",
		fade:500
	});
	</cfif>--->
	
	/* CATEGORY MANAGEMENT */
	$("#CatAdder").val("");
	
	$(".CatAdder").change(function() {
		if($(this).val() != '') {
			saveActCat(this);
		}
	});
	
	createNewCat = function(oCategory) {
		var CatTitle = prompt("Container Name:", "");
		
		if(CatTitle) {
			$.getJSON(sRootPath + "/_com/AJAX_Activity.cfc", { method: "createCategory", Name: CatTitle, ReturnFormat:"plain" },
				function(data) {
					if(data.STATUS) {
						$("#CatAdder").addOption(data.DATASET[0].CATEGORYID, CatTitle);
						$("#CatAdder").val(data.DATASET[0].CATEGORYID);
						saveActCat($("#CatAdder"));
					} else {
						addError(statusMsg,250,6000,4000);
					}
			});
		}
	};
	
	removeCat = function(oCategory) {
		console.log('removing category:')
		console.log(oCategory);
		var CatID = oCategory.value
		var CatName = oCategory.label
		
		if (confirm('Are you sure you want to remove the activity from the container \'' + CatName + '\'?')) {
			$.post(sRootPath + "/_com/AJAX_Activity.cfc", { 
					method: "deleteCategory", 
					ActivityID: nActivity, 
					CategoryID: CatID, 
					returnFormat:"plain" 
				},
			  	function(data){
					if(data.STATUS) {
						updateContainers();
						updateActions();
						addMessage(data.STATUSMSG,250,6000,4000);
			
						$("#CatRow" + CatID).remove();
						$("#CatAdder").val("");
					} else {
						addMessage(data.STATUSMSG,250,6000,4000);
					}
			});
		}
	}
});
</script>

<cfoutput>

<h3><i class="fg fg-folder-horizontal"></i> Folders</h3>
<div class="box containerBox">
	<div class="row-fluid">
	<input type="text" class="js-ui-tokenizer js-tokenizer-list" style="width:168px;" name="folder-input" />
	
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
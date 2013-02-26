<cfparam name="Attributes.InstanceName" default="" />
<cfparam name="Attributes.GroupID" default="" />
<cfparam name="Attributes.GroupExclude" default="N" />
<cfparam name="Attributes.Submitted" default="0" />
<cfparam name="Attributes.Type" default="Add" />
<cfparam name="Attributes.ListMethod" default="" />
<cfparam name="Attributes.ListFields" default="" />
<cfoutput>
<script type="text/javascript">
var #Attributes.InstanceName#Filtered = '';
var #Attributes.InstanceName#FieldList = '#Attributes.ListFields#';
var #Attributes.InstanceName#CurrPage = 1;
var #Attributes.InstanceName#CurrDisplay = 25;

jQuery().ready(function(){
	document.#Attributes.InstanceName#frmLookup.elements[0].focus();
	$("###Attributes.InstanceName#frmLookup").submit(function(){   
		#Attributes.InstanceName#filterData(#Attributes.InstanceName#FieldList);
		return false;
	});
});

var #Attributes.InstanceName#baseurl = "#Application.Settings.RootPath#/_com/Listing.cfc?returnFormat=json&queryFormat=column&method=#Attributes.ListMethod#";

function #Attributes.InstanceName#getURL() {
   var #Attributes.InstanceName#s = #Attributes.InstanceName#baseurl;
   #Attributes.InstanceName#s+="&PageIndex="+#Attributes.InstanceName#CurrPage;
   #Attributes.InstanceName#s+="&PageSize="+#Attributes.InstanceName#CurrDisplay;
   #Attributes.InstanceName#s+=#Attributes.InstanceName#Filtered;
   return #Attributes.InstanceName#s;
}

var #Attributes.InstanceName#mydata = new Spry.Data.JSONDataSet(#Attributes.InstanceName#getURL(),{path:"DATA", pathIsObjectOfArrays:true,useCache:false});

Spry.Data.Region.debug=false;
function #Attributes.InstanceName#goBack() {
   #Attributes.InstanceName#CurrPage=#Attributes.InstanceName#CurrPage-#Attributes.InstanceName#CurrDisplay;
   if(#Attributes.InstanceName#CurrPage < 1) #Attributes.InstanceName#CurrPage=1;
   #Attributes.InstanceName#mydata.setURL(#Attributes.InstanceName#getURL());
   #Attributes.InstanceName#mydata.loadData();   
}

function #Attributes.InstanceName#goForward() {
   #Attributes.InstanceName#CurrPage=#Attributes.InstanceName#CurrPage+#Attributes.InstanceName#CurrDisplay;
   #Attributes.InstanceName#mydata.setURL(#Attributes.InstanceName#getURL());
   #Attributes.InstanceName#mydata.loadData(); 
   
}

function #Attributes.InstanceName#filterData(#Attributes.InstanceName#FieldNames) {
	#Attributes.InstanceName#FieldNames = $.ListToArray(#Attributes.InstanceName#FieldNames);
	
	#Attributes.InstanceName#Filtered='';
	#Attributes.InstanceName#CurrPage = 1;
	#Attributes.InstanceName#CurrDisplay = 25;
	for (i=0;i<#Attributes.InstanceName#FieldNames.length;i++) {
		#Attributes.InstanceName#Filtered+="&" + #Attributes.InstanceName#FieldNames[i] + "=" + $('##' + #Attributes.InstanceName#FieldNames[i]).attr("value");
	}
	#Attributes.InstanceName#mydata.setURL(#Attributes.InstanceName#getURL());
	#Attributes.InstanceName#mydata.loadData();
}

</script>

<div style="padding:5px;">
<div class="ContentBody">
<form action="" id="#Attributes.InstanceName#frmSearch" name="#Attributes.InstanceName#frmLookup" class="MainForm">
<table width="100%" cellspacing="0" cellpadding="0" border="0">
	<tr>
		<td colspan="2" class="FormSection">
			<span><input type="text" name="LastName" class="field text" id="#Attributes.InstanceName#LastName" style="width:100px;" /><label for="#Attributes.InstanceName#LastName">Last Name</label></span>
			<span><input type="text" name="FirstName" class="field text" id="#Attributes.InstanceName#FirstName" style="width:100px;" /><label for="#Attributes.InstanceName#FirstName">First Name</label></span>
			<span><input type="image" src="#Application.Settings.RootPath#/_images/magnifier.gif" value="submit" /></span>
		</td>
	</tr>
</table>
</form>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="DataGrid" id="Results">
	<thead>
		<tr>
			<th><a href="javascript:void(0);">Person Name</a></th>
			<th width="25"><a href="javascript:void(0);">&nbsp;</a></th>
		</tr>
	</thead>
	<tbody id="#Attributes.InstanceName#DataLoop">
		
	</tbody>
</table>

</div>
</div>
</cfoutput>
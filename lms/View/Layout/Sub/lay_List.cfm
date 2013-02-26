<cfparam name="Request.InstanceName" default="">
<cfparam name="Request.ListForm" default="">
<cfparam name="Request.ListResults" default="">
<cfparam name="Request.ListFields" default="">
<cfparam name="Request.ListMethod" default="">
<script type="text/javascript" src="/lms/_scripts/Spry/Includes/SpryData.js"></script>
<script type="text/javascript" src="/lms/_scripts/Spry/Includes/SpryJSONDataSet.js"></script>
<cfoutput>
<script type="text/javascript">
var Filtered = '';
var FieldList = '#Request.ListFields#';
var CurrPage = 1;
var CurrDisplay = 25;

jQuery().ready(function(){
	document.frmLookup.elements[0].focus();
	filterData(FieldList);
	$("##frmLookup").submit(function(){   
		filterData(FieldList);
		return false;
	});
});

var baseurl = "/lms/_com/Listing.cfc?returnFormat=json&queryFormat=column&method=#Request.ListMethod#";

function getURL() {
   var s = baseurl;
   s+="&PageIndex="+CurrPage;
   s+="&PageSize="+CurrDisplay;
   s+=Filtered;
   return s;
}

var mydata = new Spry.Data.JSONDataSet(getURL(),{path:"DATA", pathIsObjectOfArrays:true,useCache:false});

Spry.Data.Region.debug=false;
function goBack() {
   CurrPage=CurrPage-CurrDisplay;
   if(CurrPage < 1) CurrPage=1;
   mydata.setURL(getURL());
   mydata.loadData();   
}

function goForward() {
   CurrPage=CurrPage+CurrDisplay;
   mydata.setURL(getURL());
   mydata.loadData(); 
   
}

function filterData(FieldNames) {
	FieldNames = $.ListToArray(FieldNames);
	
	Filtered='';
	CurrPage = 1;
	CurrDisplay = 25;
	for (i=0;i<FieldNames.length;i++) {
		Filtered+="&" + FieldNames[i] + "=" + $('##' + FieldNames[i]).attr("value");
	}
	mydata.setURL(getURL());
	mydata.loadData();
}

</script>
<form action="" method="POST" name="frmLookup" id="frmLookup" class="MainForm">
#Request.ListForm#
</form>
<div class="DataGridPager"><a href="javaScript:goBack()"><img src="/lms/_images/control_rewind_blue.gif" border="0" align="absmiddle" /> Previous</a>&nbsp;&nbsp;&nbsp;
	<a href="javaScript:goForward()">Next <img src="/lms/_images/control_fastforward_blue.gif" border="0" align="absmiddle" /></a></div>
<div id="mydata" spry:region="mydata">
		<table spry:state="loading" id="LoadingTable" class="RSSItemListFeedback">
			<tr><td class="RSSItemListLoading" valign="middle" align="center"><img src="/lms/_images/loading.gif" border="0" align="absmiddle" /> Please Wait ...</td></tr></table>
#Request.ListResults#
</div>
</cfoutput>
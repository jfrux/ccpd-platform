<cfparam name="Attributes.q" default="" />
<cfparam name="Attributes.type" default="all" />
<cfparam name="Attributes.YearStart" default="1902" />
<cfparam name="Attributes.YearEnd" default="#Year(now())+1#" />
<cfparam name="Attributes.Make" default="" />
<cfparam name="Attributes.Model" default="" />
<cfparam name="Attributes.Category" default="" />

<cfsavecontent variable="feattmpl">
<div class="mbm detailedsearch_result clearfix">
	<div class="UIImageBlock clearfix">
		<a href="${LINK}" class="UIImageBlock_Image UIImageBlock_ICON_Image">
		<img alt="" src="${IMAGE}" class="img">
		</a>
		<div class="pls UIImageBlock_Content UIImageBlock_ICON_Content">
			<div class="clearfix"><!---
				<div class="rfloat">
				<a href="#" role="button" class="uiButton">
				<i class="mrs img sp_40t2mn sx_d790f5"></i>
				<span class="uiButtonText">Like</span></a></div>--->
				<div>
					<div class="fsl fwb fcb">
					<a href="${LINK}">${TEXT}</a>
					</div>
					<div class="fsm fwn fcg">
						<div class="fsm fwn fcg">${SUBTEXT1}</div>
						<div class="fsm fwn fcg">${SUBTEXT2}</div>
					</div>
				</div>
			</div>
			<div></div>
		</div>
	</div>
</div>
</cfsavecontent>
<cfsavecontent variable="linktmpl">
<li>
<cfoutput><a href="#myself#main.search?q=#attributes.q#&type=${obj}"><span>${label}</span> <span>(${results})</span></a></cfoutput>
</li>
</cfsavecontent>
<script>
<cfoutput>
var sQueryString = #serializeJson(attributes.q)#;
var sType = #serializeJson(attributes.type)#;
var resultTmpl = #serializeJson(feattmpl)#;
var linkTmpl = #serializeJson(linktmpl)#;
</cfoutput>
var searchTypes = {
	'all':{
		'obj':'all',
		'label':'All Results',
		'results':0
	},
	'activity':{
		'obj':'activity',
		'label':'Activities',
		'results':0
	},
	'person':{
		'obj':'person',
		'label':'People',
		'results':0
	}
};

function setSearch(q,t) {
	$.ajax({
		url:'/admin/_com/ajax/typeahead.cfc',
		data:{
			'method':'search',
			'max':'1000',
			'q':q,
			'type':t
		},
		type:'get',
		dataType:'json',
		async:true,
		success:function(data) {
			var records = data.PAYLOAD.DATASET;
			/* BUILD NAV AND TOTALS */
			$.each(records,function(i,val) {
				var $itemMarkup = $.tmpl(resultTmpl,val).appendTo(".search-right");
				searchTypes[val.TYPE].results++;
				searchTypes.all.results++;
			});
			
			$.each(searchTypes,function(i,val) {
				var $links = $(".search-left ul");
				
				var $linkMarkup = $.tmpl(linkTmpl,val).appendTo($links);
			});
		}
	});
}
$(document).ready(function() {
	if(sQueryString.length) {
		$("#navSearch .ui-autocomplete-input").val(sQueryString);
	}
	
	<!---
	$(".filter-buttons li").click(function() {
		var $SearchName = $(this).children().attr('href').replace(sMyself + 'main.search?type=','');
		
		setSearch($SearchName);
		
		
		return false;
	});
	--->
	setSearch(sQueryString,sType);
	
	$(".filter-buttons li").live("click",function() {
		var sLocation = $(this).children('a').attr('href');
		window.location=sLocation;
	});
});
</script>
<cfoutput>
<h1>Search</h1>
<div class="ContentBody">
	
	<div class="search-head"> </div>
	<div class="search-body">
		<div class="search-left">
			<h4>FILTERS</h4>
			<div class="menu">
				<ul>
					
				</ul>
			</div>
		</div>
		<div class="search-right"> </div>
	</div>
</div>
</cfoutput>

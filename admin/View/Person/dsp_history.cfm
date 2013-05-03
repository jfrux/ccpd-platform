<script>

$(document).ready(function() {

var personId = <cfoutput>#attributes.personid#</cfoutput>;
var lister = new historyList({
		mode:"personAll",
		appendto:$(".ViewSection"),
		data:{
			personfrom:personId,
			personto:personId,
			startrow:1,
			maxrows:25
		}
	});

$(".history-filter ul li a").click(function() {
	var $link = $(this);
	var $parent = $link.parent();
	var mode = $parent.attr('id').replace('history-','');
	var label = $link.text();
	
	lister.setMode(mode);
	
	lister.getList(true);
	
	$(".ViewSection h3").text(label);
	$parent.siblings('.current').removeClass('current');
	$parent.addClass('current');
	return false;
});

lister.getList(true);
});

</script>

<div class="ViewSection">
<div class="history-filter">
	<ul>
		<li id="history-personAll" class="current"><a href="">All History</a></li>
		<li id="history-personFrom"><a href="">Actions</a></li>
		<li id="history-personTo"><a href="">Personal</a></li>
	</ul>
	<div style="clear:both;"></div>
</div>
</div>
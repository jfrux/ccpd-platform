<style>
.groupWrapper {
margin-right:2px;
padding-bottom:100px;
width:478px;
}
</style>

<script>
var lister = '';
function getListAuto() {
	var currTime = Math.round(new Date().getTime() / 1000);
	lister.getList(false,currTime,'prepend');
}

$(document).ready(function() {
	lister = new historyList({
			mode:"all",
			appendto:$(".ViewSection .historyItems"),
			data:{
				personfrom:currPersonId,
				personto:currPersonId,
				startrow:1,
				maxrows:25
			}
		});
	
	lister.getList(true);
	
	$(".history-filter ul li a").click(function() {
		var $link = $(this);
		var $parent = $link.parent();
		var mode = $parent.attr('id').replace('history-','');
		var label = $link.text();
		
		lister.setMode(mode);

		lister.getList(true);
		
		$(".ViewSection h3").text(label);
		$parent.siblings('.active').removeClass('active');
		$parent.addClass('active');
		return false;
	});
	
setInterval("getListAuto()",5000);
});
</script>
<h1>Latest Updates</h1>
<div class="ContentBody">
	
	<div class="ViewSection">
		<h3>All History</h3>
		<div class="history-filter">
		<ul class="nav">
			<li id="history-all" class="active"><a href="/admin/">All History</a></li>
			<li id="history-personFrom"><a href="/admin/">My Actions</a></li>
			<li id="history-personTo"><a href="/admin/">Personal History</a></li>
		</ul>
		<div class="historyItems" style="clear:both;"></div>
	</div>
	</div>
</div>
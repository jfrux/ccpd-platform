
<script>
var lister = '';
function getListAuto() {
	var currTime = Math.round(new Date().getTime() / 1000);
	lister.getList(false,currTime,'prepend');
}

setInterval("getListAuto()",5000);
</script>
<div class="newsfeed js-newsfeed"></div>
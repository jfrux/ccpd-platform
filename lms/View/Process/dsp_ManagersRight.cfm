<cfoutput>
<script type="text/javascript" src="/_scripts/RIA.funcs.js"></script>
<script type="text/javascript" src="/_scripts/Spry/Includes/SpryData.js"></script>
<script type="text/javascript" src="/_scripts/Spry/Includes/SpryJSONDataSet.js"></script>
<div class="MultiFormRight_SectTitle">What can I do?</div>
<div>
<div class="MultiFormRight_SectSubTitle">Add Manager</div>
<cf_cePersonFinder Label="Managers" Instance="Managers" DefaultName="Click Here To Lookup" DefaultID="" AddPersonFunc="saveManager();"> 
</div>
<div class="MultiFormRight_SectSubTitle">Delete Actions</div>
<div class="MultiFormRight_LinkList">
	<a href="javascript:void(0);" id="RemoveChecked">Remove Checked</a>
	<a href="javascript:void(0);" id="RemoveAll" style="color:##FF0000;">Remove All</a>
</div>
</cfoutput>
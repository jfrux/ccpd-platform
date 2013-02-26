<cfoutput>
<div class="MultiFormRight_SectTitle">What can I do?</div>
<div class="MultiFormRight_LinkList">
	<a href="javascript://" class="upload-add"><img src="#Application.Settings.RootPath#/_images/icons/disk.png" /> Upload document</a>
	<!---#jButton("Upload By Scanner","#myself#File.Scan?Mode=Person&amp;ModeID=#Attributes.PersonID#","scan")#--->
</div>
<div class="MultiFormRight_SectBody"></div>
</div>
<div class="MultiFormRight_SectSubTitle">Removal Options</div>
<div class="MultiFormRight_LinkList">
<a href="javascript:void(0);" id="RemoveChecked">Remove Checked</a>
<a href="javascript:void(0);" id="RemoveAll">Remove All</a>
</div>
</cfoutput>
<div class="ContentBlock">
	<h1>Grant Applications</h1>
	<cfsetting showdebugoutput="false" />
	<cfset topdirectory = "C:\Sites\grant_apps">
	<cfset baseurl = "#myself#main.grants">
	<cfparam name="attributes.dir" default="\" />
	<cfparam name="attributes.sort" default="datelastmodified desc">
	<cfset parentpath = GetDirectoryFromPath(attributes.dir).ReplaceFirst("([\\\/]){1}$", "") />
	<cfset parentlink = replace(parentpath,topdirectory,'') />
	<cfset physpath = topdirectory & replace(replace(attributes.dir,'/grants/',''),'/','\','ALL')>
	
	<cfoutput>
	#physpath#
	<a href="/grants/index.cfm?dir=#parentlink#">Go up directory</a>
	</cfoutput>
	<cfdirectory directory="#physpath#" action="list" name="dir" sort="#attributes.sort#">
	<cfset currdir = dir.directory />
	<cfset filelink = baseurl & replace(currdir,topdirectory,'') />
	<cfset filelink = replace(filelink,'\','/','ALL') />
	
	<cfoutput>#filelink#</cfoutput>
	<table width="100%" cellpadding="0" cellspacing="0">
		<tr>
			<th>Name <a href="?sort=name" class="sort" title="Sort By Name">?</a></th>
			<th>Size (bytes) <a href="?sort=size" class="sort" title="Sort By Size">?</a></th>
			<th>Last Modified <a href="?sort=datelastmodified+desc" class="sort" title="Sort By Date">?</a></th>
		</tr>
		<cfoutput query="dir">
			<cfset fullpath = dir.directory & "\" & dir.name>
			<cfset relativepath = replace(replace(fullpath,topdirectory,""),'\','/','ALL')>
		<cfif NOT fileExists(fullpath)>
			<cfset filelink = "#baseurl#?dir=#relativepath#">
		<cfelse>
			<cfset filelink = "#baseurl#?" & relativepath />
		</cfif>
		<cfif dir.name IS NOT "index.cfm">
		<tr>
			<td><a href="#filelink#" class="file-link"><img src="/grants/_icons/#getExtension(dir.name)#.png" style="width:24px;" />#dir.name#</a></td>
			<td>#dir.size#</td>
			<td>#dir.datelastmodified#</td>
		</tr>
		</cfif>
		</cfoutput>
	</table>
	<cfscript>
	/**
	* Returns extension defined by all characters following last period.
	* v2 by Ray Camden
	* 
	* @param name      File name to use. (Required)
	* @return Returns a string. 
	* @author Alexander Sicular (as867@columbia.edu) 
	* @version 2, May 9, 2003 
	*/
	function getExtension(name) { 
	if(find(".",name)) return listLast(name,".");
	else return "";
	}
	</cfscript>
</div>
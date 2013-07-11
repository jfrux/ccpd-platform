<cfparam name="Attributes.Submitted" default="">
<cfif Attributes.Submitted NEQ "">
	<cfset var path = "\public\system\photos\" />

	<cftry>
    	<cfif NOT DirectoryExists("#ExpandPath(path)#")>
        	<cfdirectory action="create" directory="#ExpandPath(path)#">
        </cfif>
        
		<cffile
			action="upload"
			destination="#ExpandPath(path & '#Attributes.PersonID#.jpg')#"
			filefield="PhotoFile"
			nameconflict="overwrite" accept="image/jpg,image/jpeg,image/pjpeg,image/pjpg" />
		
		<cfcatch>
			<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Error Uploading File: #CFCATCH.Message#","|")>
		</cfcatch>
	</cftry>
	
	<cfif Request.Status.Errors EQ "">
		<cfset oImage = ImageRead(ExpandPath(path & "#Attributes.PersonID#.jpg"))>
		<cfset sImageInfo = ImageInfo(oImage)>
		
		<cfif sImageInfo.height GT 100 OR sImageInfo.width GT 100>
		<cfset ImageScaleToFit(oImage, 100, 100, "highestQuality")>
		</cfif>
		<cfset newImgName = hash('person_' & attributes.personId & '_primary_' & dateFormat(now(), "yyyymmdd") & timeFormat(now(), 'HHmmss'), 'md5')>
		<cfset ImageWrite(oImage,ExpandPath(path & "#newImgName#.jpg"),1)>
		<cfset fileDelete(ExpandPath(path & '#Attributes.PersonID#.jpg'))>

    	<cfset var primaryPhotoSaved = application.person.savePrimaryPhoto(personId=attributes.personId, photoName=newImgName & '.jpg') />
	
		<cflocation url="#myself#Person.PhotoUpload?PersonID=#Attributes.PersonID#&Insert=1&ElementID=#Attributes.ElementID#" addtoken="no" />
	<cfelse>
		<cfoutput><font color="##FF0000">#Request.Status.Errors#</font></cfoutput>
	</cfif>
</cfif>
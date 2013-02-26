<cfparam name="Attributes.Submitted" default="">

<cfif Attributes.Submitted NEQ "">
	<cftry>
    	<cfif NOT DirectoryExists("#ExpandPath('.\_uploads\PersonPhotos\_original\')#")>
        	<cfdirectory action="create" directory="#ExpandPath('.\_uploads\PersonPhotos\_original\')#">
        </cfif>
        
		<cffile
			action="upload"
			destination="#ExpandPath('.\_uploads\PersonPhotos\_original\#Attributes.PersonID#.jpg')#"
			filefield="PhotoFile"
			nameconflict="overwrite" accept="image/jpg,image/jpeg,image/pjpeg,image/pjpg" />
		
		<cfcatch>
			<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Error Uploading File: #CFCATCH.Message#","|")>
		</cfcatch>
	</cftry>
	
	<cfif Request.Status.Errors EQ "">
		<cfset oImage = ImageRead(ExpandPath("./_uploads/PersonPhotos/_original/#Attributes.PersonID#.jpg"))>
		<cfset sImageInfo = ImageInfo(oImage)>
		
		<cfif sImageInfo.height GT 100 OR sImageInfo.width GT 100>
		<cfset ImageScaleToFit(oImage, 100, 100, "highestQuality")>
		</cfif>
		<cfset ImageWrite(oImage,ExpandPath("./_uploads/PersonPhotos/#Attributes.PersonID#.jpg"),1)>
	
		<cflocation url="#myself#Person.PhotoUpload?PersonID=#Attributes.PersonID#&Insert=1&ElementID=#Attributes.ElementID#" addtoken="no" />
	<cfelse>
		<cfoutput><font color="##FF0000">#Request.Status.Errors#</font></cfoutput>
	</cfif>
</cfif>
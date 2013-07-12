<cfcomponent displayname="Upload" output="no">
    <cfinclude template="/_com/_UDF/getExtension.cfm" />

    <cffunction name="init" access="public" output="no" returntype="_com.upload">
        <cfreturn this />
    </cffunction>
    
    <cffunction name="start" access="public" output="no" returnformat="plain">
        <cfargument name="photo" type="any" required="yes">
        <cfargument name="photo_type" type="any" required="no" default="primary">
        <cfargument name="entity_type" type="any" required="yes">
        <cfargument name="entity_id" type="any" required="yes">

        <cfset var path = "\public\system\photos\" />
        <cfset var status = createObject("component","#Application.Settings.Com#returnData.buildStruct").init()>
    
        <cfset status.setStatus(false)>
        <cfset status.setStatusMsg('Cannot upload photo for unknown reasons.')>
        
        <cftry>
            <cfif NOT DirectoryExists("#ExpandPath(path)#")>
                <cfdirectory action="create" directory="#ExpandPath(path)#">
            </cfif>
              
            <cffile
                action="upload"
                destination="#ExpandPath(path & arguments.entity_type & "_" & arguments.entity_id & '.jpg')#"
                filefield="PhotoFile"
                nameconflict="overwrite" accept="image/jpg,image/jpeg,image/pjpeg,image/pjpg" />
          
            <cfcatch>
                <cfset status.setStatusMsg('Error Uploading File: ' & cfcatch.message)>
                <cfreturn status />
            </cfcatch>
        </cftry>
        
        <cfset oImage = ImageRead(ExpandPath(path & arguments.entity_type & "_" & arguments.entity_id & ".jpg"))>
        <cfset sImageInfo = ImageInfo(oImage)>
        
        <cfset hashedFileName = hash(arguments.entity_type & '_' & arguments.entity_id & '_' & arguments.photo_type & '_' & dateFormat(now(), "yyyymmdd") & timeFormat(now(), 'HHmmss'), 'md5')>
        <cfset ImageWrite(oImage,ExpandPath(path & hashedFileName & '.jpg'),1)>
        <cfset fileDelete(ExpandPath(path & arguments.entity_type & "_" & arguments.entity_id & '.jpg'))>

        <cfset status.setData(imageHandler(hashedFileName, arguments.entity_type, arguments.entity_id, arguments.photo_type, path))>

        <cfreturn status />
    </cffunction>
    
    <cffunction name="imageHandler" access="public" output="no">
        <cfargument name="hashedFileName" type="string" required="yes" />
        <cfargument name="entity_type" type="string" required="yes" />
        <cfargument name="entity_id" type="string" required="yes" />
        <cfargument name="photo_type" type="string" required="yes" />
        <cfargument name="path" type="string" required="no" default="\public\system\photos\" />
        
        <!--- variables --->
        <cfset var imagePath = ExpandPath(arguments.path)>

        <!--- RESIZE --->
        <cfset oImage = ImageRead("#imagePath##arguments.hashedFileName#.jpg")>
        <cfset ImageSetAntialiasing(oImage,"on")>
        <cfset imgSizes = {
                'f': {
                    'size': 650
                },
                'p': {
                    'size': 220
                },
                'a': {
                    'size': 130
                },
                't': {
                    'size': 94
                },
                'i': {
                    'size': 52
                }
            } />

        <cfset oImageInfo = ImageInfo(oImage)>
        <cfset imgData = {} />
        <cfset imgData['hash'] = arguments.hashedFileName>
        <cfset imgData['path'] = replace(arguments.path, "\", "/", "ALL")>

        <cfloop collection="#imgSizes#" item="current">
            <cfif oImageInfo.width GTE imgSizes[current]['size']>
                <cfset ImageScaleToFit(oImage, imgSizes[current]['size'], "","highestquality")>
            </cfif>
            <cfset currName = imgData.hash & "_" & current & '.jpg'>
            <cfset ImageWrite(oImage, imagePath & currName)>

            <cfset imgData[current] = currName />
        </cfloop>

        <cfreturn imgData />
    </cffunction>
</cfcomponent>
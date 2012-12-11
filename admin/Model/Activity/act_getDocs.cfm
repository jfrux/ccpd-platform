<cfset qFileList = Application.Com.FileGateway.getByViewAttributes(ActivityID=Attributes.ActivityID,DeletedFlag='N',OrderBy='FileTypeID')>

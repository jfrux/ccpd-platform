<cfset qFileList = Application.Com.FileGateway.getByViewAttributes(PersonID=Attributes.PersonID,DeletedFlag='N',OrderBy='FileTypeID')>

<cfparam name="Attributes.CommentType" default="P" />

<cfswitch expression="#Attributes.CommentType#">
	<!--- PENDING CASE --->
	<cfcase value="P">
        <cfquery name="qComments" datasource="#Application.Settings.DSN#">
            SELECT 	com.CommentID,
                    com.Comment,
                    com.Created,
                    act.ActivityID,
                    act.Title AS ActivityTitle,
                    per.FirstName,
                    per.LastName
            FROM ce_Comment com
            LEFT JOIN ce_Activity act ON act.ActivityID = com.ActivityID
            LEFT JOIN ce_Person per ON per.PersonID = com.Created
            WHERE
                    (com.ApproveFlag = 'N') AND
                    (com.DeletedFlag = 'N')
        </cfquery>
    </cfcase>
    <!--- APPROVED --->
    <cfcase value="A">
        <cfquery name="qComments" datasource="#Application.Settings.DSN#">
            SELECT 	com.CommentID,
                    com.Comment,
                    com.Created,
                    act.ActivityID,
                    act.Title AS ActivityTitle,
                    per.FirstName,
                    per.LastName
            FROM ce_Comment com
            LEFT JOIN ce_Activity act ON act.ActivityID = com.ActivityID
            LEFT JOIN ce_Person per ON per.PersonID = com.Created
            WHERE
                    (com.ApproveFlag = 'Y') AND
                    (com.DeletedFlag = 'N')
        </cfquery>
    </cfcase>
    <!--- DENIED --->
    <cfcase value="D">
        <cfquery name="qComments" datasource="#Application.Settings.DSN#">
            SELECT 	com.CommentID,
                    com.Comment,
                    com.Created,
                    act.ActivityID,
                    act.Title AS ActivityTitle,
                    per.FirstName,
                    per.LastName
            FROM ce_Comment com
            LEFT JOIN ce_Activity act ON act.ActivityID = com.ActivityID
            LEFT JOIN ce_Person per ON per.PersonID = com.Created
            WHERE
                    (com.ApproveFlag = 'N') AND
                    (com.DeletedFlag = 'Y')
        </cfquery>
    </cfcase>
    <cfdefaultcase>
        <cfquery name="qComments" datasource="#Application.Settings.DSN#">
            SELECT 	com.CommentID,
                    com.Comment,
                    com.Created,
                    act.ActivityID,
                    act.Title AS ActivityTitle,
                    per.FirstName,
                    per.LastName
            FROM ce_Comment com
            LEFT JOIN ce_Activity act ON act.ActivityID = com.ActivityID
            LEFT JOIN ce_Person per ON per.PersonID = com.Created
            WHERE
                    (com.ApproveFlag = 'N') AND
                    (com.DeletedFlag = 'N')
        </cfquery>
    </cfdefaultcase>
</cfswitch>
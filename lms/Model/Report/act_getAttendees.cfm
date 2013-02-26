<cfparam name="Attributes.ActivityID" default="" />

<cfif Attributes.ActivityID NEQ "">
    <cfquery name="qReportData" datasource="#Application.Settings.DSN#">
        SELECT 	a.AttendeeID,
                a.ActivityID, 
                a.PersonID, 
                p.FirstName,
                p.LastName,
                p.DisplayName,
                (SELECT Address1
                 FROM ce_Person_Address AS A1
                 WHERE (A1.AddressID = p.PrimaryAddressID)) AS StreetLine1,
                (SELECT Address2
                 FROM ce_Person_Address AS A1
                 WHERE (A1.AddressID = p.PrimaryAddressID)) AS StreetLine2,
                (SELECT city 
                 FROM ce_Person_Address AS A1 
                 WHERE (A1.AddressID = p.PrimaryAddressID)) AS City, 
                (SELECT State
                 FROM ce_Person_Address AS A1 
                 WHERE (A1.AddressID = p.PrimaryAddressID)) AS State, 
                (SELECT Province
                 FROM ce_Person_Address AS A1
                 WHERE (A1.AddressID = p.PrimaryAddressID)) AS Province, 
                (SELECT ZipCode
                 FROM ce_Person_Address AS A1
                 WHERE (A1.AddressID = p.PrimaryAddressID)) AS PostalCode,
                (SELECT Country 
                 FROM  ce_Person_Address AS A1 
                 WHERE (A1.AddressID = p.PrimaryAddressID)) AS Country
        FROM ce_Attendee AS A
        LEFT OUTER JOIN ce_Person p ON p.PersonID = A.PersonID
        WHERE 
            a.ActivityID=#Attributes.ActivityID# AND
            a.DeletedFlag = 'N' AND
            p.DeletedFlag = 'N'
        <cfif IsDefined("Attributes.SelectedAttendees")>
            AND a.AttendeeId IN (#Attributes.SelectedAttendees#)
        </cfif>
        ORDER BY p.LastName,p.FirstName
    </cfquery>
</cfif>
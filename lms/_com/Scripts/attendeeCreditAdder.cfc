<cfcomponent displayname="Attendee Stat Fixer" output="no">
	<cffunction name="Run" output="yes" access="remote" returntype="string" returnformat="plain">
		
		<cfquery name="qSelector" datasource="#Application.Settings.DSN#">
			SELECT     AttendeeID,
						  (SELECT     Amount
							FROM          ce_Activity_Credit AS AC
							WHERE      (ActivityID = Att.ActivityID) AND (CreditID = 1) AND (DeletedFlag = 'N')) AS CreditAmount, ActivityID, PersonID, StatusID, CheckedInFlag, CheckIn, 
					  CheckedOutFlag, CheckOut, MDflag, TermsFlag, PaymentFlag, PayAmount, PayOrderNo, PaymentDate, RegisterDate, CompleteDate, TermDate, Created, CreatedBy, 
					  Updated, UpdatedBy, Deleted, DeletedFlag
			FROM         ce_Attendee AS Att
			WHERE     ((SELECT     COUNT(*) AS Expr1
							  FROM         ce_AttendeeCredit
							  WHERE     (AttendeeID = Att.AttendeeID)) = 0) AND (SELECT     Amount
							FROM          ce_Activity_Credit AS AC
							WHERE      (ActivityID = Att.ActivityID) AND (CreditID = 1) AND (DeletedFlag = 'N')) > 0
		</cfquery>
		
		<cfloop query="qSelector">
			#qSelector.AttendeeID#...
			<cfquery name="qInsert" datasource="#Application.Settings.DSN#">
				INSERT INTO ce_AttendeeCredit
				(
				AttendeeID,
				CreditID,
				Amount,
				CreatedBy
				)
				VALUES (
				<cfqueryparam value="#qSelector.AttendeeID#" cfsqltype="cf_sql_integer" />,
				<cfqueryparam value="1" cfsqltype="cf_sql_integer" />,
				<cfqueryparam value="#qSelector.CreditAmount#" cfsqltype="cf_sql_integer" />,
				169841
				)
			</cfquery>
			fixed.
		</cfloop>
		
	</cffunction>
</cfcomponent>
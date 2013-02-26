<cfcomponent displayname="can plug missing pif holes and replicate PIF data to older PIFs">
	<cffunction name="run" access="remote" output="yes">
		<cfquery name="preferredPifs" datasource="#application.settings.dsn#">
			SELECT   AttendeeCDCID, AttendeeID, CBAFundId, CBACDC, CBAOth, CBOFundId, CBOCDC, CBOOth, FunRCId, FunRCSp, FunRNId, FunRNSp, MarketId, Mspecify, 
                      OccClassId, OrgTypeId, Tspecify, ProfCId, ProfCSp, ProfNId, ProfNSp, PrinEmpID, PrinEmpSp, WorkState, WorkZip, FocSTD, FocHIV, FocWRH, FocGen, FocAdol, 
                      FocMH, FocSub, FocEm, FocCor, FocOth, FocSpec, PopGen, PopAdol, PopGLB, PopTran, PopHome, PopCorr, PopPreg, PopSW, PopAA, PopAs, PopNH, PopAIAN, 
                      PopHisp, PopImm, PopIDU, PopSub, PopHIV, PopOth, PopSpec, Updates, Eval, TrainingAlert, CurrentlyEnrolled, RelevantTraining, MotivationTraining, SentFlag, 
                      SentDate, Created, CreatedBy, Updated, UpdatedBy, Deleted, DeletedFlag, MaxPIFid, PrinEmpBit, MaxCreated, PersonID
FROM         ceschema.View_PreferredPifFull
ORDER BY AttendeeCDCID DESC
		</cfquery>
		
		<cfquery name="qFixPifs" datasource="#application.settings.dsn#">
			SELECT     Att.AttendeeID,Att.ActivityID,Att.PersonID,(CASE 
			WHEN isNull(PIF.AttendeeCDCID,0) > 0 THEN 1
			ELSE 0
			END) AS hasPif
			FROM         ceschema.ce_Attendee AS Att INNER JOIN
			  ceschema.ce_Activity_Category AS AC ON Att.ActivityID = AC.ActivityID
			  lEFT JOIN ceschema.ce_AttendeeCDC AS PIF ON PIF.AttendeeID=Att.AttendeeID
			  INNER JOIN ceschema.ce_Activity AS Act ON Act.ActivityID=Att.ActivityID
			  INNER JOIN ceschema.ce_Person AS P ON P.PersonID=Att.PersonID
			WHERE     (Att.DeletedFlag = 'N') AND (AC.CategoryID IN (31, 162, 196)) AND P.DeletedFlag='N' AND Act.DeletedFlag='N' AND Act.StatusID IN (1,2,3) AND (CASE 
			WHEN isNull(PIF.AttendeeCDCID,0) > 0 THEN 1
			ELSE 0
			END) <> 1
			GROUP BY Att.AttendeeID, Att.PersonID, Att.ActivityID,(CASE 
			WHEN isNull(PIF.AttendeeCDCID,0) > 0 THEN 1
			ELSE 0
			END)
			ORDER BY Att.AttendeeID,Att.PersonID
		</cfquery>
		<cfset currCount = 0 />
		<cfloop query="qFixPifs">
			<cfquery name="qGetPref" dbtype="query">
				SELECT AttendeeCDCId,CBAFundId, CBACDC, CBAOth, CBOFundId, CBOCDC, CBOOth, FunRCId, FunRCSp, FunRNId, FunRNSp, MarketId, Mspecify, 
                      OccClassId, OrgTypeId, Tspecify, ProfCId, ProfCSp, ProfNId, ProfNSp, PrinEmpID, PrinEmpSp, WorkState, WorkZip, FocSTD, FocHIV, FocWRH, FocGen, FocAdol, 
                      FocMH, FocSub, FocEm, FocCor, FocOth, FocSpec, PopGen, PopAdol, PopGLB, PopTran, PopHome, PopCorr, PopPreg, PopSW, PopAA, PopAs, PopNH, PopAIAN, 
                      PopHisp, PopImm, PopIDU, PopSub, PopHIV, PopOth, PopSpec, Updates, Eval, TrainingAlert, CurrentlyEnrolled, RelevantTraining, MotivationTraining, SentFlag, 
                      SentDate,MaxPifId FROM preferredPifs
					  WHERE PersonID = <cfqueryparam value="#qFixPifs.PersonID#" cfsqltype="cf_sql_integer" />
					  ORDER BY MaxPifId
			</cfquery>
			<cfif qGetPref.RecordCount GT 0>
				<cfset currCount++ />
				[#currCount#] Add pif: ###qGetPref.MaxPifId# to Attendee: ###qFixPifs.AttendeeID# (Person: #qFixPifs.PersonID#)<cfflush>
				<cfquery name="qInsert" datasource="#application.settings.dsn#">
					INSERT INTO ce_AttendeeCDC (AttendeeID,
						CBAFundId,
						CBACDC,
						CBAOth,
						CBOFundId,
						CBOCDC,
						CBOOth,
						FunRCId,
						FunRCSp,
						FunRNId,
						FunRNSp,
						MarketId,
						Mspecify,
						OccClassId,
						OrgTypeId,
						Tspecify,
						ProfCId,
						ProfCSp,
						ProfNId,
						ProfNSp,
						PrinEmpID,
						PrinEmpSp,
						WorkState,
						WorkZip,
						FocSTD,
						FocHIV,
						FocWRH,
						FocGen,
						FocAdol,
						FocMH,
						FocSub,
						FocEm,
						FocCor,
						FocOth,
						FocSpec,
						PopGen,
						PopAdol,
						PopGLB,
						PopTran,
						PopHome,
						PopCorr,
						PopPreg,
						PopSW,
						PopAA,
						PopAs,
						PopNH,
						PopAIAN,
						PopHisp,
						PopImm,
						PopIDU,
						PopSub,
						PopHIV,
						PopOth,
						PopSpec,
						Updates,
						Eval,
						TrainingAlert,
						CurrentlyEnrolled,
						RelevantTraining,
						MotivationTraining,
						CreatedBy)
					VALUES (<cfqueryparam value="#qFixPifs.AttendeeID#" CFSQLType="cf_sql_integer" />,
						<cfqueryparam value="#qGetPref.CBAFundId#" CFSQLType="cf_sql_integer" null="#not len(qGetPref.CBAFundId)#" />,
						<cfqueryparam value="#qGetPref.CBACDC#" CFSQLType="cf_sql_varchar" null="#not len(qGetPref.CBACDC)#" />,
						<cfqueryparam value="#qGetPref.CBAOth#" CFSQLType="cf_sql_varchar" null="#not len(qGetPref.CBAOth)#" />,
						<cfqueryparam value="#qGetPref.CBOFundId#" CFSQLType="cf_sql_integer" null="#not len(qGetPref.CBOFundId)#" />,
						<cfqueryparam value="#qGetPref.CBOCDC#" CFSQLType="cf_sql_varchar" null="#not len(qGetPref.CBOCDC)#" />,
						<cfqueryparam value="#qGetPref.CBOOth#" CFSQLType="cf_sql_varchar" null="#not len(qGetPref.CBOOth)#" />,
						<cfqueryparam value="#qGetPref.FunRCId#" CFSQLType="cf_sql_integer" null="#not len(qGetPref.FunRCId)#" />,
						<cfqueryparam value="#qGetPref.FunRCSp#" CFSQLType="cf_sql_varchar" null="#not len(qGetPref.FunRCSp)#" />,
						<cfqueryparam value="#qGetPref.FunRNId#" CFSQLType="cf_sql_integer" null="#not len(qGetPref.FunRNId)#" />,
						<cfqueryparam value="#qGetPref.FunRNSp#" CFSQLType="cf_sql_varchar" null="#not len(qGetPref.FunRNSp)#" />,
						<cfqueryparam value="#qGetPref.MarketId#" CFSQLType="cf_sql_integer" null="#not len(qGetPref.MarketId)#" />,
						<cfqueryparam value="#qGetPref.Mspecify#" CFSQLType="cf_sql_varchar" null="#not len(qGetPref.Mspecify)#" />,
						<cfqueryparam value="#qGetPref.OccClassId#" CFSQLType="cf_sql_integer" null="#not len(qGetPref.OccClassId)#" />,
						<cfqueryparam value="#qGetPref.OrgTypeId#" CFSQLType="cf_sql_integer" null="#not len(qGetPref.OrgTypeId)#" />,
						<cfqueryparam value="#qGetPref.Tspecify#" CFSQLType="cf_sql_varchar" null="#not len(qGetPref.Tspecify)#" />,
						<cfqueryparam value="#qGetPref.ProfCId#" CFSQLType="cf_sql_integer" null="#not len(qGetPref.ProfCId)#" />,
						<cfqueryparam value="#qGetPref.ProfCSp#" CFSQLType="cf_sql_varchar" null="#not len(qGetPref.ProfCSp)#" />,
						<cfqueryparam value="#qGetPref.ProfNId#" CFSQLType="cf_sql_integer" null="#not len(qGetPref.ProfNId)#" />,
						<cfqueryparam value="#qGetPref.ProfNSp#" CFSQLType="cf_sql_varchar" null="#not len(qGetPref.ProfNSp)#" />,
						<cfqueryparam value="#qGetPref.PrinEmpID#" CFSQLType="cf_sql_integer" null="#not len(qGetPref.PrinEmpID)#" />,
						<cfqueryparam value="#qGetPref.PrinEmpSp#" CFSQLType="cf_sql_varchar" null="#not len(qGetPref.PrinEmpSp)#" />,
						<cfqueryparam value="#qGetPref.WorkState#" CFSQLType="cf_sql_varchar" null="#not len(qGetPref.WorkState)#" />,
						<cfqueryparam value="#qGetPref.WorkZip#" CFSQLType="cf_sql_varchar" null="#not len(qGetPref.WorkZip)#" />,
						<cfqueryparam value="#qGetPref.FocSTD#" CFSQLType="cf_sql_char" />,
						<cfqueryparam value="#qGetPref.FocHIV#" CFSQLType="cf_sql_char" />,
						<cfqueryparam value="#qGetPref.FocWRH#" CFSQLType="cf_sql_char" />,
						<cfqueryparam value="#qGetPref.FocGen#" CFSQLType="cf_sql_char" />,
						<cfqueryparam value="#qGetPref.FocAdol#" CFSQLType="cf_sql_char" />,
						<cfqueryparam value="#qGetPref.FocMH#" CFSQLType="cf_sql_char" />,
						<cfqueryparam value="#qGetPref.FocSub#" CFSQLType="cf_sql_char" />,
						<cfqueryparam value="#qGetPref.FocEm#" CFSQLType="cf_sql_char" />,
						<cfqueryparam value="#qGetPref.FocCor#" CFSQLType="cf_sql_char" />,
						<cfqueryparam value="#qGetPref.FocOth#" CFSQLType="cf_sql_char" />,
						<cfqueryparam value="#qGetPref.FocSpec#" CFSQLType="cf_sql_varchar" null="#not len(qGetPref.FocSpec)#" />,
						<cfqueryparam value="#qGetPref.PopGen#" CFSQLType="cf_sql_char" />,
						<cfqueryparam value="#qGetPref.PopAdol#" CFSQLType="cf_sql_char" />,
						<cfqueryparam value="#qGetPref.PopGLB#" CFSQLType="cf_sql_char" />,
						<cfqueryparam value="#qGetPref.PopTran#" CFSQLType="cf_sql_char" />,
						<cfqueryparam value="#qGetPref.PopHome#" CFSQLType="cf_sql_char" />,
						<cfqueryparam value="#qGetPref.PopCorr#" CFSQLType="cf_sql_char" />,
						<cfqueryparam value="#qGetPref.PopPreg#" CFSQLType="cf_sql_char" />,
						<cfqueryparam value="#qGetPref.PopSW#" CFSQLType="cf_sql_char" />,
						<cfqueryparam value="#qGetPref.PopAA#" CFSQLType="cf_sql_char" />,
						<cfqueryparam value="#qGetPref.PopAs#" CFSQLType="cf_sql_char" />,
						<cfqueryparam value="#qGetPref.PopNH#" CFSQLType="cf_sql_char" />,
						<cfqueryparam value="#qGetPref.PopAIAN#" CFSQLType="cf_sql_char" />,
						<cfqueryparam value="#qGetPref.PopHisp#" CFSQLType="cf_sql_char" />,
						<cfqueryparam value="#qGetPref.PopImm#" CFSQLType="cf_sql_char" />,
						<cfqueryparam value="#qGetPref.PopIDU#" CFSQLType="cf_sql_char" />,
						<cfqueryparam value="#qGetPref.PopSub#" CFSQLType="cf_sql_char" />,
						<cfqueryparam value="#qGetPref.PopHIV#" CFSQLType="cf_sql_char" />,
						<cfqueryparam value="#qGetPref.PopOth#" CFSQLType="cf_sql_char" />,
						<cfqueryparam value="#qGetPref.PopSpec#" CFSQLType="cf_sql_varchar" null="#not len(qGetPref.PopSpec)#" />,
						<cfqueryparam value="#qGetPref.Updates#" CFSQLType="cf_sql_char" null="#not len(qGetPref.Updates)#" />,
						<cfqueryparam value="#qGetPref.Eval#" CFSQLType="cf_sql_char" null="#not len(qGetPref.Eval)#" />,
						<cfqueryparam value="#qGetPref.TrainingAlert#" CFSQLType="cf_sql_char" null="#not len(qGetPref.TrainingAlert)#" />,
						<cfqueryparam value="#qGetPref.CurrentlyEnrolled#" CFSQLType="cf_sql_char" null="#not len(qGetPref.CurrentlyEnrolled)#" />,
						<cfqueryparam value="#qGetPref.RelevantTraining#" CFSQLType="cf_sql_char" null="#not len(qGetPref.RelevantTraining)#" />,
						<cfqueryparam value="#qGetPref.MotivationTraining#" CFSQLType="cf_sql_char" null="#not len(qGetPref.MotivationTraining)#" />,
						<cfqueryparam value="169841" CFSQLType="cf_sql_integer" />)
				</cfquery>
				<strong>ADDED!</strong><br /><cfflush>
			<cfelse>
				<!--- DO NOTHING --->
			</cfif>
			
		</cfloop>
	</cffunction>
</cfcomponent>
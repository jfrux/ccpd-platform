<cfcomponent displayname="Vote Ajax">
	<cffunction name="VoteSave" access="remote" output="no" returntype="any">
		<cfargument name="ActivityID" required="yes">
		<cfargument name="VoteValue" required="yes">
		
		<cfset Vote = createobject("component","#Application.Settings.Com#ActivityVote.ActivityVote").init()>
		<cfset Vote.setActivityID(Arguments.ActivityID)>
		<cfset Vote.setPersonID(Session.PersonID)>
		<cfif Application.Com.ActivityVoteDAO.Exists(Vote)>
			<cfset Vote = Application.Com.ActivityVoteDAO.Read(Vote)>
			
			<cfquery name="qStats" datasource="#Application.Settings.DSN#">
				UPDATE ce_Activity_PubGeneral
				SET StatVoteCount=StatVoteCount-1,
					StatVoteValue=StatVoteValue-#Vote.getVoteValue()#
				WHERE
					ActivityID=<cfqueryparam value="#Arguments.ActivityID#" cfsqltype="cf_sql_integer" />
			</cfquery>
		</cfif>
		<cfset Vote.setVoteValue(Arguments.VoteValue)>
		<cfset Vote.setCreated(now())>
		
		<cfset Application.Com.ActivityVoteDAO.Save(Vote)>
		
		<cfquery name="qStats" datasource="#Application.Settings.DSN#">
			UPDATE ce_Activity_PubGeneral
			SET StatVoteCount=StatVoteCount+1,
				StatVoteValue=StatVoteValue+<cfqueryparam value="#Arguments.VoteValue#" cfsqltype="cf_sql_integer" />
			WHERE
				ActivityID=<cfqueryparam value="#Arguments.ActivityID#" cfsqltype="cf_sql_integer" />
		</cfquery>
		
		<cfreturn "success" />
	</cffunction>
	
	<cffunction name="VoteDelete" access="remote" output="no" returntype="any">
		<cfargument name="ActivityID" required="yes">
		
		<cfset Vote = createobject("component","#Application.Settings.Com#ActivityVote.ActivityVote").init()>
		<cfset Vote.setActivityID(Arguments.ActivityID)>
		<cfset Vote.setPersonID(Session.PersonID)>
		<cfif Application.Com.ActivityVoteDAO.Exists(Vote)>
			<cfset Vote = Application.Com.ActivityVoteDAO.Read(Vote)>
			
			<!--- SUBTRACT VOTE --->
			<cfquery name="qStats" datasource="#Application.Settings.DSN#">
				UPDATE ce_Activity_PubGeneral
				SET StatVoteCount=StatVoteCount-1,
					StatVoteValue=StatVoteValue-#Vote.getVoteValue()#
				WHERE
					ActivityID=<cfqueryparam value="#Arguments.ActivityID#" cfsqltype="cf_sql_integer" />
			</cfquery>
			
			<cfquery name="qDelete" datasource="#Application.Settings.DSN#">
				DELETE ce_Activity_Vote
				WHERE ActivityID=<cfqueryparam value="#Arguments.ActivityID#" cfsqltype="cf_sql_integer" /> AND PersonID=#Session.PersonID#
			</cfquery>
		</cfif>
		
		<cfreturn "success" />
	</cffunction>
	
	<cffunction name="InterestExcept" access="remote" output="no" returntype="any">
		<cfargument name="ActivityID" required="yes">
		
		<cfset InterestExcept = createobject("component","#Application.Settings.Com#PersonInterestExcept.PersonInterestExcept").init()>
		<cfset InterestExcept.setActivityID(Arguments.ActivityID)>
		<cfset InterestExcept.setPersonID(Session.PersonID)>
		<cfset InterestExcept.setCreated(now())>
		<cfset Application.Com.PersonInterestExceptDAO.Save(InterestExcept)>
		
		<cfreturn "success" />
	</cffunction>
</cfcomponent>
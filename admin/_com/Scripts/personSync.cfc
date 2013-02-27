<cfcomponent displayname="Person Sync" output="no">
	<cfparam name="url.reload" default="false">
	
	<cffunction name="query" access="remote" output="yes">
			<cfquery name="session.query" datasource="#application.settings.dsn#" timeout="500000" cachedwithin="#CreateTimeSpan(0,1,0,0)#">
				select * FROM pd_personinfoforcme
				ORDER BY PERSONID
			</cfquery>
			DONE
	</cffunction>
	
	<cffunction name="Run" output="yes" access="remote" returntype="string" returnformat="plain">
		<cfargument name="Start" type="numeric" required="no" default="0">
		<cfargument name="Rows" type="numeric" required="no" default="200">
		<cfargument name="type" type="string" required="no" default="person">
		
		<cfswitch expression="#arguments.type#">
				<cfcase value="person">
					<cfquery name="qQuery" dbtype="query">
						SELECT * FROM session.query
						<cfif arguments.start GT 0>
						WHERE personid >= #arguments.start#
						</cfif>
						ORDER BY personid
					</cfquery>
					<cfloop query="qQuery">
						<cfset createPerson()>
					</cfloop>
				</cfcase>
				<cfcase value="education">
					<cfquery name="qQuery" dbtype="query" timeout="5000">
						SELECT * FROM session.query
						<cfif arguments.start GT 0>
						WHERE personid >= #arguments.start#
						</cfif>
						ORDER BY personid
					</cfquery>
					<cfloop query="qQuery">
						<cfset education()>
					</cfloop>
				</cfcase>
				<cfcase value="address">
					<cfquery name="qQuery" dbtype="query" timeout="5000">
						SELECT * FROM session.query
						WHERE 
						
						(0 = 0
						<cfif arguments.start GT 0>
						AND personid >= #arguments.start#
						</cfif>
						AND streetline1 IS NOT NULL)
						ORDER BY personid
					</cfquery>
					<cfloop query="qQuery">
						<cfset address()>
					</cfloop>
				</cfcase>
			</cfswitch>
		
		<!---<script>window.location='#Application.Settings.RootPath#/_com/Scripts/personSync.cfc?method=Run&Start=#Arguments.Start+Arguments.Rows+1#&Rows=#Arguments.Rows#';</script>
		--->
	</cffunction>
	
	<cffunction name="createPerson" access="private" output="yes">
		<cfset var Person = createobject("component","#Application.Settings.Com#Person.Person").init()>
		<cfset var qCheckExists = "">
		<cfset Person.setPersonID(qQuery.PersonID)>
		<cfset Person.setCreatedBy(1)>
		
		<cfquery name="qCheckExists" datasource="#application.settings.dsn#">
			SELECT Count(PersonID) PersonCount FROM ce_Person
			WHERE personid=<cfqueryparam value="#qQuery.personid#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<!---<cfif qCheckExists.PersonCount GT 0>
			<cfset Person = Application.Com.PersonDAO.Read(Person)>
			<cfset Person.setUpdatedBy(1)>
			<cfset Person.setUpdated(now())>
		</cfif>--->
		
		<cfset displayname = "#qQuery.FirstName# #qQuery.MiddleName# #qQuery.LastName#">
		
		<cfif isMD(qQuery.educationname)>
			<cfset displayname = displayname & ", MD">
		</cfif>
		
		<cfif isDO(qQuery.educationname)>
			<cfset displayname = displayname & ", DO">
		</cfif>
		
		<cfif isPHD(qQuery.educationname)>
			<cfset displayname = displayname & ", PhD">
		</cfif>
		
		<cfset Person.setDisplayName(displayname)>
		<cfset Person.setFirstName(qQuery.FirstName)>
		<cfset Person.setMiddleName(qQuery.MiddleName)>
		<cfset Person.setLastName(qQuery.LastName)>
		<cfset Person.setEmail(qQuery.Email)>
		
		

		<cfif qCheckExists.PersonCount GT 0>
			#qQuery.PersonID#,			
			<!---<cfif Update(Person)>
			<strong>UPDATED</strong><br>
			<cfelse>
			<strong>FAILED TO UPDATE</strong><br>
			</cfif>--->
		<cfelse>
			<cfset CreateIDins(Person)>
			
		<br>[#qQuery.PersonID#] #qQuery.LastName#, #qQuery.FirstName# (#displayname#)<strong>CREATED</strong>
		</cfif>
		
		<cfflush>
	</cffunction>
	
	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="Person" type="_com.Person.Person" required="true" />

		<cfset var qUpdate = "" />
		
		<cfquery name="qUpdate" datasource="#application.settings.dsn#">
				UPDATE	ce_Person
				SET
					Prefix = <cfqueryparam value="#arguments.Person.getPrefix()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Person.getPrefix())#" />,
					FirstName = <cfqueryparam value="#arguments.Person.getFirstName()#" CFSQLType="cf_sql_varchar" />,
					MiddleName = <cfqueryparam value="#arguments.Person.getMiddleName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Person.getMiddleName())#" />,
					LastName = <cfqueryparam value="#arguments.Person.getLastName()#" CFSQLType="cf_sql_varchar" />,
					Suffix = <cfqueryparam value="#arguments.Person.getSuffix()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Person.getSuffix())#" />,
					DisplayName = <cfqueryparam value="#arguments.Person.getDisplayName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Person.getDisplayName())#" />,
					EthnicityID = <cfqueryparam value="#arguments.Person.getEthnicityID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Person.getEthnicityID())#" />,
					OMBEthnicityID = <cfqueryparam value="#arguments.Person.getOMBEthnicityID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Person.getOMBEthnicityID())#" />,
					Email = <cfqueryparam value="#arguments.Person.getEmail()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Person.getEmail())#" />,
					Password = <cfqueryparam value="#arguments.Person.getPassword()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Person.getPassword())#" />,
					PrimaryAddressID = <cfqueryparam value="#arguments.Person.getPrimaryAddressID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Person.getPrimaryAddressID())#" />,
					Birthdate = <cfqueryparam value="#arguments.Person.getBirthdate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Person.getBirthdate())#" />,
					SSN = <cfqueryparam value="#arguments.Person.getSSN()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Person.getSSN())#" />,
					Gender = <cfqueryparam value="#arguments.Person.getGender()#" CFSQLType="cf_sql_char" null="#not len(arguments.Person.getGender())#" />,
					StatusID = <cfqueryparam value="#arguments.Person.getStatusID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Person.getStatusID())#" />,
					Created = <cfqueryparam value="#arguments.Person.getCreated()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Person.getCreated())#" />,
					CreatedBy = <cfqueryparam value="#arguments.Person.getCreatedBy()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Person.getCreatedBy())#" />,
					Updated = <cfqueryparam value="#arguments.Person.getUpdated()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Person.getUpdated())#" />,
					UpdatedBy = <cfqueryparam value="#arguments.Person.getUpdatedBy()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Person.getUpdatedBy())#" />,
					Deleted = <cfqueryparam value="#arguments.Person.getDeleted()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Person.getDeleted())#" />,
					DeletedFlag = <cfqueryparam value="#arguments.Person.getDeletedFlag()#" CFSQLType="cf_sql_char" null="#not len(arguments.Person.getDeletedFlag())#" />,
					DeletedBy = <cfqueryparam value="#arguments.Person.getDeletedBy()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Person.getDeletedBy())#" />
				WHERE	PersonID = <cfqueryparam value="#arguments.Person.getPersonID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
		<cftry>
			
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>
	
	<cffunction name="education" type="remote" output="yes">
		<cfset var qInsert = "">
		<cfset var qUpdate = "">
		<cfset var checkExists = "">
		<cfset var degreeid = getDegreeID(qQuery.educationname)>
		
		#qQuery.personid# - 
		<cfif degreeid GT 0>
			<cfquery name="checkExists" datasource="#application.settings.dsn#">
				SELECT Count(persondegreeid) As count FROM ce_person_degree
				WHERE PersonID=#qQuery.personid# AND degreeid=#degreeid#
			</cfquery>
			
			<cfif checkExists.count LTE 0>
				<cfquery name="qInsert" datasource="#application.settings.dsn#">
					INSERT INTO ce_person_degree (
						personid,
						degreeid
					) VALUES (
						#qQuery.personid#,
						#degreeid#
					)
				</cfquery>
				<strong>#qQuery.educationname#</strong><br>
				<cfflush>
			<cfelse>
				<strong>ALREADY EXISTS</strong><br>
			</cfif>
			<cfflush>
		<cfelse>
			<strong>NO DEGREE</strong><br>
		</cfif>
	</cffunction>
	
	<cffunction name="address" type="remote" output="yes">
		<cfset var qInsert = "">
		<cfset var qUpdate = "">
		<cfset var checkExists = "">
		
		#qQuery.personid# - 
		<cfquery name="checkExists" datasource="#application.settings.dsn#">
			SELECT Count(addressid) As count FROM ce_person_address
			WHERE PersonID=#qQuery.personid# AND address1=<cfqueryparam value="#qQuery.streetline1#" cfsqltype="cf_sql_varchar" />
		</cfquery>
		
		<cfif checkExists.count LTE 0>
			<cfquery name="qCreate" datasource="#application.settings.dsn#" result="CreateResult">
				INSERT INTO ce_Person_Address
					(
					PersonID,
					AddressTypeID,
					Address1,
					Address2,
					City,
					State,
					Province,
					Country,
					ZipCode,
					CreatedBy
					)
				VALUES
					(
					<cfqueryparam value="#qQuery.personid#" CFSQLType="cf_sql_integer" />,
					<cfqueryparam value="1" CFSQLType="cf_sql_integer" />,
					<cfqueryparam value="#qQuery.streetline1#" CFSQLType="cf_sql_varchar" />,
					<cfqueryparam value="#qQuery.streetline2#" CFSQLType="cf_sql_varchar" />,
					<cfqueryparam value="#qQuery.City#" CFSQLType="cf_sql_varchar" />,
					<cfqueryparam value="#UCASE(Left(StateToAbbr(qQuery.State),2))#" CFSQLType="cf_sql_varchar" />,
					<cfqueryparam value="#qQuery.Province#" CFSQLType="cf_sql_varchar" />,
					<cfqueryparam value="#qQuery.Country#" CFSQLType="cf_sql_varchar" />,
					<cfqueryparam value="#qQuery.postalcode#" CFSQLType="cf_sql_varchar" />,
					<cfqueryparam value="1" CFSQLType="cf_sql_integer" />
					)
			</cfquery>
			<strong>#qQuery.streetline1#</strong><br>
			<cfflush>
		<cfelse>
			<strong>ALREADY EXISTS</strong><br>
		</cfif>
		<cfflush>
	</cffunction>
	
	<cfscript>
/**
* Takes a full State name (i.e. California) and returns the two letter abbreviation (i.e. CA).
*
* @param state      The state to convert.
* @return Returns a string.
* @author Sivan Leoni (sleoni@leoniz.com)
* @version 1, January 7, 2002
*/
function StateToAbbr(State) {
var states = "ALABAMA,ALASKA,AMERICAN
SAMOA,ARIZONA,ARKANSAS,CALIFORNIA,COLORADO,CONNECTICUT,DELAWARE,DISTRICT
OF COLUMBIA,FEDERATED STATES OF
MICRONESIA,FLORIDA,GEORGIA,GUAM,HAWAII,IDAHO,ILLINOIS,INDIANA,IOWA,KANSA
S,KENTUCKY,LOUISIANA,MAINE,MARSHALL
ISLANDS,MARYLAND,MASSACHUSETTS,MICHIGAN,MINNESOTA,MISSISSIPPI,MISSOURI,M
ONTANA,NEBRASKA,NEVADA,NEW HAMPSHIRE,NEW JERSEY,NEW MEXICO,NEW
YORK,NORTH CAROLINA,NORTH DAKOTA,NORTHERN MARIANA
ISLANDS,OHIO,OKLAHOMA,OREGON,PALAU,PENNSYLVANIA,PUERTO RICO,RHODE
ISLAND,SOUTH CAROLINA,SOUTH DAKOTA,TENNESSEE,TEXAS,UTAH,VERMONT,VIRGIN
ISLANDS,VIRGINIA,WASHINGTON,WEST VIRGINIA,WISCONSIN,WYOMING";
var abbr =
"AL,AK,AS,AZ,AR,CA,CO,CT,DE,DC,FM,FL,GA,GU,HI,ID,IL,IN,IA,KS,KY,LA,ME,MH
,MD,MA,MI,MN,MS,MO,MT,NE,NV,NH,NJ,NM,NY,NC,ND,MP,OH,OK,OR,PW,PA,PR,RI,SC
,SD,TN,TX,UT,VT,VI,VA,WA,WV,WI,WY";
if(listFindNoCase(states,State))
    State=listGetAt(abbr,listFindNoCase(states,state));
return State;
}
</cfscript>
	
	<cffunction name="isMD" access="public" displayname="Is MD" output="no" returntype="boolean">
		<cfargument name="education" type="string" required="yes">
		
		<cfset var mdcheck = false>
		<cfset var mdlist = "MB BS,M D,D MED SC,M.D.,FRCR,FACR,FACC,FACP,MBBS,FRCS,FRCPC,MRCP,MB,MD/PhD">
		<cfif listFind(mdlist,arguments.education,',')>
			<cfset mdcheck = true>
		</cfif>
		
		<cfreturn mdcheck />
	</cffunction>
	
	<cffunction name="isDO" access="public" displayname="Is MD" output="no" returntype="boolean">
		<cfargument name="education" type="string" required="yes">
		
		<cfset var check = false>
		<cfset var list = "D O,DO,D.O.">
		<cfif listFind(list,arguments.education,',')>
			<cfset check = true>
		</cfif>
		
		<cfreturn check />
	</cffunction>
	
	<cffunction name="isPHD" access="public" displayname="Is MD" output="no" returntype="boolean">
		<cfargument name="education" type="string" required="yes">
		
		<cfset var check = false>
		<cfset var list = "PhD,PHD,Ph.D.">
		<cfif listFind(list,arguments.education,',')>
			<cfset check = true>
		</cfif>
		
		<cfreturn check />
	</cffunction>
	
	<cffunction name="getDegreeID" access="public" output="no" returntype="numeric">
		<cfargument name="string" type="string" required="yes">
		
		<cfset var degreeid = 0>
		
		<cfif isMD(arguments.string)>
			<cfset degreeid = 3>
		</cfif>
		
		<cfif isDO(arguments.string)>
			<cfset degreeid = 4>
		</cfif>
		
		<cfreturn degreeid />
	</cffunction>
	
	
	<cffunction name="createIDins" access="public" output="false" returntype="boolean">
		<cfargument name="Person" type="_com.Person.Person" required="true" />

		<cfset var qCreate = "" />
		<cfquery name="qCreate" datasource="CCPD_PROD" result="CreateResult">
			SET IDENTITY_INSERT ce_Person ON;
			INSERT INTO ce_Person
					(
					PersonID,
					Prefix,
					FirstName,
					MiddleName,
					LastName,
					Suffix,
					DisplayName,
					EthnicityID,
					OMBEthnicityID,
					Email,
					Password,
					PrimaryAddressID,
					Birthdate,
					SSN,
					Gender,
					StatusID,
					CreatedBy,
					DeletedBy
					)
				VALUES
					(
					<cfqueryparam value="#arguments.Person.getPersonID()#" CFSQLType="cf_sql_integer" />,
					<cfqueryparam value="#arguments.Person.getPrefix()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Person.getPrefix())#" />,
					<cfqueryparam value="#arguments.Person.getFirstName()#" CFSQLType="cf_sql_varchar" />,
					<cfqueryparam value="#arguments.Person.getMiddleName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Person.getMiddleName())#" />,
					<cfqueryparam value="#arguments.Person.getLastName()#" CFSQLType="cf_sql_varchar" />,
					<cfqueryparam value="#arguments.Person.getSuffix()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Person.getSuffix())#" />,
					<cfqueryparam value="#arguments.Person.getDisplayName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Person.getDisplayName())#" />,
					<cfqueryparam value="#arguments.Person.getEthnicityID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Person.getEthnicityID())#" />,
					<cfqueryparam value="#arguments.Person.getOMBEthnicityID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Person.getOMBEthnicityID())#" />,
					<cfqueryparam value="#arguments.Person.getEmail()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Person.getEmail())#" />,
					<cfqueryparam value="#arguments.Person.getPassword()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Person.getPassword())#" />,
					<cfqueryparam value="#arguments.Person.getPrimaryAddressID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Person.getPrimaryAddressID())#" />,
					<cfqueryparam value="#arguments.Person.getBirthdate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Person.getBirthdate())#" />,
					<cfqueryparam value="#arguments.Person.getSSN()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Person.getSSN())#" />,
					<cfqueryparam value="#arguments.Person.getGender()#" CFSQLType="cf_sql_char" null="#not len(arguments.Person.getGender())#" />,
					<cfqueryparam value="#arguments.Person.getStatusID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Person.getStatusID())#" />,
					<cfqueryparam value="#arguments.Person.getCreatedBy()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Person.getCreatedBy())#" />,
					<cfqueryparam value="#arguments.Person.getDeletedBy()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Person.getDeletedBy())#" />
					);
			</cfquery>
		<cftry>
			
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>
</cfcomponent>
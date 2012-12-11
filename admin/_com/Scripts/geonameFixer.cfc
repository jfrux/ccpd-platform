<cfcomponent displayname="geonames">
	<cffunction name="assignGeoToAddress" access="remote" output="yes">
		<cfquery name="qAddresses" datasource="#application.settings.dsn#">
SELECT     addr.AddressID, adm1.code, adm1.name, adm1.nameAscii, addr.Province, geo.geonameid
FROM         ceschema.ce_Person_Address AS addr LEFT OUTER JOIN
                      ceschema.geonameCities AS geo ON addr.City = geo.name INNER JOIN
                      ceschema.geoname_admin1CodesASCII AS adm1 ON geo.country_code + '.' + geo.admin1_code = adm1.code
WHERE     (addr.geonameid IS NULL) AND (addr.Country = 'Canada') AND (geo.country_code = 'CA') AND (adm1.code LIKE 'CA.%')
ORDER BY addr.AddressID</cfquery>
		
		<cfloop query="qAddresses">
			<cfquery name="qUpdate" datasource="#application.settings.dsn#">
				UPDATE ce_person_address
				SET geonameid = #qAddresses.geonameid#
				WHERE addressid = #qAddresses.addressid#
			</cfquery>
		</cfloop>
	</cffunction>
</cfcomponent>
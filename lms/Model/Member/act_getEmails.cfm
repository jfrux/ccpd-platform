<cfset EmailList = Application.Com.PersonEmailGateway.getByAttributesQueryFull(Person_ID=session.personId, orderBy="pe.email_address")>
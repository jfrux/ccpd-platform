<cfparam name="Attributes.ActivityID" default="" />

<cfset qLinks = Application.Com.ActivityPubComponentGateway.getByViewAttributesLMS(ComponentIDin="10",ActivityID=Attributes.ActivityID,DeletedFlag="N",OrderBy="apc.Sort")>
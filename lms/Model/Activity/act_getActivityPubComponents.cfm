<cfparam name="Attributes.ActivityID" default="" />

<cfset qActivityPubComponents = Application.Com.ActivityPubComponentGateway.getByViewAttributesLMS(ActivityID=Attributes.ActivityID,DeletedFlag="N",OrderBy="apc.Sort")>

<!--- NEW WAY --->
<cfset qMaterials = Application.Com.ActivityPubComponentGateway.getByViewAttributesLMS(ComponentIDin="3,4,9,13,14",ActivityID=Attributes.ActivityID,DeletedFlag="N",OrderBy="apc.Sort")>
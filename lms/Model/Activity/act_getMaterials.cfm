<cfparam name="Attributes.ActivityID" default="" />

<cfset qMaterials = Application.Com.ActivityPubComponentGateway.getByViewAttributesLMS(ComponentIDin="3,4,9,13,14,10",ActivityID=Attributes.ActivityID,DeletedFlag="N",OrderBy="apc.Sort")>
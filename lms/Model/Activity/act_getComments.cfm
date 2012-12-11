<cfparam name="Attributes.ActivityID" default="" />

<cfset qComments = Application.Com.CommentGateway.getByViewAttributes(ActivityID=Attributes.ActivityID,ApproveFlag="Y",DeletedFlag="N",OrderBy="CommentID DESC")>
<!--- 
###############################
INSTALL INFORMATION 
Last Updated: 09/28/2009
###############################

TwitterFeed.com Account:
	Username: rountrjf@ucmail.uc.edu
	Password: 05125586

#########################
Twitter Account:
	Username: UC_CCPD
	Password: 05125586
#########################

#########################
URL REWRITING RULES:

# Helicon ISAPI_Rewrite configuration file
# Version 3.1.0.63
RewriteEngine On

#LMS
RewriteRule ^/activity/([^/.]+)$ /index.cfm/event/Activity.Detail?ActivityID=$1  [NC]
RewriteRule ^/category/([^/.]+)$ /index.cfm/event/Activity.Browse?Category=$1&Submitted=1	[NC]
RewriteRule ^/specialty/([^/.]+)$ /index.cfm/event/Activity.Browse?Specialty=$1&Submitted=1	[NC]
RewriteRule ^/browse$ /index.cfm/event/Activity.Browse  [NC]
RewriteRule ^/signup$ /index.cfm/event/Main.Register  [NC]
RewriteRule ^/about$ /index.cfm/event/Main.About  [NC]
RewriteRule ^/support$ /index.cfm/event/Main.Support  [NC]
RewriteRule ^/login$ /index.cfm/event/Main.Login  [NC]
RewriteRule ^/feeds/([^/.]+)/([^/.]+)$ /_com/Feeds.cfc?method=$1&Mode=$2&returnformat=plain	[NC]

#LMS SUPPORT
RewriteRule ^/support/kb/([^/.]+)$ /support/index.php/kb/$1  [NC]
RewriteRule ^/support/([^/.]+)$ /support/index.php/$1  [NC]

#ADMIN
RewriteRule ^/register/([^/.]+)/([^/.]+)$ /admin/index.cfm/event/Public.Register?ActivityID=$1&Step=$2  [NC]
RewriteRule ^/register/([^/.]+)$ /admin/index.cfm/event/Public.Register?ActivityID=$1  [NC]
RewriteRule ^/download/([^/.]+)/([^/.]+)/([^/.]+)$ /admin/index.cfm/event/Public.Download?mode=$1&ModeID=$2&fid=$3  [NC]
#########################
--->
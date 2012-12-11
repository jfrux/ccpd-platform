<cfparam name="attributes.format" default="PDF">
<cfsavecontent variable="stylesheet">
<style>
body { margin:0; }
.certificates { font-family:"Times New Roman", Times, serif; }
.certificate { border:1px solid #E51937;
float:left;
left:0;
margin:auto;
position:absolute;
right:0; }
.certline { left:0;
right:0;
text-align:center;
position:relative;
width:100%;
clear:both; }

.sigs { margin-top:15px; height:170px; position:relative; }
.sigs div { 
font-size:12pt;
font-weight:bold;
margin:auto;
position:absolute;
text-align:left;
width:200px; 
}

.statements {  font-size:10pt;
font-style:italic;
font-weight:bold;
margin:20px;
width:95%; }

.bluefont {  color: rgb(0, 51, 153); }
</style>
</cfsavecontent>

<cfsavecontent variable="header">
<?xml version=”1.0? encoding=”UTF-8??>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN” “http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<cfoutput>#stylesheet#</cfoutput>
</head>
<body>
<div class="certificates">
</cfsavecontent>

<cfsavecontent variable="footer">
</div>
</body>
</html>
</cfsavecontent>

<cfoutput>
<cfswitch expression="#Attributes.Format#">
	<cfcase value="PDF">
		<cfdocument format="pdf">
			#header#
			<cfloop query="qReportData">
				#renderCert()#
			</cfloop>
			#footer#
		</cfdocument>
	</cfcase>
	<cfcase value="FLASH">
		<cfdocument format="flashpaper">
		#header#
		<cfloop query="qReportData">
			#renderCert()#
		</cfloop>
		#footer#
		</cfdocument>
	</cfcase>
	<cfcase value="HTML">
		#header#
		<cfloop query="qReportData">
			#renderCert()#
		</cfloop>
		#footer#
	</cfcase>
	<cfdefaultcase>
		<cfdocument format="pdf">
			#header#
			<cfloop query="qReportData">
				#renderCert()#
			</cfloop>
			#footer#
		</cfdocument>
	</cfdefaultcase>
</cfswitch>
</cfoutput>

<cffunction name="renderCert" access="public" output="yes">
	<cfset var certificate = "">
	<cfsavecontent variable="certificate">
	<cfoutput>
		<div class="certificate">
			<div class="certline" style="width: 600px; margin: 50px auto 0;"><img src="#application.settings.rootpath#/_images/uc_logo_separate.png" style="width:85px; float:left;" /><div class="bluefont" style="font-size: 17pt; font-weight: bold;">CERTIFICATE OF ATTENDANCE</div>
			<div class="bluefont" style="font-size: 17pt; font-weight: bold;">Universtity of Cincinnati College of Medicine</div></div>
			
			<div class="certline bluefont" style="font-size:12pt;padding: 10px 0pt;">certifies that</div>
			<div class="certline" style="font-size:18pt;padding: 10px 0pt;">#qReportData.FirstName# #qReportData.LastName#</div>
			<div class="certline bluefont" style="font-size:10pt;padding: 10px 0pt;">has participated in the educational activity</div>
			<div class="certline" style="font-size:18pt;padding: 10px 0pt;">#qReportData.ActivityTitle#</div>
			<cfif qReportData.City NEQ "" AND qReportData.State NEQ "">
				<div class="certline bluefont" style="font-size:12pt;padding: 5px 0pt;">in</div>
				<div class="certline" style="font-size:12pt;padding: 5px 0pt;">#qReportData.City#, #qReportData.State#</div>
			<cfelse>
				<div class="certline" style="font-size:0pt;">&nbsp;</div>
				<div class="certline" style="font-size:0pt;">&nbsp;</div>
			</cfif>
			<div class="certline bluefont" style="font-size:12pt;padding: 10px 0pt;">on</div>
			<div class="certline" style="font-size:16pt;padding: 10px 0pt;">#qReportData.CertificateDate#</div>
			<div class="certline" style="font-size:10pt;padding: 10px 0pt; font-style: italic;">#qReportData.AwardStatement#</div>
            <cfif qReportData.ActivityTypeID EQ 2>
            	<div class="certline bluefont" style="font-size:10pt; padding: 10px 0px;">
                <p>
                Material Approval Date: #DateFormat(qReportData.CertificateDate, 'MMMM YYYY')#<br />
                Material Expiration Date: #DateFormat(qReportData.EndDate, 'MMMM YYYY')#</p>
                </div>
            <cfelse>
            	<div class="certline bluefont" style="font-size:10pt; padding: 10px 0px;">&nbsp;</div>
            </cfif>
			<div class="sigs certline bluefont">
				<div style="left: 20pt; top: 0pt; bottom: 0pt; height: 40px;">
					University of Cincinnati<br />
					College of Medicine
				</div>
				
				<div style="right: 0pt; top: 0pt; bottom: 0pt; width:200px;">
				<img src="#application.settings.rootpath#/_images/john_kues_signature.png" style="width: 170px; " /><br />
					John R. Kues, Ph, D.<br />
					Assistant Dean for<br />
					Continuing<br />
					Medical Education
				</div>
			</div>
			<div class="statements certline">
				<p>#qReportData.SponsorshipStatement#</p>
				<p>
				The University of Cincinnati designates this educational activity for a maximum of #qReportData.TotalAmount# AMA PRA Category 1 
				Credit(s)&trade;.  
				Physicians should only claim credit commensurate with the extent of their participation in the activity.
				</p>
				<p>
				This activity has been planned and implemented in accordance with the Essentials and Standards of the 
				Acceditation Council for Continuing Medical Education through the University of Cincinnati.  
				The University of Cincinnati College of Medicine is accredited by the Accreditation Council for 
				Continuing Medical Education (ACCME) to provide continuing medical education for physicians.  
				For more information, visit www.cme.uc.edu.
				</p>
			</div>
		</div>
	</cfoutput>
	</cfsavecontent>
	
	<cfreturn certificate />
</cffunction>

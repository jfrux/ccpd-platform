<cfparam name="Attributes.Format" default="PDF">
<cfsavecontent variable="stylesheet">
<style>
.certificates { font-family:"Times New Roman", Times, serif; }
.certificate { border:1px solid #E51937;
float:left;
height:9.6in;
left:17px;
margin-top:1px;
padding:10px 0 0;
position:relative;
right:0;
width:100%; }
.certline { left:0;
right:0;
text-align:center;
width:615px; }

.sigs { margin-top:15px; height:170px; position:relative; }
.sigs div { position:absolute; text-align:left; font-size:12pt; font-weight: bold; margin:auto; }

.statements {  font-size:10pt; font-weight: bold; font-style: italic; }

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
<div class="certificates" style="width: 625px;">
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
				<cfdocumentitem type="pagebreak" />
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
				<cfdocumentitem type="pagebreak" />
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
			<div class="certline"><img src="#Application.Settings.RootPath#/_images/uc_logo_separate.png" style="width:85px;" /></div>
			<div class="certline bluefont" style="font-size: 24pt; font-weight: bold;padding: 10px 0pt;">CERTIFICATE OF ATTENDANCE</div>
			<div class="certline bluefont" style="font-size: 17pt; font-weight: bold;padding: 10px 0pt;">Universtity of Cincinnati College of Medicine</div>
			<div class="certline bluefont" style="font-size:12pt;padding: 10px 0pt;">certifies that</div>
			<div class="certline" style="font-size:18pt;padding: 10px 0pt;">#qReportData.FirstName# #qReportData.LastName#</div>
			<div class="certline bluefont" style="font-size:10pt;padding: 10px 0pt;">has participated in the educational activity</div>
			<div class="certline" style="font-size:18pt;padding: 10px 0pt;">#qReportData.ActivityTitle#</div>
			<cfif qReportData.City NEQ "" AND qReportData.State NEQ "">
				<div class="certline bluefont" style="font-size:12pt;padding: 10px 0pt;">in</div>
				<div class="certline" style="font-size:16pt;padding: 10px 0pt;">#qReportData.City#, #qReportData.State#</div>
			<cfelse>
				<div class="certline" style="font-size:12pt;">&nbsp;</div>
				<div class="certline" style="font-size:16pt;">&nbsp;</div>
			</cfif>
			<div class="certline bluefont" style="font-size:12pt;padding: 10px 0pt;">on</div>
			<div class="certline" style="font-size:16pt;padding: 10px 0pt;">#qReportData.CertificateDate#</div>
			<div class="certline" style="font-size:10pt;padding: 10px 0pt; font-style: italic;">#qReportData.AwardStatement#</div>
			<div class="sigs certline bluefont">
				<div style="left: 20pt; top: 0pt; bottom: 0pt; height: 40px;">
					University of Cincinnati<br />
					College of Medicine
				</div>
				<cfif qReportDataPre.ActivityTypeID EQ 2>
					<div style="left: 20pt; top: 80pt; bottom: 0pt; height: 40px;">
                    Material Approval Date: #DateFormat(qReportDataPre.CertificateDate, 'MMMM YYYY')#<br />
                    Material Expiration Date: #DateFormat(qReportDataPre.EndDate, 'MMMM YYYY')#
                    </div>
                </cfif>
				<div style="left: 20pt; top: 0pt; bottom: 0pt; height: 40px;">
					University of Cincinnati<br />
					College of Medicine
				</div>
				
				<div style="right: 0pt; top: 0pt; bottom: 0pt; width:200px;">
				<img src="#Application.Settings.RootPath#/_images/john_kues_signature.png" style="width: 170px; " /><br />
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

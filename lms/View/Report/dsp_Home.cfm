<style>
.report-group { 
-webkit-border-radius: 7px;
-moz-border-radius-bottomleft:7px;
-moz-border-radius-bottomright:7px;
-moz-border-radius-topleft:7px;
-moz-border-radius-topright:7px;
padding:1px;
}

.report-group h3 { 
-moz-border-radius-topleft:7px;
-moz-border-radius-topright:7px; margin:1px!important; }

.report-section { background-color:#EEE; border:1px solid #CCC; padding:8px; margin:4px;-webkit-border-radius: 7px;
-moz-border-radius-bottomleft:7px;
-moz-border-radius-bottomright:7px;
-moz-border-radius-topleft:7px;
-moz-border-radius-topright:7px; }
.report-section:hover { background-color:#F7F7F7; }

.report-section ul { margin-left:18px; margin-top:4px; }
.report-section li { list-style-type:circle; }
.report-section li a { padding:1px 1px; }
.report-section li a:hover {  }
.report-section li span { font-size:.95em; color:#555; font-style:italic; }

.report-section h4 { margin:0!important; padding:0!important; }
</style>
<cfoutput>
<div class="ViewSection">
	<div class="report-group">
		<h3>Activity Reports</h3>
		<div class="report-section">
		<h4>Lists of activities</h4>
		<ul>
			<li><a href="#Myself#report.ContainerSummary">Activities by Container</a></li>
            <li><a href="#Myself#report.advancedactivity">Activities by Type</a></li>
			<li><a href="#Myself#report.SpecialtyLMS">Activities by Specialty</a> <span>learning management system</span></li>
			<li><a href="#Myself#report.CategoryLMS">Activities by Category</a> <span>learning management system</span></li>
		</ul>
		</div>
		
		<div class="report-section">
		<h4>Assessment Reports</h4>
		<ul>
			<li><a href="#Myself#report.assesssingle">Individual Assessment Report</a></li>
			<li><a href="#Myself#report.testingsummary">Pre/Post Test Data PIE CHART</a></li>
			<li><a href="#Myself#report.legacysurvey">Legacy Survey Builder Results (Old LMS)</a></li>
			<li><a href="#Myself#report.cpdEvals">Legacy CPD Evaluation Results (Old LMS)</a></li>
		</ul>
		</div>
		<div class="report-section">
		<h4>Accreditation</h4>
		<ul>
			<li><a href="javascript:alert('coming soon!');">ACCME PARS Export</a></li>
			<li><a href="#Myself#report.accmeSummary">ACCME Summary</a></li>
			<li><a href="#Myself#report.accmePrep">ACCME Preparation</a> <span>Not formatted for ACCME Submission</span></li>
			<li><a href="#Myself#report.accmePrep-mod">ACCME Preparation Modified</a> <span>Includes "Designed to Change"/"Changes in Evaluated" fields</span></li>
		</ul>
		</div>
		
		<div class="report-section">
		<h4>Financial Reports</h4>
		<ul>
			<li><a href+""></a></li>
		</ul>
		</div>
		
		<div class="report-section">
		<h4>STD/HIV - CDC Related</h4>
		<ul>
			<li><a href="#Myself#report.cdcreport">CDC Activity/Student Report</a></li>
            <li><a href="#Myself#report.cdcstateattendeecount">Attendee Count for Activity Type by State</a></li>
			<li><a href="#Myself#report.cdcoverview">CDC Overview Report</a></li>
            <li><a href="#Myself#report.cdcpiftally">CDC PIF Tally Report</a></li>
			<!---<li><a href="#Myself#report.cdcpif">CDC PIF Report</a></li>--->
		</ul>
		</div>
	</div>
</div>

<div class="ViewSection">
	
	<p>&nbsp;
	
	</p>
</div>

<div class="ViewSection">
	<h3>Processes &amp; Queues</h3>
	<p>&nbsp;
	
	</p>
</div>
</cfoutput>
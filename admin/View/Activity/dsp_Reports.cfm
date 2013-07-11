<script>
App.Activity.Reports.start();
</script>
<cfoutput>
<cfset qAssessments = Application.Com.AssessmentGateway.getByViewAttributes(ActivityID=Attributes.ActivityID,DeletedFlag='N')>
<div class="ViewSection">
  <div class="report-group">
    <h4>Assessments</h4>
    <div class="report-item">
      <div class="report-item-title">Inception Data / Tally</div>
      <div class="report-item-details">Full data dump / tally since activity went live.</div>
      <div class="report-item-criteria">
        <form class="form-horizontal" action="#Application.Settings.RootPath#/_com/Report/Assess_AnswerDump.cfc" method="get">
          <input type="hidden" name="method" value="Run" />
          <input type="hidden" name="reportLabel" value="Incept" />
          
          <div class="control-group">
            <label class="control-label" for="AssessmentID">Assessment</label>
            <div class="controls">
            <select name="AssessmentID" class="fieldinput" style="width: 190px;">
              <cfloop query="qAssessments">
              <option value="#qAssessments.AssessmentID#">#qAssessments.AssessTypeName#</option>
              </cfloop>
            </select>
            </div>
          </div>
          
          <div class="control-group">
            <div class="controls">
              <label for="showDeleted-2" class="checkbox">
                <input type="checkbox" name="showDeleted" id="showDeleted-1" checked="checked" />
                Show deleted questions in report.
              </label> 
            </div>
          </div>
          
          <div class="control-group">
            <div class="controls">
              <input type="submit" name="submit" value="Download" class="btn" />
            </div>
          </div>
        </form>
      </div>
    </div>

    <div class="report-item">
      <cfset currDate = now() />
      <cfset prevMonth = dateAdd('m',-1,currDate) />
      <cfset prevMonthLastDay = DateAdd("d", -1, CreateDate(year(currDate), month(currDate), 1))>
      <cfset startDate = createDate(year(prevMonth),month(prevMonth),1) />
      <cfset endDate = createDate(year(prevMonth),month(prevMonth),day(prevMonthLastDay))/>
      <div class="report-item-title">Last Month Data / Tally</div>
      <div class="report-item-details">Data dump / tally for #dateFormat(startDate,'mm/dd/yyyy')# - #dateFormat(endDate,'mm/dd/yyyy')#</div>
      <div class="report-item-criteria">
        <form class="form-horizontal" action="#Application.Settings.RootPath#/_com/Report/Assess_AnswerDump.cfc" method="get">
          <input type="hidden" name="method" value="Run" />
          <input type="hidden" name="startDate" value="#startDate#" />          
          <input type="hidden" name="endDate" value="#endDate#" />
          <input type="hidden" name="reportLabel" value="Month" />
        
          <div class="control-group">
            <label class="control-label" for="AssessmentID">Assessment</label>
            <div class="controls">
            <select name="AssessmentID" class="fieldinput" style="width: 190px;">
              <cfloop query="qAssessments">
              <option value="#qAssessments.AssessmentID#">#qAssessments.AssessTypeName#</option>
              </cfloop>
            </select>
            </div>
          </div>

          <div class="control-group">
            <div class="controls">
              <label for="showDeleted-2" class="checkbox">
                <input type="checkbox" name="showDeleted" id="showDeleted-2" checked="checked" /> Show deleted questions in report.
              </label> 
            </div>
          </div>

          <div class="control-group">
            <div class="controls">
              <input type="submit" name="submit" value="Download" class="btn" />
            </div>
          </div>
        </form>
      </div>
    </div>

    <div class="report-item">
      <cfset startDate = firstDayOfWeek(dateAdd('ww',-1,now())) />
      <cfset endDate = dateAdd('d',6,startDate) />
      <div class="report-item-title">Last Week Data / Tally</div>
      <div class="report-item-details">Data dump / tally for #dateFormat(startDate,'mm/dd/yyyy')# - #dateFormat(endDate,'mm/dd/yyyy')#</div>
      <div class="report-item-criteria">
        <form class="form-horizontal" action="#Application.Settings.RootPath#/_com/Report/Assess_AnswerDump.cfc" method="get">
          <input type="hidden" name="method" value="Run" />
          <input type="hidden" name="startDate" value="#startDate#" />          
          <input type="hidden" name="endDate" value="#endDate#" />
          <input type="hidden" name="reportLabel" value="Week" />
          
          <div class="control-group">
            <label class="control-label" for="AssessmentID">Assessment</label>
            <div class="controls">
            <select name="AssessmentID" class="fieldinput" style="width: 190px;">
              <cfloop query="qAssessments">
              <option value="#qAssessments.AssessmentID#">#qAssessments.AssessTypeName#</option>
              </cfloop>
            </select>
            </div>
          </div>

          <div class="control-group">
            <div class="controls">
              <label for="showDeleted-2" class="checkbox">
                <input type="checkbox" name="showDeleted" id="showDeleted-3" checked="checked" /> Show deleted questions in report.
              </label> 
            </div>
          </div>

          <div class="control-group">
            <div class="controls">
              <input type="submit" name="submit" value="Download" class="btn" />
            </div>
          </div>
        </form>
      </div>
    </div>

  </div>
  <div class="report-group">
    <h4>Participants</h4>
    <div class="report-item">
      <div class="report-item-title">Attendance</div>
      <div class="report-item-details">
      Raw attendance data from the participants.<br />
      </div>
      <div class="report-item-criteria">
        <form class="form-horizontal" action="#Application.Settings.RootPath#/_com/Report/Attendance.cfc" method="get">
          <input type="hidden" name="method" value="Run" />
          <input type="hidden" name="ActivityID" value="#Attributes.activityID#" />

          <div class="control-group">
            <input type="submit" name="submit" value="Download" class="btn btn-default mll" />
          </div>
        </form>
      </div>
      <div class="report-container-loading" id="attendance-report-loading"><img src="/admin/_images/ajax-loader.gif" /></div>
      <div class="report-container-download" id="attendance-report-download"></div>
    </div>
  </div>
    <cfif application.activity.isCDCActivity(attributes.ActivityID)>
  <div class="report-group">
    <h4>CDC Reports</h4>
    <div class="report-item">
      <div class="report-item-title">CDC PIF Report</div>
      <div class="report-item-details">
      Extract raw attendance data from the registrants.<br />
      </div>
      <div class="report-item-criteria">
        <form action="#Application.Settings.RootPath#/_com/Report/CDCPIFTally.cfc" method="get">
          <input type="hidden" name="method" value="Run" />
          <input type="hidden" name="ActivityID" value="#Attributes.activityID#" />
          <input type="hidden" name="startDate" value="#Attributes.StartDate#" />
          <input type="hidden" name="endDate" value="#Attributes.endDate#" />
          <input type="submit" name="submit" value="Download" class="btn" />
        </form>
      </div>
      <div class="report-container-loading" id="attendance-report-loading"><img src="/admin/_images/ajax-loader.gif" /></div>
      <div class="report-container-download" id="attendance-report-download"></div>
    </div>
  </div>
    </cfif>
  <div class="report-group">
    <h4>Financial Reports</h4>
    
    <div class="alert mtl">
      Custom finance reports may be created upon request.
    </div>
  </div>
   <!--- <div class="report-container" id="individ-report-container">
        <div class="report-container-title"><a href="Report.AssessSingle?activityid=#Attributes.ActivityID#" class="report-title" id="individ-report-title">Individual Assessment Report</a> <img src="#Application.Settings.RootPath#/_images/222222_7x7_arrow_right.gif" class="report-arrow" id="individ-report-arrow" /></div>
        <div class="report-container-content" id="individ-report-content">
            <!---<div class="report-container-options"><input type="checkbox" name="Email" id="individ-email" /><label for="individ-email">Include Email Addresses</label></div>
            <div class="report-container-buttons"><input type="button" value="Generate" class="btnSubmit" name="btnIndividReport" id="individ-report-generator" /></div>--->
        </div>
        <div class="report-container-loading" id="individ-report-loading"><img src="/admin/_images/ajax-loader.gif" /></div>
        <div class="report-container-download" id="individ-report-download"></div>
    </div>
    <div class="report-container" id="assess-report-container">
      <div class="report-container-title"><a href="Report.Assessment?activityid=#Attributes.ActivityID#" class="report-title" id="assess-report-title">Activity Assessment Report</a> <img src="#Application.Settings.RootPath#/_images/222222_7x7_arrow_right.gif" class="report-arrow" id="assess-report-arrow" /></div>
        <div class="report-container-content" id="assess-report-content">
            <!---<div class="report-container-options"><input type="checkbox" name="Email" id="assess-email" /><label for="assess-email">Include Email Addresses</label></div>
            <div class="report-container-buttons"><input type="button" value="Generate" class="btnSubmit" name="btnAssessReport" id="assess-report-generator" /></div>--->
        </div>
        <div class="report-container-loading" id="assess-report-loading"><img src="/admin/_images/ajax-loader.gif" /></div>
        <div class="report-container-download" id="assess-report-download"></div>
    </div>--->
</div>
<cfscript>
/**
* Analogous to firstDayOfMonth() function.
*
* @param date      Date object used to figure out week. (Required)
* @return Returns a date.
* @author Pete Ruckelshaus (pruckelshaus@yahoo.com)
* @version 1, September 12, 2007
*/
function firstDayOfWeek(date) {
    var dow = "";
    var dowMod = "";
    var dowMult = "";
    var firstDayOfWeek = "";
    date = trim(arguments.date);
    dow = dayOfWeek(date);
    dowMod = decrementValue(dow);
    dowMult = dowMod * -1;
    firstDayOfWeek = dateAdd("d", dowMult, date);
    
    return firstDayOfWeek;
}
</cfscript>
</cfoutput>

<script>
<cfoutput>
var sFirstName = '#replace(Attributes.FirstName,"'","\'","ALL")#';
var sLastName = '#replace(Attributes.LastName,"'","\'","ALL")#';
var sFullName = sFirstName + ' ' + sLastName;
</cfoutput>

</script>
<cfoutput>
<div class="toolbar btn-toolbar">
  <div class="btn-group">
    <a href="javascript://" id="moveActivities" class="btn btn-mini js-moveactivities"><i class="icon-road"></i></a>
  </div>
  <div class="btn-group">
    <a class="btn btn-mini btn-transcript dropdown-toggle js-transcript-menu" data-toggle="dropdown" href="##">
      Transcript
      <span class="caret"></span>
    </a>
    <ul class="dropdown-menu">
      <li class="nav-header">
        <form class="form-horizontal">
          <div class="control-group">
            <input type="text" class="js-transcript-date col col-lg-24" placeholder="start date" name="StartDate" />
          </div>
          <div class="control-group">
            <input type="text" class="js-transcript-date col col-lg-24" placeholder="end date" name="EndDate" />
          </div>
          <a href="javascript://" class="btn js-transcript-button"><i class="icon-refresh"></i> Generate</a>
        </form>
      </li>
    </ul>
  </div>
</div>
<cf_cePersonFinder Instance="MoveActivities" DefaultName="Move Activities" DefaultID="" AddPersonFunc="moveActivities();">
</cfoutput>
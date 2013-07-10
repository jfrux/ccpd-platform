<cfoutput>
<div class="navbar navbar-inverse navbar-fixed-top">
  <div class="container">
    <a class='navbar-toggle' data-target='.navbar-responsive-collapse' data-toggle='collapse' href='javascript:void(0);'>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </a>
    <a class="navbar-brand" href="/">
      <div class="cropper">CCPD</div>
      <div class="logo3d"></div>
    </a>
    <div class="global-nav nav-collapse collapse">
      <ul class="nav navbar-nav global-nav-links">
        <li<cfif params.event EQ "main-welcome"> class="active"</cfif>><a href="#myself#main.welcome"><i class="nav-icon-home"></i><span class="text">Home</span></a></li>
        <li<cfif params.event EQ "main-activities" OR params.controller EQ "activity"> class="active"</cfif>><a href="#myself#main.activities"><i class="nav-icon-activities"></i><span class="text">Activities</span></a></li>
        <li<cfif params.event EQ "main-people" OR params.controller EQ "person"> class="active"</cfif>><a href="#myself#main.people"><i class="nav-icon-people"></i><span class="text">People</span></a></li>
        <li<cfif params.event EQ "main-reports"> class="active"</cfif>><a href="#myself#main.reports"><i class="nav-icon-reports"></i><span class="text">Reports</span></a></li>
      </ul>
      <ul class="nav navbar-nav global-nav-links global-nav-panes pull-right">
        <li class="divider-vertical"></li>
        <li class="dropdown">
          <a data-toggle="dropdown" class="dropdown-toggle" href="##">
            <i class="nav-icon-user-profile" style="background-image:url(#imageUrl('default_photo/person_m_i.png')#);"></i>
          </a>
          <ul class="dropdown-menu">
            <li>#linkTo(controller="person",action="detail",params="personid=#session.person.getPersonId()#",text='Edit Profile')#</li>
            <li>#linkTo(controller="person",action="preferences",params="personid=#session.person.getPersonId()#",text='Preferences')#</li>
            <li>#linkTo(controller="main",action="dologout",text='Logout')#</li>
          </ul>
        </li>
        <li class="dropdown">
          <a data-toggle="dropdown" class="dropdown-toggle" href="##"><i class="nav-icon-alerts"></i></a>
          <div class="alerts-menu dropdown-menu">
            <div class="dropdown-menu-header">
              <div class="title pull-left">Notifications</div>
              <div class="actions pull-right">
                <a href="##">Settings</a>
              </div>
            </div>
            <div class="dropdown-menu-body">
              No notifications at this time.
            </div>
          </div>
        </li>
      </ul>

      <!--- <form class="navbar-search pull-right">
        <input type="text" class="search-query span4" placeholder="Search">
      </form> --->
    </div>
  </div>
</div>
</cfoutput>
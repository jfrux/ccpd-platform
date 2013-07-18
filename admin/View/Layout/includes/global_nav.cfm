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
        <li<cfif params.event EQ "main-welcome"> class="active"</cfif>><a href="#myself#main.welcome"><i class="icon-home"></i><span class="text">Home</span></a></li>
        <li<cfif params.event EQ "main-activities" OR params.controller EQ "activity"> class="active"</cfif>><a href="#myself#main.activities"><i class="icon-book-open"></i><span class="text">Activities</span></a></li>
        <li<cfif params.event EQ "main-people" OR params.controller EQ "person"> class="active"</cfif>><a href="#myself#main.people"><i class="icon-users"></i><span class="text">People</span></a></li>
        <li<cfif params.event EQ "main-reports"> class="active"</cfif>><a href="#myself#main.reports"><i class="icon-chart-bar"></i><span class="text">Reports</span></a></li>
      </ul><!--- <form class="navbar-search pull-right">
        <input type="text" class="search-query span4" placeholder="Search">
      </form> --->
    </div>

    <cfif session.loggedIn>
    <div class="global-panes">
      <ul class="nav navbar-nav global-nav-links global-nav-panes pull-right">
        <li class="divider-vertical"></li>
        <li class="pane-user-profile dropdown">
          <a data-toggle="dropdown" class="dropdown-toggle" href="##">
            <i class="icon-user-profile" style="background-image:url(#imageUrl('default_photo/person_m_i.png')#);"></i>
          </a>
          <ul class="dropdown-menu">
            <li>#linkTo(controller="person",action="detail",params="personid=#session.person.getPersonId()#",text='Edit Profile')#</li>
            <li>#linkTo(controller="person",action="preferences",params="personid=#session.person.getPersonId()#",text='Preferences')#</li>
            <li>#linkTo(controller="main",action="dologout",text='Logout')#</li>
          </ul>
        </li>
        <li class="pane-notifs dropdown">
          <a data-toggle="dropdown" class="dropdown-toggle" href="##"><i class="icon-bell-alt"></i></a>
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
    </div>
    </cfif>
  </div>
</div>

<div class="jpanel-nav">
  <ul class="nav nav-pills nav-stacked">
    <li class="nav-header">Account</li>
  <cfif session.loggedIn>
    <li<cfif params.controller EQ "person" AND attributes.personId EQ session.personid> class="active"</cfif>>
      <a data-toggle="dropdown" class="dropdown-toggle" href="##">
        <i class="icon-user-profile" style="background-image:url(#imageUrl('default_photo/person_m_i.png')#);"></i>
        <span class="text">#session.person.getCertName()#</span>
      </a>
    </li>
   <li<cfif params.event EQ "person-preferences" AND attributes.personId EQ session.personid> class="active"</cfif>>#linkTo(controller="person",action="preferences",params="personid=#session.person.getPersonId()#",text='<i class="icon-cog-alt"></i><span class="text">Preferences</span>')#</li>
   <li>#linkTo(controller="main",action="dologout",text='<i class="icon-logout"></i><span class="text">Sign Out</span>')#</li>
  <cfelse>
    <li<cfif params.event EQ "main-login"> class="active"</cfif>><a href="#myself#main.login"><i class="icon-lock"></i><span class="text">Sign-in</span></a></li>
    <li<cfif params.event EQ "main-register"> class="active"</cfif>><a href="#myself#main.register"><i class="icon-user"></i><span class="text">Create an account</span></a></li>
  </cfif>
    <li class="nav-header">Sections</li>
    <li<cfif params.event EQ "main-welcome"> class="active"</cfif>><a href="#myself#main.welcome"><i class="icon-article-alt"></i><span class="text">News Feed</span></a></li>
    <li<cfif params.event EQ "main-activities" OR params.controller EQ "activity"> class="active"</cfif>><a href="#myself#main.activities"><i class="icon-book-open"></i><span class="text">Activities</span></a></li>
    <li<cfif params.event EQ "main-people" OR params.controller EQ "person"> class="active"</cfif>><a href="#myself#main.people"><i class="icon-users"></i><span class="text">People</span></a></li>
    <li<cfif params.event EQ "main-reports"> class="active"</cfif>><a href="#myself#main.reports"><i class="icon-chart-bar"></i><span class="text">Reports</span></a></li>
    <li class="nav-footer">&copy;#Year(now())# University of Cincinnati</li>
  </ul>
</div>
</cfoutput>
<cfparam name="Request.Page.Title" default="Untitled Page">
<cfparam name="Request.Page.Body" default="No Body Found">
<cfparam name="Request.Page.Breadcrumbs" default="">
<cfparam name="tabSettings" default="{ 'title':'No Title' }" />
<cfif structkeyExists(request,'tabSettings') AND structKeyExists(request.tabSettings,attributes.fuseaction)>
  <cfset tabSettings = request.tabSettings.tabs[lcase(attributes.fuseaction)] />
<cfelse>
  <cfset tabSettings = {
    'title':""
  } />
</cfif>
<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title><cfif structKeyExists(tabSettings,'title') AND len(trim(tabSettings.title)) GT 0>
    #tabSettings.title# - </cfif>#Application.Settings.AppName#</title>
  <cfinclude template="dsp_HeadGlobal.cfm" />
  <script>
  sMyself = "#Myself#";
  sRootPath = "#Application.Settings.RootPath#";
  
  </script>
</head>

<body class="#params.controller# #params.action# #params.event# tabs tab#Request.NavItem#">
  <div class="body-inner container-fluid">
      <div class="global-nav navbar navbar-inverse navbar-fixed-top">
        <div class="global-nav-inner navbar-inner">
          <div class="container">
            <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="brand" href="/">
              <div class="cropper">CCPD</div>
              <div class="logo3d"></div>
            </a>
            <div class="">
              <ul class="nav global-nav-links">
                <li<cfif params.event EQ "main-welcome"> class="active"</cfif>><a href="#myself#main.welcome"><i class="nav-home"></i><span class="text">Home</span></a></li>
                <li<cfif params.event EQ "main-activities" OR params.controller EQ "activity"> class="active"</cfif>><a href="#myself#main.activities"><i class="nav-activities"></i><span class="text">Activities</span></a></li>
                <li<cfif params.event EQ "main-people" OR params.controller EQ "person"> class="active"</cfif>><a href="#myself#main.people"><i class="nav-people"></i><span class="text">People</span></a></li>
                <li<cfif params.event EQ "main-reports"> class="active"</cfif>><a href="#myself#main.reports"><i class="nav-reports"></i><span class="text">Reports</span></a></li>
              </ul>
              <ul class="nav global-nav-links global-nav-panes pull-right">
                <li class="divider-vertical"></li>
                <li class="dropdown">
                  <a data-toggle="dropdown" class="dropdown-toggle" href="##">
                    <i class="nav-user-profile" style="background-image:url(#imageUrl('default_photo/person_m_i.png')#);"></i>
                  </a>
                  <ul class="dropdown-menu">
                    <li>#linkTo(controller="person",action="detail",params="personid=#session.person.getPersonId()#",text='Edit Profile')#</li>
                    <li>#linkTo(controller="person",action="preferences",params="personid=#session.person.getPersonId()#",text='Preferences')#</li>
                    <li>#linkTo(controller="main",action="dologout",text='Logout')#</li>
                  </ul>
                </li>
                <li class="dropdown">
                  <a data-toggle="dropdown" class="dropdown-toggle" href="##"><i class="nav-alerts"></i></a>
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

              <form class="navbar-search pull-right">
                <input type="text" class="search-query span4" placeholder="Search">
              </form>
            </div>
          </div>
        </div>
      </div>
      <div class="container">
        <div id="Content">
          #request.page.body#
        </div>
        <div class="footer">
          <div class="footer-inner">
            Copyright &copy;#year(now())# University of Cincinnati. All Rights Reserved.
          </div>
        </div>
      </div>
    </cfoutput>
    </div>
    <div id="chatpanel">
    <div id="collective-xmpp-chat-data"></div>
    <div id="toggle-controlbox">
        <a href="#" class="chat toggle-online-users">
            <strong class="conn-feedback">Click here to chat</strong> <strong style="display: none" id="online-count">(0)</strong>
        </a>
    </div>
</div>
    <script>
    // http-pre-bind example
// This example works with mod_http_pre_bind found here:
// http://github.com/thepug/Mod-Http-Pre-Bind
// 
// It expects both /xmpp-httpbind to be proxied and /http-pre-bind
//
// If you want to test this out without setting it up, you can use Collecta's
// at http://www.collecta.com/xmpp-httpbind and 
// http://www.collecta.com/http-pre-bind
// Use a JID of 'guest.collecta.com' to test.

var BOSH_SERVICE = '/http-bind';
var PREBIND_SERVICE = '/admin/_com/ajax-chat.cfc?method=xmpp-auth';
var connection = null;

function log(msg) 
{
    $('#log').append('<div></div>').append(document.createTextNode(msg));
}

function rawInput(data)
{
    log('RECV: ' + data);
}

function rawOutput(data)
{
    log('SENT: ' + data);
}

function onConnect(status)
{
    if (status === Strophe.Status.CONNECTING) {
  log('Strophe is connecting.');
    } else if (status === Strophe.Status.CONNFAIL) {
  log('Strophe failed to connect.');
  $('#connect').get(0).value = 'connect';
    } else if (status === Strophe.Status.DISCONNECTING) {
  log('Strophe is disconnecting.');
    } else if (status === Strophe.Status.DISCONNECTED) {
  log('Strophe is disconnected.');
  $('#connect').get(0).value = 'connect';
    } else if (status === Strophe.Status.CONNECTED) {
  log('Strophe is connected.');
  connection.disconnect();
    } else if (status === Strophe.Status.ATTACHED) {
        log('Strophe is attached.');
        connection.disconnect();
    }
}

function normal_connect() {
    log('Prebind failed. Connecting normally...');

    connection = new Strophe.Connection(BOSH_SERVICE);
    connection.rawInput = rawInput;
    connection.rawOutput = rawOutput;

    connection.connect($('#jid').val(), $('#pass').val(), onConnect);
}

function attach(data) {
    log('Prebind succeeded. Attaching...');

    connection = new Strophe.Connection(BOSH_SERVICE);
    connection.rawInput = rawInput;
    connection.rawOutput = rawOutput;
    
    var $body = $(data.documentElement);
    connection.attach($body.find('jid').text(), 
                      $body.attr('sid'), 
                      parseInt($body.attr('rid'), 10) + 1, 
                      onConnect);
}

$(document).ready(function () {
    $('#connect').bind('click', function () {
  var button = $('#connect').get(0);
  if (button.value == 'connect') {
      button.value = 'disconnect';

            // attempt prebind
            $.ajax({
                type: 'POST',
                url: PREBIND_SERVICE,
                contentType: 'text/xml',
                processData: false,
                data: $build('body', {
                    to: Strophe.getDomainFromJid($('#jid').val()),
                    rid: '' + Math.floor(Math.random() * 4294967295),
                    wait: '60',
                    hold: '1'}).toString(),
                dataType: 'xml',
                error: normal_connect,
                success: attach});
  } else {
      button.value = 'connect';
      if (connection) {
                connection.disconnect();
            }
  }
    });
});
    </script>
    <div id='login' style='text-align: center'>
      <form name='cred'>
        <label for='jid'>JID:</label>
        <input type='text' id='jid'>
        <label for='pass'>Password:</label>
        <input type='password' id='pass'>
        <input type='button' id='connect' value='connect'>
      </form>
    </div>
    <div id='log'></div>
    <cfdump label="PARAMS" var="#params#" />
    <cfdump label="ATTRIBUTES" var="#attributes#" />
</body>
</html>
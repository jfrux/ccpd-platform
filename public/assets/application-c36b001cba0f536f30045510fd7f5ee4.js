/*
* CCPD JS-ASSETS
*/


(function() {


}).call(this);
(function() {
  var __slice = [].slice;

  window.HAML = (function() {
    function HAML() {}

    HAML.escape = function(text) {
      return ("" + text).replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;").replace(/'/g, "&#39;").replace(/\//g, "&#47;");
    };

    HAML.cleanValue = function(text) {
      switch (text) {
        case null:
        case void 0:
          return '';
        case true:
        case false:
          return '\u0093' + text;
        default:
          return text;
      }
    };

    HAML.extend = function() {
      var key, obj, source, sources, val, _i, _len;
      obj = arguments[0], sources = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
      for (_i = 0, _len = sources.length; _i < _len; _i++) {
        source = sources[_i];
        for (key in source) {
          val = source[key];
          obj[key] = val;
        }
      }
      return obj;
    };

    HAML.globals = function() {
      return {};
    };

    HAML.context = function(locals) {
      return this.extend({}, HAML.globals(), locals);
    };

    HAML.preserve = function(text) {
      return text.replace(/\n/g, '&#x000A;');
    };

    HAML.findAndPreserve = function(text) {
      var tags;
      tags = 'textarea,pre'.split(',').join('|');
      return text = text.replace(RegExp("<(" + tags + ")>([^]*?)<\\/\\1>", "g"), function(str, tag, content) {
        return "<" + tag + ">" + (window.HAML.preserve(content)) + "</" + tag + ">";
      });
    };

    HAML.surround = function(start, end, fn) {
      var _ref;
      return start + ((_ref = fn.call(this)) != null ? _ref.replace(/^\s+|\s+$/g, '') : void 0) + end;
    };

    HAML.succeed = function(end, fn) {
      var _ref;
      return ((_ref = fn.call(this)) != null ? _ref.replace(/\s+$/g, '') : void 0) + end;
    };

    HAML.precede = function(start, fn) {
      var _ref;
      return start + ((_ref = fn.call(this)) != null ? _ref.replace(/^\s+/g, '') : void 0);
    };

    HAML.reference = function(object, prefix) {
      var id, name, result, _ref;
      name = prefix ? prefix + '_' : '';
      if (typeof object.hamlObjectRef === 'function') {
        name += object.hamlObjectRef();
      } else {
        name += (((_ref = object.constructor) != null ? _ref.name : void 0) || 'object').replace(/\W+/g, '_').replace(/([a-z\d])([A-Z])/g, '$1_$2').toLowerCase();
      }
      id = typeof object.to_key === 'function' ? object.to_key() : typeof object.id === 'function' ? object.id() : object.id ? object.id : object;
      result = "class='" + name + "'";
      if (id) {
        return result += " id='" + name + "_" + id + "'";
      }
    };

    return HAML;

  })();

}).call(this);
(function() {


}).call(this);
(function() {
  if (window.JST == null) {
    window.JST = {};
  }

  window.JST['hub/hub_view'] = function(context) {
    return (function() {
      var $o;
      $o = [];
      $o.push("<div class='activity grouping-1 parent_activity profile type-1'>\n  <div class='profile-bg'>\n    <div class='profile-bg-inner'></div>\n  </div>\n  <div class='row'>\n    <div class='span5'>\n      <div class='js-projectbar projectbar'>\n        <div class='box'>\n          <div class='profile-picture' style='background-image:url(http://localhost:8888/assets/default_photo/activity_p.png);'></div>\n        </div>\n        <div class='box js-profile-menu'>\n          <div class='TabControl linkbar' id='Tabs'>\n            <div class='linkbar-inner'>\n              <ul class='nav'>\n                <li class='active'>\n                  <a data-data-icon='fg-card-address' data-js-namespace='js-activity-detail' data-pjax-container='#js-activity-detail' data-pjax-title='General Information' data-tooltip-title='Start Date: 09/28/2013<br />End Date: 09/28/2013' href='/admin/event/activity.detail?activityid=15088'>\n                    <i class='fg-card-address'></i>\n                    <span>General Info</span>\n                    <span class='icon-spin icon-spin2 menuLoader'></span>\n                    <span class='menuArrow'></span>\n                  </a>\n                </li>\n                <li>\n                  <a data-data-icon='fg-medal' data-js-namespace='js-activity-credits' data-pjax-container='#js-activity-credits' data-pjax-title='Credits' data-tooltip-title='CME: 1' href='/admin/event/activity.credits?activityid=15088'>\n                    <i class='fg-medal'></i>\n                    <span>Credits</span>\n                    <span class='icon-spin icon-spin2 menuLoader'></span>\n                    <span class='menuArrow'></span>\n                  </a>\n                </li>\n                <li>\n                  <a data-data-icon='fg-users' data-js-namespace='js-activity-attendees' data-pjax-container='#js-activity-attendees' data-pjax-title='Participants' data-tooltip-title='Total Records: 0<br />Physicians: 0<br />Non-Physicians: 0<br />Addl Participants: 0' href='/admin/event/activity.attendees?activityid=15088'>\n                    <i class='fg-users'></i>\n                    <span>Participants</span>\n                    <span class='navItemCount pull-right'>0</span>\n                    <span class='icon-spin icon-spin2 menuLoader'></span>\n                    <span class='menuArrow'></span>\n                  </a>\n                </li>\n                <li>\n                  <a data-data-icon='fg-user-business' data-js-namespace='js-activity-faculty' data-pjax-container='#js-activity-faculty' data-pjax-title='Faculty / Speakers' data-tooltip-title='' href='/admin/event/activity.faculty?activityid=15088'>\n                    <i class='fg-user-business'></i>\n                    <span>Faculty</span>\n                    <span class='icon-spin icon-spin2 menuLoader'></span>\n                    <span class='menuArrow'></span>\n                  </a>\n                </li>\n                <li>\n                  <a data-data-icon='fg-user-female' data-js-namespace='js-activity-committee' data-pjax-container='#js-activity-committee' data-pjax-title='Planning Committee Members' data-tooltip-title='' href='/admin/event/activity.committee?activityid=15088'>\n                    <i class='fg-user-female'></i>\n                    <span>Committee Members</span>\n                    <span class='icon-spin icon-spin2 menuLoader'></span>\n                    <span class='menuArrow'></span>\n                  </a>\n                </li>\n                <li>\n                  <a data-data-icon='fg-documents' data-js-namespace='js-activity-docs' data-pjax-container='#js-activity-docs' data-pjax-title='Files & Documents' data-tooltip-title='' href='/admin/event/activity.docs?activityid=15088'>\n                    <i class='fg-documents'></i>\n                    <span>Files & Documents</span>\n                    <span class='icon-spin icon-spin2 menuLoader'></span>\n                    <span class='menuArrow'></span>\n                  </a>\n                </li>\n                <li>\n                  <a data-data-icon='fg-flag-checker' data-js-namespace='js-activity-application' data-pjax-container='#js-activity-application' data-pjax-title='Application Checklist' data-tooltip-title='' href='/admin/event/activity.application?activityid=15088'>\n                    <i class='fg-flag-checker'></i>\n                    <span>Checklist</span>\n                    <span class='icon-spin icon-spin2 menuLoader'></span>\n                    <span class='menuArrow'></span>\n                  </a>\n                </li>\n                <li>\n                  <a data-data-icon='fg-calendar-blue' data-js-namespace='js-activity-agenda' data-pjax-container='#js-activity-agenda' data-pjax-title='Agenda' data-tooltip-title='' href='/admin/event/activity.agenda?activityid=15088'>\n                    <i class='fg-calendar-blue'></i>\n                    <span>Agenda</span>\n                    <span class='icon-spin icon-spin2 menuLoader'></span>\n                    <span class='menuArrow'></span>\n                  </a>\n                </li>\n                <li>\n                  <a data-data-icon='fg-money' data-js-namespace='js-activity-finances' data-pjax-container='#js-activity-finances' data-pjax-title='Finances' data-tooltip-title='' href='/admin/event/activity.finances?activityid=15088'>\n                    <i class='fg-money'></i>\n                    <span>Finances</span>\n                    <span class='icon-spin icon-spin2 menuLoader'></span>\n                    <span class='menuArrow'></span>\n                  </a>\n                  <ul class='nav subnav'>\n                    <li>\n                      <a data-data-icon='' data-js-namespace='js-activity-finledger' data-pjax-container='#js-activity-finledger' data-pjax-title='General Ledger' data-tooltip-title='' href='/admin/event/activity.finledger?activityid=15088'>\n                        <i></i>\n                        <span>General Ledger</span>\n                        <span class='icon-spin icon-spin2 menuLoader'></span>\n                        <span class='menuArrow'></span>\n                      </a>\n                    </li>\n                    <li>\n                      <a data-data-icon='' data-js-namespace='js-activity-finbudget' data-pjax-container='#js-activity-finbudget' data-pjax-title='Budget' data-tooltip-title='' href='/admin/event/activity.finbudget?activityid=15088'>\n                        <i></i>\n                        <span>Budget</span>\n                        <span class='icon-spin icon-spin2 menuLoader'></span>\n                        <span class='menuArrow'></span>\n                      </a>\n                    </li>\n                    <li>\n                      <a data-data-icon='' data-js-namespace='js-activity-finfees' data-pjax-container='#js-activity-finfees' data-pjax-title='Fee Schedule' data-tooltip-title='' href='/admin/event/activity.finfees?activityid=15088'>\n                        <i></i>\n                        <span>Fee Schedule</span>\n                        <span class='icon-spin icon-spin2 menuLoader'></span>\n                        <span class='menuArrow'></span>\n                      </a>\n                    </li>\n                    <li>\n                      <a data-data-icon='' data-js-namespace='js-activity-finsupport' data-pjax-container='#js-activity-finsupport' data-pjax-title='Commercial Support' data-tooltip-title='Total Supporters: 0<br />Total Dollars: $0.00' href='/admin/event/activity.finsupport?activityid=15088'>\n                        <i></i>\n                        <span>Commercial Support</span>\n                        <span class='icon-spin icon-spin2 menuLoader'></span>\n                        <span class='menuArrow'></span>\n                      </a>\n                    </li>\n                  </ul>\n                </li>\n                <li>\n                  <a data-data-icon='fg-sealing-wax' data-js-namespace='js-activity-accme' data-pjax-container='#js-activity-accme' data-pjax-title='ACCME Details' data-tooltip-title='' href='/admin/event/activity.accme?activityid=15088'>\n                    <i class='fg-sealing-wax'></i>\n                    <span>ACCME</span>\n                    <span class='icon-spin icon-spin2 menuLoader'></span>\n                    <span class='menuArrow'></span>\n                  </a>\n                </li>\n                <li>\n                  <a data-data-icon='fg-globe-green' data-js-namespace='js-activity-pubgeneral' data-pjax-container='#js-activity-pubgeneral' data-pjax-title='Publishing Settings' data-tooltip-title='' href='/admin/event/activity.pubgeneral?activityid=15088'>\n                    <i class='fg-globe-green'></i>\n                    <span>Publish</span>\n                    <span class='icon-spin icon-spin2 menuLoader'></span>\n                    <span class='menuArrow'></span>\n                  </a>\n                  <ul class='nav subnav'>\n                    <li>\n                      <a data-data-icon='' data-js-namespace='js-activity-pubbuilder' data-pjax-container='#js-activity-pubbuilder' data-pjax-title='Builder Components' data-tooltip-title='' href='/admin/event/activity.pubbuilder?activityid=15088'>\n                        <i></i>\n                        <span>Builder</span>\n                        <span class='icon-spin icon-spin2 menuLoader'></span>\n                        <span class='menuArrow'></span>\n                      </a>\n                    </li>\n                    <li>\n                      <a data-data-icon='' data-js-namespace='js-activity-pubcategory' data-pjax-container='#js-activity-pubcategory' data-pjax-title='Categories' data-tooltip-title='' href='/admin/event/activity.pubcategory?activityid=15088'>\n                        <i></i>\n                        <span>Categories</span>\n                        <span class='icon-spin icon-spin2 menuLoader'></span>\n                        <span class='menuArrow'></span>\n                      </a>\n                    </li>\n                    <li>\n                      <a data-data-icon='' data-js-namespace='js-activity-pubspecialty' data-pjax-container='#js-activity-pubspecialty' data-pjax-title='Specialty Areas' data-tooltip-title='' href='/admin/event/activity.pubspecialty?activityid=15088'>\n                        <i></i>\n                        <span>Specialities</span>\n                        <span class='icon-spin icon-spin2 menuLoader'></span>\n                        <span class='menuArrow'></span>\n                      </a>\n                    </li>\n                  </ul>\n                </li>\n                <li>\n                  <a data-data-icon='fg-sticky-note-pin' data-js-namespace='js-activity-notes' data-pjax-container='#js-activity-notes' data-pjax-title='Notes' data-tooltip-title='' href='/admin/event/activity.notes?activityid=15088'>\n                    <i class='fg-sticky-note-pin'></i>\n                    <span>Notes</span>\n                    <span class='icon-spin icon-spin2 menuLoader'></span>\n                    <span class='menuArrow'></span>\n                  </a>\n                </li>\n                <li>\n                  <a data-data-icon='fg-chart' data-js-namespace='js-activity-reports' data-pjax-container='#js-activity-reports' data-pjax-title='Reporting & Exports' data-tooltip-title='' href='/admin/event/activity.reports?activityid=15088'>\n                    <i class='fg-chart'></i>\n                    <span>Reporting & Exports</span>\n                    <span class='icon-spin icon-spin2 menuLoader'></span>\n                    <span class='menuArrow'></span>\n                  </a>\n                </li>\n                <li>\n                  <a data-data-icon='fg-clock-history' data-js-namespace='js-activity-history' data-pjax-container='#js-activity-history' data-pjax-title='History' data-tooltip-title='' href='/admin/event/activity.history?activityid=15088'>\n                    <i class='fg-clock-history'></i>\n                    <span>History</span>\n                    <span class='icon-spin icon-spin2 menuLoader'></span>\n                    <span class='menuArrow'></span>\n                  </a>\n                </li>\n              </ul>\n            </div>\n          </div>\n        </div>\n      </div>\n    </div>\n    <div class='span19'>\n      <div class='titlebar'>\n        <div class='row-fluid'>\n          <div class='span16'>\n            <div class='ContentTitle'>\n              <span title='Optimizing Treatment of Familial Hypercholesterolemia:  Current and Emerging Therapies'>Optimizing Treatment of ... and Emerging Therapies</span>\n            </div>\n          </div>\n          <div class='span8'>\n            <div class='action-buttons pull-right'>\n              <div class='btn-group'>\n                <a class='btn' id='MoveLink' href='javascript:void(0);' title='Move Activity'>\n                  <i class='icon-road'></i>\n                </a>\n                <a class='btn' id='CopyLink' href='javascript:void(0);' title='Copy Activity'>\n                  <i class='icon-doc'></i>\n                </a>\n                <a class='btn' id='DeleteActivityLink' href='javascript:void(0);' title='Delete Activity'>\n                  <i class='icon-trash'></i>\n                </a>\n              </div>\n              <div class='btn-group'>\n                <a class='btn js-toggle-infobar' title='Toggle Infobar'>\n                  <i class='icon-info'></i>\n                </a>\n              </div>\n            </div>\n          </div>\n        </div>\n      </div>\n    </div>\n    <div class='span19'>\n      <div class='content js-profile-content'>\n        <div class='row-fluid'>\n          <div class='js-content-toggle span18'>\n            <div class='row-fluid'>\n              <div class='content-title'>\n                <h3>General Information</h3>\n              </div>\n            </div>\n            <div class='MultiFormContent content-inner'>\n              <div id='js-activity-detail'>\n                <script>\n                  var lastSavedDate = \" at 12:29 PM\";\n                  var IsSaved = false;\n                \n                \n                  IsSaved = true;\n                </script>\n                <script>\n                  var LiveOptions = \"<option value=\"1\">Course</option>\" + \"<option value=\"2\">Regularly Scheduled Series</option>\" + \"<option value=\"3\">Internet Live Course</option>\" + \"<option value=\"4\">Manuscript review</option>\" + \"<option value=\"5\">Teaching</option>\";\n                  var EMOptions = \"<option value=\"6\">Internet Activity Enduring Material</option>\" + \"<option value=\"7\">Print</option>\" + \"<option value=\"8\">CD</option>\" + \"<option value=\"9\">Audio</option>\" + \"<option value=\"10\">Video</option>\";\n                  var nActivityType = 1;\n                  var nGrouping = 1;\n                  var sSessionType = \"S\";\n                  var nCountryId = 230\n                \n                \n                \n                  App.module(\"Activity.GeneralInfo\").start();\n                </script>\n                <div class='ViewContainer'>\n                  <div class='ViewSection'>\n                    <form class='form-horizontal formstate js-form-generalinfo js-formstate' action='/admin/_com/AJAX_Activity.cfc' method='post' name='frmEditActivity'>\n                      <input name='Method' type='hidden' value='saveActivity'>\n                      <input name='returnFormat' type='hidden' value='plain'>\n                      <input name='ActivityID' type='hidden' value='15088'>\n                      <input name='SessionType' type='hidden' value='S'>\n                      <div class='control-group'>\n                        <label class='control-label' for='Title'>Title</label>\n                        <div class='controls'>\n                          <textarea class='span23' id='Title' name='Title' rows='2' style='height:46px;'>Optimizing Treatment of Familial Hypercholesterolemia:  Current and Emerging Therapies</textarea>\n                        </div>\n                      </div>\n                      <div class='control-group'>\n                        <label class='control-label' for='ActivityType'>Type</label>\n                        <div class='controls'>\n                          <select id='ActivityType' disabled='disabled' name='ActivityTypeID'>\n                            <option selected='' value='1'>Live</option>\n                            <option value='2'>Enduring Material</option>\n                            <option value='3'>Journal</option>\n                            <option value='6'>Performance Improvement</option>\n                            <option value='7'>Point of Care</option>\n                            <option value='8'>Learning From Teaching</option>\n                          </select>\n                        </div>\n                      </div>\n                      <div class='control-group' id='Groupings'>\n                        <label class='control-label' for='Grouping'>Sub Type</label>\n                        <div class='controls'>\n                          <select id='Grouping' disabled='disabled' name='Grouping'></select>\n                        </div>\n                      </div>\n                      <div class='control-group'>\n                        <label class='control-label' for='SessionType'>Session Type</label>\n                        <div class='controls'>\n                          <select id='SessionType' disabled='disabled' name='SessionType'>\n                            <option selected='' value='S'>Stand-alone</option>\n                            <option value='M'>Multi-session</option>\n                          </select>\n                        </div>\n                      </div>\n                      <div class='control-group' style='display:none;'>\n                        <label class='control-label' for='ReleaseDate'>Release Date</label>\n                        <div class='controls'>\n                          <input class='DatePicker' id='ReleaseDate' name='ReleaseDate' type='text' value='02/18/2013'>\n                        </div>\n                      </div>\n                      <div class='divider'>\n                        <hr>\n                      </div>\n                      <div class='control-group'>\n                        <label class='control-label' for='Sponsorship'>Sponsorship</label>\n                        <div class='controls'>\n                          <div class='btn-group' data-toggle='buttons-radio'>\n                            <a class='btn js-sponsorship-D js-sponsorship-toggle'>Directly</a>\n                            <a class='btn js-sponsorship-J js-sponsorship-toggle'>Jointly</a>\n                          </div>\n                          <span class='hide mls' id='JointlyTextFld'>\n                            <input id='Sponsor' name='Sponsor' type='text' value='Horizon CME'>\n                          </span>\n                          <input class='Sponsorship hide' id='Sponsorship' name='Sponsorship' type='text' value='J'>\n                        </div>\n                      </div>\n                      <div class='divider'>\n                        <hr>\n                      </div>\n                      <div class='control-group'>\n                        <label class='control-label' for='StartDate'>Start Date</label>\n                        <div class='controls'>\n                          <input class='DatePicker span5 text-center' id='StartDate' name='StartDate' type='text' value='09/28/2013'>\n                        </div>\n                      </div>\n                      <div class='control-group'>\n                        <label class='control-label' for='EndDate'>End Date</label>\n                        <div class='controls'>\n                          <input class='DatePicker span5 text-center' id='EndDate' name='EndDate' type='text' value='09/28/2013'>\n                        </div>\n                      </div>\n                      <div class='divider'>\n                        <hr>\n                      </div>\n                      <div class='Location control-group'>\n                        <label class='control-label' for='Location'>Location</label>\n                        <div class='controls'>\n                          <input id='Location' name='Location' type='text' value=' '>\n                        </div>\n                      </div>\n                      <div class='Location control-group'>\n                        <label class='control-label' for='Address1'>Address 1</label>\n                        <div class='controls'>\n                          <input id='Address1' name='Address1' type='text' value=''>\n                        </div>\n                      </div>\n                      <div class='Location control-group'>\n                        <label class='control-label' for='Address2'>Address 2</label>\n                        <div class='controls'>\n                          <input id='Address2' name='Address2' type='text' value=''>\n                        </div>\n                      </div>\n                      <div class='Location control-group'>\n                        <label class='control-label' for='City'>City</label>\n                        <div class='controls'>\n                          <input id='City' name='City' type='text' value=''>\n                        </div>\n                      </div>\n                      <div class='Location control-group stateField'>\n                        <label class='control-label' for='State'>State</label>\n                        <div class='controls'>\n                          <select id='State' name='State'>\n                            <option value='0'>Select one...</option>\n                            <option value='1'>Alabama</option>\n                            <option value='2'>Alaska</option>\n                            <option value='3'>Arizona</option>\n                            <option value='4'>Arkansas</option>\n                            <option value='5'>California</option>\n                            <option value='6'>Colorado</option>\n                            <option value='7'>Connecticut</option>\n                            <option value='8'>Delaware</option>\n                            <option value='9'>District of Columbia</option>\n                            <option value='10'>Florida</option>\n                            <option value='11'>Georgia</option>\n                            <option value='12'>Hawaii</option>\n                            <option value='13'>Idaho</option>\n                            <option value='14'>Illinois</option>\n                            <option value='15'>Indiana</option>\n                            <option value='16'>Iowa</option>\n                            <option value='17'>Kansas</option>\n                            <option value='18'>Kentucky</option>\n                            <option value='19'>Louisiana</option>\n                            <option value='20'>Maine</option>\n                            <option value='21'>Maryland</option>\n                            <option value='22'>Massachusetts</option>\n                            <option value='23'>Michigan</option>\n                            <option value='24'>Minnesota</option>\n                            <option value='25'>Mississippi</option>\n                            <option value='26'>Missouri</option>\n                            <option value='27'>Montana</option>\n                            <option value='28'>Nebraska</option>\n                            <option value='29'>Nevada</option>\n                            <option value='30'>New Hampshire</option>\n                            <option value='31'>New Jersey</option>\n                            <option value='32'>New Mexico</option>\n                            <option value='33'>New York</option>\n                            <option value='34'>North Carolina</option>\n                            <option value='35'>North Dakota</option>\n                            <option value='36'>Ohio</option>\n                            <option value='37'>Oklahoma</option>\n                            <option value='38'>Oregon</option>\n                            <option value='39'>Pennsylvania</option>\n                            <option value='40'>Rhode Island</option>\n                            <option value='41'>South Carolina</option>\n                            <option value='42'>South Dakota</option>\n                            <option value='43'>Tennessee</option>\n                            <option value='44'>Texas</option>\n                            <option value='45'>Utah</option>\n                            <option value='46'>Vermont</option>\n                            <option value='47'>Virginia</option>\n                            <option value='48'>Washington</option>\n                            <option value='49'>West Virginia</option>\n                            <option value='50'>Wisconsin</option>\n                            <option value='51'>Wyoming</option>\n                          </select>\n                        </div>\n                      </div>\n                      <div class='Location control-group provinceField'>\n                        <label class='control-label' for='Province'>State / Province</label>\n                        <div class='controls'>\n                          <input id='Province' name='Province' type='text' value=''>\n                        </div>\n                      </div>\n                      <div class='Location control-group'>\n                        <label class='control-label' for='Country'>Country</label>\n                        <div class='controls'>\n                          <select id='Country' name='Country'>\n                            <option value='0'>Select one...</option>\n                            <option value='1'>Afghanistan</option>\n                            <option value='2'>Aland Islands</option>\n                            <option value='3'>Albania</option>\n                            <option value='4'>Algeria</option>\n                            <option value='5'>American Samoa</option>\n                            <option value='6'>Andorra</option>\n                            <option value='7'>Angola</option>\n                            <option value='8'>Anguilla</option>\n                            <option value='9'>Antarctica</option>\n                            <option value='10'>Antigua And Barbuda</option>\n                            <option value='11'>Argentina</option>\n                            <option value='12'>Armenia</option>\n                            <option value='13'>Aruba</option>\n                            <option value='14'>Australia</option>\n                            <option value='15'>Austria</option>\n                            <option value='16'>Azerbaijan</option>\n                            <option value='17'>Bahamas</option>\n                            <option value='18'>Bahrain</option>\n                            <option value='19'>Bangladesh</option>\n                            <option value='20'>Barbados</option>\n                            <option value='21'>Belarus</option>\n                            <option value='22'>Belgium</option>\n                            <option value='23'>Belize</option>\n                            <option value='24'>Benin</option>\n                            <option value='25'>Bermuda</option>\n                            <option value='26'>Bhutan</option>\n                            <option value='27'>Bolivia</option>\n                            <option value='252'>Bonaire, Saint Eustatius and Saba</option>\n                            <option value='28'>Bosnia And Herzegovina</option>\n                            <option value='29'>Botswana</option>\n                            <option value='30'>Bouvet Island</option>\n                            <option value='31'>Brazil</option>\n                            <option value='32'>British Indian Ocean Territory</option>\n                            <option value='33'>Brunei Darussalam</option>\n                            <option value='34'>Bulgaria</option>\n                            <option value='35'>Burkina Faso</option>\n                            <option value='36'>Burundi</option>\n                            <option value='37'>Cambodia</option>\n                            <option value='38'>Cameroon</option>\n                            <option value='39'>Canada</option>\n                            <option value='40'>Cape Verde</option>\n                            <option value='41'>Cayman Islands</option>\n                            <option value='42'>Central African Republic</option>\n                            <option value='43'>Chad</option>\n                            <option value='44'>Chile</option>\n                            <option value='45'>China</option>\n                            <option value='46'>Christmas Island</option>\n                            <option value='47'>Cocos (Keeling) Islands</option>\n                            <option value='48'>Colombia</option>\n                            <option value='49'>Comoros</option>\n                            <option value='50'>Congo</option>\n                            <option value='51'>Congo, The Democratic Republic Of The</option>\n                            <option value='52'>Cook Islands</option>\n                            <option value='53'>Costa Rica</option>\n                            <option value='54'>Cote D'Ivoire</option>\n                            <option value='55'>Croatia</option>\n                            <option value='56'>Cuba</option>\n                            <option value='251'>Curacao</option>\n                            <option value='57'>Cyprus</option>\n                            <option value='58'>Czech Republic</option>\n                            <option value='59'>Denmark</option>\n                            <option value='60'>Djibouti</option>\n                            <option value='61'>Dominica</option>\n                            <option value='62'>Dominican Republic</option>\n                            <option value='63'>Ecuador</option>\n                            <option value='64'>Egypt</option>\n                            <option value='65'>El Salvador</option>\n                            <option value='66'>Equatorial Guinea</option>\n                            <option value='67'>Eritrea</option>\n                            <option value='68'>Estonia</option>\n                            <option value='69'>Ethiopia</option>\n                            <option value='70'>Falkland Islands (Malvinas)</option>\n                            <option value='71'>Faroe Islands</option>\n                            <option value='72'>Fiji</option>\n                            <option value='73'>Finland</option>\n                            <option value='74'>France</option>\n                            <option value='75'>French Guiana</option>\n                            <option value='76'>French Polynesia</option>\n                            <option value='77'>French Southern Territories</option>\n                            <option value='78'>Gabon</option>\n                            <option value='79'>Gambia</option>\n                            <option value='80'>Georgia</option>\n                            <option value='81'>Germany</option>\n                            <option value='82'>Ghana</option>\n                            <option value='83'>Gibraltar</option>\n                            <option value='84'>Greece</option>\n                            <option value='85'>Greenland</option>\n                            <option value='86'>Grenada</option>\n                            <option value='87'>Guadeloupe</option>\n                            <option value='88'>Guam</option>\n                            <option value='89'>Guatemala</option>\n                            <option value='245'>Guernsey</option>\n                            <option value='91'>Guinea</option>\n                            <option value='92'>Guinea-Bissau</option>\n                            <option value='93'>Guyana</option>\n                            <option value='94'>Haiti</option>\n                            <option value='95'>Heard Island And Mcdonald Islands</option>\n                            <option value='96'>Holy See (Vatican City State)</option>\n                            <option value='97'>Honduras</option>\n                            <option value='98'>Hong Kong</option>\n                            <option value='99'>Hungary</option>\n                            <option value='100'>Iceland</option>\n                            <option value='101'>India</option>\n                            <option value='102'>Indonesia</option>\n                            <option value='103'>Iran, Islamic Republic Of</option>\n                            <option value='104'>Iraq</option>\n                            <option value='105'>Ireland</option>\n                            <option value='106'>Isle Of Man</option>\n                            <option value='107'>Israel</option>\n                            <option value='108'>Italy</option>\n                            <option value='109'>Jamaica</option>\n                            <option value='110'>Japan</option>\n                            <option value='111'>Jersey</option>\n                            <option value='112'>Jordan</option>\n                            <option value='113'>Kazakhstan</option>\n                            <option value='114'>Kenya</option>\n                            <option value='115'>Kiribati</option>\n                            <option value='116'>Korea, Democratic People'S Republic Of</option>\n                            <option value='117'>Korea, Republic Of</option>\n                            <option value='244'>Kosovo</option>\n                            <option value='118'>Kuwait</option>\n                            <option value='119'>Kyrgyzstan</option>\n                            <option value='120'>Lao People'S Democratic Republic</option>\n                            <option value='121'>Latvia</option>\n                            <option value='122'>Lebanon</option>\n                            <option value='123'>Lesotho</option>\n                            <option value='124'>Liberia</option>\n                            <option value='125'>Libyan Arab Jamahiriya</option>\n                            <option value='126'>Liechtenstein</option>\n                            <option value='127'>Lithuania</option>\n                            <option value='128'>Luxembourg</option>\n                            <option value='129'>Macao</option>\n                            <option value='130'>Macedonia, The Former Yugoslav Republic Of</option>\n                            <option value='131'>Madagascar</option>\n                            <option value='132'>Malawi</option>\n                            <option value='133'>Malaysia</option>\n                            <option value='134'>Maldives</option>\n                            <option value='135'>Mali</option>\n                            <option value='136'>Malta</option>\n                            <option value='137'>Marshall Islands</option>\n                            <option value='138'>Martinique</option>\n                            <option value='139'>Mauritania</option>\n                            <option value='140'>Mauritius</option>\n                            <option value='141'>Mayotte</option>\n                            <option value='142'>Mexico</option>\n                            <option value='143'>Micronesia, Federated States Of</option>\n                            <option value='144'>Moldova, Republic Of</option>\n                            <option value='145'>Monaco</option>\n                            <option value='146'>Mongolia</option>\n                            <option value='246'>Montenegro</option>\n                            <option value='147'>Montserrat</option>\n                            <option value='148'>Morocco</option>\n                            <option value='149'>Mozambique</option>\n                            <option value='150'>Myanmar</option>\n                            <option value='151'>Namibia</option>\n                            <option value='152'>Nauru</option>\n                            <option value='153'>Nepal</option>\n                            <option value='154'>Netherlands</option>\n                            <option value='155'>Netherlands Antilles</option>\n                            <option value='156'>New Caledonia</option>\n                            <option value='157'>New Zealand</option>\n                            <option value='158'>Nicaragua</option>\n                            <option value='159'>Niger</option>\n                            <option value='160'>Nigeria</option>\n                            <option value='161'>Niue</option>\n                            <option value='162'>Norfolk Island</option>\n                            <option value='163'>Northern Mariana Islands</option>\n                            <option value='164'>Norway</option>\n                            <option value='165'>Oman</option>\n                            <option value='166'>Pakistan</option>\n                            <option value='167'>Palau</option>\n                            <option value='168'>Palestinian Territory, Occupied</option>\n                            <option value='169'>Panama</option>\n                            <option value='170'>Papua New Guinea</option>\n                            <option value='171'>Paraguay</option>\n                            <option value='172'>Peru</option>\n                            <option value='173'>Philippines</option>\n                            <option value='174'>Pitcairn</option>\n                            <option value='175'>Poland</option>\n                            <option value='176'>Portugal</option>\n                            <option value='177'>Puerto Rico</option>\n                            <option value='178'>Qatar</option>\n                            <option value='179'>Reunion</option>\n                            <option value='180'>Romania</option>\n                            <option value='181'>Russian Federation</option>\n                            <option value='182'>Rwanda</option>\n                            <option value='248'>Saint Barthélemy</option>\n                            <option value='183'>Saint Helena</option>\n                            <option value='184'>Saint Kitts And Nevis</option>\n                            <option value='185'>Saint Lucia</option>\n                            <option value='247'>Saint Martin</option>\n                            <option value='186'>Saint Pierre And Miquelon</option>\n                            <option value='187'>Saint Vincent And The Grenadines</option>\n                            <option value='188'>Samoa</option>\n                            <option value='189'>San Marino</option>\n                            <option value='190'>Sao Tome And Principe</option>\n                            <option value='191'>Saudi Arabia</option>\n                            <option value='192'>Senegal</option>\n                            <option value='249'>Serbia</option>\n                            <option value='193'>Serbia And Montenegro</option>\n                            <option value='194'>Seychelles</option>\n                            <option value='195'>Sierra Leone</option>\n                            <option value='196'>Singapore</option>\n                            <option value='250'>Sint Maarten</option>\n                            <option value='197'>Slovakia</option>\n                            <option value='198'>Slovenia</option>\n                            <option value='199'>Solomon Islands</option>\n                            <option value='200'>Somalia</option>\n                            <option value='201'>South Africa</option>\n                            <option value='202'>South Georgia And The South Sandwich Islands</option>\n                            <option value='203'>Spain</option>\n                            <option value='204'>Sri Lanka</option>\n                            <option value='205'>Sudan</option>\n                            <option value='206'>Suriname</option>\n                            <option value='207'>Svalbard And Jan Mayen</option>\n                            <option value='208'>Swaziland</option>\n                            <option value='209'>Sweden</option>\n                            <option value='210'>Switzerland</option>\n                            <option value='211'>Syrian Arab Republic</option>\n                            <option value='212'>Taiwan, Province Of China</option>\n                            <option value='213'>Tajikistan</option>\n                            <option value='214'>Tanzania, United Republic Of</option>\n                            <option value='215'>Thailand</option>\n                            <option value='216'>Timor-Leste</option>\n                            <option value='217'>Togo</option>\n                            <option value='218'>Tokelau</option>\n                            <option value='219'>Tonga</option>\n                            <option value='220'>Trinidad And Tobago</option>\n                            <option value='221'>Tunisia</option>\n                            <option value='222'>Turkey</option>\n                            <option value='223'>Turkmenistan</option>\n                            <option value='224'>Turks And Caicos Islands</option>\n                            <option value='225'>Tuvalu</option>\n                            <option value='226'>Uganda</option>\n                            <option value='227'>Ukraine</option>\n                            <option value='228'>United Arab Emirates</option>\n                            <option value='229'>United Kingdom</option>\n                            <option value='231'>United States Minor Outlying Islands</option>\n                            <option selected='' value='230'>United States of America</option>\n                            <option value='232'>Uruguay</option>\n                            <option value='233'>Uzbekistan</option>\n                            <option value='234'>Vanuatu</option>\n                            <option value='235'>Venezuela</option>\n                            <option value='236'>Viet Nam</option>\n                            <option value='237'>Virgin Islands, British</option>\n                            <option value='238'>Virgin Islands, U.S.</option>\n                            <option value='239'>Wallis And Futuna</option>\n                            <option value='240'>Western Sahara</option>\n                            <option value='241'>Yemen</option>\n                            <option value='242'>Zambia</option>\n                            <option value='243'>Zimbabwe</option>\n                          </select>\n                        </div>\n                      </div>\n                      <div class='Location control-group'>\n                        <label class='control-label' for='PostalCode'>Postal Code</label>\n                        <div class='controls'>\n                          <input id='PostalCode' name='PostalCode' type='text' value=''>\n                        </div>\n                      </div>\n                      <div class='control-group'>\n                        <label class='control-label' for='ExternalID'>External ID</label>\n                        <div class='controls'>\n                          <input id='ExternalID' name='ExternalID' type='text' value=''>\n                        </div>\n                      </div>\n                      <div class='control-group hide'>\n                        Created By\n                        <a href='/admin/event/Person.Detail?PersonID=14887'>M. Gallo (02/18/2013 03:27PM)</a>\n                      </div>\n                      <div class='control-group hide'>\n                        Updated By\n                        <a href='/admin/event/Person.Detail?PersonID=169841'>J. Rountree (07/08/2013 12:29PM)</a>\n                      </div>\n                      <div class='divider'>\n                        <hr>\n                      </div>\n                    </form>\n                  </div>\n                </div>\n              </div>\n            </div>\n          </div>\n          <div class='js-infobar-outer span6'>\n            <div class='InfoBar infobar js-infobar'>\n              <div id='Status'>\n                <h3>\n                  <i class='fg fg-fruit'></i>\n                  Activity Health\n                </h3>\n                <div class='box'>\n                  <div class='activity-status js-activity-status project-status'>\n                    <select class='span24' id='StatusChanger' name='StatusChanger'>\n                      <option value=''>No Status</option>\n                      <option selected='' value='1'>Active</option>\n                      <option value='4'>Cancelled</option>\n                      <option value='3'>Ended</option>\n                      <option value='2'>Pending</option>\n                    </select>\n                  </div>\n                  <div class='overview-buttons'>\n                    <div class='row-fluid'>\n                      <div class='btn-group span24'>\n                        <a class='btn span12' id='OverviewDialogLink' href='javascript:void(0);'>Overview</a>\n                        <a class='btn disabled span12' id='ActivityDialogLink' href='javascript:void(0);'>Related</a>\n                      </div>\n                    </div>\n                  </div>\n                  <div id='ActivityStats'></div>\n                </div>\n              </div>\n              <div id='Containers'></div>\n            </div>\n          </div>\n        </div>\n      </div>\n    </div>\n  </div>\n  <div class='dialog' id='OverviewList'></div>\n  <div class='dialog' id='MoveDialog'>\n    <div>\n      <strong>Are you sure you want to move this activity?</strong>\n      <br>\n      Select from the list below which Multi-Session Parent Activity you wish to move it to.\n      <div style='padding:5px;'>\n        <strong>From:</strong>\n        Optimizing Treatment of Familial Hypercholesterolemia:  Current and Emerging Therapies\n      </div>\n      <div style='padding:5px;'>\n        <strong>To:</strong>\n        <select id='ToActivity' name='ToActivity' style='width:350px;'>\n          <option value=''>Select Activity</option>\n          <option value='7282'>\"Nonpharmaceutical Intervention Stategies for Pandemic Influenza Mitigation [03/22/2007]</option>\n          <option value='6790'>\"Presenteeism\":  The Newest Element in the Productivity Equation [03/17/2006]</option>\n          <option value='13450'>_test RSS activity for data integrity [06/01/2011]</option>\n          <option value='4786'>10th Annual Resident/Alumni Research Forum/Resident Teaching Day [06/01/2002]</option>\n          <option value='6474'>2004 Fall Health Commissioner's Conference [01/01/1970]</option>\n          <option value='6398'>2005 Annual Meeting of the Society of Hospital Medicine: Action and Reaction: Venous Thromboembolism [04/28/2005]</option>\n          <option value='5487'>3rd Annual Greater Cincinnati Prostate Cancer Forum [06/21/2003]</option>\n          <option value='1762'>5th Monday Obstetrics & Perinatal Journal Club 2002 [09/30/2002]</option>\n          <option value='7051'>7th Annual Pilot Research Project Symposium [10/12/2006]</option>\n          <option value='7571'>8th Annual Pilot Research Project Symposium [10/11/2007]</option>\n          <option value='9681'>A Behavioral Approach to difficult patients [08/28/2009]</option>\n          <option value='12101'>A New Category of Treatment-Responsive Encephalitis with Psychiatric Manifestations [02/09/2010]</option>\n          <option value='5187'>A New Era in the Treatment of PAD:  Practical Tools for the Primary Care Physician [10/04/2002]</option>\n          <option value='5543'>A Symposium on Mold Exposures: From Sick Buildings to Sick People [01/01/1970]</option>\n          <option value='13758'>Accountable Care Transformation (ACT) Learning Session [10/03/2011]</option>\n          <option value='24'>Anesthesia 2000 [01/12/2000]</option>\n          <option value='584'>Anesthesia 2001 [01/10/2001]</option>\n          <option value='1243'>Anesthesia 2002 [01/02/2002]</option>\n          <option value='1958'>Anesthesia 2003 [01/15/2003]</option>\n          <option value='2698'>Anesthesia 2004 [01/14/2004]</option>\n          <option value='3500'>Anesthesia 2005 [01/12/2005]</option>\n          <option value='5494'>Anesthesia 2006 [01/11/2006]</option>\n          <option value='6867'>Anesthesia 2007 [01/10/2007]</option>\n          <option value='8309'>Anesthesia 2008 [01/09/2008]</option>\n          <option value='9068'>Anesthesia 2009 [01/14/2009]</option>\n          <option value='9118'>Anesthesia 2009 [02/04/2009]</option>\n          <option value='11938'>Anesthesia 2010 [01/11/2010]</option>\n          <option value='12991'>Anesthesiology 2011 [01/19/2011]</option>\n          <option value='14036'>Anesthesiology 2012 [01/10/2012]</option>\n          <option value='14848'>Anesthesiology 2013 [12/10/2012]</option>\n          <option value='6146'>Ann Approach to the Dizzy Patient [01/01/1970]</option>\n          <option value='5565'>ASCI/AAP 2003 Joint Meeting [04/25/2003]</option>\n          <option value='5591'>Audio Conference - Incident to Billing, Practical Strategies to Stay in Compliance [01/01/1970]</option>\n          <option value='6175'>Aurgical Advances in the Treatment of Malignant Melanoma [01/01/1970]</option>\n          <option value='5623'>Basic MEDLINE: OhioLINK [08/08/2003]</option>\n          <option value='3218'>Cancer Center 2004 [09/03/2004]</option>\n          <option value='3479'>Cancer Center 2005 [01/07/2005]</option>\n          <option value='5467'>Cancer Center 2006 [01/06/2006]</option>\n          <option value='6956'>Cancer Center 2007 [02/02/2007]</option>\n          <option value='8387'>Cancer Center 2008 [02/01/2008]</option>\n          <option value='9408'>Cancer Center Seminar Series 2009 [04/03/2009]</option>\n          <option value='5934'>CardioGuide [01/01/1970]</option>\n          <option value='3264'>Cardiology 2004 [09/24/2004]</option>\n          <option value='3613'>Cardiology 2005 [02/17/2005]</option>\n          <option value='3031'>Cardiothoracic Surgery 2004 [05/13/2004]</option>\n          <option value='6757'>Cardiovascular Disease 2006 [12/05/2006]</option>\n          <option value='6828'>Cardiovascular Disease 2007 [01/02/2007]</option>\n          <option value='8301'>Cardiovascular Disease 2008 [01/08/2008]</option>\n          <option value='9116'>Cardiovascular Disease 2009 [02/02/2009]</option>\n          <option value='11975'>Cardiovascular Diseases 2010 [01/25/2010]</option>\n          <option value='9737'>CCTST/CTSA/Family Medicine 2009 [09/25/2009]</option>\n          <option value='12124'>CCTST/CTSA/Family Medicine 2010 [02/19/2010]</option>\n          <option value='12998'>CCTST/CTSA/Family Medicine 2011 [01/19/2011]</option>\n          <option value='14033'>CCTST/CTSA/Family Medicine 2012 [01/10/2012]</option>\n          <option value='14916'>CCTST/CTSA/Family Medicine 2013 [12/26/2012]</option>\n          <option value='1547'>Center for Competency Development and Assessment 2002 [05/14/2002]</option>\n          <option value='7132'>Center for Executive Education 2007 [03/15/2007]</option>\n          <option value='15129'>CeTREAD Journal Club [03/13/2013]</option>\n          <option value='12296'>Child Psychiatry Council of Cincinnati and Dayton [04/05/2010]</option>\n          <option value='13439'>Child Psychiatry Council of Cincinnati and Dayton 2011 [05/31/2011]</option>\n          <option value='2955'>Cincinnati Allergy & Asthma Society 2004 [04/15/2004]</option>\n          <option value='1020'>Cincinnati Critical Care Society 2001 [09/04/2001]</option>\n          <option value='1377'>Cincinnati Critical Care Society 2002 [02/20/2002]</option>\n          <option value='2362'>Cincinnati Critical Care Society 2003 [08/12/2003]</option>\n          <option value='8460'>Cincinnati Dermatologic Society 2008 [03/05/2008]</option>\n          <option value='9120'>Cincinnati Dermatologic Society 2009 [02/04/2009]</option>\n          <option value='15194'>Cincinnati Dermatological Society [03/28/2013]</option>\n          <option value='12109'>Cincinnati Dermatological Society 2010 [02/10/2010]</option>\n          <option value='13155'>Cincinnati Dermatological Society 2011 [02/24/2011]</option>\n          <option value='14058'>Cincinnati Dermatological Society 2012 [01/18/2012]</option>\n          <option value='6151'>Cincinnati Health Department 2006 [06/06/2006]</option>\n          <option value='1980'>Cincinnati Prostate Cancer Forum 2003 [01/22/2003]</option>\n          <option value='2736'>Cincinnati Prostate Cancer Forum 2004 [01/22/2004]</option>\n          <option value='394'>Cincinnati Psychiatric Society 2000 [09/20/2000]</option>\n          <option value='674'>Cincinnati Psychiatric Society 2001 [02/21/2001]</option>\n          <option value='1379'>Cincinnati Psychiatric Society 2002 [02/20/2002]</option>\n          <option value='1960'>Cincinnati Psychiatric Society 2003 [01/15/2003]</option>\n          <option value='2716'>Cincinnati Psychiatric Society 2004 [01/21/2004]</option>\n          <option value='3521'>Cincinnati Psychiatric Society 2005 [01/19/2005]</option>\n          <option value='5654'>Cincinnati Psychiatric Society 2006 [02/15/2006]</option>\n          <option value='8492'>Cincinnati Psychiatric Society 2008 [03/18/2008]</option>\n          <option value='9101'>Cincinnati Psychiatric Society 2009 [01/26/2009]</option>\n          <option value='11955'>Cincinnati Psychiatric Society 2010 [01/26/2010]</option>\n          <option value='13055'>Cincinnati Psychiatric Society 2011 [02/02/2011]</option>\n          <option value='14234'>Cincinnati Psychiatric Society 2012 [03/21/2012]</option>\n          <option value='701'>Cincinnati Radiologic Society 2001 [03/05/2001]</option>\n          <option value='1535'>Cincinnati Radiologic Society 2002 [05/06/2002]</option>\n          <option value='2087'>Cincinnati Radiologic Society 2003 [03/10/2003]</option>\n          <option value='2819'>Cincinnati Radiologic Society 2004 [02/23/2004]</option>\n          <option value='3950'>Cincinnati Radiologic Society 2005 [04/07/2005]</option>\n          <option value='637'>Cincinnati Society of Internal Medicine 2001 [02/05/2001]</option>\n          <option value='1341'>Cincinnati Society of Internal Medicine 2002 [02/04/2002]</option>\n          <option value='2015'>Cincinnati Society of Internal Medicine 2003 [02/03/2003]</option>\n          <option value='2765'>Cincinnati Society of Internal Medicine 2004 [02/02/2004]</option>\n          <option value='376'>Cincinnati Society of Ophthalmology 2000 [09/13/2000]</option>\n          <option value='655'>Cincinnati Society of Ophthalmology 2001 [02/14/2001]</option>\n          <option value='1363'>Cincinnati Society of Ophthalmology 2002 [02/13/2002]</option>\n          <option value='2030'>Cincinnati Society of Ophthalmology 2003 [02/12/2003]</option>\n          <option value='2783'>Cincinnati Society of Ophthalmology 2004 [02/11/2004]</option>\n          <option value='3584'>Cincinnati Society of Ophthalmology 2005 [02/09/2005]</option>\n          <option value='5627'>Cincinnati Society of Ophthalmology 2006 [02/08/2006]</option>\n          <option value='7121'>Cincinnati Society of Ophthalmology 2007 [03/14/2007]</option>\n          <option value='8414'>Cincinnati Society of Ophthalmology 2008 [02/13/2008]</option>\n          <option value='9070'>Cincinnati Society of Ophthalmology 2009 [01/14/2009]</option>\n          <option value='15053'>Cincinnati Society of Ophthalmology/UC Evening Meeting Series [02/07/2013]</option>\n          <option value='1509'>Cincinnati Surgical Society 2002 [04/24/2002]</option>\n          <option value='2151'>Cincinnati Surgical Society 2003 [04/09/2003]</option>\n          <option value='2965'>Cincinnati Surgical Society 2004 [04/21/2004]</option>\n          <option value='3560'>Cincinnati Surgical Society 2005 [02/02/2005]</option>\n          <option value='5600'>Cincinnati Surgical Society 2006 [02/01/2006]</option>\n          <option value='6974'>Cincinnati Surgical Society 2007 [02/07/2007]</option>\n          <option value='8397'>Cincinnati Surgical Society 2008 [02/06/2008]</option>\n          <option value='9122'>Cincinnati Surgical Society 2009 [02/04/2009]</option>\n          <option value='5985'>Citywide Sleep Medicine Series 2006 [04/26/2006]</option>\n          <option value='13463'>Clinical Documentation for Severity of Illness [06/10/2011]</option>\n          <option value='6788'>Clinical Trials [01/01/1970]</option>\n          <option value='7955'>College of Law 2007 [10/11/2007]</option>\n          <option value='7413'>Complimentary and Alternative Medicine in Parkinson's Disease [01/01/1970]</option>\n          <option value='9674'>COPD [08/13/2009]</option>\n          <option value='391'>Council of Child & Adolescent Psychiatry 2000 [09/19/2000]</option>\n          <option value='926'>Council of Child & Adolescent Psychiatry 2001 [06/26/2001]</option>\n          <option value='1303'>Council of Child & Adolescent Psychiatry 2002 [01/22/2002]</option>\n          <option value='5068'>Council of Child & Adolescent Psychiatry 2005 [10/11/2005]</option>\n          <option value='5904'>Council of Child & Adolescent Psychiatry 2006 [04/05/2006]</option>\n          <option value='7012'>Council of Child & Adolescent Psychiatry 2007 [02/20/2007]</option>\n          <option value='8558'>Council of Child & Adolescent Psychiatry 2008 [04/15/2008]</option>\n          <option value='4760'>Council of Deans Meeting [04/19/2002]</option>\n          <option value='2939'>Dearborn County Hospital 2004 [04/08/2004]</option>\n          <option value='4072'>Dearborn County Hospital 2005 [04/14/2005]</option>\n          <option value='5671'>Dearborn County Hospital 2006 [02/16/2006]</option>\n          <option value='7318'>Dearborn County Hospital 2007 [04/19/2007]</option>\n          <option value='8454'>Dearborn County Hospital 2008 [02/28/2008]</option>\n          <option value='9473'>Dearborn County Hospital 2009 [05/29/2009]</option>\n          <option value='12270'>Dearborn County Hospital 2010 [03/23/2010]</option>\n          <option value='13318'>Dearborn County Hospital 2011 [03/23/2010]</option>\n          <option value='14374'>Dearborn County Hospital 2012 [05/21/2012]</option>\n          <option value='2984'>Dearborn County Hospital ACLS 2004 [04/26/2004]</option>\n          <option value='8811'>Dearborn County Hospital ACLS 2008 [08/21/2008]</option>\n          <option value='9098'>Dermatology 2009 [01/22/2009]</option>\n          <option value='11740'>Dermatology 2010 [01/01/2010]</option>\n          <option value='12909'>Dermatology 2011 [01/04/2011]</option>\n          <option value='13977'>Dermatology 2012 [12/21/2011]</option>\n          <option value='14918'>Dermatology 2013 [12/26/2012]</option>\n          <option value='8291'>Dermatology Clinical Conference 2008 [01/03/2008]</option>\n          <option value='309'>Disease of the Month Update 2000 [07/11/2000]</option>\n          <option value='982'>Disease of the Month Update 2001 [08/07/2001]</option>\n          <option value='1916'>Disease of the Month Update 2002 [12/17/2002]</option>\n          <option value='2384'>Disease of the Month Update 2003 [08/26/2003]</option>\n          <option value='2746'>Disease of the Month Update 2004 [01/27/2004]</option>\n          <option value='3542'>Disease of the Month Update 2005 [01/25/2005]</option>\n          <option value='8522'>Division of Plastic, Reconstructive & Hand Surgery 2008 [04/02/2008]</option>\n          <option value='9454'>Division of Plastic, Reconstructive & Hand Surgery 2009 [03/25/2009]</option>\n          <option value='12075'>Division of Plastic, Reconstructive, and Hand Surgery 2010 [01/27/2010]</option>\n          <option value='13593'>Division of Plastic, Reconstructive, and Hand Surgery 2011 [08/02/2011]</option>\n          <option value='13988'>Division of Plastic, Reconstructive, and Hand Surgery 2012 [08/02/2011]</option>\n          <option value='14975'>Division of Plastic, Reconstructive, Hand and Burn Surgery 2013 [01/08/2013]</option>\n          <option value='326'>Drake Center 2000 [08/01/2000]</option>\n          <option value='811'>Drake Center 2001 [04/25/2001]</option>\n          <option value='1324'>Drake Center 2002 [01/30/2002]</option>\n          <option value='2064'>Drake Center 2003 [02/26/2003]</option>\n          <option value='2827'>Drake Center 2004 [02/25/2004]</option>\n          <option value='3523'>Drake Center 2005 [01/19/2005]</option>\n          <option value='5958'>Drake Center 2006 [04/19/2006]</option>\n          <option value='6136'>Effective Written and Oral Communications Between Providers and Their Patients [11/15/2004]</option>\n          <option value='12099'>Effort, Malingering, and Somatization [02/09/2010]</option>\n          <option value='7565'>Eighth Annual Pilot Research Project Symposium [01/01/1970]</option>\n          <option value='7563'>Eighth Annual Pilot Reserch Project Symposium [01/01/1970]</option>\n          <option value='8843'>Emergency Medicine - Cardiology 2008 [09/10/2008]</option>\n          <option value='9223'>Emergency Medicine - Cardiology 2009 [04/29/2009]</option>\n          <option value='8829'>Emergency Medicine - Critical Care 2008 [09/03/2008]</option>\n          <option value='9231'>Emergency Medicine - Critical Care 2009 [05/06/2009]</option>\n          <option value='8747'>Emergency Medicine - M&M 2008 [07/16/2008]</option>\n          <option value='9104'>Emergency Medicine - M&M 2009 [01/28/2009]</option>\n          <option value='9627'>\n            Emergency Medicine - M&M\n            (July 2009 to June 2010) [07/29/2009]\n          </option>\n          <option value='8972'>Emergency Medicine - Neurology 2008 [11/12/2008]</option>\n          <option value='26'>Emergency Medicine 2000 [01/12/2000]</option>\n          <option value='952'>Emergency Medicine 2001 [07/18/2001]</option>\n          <option value='1326'>Emergency Medicine 2002 [01/30/2002]</option>\n          <option value='1982'>Emergency Medicine 2003 [01/22/2003]</option>\n          <option value='2718'>Emergency Medicine 2004 [01/21/2004]</option>\n          <option value='3545'>Emergency Medicine 2005 [01/26/2005]</option>\n          <option value='5557'>Emergency Medicine 2006 [01/25/2006]</option>\n          <option value='6833'>Emergency Medicine 2007 [01/03/2007]</option>\n          <option value='8377'>Emergency Medicine 2008 [01/30/2008]</option>\n          <option value='12546'>Emergency Medicine 2011 [07/19/2010]</option>\n          <option value='13954'>Emergency Medicine 2012 [12/20/2011]</option>\n          <option value='14870'>Emergency Medicine 2013 [12/17/2012]</option>\n          <option value='12539'>Emergency Medicine Jul - Dec 2010 [07/19/2010]</option>\n          <option value='4828'>Emergent Pediatric Burn Care: Treatment Priorities & Medical Advancements [03/30/2002]</option>\n          <option value='736'>ENT Society 2001 [03/20/2001]</option>\n          <option value='1284'>ENT Society 2002 [01/16/2002]</option>\n          <option value='1962'>ENT Society 2003 [01/15/2003]</option>\n          <option value='2720'>ENT Society 2004 [01/21/2004]</option>\n          <option value='3525'>ENT Society 2005 [01/19/2005]</option>\n          <option value='5657'>ENT Society 2006 [02/15/2006]</option>\n          <option value='7123'>ENT Society 2007 [03/14/2007]</option>\n          <option value='8342'>ENT Society 2008 [01/16/2008]</option>\n          <option value='9087'>ENT Society 2009 [01/20/2009]</option>\n          <option value='12618'>ENT Society 2010 [09/01/2010]</option>\n          <option value='12700'>ENT Society 2011 [10/14/2010]</option>\n          <option value='13985'>ENT Society 2012 [12/22/2011]</option>\n          <option value='14877'>ENT Society 2013 [12/17/2012]</option>\n          <option value='1321'>Environmental Health 2002 [01/29/2002]</option>\n          <option value='2119'>Environmental Health 2003 [03/21/2003]</option>\n          <option value='14243'>Epilepsy Surgery Conference [03/23/2012]</option>\n          <option value='14852'>Epilepsy Surgery Conference 2013 [12/11/2012]</option>\n          <option value='5202'>Essential STD Exam Skills [01/01/1970]</option>\n          <option value='580'>Ethics in Research 2001 [01/08/2001]</option>\n          <option value='12107'>Experiences of the Haiti Earthquake [02/09/2010]</option>\n          <option value='3427'>Family Medicine Cross Cultural Education Series 2004 [12/07/2004]</option>\n          <option value='5138'>Federation of American Societies for Experimental Biology [06/29/2002]</option>\n          <option value='2371'>Fetal Therapeutics 2003 [08/14/2003]</option>\n          <option value='43'>General Internal Medicine 2000 [01/19/2000]</option>\n          <option value='574'>General Internal Medicine 2001 [01/05/2001]</option>\n          <option value='3683'>General Internal Medicine 2005 [03/16/2005]</option>\n          <option value='8563'>General Internal Medicine 2008 [04/16/2008]</option>\n          <option value='386'>General Medicine-Clinical Conference 2000 [09/15/2000]</option>\n          <option value='954'>General Medicine-Clinical Conference 2001 [07/18/2001]</option>\n          <option value='1286'>General Medicine-Clinical Conference 2002 [01/16/2002]</option>\n          <option value='1964'>General Medicine-Clinical Conference 2003 [01/15/2003]</option>\n          <option value='2722'>General Medicine-Clinical Conference 2004 [01/21/2004]</option>\n          <option value='3527'>General Medicine-Clinical Conference 2005 [01/19/2005]</option>\n          <option value='5519'>General Medicine-Clinical Conference 2006 [01/18/2006]</option>\n          <option value='6890'>General Medicine-Clinical Conference 2007 [01/17/2007]</option>\n          <option value='8431'>General Medicine-Clinical Conference 2008 [02/20/2008]</option>\n          <option value='754'>General Medicine-Evidence Based 2001 [03/28/2001]</option>\n          <option value='1328'>General Medicine-Evidence Based 2002 [01/30/2002]</option>\n          <option value='2000'>General Medicine-Evidence Based 2003 [01/29/2003]</option>\n          <option value='2880'>Geriatric Medicine 2004 [03/17/2004]</option>\n          <option value='3669'>Geriatric Medicine 2005 [03/10/2005]</option>\n          <option value='5714'>Geriatric Medicine 2006 [02/24/2006]</option>\n          <option value='7082'>Geriatric Medicine 2007 [03/06/2007]</option>\n          <option value='5298'>Good Clinical Practices for the Research Professional: Conducting a Clinical Research Study [01/01/1970]</option>\n          <option value='2546'>Graduate Medical Education 2003 [10/31/2003]</option>\n          <option value='2593'>Greater Cincinnati Anesthesiology Society 2003 [11/19/2003]</option>\n          <option value='2724'>Greater Cincinnati Anesthesiology Society 2004 [01/21/2004]</option>\n          <option value='3621'>Greater Cincinnati Anesthesiology Society 2005 [02/23/2005]</option>\n          <option value='5780'>Greater Cincinnati Anesthesiology Society 2006 [03/08/2006]</option>\n          <option value='7180'>Greater Cincinnati Anesthesiology Society 2007 [03/27/2007]</option>\n          <option value='8357'>Greater Cincinnati Anesthesiology Society 2008 [01/22/2008]</option>\n          <option value='9587'>Greater Cincinnati Anesthesiology Society 2009 [04/07/2009]</option>\n          <option value='1563'>Greater Cincinnati Bone Club 2002 [05/21/2002]</option>\n          <option value='1724'>Greater Cincinnati Pain Society 2002 [09/17/2002]</option>\n          <option value='1997'>Greater Cincinnati Pain Society 2003 [01/28/2003]</option>\n          <option value='2801'>Greater Cincinnati Pain Society 2004 [02/17/2004]</option>\n          <option value='3516'>Greater Cincinnati Pain Society 2005 [01/17/2005]</option>\n          <option value='5549'>Greater Cincinnati Pain Society 2006 [01/23/2006]</option>\n          <option value='9481'>Greater Cincinnati Radiologic Society [05/20/2009]</option>\n          <option value='12268'>Greater Cincinnati Radiologic Society 2010 [03/23/2010]</option>\n          <option value='15014'>Greater Cincinnati Society of Anesthesiologists [01/31/2013]</option>\n          <option value='12121'>Greater Cincinnati Society of Anesthesiologists 2010 [02/19/2010]</option>\n          <option value='12989'>Greater Cincinnati Society of Anesthesiologists 2011 [01/19/2011]</option>\n          <option value='14146'>Greater Cincinnati Society of Anesthesiologists 2012 [02/23/2012]</option>\n          <option value='2551'>Harold Schwinger Lecture Series 2003 [11/03/2003]</option>\n          <option value='3283'>Health Care for the Homeless 2004 [10/01/2004]</option>\n          <option value='3481'>Health Care for the Homeless 2005 [01/07/2005]</option>\n          <option value='2438'>Hebrew Union College-Ethics Center 2003 [09/19/2003]</option>\n          <option value='14007'>Hematology Oncology 2012 [01/04/2012]</option>\n          <option value='5'>Hematology-Oncology 2000 [01/05/2000]</option>\n          <option value='596'>Hematology-Oncology 2001 [01/12/2001]</option>\n          <option value='1257'>Hematology-Oncology 2002 [01/04/2002]</option>\n          <option value='1936'>Hematology-Oncology 2003 [01/03/2003]</option>\n          <option value='2710'>Hematology-Oncology 2004 [01/16/2004]</option>\n          <option value='3483'>Hematology-Oncology 2005 [01/07/2005]</option>\n          <option value='5471'>Hematology-Oncology 2006 [01/06/2006]</option>\n          <option value='6857'>Hematology-Oncology 2007 [01/05/2007]</option>\n          <option value='8293'>Hematology-Oncology 2008 [01/04/2008]</option>\n          <option value='9084'>Hematology-Oncology 2009 [01/16/2009]</option>\n          <option value='9062'>Hematology-Oncology 2009 [01/09/2009]</option>\n          <option value='11860'>Hematology-Oncology 2010 [01/04/2010]</option>\n          <option value='12916'>Hematology-Oncology 2011 [01/05/2011]</option>\n          <option value='14954'>Hematology-Oncology 2013 [01/03/2013]</option>\n          <option value='12103'>Hemispheric Disconnection as a Mechanism for Schneiderian Delusions in Schizophrenia [02/09/2010]</option>\n          <option value='2206'>Highland District Hospital 2003 [05/02/2003]</option>\n          <option value='2853'>Highland District Hospital 2004 [03/05/2004]</option>\n          <option value='15162'>HMGIM Education Conference [03/18/2013]</option>\n          <option value='5137'>Hospice 2005 [10/18/2005]</option>\n          <option value='6533'>Hospice 2006 [10/08/2006]</option>\n          <option value='7045'>Hospice 2007 [02/27/2007]</option>\n          <option value='4558'>Hot Topics:  Exempt/Expedited IRB Review [03/14/2002]</option>\n          <option value='8007'>Human Subject Protection:  Still Challenging After All These Years [09/26/2008]</option>\n          <option value='493'>Infectious Diseases 2000 [11/11/2000]</option>\n          <option value='5391'>Information of Biomarkers in Pediatric OCD and Depression [01/01/1970]</option>\n          <option value='5326'>Insights into Regulation of Epithelial Secretion [01/01/1970]</option>\n          <option value='501'>Integrative Medicine 2000 [11/15/2000]</option>\n          <option value='5556'>Intermediate Access XP: Tables [08/11/2003]</option>\n          <option value='14432'>Internal Medicine - Attending Meeting [06/21/2012]</option>\n          <option value='14978'>Internal Medicine - Attending Meeting 2013 [01/14/2013]</option>\n          <option value='13101'>Internal Medicine - Current Controversies in Clinical Medicine 2011 [02/14/2011]</option>\n          <option value='14023'>Internal Medicine - Current Controversies in Clinical Medicine 2012 [01/09/2012]</option>\n          <option value='14797'>Internal Medicine - Current Controversies in Clinical Medicine 2013 [12/04/2012]</option>\n          <option value='12876'>Internal Medicine - Molecule to Bedside 2011 [12/17/2010]</option>\n          <option value='13949'>Internal Medicine - Molecule to Bedside 2012 [12/20/2011]</option>\n          <option value='14962'>Internal Medicine - Molecule to Bedside 2013 [01/07/2013]</option>\n          <option value='29'>Internal Medicine 2000 [01/12/2000]</option>\n          <option value='562'>Internal Medicine 2001 [01/03/2001]</option>\n          <option value='1245'>Internal Medicine 2002 [01/02/2002]</option>\n          <option value='1938'>Internal Medicine 2003 [01/08/2003]</option>\n          <option value='2676'>Internal Medicine 2004 [01/07/2004]</option>\n          <option value='3465'>Internal Medicine 2005 [01/05/2005]</option>\n          <option value='5447'>Internal Medicine 2006 [01/04/2006]</option>\n          <option value='6837'>Internal Medicine 2007 [01/03/2007]</option>\n          <option value='8276'>Internal Medicine 2008 [01/02/2008]</option>\n          <option value='9048'>Internal Medicine 2009 [01/07/2009]</option>\n          <option value='11865'>Internal Medicine 2010 [01/06/2010]</option>\n          <option value='12852'>Internal Medicine 2011 [12/06/2010]</option>\n          <option value='13945'>Internal Medicine 2012 [12/19/2011]</option>\n          <option value='14794'>Internal Medicine 2013 [12/03/2012]</option>\n          <option value='5525'>Introductory STD Distance Learning [01/01/1970]</option>\n          <option value='1952'>IRB 2003 [01/13/2003]</option>\n          <option value='2741'>IRB 2004 [01/26/2004]</option>\n          <option value='3503'>IRB 2005 [01/12/2005]</option>\n          <option value='5581'>IRB 2006 [01/26/2006]</option>\n          <option value='9374'>ISCD Bone Densitometry 2008 [02/01/2008]</option>\n          <option value='8390'>ISCD Vertebral Fracture Assessment 2008 [02/01/2008]</option>\n          <option value='4455'>Laparoscopic Herniorrhaphy: A Laparoscopic Approach to Abdominal Wall Defects [11/09/2001]</option>\n          <option value='13205'>Lindner Center of HOPE - Journal Club 2011 [03/04/2011]</option>\n          <option value='9524'>Lindner Center of HOPE 2009 *LINDNER CENTER STAFF ONLY* [07/07/2009]</option>\n          <option value='11709'>Lindner Center of HOPE 2010 [11/25/2009]</option>\n          <option value='12857'>Lindner Center of HOPE 2011 [12/06/2010]</option>\n          <option value='14011'>Lindner Center of HOPE 2012 [01/04/2012]</option>\n          <option value='14800'>Lindner Center of HOPE 2013 [12/04/2012]</option>\n          <option value='12251'>Lindner Center of HOPE Journal Club 2010 [03/09/2010]</option>\n          <option value='7835'>Malcolm Adcock Memorial Lecture Series: \"Pandemic Influenza: A Harbinger of Things to Come\" [05/08/2008]</option>\n          <option value='2193'>Master Series in Otolaryngology 2003 [04/29/2003]</option>\n          <option value='12337'>Medical Education - Faculty Teaching Skills Development Seminar Series [04/30/2010]</option>\n          <option value='13066'>Medical Education 2011 [02/03/2011]</option>\n          <option value='14132'>Medical Education 2012 [02/22/2012]</option>\n          <option value='12105'>Medical Missions and Systems Applications [02/09/2010]</option>\n          <option value='3486'>MFM Core Curriculum Lecutre Series 2005 [01/07/2005]</option>\n          <option value='5474'>MFM Core Curriculum Lecutre Series 2006 [01/06/2006]</option>\n          <option value='6859'>MFM Core Curriculum Lecutre Series 2007 [01/05/2007]</option>\n          <option value='8333'>MFM Core Curriculum Lecutre Series 2008 [01/14/2008]</option>\n          <option value='819'>MFM Ultrasound Journal Club 2001 [04/26/2001]</option>\n          <option value='1393'>MFM Ultrasound Journal Club 2002 [02/25/2002]</option>\n          <option value='1994'>MFM Ultrasound Journal Club 2003 [01/27/2003]</option>\n          <option value='2743'>MFM Ultrasound Journal Club 2004 [01/26/2004]</option>\n          <option value='12508'>Multidisciplinary Solid Tumor Board (Sarcoma Conference) [01/25/2010]</option>\n          <option value='337'>Multidisciplinary Solid Tumor Board 2000 [08/09/2000]</option>\n          <option value='564'>Multidisciplinary Solid Tumor Board 2001 [01/03/2001]</option>\n          <option value='1247'>Multidisciplinary Solid Tumor Board 2002 [01/02/2002]</option>\n          <option value='1940'>Multidisciplinary Solid Tumor Board 2003 [01/08/2003]</option>\n          <option value='2690'>Multidisciplinary Solid Tumor Board 2004 [01/08/2004]</option>\n          <option value='3488'>Multidisciplinary Solid Tumor Board 2005 [01/07/2005]</option>\n          <option value='5497'>Multidisciplinary Solid Tumor Board 2006 [01/11/2006]</option>\n          <option value='6841'>Multidisciplinary Solid Tumor Board 2007 [01/03/2007]</option>\n          <option value='8278'>Multidisciplinary Solid Tumor Board 2008 [01/02/2008]</option>\n          <option value='9050'>Multidisciplinary Solid Tumor Board 2009 [01/07/2009]</option>\n          <option value='9052'>Multidisciplinary Solid Tumor Board 2009 2009 [01/07/2009]</option>\n          <option value='11983'>Multidisciplinary Solid Tumor Board 2010 [01/25/2010]</option>\n          <option value='12892'>Multidisciplinary Solid Tumor Boards 2011 [01/04/2011]</option>\n          <option value='13965'>Multidisciplinary Tumor Boards 2012 [12/21/2011]</option>\n          <option value='14925'>Multidisciplinary Tumor Boards 2013 [12/27/2012]</option>\n          <option value='709'>Nephrology 2001 [03/07/2001]</option>\n          <option value='330'>Neuro/Oncology Tumor Board 2000 [08/02/2000]</option>\n          <option value='588'>Neuro/Oncology Tumor Board 2001 [01/10/2001]</option>\n          <option value='1249'>Neuro/Oncology Tumor Board 2002 [01/02/2002]</option>\n          <option value='1934'>Neuro/Oncology Tumor Board 2003 [01/02/2003]</option>\n          <option value='2678'>Neuro/Oncology Tumor Board 2004 [01/07/2004]</option>\n          <option value='3467'>Neuro/Oncology Tumor Board 2005 [01/05/2005]</option>\n          <option value='5449'>Neuro/Oncology Tumor Board 2006 [01/04/2006]</option>\n          <option value='6843'>Neuro/Oncology Tumor Board 2007 [01/03/2007]</option>\n          <option value='8281'>Neuro/Oncology Tumor Board 2008 [01/02/2008]</option>\n          <option value='9178'>Neuro/Oncology Tumor Board 2009 [03/04/2009]</option>\n          <option value='9054'>Neuro/Oncology Tumor Boards 2009 [01/07/2009]</option>\n          <option value='7'>Neurology 2000 [01/05/2000]</option>\n          <option value='566'>Neurology 2001 [01/03/2001]</option>\n          <option value='1251'>Neurology 2002 [01/02/2002]</option>\n          <option value='1943'>Neurology 2003 [01/08/2003]</option>\n          <option value='2680'>Neurology 2004 [01/07/2004]</option>\n          <option value='3469'>Neurology 2005 [01/05/2005]</option>\n          <option value='5451'>Neurology 2006 [01/04/2006]</option>\n          <option value='6845'>Neurology 2007 [01/03/2007]</option>\n          <option value='8315'>Neurology 2008 [01/09/2008]</option>\n          <option value='9140'>Neurology 2009 [02/11/2009]</option>\n          <option value='9075'>Neurology 2009 [01/14/2009]</option>\n          <option value='11922'>Neurology 2010 [01/07/2010]</option>\n          <option value='12870'>Neurology 2011 [12/17/2010]</option>\n          <option value='14017'>Neurology 2012 [01/04/2012]</option>\n          <option value='14803'>Neurology 2013 [12/04/2012]</option>\n          <option value='14942'>Neurology and Rehabilitation Medicine 2013 [12/31/2012]</option>\n          <option value='12628'>Neuromuscular Conditions and Management in Diabetes [01/20/2010]</option>\n          <option value='3438'>Neuromuscular Conference 2004 [12/09/2004]</option>\n          <option value='3490'>Neuromuscular Conference 2005 [01/07/2005]</option>\n          <option value='5535'>Neuromuscular Conference 2006 [01/19/2006]</option>\n          <option value='6906'>Neuromuscular Conference 2007 [01/18/2007]</option>\n          <option value='11793'>Neuro-Oncology Tumor Board aka UC Brain Tumor Center 2010 [01/01/2010]</option>\n          <option value='8162'>Ninth Annual Pilot Research Project Symposium [10/02/2008]</option>\n          <option value='100'>OB/GYN 2000 [02/17/2000]</option>\n          <option value='609'>OB/GYN 2001 [01/18/2001]</option>\n          <option value='1299'>OB/GYN 2002 [01/17/2002]</option>\n          <option value='1975'>OB/GYN 2003 [01/16/2003]</option>\n          <option value='2708'>OB/GYN 2004 [01/15/2004]</option>\n          <option value='3507'>OB/GYN 2005 [01/12/2005]</option>\n          <option value='5501'>OB/GYN 2006 [01/11/2006]</option>\n          <option value='6874'>OB/GYN 2007 [01/10/2007]</option>\n          <option value='8365'>OB/GYN 2008 [01/23/2008]</option>\n          <option value='9148'>OB/GYN 2009 [02/13/2009]</option>\n          <option value='844'>OB/GYN Perinatal Journal Club 2001 [05/10/2001]</option>\n          <option value='1358'>OB/GYN Perinatal Journal Club 2002 [02/11/2002]</option>\n          <option value='1954'>OB/GYN Perinatal Journal Club 2003 [01/13/2003]</option>\n          <option value='2694'>OB/GYN Perinatal Journal Club 2004 [01/12/2004]</option>\n          <option value='1309'>OB/GYN Society of Cincinnati 2002 [01/23/2002]</option>\n          <option value='1987'>OB/GYN Society of Cincinnati 2003 [01/22/2003]</option>\n          <option value='2730'>OB/GYN Society of Cincinnati 2004 [01/21/2004]</option>\n          <option value='3498'>OB/GYN Society of Cincinnati 2005 [01/11/2005]</option>\n          <option value='5624'>OB/GYN Society of Cincinnati 2006 [02/07/2006]</option>\n          <option value='12756'>Obstetrics and Gynecology 2010 [11/02/2010]</option>\n          <option value='13052'>Obstetrics and Gynecology 2011 [02/01/2011]</option>\n          <option value='14081'>Obstetrics and Gynecology 2012 [01/31/2012]</option>\n          <option value='15215'>Obstetrics and Gynecology 2013 [04/03/2013]</option>\n          <option value='4410'>Ohio Medication Algorithm Project Physician Training [11/19/2001]</option>\n          <option value='36'>Ophthalmology 2000 [01/15/2000]</option>\n          <option value='568'>Ophthalmology 2001 [01/03/2001]</option>\n          <option value='1292'>Ophthalmology 2002 [01/16/2002]</option>\n          <option value='1970'>Ophthalmology 2003 [01/15/2003]</option>\n          <option value='2682'>Ophthalmology 2004 [01/07/2004]</option>\n          <option value='3471'>Ophthalmology 2005 [01/05/2005]</option>\n          <option value='5453'>Ophthalmology 2006 [01/04/2006]</option>\n          <option value='6847'>Ophthalmology 2007 [01/03/2007]</option>\n          <option value='8285'>Ophthalmology 2008 [01/02/2008]</option>\n          <option value='9077'>Ophthalmology 2009 [01/14/2009]</option>\n          <option value='9056'>Ophthalmology 2009 [01/01/2009]</option>\n          <option value='11916'>Ophthalmology 2010 [01/05/2010]</option>\n          <option value='12762'>Ophthalmology 2011 [11/02/2010]</option>\n          <option value='13926'>Ophthalmology 2012 [12/19/2011]</option>\n          <option value='14885'>Ophthalmology 2013 [12/18/2012]</option>\n          <option value='17'>Orthopaedic Surgery 2000 [01/08/2000]</option>\n          <option value='578'>Orthopaedic Surgery 2001 [01/06/2001]</option>\n          <option value='1263'>Orthopaedic Surgery 2002 [01/05/2002]</option>\n          <option value='2402'>Orthopaedic Surgery 2003 [09/03/2003]</option>\n          <option value='2847'>Orthopaedic Surgery 2004 [03/03/2004]</option>\n          <option value='4333'>Orthopaedic Surgery 2005 [05/07/2005]</option>\n          <option value='2147'>Osteoporosis 2003 [04/05/2003]</option>\n          <option value='2748'>Osteoporosis 2004 [01/27/2004]</option>\n          <option value='3576'>Osteoporosis 2005 [02/04/2005]</option>\n          <option value='5598'>Osteoporosis 2006 [01/31/2006]</option>\n          <option value='7035'>Osteoporosis 2007 [02/22/2007]</option>\n          <option value='9'>Otolaryngology 2000 [01/05/2000]</option>\n          <option value='570'>Otolaryngology 2001 [01/03/2001]</option>\n          <option value='1253'>Otolaryngology 2002 [01/02/2002]</option>\n          <option value='1945'>Otolaryngology 2003 [01/08/2003]</option>\n          <option value='2684'>Otolaryngology 2004 [01/07/2004]</option>\n          <option value='3473'>Otolaryngology 2005 [01/05/2005]</option>\n          <option value='5457'>Otolaryngology 2006 [01/04/2006]</option>\n          <option value='6851'>Otolaryngology 2007 [01/03/2007]</option>\n          <option value='8287'>Otolaryngology 2008 [01/02/2008]</option>\n          <option value='9058'>Otolaryngology 2009 [01/07/2009]</option>\n          <option value='9129'>Otolaryngology 2009 [02/04/2009]</option>\n          <option value='11796'>Otolaryngology 2010 [12/18/2009]</option>\n          <option value='12798'>Otolaryngology 2011 [11/12/2010]</option>\n          <option value='13951'>Otolaryngology 2012 [12/20/2011]</option>\n          <option value='14867'>Otolaryngology 2013 [12/14/2012]</option>\n          <option value='671'>Outcomes Research 2001 [02/20/2001]</option>\n          <option value='1259'>Outcomes Research 2002 [01/04/2002]</option>\n          <option value='2011'>Outcomes Research 2003 [01/31/2003]</option>\n          <option value='2712'>Outcomes Research 2004 [01/16/2004]</option>\n          <option value='3492'>Outcomes Research 2005 [01/07/2005]</option>\n          <option value='5866'>Outcomes Research 2006 [03/24/2006]</option>\n          <option value='6911'>Outcomes Research 2007 [01/19/2007]</option>\n          <option value='8355'>Outcomes Research 2008 [01/18/2008]</option>\n          <option value='9064'>Outcomes Research 2009 [01/09/2009]</option>\n          <option value='5857'>Pain Management 2006 [03/22/2006]</option>\n          <option value='3'>Pathology 2000 [01/04/2000]</option>\n          <option value='582'>Pathology 2001 [01/08/2001]</option>\n          <option value='1265'>Pathology 2002 [01/07/2002]</option>\n          <option value='1956'>Pathology 2003 [01/13/2003]</option>\n          <option value='2672'>Pathology 2004 [01/05/2004]</option>\n          <option value='3463'>Pathology 2005 [01/03/2005]</option>\n          <option value='5488'>Pathology 2006 [01/09/2006]</option>\n          <option value='6936'>Pathology 2007 [01/29/2007]</option>\n          <option value='5926'>Pathology AP/CP Meeting - Introductory Remarks on HIPAA [05/13/2003]</option>\n          <option value='4739'>Pathology Autopsy Conference 2005 [08/15/2005]</option>\n          <option value='5490'>Pathology Autopsy Conference 2006 [01/10/2006]</option>\n          <option value='6887'>Pathology Autopsy Conference 2007 [01/16/2007]</option>\n          <option value='6142'>Pathology of Epilepsy and Its Management [01/01/1970]</option>\n          <option value='1'>Pediatrics 2000 [01/03/2000]</option>\n          <option value='705'>Pediatrics 2001 [03/05/2001]</option>\n          <option value='1267'>Pediatrics 2002 [01/07/2002]</option>\n          <option value='3518'>Pharmacy Statin Series 2005 [01/17/2005]</option>\n          <option value='15'>Physical Medicine 2000 [01/07/2000]</option>\n          <option value='576'>Physical Medicine 2001 [01/05/2001]</option>\n          <option value='1261'>Physical Medicine 2002 [01/04/2002]</option>\n          <option value='2013'>Physical Medicine 2003 [01/31/2003]</option>\n          <option value='2692'>Physical Medicine 2004 [01/09/2004]</option>\n          <option value='3494'>Physical Medicine 2005 [01/07/2005]</option>\n          <option value='5476'>Physical Medicine 2006 [01/06/2006]</option>\n          <option value='6861'>Physical Medicine 2007 [01/05/2007]</option>\n          <option value='8295'>Physical Medicine 2008 [01/04/2008]</option>\n          <option value='9066'>Physical Medicine 2009 [01/09/2009]</option>\n          <option value='9134'>Physical Medicine 2009 [02/06/2009]</option>\n          <option value='11787'>Physical Medicine and Rehabilitation 2010 [12/16/2009]</option>\n          <option value='12912'>Physical Medicine and Rehabilitation 2011 [01/04/2011]</option>\n          <option value='13897'>Physical Medicine and Rehabilitation 2012 [11/30/2011]</option>\n          <option value='4967'>Physician Leadership Program 2005 [09/21/2005]</option>\n          <option value='5506'>Physician Leadership Program 2006 [01/11/2006]</option>\n          <option value='7895'>Physician Leadership Program 2007 [09/19/2007]</option>\n          <option value='9444'>Physician Leadership Program 2008-2009 [10/01/2008]</option>\n          <option value='11626'>Physician Leadership Program 2009-2010 [10/01/2008]</option>\n          <option value='13736'>Physician Leadership Program 2011-2012 [09/28/2011]</option>\n          <option value='5987'>Physician Training for the Depression, Schizophrenia & Bipolar Medication Algorithms [01/01/1970]</option>\n          <option value='7932'>Plastic, Reconstructive & Hand Surgery 2007 [10/03/2007]</option>\n          <option value='8289'>Plastic, Reconstructive & Hand Surgery 2008 [01/02/2008]</option>\n          <option value='9575'>Psychiatry – Journal Club 2009 [07/09/2009]</option>\n          <option value='11951'>Psychiatry - Journal Club 2010 [01/13/2010]</option>\n          <option value='12974'>Psychiatry - Journal Club 2011 [01/13/2010]</option>\n          <option value='11'>Psychiatry 2000 [01/05/2000]</option>\n          <option value='593'>Psychiatry 2001 [01/10/2001]</option>\n          <option value='1275'>Psychiatry 2002 [01/09/2002]</option>\n          <option value='1947'>Psychiatry 2003 [01/08/2003]</option>\n          <option value='2686'>Psychiatry 2004 [01/07/2004]</option>\n          <option value='3475'>Psychiatry 2005 [01/05/2005]</option>\n          <option value='5459'>Psychiatry 2006 [01/04/2006]</option>\n          <option value='6853'>Psychiatry 2007 [01/03/2007]</option>\n          <option value='8321'>Psychiatry 2008 [01/09/2008]</option>\n          <option value='9499'>\n            Psychiatry 2008-2009\n            (July 1, 2008 to June 30, 2009) [07/01/2008]\n          </option>\n          <option value='9081'>Psychiatry 2009 [01/14/2009]</option>\n          <option value='9608'>\n            Psychiatry 2009-2010\n            [07/01/2009]\n          </option>\n          <option value='12937'>Psychiatry 2011 [07/01/2009]</option>\n          <option value='14044'>Psychiatry 2012 [01/11/2012]</option>\n          <option value='15071'>Psychiatry 2013 [02/12/2013]</option>\n          <option value='14048'>Psychiatry Journal Club 2012 [01/11/2012]</option>\n          <option value='13087'>Public Health Sciences [02/09/2011]</option>\n          <option value='287'>Pulmonary 2000 [06/19/2000]</option>\n          <option value='9414'>Pulmonary and Critical Care [03/16/2009]</option>\n          <option value='7080'>Pulmonary and Critical Care 2007 [03/05/2007]</option>\n          <option value='8392'>Pulmonary and Critical Care 2008 [02/04/2008]</option>\n          <option value='3379'>Quarterly Mtg. of Council of Child & Adoles. Psych 2004 [11/10/2004]</option>\n          <option value='4056'>Quarterly Mtg. of Council of Child & Adoles. Psych 2005 [04/13/2005]</option>\n          <option value='21'>Radiology 2000 [01/10/2000]</option>\n          <option value='890'>Radiology 2001 [06/01/2001]</option>\n          <option value='1864'>Radiology 2002 [11/18/2002]</option>\n          <option value='3867'>Radiology 2005 [04/02/2005]</option>\n          <option value='3270'>Recovery Month Open House 2004 [09/28/2004]</option>\n          <option value='1061'>Renal Pathology 2001 [09/21/2001]</option>\n          <option value='1451'>Renal Pathology 2002 [03/22/2002]</option>\n          <option value='2102'>Renal Pathology 2003 [03/14/2003]</option>\n          <option value='5514'>Reproductive Health 2003 [03/31/2003]</option>\n          <option value='2891'>Research Study 2004 [03/18/2004]</option>\n          <option value='3699'>Research Study 2005 [03/18/2005]</option>\n          <option value='7028'>Rural Health Collaborative 2007 [02/21/2007]</option>\n          <option value='12630'>SAVE THE DATE:  11th Annual MISS 2011\n            Minimally Invasive Surgery Symposium - February 21-26, 2011 - Salt Lake City, UT\n            [09/08/2010]\n          </option>\n          <option value='6595'>Sixth Annual Pilot Research Project Symposium [10/20/2005]</option>\n          <option value='6596'>Sixth Annual Pilot Research Project Symposium [01/01/1970]</option>\n          <option value='748'>Spirometry 2001 [03/21/2001]</option>\n          <option value='6532'>Spirometry Workshop for the Health Care Professional [09/23/2005]</option>\n          <option value='5387'>Strategies for Inactivation of the RET Proto-Oncogene in Multiple Endocrine Neoplasis, Type 2 [01/01/1970]</option>\n          <option value='13'>Surgery 2000 [01/05/2000]</option>\n          <option value='572'>Surgery 2001 [01/03/2001]</option>\n          <option value='1255'>Surgery 2002 [01/02/2002]</option>\n          <option value='1949'>Surgery 2003 [01/08/2003]</option>\n          <option value='2688'>Surgery 2004 [01/07/2004]</option>\n          <option value='3477'>Surgery 2005 [01/05/2005]</option>\n          <option value='5461'>Surgery 2006 [01/04/2006]</option>\n          <option value='6855'>Surgery 2007 [01/03/2007]</option>\n          <option value='8323'>Surgery 2008 [01/09/2008]</option>\n          <option value='9060'>Surgery 2009 [01/07/2009]</option>\n          <option value='9131'>Surgery 2009 [02/04/2009]</option>\n          <option value='11929'>Surgery 2010 [01/07/2010]</option>\n          <option value='12906'>Surgery 2011 [01/04/2011]</option>\n          <option value='14013'>Surgery 2012 [01/04/2012]</option>\n          <option value='14907'>Surgery 2013 [12/18/2012]</option>\n          <option value='9690'>Technical and Anatomical Considerations of the First Human Face and Maxilla Transplant [08/28/2009]</option>\n          <option value='6762'>The Center on Closing the Health Gap [01/01/1970]</option>\n          <option value='7301'>The Conference and Expo on Closing the Health Gap [04/13/2007]</option>\n          <option value='4821'>The Wellness Lecture Series: Creating a New Balance Between Health Care & the Wellness Industry [06/20/2002]</option>\n          <option value='9688'>The X-Files: Interesting Retina Cases and Novel Treatment [08/28/2009]</option>\n          <option value='4420'>Town Meeting/ Hot Topics on Human Subjects Research [12/05/2001]</option>\n          <option value='8394'>Tri-State Area Pulmonary and Critical Care 2008 [02/04/2008]</option>\n          <option value='13110'>UC Brain Tumor Center [02/21/2011]</option>\n          <option value='14028'>UC Brain Tumor Center 2012 [01/09/2012]</option>\n          <option value='14879'>UC Brain Tumor Center 2013 [12/17/2012]</option>\n          <option value='15233'>UC Health Quarterly Leadership Retreats  [04/17/2013]</option>\n          <option value='7443'>UC Neurology Movement Disorders 2007 [05/17/2007]</option>\n          <option value='8786'>UC Neurology Movement Disorders 2008 [08/06/2008]</option>\n          <option value='9214'>UC Neurology Movement Disorders 2009 [04/15/2009]</option>\n          <option value='9651'>\n            UC Neurology Movement Disorders 2009/2010\n            (August 1, 2009 to June 30, 2010) [07/16/2009]\n          </option>\n          <option value='12579'>UC Neurology Movement Disorders Video Rounds - Jul thru Dec 2010 [08/05/2010]</option>\n          <option value='12922'>UC Neurology Movement Disorders Video Rounds 2011 [01/05/2011]</option>\n          <option value='14056'>UC Neurology Movement Disorders Video Rounds 2012 [01/18/2012]</option>\n          <option value='14983'>UC Neurology Movement Disorders Video Rounds 2013 [01/14/2013]</option>\n          <option value='12390'>University Hospital - Clinical Documentation for Severity of Illness [06/03/2010]</option>\n          <option value='9685'>Update on Heart Failure [08/28/2009]</option>\n          <option value='2480'>Updates in Allergic Diseases Series 2003 [10/07/2003]</option>\n          <option value='2674'>Updates in Allergic Diseases Series 2004 [01/05/2004]</option>\n          <option value='15112'>VAMC Cincinnati [02/27/2013]</option>\n          <option value='14646'>VAMC Cincinnati [09/26/2012]</option>\n          <option value='3442'>Vascular Series Update 2004 [12/14/2004]</option>\n          <option value='9683'>Workplace Diversity: Benefits, Challenges and Solutions [08/28/2009]</option>\n          <option value='5330'>yofascial Pain [01/01/1970]</option>\n        </select>\n      </div>\n    </div>\n  </div>\n  <div class='dialog' id='PersonDetail'>\n    <iframe id='frameDetail' frameborder='0' height='500' name='frameDetail' scrolling='auto' src='' width='840'></iframe>\n  </div>\n  <div class='dialog' id='CopyDialog'>\n    <div style='height:300px;'>\n      <form class='form-horizontal'>\n        <div class='control-group'>\n          <label class='control-label'>Method</label>\n          <div class='controls'>\n            <label class='radio' for='CopyChoice1'>\n              <input class='CopyChoice' id='CopyChoice1' checked='checked' name='CopyChoice' type='radio' value='1'>\n              Paste as new parent activity.\n            </label>\n            <label class='radio' for='CopyChoice2'>\n              <input class='CopyChoice' id='CopyChoice2' disabled='disabled' name='CopyChoice' type='radio' value='2'>\n              Paste as new session within this activity.\n            </label>\n          </div>\n        </div>\n        <div class='control-group'>\n          <label class='control-label'>Title</label>\n          <div class='controls'>\n            <input id='NewActivityTitle' name='NewActivityTitle' style='width: 300px;' type='text'>\n          </div>\n        </div>\n        <div class='control-group' id='ParentActivityOptions'>\n          <label class='control-label'>Type</label>\n          <div class='controls'>\n            <select id='NewActivityType' name='NewActivityType'>\n              <option value=''>Select one...</option>\n              <option value='1'>Live</option>\n              <option value='2'>Enduring Material</option>\n              <option value='3'>Journal</option>\n              <option value='6'>Performance Improvement</option>\n              <option value='7'>Point of Care</option>\n              <option value='8'>Learning From Teaching</option>\n            </select>\n          </div>\n        </div>\n        <div class='control-group' id='NewGroupingSelect' style='display:none;'>\n          <label class='control-label'>Sub Type</label>\n          <div class='controls'>\n            <select id='NewGrouping' name='NewGrouping'></select>\n          </div>\n        </div>\n        <div class='control-group' id='ItemsToCopy'>\n          <label class='control-label'>Items To Copy</label>\n          <div class='controls'>\n            <label class='checkbox' for='copy_agenda'>\n              <input class='CopyItems' id='copy_agenda' checked='checked' name='copy_agenda' type='checkbox' value='agenda'>\n              Agenda\n            </label>\n            <label class='checkbox' for='copy_committee'>\n              <input class='CopyItems' id='copy_committee' checked='checked' name='copy_committee' type='checkbox' value='committee'>\n              Committee Members\n            </label>\n            <label class='checkbox' for='copy_credits'>\n              <input class='CopyItems' id='copy_credits' checked='checked' name='copy_credits' type='checkbox' value='credits'>\n              Credits\n            </label>\n            <label class='checkbox' for='copy_faculty'>\n              <input class='CopyItems' id='copy_faculty' name='copy_faculty' type='checkbox' value='faculty'>\n              Faculty\n            </label>\n            <label class='checkbox' for='copy_files'>\n              <input class='CopyItems' id='copy_files' name='copy_files' type='checkbox' value='files'>\n              Files & Documents\n            </label>\n            <label class='checkbox' for='copy_categories'>\n              <input class='CopyItems' id='copy_categories' checked='checked' name='copy_categories' type='checkbox' value='categories'>\n              Folders\n            </label>\n            <label class='checkbox' for='copy_attendees'>\n              <input class='CopyItems' id='copy_attendees' name='copy_attendees' type='checkbox' value='attendees'>\n              Participants\n            </label>\n            <label class='checkbox' for='copy_finances'>\n              <input class='CopyItems' id='copy_finances' name='copy_finances' type='checkbox' value='finances'>\n              Supporters\n            </label>\n          </div>\n        </div>\n      </form>\n    </div>\n  </div>\n  <div class='dialog' id='CreditsDialog'></div>\n  <div class='dialog' id='email-cert-dialog'></div>\n  <div class='dialog' id='PhotoUpload'>\n    <iframe id='frmUpload' frameborder='0' height='110' scrolling='no' src='' width='440'></iframe>\n  </div>\n  <div class='dialog' id='DisableActivity'>\n    \ \n  </div>\n</div>");
      return $o.join("\n").replace(/\s(?:id|class)=(['"])(\1)/mg, "");
    }).call(window.HAML.context(context));
  };

}).call(this);
(function() {
  if (window.JST == null) {
    window.JST = {};
  }

  window.JST['hub/infobar_view'] = function(context) {
    return (function() {
      var $o;
      $o = [];
      return $o.join("\n");
    }).call(window.HAML.context(context));
  };

}).call(this);
(function() {
  if (window.JST == null) {
    window.JST = {};
  }

  window.JST['hub/linkbar_item_view'] = function(context) {
    return (function() {
      var $c, $e, $o, sub, _i, _len, _ref;
      $e = window.HAML.escape;
      $c = window.HAML.cleanValue;
      $o = [];
      $o.push("<a href='" + ($e($c(this.link))) + "' data-js-namespace='" + ($e($c("js-" + this.event.replace('.', '-')))) + "' data-pjax-container='" + ($e($c("#js-" + this.event.replace('.', '-')))) + "' data-pjax-title='" + ($e($c(this.title))) + "' data-tooltip-title='" + ($e($c(this.tooltip))) + "' data-data-icon='" + ($e($c(this.icon))) + "'>\n  <i class='" + ($e($c(this.icon))) + "'></i>\n  <div class='text'>" + ($c(this.label)) + "</div>");
      if (this.count) {
        $o.push("  <span class='navItemCount pull-right'>" + ($e($c(this.count))) + "</span>");
      }
      $o.push("  <span class='menuLoader'></span>\n  <span class='menuArrow'></span>");
      if (this.subEvents.length) {
        $o.push("  <ul class='nav subnav'>");
        _ref = this.subEvents;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          sub = _ref[_i];
          $o.push("    <a href='" + ($e($c(sub.link))) + "' data-js-namespace='" + ($e($c("js-" + sub.event.replace('.', '-')))) + "' data-pjax-container='" + ($e($c("#js-" + sub.event.replace('.', '-')))) + "' data-pjax-title='" + ($e($c(sub.title))) + "' data-tooltip-title='" + ($e($c(sub.tooltip))) + "' data-data-icon='" + ($e($c(sub.icon))) + "'>\n      <i class='" + ($e($c(sub.icon))) + "'></i>\n      <div class='text'>" + ($c(sub.label)) + "</div>");
          if (sub.count) {
            $o.push("      <span class='navItemCount pull-right'>" + ($e($c(sub.count))) + "</span>");
          }
          $o.push("      <span class='menuLoader'></span>\n      <span class='menuArrow'></span>\n    </a>");
        }
        $o.push("  </ul>");
      }
      $o.push("</a>");
      return $o.join("\n").replace(/\s(\w+)='true'/mg, ' $1').replace(/\s(\w+)='false'/mg, '').replace(/\s(?:id|class)=(['"])(\1)/mg, "");
    }).call(window.HAML.context(context));
  };

}).call(this);
(function() {
  var root;

  Backbone.Marionette.Renderer.render = function(template, data) {
    if (!JST[template]) {
      throw "Template '" + template + "' not found!";
    }
    return JST[template](data);
  };

  root = this;

  root.App = new Backbone.Marionette.Application();

  App.Views = {};

  App.Collections = {};

  App.Models = {};

  App.addInitializer(function(options) {
    var socketIOScript;
    socketIOScript = App.config.get('realtimeUrl') + "socket.io/socket.io.js";
    return $.getScript(socketIOScript, function(script, textStatus, jqXHR) {
      var currentUrl, settings;
      App.rt = io.connect(App.config.get('realtimeUrl'));
      currentUrl = $("<a></a>").attr('href', window.location.href);
      console.log(currentUrl);
      settings = {
        channel: App.Main.model.get('id') + "_" + $.cookie("CFID") + "_" + $.cookie("CFTOKEN")
      };
      return App.rt.on("ready", function() {
        return App.rt.emit('boot', settings);
      });
    });
  });

  App.on("start", function() {
    return console.info("started: Application");
  });

  App.addRegions({
    header: "#header",
    navbar: "#header > .navbar",
    content: "#content > .container > .content-inner",
    footer: "#footer",
    mainContent: "#Content"
  });

}).call(this);
(function() {
  var DialogRegion,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  DialogRegion = (function(_super) {
    __extends(DialogRegion, _super);

    DialogRegion.prototype.el = "#RegionDialog";

    function DialogRegion() {
      _.bindAll(this);
      Backbone.Marionette.Region.prototype.constructor.apply(this, arguments);
      this.on('view:show', this.showDialog, this);
    }

    DialogRegion.prototype.getEl = function(selector) {
      var $el;
      $el = $(selector);
      $el.dialog;
      $el.on("hidden", this.close);
      return $el;
    };

    DialogRegion.prototype.showDialog = function(view) {
      view.on("close", this.hideDialog, this);
      return this.$el.dialog("show");
    };

    DialogRegion.prototype.hideDialog = function() {
      return this.$el.dialog("hide");
    };

    return DialogRegion;

  })(Marionette.Region);

  App.addRegions({
    dialog: DialogRegion
  });

}).call(this);
(function() {
  App.addInitializer(function() {
    return $(document).ready(function() {
      return App.jPanelMenu = $.jPanelMenu({
        menu: $(".jpanel-nav"),
        trigger: 'a.navbar-toggle',
        excludedPanelContent: '#fb-root,script,uvOverlay1,.modal',
        before: function() {
          return console.log("test");
        },
        afterOpen: function() {},
        afterClose: function() {}
      });
    });
  });

}).call(this);
(function() {
  var dialogFixer, mediumDo, oldOpen, smallDo, tinyDo;

  App.respond = {
    mobile: false,
    medium: window.matchMedia("(max-width: 767px)"),
    small: window.matchMedia("(max-width: 360px)"),
    tiny: window.matchMedia("(max-width: 300px)"),
    test: {
      medium: function() {
        mediumDo();
        console.log(App.respond.medium.matches);
        return App.respond.medium.matches;
      },
      small: function() {
        smallDo();
        console.log(App.respond.small.matches);
        return App.respond.small.matches;
      },
      tiny: function() {
        tinyDo();
        console.log(App.respond.tiny.matches);
        return App.respond.tiny.matches;
      }
    }
  };

  dialogFixer = function() {
    var $dialogs, dialogSizer;
    $dialogs = $(".ui-dialog:visible");
    dialogSizer = function(dialog) {
      var content, contentHeight, contentWidth, iframe, winHeight, winWidth;
      content = dialog.find(".ui-dialog-content");
      iframe = content.find("iframe");
      winHeight = $(window).height();
      winWidth = $(window).width();
      dialog.height(winHeight);
      dialog.width(winWidth);
      contentHeight = winHeight - 95;
      contentWidth = winWidth - 28;
      content.height(contentHeight);
      return content.width(contentWidth);
    };
    if ($dialogs.length) {
      return $dialogs.each(function() {
        var content, iframe, orig, thisDialog;
        thisDialog = $(this);
        content = thisDialog.find('.ui-dialog-content');
        iframe = content.find('iframe');
        if (App.respond.medium.matches) {
          thisDialog.addClass('is-mobile');
          if (iframe.length) {
            iframe.height(content.height());
            iframe.width('100%');
          }
          thisDialog.css({
            width: '100%',
            top: 0,
            left: 0
          });
          return dialogSizer(thisDialog);
        } else {
          thisDialog.removeClass('is-mobile');
          orig = thisDialog.data('myOrig');
          thisDialog.height(orig.height);
          thisDialog.width(orig.width);
          thisDialog.css('left', orig.left);
          thisDialog.css('top', orig.top);
          return content.height(orig.contentHeight);
        }
      });
    }
  };

  oldOpen = $.ui.dialog.prototype.open;

  $.ui.dialog.prototype.open = function() {
    var myOrig;
    oldOpen.apply(this, arguments);
    myOrig = {
      height: this.uiDialog.height(),
      width: this.uiDialog.width(),
      left: this.uiDialog.css('left'),
      top: this.uiDialog.css('top'),
      contentHeight: this.uiDialog.find('.ui-dialog-content').height()
    };
    this.uiDialog.data('myOrig', myOrig);
    dialogFixer();
  };

  mediumDo = function() {
    var mql;
    mql = App.respond.medium;
    if (mql.matches) {
      $(window).on("resize", dialogFixer);
      $(window).on("orientationchange", dialogFixer);
      dialogFixer();
      return $("body").addClass("mobile screen-medium");
    } else {
      $(window).off("resize", dialogFixer);
      $(window).off("orientationchange", dialogFixer);
      dialogFixer();
      return $("body").removeClass("mobile screen-medium");
    }
  };

  smallDo = function() {
    var mql;
    mql = App.respond.small;
    if (mql.matches) {
      return $("body").addClass("screen-small");
    } else {
      return $("body").removeClass("screen-small");
    }
  };

  tinyDo = function() {
    var mql;
    mql = App.respond.tiny;
    if (mql.matches) {
      return $("body").addClass("screen-tiny");
    } else {
      return $("body").removeClass("screen-tiny");
    }
  };

  App.respond.medium.addListener(mediumDo);

  App.respond.small.addListener(smallDo);

  App.respond.tiny.addListener(tinyDo);

  $(document).ready(function() {
    if (App.respond.test.medium()) {
      App.jPanelMenu.on();
    }
    App.respond.test.small();
    return App.respond.test.tiny();
  });

}).call(this);
(function() {
  App.module("Components", function(Self, App, Backbone, Marionette, $, _) {
    this.startWithParent = false;
    return this._init = function() {};
  });

}).call(this);
/*
@license Copyright (c) 2003-2013, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/


(function() {
  CKEDITOR.editorConfig = function(config) {
    config.height = "100px";
    config.removePlugins = "elementspath";
    config.resize_enabled = false;
    config.contentsCss = "/assets/application.css";
    config.skinName = "/ckeditor/skins/moono";
    config.bodyClass = "no-layout ckeditor-tweaks";
    config.toolbar = [
      {
        name: "basicstyles",
        groups: ["basicstyles", "cleanup"],
        items: ["Source", "-", "Bold", "Italic", "Strike", "-", "RemoveFormat"]
      }, {
        name: "paragraph",
        groups: ["list", "indent", "blocks", "align", "bidi"],
        items: ["NumberedList", "BulletedList", "-", "Blockquote"]
      }, {
        name: "clipboard",
        groups: ["clipboard", "undo"]
      }, {
        name: "links",
        items: ["Link", "Unlink", "Anchor"]
      }
    ];
    return config.toolbarGroups = [
      {
        name: "clipboard",
        groups: ["clipboard", "undo"]
      }, {
        name: "editing",
        groups: ["find", "selection", "spellchecker"]
      }, {
        name: "links"
      }, {
        name: "insert"
      }, {
        name: "forms"
      }, {
        name: "tools"
      }, {
        name: "document",
        groups: ["mode", "document", "doctools"]
      }, {
        name: "others"
      }, "/", {
        name: "basicstyles",
        groups: ["basicstyles", "cleanup"]
      }, {
        name: "paragraph",
        groups: ["list", "indent", "blocks", "align", "bidi"]
      }, {
        name: "styles"
      }, {
        name: "colors"
      }, {
        name: "about"
      }
    ];
  };

}).call(this);
(function() {
  var defineVars;

  defineVars = function(oRecord) {
    var oPerson, sPersonNameTemp;
    oPerson = new Object();
    oPerson.oLink = $(oRecord);
    oPerson.oPersonRow = oPerson.oLink.parents(".AllAttendees");
    oPerson.nAttendee = oPerson.oPersonRow.find(".personId").val();
    oPerson.nPerson = oPerson.oPersonRow.find(".personId").val();
    oPerson.nAttendee = oPerson.oPersonRow.find(".attendeeId").val();
    oPerson.sAction = oPerson.oLink.parent("li, span").attr("class").replace("-action", "");
    sPersonNameTemp = oPerson.oPersonRow.find(".PersonLink").html();
    oPerson.sPersonName = $.Trim($.ListGetAt(sPersonNameTemp, 2, ",")) + " " + $.Trim($.ListGetAt(sPersonNameTemp, 1, ","));
    return oPerson;
  };

  $.fn.isPerson = function() {
    return this.each(function() {
      var oPersonActionMenu, oPersonRow;
      oPersonRow = $(this);
      return oPersonActionMenu = oPersonRow.find(".user-actions .action-menu button").isPersonActionMenu();
    });
  };

  $.fn.isPersonActionLink = function() {
    return this.each(function() {
      return $(this).click(function(J) {
        var Result, oPerson;
        oPerson = defineVars(this);
        switch (oPerson.sAction) {
          case "assess":
            $.post(sMyself + "Activity.AttendeeDetailAHAH", {
              ActivityID: nActivity,
              PersonID: oPerson.nPerson,
              AttendeeID: oPerson.nAttendee
            }, function(data) {
              return $("#PersonDetailContent").html(data);
            });
            $("#PersonDetailContainer").overlay({
              top: 100,
              left: 50,
              expose: {
                color: "#333",
                loadSpeed: 200,
                opacity: 0.9
              },
              closeOnClick: false,
              onClose: function() {
                updateRegistrants(nId);
                return $("#PersonDetailContent").html("");
              },
              api: true
            }).load();
            break;
          case "pifform":
            $.post(sMyself + "Activity.AttendeeCDC", {
              ActivityID: nActivity,
              PersonID: oPerson.nPerson,
              AttendeeID: oPerson.nAttendee
            }, function(data) {
              return $("#pifForm").html(data);
            });
            $("#pifDialog").dialog({
              title: "PIF Form",
              modal: true,
              autoOpen: false,
              position: [40, 40],
              height: 450,
              width: 750,
              resizable: true,
              dragStop: function(ev, ui) {},
              buttons: {
                Save: function() {
                  $("#frmCDC").ajaxSubmit();
                  addMessage("PIF successfully updated.", 250, 6000, 4000);
                  return $(this).dialog("close");
                },
                Cancel: function() {
                  return $(this).dialog("close");
                }
              },
              overlay: {
                opacity: 0.5,
                background: "black"
              },
              close: function() {
                return $("#pifForm").html("");
              },
              resizeStop: function(ev, ui) {
                return $("#pifForm").css("height", ui.size.height - 73 + "px");
              }
            });
            $("#pifDialog").dialog("open");
            break;
          case "eCMECert":
            $.post(sMyself + "Activity.emailCert", {
              ActivityID: nActivity,
              PersonID: oPerson.nPerson,
              AttendeeID: oPerson.nAttendee
            }, function(data) {
              return $("#email-cert-dialog").html(data);
            });
            $("#email-cert-dialog").dialog({
              title: "Email Certificate",
              modal: true,
              autoOpen: true,
              height: 300,
              width: 400,
              resizable: false,
              overlay: {
                opacity: 0.5,
                background: "black"
              },
              buttons: {
                Save: function() {
                  $("#frmEmailCert").ajaxSubmit({
                    success: function(data) {
                      return addMessage("Emailed certificate successfully.", 250, 6000, 4000);
                    }
                  });
                  updateActions();
                  return $(this).dialog("close");
                },
                Preview: function() {
                  return window.open("Report.CMECert?ActivityID=" + nActivity + "&ReportID=5&SelectedMembers=" + oPerson.nPerson);
                },
                Cancel: function() {
                  return $(this).dialog("close");
                }
              },
              open: function() {},
              close: function() {
                $("#email-cert-dialog").html("");
                return oPerson.nPerson = "";
              }
            });
            $("#email-cert-dialog").dialog("open");
            break;
          case "pCMECert":
            window.open("Report.CMECert?ActivityID=" + nActivity + "&ReportID=5&SelectedMembers=" + oPerson.nPerson);
            break;
          case "CNECert":
            window.open("Report.CNECert?ActivityID=" + nActivity + "&ReportID=6&SelectedMembers=" + oPerson.nPerson);
            break;
          case "credits":
            $.post(sMyself + "Activity.AdjustCredits", {
              ActivityID: nActivity,
              PersonID: oPerson.nPerson,
              AttendeeID: oPerson.nAttendee
            }, function(data) {
              return $("#CreditsDialog").html(data);
            });
            $("#CreditsDialog").dialog({
              title: "Adjust Credits",
              modal: true,
              autoOpen: true,
              height: 175,
              width: 400,
              resizable: false,
              overlay: {
                opacity: 0.5,
                background: "black"
              },
              buttons: {
                Save: function() {
                  $("#formAdjustCredits").ajaxSubmit();
                  addMessage("Credits successfully updated.", 250, 6000, 4000);
                  updateActions();
                  return $(this).dialog("close");
                },
                Cancel: function() {
                  return $(this).dialog("close");
                }
              },
              open: function() {},
              close: function() {
                $("#CreditsDialog").html("");
                return oPerson.nPerson = "";
              }
            });
            $("#CreditsDialog").dialog("open");
            break;
          case "togglemd":
            if ($("#MDNonMD" + oPerson.nAttendee).html() === "Yes") {
              Result = "N";
            } else {
              if ($("#MDNonMD" + oPerson.nAttendee).html() === "No") {
                Result = "Y";
              }
            }
            $.post(sRootPath + "/_com/AJAX_Activity.cfc", {
              method: "updateMDStatus",
              PersonID: oPerson.nPerson,
              AttendeeID: oPerson.nAttendee,
              ActivityID: nActivity,
              MDNonMD: Result,
              returnFormat: "plain"
            }, function(returnData) {
              var cleanData, status, statusMsg;
              cleanData = $.trim(returnData);
              status = $.ListGetAt(cleanData, 1, "|");
              statusMsg = $.ListGetAt(cleanData, 2, "|");
              if (status === "Success") {
                addMessage(statusMsg, 250, 6000, 4000);
                updateActions();
                return updateStats();
              } else {
                return addError(statusMsg, 250, 6000, 4000);
              }
            });
            if ($("#MDNonMD" + oPerson.nAttendee).html() === "Yes") {
              $("#MDNonMD" + oPerson.nAttendee).html("No");
            } else {
              if ($("#MDNonMD" + oPerson.nAttendee).html() === "No") {
                $("#MDNonMD" + oPerson.nAttendee).html("Yes");
              }
            }
            break;
          case "sendCertificate":
            if (confirm("Are you sure you want to send " + oPerson.sPersonName + " a copy of their ceritificate?")) {
              $.ajax({
                url: sRootPath + "/_com/AJAX_Activity.cfc",
                type: "post",
                data: {
                  method: "sendCertificate",
                  activityId: nActivity,
                  PersonID: oPerson.nPerson,
                  AttendeeID: oPerson.nAttendee,
                  returnFormat: "plain"
                },
                dataType: "json",
                success: function(data) {
                  if (data.STATUS) {
                    return addMessage(data.STATUSMSG, 250, 6000, 4000);
                  } else {
                    return addError(data.STATUSMSG, 250, 6000, 4000);
                  }
                }
              });
            }
            break;
          case "reset":
            if (confirm("Are you sure you want to reset the attendee record for " + oPerson.sPersonName + "?")) {
              if (confirm("Do you want to clear all payment information attached to current attendee record for " + oPerson.sPersonName + "?")) {
                resetAttendee(nActivity, oPerson.nAttendee, "Y");
              } else {
                resetAttendee(nActivity, oPerson.nAttendee, "N");
              }
            }
            break;
          case "remove":
            if (confirm("Are you sure you would like to remove " + oPerson.sPersonName + " from this activity?")) {
              $.ajax({
                url: sRootPath + "/_com/AJAX_Activity.cfc",
                type: "post",
                data: {
                  method: "removeCheckedAttendees",
                  AttendeeList: oPerson.nAttendee,
                  ActivityID: nActivity,
                  returnFormat: "plain"
                },
                dataType: "json",
                success: function(data) {
                  if (data.STATUS) {
                    $("#attendeeRow-" + oPerson.nAttendee).fadeOut("medium");
                    addMessage(data.STATUSMSG, 250, 6000, 4000);
                    updateActions();
                    return updateStats();
                  } else {
                    addError(data.STATUSMSG, 250, 6000, 4000);
                    updateRegistrants(nId);
                    updateActions();
                    return updateStats();
                  }
                }
              });
            }
        }
        return J.preventDefault();
      });
    });
  };

  $.fn.isPersonActionMenu = function() {
    var $actionMenu;
    $actionMenu = $("#action_menu");
    return this.one("click", function() {
      var oPerson, sMenuHTML;
      oPerson = defineVars(this);
      sMenuHTML = $actionMenu.html();
      sMenuHTML = $.Replace(sMenuHTML, "{personid}", oPerson.nPerson, "ALL");
      sMenuHTML = $.Replace(sMenuHTML, "{activityid}", nActivity, "ALL");
      $("body").click();
      oPerson.oLink.addClass("clicked").after(sMenuHTML);
      oPerson.oLink.siblings("ul").find("a").find("span").html(oPerson.sPersonName).end().isPersonActionLink();
      $("html").one("click", function() {
        oPerson.oLink.removeClass("clicked").blur().siblings("ul").remove().end().isPersonActionMenu();
        return false;
      });
      return false;
    });
  };

}).call(this);
(function() {
  $.widget("custom.combobox", {
    _create: function() {
      this.wrapper = $("<span>").addClass("").insertAfter(this.element);
      this.element.hide();
      this._createAutocomplete();
      return this._createShowAllButton();
    },
    _createAutocomplete: function() {
      var selected, value;
      selected = this.element.children(":selected");
      value = (selected.val() ? selected.text() : "");
      this.input = $("<input>").appendTo(this.wrapper).val(value).attr("placeholder", "Type a Folder").addClass("input-block-level ui-widget ui-widget-content ui-state-default").autocomplete({
        delay: 0,
        autoFocus: true,
        minLength: 0,
        source: $.proxy(this, "_source")
      }).tooltip({
        tooltipClass: "ui-state-highlight"
      });
      return this._on(this.input, {
        autocompleteselect: function(event, ui) {
          ui.item.option.selected = true;
          return this._trigger("select", event, {
            item: ui.item.option
          });
        },
        autocompletechange: "_removeIfInvalid"
      });
    },
    _createShowAllButton: function() {
      var input, wasOpen;
      input = this.input;
      wasOpen = false;
      return $("<a>").attr("tabIndex", -1).attr("title", "Show All Items").tooltip().appendTo(this.wrapper).button({
        icons: {
          primary: "ui-icon-triangle-1-s"
        },
        text: false
      }).removeClass("ui-corner-all").addClass("custom-combobox-toggle ui-corner-right").mousedown(function() {
        return wasOpen = input.autocomplete("widget").is(":visible");
      }).click(function() {
        input.focus();
        if (wasOpen) {
          return;
        }
        return input.autocomplete("search", "");
      });
    },
    _source: function(request, response) {
      var matcher;
      matcher = new RegExp($.ui.autocomplete.escapeRegex(request.term), "i");
      return response(this.element.children("option").map(function() {
        var text;
        text = $(this).text();
        if (this.value && (!request.term || matcher.test(text))) {
          return {
            label: text,
            value: text,
            option: this
          };
        }
      }));
    },
    _removeIfInvalid: function(event, ui) {
      var valid, value, valueLowerCase;
      if (ui.item) {
        return;
      }
      value = this.input.val();
      valueLowerCase = value.toLowerCase();
      valid = false;
      this.element.children("option").each(function() {
        if ($(this).text().toLowerCase() === valueLowerCase) {
          this.selected = valid = true;
          return false;
        }
      });
      if (valid) {
        return;
      }
      this.input.val("").attr("title", value + " didn't match any item").tooltip("open");
      this.element.val("");
      this._delay((function() {
        return this.input.tooltip("close").attr("title", "");
      }), 2500);
      return this.input.data("ui-autocomplete").term = "";
    },
    _destroy: function() {
      this.wrapper.remove();
      return this.element.show();
    }
  });

}).call(this);
(function() {
  var prettyDate;

  prettyDate = function(time) {
    var date, day_diff, diff;
    date = new Date((time || "").replace(/-/g, "/").replace(/[TZ]/g, " "));
    diff = ((new Date()).getTime() - date.getTime()) / 1000;
    day_diff = Math.floor(diff / 86400);
    if (isNaN(day_diff) || day_diff < 0 || day_diff >= 31) {
      return $.DateFormat(date, "mmm dd, yyyy");
    }
    return day_diff === 0 && (diff < 60 && "just now" || diff < 120 && "1 minute ago" || diff < 3600 && Math.floor(diff / 60) + " minutes ago" || diff < 7200 && "1 hour ago" || diff < 86400 && Math.floor(diff / 3600) + " hours ago") || day_diff === 1 && "Yesterday" || day_diff < 7 && day_diff + " days ago" || day_diff < 31 && Math.ceil(day_diff / 7) + " weeks ago";
  };

  if (typeof jQuery !== "undefined") {
    jQuery.fn.prettyDate = function() {
      return this.each(function() {
        var date;
        date = prettyDate(this.title);
        if (date) {
          return jQuery(this).text(date);
        }
      });
    };
  }

}).call(this);
/*!
* Debug
*/


(function() {
  App.module("Components.Debug", (function(Self, App, Backbone, Marionette, $, _, wndw) {
    var aps, callback_force, callback_func, con, exec_callback, idx, is_level, log_level, log_methods, logs, pass_methods, that, window;
    this.startWithParent = false;
    exec_callback = function(args) {
      if (callback_func && (callback_force || !con || !con.log)) {
        return callback_func.apply(window, args);
      }
    };
    is_level = function(level) {
      if (log_level > 0) {
        return log_level > level;
      } else {
        return log_methods.length + log_level <= level;
      }
    };
    window = wndw;
    aps = Array.prototype.slice;
    con = window.console;
    that = {};
    callback_func = void 0;
    callback_force = void 0;
    log_level = 9;
    log_methods = ["error", "warn", "info", "debug", "log"];
    pass_methods = "assert clear count dir dirxml exception group groupCollapsed groupEnd profile profileEnd table time timeEnd trace".split(" ");
    idx = pass_methods.length;
    logs = [];
    while (--idx >= 0) {
      (function(method) {
        return self[method] = function() {
          return log_level !== 0 && con && con[method] && con[method].apply(con, arguments);
        };
      })(pass_methods[idx]);
    }
    idx = log_methods.length;
    while (--idx >= 0) {
      (function(idx, level) {
        return Self[level] = function() {
          var args, log_arr;
          args = aps.call(arguments);
          log_arr = [level].concat(args);
          logs.push(log_arr);
          exec_callback(log_arr);
          if (!con || !is_level(idx)) {
            return;
          }
          if (con.firebug) {
            return con[level].apply(window, args);
          } else {
            if (con[level]) {
              return con[level](args);
            } else {
              return con.log(args);
            }
          }
        };
      })(idx, log_methods[idx]);
    }
    this.setLevel = function(level) {
      return log_level = (typeof level === "number" ? level : 9);
    };
    return this.setCallback = function() {
      var args, i, max, _results;
      args = aps.call(arguments);
      max = logs.length;
      i = max;
      callback_func = args.shift() || null;
      callback_force = (typeof args[0] === "boolean" ? args.shift() : false);
      i -= (typeof args[0] === "number" ? args.shift() : max);
      _results = [];
      while (i < max) {
        _results.push(exec_callback(logs[i++]));
      }
      return _results;
    };
  }), window);

  App.Components.Debug.start();

  App.log = App.Components.Debug.log;

  App.logInfo = App.Components.Debug.info;

  App.logError = App.Components.Debug.error;

  App.logWarn = App.Components.Debug.warn;

  App.logDebug = App.Components.Debug.debug;

}).call(this);
/*!
* SEARCH CLASS
*/


(function() {
  App.Components.Search = (function() {
    function Search(settings) {
      var $tooltips, Self;
      this.settings = settings;
      App.logInfo("New Search: " + this.settings.el);
      this.$base = $(this.settings.el);
      Self = this;
      Self = _.extend(Self, Backbone.Events);
      this.$formEasy = this.$base.find(".js-search-easy");
      this.$formAdv = this.$base.find(".js-search-adv");
      $tooltips = this.$base.find("[data-tooltip-title]");
      this.on("search", function() {
        App.logInfo("search: searched!");
      });
      this.on("result", function() {
        App.logInfo("search: results!");
      });
      this.on("ready", function() {
        App.logInfo("search: Ready!");
      });
      $tooltips.tooltip({
        placement: 'top',
        html: 'true',
        trigger: 'hover focus',
        title: function(e) {
          return $(this).attr('data-tooltip-title');
        },
        container: 'body'
      }, false);
      Self.trigger('ready');
      return Self;
    }

    return Search;

  })();

}).call(this);
/*!
* Components > PersonFinder
*/


(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.module("Components.PersonFinder", function(Self, App, Backbone, Marionette, $) {
    this.startWithParent = false;
    return this.PersonFinder = (function(_super) {
      __extends(PersonFinder, _super);

      function PersonFinder(options) {
        options = options || {};
        this.options = options;
        PersonFinder.__super__.constructor.apply(this, arguments);
      }

      PersonFinder.prototype.el = "";

      PersonFinder.prototype.events = {
        "click .dialog-content": "clickTest"
      };

      PersonFinder.prototype.clickTest = function() {
        return alert("click");
      };

      PersonFinder.prototype.loadMarkup = function(callback) {
        var cb;
        cb = callback;
        return $.ajax({
          url: this.options.url,
          type: 'get',
          data: {
            instance: this.options.instance,
            activity: this.options.activityid
          },
          success: function(data) {
            return cb(data);
          }
        });
      };

      PersonFinder.prototype.render = function() {
        loadMarkup(function(data) {
          return this.$el.html($(data));
        });
        return this;
      };

      PersonFinder.prototype.initialize = function() {};

      return PersonFinder;

    })(Backbone.View);
  });

}).call(this);
/*!
* FORM STATE MANAGEMENT
*/


(function() {
  App.Components.FormState = (function() {
    function FormState(settings) {
      var $actions, $changedFields, $changedValues, $ckeditors, $discardButton, $form, $groupsets, $inputs, $saveButton, $saveInfo, $toolbar, $tooltips, AddChange, ChangedFields, ChangedValues, ClearChanges, IsSaved, Self, Unsaved, config, disableSave, enableSave, isDirty, isPublishArea, resetForm, setInitialState, setupCKEDITOR, showAllGroupsets;
      this.settings = settings;
      App.logInfo("New FormState: " + this.settings.el);
      Self = this;
      Self = _.extend(Self, Backbone.Events);
      $form = $(this.settings.el);
      $toolbar = $('<div class="toolbar btn-toolbar test"></div>');
      $toolbar.prependTo($form.parents('.content-inner :first'));
      $actions = $('<div class="ViewSectionButtons btn-group"></div>');
      $saveInfo = $('<div class="SaveInfo js-save-info"></div>');
      $saveButton = $('<a href="javascript://" class="btn btn-mini js-btn-save">Save Now</a>');
      $discardButton = $('<a class="btn btn-mini js-btn-discard">Cancel</a>');
      $saveButton.appendTo($actions);
      $inputs = $form.find(':input');
      $ckeditors = $form.find(".js-ckeditor");
      $saveInfo.appendTo($toolbar);
      $actions.appendTo($toolbar);
      $toolbar.removeClass('hide');
      $tooltips = $inputs.filter('[data-tooltip-title]');
      console.log($tooltips);
      $changedFields = $('<input type="text" class="js-changed-fields hide" name="ChangedFields" value="" />');
      $changedValues = $('<input type="text" class="js-changed-values hide" name="ChangedValues" value="" />');
      $form.append($changedFields);
      $form.append($changedValues);
      $form.addClass('js-formstate formstate');
      /*!
      GROUPSETS SETUP / BINDING
      */

      $groupsets = $form.find(".control-groupset");
      $groupsets.each(function() {
        var $groupset, $groupsetLink, $groupsetTitle, config;
        $groupset = $(this);
        $groupsetTitle = $groupset.find('.groupset-title');
        $groupsetLink = $('<a></a>');
        $groupset.activate = function() {
          $groupset.addClass('activated');
        };
        $groupset.deactivate = function() {
          $groupset.removeClass('activated');
        };
        config = _.defaults($groupset.data(), {
          'triggerText': ("Edit " + ($groupsetTitle.text())) || "Edit",
          'defaultState': 1
        });
        $groupsetLink.attr('href', '#').addClass('js-groupset-link groupset-link').text(config.triggerText).appendTo($groupset).on("click", function() {
          $groupset.activate();
        });
        if (config.defaultState) {
          $groupset.addClass('activated');
        } else {
          $groupset.removeClass('activated');
        }
      });
      /*!
      TAB INDEX OVERRIDES
      */

      $inputs.each(function(i, el) {
        var $el;
        $el = $(el);
        $el.attr('tabindex', i + 1);
      });
      this.config = config = {
        "buttons": {
          "save": "Save Now",
          "saved": "Saved",
          "saving": "Saving..."
        }
      };
      this.on("reset", function() {
        App.logInfo("formstate: reset!");
      });
      this.on("beforeSave", function() {
        App.logInfo("formstate: beforeSave!");
      });
      this.on("save", function() {
        var IsSaved, d;
        App.logInfo("formstate: saved!");
        d = new Date();
        setInitialState();
        disableSave();
        $saveInfo.text("Last saved at " + d.getHours() + ":" + d.getMinutes() + " ");
        Self.ClearChanges();
        IsSaved = true;
        addMessage("Information saved!", 250, 6000, 4000);
      });
      this.on("ready", function() {
        App.logInfo("formstate: Ready!");
      });
      this.on("change", function(eventName, changePair) {
        App.logInfo("formstate: change: " + eventName);
        if (isDirty()) {
          Self.AddChange(changePair.field, changePair.value);
          Unsaved();
        } else {
          resetForm();
        }
      });
      IsSaved = this.settings.saved || true;
      isPublishArea = false;
      ChangedFields = "";
      ChangedValues = "";
      $tooltips.tooltip({
        placement: 'right',
        html: 'true',
        trigger: 'hover focus',
        title: function(e) {
          return $(this).attr('data-tooltip-title');
        },
        container: 'body'
      });
      $saveInfo.html("Last saved " + lastSavedDate);
      $form.append($changedFields);
      $form.append($changedValues);
      $form.find("input,textarea").keyup(function() {
        var change;
        change = {
          'field': $(this).attr('name'),
          'value': $(this).val()
        };
        Self.trigger('change', 'input.keyup!', change);
      });
      $form.find(".DatePicker").datepicker({
        showOn: "focus",
        showButtonPanel: true,
        changeMonth: true,
        changeYear: true,
        onSelect: function() {
          var change;
          change = {
            'field': $(this).attr('name'),
            'value': $(this).val()
          };
          Self.trigger('change', 'date.chosen!', change);
        }
      });
      $form.find("select").on("change", function() {
        var change;
        change = {
          'field': $(this).attr('name'),
          'value': $(this).selectedTexts()
        };
        Self.trigger('change', 'select.change!', change);
      });
      $form.find("input[type='checkbox']").on("click", function() {
        var $this, change, value;
        $this = $(this);
        value = '';
        if ($this.attr('checked')) {
          value = $this.data('initialState');
        }
        change = {
          'field': $(this).attr('name'),
          'value': value
        };
        Self.trigger('change', 'checkbox.checked!', change);
      });
      $form.find("input[type='radio']").on("click", function() {
        var change;
        change = {
          'field': $(this).attr('name'),
          'value': $(this).val()
        };
        Self.trigger('change', 'radio.checked!', change);
      });
      $discardButton.click(function() {
        resetForm();
        return true;
      });
      Self.setupCKEDITOR = setupCKEDITOR = function($input) {
        var $elem, id, updateValue;
        $elem = $input;
        id = $elem.attr('id');
        CKEDITOR.replace(id, {
          customConfig: '/app/components/ckeditor-config',
          on: {
            blur: function(evt) {
              var $editor;
              $editor = $(this.container.$);
              return $editor.find(".cke_top").css({
                'display': ''
              });
            },
            focus: function(evt) {
              var $editor;
              $editor = $(this.container.$);
              return $editor.find(".cke_top").css({
                'display': 'block'
              });
            },
            instanceReady: function(evt) {
              var $editor;
              $editor = $(this.container.$);
              this.document.on("keyup", updateValue);
              return this.document.on("paste", updateValue);
            }
          }
        });
        return updateValue = function() {
          CKEDITOR.instances[id].updateElement();
          $elem.trigger('keyup');
        };
      };
      $ckeditors.each(function() {
        setupCKEDITOR($(this));
      });
      $form.submit(function() {
        $(this).ajaxSubmit({
          type: "post",
          dataType: "json",
          beforeSubmit: function() {
            $saveButton.text(config.buttons.saving).removeClass('btn-primary').addClass('disabled').attr("disabled", true);
          },
          success: function(responseText, statusText) {
            if (!responseText.STATUS) {
              $.each(responseText.ERRORS, function(i, item) {
                return addError(item.MESSAGE, 250, 6000, 4000);
              });
              $saveButton.text(config.buttons.save).removeClass('disabled').attr("disabled", false);
              IsSaved = false;
            } else {
              Self.trigger('save');
            }
          }
        });
        return false;
      });
      Self.isDirty = isDirty = function() {
        return _.some($inputs, function(i) {
          var input;
          input = $(i);
          if (input.val() !== input.data('initialState')) {
            return true;
          } else {
            return false;
          }
        });
      };
      Self.resetForm = resetForm = function() {
        IsSaved = true;
        $ckeditors.each(function() {
          var $elem, id;
          $elem = $(this);
          id = $elem.attr('id');
          CKEDITOR.instances[id].destroy();
          setupCKEDITOR($elem);
        });
        Self.ClearChanges();
        $inputs.each(function(i, elem) {
          var input;
          input = $(elem);
          input.val(input.data('initialState'));
        });
        disableSave();
        $discardButton.detach();
        Self.trigger('reset');
      };
      Self.disableSave = disableSave = function() {
        $saveButton.removeClass('btn-primary').attr("disabled", true).addClass('disabled').text(config.buttons.saved).off();
        $discardButton.detach();
      };
      Self.enableSave = enableSave = function() {
        $saveButton.attr("disabled", false).removeClass('disabled').text(config.buttons.save).addClass('btn-primary').on("click", function(e) {
          Self.trigger("beforeSave");
          $form.submit();
          e.preventDefault();
        });
        $discardButton.appendTo($actions);
      };
      Self.Unsaved = Unsaved = function() {
        if (IsSaved) {
          enableSave();
        }
        App.logInfo("formstate: dirty: " + (Self.isDirty()));
        IsSaved = false;
      };
      Self.AddChange = AddChange = function(sField, sValue) {
        var nLocation;
        if (sValue === "") {
          sValue = "%20";
        }
        if (!$.ListFind(ChangedFields, sField, "|")) {
          ChangedFields = $.ListAppend(ChangedFields, sField, "|");
          ChangedValues = $.ListAppend(ChangedValues, sValue, "|");
        } else {
          nLocation = $.ListFind(ChangedFields, sField, "|");
          ChangedValues = $.ListSetAt(ChangedValues, nLocation, sValue, "|");
        }
        $changedFields.val(ChangedFields);
        $changedValues.val(ChangedValues);
      };
      Self.ClearChanges = ClearChanges = function() {
        ChangedFields = "";
        ChangedValues = "";
        $changedFields.val("");
        $changedValues.val("");
        IsSaved = true;
      };
      Self.setInitialState = setInitialState = function() {
        $inputs.each(function(i, elem) {
          var input, value;
          input = $(elem);
          value = input.val();
          if (input.attr('type') === 'checkbox') {
            if (input.attr('checked')) {
              value = true;
            } else {
              value = false;
            }
          }
          return input.data('initialState', value);
        });
      };
      Self.activateAllGroupsets = showAllGroupsets = function() {
        return $groupsets.each(function() {
          return $(this).addClass('activated');
        });
      };
      Self.deactivateAllGroupsets = showAllGroupsets = function() {
        return $groupsets.each(function() {
          return $(this).removeClass('activated');
        });
      };
      disableSave();
      setInitialState();
      Self.trigger('ready');
      return Self;
    }

    return FormState;

  })();

}).call(this);
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.Collections.LinkbarCollection = (function(_super) {
    __extends(LinkbarCollection, _super);

    function LinkbarCollection() {
      _ref = LinkbarCollection.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    return LinkbarCollection;

  })(Backbone.Collection);

}).call(this);
(function() {


}).call(this);
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.Views.HubInfobarView = (function(_super) {
    __extends(HubInfobarView, _super);

    function HubInfobarView() {
      _ref = HubInfobarView.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    HubInfobarView.prototype.el = '.hub .hub-infobar';

    HubInfobarView.prototype.initialize = function() {};

    return HubInfobarView;

  })(Marionette.ItemView);

}).call(this);
(function() {
  var _ref, _ref1,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.Views.HubLinkbarItemView = (function(_super) {
    __extends(HubLinkbarItemView, _super);

    function HubLinkbarItemView() {
      _ref = HubLinkbarItemView.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    HubLinkbarItemView.prototype.tagName = 'li';

    HubLinkbarItemView.prototype.template = 'hub/linkbar_item_view';

    HubLinkbarItemView.prototype.ui = {
      link: 'a'
    };

    HubLinkbarItemView.prototype.events = {
      'click a': 'linkClicked'
    };

    HubLinkbarItemView.prototype.linkClicked = function(e) {
      var container, excludedModules, link;
      link = $(e.currentTarget);
      excludedModules = "Folders,Stats".split(',');
      $.each(App[this.options.hub.type.capitalize()].submodules, function(i, module) {
        if (excludedModules.indexOf(i) === -1) {
          module.stop();
        }
      });
      container = link.data('pjax-container');
      $(".content-inner").wrapInner("<div id='" + (container.replace('#', '')) + "'></div>");
      return $.pjax.click(e, {
        container: container
      });
    };

    HubLinkbarItemView.prototype.onRender = function() {
      console.log("rendered link");
      console.log(this.ui.link);
      this.ui.link = this.ui.link;
      this.ui.link.on("click", function(e) {
        var $link;
        $link = $(this);
        return e.preventDefault();
      });
      if (!Modernizr.touch) {
        return this.ui.link.tooltip({
          placement: 'right',
          html: true,
          title: function(e) {
            return $(this).attr('data-tooltip-title');
          },
          container: 'body'
        });
      }
    };

    return HubLinkbarItemView;

  })(Marionette.ItemView);

  App.Views.HubLinkbarView = (function(_super) {
    __extends(HubLinkbarView, _super);

    function HubLinkbarView() {
      _ref1 = HubLinkbarView.__super__.constructor.apply(this, arguments);
      return _ref1;
    }

    HubLinkbarView.prototype.el = ".hub .js-hub-menu ul.nav";

    HubLinkbarView.prototype.buildItemView = function(item, ItemViewType, itemViewOptions) {
      var options, view;
      options = _.extend({
        model: item
      }, itemViewOptions);
      view = new App.Views.HubLinkbarItemView(options);
      return view;
    };

    HubLinkbarView.prototype.triggers = {
      "click a": "linkbar:clicked"
    };

    HubLinkbarView.prototype.itemView = App.Views.HubLinkbarItemView;

    return HubLinkbarView;

  })(Marionette.CollectionView);

}).call(this);
/*
* HUB VIEW (Represents top level sections of the app such as 'Activity' and 'Person')
*/


(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.Views.HubView = (function(_super) {
    __extends(HubView, _super);

    function HubView() {
      _ref = HubView.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    HubView.prototype.el = ".hub";

    HubView.prototype.LinkbarView = App.Views.HubLinkbarView;

    HubView.prototype.InfobarView = App.Views.HubInfobarView;

    HubView.prototype.type = "undefined";

    HubView.prototype.hasKey = function() {
      if (this.model.get('id')) {
        return true;
      }
    };

    HubView.prototype.showInfobar = function() {
      var $spanDiv;
      $spanDiv = this.infobar.$el.parent();
      App.setCookie('prefInfoBar', true, {
        path: '/',
        expires: 7
      });
      console.log("infobar cookie: " + (App.getCookie('prefInfoBar')));
      this.ui.infobarToggle.addClass('active');
      this.$el.removeClass('infobar-inactive').addClass('infobar-active');
    };

    HubView.prototype.hideInfobar = function() {
      var $spanDiv;
      this.ui.infobarToggle.removeClass('active');
      App.setCookie('prefInfoBar', false, {
        path: '/',
        expires: 7
      });
      console.log("infobar cookie: " + (App.getCookie('prefInfoBar')));
      $spanDiv = this.infobar.$el.parent();
      this.$el.removeClass('infobar-active').addClass('infobar-inactive');
    };

    HubView.prototype.enableSwipe = function() {
      return this.linkbar.$el.swipeThis({
        'fillContainer': false,
        'multiple': true,
        'itemWidth': 92,
        'itemHeight': 80,
        'marginRight': 12
      });
    };

    HubView.prototype.disableSwipe = function() {
      var $linkbar;
      $linkbar = this.linkbar.$el;
      return $linkbar.swipeThis('destroy');
    };

    HubView.prototype.initialize = function() {
      var hub;
      HubView.__super__.initialize.apply(this, arguments);
      hub = this;
      this.ui = {
        titlebar: this.$(".hub-body .titlebar .title-text"),
        contentTitlebar: this.$(".hub-content .content-title h3"),
        infobarToggle: this.$(".js-toggle-infobar"),
        actionButtons: this.$(".action-buttons a.btn, .action-buttons button.btn")
      };
      this.linkbar = new this.LinkbarView({
        collection: this.options.linkbarCollection,
        itemViewOptions: {
          'hub': hub
        }
      });
      this.infobar = new this.InfobarView;
      this.linkbar.on("collection:rendered", function() {});
      this.linkbar.render();
      $(document).on('pjax:send', function(xhr, options) {
        var $clickedLink, $parent;
        $clickedLink = $(xhr.relatedTarget);
        $parent = $clickedLink.parent();
        $parent.addClass('loading');
      });
      $(document).on('pjax:timeout', function(e) {
        e.preventDefault();
      });
      $(document).on('pjax:complete', function(xhr, options, textStatus) {
        var $clickedLink, $contentArea, $contentTitle, $pageTitle, $parent;
        $clickedLink = $(xhr.relatedTarget);
        $pageTitle = $clickedLink.data('pjax-title');
        $contentArea = $(xhr.target);
        $contentTitle = hub.ui.contentTitlebar;
        $contentTitle.text($pageTitle);
        $parent = $clickedLink.parent();
        document.title = "" + $pageTitle;
        $parent.find('.active').removeClass('active');
        $parent.siblings().removeClass('active');
        $clickedLink.children().removeClass('active');
        $parent.addClass('active');
        $parent.removeClass('loading');
      });
      this.ui.infobarToggle.on("click", function(e) {
        var $btn;
        $btn = $(this);
        if ($btn.hasClass('active')) {
          hub.hideInfobar();
        } else {
          hub.showInfobar();
        }
      });
      if (!Modernizr.touch) {
        this.ui.titlebar.tooltip({
          placement: 'bottom',
          trigger: 'hover focus',
          container: 'body',
          title: function(e) {
            return $(this).text();
          }
        });
        this.ui.actionButtons.tooltip({
          placement: 'bottom',
          trigger: 'hover focus',
          container: 'body'
        });
      }
      if (App.getCookie('prefInfoBar')) {
        this.showInfobar();
      } else {
        this.hideInfobar();
      }
      if (App.respond.test.medium()) {
        this.enableSwipe();
      }
      return App.respond.medium.addListener(function() {
        var mql;
        mql = App.respond.medium;
        if (mql.matches) {
          return hub.enableSwipe();
        } else {
          return hub.disableSwipe();
        }
      });
    };

    return HubView;

  })(Marionette.ItemView);

}).call(this);
/*!
* NEWS FEED COMPONENT
*/


(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.Components.NewsFeed = (function() {
    function NewsFeed(settings) {
      var ListerView, Self, filterHtml, filterTemplate, listerParams, _ref;
      this.settings = settings;
      App.logInfo("New History: in '" + this.settings.el + "'");
      Self = this;
      Self = _.extend(Self, Backbone.Events);
      this.$container = $(this.settings.el);
      /*
      LIST SETUP
      */

      this.$list = $('<div class="history-list"></div>');
      this.Collection = (function(_super) {
        __extends(Collection, _super);

        function Collection() {
          _ref = Collection.__super__.constructor.apply(this, arguments);
          return _ref;
        }

        Collection.prototype.parse = function(response) {
          return response.PAYLOAD;
        };

        Collection.prototype.url = "/admin/_com/ajax_history.cfc?method=list";

        return Collection;

      })(Backbone.Collection);
      /*
      FILTER OPTIONS SETUP
      */

      filterHtml = '<div class="history-filter btn-group"></div>';
      /*
      FILTER BUTTONS
      */

      this.$filters = $(filterHtml);
      filterTemplate = _.template('<a href="" class="btn btn-default" data-mode="<%= filter%>"><%= label%></a>');
      _.each(this.settings.modes, function(mode, key) {
        var $filter, filterContext;
        console.log("" + mode + "," + key);
        filterContext = Self.filterTypes[Self.settings.hub][mode];
        console.log(filterContext);
        $filter = $(filterTemplate(filterContext));
        Self.$filters.append($filter);
        $filter.on("click", function(e) {
          var $link, label;
          $link = $(this);
          mode = $link.data("mode");
          label = $link.text();
          Self.lister.setMode(mode);
          Self.lister.getList(true);
          $link.siblings(".active").removeClass("active");
          $link.addClass("active");
          return e.preventDefault();
        });
        return true;
      });
      this.$filters.appendTo(this.$container);
      this.$list.appendTo(this.$container);
      this.collection = new this.Collection();
      /*
      PRIMARY LIST VIEW
      */

      ListerView = (function(_super) {
        __extends(ListerView, _super);

        function ListerView(properties) {
          var self;
          self = this;
          settings = properties;
          this.setMode = function(mode) {
            return settings.mode = mode;
          };
          this.setStartRow = function(startrow) {
            return settings.data.startrow = startrow;
          };
          this.setMaxRows = function(maxrows) {
            return settings.data.maxrows = maxrows;
          };
          this.getList = function(clear, startTime, inject) {
            if (!inject) {
              inject = "append";
            }
            settings.data.starttime = startTime;
            if (clear) {
              Self.$list.empty();
            }
            Self.listHistory(settings.data, inject);
          };
          return;
        }

        return ListerView;

      })(Backbone.View);
      /*
      LISTER VIEW SETUP
      */

      listerParams = _.defaults({
        startrow: 1,
        maxrows: 25
      }, this.settings.queryParams);
      this.lister = new ListerView({
        mode: this.settings.defaultMode,
        appendto: this.$list,
        data: listerParams
      });
      /*
      START THE LIST
      */

      this.lister.getList(true);
      return {
        lister: Self.lister
      };
    }

    NewsFeed.prototype.filterTypes = {
      person: {
        "personAll": {
          "label": 'All',
          "filter": 'personAll'
        },
        "personTo": {
          "label": 'To Person',
          "filter": 'personTo'
        },
        "personFrom": {
          "label": 'By Person',
          "filter": 'personFrom'
        }
      },
      activity: {
        "activityAll": {
          "label": 'All',
          "filter": 'activityTo'
        }
      },
      main: {
        "personTo": {
          "label": 'To Me',
          "filter": 'personTo'
        },
        "personFrom": {
          "label": 'By Me',
          "filter": 'personFrom'
        }
      }
    };

    NewsFeed.prototype.itemTemplate = _.template('<div class="history-item" id="history-item-<%=row.HISTORYID%>">\
                              <div class="history-line">\
                                <img src="/admin/_images/icons/<%=row.ICONIMG%>" border="0" />\
                                <%=content%>\
                              </div>\
                              <% if(subcontent) { %>\
                              <div class="history-subbox clearfix"><%=subcontent%></div>\
                              <% } %>\
                              <div class="history-meta">\
                                <a title="<%=row.CREATED%>">\
                                <%=row.CREATED%>\
                                </a>\
                              </div>\
                            </div>');

    NewsFeed.prototype.listHistory = function(params, inject) {
      var Self, output;
      Self = this;
      output = "";
      App.rt.on("feed", function(data) {
        var newsItems;
        newsItems = new Self.Collection(data);
        newsItems.each(function(itemModel) {
          var $historyitem, item, rendered;
          item = itemModel.attributes;
          $historyitem = "";
          rendered = Self.renderItem(item);
          if (inject === "append") {
            Self.$list.append(rendered);
            $historyitem = $("#history-item-" + item.HISTORYID);
            $historyitem.show();
          } else if (inject === "prepend") {
            Self.$list.prepend(Self.renderItem(item));
            $historyitem = $("#history-item-" + item.HISTORYID);
            $historyitem.fadeIn();
          }
          $historyitem.find(".history-meta a").prettyDate();
          $historyitem.find(".prettydate").prettyDate();
          setInterval((function() {
            return $historyitem.find(".history-meta a").prettyDate();
          }), 5000);
          return setInterval((function() {
            return $historyitem.find(".prettydate").prettyDate();
          }), 5000);
        });
      });
    };

    NewsFeed.prototype.stop = function() {};

    NewsFeed.prototype.renderItem = function(row) {
      var Self, aFoundFields, itemContext, re, sOutput;
      Self = this;
      re = /\%[A-Za-z]+\%/g;
      itemContext = {
        content: row.TEMPLATEFROM,
        subcontent: $.Replace(row.TOCONTENT, "/index.cfm/event/", sMyself, "ALL") || "",
        row: row
      };
      aFoundFields = _.flatten(itemContext.content.match(re));
      aFoundFields = _.unique(aFoundFields);
      sOutput = "";
      _.each(aFoundFields, function(value, key, list) {
        itemContext.content = $.Replace(itemContext.content, value, row[value.replace(/%/g, '').toUpperCase()], "ALL");
        return true;
      });
      sOutput = this.itemTemplate(itemContext);
      return sOutput;
    };

    return NewsFeed;

  })();

}).call(this);
/*!
* USER
*/


(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.module("Main", {
    startWithParent: false,
    define: function(Main, App, Backbone, Marionette, $) {
      var $contentArea, $contentToggleSpan, $infoBar, $infoBarToggleSpan, $infoBarToggler, $menuBar, $profile, $projectBar, $statusBox, $statusChanger, $statusIcon, $titlebar, InfobarView, LinkbarView, MainView, Model, cShowInfobar, defaultFolders, _init, _ref, _ref1, _ref2, _ref3;
      cShowInfobar = null;
      $profile = null;
      $projectBar = null;
      $contentArea = null;
      $infoBar = null;
      $infoBarToggler = null;
      $contentToggleSpan = null;
      $infoBarToggleSpan = null;
      $statusChanger = null;
      $statusIcon = null;
      $titlebar = null;
      $statusBox = null;
      $menuBar = null;
      defaultFolders = null;
      Main.on("before:start", function() {
        App.logInfo("starting: " + Main.moduleName);
      });
      Main.on("start", function(options) {
        $(document).ready(function() {
          _init(options);
          return App.logInfo("started: " + Main.moduleName);
        });
      });
      Main.on("stop", function() {
        App.logInfo("stopped: " + Main.moduleName);
      });
      Model = (function(_super) {
        __extends(Model, _super);

        function Model() {
          _ref = Model.__super__.constructor.apply(this, arguments);
          return _ref;
        }

        Model.prototype.url = '/api/';

        return Model;

      })(Backbone.Model);
      InfobarView = (function(_super) {
        __extends(InfobarView, _super);

        function InfobarView() {
          _ref1 = InfobarView.__super__.constructor.apply(this, arguments);
          return _ref1;
        }

        return InfobarView;

      })(App.Views.HubInfobarView);
      LinkbarView = (function(_super) {
        __extends(LinkbarView, _super);

        function LinkbarView() {
          _ref2 = LinkbarView.__super__.constructor.apply(this, arguments);
          return _ref2;
        }

        return LinkbarView;

      })(App.Views.HubLinkbarView);
      MainView = (function(_super) {
        __extends(MainView, _super);

        function MainView() {
          _ref3 = MainView.__super__.constructor.apply(this, arguments);
          return _ref3;
        }

        MainView.prototype.el = ".hub .main";

        MainView.prototype.type = 'main';

        MainView.prototype.InfobarView = InfobarView;

        MainView.prototype.LinkbarView = LinkbarView;

        MainView.prototype.initialize = function() {
          _.bindAll(this);
          return MainView.__super__.initialize.apply(this, arguments);
        };

        return MainView;

      })(App.Views.HubView);
      Main._init = _init = function(settings) {
        var $menuLinks, model;
        model = Main.model = new Model(settings.model);
        this.hubView = new MainView({
          model: model,
          linkbarCollection: new App.Collections.LinkbarCollection(settings.linkbarSettings.tabArray),
          el: '.hub'
        });
        $profile = $(".profile");
        $titlebar = $profile.find(".titlebar .ContentTitle span");
        $infoBar = $(".js-infobar");
        $projectBar = $(".js-projectbar");
        $menuBar = $(".js-profile-menu > div > div > ul");
        $contentArea = $(".js-profile-content");
        $contentToggleSpan = $(".js-content-toggle");
        $infoBarToggleSpan = $(".js-infobar-outer");
        $menuLinks = $menuBar.find('a');
      };
    }
  });

}).call(this);
/*!
* ACTIVITY
*/


(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.module("Activity", function(Activity, App, Backbone, Marionette) {
    var $contentArea, $contentToggleSpan, $infoBar, $infoBarToggleSpan, $infoBarToggler, $menuBar, $profile, $projectBar, $statusBox, $statusChanger, $statusIcon, ActivityView, InfobarView, LinkbarView, Model, cancelCopy, continueCopy, defaultFolders, getGroupingList, setCurrActivityType, setStatus, statusIcons, updateActivityList, updateAll, updateNoteCount, _ref, _ref1, _ref2, _ref3;
    this.startWithParent = false;
    $profile = null;
    $projectBar = null;
    $contentArea = null;
    $infoBar = null;
    $infoBarToggler = null;
    $contentToggleSpan = null;
    $infoBarToggleSpan = null;
    $statusChanger = null;
    $statusIcon = null;
    $statusBox = null;
    $menuBar = null;
    defaultFolders = null;
    statusIcons = {
      "0": "exclamation-circle",
      "1": "light-bulb",
      "2": "hourglass",
      "3": "light-bulb-off",
      "4": "cross"
    };
    Activity.on("before:start", function() {
      App.logInfo("starting: " + Activity.moduleName);
    });
    Activity.on("start", function(options) {
      $(document).ready(function() {
        Activity._init(options);
        return App.logInfo("started: " + Activity.moduleName);
      });
    });
    Activity.on("stop", function() {
      App.logInfo("stopped: " + Activity.moduleName);
    });
    Activity.on("status.changeStart", function(status) {
      App.logDebug("statusChange Started!");
      return $statusChanger.addClass('disabled');
    });
    Activity.on("status.changeEnd", function(status) {
      App.logDebug("statusChange Ended!");
      $statusChanger.removeClass('disabled');
      addMessage("Status changed successfully!", 250, 6000, 4000);
      $statusIcon.attr('class', '').addClass('fg-' + statusIcons[status]);
      return $statusBox.addClass('activity-status-' + status);
    });
    Model = (function(_super) {
      __extends(Model, _super);

      function Model() {
        _ref = Model.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      Model.prototype.url = '/api/activity/getActivity';

      return Model;

    })(Backbone.Model);
    InfobarView = (function(_super) {
      __extends(InfobarView, _super);

      function InfobarView() {
        _ref1 = InfobarView.__super__.constructor.apply(this, arguments);
        return _ref1;
      }

      return InfobarView;

    })(App.Views.HubInfobarView);
    LinkbarView = (function(_super) {
      __extends(LinkbarView, _super);

      function LinkbarView() {
        _ref2 = LinkbarView.__super__.constructor.apply(this, arguments);
        return _ref2;
      }

      return LinkbarView;

    })(App.Views.HubLinkbarView);
    ActivityView = (function(_super) {
      __extends(ActivityView, _super);

      function ActivityView() {
        _ref3 = ActivityView.__super__.constructor.apply(this, arguments);
        return _ref3;
      }

      ActivityView.prototype.el = ".hub .activity";

      ActivityView.prototype.type = 'activity';

      ActivityView.prototype.InfobarView = InfobarView;

      ActivityView.prototype.LinkbarView = LinkbarView;

      ActivityView.prototype.initialize = function() {
        _.bindAll(this);
        return ActivityView.__super__.initialize.apply(this, arguments);
      };

      return ActivityView;

    })(App.Views.HubView);
    Activity._init = function(settings) {
      var $menuLinks, model;
      model = new Model(settings.model);
      this.hubView = new ActivityView({
        model: model,
        linkbarCollection: new App.Collections.LinkbarCollection(settings.linkbarSettings.tabArray),
        el: '.hub'
      });
      Activity.data = settings;
      $profile = $(".profile");
      $infoBar = $(".js-infobar");
      $projectBar = $(".js-projectbar");
      $menuBar = $(".js-profile-menu > div > div > ul");
      $contentArea = $(".js-profile-content");
      $infoBarToggler = $(".js-toggle-infobar");
      $contentToggleSpan = $(".js-content-toggle");
      $infoBarToggleSpan = $(".js-infobar-outer");
      $menuLinks = $menuBar.find('a');
      $statusBox = $(".js-activity-status");
      $statusChanger = $statusBox.find('select');
      $statusIcon = $("<i></i>").addClass('fg-exclamation-circle');
      $statusBox.append($statusIcon);
      $statusChanger.change(function() {
        var nStatus;
        Activity.trigger('status.changeStart');
        nStatus = $(this).val();
        if (nStatus === "") {
          addError("You must select a status.", 250, 6000, 4000);
          return false;
        }
        setStatus(nStatus);
      });
      $statusIcon.attr('class', '').addClass('fg-' + statusIcons[$statusChanger.val()]);
      $("#ActivityList").dialog({
        title: "Activity List",
        modal: false,
        autoOpen: cActListOpen,
        height: cActListHeight,
        width: cActListWidth,
        position: [cActListPosX, cActListPosY],
        resizable: true,
        dragStop: function(ev, ui) {
          return $.post(sRootPath + "/_com/UserSettings.cfc", {
            method: "setActListPos",
            position: ui.position.left + "," + ui.position.top
          });
        },
        open: function() {
          updateActivityList();
          $("#ActivityList").show();
          $.post(sRootPath + "/_com/UserSettings.cfc", {
            method: "setActListOpen",
            IsOpen: "true"
          });
          return $("#ActivityDialogLink").fadeOut();
        },
        close: function() {
          $("#ActivityList").html("");
          $("#ActivityDialogLink").fadeIn();
          return $.post(sRootPath + "/_com/UserSettings.cfc", {
            method: "setActListOpen",
            IsOpen: "false"
          });
        },
        resizeStop: function(ev, ui) {
          return $.post(sRootPath + "/_com/UserSettings.cfc", {
            method: "setActListSize",
            Size: ui.size.width + "," + ui.size.height
          });
        }
      });
      $("#ActivityDialogLink").click(function() {
        return $("#ActivityList").dialog("open");
      });
      $("#MoveDialog").dialog({
        title: "Move Activity",
        modal: true,
        autoOpen: false,
        buttons: {
          Continue: function() {
            return $.post(sRootPath + "/_com/AJAX_Activity.cfc", {
              method: "Move",
              FromActivityID: nActivity,
              ToActivityID: $("#ToActivity").val()
            }, function(data) {
              return window.location = sMyself + "Activity.Detail?ActivityID=" + nActivity + "&Message=Activity successfully moved.";
            });
          },
          Cancel: function() {
            return $("#MoveDialog").dialog("close");
          }
        },
        height: 400,
        width: 500,
        resizable: false,
        draggable: false,
        open: function() {
          return $("#MoveDialog").show();
        },
        close: function() {}
      });
      $("#MoveLink").click(function() {
        return $("#MoveDialog").dialog("open");
      });
      $("#CopyDialog").dialog({
        title: "Copy & Paste Activity",
        modal: true,
        autoOpen: false,
        height: 535,
        width: 485,
        resizable: false,
        draggable: false,
        buttons: {
          Continue: function() {
            return continueCopy();
          },
          Cancel: function() {
            cancelCopy();
            return $("#CopyDialog").dialog("close");
          }
        },
        close: function() {
          return cancelCopy();
        }
      });
      $("#CopyLink").click(function() {
        setCurrActivityType(nActivityType);
        $("#CopyDialog").dialog("open");
        $("#NewActivityTitle").val("Copy of " + sActivityTitle);
        $("#NewActivityTitle").focus();
        return $("#NewActivityTitle").select();
      });
      $(".CopyChoice").change(function() {
        var sID;
        sID = $.Replace(this.id, "CopyChoice", "");
        if (sID === 2) {
          return $("#ParentActivityOptions").hide();
        } else {
          return $("#ParentActivityOptions").show();
        }
      });
      $("#NewActivityType").bind("change", this, function() {
        var nID;
        nID = $(this).val();
        if (nID !== "") {
          return getGroupingList(nID);
        } else {
          $("#NewGroupingSelect").hide();
          return $("#NewGrouping").val("");
        }
      });
      $("#OverviewList").dialog({
        title: "Activity Overview",
        modal: false,
        autoOpen: false,
        height: 550,
        width: 740,
        resizable: false,
        open: function() {
          return $.post(sMyself + "Activity.Overview", {
            ActivityID: nActivity
          }, function(data) {
            return $("#OverviewList").html(data);
          });
        },
        close: function() {
          $("#OverviewDialogLink").fadeIn();
          return $("#OverviewList").html("");
        },
        buttons: {
          Print: function() {
            return $("#OverviewList").printArea();
          },
          Close: function() {
            return $("#OverviewList").dialog("close");
          }
        }
      });
      $("#OverviewDialogLink").click(function() {
        return $("#OverviewList").dialog("open");
      });
      $("#DeleteActivityLink").bind("click", this, function() {
        var sReason;
        sReason = prompt("Do you really want to delete '" + sActivityTitle + "'?  What is the reason?", "");
        if ((sReason != null) && sReason !== "") {
          return $.getJSON(sRootPath + "/_com/AJAX_Activity.cfc", {
            method: "deleteActivity",
            ActivityID: nActivity,
            Reason: sReason,
            returnFormat: "plain"
          }, function(data) {
            if (data.STATUS) {
              return window.location = sMyself + "Activity.Home?Message=" + data.STATUSMSG;
            } else {
              return addError(data.STATUSMSG, 250, 6000, 4000);
            }
          });
        } else {
          return addError("Please provide a reason.", 250, 6000, 4000);
        }
      });
    };
    continueCopy = function() {
      var nCopyChoice, nCopyItems, nError, nNewActivityType, nNewGrouping, sNewActivityTitle;
      sNewActivityTitle = $("#NewActivityTitle").val();
      nNewActivityType = $("#NewActivityType").val();
      nNewGrouping = $("#NewGrouping").val();
      nCopyChoice = $(".CopyChoice:checked").val();
      nCopyItems = [];
      $('.CopyItems:checkbox:checked').map(function() {
        return nCopyItems.push(this.value);
      }).get();
      nError = 0;
      if (nNewActivityType === "" && nCopyChoice === 1) {
        addError("Please select an activity type.", 250, 6000, 4000);
        nError = nError + 1;
      }
      if (sNewActivityTitle === "") {
        addError("Please enter an activity title.", 250, 6000, 4000);
        nError = nError + 1;
      }
      if (nError > 0) {
        return false;
      }
      if (nNewGrouping === "") {
        nNewGrouping = 0;
      }
      $.getJSON(sRootPath + "/_com/AJAX_Activity.cfc", {
        method: "CopyPaste",
        Mode: nCopyChoice,
        ItemsToCopy: nCopyItems.join(),
        NewActivityTitle: sNewActivityTitle,
        NewActivityTypeID: nNewActivityType,
        NewGroupingID: nNewGrouping,
        ActivityID: nActivity,
        ReturnFormat: "plain"
      }, function(data) {
        if (data.STATUS) {
          return window.location = sMyself + "Activity.Detail?ActivityID=" + data.DATASET[0].activityid + "&Message=" + data.STATUSMSG;
        } else {
          return addError(data.STATUSMSG, 250, 6000, 4000);
        }
      });
    };
    cancelCopy = function() {};
    setCurrActivityType = function(nID) {
      $("#NewActivityType").val(nID);
      getGroupingList(nID);
    };
    getGroupingList = function(nID) {
      $("#NewGrouping").removeOption("");
      $("#NewGrouping").removeOption(/./);
      $("#NewGrouping").ajaxAddOption(sRootPath + "/_com/AJAX_Activity.cfc", {
        method: "getGroupings",
        ATID: nID,
        returnFormat: "plain"
      }, false, function(data) {
        if ($("#NewGrouping").val() !== "") {
          $("#NewGrouping").val(nGrouping);
          return $("#NewGroupingSelect").show();
        } else {
          $("#NewGrouping").val(0);
          return $("#NewGroupingSelect").hide();
        }
      });
    };
    setStatus = Activity.setStatus = function(status) {
      $.ajax({
        url: sRootPath + "/_com/AJAX_Activity.cfc",
        type: 'post',
        data: {
          method: "updateActivityStatus",
          ActivityID: nActivity,
          StatusID: status,
          returnFormat: "plain"
        },
        success: function(data) {
          var cleanData;
          cleanData = $.trim(data);
          Activity.trigger('status.changeEnd', status);
        }
      });
    };
    updateAll = Activity.updateAll = function() {
      Activity.Stats.refresh(function() {});
      Activity.Folders.refresh(function() {});
      updateActivityList();
    };
    updateActivityList = Activity.updateActivityList = function() {
      $.post(sMyself + "Activity.ActivityList", {
        ActivityID: nActivity
      }, function(data) {
        return $("#ActivityList").html(data);
      });
    };
    updateNoteCount = Activity.updateNoteCount = function() {
      $.post(sRootPath + "/_com/AJAX_Activity.cfc", {
        method: "getNoteCount",
        ActivityID: nActivity,
        returnFormat: "plain"
      }, function(data) {
        var nNoteCount;
        nNoteCount = $.ListGetAt($.Trim(data), 1, ".");
        return $("#NoteCount").html("(" + nNoteCount + ")");
      });
    };
  });

}).call(this);
/*!
* PERSON
*/


(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.module("Person", function(Person, App, Backbone, Marionette) {
    var $contentArea, $contentToggleSpan, $infoBar, $infoBarToggleSpan, $infoBarToggler, $menuBar, $profile, $projectBar, $statusBox, $statusChanger, $statusIcon, InfobarView, LinkbarView, Model, PersonView, cShowInfobar, defaultFolders, setStatus, statusIcons, updateAccountID, updateActions, updateAll, _init, _ref, _ref1, _ref2, _ref3;
    this.startWithParent = false;
    cShowInfobar = null;
    $profile = null;
    $projectBar = null;
    $contentArea = null;
    $infoBar = null;
    $infoBarToggler = null;
    $contentToggleSpan = null;
    $infoBarToggleSpan = null;
    $statusChanger = null;
    $statusIcon = null;
    $statusBox = null;
    $menuBar = null;
    defaultFolders = null;
    statusIcons = {
      "0": "exclamation-circle",
      "1": "light-bulb",
      "2": "hourglass",
      "3": "light-bulb-off",
      "4": "cross"
    };
    Person.on("before:start", function() {
      App.logInfo("starting: " + Person.moduleName);
    });
    Person.on("start", function(options) {
      $(document).ready(function() {
        _init(options);
        return App.logInfo("started: " + Person.moduleName);
      });
    });
    Person.on("stop", function() {
      App.logInfo("stopped: " + Person.moduleName);
    });
    Person.on("status.changeStart", function(status) {
      $statusChanger.addClass('disabled');
    });
    Person.on("status.changeEnd", function(status) {
      $statusChanger.removeClass('disabled');
      addMessage("Status changed successfully!", 250, 6000, 4000);
      $statusIcon.attr('class', '').addClass('fg-' + statusIcons[status]);
      return $statusBox.addClass('activity-status-' + status);
    });
    Model = (function(_super) {
      __extends(Model, _super);

      function Model() {
        _ref = Model.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      Model.prototype.url = '/api/person/getPerson';

      return Model;

    })(Backbone.Model);
    InfobarView = (function(_super) {
      __extends(InfobarView, _super);

      function InfobarView() {
        _ref1 = InfobarView.__super__.constructor.apply(this, arguments);
        return _ref1;
      }

      return InfobarView;

    })(App.Views.HubInfobarView);
    LinkbarView = (function(_super) {
      __extends(LinkbarView, _super);

      function LinkbarView() {
        _ref2 = LinkbarView.__super__.constructor.apply(this, arguments);
        return _ref2;
      }

      return LinkbarView;

    })(App.Views.HubLinkbarView);
    PersonView = (function(_super) {
      __extends(PersonView, _super);

      function PersonView() {
        _ref3 = PersonView.__super__.constructor.apply(this, arguments);
        return _ref3;
      }

      PersonView.prototype.el = ".hub .person";

      PersonView.prototype.InfobarView = InfobarView;

      PersonView.prototype.LinkbarView = LinkbarView;

      PersonView.prototype.type = 'person';

      PersonView.prototype.initialize = function() {
        return PersonView.__super__.initialize.apply(this, arguments);
      };

      return PersonView;

    })(App.Views.HubView);
    Person._init = _init = function(settings) {
      var $menuLinks;
      Person.model = new Model(settings.model);
      this.hubView = new PersonView({
        model: Person.model,
        linkbarCollection: new App.Collections.LinkbarCollection(settings.linkbarSettings.tabArray),
        el: '.hub'
      });
      $profile = $(".profile");
      $infoBar = $(".js-infobar");
      $projectBar = $(".js-projectbar");
      $menuBar = $(".js-profile-menu > div > div > ul");
      $contentArea = $(".js-profile-content");
      $contentToggleSpan = $(".js-content-toggle");
      $menuLinks = $menuBar.find('a');
      $statusBox = $(".js-activity-status");
      $statusChanger = $statusBox.find('select');
      $statusIcon = $("<i></i>").addClass('fg-exclamation-circle');
      $statusBox.append($statusIcon);
      $statusChanger.change(function() {
        var nStatus;
        Person.trigger('status.changeStart');
        nStatus = $(this).val();
        if (nStatus === "") {
          addError("You must select a status.", 250, 6000, 4000);
          return false;
        }
        setStatus(nStatus);
      });
      $statusIcon.attr('class', '').addClass('fg-' + statusIcons[$statusChanger.val()]);
      updateAll();
      $("#AuthLevel").change(function() {
        return $.getJSON(sRootPath + "/_com/AJAX_Person.cfc", {
          method: "setAuthLevel",
          AccountID: nAccount,
          AuthorityID: $(this).val(),
          returnFormat: "plain"
        }, function(data) {
          if (data.STATUS) {
            return addMessage(data.STATUSMSG, 250, 6000, 4000);
          } else {
            return addError(data.STATUSMSG, 250, 6000, 4000);
          }
        });
      });
      $("#StatusChanger").change(function() {
        return $.getJSON(sRootPath + "/_com/AJAX_Person.cfc", {
          method: "setStatus",
          PersonID: nPerson,
          StatusID: $(this).val(),
          returnFormat: "plain"
        }, function(data) {
          if (data.STATUS) {
            return addMessage(data.STATUSMSG, 250, 6000, 4000);
          } else {
            return addError(data.STATUSMSG, 250, 6000, 4000);
          }
        });
      });
      $("#CredentialsContainer").dialog({
        title: "Credentials",
        modal: false,
        autoOpen: false,
        height: 325,
        width: 450,
        resizable: false,
        draggable: false,
        buttons: {
          Save: function() {
            var sConPass, sPass;
            sPass = $("#NewPassword").val();
            sConPass = $("#ConfirmPassword").val();
            return $.getJSON(sRootPath + "/_com/AJAX_Person.cfc", {
              method: "saveCredentials",
              PersonID: nPerson,
              Pass: sPass,
              ConPass: sConPass
            }, function(data) {
              if (data.STATUS) {
                addMessage(data.STATUSMSG, 250, 6000, 4000);
                $("#CredentialsContainer").dialog("close");
                $("#NewPassword").val("");
                return $("#ConfirmPassword").val("");
              } else {
                if ($.ArrayLen(data.ERRORS) > 0) {
                  return $.each(data.ERRORS, function(i, item) {
                    return addError(item.MESSAGE, 250, 6000, 4000);
                  });
                } else {
                  return addError(data.STATUSMSG, 250, 6000, 4000);
                }
              }
            });
          },
          Close: function() {
            $("#CredentialsContainer").dialog("close");
            return $("#CredentialsContainer").html("");
          }
        },
        open: function() {
          $.post(sMyPerson + "Person.Credentials", {
            PersonID: nPerson
          }, function(data) {
            return $("#CredentialsContainer").html(data);
          });
          return $("#CredentialsDialogLink").fadeOut();
        },
        close: function() {
          return $("#CredentialsDialogLink").fadeIn();
        }
      });
      $("#CredentialsDialogLink").click(function() {
        return $("#CredentialsContainer").dialog("open");
      });
      $("#DeletePersonLink").click(function() {
        var sReason;
        sReason = prompt("Do you really want to delete " + sPersonName + "?  What is the reason?", "");
        if ((sReason != null) && sReason !== "") {
          $.getJSON(sRootPath + "/_com/AJAX_Person.cfc", {
            method: "deletePerson",
            PersonID: nPerson,
            Reason: sReason,
            returnFormat: "plain"
          }, function(data) {
            if (data.STATUS) {
              return window.location = sMyPerson + "Person.Home?Message=" + data.STATUSMSG;
            } else {
              return addError(data.STATUSMSG, 250, 6000, 4000);
            }
          });
        } else {
          addError("Please provide a reason.", 250, 6000, 4000);
        }
      });
    };
    setStatus = Person.setStatus = function(status) {
      $.ajax({
        url: sRootPath + "/_com/AJAX_Activity.cfc",
        type: 'post',
        data: {
          method: "updateActivityStatus",
          ActivityID: nActivity,
          StatusID: status,
          returnFormat: "plain"
        },
        success: function(data) {
          var cleanData;
          cleanData = $.trim(data);
          Person.trigger('status.changeEnd', status);
        }
      });
    };
    updateAll = function() {};
    updateActions = function() {};
    updateAccountID = function(sAccountID) {
      $("#AccountID").html(sAccountID);
    };
  });

}).call(this);
/*
* ACTIVITY > SEARCH
*/


(function() {
  App.module("User.ActivitySearch", function(Self, App, Backbone, Marionette, $) {
    var $activityType, $base, $grouping, $releaseDate, $title, setActivityType, _init;
    this.startWithParent = false;
    Self = this;
    $base = null;
    this.search = null;
    $releaseDate = null;
    $title = null;
    $activityType = null;
    $grouping = null;
    this.on("before:start", function() {
      App.logInfo("starting: Activity." + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: Activity." + Self.moduleName);
      });
    });
    this.on("stop", function() {
      App.logInfo("stopped: Activity." + Self.moduleName);
    });
    _init = function(settings) {
      var $category, searchSettings;
      searchSettings = settings;
      Self.search = new App.Components.Search({
        el: "#js-main-activities"
      });
      $base = Self.search.$base;
      $releaseDate = $base.find("#ReleaseDate");
      $title = $base.find("#Title");
      $activityType = $base.find("#ActivityTypeID");
      $grouping = $base.find("#Grouping");
      $category = $base.find("#CategoryID");
      $category.combobox();
      $releaseDate.mask("99/99/9999");
      $title.unbind("keydown");
      $title.focus();
      setActivityType(parseInt($activityType.val()));
      $activityType.on("change", function() {
        return setActivityType(parseInt($(this).val()));
      });
    };
    return setActivityType = function(nActivityType) {
      if (nActivityType === 1) {
        console.log(searchSettings.liveOptions);
        $grouping.html(searchSettings.liveOptions);
        return $grouping.attr("disabled", false);
      } else if (nActivityType === 2) {
        console.log(searchSettings.emOptions);
        $grouping.html(searchSettings.emOptions);
        return $grouping.attr("disabled", false);
      } else {
        console.log(searchSettings.noOptions);
        $grouping.html(searchSettings.noOptions);
        return $grouping.attr("disabled", true);
      }
    };
  });

}).call(this);
/*!
* USER > NEWSFEED
*/


(function() {
  App.module("User.NewsFeed", function(Self, App, Backbone, Marionette, $) {
    var getListAuto, repeater, _init;
    this.startWithParent = false;
    Self = this;
    getListAuto = null;
    repeater = null;
    this.on("before:start", function() {
      App.logInfo("starting: User." + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: User." + Self.moduleName);
      });
    });
    this.on("stop", function() {
      clearInterval(repeater);
      Self.feed = null;
      App.logInfo("stopped: User." + Self.moduleName);
    });
    return _init = function() {
      Self.feed = new App.Components.NewsFeed({
        el: '#js-main-welcome .js-newsfeed',
        defaultMode: 'personTo',
        hub: 'main',
        modes: ["personTo", "personFrom"],
        queryParams: {
          personTo: App.Main.model.get('id'),
          personFrom: App.Main.model.get('id')
        }
      });
      getListAuto = Self.getListAuto = function() {
        var currTime;
        currTime = Math.round(new Date().getTime() / 1000);
        return Self.feed.lister.getList(false, currTime, 'prepend');
      };
      repeater = setInterval("App.User.NewsFeed.getListAuto()", 5000);
    };
  });

}).call(this);
/*!
* PERSON > SEARCH
*/


(function() {
  App.module("User.PersonSearch", function(Self, App, Backbone, Marionette, $) {
    var _init;
    this.startWithParent = false;
    this.on("before:start", function() {
      App.logInfo("starting: Person." + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: Person." + Self.moduleName);
      });
    });
    this.on("stop", function() {
      App.logInfo("stopped: Person." + Self.moduleName);
    });
    return _init = function(defaults) {};
  });

}).call(this);
/*!
* ACTIVITY > ACCME
*/


(function() {
  App.module("Activity.ACCME", function(Self, App, Backbone, Marionette, $) {
    var _init;
    this.startWithParent = false;
    this.on("before:start", function() {
      App.logInfo("starting: " + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: " + Self.moduleName);
      });
    });
    this.on("stop", function() {
      App.logInfo("stopped: " + Self.moduleName);
    });
    return _init = function(defaults) {
      var FormState;
      return FormState = new App.Components.FormState({
        el: '#js-activity-accme .js-formstate',
        saved: true
      });
    };
  });

}).call(this);
/*!
* ACTIVITY > AGENDA
*/


(function() {
  App.module("Activity.Agenda", function(Self, App, Backbone, Marionette, $) {
    var _init;
    this.startWithParent = false;
    this.on("before:start", function() {
      App.logInfo("starting: " + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: " + Self.moduleName);
      });
    });
    this.on("stop", function() {
      App.logInfo("stopped: " + Self.moduleName);
    });
    return _init = function(defaults) {};
  });

}).call(this);
/*!
* ACTIVITY > CHECKLIST
*/


(function() {
  App.module("Activity.Checklist", function(Self, App, Backbone, Marionette, $) {
    var _init;
    this.startWithParent = false;
    this.on("before:start", function() {
      App.logInfo("starting: " + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: " + Self.moduleName);
      });
    });
    this.on("stop", function() {
      App.logInfo("stopped: " + Self.moduleName);
    });
    return _init = function(defaults) {};
  });

}).call(this);
/*
* ACTIVITY > COMMITTEE
*/


(function() {
  App.module("Activity.Committee", function(Self, App, Backbone, Marionette, $) {
    var $container, $loading, addSelected, clearSelected, getSelected, refresh, removeSelected, saveCommitteeMember, selected, selectedCount, setRole, updateSelectedCount, _init;
    this.startWithParent = false;
    Self.el = {};
    $container = Self.el.$container = null;
    $loading = Self.el.$loading = null;
    selectedCount = 0;
    selected = "";
    this.on("before:start", function() {
      App.logInfo("starting: " + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: " + Self.moduleName);
      });
    });
    this.on("stop", function() {
      Self.Ahah.stop();
      App.logInfo("stopped: " + Self.moduleName);
    });
    this.on("refreshStart", function() {
      Self.Ahah.stop();
    });
    this.on("refreshEnd", function() {
      Self.Ahah.start();
    });
    updateSelectedCount = Self.updateSelectedCount = function(nAmount) {
      App.logInfo("Count is currently " + parseInt(selectedCount));
      App.logInfo("Updating Count by " + parseInt(nAmount));
      selectedCount = parseInt(selectedCount) + parseInt(nAmount);
      if (selectedCount < 0) {
        selectedCount = 0;
      }
      App.logInfo("Count is now " + selectedCount);
      $("#CheckedCount,.js-status-selected-count").html("" + selectedCount + "");
      if (selectedCount > 0) {
        $(".js-selected-actions").find(".btn").removeClass("disabled");
      } else {
        $(".js-selected-actions").find(".btn").addClass("disabled");
      }
    };
    clearSelected = function() {
      selected = "";
      updateSelectedCount(selectedCount * -1);
      $(".js-status-selected-count").html("0");
    };
    getSelected = Self.getSelected = function() {
      return selected.split(',');
    };
    addSelected = Self.addSelected = function(params) {
      var settings;
      settings = $.extend({}, params);
      if (settings.person && settings.person > 0) {
        if (!$.ListFind(selected, settings.person, ",")) {
          selected = $.ListAppend(selected, settings.person, ",");
          updateSelectedCount(1);
        }
      }
      App.logDebug(selected);
    };
    removeSelected = Self.removeSelected = function(params) {
      var settings;
      settings = $.extend({}, params);
      if (settings.person && settings.person > 0) {
        if ($.ListFind(selected, settings.person, ",")) {
          if (settings.person && settings.person > 0) {
            selected = $.ListDeleteAt(selected, $.ListFind(selected, settings.person));
          }
          updateSelectedCount(-1);
        }
      }
      App.logDebug(selected);
    };
    setRole = Self.setRole = function(persons, role) {
      $.ajax({
        url: sRootPath + "/_com/AJAX_Activity.cfc",
        type: 'post',
        dataType: 'json',
        data: {
          method: "changeCommitteeRoles",
          PersonList: persons,
          ActivityID: nActivity,
          RoleID: role,
          returnFormat: "plain"
        },
        success: function(data) {
          if (data.STATUS) {
            addMessage(data.STATUSMSG, 250, 6000, 4000);
          } else {
            addError(data.STATUSMSG, 250, 6000, 4000);
          }
          return refresh();
        }
      });
    };
    refresh = Self.refresh = function() {
      Self.trigger('refreshStart');
      $.ajax({
        url: sMyself + "Activity.CommitteeAHAH",
        type: 'get',
        data: {
          ActivityID: nActivity
        },
        success: function(data) {
          var setDefaults;
          Self.el.$container.html(data);
          Self.el.$loading.hide();
          setDefaults = function() {
            $(".js-status-selected-count").text(selectedCount);
            if (selectedCount && selectedCount > 0) {
              $(".js-selected-actions .btn").removeClass('disabled');
            }
            return $(".js-select-all-rows").each(function() {
              var $checkBox, $row, nPerson;
              $row = $(this);
              $checkBox = $row.find(".MemberCheckbox");
              nPerson = $row.data('key');
              if ($.ListFind(selected, nPerson)) {
                return $checkBox.attr('checked', true);
              }
            });
          };
          setDefaults();
          Self.trigger('refreshEnd');
        }
      });
    };
    saveCommitteeMember = Self.save = function() {
      var nCommittee;
      nCommittee = $("#CommitteeID").val();
      $.ajax({
        url: sRootPath + "/_com/AJAX_Activity.cfc",
        type: 'post',
        data: {
          method: "saveCommitteeMember",
          PersonID: nCommittee,
          ActivityID: nActivity,
          returnFormat: "plain"
        },
        success: function(returnData) {
          var cleanData, status, statusMsg;
          cleanData = $.trim(returnData);
          status = $.ListGetAt(cleanData, 1, "|");
          statusMsg = $.ListGetAt(cleanData, 2, "|");
          if (status === 'Success') {
            setRole(nCommittee, 1);
            refresh();
            $("#PersonWindowCommittee").dialog("close");
            addMessage(statusMsg, 250, 6000, 4000);
          } else if (status === 'Fail') {
            refresh();
            $("#PersonWindowCommittee").dialog("close");
            addError(statusMsg, 250, 6000, 4000);
          }
        }
      });
      $("#PersonActivityID").val('');
    };
    return _init = function(defaults) {
      Self.el.$container = $container = $("#CommitteeContainer");
      Self.el.$loading = $loading = $("#CommitteeLoading");
      refresh();
      $("#CommitteeList").ajaxForm();
      $("#RemoveChecked").on("click", function() {
        var cleanData, result;
        if (confirm("Are you sure you want to remove the checked people from this Activity?")) {
          result = "";
          cleanData = "";
          $(".MemberCheckbox:checked").each(function() {
            result = $.ListAppend(result, $(this).val(), ",");
          });
          return $.ajax({
            url: sRootPath + "/_com/AJAX_Activity.cfc",
            dataType: 'json',
            data: {
              method: "removeCheckedCommittee",
              PersonList: result,
              ActivityID: nActivity,
              returnFormat: "plain"
            },
            success: function(data) {
              if (data.STATUS) {
                clearSelected();
                addMessage(data.STATUSMSG, 250, 6000, 4000);
              } else {
                addError(data.STATUSMSG, 250, 6000, 4000);
              }
              refresh();
            }
          });
        }
      });
      $("#RemoveAll").on("click", function() {
        var cleanData;
        if (confirm("WARNING!\nYou are about to remove ALL people from this Activity!\nAre you sure you wish to continue?")) {
          cleanData = "";
          return $.getJSON(sRootPath + "/_com/AJAX_Activity.cfc", {
            method: "removeAllCommittee",
            ActivityID: nActivity,
            returnFormat: "plain"
          }, function(data) {
            if (data.STATUS) {
              addMessage(data.STATUSMSG, 250, 6000, 4000);
            } else {
              addError(data.STATUSMSG, 250, 6000, 4000);
            }
            return refresh();
          });
        }
      });
      $(".js-change-type").on("click", function(e) {
        var nActivityRole, result;
        nActivityRole = $(this).data('roleid');
        result = "";
        $(".MemberCheckbox:checked").each(function() {
          result = $.ListAppend(result, $(this).val(), ",");
        });
        setRole(result, nActivityRole);
        e.preventDefault();
      });
    };
  });

}).call(this);
/*
* ACTIVITY > COMMITTEE > AHAH
*/


(function() {
  App.module("Activity.Committee.Ahah", function(Self, App, Backbone, Marionette, $) {
    var CurrPersonID, Parent, nPersonID, sPersonName, _destroy, _init;
    this.startWithParent = false;
    Parent = App.Activity.Committee;
    nPersonID = null;
    sPersonName = null;
    this.on("before:start", function() {
      App.logInfo("starting: Activity.Committee." + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: Activity.Committee." + Self.moduleName);
      });
    });
    this.on("stop", function() {
      $("#CommitteeContainer").empty();
      App.logInfo("stopped: Activity.Committee." + Self.moduleName);
    });
    CurrPersonID = null;
    _destroy = function() {};
    return _init = function(defaults) {
      var $selectAll, $selectOne;
      $selectAll = $("#CommitteeContainer").find(".js-select-all");
      $selectOne = $("#CommitteeContainer").find(".js-select-one");
      $selectAll.on("click", function() {
        App.logDebug("selectAll Clicked");
        if ($selectAll.attr("checked")) {
          $selectOne.each(function() {
            $(this).attr("checked", true);
            nPersonID = $.Replace(this.id, "Checked", "", "ALL");
            Parent.addSelected({
              person: nPersonID
            });
            return $(".js-select-all-rows").find('td').css("background-color", "#FFD");
          });
        } else {
          $selectOne.each(function() {
            $(this).attr("checked", false);
            nPersonID = $.Replace(this.id, "Checked", "", "ALL");
            Parent.removeSelected({
              person: nPersonID
            });
            return $(".js-select-all-rows").find('td').css("background-color", "#FFF");
          });
        }
      });
      $selectOne.on("click", function() {
        App.logDebug("selectOne Clicked");
        if ($(this).attr("checked")) {
          nPersonID = $.Replace(this.id, "Checked", "", "ALL");
          Parent.addSelected({
            person: nPersonID
          });
          $("#PersonRow" + nPersonID).find('td').css("background-color", "#FFD");
        } else {
          nPersonID = $.Replace(this.id, "Checked", "", "ALL");
          Parent.removeSelected({
            person: nPersonID
          });
          $("#PersonRow" + nPersonID).find('td').css("background-color", "#FFF");
        }
      });
      $("#PersonDetail").dialog({
        title: "Person Detail",
        modal: true,
        autoOpen: false,
        height: 550,
        maxWidth: 855,
        resizable: false,
        dragStop: function(ev, ui) {},
        open: function() {
          $(this).find('iframe').attr("src", sMyself + "Person.Detail?PersonID=" + nPersonID + "&Mini=1");
        },
        close: function() {},
        resizeStop: function(ev, ui) {}
      });
      $(".PersonLink").on("click", function(e) {
        var $row;
        $row = $(this).parents('.js-row');
        nPersonID = $row.data('key');
        sPersonName = $row.data('name');
        $("#PersonDetail").dialog("open", e.preventDefault());
        return false;
      });
    };
  });

}).call(this);
/*
* ACTIVITY > CREATE FORM
*/


(function() {
  App.module("Activity.Create", function(Self, App, Backbone, Marionette, $) {
    var FormState, setActivityType, setSessionType, updateStateProvince, _init;
    this.startWithParent = false;
    FormState = null;
    this.on("before:start", function() {
      App.logInfo("starting: " + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: " + Self.moduleName);
      });
    });
    this.on("stop", function() {
      App.logInfo("stopped: " + Self.moduleName);
      FormState = null;
    });
    updateStateProvince = function(countryId) {
      if (parseInt(countryId) === 230) {
        $(".stateField").show();
        return $(".provinceField").hide();
      } else {
        $(".stateField").hide().css({
          display: "none"
        });
        return $(".provinceField").show();
      }
    };
    setSessionType = function(sSessionType) {
      if (sSessionType === "M") {
        $(".Sessions").fadeIn();
        return $(".SingleSession").fadeOut();
      } else {
        $(".Sessions").fadeOut();
        return $(".SingleSession").fadeIn();
      }
    };
    setActivityType = function(nActivityType) {
      if (parseInt(nActivityType) === 1) {
        $("#Grouping").html(LiveOptions);
        $("#Groupings").show();
        $(".Location").show();
      } else if (parseInt(nActivityType) === 2) {
        $("#Groupings").show();
        $("#Grouping").html(EMOptions);
      } else {
        $("#Groupings").hide();
        $("#Grouping").html("");
        $(".Location").hide();
      }
      return updateStateProvince(parseInt($("#Country").val()));
    };
    return _init = function() {
      console.log('in');
      FormState = new App.Components.FormState({
        el: '#js-activity-detail .js-formstate',
        saved: true
      });
      updateStateProvince(nCountryId);
      $("#Country").change(function() {
        updateStateProvince(parseInt($(this).val()));
      });
      $("#ActivityType").bind("change", this, function() {
        return setActivityType(parseInt($(this).val()));
      });
      $("#SessionType").change(function() {
        return setSessionType($(this).val());
      });
      if (!!nActivityType) {
        $("#ActivityType").val(parseInt(nActivityType));
        setActivityType(parseInt(nActivityType));
        if (nGrouping) {
          $("#Grouping").val(parseInt(nGrouping));
        }
      }
      if (!!sSessionType) {
        $("#SessionType").val(sSessionType);
        setSessionType(sSessionType);
      }
      if ($("#Sponsorship").val() === "J") {
        $(".js-sponsorship-J").addClass("active");
        $("#JointlyTextFld").removeClass("hide");
      } else {
        $(".js-sponsorship-D").addClass("active");
        $("#JointlyTextFld").addClass("hide");
      }
      $(".js-sponsorship-toggle").bind("click", function(e) {
        var $this;
        $this = $(this);
        if ($this.hasClass("js-sponsorship-J")) {
          FormState.Unsaved();
          FormState.AddChange("Sponsorship", "J");
          FormState.AddChange("Sponsor", $("#Sponsor").val());
          $("#Sponsorship").val("J");
          $("#JointlyTextFld").removeClass("hide");
        } else {
          FormState.Unsaved();
          FormState.AddChange("Sponsorship", "D");
          $("#Sponsorship").val("D");
          $("#JointlyTextFld").addClass("hide");
        }
        e.preventDefault();
      });
    };
  });

}).call(this);
/*!
* ACTIVITY > CREDITS
*/


(function() {
  App.module("Activity.Credits", function(Self, App, Backbone, Marionette, $) {
    var $form, $saveButton, _init;
    this.startWithParent = false;
    this.on("before:start", function() {
      App.logInfo("starting: " + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: " + Self.moduleName);
      });
    });
    this.on("stop", function() {
      App.logInfo("stopped: " + Self.moduleName);
    });
    $saveButton = null;
    $form = null;
    return _init = function(defaults) {
      App.logInfo("init: credits");
      $form = $(".js-form-credits");
      $saveButton = $(".js-credits-save");
      $saveButton.click(function() {
        $form.submit();
        return false;
      });
      $form.submit(function() {
        $(this).ajaxSubmit({
          type: "get",
          dataType: 'json',
          beforeSubmit: function() {
            $saveButton.text("Saving...").attr("disabled", true);
          },
          success: function(responseText, statusText) {
            var d;
            d = new Date();
            if (responseText.STATUS) {
              $saveButton.text("Save Credits").attr("disabled", false);
              addMessage("Saved credits successfully.", 250, 2000, 2000);
            } else {
              $.each(responseText.ERRORS, function(i, item) {
                return addError(item.MESSAGE, 250, 6000, 4000);
              });
              $saveButton.text("Save Now").attr("disabled", false);
            }
          }
        });
        return false;
      });
      $(".CreditBox").each(function() {
        var nCreditID;
        nCreditID = $.Replace(this.id, "Credits", "", "ALL");
        if ($(this).attr("checked")) {
          $("#CreditAmount" + nCreditID).attr("disabled", false);
          return $("#ReferenceNo" + nCreditID).attr("disabled", false);
        } else {
          $("#CreditAmount" + nCreditID).attr("disabled", true);
          return $("#ReferenceNo" + nCreditID).attr("disabled", true);
        }
      });
      return $(".CreditBox").click(function() {
        var nCreditID;
        nCreditID = $.Replace(this.id, "Credits", "", "ALL");
        if ($(this).attr("checked")) {
          $("#CreditAmount" + nCreditID).attr("disabled", false);
          return $("#ReferenceNo" + nCreditID).attr("disabled", false);
        } else {
          $("#CreditAmount" + nCreditID).attr("disabled", true);
          return $("#ReferenceNo" + nCreditID).attr("disabled", true);
        }
      });
    };
  });

}).call(this);
/*
* ACTIVITY > FACULTY
*/


(function() {
  App.module("Activity.Faculty", function(Self, App, Backbone, Marionette, $) {
    var $container, $loading, addSelected, clearSelected, getSelected, refresh, removeSelected, saveFacultyMember, selected, selectedCount, setFacultyRole, updateSelectedCount, _init;
    this.startWithParent = false;
    Self.el = {};
    $container = Self.el.$container = null;
    $loading = Self.el.$loading = null;
    selectedCount = 0;
    selected = "";
    this.on("before:start", function() {
      App.logInfo("starting: " + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: " + Self.moduleName);
      });
    });
    this.on("stop", function() {
      Self.Ahah.stop();
      App.logInfo("stopped: " + Self.moduleName);
    });
    this.on("refreshStart", function() {
      Self.Ahah.stop();
    });
    this.on("refreshEnd", function() {
      Self.Ahah.start();
    });
    updateSelectedCount = Self.updateSelectedCount = function(nAmount) {
      App.logInfo("Count is currently " + parseInt(selectedCount));
      App.logInfo("Updating Count by " + parseInt(nAmount));
      selectedCount = parseInt(selectedCount) + parseInt(nAmount);
      if (selectedCount < 0) {
        selectedCount = 0;
      }
      App.logInfo("Count is now " + selectedCount);
      $("#CheckedCount,.js-status-selected-count").html("" + selectedCount + "");
      if (selectedCount > 0) {
        $(".js-selected-actions").find(".btn").removeClass("disabled");
      } else {
        $(".js-selected-actions").find(".btn").addClass("disabled");
      }
    };
    clearSelected = function() {
      selected = "";
      updateSelectedCount(selectedCount * -1);
      $(".js-status-selected-count").html("0");
    };
    getSelected = Self.getSelected = function() {
      return selected.split(',');
    };
    addSelected = Self.addSelected = function(params) {
      var settings;
      settings = $.extend({}, params);
      if (!(settings.person && settings.person > 0 ? $.ListFind(selected, settings.person, ",") : void 0)) {
        selected = $.ListAppend(selected, settings.person, ",");
      }
      updateSelectedCount(1);
    };
    removeSelected = Self.removeSelected = function(params) {
      var settings;
      settings = $.extend({}, params);
      if (settings.person && settings.person > 0) {
        selected = $.ListDeleteAt(selected, $.ListFind(selected, settings.person));
      }
      updateSelectedCount(-1);
    };
    setFacultyRole = Self.setFacultyRole = function(persons, role) {
      return $.ajax({
        url: sRootPath + "/_com/AJAX_Activity.cfc",
        type: 'post',
        dataType: 'json',
        data: {
          method: "changeFacultyRoles",
          PersonList: persons,
          ActivityID: nActivity,
          RoleID: role,
          returnFormat: "plain"
        },
        success: function(data) {
          if (data.STATUS) {
            addMessage(data.STATUSMSG, 250, 6000, 4000);
            refresh();
          } else {
            addError(data.STATUSMSG, 250, 6000, 4000);
          }
        }
      });
    };
    _init = function(defaults) {
      Self.el.$container = $container = $("#FacultyContainer");
      Self.el.$loading = $loading = $("#FacultyLoading");
      refresh();
      $("#FacultyList").ajaxForm();
      $("#RemoveChecked").on("click", function() {
        var cleanData, result;
        if (confirm("Are you sure you want to remove the checked people from this Activity?")) {
          result = "";
          cleanData = "";
          $(".MemberCheckbox:checked").each(function() {
            result = $.ListAppend(result, $(this).val(), ",");
          });
          return $.ajax({
            url: sRootPath + "/_com/AJAX_Activity.cfc",
            dataType: 'json',
            data: {
              method: "removeCheckedFaculty",
              PersonList: result,
              ActivityID: nActivity,
              returnFormat: "plain"
            },
            success: function(data) {
              if (data.STATUS) {
                clearSelected();
                addMessage(data.STATUSMSG, 250, 6000, 4000);
              } else {
                addError(data.STATUSMSG, 250, 6000, 4000);
              }
              refresh();
            }
          });
        }
      });
      $("#RemoveAll").on("click", function() {
        var cleanData;
        if (confirm("WARNING!\nYou are about to remove ALL people from this Activity!\nAre you sure you wish to continue?")) {
          cleanData = "";
          return $.getJSON(sRootPath + "/_com/AJAX_Activity.cfc", {
            method: "removeAllFaculty",
            ActivityID: nActivity,
            returnFormat: "plain"
          }, function(data) {
            if (data.STATUS) {
              addMessage(data.STATUSMSG, 250, 6000, 4000);
            } else {
              addError(data.STATUSMSG, 250, 6000, 4000);
            }
            return refresh();
          });
        }
      });
      return $(".js-change-type").on("click", function(e) {
        var nActivityRole, result;
        nActivityRole = $(this).data('roleid');
        result = "";
        $(".MemberCheckbox:checked").each(function() {
          result = $.ListAppend(result, $(this).val(), ",");
        });
        setFacultyRole(result, nActivityRole);
        e.preventDefault();
      });
    };
    saveFacultyMember = Self.save = function() {
      var nFaculty;
      nFaculty = $("#FacultyID").val();
      $.ajax({
        url: sRootPath + "/_com/AJAX_Activity.cfc",
        type: 'post',
        data: {
          method: "saveFacultyMember",
          PersonID: nFaculty,
          ActivityID: nActivity,
          returnFormat: "plain"
        },
        success: function(returnData) {
          var cleanData, status, statusMsg;
          cleanData = $.trim(returnData);
          status = $.ListGetAt(cleanData, 1, "|");
          statusMsg = $.ListGetAt(cleanData, 2, "|");
          if (status === 'Success') {
            setFacultyRole(nFaculty, 3);
            refresh();
            $("#PersonWindowFaculty").dialog("close");
            addMessage(statusMsg, 250, 6000, 4000);
          } else if (status === 'Fail') {
            refresh();
            $("#PersonWindowFaculty").dialog("close");
            addError(statusMsg, 250, 6000, 4000);
          }
        }
      });
      $("#PersonActivityID").val('');
    };
    return refresh = Self.refresh = function() {
      Self.trigger('refreshStart');
      Self.el.$loading.show();
      Self.el.$container.empty();
      $.ajax({
        url: sMyself + "Activity.FacultyAHAH",
        type: 'get',
        data: {
          ActivityID: nActivity
        },
        success: function(data) {
          var setDefaults;
          Self.el.$container.html(data);
          Self.el.$loading.hide();
          setDefaults = function() {
            $(".js-status-selected-count").text(selectedCount);
            return $(".js-select-all-rows").each(function() {
              var $checkBox, $row, nPerson;
              $row = $(this);
              $checkBox = $row.find(".MemberCheckbox");
              nPerson = $row.data('key');
              if ($.ListFind(selected, nPerson)) {
                return $checkBox.attr('checked', true);
              }
            });
          };
          setDefaults();
          Self.trigger('refreshEnd');
        }
      });
    };
  });

}).call(this);
/*
* ACTIVITY > FACULTY
*/


(function() {
  App.module("Activity.Faculty.Ahah", function(Self, App, Backbone, Marionette, $) {
    var CurrPersonID, Parent, nPersonID, sPersonName, _destroy, _init;
    this.startWithParent = false;
    Parent = App.Activity.Faculty;
    nPersonID = null;
    sPersonName = null;
    this.on("before:start", function() {
      App.logInfo("starting: Activity.Faculty." + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: Activity.Faculty." + Self.moduleName);
      });
    });
    this.on("stop", function() {
      $("#FacultyContainer").empty();
      App.logInfo("stopped: Activity.Faculty." + Self.moduleName);
    });
    CurrPersonID = null;
    _destroy = function() {};
    return _init = function(defaults) {
      var $cvBtn, $discBtn, $selectAll, $selectOne;
      $selectAll = $("#FacultyContainer").find(".js-select-all");
      $selectOne = $("#FacultyContainer").find(".js-select-one");
      $cvBtn = $(".js-cv-btn");
      $discBtn = $(".js-disclosure-btn");
      $cvBtn.tooltip({
        placement: 'bottom',
        trigger: 'hover focus',
        container: '#FacultyContainer',
        title: function() {
          return $(this).attr('data-tooltip-title');
        }
      });
      $discBtn.tooltip({
        placement: 'bottom',
        trigger: 'hover focus',
        container: '#FacultyContainer',
        title: function() {
          return $(this).attr('data-tooltip-title');
        }
      });
      $selectAll.on("click", function() {
        App.logDebug("selectAll Clicked");
        if ($selectAll.attr("checked")) {
          $selectOne.each(function() {
            $(this).attr("checked", true);
            nPersonID = $.Replace(this.id, "Checked", "", "ALL");
            Parent.addSelected({
              person: nPersonID
            });
            return $(".AllFaculty").css("background-color", "#FFD");
          });
        } else {
          $selectOne.each(function() {
            $(this).attr("checked", false);
            nPersonID = $.Replace(this.id, "Checked", "", "ALL");
            Parent.removeSelected({
              person: nPersonID
            });
            return $(".AllFaculty").css("background-color", "#FFF");
          });
        }
      });
      $selectOne.on("click", function() {
        App.logDebug("selectOne Clicked");
        if ($(this).attr("checked")) {
          nPersonID = $.Replace(this.id, "Checked", "", "ALL");
          Parent.addSelected({
            person: nPersonID
          });
          $("#PersonRow" + nPersonID).css("background-color", "#FFD");
        } else {
          nPersonID = $.Replace(this.id, "Checked", "", "ALL");
          Parent.removeSelected({
            person: nPersonID
          });
          $("#PersonRow" + nPersonID).css("background-color", "#FFF");
        }
      });
      $("#PersonDetail").dialog({
        title: "Person Detail",
        modal: true,
        autoOpen: false,
        height: 550,
        maxWidth: 855,
        resizable: false,
        dragStop: function(ev, ui) {},
        open: function() {
          return $(this).find('iframe').attr("src", sMyself + "Person.Detail?PersonID=" + nPersonID + "&Mini=1");
        },
        close: function() {},
        resizeStop: function(ev, ui) {}
      });
      $(".PersonLink").on("click", function(e) {
        var $row;
        $row = $(this).parents('.js-row');
        nPersonID = $row.data('key');
        sPersonName = $row.data('name');
        $("#PersonDetail").dialog("open", e.preventDefault());
        return false;
      });
      $("#FileUploader").dialog({
        title: "Upload File",
        modal: false,
        autoOpen: false,
        height: 320,
        width: 350,
        resizable: false,
        stack: false,
        buttons: {
          Save: function() {
            return $("#frmFileUpload").ajaxSubmit({
              beforeSubmit: function() {
                return $("#Section" + CurrPersonID).html("<img src=\"/admin/_images/ajax-loader.gif\"/><br />Please wait...");
              },
              url: sMyself + "File.Upload&Mode=Person&ModeID=" + CurrPersonID + "&ActivityID=" + nActivity + "&Submitted=1",
              type: "post",
              success: function() {
                $("#FileUploader").html("");
                addMessage("File uploaded successfully.", 250, 6000, 4000);
                return $("#FileUploader").dialog("close");
              }
            });
          },
          Cancel: function() {
            return $(this).dialog("close");
          }
        },
        open: function() {
          return $.post(sMyself + "File.Upload", {
            Mode: "Person",
            ModeID: CurrPersonID,
            ActivityID: nActivity
          }, function(data) {
            return $("#FileUploader").html(data);
          });
        },
        close: function() {
          return App.Activity.Faculty.refresh();
        }
      });
      $(".UploadFile").on("click", function() {
        CurrPersonID = $.ListGetAt(this.id, 2, "|");
        App.logDebug(CurrPersonID);
        $("#FileUploader").dialog("open");
      });
      return $(".approveFile").on("click", function() {
        var sApprovalType, sFileType;
        sApprovalType = $.ListGetAt(this.id, 1, "|");
        sFileType = $.ListGetAt(this.id, 2, "|");
        nPersonID = $.ListGetAt(this.id, 3, "|");
        $.ajax({
          url: sRootPath + "/_com/AJAX_Activity.cfc",
          type: 'post',
          dataType: 'json',
          data: {
            method: "approveFacultyFile",
            ActivityID: nActivity,
            PersonID: nPersonID,
            FileType: sFileType,
            Mode: sApprovalType,
            returnFormat: "plain"
          },
          success: function(data) {
            console.log("hello");
            if (data.STATUS) {
              App.Activity.Faculty.refresh();
              addMessage(data.STATUSMSG, 250, 6000, 4000);
            } else {
              App.Activity.Faculty.refresh();
              addError(data.STATUSMSG, 250, 6000, 4000);
            }
          }
        });
      });
    };
  });

}).call(this);
/*
* ACTIVITY > FILES
*/


(function() {
  App.module("Activity.Files", function(Self, App, Backbone, Marionette, $) {
    var $container, $loading, addSelected, clearSelected, getSelected, refresh, removeSelected, saveFileMember, selected, selectedCount, setRole, updateSelectedCount, _init;
    this.startWithParent = false;
    Self.el = {};
    $container = Self.el.$container = null;
    $loading = Self.el.$loading = null;
    selectedCount = 0;
    selected = "";
    this.on("before:start", function() {
      App.logInfo("starting: " + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: " + Self.moduleName);
      });
    });
    this.on("stop", function() {
      Self.Ahah.stop();
      App.logInfo("stopped: " + Self.moduleName);
    });
    this.on("refreshStart", function() {
      Self.Ahah.stop();
    });
    this.on("refreshEnd", function() {
      Self.Ahah.start();
    });
    updateSelectedCount = Self.updateSelectedCount = function(nAmount) {
      App.logInfo("Count is currently " + parseInt(selectedCount));
      App.logInfo("Updating Count by " + parseInt(nAmount));
      selectedCount = parseInt(selectedCount) + parseInt(nAmount);
      if (selectedCount < 0) {
        selectedCount = 0;
      }
      App.logInfo("Count is now " + selectedCount);
      $("#CheckedCount,.js-status-selected-count").html("" + selectedCount + "");
      if (selectedCount > 0) {
        $(".js-selected-actions").find(".btn").removeClass("disabled");
      } else {
        $(".js-selected-actions").find(".btn").addClass("disabled");
      }
    };
    clearSelected = function() {
      selected = "";
      updateSelectedCount(selectedCount * -1);
      $(".js-status-selected-count").html("0");
    };
    getSelected = Self.getSelected = function() {
      return selected.split(',');
    };
    addSelected = Self.addSelected = function(params) {
      var settings;
      settings = $.extend({}, params);
      if (settings.person && settings.person > 0) {
        if (!$.ListFind(selected, settings.person, ",")) {
          selected = $.ListAppend(selected, settings.person, ",");
          updateSelectedCount(1);
        }
      }
      App.logDebug(selected);
    };
    removeSelected = Self.removeSelected = function(params) {
      var settings;
      settings = $.extend({}, params);
      if (settings.person && settings.person > 0) {
        if ($.ListFind(selected, settings.person, ",")) {
          if (settings.person && settings.person > 0) {
            selected = $.ListDeleteAt(selected, $.ListFind(selected, settings.person));
          }
          updateSelectedCount(-1);
        }
      }
      App.logDebug(selected);
    };
    setRole = Self.setRole = function(persons, role) {
      $.ajax({
        url: sRootPath + "/_com/AJAX_Activity.cfc",
        type: 'post',
        dataType: 'json',
        data: {
          method: "changeFileRoles",
          PersonList: persons,
          ActivityID: nActivity,
          RoleID: role,
          returnFormat: "plain"
        },
        success: function(data) {
          if (data.STATUS) {
            addMessage(data.STATUSMSG, 250, 6000, 4000);
          } else {
            addError(data.STATUSMSG, 250, 6000, 4000);
          }
          return refresh();
        }
      });
    };
    refresh = Self.refresh = function() {
      Self.trigger('refreshStart');
      $.ajax({
        url: sMyself + "Activity.DocsAHAH",
        type: 'get',
        data: {
          ActivityID: nActivity
        },
        success: function(data) {
          var setDefaults;
          Self.el.$container.html(data);
          Self.el.$loading.hide();
          setDefaults = function() {
            $(".js-status-selected-count").text(selectedCount);
            if (selectedCount && selectedCount > 0) {
              $(".js-selected-actions .btn").removeClass('disabled');
            }
            return $(".js-select-all-rows").each(function() {
              var $checkBox, $row, nPerson;
              $row = $(this);
              $checkBox = $row.find(".MemberCheckbox");
              nPerson = $row.data('key');
              if ($.ListFind(selected, nPerson)) {
                return $checkBox.attr('checked', true);
              }
            });
          };
          setDefaults();
          Self.trigger('refreshEnd');
        }
      });
    };
    saveFileMember = Self.save = function() {
      var nFile;
      nFile = $("#FileID").val();
      $.ajax({
        url: sRootPath + "/_com/AJAX_Activity.cfc",
        type: 'post',
        data: {
          method: "saveFileMember",
          PersonID: nFile,
          ActivityID: nActivity,
          returnFormat: "plain"
        },
        success: function(returnData) {
          var cleanData, status, statusMsg;
          cleanData = $.trim(returnData);
          status = $.ListGetAt(cleanData, 1, "|");
          statusMsg = $.ListGetAt(cleanData, 2, "|");
          if (status === 'Success') {
            setRole(nFile, 1);
            refresh();
            $("#PersonWindowFile").dialog("close");
            addMessage(statusMsg, 250, 6000, 4000);
          } else if (status === 'Fail') {
            refresh();
            $("#PersonWindowFile").dialog("close");
            addError(statusMsg, 250, 6000, 4000);
          }
        }
      });
      $("#PersonActivityID").val('');
    };
    return _init = function(defaults) {
      Self.el.$container = $container = $("#FilesContainer");
      Self.el.$loading = $loading = $("#FilesLoading");
      refresh();
      $("#FileList").ajaxForm();
      $("#UploadDialog").dialog({
        title: "Upload File",
        modal: false,
        autoOpen: false,
        height: 350,
        width: 350,
        resizable: false,
        stack: false,
        buttons: {
          Save: function() {
            return $("#frmFileUpload").ajaxSubmit({
              beforeSubmit: function() {},
              url: sMyself + "File.Upload&Mode=Activity&ModeID=" + nActivity + "&ActivityID=" + nActivity + "&Submitted=1",
              type: "post",
              success: function() {
                $("#UploadDialog").html("");
                addMessage("File uploaded successfully.", 250, 6000, 4000);
                $("#UploadDialog").dialog("close");
                return refresh();
              }
            });
          },
          Cancel: function() {
            $(this).dialog("close");
            return refresh();
          }
        },
        open: function() {
          return $.ajax({
            url: "" + sMyself + "File.Upload",
            type: 'get',
            data: {
              Mode: 'Activity',
              ModeID: nActivity,
              ActivityID: nActivity
            },
            success: function(data) {
              return $("#UploadDialog").html(data);
            }
          });
        },
        close: function() {
          return refresh();
        }
      });
      $(".UploadLink").click(function() {
        $("#UploadDialog").dialog("open");
      });
      $("#RemoveChecked").on("click", function() {
        var cleanData, result;
        if (confirm("Are you sure you want to remove the checked people from this Activity?")) {
          result = "";
          cleanData = "";
          return $.ajax({
            url: sRootPath + "/_com/File/FileAjax.cfc",
            dataType: 'json',
            data: {
              method: "removeChecked",
              DocList: selected,
              ActivityID: nActivity,
              returnFormat: "plain"
            },
            success: function(data) {
              if (data.STATUS) {
                clearSelected();
                addMessage(data.STATUSMSG, 250, 6000, 4000);
              } else {
                addError(data.STATUSMSG, 250, 6000, 4000);
              }
              refresh();
            }
          });
        }
      });
    };
  });

}).call(this);
/*
* ACTIVITY > FILES > AHAH
*/


(function() {
  App.module("Activity.Files.Ahah", function(Self, App, Backbone, Marionette, $) {
    var CurrPersonID, Parent, nPersonID, sPersonName, _destroy, _init;
    this.startWithParent = false;
    Parent = App.Activity.Files;
    nPersonID = null;
    sPersonName = null;
    this.on("before:start", function() {
      App.logInfo("starting: Activity.Files." + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: Activity.Files." + Self.moduleName);
      });
    });
    this.on("stop", function() {
      $("#FilesContainer").empty();
      App.logInfo("stopped: Activity.Files." + Self.moduleName);
    });
    CurrPersonID = null;
    _destroy = function() {};
    return _init = function(defaults) {
      var $rows, $selectAll, $selectOne;
      $selectAll = $("#FilesContainer").find(".js-select-all");
      $selectOne = $("#FilesContainer").find(".js-select-one");
      $rows = $(".js-select-all-rows");
      $rows.each(function() {
        var $checkBox, $copyLink, $dlLink, $editLink, $linkTextField, $row;
        $row = $(this);
        $dlLink = $row.find('.js-download-file-link');
        $editLink = $row.find('.js-edit-file-link');
        $checkBox = $row.find('.js-select-one');
        $copyLink = $row.find('.js-copy-file-link');
        $linkTextField = $row.find('.js-public-file-link');
        $editLink.tooltip({
          placement: 'left',
          html: 'true',
          trigger: 'hover focus',
          title: function(e) {
            return $(this).attr('data-tooltip-title');
          },
          container: "body"
        });
        $dlLink.tooltip({
          placement: 'left',
          html: 'true',
          trigger: 'hover focus',
          title: function(e) {
            return $(this).attr('data-tooltip-title');
          },
          container: "body"
        });
        $copyLink.zclip({
          path: "/assets/ZeroClipboard-c1f3a824a0c3d9d5253890fedd150d3d.swf",
          copy: function() {
            return $(this).data('clipboard-text');
          }
        });
        return $checkBox.on("click", function() {
          App.logDebug("selectOne Clicked");
          if ($(this).attr("checked")) {
            nPersonID = $.Replace(this.id, "Checked", "", "ALL");
            Parent.addSelected({
              person: nPersonID
            });
            $row.find('td').css("background-color", "#FFD");
          } else {
            nPersonID = $.Replace(this.id, "Checked", "", "ALL");
            Parent.removeSelected({
              person: nPersonID
            });
            $row.find('td').css("background-color", "#FFF");
          }
        });
      });
      $selectAll.on("click", function() {
        App.logDebug("selectAll Clicked");
        if ($selectAll.attr("checked")) {
          $selectOne.each(function() {
            $(this).attr("checked", true);
            nPersonID = $.Replace(this.id, "Checked", "", "ALL");
            Parent.addSelected({
              person: nPersonID
            });
            return $(".js-select-all-rows").find('td').css("background-color", "#FFD");
          });
        } else {
          $selectOne.each(function() {
            $(this).attr("checked", false);
            nPersonID = $.Replace(this.id, "Checked", "", "ALL");
            Parent.removeSelected({
              person: nPersonID
            });
            return $(".js-select-all-rows").find('td').css("background-color", "#FFF");
          });
        }
      });
      $("#PersonDetail").dialog({
        title: "Person Detail",
        modal: true,
        autoOpen: false,
        height: 550,
        width: 855,
        resizable: false,
        dragStop: function(ev, ui) {},
        open: function() {
          $(this).find('iframe').attr("src", sMyself + "Person.Detail?PersonID=" + nPersonID + "&Mini=1");
        },
        close: function() {},
        resizeStop: function(ev, ui) {}
      });
      $(".PersonLink").on("click", function(e) {
        var $row;
        $row = $(this).parents('.js-row');
        nPersonID = $row.data('key');
        sPersonName = $row.data('name');
        $("#PersonDetail").dialog("open", e.preventDefault());
        return false;
      });
      $(".UploadLink").click(function() {
        $("#UploadDialog").dialog("open");
      });
      $(".PublishLink").on("click", function() {
        var nComponent, nFile, sFileName;
        nFile = $.ListGetAt(this.id, 3, "-");
        nComponent = $.ListGetAt(this.id, 2, "-");
        sFileName = prompt("What is the display name of this component?");
        if (sFileName !== null) {
          if (sFileName !== '') {
            $.ajax({
              url: sRootPath + "/_com/AJAX_Activity.cfc",
              type: 'post',
              dataType: 'json',
              data: {
                method: "publishFile",
                ActivityID: nActivity,
                FileID: nFile,
                FileName: sFileName,
                ComponentID: nComponent,
                returnFormat: "plain"
              },
              success: function(data) {
                if (data.STATUS) {
                  addMessage(data.STATUSMSG, 250, 6000, 4000);
                  Parent.refresh();
                } else {
                  addError(data.STATUSMSG, 250, 6000, 4000);
                }
              }
            });
          } else {
            return addError('You must provide a display name for the component.');
          }
        }
      });
      $(".UnpublishLink").on("click", function() {
        var nFile;
        nFile = $.ListGetAt(this.id, 2, "-");
        return $.ajax({
          url: sRootPath + "/_com/AJAX_Activity.cfc",
          type: 'post',
          dataType: 'json',
          data: {
            method: "UnpublishFile",
            ActivityID: nActivity,
            FileID: nFile,
            returnFormat: "plain"
          },
          success: function(data) {
            if (data.STATUS) {
              addMessage(data.STATUSMSG, 250, 6000, 4000);
              Parent.refresh();
            } else {
              addError(data.STATUSMSG, 250, 6000, 4000);
            }
          }
        });
      });
    };
  });

}).call(this);
/*
* ACTIVITY > FINANCES
*/


(function() {
  App.module("Activity.Finances", function(Self, App, Backbone, Marionette, $) {
    var _init;
    this.startWithParent = false;
    this.on("before:start", function() {
      App.logInfo("starting: " + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: " + Self.moduleName);
      });
    });
    this.on("stop", function() {
      App.logInfo("stopped: " + Self.moduleName);
    });
    return _init = function(defaults) {};
  });

}).call(this);
/*!
* ACTIVITY > FINANCES > BUDGET
*/


(function() {
  App.module("Activity.Finances.Budget", function(Self, App, Backbone, Marionette, $) {
    var _init;
    this.startWithParent = false;
    this.on("before:start", function() {
      App.logInfo("starting: " + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: " + Self.moduleName);
      });
    });
    this.on("stop", function() {
      App.logInfo("stopped: " + Self.moduleName);
    });
    return _init = function(defaults) {};
  });

}).call(this);
/*!
* ACTIVITY > FINANCES > FEES
*/


(function() {
  App.module("Activity.Finances.Fees", function(Self, App, Backbone, Marionette, $) {
    var _init;
    this.startWithParent = false;
    this.on("before:start", function() {
      App.logInfo("starting: " + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: " + Self.moduleName);
      });
    });
    this.on("stop", function() {
      App.logInfo("stopped: " + Self.moduleName);
    });
    return _init = function(defaults) {};
  });

}).call(this);
/*!
* ACTIVITY > FINANCES > LEDGER
*/


(function() {
  App.module("Activity.Finances.Budget", function(Self, App, Backbone, Marionette, $) {
    var _init;
    this.startWithParent = false;
    this.on("before:start", function() {
      App.logInfo("starting: " + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: " + Self.moduleName);
      });
    });
    this.on("stop", function() {
      App.logInfo("stopped: " + Self.moduleName);
    });
    return _init = function(defaults) {};
  });

}).call(this);
/*!
* ACTIVITY > FINANCES > SUPPORT
*/


(function() {
  App.module("Activity.Finances.Support", function(Self, App, Backbone, Marionette, $) {
    var _init;
    this.startWithParent = false;
    this.on("before:start", function() {
      App.logInfo("starting: " + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: " + Self.moduleName);
      });
    });
    this.on("stop", function() {
      App.logInfo("stopped: " + Self.moduleName);
    });
    return _init = function(defaults) {};
  });

}).call(this);
/*
* ACTIVITY > FOLDERS
*/


(function() {
  App.module("Activity.Folders", function(Self, App, Backbone, Marionette, $) {
    var $containersBox, createNewCat, refresh, removeCat, saveActCat, _init;
    this.startWithParent = true;
    $containersBox = null;
    this.on("before:start", function() {
      App.logInfo("starting: " + Self.moduleName);
    });
    this.on("start", function(defaultFolders) {
      $(document).ready(function() {
        _init(defaultFolders);
        return App.logInfo("started: " + Self.moduleName);
      });
    });
    this.on("stop", function() {
      App.logInfo("stopped: " + Self.moduleName);
    });
    refresh = Self.refresh = function(callback) {
      var cb;
      cb = callback;
      return $.post(sMyself + "Activity.Container", {
        ActivityID: nActivity
      }, function(data) {
        $containersBox.html(data);
        return cb(true);
      });
    };
    _init = function(defaults) {
      $containersBox = $("#Containers");
      refresh(function() {
        return $(".js-tokenizer-list").uiTokenizer({
          listLocation: "top",
          type: "list",
          showImage: false,
          watermarkText: "Type to Add Folder",
          ajaxAddURL: "/admin/_com/AJAX_Activity.cfc",
          ajaxAddParams: {
            method: "createCategory"
          },
          ajaxSearchURL: "/admin/_com/ajax/typeahead.cfc",
          ajaxSearchParams: {
            method: "search",
            type: "folders"
          },
          onSelect: function(i, e) {
            saveActCat(e);
            return true;
          },
          onAdd: function(i, e) {
            return true;
          },
          onRemove: function(i, e) {
            removeCat(e);
            return true;
          },
          defaultValue: App.Activity.data.folders
        });
      });
    };
    saveActCat = function(oCategory) {
      $.post(sRootPath + "/_com/AJAX_Activity.cfc", {
        method: "saveCategory",
        ActivityID: nActivity,
        CategoryID: oCategory.value,
        returnFormat: "plain"
      }, function(data) {
        var cleanData, status, statusMsg;
        cleanData = $.trim(data);
        status = $.ListGetAt(cleanData, 1, "|");
        statusMsg = $.ListGetAt(cleanData, 2, "|");
        if (status === "Success") {
          return addMessage(statusMsg, 250, 6000, 4000);
        } else {
          if (status === "Fail") {
            return addError(statusMsg, 250, 6000, 4000);
          }
        }
      });
    };
    createNewCat = function(oCategory) {
      var CatTitle;
      CatTitle = prompt("Container Name:", "");
      if (CatTitle) {
        $.post(sRootPath + "/_com/AJAX_Activity.cfc", {
          method: "createCategory",
          Name: CatTitle,
          ReturnFormat: "plain"
        }, function(data) {
          if (data.STATUS) {
            return saveActCat(oCategory);
          } else {
            return addError(statusMsg, 250, 6000, 4000);
          }
        });
      }
    };
    return removeCat = function(oCategory) {
      var CatID, CatName;
      CatID = oCategory.value;
      CatName = oCategory.label;
      if (confirm("Are you sure you want to remove the activity from the container '" + CatName + "'?")) {
        $.post(sRootPath + "/_com/AJAX_Activity.cfc", {
          method: "deleteCategory",
          ActivityID: nActivity,
          CategoryID: CatID,
          returnFormat: "plain"
        }, function(data) {
          if (data.STATUS) {
            addMessage(data.STATUSMSG, 250, 6000, 4000);
            $("#CatRow" + CatID).remove();
            return $("#CatAdder").val("");
          } else {
            return addMessage(data.STATUSMSG, 250, 6000, 4000);
          }
        });
      }
    };
  });

}).call(this);
/*
* ACTIVITY > GENERAL INFORMATION
*/


(function() {
  App.module("Activity.GeneralInfo", function(Self, App, Backbone, Marionette, $) {
    var FormState, setActivityType, setSessionType, updateStateProvince, _init;
    this.startWithParent = false;
    FormState = null;
    this.on("before:start", function() {
      App.logInfo("starting: " + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: " + Self.moduleName);
      });
    });
    this.on("stop", function() {
      App.logInfo("stopped: " + Self.moduleName);
      FormState = null;
    });
    updateStateProvince = function(countryId) {
      if (parseInt(countryId) === 230) {
        $(".stateField").show();
        return $(".provinceField").hide();
      } else {
        $(".stateField").hide().css({
          display: "none"
        });
        return $(".provinceField").show();
      }
    };
    setSessionType = function(sSessionType) {
      if (sSessionType === "M") {
        $(".Sessions").fadeIn();
        return $(".SingleSession").fadeOut();
      } else {
        $(".Sessions").fadeOut();
        return $(".SingleSession").fadeIn();
      }
    };
    setActivityType = function(nActivityType) {
      if (parseInt(nActivityType) === 1) {
        $("#Grouping").html(LiveOptions);
        $("#Groupings").show();
        $(".Location").show();
      } else if (parseInt(nActivityType) === 2) {
        $("#Groupings").show();
        $("#Grouping").html(EMOptions);
      } else {
        $("#Groupings").hide();
        $("#Grouping").html("");
        $(".Location").hide();
      }
      return updateStateProvince(parseInt($("#Country").val()));
    };
    return _init = function() {
      FormState = new App.Components.FormState({
        el: '#js-activity-detail .js-formstate',
        saved: true
      });
      updateStateProvince(nCountryId);
      $("#Country").change(function() {
        updateStateProvince(parseInt($(this).val()));
      });
      $("#ActivityType").bind("change", this, function() {
        return setActivityType(parseInt($(this).val()));
      });
      $("#SessionType").change(function() {
        return setSessionType($(this).val());
      });
      if (!!nActivityType) {
        $("#ActivityType").val(parseInt(nActivityType));
        setActivityType(parseInt(nActivityType));
        if (nGrouping) {
          $("#Grouping").val(parseInt(nGrouping));
        }
      }
      if (!!sSessionType) {
        $("#SessionType").val(sSessionType);
        setSessionType(sSessionType);
      }
      if ($("#Sponsorship").val() === "J") {
        $(".js-sponsorship-J").addClass("active");
        $("#JointlyTextFld").removeClass("hide");
      } else {
        $(".js-sponsorship-D").addClass("active");
        $("#JointlyTextFld").addClass("hide");
      }
      $(".js-sponsorship-toggle").bind("click", function(e) {
        var $this;
        $this = $(this);
        if ($this.hasClass("js-sponsorship-J")) {
          FormState.Unsaved();
          FormState.AddChange("Sponsorship", "J");
          FormState.AddChange("Sponsor", $("#Sponsor").val());
          $("#Sponsorship").val("J");
          $("#JointlyTextFld").removeClass("hide");
        } else {
          FormState.Unsaved();
          FormState.AddChange("Sponsorship", "D");
          $("#Sponsorship").val("D");
          $("#JointlyTextFld").addClass("hide");
        }
        e.preventDefault();
      });
    };
  });

}).call(this);
/*
* ACTIVITY > HISTORY
*/


(function() {
  App.module("Activity.History", function(Self, App, Backbone, Marionette, $) {
    var _init;
    this.startWithParent = false;
    this.on("before:start", function() {
      App.logInfo("starting: Activity." + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: Activity." + Self.moduleName);
      });
    });
    this.on("stop", function() {
      App.logInfo("stopped: Activity." + Self.moduleName);
    });
    return _init = function() {
      this.feed = new App.Components.NewsFeed({
        el: '#js-activity-history .js-newsfeed',
        defaultMode: 'activityTo',
        hub: 'activity',
        modes: ["activityAll"],
        queryParams: {
          activityTo: App.Activity.model.get('id')
        }
      });
    };
  });

}).call(this);
/*!
* ACTIVITY > PUBLISH > CATEGORIES
*/


(function() {
  App.module("Activity.Publish.Categories", function(Self, App, Backbone, Marionette, $) {
    var FormState, _init;
    this.startWithParent = false;
    FormState = null;
    this.on("before:start", function() {
      App.logInfo("starting: Publish." + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: Publish." + Self.moduleName);
      });
    });
    this.on("stop", function() {
      App.logInfo("stopped: Publish." + Self.moduleName);
      FormState = null;
    });
    return _init = function(defaults) {
      return FormState = new App.Components.FormState({
        el: '#js-activity-pubcategory .js-formstate',
        saved: true
      });
    };
  });

}).call(this);
/*!
* ACTIVITY > PUBLISH > GENERAL INFO
*/


(function() {
  App.module("Activity.Publish.General", function(Self, App, Backbone, Marionette, $) {
    var FormState, _init;
    this.startWithParent = false;
    FormState = null;
    this.on("before:start", function() {
      App.logInfo("starting: Publish." + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: Publish." + Self.moduleName);
      });
    });
    this.on("stop", function() {
      App.logInfo("stopped: Publish." + Self.moduleName);
      $.each(Self.submodules, function(i, module) {
        module.stop();
      });
    });
    return _init = function(defaults) {
      return FormState = new App.Components.FormState({
        el: '.js-form-publish',
        saved: true
      });
    };
  });

}).call(this);
/*!
* ACTIVITY > PUBLISH > GENERAL INFO
*/


(function() {
  App.module("Activity.Publish.Bar", function(Self, App, Backbone, Marionette, $) {
    var _init;
    this.startWithParent = false;
    this.on("before:start", function() {
      App.logInfo("starting: Publish." + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init(Self.data);
        return App.logInfo("started: Publish." + Self.moduleName);
      });
    });
    this.on("stop", function() {
      App.logInfo("stopped: Publish." + Self.moduleName);
      $.each(Self.submodules, function(i, module) {
        module.stop();
      });
    });
    return _init = function(data) {
      var publishActivity;
      $(".js-progress-info-bar-fill").css({
        "width": data.nFillPercent + "%",
        "background-color": "#" + data.sFillColor
      });
      if (data.publishState === 'Y') {
        $('.js-publishactivity-btn').hide();
      } else {
        $('.js-unpublishactivity-btn').hide();
      }
      if (data.nFillPercent !== 100) {
        $('.js-publishactivity-btn, js-unpublishactivity-btn').attr('disabled', 'disabled');
      }
      publishActivity = function(published) {
        return $.ajax({
          url: sRootPath + "/_com/AJAX_Activity.cfc",
          dataType: 'json',
          type: 'post',
          data: {
            method: "publishActivity",
            ActivityID: nActivity,
            returnFormat: "plain"
          },
          success: function(data) {
            if (data.STATUS) {
              addMessage(data.STATUSMSG, 250, 6000, 4000);
              if (published) {
                $(".js-publishactivity-btn").hide();
                $(".js-unpublishactivity-btn").show();
              } else {
                $(".js-unpublishactivity-btn").hide();
                $(".js-publishactivity-btn").show();
              }
              return updatePublishState;
            } else {
              return addError(data.STATUSMSG, 250, 6000, 4000);
            }
          }
        });
      };
      return $(".js-publishactivity-btn, .js-unpublishactivity-btn").tooltip({
        placement: 'top',
        trigger: 'hover focus',
        title: function(e) {
          return $(this).attr('data-tooltip-title');
        },
        container: 'body'
      }, $(".js-publishactivity-btn").on("click", function() {
        if (!$(".js-publishactivity-btn").attr("disabled")) {
          return publishActivity(true);
        } else {
          return addError('More progress is required.  See Progress dropdown for more information.');
        }
      }), $(".js-unpublishactivity-btn").on("click", function() {
        if (!$(".js-unpublishactivity-btn").attr("disabled")) {
          return publishActivity(false);
        } else {
          return addError('More progress is required.  See Progress dropdown for more information.');
        }
      }));
    };
  });

}).call(this);
/*!
* ACTIVITY > PUBLISH > SPECIALTIES
*/


(function() {
  App.module("Activity.Publish.Specialties", function(Self, App, Backbone, Marionette, $) {
    var FormState, _init;
    this.startWithParent = false;
    FormState = null;
    this.on("before:start", function() {
      App.logInfo("starting: Publish." + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: Publish." + Self.moduleName);
      });
    });
    this.on("stop", function() {
      App.logInfo("stopped: Publish." + Self.moduleName);
      FormState = null;
    });
    return _init = function(defaults) {
      return FormState = new App.Components.FormState({
        el: '#js-activity-pubspecialty .js-formstate',
        saved: true
      });
    };
  });

}).call(this);





//=require_dir ./
;
/*!
* ACTIVITY > NOTES
*/


(function() {
  App.module("Activity.Notes", function(Self, App, Backbone, Marionette, $) {
    var $noteAddBtn, $noteContent, $notebody, $notebox, $notedummy, $notelist, $notes, deleteNote, note, noteMarkup, resetForm, _init;
    this.startWithParent = false;
    $noteContent = null;
    $notes = null;
    $notebox = null;
    $notebody = null;
    $notelist = null;
    $notedummy = null;
    $noteAddBtn = null;
    noteMarkup = '<div class="divider">\
                  <hr>\
                </div>\
                <div class="post-row row-fluid" data-key="<%=id%>">\
                  <div class="post-item span24">\
                    <div class="post-author">\
                      <a href="/admin/event/Activity.Detail?ActivityID=<%=author.id%>" title="View Profile"><%=author.name%></a>\
                    </div>\
                    <div class="post-body">\
                       <%=body%>\
                    </div>\
                    <div class="post-meta">\
                      <i class="icon-calendar"></i> <%=timestamp%>\
                      <a href="javascript://" class="js-notedelete"><i class="icon-trash"></i></a>\
                    </div>\
                  </div>\
                </div>';
    note = _.template(noteMarkup);
    this.on("before:start", function() {
      App.logInfo("starting: Activity." + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: Activity." + Self.moduleName);
      });
    });
    this.on("stop", function() {
      $noteContent.empty();
      App.logInfo("stopped: Activity." + Self.moduleName);
    });
    this.on("noteDeleted", function(n) {
      var $deleteNote;
      App.logInfo("Deleted Note: " + n);
      $deleteNote = $notes.filter("[data-key='" + n + "']");
      $deleteNote.prev().remove();
      $deleteNote.remove();
    });
    Self.resetForm = resetForm = function() {
      $notebody.val('');
      $notebody.blur();
    };
    _init = function(defaults) {
      $noteContent = $("#js-activity-notes");
      $notebox = $noteContent.find(".js-notebox");
      $notebody = $noteContent.find(".js-note-body");
      $notelist = $noteContent.find(".posts-list");
      $notes = $notelist.find('.post-item');
      $notedummy = $noteContent.find(".js-dummynote");
      $noteAddBtn = $noteContent.find(".js-note-actions .addNote");
      App.logDebug($notelist);
      $notebody.autosize();
      $notedummy.on("click", function() {
        $notebox.addClass("activated");
        $notebody.focus();
      });
      $notebody.on("focus", function() {
        $notebox.addClass("focused");
      });
      $notebody.on("blur", function() {
        if ($(this).val() === "") {
          $notebox.removeClass("activated focused");
        } else {
          $notebox.removeClass("focused");
        }
      });
      $noteAddBtn.on("click", function(e) {
        var sBody;
        sBody = $notebody.val();
        sBody = sBody.replace(/\n/g, '<br />');
        $.ajax({
          url: sRootPath + "/_com/AJAX_Activity.cfc",
          type: "post",
          dataType: "json",
          data: {
            method: "saveNote",
            ActivityID: nActivity,
            NoteBody: sBody,
            returnFormat: "plain"
          },
          success: function(data) {
            var $newNote, $newNoteRow, payLoad;
            if (data.STATUS) {
              addMessage(data.STATUSMSG, 250, 2500, 2500);
              payLoad = data.PAYLOAD;
              $newNoteRow = $(note(payLoad));
              $newNote = $newNoteRow.find('.post-item');
              $newNote.find(".js-notedelete").on("click", function() {
                deleteNote($newNote);
              });
              $notelist.prepend($newNoteRow);
              return resetForm();
            } else {
              return addError(data.STATUSMSG, 250, 2500, 2500);
            }
          }
        });
        return e.preventDefault();
      });
      $notes.each(function() {
        var $note, $noteDelete, $noteDivider, $noteRow, note_id;
        $note = $(this);
        $noteDelete = $note.find('.js-notedelete');
        $noteRow = $note.parents('.post-row');
        $noteDivider = $noteRow.prev();
        note_id = $noteRow.data('key');
        return $noteDelete.on("click", function(e) {
          deleteNote($note);
          return e.preventDefault();
        });
      });
    };
    return deleteNote = function($el) {
      var $note, $row, note_id;
      $note = $el;
      $row = $el.parents('.post-row');
      console.log($note);
      console.log($row);
      note_id = $row.data('key');
      if (confirm("Are you sure you want to delete this note?")) {
        return $.ajax({
          url: sRootPath + "/_com/AJAX_Activity.cfc",
          dataType: 'json',
          type: 'post',
          data: {
            method: "deleteNote",
            noteid: note_id,
            returnFormat: "plain"
          },
          success: function(data) {
            if (data.STATUS) {
              $row.prev().remove();
              $row.remove();
              parent.addMessage(data.STATUSMSG, 250, 2500, 2500);
            } else {
              parent.addError(data.STATUSMSG, 250, 2500, 2500);
            }
          }
        });
      }
    };
  });

}).call(this);
/*
* ACTIVITY > Participants
*/


(function() {
  App.module("Activity.Participants", function(Self, App, Backbone, Marionette, $) {
    var $container, $loading, addSelected, addlAttendeesUnsaved, cancelButton, checkmarkMember, clearSelected, getSelected, refresh, removeSelected, resetAttendee, saveAttendee, selected, selectedCount, setAddlPartic, updateSelectedCount, updateStatusDate, _init;
    this.startWithParent = false;
    Self.el = {};
    $container = Self.el.$container = null;
    $loading = Self.el.$loading = null;
    selectedCount = 0;
    selected = "";
    addlAttendeesUnsaved = false;
    this.on("before:start", function() {
      App.logInfo("starting: " + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: " + Self.moduleName);
      });
    });
    this.on("stop", function() {
      Self.Ahah.stop();
      App.logInfo("stopped: " + Self.moduleName);
    });
    this.on("refreshStart", function() {
      Self.Ahah.stop();
    });
    this.on("refreshEnd", function() {
      Self.Ahah.start();
    });
    updateSelectedCount = Self.updateSelectedCount = function(nAmount) {
      App.logInfo("Count is currently " + parseInt(selectedCount));
      App.logInfo("Updating Count by " + parseInt(nAmount));
      selectedCount = parseInt(selectedCount) + parseInt(nAmount);
      if (selectedCount < 0) {
        selectedCount = 0;
      }
      App.logInfo("Count is now " + selectedCount);
      $("#CheckedCount,.js-status-selected-count").html("" + selectedCount + "");
      if (selectedCount > 0) {
        $(".js-selected-actions").find(".btn").removeClass("disabled");
      } else {
        $(".js-selected-actions").find(".btn").addClass("disabled");
      }
    };
    clearSelected = function() {
      selected = "";
      updateSelectedCount(selectedCount * -1);
      $(".js-status-selected-count").html("0");
    };
    getSelected = Self.getSelected = function() {
      return selected.split(',');
    };
    addSelected = Self.addSelected = function(id) {
      if (!$.ListFind(selected, id, ",")) {
        selected = $.ListAppend(selected, id, ",");
        updateSelectedCount(1);
      }
      App.logDebug(selected);
    };
    removeSelected = Self.removeSelected = function(id) {
      if (id && id > 0) {
        if ($.ListFind(selected, id, ",")) {
          selected = $.ListDeleteAt(selected, $.ListFind(selected, id));
          updateSelectedCount(-1);
        }
      }
      App.logDebug(selected);
    };
    saveAttendee = Self.save = function() {
      $.blockUI({
        message: "<h1>Adding Attendee...</h1>"
      });
      $.post(sRootPath + "/_com/AJAX_Activity.cfc", {
        method: "saveAttendee",
        PersonID: $("#AttendeeID").val(),
        ActivityID: nActivity,
        returnFormat: "plain"
      }, function(returnData) {
        var cleanData, status, statusMsg;
        cleanData = $.trim(returnData);
        status = $.ListGetAt(cleanData, 1, "|");
        statusMsg = $.ListGetAt(cleanData, 2, "|");
        if (status === "Success") {
          refresh(nId, nStatus);
          addMessage(statusMsg, 250, 6000, 4000);
          return $.unblockUI();
        } else if (status === "Fail") {
          addError(statusMsg, 250, 6000, 4000);
          $.unblockUI();
          return $("#AttendeeName").val("Click To Add Attendee");
        }
      });
      $("#AttendeeID").val("");
      $("#AttendeeName").val("Click To Add Attendee");
    };
    setAddlPartic = function(nPartic) {
      App.logInfo("setting addl participants");
      $.post(sRootPath + "/_com/AJAX_Activity.cfc", {
        method: "updateAddlAttendees",
        ActivityID: nActivity,
        AddlAttendees: nPartic,
        returnFormat: "plain"
      }, function(returnData) {
        var cleanData, status, statusMsg;
        cleanData = $.trim(returnData);
        status = $.ListGetAt(cleanData, 1, "|");
        statusMsg = $.ListGetAt(cleanData, 2, "|");
        if (status === "Success") {
          addMessage(statusMsg, 250, 6000, 4000);
          addlAttendeesUnsaved = false;
        } else {
          addError(statusMsg, 250, 6000, 4000);
        }
      });
    };
    cancelButton = function() {
      $("#CreditsDialog").dialog("close");
    };
    updateStatusDate = function($Attendee, $Type) {
      if ($Type !== "") {
        $.ajax({
          url: sRootPath + "/_com/AJAX_Activity.cfc",
          type: 'post',
          data: {
            method: "getAttendeeDate",
            AttendeeId: $Attendee,
            type: $Type,
            returnFormat: "plain"
          },
          success: function(data) {
            var cleanData;
            cleanData = $.Trim(data);
            $("#datefill-" + $Attendee).html(cleanData);
            return $("#editdatelink-" + $Attendee).show();
          }
        });
      } else {
        $("#datefill-" + $Attendee).html("");
        $("#editdatelink-" + $Attendee).hide();
      }
    };
    resetAttendee = function(nA, nP, sP) {
      $.ajax({
        url: sRootPath + "/_com/AJAX_Activity.cfc",
        data: {
          method: "resetAttendee",
          attendeeId: nP,
          ActivityID: nA,
          PaymentFlag: sP,
          returnFormat: "plain"
        },
        success: function(data) {
          if (data.STATUS) {
            addMessage(data.STATUSMSG, 250, 6000, 4000);
            updateActions();
            updateStats();
            refresh();
          } else {
            addError(data.STATUSMSG, 250, 6000, 4000);
          }
        }
      });
    };
    checkmarkMember = function(id) {
      if (id && id > 0) {
        if ($.ListFind(selectedAttendees, id, ",")) {
          $("#Checked-" + id).attr("checked", true);
          return $("#attendeeRow-" + id).css("background-color", "#FFD");
        }
      }
    };
    refresh = Self.refresh = function() {
      Self.trigger('refreshStart');
      $.ajax({
        url: sMyself + "Activity.AttendeesAHAH",
        type: 'get',
        data: {
          ActivityID: nActivity
        },
        success: function(data) {
          var setDefaults;
          Self.el.$container.html(data);
          Self.el.$loading.hide();
          setDefaults = function() {
            $(".js-status-selected-count").text(selectedCount);
            if (selectedCount && selectedCount > 0) {
              $(".js-selected-actions .btn").removeClass('disabled');
            }
            return $(".js-select-all-rows").each(function() {
              var $checkBox, $row, id;
              $row = $(this);
              $checkBox = $row.find(".MemberCheckbox");
              id = $row.data('key');
              if ($.ListFind(selected, id)) {
                return $checkBox.attr('checked', true);
              }
            });
          };
          setDefaults();
          Self.trigger('refreshEnd');
        }
      });
    };
    return _init = function() {
      var $addlAttendeesMenu, setCheckedStatuses, statusText;
      Self.el.$container = $container = $("#ParticipantsContainer");
      Self.el.$loading = $loading = $("#ParticipantsLoading");
      $("#ParticipantList").ajaxForm();
      $addlAttendeesMenu = $container.find(".js-addl-attendees-menu");
      $addlAttendeesMenu.find('form').on("click", function(e) {
        e.stopPropagation();
      });
      if (parseInt(CookieAttendeeStatus) > 0) {
        statusText = $("#attendees-" + CookieAttendeeStatus).text();
        $(".js-attendee-filter-button").find("span:first").text(statusText);
      }
      $('.toolbar .dropdown-menu').find('form').click(function(e) {
        e.stopPropagation();
      });
      setCheckedStatuses = function(nStatus) {
        var cleanData, nActivityRole, result;
        result = "";
        cleanData = "";
        nActivityRole = $("#ActivityRoles").val();
        $(".MemberCheckbox:checked").each(function() {
          return result = $.ListAppend(result, $(this).val(), ",");
        });
        $.ajax({
          url: sRootPath + "/_com/AJAX_Activity.cfc",
          type: "post",
          data: {
            method: "updateAttendeeStatuses",
            AttendeeList: result,
            ActivityID: nActivity,
            StatusID: nStatus,
            returnFormat: "plain"
          },
          dataType: "json",
          success: function(returnData) {
            var status, statusMsg;
            status = returnData.STATUS;
            statusMsg = returnData.STATUSMSG;
            if (status) {
              addMessage(statusMsg, 250, 6000, 4000);
              updateActions();
              updateStats();
              clearSelectedMembers();
              return refresh(nId, nStatus);
            } else {
              return addError(statusMsg, 250, 6000, 4000);
            }
          }
        });
      };
      if (parseInt(CookieAttendeePageActivity) === parseInt(nActivity)) {
        if (parseInt(CookieAttendeeStatusActivity) === parseInt(nActivity)) {
          refresh(parseInt(CookieAttendeePage), parseInt(CookieAttendeeStatus));
        } else {
          refresh(parseInt(CookieAttendeePage), parseInt(nStatus));
        }
      } else {
        refresh(nId, nStatus);
      }
      /*
      PAGINATION BINDING
      */

      $("a.page,a.first,a.last,a.next,a.previous").live("click", function() {
        var nPageNo;
        nPageNo = $.Mid(this.href, $.Find("page=", this.href) + 5, $.Len(this.href) - $.Find("page=", this.href) + 4);
        $.post(sRootPath + "/_com/UserSettings.cfc", {
          method: "setAttendeePage",
          ActivityID: nActivity,
          Page: nPageNo
        });
        refresh(nPageNo, nStatus);
        return false;
      });
      /*
      ATTENDEE STATUS FILTER BINDING
      */

      $(".attendees-filter li").live("click", function() {
        var $this, nStatus;
        $this = $(this);
        $this.parents(".btn-group").find(".btn span:first").text($this.text());
        nStatus = $.ListGetAt(this.id, 2, "-");
        $("#ParticipantsContainer").html("");
        $("#ParticipantsLoading").show();
        return $.post(sRootPath + "/_com/UserSettings.cfc", {
          method: "setAttendeeStatus",
          ActivityID: nActivity,
          status: nStatus
        }, function(data) {
          return refresh(1, nStatus);
        });
      });
      $("#btnStatusSubmit").bind("click", function() {
        setCheckedStatuses($("#StatusID").val());
      });
      $("#AddlAttendees").keyup(function() {
        var $this;
        App.logInfo("attempting to set addl registrants");
        $this = $(this);
        addlAttendeesUnsaved = true;
        delay((function() {
          if (addlAttendeesUnsaved) {
            App.logInfo("waited 2500ms now setting addl registrants");
            return setAddlPartic($this.val());
          }
        }), 2500);
      });
      $("#AddlAttendees").bind("blur", function() {
        var $this;
        $this = $(this);
        if (addlAttendeesUnsaved) {
          setAddlPartic($this.val());
        }
      });
      $("#RemoveChecked").bind("click", function() {
        var cleanData;
        if (confirm("Are you sure you want to remove the checked attendees from this activity?")) {
          cleanData = "";
          return $.ajax({
            url: sRootPath + "/_com/AJAX_Activity.cfc",
            type: "post",
            data: {
              method: "removeCheckedAttendees",
              AttendeeList: selected,
              ActivityID: nActivity,
              returnFormat: "plain"
            },
            dataType: "json",
            success: function(data) {
              if (data.STATUS) {
                addMessage(data.STATUSMSG, 250, 6000, 4000);
                clearSelected();
              } else {
                addError(data.STATUSMSG, 250, 6000, 4000);
              }
              return refresh(nId, nStatus);
            }
          });
        }
      });
      $("#RemoveAll").bind("click", function() {
        var cleanData;
        if (confirm("WARNING!\nYou are about to remove ALL attendees from this Activity!\nAre you sure you wish to continue?")) {
          cleanData = "";
          return $.ajax({
            url: sRootPath + "/_com/AJAX_Activity.cfc",
            type: "post",
            data: {
              method: "removeAllAttendees",
              ActivityID: nActivity,
              returnFormat: "plain"
            },
            dataType: "json",
            success: function(data) {
              if (data.STATUS) {
                addMessage(data.STATUSMSG, 250, 6000, 4000);
                updateActions();
                updateStats();
                clearSelectedMembers();
                return refresh(nId, nStatus);
              } else {
                addError(data.STATUSMSG, 250, 6000, 4000);
                updateActions();
                updateStats();
                return refresh();
              }
            }
          });
        }
      });
      $("#PrintCMECert").bind("click", this, function() {
        if ($("#PrintSelected").attr("checked") === "checked") {
          return window.open("http://www.getmycme.com/activities/" + nActivity + "/certificates?attendees=" + selectedAttendees);
        } else {
          return window.open(sMyself + "Report.CMECert?ActivityID=" + nActivity + "&ReportID=5");
        }
      });
      $("#PrintCNECert").bind("click", this, function() {
        if ($("#PrintSelected").attr("checked") === "checked") {
          if (selectedAttendees !== "") {
            return window.open(sMyself + "Report.CNECert?ActivityID=' nActivity + '&ReportID=6&selectedAttendees=" + selectedAttendees);
          } else {
            return addError("You must select registrants", 250, 6000, 4000);
          }
        } else {
          return window.open(sMyself + "Report.CNECert?ActivityID=" + nActivity + "&ReportID=6");
        }
      });
      $(".PrintSigninSheet").bind("click", this, function() {
        if ($("#PrintSelected").attr("checked") === "checked") {
          if (selectedAttendees !== "") {
            if ($.ListGetAt(this.id, 2, "|") === "Y") {
              return window.open(sMyself + "Report.SigninSheet?ActivityID=" + nActivity + "&ssn=1&ReportID=12&selectedAttendees=" + selectedAttendees);
            } else {
              return window.open(sMyself + "Report.SigninSheet?ActivityID=" + nActivity + "&ssn=0&ReportID=12&selectedAttendees=" + selectedAttendees);
            }
          } else {
            return addError("You must select registrants", 250, 6000, 4000);
          }
        } else {
          if ($.ListGetAt(this.id, 2, "|") === "Y") {
            return window.open(sMyself + "Report.SigninSheet?ActivityID=" + nActivity + "&ssn=1&ReportID=12");
          } else {
            return window.open(sMyself + "Report.SigninSheet?ActivityID=" + nActivity + "&ssn=0&ReportID=12");
          }
        }
      });
      $("#PrintMailingLabels").bind("click", this, function() {
        if ($("#PrintSelected").attr("checked") === "checked") {
          if (selectedMembers !== "") {
            return window.open(sMyself + "Report.MailingLabels?ActivityID=" + nActivity + "&ReportID=3&Print=1&selectedAttendees=" + selectedAttendees);
          } else {
            return addError("You must select registrants", 250, 6000, 4000);
          }
        } else {
          return window.open(sMyself + "Report.MailingLabels?ActivityID=" + nActivity + "&ReportID=3&Print=1");
        }
      });
      $("#PrintNameBadges").bind("click", this, function() {
        if ($("#PrintSelected").attr("checked") === "checked") {
          if (selectedMembers !== "") {
            return window.open(sMyself + "Report.NameBadges?ActivityID=" + nActivity + "&selectedMembers=" + selectedMembers);
          } else {
            return addError("You must select registrants", 250, 6000, 4000);
          }
        } else {
          return window.open(sMyself + "Report.NameBadges?ActivityID=" + nActivity + "");
        }
      });
      $(".importDialog").dialog({
        title: "Batch Attendee Import",
        modal: false,
        autoOpen: false,
        height: 200,
        maxWidth: 500,
        buttons: {
          Done: function() {
            refresh();
            $(".importDialog").find("iframe").attr("src", sMyself + "activity.import?activityid=" + nActivity);
            return $(".importDialog").dialog("close");
          }
        }
      });
      $(".newImportDialog").dialog({
        title: "Batch Attendee Import",
        modal: false,
        autoOpen: false,
        height: 550,
        maxWidth: 670,
        buttons: {
          Done: function() {
            refresh();
            $(".newImportDialog").find("iframe").attr("src", "<cfoutput>#Application.Settings.apiUrl#</cfoutput>/imports?importable_id=" + nActivity);
            return $(".newImportDialog").dialog("close");
          }
        }
      });
      $(".batchLink").click(function() {
        return $(".newImportDialog").dialog("open");
      });
      $(".js-change-status").on("click", function() {
        return setCheckedStatuses($(this).data('key'));
      });
      App.trigger("activity.participants.load");
    };
  });

}).call(this);
/*
* ACTIVITY > Participants > AHAH
*/


(function() {
  App.module("Activity.Participants.Ahah", function(Self, App, Backbone, Marionette, $) {
    var CurrPersonID, Parent, nPersonID, sPersonName, _destroy, _init;
    this.startWithParent = false;
    Parent = App.Activity.Participants;
    nPersonID = null;
    sPersonName = null;
    this.on("before:start", function() {
      App.logInfo("starting: Activity.Participants." + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: Activity.Participants." + Self.moduleName);
      });
    });
    this.on("stop", function() {
      $("#ParticipantsContainer").empty();
      App.logInfo("stopped: Activity.Participants." + Self.moduleName);
    });
    CurrPersonID = null;
    _destroy = function() {};
    return _init = function(defaults) {
      var $selectAll, $selectOne;
      $selectAll = $("#ParticipantsContainer").find(".js-select-all");
      $selectOne = $("#ParticipantsContainer").find(".js-select-one");
      $selectAll.on("click", function() {
        App.logDebug("selectAll Clicked");
        if ($selectAll.attr("checked")) {
          $selectOne.each(function() {
            var $row, $this, id;
            $this = $(this);
            $row = $this.parents('.js-row');
            $this.attr("checked", true);
            id = $row.data('key');
            Parent.addSelected(id);
            return $(".js-select-all-rows").find('td').css("background-color", "#FFD");
          });
        } else {
          $selectOne.each(function() {
            var $row, $this, id;
            $this = $(this);
            $row = $this.parents('.js-row');
            $this.attr("checked", false);
            id = $row.data('key');
            Parent.removeSelected(id);
            return $(".js-select-all-rows").find('td').css("background-color", "#FFF");
          });
        }
      });
      $selectOne.on("click", function() {
        var $row, $this, id;
        $this = $(this);
        $row = $this.parents('.js-row');
        App.logDebug("selectOne Clicked");
        if ($this.attr("checked")) {
          id = $row.data('key');
          Parent.addSelected(id);
          $("#PersonRow" + nPersonID).find('td').css("background-color", "#FFD");
        } else {
          id = $row.data('key');
          Parent.removeSelected(id);
          $("#PersonRow" + nPersonID).find('td').css("background-color", "#FFF");
        }
      });
      $(".js-row").each(function() {
        var $deleteLink, $personLink, $row, person_id, row_id;
        $row = $(this);
        row_id = $row.data('key');
        person_id = $row.data('personkey');
        $row.isPerson();
        if (person_id > 0) {
          $personLink = $row.find('.PersonLink');
        } else {
          $deleteLink = $row.find(".deleteLink");
          $deleteLink.one("click", function() {
            return $.ajax({
              type: "post",
              url: "/admin/_com/ajax_activity.cfc",
              dataType: "json",
              data: {
                method: "removeAttendeeByID",
                attendeeId: row_id
              },
              async: false,
              success: function(data) {
                if (data.STATUS) {
                  return $row.remove();
                }
              }
            });
          });
        }
        return $row.find('.StatusDate .label').popover({
          placement: 'top',
          trigger: 'hover',
          html: true,
          container: 'body'
        });
      });
      App.logInfo("binding records");
      $(".js-status-selected-count").text(SelectedCount);
    };
  });

}).call(this);
/*
* Activity > PHOTOUPLOAD
*/


(function() {
  App.module("Activity.PhotoUpload", function(Self, App, Backbone, Marionette, $) {
    var _init;
    this.startWithParent = false;
    this.on("before:start", function() {
      App.logInfo("starting: Activity." + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: Activity." + Self.moduleName);
      });
    });
    this.on("stop", function() {
      App.logInfo("stopped: Activity." + Self.moduleName);
    });
    return _init = function() {
      var $uploadField, $uploadForm, $uploadObj;
      $uploadField = $('.js-upload-field');
      $uploadForm = $('.js-upload-form');
      $uploadObj = $('.profile-picture');
      $uploadField.on('change', function(e) {
        e.preventDefault;
        return $uploadForm.ajaxSubmit({
          url: '/admin/_com/ajax_activity.cfc?method=saveprimaryphoto&ActivityID=' + App.Activity.model.get('id'),
          target: $uploadObj,
          dataType: 'json',
          beforeSubmit: function(formData, jqForm, options) {
            var queryString;
            queryString = $.param(formData);
            $uploadObj.addClass('faded');
            return true;
          },
          uploadProgress: function(e, pos, tot, perc) {
            return console.log('testing');
          },
          success: function(data) {
            $uploadObj.removeClass('faded');
            if (data.STATUS) {
              addMessage(data.STATUSMSG, 250, 6000, 4000);
              return $uploadObj.css('background-image', 'url("' + data.DATASET.path + data.DATASET.hash + '.jpg")');
            }
          },
          error: function(data) {
            return $uploadObj.removeClass('faded');
          },
          reset: true
        });
      });
    };
  });

}).call(this);
/*!
* ACTIVITY > PUBLISH
*/


(function() {
  App.module("Activity.Publish", function(Self, App, Backbone, Marionette, $) {
    var _init;
    this.startWithParent = false;
    this.on("before:start", function() {
      App.logInfo("starting: " + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: " + Self.moduleName);
      });
    });
    this.on("stop", function() {
      App.logInfo("stopped: " + Self.moduleName);
      $.each(Self.submodules, function(i, module) {
        module.stop();
      });
    });
    return _init = function(defaults) {};
  });

}).call(this);
/*
* ACTIVITY > REPORTS
*/


(function() {
  App.module("Activity.Reports", function(Self, App, Backbone, Marionette, $) {
    var _init;
    this.startWithParent = false;
    this.on("before:start", function() {
      App.logInfo("starting: " + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: " + Self.moduleName);
      });
    });
    this.on("stop", function() {
      App.logInfo("stopped: " + Self.moduleName);
    });
    return _init = function(defaults) {
      var $reportArea, $reportItems;
      $reportArea = $("#js-activity-reports");
      $reportItems = $reportArea.find(".report-item");
      $reportItems.each(function() {
        var $item, $itemCriteria, $itemForm, $itemGroup, $itemLink, $itemTitle;
        $item = $(this);
        $itemForm = $item.find('form');
        $itemGroup = $item.parents('.report-group');
        $itemTitle = $item.find('.report-item-title');
        $itemTitle.wrapInner('<a href="javascript://"></a>');
        $itemLink = $item.find('.report-item-title > a');
        $itemCriteria = $item.find('.report-item-criteria');
        $itemLink.on('click', function(e) {
          $item.siblings().removeClass('activated');
          $itemGroup.siblings().find('.report-item').removeClass('activated');
          $item.addClass('activated');
          e.preventDefault();
        });
      });
    };
  });

}).call(this);
/*
* ACTIVITY > FOLDERS
*/


(function() {
  App.module("Activity.Stats", function(Self, App, Backbone, Marionette, $) {
    var $icon, $refreshLink, $stats, $statsContainer, $statsLoading, recalculate, refresh, _init;
    this.startWithParent = true;
    this.on("before:start", function() {
      App.logInfo("starting: " + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: " + Self.moduleName);
      });
    });
    this.on("stop", function() {
      App.logInfo("stopped: " + Self.moduleName);
    });
    $stats = null;
    $statsContainer = null;
    $statsLoading = null;
    $icon = null;
    $refreshLink = null;
    refresh = Self.refresh = function(callback) {
      var cb;
      cb = callback;
      $.post(sMyself + "Activity.Stats", {
        ActivityID: nActivity
      }, function(data) {
        $stats.html(data);
        Self.trigger('refresh.complete');
        return cb(true);
      });
    };
    this.on("refresh.complete", function() {
      $stats.append($refreshLink);
      $stats.css('color', '#333');
      $icon.removeClass('icon-spin');
      $refreshLink.click(function() {
        return recalculate();
      });
    });
    this.on("recalculate.start", function() {
      $icon.addClass('icon-spin');
      $stats.css('color', '#EEE');
    });
    this.on("recalculate.end", function() {
      refresh(function() {});
    });
    recalculate = Self.recalc = function() {
      Self.trigger('recalculate.start');
      $icon.addClass('icon-spin');
      $.ajax({
        url: "/admin/_com/scripts/statFixer.cfc",
        type: "post",
        async: false,
        dataType: "json",
        data: {
          method: "run",
          returnFormat: "plain",
          mode: "manual",
          activityId: nActivity
        },
        success: function(data) {
          if (data.STATUS) {
            $statsContainer.css('color', '#333');
            return Self.trigger('recalculate.end');
          } else {
            $statsLoading.hide();
            $statsContainer.show();
            return Self.trigger('recalculate.end');
          }
        }
      });
    };
    return _init = function() {
      $stats = $("#ActivityStats");
      $statsContainer = $("#stats-container");
      $statsLoading = $("#stats-loading");
      $icon = $('<i class="icon-arrows-cw"></i>');
      $refreshLink = $("<a></a>").addClass('btn btn-default stats-refresher js-stats-refresher').html($icon);
      refresh(function() {});
    };
  });

}).call(this);
/*
* PERSON > ACTIVITIES
*/


(function() {
  App.module("Person.Activities", function(Self, App, Backbone, Marionette, $) {
    var $base, $transcriptDates, moveActivities, moveMarkup, openTranscript, _init;
    this.startWithParent = false;
    $base = null;
    $transcriptDates = null;
    this.config = {
      transcript: {
        height: 50,
        width: 50
      }
    };
    moveMarkup = '<div class="js-move-activities modal">\
                  <div class="modal-header">\
                     <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>\
                      <h3 id="myModalLabel">Move Activities</h3>\
                  </div>\
                  <div class="modal-body">\
                    <form action="" method="post" name="formMoveActivities" class="form-horizontal">\
                      <div class="control-group">\
                        <label class="control-label">From</label>\
                        <div class="controls">\
                          <input type="text" name="moveFromPersonID" class="js-typeahead-person-from" />\
                        </div>\
                      </div>\
                      <div class="control-group">\
                        <label class="control-label">Move To</label>\
                        <div class="controls">\
                          <input type="text" name="moveToPersonID" class="js-typeahead-person-to" />\
                        </div>\
                      </div>\
                      <div class="control-group">\
                        <div class="controls"><input type="submit" value="Move Activities" /></div>\
                      </div>\
                    </form>\
                  </div>\
                  <div class="modal-footer">\
                    <button class="btn btn-primary">Move Now</button>\
                    <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>\
                  </div>\
                </div>';
    this.on("before:start", function() {
      App.logInfo("starting: Person." + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        $base = $("#js-person-activities");
        _init();
        return App.logInfo("started: Person." + Self.moduleName);
      });
    });
    this.on("stop", function() {
      App.logInfo("stopped: Person." + Self.moduleName);
    });
    _init = function() {
      var $moveBtn, $moveForm, $moveFromInput, $moveModal, $moveScreen, $moveToInput, $transcriptButton, $transcriptEnd, $transcriptMenu, $transcriptStart;
      $transcriptMenu = $base.find(".js-transcript-menu");
      $transcriptDates = $base.find(".js-transcript-date");
      $transcriptStart = $($transcriptDates[0]);
      $transcriptEnd = $($transcriptDates[1]);
      $transcriptButton = $base.find(".js-transcript-button");
      $moveScreen = $(moveMarkup);
      $moveForm = $moveScreen.find('form');
      $moveFromInput = $($moveForm.find(".js-typeahead-person-from"));
      $moveToInput = $($moveForm.find(".js-typeahead-person-to"));
      $moveFromInput.uiTypeahead({
        showImage: false,
        allowAdd: false,
        ajaxSearchURL: "/admin/_com/ajax/typeahead.cfc",
        ajaxSearchParams: {
          method: "search",
          type: "person"
        },
        defaultValue: {
          id: App.Person.model.get('id'),
          label: App.Person.model.get('name'),
          value: App.Person.model.get('id')
        }
      });
      $moveToInput.uiTypeahead({
        showImage: false,
        allowAdd: false,
        ajaxSearchURL: "/admin/_com/ajax/typeahead.cfc",
        ajaxSearchParams: {
          method: "search",
          type: "person"
        }
      });
      $moveForm.submit(function() {
        return false;
      });
      $moveModal = $moveScreen.modal({
        backdrop: true,
        keyboard: true,
        show: false
      });
      $transcriptButton.on("click", function() {
        var endDate, formattedEndDate, formattedStartDate, startDate;
        startDate = Date.parseString($transcriptStart.val());
        endDate = Date.parseString($transcriptEnd.val());
        if (!(_.isDate(startDate) && _.isDate(endDate))) {
          return addError("Please ensure you have specified a valid Start and End Date.");
        }
        formattedStartDate = startDate.format('MM/dd/yyyy');
        formattedEndDate = endDate.format('MM/dd/yyyy');
        return openTranscript(formattedStartDate, formattedEndDate);
      });
      $moveBtn = $base.find(".js-moveactivities");
      $moveBtn.on("click", function() {
        $moveModal.modal("show");
      });
      $transcriptMenu.next().find("form").on("click", function(e) {
        e.stopPropagation();
      });
      $transcriptDates.datepicker({
        showOn: "button",
        buttonImage: "/admin/_images/icons/calendar.png",
        buttonImageOnly: true,
        showButtonPanel: true,
        changeMonth: true,
        changeYear: true
      });
    };
    openTranscript = function(start, end) {
      var cfg, transcriptWindow, urlPath, windowSettings;
      cfg = Self.config.transcript;
      windowSettings = "height=" + cfg.height + ",width=" + cfg.width + ",location=0,menubar=0,resizable=no,scrollbars=0,status=0,centerscreen=yes";
      urlPath = "" + (App.config.get('apiUrl')) + "/users/" + App.Person.data.id + "/transcript?startdate=" + start + "&enddate=" + end;
      transcriptWindow = window.open(urlPath, "transcript_show", windowSettings);
      if (window.focus) {
        transcriptWindow.focus();
      }
      return false;
    };
    return moveActivities = function() {
      var bMove, nPersonID, sPersonName;
      if ($("#MoveActivitiesID").val() !== "") {
        bMove = confirm("Are you sure you want to move the activites from " + sFullName + " to" + $.ListGetAt($("#MoveActivitiesName").val(), 2, ",") + $.ListGetAt($("#MoveActivitiesName").val(), 1, ",") + "?");
        if (bMove) {
          nPersonID = $("#MoveActivitiesID").val();
          sPersonName = $.ListGetAt($("#MoveActivitiesName").val(), 2, ",") + $.ListGetAt($("#MoveActivitiesName").val(), 1, ",");
          return $.getJSON(sRootPath + "/_com/AJAX_Person.cfc", {
            method: "moveActivities",
            MoveToPersonID: nPersonID,
            MoveToName: sPersonName,
            MoveFromPersonID: nPerson,
            MoveFromName: sFullName,
            returnFormat: "plain"
          }, function(data) {
            return window.location = sMyself + "Person.Activities?PersonID=" + nPersonID + "&Message=" + data.STATUSMSG;
          });
        }
      }
    };
  });

}).call(this);
/*
* PERSON > ADDRESSES
*/


(function() {
  App.module("Person.Addresses", function(Self, App, Backbone, Marionette, $) {
    var $addLink, $addressForm, $ahahContainer, $ahahLoading, $base, $editDialog, deleteAddress, editAddress, loadForm, makePrimary, newAddress, refresh, _init;
    this.startWithParent = false;
    $base = null;
    $ahahContainer = null;
    $ahahLoading = null;
    $editDialog = null;
    $addLink = null;
    $addressForm = null;
    this.on("before:start", function() {
      App.logInfo("starting: Person." + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        $base = $("#js-person-address");
        _init();
        return App.logInfo("started: Person." + Self.moduleName);
      });
    });
    this.on("stop", function() {
      App.logInfo("stopped: Person." + Self.moduleName);
    });
    this.on("address:save", function(response) {
      if (response.STATUS) {
        $editDialog.dialog("close");
        addMessage(response.STATUSMSG, 250, 6000, 4000);
        refresh();
      } else {
        addError(response.STATUSMSG, 250, 6000, 4000);
      }
    });
    this.on("form:loaded", function(markup) {
      var $canada, $countryField, $locationField, $markup, $usa, updateStateProvince;
      App.logDebug("Address Form LOADED");
      $markup = $(markup);
      $addressForm = $markup;
      $countryField = $addressForm.find("#editaddress-country");
      $canada = $addressForm.find(".canada");
      $usa = $addressForm.find(".unitedstates");
      $locationField = $addressForm.find(".js-typeahead-city");
      $locationField.uiTypeahead({
        showImage: false,
        allowAdd: false,
        ajaxSearchURL: "/admin/_com/ajax/typeahead.cfc",
        ajaxSearchParams: {
          method: "search",
          type: "city"
        }
      });
      updateStateProvince = function(country_id) {
        App.logDebug("country: " + country_id);
        if (parseInt(country_id) === 230) {
          $canada.hide();
          $usa.show();
        } else if (parseInt(country_id) === 39) {
          $usa.hide();
          $canada.show();
        } else {
          $usa.hide();
          $canada.hide();
        }
      };
      updateStateProvince($countryField.val());
      $countryField.change(function() {
        updateStateProvince($(this).val());
      });
      $addressForm.on("submit", function() {
        $(this).ajaxSubmit({
          url: sRootPath + "/_com/AJAX_Person.cfc",
          type: 'post',
          dataType: 'json',
          success: function(data) {
            return Self.trigger('address:save', data);
          }
        });
        return false;
      });
      $editDialog.html($addressForm);
      $editDialog.dialog({
        title: "Address Information",
        modal: true,
        autoOpen: false,
        height: 450,
        width: 600,
        draggable: false,
        resizable: false,
        buttons: {
          Save: function() {
            $addressForm.submit();
          },
          Cancel: function() {
            $(this).dialog("close");
          }
        },
        open: function() {},
        close: function() {
          $(this).html("");
        }
      });
      Self.trigger("form:ready");
    });
    this.on("form:ready", function() {
      App.logDebug("Address Form is Ready!");
      $editDialog.dialog("open");
    });
    this.on("ahah:ready", function(markup) {
      $ahahContainer.html(markup);
      $ahahLoading.hide();
      $ahahContainer.find(".js-list-row").each(function() {
        var $delete, $edit, $phones, $primary, $row, $tooltips, address_id, countryCode;
        $row = $(this);
        address_id = $row.data('key');
        $tooltips = $row.find('[data-tooltip-title]');
        $edit = $row.find('.address-edit');
        $delete = $row.find('.address-delete');
        $primary = $row.find('.address-makeprimary');
        countryCode = $row.find(".js-country-code");
        $phones = $row.find(".js-phonenumber");
        if (!countryCode) {
          countryCode = 'US';
        }
        $phones.each(function() {
          var $phoneSpace, formattedPhone, phoneNumber;
          $phoneSpace = $(this);
          phoneNumber = $phoneSpace.text();
          formattedPhone = PhoneNumber.Parse(phoneNumber);
          console.log(phoneNumber);
          console.log(formattedPhone);
        });
        $primary.on("click", function() {
          makePrimary(address_id);
        });
        $edit.on("click", function() {
          editAddress(address_id);
        });
        $delete.on("click", function() {
          var ConfirmDelete;
          ConfirmDelete = confirm("Are you sure you want to delete this address?");
          if (ConfirmDelete) {
            deleteAddress(address_id);
          }
        });
        $tooltips.tooltip({
          placement: 'top',
          html: 'true',
          trigger: 'hover focus',
          title: function(e) {
            return $(this).attr('data-tooltip-title');
          },
          container: $ahahContainer
        });
        $row.hover(function() {
          return $(this).addClass('hovered');
        }, function() {
          return $(this).removeClass('hovered');
        });
      });
    });
    _init = function() {
      $ahahContainer = $base.find("#AddressesContainer");
      $ahahLoading = $base.find("#AddressesLoading");
      $editDialog = $('<div id="address-info"></div>');
      $editDialog.appendTo('body');
      $addLink = $base.find(".address-add");
      refresh();
      return $addLink.on("click", function() {
        return newAddress();
      });
    };
    makePrimary = Self.makePrimary = function(address_id) {
      return $.ajax({
        url: "/admin/_com/AJAX_Person.cfc",
        dataType: 'json',
        type: 'post',
        data: {
          method: 'setPrimaryAddress',
          returnformat: 'plain',
          person_id: nPerson,
          address_id: address_id
        },
        success: function(data) {
          if (data.STATUS) {
            refresh();
            addMessage(data.STATUSMSG);
          } else {
            addError(data.STATUSMSG);
          }
        }
      });
    };
    editAddress = Self.editAddress = function(address_id) {
      return loadForm(address_id);
    };
    deleteAddress = Self.editAddress = function(address_id) {
      return $.ajax({
        url: sRootPath + "/_com/AJAX_Person.cfc",
        dataType: 'json',
        type: 'post',
        data: {
          method: "deleteAddress",
          PersonID: nPerson,
          AddressID: address_id,
          returnFormat: "plain"
        },
        success: function(data) {
          if (data.STATUS) {
            addMessage(data.STATUSMSG, 250, 6000, 4000);
            refresh();
          } else {
            addError(data.STATUSMSG, 250, 6000, 4000);
          }
        }
      });
    };
    newAddress = Self.newAddress = function() {
      return loadForm(0);
    };
    loadForm = Self.loadForm = function(address_id) {
      return $.ajax({
        url: sMyself + "Person.EditAddress",
        dataType: 'html',
        type: 'get',
        data: {
          PersonID: nPerson,
          AddressID: address_id
        },
        success: function(data, text, xhr) {
          var markup;
          markup = $.trim(data);
          Self.trigger('form:loaded', markup);
        }
      });
    };
    return refresh = Self.refresh = function() {
      return $.ajax({
        url: sMyself + "Person.AddressAHAH",
        type: 'get',
        dataType: 'html',
        data: {
          PersonID: nPerson
        },
        success: function(data) {
          return Self.trigger("ahah:ready", data);
        }
      });
    };
  });

}).call(this);
/*
* PERSON > ADDRESSES
*/


(function() {
  App.module("Person.Emails", function(Self, App, Backbone, Marionette, $) {
    var $addBox, $addForm, $ahahContainer, $ahahLoading, $base, $cancelLink, $emailField, $saveLink, addEmail, allowLoginFunc, currElem, deleteFunc, nId, refresh, setPrimaryEmail, verifyFunc, _init;
    this.startWithParent = false;
    $base = null;
    $ahahContainer = null;
    $ahahLoading = null;
    $addBox = null;
    $addForm = null;
    $emailField = null;
    $cancelLink = null;
    $saveLink = null;
    nId = 0;
    currElem = null;
    this.on("before:start", function() {
      App.logInfo("starting: Person." + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        $base = $("#js-person-email");
        _init();
        return App.logInfo("started: Person." + Self.moduleName);
      });
    });
    this.on("stop", function() {
      $base.empty().remove();
      App.logInfo("stopped: Person." + Self.moduleName);
    });
    this.on("ahah:ready", function(markup) {
      $ahahContainer.html(markup);
      $ahahLoading.hide();
      return $(".view-row").each(function() {
        var $delete, $login, $primary, $row, $tooltips, $verify, email_id;
        $row = $(this);
        email_id = $row.data('key');
        $tooltips = $row.find('[data-tooltip-title]');
        $delete = $row.find(".delete-link");
        $verify = $row.find(".isverified-link");
        $primary = $row.find(".makeprimary-link");
        $login = $row.find(".allowlogin-link");
        $delete.on("click", function() {
          deleteFunc(email_id, $row);
        });
        $primary.on("click", function() {
          setPrimaryEmail(email_id);
        });
        $verify.on("click", function() {
          verifyFunc(email_id);
        });
        $login.on("click", function() {
          var action, theVal;
          action = $(this).data('button-action');
          if (action === 'enable') {
            theVal = 1;
          } else {
            theVal = 0;
          }
          allowLoginFunc(email_id, theVal);
        });
        $tooltips.tooltip({
          placement: 'top',
          html: 'true',
          trigger: 'hover focus',
          title: function(e) {
            return $(this).attr('data-tooltip-title');
          },
          container: $ahahContainer
        });
        return $row.hover(function() {
          return $(this).addClass('hovered');
        }, function() {
          return $(this).removeClass('hovered');
        });
      });
    });
    _init = function() {
      var $addLink;
      $ahahContainer = $base.find("#EmailContainer");
      $ahahLoading = $base.find("#EmailLoading");
      $addBox = $base.find('.js-email-add');
      $addForm = $base.find('form');
      $emailField = $addForm.find('.email_address');
      $cancelLink = $addForm.find(".cancel-link");
      $saveLink = $addForm.find(".save-link");
      $addLink = $base.find('#addEmailAddress');
      $cancelLink.click(function() {
        $emailField.val('');
        $addBox.hide();
      });
      $addForm.submit(function(e) {
        $addForm.ajaxSubmit({
          type: "post",
          dataType: "json",
          success: function(data) {
            if (data.STATUS) {
              addMessage(data.STATUSMSG, 250, 6000, 4000);
              currElem = "";
              refresh();
            } else {
              if (data.ERRORS.length > 0) {
                $.each(data.ERRORS, function(i, item) {
                  return addError(item.MESSAGE, 250, 6000, 4000);
                });
              } else {
                addError(data.STATUSMSG, 250, 6000, 4000);
              }
            }
          }
        });
        return false;
      });
      refresh();
      $addLink.click(function() {
        return addEmail();
      });
    };
    addEmail = function() {
      $addBox.show();
      return $emailField.focus();
    };
    deleteFunc = function(email_id, $row) {
      var $viewRow, emailAddress, emailId;
      emailId = email_id;
      $viewRow = $row;
      emailAddress = $viewRow.find(".email-address").text();
      if (confirm("Are you sure you want to delete the email address '" + emailAddress + "'?  It will be permanently removed from the database.")) {
        if (emailId !== 0) {
          $.ajax({
            url: sRootPath + "/_com/ajax_person.cfc",
            type: "post",
            data: {
              method: "deleteEmail",
              person_id: nPerson,
              email_id: emailId,
              returnFormat: "plain"
            },
            dataType: "json",
            success: function(data) {
              if (data.STATUS) {
                addMessage(data.STATUSMSG, 250, 6000, 4000);
                return refresh();
              } else {
                if (data.ERRORS.length > 0) {
                  return $.each(data.ERRORS, function(i, item) {
                    return addError(item.MESSAGE, 250, 6000, 4000);
                  });
                } else {
                  return addError(data.STATUSMSG, 250, 6000, 4000);
                }
              }
            }
          });
          return $row.remove();
        }
      }
    };
    setPrimaryEmail = function(email_id) {
      var emailId;
      emailId = email_id;
      return $.ajax({
        url: sRootPath + "/_com/ajax_person.cfc",
        type: "post",
        data: {
          method: "setPrimaryEmail",
          email_id: emailId,
          person_id: nPerson,
          returnFormat: "plain"
        },
        dataType: "json",
        success: function(data) {
          if (data.STATUS) {
            addMessage(data.STATUSMSG, 250, 6000, 4000);
            return refresh();
          } else {
            return addError(data.STATUSMSG, 250, 6000, 4000);
          }
        }
      });
    };
    refresh = Self.refresh = function() {
      return $.ajax({
        url: sMyself + "Person.EmailAHAH",
        type: 'get',
        dataType: 'html',
        data: {
          PersonID: nPerson
        },
        success: function(data) {
          return Self.trigger("ahah:ready", data);
        }
      });
    };
    allowLoginFunc = function(email_id, value) {
      var emailId;
      emailId = email_id;
      $.ajax({
        url: sRootPath + "/_com/ajax_person.cfc",
        type: "post",
        data: {
          method: "setAllowLogin",
          email_id: emailId,
          value: value,
          returnFormat: "plain"
        },
        dataType: "json",
        success: function(data) {
          if (data.STATUS) {
            refresh();
            return addMessage(data.STATUSMSG, 250, 6000, 4000);
          } else {
            return addError(data.STATUSMSG, 250, 6000, 4000);
          }
        }
      });
    };
    verifyFunc = function(email_id) {
      var emailId;
      emailId = email_id;
      $.ajax({
        url: sRootPath + "/_com/ajax_person.cfc",
        type: "post",
        data: {
          method: "sendVerificationEmail",
          email_id: emailId,
          returnFormat: "plain"
        },
        dataType: "json",
        success: function(data) {
          if (data.STATUS) {
            return addMessage(data.STATUSMSG, 250, 6000, 4000);
          } else {
            return addError(data.STATUSMSG, 250, 6000, 4000);
          }
        }
      });
    };
  });

}).call(this);
/*
* PERSON > FINDER
*/


(function() {
  App.module("Person.Finder", function(Self, App, Backbone, Marionette, $) {
    var _init;
    this.startWithParent = false;
    this.on("before:start", function() {
      App.logInfo("starting: Person." + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: Person." + Self.moduleName);
      });
    });
    this.on("stop", function() {
      App.logInfo("stopped: Person." + Self.moduleName);
    });
    return _init = function() {};
  });

}).call(this);
/*
* PERSON > GENERAL INFORMATION
*/


(function() {
  App.module("Person.GeneralInfo", function(Self, App, Backbone, Marionette, $) {
    var $base, $certName, $displayName, $firstName, $form, $lastName, $middleName, $suffix, $suggestionsList, FormState, NameTmpls, makeCertName, suggestionItem, updateCertNameValue, updateSuggestions, _init;
    this.startWithParent = false;
    FormState = null;
    $base = null;
    $form = null;
    $firstName = null;
    $middleName = null;
    $lastName = null;
    $suffix = null;
    $displayName = null;
    $certName = null;
    $suggestionsList = null;
    NameTmpls = [];
    suggestionItem = _.template('<div class="item" data-suggestion="<%=suggestion%>"><a href="#"><%=suggestion%></a></div>');
    makeCertName = function(str) {
      return _.template(str);
    };
    NameTmpls.push(makeCertName("<% if (firstname) { %><%= firstname %><% } %><% if (middlename) { %> <%= middlename %><% } %><% if (lastname) { %> <%= lastname %><% } %><% if (suffix) { %>, <%= suffix %><% } %>"));
    NameTmpls.push(makeCertName("<% if (firstname) { %><%= firstname %><% } %><% if (middlename) { %> <%= middlename.substring(0,1) %>.<% } %><% if (lastname) { %> <%= lastname %><% } %><% if (suffix) { %>, <%= suffix %><% } %>"));
    NameTmpls.push(makeCertName("<% if (firstname) { %><%= firstname.substring(0,1) %>.<% } %><% if (middlename) { %> <%= middlename %><% } %><% if (lastname) { %> <%= lastname %><% } %><% if (suffix) { %>, <%= suffix %><% } %>"));
    NameTmpls.push(makeCertName("<% if (firstname) { %><%= firstname.substring(0,1) %>.<% } %><% if (middlename) { %> <%= middlename.substring(0,1) %>.<% } %><% if (lastname) { %> <%= lastname %><% } %><% if (suffix) { %>, <%= suffix %><% } %>"));
    NameTmpls.push(makeCertName("<% if (firstname) { %><%= firstname %><% } %><% if (lastname) { %> <%= lastname %><% } %><% if (suffix) { %>, <%= suffix %><% } %>"));
    NameTmpls.push(makeCertName("<% if (firstname) { %><%= firstname.substring(0,1) %>.<% } %><% if (lastname) { %> <%= lastname %><% } %><% if (suffix) { %>, <%= suffix %><% } %>"));
    this.on("before:start", function() {
      App.logInfo("starting: Person." + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: Person." + Self.moduleName);
      });
    });
    this.on("stop", function() {
      App.logInfo("stopped: Person." + Self.moduleName);
      FormState = null;
    });
    _init = function() {
      var $suggestionInputs;
      $base = $("#js-person-detail");
      $form = $base.find('.js-formstate');
      $firstName = $form.find("[name='firstname']");
      $middleName = $form.find("[name='middlename']");
      $lastName = $form.find("[name='lastname']");
      $suffix = $form.find("[name='suffix']");
      $certName = $form.find("[name='certname']");
      $displayName = $form.find(".js-displayname-input");
      $suggestionsList = $form.find(".js-suggestions-list");
      $suggestionInputs = $(".js-suggest-input");
      FormState = new App.Components.FormState({
        el: '#js-person-detail .js-formstate',
        saved: true
      });
      FormState.on("beforeSave", function() {
        $certName.val($displayName.val());
      });
      updateSuggestions();
      $(".certname").click(function() {
        return updateCertNameValue($(this).val());
      });
      $("#certnamecustom").keyup(function() {
        return updateCertNameValue($(this).val());
      });
      if ($(".certname").attr("checked") === false && sCertName !== "") {
        $("#certnamecustom").val(sCertName);
        $("#certname-7").attr("checked", true);
      }
      $suggestionInputs.on("keyup", function() {
        return updateSuggestions();
      });
    };
    updateSuggestions = function() {
      var context, suggestions;
      $suggestionsList.empty();
      context = {
        'firstname': $.trim($firstName.val()),
        'middlename': $.trim($middleName.val()),
        'lastname': $.trim($lastName.val()),
        'suffix': $.trim($suffix.val())
      };
      suggestions = _.map(NameTmpls, function(suggestion, i, newList) {
        return suggestion(context);
      });
      suggestions = _.unique(suggestions);
      _.each(suggestions, function(suggestion) {
        var $suggestion;
        $suggestion = $(suggestionItem({
          'suggestion': suggestion
        }));
        $suggestion.on("click", function(e) {
          var suggestText;
          suggestText = $(this).data('suggestion');
          $displayName.val(suggestText).keyup();
          e.preventDefault();
        });
        return $suggestionsList.append($suggestion);
      });
      if ($.trim($displayName.val()) === "" && !_.isEmpty(suggestions)) {
        $displayName.val(suggestions[0]);
      }
    };
    return updateCertNameValue = function(sName) {
      $("#certnamecustom").val(sName);
      $("#certname-7").val(sName);
    };
  });

}).call(this);
/*
* PERSON > HISTORY
*/


(function() {
  App.module("Person.History", function(Self, App, Backbone, Marionette, $) {
    var _init;
    this.startWithParent = false;
    this.on("before:start", function() {
      App.logInfo("starting: Person." + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: Person." + Self.moduleName);
      });
    });
    this.on("stop", function() {
      App.logInfo("stopped: Person." + Self.moduleName);
    });
    return _init = function() {
      this.feed = new App.Components.NewsFeed({
        el: '#js-person-history .js-newsfeed',
        defaultMode: 'personAll',
        hub: 'person',
        modes: ["personAll", "personFrom", "personTo"],
        queryParams: {
          personFrom: App.Person.model.get('id'),
          personTo: App.Person.model.get('id')
        }
      });
    };
  });

}).call(this);
/*!
* PERSON > NOTES
*/


(function() {
  App.module("Person.Notes", function(Self, App, Backbone, Marionette, $) {
    var $noteAddBtn, $noteContent, $notebody, $notebox, $notedummy, $notelist, $notes, deleteNote, note, noteMarkup, resetForm, _init;
    this.startWithParent = false;
    $noteContent = null;
    $notes = null;
    $notebox = null;
    $notebody = null;
    $notelist = null;
    $notedummy = null;
    $noteAddBtn = null;
    noteMarkup = '<div class="divider">\
                  <hr>\
                </div>\
                <div class="post-row row-fluid" data-key="<%=id%>">\
                  <div class="post-item span24">\
                    <div class="post-author">\
                      <a href="/admin/event/Person.Detail?PersonID=<%=author.id%>" title="View Profile"><%=author.name%></a>\
                    </div>\
                    <div class="post-body">\
                       <%=body%>\
                    </div>\
                    <div class="post-meta">\
                      <i class="icon-calendar"></i> <%=timestamp%>\
                      <a href="javascript://" class="js-notedelete"><i class="icon-trash"></i></a>\
                    </div>\
                  </div>\
                </div>';
    note = _.template(noteMarkup);
    this.on("before:start", function() {
      App.logInfo("starting: Person." + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: Person." + Self.moduleName);
      });
    });
    this.on("stop", function() {
      $noteContent.empty();
      App.logInfo("stopped: Person." + Self.moduleName);
    });
    this.on("noteDeleted", function(n) {
      var $deleteNote;
      App.logInfo("Deleted Note: " + n);
      $deleteNote = $notes.filter("[data-key='" + n + "']");
      $deleteNote.prev().remove();
      $deleteNote.remove();
    });
    Self.resetForm = resetForm = function() {
      $notebody.val('');
      $notebody.blur();
    };
    _init = function(defaults) {
      $noteContent = $("#js-person-notes");
      $notebox = $noteContent.find(".js-notebox");
      $notebody = $noteContent.find(".js-note-body");
      $notelist = $noteContent.find(".posts-list");
      $notes = $notelist.find('.post-item');
      $notedummy = $noteContent.find(".js-dummynote");
      $noteAddBtn = $noteContent.find(".js-note-actions .addNote");
      App.logDebug($notelist);
      $notebody.autosize();
      $notedummy.on("click", function() {
        $notebox.addClass("activated");
        $notebody.focus();
      });
      $notebody.on("focus", function() {
        $notebox.addClass("focused");
      });
      $notebody.on("blur", function() {
        if ($(this).val() === "") {
          $notebox.removeClass("activated focused");
        } else {
          $notebox.removeClass("focused");
        }
      });
      $noteAddBtn.on("click", function(e) {
        var sBody;
        sBody = $notebody.val();
        sBody = sBody.replace(/\n/g, '<br />');
        $.ajax({
          url: sRootPath + "/_com/AJAX_Person.cfc",
          type: "post",
          dataType: "json",
          data: {
            method: "saveNote",
            PersonID: nPerson,
            NoteBody: sBody,
            returnFormat: "plain"
          },
          success: function(data) {
            var $newNote, $newNoteRow, payLoad;
            if (data.STATUS) {
              addMessage(data.STATUSMSG, 250, 2500, 2500);
              payLoad = data.PAYLOAD;
              $newNoteRow = $(note(payLoad));
              $newNote = $newNoteRow.find('.post-item');
              $newNote.find(".js-notedelete").on("click", function() {
                deleteNote($newNote);
              });
              $notelist.prepend($newNoteRow);
              return resetForm();
            } else {
              return addError(data.STATUSMSG, 250, 2500, 2500);
            }
          }
        });
        return e.preventDefault();
      });
      $notes.each(function() {
        var $note, $noteDelete, $noteDivider, $noteRow, note_id;
        $note = $(this);
        $noteDelete = $note.find('.js-notedelete');
        $noteRow = $note.parents('.post-row');
        $noteDivider = $noteRow.prev();
        note_id = $noteRow.data('key');
        return $noteDelete.on("click", function(e) {
          deleteNote($note);
          return e.preventDefault();
        });
      });
    };
    return deleteNote = function($el) {
      var $note, $row, note_id;
      $note = $el;
      $row = $el.parents('.post-row');
      console.log($note);
      console.log($row);
      note_id = $row.data('key');
      if (confirm("Are you sure you want to delete this note?")) {
        return $.ajax({
          url: sRootPath + "/_com/AJAX_Person.cfc",
          dataType: 'json',
          type: 'post',
          data: {
            method: "deleteNote",
            noteid: note_id,
            returnFormat: "plain"
          },
          success: function(data) {
            if (data.STATUS) {
              $row.prev().remove();
              $row.remove();
              parent.addMessage(data.STATUSMSG, 250, 2500, 2500);
            } else {
              parent.addError(data.STATUSMSG, 250, 2500, 2500);
            }
          }
        });
      }
    };
  });

}).call(this);
/*
* PERSON > PHOTOUPLOAD
*/


(function() {
  App.module("Person.PhotoUpload", function(Self, App, Backbone, Marionette, $) {
    var _init;
    this.startWithParent = false;
    this.on("before:start", function() {
      App.logInfo("starting: Person." + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: Person." + Self.moduleName);
      });
    });
    this.on("stop", function() {
      App.logInfo("stopped: Person." + Self.moduleName);
    });
    return _init = function() {
      var $uploadField, $uploadForm, $uploadObj;
      $uploadField = $('.js-upload-field');
      $uploadForm = $('.js-upload-form');
      $uploadObj = $('.profile-picture');
      $uploadField.on('change', function(e) {
        e.preventDefault;
        return $uploadForm.ajaxSubmit({
          url: '/admin/_com/ajax_person.cfc?method=saveprimaryphoto&PersonID=' + App.Person.model.get('id'),
          target: '.profile-photo .photo-container',
          dataType: 'json',
          beforeSubmit: function(formData, jqForm, options) {
            var queryString;
            queryString = $.param(formData);
            $uploadObj.addClass('faded');
            return true;
          },
          uploadProgress: function(e, pos, tot, perc) {
            return console.log('testing');
          },
          success: function(data) {
            $uploadObj.removeClass('faded');
            if (data.STATUS) {
              addMessage(data.STATUSMSG, 250, 6000, 4000);
              return $uploadObj.css('background-image', 'url("' + data.DATASET.path + data.DATASET.hash + '.jpg")');
            }
          },
          error: function(data) {
            return $uploadObj.removeClass('faded');
          },
          reset: true
        });
      });
    };
  });

}).call(this);
/*
* PERSON > PREFERENCES
*/


(function() {
  App.module("Person.Preferences", function(Self, App, Backbone, Marionette, $) {
    var $base, $specialtiesList, FormState, getPersonSpecialties, getSpecialties, nDegree, updateDegreeOption, updateSpecialtyOption, _init;
    this.startWithParent = false;
    FormState = null;
    $base = null;
    $specialtiesList = null;
    nDegree = null;
    this.on("before:start", function() {
      App.logInfo("starting: Person." + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        $base = $("#js-person-preferences");
        _init();
        return App.logInfo("started: Person." + Self.moduleName);
      });
    });
    this.on("stop", function() {
      App.logInfo("stopped: Person." + Self.moduleName);
      FormState = null;
    });
    this.on("personSpecialties:ready", function(specialties) {
      $.each(specialties, function(i, item) {
        $("#Specialty" + item.SPECIALTYID).attr("checked", true);
        return updateSpecialtyOption(item.SPECIALTYID);
      });
      App.logDebug("person specialties displayed!");
    });
    this.on("specialties:ready", function(specialties) {
      var specialtyMarkup, specialtyTemplate;
      App.logDebug("specialties list is ready");
      specialtyMarkup = ' <label id="specialty-<%=SPECIALTYID%>" for="Specialty<%=SPECIALTYID%>" class="checkbox specialtyOption" data-key="<%=SPECIALTYID%>">\
                          <input type="checkbox" \
                               name="Specialties" \
                               id="Specialty<%=SPECIALTYID%>" \
                               value="<%=SPECIALTYID%>" />\
                          <%=NAME%>\
                        </label>';
      specialtyTemplate = _.template(specialtyMarkup);
      $.each(specialties, function(i, item) {
        return $specialtiesList.append(specialtyTemplate(item));
      });
      getPersonSpecialties(nPerson);
    });
    _init = function() {
      $specialtiesList = $base.find(".js-specialties > .controls");
      getSpecialties();
      Self.once("personSpecialties:ready", function() {
        return FormState = new App.Components.FormState({
          el: '#js-person-preferences .js-formstate',
          saved: true
        });
      });
      updateDegreeOption(nDegree);
      $(".specialtyOption").on("change", function() {
        var nSpecialty;
        nSpecialty = $.ListGetAt(this.id, 2, "-");
        return updateSpecialtyOption(nSpecialty);
      });
    };
    getPersonSpecialties = function(nPerson) {
      $.ajax({
        url: sRootPath + "/_com/AJAX_person.cfc",
        dataType: 'json',
        type: 'get',
        data: {
          method: "getPersonSpecialties",
          personId: nPerson,
          returnFormat: "plain"
        },
        success: function(data) {
          Self.trigger("personSpecialties:ready", data.PAYLOAD);
        }
      });
    };
    getSpecialties = function() {
      $.ajax({
        url: sRootPath + "/_com/AJAX_activity.cfc",
        dataType: 'json',
        type: 'get',
        data: {
          method: "getSpecialties",
          returnFormat: "plain"
        },
        success: function(data) {
          Self.trigger("specialties:ready", data.PAYLOAD);
        }
      });
    };
    updateDegreeOption = function(nId) {
      $(".degreeOption").removeClass("formOptionSelected");
      $("#degree-" + nId).addClass("formOptionSelected");
    };
    return updateSpecialtyOption = function(nId) {
      if ($("#specialty-" + nId).is(".formOptionSelected")) {
        $("#specialty-" + nId).removeClass("formOptionSelected");
      } else {
        $("#specialty-" + nId).addClass("formOptionSelected");
      }
    };
  });

}).call(this);
(function() {
  App.setCookie = function(c_name, c_value, params) {
    $.cookie("uc_" + c_name, c_value, params);
  };

  App.getCookie = function(c_name) {
    var c_value;
    c_value = $.cookie("uc_" + c_name);
    return c_value;
  };

}).call(this);
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.Models.Config = (function(_super) {
    __extends(Config, _super);

    function Config() {
      App.logInfo("App.config > loaded!");
      Config.__super__.constructor.apply(this, arguments);
    }

    return Config;

  })(Backbone.Model);

}).call(this);
function is_printable_character(keycode) {
	if((keycode >= 48 && keycode <= 90) ||      // 0-1a-z
	   (keycode >= 96 && keycode <= 111) ||     // numpad 0-9 + - / * .
	   (keycode >= 186 && keycode <= 192) ||    // ; = , - . / ^
	   (keycode >= 219 && keycode <= 222)       // ( \ ) '
	  ) {
		  return true;
	  } else {
		  return false;
	  }
}
function querystring(key) {
   var re=new RegExp('(?:\\?|&)'+key+'=(.*?)(?=&|$)','gi');
   var r=[], m;
   while ((m=re.exec(document.location.search)) != null) r.push(m[1]);
   return r;
}
;
/*!
* STATUS MANAGER
*/


(function() {
  App.module("Components.Status", function(Self, App, Backbone, Marionette, $) {
    var _init;
    this.startWithParent = false;
    this.on("before:start", function() {
      App.logInfo("starting: " + Self.moduleName);
    });
    this.on("start", function() {
      $(document).ready(function() {
        _init();
        return App.logInfo("started: " + Self.moduleName);
      });
    });
    this.on("stop", function() {
      App.logInfo("stopped: " + Self.moduleName);
    });
    _init = function() {};
    Self.addMessage = function(message, fadein, fadeto, fadeout) {
      App.logInfo("adding status message: '" + message + "'");
      $.jGrowl(message, {
        life: fadeto,
        openDuration: fadein,
        closeDuration: 100,
        themeState: 'normal'
      });
    };
    Self.addError = function(message, fadein, fadeto, fadeout) {
      App.logInfo("adding error message: '" + message + "'");
      $.jGrowl(message, {
        header: 'ERROR!',
        life: fadeto,
        openDuration: fadein,
        closeDuration: 100,
        themeState: 'error'
      });
    };
  });

}).call(this);
(function() {
  (function($) {
    var debug, log, methods;
    debug = true;
    log = function() {
      if (debug) {
        return App.logInfo(arguments);
      }
    };
    methods = {
      init: function(options) {
        var settings;
        settings = $.extend({}, $.uiTypeahead.defaults, options);
        return this.each(function() {
          var typeahead;
          return typeahead = new $.uiTypeahead(this, settings);
        });
      },
      reset: function() {
        return $.uiTypeahead.clear(this);
      }
    };
    $.fn.uiTypeahead = function(method) {
      if (methods[method]) {
        return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
      } else if (typeof method === "object" || !method) {
        return methods.init.apply(this, arguments);
      } else {
        return $.error("Method " + method + " does not exist on uiTypeahead");
      }
    };
    $.uiTypeahead = function(input, settings) {
      var $clearer, $hiddenInput, $input, $removeBtn, $typeahead, $typeaheadView, $wrap, KEY, alreadyExists, clear_typeahead, currTotalResults, currTotalTypes, curr_types, fieldName, get_wikiImage, headerHeight, heightEach, heightEachReal, item_add, item_deselect, item_focus, item_select, itemsPerType, load_default, maxItems, maxResults, origWidth, resize_math, resultsPerType, searchTypes, search_resizer, set_image, totalHeight;
      load_default = function() {
        if (settings.defaultValue) {
          return item_select(settings.defaultValue);
        }
      };
      item_focus = function(item) {};
      search_resizer = function() {
        var items;
        items = $(".uiSearchInput ul li");
        return $(curr_types).each(function() {
          var typeItems;
          typeItems = items.filter("." + this);
          $(typeItems).slice(0, itemsPerType - 1).show();
          return $(typeItems).slice(itemsPerType).hide();
        });
      };
      alreadyExists = function(value) {
        var doesExist;
        doesExist = false;
        $(settings.excludeItems).each(function() {
          if (this === value) {
            doesExist = true;
            return false;
          }
        });
        return doesExist;
      };
      resize_math = function() {
        var heightEachReal, itemsPerType, maxItems, totalHeight;
        totalHeight = (currTotalResults * heightEach) + (currTotalTypes * headerHeight) + 39;
        heightEachReal = totalHeight / currTotalResults;
        maxItems = $(window).height() / heightEachReal;
        if (currTotalTypes) {
          return itemsPerType = Math.floor(maxItems / currTotalTypes);
        }
      };
      item_add = function(name, method) {
        return $.ajax({
          url: settings.ajaxAddURL,
          type: settings.ajaxAddMethod,
          dataType: "json",
          async: false,
          data: $.extend(settings.ajaxAddParams, {
            name: name
          }),
          success: function(returnData) {
            var data;
            data = returnData.PAYLOAD;
            data.label = data.name;
            data.value = data.id;
            data.ITEM_ID = data.id;
            item_select(data);
            return true;
          }
        });
      };
      item_select = function(item) {
        if (item.value !== 0) {
          if (!settings.clearOnSelect) {
            $hiddenInput.val(item.value.toString());
            $hiddenInput.keyup();
            $input.val(item.label);
            $wrap.addClass("selected");
            $hiddenInput.keyup();
            settings.onSelect(item);
            return settings.excludeItems.push(item.value);
          } else {
            settings.onSelect(item);
            return clear_typeahead();
          }
        } else {
          if (settings.allowAdd) {
            return item_add($input.val(), settings.ajaxSearchParams.method);
          }
        }
      };
      item_deselect = function() {
        $hiddenInput.val("");
        $input.focus();
        return $wrap.removeClass("selected");
      };
      set_image = function(item) {
        return $img;
      };
      clear_typeahead = function() {
        $hiddenInput.val("");
        $input.val("");
        $input.focus();
        return $wrap.removeClass("selected");
      };
      get_wikiImage = function(item) {
        return $.ajax({
          url: "/admin/_com/ajax/typeahead.cfc",
          type: "get",
          data: {
            method: "wikipedia_image",
            q: item.label
          },
          success: function(data) {
            return $img.attr("src", $.trim(data));
          }
        });
      };
      KEY = {
        BACKSPACE: 8,
        TAB: 9,
        RETURN: 13,
        ESC: 27,
        LEFT: 37,
        UP: 38,
        RIGHT: 39,
        DOWN: 40,
        COMMA: 188,
        ENTER: 13,
        DELETE: 46
      };
      searchTypes = 3;
      resultsPerType = 4;
      maxResults = searchTypes * resultsPerType;
      heightEach = 68;
      headerHeight = 18;
      currTotalResults = 0;
      currTotalTypes = 0;
      curr_types = [];
      maxItems = $(window).height() / heightEach;
      itemsPerType = 4;
      totalHeight = (currTotalResults * heightEach) + (currTotalTypes * headerHeight) + 39;
      heightEachReal = totalHeight / maxResults;
      if (settings.bucketed) {
        $(window).resize(function() {
          resize_math();
          return search_resizer();
        });
      }
      $hiddenInput = $(input).addClass("hide").focus(function() {}).blur(function() {
        return $input.blur();
      });
      fieldName = $hiddenInput.attr("name");
      origWidth = $hiddenInput.width();
      $hiddenInput.has(".hide");
      $input = $("<input/>").attr({
        type: "text",
        autocomplete: "off",
        spellcheck: false
      }).addClass("inputtext textInput").click(function() {
        if ($(this).val().length > 0 && $hiddenInput.val().length === 0) {
          return $input.autocomplete("widget").show();
        }
      }).blur(function() {}).keydown(function(event) {
        var next_token, previous_token;
        previous_token = void 0;
        next_token = void 0;
        switch (event.keyCode) {
          case KEY.LEFT:
          case KEY.RIGHT:
          case KEY.UP:
          case KEY.DOWN:
          case KEY.BACKSPACE:
            item_deselect();
            break;
          case KEY.TAB:
          case KEY.RETURN:
          case KEY.COMMA:
          case KEY.ESC:
            return true;
        }
      });
      $typeahead = $("<div/>").addClass("uiTypeahead").addClass(settings.typeaheadClass);
      $wrap = $("<div/>").addClass("wrap").appendTo($typeahead);
      if (settings.clearable) {
        $typeahead.addClass("uiClearableTypeahead");
        $clearer = $("<label/>").addClass("clear uiCloseButton").prependTo($wrap);
        $removeBtn = $("<input/>").attr({
          type: "button",
          title: "Remove"
        }).click(function() {
          return clear_typeahead();
        }).appendTo($clearer);
      }
      $input.appendTo($wrap);
      $typeaheadView = $("<div/>").addClass("uiTypeaheadView").appendTo($typeahead);
      if ($.isFunction($.fn.autocomplete)) {
        $input.autocomplete({
          autoFocus: true,
          appendTo: $typeaheadView,
          source: function(req, add) {
            if ($.trim(req.term).length) {
              return $.ajax({
                url: settings.ajaxSearchURL,
                type: settings.ajaxSearchType,
                dataType: "json",
                data: $.extend({}, settings.ajaxSearchParams, {
                  q: req.term
                }),
                success: function(data) {
                  var anItem, curr_type, curr_type_friendly, suggestions;
                  suggestions = [];
                  curr_type = "";
                  curr_type_friendly = "";
                  currTotalResults = 0;
                  currTotalTypes = 0;
                  $.each(data.PAYLOAD.DATASET, function(i, val) {
                    var anItem;
                    currTotalResults++;
                    if (curr_type !== data.PAYLOAD.DATASET[i].TYPE) {
                      currTotalTypes++;
                      curr_type = data.PAYLOAD.DATASET[i].TYPE;
                      curr_types.push(curr_type);
                      switch (curr_type) {
                        case "activity":
                          curr_type_friendly = "Activities";
                          break;
                        case "entity":
                          curr_type_friendly = "Entities";
                          break;
                        case "person":
                          curr_type_friendly = "People";
                          break;
                        default:
                          curr_type_friendly = "Other";
                      }
                      if (settings.bucketed) {
                        anItem = {
                          label: curr_type_friendly,
                          value: 0,
                          image: "",
                          ITEM_ID: 0,
                          TEXT: curr_type_friendly,
                          SUBTEXT1: "",
                          IMAGE: "",
                          classes: "header",
                          ignored: true,
                          isHeader: true,
                          callToAction: false
                        };
                        suggestions.push(anItem);
                      }
                    }
                    anItem = data.PAYLOAD.DATASET[i];
                    anItem.label = data.PAYLOAD.DATASET[i].TEXT;
                    if (anItem.label.length > 70) {
                      anItem.label = anItem.label.substr(0, 67) + "...";
                    }
                    anItem.value = data.PAYLOAD.DATASET[i].ITEM_ID;
                    anItem.image = data.PAYLOAD.DATASET[i].IMAGE;
                    anItem.type = data.PAYLOAD.DATASET[i].TYPE;
                    anItem.link = data.PAYLOAD.DATASET[i].LINK;
                    anItem.classes = data.PAYLOAD.DATASET[i].TYPE;
                    anItem.callToAction = false;
                    anItem.ignored = false;
                    return suggestions.push(anItem);
                  });
                  if (settings.allowViewMore) {
                    anItem = {
                      label: "See more results for '" + ($input.val()) + "'",
                      value: 0,
                      image: "",
                      ITEM_ID: 0,
                      TEXT: "See more results for '" + ($input.val()) + "'",
                      SUBTEXT1: "Displaying top " + data.PAYLOAD.DATASET.length + " results",
                      IMAGE: "",
                      ignored: false,
                      callToAction: true
                    };
                    suggestions.push(anItem);
                  }
                  if (settings.allowAdd) {
                    anItem = {
                      label: "Add '" + ($input.val()) + "'",
                      value: 0,
                      image: "",
                      ITEM_ID: 0,
                      TEXT: "Add '" + ($input.val()) + "'",
                      IMAGE: "",
                      classes: "",
                      ignored: false,
                      callToAction: true
                    };
                    suggestions.push(anItem);
                  }
                  $(this).data("suggestions", suggestions);
                  add(suggestions);
                }
              });
            }
          },
          focus: function(e, ui) {
            return false;
          },
          delay: 100,
          search: function(e, ui) {
            item_deselect();
          },
          select: function(e, ui) {
            item_select(ui.item);
            return false;
          },
          change: function() {
            return false;
          }
        }).data("ui-autocomplete")._renderMenu = function(ul, items) {
          var that;
          that = this;
          return $.each(items, function(index, item) {
            var $img, $label, $li, $subtext1, $subtext2;
            $li = that._renderItemData(ul, item);
            $li.html('');
            App.logInfo($li);
            $subtext1 = $("<span></span>").addClass("fcg fsm clearfix").text(item.SUBTEXT1);
            $subtext2 = $("<span></span>").addClass("fcg fsm clearfix").text(item.SUBTEXT2);
            $label = $("<a></a>").html("<div>" + item.label + "</div>").appendTo($li);
            $img = $("<img/>").attr('src', item.image).prependTo($label);
            if (item.SUBTEXT1) {
              $label.append($subtext1);
            }
            if (item.SUBTEXT2) {
              $label.append($subtext2);
            }
            if (item.ignored) {
              $li.addClass("ignore");
            }
            if (item.isHeader) {
              $img.remove();
            }
            if (item.callToAction) {
              $img.remove();
              $li.addClass("calltoaction");
            }
          });
        };
      }
      $typeahead.insertAfter($hiddenInput);
      if (settings.appendTo) {
        $typeahead.prependTo(settings.appendTo);
      }
      if (jQuery.watermark) {
        $input.watermark(settings.watermarkText);
      }
      load_default();
      $(this).data("hiddenInput", $hiddenInput);
      $(this).data("input", $input);
      $(this).data("typeahead", $input);
      $(this).data("wrap", $input);
      return $input;
    };
    $.uiTypeahead.clear = function() {
      clear_typeahead();
    };
    return $.uiTypeahead.defaults = {
      ajaxSearchParams: null,
      ajaxAddParams: null,
      ajaxAddMethod: "POST",
      showImage: true,
      allowAdd: true,
      allowViewMore: false,
      excludeItems: [],
      clearable: true,
      appendTo: null,
      useExistingInput: false,
      clearOnSelect: false,
      allowAdd: true,
      size: "compact",
      bucketed: false,
      shownCount: 5,
      watermarkText: "Type in a search term",
      width: 384,
      typeaheadClass: "",
      minChars: 1,
      ajaxMethod: "POST",
      type: "token",
      tokenLimit: null,
      jsonContainer: null,
      method: "GET",
      contentType: "json",
      autocomplete: null,
      queryParam: "q",
      onResult: null,
      selectFirst: true,
      autoFill: false,
      defaultValue: null,
      onAdd: function(item) {
        return true;
      },
      onSelect: function(item) {
        return true;
      }
    };
  })(jQuery);

}).call(this);
(function() {
  (function($) {
    var debug, log, methods;
    debug = true;
    log = function() {
      if (debug) {
        return App.logInfo(arguments[0]);
      }
    };
    methods = {
      init: function(options) {
        var settings;
        settings = $.extend({}, $.uiTokenizer.defaults, options);
        return this.each(function() {
          return new $.uiTokenizer(this, settings);
        });
      }
    };
    $.fn.uiTokenizer = function(method) {
      if (methods[method]) {
        return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
      } else if (typeof method === "object" || !method) {
        return methods.init.apply(this, arguments);
      } else {
        return $.error("Method " + method + " does not exist on uiTokenizer");
      }
    };
    $.uiTokenizer = function(input, settings) {
      var $hiddenInput, $tokenarea, $wrapper, KEY, alreadyExists, fieldName, is_printable_character, load_default, makeDragHidden, makeDragShown, makeTokenHidden, makeTokenShown, refreshHiddenInput, refreshTokens, refresh_binding, removeTokenFromArray, token_add, token_delete, token_deselect, token_items, token_select, typeahead_select;
      makeDragShown = function(ui) {
        ui.item.addClass("shown").removeClass("hidden").find(".tokenImg").show();
        ui.placeholder.addClass("shown shownPlaceholder").css({
          height: 102,
          width: 72
        }).removeClass("hidden hiddenPlaceholder").find(".tokenImg").show();
        ui.helper.addClass("shown shownPlaceholder").css({
          height: 102,
          width: 72
        }).removeClass("hidden hiddenPlaceholder").find(".tokenImg").show();
      };
      makeDragHidden = function(ui) {
        ui.item.removeClass("shown").addClass("hidden").find(".tokenImg").hide();
        ui.placeholder.removeClass("shown shownPlaceholder").css({
          height: 16,
          width: 72
        }).addClass("hidden hiddenPlaceholder").find(".tokenImg").hide();
        ui.helper.removeClass("shown shownPlaceholder").css({
          height: 16,
          width: 72
        }).addClass("hidden hiddenPlaceholder").find(".tokenImg").hide();
      };
      makeTokenShown = function(token) {
        token.addClass("shown").removeClass("hidden").find(".tokenImg").show();
        token.hasClass("drag");
      };
      makeTokenHidden = function(token) {
        token.removeClass("shown").addClass("hidden").find(".tokenImg").hide();
      };
      is_printable_character = function(keycode) {
        if ((keycode >= 48 && keycode <= 90) || (keycode >= 96 && keycode <= 111) || (keycode >= 186 && keycode <= 192) || (keycode >= 219 && keycode <= 222)) {
          return true;
        } else {
          return false;
        }
      };
      load_default = function() {
        var list_items, token;
        list_items = settings.defaultValue;
        token = {};
        $.each(list_items, function(i, e) {
          token_add(e, false);
        });
      };
      typeahead_select = function(token) {
        token_add(token);
        $input.val("");
        $input.blur();
      };
      refresh_binding = function(token) {
        var tokens;
        if (!token) {
          tokens = $tokenarea.children(".uiToken").not(".droppable_placeholder");
        } else {
          tokens = token;
        }
        tokens.drag("init", function(ev, dd) {
          var placeholder, siblings;
          placeholder = $("<span/>").addClass("uiToken droppable_placeholder");
          siblings = $(this).siblings(".uiToken");
          return $(this).data("placeholder", placeholder);
        });
        tokens.drag("start", function(ev, dd) {
          var clickOffset, container, placeholder, siblings, startHeight, startIndex, startOffset, startWidth;
          placeholder = $(this).data("placeholder");
          startIndex = $(this).index();
          startHeight = $(this).height();
          startWidth = $(this).width();
          siblings = $(this).data("siblings");
          $(this).data("startIndex", startIndex);
          $(this).data("startHeight", startHeight);
          $(this).data("startWidth", startWidth);
          clickOffset = {
            x: parseInt(ev.pageX - dd.originalX) / 100,
            y: parseInt(ev.pageY - dd.originalY) / 100
          };
          $(this).data("clickOffset", clickOffset);
          startOffset = $(this).height() * clickOffset.y;
          $(this).data("startOffset", startOffset);
          container = $tokenarea.offset();
          $(this).addClass("drag");
          return $(this).css({
            "z-index": "1000"
          });
        }).drag(function(ev, dd) {
          var clickOffset, container, currHeight, currHeightOffset, currWidth, currWidthOffset, drop, left, method, placeholder, rel, startHeight, startIndex, startOffset, startWidth, testX, testY, top;
          placeholder = $(this).data("placeholder");
          clickOffset = $(this).data("clickOffset");
          startOffset = $(this).data("startOffset");
          startHeight = $(this).data("startHeight");
          startWidth = $(this).data("startWidth");
          startIndex = $(this).data("startIndex");
          container = $tokenarea.offset();
          rel = {
            y: parseInt(ev.pageY - container.top),
            x: parseInt(ev.pageX - container.left)
          };
          top = rel.y;
          left = rel.x;
          drop = dd.drop[0];
          method = $.data(drop || {}, "drop+reorder");
          if ($(drop).parents().filter($tokenarea).length() > 0) {
            $("#stat-container").html("<div>" + $(drop).text() + "</div>");
            if (drop && $(drop).is(".uiToken") && (drop !== dd.current || method !== dd.method)) {
              $(this).insertBefore(drop);
              dd.current = drop;
              dd.method = method;
              dd.update();
              refreshTokens(clickOffset);
            }
          } else {

          }
          if (settings.type === "tokenImage") {
            if ($(this).index() > 4) {
              placeholder.addClass("hidden hiddenPlaceholder").removeClass("shown shownPlaceholder").css({
                height: $(this).height(),
                width: $(this).width()
              });
            } else {
              placeholder.addClass("shown shownPlaceholder").removeClass("hidden hiddenPlaceholder").css({
                height: $(this).height()
              });
            }
          } else {
            placeholder.removeClass("shown shownPlaceholder").removeClass("hidden hiddenPlaceholder").css({
              height: $(this).height(),
              width: $(this).width()
            });
          }
          currHeight = $(this).height();
          currWidth = $(this).width();
          currHeightOffset = currHeight * clickOffset.y;
          testY = parseFloat(ev.pageY - dd.offsetY) - parseFloat(currHeightOffset);
          currWidthOffset = currWidth * clickOffset.x;
          testX = parseFloat(ev.pageX - dd.offsetX) - parseFloat(currWidthOffset);
          return $(this).css({
            position: "relative",
            "z-index": "1000",
            top: 0,
            left: 0
          });
        }, {
          relative: true
        }).drag("end", function(ev, dd) {
          var container, placeholder, startIndex;
          placeholder = $(this).data("placeholder");
          startIndex = $(this).data("startIndex");
          container = $tokenarea.offset();
          placeholder.remove();
          if (startIndex !== $(this).index()) {
            refreshHiddenInput();
          }
          $(this).css({
            position: "relative",
            "z-index": "0",
            top: 0,
            left: 0,
            "margin-top": "auto"
          });
          return $(this).removeClass("drag");
        }).drop("init", function(ev, dd) {
          return this !== dd.drag;
        });
      };
      token_delete = function($token, item) {
        var override;
        override = settings.onRemove($token, item);
        $token.tooltip("destroy");
        if (override) {
          removeTokenFromArray(item.value);
          $token.remove();
        }
      };
      token_deselect = function($token) {
        $token.removeClass("uiTokenSelected").removeClass("uiTokenShownSelected");
        return false;
      };
      token_select = function($token) {
        var $nextToken, $prevToken;
        $nextToken = $token.next();
        $prevToken = $token.prev();
        $token.addClass("uiTokenSelected");
        if ($token.hasClass("shown")) {
          $token.addClass("uiTokenShownSelected");
        }
        $("body").click();
        $("html").one("click", function() {
          token_deselect($token);
          return false;
        });
        return false;
      };
      refreshHiddenInput = function() {
        var counter, tokenLabels, tokenValues;
        tokenLabels = $("[name=\"" + fieldName + "_label\"]").serializeArray();
        tokenValues = $("[name=\"" + fieldName + "_value\"]").serializeArray();
        counter = 0;
        $hiddenInput.html("").val("");
        $(tokenLabels).each(function() {
          var option;
          option = $("<option/>").val(tokenValues[counter].value).attr("selected", true).appendTo($hiddenInput).text(tokenLabels[counter].value);
          return counter++;
        });
        $hiddenInput.change();
      };
      alreadyExists = function(item) {
        var doesExist;
        doesExist = false;
        $(token_items).each(function() {
          if (this === item) {
            doesExist = true;
            return false;
          }
        });
        return doesExist;
      };
      removeTokenFromArray = function(item) {
        var token_items;
        if (token_items && token_items.length) {
          token_items = $.grep(token_items, function(a) {
            return a = item;
          });
        }
      };
      token_add = function(token, allowCallback) {
        var $clearer, $hubPhoto, $img, $input, $removeBtn, $token, $tokenImg, $tokenText, hiddenTokens, proceed, shownTokens, tokenShort;
        shownTokens = [];
        hiddenTokens = [];
        $token = $("<span/>");
        $tokenText = $("<span/>").addClass("text").text(token.label);
        $img = $("<img/>");
        $tokenImg = $("<span/>");
        $hubPhoto = $("<div/>");
        $input = $("<input/>").attr({
          type: "hidden",
          value: token.value,
          name: settings.fieldName + "_value",
          autocomplete: "off"
        });
        $clearer = $("<label/>").addClass("remove uiCloseButton");
        $removeBtn = $("<input/>").attr({
          type: "button",
          title: "Remove"
        }).click(function() {
          return token_delete($token, token);
        });
        proceed = true;
        if (allowCallback) {
          proceed = settings.onSelect($token, token);
        }
        if (proceed) {
          switch (settings.type) {
            case "token":
              $token.addClass("uiToken");
              $tokenText.appendTo($token);
              break;
            case "tokenImage":
              $token.addClass("uiToken");
              $img.attr({
                width: settings.typeOpts.imgSize,
                height: settings.typeOpts.imgSize,
                src: token.image
              });
              $tokenImg.addClass("tokenImg").appendTo($token);
              $hubPhoto.css({
                height: settings.typeOpts.imgSize + "px",
                width: settings.typeOpts.imgSize + "px"
              }).addClass("hubPhoto").appendTo($tokenImg);
              $img.appendTo($hubPhoto);
              $tokenText.appendTo($token);
              break;
            case "list":
              $token.addClass("uiListToken");
              if (token.label.length > settings.tokenMaxChar - 3) {
                tokenShort = token.label.substr(0, settings.tokenMaxChar - 3) + "...";
                $token.tooltip({
                  placement: "top",
                  trigger: "hover focus",
                  container: "body"
                });
                $token.tooltip('show');
              } else {
                tokenShort = token.label;
              }
              $token.text(tokenShort);
              $token.attr("title", token.label);
              $clearer.appendTo($token);
              $removeBtn.appendTo($clearer);
              $input.appendTo($token);
              $token.wrapInner("<div class=\"name\"></div>");
              break;
            case "listImage":
              $token.addClass("uiListToken");
              $img.attr({
                width: settings.typeOpts.imgSize,
                height: settings.typeOpts.imgSize,
                src: token.image
              }).addClass("photo img");
              $token.text(token.label);
              $clearer.appendTo($token);
              $removeBtn.appendTo($clearer);
              $img.prependTo($token);
              $input.appendTo($token);
              $token.wrapInner("<div class=\"name\"></div>");
          }
          $tokenarea.addClass("expanded").removeClass("hide");
          $token.prependTo($tokenarea);
          token_items.push(token.value);
        }
        return false;
      };
      KEY = {
        BACKSPACE: 8,
        TAB: 9,
        RETURN: 13,
        ESC: 27,
        LEFT: 37,
        UP: 38,
        RIGHT: 39,
        DOWN: 40,
        COMMA: 188,
        ENTER: 13,
        DELETE: 46
      };
      token_items = [];
      $hiddenInput = $(input).hide().focus(function() {}).blur(function() {
        $input.blur();
      });
      fieldName = $hiddenInput.attr("name");
      $wrapper = $("<div/>").addClass("uiTokenizer mrl");
      switch (settings.type) {
        case "token":
          settings.typeOpts = {
            imgSize: 0,
            dragOffset: {
              top: -10,
              left: -30
            }
          };
          break;
        case "tokenImage":
          settings.typeOpts = {
            imgSize: 62,
            dragOffset: {
              top: 23,
              left: 30
            }
          };
          $wrapper.addClass("uiImageTokenizer");
          break;
        case "list":
          settings.typeOpts = {
            imgSize: 0,
            dragOffset: {
              top: -10,
              left: 40
            }
          };
          $wrapper.addClass("uiListTokenizer");
          break;
        case "listImage":
          settings.typeOpts = {
            imgSize: 16,
            dragOffset: {
              top: -10,
              left: 40
            }
          };
          $wrapper.addClass("uiListImageTokenizer");
      }
      $tokenarea = $("<div/>").addClass("uiTokenarea hide clearfix");
      $wrapper.insertAfter($hiddenInput);
      $hiddenInput.uiTypeahead({
        watermarkText: settings.watermarkText,
        defaultValue: null,
        queryParam: "q",
        appendTo: $wrapper,
        clearOnSelect: true,
        ajaxSearchURL: settings.ajaxSearchURL,
        ajaxSearchType: settings.ajaxSearchType,
        ajaxSearchParams: settings.ajaxSearchParams,
        ajaxAddURL: settings.ajaxAddURL,
        ajaxAddType: settings.ajaxAddType,
        ajaxAddParams: settings.ajaxAddParams,
        onSelect: function(item) {
          if (!($.inArray(item.value, token_items) >= 0)) {
            token_add(item, true);
          }
          return false;
        }
      });
      if (settings.listLocation === "top") {
        $tokenarea.prependTo($wrapper);
      } else {
        $tokenarea.appendTo($wrapper);
      }
      refreshTokens = function(clickOffset) {
        var counter, textAll, tokens;
        counter = 0;
        tokens = $tokenarea.children(".uiToken").not(".droppable_placeholder");
        if (!clickOffset) {
          clickOffset = {
            x: 0,
            y: 0
          };
        }
        if (settings.type === "tokenImage") {
          textAll = "";
          return tokens.each(function() {
            var index, text, token;
            token = $(this);
            index = token.index();
            text = token.find(".text").text();
            textAll = textAll + ", " + text;
            if (counter < 5) {
              makeTokenShown(token);
            } else {
              makeTokenHidden(token);
            }
            return counter++;
          });
        }
      };
      return load_default();
    };
    return $.uiTokenizer.defaults = {
      ajaxSearchParams: null,
      ajaxAddParams: null,
      ajaxParams: null,
      shownImages: true,
      shownCount: 5,
      listLocation: "bottom",
      defaultValue: [],
      watermarkText: "Type in a search term",
      searchDelay: 300,
      minChars: 1,
      tokenMaxChar: 21,
      ajaxMethod: "get",
      type: "token",
      tokenLimit: null,
      jsonContainer: null,
      method: "GET",
      tokenTmpl: "<span title=\"${label}\" class=\"uiToken ${shown}\">" + "        <span class=\"tokenImg hide\">" + "            <div style=\"height: 62px; width: 62px;\" class=\"hubPhoto\">" + "                <img height=\"62\" src=\"/static/images/no-photo/none_i.png\" class=\"img\">" + "            </div>" + "        </span>" + "        <span class=\"text\">" + "            ${label}" + "        </span>" + "        <input type=\"hidden\" value=\"${value}\" name=\"${fieldName}\" autocomplete=\"off\">" + "        <input type=\"hidden\" value=\"${label}\" name=\"text_${fieldName}\" autocomplete=\"off\">" + "    </span>",
      contentType: "json",
      autocomplete: null,
      queryParam: "q",
      onResult: null,
      selectFirst: true,
      autoFill: false,
      defaultData: null,
      onRemove: function(item) {
        return true;
      },
      onSelect: function(item) {
        return true;
      }
    };
  })(jQuery);

}).call(this);
(function() {
  var announcer, crashCart, defibrillate, defibrillator, delay, fluidDialog, startDefibrillator, stopDefibrillator;

  announcer = function(data) {};

  stopDefibrillator = function() {
    return defibrillator.stop();
  };

  defibrillate = function(thedata) {
    return announcer(thedata);
  };

  crashCart = function() {
    $.ajax({
      url: "/admin/defibrillator.cfc?method=shock&yell=clear",
      type: 'get',
      dataType: 'json',
      success: function(data) {
        return defibrillate(data);
      }
    });
  };

  startDefibrillator = function() {
    var defibrillator;
    return defibrillator = $.PeriodicalUpdater("/admin/_com/defibrillator.cfc", {
      method: "get",
      data: {
        method: "shock",
        yell: "clear"
      },
      minTimeout: 2000,
      maxTimeout: 16000,
      multiplier: 2,
      type: "json",
      maxCalls: 25,
      autoStop: 0
    }, function(data) {
      return defibrillate(data);
    });
  };

  delay = (function() {
    var timer;
    timer = 0;
    return function(callback, ms) {
      clearTimeout(timer);
      return timer = setTimeout(callback, ms);
    };
  })();

  defibrillator = "";

  fluidDialog = function() {
    var $visible;
    $visible = $(".ui-dialog:visible");
    return $visible.each(function() {
      var $this, dialog;
      $this = $(this);
      dialog = $this.find(".ui-dialog-content").data("dialog");
      if (dialog.options.maxWidth && dialog.options.width) {
        $this.css("max-width", dialog.options.maxWidth);
        dialog.option("position", dialog.options.position);
      }
      if (dialog.options.fluid) {
        return $(window).on("resize.responsive", function() {
          var wWidth;
          wWidth = $(window).width();
          if (wWidth < dialog.options.maxWidth + 50) {
            $this.css("width", "90%");
          }
          return dialog.option("position", dialog.options.position);
        });
      }
    });
  };

  $(function() {
    $("*").bind("touchend", function(e) {
      if ($(e.target).attr("rel") !== "tooltip" && ($("div.tooltip.in").length > 0)) {
        $("[rel=tooltip]").mouseleave();
        e.stopPropagation();
      } else {
        $(e.target).mouseenter();
      }
    });
    $("input").keydown(function(e) {
      if (e.keyCode === 13) {
        $(this).parents("form").submit();
        return false;
      }
    });
    if (typeof loggedIn === "boolean" && loggedIn) {
      return startDefibrillator();
    }
  });

}).call(this);
Encoder = {

	// When encoding do we convert characters into html or numerical entities
	EncodeType : "entity",  // entity OR numerical

	isEmpty : function(val){
		if(val){
			return ((val===null) || val.length==0 || /^\s+$/.test(val));
		}else{
			return true;
		}
	},
	// Convert HTML entities into numerical entities
	HTML2Numerical : function(s){
		var arr1 = new Array('&nbsp;','&iexcl;','&cent;','&pound;','&curren;','&yen;','&brvbar;','&sect;','&uml;','&copy;','&ordf;','&laquo;','&not;','&shy;','&reg;','&macr;','&deg;','&plusmn;','&sup2;','&sup3;','&acute;','&micro;','&para;','&middot;','&cedil;','&sup1;','&ordm;','&raquo;','&frac14;','&frac12;','&frac34;','&iquest;','&agrave;','&aacute;','&acirc;','&atilde;','&Auml;','&aring;','&aelig;','&ccedil;','&egrave;','&eacute;','&ecirc;','&euml;','&igrave;','&iacute;','&icirc;','&iuml;','&eth;','&ntilde;','&ograve;','&oacute;','&ocirc;','&otilde;','&Ouml;','&times;','&oslash;','&ugrave;','&uacute;','&ucirc;','&Uuml;','&yacute;','&thorn;','&szlig;','&agrave;','&aacute;','&acirc;','&atilde;','&auml;','&aring;','&aelig;','&ccedil;','&egrave;','&eacute;','&ecirc;','&euml;','&igrave;','&iacute;','&icirc;','&iuml;','&eth;','&ntilde;','&ograve;','&oacute;','&ocirc;','&otilde;','&ouml;','&divide;','&Oslash;','&ugrave;','&uacute;','&ucirc;','&uuml;','&yacute;','&thorn;','&yuml;','&quot;','&amp;','&lt;','&gt;','&oelig;','&oelig;','&scaron;','&scaron;','&yuml;','&circ;','&tilde;','&ensp;','&emsp;','&thinsp;','&zwnj;','&zwj;','&lrm;','&rlm;','&ndash;','&mdash;','&lsquo;','&rsquo;','&sbquo;','&ldquo;','&rdquo;','&bdquo;','&dagger;','&dagger;','&permil;','&lsaquo;','&rsaquo;','&euro;','&fnof;','&alpha;','&beta;','&gamma;','&delta;','&epsilon;','&zeta;','&eta;','&theta;','&iota;','&kappa;','&lambda;','&mu;','&nu;','&xi;','&omicron;','&pi;','&rho;','&sigma;','&tau;','&upsilon;','&phi;','&chi;','&psi;','&omega;','&alpha;','&beta;','&gamma;','&delta;','&epsilon;','&zeta;','&eta;','&theta;','&iota;','&kappa;','&lambda;','&mu;','&nu;','&xi;','&omicron;','&pi;','&rho;','&sigmaf;','&sigma;','&tau;','&upsilon;','&phi;','&chi;','&psi;','&omega;','&thetasym;','&upsih;','&piv;','&bull;','&hellip;','&prime;','&prime;','&oline;','&frasl;','&weierp;','&image;','&real;','&trade;','&alefsym;','&larr;','&uarr;','&rarr;','&darr;','&harr;','&crarr;','&larr;','&uarr;','&rarr;','&darr;','&harr;','&forall;','&part;','&exist;','&empty;','&nabla;','&isin;','&notin;','&ni;','&prod;','&sum;','&minus;','&lowast;','&radic;','&prop;','&infin;','&ang;','&and;','&or;','&cap;','&cup;','&int;','&there4;','&sim;','&cong;','&asymp;','&ne;','&equiv;','&le;','&ge;','&sub;','&sup;','&nsub;','&sube;','&supe;','&oplus;','&otimes;','&perp;','&sdot;','&lceil;','&rceil;','&lfloor;','&rfloor;','&lang;','&rang;','&loz;','&spades;','&clubs;','&hearts;','&diams;');
		var arr2 = new Array('&#160;','&#161;','&#162;','&#163;','&#164;','&#165;','&#166;','&#167;','&#168;','&#169;','&#170;','&#171;','&#172;','&#173;','&#174;','&#175;','&#176;','&#177;','&#178;','&#179;','&#180;','&#181;','&#182;','&#183;','&#184;','&#185;','&#186;','&#187;','&#188;','&#189;','&#190;','&#191;','&#192;','&#193;','&#194;','&#195;','&#196;','&#197;','&#198;','&#199;','&#200;','&#201;','&#202;','&#203;','&#204;','&#205;','&#206;','&#207;','&#208;','&#209;','&#210;','&#211;','&#212;','&#213;','&#214;','&#215;','&#216;','&#217;','&#218;','&#219;','&#220;','&#221;','&#222;','&#223;','&#224;','&#225;','&#226;','&#227;','&#228;','&#229;','&#230;','&#231;','&#232;','&#233;','&#234;','&#235;','&#236;','&#237;','&#238;','&#239;','&#240;','&#241;','&#242;','&#243;','&#244;','&#245;','&#246;','&#247;','&#248;','&#249;','&#250;','&#251;','&#252;','&#253;','&#254;','&#255;','&#34;','&#38;','&#60;','&#62;','&#338;','&#339;','&#352;','&#353;','&#376;','&#710;','&#732;','&#8194;','&#8195;','&#8201;','&#8204;','&#8205;','&#8206;','&#8207;','&#8211;','&#8212;','&#8216;','&#8217;','&#8218;','&#8220;','&#8221;','&#8222;','&#8224;','&#8225;','&#8240;','&#8249;','&#8250;','&#8364;','&#402;','&#913;','&#914;','&#915;','&#916;','&#917;','&#918;','&#919;','&#920;','&#921;','&#922;','&#923;','&#924;','&#925;','&#926;','&#927;','&#928;','&#929;','&#931;','&#932;','&#933;','&#934;','&#935;','&#936;','&#937;','&#945;','&#946;','&#947;','&#948;','&#949;','&#950;','&#951;','&#952;','&#953;','&#954;','&#955;','&#956;','&#957;','&#958;','&#959;','&#960;','&#961;','&#962;','&#963;','&#964;','&#965;','&#966;','&#967;','&#968;','&#969;','&#977;','&#978;','&#982;','&#8226;','&#8230;','&#8242;','&#8243;','&#8254;','&#8260;','&#8472;','&#8465;','&#8476;','&#8482;','&#8501;','&#8592;','&#8593;','&#8594;','&#8595;','&#8596;','&#8629;','&#8656;','&#8657;','&#8658;','&#8659;','&#8660;','&#8704;','&#8706;','&#8707;','&#8709;','&#8711;','&#8712;','&#8713;','&#8715;','&#8719;','&#8721;','&#8722;','&#8727;','&#8730;','&#8733;','&#8734;','&#8736;','&#8743;','&#8744;','&#8745;','&#8746;','&#8747;','&#8756;','&#8764;','&#8773;','&#8776;','&#8800;','&#8801;','&#8804;','&#8805;','&#8834;','&#8835;','&#8836;','&#8838;','&#8839;','&#8853;','&#8855;','&#8869;','&#8901;','&#8968;','&#8969;','&#8970;','&#8971;','&#9001;','&#9002;','&#9674;','&#9824;','&#9827;','&#9829;','&#9830;');
		return this.swapArrayVals(s,arr1,arr2);
	},	

	// Convert Numerical entities into HTML entities
	NumericalToHTML : function(s){
		var arr1 = new Array('&#160;','&#161;','&#162;','&#163;','&#164;','&#165;','&#166;','&#167;','&#168;','&#169;','&#170;','&#171;','&#172;','&#173;','&#174;','&#175;','&#176;','&#177;','&#178;','&#179;','&#180;','&#181;','&#182;','&#183;','&#184;','&#185;','&#186;','&#187;','&#188;','&#189;','&#190;','&#191;','&#192;','&#193;','&#194;','&#195;','&#196;','&#197;','&#198;','&#199;','&#200;','&#201;','&#202;','&#203;','&#204;','&#205;','&#206;','&#207;','&#208;','&#209;','&#210;','&#211;','&#212;','&#213;','&#214;','&#215;','&#216;','&#217;','&#218;','&#219;','&#220;','&#221;','&#222;','&#223;','&#224;','&#225;','&#226;','&#227;','&#228;','&#229;','&#230;','&#231;','&#232;','&#233;','&#234;','&#235;','&#236;','&#237;','&#238;','&#239;','&#240;','&#241;','&#242;','&#243;','&#244;','&#245;','&#246;','&#247;','&#248;','&#249;','&#250;','&#251;','&#252;','&#253;','&#254;','&#255;','&#34;','&#38;','&#60;','&#62;','&#338;','&#339;','&#352;','&#353;','&#376;','&#710;','&#732;','&#8194;','&#8195;','&#8201;','&#8204;','&#8205;','&#8206;','&#8207;','&#8211;','&#8212;','&#8216;','&#8217;','&#8218;','&#8220;','&#8221;','&#8222;','&#8224;','&#8225;','&#8240;','&#8249;','&#8250;','&#8364;','&#402;','&#913;','&#914;','&#915;','&#916;','&#917;','&#918;','&#919;','&#920;','&#921;','&#922;','&#923;','&#924;','&#925;','&#926;','&#927;','&#928;','&#929;','&#931;','&#932;','&#933;','&#934;','&#935;','&#936;','&#937;','&#945;','&#946;','&#947;','&#948;','&#949;','&#950;','&#951;','&#952;','&#953;','&#954;','&#955;','&#956;','&#957;','&#958;','&#959;','&#960;','&#961;','&#962;','&#963;','&#964;','&#965;','&#966;','&#967;','&#968;','&#969;','&#977;','&#978;','&#982;','&#8226;','&#8230;','&#8242;','&#8243;','&#8254;','&#8260;','&#8472;','&#8465;','&#8476;','&#8482;','&#8501;','&#8592;','&#8593;','&#8594;','&#8595;','&#8596;','&#8629;','&#8656;','&#8657;','&#8658;','&#8659;','&#8660;','&#8704;','&#8706;','&#8707;','&#8709;','&#8711;','&#8712;','&#8713;','&#8715;','&#8719;','&#8721;','&#8722;','&#8727;','&#8730;','&#8733;','&#8734;','&#8736;','&#8743;','&#8744;','&#8745;','&#8746;','&#8747;','&#8756;','&#8764;','&#8773;','&#8776;','&#8800;','&#8801;','&#8804;','&#8805;','&#8834;','&#8835;','&#8836;','&#8838;','&#8839;','&#8853;','&#8855;','&#8869;','&#8901;','&#8968;','&#8969;','&#8970;','&#8971;','&#9001;','&#9002;','&#9674;','&#9824;','&#9827;','&#9829;','&#9830;');
		var arr2 = new Array('&nbsp;','&iexcl;','&cent;','&pound;','&curren;','&yen;','&brvbar;','&sect;','&uml;','&copy;','&ordf;','&laquo;','&not;','&shy;','&reg;','&macr;','&deg;','&plusmn;','&sup2;','&sup3;','&acute;','&micro;','&para;','&middot;','&cedil;','&sup1;','&ordm;','&raquo;','&frac14;','&frac12;','&frac34;','&iquest;','&agrave;','&aacute;','&acirc;','&atilde;','&Auml;','&aring;','&aelig;','&ccedil;','&egrave;','&eacute;','&ecirc;','&euml;','&igrave;','&iacute;','&icirc;','&iuml;','&eth;','&ntilde;','&ograve;','&oacute;','&ocirc;','&otilde;','&Ouml;','&times;','&oslash;','&ugrave;','&uacute;','&ucirc;','&Uuml;','&yacute;','&thorn;','&szlig;','&agrave;','&aacute;','&acirc;','&atilde;','&auml;','&aring;','&aelig;','&ccedil;','&egrave;','&eacute;','&ecirc;','&euml;','&igrave;','&iacute;','&icirc;','&iuml;','&eth;','&ntilde;','&ograve;','&oacute;','&ocirc;','&otilde;','&ouml;','&divide;','&Oslash;','&ugrave;','&uacute;','&ucirc;','&uuml;','&yacute;','&thorn;','&yuml;','&quot;','&amp;','&lt;','&gt;','&oelig;','&oelig;','&scaron;','&scaron;','&yuml;','&circ;','&tilde;','&ensp;','&emsp;','&thinsp;','&zwnj;','&zwj;','&lrm;','&rlm;','&ndash;','&mdash;','&lsquo;','&rsquo;','&sbquo;','&ldquo;','&rdquo;','&bdquo;','&dagger;','&dagger;','&permil;','&lsaquo;','&rsaquo;','&euro;','&fnof;','&alpha;','&beta;','&gamma;','&delta;','&epsilon;','&zeta;','&eta;','&theta;','&iota;','&kappa;','&lambda;','&mu;','&nu;','&xi;','&omicron;','&pi;','&rho;','&sigma;','&tau;','&upsilon;','&phi;','&chi;','&psi;','&omega;','&alpha;','&beta;','&gamma;','&delta;','&epsilon;','&zeta;','&eta;','&theta;','&iota;','&kappa;','&lambda;','&mu;','&nu;','&xi;','&omicron;','&pi;','&rho;','&sigmaf;','&sigma;','&tau;','&upsilon;','&phi;','&chi;','&psi;','&omega;','&thetasym;','&upsih;','&piv;','&bull;','&hellip;','&prime;','&prime;','&oline;','&frasl;','&weierp;','&image;','&real;','&trade;','&alefsym;','&larr;','&uarr;','&rarr;','&darr;','&harr;','&crarr;','&larr;','&uarr;','&rarr;','&darr;','&harr;','&forall;','&part;','&exist;','&empty;','&nabla;','&isin;','&notin;','&ni;','&prod;','&sum;','&minus;','&lowast;','&radic;','&prop;','&infin;','&ang;','&and;','&or;','&cap;','&cup;','&int;','&there4;','&sim;','&cong;','&asymp;','&ne;','&equiv;','&le;','&ge;','&sub;','&sup;','&nsub;','&sube;','&supe;','&oplus;','&otimes;','&perp;','&sdot;','&lceil;','&rceil;','&lfloor;','&rfloor;','&lang;','&rang;','&loz;','&spades;','&clubs;','&hearts;','&diams;');
		return this.swapArrayVals(s,arr1,arr2);
	},


	// Numerically encodes all unicode characters
	numEncode : function(s){
		
		if(this.isEmpty(s)) return "";

		var e = "";
		for (var i = 0; i < s.length; i++)
		{
			var c = s.charAt(i);
			if (c < " " || c > "~")
			{
				c = "&#" + c.charCodeAt() + ";";
			}
			e += c;
		}
		return e;
	},
	
	// HTML Decode numerical and HTML entities back to original values
	htmlDecode : function(s){

		var c,m,d = s;
		
		if(this.isEmpty(d)) return "";

		// convert HTML entites back to numerical entites first
		d = this.HTML2Numerical(d);
		
		// look for numerical entities &#34;
		arr=d.match(/&#[0-9]{1,5};/g);
		
		// if no matches found in string then skip
		if(arr!=null){
			for(var x=0;x<arr.length;x++){
				m = arr[x];
				c = m.substring(2,m.length-1); //get numeric part which is refernce to unicode character
				// if its a valid number we can decode
				if(c >= -32768 && c <= 65535){
					// decode every single match within string
					d = d.replace(m, String.fromCharCode(c));
				}else{
					d = d.replace(m, ""); //invalid so replace with nada
				}
			}			
		}

		return d;
	},		

	// encode an input string into either numerical or HTML entities
	htmlEncode : function(s,dbl){
			
		if(this.isEmpty(s)) return "";

		// do we allow double encoding? E.g will &amp; be turned into &amp;amp;
		dbl = dbl | false; //default to prevent double encoding
		
		// if allowing double encoding we do ampersands first
		if(dbl){
			if(this.EncodeType=="numerical"){
				s = s.replace(/&/g, "&#38;");
			}else{
				s = s.replace(/&/g, "&amp;");
			}
		}

		// convert the xss chars to numerical entities ' " < >
		s = this.XSSEncode(s,false);
		
		if(this.EncodeType=="numerical" || !dbl){
			// Now call function that will convert any HTML entities to numerical codes
			s = this.HTML2Numerical(s);
		}

		// Now encode all chars above 127 e.g unicode
		s = this.numEncode(s);

		// now we know anything that needs to be encoded has been converted to numerical entities we
		// can encode any ampersands & that are not part of encoded entities
		// to handle the fact that I need to do a negative check and handle multiple ampersands &&&
		// I am going to use a placeholder

		// if we don't want double encoded entities we ignore the & in existing entities
		if(!dbl){
			s = s.replace(/&#/g,"##AMPHASH##");
		
			if(this.EncodeType=="numerical"){
				s = s.replace(/&/g, "&#38;");
			}else{
				s = s.replace(/&/g, "&amp;");
			}

			s = s.replace(/##AMPHASH##/g,"&#");
		}
		
		// replace any malformed entities
		s = s.replace(/&#\d*([^\d;]|$)/g, "$1");

		if(!dbl){
			// safety check to correct any double encoded &amp;
			s = this.correctEncoding(s);
		}

		// now do we need to convert our numerical encoded string into entities
		if(this.EncodeType=="entity"){
			s = this.NumericalToHTML(s);
		}

		return s;					
	},

	// Encodes the basic 4 characters used to malform HTML in XSS hacks
	XSSEncode : function(s,en){
		if(!this.isEmpty(s)){
			en = en || true;
			// do we convert to numerical or html entity?
			if(en){
				s = s.replace(/\'/g,"&#39;"); //no HTML equivalent as &apos is not cross browser supported
				s = s.replace(/\"/g,"&quot;");
				s = s.replace(/</g,"&lt;");
				s = s.replace(/>/g,"&gt;");
			}else{
				s = s.replace(/\'/g,"&#39;"); //no HTML equivalent as &apos is not cross browser supported
				s = s.replace(/\"/g,"&#34;");
				s = s.replace(/</g,"&#60;");
				s = s.replace(/>/g,"&#62;");
			}
			return s;
		}else{
			return "";
		}
	},

	// returns true if a string contains html or numerical encoded entities
	hasEncoded : function(s){
		if(/&#[0-9]{1,5};/g.test(s)){
			return true;
		}else if(/&[A-Z]{2,6};/gi.test(s)){
			return true;
		}else{
			return false;
		}
	},

	// will remove any unicode characters
	stripUnicode : function(s){
		return s.replace(/[^\x20-\x7E]/g,"");
		
	},

	// corrects any double encoded &amp; entities e.g &amp;amp;
	correctEncoding : function(s){
		return s.replace(/(&amp;)(amp;)+/,"$1");
	},


	// Function to loop through an array swaping each item with the value from another array e.g swap HTML entities with Numericals
	swapArrayVals : function(s,arr1,arr2){
		if(this.isEmpty(s)) return "";
		var re;
		if(arr1 && arr2){
			//ShowDebug("in swapArrayVals arr1.length = " + arr1.length + " arr2.length = " + arr2.length)
			// array lengths must match
			if(arr1.length == arr2.length){
				for(var x=0,i=arr1.length;x<i;x++){
					re = new RegExp(arr1[x], 'g');
					s = s.replace(re,arr2[x]); //swap arr1 item with matching item from arr2	
				}
			}
		}
		return s;
	},

	inArray : function( item, arr ) {
		for ( var i = 0, x = arr.length; i < x; i++ ){
			if ( arr[i] === item ){
				return i;
			}
		}
		return -1;
	}

}
;

/*
* CCPD JS-ASSETS
*/


(function() {


}).call(this);
(function() {
  var root, _init;

  Backbone.Marionette.Renderer.render = function(template, data) {
    if (!JST[template]) {
      throw "Template '" + template + "' not found!";
    }
    return JST[template](data);
  };

  root = this;

  root.App = new Backbone.Marionette.Application();

  _init = function() {};

  App.addInitializer(function(options) {
    return _init();
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

  App.start();

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
        before: function() {},
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
      App.jPanelMenu.on();
      return $("body").addClass("mobile screen-medium");
    } else {
      $(window).off("resize", dialogFixer);
      $(window).off("orientationchange", dialogFixer);
      dialogFixer();
      App.jPanelMenu.off();
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
    App.respond.test.medium();
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
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.module("Collections", function(Collections, App, Backbone, Marionette) {
    var _ref;

    return Collections.LinkbarCollection = (function(_super) {
      __extends(LinkbarCollection, _super);

      function LinkbarCollection() {
        _ref = LinkbarCollection.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      return LinkbarCollection;

    })(Backbone.Collection);
  });

}).call(this);
(function() {


}).call(this);
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.module("Models", function(Models, App, Backbone, Marionette) {
    var _ref;

    return Models.Activity = (function(_super) {
      __extends(Activity, _super);

      function Activity() {
        _ref = Activity.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      Activity.prototype.url = '/api/activity/getActivity';

      return Activity;

    })(Backbone.Model);
  });

}).call(this);
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.module("Models", function(Models, App, Backbone, Marionette) {
    var _ref;

    return Models.Hub = (function(_super) {
      __extends(Hub, _super);

      function Hub() {
        _ref = Hub.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      return Hub;

    })(Backbone.Model);
  });

}).call(this);
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.module("Models", function(Models, App, Backbone, Marionette) {
    var _ref;

    return Models.Person = (function(_super) {
      __extends(Person, _super);

      function Person() {
        _ref = Person.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      Person.prototype.url = '/api/person/getPerson';

      return Person;

    })(Backbone.Model);
  });

}).call(this);
/*
* HUB VIEW (Represents top level sections of the app such as 'Activity' and 'Person')
*/


(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.module("Views", function(Views, App, Backbone, Marionette) {
    var _ref, _ref1, _ref2, _ref3;

    Views.HubInfobarView = (function(_super) {
      __extends(HubInfobarView, _super);

      function HubInfobarView() {
        _ref = HubInfobarView.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      HubInfobarView.prototype.template = 'hub/infobar_view';

      return HubInfobarView;

    })(Marionette.ItemView);
    Views.HubLinkbarItemView = (function(_super) {
      __extends(HubLinkbarItemView, _super);

      function HubLinkbarItemView() {
        _ref1 = HubLinkbarItemView.__super__.constructor.apply(this, arguments);
        return _ref1;
      }

      HubLinkbarItemView.prototype.template = 'hub/linkbar_item_view';

      return HubLinkbarItemView;

    })(Marionette.ItemView);
    Views.HubLinkbarView = (function(_super) {
      __extends(HubLinkbarView, _super);

      function HubLinkbarView() {
        _ref2 = HubLinkbarView.__super__.constructor.apply(this, arguments);
        return _ref2;
      }

      HubLinkbarView.prototype.template = 'hub/linkbar_view';

      HubLinkbarView.prototype.itemView = Views.HubLinkbarItemView;

      return HubLinkbarView;

    })(Marionette.CollectionView);
    return Views.HubView = (function(_super) {
      __extends(HubView, _super);

      function HubView() {
        _ref3 = HubView.__super__.constructor.apply(this, arguments);
        return _ref3;
      }

      HubView.prototype.el = ".hub";

      HubView.prototype.ui = {
        picture: ".hub-bar .profile-picture",
        linkbar: ".hub-bar .linkbar .linkbar-inner"
      };

      HubView.prototype.initialize = function() {};

      return HubView;

    })(Marionette.ItemView);
  });

}).call(this);
/*
* ACTIVITY HUB VIEW
*/


(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.module("Views", function(Views, App, Backbone, Marionette) {
    var _ref;

    Views.ActivityView = (function(_super) {
      __extends(ActivityView, _super);

      function ActivityView() {
        _ref = ActivityView.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      ActivityView.prototype.el = ".hub .activity";

      ActivityView.prototype.initialize = function() {};

      return ActivityView;

    })(Views.HubView);
  });

}).call(this);
/*
* PERSON HUB VIEW
*/


(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.module("Views", function(Views, App, Backbone, Marionette) {
    var _ref;

    Views.PersonView = (function(_super) {
      __extends(PersonView, _super);

      function PersonView() {
        _ref = PersonView.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      PersonView.prototype.el = ".hub .person";

      PersonView.prototype.initialize = function() {};

      return PersonView;

    })(Views.HubView);
  });

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
      console.log(this.settings.modes);
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
      user: {
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
      this.collection.fetch({
        data: params,
        success: function(newsItems, response, options) {
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
        }
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
  App.module("User", {
    startWithParent: false,
    define: function(Self, App, Backbone, Marionette, $) {
      var $contentArea, $contentToggleSpan, $infoBar, $infoBarToggleSpan, $infoBarToggler, $menuBar, $profile, $projectBar, $statusBox, $statusChanger, $statusIcon, $titlebar, cShowInfobar, defaultFolders, _init;

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
      Self.on("before:start", function() {
        App.logInfo("starting: " + Self.moduleName);
      });
      Self.on("start", function(options) {
        $(document).ready(function() {
          _init(options);
          return App.logInfo("started: " + Self.moduleName);
        });
      });
      Self.on("stop", function() {
        App.logInfo("stopped: " + Self.moduleName);
      });
      Self.on("linkbar.click", function(link, e) {
        var container, excludedModules;

        excludedModules = "".split(',');
        $.each(Self.submodules, function(i, module) {
          if (excludedModules.indexOf(i) === -1) {
            module.stop();
          }
        });
        container = link.data('pjax-container');
        $(".content-inner").wrapInner("<div id='" + (container.replace('#', '')) + "'></div>");
        $.pjax.click(e, {
          container: container
        });
      });
      Self._init = _init = function(settings) {
        var $menuLinks;

        Self.model = new App.Models.Person(settings.model);
        $profile = $(".profile");
        $titlebar = $profile.find(".titlebar .ContentTitle span");
        $infoBar = $(".js-infobar");
        $projectBar = $(".js-projectbar");
        $menuBar = $(".js-profile-menu > div > div > ul");
        $contentArea = $(".js-profile-content");
        $contentToggleSpan = $(".js-content-toggle");
        $infoBarToggleSpan = $(".js-infobar-outer");
        $menuLinks = $menuBar.find('a');
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
          var $clickedLink, $contentTitle, $pageTitle, $parent;

          $clickedLink = $(xhr.relatedTarget);
          $pageTitle = $clickedLink.data('pjax-title');
          $contentArea = $(xhr.target);
          $contentTitle = $contentArea.parents('.js-profile-content').find('.content-title > span');
          $contentTitle.text($pageTitle);
          $titlebar.text($pageTitle);
          $parent = $clickedLink.parent();
          document.title = "" + $pageTitle;
          $parent.find('.active').removeClass('active');
          $parent.siblings().removeClass('active');
          $clickedLink.children().removeClass('active');
          $parent.addClass('active');
          $parent.removeClass('loading');
        });
        App.logInfo("InfoBar: " + cShowInfobar);
        $(".ContentTitle span").tooltip({
          placement: 'bottom',
          trigger: 'hover focus',
          container: 'body'
        });
        $menuLinks.on("click", function(e) {
          var $link;

          $link = $(this);
          Self.trigger('linkbar.click', $link, e);
        });
        $menuLinks.tooltip({
          placement: 'right',
          html: 'true',
          trigger: 'hover focus',
          title: function(e) {
            return $(this).attr('data-tooltip-title');
          },
          container: 'body'
        });
        $(".action-buttons a.btn, .action-buttons button.btn").tooltip({
          placement: 'bottom',
          trigger: 'hover focus',
          container: 'body'
        });
      };
    }
  });

}).call(this);
/*!
* ACTIVITY
*/


(function() {
  App.module("Activity", {
    startWithParent: false,
    define: function(Self, App, Backbone, Marionette, $) {
      var $contentArea, $contentToggleSpan, $infoBar, $infoBarToggleSpan, $infoBarToggler, $menuBar, $profile, $projectBar, $statusBox, $statusChanger, $statusIcon, cancelCopy, continueCopy, defaultFolders, getGroupingList, hideInfobar, setCurrActivityType, setStatus, showInfobar, statusIcons, updateActivityList, updateAll, updateNoteCount;
      App.addRegions({
        profileRegion: ".profile"
      });
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
      Self.on("before:start", function() {
        App.logInfo("starting: " + Self.moduleName);
      });
      Self.on("start", function(options) {
        $(document).ready(function() {
          Self._init(options);
          return App.logInfo("started: " + Self.moduleName);
        });
      });
      Self.on("stop", function() {
        App.logInfo("stopped: " + Self.moduleName);
      });
      Self.on("linkbar.click", function(link, e) {
        var container, excludedModules;
        excludedModules = "Folders,Stats".split(',');
        $.each(Self.submodules, function(i, module) {
          if (excludedModules.indexOf(i) === -1) {
            module.stop();
          }
        });
        App.logDebug(link.data('pjax-container'));
        App.logDebug(link);
        container = link.data('pjax-container');
        App.logDebug(container);
        $(".content-inner").wrapInner("<div id='" + (container.replace('#', '')) + "'></div>");
        $.pjax.click(e, {
          container: container
        });
        App.logDebug("clicked: " + (link.attr('data-pjax-title')));
      });
      Self.on("status.changeStart", function(status) {
        App.logDebug("statusChange Started!");
        return $statusChanger.addClass('disabled');
      });
      Self.on("status.changeEnd", function(status) {
        App.logDebug("statusChange Ended!");
        $statusChanger.removeClass('disabled');
        addMessage("Status changed successfully!", 250, 6000, 4000);
        $statusIcon.attr('class', '').addClass('fg-' + statusIcons[status]);
        return $statusBox.addClass('activity-status-' + status);
      });
      Self._init = function(settings) {
        var $menuLinks;
        Self.model = new App.Models.Activity(settings.model);
        Self.linkbarCollection = new App.Collections.LinkbarCollection(settings.linkbar);
        Self.linkbarView = new App.Views.HubLinkbarView({
          collection: Self.linkbarCollection
        });
        Self.infobarView = new App.Views.HubInfobarView;
        Self.view = new App.Views.ActivityView({
          model: Self.model,
          linkbar: Self.linkbarView,
          infobar: Self.infobarView
        });
        Self.data = settings;
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
        $(document).on('pjax:send', function(xhr, options) {});
        $(document).on('pjax:timeout', function(e) {
          e.preventDefault();
        });
        $(document).on('pjax:complete', function(xhr, options, textStatus) {
          var $clickedLink, $contentTitle, $pageTitle, $parent;
          $clickedLink = $(xhr.relatedTarget);
          $pageTitle = $clickedLink.data('pjax-title');
          $contentArea = $(xhr.target);
          $contentTitle = $contentArea.parents('.js-profile-content').find('.content-title > h3');
          $contentTitle.text($pageTitle);
          $parent = $clickedLink.parent();
          console.log($parent);
          $parent.find('.active').removeClass('active');
          $parent.siblings().removeClass('active');
          $clickedLink.children().removeClass('active');
          $parent.addClass('active');
        });
        $infoBarToggler.on("click", function(e) {
          var $btn;
          $btn = $(this);
          if ($btn.hasClass('active')) {
            hideInfobar();
          } else {
            showInfobar();
          }
        });
        if (cActShowInfobar) {
          showInfobar();
        } else {
          hideInfobar();
        }
        if (!Modernizr.touch) {
          $(".ContentTitle span").tooltip({
            placement: 'bottom',
            trigger: 'hover focus',
            container: 'body'
          });
        }
        $menuLinks.each(function() {
          var $this;
          $this = $(this);
          $this.on("click", function(e) {
            var $link;
            $link = $(this);
            Self.trigger('linkbar.click', $link, e);
          });
          if (!Modernizr.touch) {
            return $this.tooltip({
              placement: 'right',
              html: true,
              title: function(e) {
                return $(this).attr('data-tooltip-title');
              },
              container: 'body'
            });
          }
        });
        if (!Modernizr.touch) {
          $(".action-buttons a.btn, .action-buttons button.btn").tooltip({
            placement: 'bottom',
            trigger: 'hover focus',
            container: 'body'
          });
        }
        $statusChanger.change(function() {
          var nStatus;
          Self.trigger('status.changeStart');
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
      showInfobar = function() {
        var $spanDiv;
        $spanDiv = $infoBar.parent();
        $.cookie('USER_ACTSHOWINFOBAR', 'true', {
          path: '/'
        });
        $infoBarToggler.addClass('active');
        $profile.removeClass('infobar-inactive').addClass('infobar-active');
      };
      hideInfobar = function() {
        var $spanDiv;
        $infoBarToggler.removeClass('active');
        $.cookie('USER_ACTSHOWINFOBAR', 'false', {
          path: '/'
        });
        $spanDiv = $infoBar.parent();
        $profile.removeClass('infobar-active').addClass('infobar-inactive');
      };
      setStatus = Self.setStatus = function(status) {
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
            Self.trigger('status.changeEnd', status);
          }
        });
      };
      updateAll = Self.updateAll = function() {
        Self.Stats.refresh(function() {});
        Self.Folders.refresh(function() {});
        updateActivityList();
      };
      updateActivityList = Self.updateActivityList = function() {
        $.post(sMyself + "Activity.ActivityList", {
          ActivityID: nActivity
        }, function(data) {
          return $("#ActivityList").html(data);
        });
      };
      updateNoteCount = Self.updateNoteCount = function() {
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
    }
  });

}).call(this);
/*!
* PERSON
*/


(function() {
  App.module("Person", {
    startWithParent: false,
    define: function(Self, App, Backbone, Marionette, $) {
      var $contentArea, $contentToggleSpan, $infoBar, $infoBarToggleSpan, $infoBarToggler, $menuBar, $profile, $projectBar, $statusBox, $statusChanger, $statusIcon, cShowInfobar, defaultFolders, hideInfobar, setStatus, showInfobar, statusIcons, updateAccountID, updateActions, updateAll, _init;
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
      Self.on("before:start", function() {
        App.logInfo("starting: " + Self.moduleName);
      });
      Self.on("start", function(options) {
        $(document).ready(function() {
          _init(options);
          return App.logInfo("started: " + Self.moduleName);
        });
      });
      Self.on("stop", function() {
        App.logInfo("stopped: " + Self.moduleName);
      });
      Self.on("linkbar.click", function(link, e) {
        var container, excludedModules;
        excludedModules = "Folders,Stats".split(',');
        $.each(Self.submodules, function(i, module) {
          if (excludedModules.indexOf(i) === -1) {
            module.stop();
          }
        });
        container = link.data('pjax-container');
        $(".content-inner").wrapInner("<div id='" + (container.replace('#', '')) + "'></div>");
        $.pjax.click(e, {
          container: container
        });
      });
      Self.on("status.changeStart", function(status) {
        $statusChanger.addClass('disabled');
      });
      Self.on("status.changeEnd", function(status) {
        $statusChanger.removeClass('disabled');
        addMessage("Status changed successfully!", 250, 6000, 4000);
        $statusIcon.attr('class', '').addClass('fg-' + statusIcons[status]);
        return $statusBox.addClass('activity-status-' + status);
      });
      Self._init = _init = function(settings) {
        var $menuLinks, infoBarState;
        Self.model = new App.Models.Person(settings.model);
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
        $(document).on('pjax:send', function(xhr, options) {});
        $(document).on('pjax:timeout', function(e) {
          e.preventDefault();
        });
        $(document).on('pjax:complete', function(xhr, options, textStatus) {
          var $clickedLink, $contentTitle, $pageTitle, $parent;
          $clickedLink = $(xhr.relatedTarget);
          $pageTitle = $clickedLink.data('pjax-title');
          $contentArea = $(xhr.target);
          $contentTitle = $contentArea.parents('.js-profile-content').find('.content-title > h3');
          $contentTitle.text($pageTitle);
          $parent = $clickedLink.parent();
          $parent.find('.active').removeClass('active');
          $parent.siblings().removeClass('active');
          $clickedLink.children().removeClass('active');
          $parent.addClass('active');
        });
        /*
        INFOBAR / COOKIE
        */

        infoBarState = App.getCookie('prefInfoBar') || 'on';
        App.logInfo("InfoBar: " + cShowInfobar);
        $infoBarToggler.on("click", function(e) {
          var $btn;
          $btn = $(this);
          if ($btn.hasClass('active')) {
            hideInfobar();
          } else {
            showInfobar();
          }
        });
        if (infoBarState === "on") {
          showInfobar();
        } else {
          hideInfobar();
        }
        if (!Modernizr.touch) {
          $(".ContentTitle span").tooltip({
            placement: 'bottom',
            trigger: 'hover focus',
            container: 'body'
          });
        }
        $menuLinks.on("click", function(e) {
          var $link;
          $link = $(this);
          Self.trigger('linkbar.click', $link, e);
        });
        if (!Modernizr.touch) {
          $menuLinks.tooltip({
            placement: 'right',
            html: 'true',
            trigger: 'hover focus',
            title: function(e) {
              return $(this).attr('data-tooltip-title');
            },
            container: 'body'
          });
          $(".action-buttons a.btn, .action-buttons button.btn").tooltip({
            placement: 'bottom',
            trigger: 'hover focus',
            container: 'body'
          });
        }
        $statusChanger.change(function() {
          var nStatus;
          Self.trigger('status.changeStart');
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
            $.post(sMyself + "Person.Credentials", {
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
                return window.location = sMyself + "Person.Home?Message=" + data.STATUSMSG;
              } else {
                return addError(data.STATUSMSG, 250, 6000, 4000);
              }
            });
          } else {
            addError("Please provide a reason.", 250, 6000, 4000);
          }
        });
      };
      showInfobar = function() {
        var $spanDiv;
        $spanDiv = $infoBar.parent();
        App.setCookie('prefInfoBar', 'on');
        App.logInfo("InfoBar: On (" + (App.getCookie('prefInfoBar')) + ")");
        cShowInfobar = true;
        $infoBarToggler.addClass('active');
        $infoBar.removeClass('hide');
        $profile.removeClass('infobar-inactive').addClass('infobar-active');
        $contentToggleSpan.removeClass('span24').addClass('span18');
        $infoBarToggleSpan.addClass('span6');
      };
      hideInfobar = function() {
        var $spanDiv;
        $infoBarToggler.removeClass('active');
        App.setCookie('prefInfoBar', 'off');
        App.logInfo("InfoBar: Off (" + (App.getCookie('prefInfoBar')) + ")");
        cShowInfobar = false;
        $spanDiv = $infoBar.parent();
        $profile.removeClass('infobar-active').addClass('infobar-inactive');
        $contentToggleSpan.removeClass('span18').addClass('span24');
        $infoBar.addClass('hide');
        $infoBarToggleSpan.removeClass('span6');
      };
      setStatus = Self.setStatus = function(status) {
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
            Self.trigger('status.changeEnd', status);
          }
        });
      };
      updateAll = function() {};
      updateActions = function() {};
      updateAccountID = function(sAccountID) {
        $("#AccountID").html(sAccountID);
      };
    }
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
        hub: 'user',
        modes: ["personTo", "personFrom"],
        queryParams: {
          personTo: App.User.model.get('id'),
          personFrom: App.User.model.get('id')
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
          path: "/assets/ZeroClipboard.swf",
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
  App.setCookie = function(c_name, value, exdays) {
    var c_value, exdate;

    exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    c_value = escape(value) + (!(exdays != null) ? "" : "; expires=" + exdate.toUTCString());
    document.cookie = "uc_" + c_name + "=" + c_value;
  };

  App.getCookie = function(c_name) {
    var c_end, c_start, c_value;

    c_value = document.cookie;
    c_start = c_value.indexOf(" uc_" + c_name + "=");
    if (c_start === -1) {
      c_start = c_value.indexOf(c_name + "=");
    }
    if (c_start === -1) {
      c_value = null;
    } else {
      c_start = c_value.indexOf("=", c_start) + 1;
      c_end = c_value.indexOf(";", c_start);
      if (c_end === -1) {
        c_end = c_value.length;
      }
      c_value = unescape(c_value.substring(c_start, c_end));
    }
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

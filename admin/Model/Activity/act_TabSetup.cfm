<cfscript>
  request.tabSettings = {
    "tabsSort":[
      "activity.detail",
      "activity.credits",
      "activity.attendees",
      "activity.faculty",
      "activity.committee",
      "activity.docs",
      "activity.application",
      "activity.agenda",
      "activity.finances",
      "activity.accme",
      "activity.pubgeneral",
      "activity.notes",
      "activity.reports",
      "activity.history"
    ],
    "tabs": {
      "activity.detail": {
        "label":"General Info",
        "title":"General Information",
        "tooltip":"Start Date: #DateFormat(activityBean.getStartDate(),'mm/dd/yyyy')#<br />End Date: #DateFormat(activityBean.getEndDate(),'mm/dd/yyyy')#",
        "icon":"icon-book-open",
        "event":"activity.detail",
        "hasToolbar":false,
        "subEvents":[]
      },
      "activity.faculty": {
        "label":"Faculty",
        "title":"Faculty / Speakers",
        "icon":"icon-user-md",
        "tooltip":"",
        "event":"activity.faculty",
        "hasToolbar":true,
        "subEvents":[]
      },
      "activity.committee": {
        "label":"Committee Members",
        "title":"Planning Committee Members",
        "icon":"icon-users",
        "tooltip":"",
        "event":"activity.committee",
        "hasToolbar":true,
        "subEvents":[]
      },
      "activity.finances": {
        "label":"Finances",
        "title":"Finances",
        "tooltip":"",
        "icon":"icon-money",
        "event":"activity.finances",
        "hasToolbar":false,
        "subEvents":["activity.finledger","activity.finbudget","activity.finfees","activity.finsupport"]
      },
      "activity.finledger": {
        "label":"General Ledger",
        "title":"General Ledger",
        "icon":"",
        "tooltip":"",
        "event":"activity.finledger",
        "hasToolbar":false,
        "subEvents":[]
      },
      "activity.finbudget": {
        "label":"Budget",
        "title":"Budget",
        "tooltip":"",
        "icon":"",
        "event":"activity.finbudget",
        "hasToolbar":false,
        "subEvents":[]
      },
      "activity.finsupport": {
        "label":"Commercial Support",
        "title":"Commercial Support",
        "tooltip":"Total Supporters: #ActivityBean.getStatSupporters()#<br />Total Dollars: #LSCurrencyFormat(ActivityBean.getStatSuppAmount())#",
        "icon":"",
        "event":"activity.finsupport",
        "hasToolbar":false,
        "subEvents":[]
      },
      "activity.finfees": {
        "label":"Fee Schedule",
        "title":"Fee Schedule",
        "icon":"",
        "tooltip":"",
        "event":"activity.finfees",
        "hasToolbar":false,
        "subEvents":[]
      },
      "activity.credits": {
        "label":"Credits",
        "title":"Credits",
        "tooltip":"CME: #activityBean.getStatCMEHours()#",
        "icon":"icon-award",
        "event":"activity.credits",
        "hasToolbar":true,
        "subEvents":[]
      },
      "activity.docs": {
        "label":"Files &amp; Documents",
        "title":"Files &amp; Documents",
        "tooltip":"",
        "icon":"icon-docs",
        "event":"activity.docs",
        "hasToolbar":true,
        "subEvents":[]
      },
      "activity.attendees": {
        "label":"Participants",
        "title":"Participants",
        "tooltip":"Total Records: #ActivityBean.getStatAttendees()#<br />Physicians: #ActivityBean.getStatMD()#<br />Non-Physicians: #ActivityBean.getStatNonMD()#<br />Addl Participants: #ActivityBean.getStatAddlAttendees()#",
        "icon":"icon-users",
        "event":"activity.attendees",
        "count":"#activityBean.getStatAttendees()#",
        "hasToolbar":true,
        "subEvents":[]
      },
      "activity.application": {
        "label":"Checklist",
        "title":"Application Checklist",
        "tooltip":"",
        "icon":"icon-flag-checkered",
        "event":"activity.application",
        "hasToolbar":true,
        "subEvents":[]
      },
      "activity.agenda": {
        "label":"Agenda",
        "title":"Agenda",
        "tooltip":"",
        "icon":"icon-calendar",
        "event":"activity.agenda",
        "hasToolbar":true,
        "subEvents":[]
      },
      "activity.pubgeneral": {
        "label":"Publish",
        "title":"Publishing Settings",
        "tooltip":"",
        "icon":"icon-globe",
        "event":"activity.pubgeneral",
        "hasToolbar":true,
        "subEvents":["activity.pubbuilder","activity.pubcategory","activity.pubspecialty"]
      },
      "activity.pubbuilder": {
        "label":"Builder",
        "title":"Builder Components",
        "tooltip":"",
        "icon":"",
        "event":"activity.pubbuilder",
        "hasToolbar":true,
        "subEvents":[]
      },
      "activity.pubcategory": {
        "label":"Categories",
        "title":"Categories",
        "tooltip":"",
        "icon":"",
        "event":"activity.pubcategory",
        "hasToolbar":true,
        "subEvents":[]
      },
      "activity.pubspecialty": {
        "label":"Specialities",
        "title":"Specialty Areas",
        "tooltip":"",
        "icon":"",
        "event":"activity.pubspecialty",
        "hasToolbar":true,
        "subEvents":[]
      },
      "activity.pubsites": {
        "label":"Sites",
        "title":"Sites to Publish To",
        "tooltip":"",
        "icon":"",
        "event":"activity.pubsites",
        "hasToolbar":true,
        "subEvents":[]
      },
      "activity.accme": {
        "label":"ACCME",
        "title":"ACCME Details",
        "tooltip":"",
        "icon":"icon-certificate",
        "event":"activity.accme",
        "hasToolbar":true,
        "subEvents":[]
      },
      "activity.history": {
        "label":"History",
        "title":"History",
        "tooltip":"",
        "icon":"icon-back-in-time",
        "event":"activity.history",
        "hasToolbar":true,
        "subEvents":[]
      },
      "activity.notes": {
        "label":"Notes",
        "title":"Notes",
        "tooltip":"",
        "icon":"icon-pin",
        "event":"activity.notes",
        "hasToolbar":true,
        "subEvents":[]
      },
      "activity.reports": {
        "label":"Reporting &amp; Exports",
        "title":"Reporting &amp; Exports",
        "tooltip":"",
        "icon":"icon-chart-bar",
        "event":"activity.reports",
        "hasToolbar":true,
        "subEvents":[]
      }
    }
  };
  if (structKeyExists(request.tabSettings.tabs,lcase(attributes.fuseaction))) {
    request.currentTab = request.tabSettings.tabs[lcase(attributes.fuseaction)];
  } else {
    request.currentTab = {
      "label":"",
      "title":"",
      "tooltip":"",
      "icon":"",
      "event":"#attributes.fuseaction#",
      "hasToolbar":false,
      "subEvents":[]
    }
  }

  Request.MultiFormQS = "?ActivityID=#Attributes.ActivityID#";
  Request.MultiFormLabels = "General,Faculty,Committee,Finances,Credits,Documents,Registrants,Other,Publish,Reports,History,Notes";
  Request.MultiFormFuseactions = "Activity.Detail,Activity.Faculty,Activity.Committee,Activity.Finances|Activity.FinLedger|Activity.FinBudget|Activity.FinSupport,Activity.Credits,Activity.Docs,Activity.Attendees,Activity.Other|Activity.Application|Activity.Agenda|Activity.CDCInfo|Activity.Meals,Activity.Publish|Activity.PubGeneral|Activity.PubSites|Activity.PubBuilder|Activity.PubCategory|Activity.PubSpecialty,Activity.Reports,Activity.History,Activity.Notes";
</cfscript>
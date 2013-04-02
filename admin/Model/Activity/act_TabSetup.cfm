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
        "icon":"card-address",
        "event":"activity.detail",
        "subEvents":[]
      },
      "activity.faculty": {
        "label":"Faculty",
        "title":"Faculty / Speakers",
        "icon":"user-business",
        "tooltip":"",
        "event":"activity.faculty",
        "subEvents":[]
      },
      "activity.committee": {
        "label":"Committee Members",
        "title":"Planning Committee Members",
        "icon":"user-female",
        "tooltip":"",
        "event":"activity.committee",
        "subEvents":[]
      },
      "activity.finances": {
        "label":"Finances",
        "title":"Finances",
        "tooltip":"",
        "icon":"money",
        "event":"activity.finances",
        "subEvents":["activity.finledger","activity.finbudget","activity.finfees","activity.finsupport"]
      },
      "activity.finledger": {
        "label":"General Ledger",
        "title":"General Ledger",
        "icon":"",
        "tooltip":"",
        "event":"activity.finledger",
        "subEvents":[]
      },
      "activity.finbudget": {
        "label":"Budget",
        "title":"Budget",
        "tooltip":"",
        "icon":"",
        "event":"activity.finbudget",
        "subEvents":[]
      },
      "activity.finsupport": {
        "label":"Commercial Support",
        "title":"Commercial Support",
        "tooltip":"Total Supporters: #ActivityBean.getStatSupporters()#<br />Total Dollars: #LSCurrencyFormat(ActivityBean.getStatSuppAmount())#",
        "icon":"",
        "event":"activity.finsupport",
        "subEvents":[]
      },
      "activity.finfees": {
        "label":"Fees",
        "title":"Fees",
        "icon":"",
        "tooltip":"",
        "event":"activity.finfees",
        "subEvents":[]
      },
      "activity.credits": {
        "label":"Credits",
        "title":"Credits",
        "tooltip":"CME: #activityBean.getStatCMEHours()#",
        "icon":"medal",
        "event":"activity.credits",
        "subEvents":[]
      },
      "activity.docs": {
        "label":"Files &amp; Documents",
        "title":"Files &amp; Documents",
        "tooltip":"",
        "icon":"documents",
        "event":"activity.docs",
        "subEvents":[]
      },
      "activity.attendees": {
        "label":"Participants",
        "title":"Participants",
        "tooltip":"Total Records: #ActivityBean.getStatAttendees()#<br />Physicians: #ActivityBean.getStatMD()#<br />Non-Physicians: #ActivityBean.getStatNonMD()#<br />Addl Participants: #ActivityBean.getStatAddlAttendees()#",
        "icon":"users",
        "event":"activity.attendees",
        "count":"#activityBean.getStatAttendees()#",
        "subEvents":[]
      },
      "activity.application": {
        "label":"Checklist",
        "title":"Application Checklist",
        "tooltip":"",
        "icon":"flag-checker",
        "event":"activity.application",
        "subEvents":[]
      },
      "activity.agenda": {
        "label":"Agenda",
        "title":"Agenda",
        "tooltip":"",
        "icon":"calendar-blue",
        "event":"activity.agenda",
        "subEvents":[]
      },
      "activity.pubgeneral": {
        "label":"Publish",
        "title":"Publishing Settings",
        "tooltip":"",
        "icon":"globe-green",
        "event":"activity.pubgeneral",
        "subEvents":["activity.pubbuilder","activity.pubcategory","activity.pubspecialty"]
      },
      "activity.pubbuilder": {
        "label":"Builder",
        "title":"Builder Components",
        "tooltip":"",
        "icon":"globe-green",
        "event":"activity.pubbuilder",
        "subEvents":[]
      },
      "activity.pubcategory": {
        "label":"Categories",
        "title":"Categories",
        "tooltip":"",
        "icon":"globe-green",
        "event":"activity.pubcategory",
        "subEvents":[]
      },
      "activity.pubspecialty": {
        "label":"Specialities",
        "title":"Specialty Areas",
        "tooltip":"",
        "icon":"globe-green",
        "event":"activity.pubspecialty",
        "subEvents":[]
      },
      "activity.pubsites": {
        "label":"Sites",
        "title":"Sites to Publish To",
        "tooltip":"",
        "icon":"globe-green",
        "event":"activity.pubsites",
        "subEvents":[]
      },
      "activity.accme": {
        "label":"ACCME",
        "title":"ACCME Details",
        "tooltip":"",
        "icon":"sealing-wax",
        "event":"activity.accme",
        "subEvents":[]
      },
      "activity.history": {
        "label":"History",
        "title":"History",
        "tooltip":"",
        "icon":"clock-history",
        "event":"activity.history",
        "subEvents":[]
      },
      "activity.notes": {
        "label":"Notes",
        "title":"Notes",
        "tooltip":"",
        "icon":"sticky-note-pin",
        "event":"activity.notes",
        "subEvents":[]
      },
      "activity.reports": {
        "label":"Reporting &amp; Exports",
        "title":"Reporting &amp; Exports",
        "tooltip":"",
        "icon":"chart",
        "event":"activity.reports",
        "subEvents":[]
      }
    }
  };
  
  Request.MultiFormQS = "?ActivityID=#Attributes.ActivityID#";
  Request.MultiFormLabels = "General,Faculty,Committee,Finances,Credits,Documents,Registrants,Other,Publish,Reports,History,Notes";
  Request.MultiFormFuseactions = "Activity.Detail,Activity.Faculty,Activity.Committee,Activity.Finances|Activity.FinLedger|Activity.FinBudget|Activity.FinSupport,Activity.Credits,Activity.Docs,Activity.Attendees,Activity.Other|Activity.Application|Activity.Agenda|Activity.CDCInfo|Activity.Meals,Activity.Publish|Activity.PubGeneral|Activity.PubSites|Activity.PubBuilder|Activity.PubCategory|Activity.PubSpecialty,Activity.Reports,Activity.History,Activity.Notes";
</cfscript>
<cfscript>
  request.tabSettings = {
    "tabsSort":[
      "activity.detail",
      "activity.faculty",
      "activity.committee",
      "activity.finances",
      "activity.credits",
      "activity.docs",
      "activity.attendees",
      "activity.application",
      "activity.agenda",
      "activity.pubgeneral",
      "activity.notes",
      "activity.reports",
      "activity.history"
    ],
    "tabs": {
      "activity.detail": {
        "label":"General Info",
        "title":"General Information",
        "icon":"card-address",
        "event":"activity.detail",
        "subEvents":[]
      },
      "activity.faculty": {
        "label":"Faculty",
        "title":"Faculty / Speakers",
        "icon":"user-business",
        "event":"activity.faculty",
        "subEvents":[]
      },
      "activity.committee": {
        "label":"Committee Members",
        "title":"Planning Committee Members",
        "icon":"user-female",
        "event":"activity.committee",
        "subEvents":[]
      },
      "activity.finances": {
        "label":"Finances",
        "title":"Finances",
        "icon":"money",
        "event":"activity.finances",
        "subEvents":["activity.finledger","activity.finbudget","activity.finsupport"]
      },
      "activity.credits": {
        "label":"Credits",
        "title":"Credits",
        "icon":"medal",
        "event":"activity.credits",
        "subEvents":[]
      },
      "activity.docs": {
        "label":"Files &amp; Documents",
        "title":"Files &amp; Documents",
        "icon":"documents",
        "event":"activity.docs",
        "subEvents":[]
      },
      "activity.attendees": {
        "label":"Participants",
        "title":"Participants",
        "icon":"users",
        "event":"activity.attendees",
        "subEvents":[]
      },
      "activity.application": {
        "label":"Checklist",
        "title":"Application Checklist",
        "icon":"flag-checker",
        "event":"activity.application",
        "subEvents":[]
      },
      "activity.agenda": {
        "label":"Agenda",
        "title":"Agenda",
        "icon":"calendar-blue",
        "event":"activity.agenda",
        "subEvents":[]
      },
      "activity.pubgeneral": {
        "label":"Publish",
        "title":"Publishing Settings",
        "icon":"globe-green",
        "event":"activity.pubgeneral",
        "subEvents":["activity.pubbuilder","activity.pubcategory","activity.pubspecialty"]
      },
      "activity.history": {
        "label":"",
        "title":"",
        "icon":"",
        "event":"",
        "subEvents":[]
      },
      "activity.notes": {
        "label":"Notes",
        "title":"Notes",
        "icon":"sticky-note-pin",
        "event":"activity.notes",
        "subEvents":[]
      },
      "activity.reports": {
        "label":"Reporting &amp; Exports",
        "title":"Reporting &amp; Exports",
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
<cfscript>
request.tabSettings = {
  "tabsSort":[
    "person.detail",
    "person.email",
    "person.address",
    "person.preferences",
    "person.activities",
    "person.notes",
    "person.history"
  ],
  "tabs": {
    "person.detail": {
      "label":"General Info",
      "title":"General Information",
      "tooltip":"",
      "icon":"card-address",
      "event":"person.detail",
      "hasToolbar":false,
      "subEvents":[]
    },
    "person.email": {
      "label":"Emails",
      "title":"Emails",
      "tooltip":"",
      "icon":"mail-at-sign",
      "event":"person.email",
      "hasToolbar":true,
      "subEvents":[]
    },
    "person.address": {
      "label":"Addresses",
      "title":"Addresses",
      "tooltip":"",
      "icon":"address-book-blue",
      "event":"person.address",
      "hasToolbar":true,
      "subEvents":[]
    },
    "person.preferences": {
      "label":"Preferences",
      "title":"Preferences",
      "tooltip":"",
      "icon":"equalizer",
      "event":"person.preferences",
      "hasToolbar":false,
      "subEvents":[]
    },
    "person.activities": {
      "label":"Activities",
      "title":"Activities",
      "tooltip":"",
      "icon":"book-open",
      "event":"person.activities",
      "hasToolbar":true,
      "subEvents":[]
    },
    "person.notes": {
      "label":"Notes",
      "title":"Notes",
      "tooltip":"",
      "icon":"sticky-note-pin",
      "event":"person.notes",
      "hasToolbar":false,
      "subEvents":[]
    },
    "person.history": {
      "label":"History",
      "title":"History",
      "tooltip":"",
      "icon":"newspaper",
      "event":"person.history",
      "hasToolbar":false,
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

Request.MultiFormQS = "?PersonID=#Attributes.PersonID#";
Request.MultiFormLabels = "General,Emails,Locations,Preferences,Activities,History";
Request.MultiFormFuseactions = "person.detail,person.email,person.address,person.preferences,person.activities,person.history";
</cfscript>
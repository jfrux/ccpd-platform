<cfscript>
request.tabSettings = {
  "tabsSort":[
    "person.detail",
    "person.email",
    "person.address",
    "person.activities",
    "person.photoupload",
    "person.preferences",
    "person.notes",
    "person.history"
  ],
  "tabs": {
    "person.detail": {
      "label":"About",
      "title":"About",
      "tooltip":"",
      "icon":"icon-info-circle",
      "event":"person.detail",
      "hasToolbar":false,
      "subEvents":[]
    },
    "person.email": {
      "label":"Emails",
      "title":"Emails",
      "tooltip":"",
      "icon":"icon-mail",
      "event":"person.email",
      "hasToolbar":true,
      "subEvents":[]
    },
    "person.address": {
      "label":"Addresses",
      "title":"Addresses",
      "tooltip":"",
      "icon":"icon-location",
      "event":"person.address",
      "hasToolbar":true,
      "subEvents":[]
    },
    "person.preferences": {
      "label":"Preferences",
      "title":"Preferences",
      "tooltip":"",
      "icon":"icon-cog",
      "event":"person.preferences",
      "hasToolbar":false,
      "subEvents":[]
    },
    "person.activities": {
      "label":"Activities",
      "title":"Activities",
      "tooltip":"",
      "icon":"icon-book-open",
      "event":"person.activities",
      "hasToolbar":true,
      "subEvents":[]
    },
    "person.photoupload": {
      "label":"Change Picture",
      "title":"Change Picture",
      "tooltip":"",
      "icon":"icon-picture",
      "event":"person.photoupload",
      "hasToolbar":false,
      "subEvents":[]
    },
    "person.notes": {
      "label":"Notes",
      "title":"Notes",
      "tooltip":"",
      "icon":"icon-pin",
      "event":"person.notes",
      "hasToolbar":false,
      "subEvents":[]
    },
    "person.history": {
      "label":"History",
      "title":"History",
      "tooltip":"",
      "icon":"icon-back-in-time",
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
<cfscript>
request.tabSettings = {
  "tabsSort":[
    "main.welcome",
    "main.people",
    "main.activities"
  ],
  "tabs": {
    "main.welcome": {
      "label":"News Feed",
      "title":"News Feed",
      "tooltip":"",
      "icon":"icon-article-alt",
      "event":"main.welcome",
      "hasToolbar":false,
      "subEvents":[]
    },
      "main.people": {
        "label":"People",
        "title":"People",
        "tooltip":"",
        "icon":"icon-users",
        "event":"main.people",
        "hasToolbar":false,
        "subEvents":[]
      },
      "main.activities": {
        "label":"Activities",
        "title":"Activities",
        "tooltip":"",
        "icon":"icon-book-open",
        "event":"main.activities",
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

Request.MultiFormQS = "";
Request.MultiFormLabels = "News Feed";
Request.MultiFormFuseactions = "main.welcome";
</cfscript>
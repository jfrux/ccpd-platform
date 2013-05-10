<cfscript>
request.tabSettings = {
  "tabsSort":[
    "main.welcome"
  ],
  "tabs": {
    "main.welcome": {
      "label":"News Feed",
      "title":"News Feed",
      "tooltip":"",
      "icon":"newspaper",
      "event":"main.welcome",
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
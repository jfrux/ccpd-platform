<cfscript>
request.tabSettings = {
  "tabsSort":[
    "main.welcome",
    "person.home",
    "activity.home"
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
    },
      "person.home": {
        "label":"People",
        "title":"People",
        "tooltip":"",
        "icon":"users",
        "event":"person.home",
        "hasToolbar":false,
        "subEvents":[]
      },
      "activity.home": {
        "label":"Activities",
        "title":"Activities",
        "tooltip":"",
        "icon":"book",
        "event":"activity.home",
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
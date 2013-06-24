/**
 * @name Search.cfc
 * @hint A component to do all things search
 * @author Justin S. Slamka
 */
 component accessors="true" {
    remote any function init() {
        return this;
    }

    remote any function findActivity() {
        // BUILD HTTP REQUEST
        httpServ = new http();
        httpServ.setMethod("GET");
        httpServ.setURL("http://10.168.1.132:9200/ccpd/activities/_search");
        httpServ.addParam(type="url",name="pretty",value=true);

        queryString = [];

        for(argument in arguments) {
            arrayAppend(queryString, argument & ":" & arguments[argument]);
        }

        //writeDump("PRE-MODIFIED SEARCH");
        writeDump(queryString);

        queryString = arrayToList(queryString, " AND ");

        //writeDump("POST-MODIFIED SEARCH")
        //writeDump(queryString);

        httpServ.addParam(type="url",name="q",value=queryString);

        //writeDump("SEND HTTP REQUEST")

        results = httpServ.send();

        //writeDump("HTTP REQUEST SENT");

        writeDump(results.getPrefix());
    }

    remote any function findPerson() {
        // BUILD HTTP REQUEST
        httpServ = new http();
        httpServ.setMethod("GET");
        httpServ.setURL("http://10.168.1.132:9200/ccpd/people/_search");
        httpServ.addParam(type="url",name="pretty",value=true);

        queryString = [];

        for(argument in arguments) {
            writeDump(argument);
            arrayAppend(queryString, argument & ":" & arguments[argument]);
        }

        //writeDump("PRE-MODIFIED SEARCH");
        writeDump(queryString);

        queryString = arrayToList(queryString, " AND ");

        //writeDump("POST-MODIFIED SEARCH")
        //writeDump(queryString);

        httpServ.addParam(type="url",name="q",value=queryString);

        //writeDump("SEND HTTP REQUEST")

        results = httpServ.send();

        //writeDump("HTTP REQUEST SENT");

        writeDump(results.getPrefix());
    }

    private any function formatActivitiesForInsertion(activitiesQuery) {
        ///writeDump("FORMAT ACTIVITY DATA")
        fileName = expandPath("/admin/_com/data/activity-data_" & dateFormat(now(), "mm-dd-yyyy") & ".txt");

        if(!fileExists(fileName)) {
            fileWrite(fileName, "", "utf-8");   
        }

        fileObj = fileOpen(fileName, "append");

        // BUILD INITIAL ACTIVITIES STRUCTURE
        newLine = chr(13) & chr(10);
        formattedActivities = "";

        // LOOP OVER ACTIVITIES
        for(activity in activitiesQuery) {
            //writeDump("FORMATTING ACTIVITY ##" & activity.activityId);

            activityIntro = "{""index"":{""_index"":""ccpd"",""_type"":""activities"",""_id"":""" & activity.activityId & """}}";
            activityStruct = {};

            activityStruct["activityTypeId"] = (structKeyExists(activity, "activityTypeId")) ? activity.activityTypeId : "";
            activityStruct["title"] = (structKeyExists(activity, "title")) ? activity.title : "";
            activityStruct["startDate"] = (structKeyExists(activity, "startDate")) ? activity.startDate : "";
            activityStruct["grouping"] = (structKeyExists(activity, "grouping")) ? activity.grouping : "";
            activityStruct["sessionType"] = (structKeyExists(activity, "sessionType")) ? activity.sessionType : "";
            activityStruct["activityId"] = (structKeyExists(activity, "activityId")) ? activity.activityId : "";
            activityStruct["description"] = (structKeyExists(activity, "description")) ? activity.description : "";
            activityStruct["groupingId"] = (structKeyExists(activity, "groupingId")) ? activity.groupingId : "";
            activityStruct["activityType"] = (structKeyExists(activity, "activityType")) ? activity.activityType : "";
            activityStruct["searchAll"] = (structKeyExists(activity, "searchAll")) ? activity.searchAll : "";
            
            //writeDump(serializeJSON(activityStruct));
            fileWrite(fileObj, activityIntro & newLine & serializeJSON(activityStruct) & newLine);
            formattedActivities = formattedActivities & activityIntro & newLine & serializeJSON(activityStruct) & newLine;
        }

        return formattedActivities;
    }

    private any function formatPeopleForInsertion(peopleQuery) {
        //writeDump("FORMAT PEOPLE DATA")
        fileName = expandPath("/admin/_com/data/people-data_" & dateFormat(now(), "mm-dd-yyyy") & ".txt");

        if(!fileExists(fileName)) {
            fileWrite(fileName, "", "utf-8");   
        }

        fileObj = fileOpen(fileName, "append");

        // BUILD INITIAL PEOPLE STRUCTURE
        newLine = chr(13) & chr(10);
        formattedPeople = "";

        // LOOP OVER PEOPLE
        for(person in peopleQuery) {
            //writeDump("FORMATTING PERSON ##" & person.personId);

            personIntro = "{""index"":{""_index"":""ccpd"",""_type"":""people"",""_id"":""" & person.personId & """}}";
            personStruct = {};

            personStruct["personId"] = (structKeyExists(person, "personId")) ? person.personId : "";
            personStruct["prefix"] = (structKeyExists(person, "prefix")) ? person.prefix : "";
            personStruct["firstName"] = (structKeyExists(person, "firstName")) ? person.firstName : "";
            personStruct["middleName"] = (structKeyExists(person, "middleName")) ? person.middleName : "";
            personStruct["lastName"] = (structKeyExists(person, "lastName")) ? person.lastName : "";
            personStruct["suffix"] = (structKeyExists(person, "suffix")) ? person.suffix : "";
            personStruct["displayName"] = (structKeyExists(person, "displayName")) ? person.displayName : "";
            personStruct["certName"] = (structKeyExists(person, "certName")) ? person.certName : "";
            personStruct["email"] = (structKeyExists(person, "email")) ? person.email : "";
            personStruct["birthDate"] = (structKeyExists(person, "birthDate")) ? person.birthDate : "";
            personStruct["ssn"] = (structKeyExists(person, "ssn")) ? person.ssn : "";
            personStruct["searchAll"] = (structKeyExists(person, "searchAll")) ? person.searchAll : "";
            
            //writeDump(serializeJSON(personStruct));
            fileWrite(fileObj, personIntro & newLine & serializeJSON(personStruct) & newLine);
            formattedPeople = formattedPeople & personIntro & newLine & serializeJSON(personStruct) & newLine;
        }

        return formattedPeople;
    }

    remote any function importFileData(fileName) {
        fileContents = fileRead(expandPath("/admin/_com/data/" & fileName), "utf-8");
        
        httpServ = new http();
        httpServ.setMethod("PUT");
        httpServ.setURL("http://10.168.1.132:9200/_bulk");
        httpServ.addParam(type="body",name="data",value=fileContents);
        httpServ.addParam(type="url",name="pretty",value=true);

        // writeDump("SEND HTTP REQUEST")

        results = httpServ.send();

        // writeDump("HTTP REQUEST SENT");

        // writeDump(results.getPrefix());
    }

    remote any function populateDB(type, id) {
        if(!structKeyExists(arguments, "id")) {
            arguments.id = 0;
        }

        switch(arguments.type) {
            case "activities":
                populateActivitiesDB(arguments.id);
                break;

            case "activity":
                populateActivitiesDB(arguments.id);
                break;

            case "people":
                populatePeopleDB(arguments.id);
                break;

            case "person":
                populatePeopleDB(arguments.id);
                break;
        }
    }

    private any function populateActivitiesDB(startingId) {
        //writeDump("BUILD QUERY");

        // BUILD QUERY
        qObj = new Query();
        qObj.setName("qActivities");
        qObj.setDataSource(application.settings.dsn);
        qObj.setSQL("SELECT TOP 7000 * FROM View_Activities WHERE activityId > :activityId");
        qObj.addParam(name="activityId", value=arguments.startingId, cfsqltype="cf_sql_integer");

        //writeDump("QUERY IS BUILT FOR ACTIVITIES");

        result = qObj.execute();
        qActivities = result.getResult();

        qObj.clearParams();

        //writeDump("CLEAR THE QUERY PARAMS");

        // FORMAT THE DATA INTO THE PROPER STRUCTURE
        if(qActivities.recordCount GT 0) {
            formattedActivities = formatActivitiesForInsertion(qActivities)

            writeDump('http://localhost:8888/admin/_com/search.cfc?method=populateDB&type=activities&id=' & qActivities.activityId[qActivities.recordCount]);
        } else {
            writeDump("DONE!");
        }
        //writeDump(formattedActivities);

        result = qObj.execute();
        qPeople = result.getResult();
    }

    private any function populatePeopleDB(startingId) {
        //writeDump("BUILD QUERY");

        // BUILD QUERY
        qObj = new Query();
        qObj.setName("qPeople");
        qObj.setDataSource(application.settings.dsn);
        qObj.setSQL("SELECT TOP 7000 * FROM View_People WHERE personId > :personId");
        qObj.addParam(name="personId", value=arguments.startingId, cfsqltype="cf_sql_integer");

        //writeDump("QUERY IS BUILT FOR PEOPLE");

        result = qObj.execute();
        qPeople = result.getResult();

        qObj.clearParams();

        //writeDump("CLEAR THE QUERY PARAMS");

        // FORMAT THE DATA INTO THE PROPER STRUCTURE
        if(qPeople.recordCount GT 0) {
            formattedPeople = formatPeopleForInsertion(qPeople);

            writeDump('http://localhost:8888/admin/_com/search.cfc?method=populateDB&type=people&id=' & qPeople.personId[qPeople.recordCount]);
        } else {
            writeDump("DONE!");
        }
        //writeDump(formattedPeople);
    }
 }
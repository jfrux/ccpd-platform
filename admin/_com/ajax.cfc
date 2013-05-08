/** 
* I am a base ajax class for all ajax_ cfc's within _com
*/ 
component displayname="ajax" output="false" {
  /**
  * Abstract Base Constructor
  * @returnType void 
  */ 
  private function init(struct settings = {}) {
    var loc = {};
    loc.defaults = {
    };
    VARIABLES.Instance = {};
    VARIABLES.config = {};
    structAppend(VARIABLES.config,loc.defaults);
    structAppend(VARIABLES.config,arguments.settings);
    return;
  }

  /**
  * calls the respective public_ method if no method exists...?
  * @returnFormat text
  * @access remote
  */
  remote function onMissingMethod(string missingMethodName,struct missingMethodArguments) {
    var returnVar = createObject("component","#application.settings.com#returnData.buildStruct").init();
    
    returnVar.setStatus(false);
    returnVar.setStatusMsg("Failed to perform '#variables.config.model#.#arguments.missingMethodName#'");
    
    returnVar = evaluate("application.#variables.config.model#.#arguments.missingMethodName#(argumentCollection=missingMethodArguments)");

    return returnVar.getJSON();
  }
}
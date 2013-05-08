/** 
* I am a base public class for all public_ cfc's within _com
*/ 
component displayname="public" output="false" {
  /** 
  * Abstract Base Constructor
  * @returnType void 
  */ 
  private function init(struct settings = {}) {
    var loc = {};
    loc.defaults = {
      'dsn':'ccpd_clone'
    };
    VARIABLES.Instance = {};

    VARIABLES.config = structAppend(loc.defaults,arguments.settings,true);

    return;
  }

  public function onMissingMethod(string missingMethodName,struct missingMethodArguments) {
    writeDump(var=arguments,abort=true);
  }
}
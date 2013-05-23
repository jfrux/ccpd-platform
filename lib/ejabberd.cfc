component {
  public ejabberd function init(domain string,ctlpath='',syscommand = "javaloader",javaloader = {}) {
    this.domain = arguments.domain;
    this.syscommand = arguments.syscommand;
    this.javaloader = arguments.javaloader;
    this.ctl = 'ejabberdctl';
    this.ctlpath = arguments.ctlpath;
    if(this.syscommand EQ "javaloader") {
      this.cmd = this.javaloader.create("au.com.webcode.util.SystemCommand").init();
    } else {
      this.cmd = createObject("java","au.com.webcode.util.SystemCommand").init();
    }

    return this;
  }

  public struct function register(username,password) {
    result = exec('register #arguments.username# #this.domain# #arguments.password#');
    if(result.exit EQ 1) {
      result.status = false;
    }
    return result;
  }

  public struct function unregister(username,password) {
    result = exec('unregister #arguments.username# #this.domain#');
    
    return result;
  }

  public struct function setPassword(username,password) {
    result = exec('set-password #arguments.username# #this.domain# #arguments.password#');
    
    return result;
  }

  public struct function exec(command) {
    returnVal = {'status':true,'output':'','errors':'','command':'','exit':''};

    result = this.cmd.execute('#this.ctlpath#/#this.ctl# #arguments.command#')  

    if(len(trim(result.getErrorOutput())) GT 0) {
      returnVal.status = false;
    }
    returnVal.errors = result.getErrorOutput();
    returnVal.output = result.getStandardOutput();
    returnVal.command = result.getCommand();
    returnVal.exit = result.getExitValue();

    return returnVal;
  }
}
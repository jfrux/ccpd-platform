component displayname="CCPD-PROVIDER API CLIENT" {
  public function init(apiBaseUrl = 'http://www.getmycme.com/',apiEndpoint = '') {
    this.baseUrl = arguments.apiBaseUrl;
    this.apiEndpoint = arguments.apiEndpoint;

    return this;
  }

  private function call(command,method,data) {
    apiUrl = this.baseUrl + this.apiEndpoint + command;
    client = new http();

    client.setMethod(arguments.method);
    client.setCharset('utf-8');
    client.setUrl(apiUrl)
    client.setAttributes(data);
  }

  public function get(command,data) {
    return call(command,'get',data);
  }

  public function put(command,data) {
    return call(command,'put',data);
  }

  public function post(command,data) {
    return call(command,'post',data);
  }

  public function delete(command,data) {
    return call(command,'delete',data);
  }

  include "imports/index.cfc";
  include "activities/index.cfc";
}
import org.jivesoftware.smack.BOSHConfiguration;
import org.jivesoftware.smack.BOSHConnection;
public class XMPP
{
  public XMPP()
  {
    //do nothing
  }

  public Boolean connect()
  {
    //create Bosh configuration
    BOSHConfiguration config = new BOSHConfiguration(false, "127.0.0.1", 7070, "/http-bind/", "your.domain.com", "xmpp:127.0.0.1:5222");

    //create a connection
    BOSHConnection connection = new BOSHConnection(config);

    connection.connect();
    connection.login(userName, password, resource);

    return true;
  }
}
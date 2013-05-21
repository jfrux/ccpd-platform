import org.jivesoftware.smack.BOSHConfiguration;
import org.jivesoftware.smack.BOSHConnection;
public class XMPP
{
  public XMPP()
  {
    //do nothing
  }

  public Boolean connect(String username, String password)
  {
    //create Bosh configuration
    BOSHConfiguration config = new BOSHConfiguration("ccpd.uc.edu");

    //create a connection
    BOSHConnection connection = new BOSHConnection(config);

    connection.connect();
    connection.login(userName, password,"ccpd-web");

    return true;
  }
}
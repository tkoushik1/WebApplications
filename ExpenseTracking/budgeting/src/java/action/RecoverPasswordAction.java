package action;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.validator.annotations.RequiredStringValidator;


import dao.UserDAO;
import java.util.Properties;
import javax.activation.DataHandler;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class RecoverPasswordAction  extends ActionSupport {

    private String username, message;
    
    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    @RequiredStringValidator(  message="Username is required!")
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
    
    @Override
    public String execute() throws Exception {
       User user  =  UserDAO.getUser(username);
       if ( user!= null) {
           // sendmail 
            Properties props = System.getProperties();
            // Get a Session object
            Session session = Session.getDefaultInstance( props, null);
            // construct the message
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress("admin@budgeting.com"));
            msg.setRecipient(Message.RecipientType.TO,
                    new InternetAddress( user.getEmail()));
            msg.setDataHandler(
                    new DataHandler(
                    new String("Dear User, <p/>Please use the following password to login. <p/>Password : " +    user.getPassword()  + 
                    "<p/>Regards,<br/>WebMaster,<br/>Budgeting.Com"),
                    "text/html"));
            msg.setSubject("Password Recovery");
            // send message
            Transport.send(msg);
           message = "A mail is sent to your email. Please use details given in the mail to log in again!";
           return  SUCCESS;
       }
       else {
          message = "Could not get find the given username!";
          return ERROR;
       }
    }
   
}

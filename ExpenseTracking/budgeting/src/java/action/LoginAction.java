
package action;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.validator.annotations.RequiredStringValidator;


import dao.UserDAO;
import java.util.Map;
import org.apache.struts2.interceptor.SessionAware;

public class LoginAction  extends ActionSupport  implements SessionAware {

    private String username, password, message;
    private Map<String,Object> sessionData;

    
    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

   
    public String getPassword() {
        return password;
    }

    @RequiredStringValidator( message="Password is required!") 
    public void setPassword(String password) {
        this.password = password;
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
       String userid =  UserDAO.login(username, password);
       if ( userid == null) {
           addActionError("Invalid Login!");
           return  ERROR;
       }
       else {
           sessionData.put("userid", userid);
           sessionData.put("username",username);
           return SUCCESS;
           
       }
    }

    @Override
    public void setSession(Map<String, Object> map) {
        sessionData = map;
    }
    
    
}

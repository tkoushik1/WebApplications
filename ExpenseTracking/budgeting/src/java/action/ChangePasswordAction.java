package action;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.validator.annotations.RequiredStringValidator;


import dao.UserDAO;
import java.util.Map;
import org.apache.struts2.interceptor.SessionAware;

public class ChangePasswordAction  extends ActionSupport
implements SessionAware {

    private String userid, password, newpassword, message, confirmPassword;
 
    @RequiredStringValidator( message="New password is required!") 
    public String getNewpassword() {
        return newpassword;
    }

    public void setNewpassword(String newpassword) {
        this.newpassword = newpassword;
    }

    @RequiredStringValidator( message="Confirm password is required!") 
    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    @RequiredStringValidator( message="Old password is required!") 
    public String getPassword() {
        return password;
    }

  
    public void setPassword(String password) {
        this.password = password;
    }
    
    @Override
    public String execute() throws Exception {
       boolean done  =  UserDAO.changePassword(userid, password, newpassword);
       if (!done) {
           message = "Sorry! Could not change password! Ensure your old password is correct!";
           return  ERROR;
       }
       else {
          message = "Successfully Changed Password!";
          return SUCCESS;
       }
    }

    @Override
    public void setSession(Map<String, Object> map) {
        // take userid from session 
        userid = (String) map.get("userid");
    }


    
    
}

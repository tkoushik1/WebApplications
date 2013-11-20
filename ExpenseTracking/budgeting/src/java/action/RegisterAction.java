package action;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.validator.annotations.RequiredStringValidator;


import dao.UserDAO;

public class RegisterAction  extends ActionSupport {

    private String username, password, message, confirmPassword, email;

    @RequiredStringValidator( message="Confirm password is required!") 
    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    
    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    @RequiredStringValidator( message="Password is required!") 
    public String getPassword() {
        return password;
    }

  
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
       String result =  UserDAO.register(username, password, email);
       if (result != null) {
           addActionError("Sorry! Could not register the user! Error --> " + result);
           return  ERROR;
       }
       else
          return SUCCESS;
    }
   
}

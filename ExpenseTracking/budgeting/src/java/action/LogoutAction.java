
package action;

import com.opensymphony.xwork2.ActionSupport;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.struts2.interceptor.ServletRequestAware;

public class LogoutAction  extends ActionSupport  implements ServletRequestAware {
    HttpServletRequest request;
    @Override
    public String execute() throws Exception {
           HttpSession session = request.getSession();
           session.invalidate(); // terminate session
           return "login";
    }

    @Override
    public void setServletRequest(HttpServletRequest hsr) {
        request = hsr;
    }
    
    
}

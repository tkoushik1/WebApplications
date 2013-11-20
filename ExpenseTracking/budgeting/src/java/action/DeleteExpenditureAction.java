package action;

import com.opensymphony.xwork2.ActionSupport;
import dao.BudgetDAO;
import java.util.Map;


import org.apache.struts2.interceptor.ParameterAware;


public class DeleteExpenditureAction  extends ActionSupport  implements  ParameterAware {
    private String expid, message;

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
    @Override
    public String execute() throws Exception {
       boolean done  =  BudgetDAO.deleteExpenditure(expid);
       if (!done) {
           message = "Sorry! Could not change password! Ensure your old password is correct!";
           return  ERROR;
       }
       else
          return SUCCESS;
    }

    @Override
    public void setParameters(Map<String, String[]> maps) {
        expid =  ((String [])  maps.get("expid"))[0];
       
    }

    
}

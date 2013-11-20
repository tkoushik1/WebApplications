package action;

import com.opensymphony.xwork2.ActionSupport;
import dao.BudgetDAO;
import java.util.List;

import java.util.Map;
import org.apache.struts2.interceptor.SessionAware;

public class ListBudgetsAction  extends ActionSupport implements SessionAware {
    private String userid;
    public List<Budget> getBudgets() {
         return BudgetDAO.getBudgets(userid);
    }
    
    @Override
    public String execute() throws Exception {
        return SUCCESS;
    }

    @Override
    public void setSession(Map<String, Object> map) {
         userid = (String) map.get("userid");
    }
    
}

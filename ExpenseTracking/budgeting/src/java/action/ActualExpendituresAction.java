package action;

import com.opensymphony.xwork2.ActionSupport;
import dao.BudgetDAO;
import java.util.List;

import java.util.Map;
import org.apache.struts2.interceptor.SessionAware;

public class ActualExpendituresAction  extends ActionSupport implements SessionAware {
    private String userid;
    public List<CategoryExpenditure> getExpenditures() {
         return BudgetDAO.getCategoryExpenditure(userid);
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

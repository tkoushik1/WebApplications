package action;

import com.opensymphony.xwork2.ActionSupport;
import dao.BudgetDAO;

import java.util.List;

public class AddBudgetForm  extends ActionSupport  {
    public List<Category> getCategories() {
         return BudgetDAO.getCategories();
    }
    
    @Override
    public String execute() throws Exception {
        return SUCCESS;
    }
    
}

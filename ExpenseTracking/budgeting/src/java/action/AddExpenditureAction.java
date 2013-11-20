package action;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.validator.annotations.IntRangeFieldValidator;
import dao.BudgetDAO;

import java.util.List;
import java.util.Map;
import org.apache.struts2.interceptor.SessionAware;

public class AddExpenditureAction  extends ActionSupport implements SessionAware {

    private String userid, message, category, description, date;

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    private int amount;

    @IntRangeFieldValidator(message = "Amount must be > 0", shortCircuit = true, min = "1")
    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }
    
    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
    
    public List<Category> getCategories() {
         return BudgetDAO.getBudgetCategories(userid);
    }
    
    @Override
    public String execute() throws Exception {
        System.out.println("It has come to execute");
        boolean done = BudgetDAO.addExpenditure(userid, category, description, date, amount);
        if ( done )  {
            message = "Sucessfully Added Expediture Entry!";
           return SUCCESS;
        }
        else
        {
            message = "Sorry Could Not Add Expenditure Entry!";
            return ERROR;
        }
    }

    @Override
    public void setSession(Map<String, Object> map) {
        userid = (String) map.get("userid");
    }
    
}

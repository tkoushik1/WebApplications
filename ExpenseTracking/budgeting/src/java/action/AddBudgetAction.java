package action;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.validator.annotations.IntRangeFieldValidator;
import dao.BudgetDAO;

import java.util.List;
import java.util.Map;
import org.apache.struts2.interceptor.SessionAware;

public class AddBudgetAction  extends ActionSupport implements SessionAware {

    private String userid, message, category;
    private int year,month,amount;

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

    @IntRangeFieldValidator(message = "Invalid Month", shortCircuit = true, min = "1", max = "12")
    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }
    

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
    
    public List<Category> getCategories() {
         return BudgetDAO.getCategories();
    }
    
    @Override
    public String execute() throws Exception {
        System.out.println("It has come to execute");
        boolean done = BudgetDAO.addBudget(userid, category, month, year, amount);
        if ( done )  {
            message = "Sucessfully Added Budget Entry!";
           return SUCCESS;
        }
        else
        {
            message = "Sorry Could Not Add Budget Entry!";
            return ERROR;
        }
    }

    @Override
    public void setSession(Map<String, Object> map) {
        userid = (String) map.get("userid");
    }
    
}

package dao;

import action.Budget;
import action.Category;
import action.CategoryExpenditure;
import action.Expenditure;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BudgetDAO {
    
    public static List<Category> getCategories() {
        
       Connection con = null;
        try {
            con = Database.getConnection();
            PreparedStatement ps =  con.prepareStatement("select catcode,catname from categories order by catname");
            ResultSet rs = ps.executeQuery();
            ArrayList<Category> cats = new ArrayList<Category>();
            while ( rs.next()) {
                cats.add( new Category( rs.getString(1), rs.getString(2)));
            }
            rs.close();
            return cats;
        }
        catch(Exception ex) {
            System.out.println("Error in BudgetDAO.getCategories() --> " + ex.getMessage());
            return null;
        }
        finally {
            Database.close(con);
        }
    }
    
    public static List<CategoryExpenditure> getCategoryExpenditure(String userid) {
        
       Connection con = null;
        try {
            con = Database.getConnection();
            PreparedStatement ps =  con.prepareStatement("select c.catname, amount budget, nvl(sum(exp_amount),0) expenditure from budgets b left outer join expenditures e on (e.catcode = b.catcode) inner join categories c on (c.catcode = b.catcode) where b.userid = ? and    (exp_date is null or to_char(exp_date,'mmyyyy') = to_char(sysdate,'mmyyyy')) group by c.catname, b.catcode, amount");
            ps.setString(1,userid);
            ResultSet rs = ps.executeQuery();
            ArrayList<CategoryExpenditure> exps = new ArrayList<CategoryExpenditure>();
            while ( rs.next()) {
                CategoryExpenditure exp = new CategoryExpenditure();
                exp.setCatname( rs.getString("catname"));
                exp.setBudget( rs.getInt("budget"));
                exp.setExpenditure( rs.getInt("expenditure"));
                exps.add(exp);
            }
            rs.close();
            return exps;
        }
        catch(Exception ex) {
            System.out.println("Error in BudgetDAO.getCategoryExpenditure() --> " + ex.getMessage());
            return null;
        }
        finally {
            Database.close(con);
        }
    }
    
    public static List<Category> getBudgetCategories(String userid) {
       Connection con = null;
        try {
            con = Database.getConnection();
            PreparedStatement ps =  con.prepareStatement("select catcode,catname from categories where catcode in  (select catcode from budgets where userid=? and year=to_char(sysdate,'yyyy') and to_char(sysdate,'mm') = month ) order by catname");
            ps.setString(1,userid);
            ResultSet rs = ps.executeQuery();
            ArrayList<Category> cats = new ArrayList<Category>();
            while ( rs.next()) {
                cats.add( new Category( rs.getString(1), rs.getString(2)));
            }
            rs.close();
            return cats;
        }
        catch(Exception ex) {
            System.out.println("Error in BudgetDAO.getBudgetCategories() --> " + ex.getMessage());
            return null;
        }
        finally {
            Database.close(con);
        }
    }
    
     public static List<Budget> getBudgets(String userid) {
        
       Connection con = null;
        try {
            con = Database.getConnection();
            PreparedStatement ps =  con.prepareStatement("select catcode, catname, amount from budgets b  join  categories c using(catcode) where userid = ? and  month = to_char(sysdate,'mm') and year = to_char(sysdate,'yyyy') order by catname");
            ps.setString(1,userid);
            ResultSet rs = ps.executeQuery();
            ArrayList<Budget> budgets = new ArrayList<Budget>();
            while ( rs.next()) {
                Budget b = new Budget();
                b.setCatname( rs.getString("catname"));
                b.setAmount( rs.getInt("amount"));
                budgets.add(b);
            }
            
            return budgets;
        }
        catch(Exception ex) {
            System.out.println("Error in BudgetDAO.getBudgets() --> " + ex.getMessage());
            return null;
        }
        finally {
            Database.close(con);
        }
    }
     
     
      public static List<Expenditure> getExpenditures(String userid) {
        
       Connection con = null;
        try {
            con = Database.getConnection();
            PreparedStatement ps =  con.prepareStatement("select catname,expid, exp_details, to_char(exp_date,'dd-Mon-yyyy') exp_date, exp_amount  from expenditures  e  join categories c on ( e.catcode = c.catcode) where userid = ? and  to_char(exp_date,'mm') = to_char(sysdate,'mm') and  to_char(exp_date,'yyyy') = to_char(sysdate,'yyyy') order by exp_date desc");
            ps.setString(1,userid);
            ResultSet rs = ps.executeQuery();
            ArrayList<Expenditure> explist = new ArrayList<Expenditure>();
            while ( rs.next()) {
                Expenditure e = new Expenditure();
                e.setExpid(rs.getInt("expid"));
                e.setCategory(rs.getString("catname"));
                e.setDate( rs.getString("exp_date"));
                e.setDescription( rs.getString("exp_details"));
                e.setAmount( rs.getInt("exp_amount"));
                explist.add(e);
            }
            return explist;
        }
        catch(Exception ex) {
            System.out.println("Error in BudgetDAO.getExpenditures() --> " + ex.getMessage());
            return null;
        }
        finally {
            Database.close(con);
        }
    }
    
     public static boolean addBudget(String userid, String category, int month, int year, int amount) {
        Connection con = null;
        try {
            con = Database.getConnection();
            PreparedStatement ps =
                    con.prepareStatement("insert into budgets values ( budgetid_sequence.nextval,?,?,?,?,?)");
            ps.setString(1,userid);
            ps.setInt(2,month);
            ps.setInt(3,year);
            ps.setString(4,category);
            ps.setInt(5,amount);
            

            int count = ps.executeUpdate();
            if ( count == 1)
               return true;  // no errors
            else
               return false;
                    
        }
        catch(Exception ex) {
            System.out.println("Error in BudetDAO.addBudget() --> " + ex.getMessage());
            return false;
        }
        finally {
            Database.close(con);
        }
     }
     
      public static boolean addExpenditure(String userid, String category, String description, String date, int amount) {
        Connection con = null;
        try {
            con = Database.getConnection();
            PreparedStatement ps =
                    con.prepareStatement("insert into expenditures values ( expid_sequence.nextval,?,?,?,?,?)");
            ps.setString(1,userid);
            ps.setString(2,date);
            ps.setString(3,description);
            ps.setInt(4,amount);
            ps.setString(5,category);

            int count = ps.executeUpdate();
            if ( count == 1)
               return true;  // no errors
            else
               return false;
                    
        }
        catch(Exception ex) {
            System.out.println("Error in BudetDAO.addExpenditure() --> " + ex.getMessage());
            return false;
        }
        finally {
            Database.close(con);
        }
     }
      
        public static boolean deleteExpenditure(String expid) {
        Connection con = null;
        try {
            con = Database.getConnection();
            PreparedStatement ps =
                    con.prepareStatement("delete from expenditures where expid = ? ");
            ps.setString(1,expid);
            int count = ps.executeUpdate();
            if ( count == 1)
               return true;  // no errors
            else
               return false;

        }
        catch(Exception ex) {
            System.out.println("Error in BudetDAO.deleteExpenditure() --> " + ex.getMessage());
            return false;
        }
        finally {
            Database.close(con);
        }
     }
    
}

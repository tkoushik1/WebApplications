
package dao;


import action.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class UserDAO {
    
    public static String register(String username, String password, String email) {
        Connection con = null;
        try {
            con = Database.getConnection();
            PreparedStatement ps =
                    con.prepareStatement("insert into users values ( userid_sequence.nextval,?,?,?)");
            ps.setString(1,username);
            ps.setString(2,password);
            ps.setString(3,email);

            int count = ps.executeUpdate();
            if ( count == 1)
               return null;  // no errors
            else
               return "Could not register user!";
                    
        }
        catch(Exception ex) {
            System.out.println("Error in UserDAO.register() --> " + ex.getMessage());
            return ex.getMessage();
        }
        finally {
            Database.close(con);
        }
     }
    

     public static boolean changePassword(String userid, String password, String newpassword) {
        Connection con = null;
        try {
            con = Database.getConnection();
            PreparedStatement ps =
                    con.prepareStatement(
                    "update users set password = ? where userid= ? and password = ?");
            ps.setString(1,newpassword);
            ps.setString(2,userid);
            ps.setString(3,password);
            int count = ps.executeUpdate();
            return count == 1;
        }
        catch(Exception ex) {
            System.out.println("Error in UserDAO.changePassword() --> " + ex.getMessage());
            return false;
        }
        finally {
            Database.close(con);
        }
    }

     public static String login(String username, String password) {
        Connection con = null;
        try {
            con = Database.getConnection();
            PreparedStatement ps =
                    con.prepareStatement(
                    "select userid from users where username = ? and password = ?");
            ps.setString(1,username);
            ps.setString(2,password);

            ResultSet rs = ps.executeQuery();
            
            if ( rs.next())  // user found
                return rs.getString(1);
            else
                return null;
        }
        catch(Exception ex) {
            System.out.println("Error in UserDAO.login() --> " + ex.getMessage());
            return null;
        }
        finally {
            Database.close(con);
        }
    }
     
     public static User getUser(String username) {
        Connection con = null;
        try {
            con = Database.getConnection();
            PreparedStatement ps =
                    con.prepareStatement(
                    "select email,password from users where username = ?");
            ps.setString(1,username);

            ResultSet rs = ps.executeQuery();
            
            if ( rs.next())  // user found
            {
               User u  = new User();
               u.setEmail(rs.getString(1));
               u.setPassword(rs.getString(2));
               return u;
            }
            else
                return null;
        }
        catch(Exception ex) {
            System.out.println("Error in UserDAO.getPassword() --> " + ex.getMessage());
            return null;
        }
        finally {
            Database.close(con);
        }
    }

}

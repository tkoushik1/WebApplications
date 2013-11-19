using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class UserDAL
{
    //  returns User object on success otherwise null 
    public static User Login(string email, string password)
    {
        try
        {
            BookDataContext bd = new BookDataContext();
            var user = (from u in bd.Users
                        where u.Email == email && u.Password == password 
                        select u).SingleOrDefault();
            return user;
        }
        catch (Exception ex)
        {
            Util.WriteToTrace("Login", ex.Message);
            return null;
        }
    }

    //  returns password 
    public static string GetPassword(string email)
    {
        try
        {
            BookDataContext bd = new BookDataContext();
            var password = (from u in bd.Users
                        where u.Email == email
                        select u.Password).SingleOrDefault();
            return password;
        }
        catch (Exception ex)
        {
            Util.WriteToTrace("GetPassword", ex.Message);
            return null;
        }
    }

    //  returns User object on success otherwise null 
    public static User ChangePassword(string email, string password, string newpassword)
    {
        try
        {
            BookDataContext bd = new BookDataContext();
            var user = (from u in bd.Users
                        where u.Email == email && u.Password == password
                        select u).SingleOrDefault();
            if (user == null)
                return null; // user details are invalid
            else
            {
                user.Password = newpassword;
                bd.SubmitChanges();
                return user;  // successfully changed password
            }
        }
        catch (Exception ex)
        {
            Util.WriteToTrace("ChangePassword", ex.Message);
            return null;
        }
    }


    //  returns User object on success otherwise null 
    public static User ChangeProfile(string email, string address, string mobileno)
    {
        try
        {
            BookDataContext bd = new BookDataContext();
            var user = (from u in bd.Users
                        where u.Email == email
                        select u).SingleOrDefault();
            if (user == null)
                return null; // user details are invalid
            else
            {
                user.Address = address;
                user.Mobileno = mobileno;
                bd.SubmitChanges();
                return user;  // successfully changed password
            }
        }
        catch (Exception ex)
        {
            Util.WriteToTrace("ChangeProfile", ex.Message);
            return null;
        }
    }

    public static bool Register(User u)
    {
        try
        {
            BookDataContext bd = new BookDataContext();
            bd.Users.InsertOnSubmit(u);
            bd.SubmitChanges();
            return true; 
        }
        catch (Exception ex)
        {
            Util.WriteToTrace ("Register", ex.Message);
            return false; 
        }
    }

    public static bool IsEmailPresent(string email)
    {
        try
        {
            BookDataContext bd = new BookDataContext();
            var user = (from u in bd.Users
                       where u.Email == email
                       select u).SingleOrDefault();
            return user != null;  // true if it is present 
        }
        catch (Exception ex)
        {
            Util.WriteToTrace("IsEmailPresent", ex.Message);
            return false;
        }

    }


    public static IQueryable <Order> GetUserOrders(string email)
    {
        try
        {
            BookDataContext bd = new BookDataContext();
            var orders = (from order in bd.Orders
                          where order.Email == email
                          orderby order.OrderDate 
                          select order);
            return orders;            
        }
        catch (Exception ex)
        {
            Util.WriteToTrace("GetUserOrders", ex.Message);
            return null;
        }

    }

    public static IQueryable GetOrderBooks(int orderid)
    {
        try
        {
            BookDataContext bd = new BookDataContext();
            var orderbooks = from orderbook in bd.OrderBooks
                         where orderbook.Orderid == orderid
                         select new
                         {
                             Title = orderbook.Book.Title,
                             Author = orderbook.Book.Author,
                             orderbook.NetPrice,
                             orderbook.Nocopies,
                             Total = orderbook.NetPrice * orderbook.Nocopies
                         };
            return orderbooks;
        }
        catch (Exception ex)
        {
            Util.WriteToTrace("GetOrderBooks", ex.Message);
            return null;
        }

    }
}
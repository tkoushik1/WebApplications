using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.Common;

/// <summary>
/// Summary description for BookDAL
/// </summary>
public class BookDAL
{

    
   
    public static int PlaceOrder(User u, List<Book> cart)
    {
        BookDataContext bd = new BookDataContext();
        bd.Connection.Open();
        DbTransaction trans = bd.Connection.BeginTransaction ();
        try
        {
            bd.Transaction = trans;
            Order order = new Order
            {
                Email = u.Email,
                OrderDate = DateTime.Now,
                ShippingAddress = u.Address,
                TotalAmount = cart.Sum(b => b.TotalNetPrice),
                Status = 'n'
            };

            bd.Orders.InsertOnSubmit(order);
            bd.SubmitChanges();

            foreach (Book b in cart)
            {
                OrderBook ob = new OrderBook
                {
                    Bookid = b.Bookid,
                    NetPrice = b.NetPrice,
                    Nocopies = b.NoCopies,
                    Orderid = order.Orderid
                };

                bd.OrderBooks.InsertOnSubmit(ob);
            }

            bd.SubmitChanges();
            trans.Commit();
            return order.Orderid; // success
        }
        catch (Exception ex)
        {
            trans.Rollback();
            Util.WriteToTrace("PlaceOrder", ex.Message);
            return 0; // failure
        }
        finally
        {
            bd.Connection.Close();

        }
    }

    public static IEnumerable<Book> GetRecentBooks()
    {
        BookDataContext bd = new BookDataContext();
        var books = (from b in bd.Books 
                     orderby b.Bookid descending
                     select b).Take(5);
        return books;
    }

    public static IEnumerable<Book> SearchBooks(string title)
    {
        BookDataContext bd = new BookDataContext();
        var books = (from b in bd.Books
                     where b.Title.ToUpper().Contains(title.ToUpper())
                     orderby b.Bookid descending
                     select b);
        return books;
    }

    public static Book GetBook(string bookid)
    {
        BookDataContext bd = new BookDataContext();
        var book = (from b in bd.Books
                     where b.Bookid == Int32.Parse(bookid)
                     select b).SingleOrDefault();
        return book;
    }
}


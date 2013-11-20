using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;


public class ExpensesDAL
{
    public static bool AddContribution(string progid, string memberid, 
        double amount,  string date)
    {
        SqlConnection con = new SqlConnection(Database.ConnectionString);
        using (con)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand
                    ("insert into expenses values('Contribution',@amount,@date,'c',@progid,@memberid)", con);
                cmd.Parameters.AddWithValue("@amount", amount);
                cmd.Parameters.AddWithValue("@date", date);
                cmd.Parameters.AddWithValue("@progid", progid);
                cmd.Parameters.AddWithValue("@memberid", memberid);
                cmd.ExecuteNonQuery();
                return true;
            }
            catch (Exception ex)
            {
                Util.LogToTrace("ExpensesDAL.AddContribution", ex.Message);
                return false;
            }
        }

    }



    public static DataTable GetMembersAmounts(string progid)
    {
        SqlConnection con = new SqlConnection(Database.ConnectionString);
        using (con)
        {
            try
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT pm.MemberId, m.Fullname, dbo.GetAmountPaid(pm.ProgId, pm.MemberId) AS AmountPaid, dbo.GetAmountSpent(pm.ProgId, pm.MemberId) AS AmountSpent FROM  Programmes_Members AS pm INNER JOIN  Members AS m ON m.MemberId = pm.MemberId WHERE (pm.ProgId = @progid)",con);
                da.SelectCommand.Parameters.AddWithValue("@progid", progid);
                DataSet ds = new DataSet(); 
                da.Fill (ds,"membersamounts");
                return ds.Tables[0];
            }
            catch (Exception ex)
            {
                Util.LogToTrace("ExpensesDAL.GetMembersAmounts", ex.Message);
                return null;
            }
        }

    }



    public static DataTable GetExpenses(string progid)
    {
        SqlConnection con = new SqlConnection(Database.ConnectionString);
        using (con)
        {
            try
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT expid, m.Fullname, e.ExpAmount, expdesc, expdate FROM Expenses AS e INNER JOIN  Members AS m ON e.MemberId = m.MemberId WHERE e.ProgId = @progid  and exptype = 'e' order by expid desc", con);
                da.SelectCommand.Parameters.AddWithValue("@progid", progid);
                DataSet ds = new DataSet();
                da.Fill(ds, "expenses");
                return ds.Tables[0];
            }
            catch (Exception ex)
            {
                Util.LogToTrace("ExpensesDAL.GetExpenses", ex.Message);
                return null;
            }
        }
    }

    public static DataTable GetExpense(string expid)
    {
        SqlConnection con = new SqlConnection(Database.ConnectionString);
        using (con)
        {
            try
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT expid, m.Fullname, e.ExpAmount, expdesc, expdate FROM Expenses AS e INNER JOIN  Members AS m ON e.MemberId = m.MemberId WHERE  expid = @expid", con);
                da.SelectCommand.Parameters.AddWithValue("@expid", expid);
                DataSet ds = new DataSet();
                da.Fill(ds, "expenses");
                return ds.Tables[0];
            }
            catch (Exception ex)
            {
                Util.LogToTrace("ExpensesDAL.GetExpense", ex.Message);
                return null;
            }
        }
    }


    public static DataTable GetMemberExpenses(string expid)
    {
        SqlConnection con = new SqlConnection(Database.ConnectionString);
        using (con)
        {
            try
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT Fullname, Amount FROM Expenses_Members as em INNER JOIN  Members as m on m.MemberId = em.MemberId WHERE expid = @expid order by fullname", con);
                da.SelectCommand.Parameters.AddWithValue("@expid", expid);
                DataSet ds = new DataSet();
                da.Fill(ds, "memberexpenses");
                return ds.Tables[0];
            }
            catch (Exception ex)
            {
                Util.LogToTrace("ExpensesDAL.GetMemberExpenses", ex.Message);
                return null;
            }
        }
    }


    public static bool AddExpenditure(string progid, string memberid, string description,
          string date,  double amount, Dictionary<String, double> memberamounts)
    {
        SqlConnection con = new SqlConnection(Database.ConnectionString);
        SqlTransaction trans = null; 
        using (con)
        {
            try
            {
                con.Open();
                trans = con.BeginTransaction();

                SqlCommand cmd = new SqlCommand
                    ("insert into expenses values(@description,@amount,@date,'e',@progid,@memberid)", con);
                cmd.Parameters.AddWithValue("@description", description);
                cmd.Parameters.AddWithValue("@amount", amount);
                cmd.Parameters.AddWithValue("@date", date);
                cmd.Parameters.AddWithValue("@progid", progid);
                cmd.Parameters.AddWithValue("@memberid", memberid);

                cmd.Transaction = trans; 
                cmd.ExecuteNonQuery();
                // get expid, which is identity value from most recent INSERT 

                cmd.CommandText = "select @@identity";
                String expid = cmd.ExecuteScalar().ToString();

                // insert into  EXPENSES_MEMBERS 

                SqlCommand cmd2 = new SqlCommand("insert into expenses_members values(@expid, @memberid, @amount)",con);
                cmd2.Transaction = trans;
                cmd2.Parameters.AddWithValue("@expid",expid);
                cmd2.Parameters.Add("@memberid", System.Data.SqlDbType.Int);
                cmd2.Parameters.Add("@amount", System.Data.SqlDbType.Money); 

                foreach (String member in memberamounts.Keys)
                {
                    cmd2.Parameters["@memberid"].Value = member;
                    cmd2.Parameters["@amount"].Value = memberamounts[member];
                    cmd2.ExecuteNonQuery();
                }

                trans.Commit(); 
                return true;
            }
            catch (Exception ex)
            {
                trans.Rollback();
                Util.LogToTrace("ExpensesDAL.AddExpenditure", ex.Message);
                return false;
            }
        }

    }
}
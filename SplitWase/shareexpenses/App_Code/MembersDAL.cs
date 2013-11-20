using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;

public class MembersDAL
{
    public static Member Login(string email, string password) {

        SqlConnection con = new SqlConnection(Database.ConnectionString);

        using (con)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand
                    ("select memberid,fullname from members where email = @email and password = @password", con);
                cmd.Parameters.AddWithValue("@email", email);
                cmd.Parameters.AddWithValue("@password", password);
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {  // member found
                    Member m = new Member
                    {
                        MemberId = Int32.Parse(dr["memberid"].ToString()),
                        Fullname = dr["fullname"].ToString()
                    };
                    return m;
                }
                else
                    return null; // login failed 
            }
            catch (Exception ex)
            {
                Util.LogToTrace("MembersDAL.Login",ex.Message);
                return null; 
            }
        }

    }


    public static bool EmailExists(string email)
    {
        SqlConnection con = new SqlConnection(Database.ConnectionString);
        using (con)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand
                    ("select * from members where email = @email", con);
                cmd.Parameters.AddWithValue("@email", email);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    return true;
                }
                else
                    return false; 
            }
            catch (Exception ex)
            {
                Util.LogToTrace("MembersDAL.EmailExists", ex.Message);
                return false;
            }
        }

    }



    public static string GetPassword(string email)
    {
        SqlConnection con = new SqlConnection(Database.ConnectionString);
        using (con)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand
                    ("select password from members where email = @email", con);
                cmd.Parameters.AddWithValue("@email", email);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                    return dr["password"].ToString();
                else
                    return null;
            }
            catch (Exception ex)
            {
                Util.LogToTrace("MembersDAL.GetPassword", ex.Message);
                return null;
            }
        }

    }



    public static bool Register(string email, string password, string fullname, string mobile)
    {
        SqlConnection con = new SqlConnection(Database.ConnectionString);
        using (con)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand
                    ("insert into members values(@fullname, @password,@email,@mobile)", con);
                cmd.Parameters.AddWithValue("@fullname", fullname);
                cmd.Parameters.AddWithValue("@mobile",mobile);
                cmd.Parameters.AddWithValue("@email", email);
                cmd.Parameters.AddWithValue("@password", password);
                int count = cmd.ExecuteNonQuery();
                return count == 1;
            }
            catch (Exception ex)
            {
                Util.LogToTrace("MembersDAL.Register", ex.Message);
                return false; 
            }
        }

    }


    public static bool ChangePassword(string memberid, string oldpassword, string password)
    {
        SqlConnection con = new SqlConnection(Database.ConnectionString);
        using (con)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand
                    ("update members set password = @password where memberid=@memberid and password = @oldpassword", con);
                cmd.Parameters.AddWithValue("@memberid",memberid);
                cmd.Parameters.AddWithValue("@oldpassword",oldpassword);
                cmd.Parameters.AddWithValue("@password", password);
                int count = cmd.ExecuteNonQuery();
                return count == 1;
            }
            catch (Exception ex)
            {
                Util.LogToTrace("MembersDAL.ChangePassword", ex.Message);
                return false;
            }
        }

    }
}
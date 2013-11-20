using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;


public class ProgrammesDAL
{
    public static bool AddProgramme(string title, string description, string startdate, string memberid)
    {
        SqlConnection con = new SqlConnection(Database.ConnectionString);
        
        using (con)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand  ("AddProgramme", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@title", title);
                cmd.Parameters.AddWithValue("@description", description);
                cmd.Parameters.AddWithValue("@startdate", startdate);
                cmd.Parameters.AddWithValue("@memberid", memberid);
                cmd.ExecuteNonQuery();
                return true; 
            }
            catch (Exception ex)
            {
                Util.LogToTrace("ProgrammesDAL.AddProgramme", ex.Message);
                return false;
            }
        }

    }

    public static bool DeleteProgramme(string progid)
    {
        SqlConnection con = new SqlConnection(Database.ConnectionString);

        using (con)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("DeleteProgramme", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@progid", progid);
                cmd.ExecuteNonQuery();
                return true;
            }
            catch (Exception ex)
            {
                Util.LogToTrace("ProgrammesDAL.DeleteProgramme", ex.Message);
                return false;
            }
        }

    }

    public static bool AddMemberToProgramme(string progid, string memberid)
    {
        SqlConnection con = new SqlConnection(Database.ConnectionString);
        using (con)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("insert into programmes_members values(@progid,@memberid)", con);
                cmd.Parameters.AddWithValue("@progid",progid);
                cmd.Parameters.AddWithValue("@memberid", memberid);
                int count = cmd.ExecuteNonQuery();
                return count == 1;
            }
            catch (Exception ex)
            {
                Util.LogToTrace("ProgrammesDAL.AddMemberToProgramme", ex.Message);
                return false;
            }
        }

    }

    public static DataTable GetProgrammes(string memberid)
    {
        SqlConnection con = new SqlConnection(Database.ConnectionString);
        using (con)
        {
            try
            {
                SqlDataAdapter da = new SqlDataAdapter("select * from programmes where memberid = @memberid order by title", con);
                da.SelectCommand.Parameters.AddWithValue("@memberid", memberid);
                DataSet ds = new DataSet();
                da.Fill(ds, "programmes");
                return ds.Tables[0];
            }
            catch (Exception ex)
            {
                Util.LogToTrace("ProgrammesDAL.GetProgrammes", ex.Message);
                return null;
            }
        }
    }


    public static DataTable GetProgramme(string progid)
    {
        SqlConnection con = new SqlConnection(Database.ConnectionString);
        using (con)
        {
            try
            {
                SqlDataAdapter da = new SqlDataAdapter("select progid, title, description, convert(char(10),startdate,101) startdate from programmes where progid = @progid", con);
                da.SelectCommand.Parameters.AddWithValue("@progid", progid);
                DataSet ds = new DataSet();
                da.Fill(ds, "programme");
                return ds.Tables[0];
            }
            catch (Exception ex)
            {
                Util.LogToTrace("ProgrammesDAL.GetProgramme", ex.Message);
                return null;
            }
        }
    }

    public static DataTable GetProgrammesByMember(string memberid)
    {
        SqlConnection con = new SqlConnection(Database.ConnectionString);
        using (con)
        {
            try
            {
                SqlDataAdapter da = new SqlDataAdapter("select * from programmes where progid in  ( select progid from programmes_members where memberid = @memberid) order by title", con);
                da.SelectCommand.Parameters.AddWithValue("@memberid", memberid);
                DataSet ds = new DataSet();
                da.Fill(ds, "programmes");
                return ds.Tables[0];
            }
            catch (Exception ex)
            {
                Util.LogToTrace("ProgrammesDAL.GetProgrammesByMember", ex.Message);
                return null;
            }
        }
    }

    public static DataTable GetMembersOfProgramme(string progid)
    {
        SqlConnection con = new SqlConnection(Database.ConnectionString);
        using (con)
        {
            try
            {
                SqlDataAdapter da = new SqlDataAdapter
                    ("select memberid, fullname from members where memberid in ( select memberid from programmes_members where progid = @progid)  order by fullname", con);
                da.SelectCommand.Parameters.AddWithValue("@progid", progid);
                DataSet ds = new DataSet();
                da.Fill(ds, "members");
                return ds.Tables[0];
            }
            catch (Exception ex)
            {
                Util.LogToTrace("ProgrammesDAL.GetMembersOfProgramme", ex.Message);
                return null;
            }
        }

    }


    public static DataTable GetNonMembersOfProgramme(string progid)
    {
        SqlConnection con = new SqlConnection(Database.ConnectionString);
        using (con)
        {
            try
            {
                SqlDataAdapter da = new SqlDataAdapter
                    ("select memberid, fullname from members where memberid not in (select memberid from programmes_members where progid = @progid)", con);
                da.SelectCommand.Parameters.AddWithValue("@progid", progid);
                DataSet ds = new DataSet();
                da.Fill(ds, "members");
                return ds.Tables[0];
            }
            catch (Exception ex)
            {
                Util.LogToTrace("ProgrammesDAL.GetNonMembersOfProgramme", ex.Message);
                return null;
            }
        }

    }
	
}
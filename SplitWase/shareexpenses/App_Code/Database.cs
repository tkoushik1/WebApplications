using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;

public class Database
{
    public static String ConnectionString
    {
        get
        {
            return WebConfigurationManager.
                      ConnectionStrings["ConnectionString"].
                      ConnectionString;
             
        }

    }
}
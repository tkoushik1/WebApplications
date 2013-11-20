using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


public class Util
{
    public static void LogToTrace(string method, string message)
    {
        HttpContext.Current.Trace.Write( "Error in " + method + " --> " + message);
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Util
/// </summary>
public class Util
{
    public static void WriteToTrace(string method, string message)
    {
        HttpContext.Current.Trace.Write(method + " --> " + message);
    }

    public static string GetStatusString(string status, object dispatchedon, object deliveredon)
    {
        switch (status)
        {
            case "n": return "New";
            case "p": return "Processed";
            case "d": return "Dispatched on " + dispatchedon.ToString();
            case "c": return "Completed on" + deliveredon.ToString();
        }
        return null;
    }
}
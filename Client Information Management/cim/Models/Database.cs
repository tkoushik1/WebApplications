using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Mvc;

namespace cim.Models
{
    public class Database
    {
        public static String ConnectionString
        {
            get
            {
                return WebConfigurationManager.ConnectionStrings["cim_cs"].ConnectionString;
            }
        }
        public static List<SelectListItem> InteractionTypes
        {
            get
            {
                return new List<SelectListItem> { 
                        new SelectListItem { Text="SMS", Value = "s"},
                        new SelectListItem { Text="EMail", Value = "e"},
                        new SelectListItem { Text="Phone", Value = "p"},
                        new SelectListItem { Text="Meet", Value = "m"} };

            }

        }
    }
    
}
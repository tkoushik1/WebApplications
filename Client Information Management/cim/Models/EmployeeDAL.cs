using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace cim.Models
{
    public class EmployeeDAL
    {
        public static string Login(int id, string password)
        {
            CIMDataContext dc = new CIMDataContext();
            var emp = (from e in dc.Employees
                       where e.Id == id && e.Password == password
                       select e).SingleOrDefault();

            if (emp == null)
                return null;
            else
                return emp.Name; 
        }

        public static bool ChangePassword(int id, string password, string newpassword)
        {
            CIMDataContext dc = new CIMDataContext();
            var emp = (from e in dc.Employees
                       where e.Id == id && e.Password == password
                       select e).SingleOrDefault();

            if (emp == null)
                return false;

            // change password
            emp.Password = newpassword;
            dc.SubmitChanges();
            return true; 
        }
    }
}
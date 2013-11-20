using cim.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace cim.Controllers
{
 
    public class EmployeeController : Controller
    {

        // GET: Employee/Login
     
        public ActionResult Login()
        {
            EmployeeLogin e = new EmployeeLogin(); 
            return View(e);
        }
        [HttpPost]
        public ActionResult Login(EmployeeLogin emp)
        {

            if (ModelState.IsValid)
            {
                string name = EmployeeDAL.Login( Int32.Parse(emp.Id), emp.Password);
                if (name != null)  // login is successful 
                {
                    Session.Add("id", emp.Id);
                    Session.Add("name", name);
                    FormsAuthentication.SetAuthCookie(name, false); 
                    return RedirectToAction("Home");
                }
                else
                {
                   emp.Message = "Login Failed. Please Try Again!";
                }

            }
            return View(emp); 
        }


        [Authorize]
        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Login");
        }


        [Authorize ]
        public ActionResult Home()
        {
            return View();
        }


        [Authorize]
        public ActionResult ChangePassword()
        {
            ChangePasswordModel m = new ChangePasswordModel();
            return View(m);
        }

        [HttpPost]
        [Authorize]
        public ActionResult ChangePassword(ChangePasswordModel m)
        {

            if (ModelState.IsValid)
            {
                bool done  = EmployeeDAL.ChangePassword ( Int32.Parse(Session["id"].ToString()),
                                           m.Password, m.NewPassword );
                if (done)  // login is successful 
                {
                    m.Message = "Password has been changed successfully!";
                }
                else
                {
                    m.Message = "Sorry! Could not change password. Old password may be incorrect!";
                }

            }
            return View(m);
        }



    } // EmployeeController
}

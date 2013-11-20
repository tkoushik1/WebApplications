using cim.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace cim.Controllers
{
    [Authorize]
    public class ClientController : Controller
    {
        public ActionResult Add()
        {
            Client c = new Client(); 
            return View(c);
        }


        public ActionResult Delete(int id)
        {
            bool done = ClientDAL.Delete(id);
            if (!done)
            {
                ViewBag.Message = "Sorry! Could Not Delete Client!";
            }
            return RedirectToAction("Home","Employee"); 
        }



        [HttpPost]
        public ActionResult Add(Client c)
        {
            if (ModelState.IsValid)
            {
                c.AddedBy = Int32.Parse(Session["id"].ToString());
                c.AddedOn = DateTime.Now;
                c.Creator = null; 
                bool done = ClientDAL.Add(c);

                if (done)
                {
                    ViewBag.Message = "Successfully added [" + c.Name + "] as new client!";
                }
                else
                {
                    ViewBag.Message = "Sorry! Could not add [" + c.Name + "] as client!";
                }
            }

            return View(c);
        }


        public ActionResult AddInteraction()
        {
            Interaction i = new Interaction();
            i.IntDate = DateTime.Today; 
            return View(i);
        }

        public ActionResult DeleteInteraction(int id)
        {
            var done = ClientDAL.DeleteInteraction(id);
            if (!done)
            {
                ViewBag.Message = "Sorry! Could not delete Interaction!";
            }
            return RedirectToAction("RecentInteractions"); 
        }

        [HttpPost]
        public ActionResult AddInteraction(Interaction interaction)
        {
            interaction.EmpId = Int32.Parse(Session["id"].ToString());
            if (ModelState.IsValid)
            {
                bool done = ClientDAL.AddInteraction(interaction);
                if (done)
                {
                    ViewBag.Message = "Successfully added interaction with client!";
                }
                else
                {
                    ViewBag.Message = "Sorry! Could not add interaction!";
                }
            }

            return View(interaction);
        }


        
        public ActionResult SearchClients(string pattern)
        {
            IQueryable<Client> clients = ClientDAL.Search(pattern);
            if ( clients != null && clients.Count () > 0)
                return PartialView("SearchClients", clients);
            else
                return PartialView("_SearchError");
        }

        [HttpGet]
        public ActionResult Edit(string id)
        {
            var client = ClientDAL.GetClient(id);
            return View(client);
        }

        [HttpPost]
        public ActionResult Edit(Client client)
        {
            if (ModelState.IsValid)
            {
                bool updated = ClientDAL.UpdateClient(client);
                if (updated)
                {
                    ViewBag.Message = "Client Details Updated Successfully!";

                }
                else
                {
                    ViewBag.Message = "Sorry! Could not update client's details!";
                }
            }
            return View(client);
        }


        public ActionResult RecentInteractions()
        {
            var interactions = ClientDAL.GetRecentInteractions();
            return View( interactions);
        }


        public ActionResult Details(String id)
        {
            var client = ClientDAL.GetClient(id);
            return View(client);
            
        }


    }
}

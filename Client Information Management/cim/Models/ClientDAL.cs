using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace cim.Models
{
    public class ClientDAL
    {
        public static IEnumerable<Client> GetAllClients()
        {
            try
            {
                CIMDataContext dc = new CIMDataContext();
                return dc.Clients; 
            }
            catch (Exception ex)
            {
                HttpContext.Current.Trace.Write("ClientDAL.GetAllClients() --> " + ex.Message);
                return null;
            }
        }


        public static IEnumerable<Interaction> GetRecentInteractions()
        {
            try
            {
                CIMDataContext dc = new CIMDataContext();
                return dc.Interactions.OrderByDescending(i => i.IntDate).Take(20); 
            }
            catch (Exception ex)
            {
                HttpContext.Current.Trace.Write("ClientDAL.GetRecentInteractions() --> " + ex.Message);
                return null;
            }
        }




        public static bool Add(Client client)
        {
            try
            {
                CIMDataContext dc = new CIMDataContext();
                dc.Clients.InsertOnSubmit(client);
                dc.SubmitChanges();
                return true;
            }
            catch (Exception ex)
            {
                HttpContext.Current.Trace.Write("ClientDAL.Add() --> " + ex.Message);
                HttpContext.Current.Trace.Write("ClientDAL.Add() --> " + ex.StackTrace); 
                return false; 
            }
        }

        public static bool AddInteraction(Interaction interaction)
        {
            try
            {
                CIMDataContext dc = new CIMDataContext();
                dc.Interactions.InsertOnSubmit(interaction);
                dc.SubmitChanges();
                return true;
            }
            catch (Exception ex)
            {
                HttpContext.Current.Trace.Write("ClientDAL.AddInteraction() --> " + ex.Message);
                return false;
            }
        }

        public static IQueryable<Client> Search(string pattern)
        {
            try
            {
                CIMDataContext dc = new CIMDataContext();
                var clients = from c in dc.Clients
                              where c.Name.ToUpper().Contains(pattern.ToUpper())
                              select c;
                return clients;
            }
            catch (Exception ex)
            {
                HttpContext.Current.Trace.Write("ClientDAL.Search() --> " + ex.Message);
                return null;
            }
        }

        public static Client GetClient(string id)
        {
            try
            {
                CIMDataContext dc = new CIMDataContext();
                var client = (from c in dc.Clients
                              where c.Id ==  Int32.Parse(id)
                              select c).SingleOrDefault();
                return client;
            }
            catch (Exception ex)
            {
                HttpContext.Current.Trace.Write("ClientDAL.GetClient() --> " + ex.Message);
                return null;
            }
        }

        public static bool UpdateClient(Client client)
        {
            try
            {
                CIMDataContext dc = new CIMDataContext();
                var dbclient = (from c in dc.Clients
                              where c.Id == client.Id 
                              select c).SingleOrDefault();
                // update client of database
                dbclient.Email = client.Email;
                dbclient.Phones = client.Phones;
                dbclient.Address = client.Address;
                dbclient.Name = client.Name;
                dc.SubmitChanges();
                return true; 
            }
            catch (Exception ex)
            {
                HttpContext.Current.Trace.Write("ClientDAL.UpdateClient() --> " + ex.Message);
                return false;
            }
        }


        public static bool Delete(int id)
        {
            try
            {
                CIMDataContext dc = new CIMDataContext();
                var interactions = from obj in dc.Interactions
                                   where obj.ClientId == id
                                   select obj;

                dc.Interactions.DeleteAllOnSubmit(interactions);

                var client =   (from c in dc.Clients 
                                   where c.Id == id
                                   select c).SingleOrDefault();

                dc.Clients.DeleteOnSubmit(client); 

                dc.SubmitChanges();
                return true;
            }
            catch (Exception ex)
            {
                HttpContext.Current.Trace.Write("ClientDAL.Delete() --> " + ex.Message);
                return false;
            }
        }


        public static bool  DeleteInteraction(int id)
        {
            try
            {
                CIMDataContext dc = new CIMDataContext();
                var interaction = (from c in dc.Interactions 
                                   where c.Id == id
                                   select c).SingleOrDefault();
                dc.Interactions.DeleteOnSubmit(interaction);
                dc.SubmitChanges();
                return true; 
            }
            catch (Exception ex)
            {
                HttpContext.Current.Trace.Write("ClientDAL.DeleteInteraction() --> " + ex.Message);
                return false;
            }
        }


    }
}
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.Linq;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace cim.Models
{
    [Table ( Name = "clients")]
    public class Client
    {
        [Column ( IsDbGenerated = true, IsPrimaryKey = true)]
        public int Id { get; set; }

        [Column ]
        [Required]
        public string Name { get; set; }
        
        [Column]
        [Required, EmailAddress]
        public string Email { get; set; }
        
        [Column]
        [Required]
        public string Phones { get; set; }
        
        [Column]
        public string Address { get; set; }
        [Column]
        public int AddedBy { get; set; }
        [Column]
        public DateTime AddedOn { get; set; }

        private EntityRef<Employee> _emp;


        [System.Data.Linq.Mapping.AssociationAttribute(Storage = "_emp", ThisKey = "AddedBy")]
        public Employee Creator
        {
            get
            {
                return _emp.Entity;
            }
            set
            {
                _emp.Entity = value;
            }
        }


        private EntitySet<Interaction> _interactions = new EntitySet<Interaction>();

        [System.Data.Linq.Mapping.AssociationAttribute(Storage = "_interactions", ThisKey = "Id", OtherKey = "ClientId")]
        public EntitySet<Interaction> Interactions
        {
            set
            {
                _interactions = value;
            }
            get
            {
                return _interactions;
            }
        }


        public IEnumerable<Interaction> AllInteractions
        {
            get
            {
                return Interactions.ToList<Interaction>(); 
            }
        }


        public static IEnumerable<SelectListItem> Clients
        {
            get
            {
                var clients = new List<SelectListItem>();
                foreach (Client c in ClientDAL.GetAllClients())
                {
                    clients.Add(new SelectListItem { Text = c.Name, Value = c.Id.ToString () });
                }

                return clients; 
            }
        }

        
    }
}
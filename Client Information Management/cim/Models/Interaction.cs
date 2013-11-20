using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.Linq;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Web;

namespace cim.Models
{
    [Table (Name = "Interactions")]
    public class Interaction
    {
        [Column ( IsPrimaryKey = true, IsDbGenerated = true)]
        public int Id { get; set; }

        [Column]
        public int ClientId { get; set; }

        [Column]
        public int EmpId { get; set; }

        [Column]
        public string IntType { get; set; }

        [Column]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}")]
        public DateTime IntDate { get; set; }

        [Column] 
        public string Remarks { get; set; }

        public string IntTypeString
        {

            get
            {
                switch( IntType ) {
                    case "s" : return "SMS";
                    case "e": return "Email";
                    case "p": return "Phone";
                    case "m": return "Meet";
                    default: return "";
                }
            }
        }


        private EntityRef<Client> _client;
        private EntityRef<Employee> _emp;

        [System.Data.Linq.Mapping.AssociationAttribute ( Storage = "_client", ThisKey = "ClientId")]
        public Client Client
        {
            get
            {
                return _client.Entity;
            }
            set
            {
                _client.Entity = value; 
            }
        }


        [System.Data.Linq.Mapping.AssociationAttribute(Storage = "_emp", ThisKey = "EmpId")]
        public Employee Employee
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

    }
}
using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Linq;
using System.Web;

namespace cim.Models
{
    public class CIMDataContext : DataContext 
    {

        public CIMDataContext()
            : base(Database.ConnectionString)
        {

        }

        public Table<Employee> Employees
        {
            get
            {
                return GetTable<Employee>();
            }
        }

        public Table<Client> Clients
        {
            get
            {
                return GetTable<Client>();
            }
        }

        public Table<Interaction > Interactions
        {
            get
            {
                return GetTable<Interaction>();
            }
        }
    }
}
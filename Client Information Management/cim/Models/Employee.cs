using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;

namespace cim.Models
{
    [Table ( Name="employees")]
    public class Employee
    {
        [Column ( IsPrimaryKey = true,IsDbGenerated = true)]
        [Required ( ErrorMessage="Employee Id Must Be Given!")]
        public int Id { get; set; }

        [Column]
        public string Name { get; set; }

        [Column]
        [Required(ErrorMessage = "Password Must Be Given!")]
        public string Password { get; set; }

        [Column]
        public string Designation { get; set; }

    }
}

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace cim.Models
{
    public class EmployeeLogin
    {
        [Required(ErrorMessage = "Employee Id Must Be Given!")]
        [Display ( Name ="Employee Id")]
        public string  Id { get; set; }

        [Required(ErrorMessage = "Password Must Be Given!")]
        public string Password { get; set; }

        public string Message { get; set; }
    }
}
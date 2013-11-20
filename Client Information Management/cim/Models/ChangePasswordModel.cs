using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace cim.Models
{
    public class ChangePasswordModel
    {
        public string Id { get; set; }
        [Required]
        public string Password { get; set; }
        [Required]
        public string NewPassword { get; set; }

        [Required, Compare ("NewPassword", ErrorMessage = "New password and confirm password do not match")] 
        public string ConfirmPassword { get; set; }

        public string Message { get; set; }

    }
}
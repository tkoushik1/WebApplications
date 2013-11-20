using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class Member
{
    public int MemberId { get; set; }
    public string Fullname { get; set; }
    public double AmountPaid { get; set; }
    public double AmountSpent { get; set; }
    public double AmountDue
    {
        get
        {
            return AmountPaid - AmountSpent;
        }
    }

}
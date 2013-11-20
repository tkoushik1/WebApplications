<%@ Page Language="C#" ValidateRequest="false"  %>
<%@ Import  Namespace = "System.Net.Mail" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

   
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string password = MembersDAL.GetPassword(txtEmail.Text);
        if (password == null)
            lblMsg.Text = "Sorry! Could not find your email address in our database!";
        else
        {
            MailMessage m = new MailMessage();
            m.To.Add(new MailAddress(txtEmail.Text));
            m.From = new MailAddress("admin@shareexpenses.com");
            m.Subject = "Password Recovery";
            m.IsBodyHtml = true;
            m.Body = "Dear Member,<p/>Here is your password to login back.<p/>" +
                     "Password : " + password + "<p/>Webmaster,<br/>ShareExpenses.Com";
            
            SmtpClient smtp = new SmtpClient("127.0.0.1", 25);
            smtp.Send(m);
            lblMsg.Text = "A mail has been sent with your password. Please use that to login again!";

        }
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
<center>
    <form id="form1" runat="server">
    <div class="mainblock">

      <div class="header">ShareExpenses.Com</div>
      <h2>Forgot Password</h2>
       Email Address :  <asp:TextBox ID="txtEmail" runat="server" Width="150px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                         ControlToValidate = "txtEmail"  
                         ErrorMessage="" Text="*" ToolTip = "Email is required!"></asp:RequiredFieldValidator>
                         <p />
       <asp:Button ID="btnSubmit" runat="server" Text="Submit" onclick="btnSubmit_Click" />
       <p />
       <asp:Label ID="lblMsg" runat="server" Text="" EnableViewState="false" ></asp:Label>
      <p />
        <a href="../login.aspx">Login Page</a>
        
    </div>
    </form>
    </center>
</body>
</html>

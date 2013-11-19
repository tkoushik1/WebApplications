<%@ Page Language="C#"  ValidateRequest ="false" %>
<%@ Import  Namespace = "System.Net.Mail" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    protected void btnRecover_Click(object sender, EventArgs e)
    {
        string password = UserDAL.GetPassword(txtEmail.Text);
        if (password == null)
        {
            lblMsg.Text = "Sorry! Email address not found!";
            return;
        }
        try
        {
            // send mail
            MailMessage m = new MailMessage();
            m.To.Add(new MailAddress(txtEmail.Text));
            m.From = new MailAddress("bob@oct11.com");
            m.Subject = "Password Recovery";
            m.IsBodyHtml = true;
            m.Body = "Dear User<p/>Please use the following password to login.<p/>"
                 + "Password : " + password + "<p/>WebMaster,<p/>BooksForCOD.Com";
            SmtpClient smtp = new SmtpClient("127.0.0.1", 25);
            smtp.Send(m);
            lblMsg.Text = "A mail was sent with your password. Please use those details to log back to website.";
        }
        catch (Exception ex)
        {
            Trace.Write(ex.Message);
            lblMsg.Text = "Sorry! Could not send mail!";
        }
        
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("../login.aspx");
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
   <form id="form1" runat="server">
   <div class="header">BooksForCOD.Com</div>
    <h2>
        Recover Password</h2>
    Enter your email address : 
                <asp:TextBox ID="txtEmail" Width="200px" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmail"
                    ErrorMessage="Email Address Is Required!"></asp:RequiredFieldValidator>
      <p />
    <asp:Button ID="btnRecover" runat="server" Text="Recover Password" 
              onclick="btnRecover_Click" />
    &nbsp;
    <asp:Button ID="btnCancel" runat="server" Text="Cancel"  CausesValidation = "false" 
              onclick="btnCancel_Click" />
    <p />
    <asp:Label ID="lblMsg" runat="server" Text="" EnableViewState="false"></asp:Label>
    </form>
</body>
</html>

<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    protected void btnLogin_Click(object sender, EventArgs e)
    {
       User user = UserDAL.Login(txtEmail.Text, txtPassword.Text);
       if (user != null)  
        {
            Session.Add("email", txtEmail.Text);
            Session.Add("user", user);
            FormsAuthentication.RedirectFromLoginPage(txtEmail.Text, false);
        }
        else
            lblMsg.Text = "Sorry! Invalid Login! Please try again.";
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
        Login</h2>
    <table>
        <tr>
            <td>
                Email Address :
            </td>
            <td>
                <asp:TextBox ID="txtEmail" Width="200px" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmail"
                    ErrorMessage="Email Address Is Required!"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                Password :
            </td>
            <td>
                <asp:TextBox ID="txtPassword" Width="200px" runat="server" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPassword"
                    ErrorMessage="Password Is Required!"></asp:RequiredFieldValidator>
            </td>
        </tr>
    </table>
    <p />
    <asp:Button ID="btnLogin" runat="server" Text="Login" onclick="btnLogin_Click" />
    <p />
    <a href="all/register.aspx">New User? Register!</a>
    <br />
    <a href="all/recoverpassword.aspx">Forgot Password? Recover your password!</a>
    <p />

    <asp:Label ID="lblMsg" runat="server" Text="" EnableViewState="false"></asp:Label>
    </form>
</body>
</html>
    
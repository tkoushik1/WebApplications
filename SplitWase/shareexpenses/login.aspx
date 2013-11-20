<%@ Page Language="C#"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        Member member = MembersDAL.Login(txtEmail.Text, txtPassword.Text);
        if (member == null)
            lblMsg.Text = "Sorry! Login Failed. Try Again!";
        else
        {
            Session.Add("memberid", member.MemberId);
            Session.Add("fullname", member.Fullname);
            FormsAuthentication.RedirectFromLoginPage(txtEmail.Text, false);
        }

    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <center>
    <div class="mainblock">
        <div class="header">ShareExpenses.Com</div>
        <h2>Login</h2>     

        
        <table>
            <tr>
                <td>
                   Email Address : 
                </td>
                <td>
                    <asp:TextBox ID="txtEmail" runat="server" Width="150px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                         ControlToValidate = "txtEmail" 
                         ErrorMessage="" Text="*" ToolTip = "Email is required!"></asp:RequiredFieldValidator>
 
               </td>
            </tr>

            <tr>
                <td>
                   Password : 
                </td>
                <td>
                    <asp:TextBox ID="txtPassword" TextMode="Password" Width="150px" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                         ControlToValidate = "txtPassword" 
                         ErrorMessage="" Text="*" ToolTip = "Password is required!"></asp:RequiredFieldValidator>

                    
                </td>
            </tr>
        </table>
        <p />
        <asp:Button ID="btnLogin" runat="server" Text="Login" onclick="btnLogin_Click"/>
        <p />
        <a href="all/register.aspx">Register!</a>
        <p />
        <a href="all/forgotpassword.aspx">Forgot Password?</a>
        <p />
        <asp:Label ID="lblMsg" runat="server" Text="" EnableViewState="false"></asp:Label>
        <p />
        <p />
        <center>
        <img src="all/img1.jpg" />
        </center>
   
    </div>
    </form>
    </center>
</body>
</html>

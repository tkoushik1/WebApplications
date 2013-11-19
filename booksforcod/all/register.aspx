<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        if (UserDAL.IsEmailPresent(txtEmail.Text))
        {
            lblMsg.Text = "Sorry! Email address is already present. Please use a different email address!";
            return;
        }
        
        User u = new User
        {
            Email = txtEmail.Text,
            Password = txtPassword.Text,
            Address = txtAddress.Text,
            Mobileno = txtMobile.Text,
            Registeredon = DateTime.Now
        };

        bool done = UserDAL.Register(u);
        if ( done ) 
            lblMsg.Text = "Registration is successful! Click <a href='../login.aspx'>here</a> to login. </a>";
        else
            lblMsg.Text = "Sorry! Registration Failed! Try again!";
            
                
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
    <div class="header">
        BooksForCOD.Com</div>
    <h2>
        Registration</h2>
    <table width="100%">
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
        <tr>
            <td>
                Confirm Password :
            </td>
            <td>
                <asp:TextBox ID="txtConfirmPassword" Width="200px" runat="server" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtConfirmPassword"
                    Display = "Dynamic"  ErrorMessage="Confirm Password Is Required!"></asp:RequiredFieldValidator>

              <asp:CompareValidator ID="CompareValidator1" runat="server"
                ControlToCompare = "txtConfirmPassword"  Display = "Dynamic" 
                 ControlToValidate="txtPassword"  Operator = "Equal" 
                  Type ="String" 
                ErrorMessage="Password and Confirm password do not match!"></asp:CompareValidator>
            </td>
        </tr>
        <tr>
            <td>
                Mailing Address :
            </td>
            <td>
                <asp:TextBox ID="txtAddress" Width="200px" TextMode="MultiLine" Rows="5" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Mobile Number :
            </td>
            <td>
                <asp:TextBox ID="txtMobile" Width="200px" runat="server"></asp:TextBox>
                <asp:RegularExpressionValidator  ControlToValidate = "txtMobile"
                   ValidationExpression = "^\d{10}$"
                    ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Mobile Number!"></asp:RegularExpressionValidator>

            </td>
        </tr>
    </table>
    <p />
    <asp:Button ID="btnRegister" runat="server" Text="Register" 
            onclick="btnRegister_Click" />
    &nbsp;
    &nbsp;
    <asp:Button ID="btnCancel" runat="server" Text="Cancel"  CausesValidation = "false" 
         BackColor = "White" ForeColor ="Red" Font-Bold="true"
            onclick="btnCancel_Click" />
    <p />
    <asp:Label ID="lblMsg" runat="server" Text="" EnableViewState="false"></asp:Label>
    </form>
</body>
</html>

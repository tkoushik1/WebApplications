<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void btnChangePassword_Click(object sender, EventArgs e)
    {
        string email = Session["email"].ToString();
        User u = UserDAL.ChangePassword(email, txtOldPassword.Text, txtPassword.Text);
        if (u == null)
        {
            lblMsg.Text = "Sorry! Couldn't change password. Old password may be invalid!";
            return;
        }

        lblMsg.Text = "Changed Password Successfully!";
        Session["user"] = u;  // update user object in the session 
       
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h2>
        Change Password</h2>
    <table>
     <tr>
            <td>
                Old Password :
            </td>
            <td>
                <asp:TextBox ID="txtOldPassword" Width="200px" runat="server" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="txtOldPassword"
                    ErrorMessage="Old Password Is Required!"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                New Password :
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
        </table>
        <p />
    <asp:Button ID="btnChangePassword" runat="server" Text="Change Password" 
                onclick="btnChangePassword_Click" />
    <p />
    <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
</asp:Content>


<%@ Page Title="Change Password" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void btnChange_Click(object sender, EventArgs e)
    {
        bool done = MembersDAL.ChangePassword(Session["memberid"].ToString(),
                                              txtOldPassword.Text, 
                                              txtPassword.Text);
        if (done)
            lblMsg.Text = "Successfully Changed Password!";
        else
            lblMsg.Text = "Incorrect old password. Please try again!";
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Change Password</h2>
<table> 
<tr>
                <td>
                   Old Password : 
                </td>
                <td>
                    <asp:TextBox ID="txtOldPassword" TextMode="Password" Width="150px" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                         ControlToValidate = "txtOldPassword" 
                         ErrorMessage="" Text="*" ToolTip = "Old Password is required!"></asp:RequiredFieldValidator>

                    
                </td>
            </tr>

            <tr>
                <td>
                   Password : 
                </td>
                <td>
                    <asp:TextBox ID="txtPassword" TextMode="Password" Width="150px" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                         ControlToValidate = "txtPassword" 
                         ErrorMessage="" Text="*" ToolTip = "Password is required!"></asp:RequiredFieldValidator>

                    
                </td>
            </tr>



              <tr>
                <td>
                   Confirm Password : 
                </td>
                <td>
                    <asp:TextBox ID="txtPassword2" TextMode="Password" Width="150px" runat="server"></asp:TextBox>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" 
                        ErrorMessage=""
                        text = "*" 
                        ControlToCompare = "txtPassword2" ControlToValidate="txtPassword" 
                        Operator="Equal" ToolTip ="Password and Confirm Password do not match!">
                   </asp:CompareValidator>
                </td>
            </tr>
            </table>
            <p />

            <asp:Button ID="btnChange" runat="server" Text="Change Password" onclick="btnChange_Click" 
                />
        <p />
        <asp:Label ID="lblMsg" runat="server" Text="" EnableViewState="false"></asp:Label>
</asp:Content>


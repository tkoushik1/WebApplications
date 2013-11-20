<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        bool done = MembersDAL.Register( txtEmail.Text, txtPassword.Text, txtFullname.Text, txtMobile.Text);
        if (done)
            lblMsg.Text = "Successfully Registered! Click <a href='../login.aspx'>here</a> to login!";
        else
           lblMsg.Text = "Sorry! Could not register!";    
                
    }

    protected void btnVerify_Click(object sender, EventArgs e)
    {
        if (MembersDAL.EmailExists(txtEmail.Text))
            lblEmailMsg.Text = "Email has been already used!";
        else
            lblEmailMsg.Text = "Valid Email Address";
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
      <h2>Member Registration</h2>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
       <table>
            <tr>
                <td>
                   
                   Email Address : 
                </td>
                <td>
                 <asp:UpdatePanel ID="UpdatePanel1" runat="server"> 
                 <ContentTemplate>
                    <asp:TextBox ID="txtEmail" runat="server" Width="150px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                         ControlToValidate = "txtEmail"  
                         ErrorMessage="" Text="*" ToolTip = "Email is required!"></asp:RequiredFieldValidator>
                     <asp:Button ID="btnVerify" runat="server" Text="Verify" 
                         CausesValidation = "false" 
                         onclick="btnVerify_Click" />
                     <asp:Label ID="lblEmailMsg" runat="server" Text="" EnableViewState="false" ></asp:Label>
                 </ContentTemplate>
                    </asp:UpdatePanel>
                 
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
             <tr>
                <td>
                   Fullname :
                </td>
                <td>
                    <asp:TextBox ID="txtFullname" Width="150px" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                         ControlToValidate = "txtFullname" 
                         ErrorMessage="" Text="*" ToolTip = "Fullname is required!"></asp:RequiredFieldValidator>
                </td>
            </tr>

              <tr>
                <td>
                   Mobile Number :
                </td>
                <td>
                    <asp:TextBox ID="txtMobile" Width="150px" runat="server" MaxLength="10"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                         ControlToValidate = "txtMobile" 
                         ErrorMessage="" Text="*" ToolTip = "Mobile Number is required!"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1"
                     ValidationExpression = "^[0-9]{10}$" 
                     ControlToValidate = "txtMobile"   Text = "*" 
                      ToolTip = "Invalid Mobile Number!"
                     runat="server" ErrorMessage=""></asp:RegularExpressionValidator>
                </td>
            </tr>


        </table>
        <p />
        <asp:Button ID="btnRegister" runat="server" Text="Register" 
                onclick="btnRegister_Click"/>
        <p />
        <a href="../login.aspx">Login Page</a>
        <p />
        <asp:Label ID="lblMsg" runat="server" Text="" EnableViewState="false"></asp:Label>

        <p />
        <center>
        <img src="img2.jpg" />
        </center>
    </div>
    </form>
    </center>
</body>
</html>

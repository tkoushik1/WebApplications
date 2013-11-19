<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            User u = (User)Session["user"];
            txtAddress.Text = u.Address;
            txtMobile.Text = u.Mobileno;
        }
    }

    protected void btnChangeProfile_Click(object sender, EventArgs e)
    {
        string email = Session["email"].ToString();
        User u = UserDAL.ChangeProfile(email, txtAddress.Text, txtMobile.Text);
        if (u == null)
            lblMsg.Text = "Sorry! Could not change profile!";
        else
        {
            lblMsg.Text = "Changed Profile Successfully!";
            Session["user"] = u;
        }
        
        
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h2>Change Profile</h2>
<table>
 <tr>
            <td valign="top">
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
      <asp:Button ID="btnChangeProfile" runat="server" Text="Change Profile" 
            onclick="btnChangeProfile_Click"/>
    <p />
    <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
</asp:Content>


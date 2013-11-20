<%@ Page Title="Add Program" Language="C#" MasterPageFile="~/MasterPage.master" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<script runat="server">

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        bool done = ProgrammesDAL.AddProgramme ( txtTitle.Text,txtDesc.Text, txtStartDate.Text, Session["memberid"].ToString());
        if ( done ) 
             lblMsg.Text = "Successfully added programme!";
        else
             lblMsg.Text = "Sorry! Could not add programme!";
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <h2>Add Programme</h2>
<table>
            <tr>
                <td>
                   
                   Title : 
                </td>
                <td>
                   <asp:TextBox ID="txtTitle" runat="server" Width="200px"></asp:TextBox>
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                         ControlToValidate = "txtTitle"  
                         ErrorMessage="" Text="*" ToolTip = "Title is required!"></asp:RequiredFieldValidator>
               </td>
            </tr>

            <tr>
                <td>
                   Description : 
                </td>
                <td>
                    <asp:TextBox ID="txtDesc" TextMode= "MultiLine" Width="200px" Rows="3" runat="server"></asp:TextBox>
                </td>
            </tr>


              <tr>
                <td>
                   Startind Date : 
                </td>
                <td>
                    <asp:TextBox ID="txtStartDate" Width="100px" runat="server"></asp:TextBox>
                    <cc1:CalendarExtender ID="txtStartDate_CalendarExtender" runat="server" 
                        Format="MM/dd/yyyy"
                        Enabled="True" TargetControlID="txtStartDate">
                    </cc1:CalendarExtender>
                    (mm/dd/yy)
                </td>
            </tr>
        </table>
        <p />
        <asp:Button ID="btnAdd" runat="server" Text="Add Programme" onclick="btnAdd_Click"/>
        <p />
        <asp:Label ID="lblMsg" runat="server" Text="" EnableViewState="false"></asp:Label>
</asp:Content>


<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<script runat="server">

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        bool done = ExpensesDAL.AddContribution(ddlProgrammes.SelectedValue,
            ddlMembers.SelectedValue, Double.Parse(txtAmount.Text),
            txtDate.Text);
        if (done)
        {
            lblMsg.Text = "Added contribution successfully!";
            txtAmount.Text = "";
            txtDate.Text = "";
        }
        
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
<h2>Add Contribution</h2>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
      <ContentTemplate> 
      
      
<table>

 <tr>
  <td>Select Programme : </td>
  <td> 
      <asp:DropDownList ID="ddlProgrammes" runat="server" AutoPostBack="True"  Width="200px"
          DataSourceID="odsProgrammes" DataTextField="title" DataValueField="progid">
      </asp:DropDownList>
      <asp:ObjectDataSource ID="odsProgrammes" runat="server" 
          SelectMethod="GetProgrammes" TypeName="ProgrammesDAL">
          <SelectParameters>
              <asp:SessionParameter Name="memberid" SessionField="memberid" Type="String" />
          </SelectParameters>
      </asp:ObjectDataSource>
     </td>
 </tr>
 <tr>
  <td>Select Member : </td>
  <td> 
      <asp:DropDownList ID="ddlMembers" runat="server" width="200px"
          DataSourceID="ObjectDataSource1" DataTextField="fullname" 
          DataValueField="memberid">
      </asp:DropDownList>
      <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
          SelectMethod="GetMembersOfProgramme" TypeName="ProgrammesDAL">
          <SelectParameters>
              <asp:ControlParameter ControlID="ddlProgrammes" Name="progid" 
                  PropertyName="SelectedValue" Type="String" />
          </SelectParameters>
      </asp:ObjectDataSource>
     </td>
 </tr>

 <tr>
  <td>Amount : </td>
 <td> 
     <asp:TextBox ID="txtAmount" runat="server"></asp:TextBox>
     <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
        ControlToValidate = "txtAmount" Text = "*" 
        ToolTip="Amount is required!"></asp:RequiredFieldValidator>
     </td>
     </tr>

     <tr>
     <td>
      Date : 
     </td>
     <td>
         <asp:TextBox ID="txtDate" runat="server"></asp:TextBox>(mm/dd/yy)
         <cc1:CalendarExtender ID="txtDate_CalendarExtender" runat="server" 
             Enabled="True" TargetControlID="txtDate">
         </cc1:CalendarExtender>
     </td>
     </tr>
</table>

</ContentTemplate>
    </asp:UpdatePanel>
<p />
   
    <asp:Button ID="btnAdd" runat="server" Text="Add" onclick="btnAdd_Click"/>
    <p />
       <asp:Label ID="lblMsg" runat="server" Text="" EnableViewState="false"></asp:Label>
</asp:Content>


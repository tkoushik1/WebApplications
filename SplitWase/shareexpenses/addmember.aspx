<%@ Page Title="Add Member" Language="C#" MasterPageFile="~/MasterPage.master" Trace="false" %>
<script runat="server">


    protected void btnAdd_Click(object sender, EventArgs e)
    {
        bool done = ProgrammesDAL.AddMemberToProgramme(ddlProgrammes.SelectedValue, 
                                                       ddlMembers.SelectedValue);
        if (done)
        {
            lblMsg.Text = "Member [" + ddlMembers.SelectedItem.Text + "]  has been added to  Programme [" + ddlProgrammes.SelectedItem.Text + "]";
            // remove member from dropdown
            ddlMembers.Items.RemoveAt(ddlMembers.SelectedIndex);
        }
        else
            lblMsg.Text = "Sorry! Could not add member to programme!";
    }

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
<h2>Add Member To Programme</h2>
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
          SelectMethod="GetNonMembersOfProgramme" TypeName="ProgrammesDAL">
          <SelectParameters>
              <asp:ControlParameter ControlID="ddlProgrammes" Name="progid" 
                  PropertyName="SelectedValue" Type="String" />
          </SelectParameters>
      </asp:ObjectDataSource>
     </td>
 </tr>
</table>

</ContentTemplate>
    </asp:UpdatePanel>
<p />
   
    <asp:Button ID="btnAdd" runat="server" Text="Add" onclick="btnAdd_Click" />
    <p />
       <asp:Label ID="lblMsg" runat="server" Text="" EnableViewState="false"></asp:Label>
</asp:Content>


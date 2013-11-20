<%@ Page Title="Add Expenditure" Language="C#" MasterPageFile="~/MasterPage.master"  %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<script runat="server">

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Dictionary<String, Double> memberamounts = new Dictionary<String, Double>();

        double totalamount = 0; 
        
        foreach (GridViewRow row in GridView1.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                String samount = ((TextBox) row.FindControl("txtAmount")).Text;
                String memberid = GridView1.DataKeys[ row.RowIndex].Value.ToString();
                if (samount.Trim() != "" && samount.Trim() != "0")
                {
                    double amount = Double.Parse(samount);
                    totalamount += amount; 
                    memberamounts.Add(memberid, amount);
                }
            }
        }

        bool done = ExpensesDAL.AddExpenditure(ddlProgrammes.SelectedValue, 
             Session["memberid"].ToString(), txtDescription.Text, txtDate.Text,
             totalamount, memberamounts);
        if (done)
        {
            lblMsg.Text = "Exenditure added successfully!";
            txtDescription.Text = "";
            txtDate.Text = "";
        }
        else
            lblMsg.Text = "Sorry! Could not add expenditure!";

                          
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<h2>Add Expenditure</h2>


 <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
     
<table>

 <tr>
  <td>Select Programme : </td>
  <td> 
      <asp:DropDownList ID="ddlProgrammes" runat="server"   Width="200px" AutoPostBack = "true"
          DataSourceID="odsProgrammes" DataTextField="title" DataValueField="progid">
      </asp:DropDownList>
      <asp:ObjectDataSource ID="odsProgrammes" runat="server" 
          SelectMethod="GetProgrammesByMember" TypeName="ProgrammesDAL">
          <SelectParameters>
              <asp:SessionParameter Name="memberid" SessionField="memberid" Type="String" />
          </SelectParameters>
      </asp:ObjectDataSource>
     </td>
 </tr>
 <tr>
 <td>Expenditure Description : </td>
 <td> 
     <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="3" Columns = "40"></asp:TextBox>
     <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
        ControlToValidate = "txtDescription" Text = "*" 
        ToolTip="Description is required!"></asp:RequiredFieldValidator>
     </td>
     </tr>

     <tr>
     <td>
      Date : 
     </td>
     <td>
         <asp:TextBox ID="txtDate" runat="server"></asp:TextBox>(mm/dd/yy)
         <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtDate" Format="MM/dd/yyyy">
         </cc1:CalendarExtender>

     </td>
     </tr>
    <tr>
    <td>
    Members Share :
    </td>
    <td>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataKeyNames = "memberid"  Width="100%"
        DataSourceID="odsMembers">
        <Columns>
            <asp:BoundField DataField="fullname" HeaderText="Member Name " />
            <asp:TemplateField HeaderText="Amount" ItemStyle-HorizontalAlign="Center">
               <ItemTemplate>
                   <asp:TextBox ID="txtAmount" runat="server"></asp:TextBox>
               </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="odsMembers" runat="server" 
        SelectMethod="GetMembersOfProgramme" TypeName="ProgrammesDAL">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlProgrammes" Name="progid" 
                PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    </td>
   </tr>
   </table>
    <p />
  
    <asp:Button ID="btnAdd" runat="server" Text="Add Expenditure" onclick="btnAdd_Click"/>
    <p />
       <asp:Label ID="lblMsg" runat="server" Text="" EnableViewState="false"></asp:Label>


</asp:Content>


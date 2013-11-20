<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h2>Details Of Expenditure</h2>

    <p>&nbsp;</p>
    <p>
        <asp:FormView ID="FormView1" runat="server" DataSourceID="odsExpense">
             <ItemTemplate>
       <table>
       <tr>
         <td class="colhead">Member :</td>
         <td> 
             <asp:Label ID="lblMember" runat="server" Text='<%# Eval("fullname") %>'></asp:Label>
         </td>
         </tr> 
         <tr>
         <td class="colhead">Description :</td>
         <td> 
             <asp:Label ID="lblDesc" runat="server" Text='<%# Eval("expdesc") %>'></asp:Label>
         </td>
         </tr>

         <tr>
         <td class="colhead">Amount : </td>
         <td> 
             <asp:Label ID="lblAmount" runat="server" Text='<%# Eval("expamount") %>'></asp:Label>
         </td>
         </tr>
         <tr>
         <td class="colhead">Date :</td>
         <td> 
             <asp:Label ID="lblDate" runat="server" Text='<%# String.Format("{0:MM/dd/yy}",Eval("expdate")) %>'></asp:Label>
         </td>
         </tr>
       </table>
    </ItemTemplate>
        </asp:FormView>
        
       <asp:ObjectDataSource ID="odsExpense" runat="server" 
            SelectMethod="GetExpense" TypeName="ExpensesDAL">
            <SelectParameters>
                <asp:QueryStringParameter Name="expid" QueryStringField="expid" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>

<p />        
<h3>Memberwise Breakup </h3>
 
        <asp:GridView ID="GridView1" runat="server" 
        DataSourceID="ObjectDataSource1" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="fullname" HeaderText="Member Name " />
                <asp:BoundField DataField="amount" DataFormatString="{0:##,##0.00}" 
                    HeaderText="Member Share">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
            SelectMethod="GetMemberExpenses" TypeName="ExpensesDAL">
            <SelectParameters>
                <asp:QueryStringParameter Name="expid" QueryStringField="expid" Type="String"  />
            </SelectParameters>
        </asp:ObjectDataSource>
    </p>



</asp:Content>


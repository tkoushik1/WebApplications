<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<h2>Programme Details</h2>
    <asp:FormView ID="FormView1" runat="server" DataSourceID="odsProgramme"> 
    <ItemTemplate>
       <table> 
         <tr>
         <td class="colhead">Title :</td>
         <td> 
             <asp:Label ID="lblTitle" runat="server" Text='<%# Eval("title") %>'></asp:Label>
         </td>
         </tr>

         <tr>
         <td class="colhead">Description :</td>
         <td> 
             <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("description") %>'></asp:Label>
         </td>
         </tr>
         <tr>
         <td class="colhead">Starting Date :</td>
         <td> 
             <asp:Label ID="lblStartDate" runat="server" Text='<%# Eval("startdate") %>'></asp:Label>
         </td>
         </tr>
       </table>
    </ItemTemplate>
    </asp:FormView>

    <asp:ObjectDataSource ID="odsProgramme" runat="server" 
        SelectMethod="GetProgramme" TypeName="ProgrammesDAL">
        <SelectParameters>
            <asp:QueryStringParameter Name="progid" QueryStringField="progid" 
                Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <p />
    
   
    <asp:GridView ID="GridView1" runat="server" DataSourceID="odsMembersAmounts"  Width="100%" EmptyDataText = "No expenses details found!" 
            AutoGenerateColumns="False">
        <Columns>
            <asp:BoundField DataField="fullname" HeaderText="Member Name" />
            <asp:BoundField DataField="amountpaid" HeaderText="Paid by Member" 
                ItemStyle-HorizontalAlign="Center"
                DataFormatString="{0:##,##0.00}" />
            <asp:BoundField DataField="amountspent" HeaderText="Spent On Member"  DataFormatString="{0:##,##0.00}" ItemStyle-HorizontalAlign="Center" />
            <asp:TemplateField headertext="Difference" ItemStyle-HorizontalAlign="Center" >
              <ItemTemplate>
                  <asp:Label ID="lblDue" runat="server" 
                  Text='<%#  String.Format("{0:##,##0.00}",
                      Double.Parse(Eval("amountpaid").ToString()) - Double.Parse(Eval("amountspent").ToString())) %>'></asp:Label>
              </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    </div>
        <asp:ObjectDataSource ID="odsMembersAmounts" runat="server" 
            SelectMethod="GetMembersAmounts" TypeName="ExpensesDAL">
            <SelectParameters>
                <asp:QueryStringParameter Name="progid" QueryStringField="progid" 
                    Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>



</asp:Content>


<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<h2>Expenses Report</h2>
Select Programme : 
   <asp:DropDownList ID="ddlProgrammes" runat="server" AutoPostBack="True"  Width="200px"
          DataSourceID="odsProgrammes" DataTextField="title" DataValueField="progid">
      </asp:DropDownList>
      <asp:ObjectDataSource ID="odsProgrammes" runat="server" 
          SelectMethod="GetProgrammesByMember" TypeName="ProgrammesDAL">
          <SelectParameters>
              <asp:SessionParameter Name="memberid" SessionField="memberid" Type="String" />
          </SelectParameters>
      </asp:ObjectDataSource>

      <p />

    <asp:GridView ID="GridView1" runat="server" AllowPaging="True"   Width="100%"
              DataSourceID="odsExpenses" AutoGenerateColumns="False">
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="expid" 
                DataNavigateUrlFormatString="memberexpenses.aspx?expid={0}" Text="Details" />
            <asp:BoundField DataField="fullname" HeaderText="Member" />
            <asp:BoundField DataField="expamount" DataFormatString="{0:##,##0.00}" 
                HeaderText="Amount ">
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="expdesc" HeaderText="Description" />
            <asp:BoundField DataField="expdate" DataFormatString="{0:MM/dd/yy}" ItemStyle-HorizontalAlign="Center"   
                HeaderText="Date" />
        </Columns>
    </asp:GridView>
          <asp:ObjectDataSource ID="odsExpenses" runat="server" 
              SelectMethod="GetExpenses" TypeName="ExpensesDAL">
              <SelectParameters>
                  <asp:ControlParameter ControlID="ddlProgrammes" Name="progid" 
                      PropertyName="SelectedValue" Type="String" />
              </SelectParameters>
          </asp:ObjectDataSource>

</asp:Content>


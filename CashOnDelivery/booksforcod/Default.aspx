<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h2>Most Recently Added Books</h2>

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"  Width="100%"
        DataSourceID="ObjectDataSource1">
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="bookid" 
                DataNavigateUrlFormatString="bookdetails.aspx?bookid={0}"
                HeaderText ="Title"
                DataTextField="Title" />
            <asp:BoundField DataField="Author" HeaderText="Author" 
                SortExpression="Author" />
            <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price"
                 DataFormatString ="{0:####.00}" ItemStyle-HorizontalAlign="Right" 
             />
            <asp:BoundField DataField="Discount" HeaderText="Discount" 
                 DataFormatString ="{0:##.00}" ItemStyle-HorizontalAlign="Right"
                SortExpression="Discount" />
            <asp:BoundField DataField="NetPrice" HeaderText="NetPrice" ReadOnly="True" 
                DataFormatString ="{0:####.00}" ItemStyle-HorizontalAlign="Right"
                SortExpression="NetPrice" />
            <asp:BoundField DataField="Nopages" HeaderText="Nopages" 
                DataFormatString ="{0:####}" ItemStyle-HorizontalAlign="Right"
                SortExpression="Nopages" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
        SelectMethod="GetRecentBooks" TypeName="BookDAL"></asp:ObjectDataSource>


</asp:Content>


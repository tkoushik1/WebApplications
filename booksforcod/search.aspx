<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master"  %>

<script runat="server">
    public void Page_Load(Object source, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            TextBox txtTitle = (TextBox)Master.FindControl("txtTitle");
            String title = Request.QueryString["title"];
            txtTitle.Text = title;
            GridView1.DataSource = BookDAL.SearchBooks(title);
            GridView1.DataBind();
        }
        
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Search Results</h2>

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
       EmptyDataText = "Sorry! No books were found!"
     Width="100%">
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="bookid" 
                DataNavigateUrlFormatString="bookdetails.aspx?bookid={0}"
                HeaderText ="Title"
                DataTextField="Title" />
            <asp:BoundField DataField="Author" HeaderText="Author" 
                SortExpression="Author" />
            <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
            <asp:BoundField DataField="Discount" HeaderText="Discount" 
                SortExpression="Discount" />
            <asp:BoundField DataField="NetPrice" HeaderText="NetPrice" ReadOnly="True" 
                SortExpression="NetPrice" />
            <asp:BoundField DataField="Nopages" HeaderText="Nopages" 
                SortExpression="Nopages" />
        </Columns>
       
    </asp:GridView>
    
</asp:Content>


<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">
    
    public void Page_Load(Object source, EventArgs e)
    {

        List<Book> cart = (List<Book>)Session["cart"];
        if (cart == null)
        {
            cart = new List<Book>();
        }

        GridView1.DataSource = cart;
        GridView1.DataBind();
        ShowTotal(cart);
    }

    private void ShowTotal(List<Book> cart)
    {
        decimal total = cart.Sum(b => b.TotalNetPrice);
        if (total > 0)
        {
            lblTotal.Text = "Total Amount : " + total.ToString();
            btnPlaceOrder.Visible = true;
        }
        else
            btnPlaceOrder.Visible = false; 

    }

    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

        String bookid = e.Keys[0].ToString();
        List<Book> cart = (List<Book>)Session["cart"];

        // delete the book from cart
        for (int i = 0; i < cart.Count; i++)
        {
            if (cart[i].Bookid == Int32.Parse(bookid))
            {
                cart.RemoveAt(i);
                break;
            }
        }

        GridView1.DataSource = cart;
        GridView1.DataBind();
        Session["cart"] = cart;
        ShowTotal(cart);

    }

    protected void btnPlaceOrder_Click(object sender, EventArgs e)
    {
        User u = (User)Session["user"];
        List<Book> cart = (List<Book>)Session["cart"];
        int orderid = BookDAL.PlaceOrder(u, cart);
        if (orderid > 0)
        {
            lblMsg.Text = "An order has been successfully placed with order id [" + orderid.ToString() + "]. Items will be shipped to your address very shortly.";
            Session.Remove("cart");// remove cart as order is placed
        }
    }
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h2>
        Shopping Cart</h2>
    <asp:GridView ID="GridView1" runat="server" Width="100%" DataKeyNames="bookid" 
        EmptyDataText="No Items Present In Your Cart!"
        AutoGenerateColumns="False" OnRowDeleting="GridView1_RowDeleting">
        <Columns>
            <asp:BoundField DataField="title" HeaderText="Title" />
            <asp:BoundField DataField="author" HeaderText="Author" />
            <asp:BoundField DataField="price" HeaderText="Price" />
            <asp:BoundField DataField="discount" HeaderText="Discount" />
            <asp:BoundField DataField="netprice" HeaderText="Net Price" />
            <asp:BoundField DataField="NoCopies" HeaderText="No. Copies" />
            <asp:BoundField DataField="TotalNetPrice" HeaderText="Total Amount" />
            <asp:CommandField ShowDeleteButton="True" />
        </Columns>
      
    </asp:GridView>
    <p />
    <asp:Label ID="lblTotal" runat="server" Text=""  EnableViewState ="false"></asp:Label>
    <p />
    <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order" OnClick="btnPlaceOrder_Click" />
    <p />
    <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
</asp:Content>

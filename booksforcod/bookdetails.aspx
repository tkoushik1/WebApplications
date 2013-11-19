<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            String bookid = Request.QueryString["bookid"];
            Book book = BookDAL.GetBook(bookid);
            Session["book"] = book;
            // populate controls with the details of book
            Image1.ImageUrl = "~/images/" + bookid + ".jpg";
            lblTitle.Text = book.Title;
            lblDescription.Text = book.Description ;
            lblAuthor.Text = book.Author;
            lblPrice.Text = book.Price.Value.ToString ("c");
            lblDiscount.Text = book.Discount.ToString () + "%";
            lblNetPrice.Text = book.NetPrice.ToString("c");
            lblNopages.Text = book.Nopages.Value.ToString();
        }
    }
    
    protected void btnAddToCart_Click(object sender, EventArgs e)
    {
        List<Book> cart = (List<Book>)Session["cart"];
        if (cart == null)
        {
           // create cart and place in session 
            cart = new List<Book>();
        }

        Book b = (Book)Session["book"];
        b.NoCopies = Int32.Parse(txtQuantity.Text);
        cart.Add(b);
        Session["cart"] = cart;
        lblMsg.Text = "[" + lblTitle.Text + "] has been added to cart!";               
             
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<table width="100%">
 <tr>
 <td valign="top" width="200px">
     <asp:Image ID="Image1" runat="server" Width = "150px" Height = "200px" />
 </td>
 <td valign="top">
    <span class="title">Title : </span>
    <asp:Label ID="lblTitle" runat="server" Text=""></asp:Label>
     <p />
     <span class="title"> Description :</span>   <asp:Label ID="lblDescription" runat="server" Text=""></asp:Label>
     <p />
      <span class="title"> Author  : </span> <asp:Label ID="lblAuthor" runat="server" Text=""></asp:Label>
     <p />
      <span class="title"> Pirce  : </span> <asp:Label ID="lblPrice" runat="server" Text=""></asp:Label>
      <span class="title"> Discount :</span> <asp:Label ID="lblDiscount" runat="server" Text=""></asp:Label>
      <span class="title"> Net Price :</span> <asp:Label ID="lblNetPrice" runat="server" Text=""></asp:Label>
      <p />
       <span class="title">  No. Pages  : </span> <asp:Label ID="lblNopages" runat="server" Text=""></asp:Label>
      <p />
      <span class="title"> Quanity : </span>
     <asp:TextBox ID="txtQuantity" runat="server" Text ="1" ></asp:TextBox>
     <p />
     <asp:Button ID="btnAddToCart" runat="server" Text="Add To Cart" 
             onclick="btnAddToCart_Click" />
             <p />
     <asp:Label ID="lblMsg" runat="server" Text="" class="title"></asp:Label>
 </td>
 </tr>
</table>
</asp:Content>


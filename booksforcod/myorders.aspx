<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master"%>

<script runat="server">
    
    public void Page_Load(Object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            DataList1.DataSource = UserDAL.GetUserOrders(Session["email"].ToString());
            DataList1.DataBind();
        }
    }

    protected void DataList1_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        // bind details for inner gridview
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType ==ListItemType.AlternatingItem)
        {
            Order order = (Order)e.Item.DataItem;
            GridView gvDetails= (GridView) e.Item.FindControl("gvDetails");
            gvDetails.DataSource = UserDAL.GetOrderBooks(order.Orderid);
            gvDetails.DataBind();
        }
        
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>My Orders</h2>
    <asp:DataList ID="DataList1" runat="server"  Width="100%" 
        onitemdatabound="DataList1_ItemDataBound">
       <ItemTemplate>
       <asp:Panel runat="server"  GroupingText ="Order Details"  BackColor="#dddddd" >  
       <table >
          <tr>
          <td> <span class="title">Order Id :</span></td>
          <td><%# Eval("orderid")%></td>
         </tr>

          <tr>
          <td> <span class="title">
          Order Date :</span>
          </td>
          <td><%# Eval("orderdate")%></td>
         </tr>

          <tr>
          <td> <span class="title">Shipping Address  :</span></td>
          <td><%# Eval("shippingaddress")%></td>
         </tr>

          <tr>
          <td> <span class="title">Total Amount :</span></td>
          <td><%# Eval("totalamount")%></td>
         </tr>
         <tr>
         <td>
           <span class="title">Status : </span>
          </td>
          <td><%# Util.GetStatusString( Eval("status").ToString(),
                        Eval("dispatchedon"),
                        Eval("deliveredon")) %></td>
         </tr>

       </table>
       <p />
       <h3>Books Ordered </h3>

       <asp:GridView ID="gvDetails" runat="server" Width="100%">
       </asp:GridView>

       </asp:Panel>
       <p />

       </ItemTemplate>
    </asp:DataList>


</asp:Content>


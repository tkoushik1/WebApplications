<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h2>List Of Programmes Owned</h2>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" width="100%"  EmptyDataText = "No programmes were created by you so far!"
            DataKeyNames = "progid" 
            DataSourceID="odsProgrammes">
            <Columns>
                <asp:BoundField DataField="title" HeaderText="Title" />
                <asp:BoundField DataField="startdate" DataFormatString="{0:MM/dd/yyyy}" 
                    HeaderText="Starting Date"  ItemStyle-HorizontalAlign="Center" />
                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                 <ItemTemplate>
                     <asp:LinkButton ID="lbDelete" 
                            OnClientClick="return confirm('Do you want to delete this programme and all its details?')"  
                            CommandName ="delete"  runat="server">Delete</asp:LinkButton>
                 </ItemTemplate>
                </asp:TemplateField>
                <asp:HyperLinkField DataNavigateUrlFields="progid" ItemStyle-HorizontalAlign="Center" 
                    DataNavigateUrlFormatString="programmedetails.aspx?progid={0}" Text="Details" />
            </Columns>

        </asp:GridView>
        <asp:ObjectDataSource ID="odsProgrammes" runat="server" 
            SelectMethod="GetProgrammes" TypeName="ProgrammesDAL" 
            DeleteMethod="DeleteProgramme">
            <DeleteParameters>
                <asp:Parameter Name="progid" Type="String" />
            </DeleteParameters>
            <SelectParameters>
                <asp:SessionParameter Name="memberid" SessionField="memberid" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>

        <p />


        <h2>List of Programmes Involved </h2>
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" width="100%"  EmptyDataText = "No programmes were created by you so far!"
            DataKeyNames = "progid" 
            DataSourceID="odsProgrammesInvolved">
            <Columns>
                <asp:BoundField DataField="title" HeaderText="Title" />
                <asp:BoundField DataField="startdate" DataFormatString="{0:MM/dd/yyyy}" 
                    HeaderText="Starting Date"  ItemStyle-HorizontalAlign="Center" />
                <asp:HyperLinkField DataNavigateUrlFields="progid" ItemStyle-HorizontalAlign="Center" 
                    DataNavigateUrlFormatString="programmedetails.aspx?progid={0}" Text="Details" />
            </Columns>

        </asp:GridView>
        <asp:ObjectDataSource ID="odsProgrammesInvolved" runat="server" 
            SelectMethod="GetProgrammesByMember" TypeName="ProgrammesDAL" 
            DeleteMethod="DeleteProgramme">
            <SelectParameters>
                <asp:SessionParameter Name="memberid" SessionField="memberid" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
</asp:Content>


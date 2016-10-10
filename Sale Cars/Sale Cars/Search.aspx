<%@ Page Title="" Language="C#" MasterPageFile="~/template_sale_cars.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="Sale_Cars.Search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="right" runat="server">
    <div class="search" style="float: left; margin: auto; text-align: center; width: 100%;">
        <asp:TextBox ID="txtKeyWords" runat="server" placeholder="Seach..." CssClass="textsearch"></asp:TextBox>
        <asp:Button ID="btnMainSearch" runat="server" Text="Search" CssClass="gray-button" OnClick="btnMainSearch_Click" />
        <div>
            <asp:RadioButton ID="rbtName" runat="server" Text="Name" Checked="true" GroupName="search" />
            <asp:RadioButton ID="rbtPrice" runat="server" Text="Price" GroupName="search" />
            <asp:CheckBox ID="chkAll" runat="server" Text="Search all" Checked="true" OnCheckedChanged="chkAll_CheckedChanged" />

            <asp:Panel ID="pnOption" runat="server">
                <asp:DropDownList ID="DDlType" runat="server" OnSelectedIndexChanged="DDlType_SelectedIndexChanged"></asp:DropDownList>
                <asp:DropDownList ID="DDLCategory" runat="server" OnSelectedIndexChanged="DDLCategory_SelectedIndexChanged"></asp:DropDownList>
            </asp:Panel>
        </div>
        <hr />
    </div>
    <div class="clear"></div>
    <div class="text">
        <asp:ListView ID="lvwProducts" runat="server" ItemPlaceholderID="itemPlaceholder" OnItemCommand="lvwProducts_ItemCommand" OnItemDataBound="lvwProducts_ItemDataBound" OnPagePropertiesChanging="lvwProducts_PagePropertiesChanging">
            <LayoutTemplate>
                <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
            </LayoutTemplate>
            <ItemTemplate>
                <div class="grid_1_of_3 images_1_of_3">
                    <div class="grid_1">
                        <a href="details.aspx?proID=<%#Eval("ProID")%>">
                            <img src="images/products/<%#Eval("ProID")%>/1_thumbs.jpg" title="Continue reading" alt="No Image">
                        </a>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div class="grid_desc">
                            <p class="title"><%#Eval ("ProName") %></p>

                            <div class="price" style="height: 19px;">
                                <span class="reducedfrom">$ <%# Eval("Price", "{0:N0}") %></span>
                                Q:<asp:Label ID="lblQuantity" runat="server" CssClass="actual"><%#Eval("Quantity")%></asp:Label>
                            </div>
                            <div class="clear"></div>
                            <div class="cart-button">
                                <div class="cart">
                                    <a class="button" href="details.aspx?proID=<%#Eval("ProID")%>"><span>Details</span></a>
                                </div>
                                <asp:LinkButton ID="lbtAddCart" runat="server" CssClass="button" CommandName="addToCart" CommandArgument='<%#Eval("ProID")%>'><span>Add Cart</span></asp:LinkButton>
                                <div class="clear"></div>
                            </div>

                        </div>
                    </div>
                    <div class="clear"></div>
                </div>

            </ItemTemplate>
            <EmptyDataTemplate>
                Không tìm thấy sản phẩm
            </EmptyDataTemplate>
        </asp:ListView>
    </div>
    <div class="paging">
        <asp:DataPager ID="DataPagerViewProducts" runat="server" PageSize="6" PagedControlID="lvwProducts">
            <Fields>
                <asp:NextPreviousPagerField ShowFirstPageButton="true" ShowNextPageButton="false" />
                <asp:NumericPagerField ButtonCount="4" />
                <asp:NextPreviousPagerField ShowLastPageButton="true" ShowPreviousPageButton="false" />
            </Fields>
        </asp:DataPager>
    </div>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/template_sale_cars.Master" AutoEventWireup="true" CodeBehind="viewProducts.aspx.cs" Inherits="Sale_Cars.viewProducts" %>

<asp:Content ID="Content3" ContentPlaceHolderID="title" runat="server">
    Danh sách sản phẩm
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right" runat="server">
    <div class="content-top">
        <div class="box_wrapper">
            <h1><asp:Label ID="lblTitle" runat="server" Text=""></asp:Label></h1>
        </div>
        <div class="text">
            <asp:ListView ID="lvwProducts" runat="server" ItemPlaceholderID="itemPlaceholder" OnPagePropertiesChanging="lvwProducts_PagePropertiesChanging" OnItemDataBound="lvwProducts_ItemDataBound" OnItemCommand="lvwProducts_ItemCommand">
                <LayoutTemplate>
                    <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
                </LayoutTemplate>
                <ItemTemplate>

                    <div class="grid_1_of_3 images_1_of_3">
                        <div class="grid_1">
                            <a href="details.aspx?proID=<%#Eval("ProID")%>">
                                <img src="images/products/<%#Eval("ProID")%>/1_thumbs.jpg" title="Continue reading" alt="No Image">
                            </a>
                            &nbsp;<div class="grid_desc">
                                <p class="title"><%#Eval ("ProName") %></p>

                                <div class="price" style="height: 19px;">
                                    <span class="reducedfrom">$ <%# Eval("Price", "{0:N0}") %></span>
                                    Q:<asp:Label ID="lblQuantity" runat="server" CssClass="actual"><%#Eval("Quantity")%></asp:Label>
                                </div>
                                <div class="clear"></div>
                                <div class="cart-button">
                                    <div class="cart">
                                        <a class="button" href="details.aspx?proID=<%#Eval("ProID")%>"><span><i class="fa fa-edit"></i> Details</span></a>
                                    </div>
                                    <%--  <button  class="button"><span>Add Cart</span></button>--%>
                                    <asp:LinkButton ID="lbtAddCart" runat="server" CssClass="button" CommandName="addToCart" CommandArgument='<%#Eval("ProID")%>' ><span><i class='fa fa-cart-plus'></i> Cart</span></asp:LinkButton>
                                    <div class="clear"></div>
                                </div>

                            </div>
                        </div>
                        <div class="clear"></div>
                    </div>

                </ItemTemplate>
                <EmptyDataTemplate>
                    Chưa có sản phẩm
                </EmptyDataTemplate>
            </asp:ListView>
        </div>

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

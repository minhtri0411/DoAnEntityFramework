<%@ Page Title="" Language="C#" MasterPageFile="~/template_sale_cars.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="Sale_Cars._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Trang chủ
</asp:Content>
<asp:Content ID="Content" ContentPlaceHolderID="head" runat="server">
    <!--slider-->
    <script src="js/jquery.min.js"></script>
    <script src="js/script.js" type="text/javascript"></script>
    <script src="js/superfish.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right" runat="server">
    <div id="slideshow">
        <ul class="slides">
            <li><a href="details.html">
                <canvas></canvas>
                <img src="images/banner4.jpg" alt="Marsa Alam underawter close up" /></a></li>
            <li><a href="details.html">
                <canvas></canvas>
                <img src="images/banner2.jpg" alt="Turrimetta Beach - Dawn" /></a></li>
            <li><a href="details.html">
                <canvas></canvas>
                <img src="images/banner3.jpg" alt="Power Station" /></a></li>
            <li><a href="details.html">
                <canvas></canvas>
                <img src="images/banner1.jpg" alt="Colors of Nature" /></a></li>
        </ul>
        <span class="arrow previous"></span>
        <span class="arrow next"></span>
    </div>

    <div style="text-align: center; margin: 10px; padding: 5px;">
        <asp:ImageButton CssClass="button" Style="float: none; margin-right: 5px;" ID="btnViews" runat="server" AlternateText="Top Views" OnClick="btnViews_Click" />
        <asp:ImageButton CssClass="button" Style="float: none; margin-right: 5px;" ID="btnNew" runat="server" AlternateText="Top New" OnClick="btnNew_Click" />
        <asp:ImageButton CssClass="button" Style="float: none; margin-right: 5px;" ID="btnSales" runat="server" AlternateText="Top Sales" OnClick="btnSales_Click" />
        <div class="clear"></div>
    </div>

    <%-- TOP CÁC SẢN PHẨM MỚI --%>
    <asp:Panel ID="pnNew" runat="server" Visible="true">
        <div id="listNew">
            <asp:Label ID="Label1" runat="server" Text="CÁC SẢN PHẨM MỚI" CssClass="title"></asp:Label>
            <div class="clear"></div>
            <asp:ListView ID="lvwDOR" runat="server" OnItemCommand="lvw_ItemCommand" OnItemDataBound="lvw_ItemDataBound">
                <LayoutTemplate>
                    <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
                </LayoutTemplate>
                <ItemTemplate>
                    <div class="grid_1_of_3 images_1_of_3">
                        <div class="grid_1">
                            <a href="details.aspx?proID=<%#Eval("ProID")%>">
                                <img src="images/products/<%#Eval("ProID")%>/1_thumbs.jpg" title="Continue reading" alt="No Image">
                            </a>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div class="grid_desc">
                                <p class="title"><%#Eval ("ProName") %></p>

                                <div class="price" style="height: 19px;">
                                    <span class="reducedfrom">$ <%# Eval("Price", "{0:N0}") %></span>
                                    Q: <%--<span class="actual"><%#Eval("Quantity") %></span>--%>
                                    <asp:Label ID="lblQuantity" runat="server" CssClass="actual"><%#Eval("Quantity") %></asp:Label>
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
                    Chưa có sản phẩm
                </EmptyDataTemplate>
            </asp:ListView>
        </div>
    </asp:Panel>
    <%-- TOP CÁC SẢN PHẨM BÁN CHẠY --%>
    <asp:Panel ID="pnSales" runat="server" Visible="false">
        <div id="listSales">
            <asp:Label ID="Label2" runat="server" Text="CÁC SẢN PHẨM BÁN CHẠY" CssClass="title"></asp:Label>
            <div class="clear"></div>
            <asp:ListView ID="lvwSales" runat="server" OnItemCommand="lvw_ItemCommand" OnItemDataBound="lvw_ItemDataBound">
                <LayoutTemplate>
                    <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
                </LayoutTemplate>
                <ItemTemplate>
                    <div class="grid_1_of_3 images_1_of_3">
                        <div class="grid_1">
                            <a href="details.aspx?proID=<%#Eval("ProID")%>">
                                <img src="images/products/<%#Eval("ProID")%>/1_thumbs.jpg" title="Continue reading" alt="No Image">
                            </a>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div class="grid_desc">
                                <p class="title"><%#Eval ("ProName") %></p>

                                <div class="price" style="height: 19px;">
                                    <span class="reducedfrom">$ <%# Eval("Price", "{0:N0}") %></span>
                                    Q: <%--<span class="actual"><%#Eval("Quantity") %></span>--%>
                                    <asp:Label ID="lblQuantity" runat="server" CssClass="actual"><%#Eval("Quantity") %></asp:Label>
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
                    Chưa có sản phẩm
                </EmptyDataTemplate>
            </asp:ListView>
        </div>
    </asp:Panel>
    <%-- TOP CÁC SẢN PHẨM ĐƯỢC XÊM NHIỀU NHẤT --%>
    <asp:Panel ID="pnViews" runat="server" Visible="false">
        <div class="listViews">
            <asp:Label ID="Label3" runat="server" Text="CÁC SẢN PHẨM ĐƯỢC XEM NHIỀU" CssClass="title"></asp:Label>
            <div class="clear"></div>
            <asp:ListView ID="lvwViews" runat="server" OnItemCommand="lvw_ItemCommand" OnItemDataBound="lvw_ItemDataBound">
                <LayoutTemplate>
                    <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
                </LayoutTemplate>
                <ItemTemplate>
                    <div class="grid_1_of_3 images_1_of_3">
                        <div class="grid_1">
                            <a href="details.aspx?proID=<%#Eval("ProID")%>">
                                <img src="images/products/<%#Eval("ProID")%>/1_thumbs.jpg" title="Continue reading" alt="No Image">
                            </a>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div class="grid_desc">
                                <p class="title"><%#Eval ("ProName") %></p>

                                <div class="price" style="height: 19px;">
                                    <span class="reducedfrom">$ <%# Eval("Price", "{0:N0}") %></span>
                                    Q: <%--<span class="actual"><%#Eval("Quantity") %></span>--%>
                                    <asp:Label ID="lblQuantity" runat="server" CssClass="actual"><%#Eval("Quantity") %></asp:Label>
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
                    Chưa có sản phẩm
                </EmptyDataTemplate>
            </asp:ListView>
        </div>
    </asp:Panel>
</asp:Content>

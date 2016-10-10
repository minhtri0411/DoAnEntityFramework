<%@ Page Title="" Language="C#" MasterPageFile="~/template_sale_cars.Master" AutoEventWireup="true" CodeBehind="details.aspx.cs" Inherits="Sale_Cars.details" %>

<asp:Content ID="Content3" ContentPlaceHolderID="title" runat="server">
    Chi tiết sản phẩm
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- use jssor.slider.min.js instead for release -->
    <!-- jssor.slider.min.js = (jssor.js + jssor.slider.js) -->
    <script src="js/sliderProduct/jssor.slider.js"></script>
    <script src="js/sliderProduct/jssor.js"></script>
    <script src="js/sliderProduct/sliderx.js"></script>

    <script type="text/javascript">        //giới hạn số lượng đặt hàng
        $(function () {
            $("#<%=txtSoLuong.ClientID %>").attr(
                {
                    max: $("#<%=lblQuantity.ClientID %>").html()
                }
                );
        });
    </script>
    <style type="text/css">
        ul > li
        {
            padding-left: 20px;
            direction: initial;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right" runat="server">

    <!-- Jssor Slider Begin -->
    <!-- To move inline styles to css file/block, please specify a class name for each element. -->
    <div id="slider1_container" style="position: relative; top: 0px; left: 0px; width: 800px; height: 700px; background: rgba(255, 255, 255, 0.9) none repeat scroll 0% 0%; overflow: hidden;">

        <!-- Loading Screen -->
        <div u="loading" style="position: absolute; top: 0px; left: 0px;">
            <div style="filter: alpha(opacity=70); opacity: 0.7; position: absolute; display: block; background: rgba(255, 255, 255, 0.9) none repeat scroll 0% 0%; top: 0px; left: 0px; width: 100%; height: 100%;">
            </div>
            <div style="position: absolute; display: block; background: url(../images/slider/loading.gif) no-repeat center center; top: 0px; left: 0px; width: 100%; height: 100%;">
            </div>
        </div>
        <!-- Slides Container -->
        <div u="slides" style="cursor: move; position: absolute; left: 0px; top: 0px; width: 800px; height: 600px; overflow: hidden;">
            <div>
                <asp:Image ID="img1" runat="server" u="image" />
                <asp:Image ID="img1_th" runat="server" u="thumb" />

            </div>
            <div>
                <asp:Image ID="img2" runat="server" u="image" />
                <asp:Image ID="img2_th" runat="server" u="thumb" />
            </div>

        </div>
        <!--#region Arrow Navigator Skin Begin -->
        <link href="css/sliderProduct/ansb.css" rel="stylesheet" />
        <!-- Arrow Left -->
        <span u="arrowleft" class="jssora05l" style="top: 158px; left: 8px;"></span>
        <!-- Arrow Right -->
        <span u="arrowright" class="jssora05r" style="top: 158px; right: 8px"></span>
        <!--#endregion Arrow Navigator Skin End -->
        <!--#region Thumbnail Navigator Skin Begin -->
        <link href="css/sliderProduct/tnsb.css" rel="stylesheet" />
        <!-- thumbnail navigator container -->
        <div u="thumbnavigator" class="jssort01" style="left: 0px; bottom: 0px;">
            <!-- Thumbnail Item Skin Begin -->
            <div u="slides" style="cursor: default;">
                <div u="prototype" class="p">
                    <div class="w">
                        <div u="thumbnailtemplate" class="t"></div>
                    </div>
                    <div class="c"></div>
                </div>
            </div>
            <!-- Thumbnail Item Skin End -->
        </div>
        <!--#endregion Thumbnail Navigator Skin End -->
        <!-- Trigger -->
        <script>
            jssor_slider1_starter('slider1_container');
        </script>
    </div>
    <!-- Jssor Slider End -->

    <div id="content-product">
        <div style="width: 45%; float: left; margin: 10px;" class="TinyDes">
            <asp:Label ID="Label1" runat="server" CssClass="title"> Thông tin ngắn: </asp:Label>
            <asp:Label ID="lblTinyDes" runat="server"></asp:Label><br />
        </div>
        <div style="width: 45%; float: left; margin: 10px;">
            <asp:Label CssClass="title" ID="lblName" runat="server"></asp:Label><br />
            <asp:Label ID="Label3" runat="server" CssClass="caption"> Giá:</asp:Label>
            <asp:Label class="reducedfrom" ID="lblPrice" runat="server"></asp:Label><br />
            <asp:Label ID="Label4" runat="server" CssClass="caption"> Số lượng tồn: </asp:Label>
            <asp:Label class="actual" ID="lblQuantity" runat="server"></asp:Label><br />
            <asp:Label ID="Label5" runat="server" CssClass="caption"> Số lượt xem: </asp:Label>
            <asp:Label class="actual" ID="lblViews" runat="server"></asp:Label><br />
            <asp:Label ID="Label7" runat="server" CssClass="caption"> Đã bán: </asp:Label>
            <asp:Label class="actual" ID="lblSales" runat="server"></asp:Label><br />

            <asp:Panel ID="pnAddCart" runat="server" Visible="false">
                <asp:TextBox ID="txtSoLuong" runat="server" TextMode="Number" min="0">0</asp:TextBox>
                <asp:Button ID="btnDatHang" runat="server" Text="Add Cart" class="gray-button" sytle="float:left;" OnClick="btnDatHang_Click" />
            </asp:Panel>
        </div>
        <div class="clear"></div>
        <div style="width: 100%; float: left; margin: 10px;" class="FullDes">
            <asp:Label ID="Label2" runat="server" CssClass="title"> Thông tin chi tiết: </asp:Label>
            <asp:Label ID="lblFullDes" runat="server"></asp:Label><br />
        </div>
    </div>
    <div id="cungnsx">
        <div class="clear"></div>
        <asp:Label ID="Label6" runat="server" class="title" Text="Cùng nhà sản xuất"></asp:Label>
        <div class="clear"></div>
        <asp:ListView ID="lvwCat" runat="server">
            <LayoutTemplate>
                <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
            </LayoutTemplate>
            <ItemTemplate>
                <div class="grid_1_of_3 images_1_of_3" style="width: 155px;">
                    <div class="grid_1" style="width: 155px;">
                        <a href="details.aspx?proID=<%#Eval("ProID")%>">
                            <img src="images/products/<%#Eval("ProID")%>/1_thumbs.jpg" title="Continue reading" alt="No Image">
                        </a>
                        &nbsp;<div class="grid_desc">
                            <p class="title"><%#Eval ("ProName") %></p>
                            <div class="price" style="height: 19px;">
                                <span class="reducedfrom">$ <%# Eval("Price", "{0:N0}") %></span>
                            </div>
                        </div>
                    </div>
                    <div class="clear"></div>
                </div>
            </ItemTemplate>
            <EmptyDataTemplate>
                Không có sản phẩm.
            </EmptyDataTemplate>
        </asp:ListView>
    </div>
    <div id="cungloai">
        <div class="clear"></div>
        <asp:Label ID="Label8" runat="server" class="title" Text="Cùng loại"></asp:Label>
        <div class="clear"></div>

        <asp:ListView ID="lvwType" runat="server">
                        <LayoutTemplate>
                <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
            </LayoutTemplate>
            <ItemTemplate>
                <div class="grid_1_of_3 images_1_of_3" style="width: 155px;">
                    <div class="grid_1" style="width: 155px;">
                        <a href="details.aspx?proID=<%#Eval("ProID")%>">
                            <img src="images/products/<%#Eval("ProID")%>/1_thumbs.jpg" title="Continue reading" alt="No Image">
                        </a>
                        &nbsp;<div class="grid_desc">
                            <p class="title"><%#Eval ("ProName") %></p>

                            <div class="price" style="height: 19px;">
                                <span class="reducedfrom">$ <%# Eval("Price", "{0:N0}") %></span>
                            </div>
                        </div>
                    </div>
                    <div class="clear"></div>
                </div>
            </ItemTemplate>
            <EmptyDataTemplate>
                Không có sản phẩm.
            </EmptyDataTemplate>

        </asp:ListView>
    </div>



</asp:Content>

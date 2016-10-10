<%@ Page Title="" Language="C#" MasterPageFile="~/template_sale_cars.Master" AutoEventWireup="true" CodeBehind="managecart.aspx.cs" Inherits="Sale_Cars.managecart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        table
        {
            width: 100%;
        }

        th
        {
            background-color: #D54F30;
            color: #fff;
            font-size: 15px;
            font-weight: bold;
            border: medium;
            border: groove 0.5px;
            border-color: gray;
        }

        td
        {
            border: groove 0.5px;
            border-color: gray;
            padding: 5px;
            text-align: center;
            margin: auto;
            vertical-align: auto;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="right" runat="server">
    <div>
        <asp:Label ID="Label1" runat="server" Text="Tổng tiền:" CssClass="title"></asp:Label>
        <asp:Label ID="lblTotal" runat="server" Text="0" CssClass="reducedfrom"></asp:Label>
    </div>
    <div class="clear"></div>
    <div>
        <asp:ListView ID="lvwCart" runat="server" OnItemDataBound="lvwCart_ItemDataBound" OnDataBound="lvwCart_DataBound" OnItemCommand="lvwCart_ItemCommand">
            <LayoutTemplate>
                <table id="cart">
                    <tr>
                        <th>Sản phẩm </th>
                        <th style="width: 200px;">Giá </th>
                        <th style="width: 100px;">Số lượng </th>
                        <th style="width: 200px;">Thành tiền </th>
                        <th style="width: 50px;"></th>
                        <th style="width: 50px;"></th>
                    </tr>
                    <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <asp:Label ID="lblSP" runat="server"><%# Eval("ProID") %></asp:Label></td>
                    <td>
                        <asp:Label ID="lblGia" runat="server"></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtSL" runat="server" Text='<%# Eval("Quantity") %>' Width="70px"></asp:TextBox>
                        <asp:CompareValidator ID="valUpdate" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="txtSL" Type="Integer" ValueToCompare="0" Operator="GreaterThan"></asp:CompareValidator>
                    </td>
                    <td>
                        <asp:Label ID="lblTTien" runat="server"></asp:Label></td>
                    <td>
                        <asp:ImageButton ID="btnDelete" runat="server" CommandName="DeleteItem" CommandArgument='<%#Eval("ProID") %>' ToolTip="Delete" AlternateText="Delete" /></td>
                    <td>
                        <asp:ImageButton ID="btnUpdate" runat="server" CommandName="UpdateItem" CommandArgument='<%#Eval("ProID") %>' ToolTip="Update" AlternateText="Update" /></td>
                </tr>
            </ItemTemplate>
            <EmptyDataTemplate>
                Giỏ hàng rỗng!
            </EmptyDataTemplate>
        </asp:ListView>
    </div>
    <div class="clear"></div>
    <asp:Button ID="btnLapHoaDon" CssClass="gray-button" runat="server" Text="Lập hóa đơn" OnClick="btnLapHoaDon_Click" />
    <asp:Button ID="btnHuy" CssClass="gray-button" runat="server" Text="Hủy giỏ hàng" OnClick="btnHuy_Click" />

</asp:Content>

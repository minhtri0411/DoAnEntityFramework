<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="admOrders.aspx.cs" Inherits="Sale_Cars.admin.admOders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="titlecontent" runat="server">
    <div id="page-heading">
        <h2>List Orders</h2>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentmain" runat="server">
    <div class="clearfix"></div>
    <asp:ListView ID="lvwOrders" runat="server" ItemPlaceholderID="itemPlaceholder" OnPagePropertiesChanging="lvwOrders_PagePropertiesChanging"
        OnItemEditing="lvwOrders_ItemEditing" DataKeyNames="OrderID" OnItemCanceling="lvwOrders_ItemCanceling" OnItemDataBound="lvwOrders_ItemDataBound"
        OnItemDeleting="lvwOrders_ItemDeleting" OnItemUpdating="lvwOrders_ItemUpdating">
        <LayoutTemplate>
            <table border="0" width="100%" cellpadding="0" cellspacing="0" id="product-table">
                <tr>
                    <th class="table-header-repeat line-left"><a href="">ID</a>	</th>
                    <th class="table-header-repeat line-left"><a href="">Date</a></th>
                    <th class="table-header-repeat line-left"><a href="">Customer</a></th>
                    <th class="table-header-repeat line-left"><a href="">Total</a></th>
                    <th class="table-header-repeat line-left"><a href="">Ship</a></th>
                    <th class="table-header-repeat line-left"><a href="">Options</a></th>
                </tr>
                <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
            </table>
        </LayoutTemplate>
        <ItemTemplate>
            <tr>
                <td>
                    <asp:Label ID="lblSP" runat="server"><%# Eval("OrderID") %></asp:Label></td>
                <td>
                    <asp:Label ID="lblDate" runat="server"><%# Eval("OrderDate") %></asp:Label></td>
                <td>
                    <asp:Label ID="lblUser" runat="server"><%# Eval("User.f_Username") %></asp:Label></td>
                <td>
                    <asp:Label ID="lblTotal" runat="server"><%# Eval("Total","{0:N0} $")%> </asp:Label></td>
                <td>
                    <asp:Label ID="lblShip" runat="server"><%# Eval("Shipment") %></asp:Label></td>
            
                <td class="options-width">
                    <asp:LinkButton ID="btnDelete" runat="server" title="Delete" class="icon-2 info-tooltip" CommandName="Delete"></asp:LinkButton>
                    <asp:LinkButton ID="btnEdit" runat="server" title="Edit" class="icon-1 info-tooltip" CommandName="Edit"></asp:LinkButton>
                </td>
            </tr>
        </ItemTemplate>
        <EmptyDataTemplate>
            Nothing!
        </EmptyDataTemplate>
        <EditItemTemplate>
            <tr>
               <td>
                    <asp:Label ID="lblSP" runat="server"><%# Eval("OrderID") %></asp:Label></td>
                <td>
                    <asp:Label ID="lblDate" runat="server"><%# Eval("OrderDate") %></asp:Label></td>
                <td>
                    <asp:Label ID="lblID" runat="server"><%# Eval("UserID") %></asp:Label></td>
                <td>
                    <asp:Label ID="lblTotal" runat="server"><%# Eval("Total","{0:N0} $")%> </asp:Label></td>
                <td>
                    <asp:DropDownList ID="ddlShip" runat="server" DataTextField='<%#Bind("Shipment")%>' ></asp:DropDownList>
                </td>

                <td class="options-width">
                    <asp:LinkButton ID="btnApply" runat="server" title="Apply" class="icon-5 info-tooltip" CommandName="Update"></asp:LinkButton>
                    <asp:LinkButton ID="btnCancel" runat="server" title="Cancel" class="icon-4 info-tooltip" CommandName="Cancel"></asp:LinkButton>
                </td>
            </tr>
        </EditItemTemplate>
    </asp:ListView>

    <div class="clear"></div>

    <div class="paging">
        <asp:DataPager ID="DataPagerView" runat="server" PageSize="10" PagedControlID="lvwOrders">
            <Fields>
                <asp:NextPreviousPagerField ShowFirstPageButton="true" ShowNextPageButton="false" />
                <asp:NumericPagerField ButtonCount="4" />
                <asp:NextPreviousPagerField ShowLastPageButton="true" ShowPreviousPageButton="false" />
            </Fields>
        </asp:DataPager>
    </div>
</asp:Content>

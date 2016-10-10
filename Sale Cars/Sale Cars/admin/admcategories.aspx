<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="admcategories.aspx.cs" Inherits="Sale_Cars.admin.admcategories" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="titlecontent" runat="server">
    <div id="page-heading">
        <h2>List categories</h2>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentmain" runat="server">
    <div class="clearfix"></div>
    <asp:ListView ID="lvwCats" runat="server" ItemPlaceholderID="itemPlaceholder" OnPagePropertiesChanging="lvwCats_PagePropertiesChanging" 
        OnItemEditing="lvwCats_ItemEditing" DataKeyNames="CatID" OnItemCanceling="lvwCats_ItemCanceling"
         OnItemDeleting="lvwCats_ItemDeleting" OnItemUpdating="lvwCats_ItemUpdating">
        <LayoutTemplate>
            <table border="0" width="100%" cellpadding="0" cellspacing="0" id="product-table">
                <tr>
                    <th class="table-header-repeat line-left"><a href="">ID</a>	</th>
                    <th class="table-header-repeat line-left"><a href="">Category Name</a></th>
                    <th class="table-header-repeat line-left"><a href="">Options</a></th>
                </tr>
                <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
            </table>
        </LayoutTemplate>
        <ItemTemplate>
            <tr>
                <td>
                    <asp:Label ID="lblSP" runat="server"><%# Eval("CatID") %></asp:Label></td>
                <td>
                    <asp:Label ID="Label1" runat="server"><%# Eval("CatName") %></asp:Label></td>
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
                    <asp:Label ID="lblSP" runat="server"><%# Eval("CatID") %></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtCatName" runat="server" Text='<%# Bind("CatName") %>' CssClass="inp-form"></asp:TextBox>
                </td>
                <td class="options-width">
                    <asp:LinkButton ID="btnApply" runat="server" title="Apply" class="icon-5 info-tooltip" CommandName="Update"></asp:LinkButton>
                    <asp:LinkButton ID="btnCancel" runat="server" title="Cancel" class="icon-4 info-tooltip" CommandName="Cancel"></asp:LinkButton>
                </td>
            </tr>
        </EditItemTemplate>
    </asp:ListView>
        <div class="clear"></div>

    <div class="row">
        <div class="col-md-12" style="text-align: right;">
             <div class="col-sm-4" style="float:right;">
                    <asp:TextBox ID="txtProName" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
            <asp:LinkButton ID="btnAdd" runat="server" role="button" CssClass="btn btn-default" OnClick="btnAdd_Click"><i class="fa fa-plus"></i>&nbsp;Add Category</asp:LinkButton>   
        </div>
    </div>
    <div class="clear"></div>

    <div class="paging">
        <asp:DataPager ID="DataPagerView" runat="server" PageSize="10" PagedControlID="lvwCats">
            <Fields>
                <asp:NextPreviousPagerField ShowFirstPageButton="true" ShowNextPageButton="false" />
                <asp:NumericPagerField ButtonCount="4" />
                <asp:NextPreviousPagerField ShowLastPageButton="true" ShowPreviousPageButton="false" />
            </Fields>
        </asp:DataPager>
    </div>
</asp:Content>

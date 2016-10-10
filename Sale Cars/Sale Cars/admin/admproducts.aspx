<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="admproducts.aspx.cs" Inherits="Sale_Cars.admin.admproducts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%-- js --%>
    <script src="../scripts/tinymce/tinymce.min.js"></script>
    <script type="text/javascript">
        $('.selectpicker').selectpicker();

        $('dlgAddProduct').on('shown.bs.modal', function (e) {
            $("#<%=txtProName.ClientID%>").focus();
        });
    </script>
    <script type="text/javascript">
        tinymce.init({
            selector: 'textarea',
            menubar: false,
            toolbar1: "styleselect | bold italic | link image | alignleft aligncenter alignright | bullist numlist",
            toolbar2: "fontselect | fontsizeselect | forecolor backcolor",
            plugins: 'link image textcolor',
            encoding: "xml",
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="titlecontent" runat="server">
    <div id="page-heading">
        <h2>List products</h2>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentmain" runat="server">

    <div class="clearfix"></div>
    <asp:ListView ID="lvwProducts" runat="server" ItemPlaceholderID="itemPlaceholder" DataKeyNames="ProID" OnPagePropertiesChanging="lvwProducts_PagePropertiesChanging" OnItemCommand="lvwProducts_ItemCommand" OnItemDeleting="lvwProducts_ItemDeleting">
        <LayoutTemplate>
            <table border="0" width="100%" cellpadding="0" cellspacing="0" id="product-table">
                <tr>
                    <th class="table-header-repeat line-left minwidth-1"><a href="">ID</a>	</th>
                    <th class="table-header-options line-left"><a href="">Product Name</a></th>
                    <th class="table-header-options line-left"><a href="">Price</a></th>
                    <th class="table-header-options line-left"><a href="">Quantity</a></th>
                    <th class="table-header-options line-left"><a href="">Category</a></th>
                    <th class="table-header-repeat line-left"><a href="">Options</a></th>
                </tr>
                <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
            </table>
        </LayoutTemplate>
        <ItemTemplate>
            <tr>
                <td>
                    <asp:Label ID="lblSP" runat="server"><%# Eval("ProID") %></asp:Label></td>
                <td>
                    <asp:Label ID="Label1" runat="server"><%# Eval("ProName") %></asp:Label></td>
                <td>
                    <asp:Label ID="Label2" runat="server"><%# Eval("Price", "{0:N0}") %> $</asp:Label></td>
                <td>
                    <asp:Label ID="Label3" runat="server"><%# Eval("Quantity") %></asp:Label></td>
                <td>
                    <asp:Label ID="Label4" runat="server"><%# Eval("Category.CatName") %></asp:Label></td>

                <td class="options-width">
                    <asp:LinkButton ID="btnDelete" runat="server" title="Delete" class="icon-2 info-tooltip" CommandName="Delete"></asp:LinkButton>
                    <asp:LinkButton ID="btnEdit" runat="server" title="Edit" class="icon-1 info-tooltip"
                        CommandName="EditProduct" CommandArgument='<%# Eval("ProID") %>'></asp:LinkButton>
                </td>
            </tr>
        </ItemTemplate>
        <EmptyDataTemplate>
            Nothing!
        </EmptyDataTemplate>
    </asp:ListView>
    <div class="row">
        <div class="col-md-12" style="text-align: right;">
            <a href="javascript:;" role="button" class="btn btn-default" data-toggle="modal" data-target="#dlgAddProduct">
                <i class="fa fa-plus"></i>&nbsp;Add Product
            </a>
        </div>
    </div>
    <div class="clear"></div>

    <div class="paging">
        <asp:DataPager ID="DataPagerViewProducts" runat="server" PageSize="10" PagedControlID="lvwProducts">
            <Fields>
                <asp:NextPreviousPagerField ShowFirstPageButton="true" ShowNextPageButton="false" />
                <asp:NumericPagerField ButtonCount="4" />
                <asp:NextPreviousPagerField ShowLastPageButton="true" ShowPreviousPageButton="false" />
            </Fields>
        </asp:DataPager>
    </div>

    <%-- modal Add --%>
    <div class="modal fade" id="dlgAddProduct" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Add product</h4>
                </div>
                <div class="modal-body form-horizontal">
                    <div class="form-horizontal" style="width: 90%;">
                        <div class="form-group">
                            <label for="<%=txtProName.ClientID %>" class="col-sm-2 control-label">Sản phẩm</label>
                            <div class="col-sm-4">
                                <asp:TextBox ID="txtProName" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <label for="<%=ddlCategory.ClientID %>" class="col-sm-2 control-label">Nhà sản xuất</label>
                            <div class="col-sm-4">
                                <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control selectpicker"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="<%=txtPrice.ClientID %>" class="col-sm-2 control-label">Giá</label>
                            <div class="col-sm-4">
                                <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" TextMode="Number" min="0"></asp:TextBox>
                            </div>
                            <label for="<%=txtQuantity.ClientID %>" class="col-sm-2 control-label">Số lượng</label>
                            <div class="col-sm-4">
                                <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control" TextMode="Number" min="0"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="<%=fuPhotoL1.ClientID %>" class="col-sm-2 control-label">Hình lớn</label>
                            <div class="col-sm-4">
                                <asp:FileUpload ID="fuPhotoL1" runat="server" />
                                <asp:RegularExpressionValidator ID="revfuPhotoL1" runat="server"
                                    ErrorMessage="Chỉ hổ trợ *.jpg" ForeColor="Red" ControlToValidate="fuPhotoL1"
                                    ValidationExpression=".+\.(jpg|JPG)$">
                                </asp:RegularExpressionValidator>
                            </div>
                            <label for="<%=fuPhotoN1.ClientID %>" class="col-sm-2 control-label">Hình nhỏ</label>
                            <div class="col-sm-4">
                                <asp:FileUpload ID="fuPhotoN1" runat="server" />
                                <asp:RegularExpressionValidator ID="revfuPhotoN1" runat="server"
                                    ErrorMessage="Chỉ hổ trợ *.jpg" ForeColor="Red" ControlToValidate="fuPhotoN1"
                                    ValidationExpression=".+\.(jpg|JPG)$">
                                </asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="<%=fuPhotoL2.ClientID %>" class="col-sm-2 control-label">Hình lớn</label>
                            <div class="col-sm-4">
                                <asp:FileUpload ID="fuPhotoL2" runat="server" />
                                <asp:RegularExpressionValidator ID="revfuPhotoL2" runat="server"
                                    ErrorMessage="Chỉ hổ trợ *.jpg" ForeColor="Red" ControlToValidate="fuPhotoL2"
                                    ValidationExpression=".+\.(jpg|JPG)$">
                                </asp:RegularExpressionValidator>
                            </div>
                            <label for="<%=fuPhotoN2.ClientID %>" class="col-sm-2 control-label">Hình nhỏ</label>
                            <div class="col-sm-4">
                                <asp:FileUpload ID="fuPhotoN2" runat="server" />
                                <asp:RegularExpressionValidator ID="revfuPhotoN2" runat="server"
                                    ErrorMessage="Chỉ hổ trợ *.jpg" ForeColor="Red" ControlToValidate="fuPhotoN2"
                                    ValidationExpression=".+\.(jpg|JPG)$">
                                </asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="<%=txtTinyDes.ClientID %>" class="col-sm-2 control-label">Mô tả</label>
                            <div class="col-sm-10">
                                <asp:TextBox ID="txtTinyDes" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-10 col-sm-offset-2">
                                <asp:TextBox ID="txtFullDes" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnClose" runat="server" class="btn btn-default" data-dismiss="modal" Text="Close" OnClick="btnClose_Click"></asp:Button>
                    <asp:Button ID="btnSavePro" runat="server" class="btn btn-primary" Text="Save" OnClick="btnSavePro_Click"></asp:Button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>

    <%-- modal Edit --%>
    <%--  <div class="modal fade" id="modalEdit" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Edit product</h4>
                </div>
                <div class="modal-body form-horizontal">
                    <div class="form-horizontal" style="width: 90%;">
                        <div class="form-group">
                            <label for="<%=txtDayAdde.ClientID %>" class="col-sm-2 control-label">Ngày thêm</label>
                            <div class="col-sm-4">
                                <asp:TextBox ID="txtDayAdde" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="<%=txtProNamee.ClientID %>" class="col-sm-2 control-label">Sản phẩm</label>
                            <div class="col-sm-4">
                                <asp:TextBox ID="txtProNamee" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <label for="<%=ddlCategorye.ClientID %>" class="col-sm-2 control-label">Nhà sản xuất</label>
                            <div class="col-sm-4">
                                <asp:DropDownList ID="ddlCategorye" runat="server" CssClass="form-control selectpicker"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="<%=txtPricee.ClientID %>" class="col-sm-2 control-label">Giá</label>
                            <div class="col-sm-4">
                                <asp:TextBox ID="txtPricee" runat="server" CssClass="form-control" TextMode="Number" min="0"></asp:TextBox>
                            </div>
                            <label for="<%=txtQuantitye.ClientID %>" class="col-sm-2 control-label">Số lượng</label>
                            <div class="col-sm-4">
                                <asp:TextBox ID="txtQuantitye" runat="server" CssClass="form-control" TextMode="Number" min="0"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="<%=FileUpload1.ClientID %>" class="col-sm-2 control-label">Hình lớn</label>
                            <div class="col-sm-4">
                                <asp:FileUpload ID="FileUpload1" runat="server" />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                    ErrorMessage="Chỉ hổ trợ *.jpg" ForeColor="Red" ControlToValidate="fuPhotoL1"
                                    ValidationExpression=".+\.(jpg|JPG)$">
                                </asp:RegularExpressionValidator>
                            </div>
                            <label for="<%=FileUpload11.ClientID %>" class="col-sm-2 control-label">Hình nhỏ</label>
                            <div class="col-sm-4">
                                <asp:FileUpload ID="FileUpload11" runat="server" />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
                                    ErrorMessage="Chỉ hổ trợ *.jpg" ForeColor="Red" ControlToValidate="fuPhotoN1"
                                    ValidationExpression=".+\.(jpg|JPG)$">
                                </asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="<%=FileUpload2.ClientID %>" class="col-sm-2 control-label">Hình lớn</label>
                            <div class="col-sm-4">
                                <asp:FileUpload ID="FileUpload2" runat="server" />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server"
                                    ErrorMessage="Chỉ hổ trợ *.jpg" ForeColor="Red" ControlToValidate="fuPhotoL2"
                                    ValidationExpression=".+\.(jpg|JPG)$">
                                </asp:RegularExpressionValidator>
                            </div>
                            <label for="<%=FileUpload22.ClientID %>" class="col-sm-2 control-label">Hình nhỏ</label>
                            <div class="col-sm-4">
                                <asp:FileUpload ID="FileUpload22" runat="server" />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server"
                                    ErrorMessage="Chỉ hổ trợ *.jpg" ForeColor="Red" ControlToValidate="fuPhotoN2"
                                    ValidationExpression=".+\.(jpg|JPG)$">
                                </asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="<%=txtTinyDese.ClientID %>" class="col-sm-2 control-label">Mô tả</label>
                            <div class="col-sm-10">
                                <asp:TextBox ID="txtTinyDese" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-10 col-sm-offset-2">
                                <asp:TextBox ID="txtFullDese" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnClosee" runat="server" class="btn btn-default" data-dismiss="modal" Text="Close" OnClick="btnClose_Click"></asp:Button>
                    <asp:Button ID="btnSavee" runat="server" class="btn btn-primary" Text="Save" OnClick="btnSavePro_Click"></asp:Button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>--%>
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Edit product</h4>
    </div>
    <div class="modal-body form-horizontal">
        <div class="form-horizontal" style="width: 90%;">
            <div class="form-group">
                <label for="<%=txtProNamee.ClientID %>" class="col-sm-2 control-label">Sản phẩm</label>
                <div class="col-sm-4">
                    <asp:TextBox ID="txtProNamee" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <label for="<%=ddlCategorye.ClientID %>" class="col-sm-2 control-label">Nhà sản xuất</label>
                <div class="col-sm-4">
                    <asp:DropDownList ID="ddlCategorye" runat="server" CssClass="form-control selectpicker"></asp:DropDownList>
                </div>
            </div>
            <div class="form-group">
                <label for="<%=txtPricee.ClientID %>" class="col-sm-2 control-label">Giá</label>
                <div class="col-sm-4">
                    <asp:TextBox ID="txtPricee" runat="server" CssClass="form-control" TextMode="Number" min="0"></asp:TextBox>
                </div>
                <label for="<%=txtQuantitye.ClientID %>" class="col-sm-2 control-label">Số lượng</label>
                <div class="col-sm-4">
                    <asp:TextBox ID="txtQuantitye" runat="server" CssClass="form-control" TextMode="Number" min="0"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <label for="<%=FileUpload1.ClientID %>" class="col-sm-2 control-label">Hình lớn</label>
                <div class="col-sm-4">
                    <asp:FileUpload ID="FileUpload1" runat="server" />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                        ErrorMessage="Chỉ hổ trợ *.jpg" ForeColor="Red" ControlToValidate="fuPhotoL1"
                        ValidationExpression=".+\.(jpg|JPG)$">
                    </asp:RegularExpressionValidator>
                </div>
                <label for="<%=FileUpload11.ClientID %>" class="col-sm-2 control-label">Hình nhỏ</label>
                <div class="col-sm-4">
                    <asp:FileUpload ID="FileUpload11" runat="server" />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
                        ErrorMessage="Chỉ hổ trợ *.jpg" ForeColor="Red" ControlToValidate="fuPhotoN1"
                        ValidationExpression=".+\.(jpg|JPG)$">
                    </asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="form-group">
                <label for="<%=FileUpload2.ClientID %>" class="col-sm-2 control-label">Hình lớn</label>
                <div class="col-sm-4">
                    <asp:FileUpload ID="FileUpload2" runat="server" />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server"
                        ErrorMessage="Chỉ hổ trợ *.jpg" ForeColor="Red" ControlToValidate="fuPhotoL2"
                        ValidationExpression=".+\.(jpg|JPG)$">
                    </asp:RegularExpressionValidator>
                </div>
                <label for="<%=FileUpload22.ClientID %>" class="col-sm-2 control-label">Hình nhỏ</label>
                <div class="col-sm-4">
                    <asp:FileUpload ID="FileUpload22" runat="server" />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server"
                        ErrorMessage="Chỉ hổ trợ *.jpg" ForeColor="Red" ControlToValidate="fuPhotoN2"
                        ValidationExpression=".+\.(jpg|JPG)$">
                    </asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="form-group">
                <label for="<%=txtTinyDese.ClientID %>" class="col-sm-2 control-label">Mô tả ngắn</label>
                <div class="col-sm-10">
                    <asp:TextBox ID="txtTinyDese" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <label for="<%=txtFullDese.ClientID %>" class="col-sm-2 control-label">Mô tả dài</label>
                <div class="col-sm-10 col-sm-offset-2">
                    <asp:TextBox ID="txtFullDese" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                </div>
            </div>
            <div class="modal-footer">
                <asp:Button ID="btnCancel" runat="server" class="btn btn-default" data-dismiss="modal" Text="Cancel" OnClick="btnCancel_Click"></asp:Button>
                <asp:Button ID="btnUpdate" runat="server" class="btn btn-primary" Text="Update" OnClick="btnUpdate_Click"></asp:Button>
            </div>
        </div>
    </div>



</asp:Content>


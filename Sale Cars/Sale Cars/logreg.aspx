<%@ Page Title="" Language="C#" MasterPageFile="~/template_sale_cars.Master" AutoEventWireup="true" CodeBehind="logreg.aspx.cs" Inherits="Sale_Cars.register1" %>

<%@ Register Assembly="BotDetect"
    Namespace="BotDetect.Web.UI"
    TagPrefix="BotDetect" %>

<asp:Content ID="Content3" ContentPlaceHolderID="title" runat="server">
    Đăng nhập - Đăng ký
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf-8">
    <link href="css/account.css" rel="stylesheet" />
    <!--webfonts-->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800' rel='stylesheet' type='text/css' />
    <!--//webfonts-->
    <style type="text/css">
        .header-para
        {
            display: none;
        }

        .header_bottom_right_images
        {
            width: 100%;
        }
    </style>
    <link href="css/jquery-ui.min.css" rel="stylesheet" />
    <script src="js/jquery-ui.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#<%=txtDate.ClientID %>").datepicker(
               {
                   dateFormat: "d/m/yy"
               }
               );
        });

        function customPass(sender, e) {
            if (e.Value.length >= 6)
                e.IsValid = true;
            else
                e.IsValid = false;
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="right" runat="server">
    <div class="main">
        <div class="header">
            <h1>Login or Create a Free Account!</h1>
        </div>
        <ul class="left-form">
            <h2>New Account:</h2>
            <li>
                <asp:TextBox ID="txtUserName" runat="server" placeholder="Username" ValidationGroup="register"></asp:TextBox>

                <asp:RequiredFieldValidator ID="rfvUserName" runat="server" ControlToValidate="txtUserName" ErrorMessage="Required." ValidationGroup="register">
                    <span class="icon into"></span>
                </asp:RequiredFieldValidator>

                <div class="clear"></div>
            </li>
            <asp:CustomValidator ID="cvUsername" runat="server" ErrorMessage="Tên đăng nhập đã tồn tại" ControlToValidate="txtUserName" Text="Tên đăng nhập đã tồn tại"
                ForeColor="Red" OnServerValidate="cvUsername_ServerValidate" ValidationGroup="register" Font-Size="Small" Display="Static"></asp:CustomValidator>

            <li>
                <asp:TextBox ID="txtEmail" runat="server" placeholder="Email" TextMode="Email" ControlToValidate="txtEmail"></asp:TextBox>

                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmail" ErrorMessage="Required." 
                    Display="Static" ValidationGroup="register"><span class="icon into"></span>
                </asp:RequiredFieldValidator>
                <div class="clear"></div>

            </li>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                ErrorMessage="Email không hợp lệ" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                ControlToValidate="txtEmail" Display="Dynamic" Text="Email không hợp lệ" Style="color: red;" ValidationGroup="register" Font-Size="Small"></asp:RegularExpressionValidator>
            <li>
                <asp:TextBox ID="txtRegPass" runat="server" placeholder="Password" TextMode="Password"></asp:TextBox>

                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtRegPass" ErrorMessage="Required." Display="Static" ValidationGroup="register">
                    <span class="icon into"></span>
                </asp:RequiredFieldValidator>

                <div class="clear"></div>
            </li>
            <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Mật khẩu phải có ít nhất 6 ký tự" Text="Mật khẩu phải có ít nhất 6 ký tự"
                ControlToValidate="txtRegPass" ClientValidationFunction="customPass" Display="Dynamic" Style="color: red;" Font-Size="Small"></asp:CustomValidator>
            <li>
                <asp:TextBox ID="txtRegPass2" runat="server" placeholder="Password" TextMode="Password"></asp:TextBox>

                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtRegPass2" ErrorMessage="Mật khẩu không hợp lệ."
                    Display="Dynamic" ValidationGroup="register">
                    <span class="icon into"></span>
                </asp:RequiredFieldValidator>
                <div class="clear"></div>

            </li>
            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtRegPass" ControlToValidate="txtRegPass2"
                ErrorMessage="Mật khẩu không khớp" Display="Dynamic" Text="Mật khẩu không khớp" Style="color: red;" Font-Size="Small"></asp:CompareValidator>
            <li>
                <asp:TextBox ID="txtName" runat="server" placeholder="Name"></asp:TextBox>

                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtName" ErrorMessage="Required." Display="Static" ValidationGroup="register">
                    <span class="icon into"></span>
                </asp:RequiredFieldValidator>
                <div class="clear"></div>
            </li>
            <li>
                <asp:TextBox ID="txtDate" runat="server" placeholder="BrithDay"></asp:TextBox>

                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtDate" ErrorMessage="Required." Display="Static" ValidationGroup="register">
                    <span class="icon into"></span>
                </asp:RequiredFieldValidator>
                <div class="clear"></div>
            </li>

            <BotDetect:Captcha ID="SampleCaptcha" runat="server" CssClass="main" />
            <div class="clear"></div>

            <li>
                <asp:TextBox ID="txtCapcha" runat="server" placeholder="Capcha"></asp:TextBox>
                <div class="clear"></div>
            </li>
            <BotDetect:CaptchaValidator ID="SampleCaptchaValidatror" runat="server"
                ControlToValidate="txtCapcha" CaptchaControl="SampleCaptcha"
                EnableClientScript="True" SetFocusOnError="True"
                ErrorMessage="Mã xác nhận không đúng" Text="Mã xác nhận không đúng"
                Style="color: red;" ValidationGroup="register" Font-Size="Small"></BotDetect:CaptchaValidator>
            <div class="clear"></div>
            <asp:Button ID="btnRegister" runat="server" Text="Create Account" OnClick="btnRegister_Click" ValidationGroup="register" />
        </ul>
        <ul class="right-form">
            <h3>Log in:</h3>
            <div>
                <asp:Label ID="lbThongBao" runat="server" ForeColor="Red" Font-Size="Small"></asp:Label>
                <li>
                    <asp:TextBox ID="txtUsernameLogin" runat="server" placeholder="Username"></asp:TextBox></li>
                <li>
                    <asp:TextBox ID="txtPassLogin" runat="server" placeholder="Password" TextMode="Password"></asp:TextBox>
                </li>
                <div class="clear"></div>
                <asp:CheckBox ID="chkRemember" runat="server" Text="Keep me logged in" Font-Size="Small" />
                <div class="clear"></div>
                <asp:Button ID="btnLogin" runat="server" Text="Login" ValidationGroup="login" OnClick="btnLogin_Click" />
            </div>
            <div class="clear"></div>
        </ul>

    </div>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/template_sale_cars.Master" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="Sale_Cars.profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Thông tin cá nhân
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .header-para
        {
            display: none;
        }

        .header_bottom_right_images
        {
            width: 100%;
        }

        .left, .right
        {
            float: left;
            width: 40%;
            margin: 2%;
        }

            .left span, .right span
            {
                font-size: small;
            }
    </style>
    <style type="text/css">
        .login-form input[type=text], input[type=password], input[type=email], input[type=text]
        {
            font-family: 'Open Sans', sans-serif;
            width: 90%;
            padding: 0.7em 1em 0.7em 1em;
            color: #000;
            font-size: 15px;
            border: none;
            outline: none;
        }

        .login-form input[type=submit]
        {
            padding: 8px 19px;
            border-radius: 0.3em;
            border: none;
            outline: none;
            -webkit-border-radius: 0.3em;
            -moz-border-radius: 0.3em;
            -o-border-radius: 0.3em;
            font-weight: bold;
            font-size: 15px;
            transition: all 0.5s ease-out;
            -webkit-transition: all 0.5s ease-out;
            -moz-transition: all 0.5s ease-out;
            -ms-transition: all 0.5s ease-out;
            -o-transition: all 0.5s ease-out;
            margin-top: 10px;
            cursor: pointer;
        }

        input[type=submit]:hover
        {
            background: #2E2D2D;
            color: #fff;
        }

        .profile-form li
        {
            display: block;
            color: #4D4949;
            border: 1px solid #EBEBEB;
            border-radius: 0.3em;
            -webkit-border-radius: 0.3em;
            -moz-border-radius: 0.3em;
            -o-border-radius: 0.3em;
            margin-bottom: 10px;
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
<asp:Content ID="Content3" ContentPlaceHolderID="right" runat="server">
    <div class="header">
        <h1 class="title">Profile!</h1>
    </div>
    <ul class="profile-form">

        <div class="left">
            <h2>Change password</h2>
            <hr />
            <div class="clear"></div>

            <asp:Label ID="Label2" runat="server" Text="Old Password:"></asp:Label>
            <li>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtOldPass" ErrorMessage="Chưa nhập mật khẩu"
                    Text="*" Display="Static" ValidationGroup="chpass" Style="color: red;">
                </asp:RequiredFieldValidator>
                <asp:TextBox ID="txtOldPass" runat="server" placeholder="Old password" TextMode="Password" Font-Size="Small" ValidationGroup="chpass"></asp:TextBox>
                <div class="clear"></div>
            </li>


            <asp:Label ID="Label1" runat="server" Text="New password:"></asp:Label>
            <div class="clear"></div>
            <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Mật khẩu phải có ít nhất 6 ký tự" Text="Mật khẩu phải có ít nhất 6 ký tự"
                ControlToValidate="txtNewPass" ClientValidationFunction="customPass" Display="Dynamic" Style="color: red;" Font-Size="Small" ValidationGroup="chpass"></asp:CustomValidator>
            <div class="clear"></div>
            <li>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtNewPass" ErrorMessage="Chưa nhập mật khẩu" Text="*"
                    Display="Static" ValidationGroup="chpass" Style="color: red;">
                </asp:RequiredFieldValidator>
                <asp:TextBox ID="txtNewPass" runat="server" placeholder="New password" TextMode="Password" Font-Size="Small"></asp:TextBox>
                <div class="clear"></div>
            </li>

            <asp:Label ID="Label3" runat="server" Text="Re-enter new password:"></asp:Label>
            <div class="clear"></div>
            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtNewPass" ControlToValidate="txtNewPass2"
                ErrorMessage="Mật khẩu không khớp" Display="Dynamic" Text="Mật khẩu không khớp" Style="color: red;" Font-Size="Small" ValidationGroup="chpass"></asp:CompareValidator>
            <li>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtNewPass2" ErrorMessage="Mật khẩu không hợp lệ."
                    Text="*" Display="Static" ValidationGroup="chpass" Style="color: red;">                    
                </asp:RequiredFieldValidator>
                <asp:TextBox ID="txtNewPass2" runat="server" placeholder="Re-enter new password" TextMode="Password" Font-Size="Small"></asp:TextBox>
                <div class="clear"></div>
            </li>
            <asp:Button ID="btnChangePass" runat="server" Text="Change password" class="gray-button" ValidationGroup="chpass" OnClick="btnChangePass_Click" />
        </div>
        <%-- ///////////////////////////////////// --%>
        <div class="right">
            <h2>Update Info</h2>
            <hr />
            <asp:Label ID="Label4" runat="server" Text="Username:"></asp:Label>
            <li>
                <asp:TextBox ID="txtUsername" runat="server" placeholder="Username" TextMode="SingleLine" Font-Size="Small" ReadOnly="True" Font-Bold="True" BackColor="#CCCCCC" Width="94%"></asp:TextBox>
                <div class="clear"></div>
            </li>

            <asp:Label ID="Label5" runat="server" Text="Email:"></asp:Label>
            <div class="clear"></div>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                ErrorMessage="Email không hợp lệ" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                ControlToValidate="txtEmail" Display="Dynamic" Text="Email không hợp lệ" Style="color: red;" ValidationGroup="info" Font-Size="Small"></asp:RegularExpressionValidator>
            <li>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmail" ErrorMessage="Required."
                    Display="Dynamic" ValidationGroup="info" Text="*" Style="color: red;">
                </asp:RequiredFieldValidator>
                <asp:TextBox ID="txtEmail" runat="server" placeholder="Email" TextMode="Email"  Font-Size="Small"></asp:TextBox>
                <div class="clear"></div>
            </li>

            <asp:Label ID="Label6" runat="server" Text="Name:"></asp:Label>
            <li>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtName" ErrorMessage="Required." Display="Static" ValidationGroup="info" Text="*" Style="color: red;">
                </asp:RequiredFieldValidator>
                <asp:TextBox ID="txtName" runat="server" placeholder="Name" Font-Size="Small"></asp:TextBox>

                <div class="clear"></div>
            </li>

            <asp:Label ID="Label7" runat="server" Text="Birthday:"></asp:Label>
            <li>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtDate" ErrorMessage="Required." Display="Static" ValidationGroup="info" Text="*" Style="color: red;">
                </asp:RequiredFieldValidator>
                <asp:TextBox ID="txtDate" runat="server" placeholder="BrithDay" Font-Size="Small"></asp:TextBox>

                <div class="clear"></div>
            </li>
            <asp:Button ID="btnUpDate" runat="server" Text="Update" class="gray-button" ValidationGroup="info" OnClick="btnUpDate_Click" />

        </div>

    </ul>
</asp:Content>

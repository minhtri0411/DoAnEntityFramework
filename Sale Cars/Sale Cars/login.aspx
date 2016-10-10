<%@ Page Title="" Language="C#" MasterPageFile="~/template_sale_cars.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Sale_Cars.login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Login
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">

    <style type="text/css">
        .login-form input[type=text], input[type=password]
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

        .login-form li
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
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="right" runat="server">
    <div style="margin: auto; text-align: center; width: 60%;">
        <ul class="login-form">
            <asp:Label ID="lbMsg" runat="server" Font-Size="Medium" ForeColor="Blue"></asp:Label>
            <div class="clear"></div>
            <asp:Label ID="Label1" runat="server" Text="Log in" Font-Size="XX-Large"></asp:Label>
            <div class="clear"></div>
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
            <div class="clear"></div>
        </ul>
    </div>

</asp:Content>

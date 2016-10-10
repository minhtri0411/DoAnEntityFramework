<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Sale_Cars.admin.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Internet Dreams</title>
    <link rel="stylesheet" href="css/screen.css" type="text/css" media="screen" title="default" />
    <!--  jquery core -->
    <script src="js/jquery/jquery-1.4.1.min.js" type="text/javascript"></script>

    <!-- Custom jquery scripts -->
    <script src="js/jquery/custom_jquery.js" type="text/javascript"></script>

    <!-- MUST BE THE LAST SCRIPT IN <HEAD></HEAD></HEAD> png fix -->
    <script src="js/jquery/jquery.pngFix.pack.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(document).pngFix();
        });
    </script>

</head>
<body id="login-bg">
    <form id="form1" runat="server">
        <div id="login-holder">

            <!-- start logo -->
            <div id="logo-login">
                <a href="index.html">
                    <img src="images/shared/logo.png" width="156" height="40" alt="" /></a>
            </div>
            <!-- end logo -->

            <div class="clear"></div>

            <!--  start loginbox ................................................................................. -->
            <div id="loginbox">

                <!--  start login-inner -->
                <div style="padding: 5px; text-align: center;">
                    <asp:Label ID="lbThongBao" runat="server" Font-Size="Medium" ForeColor="Red"></asp:Label>
                    <br />
                </div>
                <div id="login-inner">
                    <table border="0" cellpadding="0" cellspacing="0">


                        <tr>
                            <th>Username</th>
                            <td>
                                <asp:TextBox ID="txtUsernameLogin" runat="server" CssClass="login-inp"></asp:TextBox></li>

                            </td>
                        </tr>
                        <tr>
                            <th>Password</th>
                            <td>
                                <asp:TextBox ID="txtPassLogin" runat="server" TextMode="Password" onfocus="this.value=''" CssClass="login-inp"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <th></th>
                            <td valign="top">
                                <asp:CheckBox ID="chkRemember" runat="server" Text="Remember me" CssClass="checkbox-size" />
                                <%--<input type="checkbox" class="checkbox-size" id="login-check" /><label for="login-check">Remember me</label></td>--%>
                        </tr>
                        <tr>
                            <th></th>
                            <td>
                                <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" CssClass="submit-login" /></td>
                        </tr>
                    </table>
                </div>
                <!--  end login-inner -->
                <div class="clear"></div>

            </div>
            <!--  end loginbox -->

            <!--  start forgotbox ................................................................................... -->
            <div id="forgotbox">
                <div id="forgotbox-text">Please send us your email and we'll reset your password.</div>
                <!--  start forgot-inner -->
                <div id="forgot-inner">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <th>Email address:</th>
                            <td>
                                <input type="text" value="" class="login-inp" /></td>
                        </tr>
                        <tr>
                            <th></th>
                            <td>
                                <input type="button" class="submit-login" /></td>
                        </tr>
                    </table>
                </div>
                <!--  end forgot-inner -->
                <div class="clear"></div>
                <a href="" class="back-login">Back to login</a>
            </div>
            <!--  end forgotbox -->

        </div>
        <!-- End: login-holder -->
    </form>
</body>
</html>

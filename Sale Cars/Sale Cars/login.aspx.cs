using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Sale_Cars.Helpers;

namespace Sale_Cars
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (CurrentContext.IsLogged() == true)
            {
                Response.Redirect("~/index.aspx");
            }

            if (IsPostBack == false)
            {
                string msg = Request.QueryString["msg"];
                switch (msg)
                {
                    case "1":
                        lbMsg.Text = "Đăng ký thành công. Bạn có thể đăng nhập.";
                        break;
                    default: break;
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsernameLogin.Text;
            string enc_pwd = StringUtils.MD5(txtPassLogin.Text);

            using (SaleCarsEntities ctx = new SaleCarsEntities())
            {
                User us = ctx.Users
                    .Where(u => u.f_Username == username && u.f_Password == enc_pwd)
                    .FirstOrDefault();

                if (us != null)
                {
                    Session["IsLogin"] = 1;
                    Session["CurUser"] = us;

                    if (chkRemember.Checked)
                    {
                        Response.Cookies["Username"].Value = username;
                        Response.Cookies["Username"].Expires = DateTime.Now.AddDays(7);
                    }

                    string retUrl = Request.QueryString["retUrl"];
                    if (string.IsNullOrEmpty(retUrl))
                        retUrl = "~/index.aspx";
                    Response.Redirect(retUrl);
                }
                else
                {
                    lbThongBao.Text = "Username hoac mat khau khong dung!";
                }

            }
        }
    }
}


using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Sale_Cars.Helpers;

namespace Sale_Cars.admin
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (CurrentContext.IsLogged() == true)
                {
                    Response.Redirect("~/admin/admproducts.aspx");
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
                        retUrl = "~/admin/admproducts.aspx";
                    Response.Redirect(retUrl);
                }
                else
                {
                    lbThongBao.Text = "Username hoặc mật khẩu không đúng!";
                }

            }
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Sale_Cars.Helpers;

namespace Sale_Cars
{
    public partial class register1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string retUrl = "~/index.aspx"; 
            if (!string.IsNullOrEmpty(retUrl))
            {
                retUrl = Request.QueryString["retUrl"];
            }

            if (CurrentContext.IsLogged() == true)
            {
                Response.Redirect(retUrl);
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            User u = new User
            {
                f_Username = txtUserName.Text,
                f_Password = StringUtils.MD5(txtRegPass.Text),
                f_Email = txtEmail.Text,
                f_Name = txtName.Text,
                f_DOB = (DateTime.ParseExact(txtDate.Text, "dd/M/yyyy", null)),
                f_Permission = 0

            };
            using (SaleCarsEntities ctx = new SaleCarsEntities())
            {
                ctx.Users.Add(u);
                ctx.SaveChanges();
            }

            Response.Redirect("~/login.aspx?msg=1");
        }

        protected void cvUsername_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string username = args.Value;

            using (SaleCarsEntities ctx = new SaleCarsEntities())
            {
                int n = ctx.Users.Where(u => u.f_Username == username).Count();

                if (n > 0)
                    args.IsValid = false;
                else
                    args.IsValid = true;
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
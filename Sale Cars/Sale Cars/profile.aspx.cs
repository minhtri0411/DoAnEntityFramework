using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Sale_Cars.Helpers;

namespace Sale_Cars
{
    public partial class profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (CurrentContext.IsLogged() == false)
            {
                Response.Redirect("~/logreg.aspx?retUrl=profile.aspx");
            }

            if (IsPostBack == false)
            {
                User cUser = CurrentContext.GetCurUser();
                txtUsername.Text = cUser.f_Username;

                txtEmail.Text = cUser.f_Email;
                txtName.Text = cUser.f_Name;
                txtDate.Text = cUser.f_DOB.ToShortDateString().ToString();
            }        
        }

        protected void btnChangePass_Click(object sender, EventArgs e)
        {
            string oldPass = StringUtils.MD5(txtOldPass.Text);

            using (SaleCarsEntities ctx = new SaleCarsEntities())
            {
                int count = ctx.Users.Where(u => u.f_Username == txtUsername.Text && u.f_Password == oldPass).Count();

                if (count == 0)
                {
                    if (ClientScript.IsStartupScriptRegistered("swal") == false)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(),
                            "swal",
                            "alert('Mật khẩu không đúng!');",
                            true
                        );
                    }
                }
                else
                {
                    User cUs = CurrentContext.GetCurUser();
                    cUs.f_Password = StringUtils.MD5(txtNewPass.Text);

                    ctx.Entry(cUs).State = System.Data.Entity.EntityState.Modified;
                    ctx.SaveChanges();

                    if (ClientScript.IsStartupScriptRegistered("updatepass") == false)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(),
                            "updatepass",
                            "alert('Đổi mật khẩu thành công!');",
                            true
                        );
                    }
                }
            }
        }

        protected void btnUpDate_Click(object sender, EventArgs e)
        {
            using (SaleCarsEntities ctx = new SaleCarsEntities())
            {
                int count = ctx.Users.Where(u => u.f_Username == txtUsername.Text).Count();

                if (count == 0)
                {
                }
                else 
                {
                    User cUs = CurrentContext.GetCurUser();
                    cUs.f_Name = txtName.Text;
                    cUs.f_Email = txtEmail.Text;
                    cUs.f_DOB = (DateTime.ParseExact(txtDate.Text, "dd/M/yyyy", null));

                    ctx.Entry(cUs).State = System.Data.Entity.EntityState.Modified;
                    ctx.SaveChanges();

                    if (ClientScript.IsStartupScriptRegistered("updateinfo") == false)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(),
                            "updateinfo",
                            "alert('Cập nhật thành công!');",
                            true
                        );
                    }
                }
          
            }
        }
    }
}
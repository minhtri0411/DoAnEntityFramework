using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Sale_Cars.Helpers;

namespace Sale_Cars.admin
{
    public partial class admBrands : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (CurrentContext.IsLogged() == false)
            {
                // Response.Redirect("~/login.aspx?reUrl=/admin/admBrands.aspx");
            }

            if (IsPostBack == false)
            {
                LoadBrands();
            }
        }

        private void LoadBrands()
        {
            using (SaleCarsEntities ctx = new SaleCarsEntities())
            {
                List<Type> list = ctx.Types.ToList();
                lvwBrands.DataSource = list;
                lvwBrands.DataBind();
            }
        }

        protected void lvwBrands_ItemEditing(object sender, ListViewEditEventArgs e)
        {
            lvwBrands.EditIndex = e.NewEditIndex;
            LoadBrands();
        }

        protected void lvwBrands_ItemCanceling(object sender, ListViewCancelEventArgs e)
        {
            lvwBrands.EditIndex = -1;
            LoadBrands();
        }

        protected void lvwBrands_ItemUpdating(object sender, ListViewUpdateEventArgs e)
        {
            var typeID = Convert.ToInt32(e.Keys["TypeID"]);
            string typeName = e.NewValues["TypeName"].ToString();

            using (SaleCarsEntities ctx = new SaleCarsEntities())
            {
                Type type = ctx.Types.Where(c => c.TypeID == typeID).FirstOrDefault();
                if (type != null)
                {
                    type.TypeName = typeName;
                    ctx.SaveChanges();
                }
            }
            lvwBrands.EditIndex = -1;
            LoadBrands();
        }

        protected void lvwBrands_ItemDeleting(object sender, ListViewDeleteEventArgs e)
        {
            var typeID = Convert.ToInt32(e.Keys["TypeID"]);
            using (SaleCarsEntities ctx = new SaleCarsEntities())
            {
                Type type = ctx.Types.Where(c => c.TypeID == typeID).FirstOrDefault();
                if (type != null)
                {
                    ctx.Types.Remove(type);
                    ctx.SaveChanges();

                    LoadBrands();
                }
            }
        }

        //phan trang
        protected void lvwBrands_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            DataPagerView.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

            using (SaleCarsEntities ctx = new SaleCarsEntities())
            {
                List<Category> list = ctx.Categories.ToList();
                lvwBrands.DataSource = list;
                lvwBrands.DataBind();
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            using (SaleCarsEntities ctx = new SaleCarsEntities())
            {
                Type cat = new Type
                {
                    TypeName = txtNameBrands.Text
                };

                txtNameBrands.Text = string.Empty;
                ctx.Types.Add(cat);
                ctx.SaveChanges();

                ClientScript.RegisterStartupScript(this.GetType(),
                    "swal",
                    "alert('Đã thêm');",
                    true
                );

                LoadBrands();
            }
        }
    }
}
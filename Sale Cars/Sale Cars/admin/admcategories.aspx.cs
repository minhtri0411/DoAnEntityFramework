using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Sale_Cars.Helpers;

namespace Sale_Cars.admin
{
    public partial class admcategories : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (CurrentContext.IsLogged() == false)
            {
                 Response.Redirect("~/admin/login.aspx?reUrl=/admin/admcategories.aspx");
            }

            if (IsPostBack == false)
            {
                LoadCats();
            }
        }

        private void LoadCats()
        {
            using (SaleCarsEntities ctx = new SaleCarsEntities())
            {
                List<Category> list = ctx.Categories.ToList();
                lvwCats.DataSource = list;
                lvwCats.DataBind();
            }
        }

        protected void lvwCats_ItemEditing(object sender, ListViewEditEventArgs e)
        {
            lvwCats.EditIndex = e.NewEditIndex;
            LoadCats();
        }

        protected void lvwCats_ItemCanceling(object sender, ListViewCancelEventArgs e)
        {
            lvwCats.EditIndex = -1;
            LoadCats();
        }

        protected void lvwCats_ItemUpdating(object sender, ListViewUpdateEventArgs e)
        {
            var catID = Convert.ToInt32(e.Keys["CatID"]);
            string catName = e.NewValues["CatName"].ToString();

            using (SaleCarsEntities ctx = new SaleCarsEntities())
            {
                Category cat = ctx.Categories.Where(c => c.CatID == catID).FirstOrDefault();
                if (cat != null)
                {
                    cat.CatName = catName;
                    //ctx.Entry(cat).State = System.Data.Entity.EntityState.Modified;
                    ctx.SaveChanges();
                }
            }
            lvwCats.EditIndex = -1;
            LoadCats();
        }

        protected void lvwCats_ItemDeleting(object sender, ListViewDeleteEventArgs e)
        {
            var catID = Convert.ToInt32(e.Keys["CatID"]);
            using (SaleCarsEntities ctx = new SaleCarsEntities())
            {
                Category cat = ctx.Categories.Where(c => c.CatID == catID).FirstOrDefault();
                if (cat != null)
                {
                    ctx.Categories.Remove(cat);
                    ctx.SaveChanges();

                    LoadCats();
                }
            }
        }

        //phan trang
        protected void lvwCats_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            DataPagerView.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

            using (SaleCarsEntities ctx = new SaleCarsEntities())
            {
                List<Category> list = ctx.Categories.ToList();
                lvwCats.DataSource = list;
                lvwCats.DataBind();
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            using (SaleCarsEntities ctx = new SaleCarsEntities())
            {
                Category cat = new Category
                {
                    CatName = txtProName.Text
                };

                txtProName.Text = string.Empty;
                ctx.Categories.Add(cat);
                ctx.SaveChanges();
                ClientScript.RegisterStartupScript(this.GetType(),
                   "swal",
                   "alert('Đã thêm');",
                   true
               );
                LoadCats();
            }
        }
    }
}
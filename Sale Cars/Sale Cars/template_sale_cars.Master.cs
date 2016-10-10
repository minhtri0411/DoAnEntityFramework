using System;
using System.Collections.Generic;
using System.Linq;
using Sale_Cars.Helpers;

namespace Sale_Cars
{
    public partial class template_sale_cars : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (CurrentContext.IsLogged())
            {
                pnCart.Visible = true;
                pnLogged.Visible = true;

                pnNotLogged.Visible = false;

                lnkUsername.Text = string.Format("<b>{0}</b>",
                    CurrentContext.GetCurUser().f_Name);

                UpdateCartLink();
            }
            else
            {
                pnCart.Visible = false;
                pnLogged.Visible = false;

                pnNotLogged.Visible = true;
            }

            if(IsPostBack == false)
            {
                using (SaleCarsEntities ctx = new SaleCarsEntities())
                {
                    List<Type> listType = ctx.Types.ToList();
                    lvwTypes.DataSource = listType;
                    lvwTypes.DataBind();

                    List<Category> listCategories = ctx.Categories.ToList();
                    lvwCategories.DataSource = listCategories;
                    lvwCategories.DataBind();
                }        
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        { 
            CurrentContext.Destroy();
            Response.Redirect(Request.Url.AbsoluteUri);
            
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string url = "search.aspx?keySearch=" + txtSearch.Text;
            Response.Redirect(url);
        }

        public void UpdateCartLink()
        {
            lnkCart.Text = string.Format
                    ("Now in your cart <span style='font-size:15pt; font-weight:bold;'> {0} </span> items <i class='fa fa-shopping-cart fa-2x'></i>",
                    CurrentContext.GetCart().GetNumberOfItems());
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using Sale_Cars.Helpers;

namespace Sale_Cars
{
    public partial class viewProducts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {                
                LoadData();               
            }
        }

        private void LoadData()
        {
            string typeID = Request.QueryString["typeID"];
            string catID = Request.QueryString["catID"];
            

            if (string.IsNullOrEmpty(typeID) && string.IsNullOrEmpty(catID))
            {
                using (SaleCarsEntities ctx = new SaleCarsEntities())
                {
                    List<Product> list =
                       ctx.Products.ToList();
                    lvwProducts.DataSource = list;
                    lvwProducts.DataBind();
                    lblTitle.Text = "All products";
                }
                return;
            }

            // Types
            if (string.IsNullOrEmpty(typeID) == false)
            {
                int i_typeId = Convert.ToInt32(typeID);

                using (SaleCarsEntities ctx = new SaleCarsEntities())
                {
                    List<Product> list =
                       ctx.Products.Where(p => p.TypeID == i_typeId).ToList();
                    lvwProducts.DataSource = list;
                    lvwProducts.DataBind();
                }
            }
            else
            {
                //Categories
                if (string.IsNullOrEmpty(catID) == false)
                {
                    int i_catId = Convert.ToInt32(catID);

                    using (SaleCarsEntities ctx = new SaleCarsEntities())
                    {
                        List<Product> list =
                           ctx.Products.Where(p => p.CatID == i_catId).ToList();
                        lvwProducts.DataSource = list;
                        lvwProducts.DataBind();
                    }
                }
            }
        }

        protected void lvwProducts_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {         
            DataPagerViewProducts.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            this.LoadData();
        }

        protected void lvwProducts_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {                
                LinkButton lbtn = (LinkButton)e.Item.FindControl("lbtAddCart");

                if (CurrentContext.IsLogged())
                {
                    lbtn.Visible = true;
                }
                else
                {
                    lbtn.Visible = false;
                }
            }        
        }

        protected void lvwProducts_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "addToCart")
            {
                CartItems item = new CartItems
                {
                    ProID = Convert.ToInt32(e.CommandArgument),
                    Quantity = 1
                };

                bool flag = CurrentContext.GetCart().Add(item);

                if (flag == false) // kiểm tra việc đặt hàng vượt quá số lượng
                {
                    if (ClientScript.IsStartupScriptRegistered("errorQ2") == false)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(),
                            "errorQ2",
                            "alert('Hết hàng!');",
                            true
                        );
                    }
                }
                else
                    ((template_sale_cars)this.Master).UpdateCartLink();
            }
        }

    }
}
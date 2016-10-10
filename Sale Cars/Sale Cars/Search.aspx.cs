using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;
using Sale_Cars.Helpers;

namespace Sale_Cars
{
    public partial class Search : System.Web.UI.Page
    {
        static List<Product> list = null;
        static int selectedIndexCat = 0;
        static int selectedIndexType = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                using (SaleCarsEntities ctx = new SaleCarsEntities())
                {
                    DDlType.DataSource = ctx.Types.ToList();
                    DDlType.DataValueField = "TypeID";
                    DDlType.DataTextField = "TypeName";
                    DDlType.DataBind();


                    DDLCategory.DataSource = ctx.Categories.ToList();
                    DDLCategory.DataValueField = "CatID";
                    DDLCategory.DataTextField = "CatName";
                    DDLCategory.DataBind();
                }

                string keySearch = Request.QueryString["keySearch"];
                keySearch = Server.UrlDecode(keySearch);
                
                if (!string.IsNullOrEmpty(keySearch))
                {
                    SearchSimple(keySearch);
                }
            }

        }
        //search
        private void SearchSimple(string keySearch)
        {
            if (!string.IsNullOrEmpty(keySearch))
            {
                using (SaleCarsEntities ctx = new SaleCarsEntities())
                {
                    if (chkAll.Checked)
                    {
                        list =
                            ctx.Products.Where(p => p.ProName.Contains(keySearch)).ToList();
                    }
                }

                LoadData();
            }
        }

        protected void btnMainSearch_Click(object sender, EventArgs e)
        {
            //Response.Redirect("~/Search.aspx?keySearch=" + txtKeyWords.Text);
            //string keySearch = Request.QueryString["keySearch"];

            lvwProducts.DataSource = null;
            lvwProducts.DataBind();

            string keySearch = Server.UrlDecode(txtKeyWords.Text);

            if (rbtName.Checked)
            {
                SearchName(keySearch);
                return;
            }

            if (rbtPrice.Checked)
            {
                SearchPrice(keySearch);
                return;
            }

        }
      
        private void SearchPrice(string keySearch)
        {
            decimal keyPrice = 0;
            decimal.TryParse(keySearch, out keyPrice);
            if (keyPrice > 0)
            {
                using (SaleCarsEntities ctx = new SaleCarsEntities())
                {
                    

                    if (chkAll.Checked)
                    {
                        if (keyPrice <= 100000)
                        {
                            list =
                                ctx.Products.Where(p => p.Price >= keyPrice - 5000 && p.Price <= keyPrice + 5000).ToList();
                        }
                        else // > 100.000
                        {
                            list =
                            ctx.Products.Where(p => p.Price >= keyPrice - 10000 && p.Price <= keyPrice + 10000).ToList();
                        }
                    }
                    else
                    {
                        int type = Convert.ToInt32(DDlType.Items[selectedIndexType].Value);
                        int cat = Convert.ToInt32(DDLCategory.Items[selectedIndexCat].Value);

                        if (keyPrice <= 100000)
                        {
                            list =
                                ctx.Products.Where(p => 
                                    p.Price >= keyPrice - 5000 
                                    && p.Price <= keyPrice + 5000
                                    && (p.TypeID == type) 
                                    && (p.CatID == cat)).ToList();
                        }
                        else // > 100.000
                        {
                            list =
                            ctx.Products.Where(p => 
                                p.Price >= keyPrice - 10000 
                                && p.Price <= keyPrice + 10000
                                && (p.TypeID == type) 
                                && (p.CatID == cat)).ToList();
                        }
                       
                    }

                    LoadData();
                }
            }
        }

        private void SearchName(string keySearch)
        {
            if (!string.IsNullOrEmpty(keySearch) && !string.IsNullOrWhiteSpace(keySearch))
            {
                using (SaleCarsEntities ctx = new SaleCarsEntities())
                {
                    if (chkAll.Checked)

                    {
                        list =
                            ctx.Products.Where(p => p.ProName.Contains(keySearch)).ToList();
                    }
                    else
                    {
                        int type = Convert.ToInt32(DDlType.Items[selectedIndexType].Value);
                        int cat = Convert.ToInt32(DDLCategory.Items[selectedIndexCat].Value);

                        list = ctx.Products.Where(p =>( p.ProName.Contains(keySearch)
                                && (p.TypeID == type) && (p.CatID == cat))).ToList();
                    }

                    LoadData();
                }
            }           
        }

        protected void chkAll_CheckedChanged(object sender, EventArgs e)
        {
            //if (chkAll.Checked == false)
            //{
            //    pnOption.Enabled = true;
            //}
            //else
            //{
            //    pnOption.Enabled = false;
            //}
        }

        protected void DDlType_SelectedIndexChanged(object sender, EventArgs e)
        {
            selectedIndexType = DDlType.SelectedIndex;
        }

        protected void DDLCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            selectedIndexCat = DDLCategory.SelectedIndex;
        }
       //--> end search

        //phan trang
        private void LoadData()
        {
            lvwProducts.DataSource = list;
            lvwProducts.DataBind();
        }

        protected void lvwProducts_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            DataPagerViewProducts.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            this.LoadData();
        }

        //-->end phan trang

        //dat hang
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

                CurrentContext.GetCart().Add(item);
                ((template_sale_cars)this.Master).UpdateCartLink();
            }
        }


        //-> end dat hang
    }
}
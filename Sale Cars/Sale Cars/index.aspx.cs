using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Sale_Cars.Helpers;

namespace Sale_Cars
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using (SaleCarsEntities ctx = new SaleCarsEntities())
            {
                List<Product> listDOR =
                                ctx.Products.OrderByDescending(x => x.DOR).Take(9).ToList();
                lvwDOR.DataSource = listDOR;
                lvwDOR.DataBind();

                List<Product> listSales =
                                ctx.Products.OrderByDescending(x => x.Sales).Take(9).ToList();
                lvwSales.DataSource = listSales;
                lvwSales.DataBind();

                List<Product> listViews =
                                ctx.Products.OrderByDescending(x => x.Views).Take(9).ToList();
                lvwViews.DataSource = listViews;
                lvwViews.DataBind();
            }
        }

        protected void btnSales_Click(object sender, ImageClickEventArgs e)
        {
            pnSales.Visible = true;
            pnNew.Visible = false;
            pnViews.Visible = false;           
        }

        protected void btnViews_Click(object sender, ImageClickEventArgs e)
        {
            pnSales.Visible = false;
            pnNew.Visible = false;
            pnViews.Visible = true;
        }

        protected void btnNew_Click(object sender, ImageClickEventArgs e)
        {
            pnSales.Visible = false;
            pnNew.Visible = true;
            pnViews.Visible = false;

        }

        // ADD CART
        protected void lvw_ItemDataBound(object sender, ListViewItemEventArgs e)
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

        protected void lvw_ItemCommand(object sender, ListViewCommandEventArgs e)
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
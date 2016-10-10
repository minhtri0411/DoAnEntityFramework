using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Sale_Cars.Helpers;

namespace Sale_Cars
{
    public partial class managecart : System.Web.UI.Page
    {
        protected void Page_Load (object sender, EventArgs e)
        {
            if (CurrentContext.IsLogged() == false)
            {
                Response.Redirect("~/logreg.aspx");
            }

            if(IsPostBack == false)
            {
                lvwCart.DataSource = CurrentContext.GetCart().Items;
                lvwCart.DataBind();
            }
        }

        decimal total=0;
        protected void lvwCart_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                CartItems item = (CartItems)e.Item.DataItem;

                ((ImageButton)e.Item.FindControl("btnUpdate")).ValidationGroup = "grp_" + item.ProID;
                ((CompareValidator)e.Item.FindControl("valUpdate")).ValidationGroup = "grp_" + item.ProID;

                using (SaleCarsEntities ctx = new SaleCarsEntities())
                {
                    Product pro = ctx.Products.Where(p => p.ProID == item.ProID).FirstOrDefault();

                    ((Label)e.Item.FindControl("lblSP")).Text = pro.ProName;
                    ((Label)e.Item.FindControl("lblGia")).Text = String.Format("{0:N0}$",pro.Price);

                    decimal amount = pro.Price * item.Quantity;
                    ((Label)e.Item.FindControl("lblTTien")).Text = string.Format("{0:N0}$", amount);

                    total += amount;
                }
            }
        }

        protected void lvwCart_DataBound(object sender, EventArgs e)
        {
            lblTotal.Text = String.Format("{0:N0}$", total);
        }

        protected void lvwCart_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteItem")
            {
                int proID = Convert.ToInt32(e.CommandArgument);
                CurrentContext.GetCart().RemoveItem(proID);

                ((template_sale_cars)this.Master).UpdateCartLink();
                lvwCart.DataSource = CurrentContext.GetCart().Items;
                lvwCart.DataBind();

                return;
            }

            if (e.CommandName == "UpdateItem")
            {
                int proID = Convert.ToInt32(e.CommandArgument);

                using (SaleCarsEntities ctx = new SaleCarsEntities())
                {
                    Product pro = ctx.Products.Where(p => p.ProID == proID).FirstOrDefault();
                    
                    int quantity = Convert.ToInt32(((TextBox)e.Item.FindControl("txtSL")).Text);

                    if (quantity <= pro.Quantity)
                    {
                        CurrentContext.GetCart().UpdateItem(proID, quantity);

                        ((template_sale_cars)this.Master).UpdateCartLink();
                        lvwCart.DataSource = CurrentContext.GetCart().Items;
                        lvwCart.DataBind();
                    }
                    else
                    {
                        if (ClientScript.IsStartupScriptRegistered("thongbaoUP") == false)
                        {
                            ClientScript.RegisterStartupScript(this.GetType(),
                                "thongbaoUP",
                                "alert('Bạn chỉ có thể đặt tối đa là: " + pro.Quantity + " chiếc!');",
                                true
                            );
                        }
                        ((TextBox)e.Item.FindControl("txtSL")).Text = pro.Quantity.ToString();
                    }
                }
                return;
            }
        }

        protected void btnLapHoaDon_Click(object sender, EventArgs e)
        {
            if (CurrentContext.GetCart().Items.Count == 0)
            {
                if (ClientScript.IsStartupScriptRegistered("thongbao") == false)
                {
                    ClientScript.RegisterStartupScript(this.GetType(),
                        "thongbao",
                        "alert('Giỏ hàng rỗng!');",
                        true
                    );
                }
                return;
            }

            Order ord = new Order
            {
                OrderDate = System.DateTime.Now,
                UserID = CurrentContext.GetCurUser().f_ID,
                Total = (long)Convert.ToDecimal(lblTotal.Text.Substring(0, lblTotal.Text.Length - 1))
            };
  
            using (SaleCarsEntities ctx = new SaleCarsEntities())
            {
                foreach (CartItems item in CurrentContext.GetCart().Items)
                {

                    Product pro = ctx.Products.Where(p => p.ProID == item.ProID).FirstOrDefault();
                    if (pro != null)
                    {
                        Orderdetail d = new Orderdetail
                        {
                            ProID = item.ProID,
                            Quantity = item.Quantity,
                            Price = pro.Price,
                            Amount = item.Quantity*pro.Price
                        };

                        ord.Orderdetails.Add(d);

                        UpdateQuantityAndSale(ctx, pro, item);
                    }
                }
                ctx.Orders.Add(ord);
                ctx.SaveChanges();
            }

            CurrentContext.GetCart().Items.Clear();
            ((template_sale_cars)this.Master).UpdateCartLink();
            lvwCart.DataSource = CurrentContext.GetCart().Items;
            lvwCart.DataBind();

            if (ClientScript.IsStartupScriptRegistered("thongbaotc") == false)
            {
                ClientScript.RegisterStartupScript(this.GetType(),
                    "thongbaotc",
                    "alert('Đặt hàng thành công!');",
                    true
                );
            }

        }

        private void UpdateQuantityAndSale (SaleCarsEntities ctx, Product pro, CartItems item)
        {
            //update quantity
            pro.Quantity -= item.Quantity;
            //update sale
            pro.Sales += item.Quantity;

            ctx.Entry(pro).State = System.Data.Entity.EntityState.Modified;
            ctx.SaveChanges();
        }

        protected void btnHuy_Click(object sender, EventArgs e)
        {
            CurrentContext.GetCart().Items.Clear();
            ((template_sale_cars)this.Master).UpdateCartLink();
            lvwCart.DataSource = CurrentContext.GetCart().Items;
            lvwCart.DataBind();
        }
    }
}
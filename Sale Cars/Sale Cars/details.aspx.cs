using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Sale_Cars.Helpers;

namespace Sale_Cars
{
    public partial class details : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!IsPostBack)
            {
                string proID = Request.QueryString["proID"];

                if (string.IsNullOrEmpty(proID))
                {
                    Response.Redirect("~/index.aspx");
                }
                else
                {
                    int i_proID = Convert.ToInt32(proID);
                    int catID = 0;
                    int typeID = 0;

                    using (SaleCarsEntities ctx = new SaleCarsEntities())
                    {
                        Product pro = ctx.Products.Where(p => p.ProID == i_proID).FirstOrDefault();
                        if (pro != null)
                        {
                            img1.ImageUrl = string.Format("../images/products/{0}/1.jpg", pro.ProID);
                            img1_th.ImageUrl = string.Format("../images/products/{0}/1_thumbs.jpg", pro.ProID);
                            img2.ImageUrl = string.Format("../images/products/{0}/2.jpg", pro.ProID);
                            img2_th.ImageUrl = string.Format("../images/products/{0}/2_thumbs.jpg", pro.ProID);

                            lblName.Text = pro.ProName;
                            lblPrice.Text = string.Format("$ {0:N0}", pro.Price);
                            lblQuantity.Text = pro.Quantity.ToString();
                            lblViews.Text = pro.Views.ToString();
                            lblSales.Text = pro.Sales.ToString();
                            lblTinyDes.Text = HttpUtility.HtmlDecode(pro.TinyDes);
                            lblFullDes.Text = HttpUtility.HtmlDecode(pro.FullDes);

                            catID = pro.CatID;
                            typeID = pro.TypeID;

                            if (CurrentContext.IsLogged() && pro.Quantity > 0)
                            {
                                pnAddCart.Visible = true;
                            }
                            else
                            {
                                pnAddCart.Visible = false;
                            }

                            UpdateView(ctx,pro);
                        }

                        // get Category
                        List<Product> listCat =
                        ctx.Products.Where(p => p.CatID == catID && p.ProID != pro.ProID).Take(5).ToList();
                        lvwCat.DataSource = listCat;
                        lvwCat.DataBind();

                        // get Type
                        List<Product> listType =
                        ctx.Products.Where(p => p.TypeID == typeID && p.ProID != pro.ProID).Take(5).ToList();
                        lvwType.DataSource = listType;
                        lvwType.DataBind();
                    }
                }
            }
        }

        protected void btnDatHang_Click(object sender, EventArgs e)
        {
            string proID = Request.QueryString["proID"];
            int i_proID = Convert.ToInt32(proID);

            CartItems item = new CartItems
            {
                ProID = i_proID,
                Quantity = Convert.ToInt32(txtSoLuong.Text)
            };
            int sl =Convert.ToInt32(txtSoLuong.Text);

            if (sl > 0 && sl <= Convert.ToInt32(lblQuantity.Text))
            {
                bool flag = CurrentContext.GetCart().Add(item);

                if (flag == false) // kiểm tra việc đặt hàng vượt quá số lượng
                {
                    if (ClientScript.IsStartupScriptRegistered("errorQ2") == false)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(),
                            "errorQ2",
                            "alert('Bạn đã đặt quá số lượng hàng hiện có!');",
                            true
                        );
                    }
                }
                else
                    ((template_sale_cars)this.Master).UpdateCartLink();
            }
            else // kiểm tra việc đặt hàng vượt quá số lượng
            {
                if (ClientScript.IsStartupScriptRegistered("errorQ") == false)
                {
                    ClientScript.RegisterStartupScript(this.GetType(),
                        "errorQ",
                        "alert('Số lượng không hợp lệ!');",
                        true
                    );
                }
            }
        }

        private void UpdateView(SaleCarsEntities ctx, Product pro)
        {
            //update view
            pro.Views ++;
            ctx.Entry(pro).State = System.Data.Entity.EntityState.Modified;
            ctx.SaveChanges();
        }
    }
}
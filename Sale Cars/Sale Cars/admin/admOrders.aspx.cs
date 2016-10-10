using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Sale_Cars.Helpers;

namespace Sale_Cars.admin
{
    public partial class admOders : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (CurrentContext.IsLogged() == false)
            {
                 Response.Redirect("~/admin/login.aspx?reUrl=/admin/admOrders.aspx");
            }

            if (IsPostBack == false)
            {
                LoadOrders();
            }
        }
        
        private void LoadOrders()
        {
            using (SaleCarsEntities ctx = new SaleCarsEntities())
            {
                List<Order> list = ctx.Orders.ToList();
                lvwOrders.DataSource = list;
                lvwOrders.DataBind();
                
            }
        }

        protected void lvwOrders_ItemEditing(object sender, ListViewEditEventArgs e)
        {
            lvwOrders.EditIndex = e.NewEditIndex;

            LoadOrders();
        }

        protected void lvwOrders_ItemCanceling(object sender, ListViewCancelEventArgs e)
        {
            lvwOrders.EditIndex = -1;
            LoadOrders();
        }
        protected void lvwOrders_ItemUpdating(object sender, ListViewUpdateEventArgs e)
        {
            var orderID = Convert.ToInt32(e.Keys["OrderID"]);
            string typeName = e.NewValues["Shipment"].ToString(); 

                ClientScript.RegisterStartupScript(this.GetType(),
                    "swal",
                    "alert(" + typeName + ");",
                    true
                );

            using (SaleCarsEntities ctx = new SaleCarsEntities())
            {
                Order order = ctx.Orders.Where(c => c.OrderID == orderID).FirstOrDefault();
                if (order != null)
                {
                    int shipment = Convert.ToInt32(e.NewValues["Shipment"]);
                    order.Shipment = shipment;
                    ctx.SaveChanges();
                }
            }
            lvwOrders.EditIndex = -1;
            LoadOrders();
        }

        protected void lvwOrders_ItemDeleting(object sender, ListViewDeleteEventArgs e)
        {
            var orderID = Convert.ToInt32(e.Keys["OrderID"]);
            using (SaleCarsEntities ctx = new SaleCarsEntities())
            {
                Order order = ctx.Orders.Where(c => c.OrderID == orderID).FirstOrDefault();
                if (order != null)
                {
                    ctx.Orders.Remove(order);
                    ctx.SaveChanges();

                    LoadOrders();
                }
            }
        }

        protected void lvwOrders_ItemDataBound(object sender, ListViewItemEventArgs e)
        {

            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                Order od = e.Item.DataItem as Order;
                Label lblShip = e.Item.FindControl("lblShip") as Label;
                DropDownList dl = e.Item.FindControl("ddlShip") as DropDownList;
                if (dl != null)
                {
                    dl.Items.Insert(0, "Undelivered");
                    dl.Items.Insert(1, "Delivered");
                }
                else
                    if (od.Shipment == 1)
                    {
                        lblShip.Text = "Delivered";
                        Label lblSP = e.Item.FindControl("lblSP") as Label;
                        Label lblDate = e.Item.FindControl("lblDate") as Label;
                        Label lblUser = e.Item.FindControl("lblUser") as Label;
                        Label lblTotal = e.Item.FindControl("lblTotal") as Label;

                        lblSP.ForeColor = System.Drawing.Color.Green;
                        lblDate.ForeColor = System.Drawing.Color.Green;
                        lblUser.ForeColor = System.Drawing.Color.Green;
                        lblTotal.ForeColor = System.Drawing.Color.Green;
                        lblShip.ForeColor = System.Drawing.Color.Green;

                    }
                    else
                        if (od.Shipment == 0)
                        {
                            lblShip.Text = "Undelivered";
                            Label lblSP = e.Item.FindControl("lblSP") as Label;
                            Label lblDate = e.Item.FindControl("lblDate") as Label;
                            Label lblUser = e.Item.FindControl("lblUser") as Label;
                            Label lblTotal = e.Item.FindControl("lblTotal") as Label;

                            lblSP.ForeColor = System.Drawing.Color.Orange;
                            lblDate.ForeColor = System.Drawing.Color.Orange;
                            lblUser.ForeColor = System.Drawing.Color.Orange;
                            lblTotal.ForeColor = System.Drawing.Color.Orange;
                            lblShip.ForeColor = System.Drawing.Color.Orange;
                        }
            }
        }
        //phan trang
        protected void lvwOrders_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            DataPagerView.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

            using (SaleCarsEntities ctx = new SaleCarsEntities())
            {
                List<Category> list = ctx.Categories.Include("User").ToList();
                lvwOrders.DataSource = list;
                lvwOrders.DataBind();
            }
        }

    }
}
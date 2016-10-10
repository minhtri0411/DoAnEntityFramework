using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Sale_Cars.Helpers;

namespace Sale_Cars.admin
{
    public partial class admproducts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (CurrentContext.IsLogged() == false)
            {
                Response.Redirect("~/admin/login.aspx?reUrl=/admin/admcategories.aspx");
            }

            if (IsPostBack == false)
            {
                LoadProducts();
                LoadCategoryForAdding();
                LoadCategoryForEdit();
            }
        }

        private void LoadProducts()
        {
            using (SaleCarsEntities ctx = new SaleCarsEntities())
            {
                List<Product> list = ctx.Products.Include("Category").ToList();
                lvwProducts.DataSource = list;
                lvwProducts.DataBind();
            }
        }

        private void LoadCategoryForAdding()
        {
            using (SaleCarsEntities ctx = new SaleCarsEntities())
            {
                List<Category> list = ctx.Categories.ToList();
                ddlCategory.DataSource = list;
                ddlCategory.DataTextField = "CatName";
                ddlCategory.DataValueField = "CatID";
                ddlCategory.DataBind();
            }
        }

        private void LoadCategoryForEdit()
        {
            using (SaleCarsEntities ctx = new SaleCarsEntities())
            {
                List<Category> list = ctx.Categories.ToList();
                ddlCategorye.DataSource = list;
                ddlCategorye.DataTextField = "CatName";
                ddlCategorye.DataValueField = "CatID";
                ddlCategorye.DataBind();
            }
        }

        protected void lvwProducts_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            DataPagerViewProducts.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

            using (SaleCarsEntities ctx = new SaleCarsEntities())
            {
                List<Product> list = ctx.Products.Include("Category").ToList();
                lvwProducts.DataSource = list;
                lvwProducts.DataBind();
            }
        }

        private void ClearProductInfo()
        {
            //add
            txtPrice.Text = string.Empty;
            txtProName.Text = string.Empty;
            txtFullDes.Text = string.Empty;
            txtQuantity.Text = string.Empty;
            txtTinyDes.Text = string.Empty;

            //edit
            txtPricee.Text = string.Empty;
            txtProNamee.Text = string.Empty;
            txtFullDese.Text = string.Empty;
            txtQuantitye.Text = string.Empty;
            txtTinyDese.Text = string.Empty;
        }

        protected void btnClose_Click(object sender, EventArgs e)
        {
            ClearProductInfo();
        }

        protected void btnSavePro_Click(object sender, EventArgs e)
        {
            string proName = txtProName.Text;
            int catID = Convert.ToInt32(ddlCategory.SelectedItem.Value);
            int quantity = Convert.ToInt32(txtQuantity.Text);
            int price = Convert.ToInt32(txtPrice.Text);
            string tinyDes = txtTinyDes.Text;
            string fullDes = txtFullDes.Text;

            Product p = new Product
            {
                DOR = DateTime.Now,
                ProName = proName,
                CatID = catID,
                Quantity = quantity,
                Price = price,
                TinyDes = tinyDes,
                FullDes = fullDes
            };

            using (SaleCarsEntities ctx = new SaleCarsEntities())
            {
                ctx.Products.Add(p);
                ctx.SaveChanges();
            }

            if(fuPhotoL1.HasFile && fuPhotoN1.HasFile)
            {
                //tạo thư mục chứa hình
                string spDirPath = Server.MapPath("~/images/products");
                string targetDirPath = Path.Combine(spDirPath, p.ProID.ToString());
                Directory.CreateDirectory(targetDirPath);

                //copy hình lên
                //hinh 1
                string mainFileName = Path.Combine(targetDirPath, "1.jpg");
                fuPhotoL1.SaveAs(mainFileName);

                string thumbsFileName = Path.Combine(targetDirPath,"1_thumbs.jpg");
                fuPhotoN1.SaveAs(thumbsFileName);
                
                //hình 2
                mainFileName = Path.Combine(targetDirPath, "2.jpg");
                fuPhotoL2.SaveAs(mainFileName);

               thumbsFileName = Path.Combine(targetDirPath, "2_thumbs.jpg");
               fuPhotoN2.SaveAs(thumbsFileName);

            }

            ClientScript.RegisterStartupScript(this.GetType(),
                   "swal",
                   "alert('Đã thêm');",
                   true
               );

            ClearProductInfo();
            LoadProducts();
        }

        public static int tempProID = -1;
        protected void lvwProducts_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "EditProduct")
            {
                int proID = Convert.ToInt32(e.CommandArgument);
                tempProID = proID;
                using (SaleCarsEntities ctx = new SaleCarsEntities())
                {
                    Product pro = ctx.Products.Where
                        (p => p.ProID == proID).FirstOrDefault();

                    txtPricee.Text = pro.Price.ToString();
                    txtProNamee.Text = pro.ProName;
                    txtFullDese.Text = HttpUtility.HtmlDecode(pro.FullDes);
                    txtQuantitye.Text = pro.Quantity.ToString();
                    txtTinyDese.Text = HttpUtility.HtmlDecode(pro.TinyDes);
                    ddlCategorye.SelectedValue = pro.CatID.ToString();
                }

                //string script = "$('#modalEdit').modal('show')";

                //if (ClientScript.IsStartupScriptRegistered("editProduct") == false)
                //{
                //    ClientScript.RegisterStartupScript
                //    (
                //        this.GetType(), "editProduct", script, true
                //    );
                //}

            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ClearProductInfo();
            tempProID = -1;
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int proid = tempProID;
            if (proid != -1)
            {
                using (SaleCarsEntities ctx = new SaleCarsEntities())
                {
                    Product p = ctx.Products.Where(pro => pro.ProID == proid).FirstOrDefault();
                    if (p != null)
                    {
                        p.ProName = txtProNamee.Text; ;
                        p.CatID = Convert.ToInt32(ddlCategorye.SelectedItem.Value);
                        p.Quantity = Convert.ToInt32(txtQuantitye.Text);
                        p.Price = Convert.ToInt32(txtPricee.Text);
                        p.TinyDes = txtTinyDese.Text;
                        p.FullDes = txtFullDese.Text;

                        ctx.Entry(p).State = System.Data.Entity.EntityState.Modified;
                        ctx.SaveChanges();

                        if (FileUpload1.HasFile && FileUpload11.HasFile && FileUpload2.HasFile && FileUpload22.HasFile)
                        {
                            string spDirPath = Server.MapPath("~/images/products");
                            string targetDirPath = Path.Combine(spDirPath,p.ProID.ToString());

                            if(Directory.Exists(targetDirPath)==false)
                            {
                                Directory.CreateDirectory(targetDirPath);
                            }
                            //copy hình lên
                            //hinh 1
                            string mainFileName = Path.Combine(targetDirPath, "1.jpg");
                            FileUpload1.SaveAs(mainFileName);

                            string thumbsFileName = Path.Combine(targetDirPath, "1_thumbs.jpg");
                            FileUpload11.SaveAs(thumbsFileName);
                  
                            //hình 2
                             mainFileName = Path.Combine(targetDirPath, "2.jpg");
                            FileUpload2.SaveAs(mainFileName);

                            thumbsFileName = Path.Combine(targetDirPath, "2_thumbs.jpg");
                            FileUpload22.SaveAs(thumbsFileName);
                        }
                    }
                }

                ClientScript.RegisterStartupScript(this.GetType(),
                   "swal",
                   "alert('Đã Chỉnh sửa');",
                   true
               );

                ClearProductInfo();
                tempProID = -1;
                LoadProducts();
            }
        }

        protected void lvwProducts_ItemDeleting(object sender, ListViewDeleteEventArgs e)
        {
            var proID = Convert.ToInt32(e.Keys["ProID"]);
            using (SaleCarsEntities ctx = new SaleCarsEntities())
            {
                Product pro = ctx.Products.Where(c => c.ProID == proID).FirstOrDefault();
                if (pro != null)
                {
                    ctx.Products.Remove(pro);
                    ctx.SaveChanges();

                    LoadProducts();
                }
            }
        }
    }
}
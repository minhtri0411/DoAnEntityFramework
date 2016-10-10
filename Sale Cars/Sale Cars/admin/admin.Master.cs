using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Sale_Cars.Helpers;

namespace Sale_Cars.admin
{
    public partial class admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            CurrentContext.Destroy();
            Response.Redirect(Request.Url.AbsoluteUri);
        }
    }
}
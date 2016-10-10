using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sale_Cars.Helpers
{
    public class CurrentContext
    {

        public static bool IsLogged()
        {
            if ((int)HttpContext.Current.Session["IsLogin"] == 1)
                return true;
            if (HttpContext.Current.Request.Cookies["Username"] != null)
            {
                string username = HttpContext.Current.Request.Cookies["Username"].Value;
                HttpContext.Current.Session["IsLogin"] = 1;

                using (SaleCarsEntities ctx = new SaleCarsEntities())
                {
                    User us = ctx.Users
                        .Where(u => u.f_Username == username)
                        .FirstOrDefault();

                    HttpContext.Current.Session["CurUser"] = us;
                }
                return true;
            }

            return false;
        }

        public static User GetCurUser()
        {
            return (User)HttpContext.Current.Session["CurUser"];
        }

        public static Cart GetCart()
        {
            return (Cart)HttpContext.Current.Session["Cart"];
        }

        public static void Destroy()
        {
            HttpContext.Current.Session["IsLogin"] = 0;
            HttpContext.Current.Session["CurUser"] = null;
            GetCart().Items.Clear();

            HttpContext.Current.Response.Cookies["Username"].Expires = DateTime.Now.AddDays(-1);
        }
    }
}
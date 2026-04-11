using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LMS_ProjectTraining
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["lang"] != null)
            {
                string requestedLang = Request.QueryString["lang"].ToString();
                string currentLang = Session["lang"] != null ? Session["lang"].ToString() : "";

                if (requestedLang != currentLang)
                {
                    Session["lang"] = requestedLang;
                    Response.Redirect(Request.Url.AbsolutePath);
                }
            }
        }
    }
}
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
                Session["lang"] = Request.QueryString["lang"];
                Response.Redirect(Request.Url.AbsolutePath);
            }
        }
    }
}
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LMS_ProjectTraining
{
    public partial class Login : System.Web.UI.Page
    {
        DBConnect dbcon = new DBConnect();
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            //for member login
            using (SqlCommand localCmd = new SqlCommand("sp_UserLogin", dbcon.GetCon()))
            {
                localCmd.CommandType = System.Data.CommandType.StoredProcedure;
                localCmd.Parameters.AddWithValue("@member_id", int.TryParse(txtMemberID.Text.Trim(), out int mid) ? mid : 0);
                localCmd.Parameters.AddWithValue("@password", txtPassword.Text.Trim());
                
                DataTable dt = dbcon.Load_Data(localCmd);
                if (dt.Rows.Count > 0)
                {
                    DataRow dr = dt.Rows[0];
                    Session["role"] = "user";
                    Session["fullname"] = dr["full_name"].ToString();
                    Session["username"] = dr["full_name"].ToString(); // Consistent with original
                    Session["status"] = dr["account_status"].ToString();
                    Session["mid"] = txtMemberID.Text;
                    
                    Response.Redirect("~/UserScreen/UserHome.aspx");
                }
                else
                {
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Lỗi', 'Lỗi! Thông tin đăng nhập không hợp lệ', 'error')", true);
                }
            }
        }

        protected void btnAdminLogin_Click(object sender, EventArgs e)
        {
            //Admin Login button
            using (SqlCommand localCmd = new SqlCommand("sp_AdminLogin", dbcon.GetCon()))
            {
                localCmd.CommandType = System.Data.CommandType.StoredProcedure;
                localCmd.Parameters.AddWithValue("@username", txtAdminID.Text.Trim());
                localCmd.Parameters.AddWithValue("@password", txtAdminPass.Text.Trim());
                
                DataTable dt = dbcon.Load_Data(localCmd);
                if (dt.Rows.Count > 0)
                {
                    DataRow dr = dt.Rows[0];
                    Session["Adminrole"] = "Admin";
                    Session["Adminusername"] = dr["username"].ToString();
                    Session["Adminfullname"] = dr["full_name"].ToString();
                    
                    Response.Redirect("~/Admin/AdminHome.aspx");
                }
                else
                {
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Lỗi', 'Thông tin đăng nhập không hợp lệ', 'error')", true);
                }
            }
        }
    }
}
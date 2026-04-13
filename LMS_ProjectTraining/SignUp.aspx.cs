using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LMS_ProjectTraining
{
    public partial class SignUp : System.Web.UI.Page
    {
        DBConnect dbcon = new DBConnect();
        SqlCommand cmd;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Autogenrate();
            }
        }

        protected void btnSignup_Click(object sender, EventArgs e)
        {
            //how to insert or signup button code
            if (checkDuplicationMemberExist())
            {
                Response.Write("<script>alert('Th\u00e0nh vi\u00ean \u0111\u00e3 t\u1ed3n t\u1ea1i v\u1edbi ID v\u00e0 email n\u00e0y');</script>");
            }
            else
            {
                createAccount();
            }
        }

        private void createAccount()
        {
            dbcon.OpenCon();
            cmd = new SqlCommand("sp_InsertSignup", dbcon.GetCon());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@full_name", txtFullName.Text);
            cmd.Parameters.AddWithValue("@dob", txtDOB.Text);
            cmd.Parameters.AddWithValue("@contact_no", txtContactNO.Text);
            cmd.Parameters.AddWithValue("@email", txtEmail.Text);
            cmd.Parameters.AddWithValue("@state", ddlState.SelectedItem.Text);
            cmd.Parameters.AddWithValue("@city", txtCity.Text);
            cmd.Parameters.AddWithValue("@pincode", txtPIN.Text);
            cmd.Parameters.AddWithValue("@full_address", txtAddress.Text);
            cmd.Parameters.AddWithValue("@member_id", int.TryParse(txtMemberID.Text, out int mid) ? mid : 0);
            cmd.Parameters.AddWithValue("@password", txtPassword.Text);
            cmd.Parameters.AddWithValue("@account_status", "active");
            if(cmd.ExecuteNonQuery()==1)
            {
                //Response.Write("<script>alert('T\u1ea1o t\u00e0i kho\u1ea3n th\u00e0nh c\u00f4ng');</script>");
                ClientScript.RegisterClientScriptBlock(this.GetType(),"alert","swal('Success','T\u1ea1o t\u00e0i kho\u1ea3n th\u00e0nh c\u00f4ng','success')",true);
                clrcontrol();
                Autogenrate();
            }
            else
            {                 
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('L\u1ed7i','L\u1ed7i! kh\u00f4ng th\u1ec3 th\u00eam b\u1ea3n ghi...vui l\u00f2ng th\u1eed l\u1ea1i','error')", true);
            }
            dbcon.CloseCon();           

        }

        protected bool checkDuplicationMemberExist()
        {
            cmd = new SqlCommand("sp_CheckDuplicateMember", dbcon.GetCon());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@member_id", int.TryParse(txtMemberID.Text.Trim(), out int mid) ? mid : 0);
            cmd.Parameters.AddWithValue("@email", txtEmail.Text.Trim());
            dbcon.OpenCon();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count >= 1)
            {
                return true;
            }
            else
            {
                return false;
            }

        }
        public void Autogenrate()
        {
            using (SqlCommand localCmd = new SqlCommand("select max(member_id) from member_master_tbl", dbcon.GetCon()))
            {
                dbcon.OpenCon();
                object result = localCmd.ExecuteScalar();
                dbcon.CloseCon();

                if (result == null || result == DBNull.Value)
                {
                    txtMemberID.Text = "1001";
                }
                else
                {
                    int r = Convert.ToInt32(result);
                    txtMemberID.Text = (r + 1).ToString();
                }
            }
        }
        private void clrcontrol()
        {
            txtFullName.Text = txtAddress.Text = txtCity.Text = txtContactNO.Text = txtDOB.Text = txtEmail.Text = txtFullName.Text = txtPassword.Text = txtPIN.Text = String.Empty;
            ddlState.SelectedIndex = 0;
            ddlState.SelectedItem.Text = "Select";
            txtFullName.Focus();

        }
    }
}
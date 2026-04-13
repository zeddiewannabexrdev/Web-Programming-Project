using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LMS_ProjectTraining.Admin
{
    public partial class BookFineEntry : System.Web.UI.Page
    {
        SqlCommand cmd;
        DBConnect dbcon = new DBConnect();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {                
                if (Request.QueryString["mid"] != null && Request.QueryString["mid"] != string.Empty)
                {
                    GetMemName(Request.QueryString["mid"]);
                }
                if (Request.QueryString["bid"] != null && Request.QueryString["bid"] != string.Empty)
                {
                    GetBookName(Request.QueryString["bid"]);
                }
                if (Request.QueryString["day"] != null && Request.QueryString["day"] != string.Empty)
                {
                    Calculatebookfine(Request.QueryString["day"]);
                }
                lblredirectMsg.Visible = false;
            }
        }
        private void GetMemName(string mmid)
        {
            cmd = new SqlCommand("sp_getMemberByID", dbcon.GetCon());
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@member_id", int.TryParse(mmid, out int mid) ? mid : 0);
            DataTable dtt = dbcon.Load_Data(cmd);
            if (dtt.Rows.Count >= 1)
            {
                lblMembername.Text = dtt.Rows[0]["full_name"].ToString();
                ViewState["member_name"] = dtt.Rows[0]["full_name"].ToString();
                txtFullName.Text= dtt.Rows[0]["full_name"].ToString();
                txtEmail.Text= dtt.Rows[0]["email"].ToString();
                txtaddress.Text= dtt.Rows[0]["full_address"].ToString();
                txtCity.Text = dtt.Rows[0]["city"].ToString();
                txtstate.Text = dtt.Rows[0]["state"].ToString();
                txtzip.Text = dtt.Rows[0]["pincode"].ToString();
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('L\u1ed7i','Sai m\u00e3 th\u00e0nh vi\u00ean...vui l\u00f2ng th\u1eed l\u1ea1i','error')", true);
            }
        }

        private void GetBookName(string bid)
        {
            cmd = new SqlCommand("spgetBookBYID", dbcon.GetCon());
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@book_id", int.TryParse(bid, out int b_id) ? b_id : 0);
            DataTable dtt = dbcon.Load_Data(cmd);
            if (dtt.Rows.Count >= 1)
            {
                ViewState["book_name"] = dtt.Rows[0]["book_name"].ToString();
            }
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            A1.Visible = false;
            A2.Visible = true;
            btnNext.Visible = false;
        }
        private void Calculatebookfine(string d)
        {
            int days = Convert.ToInt32(d);
            double fine;
            if (days <= 0)
            {
                fine = 0.0;
            }
            else if (days >=1 && days <= 5)
            {
                fine = days  * 0.5F;
            }
            else if (days > 5 && days <= 10)
            {
                fine = 5 * 0.5F + (days - 5) * 1;
            }
            else if (days > 10 && days <= 30)
            {                
                fine = 5 * 0.5F + (days-10) * 1.5F;
            }
            else
            {                
                fine = 5 * 0.5F + 25 * 1.5F + (days-30) * 2;                
            }
            lblfine.Text = "" + fine;
            txtAmount.Text = fine.ToString();
        }

        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            if(IsValid)
            {
                InsertBookFine();
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('L\u1ed7i','L\u1ed7i x\u00e1c th\u1ef1c...vui l\u00f2ng th\u1eed l\u1ea1i','error')", true);
            }
        }

        private void InsertBookFine()
        {
            cmd = new SqlCommand("sp_InsertFineDetials", dbcon.GetCon());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@book_id", int.TryParse(Request.QueryString["bid"], out int bid) ? bid : 0);
            cmd.Parameters.AddWithValue("@member_id", int.TryParse(Request.QueryString["mid"], out int mid) ? mid : 0);
            cmd.Parameters.AddWithValue("@member_name", ViewState["member_name"] ?? "");
            cmd.Parameters.AddWithValue("@book_name", ViewState["book_name"] ?? "");
            cmd.Parameters.AddWithValue("@fineamount", decimal.TryParse(txtAmount.Text.Trim(), out decimal amount) ? amount : 0);           
            cmd.Parameters.AddWithValue("@number_of_day", int.TryParse(Request.QueryString["day"], out int days) ? days : 0);
            cmd.Parameters.AddWithValue("@fine_date", DateTime.Now.ToString("dd-MM-yyyy"));

            if (dbcon.InsertUpdateData(cmd))
            {
                ReturnBook();
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Th\u00e0nh c\u00f4ng','\u0110\u00e3 thanh to\u00e1n ti\u1ec1n ph\u1ea1t v\u00e0 tr\u1ea3 s\u00e1ch th\u00e0nh c\u00f4ng','success')", true);
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('L\u1ed7i','L\u1ed7i! kh\u00f4ng th\u1ec3 c\u1eadp nh\u1eadt...vui l\u00f2ng th\u1eed l\u1ea1i','error')", true);
            }
        }
        private void ReturnBook()
        {
            cmd = new SqlCommand("sp_returnBook_Updatestock", dbcon.GetCon());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@book_id", int.TryParse(Request.QueryString["bid"], out int bid) ? bid : 0);
            cmd.Parameters.AddWithValue("@member_id", int.TryParse(Request.QueryString["mid"], out int mid) ? mid : 0);
            if (dbcon.InsertUpdateData(cmd))
            {
                A2.Visible = false;
                lblredirectMsg.Visible = true;
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Th\u00e0nh c\u00f4ng','Tr\u1ea3 s\u00e1ch th\u00e0nh c\u00f4ng','success')", true);
                                
                Response.AddHeader("REFRESH", "5;URL=AdminHome.aspx");
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('L\u1ed7i','L\u1ed7i! kh\u00f4ng th\u1ec3 c\u1eadp nh\u1eadt...vui l\u00f2ng th\u1eed l\u1ea1i','error')", true);
            }
        }
    }
}
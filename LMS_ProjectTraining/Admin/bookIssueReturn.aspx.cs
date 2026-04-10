using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LMS_ProjectTraining.Admin
{
    public partial class bookIssueReturn : System.Web.UI.Page
    {
        DBConnect dbcon = new DBConnect();
        SqlCommand cmd;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                BindGridData();                
            }
            btnSearch.Text = LanguageHelper.Get("btn_search");
            btnIssue.Text = LanguageHelper.Get("btn_issue");
            btnReturn.Text = LanguageHelper.Get("btn_return");
            
            if (GridView1.Columns.Count > 0)
            {
                GridView1.Columns[0].HeaderText = LanguageHelper.Get("lbl_member_id");
                GridView1.Columns[1].HeaderText = LanguageHelper.Get("lbl_mem_name");
                GridView1.Columns[2].HeaderText = LanguageHelper.Get("lbl_book_id");
                GridView1.Columns[3].HeaderText = LanguageHelper.Get("lbl_book_name");
                GridView1.Columns[4].HeaderText = LanguageHelper.Get("lbl_issue_date");
                GridView1.Columns[5].HeaderText = LanguageHelper.Get("lbl_due_date");
            }
        }
        private void BindGridData()
        {
            cmd = new SqlCommand("sp_GetIssueBook", dbcon.GetCon());
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            //cmd.Parameters.AddWithValue("@StatementType", "Select");
            GridView1.DataSource = dbcon.Load_Data(cmd);
            GridView1.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if(IsValid)
            {
                GetMemName();
                GetBookName();
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('L\u1ed7i','Vui l\u00f2ng nh\u1eadp M\u00e3 th\u00e0nh vi\u00ean ho\u1eb7c M\u00e3 s\u00e1ch','error')", true);
            }
        }

        private void GetBookName()
        {
            cmd = new SqlCommand("sp_Insert_Up_Del_BookInventory", dbcon.GetCon());
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@book_id", int.TryParse(txtBookID.Text.Trim(), out int bid) ? bid : 0);
            cmd.Parameters.AddWithValue("@StatementType", "SelectByID");            

            DataTable dtt = dbcon.Load_Data(cmd);
            if (dtt.Rows.Count >= 1)
            {
                txtBookName.Text = dtt.Rows[0]["book_name"].ToString();
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('L\u1ed7i','Sai m\u00e3 s\u00e1ch...vui l\u00f2ng th\u1eed l\u1ea1i','error')", true);
            }
        }

        private void GetMemName()
        {
            cmd = new SqlCommand("sp_getMember_ByID", dbcon.GetCon());
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@ID", int.TryParse(txtMemID.Text.Trim(), out int mid) ? mid : 0);
            DataTable dtt=dbcon.Load_Data(cmd);
            if(dtt.Rows.Count>=1)
            {
                txtMemName.Text = dtt.Rows[0]["full_name"].ToString();
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('L\u1ed7i','Sai m\u00e3 th\u00e0nh vi\u00ean...vui l\u00f2ng th\u1eed l\u1ea1i','error')", true);
            }
        }

        protected void btnIssue_Click(object sender, EventArgs e)
        {
            if(IsBookExist() && IsMemberExist())
            {
                if (IsIssueEntryExist())
                {
                    Response.Write("<script>alert('Th\u00e0nh vi\u00ean n\u00e0y \u0111\u00e3 m\u01b0\u1ee3n cu\u1ed1n s\u00e1ch n\u00e0y r\u1ed3i');</script>");
                }
                else
                {
                    issueBook();
                    BindGridData();
                }
            }
            else
            {
                Response.Write("<script>alert('Sai M\u00e3 s\u00e1ch ho\u1eb7c M\u00e3 th\u00e0nh vi\u00ean');</script>");
            }
        }

        private void issueBook()
        {
            cmd = new SqlCommand("sp_InsertBookIssue", dbcon.GetCon());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@book_id", int.TryParse(txtBookID.Text.Trim(), out int bid) ? bid : 0);
            cmd.Parameters.AddWithValue("@member_id", int.TryParse(txtMemID.Text.Trim(), out int mid) ? mid : 0);
            cmd.Parameters.AddWithValue("@member_name", txtMemName.Text.Trim());
            cmd.Parameters.AddWithValue("@book_name", txtBookName.Text.Trim());
            cmd.Parameters.AddWithValue("@issue_date", txtIssueDate.Text.Trim());
            cmd.Parameters.AddWithValue("@due_date", txtDueDate.Text.Trim());
            if (dbcon.InsertUpdateData(cmd))
            {
                updateBookStock();                
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('L\u1ed7i','L\u1ed7i! kh\u00f4ng th\u1ec3 c\u1eadp nh\u1eadt...vui l\u00f2ng th\u1eed l\u1ea1i','error')", true);
            }
        }

        private void updateBookStock()
        {
            cmd = new SqlCommand("sp_UpdateIssueBookStock", dbcon.GetCon());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@book_id", int.TryParse(txtBookID.Text.Trim(), out int bid) ? bid : 0);            
            if (dbcon.InsertUpdateData(cmd))
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Th\u00e0nh c\u00f4ng','Cho m\u01b0\u1ee3n s\u00e1ch th\u00e0nh c\u00f4ng','success')", true);
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('L\u1ed7i','L\u1ed7i! kh\u00f4ng th\u1ec3 c\u1eadp nh\u1eadt s\u1ed1 l\u01b0\u1ee3ng t\u1ed3n kho','error')", true);
            }
        }

        private bool IsIssueEntryExist()
        {
            cmd = new SqlCommand("sp_checkIssueexistOrnot", dbcon.GetCon());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@bid", int.TryParse(txtBookID.Text.Trim(), out int bid) ? bid : 0);
            cmd.Parameters.AddWithValue("@mid", int.TryParse(txtMemID.Text.Trim(), out int mid) ? mid : 0);
            DataTable dtt = dbcon.Load_Data(cmd);
            if (dtt.Rows.Count >= 1)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        private bool IsBookExist()
        {
            cmd = new SqlCommand("sp_CheckBookStockExist", dbcon.GetCon());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@book_id", int.TryParse(txtBookID.Text.Trim(), out int bid) ? bid : 0);
            DataTable dtt = dbcon.Load_Data(cmd);
            if(dtt.Rows.Count>=1)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        private bool IsMemberExist()
        {
            cmd = new SqlCommand("sp_getMember_ByID", dbcon.GetCon());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@ID", int.TryParse(txtMemID.Text.Trim(), out int mid) ? mid : 0);
            DataTable dtt = dbcon.Load_Data(cmd);
            if (dtt.Rows.Count >= 1)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        protected void btnReturn_Click(object sender, EventArgs e)
        {
            if (IsBookExist() && IsMemberExist())
            {
                if (IsIssueEntryExist())
                {
                    
                    if(CheckFine())
                    {
                        ReturnBook();
                        BindGridData();
                    }
                    else
                    {
                        //open fine page where user can paid fine
                        Response.Redirect("BookFineEntry.aspx?bid="+txtBookID.Text+ "&mid="+txtMemID.Text+ "&day="+ Session["day"].ToString());

                    }
                    
                }
                else
                {
                    Response.Write("<script>alert('B\u1ea3n ghi n\u00e0y kh\u00f4ng t\u1ed3n t\u1ea1i');</script>");                    
                }
            }
            else
            {
                Response.Write("<script>alert('Sai M\u00e3 s\u00e1ch ho\u1eb7c M\u00e3 th\u00e0nh vi\u00ean');</script>");
            }
        }

        private void ReturnBook()
        {
            cmd = new SqlCommand("sp_returnBook_Updatestock", dbcon.GetCon());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@book_id", int.TryParse(txtBookID.Text.Trim(), out int bid) ? bid : 0);
            cmd.Parameters.AddWithValue("@member_id", int.TryParse(txtMemID.Text.Trim(), out int mid) ? mid : 0);
            if (dbcon.InsertUpdateData(cmd))
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Th\u00e0nh c\u00f4ng','Tr\u1ea3 s\u00e1ch th\u00e0nh c\u00f4ng','success')", true);
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('L\u1ed7i','L\u1ed7i! kh\u00f4ng th\u1ec3 c\u1eadp nh\u1eadt...vui l\u00f2ng th\u1eed l\u1ea1i','error')", true);
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if(e.Row.RowType == DataControlRowType.DataRow)
                {
                    //Check your condition here
                    DateTime dt = Convert.ToDateTime(e.Row.Cells[5].Text);
                    DateTime today = DateTime.Today;
                    if (today > dt)
                    {
                        e.Row.BackColor = System.Drawing.Color.PaleVioletRed;
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }
        private bool CheckFine()
        {
            int days;
            cmd = new SqlCommand("sp_GetNumOfDay", dbcon.GetCon());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@book_id", int.TryParse(txtBookID.Text.Trim(), out int bid) ? bid : 0);
            cmd.Parameters.AddWithValue("@member_id", int.TryParse(txtMemID.Text.Trim(), out int mid) ? mid : 0);
            DataTable dtt = dbcon.Load_Data(cmd);
            if(dtt.Rows.Count>=1)
            {
                days =Convert.ToInt32( dtt.Rows[0]["number_of_day"].ToString());
                Session["day"] = days;
                if(days<=0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                return false;
            }
        }
    }
}
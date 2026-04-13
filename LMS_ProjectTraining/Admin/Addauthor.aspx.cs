using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.WebSockets;

namespace LMS_ProjectTraining.Admin
{
    public partial class Addauthor : System.Web.UI.Page
    {
        DBConnect dbcon = new DBConnect();
        SqlCommand cmd;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                Autogenrate();
                BindRepeater();
            }
            btnAdd.Text = LanguageHelper.Get("btn_add");
            btnupdate.Text = LanguageHelper.Get("btn_update");
            btncancel.Text = LanguageHelper.Get("btn_cancel");
        }

        protected string GetDeleteConfirmText()
        {
            return "return confirm('" + LMS_ProjectTraining.LanguageHelper.Get("confirm_delete_msg") + "');";
        }
        private void AddAuthor()
        {
            using (SqlCommand localCmd = new SqlCommand("sp_InsertAuthor", dbcon.GetCon()))
            {
                localCmd.CommandType = CommandType.StoredProcedure;
                localCmd.Parameters.AddWithValue("@author_id", int.TryParse(txtID.Text.Trim(), out int aid) ? aid : 0);
                localCmd.Parameters.AddWithValue("@author_name", txtAuthorName.Text.Trim());
                dbcon.InsertUpdateData(localCmd);
            }
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (CheckDuplicateAuthor())
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Lỗi','Mã ID hoặc Tên tác giả đã tồn tại','error')", true);
            }
            else
            {
                AddAuthor();
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Thành công','Lưu thành công','success')", true);
                clrcontrol();
                BindRepeater();
                Autogenrate();
            }
        }

        private bool CheckDuplicateAuthor()
        {
            using (SqlCommand localCmd = new SqlCommand("SELECT * FROM author_tbl WHERE author_id=@ID OR author_name=@Name", dbcon.GetCon()))
            {
                localCmd.Parameters.AddWithValue("@ID", int.TryParse(txtID.Text.Trim(), out int aid) ? aid : 0);
                localCmd.Parameters.AddWithValue("@Name", txtAuthorName.Text.Trim());
                DataTable dt = dbcon.Load_Data(localCmd);
                return dt.Rows.Count > 0;
            }
        }
        protected void clrcontrol()
        {
            txtAuthorName.Text = txtID.Text = String.Empty;
            txtID.Focus();
        }
        public void Autogenrate()
        {
            int r;
            cmd = new SqlCommand("select max(author_id)as ID from author_tbl", dbcon.GetCon());
            dbcon.OpenCon();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                string d = dr[0].ToString();
                if (d == "")
                {
                    // Reseed identity to 0 if table is empty so next insert is 1
                    string reseedSql = "DBCC CHECKIDENT ('author_tbl', RESEED, 0);";
                    SqlCommand reseedCmd = new SqlCommand(reseedSql, dbcon.GetCon());
                    dbcon.OpenCon();
                    reseedCmd.ExecuteNonQuery();
                    dbcon.CloseCon();

                    txtID.Text = "1";
                }
                else
                {
                    r = Convert.ToInt32(dr[0].ToString());
                    r = r + 1;
                    txtID.Text = r.ToString();
                }
                txtID.ReadOnly = false;
                //txtID.BackColor = System.Drawing.Color.Red;
            }
            dbcon.CloseCon();
        }

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "edit")
            {
                string id = e.CommandArgument.ToString();
                SearchDataforUpdate(Convert.ToInt32(id));
            }
            else if (e.CommandName == "delete")
            {
                string id = e.CommandArgument.ToString();
                cmd = new SqlCommand("DELETE FROM author_tbl WHERE author_id=@ID", dbcon.GetCon());
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@ID", Convert.ToInt32(id));
                
                try
                {
                    dbcon.OpenCon();
                    int row = cmd.ExecuteNonQuery();
                    dbcon.CloseCon();
                    if (row > 0)
                    {
                        // Reset Identity to max ID to avoid gaps at the end
                        string reseedSql = "DECLARE @max INT; SELECT @max = ISNULL(MAX(author_id), 0) FROM author_tbl; DBCC CHECKIDENT ('author_tbl', RESEED, @max);";
                        SqlCommand reseedCmd = new SqlCommand(reseedSql, dbcon.GetCon());
                        dbcon.OpenCon();
                        reseedCmd.ExecuteNonQuery();
                        dbcon.CloseCon();

                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Thành công','Xóa thành công','success')", true);
                        clrcontrol();
                        BindRepeater();
                        Autogenrate();
                        btnAdd.Visible = true;
                        btnupdate.Visible = false;
                        btncancel.Visible = false;
                    }
                    else
                    {
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Lỗi','Không tìm thấy bản ghi để xóa','error')", true);
                    }
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Lỗi','Không thể xóa. Tác giả có thể đang được liên kết với sách.','error')", true);
                }
                finally
                {
                    dbcon.CloseCon();
                }

            }

        }

        private void SearchDataforUpdate(int idd)
        {
            cmd = new SqlCommand("SELECT * FROM author_tbl WHERE author_id=@ID", dbcon.GetCon());
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@ID",idd);
            dbcon.OpenCon();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            //DataTable dt = new DataTable();
            DataSet ds = new DataSet();
            da.Fill(ds, "dt");
            dbcon.CloseCon();
            if (ds.Tables[0].Rows.Count > 0)
            {
                Session["AuthorID"] = ds.Tables[0].Rows[0]["author_id"].ToString();
                txtID.Text = ds.Tables[0].Rows[0]["author_id"].ToString();
                txtAuthorName.Text= ds.Tables[0].Rows[0]["author_name"].ToString();
                btnAdd.Visible = false;
                btnupdate.Visible = true;
                btncancel.Visible = true;
            }
            else
            {                 
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('L\u1ed7i','Kh\u00f4ng t\u00ecm th\u1ea5y b\u1ea3n ghi, vui l\u00f2ng th\u1eed l\u1ea1i','error')", true);
            }

        }

        protected void BindRepeater()
        {
            cmd = new SqlCommand("spGetAuthor", dbcon.GetCon());
            cmd.CommandType = CommandType.StoredProcedure;
            DataTable dt = new DataTable();
            dbcon.OpenCon();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            Repeater1.DataSource = dt;
            Repeater1.DataBind();
        }

        protected void btnupdate_Click(object sender, EventArgs e)
        {
            using (SqlCommand localCmd = new SqlCommand("sp_UpdateAuthor", dbcon.GetCon()))
            {
                localCmd.CommandType = CommandType.StoredProcedure;
                localCmd.Parameters.AddWithValue("@author_id", int.TryParse(txtID.Text, out int aid) ? aid : 0);
                localCmd.Parameters.AddWithValue("@author_name", txtAuthorName.Text);
                if (dbcon.InsertUpdateData(localCmd))
                {
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Thành công','Cập nhật thành công','success')", true);
                    clrcontrol();
                    BindRepeater();
                    Autogenrate();
                    btnAdd.Visible = true;
                    btnupdate.Visible = false;
                    btncancel.Visible = false;
                }
                else
                {
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Lỗi','Lỗi! không thể cập nhật...vui lòng thử lại','error')", true);
                }
            }
        }

        protected void btncancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminHome.aspx");
        }
    }
}
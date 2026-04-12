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
    public partial class Add_publisher : System.Web.UI.Page
    {
        DBConnect dbcon = new DBConnect();
        SqlCommand cmd;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Autogenrate();
                Bindrecord();
                btnAdd.Visible = true;
                btnupdate.Visible = false;
                btnCancel.Visible = true;
            }
            btnAdd.Text = LanguageHelper.Get("btn_add");
            btnupdate.Text = LanguageHelper.Get("btn_update");
            btnCancel.Text = LanguageHelper.Get("btn_cancel");
        }

        protected string GetDeleteConfirmText()
        {
            return "return confirm('" + LMS_ProjectTraining.LanguageHelper.Get("confirm_delete_msg") + "');";
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
          if(IsValid)
            {
                insertpublisher();
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('L\u1ed7i','L\u1ed7i x\u00e1c th\u1ef1c! vui l\u00f2ng nh\u1eadp d\u1eef li\u1ec7u h\u1ee3p l\u1ec7','error')", true);
            }
        }

        protected void btnupdate_Click(object sender, EventArgs e)
        {
            cmd = new SqlCommand("sp_UpdatePublisher", dbcon.GetCon());
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@publisher_id", int.TryParse(txtpublisherID.Text, out int pid) ? pid : 0);
            cmd.Parameters.AddWithValue("@publisher_name", txtpublisherName.Text);
            if (dbcon.InsertUpdateData(cmd))
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Th\u00e0nh c\u00f4ng','C\u1eadp nh\u1eadt th\u00e0nh c\u00f4ng','success')", true);
                clrcontrol();
                Bindrecord();
                Autogenrate();
                btnAdd.Visible = true;
                btnupdate.Visible = false;
                btnCancel.Visible = false;
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('L\u1ed7i','L\u1ed7i! kh\u00f4ng th\u1ec3 c\u1eadp nh\u1eadt...vui l\u00f2ng th\u1eed l\u1ea1i','error')", true);
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminHome.aspx");
        }
        public void Autogenrate()
        {
            int r;
            cmd = new SqlCommand("select max(publisher_id)as ID from publisher_tbl", dbcon.GetCon());
            dbcon.OpenCon();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                string d = dr[0].ToString();
                if (d == "")
                {
                    txtpublisherID.Text = "501";
                }
                else
                {
                    r = Convert.ToInt32(dr[0].ToString());
                    r = r + 1;
                    txtpublisherID.Text = r.ToString();
                }
                txtpublisherID.ReadOnly = true;
                 
            }
            dbcon.CloseCon();
        }
        protected void Bindrecord()
        {
            cmd = new SqlCommand("sp_getPublisher", dbcon.GetCon());
            cmd.CommandType = CommandType.StoredProcedure;
            DataTable dt = new DataTable();
            dbcon.OpenCon();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            RptPublisher.DataSource = dt;
            RptPublisher.DataBind();
        }
        protected void insertpublisher()
        {
            cmd = new SqlCommand("sp_InsertPublisher", dbcon.GetCon());
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@publisher_name", txtpublisherName.Text);
            if (dbcon.InsertUpdateData(cmd))
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Th\u00e0nh c\u00f4ng','L\u01b0u th\u00e0nh c\u00f4ng','success')", true);
                clrcontrol();
                Bindrecord();
                Autogenrate();
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('L\u1ed7i','L\u1ed7i! kh\u00f4ng th\u1ec3 th\u00eam b\u1ea3n ghi...vui l\u00f2ng th\u1eed l\u1ea1i','error')", true);
            }
        }

        private void clrcontrol()
        {
            txtpublisherName.Text = txtpublisherID.Text = String.Empty;
            txtpublisherID.Focus();
        }
        protected void SearchRecordBy_ID(string idd)
        {
            cmd = new SqlCommand("sp_getPublisherByID", dbcon.GetCon());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@publisher_id", int.TryParse(idd, out int pid) ? pid : 0);
            dbcon.OpenCon();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            //DataTable dt = new DataTable();
            DataSet ds = new DataSet();
            da.Fill(ds, "dt");
            dbcon.CloseCon();
            if (ds.Tables[0].Rows.Count > 0)
            {                
                txtpublisherID.Text = ds.Tables[0].Rows[0]["publisher_id"].ToString();
                txtpublisherName.Text = ds.Tables[0].Rows[0]["publisher_name"].ToString();
                btnAdd.Visible = false;
                btnupdate.Visible = true;
                btnCancel.Visible = true;
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('L\u1ed7i','Kh\u00f4ng t\u00ecm th\u1ea5y b\u1ea3n ghi, vui l\u00f2ng th\u1eed l\u1ea1i','error')", true);
            }
        }

        protected void RptPublisher_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "edit")
            {
                string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { '&' });
                string id = commandArgs[0];
                SearchRecordBy_ID(id); 
            }
            if (e.CommandName == "delete")
            {
                string id = e.CommandArgument.ToString();
                cmd = new SqlCommand("sp_DeletePublisherByID", dbcon.GetCon());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@publisher_id", Convert.ToInt32(id));
                
                try
                {
                    dbcon.OpenCon();
                    int row = cmd.ExecuteNonQuery();
                    dbcon.CloseCon();
                    if (row > 0)
                    {
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Thành công','Xóa thành công','success')", true);
                        clrcontrol();
                        Bindrecord();
                        Autogenrate();
                        btnAdd.Visible = true;
                        btnupdate.Visible = false;
                    }
                    else
                    {
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Lỗi','Không tìm thấy bản ghi để xóa','error')", true);
                    }
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Lỗi','Không thể xóa. Nhà xuất bản có thể đang liên kết với sách.','error')", true);
                }
                finally
                {
                    dbcon.CloseCon();
                }

            }

        }
    }
}
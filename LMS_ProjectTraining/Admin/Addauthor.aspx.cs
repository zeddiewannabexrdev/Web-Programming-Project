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
        }

        protected string GetDeleteConfirmText()
        {
            return "return confirm('" + LMS_ProjectTraining.LanguageHelper.Get("confirm_delete_msg") + "');";
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            cmd = new SqlCommand("sp_InsertAuthor", dbcon.GetCon());
            cmd.CommandType=System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@author_name",txtAuthorName.Text);
            if(dbcon.InsertUpdateData(cmd))
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Th\u00e0nh c\u00f4ng','L\u01b0u th\u00e0nh c\u00f4ng','success')", true);
                clrcontrol();
                BindRepeater();
                Autogenrate();
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('L\u1ed7i','L\u1ed7i! kh\u00f4ng th\u1ec3 th\u00eam b\u1ea3n ghi...vui l\u00f2ng th\u1eed l\u1ea1i','error')", true);
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
                    txtID.Text = "101";
                }
                else
                {
                    r = Convert.ToInt32(dr[0].ToString());
                    r = r + 1;
                    txtID.Text = r.ToString();
                }
                txtID.ReadOnly = true;
                //txtID.BackColor = System.Drawing.Color.Red;
            }
            dbcon.CloseCon();
        }

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "edit")
            {
                string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { '&' });
                string id = commandArgs[0];
                SearchDataforUpdate(Convert.ToInt32(id));
            }
            else if (e.CommandName =="delete") 
            {
                string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { '&' });
                string id = commandArgs[0];
                cmd = new SqlCommand("DELETE FROM author_tbl WHERE author_id=@ID", dbcon.GetCon());
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@ID", int.TryParse(id, out int authorId) ? authorId : 0);
                if (dbcon.InsertUpdateData(cmd))
                {
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Th\u00e0nh c\u00f4ng','X\u00f3a th\u00e0nh c\u00f4ng','success')", true);
                    clrcontrol();
                    BindRepeater();
                    Autogenrate();
                    btnAdd.Visible = true;
                    btnupdate.Visible = false;
                    btncancel.Visible = false;
                }
                else
                {
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('L\u1ed7i','L\u1ed7i! kh\u00f4ng th\u1ec3 x\u00f3a...vui l\u00f2ng th\u1eed l\u1ea1i','error')", true);
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
            cmd = new SqlCommand("sp_UpdateAuthor", dbcon.GetCon());
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@author_id", int.TryParse(txtID.Text, out int aid) ? aid : 0);
            cmd.Parameters.AddWithValue("@author_name", txtAuthorName.Text);
            if (dbcon.InsertUpdateData(cmd))
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Th\u00e0nh c\u00f4ng','C\u1eadp nh\u1eadt th\u00e0nh c\u00f4ng','success')", true);
                clrcontrol();
                BindRepeater();
                Autogenrate();
                btnAdd.Visible = true;
                btnupdate.Visible = false;
                btncancel.Visible = false;
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('L\u1ed7i','L\u1ed7i! kh\u00f4ng th\u1ec3 c\u1eadp nh\u1eadt...vui l\u00f2ng th\u1eed l\u1ea1i','error')", true);
            }
        }

        protected void btncancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminHome.aspx");
        }
    }
}
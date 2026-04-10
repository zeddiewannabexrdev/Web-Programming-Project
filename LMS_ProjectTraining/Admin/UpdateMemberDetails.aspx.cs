using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LMS_ProjectTraining.Admin
{
    public partial class UpdateMemberDetails : System.Web.UI.Page
    {
        DBConnect dbcon = new DBConnect();
        SqlCommand cmd;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
               BindGridview();
            }
            
            // Translate Buttons
            btnSearchMember.Text = LanguageHelper.Get("btn_search");
            BtnActiveMember.Text = LanguageHelper.Get("btn_active");
            btnPendingMember.Text = LanguageHelper.Get("btn_pending");
            btnDeactiveMember.Text = LanguageHelper.Get("btn_deactive");
            
            // Translate GridView Headers
            if (GridView1.Columns.Count > 0)
            {
                GridView1.Columns[0].HeaderText = LanguageHelper.Get("lbl_member_id");
                GridView1.Columns[1].HeaderText = LanguageHelper.Get("lbl_fullname");
                GridView1.Columns[2].HeaderText = LanguageHelper.Get("lbl_dob");
                GridView1.Columns[3].HeaderText = LanguageHelper.Get("lbl_contact");
                GridView1.Columns[4].HeaderText = LanguageHelper.Get("lbl_email");
                GridView1.Columns[5].HeaderText = LanguageHelper.Get("lbl_state");
                GridView1.Columns[6].HeaderText = LanguageHelper.Get("lbl_city");
                GridView1.Columns[7].HeaderText = LanguageHelper.Get("lbl_pin");
                GridView1.Columns[8].HeaderText = LanguageHelper.Get("lbl_address");
            }
        }

        private void BindGridview()
        {
            cmd = new SqlCommand("sp_getMember_AllRecords", dbcon.GetCon());
            cmd.CommandType = CommandType.StoredProcedure;
            GridView1.DataSource = dbcon.Load_Data(cmd);
            GridView1.DataBind();
        }

        protected void btnSearchMember_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                Search_memberRecord();
            }
        }

        private void Search_memberRecord()
        {
            cmd = new SqlCommand("sp_getMemberByID", dbcon.GetCon());
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@member_id", int.TryParse(txtMemberID.Text.Trim(), out int mid) ? mid : 0);
            dbcon.OpenCon();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    txtFullName.Text = dr.GetValue(0).ToString();
                    txtDOB.Text = dr.GetValue(1).ToString();
                    txtContactNO.Text = dr.GetValue(2).ToString();
                    txtEmail.Text = dr.GetValue(3).ToString();
                    ddlState.SelectedValue = dr.GetValue(4).ToString();
                    txtCity.Text = dr.GetValue(5).ToString();
                    txtPIN.Text = dr.GetValue(6).ToString();
                    txtAddress.Text = dr.GetValue(7).ToString();
                }
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('L\u1ed7i','Kh\u00f4ng t\u00ecm th\u1ea5y b\u1ea3n ghi...vui l\u00f2ng th\u1eed l\u1ea1i','error')", true);
            }
            dbcon.CloseCon();
        }

        protected void BtnActiveMember_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                UpdateMemberStatus_ByID("Active");
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('L\u1ed7i','L\u1ed7i x\u00e1c th\u1ef1c...vui l\u00f2ng th\u1eed l\u1ea1i','error')", true);
            }
        }

        private void UpdateMemberStatus_ByID(string varStatus)
        {
            if (CheckMemberExist_OR_Not())
            {
                SqlCommand cmd = new SqlCommand("sp_UpdateMemberStatus_ByID", dbcon.GetCon());
                cmd.Parameters.Clear();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@member_id", int.TryParse(txtMemberID.Text.Trim(), out int mid) ? mid : 0);
                cmd.Parameters.AddWithValue("@account_status", varStatus);
                dbcon.OpenCon();
                if (cmd.ExecuteNonQuery() > 0)
                {
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Th\u00e0nh c\u00f4ng','Tr\u1ea1ng th\u00e1i th\u00e0nh vi\u00ean \u0111\u00e3 c\u1eadp nh\u1eadt','success')", true);
                }
                else
                {
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('L\u1ed7i','Kh\u00f4ng th\u1ec3 c\u1eadp nh\u1eadt...vui l\u00f2ng th\u1eed l\u1ea1i','error')", true);
                }
                dbcon.CloseCon();
                BindGridview();
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('L\u1ed7i','Kh\u00f4ng t\u00ecm th\u1ea5y b\u1ea3n ghi...vui l\u00f2ng th\u1eed l\u1ea1i','error')", true);
            }
        }

        private bool CheckMemberExist_OR_Not()
        {
            dbcon.OpenCon();
            cmd = new SqlCommand("sp_getMemberByID", dbcon.GetCon());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@member_id", int.TryParse(txtMemberID.Text.Trim(), out int mid) ? mid : 0);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dbcon.CloseCon();
            if (dt.Rows.Count >= 1)
                return true;
            else
                return false;
        }

        protected void btnPendingMember_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                UpdateMemberStatus_ByID("Pending");
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('L\u1ed7i','L\u1ed7i x\u00e1c th\u1ef1c...vui l\u00f2ng th\u1eed l\u1ea1i','error')", true);
            }
        }

        protected void btnDeactiveMember_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                UpdateMemberStatus_ByID("Deactive");
                
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('L\u1ed7i','L\u1ed7i x\u00e1c th\u1ef1c...vui l\u00f2ng th\u1eed l\u1ea1i','error')", true);
            }
        }
        

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            BindGridview();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            BindGridview();
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            BindGridview();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {            
            Label mid = (Label)GridView1.Rows[e.RowIndex].FindControl("lblDisplayID");
            int ID = Convert.ToInt32(mid.Text);

            TextBox updatetxtName=(TextBox)GridView1.Rows[e.RowIndex].FindControl("txtEditName");
            TextBox updatetxtdob = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtEditdob");
            TextBox updatetxtcontact = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtEditContact");
            TextBox updatetxtemail = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtEditEmail");
            DropDownList updateddlstate= (DropDownList)GridView1.Rows[e.RowIndex].FindControl("ddlEditState");
            TextBox updatetxtcity = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtEditcity");
            TextBox updatetxtpincode = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtEditpincode");
            TextBox updatetxtAddress = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtEditAddress");

            cmd =new SqlCommand("sp_UpdateMember_Records", dbcon.GetCon());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@full_name", updatetxtName.Text);
            cmd.Parameters.AddWithValue("@dob", updatetxtdob.Text);
            cmd.Parameters.AddWithValue("@contact_no", updatetxtcontact.Text);
            cmd.Parameters.AddWithValue("@email", updatetxtemail.Text);
            cmd.Parameters.AddWithValue("@state", updateddlstate.SelectedItem.Text);
            cmd.Parameters.AddWithValue("@city", updatetxtcity.Text);
            cmd.Parameters.AddWithValue("@pincode", updatetxtpincode.Text);
            cmd.Parameters.AddWithValue("@full_address", updatetxtAddress.Text);

            cmd.Parameters.AddWithValue("@member_id", ID);
            dbcon.OpenCon();
            cmd.ExecuteNonQuery();
            dbcon.CloseCon();
            GridView1.EditIndex = -1;
            BindGridview();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            Label mid = (Label)GridView1.Rows[e.RowIndex].FindControl("lblDisplayID");
            int ID = Convert.ToInt32(mid.Text);
            cmd = new SqlCommand("sp_DeleteMemberByID", dbcon.GetCon());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();            

            cmd.Parameters.AddWithValue("@member_id", ID);
            dbcon.OpenCon();
            cmd.ExecuteNonQuery();
            dbcon.CloseCon();            
            BindGridview();
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if(e.Row.RowType==DataControlRowType.DataRow && GridView1.EditIndex==e.Row.RowIndex)
            {
                DropDownList ddlEditState_value =(DropDownList) e.Row.FindControl("ddlEditState");
                Label lblstat =(Label) e.Row.FindControl("lblEditState");
                ddlEditState_value.SelectedValue = lblstat.Text;

                
            }
            
        }

        protected void GridView1_DataBound(object sender, EventArgs e)
        {
            for (int i = 0; i <= GridView1.Rows.Count - 1; i++)
            {
                Label lblparent = (Label)GridView1.Rows[i].FindControl("lblDisplayaccStatus");
                if (lblparent.Text == "Active")
                {
                    GridView1.Rows[i].Cells[9].BackColor = Color.Green;
                    lblparent.ForeColor = Color.Black;
                }
                else if (lblparent.Text == "pending")
                {
                    GridView1.Rows[i].Cells[9].BackColor = Color.Yellow;
                    lblparent.ForeColor = Color.Black;

                }
                else if (lblparent.Text == "Deactive")
                {

                    GridView1.Rows[i].Cells[9].BackColor = Color.DarkRed;
                    lblparent.ForeColor = Color.White;
                }

            }
        }
    }
}
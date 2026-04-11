using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LMS_ProjectTraining.Admin
{
    public partial class AdminBookInventory : System.Web.UI.Page
    {
        DBConnect dbcon = new DBConnect();
        SqlCommand cmd;
        static int actual_stock, current_stock, issued_books;
        static string filepath;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                Autogenrate();
                Bind_Author_Publisher();
                BindGridData();
            }
            GridView1.EmptyDataText = "<center><b>" + LMS_ProjectTraining.LanguageHelper.Get("no_data_books") + "</b></center>";
        }

        private void Bind_Author_Publisher()
        {
            cmd = new SqlCommand("spGetAuthor", dbcon.GetCon());
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            ddlAuthor.DataSource = dbcon.Load_Data(cmd);
            ddlAuthor.DataValueField = "author_name";
            ddlAuthor.DataBind();
            ddlAuthor.Items.Insert(0, new ListItem("-- Select --"));

            cmd = new SqlCommand("sp_getPublisher", dbcon.GetCon());
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            ddlPublisherName.DataSource = dbcon.Load_Data(cmd);
            ddlPublisherName.DataValueField = "publisher_name";
            ddlPublisherName.DataBind();
            ddlPublisherName.Items.Insert(0, new ListItem("-- Select --"));
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            
            if (ddlAuthor.SelectedIndex == 0 || ddlPublisherName.SelectedIndex == 0)
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Lỗi', 'Vui lòng chọn Tác giả và Nhà xuất bản', 'error')", true);
                return;
            }
            if(checkDuplicateBook())
            {                
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('L\u1ed7i','S\u00e1ch \u0111\u00e3 t\u1ed3n t\u1ea1i...vui l\u00f2ng d\u00f9ng m\u00e3 s\u00e1ch kh\u00e1c','error')", true);
            }
            else
            {
                AddBooks();
                BindGridData(); ;
            }
        }

        private bool checkDuplicateBook()
        {
            cmd = new SqlCommand("spgetBookBYID", dbcon.GetCon());
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@book_id", int.TryParse(txtBookID.Text.Trim(), out int bid) ? bid : 0);
            DataTable dt2 = new DataTable();
            dt2 = dbcon.Load_Data(cmd);
            if (dt2.Rows.Count >= 1)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {            
            if (ddlAuthor.SelectedIndex == 0 || ddlPublisherName.SelectedIndex == 0)
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Lỗi', 'Vui lòng chọn Tác giả và Nhà xuất bản', 'error')", true);
                return;
            }
            if(checkDuplicateBook())
                UpdateBooks();
            else
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Error','M\u00e3 s\u00e1ch kh\u00f4ng h\u1ee3p l\u1ec7','error')", true);
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (checkDuplicateBook())
                DeleteBooks();
            else
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Error','M\u00e3 s\u00e1ch kh\u00f4ng h\u1ee3p l\u1ec7','error')", true);
        }

        protected void btnGo_Click(object sender, EventArgs e)
        {
            SearchBooks();
        }
        private void AddBooks()
        {
            string genres = "";
            foreach (int i in ListBoxGenre.GetSelectedIndices())
            {
                genres = genres + ListBoxGenre.Items[i] + ",";
            }
            genres = genres.Remove(genres.Length - 1);

            string filepath = "~/book_img/book2.png";
            if (FileUpload1.HasFile)
            {
                string filename = Path.GetFileName(FileUpload1.PostedFile.FileName);
                FileUpload1.SaveAs(Server.MapPath("~/book_img/" + filename));
                filepath = "~/book_img/" + filename;
            }

            cmd = new SqlCommand("sp_Insert_Up_Del_BookInventory", dbcon.GetCon());
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            AddParameter();
            cmd.Parameters.AddWithValue("@StatementType", "Insert");
            cmd.Parameters.AddWithValue("@genre", genres);
            cmd.Parameters.AddWithValue("@book_img_link", filepath);
            if (dbcon.InsertUpdateData(cmd))
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Th\u00e0nh c\u00f4ng','Th\u00eam s\u00e1ch th\u00e0nh c\u00f4ng','success')", true);
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('L\u1ed7i','L\u1ed7i! kh\u00f4ng th\u1ec3 th\u00eam b\u1ea3n ghi...vui l\u00f2ng th\u1eed l\u1ea1i','error')", true);
            }
            ClearControl();
            Autogenrate();
        }
        private void UpdateBooks()
        {
            int A_stock = Convert.ToInt32(txtActualStock.Text.Trim());
            int C_stock= Convert.ToInt32(txtCurrentStock.Text.Trim());
            if(actual_stock== A_stock)
            {

            }
            else
            {
                if(A_stock < actual_stock  )
                {                    
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('L\u1ed7i','S\u1ed1 l\u01b0\u1ee3ng t\u1ed3n kho kh\u00f4ng th\u1ec3 nh\u1ecf h\u01a1n s\u1ed1 s\u00e1ch \u0111\u00e3 cho m\u01b0\u1ee3n','error')", true);
                    return;
                }
                else
                {
                    current_stock = actual_stock - issued_books;
                    txtCurrentStock.Text = C_stock + "";
                }
            }

            string genres = "";
            foreach (int i in ListBoxGenre.GetSelectedIndices())
            {
                genres = genres + ListBoxGenre.Items[i] + ",";
            }
            genres = genres.Remove(genres.Length - 1);

            string F_path = "~/book_img/book2.png";
            if (FileUpload1.HasFile)
            {
                string filename = Path.GetFileName(FileUpload1.PostedFile.FileName);
                FileUpload1.SaveAs(Server.MapPath("~/book_img/" + filename));
                F_path = "~/book_img/" + filename;
            }
            else
            {
                F_path = filepath;
            }
            

            cmd = new SqlCommand("sp_Insert_Up_Del_BookInventory", dbcon.GetCon());
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            //AddParameter();
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@StatementType", "Update");
            cmd.Parameters.AddWithValue("@book_id", int.Parse(txtBookID.Text));
            cmd.Parameters.AddWithValue("@book_name", txtBookName.Text);
            cmd.Parameters.AddWithValue("@author_name", ddlAuthor.SelectedItem.Text);
            cmd.Parameters.AddWithValue("@publisher_name", ddlPublisherName.SelectedItem.Text);
            cmd.Parameters.AddWithValue("@publish_date", txtPublishDate.Text);
            cmd.Parameters.AddWithValue("@language", ddlLanguage.SelectedItem.Text);
            cmd.Parameters.AddWithValue("@edition", txtEdition.Text);
            cmd.Parameters.AddWithValue("@book_cost", txtbookCost.Text);
            cmd.Parameters.AddWithValue("@no_of_pages", txtPages.Text);
            cmd.Parameters.AddWithValue("@book_description", txtBookDesc.Text);
            cmd.Parameters.AddWithValue("@genre", genres);
            cmd.Parameters.AddWithValue("@actual_stock", A_stock);
            cmd.Parameters.AddWithValue("@current_stock", C_stock);
            cmd.Parameters.AddWithValue("@book_img_link", F_path);
            if (dbcon.InsertUpdateData(cmd))
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Th\u00e0nh c\u00f4ng','C\u1eadp nh\u1eadt s\u00e1ch th\u00e0nh c\u00f4ng','success')", true);
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('L\u1ed7i','L\u1ed7i! kh\u00f4ng th\u1ec3 c\u1eadp nh\u1eadt...vui l\u00f2ng th\u1eed l\u1ea1i','error')", true);
            }
            ClearControl();
            Autogenrate();
            BindGridData();
        }
        private void DeleteBooks()
        {
            cmd = new SqlCommand("sp_Insert_Up_Del_BookInventory", dbcon.GetCon());
            cmd.CommandType = System.Data.CommandType.StoredProcedure;            
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@StatementType", "Delete");
            cmd.Parameters.AddWithValue("@book_id", int.TryParse(txtBookID.Text.Trim(), out int bid) ? bid : 0);
            if (dbcon.InsertUpdateData(cmd))
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Th\u00e0nh c\u00f4ng','X\u00f3a s\u00e1ch th\u00e0nh c\u00f4ng','success')", true);
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('L\u1ed7i','L\u1ed7i! kh\u00f4ng th\u1ec3 x\u00f3a...vui l\u00f2ng th\u1eed l\u1ea1i','error')", true);
            }
            ClearControl();
            Autogenrate();
            BindGridData(); 
        }
        public void Autogenrate()
        {
            int r;
            cmd = new SqlCommand("select max(book_id)as ID from book_master_tbl", dbcon.GetCon());
            dbcon.OpenCon();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                string d = dr[0].ToString();
                if (d == "")
                {
                    txtBookID.Text = "101";
                }
                else
                {
                    r = Convert.ToInt32(dr[0].ToString());
                    r = r + 1;
                    txtBookID.Text = r.ToString();
                }
                //txtBookID.ReadOnly = true;

            }
            dbcon.CloseCon();
        }
        private void ClearControl()
        {
            txtBookName.Text = txtActualStock.Text = txtbookCost.Text = txtBookDesc.Text = txtCurrentStock.Text = txtEdition.Text = txtIssuedBooks.Text = txtPages.Text = txtPublishDate.Text = "";
            ddlAuthor.SelectedIndex = -1;
            ddlPublisherName.SelectedIndex = -1;
            FileUpload1.PostedFile.InputStream.Dispose();
            ImgPhoto.ImageUrl = "../Imgs/book1.png";
        }
        public void AddParameter()
        {
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@book_id", int.TryParse(txtBookID.Text, out int bid) ? bid : 0);
            cmd.Parameters.AddWithValue("@book_name", txtBookName.Text);
            cmd.Parameters.AddWithValue("@author_name", ddlAuthor.SelectedItem.Text);
            cmd.Parameters.AddWithValue("@publisher_name", ddlPublisherName.SelectedItem.Text);
            cmd.Parameters.AddWithValue("@publish_date", txtPublishDate.Text);
            cmd.Parameters.AddWithValue("@language", ddlLanguage.SelectedItem.Text);
            cmd.Parameters.AddWithValue("@edition", txtEdition.Text);
            cmd.Parameters.AddWithValue("@book_cost", txtbookCost.Text);
            cmd.Parameters.AddWithValue("@no_of_pages", txtPages.Text);
            cmd.Parameters.AddWithValue("@book_description", txtBookDesc.Text);
            cmd.Parameters.AddWithValue("@actual_stock", int.TryParse(txtActualStock.Text, out int aStock) ? aStock : 0);
            cmd.Parameters.AddWithValue("@current_stock", int.TryParse(txtActualStock.Text, out int cStock) ? cStock : 0);
        }
        private void SearchBooks()
        {
            cmd = new SqlCommand("spgetBookBYID", dbcon.GetCon());
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Clear();            
            cmd.Parameters.AddWithValue("@book_id", int.TryParse(txtBookID.Text.Trim(), out int bid) ? bid : 0);
            DataTable dt2 = new DataTable();
            dt2 = dbcon.Load_Data(cmd);
            if (dt2.Rows.Count >= 1)
            {
                txtBookName.Text = dt2.Rows[0]["book_name"].ToString();
                txtPublishDate.Text = dt2.Rows[0]["publisher_date"].ToString();
                txtEdition.Text = dt2.Rows[0]["edition"].ToString();
                txtbookCost.Text = dt2.Rows[0]["book_cost"].ToString().Trim();
                txtPages.Text = dt2.Rows[0]["no_of_pages"].ToString().Trim();
                txtActualStock.Text = dt2.Rows[0]["actual_stock"].ToString().Trim();
                txtCurrentStock.Text = dt2.Rows[0]["current_stock"].ToString().Trim();
                txtBookDesc.Text = dt2.Rows[0]["book_description"].ToString();
                txtIssuedBooks.Text = "" + (Convert.ToInt32(dt2.Rows[0]["actual_stock"].ToString()) - Convert.ToInt32(dt2.Rows[0]["current_stock"].ToString()));

                ddlLanguage.SelectedValue = dt2.Rows[0]["language"].ToString().Trim();
                ddlPublisherName.SelectedValue = dt2.Rows[0]["publisher_name"].ToString().Trim();
                ddlAuthor.SelectedValue = dt2.Rows[0]["author_name"].ToString().Trim();

                ListBoxGenre.ClearSelection();
                string[] genre = dt2.Rows[0]["genre"].ToString().Trim().Split(',');
                for (int i = 0; i < genre.Length; i++)
                {
                    for (int j = 0; j < ListBoxGenre.Items.Count; j++)
                    {
                        if (ListBoxGenre.Items[j].ToString() == genre[i])
                        {
                            ListBoxGenre.Items[j].Selected = true;

                        }
                    }
                }
                actual_stock = Convert.ToInt32(dt2.Rows[0]["actual_stock"].ToString().Trim());
                current_stock = Convert.ToInt32(dt2.Rows[0]["current_stock"].ToString().Trim());
                issued_books = actual_stock - current_stock;
                filepath = dt2.Rows[0]["book_img_link"].ToString();
               if(filepath!="" || filepath!=null)
                {
                    ImgPhoto.ImageUrl = filepath;
                }
                
            }
            else
            {
                Response.Write("<script>alert('M\u00e3 s\u00e1ch kh\u00f4ng h\u1ee3p l\u1ec7');</script>");
                ClearControl();
            }
        }
        private void BindGridData()
        {
            cmd = new SqlCommand("sp_Insert_Up_Del_BookInventory", dbcon.GetCon());
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@StatementType", "Select");
            GridView1.DataSource = dbcon.Load_Data(cmd);
            GridView1.DataBind();
        }
    }
}
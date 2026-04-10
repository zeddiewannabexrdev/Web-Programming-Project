<%@ Page Title="Book Inventory" Language="C#" MasterPageFile="~/Admin/AdminSite.Master" AutoEventWireup="true" CodeBehind="AdminBookInventory.aspx.cs" Inherits="LMS_ProjectTraining.Admin.AdminBookInventory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../datatable/js/jquery.dataTables.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $(".table").prepend($("<thead></thead>").append($(this).find("tr:first"))).dataTable();
        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-5 font-weight-normal">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col">
                                <center>
                                    <h6><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_book_details") %></h6>
                                </center>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col">
                                <center>
                                    <%--<img id="imgview" src="../Imgs/book1.png" height="90" width="90" alt="" />--%>
                                    <asp:Image ID="ImgPhoto" ImageUrl="../Imgs/book1.png" runat="server" Height="90" Width="90" alt="" />
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <center>
                                    <hr />
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <asp:FileUpload ID="FileUpload1" runat="server" class="form-control" />

                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_book_id") %></label>
                                <div class="form-group">
                                    <div class="input-group">
                                        <asp:TextBox ID="txtBookID" CssClass="form-control" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-8">
                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_book_name") %></label>
                                <div class="form-group">
                                    <div class="input-group">
                                        <asp:TextBox ID="txtBookName" CssClass="form-control" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-4">
                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_language") %></label>
                                <div class="form-group">
                                    <asp:DropDownList class="form-control" ID="ddlLanguage" runat="server">
                                        <asp:ListItem Text="English" Value="English" />
                                        <asp:ListItem Text="Hindi" Value="Hindi" />
                                        <asp:ListItem Text="Marathi" Value="Marathi" />
                                        <asp:ListItem Text="French" Value="French" />
                                        <asp:ListItem Text="German" Value="German" />
                                        <asp:ListItem Text="Urdu" Value="Urdu" />
                                    </asp:DropDownList>
                                </div>

                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_pub_name_in") %></label>
                                <div class="form-group">
                                    <asp:DropDownList class="form-control" ID="ddlPublisherName" runat="server">
                                        <asp:ListItem Text="Publisher 1" Value="Publisher 1" />
                                        <asp:ListItem Text="Publisher 2" Value="Publisher 2" />
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_author_name_in") %></label>
                                <div class="form-group">
                                    <asp:DropDownList class="form-control" ID="ddlAuthor" runat="server">
                                        <asp:ListItem Text="select" Value="select"></asp:ListItem>
                                        <asp:ListItem Text="A1" Value="a1"></asp:ListItem>
                                        <asp:ListItem Text="A2" Value="a2"></asp:ListItem>

                                    </asp:DropDownList>
                                </div>
                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_publish_date") %></label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="txtPublishDate" runat="server" placeholder="Date" TextMode="Date"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_genre") %></label>
                                <div class="form-group">
                                    <asp:ListBox CssClass="form-control" ID="ListBoxGenre" runat="server" SelectionMode="Multiple" Rows="5">
                                        <asp:ListItem Text="Action" Value="Action" />
                                        <asp:ListItem Text="Adventure" Value="Adventure" />
                                        <asp:ListItem Text="Comic Book" Value="Comic Book" />
                                        <asp:ListItem Text="Self Help" Value="Self Help" />
                                        <asp:ListItem Text="Motivation" Value="Motivation" />
                                        <asp:ListItem Text="Healthy Living" Value="Healthy Living" />
                                        <asp:ListItem Text="Wellness" Value="Wellness" />
                                        <asp:ListItem Text="Crime" Value="Crime" />
                                        <asp:ListItem Text="Drama" Value="Drama" />
                                        <asp:ListItem Text="Fantasy" Value="Fantasy" />
                                        <asp:ListItem Text="Horror" Value="Horror" />
                                        <asp:ListItem Text="Poetry" Value="Poetry" />
                                        <asp:ListItem Text="Personal Development" Value="Personal Development" />
                                        <asp:ListItem Text="Romance" Value="Romance" />
                                        <asp:ListItem Text="Science Fiction" Value="Science Fiction" />
                                        <asp:ListItem Text="Suspense" Value="Suspense" />
                                        <asp:ListItem Text="Thriller" Value="Thriller" />
                                        <asp:ListItem Text="Art" Value="Art" />
                                        <asp:ListItem Text="Autobiography" Value="Autobiography" />
                                        <asp:ListItem Text="Encyclopedia" Value="Encyclopedia" />
                                        <asp:ListItem Text="Health" Value="Health" />
                                        <asp:ListItem Text="History" Value="History" />
                                        <asp:ListItem Text="Math" Value="Math" />
                                        <asp:ListItem Text="Textbook" Value="Textbook" />
                                        <asp:ListItem Text="Science" Value="Science" />
                                        <asp:ListItem Text="Travel" Value="Travel" />
                                        <asp:ListItem Text="Programming" Value="Programming" />
                                        <asp:ListItem Text="Computer Science" Value="Computer Science" />
                                    </asp:ListBox>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-4">
                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_edition") %></label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="txtEdition" runat="server" placeholder="Edition"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_book_cost") %></label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="txtbookCost" runat="server" placeholder="Book Cost(per unit)" TextMode="Number"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_pages") %></label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="txtPages" runat="server" placeholder="Pages" TextMode="Number"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-4">
                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_actual_stock") %></label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="txtActualStock" runat="server" placeholder="Actual Stock" TextMode="Number"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_current_stock") %></label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="txtCurrentStock" runat="server" placeholder="Current Stock" TextMode="Number" ReadOnly="True"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_issued_books") %></label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="txtIssuedBooks" runat="server" placeholder="Pages" TextMode="Number" ReadOnly="True"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12">
                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_book_desc") %></label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="txtBookDesc" runat="server" placeholder="Book Description" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-4">
                                <asp:Button ID="btnAdd" class="btn btn-lg btn-block btn-success" runat="server" Text="Add" OnClick="btnAdd_Click" />
                            </div>
                            <div class="col-4">
                                <asp:Button ID="btnUpdate" class="btn btn-lg btn-block btn-warning" runat="server" Text="Update" OnClick="btnUpdate_Click" />
                            </div>
                            <div class="col-4">
                                <asp:Button ID="btnDelete" class="btn btn-lg btn-block btn-danger" runat="server" Text="Delete" OnClick="btnDelete_Click" />
                            </div>
                        </div>

                    </div>

                </div>
                <a href="AdminHome.aspx"><< Back to Home</a><br>
                <br>
            </div>



            <div class="col-md-7">

                <div class="card">

                    <div class="card-body">

                        <div class="row">
                            <div class="col">
                                <center>
                                    <h4><%= LMS_ProjectTraining.LanguageHelper.Get("book_inventory_list") %></h4>
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <hr>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col">
                                <asp:GridView ID="GridView1" CssClass="table table-striped table-bordered" AutoGenerateColumns="false" DataKeyNames="book_id" runat="server">

                                    <Columns>
                                        <asp:TemplateField HeaderText="ID" SortExpression="book_id">
                                            <HeaderTemplate>
                                                <%# LMS_ProjectTraining.LanguageHelper.Get("lbl_book_id") %>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label runat="server" Text='<%# Eval("book_id") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <div class="container-fluid">
                                                    <div class="row">
                                                        <div class="col-lg-10">
                                                            <div class="row">
                                                                <div class="col-12">
                                                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("book_name") %>' Font-Bold="True" Font-Size="X-Large"></asp:Label>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-12">
                                                                    <span><%# LMS_ProjectTraining.LanguageHelper.Get("lbl_author_name_in") %> - </span>
                                                                    <asp:Label ID="Label2" runat="server" Font-Bold="True" Text='<%# Eval("author_name") %>'></asp:Label>
                                                                    &nbsp;| <span><span>&nbsp;</span><%# LMS_ProjectTraining.LanguageHelper.Get("lbl_genre") %> - </span>
                                                                    <asp:Label ID="Label3" runat="server" Font-Bold="True" Text='<%# Eval("genre") %>'></asp:Label>
                                                                    &nbsp;| 
                                                                    <span><%# LMS_ProjectTraining.LanguageHelper.Get("lbl_language") %> -<span>&nbsp;</span>
                                                                        <asp:Label ID="Label4" runat="server" Font-Bold="True" Text='<%# Eval("language") %>'></asp:Label>
                                                                    </span>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-12">
                                                                    <%# LMS_ProjectTraining.LanguageHelper.Get("lbl_pub_name_in") %> -
                                                                    <asp:Label ID="Label5" runat="server" Font-Bold="True" Text='<%# Eval("publisher_name") %>'></asp:Label>
                                                                    &nbsp;| <%# LMS_ProjectTraining.LanguageHelper.Get("lbl_publish_date") %> -
                                                                    <asp:Label ID="Label6" runat="server" Font-Bold="True" Text='<%# Eval("publisher_date") %>'></asp:Label>
                                                                    &nbsp;| <%# LMS_ProjectTraining.LanguageHelper.Get("lbl_pages") %> -
                                                                    <asp:Label ID="Label7" runat="server" Font-Bold="True" Text='<%# Eval("no_of_pages") %>'></asp:Label>
                                                                    &nbsp;| <%# LMS_ProjectTraining.LanguageHelper.Get("lbl_edition") %> -
                                                                    <asp:Label ID="Label8" runat="server" Font-Bold="True" Text='<%# Eval("edition") %>'></asp:Label>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-12">
                                                                    <%# LMS_ProjectTraining.LanguageHelper.Get("lbl_book_cost") %> -
                                                                    <asp:Label ID="Label9" runat="server" Font-Bold="True" Text='<%# Eval("book_cost") %>'></asp:Label>
                                                                    &nbsp;| <%# LMS_ProjectTraining.LanguageHelper.Get("lbl_actual_stock") %> -
                                                                    <asp:Label ID="Label10" runat="server" Font-Bold="True" Text='<%# Eval("actual_stock") %>'></asp:Label>
                                                                    &nbsp;| <%# LMS_ProjectTraining.LanguageHelper.Get("lbl_avail_stock") %> -
                                                                    <asp:Label ID="Label11" runat="server" Font-Bold="True" Text='<%# Eval("current_stock") %>'></asp:Label>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-12">
                                                                    <%# LMS_ProjectTraining.LanguageHelper.Get("lbl_book_desc") %> -
                                                                    <asp:Label ID="Label12" runat="server" Font-Bold="True" Font-Italic="True" Font-Size="Smaller" Text='<%# Eval("book_description") %>'></asp:Label>
                                                                </div>
                                                            </div>

                                                        </div>

                                                        <div class="col-lg-2">
                                                            <asp:Image class="img-fluid" ID="Image1" runat="server" ImageUrl='<%# Eval("book_img_link") %>' />
                                                        </div>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>

                                </asp:GridView>
                            </div>
                        </div>


                    </div>

                </div>

            </div>

        </div>
    </div>
</asp:Content>

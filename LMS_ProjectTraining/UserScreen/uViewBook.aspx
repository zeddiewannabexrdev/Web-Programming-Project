<%@ Page Title="ViewBooks" Language="C#" MasterPageFile="~/UserScreen/User.Master" AutoEventWireup="true" CodeBehind="uViewBook.aspx.cs" Inherits="LMS_ProjectTraining.UserScreen.uViewBook" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../datatable/js/jquery.dataTables.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $(".table").prepend($("<thead></thead>").append($(this).find("tr:first"))).dataTable();
        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                 <asp:GridView ID="GridView1" CssClass="table table-striped table-bordered" AutoGenerateColumns="false" DataKeyNames="book_id" runat="server" EmptyDataText='<%# LMS_ProjectTraining.LanguageHelper.Get("lbl_no_books") %>'>

                                    <Columns>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <%# LMS_ProjectTraining.LanguageHelper.Get("lbl_book_id") %>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label runat="server" Text='<%# Eval("book_id") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <%# LMS_ProjectTraining.LanguageHelper.Get("lbl_book_info") %>
                                            </HeaderTemplate>
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
</asp:Content>

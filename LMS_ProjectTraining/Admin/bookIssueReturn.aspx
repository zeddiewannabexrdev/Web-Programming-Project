<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminSite.Master" AutoEventWireup="true" CodeBehind="bookIssueReturn.aspx.cs" Inherits="LMS_ProjectTraining.Admin.bookIssueReturn" %>

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
            <div class="col-md-5">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col">
                                <center>
                                    <h4><%= LMS_ProjectTraining.LanguageHelper.Get("issue_book_heading") %></h4>
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <center>
                                    <img width="100px" src="../Imgs/Bookk.PNG" />
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <hr>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_member_id") %></label>
                                <div class="form-group">
                                    <asp:TextBox  ID="txtMemID" CssClass="form-control" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="txtMemID" Display="Dynamic" ForeColor="Red" ValidationGroup="S1"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_book_id") %></label>
                                <div class="input-group">
                                    <asp:TextBox ID="txtBookID" class="form-control"  runat="server" placeholder="Mã sách"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*Vui lòng nhập mã sách" ControlToValidate="txtBookID" Display="Dynamic" ForeColor="Red" ValidationGroup="S1"></asp:RequiredFieldValidator>
                                    <asp:Button ID="btnSearch" for="txtBookID" class="btn btn-dark"  runat="server" Text="Tìm" OnClick="btnSearch_Click" ValidationGroup="S1" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_mem_name") %></label>
                                <div class="form-group">
                                    <asp:TextBox ID="txtMemName" CssClass="form-control"  runat="server" ReadOnly="True"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_book_name") %></label>
                                <div class="form-group">
                                    <asp:TextBox ID="txtBookName" CssClass="form-control"  runat="server" placeholder="Tên sách" ReadOnly="True"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_issue_date") %></label>
                                <div class="form-group">
                                    <asp:TextBox ID="txtIssueDate" CssClass="form-control"  runat="server" TextMode="Date"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_due_date") %></label>
                                <div class="form-group">
                                    <asp:TextBox ID="txtDueDate" CssClass="form-control"  runat="server" TextMode="Date"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <asp:Button ID="btnIssue" class="btn btn-lg btn-block btn-primary" runat="server" Text="Cho Mượn" OnClick="btnIssue_Click"  />
                            </div>
                            <div class="col-6">
                                <asp:Button ID="btnReturn" class="btn btn-lg btn-block btn-success" runat="server" Text="Trả Sách" OnClick="btnReturn_Click" />
                            </div>
                        </div>
                    </div>
                </div>
                <a href="AdminHome.aspx"><%= LMS_ProjectTraining.LanguageHelper.Get("back_home") %> </a>
                <br>
                <br>
            </div>

            <div class="col-md-7">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col">
                                <center>
                                    <h4><%= LMS_ProjectTraining.LanguageHelper.Get("issued_books_list") %></h4>
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
                                <asp:GridView class="table table-striped table-bordered table-sm" ID="GridView1" Font-Size="Small" runat="server" AutoGenerateColumns="False" EmptyDataText="Không tìm thấy bản ghi..." OnRowDataBound="GridView1_RowDataBound">
                                    <Columns>
                                        <asp:BoundField DataField="member_id" HeaderText="Mã TV" SortExpression="member_id"></asp:BoundField>
                                        <asp:BoundField DataField="member_name" HeaderText="Tên TV" SortExpression="member_name"></asp:BoundField>
                                        <asp:BoundField DataField="book_id" HeaderText="Mã Sách" SortExpression="book_id"></asp:BoundField>
                                        <asp:BoundField DataField="book_name" HeaderText="Tên Sách" SortExpression="book_name"></asp:BoundField>
                                        <asp:BoundField DataField="issue_date" HeaderText="Ngày Mượn" SortExpression="issue_date"></asp:BoundField>
                                        <asp:BoundField DataField="due_date" HeaderText="Hết Hạn" SortExpression="due_date"></asp:BoundField>
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

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="LMS_ProjectTraining.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Đăng Nhập</title>
    <link rel="shortcut icon" href="LogoImg/logoIcon.ico"/>
    <meta charset="utf-8" />
    <meta name="viewport" content="width-device, initial-scale=1" />

    <%--1-Bootstrap CSS--%>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" />

    <%--2-Datatabel CSS--%>
    <link href="datatable/css/jquery.dataTables.min.css" rel="stylesheet" />

    <%--3-Fontawesome CSS--%>
    <link href="fontawesome/css/all.css" rel="stylesheet" />

    <%--4-Jquery jS--%>
    <script src="bootstrap/js/jquery-3.3.1.slim.min.js"></script>

    <%--5-Popper JS--%>
    <script src="bootstrap/js/popper.min.js"></script>

    <%--6-Bootstrap Js--%>
    <script src="bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <nav class="navbar navbar-expand-sm navbar-dark bg-primary">
                <a class="navbar-brand" href="default.aspx">
                    <img src="LogoImg/logoIcon.ico" alt="logo" width="49" height="49" />Hệ Thống Quản Lý Thư Viện</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="collapsibleNavbar">
                        <li class="nav-item">
                            <a class="nav-link" href="default.aspx"><b><%= LMS_ProjectTraining.LanguageHelper.Get("nav_home") %></b></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#"><b><%= LMS_ProjectTraining.LanguageHelper.Get("nav_about") %></b></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#"><b><%= LMS_ProjectTraining.LanguageHelper.Get("nav_terms") %></b></a>
                        </li>
                    </ul>
                </div>
                <!-- Navbar Right icon -->
                <style>
                    .hover-dropdown:hover > .dropdown-menu {
                        display: block;
                        margin-top: 0;
                    }
                </style>
                <div class="pmd-navbar-right-icon ml-auto d-flex align-items-center">
                    <div class="dropdown hover-dropdown mr-3">
                        <a class="text-white dropdown-toggle" href="#" id="langDropdown" style="text-decoration:none;">
                            🌐 <%= LMS_ProjectTraining.LanguageHelper.Get("nav_language") %>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="langDropdown">
                            <a class="dropdown-item" href="?lang=en">🇬🇧 English</a>
                            <a class="dropdown-item" href="?lang=vi">🇻🇳 Tiếng Việt</a>
                        </div>
                    </div>
                    <a id="signup" class="btn btn-sm btn-primary mr-1" href="SignUp.aspx"><%= LMS_ProjectTraining.LanguageHelper.Get("nav_signup") %></a>
                    <%--<a class="btn btn-sm btn-primary" href="#">Login</a>--%>
                </div>
            </nav>

            <div class="jumbotron text-center alert alert-primary" style="margin-bottom: 0">
                <h1>Hệ Thống Quản Lý Thư Viện</h1>
                <p>Xây dựng cộng đồng. Truyền cảm hứng đọc sách. Mở rộng khả năng tiếp cận sách!</p>
            </div>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-sm-2 border border-info">
                        <h2>Bộ Lọc</h2>

                        <p>Tìm kiếm hàng đầu</p>
                        <ul class="nav nav-pills flex-column">
                            <li class="nav-item">
                                <a class="nav-link active" href="#">Active</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">Link</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">Link</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link disabled" href="#">Disabled</a>
                            </li>
                        </ul>
                        <hr class="d-sm-none"/>
                    </div>
                    <div class="col-sm-10 border border-info">
                        <div class="container mt-3">
                            <h2><%= LMS_ProjectTraining.LanguageHelper.Get("login_panel") %></h2>
                            <br />
                            <!-- Nav tabs -->
                            <ul class="nav nav-tabs">
                                <li class="nav-item">
                                    <a class="nav-link active" data-toggle="tab" href="#home"><%= LMS_ProjectTraining.LanguageHelper.Get("login_user") %></a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" data-toggle="tab" href="#menu1"><%= LMS_ProjectTraining.LanguageHelper.Get("login_admin") %></a>
                                </li>
                            </ul>

                            <!-- Tab panes -->
                            <div class="tab-content">
                                <div id="home" class="container tab-pane active">
                                    <br/>
                                    <h3><%= LMS_ProjectTraining.LanguageHelper.Get("login_user") %></h3>
                                    <p></p>
                                    <!---design login form--->
                                    <div class="container">
                                        <div class="row">
                                            <div class="col-md-6 mx-auto">
                                                <div class="card">
                                                    <div class="card-body">
                                                        <div class="row">
                                                            <div class="col">
                                                                <center>
                                                                    <img width="150" src="LogoImg/user.png" />
                                                                </center>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col">
                                                                <center>
                                                                    <h3>Đăng Nhập Thành Viên</h3>
                                                                </center>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col">
                                                                <hr/>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col">
                                                                <asp:Panel ID="pnlUserLogin" runat="server" DefaultButton="btnLogin">
                                                                    <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_member_id") %></label>
                                                                    <div class="form-group">
                                                                        <asp:TextBox ID="txtMemberID" CssClass="form-control" placeholder="Member ID"  runat="server"></asp:TextBox>
                                                                    </div>

                                                                    <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_password") %></label>
                                                                    <div class="form-group">
                                                                        <asp:TextBox ID="txtPassword" CssClass="form-control" placeholder="Password" TextMode="Password"  runat="server"></asp:TextBox>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <asp:Button ID="btnLogin" CssClass="btn btn-success btn-lg btn-block" runat="server" Text="Login" OnClick="btnLogin_Click" />
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <a href="SignUp.aspx"><input type="button" class="btn btn-info btn-lg btn-block" value="<%= LMS_ProjectTraining.LanguageHelper.Get("btn_signup") %>" /> </a>
                                                                    </div>
                                                                </asp:Panel>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <a href="default.aspx"><%= LMS_ProjectTraining.LanguageHelper.Get("back_home") %></a>
                                            </div>

                                        </div>
                                    </div>

                                    <!----design end--->

                                </div>
                                <div id="menu1" class="container tab-pane fade">
                                    <br/>
                                    <h3>Đăng Nhập Quản Trị</h3>
                                    <p></p>
                                    <!---Admin design login form--->
                                    <div class="container">
                                        <div class="row">
                                            <div class="col-md-6 mx-auto">
                                                <div class="card">
                                                    <div class="card-body">
                                                        <div class="row">
                                                            <div class="col">
                                                                <center>
                                                                    <img width="150" src="LogoImg/admin.png" />
                                                                </center>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col">
                                                                <center>
                                                                    <h3>Đăng Nhập Quản Trị Viên</h3>
                                                                </center>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col">
                                                                <hr/>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col">
                                                                <asp:Panel ID="pnlAdminLogin" runat="server" DefaultButton="btnAdminLogin">
                                                                    <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_admin_id") %></label>
                                                                    <div class="form-group">
                                                                        <asp:TextBox ID="txtAdminID" CssClass="form-control" placeholder="Admin ID"  runat="server"></asp:TextBox>
                                                                    </div>

                                                                    <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_password") %></label>
                                                                    <div class="form-group">
                                                                        <asp:TextBox ID="txtAdminPass" CssClass="form-control" placeholder="Password" TextMode="Password"  runat="server"></asp:TextBox>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <asp:Button ID="btnAdminLogin" CssClass="btn btn-success btn-lg btn-block" runat="server" Text="Admin Login" OnClick="btnAdminLogin_Click" />
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <a href="default.aspx"><input type="button" class="btn btn-info btn-lg btn-block" value="<%= LMS_ProjectTraining.LanguageHelper.Get("btn_signup") %>" /> </a>
                                                                    </div>
                                                                </asp:Panel>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <a href="#"><%= LMS_ProjectTraining.LanguageHelper.Get("back_home") %></a>
                                            </div>

                                        </div>
                                    </div>

                                    <!----Admin design end--->
                                </div>

                            </div>
                        </div>

                        <!---ENd login screen--->
                    </div>
                </div>

            </div>

            <div id="footer2" class="container-fluid">
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-12 text-center">
                        <p style="color: whitesmoke">&copy; <%= LMS_ProjectTraining.LanguageHelper.Get("footer_copyright") %></p>
                    </div>
                </div>
            </div>

        </div>
    </form>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="LMS_ProjectTraining.SignUp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Đăng Ký</title>
    <meta charset="utf-8" />
    <link rel="shortcut icon" href="LogoImg/logoIcon.ico" />
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

    <%--7-sweetalert--%>
    <link href="SweetAlert/Styles/sweetalert.css" rel="stylesheet" />
    <script src="SweetAlert/Scripts/sweetalert.min.js"></script>

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
                    <ul class="navbar-nav">
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
                    <%--<a id="signup" class="btn btn-sm btn-primary" href="#">Sign Up</a>--%>
                    <a class="btn btn-sm btn-primary" href="Login.aspx"><%= LMS_ProjectTraining.LanguageHelper.Get("nav_login") %></a>
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
                        <hr class="d-sm-none">
                    </div>
                    <div class="col-sm-10 border border-info">
                        <%--write your code here--%>

                        <%-- Login screen--%>
                        <div class="container mt-3">
                            <h2><%= LMS_ProjectTraining.LanguageHelper.Get("create_account") %></h2>
                            <br />
                            <!-- Nav tabs -->
                            <ul class="nav nav-tabs">
                                <li class="nav-item">
                                    <a class="nav-link active" data-toggle="tab" href="#signup"><%= LMS_ProjectTraining.LanguageHelper.Get("nav_signup") %></a>
                                </li>

                            </ul>

                            <!-- Tab panes -->
                            <div class="tab-content">
                                <div id="signup" class="container tab-pane active">
                                    <br />
                                    <h3><%= LMS_ProjectTraining.LanguageHelper.Get("nav_signup") %></h3>
                                    <p></p>
                                    <!---design login form--->
                                    <div class="container">
                                        <div class="row">
                                            <div class="col-md-12 mx-auto">
                                                <div class="card">
                                                    <div class="card-body">
                                                        <div class="row">
                                                            <div class="col">
                                                                <center>
                                                                    <img width="150" src="LogoImg/sign_up.png" />
                                                                </center>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col">
                                                                <center>
                                                                    <h3><%= LMS_ProjectTraining.LanguageHelper.Get("signup_member") %></h3>
                                                                </center>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col">
                                                                <hr />
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-4">
                                                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_member_id") %></label>
                                                                <div class="form-group">
                                                                    <asp:TextBox ID="txtMemberID" CssClass="form-control" placeholder="Member ID" runat="server"></asp:TextBox>

                                                                </div>

                                                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_password") %></label>
                                                                <div class="form-group">
                                                                    <asp:TextBox ID="txtPassword" CssClass="form-control" placeholder="Password" TextMode="Password" runat="server"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="txtPassword" Display="Dynamic" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                </div>
                                                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_fullname") %></label>
                                                                <div class="form-group">
                                                                    <asp:TextBox ID="txtFullName" CssClass="form-control" placeholder="Full Name" runat="server"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ControlToValidate="txtFullName" Display="Dynamic" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                </div>
                                                                
                                                                
                                                                
                                                                <%--<div class="form-group">
                                                                    <a href="SignUp.aspx">
                                                                        <input type="button" class="btn btn-info btn-lg btn-block" value="Sign Up" />
                                                                    </a>
                                                                </div>--%>
                                                            </div>
                                                            <div class="col-4">
                                                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_dob") %></label>
                                                                <div class="form-group">
                                                                    <asp:TextBox ID="txtDOB" CssClass="form-control" TextMode="Date" runat="server"></asp:TextBox>
                                                                </div>

                                                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_contact") %></label>
                                                                <div class="form-group">
                                                                    <asp:TextBox ID="txtContactNO" CssClass="form-control" placeholder="Contact No" runat="server"></asp:TextBox>
                                                                </div>
                                                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_email") %></label>
                                                                <div class="form-group">
                                                                    <asp:TextBox ID="txtEmail" CssClass="form-control" placeholder="Email" TextMode="Email" runat="server"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ControlToValidate="txtEmail" Display="Dynamic" ForeColor="#CC0000" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="*" ControlToValidate="txtEmail" Display="Dynamic" ForeColor="#CC0099" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                                                </div>
                                                            </div>
                                                            <div class="col-4">
                                                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_state") %></label>
                                                                <div class="form-group">
                                                                    <asp:DropDownList ID="ddlState" CssClass="form-control" runat="server">
                                                                        <asp:ListItem Text="Select" Value="Select"></asp:ListItem>
                                                                        <asp:ListItem Text="Hà Nội" Value="Hà Nội" />
                                                                        <asp:ListItem Text="TP. Hồ Chí Minh" Value="TP. Hồ Chí Minh" />
                                                                        <asp:ListItem Text="Đà Nẵng" Value="Đà Nẵng" />
                                                                    </asp:DropDownList>
                                                                </div>

                                                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_city") %></label>
                                                                <div class="form-group">
                                                                    <asp:TextBox ID="txtCity" CssClass="form-control" placeholder="City" runat="server"></asp:TextBox>
                                                                </div>
                                                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_pin") %></label>
                                                                <div class="form-group">
                                                                    <asp:TextBox ID="txtPIN" CssClass="form-control" placeholder="Pincode" runat="server"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-12">
                                                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_address") %></label>
                                                                <div class="form-group">
                                                                    <asp:TextBox ID="txtAddress" CssClass="form-control" placeholder="Full Address" runat="server"></asp:TextBox>
                                                                </div>
                                                                
                                                            </div>
                                                            
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-3">
                                                                <div class="form-group">
                                                                    <asp:Button ID="btnSignup" CssClass="btn btn-success btn-lg btn-block" runat="server" Text="Sign Up" OnClick="btnSignup_Click" />
                                                                </div>
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


                            </div>
                        </div>

                        <!---ENd login screen--->

                    </div>
                </div>

            </div>

            <br />
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

<%@ Page Title="userprofile" Language="C#" MasterPageFile="~/UserScreen/User.Master" AutoEventWireup="true" CodeBehind="userprofile.aspx.cs" Inherits="LMS_ProjectTraining.UserScreen.userprofile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col">
                                <center>
                                    <img width="100px" src="../Imgs/user.png" />
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <center>
                                    <h4><%= LMS_ProjectTraining.LanguageHelper.Get("your_profile") %></h4>
                                    <span><%= LMS_ProjectTraining.LanguageHelper.Get("account_status") %></span>
                                    <asp:Label ID="lblStatus" class="badge badge-pill badge-info" runat="server" Text="Your status"></asp:Label>
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
                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_fullname") %></label>
                                <div class="form-group">
                                    <asp:TextBox ID="txtFullName" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_dob") %></label>
                                <div class="form-group">
                                    <asp:TextBox ID="txtDOB" CssClass="form-control" runat="server" placeholder="" TextMode="Date"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_contact") %></label>
                                <div class="form-group">
                                    <asp:TextBox ID="txtContact" CssClass="form-control" runat="server" TextMode="Number"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_email") %></label>
                                <div class="form-group">
                                    <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" TextMode="Email"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_state") %></label>
                                <div class="form-group">
                                    <asp:DropDownList class="form-control" ID="ddlState" runat="server">
                                        <asp:ListItem Text="Select" Value="select" />
                                        <asp:ListItem Text="Andhra Pradesh" Value="Andhra Pradesh" />
                                        <asp:ListItem Text="Arunachal Pradesh" Value="Arunachal Pradesh" />
                                        <asp:ListItem Text="Assam" Value="Assam" />
                                        <asp:ListItem Text="Bihar" Value="Bihar" />
                                        <asp:ListItem Text="Chhattisgarh" Value="Chhattisgarh" />
                                        <asp:ListItem Text="Rajasthan" Value="Rajasthan" />
                                        <asp:ListItem Text="Goa" Value="Goa" />
                                        <asp:ListItem Text="Gujarat" Value="Gujarat" />
                                        <asp:ListItem Text="Haryana" Value="Haryana" />
                                        <asp:ListItem Text="Himachal Pradesh" Value="Himachal Pradesh" />
                                        <asp:ListItem Text="Jammu and Kashmir" Value="Jammu and Kashmir" />
                                        <asp:ListItem Text="Jharkhand" Value="Jharkhand" />
                                        <asp:ListItem Text="Karnataka" Value="Karnataka" />
                                        <asp:ListItem Text="Kerala" Value="Kerala" />
                                        <asp:ListItem Text="Madhya Pradesh" Value="Madhya Pradesh" />
                                        <asp:ListItem Text="Maharashtra" Value="Maharashtra" />
                                        <asp:ListItem Text="Manipur" Value="Manipur" />
                                        <asp:ListItem Text="Meghalaya" Value="Meghalaya" />
                                        <asp:ListItem Text="Mizoram" Value="Mizoram" />
                                        <asp:ListItem Text="Nagaland" Value="Nagaland" />
                                        <asp:ListItem Text="Odisha" Value="Odisha" />
                                        <asp:ListItem Text="Punjab" Value="Punjab" />
                                        <asp:ListItem Text="Rajasthan" Value="Rajasthan" />
                                        <asp:ListItem Text="Sikkim" Value="Sikkim" />
                                        <asp:ListItem Text="Tamil Nadu" Value="Tamil Nadu" />
                                        <asp:ListItem Text="Telangana" Value="Telangana" />
                                        <asp:ListItem Text="Tripura" Value="Tripura" />
                                        <asp:ListItem Text="Uttar Pradesh" Value="Uttar Pradesh" />
                                        <asp:ListItem Text="Uttarakhand" Value="Uttarakhand" />
                                        <asp:ListItem Text="West Bengal" Value="West Bengal" />
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_city") %></label>
                                <div class="form-group">
                                    <asp:TextBox class="form-control" ID="txtCity" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_pin") %></label>
                                <div class="form-group">
                                    <asp:TextBox class="form-control" ID="txtPincode" runat="server" TextMode="Number"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_address") %></label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="txtFullAddress" runat="server" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <center>
                                    <span class="badge badge-pill badge-info"><%= LMS_ProjectTraining.LanguageHelper.Get("login_credentials") %></span>
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_member_id") %></label>
                                <div class="form-group">
                                    <asp:TextBox class="form-control" ID="txtUserID" runat="server" ReadOnly="True"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("old_password") %></label>
                                <div class="form-group">
                                    <asp:TextBox class="form-control" ID="txtOldPassword" runat="server" TextMode="Password" ReadOnly="True"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label><%= LMS_ProjectTraining.LanguageHelper.Get("new_password") %></label>
                                <div class="form-group">
                                    <asp:TextBox class="form-control" ID="txtNewPassword" runat="server" TextMode="Password"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-8 mx-auto">
                                <center>
                                    <div class="form-group">
                                        <asp:Button class="btn btn-primary btn-lg" ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click" />
                                    </div>
                                </center>
                            </div>
                        </div>
                    </div>
                </div>
                <a href="UserHome.aspx"><< Back to Home</a><br>
                <br>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col">
                                <center>
                                    <img width="100px" src="../Imgs/Bookk.PNG" />
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <center>
                                    <h4><%= LMS_ProjectTraining.LanguageHelper.Get("user_report_heading") %></h4>
                                    <asp:Label class="badge badge-pill badge-info" ID="Label2" runat="server" Text='<%# LMS_ProjectTraining.LanguageHelper.Get("user_report_sub") %>'></asp:Label>
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
                                <asp:GridView class="table table-striped table-bordered" ID="GridView1" runat="server" OnRowDataBound="GridView1_RowDataBound"></asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<%@ Page Title="Trang chủ" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="LMS_ProjectTraining._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row">
            <div id="demo" class="carousel slide" data-ride="carousel">
                 <!-- Indicators -->
                <ul class="carousel-indicators">
                    <li data-target="#demo" data-slide-to="0" class="active"></li>
                    <li data-target="#demo" data-slide-to="1"></li>
                    <li data-target="#demo" data-slide-to="2"></li>
                </ul>

                <!-- The slideshow -->
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <img src="SlideImg/lms1.png" alt="Thư viện 1">
                    </div>
                    <div class="carousel-item">
                        <img src="SlideImg/lms2.jpg" alt="Thư viện 2" width="1000" height="575">
                    </div>
                    <div class="carousel-item">
                        <img src="SlideImg/lms3.jpg" alt="Thư viện 3" width="1000" height="575">
                    </div>
                </div>

                <!-- Left and right controls -->
                <a class="carousel-control-prev" href="#demo" data-slide="prev">
                    <span class="carousel-control-prev-icon"></span>
                </a>
                <a class="carousel-control-next" href="#demo" data-slide="next">
                    <span class="carousel-control-next-icon"></span>
                </a>

            </div>
        </div>

        <div class="row">
            <div class="col-sm-12">
                <h2><%= LMS_ProjectTraining.LanguageHelper.Get("home_subtitle") %></h2>
                <h5><%= LMS_ProjectTraining.LanguageHelper.Get("home_update_info") %></h5>
                <div class="fakeimg"><%= LMS_ProjectTraining.LanguageHelper.Get("home_image_alt") %></div>
                <p><%= LMS_ProjectTraining.LanguageHelper.Get("home_about_title") %></p>
                <p><%= LMS_ProjectTraining.LanguageHelper.Get("home_about_desc") %></p>
                <br>
                <h2><%= LMS_ProjectTraining.LanguageHelper.Get("home_service_title") %></h2>
                <h5><%= LMS_ProjectTraining.LanguageHelper.Get("home_service_subtitle") %></h5>
                <div class="fakeimg"><%= LMS_ProjectTraining.LanguageHelper.Get("home_image_alt") %></div>
                <p><%= LMS_ProjectTraining.LanguageHelper.Get("home_service_detail") %></p>
                <p><%= LMS_ProjectTraining.LanguageHelper.Get("home_service_desc") %></p>
            </div>
        </div>

        <div class="row">
            <div class="container">
                <div class="row">
                    <div class="col-sm-4">
                        <div class=" panel panel-primary">
                            <div class="panel-heading"><%= LMS_ProjectTraining.LanguageHelper.Get("home_promo_title") %></div>
                            <div class="card-body">
                                <img src="https://placehold.it/150x80?text=SACH" class="img-responsive" style="width: 100%" alt="Sách">
                            </div>
                            <div class="panel-footer"><%= LMS_ProjectTraining.LanguageHelper.Get("home_promo_desc") %></div>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <div class=" card panel panel-danger">
                            <div class="panel-heading"><%= LMS_ProjectTraining.LanguageHelper.Get("home_latest_title") %></div>
                            <div class="card-body">
                                <img src="https://placehold.it/150x80?text=MOI" class="img-responsive" style="width: 100%" alt="Sách mới">
                            </div>
                            <div class="panel-footer"><%= LMS_ProjectTraining.LanguageHelper.Get("home_latest_desc") %></div>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <div class="panel panel-success">
                            <div class="panel-heading"><%= LMS_ProjectTraining.LanguageHelper.Get("home_event_title") %></div>
                            <div class="card-body">
                                <img src="https://placehold.it/150x80?text=SUKIEN" class="img-responsive" style="width: 100%" alt="Sự kiện">
                            </div>
                            <div class="panel-footer"><%= LMS_ProjectTraining.LanguageHelper.Get("home_event_desc") %></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        
    </div>
</asp:Content>

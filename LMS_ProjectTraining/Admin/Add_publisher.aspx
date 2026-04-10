<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminSite.Master" AutoEventWireup="true" CodeBehind="Add_publisher.aspx.cs" Inherits="LMS_ProjectTraining.Admin.Add_publisher" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row">      
            <div class="col-3 border">
                <div class="row">
                    <div class="col-12">
                        <h4><%= LMS_ProjectTraining.LanguageHelper.Get("add_publisher_heading") %></h4>
                        <div class="form-group">
                            <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_pub_id") %></label>
                            <asp:TextBox ID="txtpublisherID" CssClass="form-control" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ForeColor="Red" runat="server" ErrorMessage="*" ValidationGroup="btn_Save" ControlToValidate="txtpublisherID" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group">
                            <label><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_pub_name") %></label>
                            <asp:TextBox ID="txtpublisherName" CssClass="form-control" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ForeColor="Red" runat="server" ErrorMessage="*" Display="Dynamic" ValidationGroup="btn_Save"  ControlToValidate="txtpublisherName"></asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group">
                        <asp:Button ID="btnAdd" CssClass="btn btn-success" ValidationGroup="btn_Save" runat="server" Text="Add" OnClick="btnAdd_Click" />
                        <asp:Button ID="btnupdate" CssClass="btn btn-info" runat="server" Text="Update" OnClick="btnupdate_Click" />
                        <asp:Button ID="btnCancel" CssClass="btn btn-danger" runat="server" Text="Cancel" OnClick="btnCancel_Click" />
                        </div>
                    </div>
                </div>

            </div>
            <div class="col-9 border">
                <div class="table table-responsive border">
                    <h4><%= LMS_ProjectTraining.LanguageHelper.Get("publisher_list") %></h4>
                    <asp:Repeater ID="RptPublisher" runat="server" OnItemCommand="RptPublisher_ItemCommand">
                    <HeaderTemplate>
                        <table class="table table-bordered table-hover">
                            <thead class="alert-info">
                                <tr>
                                    <th><span><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_pub_id") %></span> </th>
                                    <th><span><%= LMS_ProjectTraining.LanguageHelper.Get("lbl_pub_name") %></span> </th>
                                    <th>&nbsp;</th>
                                </tr>
                            </thead>
                            <tbody>
                      </HeaderTemplate>
                    <ItemTemplate>
                       <tr> 
                           <td><%#Eval("publisher_id") %> </td>
                           <td><%#Eval("publisher_name") %> </td>
                           <td style="width:18%">
                               <asp:LinkButton ID="lnkEdit" class="table-link text-primary" runat="server" CommandArgument='<%#Eval("publisher_id") %>' CommandName="edit" ToolTip="edit record">
                                   <span class="fa-stack">
                                       <i class="fa fa-square  fa-stack-2x"> </i>
                                       <i class="fa fa-pencil fa-stack-1x fa-inverse"></i>

                                   </span>
                               </asp:LinkButton>

                               <asp:LinkButton ID="lnkDelete" class="table-link text-danger" runat="server" CommandArgument='<%#Eval("publisher_id") %>' CommandName="delete" OnClientClick='<%# GetDeleteConfirmText() %>'>
                                   <span class="fa-stack">
                                       <i class="fa fa-square  fa-stack-2x"> </i>
                                       <i class=" fa fa-trash fa-stack-1x fa-inverse"></i>

                                   </span>
                               </asp:LinkButton>
                           </td>
                       </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </tbody>
                        </table>
                    </FooterTemplate>  
                </asp:Repeater>
                </div>
            </div>
        </div> 
    </div>
</asp:Content>

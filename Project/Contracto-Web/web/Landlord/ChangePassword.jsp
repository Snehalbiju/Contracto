<%-- 
    Document   : ChangePassword
    Created on : 7 Feb, 2023, 11:08:41 AM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Change Password</title>
        <%@include file="Header.jsp" %>
        <%
            if (request.getParameter("btn_submit") != null) {
                String cur_pwd = request.getParameter("cur_password");
                String selQry = "select landlord_password from tbl_landlord where landlord_id='" + session.getAttribute("l_id") + "'";
                ResultSet rs = con.selectCommand(selQry);
                if (rs.next()) {
                    if (cur_pwd.equals(rs.getString("landlord_password"))) {
                        if (cur_pwd.equals(request.getParameter("new_password"))) {
        %>
        <script src="../Assets/JS/SweetAlert/PasswordError.js"></script>
        <%
            }
            else if(request.getParameter("new_password").equals(request.getParameter("con_password"))) {
                String upQry = "update tbl_landlord set landlord_password='" + request.getParameter("new_password") + "'"
                        + "where landlord_id='" + session.getAttribute("l_id") + "'";
                if (con.executeCommand(upQry)) {
        %>
        <script src="../Assets/JS/SweetAlert/UpdateSuccess.js"></script>
        <%
            }
        } else {
        %>
        <script src="../Assets/JS/SweetAlert/PasswordMismatch.js"></script>
        <%
                    }
                }
            }
        } 
        %>
        <div class="page-heading">
        <div class="page-title">
            <div class="row">
                <div class="col-12 col-md-6 order-md-1 order-last">
                    <h3>Change Password</h3>
                </div>
                <div class="col-12 col-md-6 order-md-2 order-first">
                    <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="Homepage.jsp">Dashboard</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Change Password</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>

    <div class="row justify-content-center align-items-center">
        <div class="col-md-6 col-sm-6" data-aos="fadeUp"  data-aos-delay="300">
            <form id="form1" class="form-box" name="form1" method="post" action="">
                <div class="table-responsive shadow">
                    <table class="table table-bordered">
                        <tr>
                            <td>Current Password</td>
                            <td>
                                <input class="form-control" type="text" name="cur_password"/>
                            </td>
                        </tr>
                        <tr>
                            <td>New Password</td>
                            <td>
                                <input class="form-control" type="text" name="new_password"/>
                            </td>
                        </tr>
                        <tr>
                            <td>Confirm Password</td>
                            <td>
                                <input class="form-control" type="text" name="con_password"/>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2">
                                <input class="btn btn-primary" type="submit" name="btn_submit"/>
                            </td>
                        </tr>
                    </table>
                </div>
            </form>
        </div>
    </div>
    <%@include file="Footer.jsp" %>
    </body>
</html>

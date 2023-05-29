<%-- 
    Document   : Category
    Created on : 28 Dec, 2022, 1:55:51 PM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Category</title>
        <%@include file="Header.jsp" %>
        <%
            if (request.getParameter("btn_submit") != null) {
                String ins = "insert into tbl_category (category_name)values('" + request.getParameter("txt_category") + "')";
                if (con.executeCommand(ins)) {
        %>
        <script src="../Assets/JS/SweetAlert/InsertSuccess.js"></script>
        <%
        } else {
        %>
        <script src="../Assets/JS/SweetAlert/Error_Alert.js"></script>
        <%
                }
            }
            if (request.getParameter("d_id") != null) {
                String del = "delete from tbl_category where category_id='" + request.getParameter("d_id") + "'";
                if (con.executeCommand(del)) {
        %>
        <script src="../Assets/JS/SweetAlert/DeleteSuccess.js"></script>
        <%
        } else {
        %>
        <script src="../Assets/JS/SweetAlert/Error_Alert.js"></script>
        <%
                }
            }

        %>

    <div class="page-heading">
        <div class="page-title">
            <div class="row">
                <div class="col-12 col-md-6 order-md-1 order-last">
                    <h3>Category</h3>
                </div>
                <div class="col-12 col-md-6 order-md-2 order-first">
                    <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="Homepage.jsp">Dashboard</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Category</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>

    <div class="row justify-content-center align-items-center">
        <div class="col-md-6 col-sm-6" data-aos="zoom-in"  data-aos-delay="300">
            <form id="form1" class="form-box" name="form1" method="post" action="">
                <div class="table-responsive shadow">
                    <table class="table table-bordered">
                        <tr>
                            <td colspan="2" align="center">
                                <h2>Category Entry</h2>
                            </td>
                        </tr>
                        <tr>
                            <td>Category</td>
                            <td>
                                <input type="text" class="form-control" name="txt_category" id="txt_category" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center" class="py-3">
                                <input type="submit" class="btn btn-primary" name="btn_submit" id="btn_submit" value="Submit" />
                                <input type="reset" class="btn btn-outline-primary" name="btn_reset" id="btn_reset" value="Cancel" />
                            </td>
                        </tr>
                    </table>
                </div><br />
            </form>
        </div>
    </div>
    <section class="section">
        <div class="card col-6 mx-auto">
            <div class="card-header">
                Category List
            </div>
            <div class="card-body">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <td>Sl no</td>
                            <td>Category</td>
                            <td>Delete</td>
                            <%                                    int i = 0;
                                String selqry = "select *from tbl_category";
                                ResultSet rs = con.selectCommand(selqry);
                                while (rs.next()) {
                                    i++;

                            %>
                        </tr>
                    </thead>
                    <tr>
                        <td><%=i%></td>
                        <td><% out.print(rs.getString("category_name"));%></td>
                        <td><a class="btn btn-danger" href="Category.jsp?d_id=<%=rs.getInt("category_id")%>">Delete</a></td>
                        <%
                            }
                        %>
                    </tr>    
                </table>
            </div>
        </div>
    </section>
    <%@include file="Footer.jsp" %>
</body>
</html>
<%-- 
    Document   : District
    Created on : 7 Dec, 2022, 2:55:03 PM
    Author     : HP
--%>
<%@page import="java.sql.ResultSet"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>District</title>
        <%@include file="Header.jsp" %>

        <%
            if (request.getParameter("btn_submit") != null) {
                String ins = "insert into tbl_district (district_name)values('" + request.getParameter("txt_dist") + "')";
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
                String delQry = "delete from tbl_district where district_id='" + request.getParameter("d_id") + "'";
                if (con.executeCommand(delQry)) {
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
                    <h3>District</h3>
                </div>
                <div class="col-12 col-md-6 order-md-2 order-first">
                    <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="Homepage.jsp">Dashboard</a></li>
                            <li class="breadcrumb-item active" aria-current="page">District</li>
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
                            <td colspan="2" align="center">
                                <h2>District Entry</h2>
                            </td>
                        </tr>
                        <tr>
                            <td>District</td>
                            <td>
                                <input type="text" class="form-control" name="txt_dist" id="txt_dist" />
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
    <!-- Basic Tables start -->
    <section class="section">
        <div class="card">
            <div class="card-header">
                District List
            </div>
            <div class="card-body">
                <div class="table table-responsive">
                    <table class="table table-striped table-hover" id="table1">
                        <thead>
                            <tr>
                                <td>Sl no</td>
                                <td>Name</td>
                                <td>Delete</td>
                                <%                    int i = 0;
                                    String selqry = "select *from tbl_district";
                                    ResultSet rs = con.selectCommand(selqry);
                                    while (rs.next()) {
                                        i++;

                                %>
                            </tr>
                        </thead>
                        <tr>
                            <td><%=i%></td>
                            <td><% out.print(rs.getString("district_name"));%></td>
                            <td>
                                <a class="btn btn-danger" href="District.jsp?d_id=<%=rs.getInt("district_id")%>">Delete</a>
                            </td>
                            <%
                                }
                            %>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </section>
    <!-- Basic Tables end -->
    <%@include file="Footer.jsp" %>
</body>
</html>

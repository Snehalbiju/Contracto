<%-- 
    Document   : Complaint
    Created on : 20 Feb, 2023, 10:16:05 AM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean> 
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Complaint Page</title>
        <%@include file="Header.jsp" %>
        <%            if (request.getParameter("btn_submit") != null) {
                String insQry = "insert into tbl_complaint (complaint_title,complaint_description,complaint_date,contractor_id) "
                        + "values ('" + request.getParameter("txt_title") + "','" + request.getParameter("txt_description") + "',curdate()," + session.getAttribute("c_id") + ")";

                if (con.executeCommand(insQry)) {
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
                String del = "delete from tbl_complaint where complaint_id='" + request.getParameter("d_id") + "'";
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
                    <h3>Complaints</h3>
                </div>
                <div class="col-12 col-md-6 order-md-2 order-first">
                    <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="Homepage.jsp">Dashboard</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Complaints</li>
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
                                <h1>Complaints</h1>
                            </td>
                        </tr>
                        <tr>
                            <td>Title</td>
                            <td><input class="form-control" type="text" name="txt_title" required/></td>
                        </tr>
                        <tr>
                            <td>Description</td>
                            <td>
                                <textarea class="form-control" name="txt_description" required></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <input class="btn btn-primary" type="submit" name="btn_submit">
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
            </div>
            <div class="card-body">
                <table class="table table-striped" id="table1">
                    <thead>

                        <tr>
                            <td>Sl No</td>
                            <td>Title</td>
                            <td>Description</td>
                            <td>Status</td>
                            <td>Action</td>
            <%                    String selQry = "select *from tbl_complaint c inner join tbl_contractor co on c.contractor_id=co.contractor_id where c.contractor_id='" + session.getAttribute("c_id") + "'";
                ResultSet rs = con.selectCommand(selQry);
                int i = 0;
                while (rs.next()) {
                    i++;
            %>
        </tr>
                    </thead>
                    <tr>
                        <td><%= i%></td>
                        <td><%=rs.getString("complaint_title")%></td>
                        <td><%=rs.getString("complaint_description")%></td>
                        <td>
                            <%
                                if (rs.getInt("complaint_status") == 0) {
                                    out.print("Pending");
                                } else if (rs.getInt("complaint_status") == 1) {
                                    out.print("Replied");
                                }
                            %>
                        </td>
                        <td><a class="btn btn-danger" href="Complaint.jsp?d_id=<%=rs.getString("complaint_id")%>">Delete</a></td>
                        <%
                            }
                        %>
                    </tr>
                </table>
            </div>
        </div>

    </section>
    <!-- Basic Tables end -->
    <%@include file="Footer.jsp" %>
</body>
</html>

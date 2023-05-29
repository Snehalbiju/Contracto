<%-- 
    Document   : Place
    Created on : 7 Dec, 2022, 3:27:12 PM
    Author     : HP
--%>
<%@page import="java.sql.ResultSet"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Place</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="Header.jsp" %>

        <%
            if (request.getParameter("btn_submit") != null) {
                String ins = "insert into tbl_place(place_name,district_id)values('" + request.getParameter("txt_place") + "','" + request.getParameter("sel_district") + "')";
                if (con.executeCommand(ins)) {
        %>
        <script src="../Assets/JS/SweetAlert/Success_Alert.js"></script>
        <%
        } else {
        %>
        <script src="../Assets/JS/SweetAlert/Error_Alert.js"></script>
        <%
                }
            }
            if (request.getParameter("d_id") != null) {
                String delQry = "delete from tbl_place where place_id='" + request.getParameter("d_id") + "'";
                if (con.executeCommand(delQry)) {
        %>
        <script src="../Assets/JS/SweetAlert/Success_Alert.js"></script>
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
                    <h3>Place</h3>
                </div>
                <div class="col-12 col-md-6 order-md-2 order-first">
                    <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="Homepage.jsp">Dashboard</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Place</li>
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
                                <h2>Place Entry</h2>
                            </td>
                        </tr>
                        <tr>
                            <td>District</td>
                            <td>
                                <select name="sel_district" class="form-select" id="sel_district">
                                    <option value="">----Select----</option>
                                    <%                          String selqry = "select *from tbl_district";
                                        ResultSet rs = con.selectCommand(selqry);
                                        while (rs.next()) {
                                    %>
                                    <option value="<%=rs.getInt("district_id")%>">
                                        <% out.print(rs.getString("district_name"));%>
                                    </option>
                                    <%
                                        }
                                    %>
                                </select></td>
                        </tr>
                        <tr>
                            <td>Place</td>
                            <td>
                                <input type="text" class="form-control" name="txt_place" id="txt_place">
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2" class="py-3">
                                <input type="submit" class="btn btn-primary" name="btn_submit" id="btn_submit" value="Submit" />
                                <input type="reset" class="btn btn-outline-primary" name="btn_reset"  id="btn_reset" value="Cancel" />
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
                Place List
            </div>
            <div class="card-body">
                <table class="table table-striped" id="table1">
                    <thead>
                        <tr>
                            <th>Sl no</th>
                            <th>Place</th>
                            <th>District</th>
                            <th>Delete</th>
                            <%
                                int i = 0;
                                String selqry1 = "select *from tbl_district d inner join tbl_place p on p.district_id=d.district_id";
                                ResultSet rs1 = con.selectCommand(selqry1);
                                while (rs1.next()) {
                                    i++;

                            %>
                        </tr>
                    </thead>
                        <tr>
                            <td><%=i%></td>
                            <td><%=rs1.getString("place_name")%></td>
                            <td><% out.print(rs1.getString("district_name"));%></td>
                            <td><a href="Place.jsp?d_id=<%=rs1.getInt("place_id")%>" class="btn btn-danger">Delete</a></td>
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
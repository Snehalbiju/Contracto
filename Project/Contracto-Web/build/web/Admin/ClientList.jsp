<%-- 
    Document   : ViewClient
    Created on : 9 Jan, 2023, 12:18:21 PM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>ClientList</title>
            <%@include file="Header.jsp" %>
            <%
                if (request.getParameter("dID") != null) {
                    String delQry = "delete from tbl_client where client_id='" + request.getParameter("dID") + "'";
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
                    <h3>Client List</h3>
                </div>
                <div class="col-12 col-md-6 order-md-2 order-first">
                    <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="Homepage.jsp">Dashboard</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Client List</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <section class="section">
        <div class="card">
            <div class="card-header">
                Client List
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped table-hover" id="table1" >
                        <thead>
                            <tr>
                                <td>Sl No</td>
                                <td>Name</td>
                                <td>Email</td>
                                <td>Contact</td>
                                <td>Gender</td>
                                <td>Address</td>
                                <td>District</td>
                                <td>Place</td>  
                                <td>Action</td>
                            </tr>
                        </thead>
                        <%
                            int i = 0;
                            String selQry = "select *from tbl_client c inner join tbl_place p on p.place_id=c.place_id "
                                    + "inner join tbl_district d on d.district_id=p.district_id";
                            ResultSet rs = con.selectCommand(selQry);
                            while (rs.next()) {
                                i++;
                        %>
                        <tr>
                            <td><%=i%></td>
                            <td >
                                <a href="ClientProfile.jsp?cliID=<%=rs.getString("client_id")%>">
                                    <div class="avatar avatar-lg">
                                        <img src="../Assets/Files/ClientPhoto/<%=rs.getString("client_photo")%>" alt="">
                                        <span style="text-align: center; padding: 10px 0px 0px 10px">
                                            <%=rs.getString("client_name")%>
                                        </span>
                                    </div>
                                </a>
                            </td>
                            <td><%=rs.getString("client_email")%></td>
                            <td><%=rs.getString("client_contact")%></td>
                            <td><%=rs.getString("client_gender")%></td>
                            <td><%=rs.getString("client_address")%></td>
                            <td><%=rs.getString("district_name")%></td>
                            <td><%=rs.getString("place_name")%></td>
                            <td>
                                <a class="btn btn-danger" href="ClientList.jsp?dID=<%=rs.getInt("client_id")%>">Delete</a>
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
    <%@include file="Footer.jsp" %>
</body>
</html>

<%-- 
    Document   : MyProfile
    Created on : 6 Feb, 2023, 9:22:16 PM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Client Profile</title>
            <link rel="stylesheet" href="../Assets/CSS/bganimation.css">
        <%@include file="Header.jsp" %>

        
    <div class="page-heading">
        <div class="page-title">
            <div class="row">
                <div class="col-12 col-md-6 order-md-1 order-last">
                    <h3>Client Profile</h3>
                </div>
                <div class="col-12 col-md-6 order-md-2 order-first">
                    <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="Homepage.jsp">Dashboard</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Client Profile</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
        
    <%
        String selQry = "select *from tbl_client c inner join tbl_place p on p.place_id=c.place_id "
                + "inner join tbl_district d on d.district_id=p.district_id where client_id='" + request.getParameter("cliID") + "'";
        ResultSet rs = con.selectCommand(selQry);
        while (rs.next()) {
    %>

    

    <section class="section"> 
        
        <div class="row">
            <div class="col-md-4 mb-3">
                <div class="card bg-indigo-indigo-700 h-100 shadow">
                    <div class="card-body">
                        <div class="d-flex flex-column align-items-center text-center">
                            <img src="../Assets/Files/ClientPhoto/<%=rs.getString("client_photo")%>" alt="Admin" class="rounded-circle" width="150">
                            <div class="mt-3">
                                <h4 class="text-white"><%=rs.getString("client_name")%></h4>
                                <p class="text-cyan-cyan-500 font-italic mb-1"><%=rs.getString("client_address")%></p>
                                <p class="text-teal-teal-500 font-size-sm"><%=rs.getString("place_name")%>,<%=rs.getString("district_name")%></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-8 mb-3">
                <div class="card h-100 shadow">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-sm-3">
                                <h6 class="mb-0">Full Name</h6>
                            </div>
                            <div class="col-sm-9 text-secondary">
                                <%=rs.getString("client_name")%>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-sm-3">
                                <h6 class="mb-0">Email</h6>
                            </div>
                            <div class="col-sm-9 text-secondary">
                                <%=rs.getString("client_email")%>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-sm-3">
                                <h6 class="mb-0">Phone</h6>
                            </div>
                            <div class="col-sm-9 text-secondary">
                                <%=rs.getString("client_contact")%>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-sm-3">
                                <h6 class="mb-0">Gender</h6>
                            </div>
                            <div class="col-sm-9 text-secondary">
                                <%=rs.getString("client_gender")%>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-sm-3">
                                <h6 class="mb-0">Address</h6>
                            </div>
                            <div class="col-sm-9 text-secondary">
                                <%=rs.getString("client_address")%>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-sm-3">
                                <h6 class="mb-0">Location</h6>
                            </div>
                            <div class="col-sm-9 text-secondary">
                                <%=rs.getString("place_name")%>, <%=rs.getString("district_name")%>
                            </div>
                        </div>
                        <hr>
                    </div>
                </div>
            </div>
        </div>
        <%
            }
        %>
    </section>

    <%@include file="Footer.jsp" %>
</body>
</html>

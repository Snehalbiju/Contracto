<%-- 
    Document   : ViewWorkRequest
    Created on : 11 Feb, 2023, 11:37:22 AM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>View Work Request</title> 
        <%@include file="Header.jsp" %>
        <%            if (request.getParameter("upID") != null) {
                String workid = null;
                String selQry2 = "select work_id from tbl_workrequest where request_id='" + request.getParameter("upID") + "'";
                ResultSet rs1 = con.selectCommand(selQry2);
                if (rs1.next()) {
                    workid = rs1.getString("work_id");
                    String upQry = "update tbl_work set work_status=2 where work_id='" + workid + "'";
                    con.executeCommand(upQry);
                }
                String upQry2 = "update tbl_workrequest set request_status=1 where request_id='" + request.getParameter("upID") + "'";
                if (con.executeCommand(upQry2)) {
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
                String del = "delete from tbl_workrequest where request_id='" + request.getParameter("d_id") + "'";
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
                    <h3>Your Works</h3>
                </div>
                <div class="col-12 col-md-6 order-md-2 order-first">
                    <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="Homepage.jsp">Dashboard</a></li>
                            <li class="breadcrumb-item active" aria-current="page">View Work Request</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <!-- Basic Tables start -->
    <section class="section">
        <div class="card">
            <div class="card-header">
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-sm table-striped table-hover" id="table1" >
                        <thead>
                            <tr>
                                <th scope="col">Sl No</th>
                                <th scope="col">Contractor</th>
                                <th scope="col">Work Details</th>
                                <th scope="col">Work Photo</th>
                                <th scope="col">Request Details</th>
                                <th scope="col">Status</th>
                                <th scope="col">Action</th>

                                <%
                                    int i = 0;
                                    String selQry = "select *from tbl_workrequest wr inner join tbl_work w on"
                                            + " wr.work_id=w.work_id inner join tbl_contractor c on wr.contractor_id=c.contractor_id "
                                            + "inner join tbl_category ct on w.category_id=ct.category_id where w.client_id=" + session.getAttribute("cli_id") + "";
                                    ResultSet rs = con.selectCommand(selQry);
                                    while (rs.next()) {
                                        i++;
                                %> 
                            </tr>
                        </thead>
                        <tr>
                            <td><%=i%></td>
                            <td>
                                <a href="ContractorProfile.jsp?cID=<%=rs.getString("contractor_id")%>">
                                    <div class="avatar avatar-lg">
                                        <img src="../Assets/Files/ContractorPhoto/<%=rs.getString("contractor_photo")%>" width="60" height="60"
                                             style="border-radius: 50%" alt="">
                                        <span style="text-align: center; padding: 10px 0px 0px 5px">
                                            <%=rs.getString("contractor_name")%>
                                        </span>
                                    </div>
                                </a>
                            </td>
                            <td>
                                Category: <%=rs.getString("category_name")%><br>
                                Details: <%=rs.getString("work_details")%>
                            </td>
                            <td>
                                <img src="../Assets/Files/WorkPhoto/<%=rs.getString("work_photo")%>" width="120" height="60" alt="" data-bs-toggle="modal" data-bs-target="#myModal-<%= rs.getString("work_id")%>">
                                <!-- Create a modal for each image using the image ID -->
                                <div class="modal fade rounded-2" id="myModal-<%= rs.getString("work_id")%>" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Work Photo</h5>
                                            </div>
                                            <div class="modal-body">
                                                <img src="../Assets/Files/WorkPhoto/<%=rs.getString("work_photo")%>" class="img-fluid">
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <%=rs.getString("request_details")%><br>
                                Estimated Time: <%=rs.getString("request_date")%>
                            </td>
                            <td>
                                <%
                                    if (rs.getInt("request_status") == 0) {
                                        out.print("Pending");
                                    } else if (rs.getInt("request_status") == 1) {
                                        out.print("Accepted");
                                    }
                                %>
                            </td>
                            <td>
                                <div class="dropdown dropdown-menu-sm-start">
                                    <a class="btn btn-sm btn-primary" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
                                        <i class="bi bi-three-dots-vertical"></i>
                                    </a>

                                    <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="dropdownMenuLink">
                                        <li>
                                            <a class="dropdown-item" href="ViewWorkRequest.jsp?upID=<%=rs.getInt("request_id")%>">
                                                <i class="bi bi-shield-check"></i> Accept
                                            </a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="ViewWorkRequest.jsp?d_id=<%=rs.getInt("request_id")%>">
                                                <i class="bi bi-shield-x"></i> Delete
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </td>
                        </tr>
                        <%
                            }
                        %>

                    </table>
                </div>
            </div>
        </div>
    </section>
    <!-- Basic Tables end -->
    <%@include file="Footer.jsp" %>

</body>
</html>

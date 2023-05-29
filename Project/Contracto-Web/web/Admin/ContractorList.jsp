<%-- 
    Document   : ViewContractor
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
            <title>Contractor List</title>
        <%@include file="Header.jsp" %>
        <%
            if (request.getParameter("upId") != null) {
                String upQry = "update tbl_contractor set contractor_status=1 where contractor_id='" + request.getParameter("upId") + "'";
                if (con.executeCommand(upQry)) {
        %>
        <script src="../Assets/JS/SweetAlert/UpdateSuccess.js"></script>
        <%
        } else {
        %>
        <script src="../Assets/JS/SweetAlert/Error_Alert.js"></script>
        <%
                }
            }
            if (request.getParameter("rejId") != null) {
                String upQry = "update tbl_contractor set contractor_status=2 where contractor_id='" + request.getParameter("rejId") + "'";
                if (con.executeCommand(upQry)) {
        %>
        <script src="../Assets/JS/SweetAlert/UpdateSuccess.js"></script>
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
                    <h3>Contractor List</h3>
                </div>
                <div class="col-12 col-md-6 order-md-2 order-first">
                    <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="Homepage.jsp">Dashboard</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Contractor List</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>

    <section class="section">
        <div class="card">
            <div class="card-header">
                Contractor List
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
                                <td>Proof</td>
                                <td>Status</td>
                                <td>Action</td>
                            </tr>
                        </thead>
                        <%
                            int i = 0;
                            String selQry = "select *from tbl_contractor c inner join tbl_place p on p.place_id=c.place_id "
                                    + "inner join tbl_district d on d.district_id=p.district_id";
                            ResultSet rs = con.selectCommand(selQry);
                            while (rs.next()) {
                                i++;
                        %>
                        <tr>
                            <td><%=i%></td>
                            <td>
                                <a href="ContractorProfile.jsp?cID=<%=rs.getString("contractor_id")%>">
                                    <div class="avatar avatar-lg">
                                        <img src="../Assets/Files/ContractorPhoto/<%=rs.getString("contractor_photo")%>"  alt="">
                                        <span style="text-align: center; padding: 10px 0px 0px 10px">
                                            <%=rs.getString("contractor_name")%>
                                        </span>
                                    </div>
                                </a>
                            </td>
                            <td><%=rs.getString("contractor_email")%></td>
                            <td><%=rs.getString("contractor_contact")%></td>
                            <td>
                                <img src="../Assets/Files/ContractorProof/<%=rs.getString("contractor_proof")%>" width="120" height="60" alt="" data-bs-toggle="modal" data-bs-target="#myModal-<%= rs.getString("contractor_id")%>">
                                <!-- Create a modal for each image using the image ID -->
                                <div class="modal fade rounded-2" id="myModal-<%= rs.getString("contractor_id")%>" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="staticBackdropLabel">Contractor Proof</h5>
                                            </div>
                                            <div class="modal-body">
                                                <img src="../Assets/Files/ContractorProof/<%=rs.getString("contractor_proof")%>" class="img-fluid">
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                            </td>
                            <td>
                                <%
                                    if (rs.getInt("contractor_status") == 0) {
                                        out.print("Pending");
                                    }
                                    if (rs.getInt("contractor_status") == 1) {
                                        out.print("Approved");
                                    }
                                    if (rs.getInt("contractor_status") == 2) {
                                        out.print("Rejected");
                                    }
                                %>
                            </td>
                            <td>
                                <div class="dropdown">
                                    <a class="btn btn-sm btn-primary" role="button"  data-bs-toggle="dropdown">
                                        <i class="bi bi-three-dots-vertical fa-2x"></i>
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-dark">
                                        <li>
                                            <a class="dropdown-item" href="ContractorList.jsp?upId=<%=rs.getInt("contractor_id")%>">
                                                <i class="bi bi-shield-check"></i> Approve
                                            </a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="ContractorList.jsp?rejId=<%=rs.getInt("contractor_id")%>">
                                                <i class="bi bi-shield-x"></i> Reject
                                            </a>
                                        </li>
                                    </ul>
                                </div>
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
    !-- Initialize the modals using JavaScript -->
    <script>
        $(document).ready(function() {
            $('.modal').modal();
        });
    </script>
</body>
</html>

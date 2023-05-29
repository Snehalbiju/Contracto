<%-- 
    Document   : ComplaintView
    Created on : 20 Feb, 2023, 10:50:20 AM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean> 
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Complaint View</title>
        <%@include file="Header.jsp" %>

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

    <section class="section">
        <div class="accordion accordion-flush" id="accordionExample">
            <div class="accordion-item">
                <h2 class="accordion-header" id="headingOne">
                    <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                        <h5 class="text-red-red-500">Client Complaints</h5>
                    </button>
                </h2>
                <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
                    <div class="accordion-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover" >
                                <thead>
                                    <tr>
                                        <td>Sl No</td>
                                        <td>Title</td>
                                        <td>Description</td>
                                        <td>User</td>
                                        <td>Status</td>
                                        <td>Reply</td>
                                        <%
                                            String selQry = "select *from tbl_complaint c inner join tbl_client cl on c.client_id=cl.client_id";
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
                                        <a href="ClientProfile.jsp?cliID=<%=rs.getString("client_id")%>">
                                            <div class="avatar avatar-lg">
                                                <img src="../Assets/Files/ClientPhoto/<%=rs.getString("client_photo")%>" alt="">
                                            </div>
                                            <span style="text-align: center; padding: 20px 0px 0px 5px">
                                                <%=rs.getString("client_name")%>
                                            </span>
                                        </a>
                                    </td>
                                    <td>
                                        <%
                                            if (rs.getInt("complaint_status") == 0) {
                                                out.print("Pending");
                                            } else if (rs.getInt("complaint_status") == 1) {
                                                out.print("Replied");
                                            }
                                        %>
                                    </td>
                                    <td>
                                        <a class="btn btn-outline-primary" href="ReplyComplaint.jsp?cID=<%=rs.getString("complaint_id")%>">Reply</a>
                                    </td>
                                    <%
                                        }
                                    %>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="accordion-item">
                <h2 class="accordion-header" id="headingTwo">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                        <h5 class="text-red-red-500">Contractor Complaints</h5>
                    </button>
                </h2>
                <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
                    <div class="accordion-body">
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <td>Sl No</td>
                                        <td>Title</td>
                                        <td>Description</td>
                                        <td>User</td>
                                        <td>Status</td>
                                        <td>Reply</td>
                                        <%
                                            String selQry1 = "select *from tbl_complaint c inner join tbl_contractor co on c.contractor_id=co.contractor_id";
                                            ResultSet rs1 = con.selectCommand(selQry1);
                                            int j = 0;
                                            while (rs1.next()) {
                                                j++;
                                        %>
                                    </tr>
                                </thead>
                                <tr>
                                    <td><%= j%></td>
                                    <td><%=rs1.getString("complaint_title")%></td>
                                    <td><%=rs1.getString("complaint_description")%></td>
                                    <td>
                                        <a href="ContractorProfile.jsp?cID=<%=rs1.getString("contractor_id")%>">
                                            <div class="avatar avatar-lg">
                                                <img src="../Assets/Files/ContractorPhoto/<%=rs1.getString("contractor_photo")%>"  alt="">
                                            </div>
                                            <span style="text-align: center; padding: 20px 0px 0px 5px">
                                                <%=rs1.getString("contractor_name")%>
                                            </span>
                                        </a>
                                    </td>
                                    <td>
                                        <%
                                            if (rs1.getInt("complaint_status") == 0) {
                                                out.print("Pending");
                                            } else if (rs1.getInt("complaint_status") == 1) {
                                                out.print("Replied");
                                            }
                                        %>
                                    </td>
                                    <td>
                                        <a class="btn btn-outline-primary" href="ReplyComplaint.jsp?cID=<%=rs1.getString("complaint_id")%>">Reply</a>
                                    </td>
                                    <%
                                        }
                                    %>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="accordion-item">
                <h2 class="accordion-header" id="headingThree">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                        <h5 class="text-red-red-500">Landlord Complaints</h5>
                    </button>
                </h2>
                <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordionExample">
                    <div class="accordion-body">
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <td>Sl No</td>
                                        <td>Title</td>
                                        <td>Description</td>
                                        <td>User</td>
                                        <td>Status</td>
                                        <td>Reply</td>
                                        <%
                                            String selQry2 = "select *from tbl_complaint c inner join tbl_landlord l on c.landlord_id=l.landlord_id";
                                            ResultSet rs2 = con.selectCommand(selQry2);
                                            int k = 0;
                                            while (rs2.next()) {
                                                k++;
                                        %>
                                    </tr>
                                </thead>
                                <tr>
                                    <td><%= k%></td>
                                    <td><%=rs2.getString("complaint_title")%></td>
                                    <td><%=rs2.getString("complaint_description")%></td>
                                    <td>
                                        <a href="LandlordProfile.jsp?lID=<%=rs2.getString("landlord_id")%>">
                                            <div class="avatar avatar-lg">
                                                <img src="../Assets/Files/LandlordPhoto/<%=rs2.getString("landlord_photo")%>"  alt="">
                                            </div>
                                            <span style="text-align: center; padding: 20px 0px 0px 5px">
                                                <%=rs2.getString("landlord_name")%>
                                            </span>
                                        </a>
                                    </td>
                                    <td>
                                        <%
                                            if (rs2.getInt("complaint_status") == 0) {
                                                out.print("Pending");
                                            } else if (rs2.getInt("complaint_status") == 1) {
                                                out.print("Replied");
                                            }
                                        %>
                                    </td>
                                    <td>
                                        <a class="btn btn-outline-primary" href="ReplyComplaint.jsp?cID=<%=rs2.getString("complaint_id")%>">Reply</a>
                                    </td>
                                    <%
                                        }
                                    %>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>


    <%@include file="Footer.jsp" %>
</body>
</html>

<%-- 
    Document   : ViewWorkRequest
    Created on : 18 Feb, 2023, 11:26:18 AM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>View Plot Request</title>
        <%@include file="Header.jsp" %>
        <%            if (request.getParameter("upID") != null) {
                String plotid = null;
                String selQry2 = "select plot_id from tbl_plotbooking where booking_id='" + request.getParameter("upID") + "'";
                ResultSet rs1 = con.selectCommand(selQry2);
                if (rs1.next()) {
                    plotid = rs1.getString("plot_id");
                    String upQry = "update tbl_plot set plot_status=2 where plot_id='" + plotid + "'";
                    con.executeCommand(upQry);
                }
                String upQry2 = "update tbl_plotbooking set payment_status=1 where booking_id='" + request.getParameter("upID") + "'";
                if (con.executeCommand(upQry2)) {
        %>
        <script src="../Assets/JS/SweetAlert/UpdateSuccess.js"></script>
        <%
        } else {
        %>
        <script src="../Assets/JS/SweetAlert/Error_Alert.js"></script>
        <%
                }
            }

            if (request.getParameter("d_id") != null) {
                String del = "delete from tbl_plotbooking where booking_id='" + request.getParameter("d_id") + "'";
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
                    <h3>Plot Request</h3>
                </div>
                <div class="col-12 col-md-6 order-md-2 order-first">
                    <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="Homepage.jsp">Dashboard</a></li>
                            <li class="breadcrumb-item active" aria-current="page">View Plot Request</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <section class="section">
        <div class="card">
            <div class="card-header"></div>
            <div class="card-body">
                <div class="table table-responsive">
                    <table class="table table-striped table-hover" id="table1">
                        <thead>
                        <td>Sl No</td>
                        <td>Details</td>
                        <td>Landmark</td>
                        <td>Advance</td>
                        <td>Place</td>
                        <td>Client</td>
                        <td>Booking date</td>
                        <td>Status</td>
                        <td>Action</td>
                        <%
                            int i = 0;
                            String selQry = "select *from tbl_plotbooking pb inner join tbl_plot pl on pb.plot_id=pl.plot_id "
                                    + "inner join tbl_client c on pb.client_id=c.client_id inner join tbl_place p on "
                                    + "pl.place_id=p.place_id inner join tbl_district d on p.district_id=d.district_id "
                                    + "where pl.landlord_id=" + session.getAttribute("l_id") + "";
                            ResultSet rs = con.selectCommand(selQry);
                            while (rs.next()) {
                                i++;
                        %>
                        </tr>
                        </thead>
                        <tr>
                            <td><%=i%></td>
                            <td><%=rs.getString("plot_details")%></td>
                            <td><%=rs.getString("plot_landmark")%></td>
                            <td><%=rs.getString("advance_amount")%></td>
                            <td><%=rs.getString("place_name")%>,<%=rs.getString("district_name")%></td>
                            <td>
                                <a href="ClientProfile.jsp?cliID=<%=rs.getString("client_id")%>">
                                    <div style="display: flex; justify-content: center;">
                                        <img src="../Assets/Files/ClientPhoto/<%=rs.getString("client_photo")%>" width="60" height="60"
                                             style="border-radius: 50%" alt="">
                                        <span style="text-align: center; padding: 20px 0px 0px 5px">
                                            <%=rs.getString("client_name")%>
                                        </span>
                                    </div>
                                </a>
                            </td>
                            <td><%=rs.getString("booking_date")%></td>
                            <td>
                                <%
                                    if (rs.getInt("plot_status") == 0) {
                                        out.print("Pending");
                                    } else if (rs.getInt("plot_status") == 1) {
                                        out.print("Requseted");
                                    } else if (rs.getInt("plot_status") == 2) {
                                        out.print("Sold");
                                    }
                                %>
                            </td>
                            <td>
                                <a href="ViewPlotRequest.jsp?upID=<%=rs.getInt("booking_id")%>">Accept</a>
                                <a href="ViewPlotRequest.jsp?d_id=<%=rs.getInt("booking_id")%>">Delete</a>
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

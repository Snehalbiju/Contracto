<%-- 
    Document   : ViewRequestedPlot
    Created on : 18 Feb, 2023, 12:12:57 PM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>View Requested Plot</title>
        <%@include file="Header.jsp" %>

    <div class="page-heading">
        <div class="page-title">
            <div class="row">
                <div class="col-12 col-md-6 order-md-1 order-last">
                    <h3>My Plot Request</h3>
                </div>
                <div class="col-12 col-md-6 order-md-2 order-first">
                    <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="Homepage.jsp">Dashboard</a></li>
                            <li class="breadcrumb-item active" aria-current="page">My Plot Request</li>
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
                <div class="table-responsive">
                    <table class="table table-striped table-hover" id="table1" >
                        <thead>
                            <tr>
                                <th>Sl No</th>
                                <th>Landlord</th>
                                <th>Landmark</th>
                                <th>Plot Details</th>
                                <th>Advance</th>
                                <th>Booking Date</th>
                                <th>Request Status</th>
                                <%                    int i = 0;
                                    String selQry = "select *from tbl_plotbooking pb inner join tbl_plot pl on pb.plot_id=pl.plot_id "
                                            + "inner join tbl_landlord l on pl.landlord_id=l.landlord_id inner join "
                                            + "tbl_place p on pl.place_id=p.place_id inner join tbl_district d on "
                                            + "p.district_id=d.district_id where pb.client_id=" + session.getAttribute("cli_id") + "";
                                    ResultSet rs = con.selectCommand(selQry);
                                    while (rs.next()) {
                                        i++;
                                %>
                            </tr>
                        </thead>
                        <tr>
                            <td><%=i%></td>
                            <td>
                                <a href="LandlordProfile.jsp?lID=<%=rs.getString("landlord_id")%>">
                                    <div style="display: flex; justify-content: center;">
                                        <img src="../Assets/Files/LandlordPhoto/<%=rs.getString("landlord_photo")%>" width="60" height="60"
                                             style="border-radius: 50%" alt="">
                                        <span style="text-align: center; padding: 20px 0px 0px 5px">
                                            <%=rs.getString("landlord_name")%>
                                        </span>
                                    </div>
                                </a>
                            </td>
                            <td>
                                <%=rs.getString("plot_landmark")%>
                                <br>
                                District:<%=rs.getString("district_name")%>
                                <br>
                                Place:<%=rs.getString("place_name")%>
                            </td>
                            <td>
                                <%=rs.getString("plot_details")%>
                            </td>
                            <td><%=rs.getString("advance_amount")%></td>
                            <td><%=rs.getString("booking_date")%></td>
                            <td>
                                <%
                                    if (rs.getInt("plot_status") == 1) {
                                        out.print("Requested");
                                    } else if (rs.getInt("plot_status") == 2) {
                                        out.print("Sold");
                                    }
                                %>
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

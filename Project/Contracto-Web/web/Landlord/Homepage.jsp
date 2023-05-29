<%-- 
    Document   : Homepage
    Created on : 9 Jan, 2023, 11:41:31 AM
    Author     : HP
--%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Homepage</title>
        <%@include file="Header.jsp" %>
    <section class="section">
        <div class="page-heading">
            <div class="page-title">
                <h1>Hello <%= session.getAttribute("l_name")%>!</h1>
            </div>
        </div>

        <div class="row">
            <div class="col-12" >
                <div class="row">
                    <div class="col-12 col-xl-8">
                        <div class="card h-100">
                            <div class="card-header">
                                <h4 class="skeleton">My Plots</h4>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <td>Sl No</td>
                                                <td>Details</td>
                                                <td>Landmark</td>
                                                <td>Place</td>
                                                <td>Status</td>
                                                <%
                                                    int i = 0;
                                                    String selqry = "select *from tbl_plot pl inner join tbl_place p on"
                                                            + " pl.place_id=p.place_id inner join tbl_district d on "
                                                            + "p.district_id=d.district_id where pl.landlord_id='" + session.getAttribute("l_id") + "' limit 2";
                                                    ResultSet rs2 = con.selectCommand(selqry);
                                                    while (rs2.next()) {
                                                        i++;
                                                %>
                                            </tr>
                                        </thead>
                                        <tr>
                                            <td><%=i%></td>
                                            <td><%=rs2.getString("plot_details")%></td>
                                            <td>
                                                <%= rs2.getString("plot_landmark")%>
                                            </td>
                                            <td><%=rs2.getString("place_name")%>,<%=rs2.getString("district_name")%></td>
                                            <td>
                                                <%
                                                    if (rs2.getInt("plot_status") == 0) {
                                                        out.print("Pending");
                                                    } else if (rs2.getInt("plot_status") == 1) {
                                                        out.print("Requested");
                                                    } else if (rs2.getInt("plot_status") == 2) {
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
                            <div class="card-footer text-center skeleton">
                                <a class="btn btn-outline-warning" href="PlotRegistration.jsp">View All</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-xl-4">
                        <div class="card h-100">
                            <div class="card-header">
                                <h4 class="text-center skeleton">Settings</h4>
                            </div>
                            <div class="card-body skeleton">
                                <a href="MyProfile.jsp">
                                    <i class="bi bi-person me-3 fa-2x"></i> My Profile
                                </a><hr>
                                <a href="EditProfile.jsp">
                                    <i class="bi bi-pencil-square me-3 fa-2x"></i> Edit Profile
                                </a><hr>
                                <a href="ChangePassword.jsp">
                                    <i class="bi bi-key me-3 fa-2x"></i> Change Password
                                </a><hr>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <%@include file="Footer.jsp" %>
</body>
</html>

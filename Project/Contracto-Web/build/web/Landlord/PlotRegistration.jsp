<%-- 
    Document   : PlotRegistration
    Created on : 12 Feb, 2023, 8:27:36 PM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Plot Registration</title>
        <%@include file="Header.jsp" %>
        <%            if (request.getParameter("btn_submit") != null) {
                String insQry = "insert into tbl_plot (landlord_id,plot_details,plot_landmark,place_id,advance_amount) values "
                        + "('" + session.getAttribute("l_id") + "','" + request.getParameter("txt_details") + "','" + request.getParameter("txt_landmark") + "',"
                        + "'" + request.getParameter("sel_place") + "','" + request.getParameter("txt_advance") + "')";
                
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
                String del = "delete from tbl_plot where plot_id='" + request.getParameter("d_id") + "'";
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
                    <h3>Plot Registration</h3>
                </div>
                <div class="col-12 col-md-6 order-md-2 order-first">
                    <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="Homepage.jsp">Dashboard</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Plot Registration</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <div class="row justify-content-center align-items-center">
        <div class="col-md-6 col-sm-6" data-aos="fadeUp"  data-aos-delay="300">
            <form method="post" class="form-box">
                <div class="table-responsive shadow">
                    <table class="table table-bordered">
                        <tr>
                            <td>Details</td>
                            <td><textarea class="form-control" name="txt_details" rows="5" cols="50" required></textarea></td>
                        </tr>
                        <tr>
                            <td>Landmark</td>
                            <td><input class="form-control" type="text" name="txt_landmark" required></td>
                        </tr>
                        <tr>
                            <td>District</td>
                            <td>
                                <select class="form-select" name="sel_district" id="sel_district" onchange="getPlace(this.value)" required>
                                    <option value="">----Select District----</option>
                                    <%
                                        String selQry = "select *from tbl_district";
                                        ResultSet rs = con.selectCommand(selQry);
                                        while (rs.next()) {
                                    %>
                                    <option value="<%=rs.getInt("district_id")%>">
                                        <% out.print(rs.getString("district_name"));%>
                                    </option>
                                    <%
                                        }
                                    %>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Place</td>
                            <td>
                                <select class="form-select" name="sel_place" id="sel_place" required>
                                    <option value="">----Select District First----</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Advance Amount</td>
                            <td><input class="form-control" type="text" name="txt_advance" required></td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <input type="reset" class="btn btn-danger" name="btn_reset" id="btn_reset" value="Reset">
                                <input type="submit" class="btn btn-primary" name="btn_submit" id="btn_submit" value="Submit" />
                            </td>
                        </tr>
                    </table>
                </div>
            </form><br>
        </div>
    </div>
    <!-- Basic Tables start -->
    <section class="section">
        <div class="card">
            <div class="card-header"></div>
            <div class="card-body">
                <div class="table table-responsive">
                    <table class="table table-striped table-hover" id="table1">
                        <thead>
                            <tr>
                                <td>Sl No</td>
                                <td>Details</td>
                                <td>Landmark</td>
                                <td>Place</td>
                                <td>Status</td>
                                <td>Action</td>
                                <%
                                    int i = 0;
                                    String selqry = "select *from tbl_plot pl inner join tbl_place p on"
                                            + " pl.place_id=p.place_id inner join tbl_district d on "
                                            + "p.district_id=d.district_id where pl.landlord_id='" + session.getAttribute("l_id") + "'";
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
                            <td><a class="btn btn-danger" href="PlotRegistration.jsp?d_id=<%=rs2.getInt("plot_id")%>">Delete</a></td>

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
    <script src="../Assets/jQuery/jQuery.js"></script>
    <script>
                                    function getPlace(did)
                                    {
                                        //alert(did);
                                        $.ajax({
                                            url: "../Assets/AjaxPages/Ajaxplace.jsp?did=" + did,
                                            success: function(html) {
                                                $("#sel_place").html(html);
                                            }
                                        });
                                    }
    </script>
</body>
</html>

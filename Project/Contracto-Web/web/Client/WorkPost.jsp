<%-- 
    Document   : WorkPost
    Created on : 7 Feb, 2023, 12:54:54 PM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Work Post</title>
        <%@include file="Header.jsp" %>
        <%        if (request.getParameter("d_id") != null) {
                String del = "delete from tbl_work where work_id='" + request.getParameter("d_id") + "'";
                if (con.executeCommand(del)) {
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
                    <h3>Post Your Works</h3>
                </div>
                <div class="col-12 col-md-6 order-md-2 order-first">
                    <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="Homepage.jsp">Dashboard</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Work Post</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>

    <div class="row justify-content-center align-items-center">
        <div class="col-md-6 col-sm-6" data-aos="fadeUp"  data-aos-delay="300">
            <form id="form1" method="post" enctype="multipart/form-data" class="form-box" action="../Assets/ActionPages/WorkPostAction.jsp">
                <div class="table-responsive shadow">
                    <table class="table table-bordered">
                        <tr>
                            <td>Category</td>
                            <td>
                                <select class="form-select" name="sel_category" id="sel_category" required>
                                    <option value="">----Select Category----</option>
                                    <%
                                        String selQry = "select *from tbl_category";
                                        ResultSet rs = con.selectCommand(selQry);
                                        while (rs.next()) {
                                    %>
                                    <option value="<%=rs.getInt("category_id")%>">
                                        <% out.print(rs.getString("category_name"));%>
                                    </option>
                                    <%
                                        }
                                    %>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Details</td>
                            <td>
                                <textarea class="form-control" name="txt_details" rows="5" cols="50" placeholder="Exact location &#10;Expected Amount" required></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>Date</td>
                            <td>
                                <input class="form-control" type="date" name="txt_date" min="<%= java.time.LocalDate.now() %>" required/>
                            </td>
                        </tr>
                        <tr>
                            <td>District</td>
                            <td>
                                <select class="form-select" name="sel_district" id="sel_district" onchange="getPlace(this.value)" required>
                                    <option value="">----Select District----</option>
                                    <%
                                        String selQry1 = "select *from tbl_district";
                                        ResultSet rs1 = con.selectCommand(selQry1);
                                        while (rs1.next()) {
                                    %>
                                    <option value="<%=rs1.getInt("district_id")%>">
                                        <% out.print(rs1.getString("district_name"));%>
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
                            <td>Photo</td>
                            <td>
                                <input class="form-control" type="file" name="work_photo" required/>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <input class="btn btn-primary" type="submit" name="btn_submit" />
                            </td>
                        </tr>
                    </table>
                </div>
            </form><br>
        </div>
    </div>
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
                                <td>Category</td>
                                <td>Details</td>
                                <td>Photo</td>
                                <td>Date</td>
                                <td>Status</td>
                                <td>Action</td>
                                <%
                                    int i = 0;
                                    String selqry = "select *from tbl_work w inner join tbl_category c on"
                                            + " w.category_id=c.category_id where client_id='" + session.getAttribute("cli_id") + "'";
                                    ResultSet rs2 = con.selectCommand(selqry);
                                    while (rs2.next()) {
                                        i++;
                                %>
                            </tr>
                        </thead>
                        <tr>
                            <td><%=i%></td>
                            <td><%=rs2.getString("category_name")%></td>
                            <td><%=rs2.getString("work_details")%></td>
                            <td>
                                <img src="../Assets/Files/WorkPhoto/<%=rs2.getString("work_photo")%>" width="120" height="60" alt="" data-bs-toggle="modal" data-bs-target="#myModal-<%= rs2.getString("work_id")%>">
                                <!-- Create a modal for each image using the image ID -->
                                <div class="modal fade rounded-2" id="myModal-<%= rs2.getString("work_id")%>" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Work Photo</h5>
                                            </div>
                                            <div class="modal-body">
                                                <img src="../Assets/Files/WorkPhoto/<%=rs2.getString("work_photo")%>" class="img-fluid">
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                            <td><%=rs2.getString("work_date")%></td>
                            <td>
                                <%
                                    if (rs2.getInt("work_status") == 0) {
                                        out.print("Pending");
                                    } else if (rs2.getInt("work_status") == 1) {
                                        out.print("Requested");
                                    } else if (rs2.getInt("work_status") == 2) {
                                        out.print("Accepted");
                                    }
                                %>
                            </td>
                            <td><a class="btn btn-danger" href="WorkPost.jsp?d_id=<%=rs2.getInt("work_id")%>">Delete</a></td>

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

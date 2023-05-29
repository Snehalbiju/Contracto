<%-- 
    Document   : Homepage
    Created on : 8 Jan, 2023, 8:29:38 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Homepage</title>
        <%@include file="Header.jsp" %>
    <section class="section">
        <div class="page-heading">
            <div class="page-title skeleton">
                <h1>Hello <%= session.getAttribute("cli_name")%>!</h1>
            </div>
        </div>

        <div class="row">
            <div class="col-12" >
                <div class="row">
                    <div class="col-12 col-xl-7">
                        <div class="card h-100">
                            <div class="card-header">
                                <h4 class="skeleton">Recent Works</h4>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-sm table-striped table-hover skeleton" >
                                        <thead>
                                            <tr>
                                                <th scope="col">Contractor</th>
                                                <th scope="col">Work Details</th>
                                                <th scope="col">Work Photo</th>
                                                    <%

                                                        String selQry = "select *from tbl_workrequest wr inner join tbl_work w on"
                                                                + " wr.work_id=w.work_id inner join tbl_contractor c on wr.contractor_id=c.contractor_id "
                                                                + "inner join tbl_category ct on w.category_id=ct.category_id where w.client_id=" + session.getAttribute("cli_id") + " order by wr.request_id desc limit 2";
                                                        ResultSet rs = con.selectCommand(selQry);

                                                        while (rs.next()) {
                                                    %> 
                                            </tr>
                                        </thead>
                                        <tr>
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
                                        </tr>

                                        <%
                                            }
                                        %>

                                    </table>
                                </div>
                            </div>
                            <div class="card-footer text-center skeleton">
                                <a class="btn btn-outline-warning" href="ViewWorkRequest.jsp">View All</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-xl-5">
                        <div class="card h-100">
                            <div class="card-header">
                                <h4 class="text-center skeleton">Messaging</h4>
                            </div>
                            <div class="card-body skeleton">
                                <img src="../Assets/Templates/Homepage/images/messaging.jpg" class="img-fluid rounded-2">
                                <div class="px-4 skeleton">
                                    <a href="Chat.jsp" class='btn btn-block btn-xl btn-outline-primary font-bold mt-3'>Start Conversation</a>
                                </div>
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

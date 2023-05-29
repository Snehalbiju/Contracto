<%-- 
    Document   : ViewAppliedWork
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
            <title>View Requested Works</title>
        <%@include file="Header.jsp" %>

    <div class="page-heading">
        <div class="page-title">
            <div class="row">
                <div class="col-12 col-md-6 order-md-1 order-last">
                    <h3>My Work Request</h3>
                </div>
                <div class="col-12 col-md-6 order-md-2 order-first">
                    <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="Homepage.jsp">Dashboard</a></li>
                            <li class="breadcrumb-item active" aria-current="page">My Work Request</li>
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
                                <td>Sl No</td>
                                <td>Client</td>
                                <td>Category</td>
                                <td>Work Details</td>
                                <td>Work Photo</td>
                                <td>Request Details</td>
                                <td>ECT</td>
                                <td>Request Status</td>
                                <%                    int i = 0;
                                    String selQry = "select *from tbl_workrequest wr inner join tbl_work w on"
                                            + " wr.work_id=w.work_id inner join tbl_client c on w.client_id=c.client_id "
                                            + "inner join tbl_category ct on w.category_id=ct.category_id inner join "
                                            + "tbl_place p on w.place_id=p.place_id inner join tbl_district d "
                                            + "on p.district_id=d.district_id where wr.contractor_id=" + session.getAttribute("c_id") + "";
                                    ResultSet rs = con.selectCommand(selQry);
                                    while (rs.next()) {
                                        i++;
                                %>
                            </tr>
                        </thead>
                        <tr>
                            <td><%=i%></td>
                            <td>
                                <div style="display: flex; justify-content: center;">
                                    <img src="../Assets/Files/ClientPhoto/<%=rs.getString("client_photo")%>" width="60" height="60"
                                         style="border-radius: 50%" alt="">
                                    <span style="text-align: center; padding: 20px 0px 0px 5px">
                                        <%=rs.getString("client_name")%>
                                    </span>
                                </div>
                            </td>
                            <td><%=rs.getString("category_name")%></td>
                            <td>
                                <%=rs.getString("work_details")%>
                                <br>
                                District:<%=rs.getString("district_name")%>
                                <br>
                                Place:<%=rs.getString("place_name")%>
                            </td>
                            <td>
                                <img src="../Assets/Files/WorkPhoto/<%= rs.getString("work_photo")%>" width="120" height="80">
                            </td>
                            <td width='200'><%=rs.getString("request_details")%></td>
                            <td><%=rs.getString("request_date")%></td>
                            <td>
                                <%
                                    if (rs.getInt("request_status") == 0) {
                                        out.print("Pending");
                                    } else if (rs.getInt("request_status") == 1) {
                                        out.print("Accepted");
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

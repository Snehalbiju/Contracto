<%-- 
    Document   : FeedbackView
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
            <title>Feedback View</title>
        <%@include file="Header.jsp" %>

    <div class="page-heading">
        <div class="page-title">
            <div class="row">
                <div class="col-12 col-md-6 order-md-1 order-last">
                    <h3>Feedbacks</h3>
                </div>
                <div class="col-12 col-md-6 order-md-2 order-first">
                    <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="Homepage.jsp">Dashboard</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Feedbacks</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>

    <section class="section">
        <div class="card">
            <div class="card-header">
            </div>
            <div class="card-body">
                <table class="table table-striped" id="table1">
                    <thead>
                        <tr>
                            <td>Sl No</td>
                            <td>Description</td>
                            <td>User</td>

                            <%
                                String selQry = "select *from tbl_feedback f inner join tbl_client cl on f.client_id=cl.client_id";
                                ResultSet rs = con.selectCommand(selQry);
                                int i = 0;
                                while (rs.next()) {
                                    i++;
                            %>
                        </tr>
                    </thead>
                    <tr>
                        <td><%= i%></td>
                        <td><%=rs.getString("feedback_content")%></td>
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
                        <%
                            }
                        %>
                    </tr>
                </table>
            </div>
        </div>

    </section>
    <!-- Basic Tables end -->
    <%@include file="Footer.jsp" %>
</body>
</html>

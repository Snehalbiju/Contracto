<%-- 
    Document   : Homepage
    Created on : 8 Jan, 2023, 8:29:17 PM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Admin Homepage</title>
        <%@include file="Header.jsp" %>
        <%
            String select = "select count(client_id) as count from tbl_client";
            ResultSet r1 = con.selectCommand(select);
            r1.next();
            String client_no = r1.getString("count");

            String select2 = "select count(contractor_id) as count from tbl_contractor";
            ResultSet r2 = con.selectCommand(select2);
            r2.next();
            String con_no = r2.getString("count");

            String select3 = "select count(landlord_id) as count from tbl_landlord";
            ResultSet r3 = con.selectCommand(select3);
            r3.next();
            String lan_no = r3.getString("count");

        %>
    <section class="section">
        <div class="page-heading">
            <div class="page-title">
                <h1 class="skeleton">Hello <%= session.getAttribute("aname")%>!</h1>
            </div>
        </div>

        <div class="row">
            <div class="col-12" >
                <div class="row">
                    <div class="col-6 col-lg-3 col-md-6">
                        <div class="card">
                            <div class="card-body px-4 py-4-5">
                                <div class="row">
                                    <div class="col-md-4 col-lg-12 col-xl-12 col-xxl-5 d-flex justify-content-center ">
                                        <div class="stats-icon purple mb-2 skeleton">
                                            <i class="bi bi-people-fill"></i>
                                        </div>
                                    </div>
                                    <div class="col-md-8 col-lg-12 col-xl-12 col-xxl-7 text-center">
                                        <h6 class="text-muted font-semibold skeleton">Total Clients</h6>
                                        <h6 class="font-extrabold mb-0 skeleton"><%=client_no%></h6>
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-md-12 col-lg-12 col-xl-12 col-xxl-12 text-center skeleton">
                                        <a class="btn btn-sm btn-danger" href="ClientList.jsp">View</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-6 col-lg-3 col-md-6">
                        <div class="card">
                            <div class="card-body px-4 py-4-5">
                                <div class="row">
                                    <div class="col-md-4 col-lg-12 col-xl-12 col-xxl-5 d-flex justify-content-center ">
                                        <div class="stats-icon blue mb-2 skeleton">
                                            <i class="bi bi-people-fill"></i>
                                        </div>
                                    </div>
                                    <div class="col-md-8 col-lg-12 col-xl-12 col-xxl-7 text-center">
                                        <h6 class="text-muted font-semibold skeleton">Total Contractor</h6>
                                        <h6 class="font-extrabold mb-0 skeleton"><%=con_no%></h6>
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-md-12 col-lg-12 col-xl-12 col-xxl-12 text-center skeleton">
                                        <a class="btn btn-sm btn-danger" href="ContractorList.jsp">View</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-6 col-lg-3 col-md-6">
                        <div class="card">
                            <div class="card-body px-4 py-4-5">
                                <div class="row">
                                    <div class="col-md-4 col-lg-12 col-xl-12 col-xxl-5 d-flex justify-content-center ">
                                        <div class="stats-icon green mb-2 skeleton">
                                            <i class="bi bi-people-fill"></i>
                                        </div>
                                    </div>
                                    <div class="col-md-8 col-lg-12 col-xl-12 col-xxl-7 text-center">
                                        <h6 class="text-muted font-semibold skeleton">Total Landlords</h6>
                                        <h6 class="font-extrabold mb-0 skeleton"><%=lan_no%></h6>
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-md-12 col-lg-12 col-xl-12 col-xxl-12 text-center skeleton">
                                        <a class="btn btn-sm btn-danger" href="LandlordList.jsp">View</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-12 col-xl-7">
                <div class="card h-100">
                    <div class="card-header">
                        <h4 class="skeleton">Latest Feedbacks</h4>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover table-lg skeleton">
                                <thead>
                                    <tr>
                                        <th>Name</th>
                                        <th>Comment</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        String select4 = "select *from tbl_feedback f inner join tbl_client cl on f.client_id=cl.client_id order by f.feedback_id desc limit 2";
                                        ResultSet r4 = con.selectCommand(select4);
                                        while (r4.next()) {
                                    %>
                                    <tr>
                                        <td class="col-3">
                                            <a href="ClientProfile.jsp?cliID=<%=r4.getString("client_id")%>">
                                                <div class="avatar avatar-lg">
                                                    <img src="../Assets/Files/ClientPhoto/<%=r4.getString("client_photo")%>" alt="">
                                                </div>
                                                <span style="text-align: center; padding: 20px 0px 0px 5px">
                                                    <%=r4.getString("client_name")%>
                                                </span>
                                            </a>
                                        </td>
                                        <td class="col-auto">
                                            <p class=" mb-0"><%=r4.getString("feedback_content")%></p>
                                        </td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                        <div class="row">
                            <div class="col-12 text-center skeleton">
                                <a class="btn btn-warning" href="FeedbackView.jsp">View All</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 col-xl-5">
                <div class="card h-100">
                    <div class="card-header">
                        <h4 class="skeleton">Users Chart</h4>
                    </div>
                    <div class="card-body">
                        <div id="chart" class="skeleton"></div>
                        <input type="hidden" value="<%=client_no%>" id="client_no">
                        <input type="hidden" value="<%=con_no%>" id="con_no">
                        <input type="hidden" value="<%=lan_no%>" id="lan_no">
                    </div>
                </div>
            </div>
        </div>
    </section>
    <%@include file="Footer.jsp" %>
    <script>
        var cli_no=parseInt(document.getElementById("client_no").value);
        var con_no=parseInt(document.getElementById("con_no").value);
        var lan_no=parseInt(document.getElementById("lan_no").value);
        
        var options = {
            series: [cli_no,con_no,lan_no],
            chart: {
                width: 380,
                type: 'pie',
            },
            labels: ['Clients', 'Contractors', 'Landlords'],
            responsive: [{
                    breakpoint: 480,
                    options: {
                        chart: {
                            width: 200
                        },
                        legend: {
                            position: 'bottom'
                        }
                    }
                }]
        };

        var chart = new ApexCharts(document.querySelector("#chart"), options);
        chart.render();
    </script>
</body>
</html>

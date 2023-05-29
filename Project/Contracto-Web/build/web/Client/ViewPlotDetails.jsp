<%-- 
    Document   : ViewPlotDetails
    Created on : 18 Feb, 2023, 10:43:42 AM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean> 
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>View Plot Details</title>
        <%@include file="Header.jsp" %>
        <%            if (request.getParameter("plID") != null) {
                String selQry = "select * from tbl_plotbooking where plot_id=" + request.getParameter("plID") + " and client_id=" + session.getAttribute("cli_id") + "";
                ResultSet rs1 = con.selectCommand(selQry);
                if (rs1.next()) {
        %>
        <script>
            Swal.fire({
                title: 'Sorry!',
                text: ' You Already booked this plot',
                icon: 'warning',
                timer: 4000,
                backdrop: `rgba(0,0,0,0.2)`,
                confirmButtonText: 'Ok'
              })
            window.location.replace("SearchPlot.jsp");
        </script>
        <%
        } else {
            String upQry = "update tbl_plot set plot_status=1 where plot_id=" + request.getParameter("plID") + "";
            con.executeCommand(upQry);
            String insQry = "insert into tbl_plotbooking (plot_id,client_id,booking_date) "
                    + "values (" + request.getParameter("plID") + "," + session.getAttribute("cli_id") + ",curdate())";
            if (con.executeCommand(insQry)) {
        %>
        <script src="../Assets/JS/SweetAlert/BookingSuccess.js"></script>
        <script>
            window.location.replace("SearchPlot.jsp");
        </script>
        <%
        } else {
        %>
        <script src="../Assets/JS/SweetAlert/Error_Alert.js"></script>
        <script>
            window.location.replace("SearchPlot.jsp");
        </script>
        <%
                    }
                }
            }
        %>

    <div class="page-heading">
        <div class="page-title">
            <div class="row">
                <div class="col-12 col-md-6 order-md-1 order-last">
                    <h3>Plot Details</h3>
                </div>
                <div class="col-12 col-md-6 order-md-2 order-first">
                    <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="Homepage.jsp">Dashboard</a></li>
                            <li class="breadcrumb-item"><a href="SearchPlot.jsp">Search Plot</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Plot Details</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <section class="section">
        <div class="card shadow">
            <div class="card-header"></div>
            <div class="card-body">
                <%
                    String selQry = "select *from tbl_plot pl inner join tbl_landlord l on pl.landlord_id=l.landlord_id inner join "
                            + "tbl_place p on pl.place_id=p.place_id "
                            + "inner join tbl_district d on p.district_id=d.district_id where plot_id=" + request.getParameter("pl_ID") + "";
                    ResultSet rs = con.selectCommand(selQry);

                    while (rs.next()) {
                %>
                <div class="row">
                    <div class="col-12 d-flex flex-column align-items-center">
                        <img src="../Assets/Files/LandlordPhoto/<%=rs.getString("landlord_photo")%>" width="60" height="60"
                             style="border-radius: 50%" alt=""><br>
                        <h4><%=rs.getString("landlord_name")%></h4>
                    </div>
                </div>
                    <hr>
                <div class="row">
                    <div class="col-6 offset-3 ">
                        <p class="font-bold">Details:</p>
                        <p><%=rs.getString("plot_details")%></p>
                    </div>
                </div>
                    <hr>
                <div class="row">
                    <div class="col-6 offset-3">
                        <p class="font-bold">Location:</p>
                        <p><%=rs.getString("plot_landmark")%>,
                        <%=rs.getString("place_name")%>,<%=rs.getString("district_name")%></p>
                    </div>
                </div>
                    <hr>
                <div class="row">
                    <div class="col-6 offset-3">
                        <p class="font-bold">Advance:</p><p> <%=rs.getString("advance_amount")%></p>
                    </div>
                </div>
                    <hr>
                <div class="row">
                    <div class="col-12 text-center">
                        <a class="btn btn-outline-primary" href="ViewPlotDetails.jsp?plID=<%=rs.getString("plot_id")%>">Book</a>
                    </div>
                </div>

                <%
                    }
                %>

            </div>
        </div>
    </section>
    <%@include file="Footer.jsp" %>
</body>
</html>

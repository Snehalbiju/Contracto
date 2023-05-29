<%-- 
    Document   : ViewWork
    Created on : 7 Feb, 2023, 2:53:51 PM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>View Work</title>
            <link rel="stylesheet" href="../Assets/CSS/ZoomPhoto.css">
        <%@include file="Header.jsp" %>
        <%            
        if (request.getParameter("btn_apply") != null) {
        String selQry2="select work_status from tbl_work where work_id='"+request.getParameter("wID")+"'";
        ResultSet r2 = con.selectCommand(selQry2);
        r2.next();
        String workstatus=r2.getString("work_status");
        if(workstatus.equals("2")){
            
        %>
        <script>
            Swal.fire({
                title: 'Sorry!',
                text: ' No longer accepting',
                icon: 'warning',
                timer: 4000,
                backdrop: `rgba(0,0,0,0.2)`,
                confirmButtonText: 'Ok'
              })
            window.location.replace("SearchPlot.jsp");
        </script>
        <%
        } else {
            String selQry1 = "select * from tbl_workrequest where work_id=" + request.getParameter("wID") + " and contractor_id=" + session.getAttribute("c_id") + "";
                ResultSet rs2 = con.selectCommand(selQry1);
                if (rs2.next()) {
                %>
                <script>
                    Swal.fire({
                        title: 'Sorry!',
                        text: ' You Have Already Applied',
                        icon: 'warning',
                        timer: 4000,
                        backdrop: `rgba(0,0,0,0.2)`,
                        confirmButtonText: 'Ok'
                      })
                    window.location.replace("SearchPlot.jsp");
                </script>
                <%
                } else {
            
                    String upQry = "update tbl_work set work_status=1 where work_id='" + request.getParameter("wID") + "'";
                    con.executeCommand(upQry);
                    String insQry = "insert into tbl_workrequest(request_details,work_id,contractor_id,request_date) values"
                            + "('" + request.getParameter("txt_details") + "','" + request.getParameter("wID") + "',"
                            + "'" + session.getAttribute("c_id") + "','" + request.getParameter("txt_date") + "')";
                    if (con.executeCommand(insQry)) {
                %>
        <script src="../Assets/JS/SweetAlert/InsertSuccess.js"></script>
        <script>
            window.location.replace("SearchWork.jsp");
        </script>
                <%
                        }
                    }
                %>
    <div class="page-heading">
        <div class="page-title">
            <div class="row">
                <div class="col-12 col-md-6 order-md-1 order-last">
                    <h3>View Work</h3>
                </div>
                <div class="col-12 col-md-6 order-md-2 order-first">
                    <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="Homepage.jsp">Dashboard</a></li>
                            <li class="breadcrumb-item"><a href="SearchWork.jsp">Search Work</a></li>
                            <li class="breadcrumb-item active" aria-current="page">View Work</li>
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
                    String selQry = "select *from tbl_work w inner join tbl_category c on w.category_id=c.category_id inner join "
                            + "tbl_client cl on w.client_id=cl.client_id inner join tbl_place p on "
                            + "w.place_id=p.place_id inner join tbl_district d on "
                            + "p.district_id=d.district_id where w.work_id='" + request.getParameter("wID") + "'";
                    ResultSet rs = con.selectCommand(selQry);
                    if (rs.next()) {
                %>
                <div class="row">
                    <div class="col-12 d-flex flex-column align-items-center">
                        <img src="../Assets/Files/ClientPhoto/<%=rs.getString("client_photo")%>" width="60" height="60"
                             style="border-radius: 50%" alt=""><br>
                        <h4><%=rs.getString("client_name")%></h4>
                    </div>
                </div>
                <hr>
                <div class="row text-center">
                    <div class="col-6 offset-3 ">
                        <p class="font-bold">Category:</p>
                        <p><%=rs.getString("category_name")%></p>
                    </div>
                </div>
                <hr>                
                <div class="row text-center">
                    <div class="col-6 offset-3 ">
                        <p class="font-bold">Details:</p>
                        <p><%=rs.getString("work_details")%></p>
                    </div>
                </div>
                <hr>
                <div class="row text-center">
                    <div class="col-6 offset-3 ">
                        <p class="font-bold">Place:</p>
                        <p><%=rs.getString("place_name") + ", " + rs.getString("district_name")%></p>
                    </div>
                </div>
                <hr>
                <div class="row text-center">
                    <div class="col-6 offset-3 ">
                        <p class="font-bold">Work Date:</p>
                        <p><%=rs.getString("work_date")%></p>
                    </div>
                </div>
                <hr>
                <div class="row text-center">
                    <div class="col-6 offset-3 ">
                        <img src="../Assets/Files/WorkPhoto/<%=rs.getString("work_photo")%>" width="160" height="80" id="myImg">
                    </div>
                </div>
                <hr>
             
                <div class="row text-center">
                    <div class="col-12 text-center">
                        <a class="btn btn-outline-primary" id="show_applytable">Apply</a>
                    </div>
                </div>

                <%
                    }
                %>
            </div>
        </div>
        <br>
        <form method="post" class="form-box">
            <table class="table shadow-lg rounded-2"id="apply_table">
                <tr>
                    <td>Details</td>
                    <td>
                        <textarea class="form-control" name="txt_details" rows="5" cols="50" placeholder="Estimated Time  &#10;Estimated Amount" required></textarea>
                    </td>
                </tr>
                <tr>
                    <td>Date</td>
                    <td><input class="form-control" type="date" name="txt_date" required></td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <input class="btn btn-danger" type="button" name="btn_cancel" id="btn_cancel" value="Cancel">
                        <input class="btn btn-primary" type="submit" name="btn_apply" id="btn_apply" value="Submit">
                    </td>
                </tr>
            </table>
        </form>
    </section>
    <%@include file="Footer.jsp" %>
    <script src="../Assets/jQuery/jQuery.js"></script>
    <script>
$(document).ready(function() {
    $("#apply_table").hide();
    $("#show_applytable").click(function() {
        $("#apply_table").show();
    });
    $("#btn_apply").click(function() {
        $("#apply_table").hide();
    });
    $("#btn_cancel").click(function() {
        $("#apply_table").hide();
    });
});
    </script>
    <div id="myModal" class="modal">
        <span class="close">&times;</span>
        <img class="modal-content" id="img01">
    </div>
    <script type="text/javascript" src="../Assets/JS/ZoomPhoto.js"></script>
</body>
</html>

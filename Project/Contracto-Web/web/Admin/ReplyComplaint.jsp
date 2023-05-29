<%-- 
    Document   : ReplyComplaint
    Created on : 20 Feb, 2023, 11:31:09 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Reply Complaint</title>
        <%@include file="Header.jsp" %>
        <%
            if (request.getParameter("btn_submit") != null) {
                String upQry = "update tbl_complaint set complaint_reply='" + request.getParameter("txt_reply") + "',complaint_status=1 "
                        + "where complaint_id='" + request.getParameter("cID") + "'";
                if (con.executeCommand(upQry)) {
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
                    <h3>Reply Complaints</h3>
                </div>
                <div class="col-12 col-md-6 order-md-2 order-first">
                    <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="Homepage.jsp">Dashboard</a></li>
                            <li class="breadcrumb-item"><a href="ComplaintView.jsp">Complaints</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Reply Complaints</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <div class="row justify-content-center align-items-center">
        <div class="col-md-6 col-sm-6" data-aos="fadeUp"  data-aos-delay="300">
            <form id="form1" class="form-box" name="form1" method="post" action="">
                <div class="table-responsive shadow">
                    <table class="table table-bordered">
                        <tr>
                            <td align="center" colspan="2">
                                <h1>Reply</h1>   
                            </td>
                        </tr>
                        <tr>
                            <td>Reply</td>
                            <td>
                                <textarea class="form-control" name="txt_reply" required></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2">
                                <input type="submit" class="btn btn-primary" name="btn_submit">
                            </td>
                        </tr>
                    </table>
                </div><br />
            </form>
        </div>
    </div>
    <%@include file="Footer.jsp" %>
    <script>
        $(document).ready(function() {
            var pgurl = window.location.href.substr(window.location.href.lastIndexOf("/") + 1);
            $(".menu li").each(function() {
                if ($('a', this).attr("href") == pgurl || $('a', this).attr("href") == 'ComplaintView.jsp')
                    $(this).addClass("active");
            })
        });
    </script>    
</body>
</html>

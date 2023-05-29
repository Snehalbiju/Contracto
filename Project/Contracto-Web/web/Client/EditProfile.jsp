<%-- 
    Document   : EditProfile
    Created on : 7 Feb, 2023, 9:52:55 AM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Edit Profile</title>
            <link rel="stylesheet" href="../Assets/CSS/fileupload.css">
            <script src="../Assets/jQuery/jQuery.js"></script>
            <script src="../Assets/JS/fileupload.js"></script>
        <%@include file="Header.jsp" %>
    <div class="page-heading">
        <div class="page-title">
            <div class="row">
                <div class="col-12 col-md-6 order-md-1 order-last">
                    <h3>Edit Profile</h3>
                </div>
                <div class="col-12 col-md-6 order-md-2 order-first">
                    <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="Homepage.jsp">Dashboard</a></li>        
                            <li class="breadcrumb-item active" aria-current="page">Edit Profile</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <%        String selQry = "select *from tbl_client c inner join tbl_place p on p.place_id=c.place_id "
                + "inner join tbl_district d on d.district_id=p.district_id where client_id='" + session.getAttribute("cli_id") + "'";
        ResultSet rs = con.selectCommand(selQry);
        while (rs.next()) {
    %>
    <section class="section">
        <div class="card">
            <div class="card-header"></div>
            <div class="card-body">
                <form id="form1" class="form" method="post" enctype="multipart/form-data" action="../Assets/ActionPages/ClientProfileEditAction.jsp">
                    <div class="row">
                        <div class="col-12">
                            <div class="form-group">
                                <div class="avatar-upload">
                                    <div class="avatar-edit">
                                        <input type="file" id="imageUpload" name="file_photo" onchange="readURL(this)"/>
                                        <label for="imageUpload">&#128393;</label>
                                    </div>
                                    <div class="avatar-preview">
                                        <div id="imagePreview" style="background-image: url(../Assets/Files/ClientPhoto/<%=rs.getString("client_photo")%>);">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <hr>
                        <div class="col-md-6 col-12">
                            <div class="form-group">
                                <label for="txt_name" class="form-label">Name</label>
                                <input type="text" class="form-control" name="txt_name" value="<%=rs.getString("client_name")%>"/>

                            </div>
                        </div>
                        <div class="col-md-6 col-12">
                            <div class="form-group">
                                <label for="txt_email" class="form-label">Email</label>
                                <input type="text" class="form-control" name="txt_email" value="<%=rs.getString("client_email")%>"/>

                            </div>
                        </div>
                        <div class="col-md-6 col-12">
                            <div class="form-group">
                                <label for="sel_district" class="form-label">District</label>
                                <select name="sel_district" class="form-select" id="sel_district" onchange="getPlace(this.value)">
                                    <option value="">---Select District---</option>
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
                            </div>
                        </div>
                        <div class="col-md-6 col-12">
                            <div class="form-group">
                                <label for="sel_place" class="form-label">Place</label>                   
                                <select name="sel_place" class="form-select" id="sel_place">
                                    <option value="">----Select District First----</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6 col-12">
                            <div class="form-group">
                                Gender
                            </div>
                        </div>
                        <div class="col-md-6 col-12">
                            <div class="form-group">
                                <div class="form-check form-check-inline">
                                    <label for="rdo_male">
                                        <input type="radio" class="form-check-input" name="rdo_gender" id="rdo_male" value="Male" />Male
                                    </label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <label for="rdo_female">
                                        <input type="radio" name="rdo_gender" class="form-check-input" id="rdo_female" value="Female" />Female
                                    </label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <label for="rdo_others">
                                        <input type="radio" name="rdo_gender" class="form-check-input" id="rdo_others" value="Other" />Other
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-12">
                            <div class="form-group">
                                Address
                            </div>
                        </div>
                        <div class="col-md-6 col-12">
                            <div class="form-group">
                                <textarea name="txt_address" class="form-control" cols="30"><%=rs.getString("client_address")%></textarea>
                            </div>
                        </div>
                        <div class="col-12 text-center">
                            <input class="btn btn-outline-primary" type="reset" name="btn_reset" id="btn_reset" value="Reset">
                            <input type="submit" class="btn btn-primary" name="btn_update" id="btn_update" value="Update" />
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </section>
    <%
        }
    %>
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
    <%@include file="Footer.jsp" %>
</body>
</html>

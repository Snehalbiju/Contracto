<%-- 
    Document   : NewContractor
    Created on : 28 Dec, 2022, 9:38:11 PM
    Author     : HP
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>New Contractor</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">


        <link href="https://fonts.googleapis.com/css?family=Muli:300,400,700,900" rel="stylesheet">
        <link rel="stylesheet" href="../Assets/Templates/Main/fonts/icomoon/style.css">

        <link rel="stylesheet" href="../Assets/Templates/Main/css/bootstrap.min.css">
        <link rel="stylesheet" href="../Assets/Templates/Main/css/jquery-ui.css">
        <link rel="stylesheet" href="../Assets/Templates/Main/css/owl.carousel.min.css">
        <link rel="stylesheet" href="../Assets/Templates/Main/css/owl.theme.default.min.css">
        <link rel="stylesheet" href="../Assets/Templates/Main/css/owl.theme.default.min.css">

        <link rel="stylesheet" href="../Assets/Templates/Main/css/jquery.fancybox.min.css">

        <link rel="stylesheet" href="../Assets/Templates/Main/css/bootstrap-datepicker.css">

        <link rel="stylesheet" href="../Assets/Templates/Main/fonts/flaticon/font/flaticon.css">

        <link rel="stylesheet" href="../Assets/Templates/Main/css/aos.css">

        <link rel="stylesheet" href="../Assets/Templates/Main/css/style.css">
        <link rel="icon" href="../Assets/Templates/Homepage/images/logo/cover.png" type="image/x-icon"> 


    </head>

    <body data-spy="scroll" data-target=".site-navbar-target" data-offset="300">

        <div class="site-wrap">
            <div class="intro-section">
                    <div class="slide-1" style="background-image: url('../Assets/Templates/Main/images/bgimg-1.jpg');" data-stellar-background-ratio="0.5">
                        <div class="container-fluid">
                            <div class="row">
                                <div class="col-1" >
                                    <div class="ml-3">
                                        <h3><a href="Login.jsp">Back</a></h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="container-fluid">
                            <div class="row match-height">
                                <div class="col-md-6 col-12 mx-auto" >
                                    <div class="card bg-dark">
                                        <div class="card-header">
                                            <h2 class="card-title text-center">Contractor Registration</h2>
                                        </div>
                                        <div class="card-content">
                                            <div class="card-body">
                                                <form id="form1" class="form-box bg-dark needs-validation" novalidate method="post" enctype="multipart/form-data" action="../Assets/ActionPages/ContractorAction.jsp">
                                                    <div class="form-body">
                                                        <div class="row">
                                                            <div class="col-md-4">
                                                                <label>Name</label>
                                                            </div>
                                                            <div class="col-md-8 form-group">
                                                                <input type="text" class="form-control" name="txt_name" id="txt_name" pattern="^[A-Z]+[a-zA-Z ]*$" required/>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <label>Email</label>
                                                            </div>
                                                            <div class="col-md-8 form-group">
                                                                <input type="email" class="form-control" name="txt_email" id="txt_email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$" required/>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <label>Contact</label>
                                                            </div>
                                                            <div class="col-md-8 form-group">
                                                                <input type="text" class="form-control" name="txt_contact" id="txt_contact" pattern="[7-9]{1}[0-9]{9}" required/>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <label>Gender</label>
                                                            </div>
                                                            <div class="col-md-8 form-group">
                                                                <div class="form-check form-check-inline">
                                                                    <label for="rdo_male">
                                                                        <input type="radio" class="form-check-input" name="rdo_gender" id="rdo_male" value="Male" required checked/>Male
                                                                    </label>
                                                                </div>
                                                                <div class="form-check form-check-inline">
                                                                    <label for="rdo_female">
                                                                        <input type="radio" class="form-check-input" name="rdo_gender" id="rdo_female" value="Female" required />Female
                                                                    </label>
                                                                </div>
                                                                <div class="form-check form-check-inline">
                                                                    <label for="rdo_others">
                                                                        <input type="radio" class="form-check-input" name="rdo_gender" id="rdo_others" value="Other" required />Other
                                                                    </label>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <label>District</label>
                                                            </div>
                                                            <div class="col-md-8 form-group">
                                                                <select class="form-control" name="sel_district" id="sel_district" onchange="getPlace(this.value)" required>
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
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label>Place</label>
                                                        </div>
                                                        <div class="col-md-8 form-group">
                                                            <select class="form-control" name="sel_place" id="sel_place" required>
                                                                <option value="">----Select District First----</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label>Address</label>
                                                        </div>
                                                        <div class="col-md-8 form-group">
                                                            <textarea name="txt_address" class="form-control" id="txt_address" required></textarea>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label>Password</label>
                                                        </div>
                                                        <div class="col-md-8 form-group">
                                                            <input type="password" class="form-control" name="txt_password" id="txt_password" required/>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label>Confirm Password</label>
                                                        </div>
                                                        <div class="col-md-8 form-group">
                                                            <input type="password" class="form-control" name="txt_confirmpassword" id="txt_confirmpassword" required/>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label>Photo</label>
                                                        </div>
                                                        <div class="col-md-8 form-group">
                                                            <input type="file" class="form-control" name="file_photo" id="file_photo" required/>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label>Proof</label>
                                                        </div>
                                                        <div class="col-md-8 form-group">
                                                            <input type="file" class="form-control" name="file_proof" id="file_proof" required/>
                                                        </div>
                                                        <div class="col-sm-12 text-center">
                                                            <input type="reset" class="btn-outline-primary rounded" name="btn_reset" id="btn_reset" value="Reset">
                                                            <input type="submit" class="btn-primary rounded" name="btn_submit" id="btn_submit" value="Submit" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
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
        <script src="../Assets/JS/formsValidation.js"></script>

        <script src="../Assets/Templates/Main/js/jquery-3.3.1.min.js"></script>
        <script src="../Assets/Templates/Main/js/jquery-migrate-3.0.1.min.js"></script>
        <script src="../Assets/Templates/Main/js/jquery-ui.js"></script>
        <script src="../Assets/Templates/Main/js/popper.min.js"></script>
        <script src="../Assets/Templates/Main/js/bootstrap.min.js"></script>
        <script src="../Assets/Templates/Main/js/owl.carousel.min.js"></script>
        <script src="../Assets/Templates/Main/js/jquery.stellar.min.js"></script>
        <script src="../Assets/Templates/Main/js/jquery.countdown.min.js"></script>
        <script src="../Assets/Templates/Main/js/bootstrap-datepicker.min.js"></script>
        <script src="../Assets/Templates/Main/js/jquery.easing.1.3.js"></script>
        <script src="../Assets/Templates/Main/js/aos.js"></script>
        <script src="../Assets/Templates/Main/js/jquery.fancybox.min.js"></script>
        <script src="../Assets/Templates/Main/js/jquery.sticky.js"></script>


        <script src="../Assets/Templates/Main/js/main.js"></script>

    </body>
</html>

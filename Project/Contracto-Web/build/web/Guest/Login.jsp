<%-- 
    Document   : Login
    Created on : 8 Jan, 2023, 7:29:44 AM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

    <!DOCTYPE html>
    <html lang="en">

        <head>
            <title>Login</title>
            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">


            <link href="https://fonts.googleapis.com/css?family=Muli:300,400,700,900" rel="stylesheet">
            <link rel="stylesheet" href="../Assets/Templates/Main/fonts/icomoon/style.css">
            <link rel="icon" href="../Assets/Templates/Homepage/images/logo/cover.png" type="image/x-icon"> 
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

            <link rel="stylesheet" href="../Assets/CSS/sweetalert.css">
            <script src="../Assets/JS/sweetalert.min.js"></script>
            <script src="../Assets/jQuery/jQuery.js"></script>
        </head>

        <body data-spy="scroll" data-target=".site-navbar-target" data-offset="300">
        <%
            if (request.getParameter("btn_submit") != null) {

                String email = request.getParameter("txt_email");
                String password = request.getParameter("txt_password");

                String selQry1 = "select *from tbl_admin where admin_email='" + email + "' and admin_password='" + password + "'";
                ResultSet rs1 = con.selectCommand(selQry1);

                String selQry2 = "select *from tbl_client where client_email='" + email + "' and client_password='" + password + "'";
                ResultSet rs2 = con.selectCommand(selQry2);

                String selQry3 = "select *from tbl_contractor where contractor_email='" + email + "' and contractor_password='" + password + "'";
                ResultSet rs3 = con.selectCommand(selQry3);

                String selQry4 = "select *from tbl_landlord where landlord_email='" + email + "' and landlord_password='" + password + "'";
                ResultSet rs4 = con.selectCommand(selQry4);

                if (rs1.next()) {
                    session.setAttribute("aname", rs1.getString("admin_name"));
                    session.setAttribute("aid", rs1.getString("admin_id"));
                    response.sendRedirect("../Admin/Homepage.jsp");
                    return;
                } else if (rs2.next()) {
                    session.setAttribute("cli_name", rs2.getString("client_name"));
                    session.setAttribute("cli_id", rs2.getString("client_id"));
                    response.sendRedirect("../Client/Homepage.jsp");
                    return;
                } else if (rs3.next()) {
                    if (rs3.getInt("contractor_status") == 1) {
                        session.setAttribute("c_name", rs3.getString("contractor_name"));
                        session.setAttribute("c_id", rs3.getString("contractor_id"));
                        response.sendRedirect("../Contractor/Homepage.jsp");
                        return;
                    }
                } else if (rs4.next()) {
                    if (rs4.getInt("landlord_status") == 1) {
                        session.setAttribute("l_name", rs4.getString("landlord_name"));
                        session.setAttribute("l_id", rs4.getString("landlord_id"));
                        response.sendRedirect("../Landlord/Homepage.jsp");
                        return;
                    }
                } else {
        %>
        <script src="../Assets/JS/SweetAlert/Error_Login.js"></script>
        <%
                }
            }
        %>
        <div class="site-wrap">

            <div class="site-mobile-menu site-navbar-target">
                <div class="site-mobile-menu-header">
                    <div class="site-mobile-menu-close mt-3">
                        <span class="icon-close2 js-menu-toggle"></span>
                    </div>
                </div>
                <div class="site-mobile-menu-body"></div>
            </div>


            <header class="site-navbar py-4 js-sticky-header site-navbar-target" role="banner">

                <div class="container-fluid">
                    <div class="d-flex align-items-center">
                        <div class="site-logo mr-auto w-25">
                            <a href="#">Contracto</a>
                        </div>

                        <div class="mx-auto text-center">
                            <nav class="site-navigation position-relative text-right" role="navigation">
                                <ul class="site-menu main-menu mx-auto d-none d-lg-block  m-0 p-0">
                                    <li class="js-clone-nav"><a href="#home-section" class="nav-link active">Home</a></li>
                                    <li class="js-clone-nav"><a href="#services-section" class="nav-link">Services</a></li>
                                    <li class="js-clone-nav"><a href="#programs-section" class="nav-link">Programs</a></li>
                                    <li class="js-clone-nav"><a href="#aboutsection" class="nav-link">About</a></li>
                                    <li class="js-clone-nav">
                                        <div class="dropdown show bg-white">
                                            <a class="nav-link dropdown-toggle text-dark font-weight-bold" href="#" data-toggle="dropdown">
                                                Register Now
                                            </a>
                                            <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                                <a class="dropdown-item" href="NewClient.jsp">New Client</a>
                                                <a class="dropdown-item" href="NewContractor.jsp">New Contractor</a>
                                                <a class="dropdown-item" href="NewLandlord.jsp">New Landlord</a>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </nav>
                        </div>

                        <div class="ml-auto w-25">
                            <nav class="site-navigation position-relative text-right" role="navigation">
                                <ul class="site-menu main-menu site-menu-dark js-clone-nav mr-auto d-none d-lg-block m-0 p-0">
                                    <li class="cta"><a href="#contact-section" class="nav-link" aria-expanded="true"><span>Contact
                                                Us</span></a></li>
                                </ul>
                            </nav>
                            <a href="#" class="d-inline-block d-lg-none site-menu-toggle js-menu-toggle text-black float-right"><span
                                    class="icon-menu h3"></span></a>
                        </div>
                    </div>
                </div>
            </header>

            <div class="intro-section" id="home-section">

                <div class="slide-1" style="background-image: url('../Assets/Templates/Main/images/bgimg-1.jpg');" data-stellar-background-ratio="0.5">
                    <div class="container">
                        <div class="row align-items-center">
                            <div class="col-12">
                                <div class="row align-items-center">
                                    <div class="col-lg-6 mb-4">
                                        <h1 data-aos="fade-up" data-aos-delay="100">Build Dreams</h1>
                                        <p class="mb-4" data-aos="fade-up" data-aos-delay="200">We pride ourselves on our commitment to
                                            excellence, and our team is dedicated to ensuring that our customers receive the best possible
                                            experience with us.
                                        </p>
                                        <p data-aos="fade-up" data-aos-delay="300">
                                            <a href="#" data-toggle="modal" data-target="#myMsgModal" class="btn btn-warning py-3 px-5 btn-pill">Get started</a>
                                        </p>
                                    </div>
                                    
                                    <!-- Modal -->
                                    <div class="modal fade" id="myMsgModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                      <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content bg-dark " style="background-image: url('../Assets/Templates/Main/images/bgimg-1.jpg');" data-stellar-background-ratio="0.5">
                                          <div class="modal-body text-center">
                                              <img src="../Assets/Templates/Main/images/program_1.jpg" class="img-thumbnail w-25 mx-auto d-block">
                                              <h3 class="m-3 bg-black p-4 rounded">Please Login to Continue</h3>
                                          </div>
                                          <div class="modal-footer mx-auto d-block">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                          </div>
                                        </div>
                                      </div>
                                    </div>
                                    <div class="col-lg-4 ml-auto" data-aos="fade-up" data-aos-delay="500">
                                        <form action="" method="post" class="form-box needs-validation" novalidate id="signin-form">
                                            <div class="mx-auto">
                                                <img src="../Assets/Templates/Main/images/man.png" class="img-thumbnail rounded-circle mb-4 w-25 mx-auto" style="margin-top: -60px">
                                                <h3 class="h4 text-black mb-4 ml-2">Sign In</h3>
                                            </div>
                                            <div class="form-group">
                                                <input type="text" class="form-control" name="txt_email"  placeholder="Email Addresss" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$" required>
                                            </div>
                                            <div class="form-group">
                                                <input type="password" class="form-control" name="txt_password" id="txt_pswd" placeholder="Password" required>
                                            </div>
                                            <div class="form-group">
                                                <input type="submit" class="btn btn-warning btn-pill" name="btn_submit" value="Sign In">
                                            </div>
                                        </form>
                                        <script src="../Assets/JS/formsValidation.js"></script>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>


            <div class="site-section services-title" id="services-section">
                <div class="container">
                    <div class="row mb-5 justify-content-center">
                        <div class="col-lg-7 text-center" data-aos="fade-up" data-aos-delay="">
                            <h2 class="section-title">Services</h2>
                        </div>
                    </div>
                </div>
            </div>
            <div class="site-section services-entry-wrap" data-aos="fade-up" data-aos-delay="100">
                <div class="container">
                    <div class="row">

                        <div class="owl-carousel col-12 nonloop-block-14">

                            <div class="service bg-white h-100 align-self-stretch">
                                <figure class="m-0">
                                    <a href="#"><img src="../Assets/Templates/Main/images/construction_support.jpg" alt="Image" class="img-fluid"></a>
                                </figure>
                                <div class="service-inner-text py-4 px-4">
                                    <h3><a href="#">Construction Works</a></h3>
                                    <p>We are committed to delivering high-quality construction work that exceeds our clients' expectations.
                                        We use only the highest-quality materials and employ the most skilled craftsmen to ensure that our
                                        work stands the test of time and provide the best. </p>
                                </div>
                            </div>

                            <div class="service bg-white h-100 align-self-stretch">
                                <figure class="m-0">
                                    <a href="#"><img src="../Assets/Templates/Main/images/plot_booking.jpg" alt="Image" class="img-fluid"></a>
                                </figure>
                                <div class="service-inner-text py-4 px-4">
                                    <h3><a href="#">Plot Booking Services</a></h3>
                                    <p>We provide plot booking services to help our clients secure their dream property. Our experienced
                                        team of real estate professionals is dedicated to providing exceptional service and making the plot
                                        booking process as smooth and hassle-free as possible. </p>
                                </div>
                            </div>

                            <div class="service bg-white h-100 align-self-stretch">
                                <figure class="m-0">
                                    <a href="#"><img src="../Assets/Templates/Main/images/chat_support.jpg" alt="Image" class="img-fluid" height="200"></a>
                                </figure>
                                <div class="service-inner-text py-4 px-4">
                                    <h3><a href="#">Chat Support Services</a></h3>
                                    <p>We take pride in delivering exceptional chat support to our customers. Experienced representatives is
                                        available 24/7 to assist with any issues or questions, and are committed to providing timely, accurate
                                        and friendly service to ensure satisfaction. </p>
                                </div>
                            </div>



                            <div class="service bg-white h-100 align-self-stretch">
                                <figure class="m-0">
                                    <a href="#"><img src="../Assets/Templates/Main/images/construction_support.jpg" alt="Image" class="img-fluid"></a>
                                </figure>
                                <div class="service-inner-text py-4 px-4">
                                    <h3><a href="#">Construction Works</a></h3>
                                    <p>We are committed to delivering high-quality construction work that exceeds our clients' expectations.
                                        We use only the highest-quality materials and employ the most skilled craftsmen to ensure that our
                                        work stands the test of time and provide the best. </p>
                                </div>
                            </div>

                            <div class="service bg-white h-100 align-self-stretch">
                                <figure class="m-0">
                                    <a href="#"><img src="../Assets/Templates/Main/images/plot_booking.jpg" alt="Image" class="img-fluid"></a>
                                </figure>
                                <div class="service-inner-text py-4 px-4">
                                    <h3><a href="#">Plot Booking Services</a></h3>
                                    <p>We provide plot booking services to help our clients secure their dream property. Our experienced
                                        team of real estate professionals is dedicated to providing exceptional service and making the plot
                                        booking process as smooth and hassle-free as possible. </p>
                                </div>
                            </div>

                            <div class="service bg-white h-100 align-self-stretch">
                                <figure class="m-0">
                                    <a href="#"><img src="../Assets/Templates/Main/images/chat_support.jpg" alt="Image" class="img-fluid"></a>
                                </figure>
                                <div class="service-inner-text py-4 px-4">
                                    <h3><a href="#">Chat Support Services</a></h3>
                                    <p>We take pride in delivering exceptional chat support to our customers. Experienced representatives is
                                        available 24/7 to assist with any issues or questions, and are committed to providing timely, accurate
                                        and friendly service to ensure satisfaction. </p>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="row justify-content-center">
                        <div class="col-7 text-center">
                            <button class="customPrevBtn btn btn-warning m-1">Prev</button>
                            <button class="customNextBtn btn btn-warning m-1">Next</button>
                        </div>
                    </div>
                </div>
            </div>


            <div class="site-section" id="programs-section">
                <div class="container">
                    <div class="row mb-5 justify-content-center">
                        <div class="col-lg-7 text-center" data-aos="fade-up" data-aos-delay="">
                            <h2 class="section-title">Why Contracto</h2>
                            <p> We are committed to providing our clients with exceptional service and delivering outstanding results.
                                Here are a few reasons why you should choose us for your construction and real estate needs:
                            </p>
                        </div>
                    </div>
                    <div class="row mb-5 align-items-center">
                        <div class="col-lg-7 mb-5" data-aos="fade-up" data-aos-delay="100">
                            <img src="../Assets/Templates/Main/images/program_1.jpg" alt="Image" class="img-fluid">
                        </div>
                        <div class="col-lg-4 ml-auto" data-aos="fade-up" data-aos-delay="200">
                            <h2 class="text-black mb-4">We Are Excellent In Construction Field</h2>
                            <p class="mb-4"> We understand that time is of the essence in the construction industry, and we make every
                                effort to complete our projects on time and on budget. We use the latest project management tools and
                                techniques to stay on schedule and communicate progress to our clients regularly.</p>
                        </div>
                    </div>

                    <div class="row mb-5 align-items-center">
                        <div class="col-lg-7 mb-5 order-1 order-lg-2" data-aos="fade-up" data-aos-delay="100">
                            <img src="../Assets/Templates/Main/images/program_2.jpg" alt="Image" class="img-fluid">
                        </div>
                        <div class="col-lg-4 mr-auto order-2 order-lg-1" data-aos="fade-up" data-aos-delay="200">
                            <h2 class="text-black mb-4">Strive for Efficiency</h2>
                            <p class="mb-4">In our manufacturing facilities, we use the principles of lean manufacturing to eliminate
                                waste and maximize efficiency. This includes implementing just-in-time inventory management, optimizing
                                production lines, and continuously monitoring and improving our processes.</p>
                        </div>
                    </div>

                    <div class="row mb-5 align-items-center">
                        <div class="col-lg-7 mb-5" data-aos="fade-up" data-aos-delay="100">
                            <img src="../Assets/Templates/Main/images/quality.svg" alt="Image" class="img-fluid">
                        </div>
                        <div class="col-lg-4 ml-auto" data-aos="fade-up" data-aos-delay="200">
                            <h2 class="text-black mb-4">Quality is First Priority</h2>
                            <p class="mb-4">We use only the highest-quality materials and processes to ensure that our products exceed
                                your expectations.</p>
                        </div>
                    </div>
                </div>
            </div>


            <div class="site-section bg-image overlay" style="background-image: url('../Assets/Templates/Main/images/bgimg2.jpg');" id="aboutsection">
                <div class="container">
                    <div class="row justify-content-center align-items-center">
                        <div class="col-md-8 text-center testimony" data-aos="zoom-in"  data-aos-delay="300">
                            <img src="../Assets/Templates/Main/images/program_1.jpg" alt="Image" class="img-fluid w-25 mb-4 rounded-circle">
                            <h3 class="mb-4">Who we are</h3>
                            <blockquote>
                                <p>&ldquo; Contracto was founded in 2010 by John Smith, with a passion for innovation and a drive to make
                                    a difference. John started the first website with just a vision for creating beautiful houses that would
                                    change the way people live and enjoy.

                                    Today, Contracto has grown to large service, and continue to push the boundaries of what's possible in
                                    construction field. We believe that our success is due to our unwavering focus on quality, innovation,
                                    and customer satisfaction. &rdquo;</p>
                            </blockquote>
                        </div>
                    </div>
                    <div class="row justify-content-center align-items-center">
                        <div class="col-md-6 col-sm-6 offset-md-3 offset-1">
                            <h1 class="text-white">Our Major Projects</h1>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="card mb-4 box-shadow" data-aos="fadeIn"  data-aos-delay="200">
                                <img class="card-img-top" src="../Assets/Templates/Main/images/img_2.jpg" alt="Card image cap">
                                <div class="card-body">
                                    <a href="#aboutsection" class="property-favorite"><span class="icon-heart-o"></span></a>
                                    <h2 class="property-title"><a href="#aboutsection">ShanthiBhavan</a></h2>
                                    <span class="property-location d-block mb-3"><span class="property-icon icon-room"></span> Near Town
                                        Auditorium, Kattappana, Idukki</span>
                                    <ul class="property-specs-wrap mb-3 mb-lg-0 text-success">
                                        <li>
                                            <span class="property-specs">Beds</span>
                                            <span class="property-specs-number">3 <sup>+</sup></span>
                                        </li>
                                        <li>
                                            <span class="property-specs">Baths</span>
                                            <span class="property-specs-number">2</span>
                                        </li>
                                        <li>
                                            <span class="property-specs">SQ FT</span>
                                            <span class="property-specs-number">7,000</span>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card mb-4 box-shadow" data-aos="fadeIn"  data-aos-delay="400">
                                <img class="card-img-top" src="../Assets/Templates/Main/images/img_7.jpg" alt="Card image cap">
                                <div class="card-body">
                                    <a href="#aboutsection" class="property-favorite"><span class="icon-heart-o"></span></a>
                                    <h2 class="property-title"><a href="#aboutsection">Ram Villa</a></h2>
                                    <span class="property-location d-block mb-3"><span class="property-icon icon-room"></span> Near Private
                                        Bus Stand, Thodupuzha, Idukki</span>
                                    <ul class="property-specs-wrap mb-3 mb-lg-0 text-success">
                                        <li>
                                            <span class="property-specs">Beds</span>
                                            <span class="property-specs-number">2 <sup>+</sup></span>

                                        </li>
                                        <li>
                                            <span class="property-specs">Baths</span>
                                            <span class="property-specs-number">2</span>

                                        </li>
                                        <li>
                                            <span class="property-specs">SQ FT</span>
                                            <span class="property-specs-number">6,000</span>

                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card mb-4 box-shadow" data-aos="fadeIn"  data-aos-delay="600">
                                <img class="card-img-top" src="../Assets/Templates/Main/images/img_8.jpg" alt="Card image cap">
                                <div class="card-body">
                                    <a href="#aboutsection" class="property-favorite"><span class="icon-heart-o"></span></a>
                                    <h2 class="property-title"><a href="#aboutsection">Bethlehem</a></h2>
                                    <span class="property-location d-block mb-3"><span class="property-icon icon-room"></span> Near St.
                                        George Church, Aluva, Ernakulam</span>
                                    <ul class="property-specs-wrap mb-3 mb-lg-0 text-success">
                                        <li>
                                            <span class="property-specs">Beds</span>
                                            <span class="property-specs-number">4 <sup>+</sup></span>

                                        </li>
                                        <li>
                                            <span class="property-specs">Baths</span>
                                            <span class="property-specs-number">3</span>

                                        </li>
                                        <li>
                                            <span class="property-specs">SQ FT</span>
                                            <span class="property-specs-number">8,500</span>

                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>




            <div class="site-section bg-image" style="background-image: url(../Assets/Templates/Main/images/blob_5.svg);" id="contact-section">
                <div class="container">

                    <div class="row justify-content-center">
                        <div class="col-md-7">



                            <h2 class="section-title mb-3">Message Us</h2>
                            <p class="mb-5">If you have any questions or would like to learn more about Contracto and our products and
                                services, please don't hesitate to contact us. We look forward to hearing from you!
                            </p>

                            <form method="post" data-aos="fade">
                                <div class="form-group row">
                                    <div class="col-md-6 mb-3 mb-lg-0">
                                        <input type="text" class="form-control" placeholder="First name">
                                    </div>
                                    <div class="col-md-6">
                                        <input type="text" class="form-control" placeholder="Last name">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <div class="col-md-12">
                                        <input type="text" class="form-control" placeholder="Subject">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <div class="col-md-12">
                                        <input type="email" class="form-control" placeholder="Email">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="col-md-12">
                                        <textarea class="form-control" id="" cols="30" rows="10"
                                                  placeholder="Write your message here."></textarea>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <div class="col-md-6">

                                        <input type="submit" class="btn btn-warning py-3 px-5 btn-block btn-pill" value="Send Message">
                                    </div>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>
            </div>


            <footer class="footer-section bg-image" style="background-image: url(../Assets/Templates/Main/images/blob_1.svg);">
                <div class="container">
                    <div class="row bg-white">
                        <div class="col-md-4 align-self-center">
                            <h2 class="text-dark">About Contracto</h2>
                            <p class="text-justify text-dark">Contracto was founded in 2010 by John Smith, with a passion for innovation
                                and a drive to make a
                                difference. John started the first website with just a vision for creating beautiful houses that would
                                change the way people live and enjoy.

                                Today, Contracto has grown to large service, and continue to push the boundaries of what's possible in
                                construction field. We believe that our success is due to our unwavering focus on quality, innovation, and
                                customer satisfaction.</p>
                        </div>

                        <div class="col-md-3 ml-auto align-self-auto">
                            <h2 class="text-dark">Links</h2>
                            <ul class="list-unstyled footer-links">
                                <li><a href="#home-section">Home</a></li>
                                <li><a href="#services-section">Services</a></li>
                                <li><a href="#programs-section">Programs</a></li>
                                <li><a href="#aboutsection">About</a></li>
                            </ul>
                        </div>

                        <div class="col-md-4 align-self-center ">
                            <div class="text-center">
                                <a href="https://www.facebook.com/"><img src="../Assets/Templates/Main/images/facebook.svg"></a>
                                <a href="https://www.instagram.com/"><img src="../Assets/Templates/Main/images/instagram.svg"></a>
                                <a href="https://telegram.org/"><img src="../Assets/Templates/Main/images/telegram-app.svg"></a>
                                <a href="https://twitter.com/i/flow/login?input_flow_data=%7B%22requested_variant%22%3A%22eyJsYW5nIjoiZW4ifQ%3D%3D%22%7D"><img src="../Assets/Templates/Main/images/twitter.svg"></a>
                                <a href="https://www.whatsapp.com/"><img src="../Assets/Templates/Main/images/whatsapp.svg"></a>
                                <a href="https://www.youtube.com/"><img src="../Assets/Templates/Main/images/youtube.svg"></a>
                            </div>
                        </div>
                    </div>

                    <div class="row pt-5 mt-5 text-center">
                        <div class="col-md-12">
                            <div class="border-top pt-5 bg-light  ">
                                <p>
                                    Copyright &copy;
                                    <script>document.write(new Date().getFullYear());</script> All rights reserved 
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </footer>

        </div>        
        <!-- .site-wrap -->

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
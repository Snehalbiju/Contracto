<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>
    <!DOCTYPE html>
    
<!DOCTYPE html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="x-ua-compatible" content="ie=edge">

    <title> Chat</title>
    <link rel="icon" type="image/png" href="assets/img/favicon.png" />

    <!-- Google Tag Manager -->
    <script>
        (function(w, d, s, l, i) {
            w[l] = w[l] || [];
            w[l].push({
                'gtm.start': new Date().getTime(),
                event: 'gtm.js'
            });
            var f = d.getElementsByTagName(s)[0],
                j = d.createElement(s),
                dl = l != 'dataLayer' ? '&l=' + l : '';
            j.async = true;
            j.src =
                'https://www.googletagmanager.com/gtm.js?id=' + i + dl;
            f.parentNode.insertBefore(j, f);
        })(window, document, 'script', 'dataLayer', 'GTM-KQHJPZP');
    </script>
    <!-- End Google Tag Manager -->

    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Roboto:400,500" rel="stylesheet">
    <!-- Core CSS -->
    <link rel="stylesheet" href="assets/css/app.css">
    <link rel="stylesheet" href="assets/css/core.css">
    <link rel="stylesheet" href="../../Assets/Templates/Homepage/extensions/bootstrap-icons/font/bootstrap-icons.css">
</head>

<body class="is-dark">
    <!-- Google Tag Manager (noscript) -->
    <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-KQHJPZP" height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
    <!-- End Google Tag Manager (noscript) -->

    <!-- Pageloader -->
    <div class="pageloader"></div>
    <div class="infraloader is-active"></div>

    <div class="chat-wrapper is-standalone">
        <div class="chat-inner">

            <!-- Chat top navigation -->
            <div class="chat-nav">
                <%
                    if (request.getParameter("cid") != null) {
                %>
                <div class="nav-start">
                    <div class="recipient-block">
                        <div class="avatar-container">
                            <img class="user-avatar" src="https://via.placeholder.com/300x300" data-demo-src="../../Assets/Files/ClientPhoto/<%=request.getParameter("cphoto")%>" alt="">
                        </div>
                        <div class="username">
                            <span><%=request.getParameter("cname")%></span>
                            <span><i data-feather="star"></i> <span>| Online</span></span>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
                <div class="nav-end">
                    <div class="chat-search">
                        <div class="control has-icon">
                            <input type="text" class="input" placeholder="Search messages">
                            <div class="form-icon">
                                <i data-feather="search"></i>
                            </div>
                        </div>
                    </div>
                    <a class="chat-nav-item is-icon is-hidden-mobile">
                        <i data-feather="at-sign"></i>
                    </a>
                    <a class="chat-nav-item is-icon is-hidden-mobile">
                        <i data-feather="star"></i>
                    </a>
                    <a class="chat-nav-item is-icon close-chat">
                        <i data-feather="x"></i>
                    </a>
                </div>
            </div>
            <!-- Chat sidebar -->
            <div id="chat-sidebar" class="users-sidebar">
                <!-- Header -->
                <a class="header-item">
                    <img src="../../Assets/Templates/Homepage/images/svg-loaders/circles.svg" alt="">
                </a>
                <!-- User list -->
                <div class="conversations-list has-slimscroll-xs">
                    <!-- User -->
                    <%
                        String selQry = "select * from tbl_work w inner join tbl_client cl on w.client_id=cl.client_id INNER JOIN tbl_workrequest wr ON w.work_id=wr.work_id where wr.contractor_id='" + request.getParameter("id") + "' group by w.client_id";
                        ResultSet rs = con.selectCommand(selQry);
                        while (rs.next()) {
                    %>
                    <a href="Chat.jsp?id=<%=request.getParameter("id")%>&cid=<%=rs.getString("client_id")%>&cname=<%=rs.getString("client_name")%>&cphoto=<%=rs.getString("client_photo")%>">
                        <div class="user-item is-active" data-chat-user="dan" data-full-name="Dan Walker" data-status="Online">
                            <div class="avatar-container">
                                <img class="user-avatar" src="../../Assets/Files/ClientPhoto/<%=rs.getString("client_photo")%>" alt="">
                                <div class="user-status is-online"></div>
                            </div>
                        </div>
                    </a>
                    <%
                        }
                    %>
                </div>
                <!-- Add Conversation -->
                <div class="footer-item">
                    <div class="add-button modal-trigger" data-modal="add-conversation-modal"><i data-feather="user"></i>
                    </div>
                </div>
            </div>

            <!-- Chat body -->
            <div id="chat-body" class="chat-body">
                <!-- Conversation with Client -->
                <div id="conversation" class="chat-body-inner has-slimscroll">
                    
                    <%
                        if (request.getParameter("cid") != null) {
                            String chatid = request.getParameter("cid");
                    %>
                    
                </div>
                <!-- Compose message area -->
                <div class="chat-action">
                    <div class="chat-action-inner">
                        <div class="control">
                            <textarea class="textarea comment-textarea" rows="1" id="msg"></textarea>
                            <input type="hidden" id="cid" name="cid" value="<%=chatid%>">
                            <input type="hidden" id="id" name="id" value="<%=request.getParameter("id")%>">
                            <div class="dropdown compose-dropdown  dropdown-trigger">
                                <div class="is-spaced is-accent is-up">
                                    <div class="add-button">
                                        <button class="button-inner" onclick="sendChat()">
                                            <i class="bi bi-send-fill primary"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                        }
                %>
            </div>
        </div>
    </div>

    <div id="add-conversation-modal" class="modal add-conversation-modal is-xsmall has-light-bg">
        <div class="modal-background"></div>
        <div class="modal-content">

            <div class="card">
                <div class="card-heading">
                    <h3>New Conversation</h3>
                    <!-- Close X button -->
                    <div class="close-wrap">
                        <span class="close-modal">
                            <i data-feather="x"></i>
                        </span>
                    </div>
                </div>
                <div class="card-body">

                    <img src="assets/img/icons/chat/bubbles.svg" alt="">

                    <div class="field is-autocomplete">
                        <div class="control has-icon">
                            <input type="text" class="input simple-users-autocpl" placeholder="Search a user">
                            <div class="form-icon">
                                <i data-feather="search"></i>
                            </div>
                        </div>
                    </div>

                    <div class="help-text">
                        Select a user to start a new conversation. You'll be able to add other users later.
                    </div>

                    <div class="action has-text-centered">
                        <button type="button" class="button is-solid accent-button raised">Start conversation</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
            
    <script src="../../Assets/jQuery/jQuery.js"></script>
        <script>

        function sendChat()
        {
            var chat = document.getElementById("msg").value;
            var cid = document.getElementById("cid").value;
            var id = document.getElementById("id").value;
            if (chat.length <= 35)
            {
                $.ajax({url: "AjaxChat.jsp?chat=" + chat + "&cid=" + cid+ "&id=" + id,
                    success: function(result) {
                        document.getElementById("msg").value = "";
                        $('#conversation').animate({scrollTop: $('#conversation')[0].scrollHeight});
                    }});
            }
            else
            {
                alert("Character Length less Than 35 Allowed");
                document.getElementById("msg").value = "";

                $('#conversation').animate({scrollTop: $('#conversation')[0].scrollHeight});
            }
        }

        $(document).ready(function() {
            setInterval(function() {
                var cid = document.getElementById("cid").value;
                var id = document.getElementById("id").value;
                $("#conversation").load('Load.jsp?cid=' + cid+"&id="+id)
            }, 50);
        });
    </script>
                
    <script>
        /scroll to top function
                $(document).ready(function() {
            $(window).scroll(function() {
                if ($(this).scrollTop() > 50) {
                    $('#back-to-top').fadeIn();
                } else {
                    $('#back-to-top').fadeOut();
                }
            });
            // scroll body to 0px on click
            $('#back-to-top').click(function() {
                $('body,html').animate({
                    scrollTop: 0
                }, slow);
                return false;
            });
        });
    </script>
    <!-- Concatenated js plugins and jQuery -->
    <script src="assets/js/app.js"></script>
    <script src="https://js.stripe.com/v3/"></script>
    <script src="assets/data/tipuedrop_content.js"></script>

    <!-- Core js -->
    <script src="assets/js/global.js"></script>

    <!-- Navigation options js -->
    <script src="assets/js/navbar-v1.js"></script>
    <script src="assets/js/navbar-v2.js"></script>
    <script src="assets/js/navbar-mobile.js"></script>
    <script src="assets/js/navbar-options.js"></script>
    <script src="assets/js/sidebar-v1.js"></script>

    <!-- Core instance js -->
    <script src="assets/js/main.js"></script>
    <script src="assets/js/chat.js"></script>
    <script src="assets/js/touch.js"></script>
    <script src="assets/js/tour.js"></script>

    <!-- Components js -->
    <script src="assets/js/explorer.js"></script>
    <script src="assets/js/widgets.js"></script>
    <script src="assets/js/modal-uploader.js"></script>
    <script src="assets/js/popovers-users.js"></script>
    <script src="assets/js/popovers-pages.js"></script>
    <script src="assets/js/lightbox.js"></script>
</body>
</html>

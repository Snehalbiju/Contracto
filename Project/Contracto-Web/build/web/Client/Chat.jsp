<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Chat</title>
            <link rel="stylesheet" href="../Assets/CSS/Chat.css">
        <%@include file="Header.jsp" %>
         <%
        response.setHeader("Cache-Control", "no-cache, no-store");
        if (session.getAttribute("cli_id") == null) {
            response.sendRedirect("../");
        }
    %>
        <!-- char-area -->
    <section class="message-area rounded-2">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="chat-area bg-dark shadow-lg">
                        <!-- chatlist -->
                        <div class="chatlist shadow-lg">
                            <div class="modal-dialog-scrollable">
                                <div class="modal-content">
                                    <div class="chat-header">
                                        <div class="msg-search">
                                            <input type="text" class="form-control shadow-sm"  placeholder="Search">
                                        </div>
                                    </div>
                                    <hr>

                                    <div class="modal-body">
                                        <!-- chat-list -->
                                        <div class="chat-lists">
                                            <div class="tab-content" id="myTabContent">
                                                <div class="tab-pane fade show active" id="Open" role="tabpanel" aria-labelledby="Open-tab">
                                                    <!-- chat-list -->
                                                    <%                                                        
                                                        String selQry = "select * from tbl_workrequest wr inner join tbl_contractor co on wr.contractor_id=co.contractor_id INNER JOIN tbl_work w ON wr.work_id=w.work_id where w.client_id='" + session.getAttribute("cli_id") + "' group by wr.contractor_id";
                                                        ResultSet rs = con.selectCommand(selQry);
                                                        while (rs.next()) {
                                                    %>
                                                    <div class="chat-list">
                                                        <a class="d-flex align-items-center" href="Chat.jsp?cid=<%=rs.getString("contractor_id")%>&cname=<%=rs.getString("contractor_name")%>&cphoto=<%=rs.getString("contractor_photo")%>">
                                                            <div class="flex-shrink-0">
                                                                <img style="width: 32px; height:32px " class="rounded-circle"  src="../Assets/Files/ContractorPhoto/<%=rs.getString("contractor_photo")%>" alt="">
                                                            </div>
                                                            <div class="flex-grow-1 ms-3">
                                                                <h6 class="text-black"><%=rs.getString("contractor_name")%>
                                                                <%
                                                                    String selQry1="select count(chat_id) as unread_msg from tbl_chat where chat_status=0 and chat_fromcon='"+rs.getString("contractor_id")+"' and chat_toclient='"+session.getAttribute("cli_id")+"'";
                                                                    ResultSet rs1 = con.selectCommand(selQry1);
                                                                    rs1.next();
                                                                    String unread_msg=rs1.getString("unread_msg");
                                                               
                                                                    if(Integer.parseInt(unread_msg)!=0){
                                                                    %>
                                                                    <span class="badge bg-success rounded-pill position-absolute top-0 end-0"><%=unread_msg%></span>
                                                                    <%
                                                                    }else{
                                                                    %>
                                                                     <span class="badge bg-success rounded-pill position-absolute top-0 end-0">0</span>
                                                                    <%
                                                                    } 
                                                                    %>
                                                                </h6>
                                                            </div>
                                                        </a>
                                                    </div>
                                                            <hr class="shadow-lg">
                                                    <%
                                                        }
                                                    %>
                                                    <!-- chat-list -->
                                                </div>
                                            </div>
                                        </div>
                                        <!-- chat-list -->
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- chatlist -->



                        <!-- chatbox -->
                        <div class="chatbox bg-white">
                            <div class="modal-dialog-scrollable">
                                <div class="modal-content">
                                    <div class="msg-head">
                                        <div class="row">
                                            <div class="col-8">
                                                <div class="d-flex align-items-center">
                                                    <span class="chat-icon text-blue-blue-700"><i class="bi bi-caret-left-fill"></i></span>
                                                        <%
                                                            if (request.getParameter("cid") != null) {
                                                        %>
                                                    <div class="flex-shrink-0">
                                                        <img class="rounded-circle" width="40" height="40" src="../Assets/Files/ContractorPhoto/<%=request.getParameter("cphoto")%>" alt="">
                                                    </div>
                                                    <div class="flex-grow-1 ms-3 ">
                                                        <h6 class="text-black"><%=request.getParameter("cname")%></h6>
                                                    </div>
                                                </div>
                                                <%
                                                    }
                                                %>
                                            </div>
                                        </div>
                                    </div>


                                    <div class="modal-body" id="scroll">
                                        <div id="conversation" class="msg-body skeleton">
                                            <%
                                                if (request.getParameter("cid") != null) {
                                                    String chatid = request.getParameter("cid");
                                            %>
                                            
                                        </div>
                                    </div>


                                    <div class="send-box">
                                        <form action="">
                                            <input type="text" name="text" class="input form-control" placeholder="Write a message" id="msg">
                                            <input type="hidden" id="cid" name="cid" value="<%=chatid%>">

                                            <button type="button" name="btn_send"  id="btn_send" onclick="sendChat()">
                                                <div class="svg-wrapper-1">
                                                  <div class="svg-wrapper">
                                                    <svg height="24" width="24" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                                      <path d="M0 0h24v24H0z" fill="none"></path>
                                                      <path d="M1.946 9.315c-.522-.174-.527-.455.01-.634l19.087-6.362c.529-.176.832.12.684.638l-5.454 19.086c-.15.529-.455.547-.679.045L12 14l6-8-8 6-8.054-2.685z" fill="currentColor"></path>
                                                    </svg>
                                                  </div>
                                                </div>
                                                <span>Send</span>
                                              </button>
                                        </form>
                                    </div>
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- chatbox -->

                    <script src="../Assets/jQuery/jQuery.js"></script>

                    <script>

                        function sendChat()
                        {
                            var chat = document.getElementById("msg").value;
                            var cid = document.getElementById("cid").value;
                            if (chat.length <= 35)
                            {
                                $.ajax({url: "AjaxChat.jsp?chat=" + chat + "&cid=" + cid,
                                    success: function(result) {


                                        document.getElementById("msg").value = "";

                                        $('#scroll').animate({scrollTop: $('#scroll')[0].scrollHeight});


                                    }});
                            }
                            else
                            {
                                alert("Character Length less Than 35 Allowed");
                                document.getElementById("msg").value = "";

                                $('#scroll').animate({scrollTop: $('#scroll')[0].scrollHeight});
                            }
                        }

                        $(document).ready(function() {
                            setInterval(function() {
                                var cid = document.getElementById("cid").value;
                                $("#conversation").load('Load.jsp?cid=' + cid)
                            }, 50);

                            $(".chat-list a").each(function() {
                                $(".chatbox").addClass('showbox');
                                return false;
                            });

                            $(".chat-icon").click(function() {
                                $(".chatbox").removeClass('showbox');
                            });
                            
                            $(".scrollDown").click(function(event) {
    //       Select the body of the page and scroll down by 650 pixels worth
                                $("html, body").animate({ scrollTop: "+=650px" }, 800);
                              });
                        });

                    </script>
                </div>
            </div>
        </div>
    </section>
    <!-- char-area -->
    <%@include file="Footer.jsp" %>
    <script>
        $(document).ready(function() {
            var pgurl = window.location.href.substr(window.location.href.lastIndexOf("/") + 1);
            $(".menu li").each(function() {
                if ($('a', this).attr("href") == pgurl || $('a', this).attr("href") == 'Chat.jsp')
                    $(this).addClass("active");
            })
        });
    </script> 
</body>
</html>

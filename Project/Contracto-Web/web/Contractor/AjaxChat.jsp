<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>
<%

    String insQry="insert into tbl_chat (`chat_fromcon`,`chat_toclient`,`chat_content`,`chat_date`) values('"+session.getAttribute("c_id") +"','"+request.getParameter("cid") +"','"+request.getParameter("chat") +"',DATE_FORMAT(sysdate(), '%M %d %Y, %h:%i %p'))";
    out.print(insQry);
    if(con.executeCommand(insQry))
    {
        %>
<!--        <script>
            alert("Send");
        </script>-->
        <%
    }
    else
    {
        out.println("failed");
        out.println(insQry);
    }
    
%>
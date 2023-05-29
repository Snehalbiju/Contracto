<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%

    String insQry="insert into tbl_chat (`chat_tocon`,`chat_fromclient`,`chat_content`,`chat_date`) values('"+request.getParameter("cid") +"','"+session.getAttribute("cli_id") +"','"+request.getParameter("chat") +"',DATE_FORMAT(sysdate(), '%M %d %Y, %h:%i %p'))";
    System.out.print(insQry);
    if(con.executeCommand(insQry))
    {
        out.println("sended");
    }
    else
    {
        out.println("failed");
        out.println(insQry);
    }
    
%>
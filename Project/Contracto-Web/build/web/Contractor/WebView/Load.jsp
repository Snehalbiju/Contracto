
<%@page import="java.sql.ResultSet"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%  
    String upQry="update tbl_chat set chat_status=1 where chat_fromclient='" + request.getParameter("cid") + "' and chat_tocon='" + request.getParameter("id") + "'";
    con.executeCommand(upQry);
    
    
    String selQry = "select * from tbl_chat c inner join tbl_client cl on (c.chat_toclient=cl.client_id) or (c.chat_fromclient=cl.client_id) inner join tbl_contractor co on (c.chat_tocon=co.contractor_id) or (c.chat_fromcon=co.contractor_id)  where cl.client_id='" + request.getParameter("cid") + "' and co.contractor_id='" + request.getParameter("id") + "' order by chat_id";
    //out.print(selQry);
    ResultSet rs = con.selectCommand(selQry);
    while (rs.next()) {
        if (rs.getString("chat_fromcon").equals(request.getParameter("id"))) {

%>
    <div class="chat-message is-sent">
        <img src="../../Assets/Files/ContractorPhoto/<%=rs.getString("contractor_photo")%>" alt="">
        <div class="message-block">
            <span><%=rs.getString("chat_date")%></span>
            <div class="message-text"><%=rs.getString("chat_content")%></div>
        </div>
    </div>
<%
//out.print(request.getParameter("cid"));
//out.print(rs.getString("to_user_id"));
 //out.print(rs.getString("chat_toclient"));
} 
         if (rs.getString("chat_fromclient").equals(request.getParameter("cid"))) {

   //out.print("hello");
%>

    <div class="chat-message is-received">
        <img src="../../Assets/Files/ClientPhoto/<%=rs.getString("client_photo")%>"  alt="">
        <div class="message-block">
            <span><%=rs.getString("chat_date")%></span>
            <div class="message-text"><%=rs.getString("chat_content")%></div>
        </div>
    </div>

<%
                    }
        
                }
%>

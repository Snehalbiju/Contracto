
<%@page import="java.sql.ResultSet"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>
<ul>
<%  
    String upQry="update tbl_chat set chat_status=1 where chat_fromclient='" + request.getParameter("cid") + "' and chat_tocon='" + session.getAttribute("c_id") + "'";
    con.executeCommand(upQry);
    
    
    String selQry = "select * from tbl_chat c inner join tbl_client cl on (c.chat_toclient=cl.client_id) or (c.chat_fromclient=cl.client_id) inner join tbl_contractor co on (c.chat_tocon=co.contractor_id) or (c.chat_fromcon=co.contractor_id)  where cl.client_id='" + request.getParameter("cid") + "' and co.contractor_id='" + session.getAttribute("c_id") + "' order by chat_id";
    //out.print(selQry);
    ResultSet rs = con.selectCommand(selQry);
    while (rs.next()) {
        if (rs.getString("chat_fromcon").equals(session.getAttribute("c_id"))) {

%>
  <li class="sender">
        <p><img src="../Assets/Files/ContractorPhoto/<%=rs.getString("contractor_photo")%>" class="rounded-circle" height="30" width="30" alt="">
    <%=rs.getString("chat_content")%></p>
        <span class="time"><%=rs.getString("chat_date")%></span>
</li>
<%
//out.print(request.getParameter("cid"));
//out.print(rs.getString("to_user_id"));
 //out.print(rs.getString("chat_toclient"));
} 
         if (rs.getString("chat_fromclient").equals(request.getParameter("cid"))) {

   //out.print("hello");
%>
<li class="repaly">
    <p><img src="../Assets/Files/ClientPhoto/<%=rs.getString("client_photo")%>" class="rounded-circle" height="30" width="30" alt="">
        <%=rs.getString("chat_content")%></p>
<span class="time"><%=rs.getString("chat_date")%></span>
<%
                    }
        %>
        </li>
        
        <%
                }
%>
</ul>

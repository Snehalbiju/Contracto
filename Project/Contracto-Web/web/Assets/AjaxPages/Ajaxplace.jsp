<%@page import="java.sql.ResultSet"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>
<option value="">----Select Place----</option>
                      <%
                         
                        String selqry="select *from tbl_place where district_id="+request.getParameter("did")+" order by place_name";
                        ResultSet rs=con.selectCommand(selqry);
                        while(rs.next()){
                      %>
                      <option value="<%=rs.getString("place_id")%>">
                      <%=rs.getString("place_name")%>
                      </option>
                      <%
                                      }
                                      %>
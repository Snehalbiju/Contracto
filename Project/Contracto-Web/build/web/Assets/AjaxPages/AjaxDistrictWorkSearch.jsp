<%-- 
    Document   : AjaxSearchWorkONDistrict
    Created on : 10 Feb, 2023, 10:52:41 PM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>              
    
            <tr>
                <%
                    String selQry = "select *from tbl_work w inner join tbl_category c on w.category_id=c.category_id inner join "
                            + "tbl_client cl on w.client_id=cl.client_id inner join tbl_place p on w.place_id=p.place_id "
                            + "inner join tbl_district d on p.district_id=d.district_id where d.district_id="+request.getParameter("did")+"";
                    ResultSet rs = con.selectCommand(selQry);
                    while (rs.next()) {
                %>
                <td>
                    <a href="ClientProfile.jsp?cliID=<%=rs.getString("client_id")%>">
                        <div style="display: flex; justify-content: center;">
                            <img src="../Assets/Files/ClientPhoto/<%=rs.getString("client_photo")%>" width="60" height="60"
                                 style="border-radius: 50%" alt="">
                            <span style="text-align: center; padding: 20px 0px 0px 5px">
                                <%=rs.getString("client_name")%>
                            </span>
                        </div>
                    </a>
                </td>
                <td>
                    <h3>
                        <a href="ViewWork.jsp?wID=<%=rs.getString("work_id")%>">
                            <%=rs.getString("category_name")%>
                        </a>
                    </h3>
                    <%=rs.getString("district_name")%>, <%=rs.getString("place_name")%>
                </td>
            </tr>
            <%
                }
            %>
    
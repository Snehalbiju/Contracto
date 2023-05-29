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
                    String selQry = "select *from tbl_plot pl inner join tbl_landlord l on pl.landlord_id=l.landlord_id inner join "
                            + "tbl_place p on pl.place_id=p.place_id "
                            + "inner join tbl_district d on p.district_id=d.district_id where p.place_id="+request.getParameter("pid")+"";
                    ResultSet rs = con.selectCommand(selQry);
                    while (rs.next()) {
                %>
                <td align="center">
                    <a href="LandlordProfile.jsp?lID=<%=rs.getString("landlord_id")%>">
                        <div class="avatar avatar-lg">
                            <img src="../Assets/Files/LandlordPhoto/<%=rs.getString("landlord_photo")%>" class="border border-2 border-warning" alt="">
                        </div>
                        <span style="text-align: center; padding: 20px 0px 0px 5px">
                            <%=rs.getString("landlord_name")%>
                        </span>

                    </a>
                </td>
                <td>
                    <h3>
                        <a href="ViewPlotDetails.jsp?pl_ID=<%=rs.getString("plot_id")%>">
                            <%=rs.getString("plot_landmark")%>
                        </a>
                    </h3>
                    <%=rs.getString("district_name")%>, <%=rs.getString("place_name")%>
                    <br>
                    <strong>
                        <%
                            if (rs.getInt("plot_status") == 0) {
                                out.print("Unsold");
                            } else if (rs.getInt("plot_status") == 1) {
                                out.print("Some booked");
                            }else if (rs.getInt("plot_status") == 2) {
                                out.print("Sold");
                            }
                        %>
                    </strong>
                </td>
            </tr>
            <%
                }
            %>                
    
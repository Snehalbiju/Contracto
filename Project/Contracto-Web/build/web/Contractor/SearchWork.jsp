<%-- 
    Document   : SearchWork
    Created on : 10 Feb, 2023, 8:55:29 PM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Search Work</title>
        <%@include file="Header.jsp" %>


    <div class="page-heading">
        <div class="page-title">
            <div class="row">
                <div class="col-12 col-md-6 order-md-1 order-last">
                    <h3>Search Work</h3>
                </div>
                <div class="col-12 col-md-6 order-md-2 order-first">
                    <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="Homepage.jsp">Dashboard</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Search Work</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
<section class="section">
        <div class="row">
            <div class="col-sm-3 text-center font-bold text-pink-pink-400">
                Filters
            </div>
            <div class="col-sm-3">
                <select class="form-select" name="sel_district" id="sel_district" onchange="getPlace(this.value)">
                    <option value="">----Select District----</option>
                    <%                        String selQry1 = "select *from tbl_district";
                        ResultSet rs1 = con.selectCommand(selQry1);
                        while (rs1.next()) {
                    %>
                    <option value="<%=rs1.getInt("district_id")%>">
                        <% out.print(rs1.getString("district_name"));%>
                    </option>
                    <%
                        }
                    %>
                </select>
            </div>
            <div class="col-sm-3">
                <select class="form-select" name="sel_place" id="sel_place" onchange="getPlacework(this.value)">
                    <option value="">----Select District First----</option>
                </select>
            </div>
            <div class="col-sm-3">
                <button type="button" id="refresh" class="btn btn-outline-danger">Clear All</button>
            </div>
        </div>
        <br>
        <table class="table table-bordered table-hover table-striped" id="tableview">
            <tr>
                <%
                    String selQry = "select *from tbl_work w inner join tbl_category c on w.category_id=c.category_id inner join "
                            + "tbl_client cl on w.client_id=cl.client_id inner join tbl_place p on w.place_id=p.place_id "
                            + "inner join tbl_district d on p.district_id=d.district_id";
                    ResultSet rs = con.selectCommand(selQry);
                    while (rs.next()) {
                %>
                <td align="center">
                    <a href="ClientProfile.jsp?cliID=<%=rs.getString("client_id")%>">
                        <div class="avatar avatar-lg">
                            <img src="../Assets/Files/ClientPhoto/<%=rs.getString("client_photo")%>" class="border border-2 border-warning" alt="">
                            </div>
                            <span style="text-align: center; padding: 20px 0px 0px 5px">
                                <%=rs.getString("client_name")%>
                            </span>
                    </a>
                </td>
                <td>
                    <h3>
                        <a href="ViewWork.jsp?wID=<%=rs.getString("work_id")%>">
                            <%=rs.getString("category_name")%>
                        </a>
                    </h3>
                    <%=rs.getString("district_name")%>, <%=rs.getString("place_name")%>
                    <br>
                    <strong>
                        <%
                            if (rs.getInt("work_status") == 0) {
                                out.print("Actively searching");
                            } else if (rs.getInt("work_status") == 1) {
                                out.print("Some applied");
                            }else if (rs.getInt("work_status") == 2) {
                                out.print("No longer Receiving");
                            }
                        %>
                    </strong>
                </td>
            </tr>
            <%
                }
            %>
        </table>
        </section>
    <%@include file="Footer.jsp" %>
        <script src="../Assets/jQuery/jQuery.js"></script>
        <script>
                        function getPlace(did) {
                            //alert(did);
                            $.ajax({
                                url: "../Assets/AjaxPages/Ajaxplace.jsp?did=" + did,
                                success: function(html) {
                                    $("#sel_place").html(html);
                                }
                            });
                            $.ajax({
                                url: "../Assets/AjaxPages/AjaxDistrictWorkSearch.jsp?did=" + did,
                                success: function(result) {
                                    $("#tableview").html(result);
                                }
                            });
                        }
                        function getPlacework(pid) {
                            //alert(pid);
                            $.ajax({
                                url: "../Assets/AjaxPages/AjaxPlaceWorkSearch.jsp?pid=" + pid,
                                success: function(html) {
                                    $("#tableview").html(html);
                                }
                            });
                        }
                        $(document).ready(function() {
                            $("#refresh").on("click", function (){
                                location.reload(true);
                            });
                        });
        </script>
    </body>
</html>

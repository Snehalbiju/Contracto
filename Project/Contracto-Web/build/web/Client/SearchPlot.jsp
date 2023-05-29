<%-- 
    Document   : SearchWork
    Created on : 18 Feb, 2023, 9:48:28 AM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Search Plot</title>
        <%@include file="Header.jsp" %>


    <div class="page-heading">
        <div class="page-title">
            <div class="row">
                <div class="col-12 col-md-6 order-md-1 order-last">
                    <h3>Search Plot</h3>
                </div>
                <div class="col-12 col-md-6 order-md-2 order-first">
                    <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="Homepage.jsp">Dashboard</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Search Plot</li>
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
                    String selQry = "select *from tbl_plot pl inner join tbl_landlord l on pl.landlord_id=l.landlord_id inner join "
                            + "tbl_place p on pl.place_id=p.place_id "
                            + "inner join tbl_district d on p.district_id=d.district_id";
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
                            } else if (rs.getInt("plot_status") == 2) {
                                out.print("Sold");
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
                            url: "../Assets/AjaxPages/AjaxDistrictPlotSearch.jsp?did=" + did,
                            success: function(result) {
                                $("#tableview").html(result);
                            }
                        });
                    }
                    function getPlacework(pid) {
                        //alert(pid);
                        $.ajax({
                            url: "../Assets/AjaxPages/AjaxPlacePlotSearch.jsp?pid=" + pid,
                            success: function(html) {
                                $("#tableview").html(html);
                            }
                        });
                    }
                    $(document).ready(function() {
                        $("#refresh").on("click", function() {
                            location.reload(true);
                        });
                    });
    </script>
</body>
</html>

<%-- 
    Document   : WorkerUploadAction
    Created on : 25 Jan, 2022, 12:53:07 PM
    Author     : asanj
--%>

<%@page import="java.sql.ResultSet"%>

<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<%@page import="org.apache.commons.fileupload.*" %>
<%@page import="org.apache.commons.fileupload.servlet.*" %>
<%@page import="org.apache.commons.fileupload.disk.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Contractor Action</title>
        <link rel="stylesheet" href="../CSS/sweetalert.css">
        <script src="../JS/sweetalert.min.js"></script>
    </head>
    <body>
        <%

            File savedFile = null;
            FileItem f_item = null;

            String field_name = "";
            String file_name = "";
            String fn = "";
            String proof="";

            String field[] = new String[20];
            String value[] = new String[20];

//checking if request cotains multipart data
            boolean isMultipart = ServletFileUpload.isMultipartContent(request);

            if (isMultipart) {
                System.out.println("ifff");

                FileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);

                //declaring a list of form fields
                List items_list = null;

                //assigning fields to list 'items_list'
                try {
                    items_list = upload.parseRequest(request);
                } catch (FileUploadException ex) {
                    out.println(ex);
                }

                //declaring iterator
                Iterator itr = items_list.iterator();
                int k = 0;
                //iterating through the list 'items_list'
                while (itr.hasNext()) {

                    //typecasting next element in items_list as fileitem
                    f_item = (FileItem) itr.next();

                    //checking if 'f_item' contains a formfield(common controls like textbox,dropdown,radio buttonetc)
                    if (f_item.isFormField()) {

                        //getting fieldname and value
                        field[k] = f_item.getFieldName();
                        value[k] = f_item.getString();

                        k++;
                    } else {

           //f_item=(FileItem)itr.next();
                        file_name = f_item.getName();
                        field_name = f_item.getFieldName();
                        if (field_name.equals("file_photo")) {
                            String ext = file_name.substring(file_name.lastIndexOf("."));
                            //setting path to store image
                            File proj_path = new File(config.getServletContext().getRealPath("/"));
                            String file_path = proj_path.getParentFile().getParentFile().getPath() + "\\web\\Assets\\Files\\ContractorPhoto\\";
                            Random r = new Random();
                            int r_num = r.nextInt(1111) + 999;

                            fn = "Contractor_" + r_num + ext;
                            //creating a file object
                            savedFile = new File(file_path + fn);
                            try {
                                //writing the file object
                                f_item.write(savedFile);

                            } catch (Exception ex) {
                                out.println(ex);
                            }
                        }
                         if (field_name.equals("file_proof")) {
                            String ext = file_name.substring(file_name.lastIndexOf("."));
                            //setting path to store image
                            File proj_path = new File(config.getServletContext().getRealPath("/"));
                            String file_path = proj_path.getParentFile().getParentFile().getPath() + "\\web\\Assets\\Files\\ContractorProof\\";
                            Random r = new Random();
                            int r_num = r.nextInt(1111) + 999;

                            proof = "Contractor_" + r_num + ext;
                            //creating a file object
                            savedFile = new File(file_path + proof);
                            try {
                                //writing the file object
                                f_item.write(savedFile);

                            } catch (Exception ex) {
                                out.println(ex);
                            }
                        }

                       

                    }

                }
    //Strinh str1="insert into tbl_wantedlist ()";
               
            if (value[7].equals(value[8])) {
                String str1 = "insert into tbl_contractor(contractor_name,contractor_email,contractor_contact,contractor_address,contractor_gender,"
                        + "contractor_photo,contractor_proof,place_id,"
                        + "contractor_password,contractor_doj)"
                        + "values('" + value[0] + "','" + value[1] + "','" + value[2] + "','" + value[6] + "','" + value[3] + "','" + fn + "','" + proof + "','" + value[5] + "','" + value[7] + "',curdate())";
                System.out.println(str1);

                boolean status = con.executeCommand(str1);

                if (status == true) {
                   
        %> 
        <script type="text/javascript" src="../JS/SweetAlert/RegistrationAlert.js"></script>
        <%             
            }
        } else {
        %>
        <script src="../JS/SweetAlert/Registration_Error.js"></script>
        <script type="text/javascript">
            setTimeout(function() {
                window.location.href = '../../Guest/NewClient.jsp'
            }, 2000);
        </script>         
        <%
                    }

                }
            

        %>
    </body>
</html>


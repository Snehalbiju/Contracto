/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package WB;

import DB.ConnectionClass;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebService;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author HP
 */
@WebService(serviceName = "NewWebService")
public class NewWebService {

    ConnectionClass con = new ConnectionClass();

    @WebMethod(operationName = "Login")
    public String Login(@WebParam(name = "email") String email, @WebParam(name = "password") String password) {

        String sel = "select * from tbl_contractor where contractor_email='" + email + "' and contractor_password='" + password + "'";
        System.err.println(sel);
        ResultSet rs = con.selectCommand(sel);
        System.out.println(sel);
        JSONArray j = new JSONArray();
        try {
            if (rs.next()) {
                JSONObject jo = new JSONObject();

                try {
                    jo.put("id", rs.getString("contractor_id"));
                    jo.put("name", rs.getString("contractor_name"));

                    j.put(jo);
                } catch (JSONException ex) {
                    Logger.getLogger(NewWebService.class.getName()).log(Level.SEVERE, null, ex);
                }

            }
        } catch (SQLException ex) {
            Logger.getLogger(NewWebService.class.getName()).log(Level.SEVERE, null, ex);
        }
        return j.toString();
    }
    
    
    @WebMethod(operationName = "GetDistrict")
    public String GetDistrict() {
        //TODO write your implementation code here:
        String sel = "select * from tbl_district ";
        ResultSet rs = con.selectCommand(sel);
        JSONArray j = new JSONArray();
        try {
            while (rs.next()) {
                JSONObject jo = new JSONObject();
                {
                    try {
                        jo.put("did", rs.getString("district_id"));
                        jo.put("dname", rs.getString("district_name"));
                        j.put(jo);
                    } catch (JSONException ex) {
                        Logger.getLogger(NewWebService.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(NewWebService.class.getName()).log(Level.SEVERE, null, ex);
        }
        return j.toString();
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "GetPlace")
    public String GetPlace(@WebParam(name = "district") String district) {
        //TODO write your implementation code here:
        String sel = "select * from tbl_place where district_id='" + district + "'";
        ResultSet rs = con.selectCommand(sel);
       
        JSONArray j = new JSONArray();
        {
            try {
                while (rs.next()) {
                    JSONObject jo = new JSONObject();
                    {
                        try {
                            jo.put("pid", rs.getString("place_id"));
                            jo.put("pname", rs.getString("place_name"));
                            j.put(jo);
                        } catch (JSONException ex) {
                            Logger.getLogger(NewWebService.class.getName()).log(Level.SEVERE, null, ex);
                        }

                    }
                }
            } catch (SQLException ex) {
                Logger.getLogger(NewWebService.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return j.toString();
    }
    
    @WebMethod(operationName = "GetUserData")
    public String GetUserData(@WebParam(name = "id") String id) {
        String sel = "select contractor_id,contractor_name,contractor_contact,contractor_photo from tbl_contractor where contractor_id='" + id + "'";
        ResultSet rs = con.selectCommand(sel);
        JSONArray j = new JSONArray();
        try {
            if (rs.next()) {
                JSONObject jo = new JSONObject();
                try {
                    jo.put("id", rs.getString("contractor_id"));
                    jo.put("name", rs.getString("contractor_name"));
                    jo.put("contact", rs.getString("contractor_contact"));
                    jo.put("photo", rs.getString("contractor_photo"));

                    j.put(jo);
                } catch (JSONException ex) {
                    Logger.getLogger(NewWebService.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(NewWebService.class.getName()).log(Level.SEVERE, null, ex);
        }
        return j.toString();
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "GetFullUserData")
    public String GetFullUserData(@WebParam(name = "id") String id) {
       
        String sel = "select *from tbl_contractor c inner join tbl_place p on p.place_id=c.place_id inner join tbl_district d on d.district_id=p.district_id where c.contractor_id='" + id + "'";
        ResultSet rs = con.selectCommand(sel);
        JSONArray j = new JSONArray();
        try {
            if (rs.next()) {
                JSONObject jo = new JSONObject();
                try {
                    jo.put("id", rs.getString("contractor_id"));
                    jo.put("name", rs.getString("contractor_name"));
                    jo.put("email", rs.getString("contractor_email"));
                    jo.put("contact", rs.getString("contractor_contact"));
                    jo.put("gender", rs.getString("contractor_gender"));
                    jo.put("address", rs.getString("contractor_address"));
                    jo.put("district", rs.getString("district_name"));
                    jo.put("place", rs.getString("place_name"));
                    jo.put("photo", rs.getString("contractor_photo"));

                    j.put(jo);
                } catch (JSONException ex) {
                    Logger.getLogger(NewWebService.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(NewWebService.class.getName()).log(Level.SEVERE, null, ex);
        }
        return j.toString();
    }
    
    
    @WebMethod(operationName = "ChangePassword")
    public String ChangePassword(@WebParam(name = "CurrentPassword") String CurrentPassword, @WebParam(name = "NewPassword") String NewPassword, @WebParam(name = "RePassword") String RePassword, @WebParam(name = "id") String id) {
        String sel = "", cp = "", result = "";
        sel = "select contractor_password from tbl_contractor where contractor_id='" + id + "'";
        ResultSet rs = con.selectCommand(sel);
        try {
            if (rs.next()) {
                cp = rs.getString("contractor_password");
            }

            if (cp.equals(CurrentPassword)) {
                if (NewPassword.equals(RePassword)) {
                    String edit = "update tbl_contractor set contractor_password='" + NewPassword + "' where contractor_id='" + id + "'";
                    con.executeCommand(edit);
                    System.out.println(edit);
                    result = "Succesfuly Changed";
                } else {
                    result = "New Password Missmatched";
                }
            } else {
                result = "Current Password Missmatched";
            }
        } catch (SQLException ex) {
            Logger.getLogger(NewWebService.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }
    
    
    @WebMethod(operationName = "Complaint")
    public String Complaint(@WebParam(name = "Title") String Title, @WebParam(name = "Description") String Description, @WebParam(name = "id") String id) {
        String result = "";
        if(Title.equals("") || Description.equals("")){
            result = "Insertion Faild";
        }else{
            String ins = "insert into tbl_complaint (complaint_title,complaint_description,complaint_date,contractor_id) values ('"+Title+"','"+Description+"',curdate(),'"+id+"')";
            boolean status = con.executeCommand(ins);
            System.out.println(ins);
            if (status == true) {
                result = "Inserted Successfully";
            } else {
                result = "Insertion Faild";
            }
        }
        return result;
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "GetWork")
    public String GetWork(@WebParam(name = "district") String district, @WebParam(name = "place") String place) {
       String sel = "select *from tbl_work w inner join tbl_category c on w.category_id=c.category_id inner join tbl_client cl on w.client_id=cl.client_id inner join tbl_place p on w.place_id=p.place_id inner join tbl_district d on p.district_id=d.district_id where true";
        
       if(!district.equals(""))
       {
           sel = sel+" and d.district_id='"+district+"'";
       }
       
       if(!place.equals(""))
       {
           sel = sel+" and p.place_id='"+place+"'";
       }
       
       ResultSet rs = con.selectCommand(sel);
        JSONArray j = new JSONArray();
        try {
            while (rs.next()) {
                JSONObject jo = new JSONObject();
                try {
                    jo.put("workid", rs.getString("work_id"));
                    jo.put("id", rs.getString("client_id"));
                    jo.put("name", rs.getString("client_name"));
                    jo.put("category", rs.getString("category_name"));
                    jo.put("district", rs.getString("district_name"));
                    jo.put("place", rs.getString("place_name"));
                    jo.put("status", rs.getString("work_status"));
                    jo.put("photo", rs.getString("client_photo"));
                    
                    j.put(jo);
                } catch (JSONException ex) {
                    Logger.getLogger(NewWebService.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(NewWebService.class.getName()).log(Level.SEVERE, null, ex);
        }
        return j.toString();
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "GetWorkHome")
    public String GetWorkHome() {
        String sel = "select *from tbl_work w inner join tbl_category c on w.category_id=c.category_id inner join tbl_client cl on w.client_id=cl.client_id inner join tbl_place p on w.place_id=p.place_id inner join tbl_district d on p.district_id=d.district_id limit 10"; 
        ResultSet rs = con.selectCommand(sel);
        JSONArray j = new JSONArray();
        try {
            while (rs.next()) {
                JSONObject jo = new JSONObject();
                try {
                    jo.put("workid", rs.getString("work_id"));
                    jo.put("id", rs.getString("client_id"));
                    jo.put("name", rs.getString("client_name"));
                    jo.put("category", rs.getString("category_name"));
                    jo.put("district", rs.getString("district_name"));
                    jo.put("place", rs.getString("place_name"));
                    jo.put("status", rs.getString("work_status"));
                    jo.put("photo", rs.getString("client_photo"));
                    
                    j.put(jo);
                } catch (JSONException ex) {
                    Logger.getLogger(NewWebService.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(NewWebService.class.getName()).log(Level.SEVERE, null, ex);
        }
        return j.toString();
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "RequestWork")
    public String RequestWork(@WebParam(name = "id") String Id, @WebParam(name = "workid") String WorkId, @WebParam(name = "Description") String Description, @WebParam(name = "date") String Date) {
        
        String result="";
        String workstatus="";
        String sel="select work_status from tbl_work where work_id='"+WorkId+"'";
        ResultSet rs = con.selectCommand(sel);
        try{
            rs.next();
            workstatus=rs.getString("work_status");
            if(workstatus.equals("2")){
                result="No longer accepting";
            }
            else{
                String selQry = "select * from tbl_workrequest where work_id=" + WorkId + " and contractor_id=" + Id + "";
                ResultSet rs1 = con.selectCommand(selQry);
                try{
                    if (rs1.next()) {

                        result="You have already applied";
                    }
                    else{
                        String upQry = "update tbl_work set work_status=1 where work_id='" + WorkId+ "'";
                        con.executeCommand(upQry);
                        String ins = "insert into tbl_workrequest(request_details,work_id,contractor_id,request_date) values ('"+Description+"','"+WorkId+"','"+Id+"','"+Date+"')";
                        boolean status = con.executeCommand(ins);
                        System.out.println(ins);
                        if (status == true) {
                            result = "Inserted Successfully";
                        } else {
                            result = "Insertion Faild";
                        }
                    }
                }catch (SQLException ex) {
                    Logger.getLogger(NewWebService.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }catch (SQLException ex) {
                    Logger.getLogger(NewWebService.class.getName()).log(Level.SEVERE, null, ex);
                }
        return result;
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "ViewJob")
    public String ViewJob(@WebParam(name = "workid") String workid) {
        String sel = "select *from tbl_work w inner join tbl_category c on w.category_id=c.category_id inner join tbl_client cl on w.client_id=cl.client_id inner join tbl_place p on w.place_id=p.place_id inner join tbl_district d on p.district_id=d.district_id where w.work_id='" + workid + "'";
        ResultSet rs = con.selectCommand(sel);
        System.out.println(sel);
        JSONArray j = new JSONArray();
        try {
            if (rs.next()) {
                JSONObject jo = new JSONObject();
                try {
                    jo.put("name", rs.getString("client_name"));
                    jo.put("category", rs.getString("category_name"));
                    jo.put("district", rs.getString("district_name"));
                    jo.put("place", rs.getString("place_name"));
                    jo.put("details", rs.getString("work_details"));
                    jo.put("date", rs.getString("work_date"));
                    jo.put("wphoto", rs.getString("work_photo"));
                    jo.put("cphoto", rs.getString("client_photo"));

                    j.put(jo);
                } catch (JSONException ex) {
                    Logger.getLogger(NewWebService.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(NewWebService.class.getName()).log(Level.SEVERE, null, ex);
        }
        return j.toString();
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "GetRequestDetails")
    public String GetRequestDetails(@WebParam(name = "id") String id) {
        String sel = "select *from tbl_workrequest wr inner join tbl_work w on wr.work_id=w.work_id inner join tbl_client c on w.client_id=c.client_id inner join tbl_category ct on w.category_id=ct.category_id inner join tbl_place p on w.place_id=p.place_id inner join tbl_district d on p.district_id=d.district_id where wr.contractor_id='"+id+"'"; 
        ResultSet rs = con.selectCommand(sel);
        JSONArray j = new JSONArray();
        try {
            while (rs.next()) {
                JSONObject jo = new JSONObject();
                try {
                    jo.put("name", rs.getString("client_name"));
                    jo.put("phone", rs.getString("client_contact"));
                    jo.put("category", rs.getString("category_name"));
                    jo.put("district", rs.getString("district_name"));
                    jo.put("place", rs.getString("place_name"));
                    jo.put("status", rs.getString("request_status"));
                    jo.put("cphoto", rs.getString("client_photo"));
                    jo.put("wphoto", rs.getString("work_photo"));
                    
                    j.put(jo);
                } catch (JSONException ex) {
                    Logger.getLogger(NewWebService.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(NewWebService.class.getName()).log(Level.SEVERE, null, ex);
        }
        return j.toString();
    }
}
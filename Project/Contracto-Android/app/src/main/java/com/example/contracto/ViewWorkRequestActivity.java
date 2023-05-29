package com.example.contracto;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.MenuItem;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

public class ViewWorkRequestActivity extends AppCompatActivity {

    RecyclerView mrecyclerView;

    String Id;

    String name[],category[],district[],place[],status[],cphoto[],wphoto[],phone[];

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_view_work_request);

        mrecyclerView=findViewById(R.id.RequestRecyclerView);

        SharedPreferences sh=getSharedPreferences("contractor",MODE_PRIVATE);
        Id = sh.getString("id","");

        GetRequestDetails grd=new GetRequestDetails();
        grd.execute(Id);
    }

    public class GetRequestDetails extends AsyncTask<String, String, String> {


        @Override
        protected String doInBackground(String... strings) {
            WebServiceCaller wb = new WebServiceCaller();
            wb.setSoapObject("GetRequestDetails");
            wb.addProperty("id", strings[0]);;
            wb.callWebService();
            return wb.getResponse();
        }

        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);
            JSONArray j = null;
            try {
                j = new JSONArray(s);
                name= new String[j.length()];
                phone= new String[j.length()];
                category= new String[j.length()];
                district= new String[j.length()];
                place= new String[j.length()];
                status= new String[j.length()];
                cphoto= new String[j.length()];
                wphoto= new String[j.length()];
                for (int i = 0; i <= j.length(); i++) {
                    JSONObject jo = j.getJSONObject(i);
                    name[i] = jo.getString("name");
                    phone[i] = jo.getString("phone");
                    category[i] = jo.getString("category");
                    district[i] = jo.getString("district");
                    place[i] = jo.getString("place");
                    status[i] = jo.getString("status");
                    cphoto[i] = jo.getString("cphoto");
                    wphoto[i] = jo.getString("wphoto");
                }

            }catch (JSONException e) {
                e.printStackTrace();
            }

            JobRequestAdapter adapter=new JobRequestAdapter(ViewWorkRequestActivity.this,name,phone,category,district,place,status,cphoto,wphoto);
            mrecyclerView.setAdapter(adapter);
            mrecyclerView.setLayoutManager(new LinearLayoutManager(ViewWorkRequestActivity.this));
        }
    }
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        if (item.getItemId() == android.R.id.home) {
            onBackPressed();
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    @Override
    public void onBackPressed() {
        Intent intent = new Intent(this, HomeActivity.class);
        startActivity(intent);
        finish();
    }

}
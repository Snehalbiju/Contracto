package com.example.contracto;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.AutoCompleteTextView;
import android.widget.Toast;

import com.google.android.material.bottomnavigation.BottomNavigationView;
import com.google.android.material.navigation.NavigationBarView;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;


public class SearchActivity extends AppCompatActivity  {

    BottomNavigationView nav;


    AutoCompleteTextView find_district,find_place;
    ArrayAdapter<String> districtadapter;
    ArrayAdapter<String> placeadapter;
    String distid[], distname[];
    String placeid[], placename[];
    String districtid,place_id;
    RecyclerView mrecyclerView;
    String name[],category[],district[],place[],status[],photo[],work_id[];

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_search);

        nav=findViewById(R.id.bottombar);
        nav.setSelectedItemId(R.id.search);
        mrecyclerView=findViewById(R.id.RecyclerView);

        GetWork gw = new GetWork();
        gw.execute("","");

        GetDistrict gd = new GetDistrict();
        gd.execute();
        find_district=(AutoCompleteTextView)findViewById(R.id.find_district);
        find_place=(AutoCompleteTextView) findViewById(R.id.find_place);

        find_district.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                districtid = distid[position];
                GetPlace gp = new GetPlace();
                gp.execute(districtid);

                GetWork gw = new GetWork();
                gw.execute(districtid,"");
            }
        });
        find_place.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                place_id = placeid[position];

                GetWork gw = new GetWork();
                gw.execute("",place_id);
            }
        });
        nav.setOnItemSelectedListener(new NavigationBarView.OnItemSelectedListener() {
            @Override
            public boolean onNavigationItemSelected(@NonNull MenuItem item) {

                switch (item.getItemId()){
                    case R.id.home:
                        startActivity(new Intent(getApplicationContext(),HomeActivity.class));
                        overridePendingTransition(0,0);
                        return true;
                    case R.id.chat:
                        startActivity(new Intent(getApplicationContext(),ChatActivity.class));
                        overridePendingTransition(0,0);
                        return true;
                    case R.id.search:
                        return true;
                    case R.id.profile:
                        startActivity(new Intent(getApplicationContext(),ProfileActivity.class));
                        overridePendingTransition(0,0);
                        return true;
                }
                return false;
            }
        });
    }


    public class GetWork extends AsyncTask<String, String, String> {


        @Override
        protected String doInBackground(String... strings) {
            WebServiceCaller wb = new WebServiceCaller();
            wb.setSoapObject("GetWork");
            wb.addProperty("district", strings[0]);
            wb.addProperty("place", strings[1]);
            wb.callWebService();
            return wb.getResponse();
        }

        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);
            JSONArray j = null;
            try {
                j = new JSONArray(s);
                work_id=new String[j.length()];
                name= new String[j.length()];
                category= new String[j.length()];
                district= new String[j.length()];
                place= new String[j.length()];
                status= new String[j.length()];
                photo= new String[j.length()];
                for (int i = 0; i <= j.length(); i++) {
                    JSONObject jo = j.getJSONObject(i);
                    work_id[i] = jo.getString("workid");
                    name[i] = jo.getString("name");
                    category[i] = jo.getString("category");
                    district[i] = jo.getString("district");
                    place[i] = jo.getString("place");
                    status[i] = jo.getString("status");
                    photo[i] = jo.getString("photo");
                }

            }catch (JSONException e) {
                e.printStackTrace();
            }

            JobSearchAdapter adapter=new JobSearchAdapter(SearchActivity.this,name,category,district,place,status,photo,work_id);
            mrecyclerView.setAdapter(adapter);
            mrecyclerView.setLayoutManager(new LinearLayoutManager(SearchActivity.this));
        }
    }

    public class GetPlace extends AsyncTask<String, String, String> {


        @Override
        protected String doInBackground(String... strings) {
            WebServiceCaller wb = new WebServiceCaller();
            wb.setSoapObject("GetPlace");
            wb.addProperty("district", strings[0]);
            wb.callWebService();
            return wb.getResponse();
        }

        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);

            JSONArray j = null;
            try {
                j = new JSONArray(s);
                placeid = new String[j.length() + 1];
                placename = new String[j.length() + 1];
                placename[0] = "--Select--";
                placeid[0] = "";
                for (int i = 0; i < j.length(); i++) {
                    JSONObject jo = j.getJSONObject(i);
                    placeid[i + 1] = jo.getString("pid");
                    placename[i + 1] = jo.getString("pname");

                }
            } catch (JSONException e) {
                e.printStackTrace();
            }

            placeadapter = new ArrayAdapter<String>(getApplicationContext(), R.layout.dropdown_item, placename);
            find_place.setAdapter(placeadapter);
        }
    }

    public class GetDistrict extends AsyncTask<String, String, String> {

        @Override
        protected String doInBackground(String... strings) {
            WebServiceCaller wb = new WebServiceCaller();
            wb.setSoapObject("GetDistrict");
            wb.callWebService();
            return wb.getResponse();

        }

        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);
            JSONArray j = null;
            try {
                j = new JSONArray(s);
                distid = new String[j.length() + 1];
                distname = new String[j.length() + 1];
                distname[0] = "--Select--";
                distid[0] = "";
                for (int i = 0; i < j.length(); i++) {
                    JSONObject jo = j.getJSONObject(i);
                    distid[i + 1] = jo.getString("did");
                    distname[i + 1] = jo.getString("dname");

                }
            } catch (JSONException e) {
                e.printStackTrace();
            }

            districtadapter = new ArrayAdapter<String>(getApplicationContext(), R.layout.dropdown_item, distname);
            find_district.setAdapter(districtadapter);

        }
    }

    @Override
    public void onBackPressed() {
        Intent intent = new Intent(this, HomeActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(intent);
        finish();
    }

}
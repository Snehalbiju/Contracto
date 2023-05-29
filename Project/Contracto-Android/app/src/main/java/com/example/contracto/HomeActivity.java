package com.example.contracto;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.cardview.widget.CardView;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.MenuItem;
import android.view.View;
import android.widget.TextView;

import com.google.android.material.bottomnavigation.BottomNavigationView;
import com.google.android.material.navigation.NavigationBarView;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class HomeActivity extends AppCompatActivity {

    BottomNavigationView nav;

    RecyclerView mrecyclerView;

    String name[],category[],place[],status[],photo[],work_id[],district[];
    TextView home_date;

    CardView view_job_request;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);
        home_date= (TextView) findViewById(R.id.homedate);
        Date currenttime= Calendar.getInstance().getTime();
        String formatdate= DateFormat.getDateInstance(DateFormat.FULL).format(currenttime);
        home_date.setText(formatdate);

        view_job_request=findViewById(R.id.card_viewrequest);
        view_job_request.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent view_job_requestIntent=new Intent(getApplicationContext(),ViewWorkRequestActivity.class);
                startActivity(view_job_requestIntent);
                finish();
            }
        });

        mrecyclerView=findViewById(R.id.HomeRecyclerView);
        GetWorkHome gwh=new GetWorkHome();
        gwh.execute();

        nav=findViewById(R.id.bottombar);
        nav.setSelectedItemId(R.id.home);

        nav.setOnItemSelectedListener(new NavigationBarView.OnItemSelectedListener() {
            @Override
            public boolean onNavigationItemSelected(@NonNull MenuItem item) {

                switch (item.getItemId()){
                    case R.id.home:
                        return true;
                    case R.id.chat:
                        Intent chat_intent = new Intent(HomeActivity.this, ChatActivity.class);
                        chat_intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK);
                        startActivity(chat_intent);
                        overridePendingTransition(5000,5000);
                        return true;
                    case R.id.search:
                        Intent search_intent = new Intent(HomeActivity.this, SearchActivity.class);
                        search_intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK);
                        startActivity(search_intent);
                        overridePendingTransition(5000,5000);
                        return true;
                    case R.id.profile:
                        Intent profile_intent = new Intent(HomeActivity.this, ProfileActivity.class);
                        profile_intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK);
                        startActivity(profile_intent);
                        overridePendingTransition(5000,5000);
                        return true;
                }
                return false;
            }
        });
    }
    public class GetWorkHome extends AsyncTask<String, String, String> {


        @Override
        protected String doInBackground(String... strings) {
            WebServiceCaller wb = new WebServiceCaller();
            wb.setSoapObject("GetWorkHome");
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

            HomeJobAdapter adapter=new HomeJobAdapter(HomeActivity.this,name,category,district,place,status,photo,work_id);
            mrecyclerView.setAdapter(adapter);
            mrecyclerView.setLayoutManager(new LinearLayoutManager(HomeActivity.this));
        }
    }
}
package com.example.contracto;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.MenuItem;
import android.widget.TextView;
import android.widget.Toast;

import com.squareup.picasso.Picasso;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import de.hdodenhof.circleimageview.CircleImageView;

public class MyProfileActivity extends AppCompatActivity {

    TextView cname,cemail,cphone,cgender,caddress,clocation;
    String Id, Name, Contact,Email,Gender,Address,District,Place;

    String ip=WebServiceCaller.ip;

    String imgString="http://"+ip+":8084/Contracto/Assets/Files/ContractorPhoto/";
    CircleImageView img;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_my_profile);
        ColorDrawable colorDrawable = new ColorDrawable(Color.parseColor("#FECE2F"));
        // Set BackgroundDrawable
        getSupportActionBar().setBackgroundDrawable(colorDrawable);


        SharedPreferences sh=getSharedPreferences("contractor",MODE_PRIVATE);
        Id = sh.getString("id","");

        GetFullUserData gfud = new GetFullUserData();
        gfud.execute(Id);

        cname=(TextView) findViewById(R.id.con_name);
        cemail=(TextView) findViewById(R.id.con_email);
        cphone=(TextView) findViewById(R.id.con_contact);
        cgender=(TextView) findViewById(R.id.con_gender);
        caddress=(TextView) findViewById(R.id.con_address);
        clocation=(TextView) findViewById(R.id.con_place);

        img=findViewById(R.id.con_image);


    }
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        if (item.getItemId() == android.R.id.home) {
            onBackPressed();
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    private class GetFullUserData extends AsyncTask<String, Void, String> {
        @Override
        protected String doInBackground(String... strings) {
            WebServiceCaller wb = new WebServiceCaller();
            wb.setSoapObject("GetFullUserData");
            wb.addProperty("id", strings[0]);
            wb.callWebService();
            return wb.getResponse();
        }

        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);
            try {
                JSONArray jsonArray = new JSONArray(s);
                JSONObject jsonObject = jsonArray.getJSONObject(0);

                Name = jsonObject.getString("name");
                Email = jsonObject.getString("email");
                Contact = jsonObject.getString("contact");
                Gender = jsonObject.getString("gender");
                Address = jsonObject.getString("address");
                District = jsonObject.getString("district");
                Place = jsonObject.getString("place");

                String imageString = jsonObject.getString("photo");
                String imageUrl = imgString+imageString;
                Picasso.get()
                        .load(imageUrl)
                        .into(img);

                cname.setText(Name);
                cemail.setText(Email);
                cphone.setText(Contact);
                cgender.setText(Gender);
                caddress.setText(Address);
                clocation.setText(Place+", "+District);

            } catch (JSONException e) {
                e.printStackTrace();
            }
        }
    }
    @Override
    public void onBackPressed() {
        Intent intent = new Intent(this, ProfileActivity.class);
        startActivity(intent);
        finish();
    }
}
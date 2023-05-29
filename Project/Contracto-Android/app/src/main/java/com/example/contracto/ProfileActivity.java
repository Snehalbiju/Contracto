package com.example.contracto;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.cardview.widget.CardView;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.MenuItem;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.material.bottomnavigation.BottomNavigationView;
import com.google.android.material.navigation.NavigationBarView;
import com.squareup.picasso.Picasso;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import de.hdodenhof.circleimageview.CircleImageView;

public class ProfileActivity extends AppCompatActivity {

    TextView cname,cphone;
    String Id, Name, Contact;

    String ip=WebServiceCaller.ip;

    String imgString="http://"+ip+":8084/Contracto/Assets/Files/ContractorPhoto/";
    CircleImageView img;
    CardView myprofile,changepassword,feedback,complaint,logout;
    BottomNavigationView nav;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_profile);

        SharedPreferences sh=getSharedPreferences("contractor",MODE_PRIVATE);
        Id = sh.getString("id","");

        GetUserData gud = new GetUserData();
        gud.execute(Id);

        cname = findViewById(R.id.contractor_name);
        cphone = findViewById(R.id.contractor_contact);
        img=findViewById(R.id.profile_image);

        nav=findViewById(R.id.bottombar);
        nav.setSelectedItemId(R.id.profile);

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
                        startActivity(new Intent(getApplicationContext(),SearchActivity.class));
                        overridePendingTransition(0,0);
                        return true;
                    case R.id.profile:
                        return true;
                }
                return false;
            }
        });

        myprofile=findViewById(R.id.myprofile);
        myprofile.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent myprofileIntent=new Intent(getApplicationContext(),MyProfileActivity.class);
                startActivity(myprofileIntent);
                finish();
            }
        });

        changepassword=findViewById(R.id.changepassword);
        changepassword.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent chpasswdIntent=new Intent(getApplicationContext(),ChangePasswordActivity.class);
                startActivity(chpasswdIntent);
                finish();
            }
        });

        feedback=findViewById(R.id.feedback);
        feedback.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent feedbackIntent=new Intent(getApplicationContext(), AboutActivity.class);
                startActivity(feedbackIntent);
                finish();
            }
        });

        complaint=findViewById(R.id.complaint);
        complaint.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent complaintIntent=new Intent(getApplicationContext(),ComplaintActivity.class);
                startActivity(complaintIntent);
                finish();
            }
        });

        logout=findViewById(R.id.log_out);
        logout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                SharedPreferences preferences = getSharedPreferences("contractor", MODE_PRIVATE);
                SharedPreferences.Editor editor = preferences.edit();
                editor.remove("id");
                editor.remove("name");
                editor.apply();

                Intent logoutIntent=new Intent(getApplicationContext(),LoginActivity.class);
                startActivity(logoutIntent);
                finish();
            }
        });
    }



    private class GetUserData extends AsyncTask<String, Void, String> {
        @Override
        protected String doInBackground(String... strings) {
            WebServiceCaller wb = new WebServiceCaller();
            wb.setSoapObject("GetUserData");
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
                Contact = jsonObject.getString("contact");
                String imageString = jsonObject.getString("photo");

                String imageUrl = imgString+imageString;

                Picasso.get()
                        .load(imageUrl)
                        .into(img);

                cname.setText(Name);
                cphone.setText(Contact);

                img.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        Intent intent=new Intent(getApplicationContext(),FullImageView.class);
                        intent.putExtra("zoom_image",imageUrl);
                        startActivity(intent);
                    }
                });

            } catch (JSONException e) {
                e.printStackTrace();
            }
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

package com.example.contracto;

import androidx.appcompat.app.AppCompatActivity;

import android.app.Dialog;
import android.content.Intent;
import android.content.SharedPreferences;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.airbnb.lottie.LottieAnimationView;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class LoginActivity extends AppCompatActivity {

    LottieAnimationView loginbg_animation;
    TextView signupText;
    Button btn_login;
    String ip=WebServiceCaller.ip;
    String Email, Password;
    String id,name;

    EditText email,password;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        loginbg_animation= findViewById(R.id.loginbg_animation);
        getSupportActionBar().hide();


        email = findViewById(R.id.editText_email);
        password = findViewById(R.id.editText_password);

        signupText=findViewById(R.id.signupText);
        signupText.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String url = "http://"+ip+":8084/Contracto/Guest/NewContractor.jsp";
                Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(url));
                startActivity(intent);
                finish();
            }
        });


        btn_login=(Button) findViewById(R.id.loginButton);
        btn_login.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                Email = email.getText().toString();
                Password = password.getText().toString();

                LoginDetails l = new LoginDetails();
                l.execute(Email, Password);

            }
        });
    }
    public class LoginDetails extends AsyncTask<String, String, String> {

        @Override
        protected String doInBackground(String... strings) {
            WebServiceCaller wb = new WebServiceCaller();
            wb.setSoapObject("Login");
            wb.addProperty("email", strings[0]);
            wb.addProperty("password", strings[1]);
            wb.callWebService();
            return wb.getResponse();
        }

        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);
            if (!s.equals("[]")) {
                JSONArray j = null;
                try {
                    j = new JSONArray(s);
                    JSONObject jo = j.getJSONObject(0);
                    id = jo.getString("id");
                    name = jo.getString("name");


                    Toast.makeText(LoginActivity.this, "success", Toast.LENGTH_SHORT).show();


                    SharedPreferences.Editor sh = getSharedPreferences("contractor", MODE_PRIVATE).edit();
                    sh.putString("id", id);
                    sh.putString("name", name);


                    sh.apply();

                } catch (JSONException e) {
                    e.printStackTrace();
                }

                final LoadingDialog loginDialog= new LoadingDialog(LoginActivity.this);
                loginDialog.startLoadingDialog();
                Handler handler=new Handler();
                handler.postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        loginDialog.dismissDialog();
                        Intent intent=new Intent(LoginActivity.this,HomeActivity.class);
                        startActivity(intent);
                        finish();
                    }
                }, 3000);


            } else {
                final ErrorDialog errorDialog= new ErrorDialog(LoginActivity.this);
                errorDialog.startLoadingDialog();
                Handler handler=new Handler();
                handler.postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        errorDialog.dismissDialog();
                        Toast.makeText(LoginActivity.this, "Failed", Toast.LENGTH_SHORT).show();
                    }
                }, 2000);

            }
        }
    }

}
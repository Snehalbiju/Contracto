package com.example.contracto;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class ChangePasswordActivity extends AppCompatActivity {

    String Id;

    EditText cp,np,rp;

    Button update;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_change_password);
        ColorDrawable colorDrawable = new ColorDrawable(Color.parseColor("#FECE2F"));
        // Set BackgroundDrawable
        getSupportActionBar().setBackgroundDrawable(colorDrawable);

        SharedPreferences sh=getSharedPreferences("contractor",MODE_PRIVATE);
        Id = sh.getString("id","");

        cp=(EditText) findViewById(R.id.current_passwd);
        np=(EditText) findViewById(R.id.new_passwd);
        rp=(EditText) findViewById(R.id.retype_password);
        update=(Button) findViewById(R.id.changepasswordButton);

        update.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String cpass,npass,rpass,id;
                cpass = cp.getText().toString();
                npass = np.getText().toString();
                rpass = rp.getText().toString();
                id=Id;

                changePassword CP = new changePassword();
                CP.execute(id,cpass,npass,rpass);
            }
        });
    }

    public class changePassword extends AsyncTask<String, String, String> {


        @Override
        protected String doInBackground(String... strings) {
            WebServiceCaller wb = new WebServiceCaller();
            wb.setSoapObject("ChangePassword");
            wb.addProperty("id", strings[0]);
            wb.addProperty("CurrentPassword", strings[1]);
            wb.addProperty("NewPassword", strings[2]);
            wb.addProperty("RePassword", strings[3]);
            wb.callWebService();
            return wb.getResponse();
        }

        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);

            if(s.equals("Succesfuly Changed")){
                final SuccessDialog successDialog= new SuccessDialog(ChangePasswordActivity.this);
                successDialog.startLoadingDialog();
                Handler handler=new Handler();
                handler.postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        successDialog.dismissDialog();
                        Toast.makeText(ChangePasswordActivity.this, s, Toast.LENGTH_SHORT).show();
                    }
                }, 2000);
            }
            if(s.equals("New Password Missmatched") || s.equals("Current Password Missmatched")){
                final ErrorDialog errorDialog= new ErrorDialog(ChangePasswordActivity.this);
                errorDialog.startLoadingDialog();
                Handler handler=new Handler();
                handler.postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        errorDialog.dismissDialog();
                        Toast.makeText(ChangePasswordActivity.this, s, Toast.LENGTH_SHORT).show();
                    }
                }, 2000);
            }
            cp.setText("");
            np.setText("");
            rp.setText("");
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
        Intent intent = new Intent(this, ProfileActivity.class);
        startActivity(intent);
        finish();
    }

}

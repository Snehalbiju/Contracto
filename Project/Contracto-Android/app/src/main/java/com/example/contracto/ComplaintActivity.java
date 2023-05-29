package com.example.contracto;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

import com.google.android.material.textfield.TextInputEditText;

public class ComplaintActivity extends AppCompatActivity {

    String Id;

    TextInputEditText title,description;

    Button submit;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_complaint);

        SharedPreferences sh=getSharedPreferences("contractor",MODE_PRIVATE);
        Id = sh.getString("id","");

        title=(TextInputEditText) findViewById(R.id.txt_complainttitle);
        description=(TextInputEditText) findViewById(R.id.txt_complaint);
        submit=(Button) findViewById(R.id.submit_complaint);

        submit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String id,ctitle,cdescription;
                id=Id;
                ctitle=title.getText().toString();
                cdescription=description.getText().toString();

                Complaint c = new Complaint();
                c.execute(id,ctitle,cdescription);
            }
        });
    }

    public class Complaint extends AsyncTask<String, String, String> {


        @Override
        protected String doInBackground(String... strings) {
            WebServiceCaller wb = new WebServiceCaller();
            wb.setSoapObject("Complaint");
            wb.addProperty("id", strings[0]);
            wb.addProperty("Title", strings[1]);
            wb.addProperty("Description", strings[2]);
            wb.callWebService();
            return wb.getResponse();
        }

        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);
            if(s.equals("Inserted Successfully")){

                final SuccessDialog successDialog= new SuccessDialog(ComplaintActivity.this);
                successDialog.startLoadingDialog();
                Handler handler=new Handler();
                handler.postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        successDialog.dismissDialog();
                        Toast.makeText(ComplaintActivity.this, s, Toast.LENGTH_SHORT).show();
                    }
                }, 2000);
            }

            if(s.equals("Insertion Faild")){
                final ErrorDialog errorDialog= new ErrorDialog(ComplaintActivity.this);
                errorDialog.startLoadingDialog();
                Handler handler=new Handler();
                handler.postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        errorDialog.dismissDialog();
                        Toast.makeText(ComplaintActivity.this, s, Toast.LENGTH_SHORT).show();
                    }
                }, 2000);
            }
            title.setText("");
            description.setText("");
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
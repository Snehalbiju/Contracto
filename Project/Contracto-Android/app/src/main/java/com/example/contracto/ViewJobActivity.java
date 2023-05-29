package com.example.contracto;

import androidx.appcompat.app.AppCompatActivity;

import android.annotation.SuppressLint;
import android.app.DatePickerDialog;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.squareup.picasso.Picasso;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Locale;

public class ViewJobActivity extends AppCompatActivity {

    ImageView img;

    TextView cname,wcategory,wdetails,wlocation,wdate;
    EditText work_date,description;
    Calendar calendar;

    Button submit;
    String Id,work_id,Name,details,category,district,place,date;

    String imgStringw="http://"+WebServiceCaller.ip+":8084/Contracto/Assets/Files/WorkPhoto/";
    @SuppressLint("MissingInflatedId")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_view_job);

        work_id=getIntent().getStringExtra("workid");
        SharedPreferences sh=getSharedPreferences("contractor",MODE_PRIVATE);
        Id = sh.getString("id","");

        ViewJob vj=new ViewJob();
        vj.execute(work_id);

        img=(ImageView) findViewById(R.id.work_image);
        cname=(TextView)findViewById(R.id.c_name);
        wcategory=(TextView)findViewById(R.id.w_category);
        wdetails=(TextView)findViewById(R.id.w_details);
        wdate=(TextView)findViewById(R.id.w_date);
        wlocation=(TextView)findViewById(R.id.w_location);
        description=findViewById(R.id.work_description);
        work_date=findViewById(R.id.work_date);
        submit=(Button)findViewById(R.id.btn_workRequest);
        submit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                RequestWork rw=new RequestWork();
                rw.execute(Id,work_id,description.getText().toString(),work_date.getText().toString());
            }
        });
        calendar=Calendar.getInstance();
        DatePickerDialog.OnDateSetListener date=new DatePickerDialog.OnDateSetListener() {
            @Override
            public void onDateSet(DatePicker view, int year, int month, int day) {
                calendar.set(Calendar.YEAR,year);
                calendar.set(Calendar.MONTH,month);
                calendar.set(Calendar.DATE,day);
                updateLabel();
            }
        };

        work_date.setOnClickListener(v -> {
            new DatePickerDialog(ViewJobActivity.this,date,calendar.get(Calendar.YEAR),calendar.get(Calendar.MONTH),calendar.get(Calendar.DATE)).show();
        });
    }
    private void updateLabel() {
        String format="yyyy-MM-dd";
        SimpleDateFormat dateFormat=new SimpleDateFormat(format,Locale.US);
        work_date.setText(dateFormat.format(calendar.getTime()));
    }

    public class ViewJob extends AsyncTask<String ,String ,String >{

        @Override
        protected String doInBackground(String... strings) {
            WebServiceCaller wb = new WebServiceCaller();
            wb.setSoapObject("ViewJob");
            wb.addProperty("workid", strings[0]);
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
                category = jsonObject.getString("category");
                district = jsonObject.getString("district");
                place = jsonObject.getString("place");
                details=jsonObject.getString("details");
                date = jsonObject.getString("date");

                String imageStringw = jsonObject.getString("wphoto");
                String imageUrlw = imgStringw+imageStringw;
                Picasso.get()
                        .load(imageUrlw)
                        .into(img);
                img.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        Intent intent=new Intent(getApplicationContext(),FullImageView.class);
                        intent.putExtra("zoom_image",imageUrlw);
                        startActivity(intent);
                    }
                });
                cname.setText(Name);
                wcategory.setText(category);
                wdetails.setText(details);
                wdate.setText(date);
                wlocation.setText(place+", "+district);

            } catch (JSONException e) {
                e.printStackTrace();
            }
        }
    }

    public class RequestWork extends AsyncTask<String, String, String> {


        @Override
        protected String doInBackground(String... strings) {
            WebServiceCaller wb = new WebServiceCaller();
            wb.setSoapObject("RequestWork");
            wb.addProperty("id", strings[0]);
            wb.addProperty("workid", strings[1]);
            wb.addProperty("Description", strings[2]);
            wb.addProperty("date", strings[3]);
            wb.callWebService();
            return wb.getResponse();
        }

        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);
            if(s.equals("Inserted Successfully")){
                final SuccessDialog successDialog= new SuccessDialog(ViewJobActivity.this);
                successDialog.startLoadingDialog();
                Handler handler=new Handler();
                handler.postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        successDialog.dismissDialog();
                        Toast.makeText(ViewJobActivity.this, s, Toast.LENGTH_SHORT).show();
                    }
                }, 2000);
            }
            else{
                final ErrorDialog errorDialog= new ErrorDialog(ViewJobActivity.this);
                errorDialog.startLoadingDialog();
                Handler handler=new Handler();
                handler.postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        errorDialog.dismissDialog();
                        Toast.makeText(ViewJobActivity.this, s, Toast.LENGTH_SHORT).show();
                    }
                }, 2000);
            }
            work_date.setText("");
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
        Intent intent = new Intent(this, SearchActivity.class);
        startActivity(intent);
        finish();
    }
}
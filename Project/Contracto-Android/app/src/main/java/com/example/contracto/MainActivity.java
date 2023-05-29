package com.example.contracto;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.os.Handler;
import android.widget.TextView;
import android.widget.Toast;

import com.airbnb.lottie.LottieAnimationView;

public class MainActivity extends AppCompatActivity {

    TextView splash_text;
    LottieAnimationView lottie;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        SharedPreferences sh=getSharedPreferences("contractor",MODE_PRIVATE);
        String Id = sh.getString("id","");
//        Toast.makeText(this,Id,Toast.LENGTH_LONG).show();



        splash_text=findViewById(R.id.splash_text);
        lottie= findViewById(R.id.splash_animation);

        splash_text.animate().translationY(1000).setDuration(4000).setStartDelay(0);
        lottie.animate().translationY(200).setDuration(2000).setStartDelay(2000);
        getSupportActionBar().hide();
        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                if (Id.isEmpty()) {
                    Intent intent=new Intent(MainActivity.this,LoginActivity.class);
                    startActivity(intent);
                    finish();
                }
                else
                {
                    Intent intent=new Intent(MainActivity.this,HomeActivity.class);
                    startActivity(intent);
                    finish();
                }

            }
        },5000);
    }
}
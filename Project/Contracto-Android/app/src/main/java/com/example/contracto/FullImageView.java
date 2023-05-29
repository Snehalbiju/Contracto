package com.example.contracto;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;

import com.github.chrisbanes.photoview.PhotoView;
import com.squareup.picasso.Picasso;

public class FullImageView extends AppCompatActivity {

    PhotoView photoView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_full_image_view);

        getSupportActionBar().hide();

        photoView=findViewById(R.id.photo_view);

        String image=getIntent().getStringExtra("zoom_image");
        Picasso.get().load(image).into(photoView);
//        int image=getIntent().getIntExtra("zoom_image",0);
//        photoView.setImageResource(image);
    }
}
package com.kalios.trustcrypt;

import androidx.annotation.ColorInt;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;

import android.content.Intent;
import android.graphics.LinearGradient;
import android.graphics.Shader;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.os.Handler;
import android.view.View;
import android.widget.GridLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.denzcoskun.imageslider.ImageSlider;
import com.denzcoskun.imageslider.constants.ScaleTypes;
import com.denzcoskun.imageslider.models.SlideModel;

import java.util.ArrayList;

public class dashboard extends AppCompatActivity {

    private ImageSlider imageSlider;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_dashboard);

        // Image Slider------------------------->
        imageSlider = findViewById(R.id.image_slider);

        //imge model
        ArrayList<SlideModel>SlideModel=new ArrayList<SlideModel>();
        SlideModel.add(new SlideModel(R.drawable.one, ScaleTypes.FIT));
        SlideModel.add(new SlideModel(R.drawable.two, ScaleTypes.FIT));
        SlideModel.add(new SlideModel(R.drawable.three, ScaleTypes.FIT));
        SlideModel.add(new SlideModel(R.drawable.four, ScaleTypes.FIT));

        imageSlider.setImageList(SlideModel,ScaleTypes.FIT);
        // image slider over here

        // Set click listeners for each CardView in the GridLayout
        GridLayout dashboardItems = findViewById(R.id.dashboard_items);
        int childCount = dashboardItems.getChildCount();
        for (int i = 0; i < childCount; i++) {
            View cardView = dashboardItems.getChildAt(i);
            cardView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    // Perform actions based on the clicked CardView
                    // For example, show a toast message indicating the clicked feature
                    if (v.getId() == R.id.urlscanner_btn) {
                        startActivity(new Intent(dashboard.this, url_scan.class));
                    } else if (v.getId() == R.id.playstoreappscanner_btn) {
                        startActivity(new Intent(dashboard.this, googleplaystorescan.class));
                    } else if (v.getId() == R.id.unknownappscanner_btn) {
                        startActivity(new Intent(dashboard.this, unknownappscan.class));
                    } else if (v.getId() == R.id.reportapp_btn) {
                        startActivity(new Intent(dashboard.this, report_us.class));
                    }
                }
            });
        }
    }
}
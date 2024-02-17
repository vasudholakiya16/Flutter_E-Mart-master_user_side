package com.kalios.trustcrypt;

import androidx.appcompat.app.AppCompatActivity;

import android.annotation.SuppressLint;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

public class report_us extends AppCompatActivity {

    Button submitButtton;

    @SuppressLint("MissingInflatedId")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_report_us);

        submitButtton= findViewById(R.id.submit_btn);
        submitButtton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Toast.makeText(report_us.this, "Reported Successfully", Toast.LENGTH_SHORT).show();
            }
        });
    }
}
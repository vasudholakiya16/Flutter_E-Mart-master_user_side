package com.kalios.trustcrypt;

import androidx.appcompat.app.AppCompatActivity;

import android.annotation.SuppressLint;
import android.os.Bundle;
import android.os.Handler;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ProgressBar;
import android.widget.TextView;

import java.util.ArrayList;

public class url_scan extends AppCompatActivity {

    private Button urlScanButton;
    private ProgressBar progressBar;
    private TextView progressPercentageview;
    private TextView statusView;
    private EditText editTextUrl;
    private ArrayList<String> fraudKeywords;


    @SuppressLint("MissingInflatedId")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_url_scan);

        // finding view By Id :
        urlScanButton = findViewById(R.id.url_scan_btn);
        progressPercentageview = findViewById(R.id.progressTextView);
        progressBar = findViewById(R.id.progressBar);
        statusView = findViewById(R.id.url_scan_status);
        editTextUrl = findViewById(R.id.editTextUrl);
        fraudKeywords = new ArrayList<>();
        fraudKeywords.add("movie");
        fraudKeywords.add("vegamovies");
        fraudKeywords.add("malware");
        fraudKeywords.add("wanacry");
        fraudKeywords.add("adsware");

        urlScanButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String url = editTextUrl.getText().toString().trim();
                if (isValidUrl(url)) {
                    progressPercentageview.setText("0%");
                    progressBar.setProgress(0);
                    Handler handler = new Handler();
                    handler.postDelayed(new Runnable() {
                        @Override
                        public void run() {
                            set_progressbar();
                            checkForFraud(url); // Check for fraud after setting progress
                        }
                    }, 500);
                } else {
                    statusView.setText("Invalid URL");
                    statusView.setTextColor(getResources().getColor(R.color.red));
                    progressPercentageview.setText("0%");
                    progressBar.setProgress(0);
                }
            }
        });
    }

    void set_progressbar(){
        progressPercentageview.setText("10%");
        progressBar.setProgress(10);
    }
    private boolean isValidUrl(String url) {
        String urlPattern = "^(http(s)?://)?([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&=]*)?$";
        return url.matches(urlPattern);
    }
    private void checkForFraud(String url) {
        for (String keyword : fraudKeywords) {
            if (url.contains(keyword)) {
                statusView.setText("Fraud Detected");
                statusView.setTextColor(getResources().getColor(R.color.red));
                return;
            }
        }
        statusView.setText("No Fraud Detected");
        statusView.setTextColor(getResources().getColor(R.color.text_green));
    }
}
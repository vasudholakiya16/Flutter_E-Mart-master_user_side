package com.kalios.trustcrypt;

import static com.kalios.trustcrypt.R.color;
import static com.kalios.trustcrypt.R.id;
import static com.kalios.trustcrypt.R.layout;
import android.annotation.SuppressLint;
import android.os.Bundle;
import android.os.Handler;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ProgressBar;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import java.util.ArrayList;

public class googleplaystorescan extends AppCompatActivity {

    private Button playStoreAppScanButton;
    private ProgressBar progressBar;
    private TextView progressPercentageview;
    private TextView statusView;
    private EditText editTextAppName;

    @SuppressLint("MissingInflatedId")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(layout.activity_googleplaystorescan);

        playStoreAppScanButton = findViewById(id.playstoreapp_scan_btn);
        progressBar=findViewById(id.progressBar);
        progressPercentageview=findViewById(id.progressTextView);
        statusView =findViewById(id.playstoreapp_scan_status);
        editTextAppName = findViewById(id.editTextAppName);


        ArrayList<String> playStoreAppNames = new ArrayList<>();
        // Add app names to the playStoreAppNames list
        playStoreAppNames.add("facebook");
        playStoreAppNames.add("instagram");
        playStoreAppNames.add("bgmi");

        ArrayList<Integer> playStoreappSafePercentage = new ArrayList<>();
        // add app Safe Percentage here
        playStoreappSafePercentage.add(65);
        playStoreappSafePercentage.add(90);
        playStoreappSafePercentage.add(75);

        ArrayList<String> appDescription = new ArrayList<>();
        // Add app Description List
        appDescription.add("Safe \nIt's A Social Media App Popular Among Adults Due to Easy to Use UI");
        appDescription.add("Harmful \n It's A Social Media App Popular Among Teenager and Adults Too Due To its Reels Feature");
        appDescription.add("Not Safe \nIt's Multiplayer Game Which Shared user's data with multi Countries ");

        playStoreAppScanButton.setOnClickListener(new View.OnClickListener() {
            @SuppressLint("ResourceAsColor")
            @Override
            public void onClick(View v) {
                String appName = editTextAppName.getText().toString().trim().toLowerCase();
                if (appName.isEmpty()) {
                    statusView.setText("First Enter App Name");
                    statusView.setTextColor(getResources().getColor(R.color.red));
                    progressPercentageview.setText("0%");
                    progressBar.setProgress(0);
                } else {
                    int index = playStoreAppNames.indexOf(appName);
                    if (index != -1) {
                        int safePercentage = playStoreappSafePercentage.get(index);
                        String description = appDescription.get(index);

                        // Update UI with the matched values
                        progressPercentageview.setText(safePercentage + "%");
                        progressBar.setProgress(safePercentage);
                        statusView.setText(description);

                        if (safePercentage >= 70) {
                            statusView.setTextColor(getResources().getColor(color.red));
                        } else {
                            statusView.setTextColor(getResources().getColor(color.text_green));
                        }
                    } else {
                        statusView.setText("App Not Found");
                        statusView.setTextColor(color.black);
                        progressPercentageview.setText("0%");
                        progressBar.setProgress(0);
                    }
                }
            }
        });
    }
}
package com.kalios.trustcrypt;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.widget.TextView;

public class splashscreen extends AppCompatActivity {
    TextView copyrightmsg;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_splashscreen);

        copyrightmsg = findViewById(R.id.copyright_text);

        char copyrightSymbol = '\u00A9';
        String copy= String.valueOf(copyrightSymbol);

        copyrightmsg.setText("Copyright"+copy+"Kalios. All Rights Reserved");



        Thread thread = new Thread() {
            public void run() {
                try {
                    sleep(1000);//1000 = 1sec
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    Intent intent = new Intent(splashscreen.this, dashboard.class);
                    startActivity(intent);
                    finish();
                }
            }
        };thread.start();

    }
}
package com.kalios.trustcrypt;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.net.Uri;
import android.os.Bundle;
import android.provider.MediaStore;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class unknownappscan extends AppCompatActivity {
    private static final int REQUEST_CODE_PICK_FILE = 1001;

    Button browse_btn;
    EditText app_path;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_unknownappscan);

        browse_btn = findViewById(R.id.browse_btn);
        app_path = findViewById(R.id.app_path);
        browse_btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                openFilePicker();
            }
        });
    }

    private void openFilePicker() {
        Intent intent = new Intent(Intent.ACTION_GET_CONTENT);
        intent.setType("*/*"); // Accept all file types

        // Restrict the file types to .apk extension
        intent.putExtra(Intent.EXTRA_MIME_TYPES, new String[]{"application/vnd.android.package-archive"});

        startActivityForResult(intent, REQUEST_CODE_PICK_FILE);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if (requestCode == REQUEST_CODE_PICK_FILE && resultCode == Activity.RESULT_OK && data != null) {
            Uri fileUri = data.getData();

            if (fileUri != null && fileUri.toString().endsWith(".apk")) {
                String apkPath = getRealPathFromURI(fileUri);

                if (apkPath != null) {
                    String packageName = getPackageNameFromAPK(apkPath);

                    if (packageName != null) {
                        // Use the package name as needed
                        Toast.makeText(this, "Package Name: " + packageName, Toast.LENGTH_SHORT).show();
                    }
                }
            }
        }
    }

    private String getRealPathFromURI(Uri contentUri) {
        String[] projection = {MediaStore.Images.Media.DATA};
        Cursor cursor = getContentResolver().query(contentUri, projection, null, null, null);
        if (cursor != null) {
            int column_index = cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA);
            cursor.moveToFirst();
            String filePath = cursor.getString(column_index);
            cursor.close();
            return filePath;
        }
        return null;
    }

    private String getPackageNameFromAPK(String apkPath) {
        PackageManager pm = getPackageManager();
        PackageInfo packageInfo = pm.getPackageArchiveInfo(apkPath, PackageManager.GET_ACTIVITIES);
        if (packageInfo != null) {
            return packageInfo.packageName;
        }
        return null;
    }
}
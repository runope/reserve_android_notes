package com.example.native_asm;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.example.native_asm.databinding.ActivityMainBinding;

public class MainActivity extends AppCompatActivity {

    // Used to load the 'native_asm' library on application startup.
    static {
        System.loadLibrary("native_asm");
    }

    private ActivityMainBinding binding;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        binding = ActivityMainBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        // Example of a call to a native method
//        TextView tv = binding.sampleText;
//        tv.setText(stringFromJNI());

        Button btn = findViewById(R.id.button);
        btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                String filePath = getFilesDir() + "/asm.txt";
                String result = stringFromJNI(filePath);
                Log.e("my_asm", result);
            }
        });

    }

    /**
     * A native method that is implemented by the 'native_asm' native library,
     * which is packaged with this application.
     */
    public native String stringFromJNI(String filePath);
}
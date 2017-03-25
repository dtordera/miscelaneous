package com.real3d.demos;

import android.app.ListActivity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListAdapter;
import android.widget.ListView;

public class Real3DApiDemos extends ListActivity{
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        ListAdapter adapter = new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1,
                new String[] { "OpenGL", "Canvas", "Video", "CameraPreview", "CameraPreview+OpenGL" });
        setListAdapter(adapter);
    }
    
    @Override
    protected void onListItemClick(ListView l, View v, int position, long id) {
        Intent intent = new Intent();
        switch (position) {
        case 0:
            intent.setClass(this, com.real3d.demos.opengl.MainActivity.class);
            startActivity(intent);
            break;
        case 1:
            intent.setClass(this, com.real3d.demos.canvas.Real3DImageDemo.class);
            startActivity(intent);
            break;    
        case 2:
            intent.setClass(this, com.real3d.demos.video.MediaPlayerDemo.class);
            startActivity(intent);
            break;
        case 3:
            intent.setClass(this, com.real3d.demos.camera.CameraPreview.class);
            startActivity(intent);
            break;
        case 4:
            intent.setClass(this, com.real3d.demos.camera.CameraPreviewWithOpengl.class);
            startActivity(intent);
            break;    
        }
        super.onListItemClick(l, v, position, id);
    }
}
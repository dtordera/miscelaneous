package com.lge.R3Dsample;

import android.app.ListActivity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListAdapter;
import android.widget.ListView;

public class SampleAppList extends ListActivity{
	/** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        ListAdapter adapter = new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1,
                new String[] { "3DImages",
        					   "ImageSequence", 
        					   "GLbased Earth rotation", 
        					   "TinySample",
        					   "Icon depth view",
        					   "GB feature test"
        					   });
        setListAdapter(adapter);
        
    }
    
    @Override
    protected void onListItemClick(ListView l, View v, int position, long id) {
        Intent intent = new Intent();
        switch (position) {
        case 0:
            intent.setClass(this, com.lge.R3Dsample.R3Dpict.class);
            startActivity(intent);
            break;
        
        case 1:
        	intent.setClass(this, com.lge.R3Dsample.R3Dmovable.class);
            startActivity(intent);
            break;
          
        case 2:
            intent.setClass(this, com.lge.R3Dsample.EarthRotate.class);
            startActivity(intent);
            break;
        case 3:
            intent.setClass(this, com.lge.R3Dsample.TinySample.class);
            startActivity(intent);
            break;
        case 4:
            intent.setClass(this, com.lge.R3Dsample.ImagesActivity.class);
            startActivity(intent);
            break;
        case 5:
            intent.setClass(this, com.lge.R3Dsample.R3DSpace.class);
            startActivity(intent);
            break;
        }
        super.onListItemClick(l, v, position, id);
    }
}
package com.real3d.demos.opengl;

import com.lge.real3d.Real3D;
import com.lge.real3d.Real3DInfo;

import android.app.Activity;
import android.opengl.GLSurfaceView;
import android.os.Bundle;
import android.view.MotionEvent;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.SeekBar;
import android.widget.SeekBar.OnSeekBarChangeListener;

public class MainActivity extends Activity {

    private GLSurfaceView glSurfaceView;
    private GLTestRenderer renderer;
    private Real3D mReal3D;
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        FrameLayout layout = new FrameLayout(this);
        glSurfaceView = new GLSurfaceView(this);
        mReal3D = new Real3D(glSurfaceView.getHolder());
        mReal3D.setReal3DInfo(new Real3DInfo(true, Real3D.REAL3D_TYPE_SS, Real3D.REAL3D_ORDER_LR));
        renderer = new GLTestRenderer(this);
        glSurfaceView.setRenderer(renderer);
        glSurfaceView.setRenderMode(GLSurfaceView.RENDERMODE_CONTINUOUSLY);
        layout.addView(glSurfaceView, new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
        
        SeekBar seekBar = new SeekBar(this);
        seekBar.setMax(100);
        layout.addView(seekBar, new FrameLayout.LayoutParams(500, ViewGroup.LayoutParams.WRAP_CONTENT));
        
        seekBar.setOnSeekBarChangeListener(new OnSeekBarChangeListener(){

			public void onProgressChanged(SeekBar arg0, int arg1, boolean arg2) {
				renderer.mEyeDistance = (float)(arg1-50)*0.01f;
				
			}

			public void onStartTrackingTouch(SeekBar arg0) {
				// TODO Auto-generated method stub
				
			}

			public void onStopTrackingTouch(SeekBar arg0) {
				// TODO Auto-generated method stub
				
			}});
        setContentView(layout);
    }

    @Override
    protected void onResume() {
        super.onResume();
        glSurfaceView.onResume();
    }

    @Override
    protected void onPause() {
        super.onPause();
        glSurfaceView.onPause();
    }
    
    @Override
    public boolean onTouchEvent(MotionEvent event) {
        if (event.getAction() == MotionEvent.ACTION_DOWN) {
            renderer.toggle();
        }
        return super.onTouchEvent(event);
    }
}
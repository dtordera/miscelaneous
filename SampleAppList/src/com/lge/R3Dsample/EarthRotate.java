package com.lge.R3Dsample;

import com.lge.real3d.Real3D;
import com.lge.real3d.Real3DInfo;

import android.app.Activity;
import android.opengl.GLSurfaceView;
import android.os.Bundle;
import android.view.MotionEvent;

public class EarthRotate extends Activity {

    private GLSurfaceView glSurfaceView;
    private GLTestRenderer renderer;
    private Real3D mReal3D;
    private int	mCanvasWidth;
    private int	mCanvasHeight;
    private	float	dX = 0;
	private float	dY = 0;
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        glSurfaceView = new GLSurfaceView(this);
        mReal3D = new Real3D(glSurfaceView.getHolder());
        mReal3D.setReal3DInfo(new Real3DInfo(true, Real3D.REAL3D_TYPE_SS, Real3D.REAL3D_ORDER_LR));
        renderer = new GLTestRenderer(this);
        glSurfaceView.setRenderer(renderer);
        glSurfaceView.setRenderMode(GLSurfaceView.RENDERMODE_CONTINUOUSLY);
        setContentView(glSurfaceView);
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
    	float X = event.getX();
    	float Y = event.getY();
    	mCanvasWidth = glSurfaceView.getWidth();
    	mCanvasHeight = glSurfaceView.getHeight();
		//float mY = event.getY();
    	switch (event.getAction()) {
	    	case MotionEvent.ACTION_DOWN:
	    		dX = X;
	    		dY = Y;
	    		renderer.toggle();
				break;
			case MotionEvent.ACTION_MOVE:
				if(dX != 0)
					renderer.setTouchMove(X - dX, (Y - mCanvasHeight/2)/(mCanvasHeight/4));
				break;
			case MotionEvent.ACTION_UP:
				dX = 0;
				dY = 0;
				renderer.toggle();
				break;
			default:
				break;
    	}
    	/*
        if (event.getAction() == MotionEvent.ACTION_DOWN) {
            renderer.toggle();
        }
        */
        return super.onTouchEvent(event);
    }
}
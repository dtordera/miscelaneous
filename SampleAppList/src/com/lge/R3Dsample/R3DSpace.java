package com.lge.R3Dsample;

import com.lge.real3d.Real3D;
import com.lge.real3d.Real3DConstant;
import com.lge.real3d.Real3DInfo;
import com.lge.R3Dsample.R;
//import com.lge.real3d.ray.R;
import com.lge.real3d.ray.R3DRect;
import com.lge.real3d.ray.R3DSpaceView;
//import com.lge.real3d.ray.R.drawable;

import android.app.Activity;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.os.Bundle;
import android.util.Log;
import android.view.Gravity;
import android.view.KeyEvent;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.SeekBar;
import android.widget.SeekBar.OnSeekBarChangeListener;
import android.widget.TextView;

public class R3DSpace extends Activity {
	R3DSpace mR3DGalView;
	Bitmap		 mBackImg = null;
	Button		 mViewModeBtn;
	Real3D		 mReal3D;
	public		 R3Dpict mImgRect, mImgRect2, mImgRect3;
	
	public	float	globalDisparity = 0.0f;
    public  int	viewmode = 0;
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        mR3DGalView = new R3DSpace();
        mR3DGalView.setSpace(800, 480, 100);
        mReal3D = mR3DGalView.getReal3DObj();
		mBackImg = BitmapFactory.decodeResource(this.getResources(), R.drawable.puzzle);
		if(null != mBackImg)
			mR3DGalView.setBackgroundImg(mBackImg);
        
        FrameLayout layout = new FrameLayout(this);
        
        layout.addView(mR3DGalView, new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
        
        DebugView	mDebugView = new DebugView(this);
        
        mDebugView.setGravity(Gravity.BOTTOM);
        
        layout.addView(mDebugView,new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
                
        setContentView(layout);
        
        mImgRect = new R3DRect(this, R.drawable.firefox);
        mImgRect.setSize(100, 100);
        mImgRect.setPos(300,300, 70);
        
        mImgRect2 = new R3DRect(this, R.drawable.google);
        mImgRect2.setSize(80, 80);
        mImgRect2.setPos(600,200, 30);
        
        mR3DGalView.addObject(mImgRect);
        mR3DGalView.addObject(mImgRect2);
    }
    
    @Override
    protected void onResume() {
        super.onResume();
        mR3DGalView.onResume();
    }

    @Override
    protected void onPause() {
        super.onPause();
        mR3DGalView.onPause();
    }
    
    @Override
	public boolean	onKeyUp(int keyCode, KeyEvent event) {
		int KeyVal = Real3DConstant.getReal3DHotKeyVal();
		//int KeyTest = Real3DConstant.KEYCODE_3D_HOTKEY;
		if(keyCode == KeyVal){
			viewmode = (++viewmode)%3;
			switch(mR3DGalView.getViewMode()){
			case 2:
				mReal3D.setViewMode(Real3D.REAL3D_VIEWMODE_INTERLEAVING);
				break;
			case 0:
				mReal3D.setViewMode(Real3D.REAL3D_VIEWMODE_SIDEBYSIDE);
				break;
			case 1:
				mReal3D.setViewMode(Real3D.REAL3D_VIEWMODE_LEFTONLY);
				break;
			default:
				break;
			}			
		}
		return super.onKeyUp(keyCode, event);
	}
    
    public class DebugView	extends LinearLayout{
    	SeekBar	CtrlBar1, CtrlBar2;
    	final 	float	DISPARITY_MAX = 20;
    	View	EmptySpace;
    	float	mBrightness = 1.0f;
    	
    	
		public DebugView(Context context) {
			super(context);		
			
			CtrlBar1 = new SeekBar(context);
			CtrlBar1.setMax((int) (DISPARITY_MAX * 2.0f));
			CtrlBar1.setProgress((int) DISPARITY_MAX);
			//CtrlBar1.setVisibility(View.INVISIBLE);
			EmptySpace = new View(context);
			EmptySpace.setVisibility(View.INVISIBLE);
			CtrlBar2 = new SeekBar(context);
			CtrlBar2.setMax(50);
			this.addView(CtrlBar1, new LinearLayout.LayoutParams(LayoutParams.FILL_PARENT, LayoutParams.WRAP_CONTENT, 1.0f));
			this.addView(EmptySpace, new LinearLayout.LayoutParams(LayoutParams.FILL_PARENT, LayoutParams.WRAP_CONTENT, 1.0f));
			this.addView(CtrlBar2, new LinearLayout.LayoutParams(LayoutParams.FILL_PARENT, LayoutParams.WRAP_CONTENT, 1.0f));
			
			
			CtrlBar1.setOnSeekBarChangeListener(new OnSeekBarChangeListener(){

				public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
					float RefVal = (float)progress - DISPARITY_MAX;
					mReal3D.setConvergenceDisparity(RefVal);	
				}

				public void onStartTrackingTouch(SeekBar arg0) {
					// TODO Auto-generated method stub
				}

				public void onStopTrackingTouch(SeekBar arg0) {
					// TODO Auto-generated method stub
				}
			});
			
			CtrlBar2.setOnSeekBarChangeListener(new OnSeekBarChangeListener(){

				public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
					float RefVal = (float)progress/(2*50.0f);
					Log.d("R3DSpace", "compansation value = "+ RefVal);
					mReal3D.compensateBrightness(1.0f+RefVal);
					mBrightness = 1.0f+RefVal;
				}

				public void onStartTrackingTouch(SeekBar arg0) {
					// TODO Auto-generated method stub
				}

				public void onStopTrackingTouch(SeekBar arg0) {
					// TODO Auto-generated method stub
				}
			});
		}
    }
}
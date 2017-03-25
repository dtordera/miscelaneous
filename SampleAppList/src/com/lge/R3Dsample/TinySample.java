package com.lge.R3Dsample;

import java.util.ArrayList;

import com.lge.R3Dsample.R;
import com.lge.R3Dsample.R.drawable;
import com.lge.R3Dsample.R.layout;

import com.lge.real3d.Real3D;
import com.lge.real3d.Real3DInfo;

import android.R.string;
import android.app.Activity;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.BlurMaskFilter;
import android.graphics.Canvas;
import android.graphics.MaskFilter;
import android.graphics.Paint;
import android.graphics.Rect;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.View.OnLongClickListener;
import android.view.View.OnTouchListener;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.LinearLayout;

public class TinySample extends Activity {
	private Real3D 				mReal3D;
	private	final int			ImgCount = 1;
	public	Bitmap 			lgImg;
	private	int					mIsSelected = ImgCount;
	private	R3DImgTestView		mR3DView;
	private	Bitmap				mBackBm;
	private final int			MAX_DEPTH = -10;
	private final int			MIN_DEPTH = 2;
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        mR3DView = new R3DImgTestView(this);
        
        mBackBm = BitmapFactory.decodeResource(getResources(), R.drawable.back);
        
        lgImg = BitmapFactory.decodeResource(getResources(), R.drawable.android); 


        setContentView(mR3DView);
    }
    
    
    class R3DImgTestView extends SurfaceView implements SurfaceHolder.Callback {
	    Bitmap	backBmp = null;
	    private	int	mMaximumDepth = -15;
	    
	    private int mCanvasWidth;
        private int mCanvasHeight;
	    
	    public	R3DImgTestView(Context context) {
	    	super(context);
	    	mReal3D = new Real3D (getHolder());
	        mReal3D.setReal3DInfo(new Real3DInfo(true, Real3D.REAL3D_TYPE_SS, Real3D.REAL3D_ORDER_LR));
	        getHolder().addCallback(this);
	    }
	    
	    public void draw() {
	    	Canvas c;
            c = getHolder().lockCanvas(null);
            
            if ( mBackBm!=null ) {
            	c.drawBitmap(mBackBm, null, new Rect(-15,0,-15 + 400,480), null);
            	c.drawBitmap(mBackBm, null, new Rect(400+1+15,0,800+15,480), null);
            }
            if(lgImg != null) {
	            c.drawBitmap(lgImg, null, new Rect(124, 180, 124 + 80, 280), null);
	        	c.drawBitmap(lgImg, null, new Rect(400+130, 180, 400 + 130 + 80, 280), null);
	        	
	        	c.drawBitmap(lgImg, null, new Rect(184, 260, 184 + 80, 360), null);
	        	c.drawBitmap(lgImg, null, new Rect(400+186, 260, 400 + 186 + 80, 360), null);
            }
            
            getHolder().unlockCanvasAndPost(c);            		
        }

		//@Override
		public void surfaceChanged(SurfaceHolder holder, int format,
				int width, int height) {
			// TODO Auto-generated method stub
			
		}

		public void surfaceCreated(SurfaceHolder holder) {
			mCanvasWidth = getWidth();
            mCanvasHeight = getHeight();
            
            draw();
		}

		//@Override
		public void surfaceDestroyed(SurfaceHolder holder) {
			 		
		}
    }
}


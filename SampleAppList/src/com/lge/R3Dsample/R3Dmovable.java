package com.lge.R3Dsample;

import java.io.File;

import com.lge.R3Dsample.R;
import com.lge.R3Dsample.R.layout;

import com.lge.real3d.Real3D;
import com.lge.real3d.Real3DInfo;

import android.R.string;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Rect;
import android.os.Bundle;
import android.os.Handler;
import android.view.Gravity;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import android.view.View;
import android.view.ViewGroup;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.SeekBar;
import android.widget.SeekBar.OnSeekBarChangeListener;
import android.widget.Toast;
import android.os.Environment;

public class R3Dmovable extends Activity {
	private Real3D 		mReal3D;
	private final int	mNumofmov = 3;
	private	int			mMovIdx = 1;
	private	int			ImgCount[] = {100, 100, 100};
	private	int			mCurrIdx = 1;
	private	String		mLImgPath = null;
	private	String		mRImgPath = null;
	private	R3DImgTestView	mR3DView;
	private	Bitmap	mLbitmap, mRbitmap;
	private String		mAbsoluteSDpath = Environment.getExternalStorageDirectory().getAbsolutePath();
	private	Handler		mHandler;
	private	boolean		mIsinPlaying = false;
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        mR3DView = new R3DImgTestView(this);
        mCurrIdx = 1;
        getImgFromFile();
        mR3DView.setLRBmp(mLbitmap, mRbitmap);
        
        FrameLayout layout = new FrameLayout(this);
        
        mR3DView.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {
				if(mIsinPlaying){
					mIsinPlaying = false;
				} else {
					mIsinPlaying = true;
					mHandler = new Handler();
					play();
				}
				
			}
		});
        layout.addView(mR3DView, new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
        
        LinearLayout	btnLayout = new LinearLayout(this);
        Button btn1 = new Button(this);
        Button btn2 = new Button(this);
        Button btn3 = new Button(this);
        btn1.setText("MOV1");
        btn2.setText("MOV2");
        btn3.setText("MOV3");
        btnLayout.addView(btn1, new LinearLayout.LayoutParams(100, 50, 0.5f));
        btnLayout.addView(btn2, new LinearLayout.LayoutParams(100, 50, 0.5f));
        btnLayout.addView(btn3, new LinearLayout.LayoutParams(100, 50, 0.5f));
        
        btnLayout.setVerticalGravity(Gravity.BOTTOM);
        layout.addView(btnLayout);
        
        btn1.setOnClickListener(new OnClickListener(){
			public void onStartTrackingTouch(SeekBar arg0) {
				// TODO Auto-generated method stub
			}

			public void onStopTrackingTouch(SeekBar arg0) {
				// TODO Auto-generated method stub
			}

			public void onClick(View arg0) {
				// TODO Auto-generated method stub
				mCurrIdx = 1;
				mMovIdx = 1;
				play();
			}}
        );
        btn2.setOnClickListener(new OnClickListener(){
			public void onStartTrackingTouch(SeekBar arg0) {
				// TODO Auto-generated method stub
			}

			public void onStopTrackingTouch(SeekBar arg0) {
				// TODO Auto-generated method stub
			}

			public void onClick(View arg0) {
				// TODO Auto-generated method stub
				mCurrIdx = 1;
				mMovIdx = 2;
				play();
			}}
        );
        btn3.setOnClickListener(new OnClickListener(){
			public void onStartTrackingTouch(SeekBar arg0) {
				// TODO Auto-generated method stub
			}

			public void onStopTrackingTouch(SeekBar arg0) {
				// TODO Auto-generated method stub
			}

			public void onClick(View arg0) {
				// TODO Auto-generated method stub
				mCurrIdx = 1;
				mMovIdx = 3;
				play();
			}}
        );
        
        setContentView(layout);
    }
    
    class R3DImgTestView extends SurfaceView implements SurfaceHolder.Callback {
	    Bitmap	bmL = null;
	    Bitmap	bmR = null;
	    private int mCanvasWidth;
        private int mCanvasHeight;
	    
	    public	R3DImgTestView(Context context) {
	    	super(context);
	    	mReal3D = new Real3D(getHolder());
	        mReal3D.setReal3DInfo(new Real3DInfo(true, Real3D.REAL3D_TYPE_SS, Real3D.REAL3D_ORDER_LR));
	        getHolder().addCallback(this);
	    }
	    
	    public	void	setLRBmp(Bitmap LBmp, Bitmap RBmp) {
	    	bmL = LBmp;
	    	bmR = RBmp;
	    }
	    
	    public void draw() {
	    	if(mCurrIdx >= 1) {
		    	Canvas c;
	            c = getHolder().lockCanvas(null);
	            if (c == null)
	                return;
	            if ( bmL!=null && bmR!=null){
	            	c.drawBitmap(bmL, null, new Rect(0,0,mCanvasWidth/2,mCanvasHeight), null);
	            	bmL.recycle();	            
	            	c.drawBitmap(bmR, null, new Rect(mCanvasWidth/2+1,0,mCanvasWidth,mCanvasHeight), null);
	            	bmR.recycle();
	            } else {
	            	c.drawColor(0xFF000044);
	            	String msg = "Can not find files";
	            	float text_length = msg.length();
	            	float text_size = 30;
	            	float startX = mCanvasWidth/4 - text_length/2;
	            	float startY = mCanvasHeight/2 - text_size;
	            	float diff = 2;
	            	Paint p = new Paint();
	            	p.setColor(0xFFEEDD21);
	            	p.setTextSize(text_size);
	            	p.setTextAlign(Paint.Align.CENTER);
	            	// draw text of left view
	            	c.drawText(msg, startX+diff, startY, p);
	            	// draw text of right view
	            	c.drawText(msg, mCanvasWidth/2 + startX-diff, startY, p);
	            }
	            
	            getHolder().unlockCanvasAndPost(c);            		
	    	}
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
    
    public	void	play() {    		
    	if(mCurrIdx >= ImgCount[mMovIdx-1]){
    		mCurrIdx = 1;
    	}
    	
    	mCurrIdx++;
		if(getImgFromFile()){
	        mR3DView.setLRBmp(mLbitmap, mRbitmap);
	        mR3DView.draw();
	        if(mIsinPlaying)
	        	playLoop();
		} else {
			mR3DView.setLRBmp(mLbitmap, mRbitmap);
			mR3DView.draw();
			mIsinPlaying = false;
		}
    }
    public void	playLoop() {
	    mHandler.postDelayed(new Runnable() {
			public void run() {
				play();
			}
		}, 10);
    }
    
    public	boolean	getImgFromFile() {
		String Path = null;
		
		switch(mMovIdx){
			case (1):
				Path = mAbsoluteSDpath + "/MOV/";
				mLImgPath = Path+"L ("+mCurrIdx+").jpg";
				mRImgPath = Path+"R ("+mCurrIdx+").jpg";
				break;				
			case (2):
				Path = mAbsoluteSDpath + "/Cop/";
				mLImgPath = Path+"L ("+mCurrIdx+").bmp";
				mRImgPath = Path+"R ("+mCurrIdx+").bmp";
				break;
			case (3):
				Path = mAbsoluteSDpath + "/Dragon/";
				mLImgPath = Path+"D_L ("+mCurrIdx+").bmp";
				mRImgPath = Path+"D_R ("+mCurrIdx+").bmp";
				break;
			default: break;
		}

		//File lFile = new File(mLImgPath);
		//File rFile = new File(mRImgPath);
		
		mLbitmap = BitmapFactory.decodeFile(mLImgPath, null);
		mRbitmap = BitmapFactory.decodeFile(mRImgPath, null);
		
		if(mLbitmap==null || mRbitmap==null){
			return false;
		}
		return true;
	}
}


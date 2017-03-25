package com.lge.R3Dsample;

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
import android.graphics.Canvas;
import android.graphics.Rect;
import android.os.Bundle;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import android.view.View;
import android.view.ViewGroup;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.LinearLayout;

public class R3Dpict extends Activity {
	//private Real3D 		mReal3D;
	private Object 		mReal3D;
	private	int			ImgCount = 13;
	private	int			CurrIdx = 0;
	private	string[]	LImgName = new string[ImgCount];
	private	string[]	RImgName = new string[ImgCount];
	private	R3DImgTestView	mR3DView;
	private	Bitmap	mLbitmap, mRbitmap;
	private int	S3D_Type;// = Real3D.REAL3D_TYPE_SS;
	
	public	boolean mLibraryLoaded = true;
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        try {
			Class c = Class.forName("com.lge.real3d.Real3D");
		} catch (ClassNotFoundException e) {
			mLibraryLoaded = false;
		}
        
        mR3DView = new R3DImgTestView(this);
        CurrIdx = 1;
        mLbitmap = BitmapFactory.decodeResource(getResources(), mLthumbIds[CurrIdx]);
        mRbitmap = BitmapFactory.decodeResource(getResources(), mRthumbIds[CurrIdx]);
        mR3DView.setLRBmp(mLbitmap, mRbitmap);
        
        mR3DView.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {
				CurrIdx = ++CurrIdx%ImgCount;
				mLbitmap = BitmapFactory.decodeResource(getResources(), mLthumbIds[CurrIdx]);
		        mRbitmap = BitmapFactory.decodeResource(getResources(), mRthumbIds[CurrIdx]);
		        mR3DView.setLRBmp(mLbitmap, mRbitmap);
		        
		        mR3DView.draw();
			}
		});
        
        
        FrameLayout layout = new FrameLayout(this);
        Button btn = new Button(this);
        btn.setText("Button");
                
        layout.addView(mR3DView);
        layout.addView(btn, new LinearLayout.LayoutParams(ViewGroup.LayoutParams.FILL_PARENT, 50, 0.0f));
        setContentView(layout);
        
        btn.setOnClickListener(new OnClickListener() {
			public void onClick(View arg0) {
				if(mLibraryLoaded) {
					if(S3D_Type == Real3D.REAL3D_TYPE_SS)
						S3D_Type = Real3D.REAL3D_TYPE_NONE;
					else
						S3D_Type = Real3D.REAL3D_TYPE_SS;
					((Real3D) mReal3D).setReal3DInfo(new Real3DInfo(true, S3D_Type, Real3D.REAL3D_ORDER_LR));
				}
			}
        });
        
        
        //setContentView(mR3DView);
    }
    
    class R3DImgTestView extends SurfaceView implements SurfaceHolder.Callback {
	    Bitmap	bmL = null;
	    Bitmap	bmR = null;
	    private int mCanvasWidth;
        private int mCanvasHeight;
	    
	    public	R3DImgTestView(Context context) {
	    	super(context);
	    	if(mLibraryLoaded) {
		    	mReal3D = new Real3D(getHolder());
		        ((Real3D)mReal3D).setReal3DInfo(new Real3DInfo(true, Real3D.REAL3D_TYPE_SS, Real3D.REAL3D_ORDER_LR));
	    	}
		    getHolder().addCallback(this);
	    	
	    }
	    
	    public	void	setLRBmp(Bitmap LBmp, Bitmap RBmp) {
	    	bmL = LBmp;
	    	bmR = RBmp;
	    }
	    
	    public void draw() {
	    	Canvas c;
            c = getHolder().lockCanvas(null);
            if (c == null)
                return;
            if ( bmL!=null )
            	c.drawBitmap(bmL, null, new Rect(0,0,mCanvasWidth/2,mCanvasHeight), null);
            if ( bmR!=null )
            	c.drawBitmap(bmR, null, new Rect(mCanvasWidth/2+1,0,mCanvasWidth,mCanvasHeight), null);
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
    
    private Integer[] mLthumbIds = {
        	R.drawable.l1,
        	R.drawable.l2,
        	//R.drawable.l3,
        	R.drawable.l4,
        	R.drawable.l5,
        	//R.drawable.l6,
        	R.drawable.omnitel00001_l,
        	R.drawable.omnitel00002_l,
        	R.drawable.omnitel00003_l,
        	R.drawable.omnitel00004_l,
        	R.drawable.omnitel00005_l,
        	R.drawable.omnitel00006_l,
        	R.drawable.omnitel00007_l,
        	R.drawable.omnitel00008_l,
        	R.drawable.omnitel00009_l,
        };
        private Integer[] mRthumbIds = {
        	R.drawable.r1,
        	R.drawable.r2,
        	//R.drawable.r3,
        	R.drawable.r4,
        	R.drawable.r5,
        	//R.drawable.r6,
        	R.drawable.omnitel00001_r,
        	R.drawable.omnitel00002_r,
        	R.drawable.omnitel00003_r,
        	R.drawable.omnitel00004_r,
        	R.drawable.omnitel00005_r,
        	R.drawable.omnitel00006_r,
        	R.drawable.omnitel00007_r,
        	R.drawable.omnitel00008_r,
        	R.drawable.omnitel00009_r,
        };
}

package com.lge.R3Dsample;

import java.util.ArrayList;

import com.lge.R3Dsample.R;
import com.lge.R3Dsample.R.drawable;
import com.lge.R3Dsample.R.id;
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
import android.os.SystemClock;
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

public class ImagesActivity extends Activity {
	private Real3D 				mReal3D;
	private	final int			ImgCount = 5;
	public	depthImage 			lgImg, chromiumImg, chromeImg, firefoxImg, androidImg;
	public	ArrayList<depthImage>	mZArray;
	private	int					mZOrder[];
	private	int					mIsSelected = ImgCount;
	private	int					mZofSelected = ImgCount;
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
        
        lgImg = new depthImage(R.drawable.lg, R.drawable.lg_g, 150, 150, 220, 20); 
        chromiumImg = new depthImage(R.drawable.chromium, R.drawable.chromium_g,150, 150, 120, 280);
        chromeImg = new depthImage(R.drawable.google, R.drawable.google_g,150, 150, 340, 80);
        firefoxImg = new depthImage(R.drawable.firefox, R.drawable.firefox_g, 150, 150, 170, 180);
        androidImg = new depthImage(R.drawable.android, R.drawable.android_g, 150, 150, 580, 230);
        
        mZArray = new ArrayList<depthImage>(ImgCount);
        mZOrder = new int[ImgCount];
        
        mZArray.add(lgImg);
        mZArray.add(chromiumImg);
        mZArray.add(chromeImg);
        mZArray.add(firefoxImg);
        mZArray.add(androidImg);
        
        int k = (MIN_DEPTH - MAX_DEPTH)/6;
        
        mZArray.get(4).setDepth(MAX_DEPTH+5*k);
        mZArray.get(3).setDepth(MAX_DEPTH+4*k);
        mZArray.get(2).setDepth(MAX_DEPTH+3*k);
        mZArray.get(1).setDepth(MAX_DEPTH+2*k);
        mZArray.get(0).setDepth(MAX_DEPTH+k);
        
        int i = 0;
        for (i=0 ; i<ImgCount ; i++)
        	mZOrder[i] = i;
        
        FrameLayout layout = new FrameLayout(this);
        LinearLayout	btnLayout = (LinearLayout) LayoutInflater.from(this).inflate(R.layout.sidebutton, null);
        
       
        Button pullbtn = (Button) btnLayout.findViewById(R.id.PULL);
        pullbtn.setOnClickListener(new OnClickListener() {
			public void onClick(View arg0) {
				if(pullSelectedIcon())
					mR3DView.draw();
			}
        });
        
        Button pushbtn = (Button) btnLayout.findViewById(R.id.PUSH);
        pushbtn.setOnClickListener(new OnClickListener() {
			public void onClick(View arg0) {
				if(pushSelectedIcon())
					mR3DView.draw();
			}
        });
        
        
        btnLayout.setGravity(Gravity.BOTTOM);
       
        layout.addView(mR3DView);
        layout.addView(btnLayout);
        setContentView(layout);
    }
    
    int	mIsMoving = ImgCount;
    float mInitX = 0, mInitY = 0;
    @Override
    public boolean onTouchEvent(MotionEvent event) {
    	float X = event.getX();
    	float Y = event.getY();
    	int i=0;
    	
    	switch(event.getAction()){    	
	    	case MotionEvent.ACTION_UP:
		    	{
		    		
			    	for(i = ImgCount-1; i>=0 ; i--) {
			    		if(mZArray.get(i).isInImgRect(X,Y)){
			    			mZArray.get(i).setSelected(true);
			    			mIsSelected = i;
			    			break;
			    		}
			    		mIsSelected = ImgCount;
			    	}
			    	
		    		if(mIsMoving != ImgCount){
			    		mZArray.get(mIsMoving).setSelected(true);
			    		mIsSelected = mIsMoving;			    	
				    	
				    	for(i = ImgCount-1; i>=0 ; i--) {
				    		if(i != mIsSelected)
				    			mZArray.get(i).setSelected(false);
				    	}
		    		} else {
		    			for(i = ImgCount-1; i>=0 ; i--) {
				    		mZArray.get(i).setSelected(false);
				    	}
		    		}
		    		mR3DView.draw();
			    	mIsMoving = ImgCount;			    	
			    	break;
		    	}
		    	
	    	case MotionEvent.ACTION_MOVE:
		    	{
		    		if(mIsMoving != ImgCount){
				    	mZArray.get(mIsMoving).mesurePos(X, Y);
				    	mR3DView.draw();
		    		}
			    	break;
		    	}
	    	case MotionEvent.ACTION_DOWN:
		    	{
		    		for(i = ImgCount-1; i>=0 ; i--) {
			    		if(mZArray.get(i).isInImgRect(X,Y)){
			    			mIsMoving = i;
			    			mInitX = X;
			    			mInitY = Y;
			    			break;
			    		}
			    	}
		    		break;
		    	}
	    	default: break;
    	}
    	
    	return super.onTouchEvent(event);	
    }
    
    
    public	void	resetSelectedIcon(){
    	int i = 0;
    	for(i = 0 ; i <ImgCount ; i++) {    		
    		mZArray.get(i).setSelected(false);
    	}
    }
    
    public	boolean	pushSelectedIcon() {
    	if(mIsSelected != ImgCount) {
    		mZArray.get(mIsSelected).tiltDepth(-1);
    		
    		if(mIsSelected > 0){
	    		if(mZArray.get(mIsSelected-1).getDepth() == mZArray.get(mIsSelected).getDepth()) {
	    			mZArray.get(mIsSelected).tiltDepth(-1);
	    			depthImage tmp = mZArray.get(mIsSelected-1);
	    			mZArray.set(mIsSelected-1, mZArray.get(mIsSelected));
	    			mZArray.set(mIsSelected, tmp);
	    			mIsSelected--;
	    		} else if(mZArray.get(mIsSelected-1).getDepth() > mZArray.get(mIsSelected).getDepth()) {
	    			depthImage tmp = mZArray.get(mIsSelected-1);
	    			mZArray.set(mIsSelected-1, mZArray.get(mIsSelected));
	    			mZArray.set(mIsSelected, tmp);
	    			mIsSelected--;
	    		}
    		}
    		
    		
    		int i=0;
    				
    		return true;
    	}
    	return false;
    }
    
    public	boolean	pullSelectedIcon() {
    	if(mIsSelected != ImgCount) {
    		mZArray.get(mIsSelected).tiltDepth(1);
    		
    		if(mIsSelected < ImgCount-1){
    			if(mZArray.get(mIsSelected+1).getDepth() == mZArray.get(mIsSelected).getDepth()) {
	    			mZArray.get(mIsSelected).tiltDepth(1);
	    			depthImage tmp = mZArray.get(mIsSelected+1);
	    			mZArray.set(mIsSelected+1, mZArray.get(mIsSelected));
	    			mZArray.set(mIsSelected, tmp);
	    			mIsSelected++;
	    		} else if(mZArray.get(mIsSelected+1).getDepth() < mZArray.get(mIsSelected).getDepth()) {
	    			depthImage tmp = mZArray.get(mIsSelected+1);
	    			mZArray.set(mIsSelected+1, mZArray.get(mIsSelected));
	    			mZArray.set(mIsSelected, tmp);
	    			mIsSelected++;
	    		}
    		}
    		
    		return true;
    	}
    	return false;
    }
    
    class depthImage {
    	Bitmap	bm;
    	Bitmap	bm_g;
    	private	int	depth; // depth is regarded as half of the difference between two images
    	private int	resId;
    	private int	resId_g;
    	private	int size_w;
    	private int	size_h;
    	private	int pos_x, pos_y;
    	private int	c_width,c_height;
    	private Paint mPaint;
    	private	boolean mIsSelected = false;
    	
    	public	depthImage(int ResID, int ResID_g, int w, int h, int X, int Y) {
    		resId = ResID;
    		resId_g = ResID_g;
    		size_w = w/2;
    		size_h = h;
    		pos_x = X/2;
    		pos_y = Y;
    		c_width = w;
    		c_height = h;
    		depth = -10;
    		
    		mPaint = new Paint();
    	}
    	
    	private	void	getBitmap(boolean isColorImg) {
    		if(isColorImg)
    			bm = BitmapFactory.decodeResource(getResources(), resId);
    		else
    			bm = BitmapFactory.decodeResource(getResources(), resId_g);
    	}
    	private void	releaseBitmap () {
    		bm.recycle();
    	}
    	public	int		getDepth() {
    		return depth;
    	}
    	public	void	setDepth(int d) {
    		depth = d;
    	}
    	public void		tiltDepth(int d) {
    		depth += d;
    		if(depth <= MAX_DEPTH)
    			depth = MAX_DEPTH;
    		if(depth >= MIN_DEPTH)
    			depth = MIN_DEPTH;
    	}
    	public	void	setPos(int X, int Y) {
    		pos_x = X/2;
    		pos_y = Y;
    	}
    	public	void	mesurePos(float X, float Y) {
    		pos_x = (int) (X/2 - size_w/2);
    		pos_y = (int) (Y - size_h/2);
    	}
    	public boolean isInImgRect(float x, float y) {
    		if((x > pos_x*2)&&(x < (pos_x+size_w)*2)&&
    			(y > pos_y)&&(y < (pos_y+size_h)))
    			return true;    		
    		return false;
    	}
    	public	void	setSelected(boolean b) {
    		mIsSelected = b;
    	}
    	
    	public void drawOnCanvas(Canvas c, int c_width, int c_height) {
    		getBitmap(!mIsSelected);
    		
    		if ( bm != null ) {
    			//if(mPaint!= null && mIsUnSelected) {
    				c.drawBitmap(bm, null, new Rect(pos_x + depth, pos_y, pos_x + depth + size_w, pos_y + size_h), mPaint);
                	c.drawBitmap(bm, null, new Rect(pos_x + c_width/2 - depth, pos_y, pos_x + c_width/2 - depth + size_w, pos_y + size_h), mPaint);    				
    			//} else {
	            //	c.drawBitmap(bm, null, new Rect(pos_x + depth, pos_y, pos_x + depth + size_w, pos_y + size_h), null);
	            //	c.drawBitmap(bm, null, new Rect(pos_x + c_width/2 - depth, pos_y, pos_x + c_width/2 - depth + size_w, pos_y + size_h), null);
    			//}
            }    		
    		// TO-DO
    		releaseBitmap();
    	}
    }
    
    class R3DImgTestView extends SurfaceView implements SurfaceHolder.Callback {
	    Bitmap	backBmp = null;
	    private	int	mMaximumDepth = -10;//30;
	    
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
            	c.drawBitmap(mBackBm, null, new Rect(mMaximumDepth,0,mMaximumDepth + mCanvasWidth/2,mCanvasHeight), null);
            	c.drawBitmap(mBackBm, null, new Rect(mCanvasWidth/2+1-mMaximumDepth,0,mCanvasWidth-mMaximumDepth,mCanvasHeight), null);
            }
            //drawIcons(c, mCanvasWidth, mCanvasHeight);
            
            int i=0;
            for(i = 0; i<ImgCount ; i++){
            	mZArray.get(i).drawOnCanvas(c, mCanvasWidth, mCanvasHeight);
            }
            /*
            lgImg.drawOnCanvas(c, mCanvasWidth, mCanvasHeight); 
            chromiumImg.drawOnCanvas(c, mCanvasWidth, mCanvasHeight); 
            chromeImg.drawOnCanvas(c, mCanvasWidth, mCanvasHeight); 
            firefoxImg.drawOnCanvas(c, mCanvasWidth, mCanvasHeight); 
            androidImg.drawOnCanvas(c, mCanvasWidth, mCanvasHeight);
            */ 
            measureFPS();
            
            getHolder().unlockCanvasAndPost(c);            		
        }
	    private long nFrameCount = 0;
	    private long nTickCount = 0;
	    private long nTotalTickCount = 0;
	    private long nMaxCheckFPS = 4;
	    private long nFrameRate = 0;
	    private long nPrevTick = 0;
	    private long nCurrTick = 0;
	    private long nNumOfCheckFPS = 0;
	    private long nAvgFPS = 0;
	    void measureFPS()
	    {
	          nFrameCount++;

	          nCurrTick = SystemClock.uptimeMillis();
	          nTickCount = nCurrTick - nPrevTick;
	          
	          if(0 != nPrevTick)
	          {
	                    nTotalTickCount += nTickCount;
	          }

	          nPrevTick = nCurrTick;

	          if(nTotalTickCount > 1000)
	          {
	                    nFrameRate += nFrameCount;
	                    nTotalTickCount = 0;
	                    nFrameCount = 0;
	                    nNumOfCheckFPS++;
	          }

	          if(nMaxCheckFPS <= nNumOfCheckFPS)
	          {
	                    nAvgFPS = (nFrameRate * 100) >> 2;
	          
	                    
	                    Log.d("glTest", "fps = " + nAvgFPS);
	                    
	                    nNumOfCheckFPS = 0;
	                    nFrameRate = 0;
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
}


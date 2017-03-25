package meves.apps.tests;

import android.app.Activity;
import android.graphics.Bitmap;
import android.graphics.BitmapShader;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.DrawFilter;
import android.graphics.Matrix;
import android.graphics.Paint;
import android.graphics.PaintFlagsDrawFilter;
import android.graphics.Shader;
import android.os.Bundle;
import android.util.Log;
import android.view.SurfaceHolder;


public class BackAnimActivity extends Activity implements SurfaceHolder.Callback2 {


/**
 * Demonstrates how to take over the Surface from a window to do direct
 * drawing to it (without going through the view hierarchy).
 */

    DrawingThread mDrawingThread;
    
        private Shader mShader1;
        private Shader mShader2;
        private Paint mPaint;
        private DrawFilter mDF;                 
    
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        // Tell the activity's window that we want to do our own drawing
        // to its surface.  This prevents the view hierarchy from drawing to
        // it, though we can still add views to capture input if desired.
        getWindow().takeSurface(this);
            
            mShader1 = new BitmapShader(makeBitmap1(), Shader.TileMode.REPEAT,
                                        Shader.TileMode.REPEAT);
            mShader2 = new BitmapShader(makeBitmap2(), Shader.TileMode.REPEAT,
                                        Shader.TileMode.REPEAT);
            
            Matrix m = new Matrix();
            m.setRotate(30);
            mShader2.setLocalMatrix(m);
            
            mPaint = new Paint(Paint.FILTER_BITMAP_FLAG);        
        
        // This is the thread that will be drawing to our surface.
        mDrawingThread = new DrawingThread();
        mDrawingThread.start();
    }

    @Override
    protected void onPause() {
        super.onPause();
        
        // Make sure the drawing thread is not running while we are paused.
        synchronized (mDrawingThread) {
            mDrawingThread.mRunning = false;
            mDrawingThread.notify();
        }
    }

    @Override
    protected void onResume() {
        super.onResume();
        
        // Let the drawing thread resume running.
        synchronized (mDrawingThread) {
            mDrawingThread.mRunning = true;
            mDrawingThread.notify();
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        
        // Make sure the drawing thread goes away.
        synchronized (mDrawingThread) {
            mDrawingThread.mQuit = true;
            mDrawingThread.notify();
        }
    }

    public void surfaceCreated(SurfaceHolder holder) {
        // Tell the drawing thread that a surface is available.
        synchronized (mDrawingThread) {
            mDrawingThread.mSurface = holder;
            mDrawingThread.notify();
        }
    }

    public void surfaceChanged(SurfaceHolder holder, int format, int width, int height) {
        // Don't need to do anything here; the drawing thread will pick up
        // new sizes from the canvas.
    }

    public void surfaceRedrawNeeded(SurfaceHolder holder) {
    }

    public void surfaceDestroyed(SurfaceHolder holder) {
        // We need to tell the drawing thread to stop, and block until
        // it has done so.
        synchronized (mDrawingThread) {
            mDrawingThread.mSurface = holder;
            mDrawingThread.notify();
            while (mDrawingThread.mActive) {
                try {
                    mDrawingThread.wait();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }
    }

   
    /**
     * This is a thread that will be running a loop, drawing into the
     * window's surface.
     */
    class DrawingThread extends Thread {
        // These are protected by the Thread's lock.
        SurfaceHolder mSurface;
        boolean mRunning;
        boolean mActive;
        boolean mQuit;
        
        Paint P = new Paint();                           
                
        int dx = 0,dy = 0;
        
        boolean mInitialized;
               
        @Override
        public void run() {
            
            
            while (true) {
                // Synchronize with activity: block until the activity is ready
                // and we have a surface; report whether we are active or inactive
                // at this point; exit thread when asked to quit.
                synchronized (this) {
                    while (mSurface == null || !mRunning) {
                        if (mActive) {
                            mActive = false;
                            notify();
                        }
                        if (mQuit) {
                            return;
                        }
                        try {
                            wait();
                        } catch (InterruptedException e) {
                        }
                    }
                    
                    if (!mActive) {
                        mActive = true;
                        notify();
                    }
                                                                                                   
                    // Lock the canvas for drawing.                    
                    Canvas canvas = mSurface.lockCanvas();
                    
            canvas.setDrawFilter(mDF);

            mPaint.setShader(mShader1);
            canvas.drawPaint(mPaint);
            
            canvas.translate(dx,dy);
            
            dx++;
            dy++;

            mPaint.setShader(mShader2);
            canvas.drawPaint(mPaint);
                    
                    
                    // All done!
                    mSurface.unlockCanvasAndPost(canvas);
                }
            }
        }
    }
    
    private static Bitmap makeBitmap1() {
        Bitmap bm = Bitmap.createBitmap(5, 5, Bitmap.Config.RGB_565);
        Canvas c = new Canvas(bm);
        c.drawColor(0xff0000aa);
        Paint p = new Paint();
        p.setColor(0xff000033);
        c.drawCircle(2, 2, 1, p);        
        return bm;
    }
    
    private static Bitmap makeBitmap2() {
        Bitmap bm = Bitmap.createBitmap(20, 20, Bitmap.Config.ARGB_8888);
        Canvas c = new Canvas(bm);
        Paint p = new Paint(Paint.DITHER_FLAG);
        p.setColor(Color.BLUE);
        p.setAlpha(0xCC);
        c.drawCircle(10, 10, 10, p);
        return bm;
    }       
}

    
    
/*    private static class SampleView extends View {

        }
        
        @Override protected void onDraw(Canvas canvas) {
        }

        @Override
        public boolean onTouchEvent(MotionEvent event) {
            float x = event.getX();
            float y = event.getY();
            
            switch (event.getAction()) {
                case MotionEvent.ACTION_DOWN:
                    mTouchStartX = mTouchCurrX = x;
                    mTouchStartY = mTouchCurrY = y;
                    mDF = mFastDF;
                    invalidate();
                    break;
                case MotionEvent.ACTION_MOVE:
                    mTouchCurrX = x;
                    mTouchCurrY = y;
                    invalidate();
                    break;
                case MotionEvent.ACTION_UP:
                    mDF = null;
                    invalidate();
                    break;
            }
            return true;
        }
    }
*/
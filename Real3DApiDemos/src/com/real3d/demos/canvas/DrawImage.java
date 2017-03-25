package com.real3d.demos.canvas;

import com.lge.real3d.Real3D;
import com.lge.real3d.Real3DConstant;
import com.lge.real3d.Real3DInfo;
import com.real3d.demos.R;

import android.app.Activity;
import android.os.Bundle;
import android.content.Context;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Point;
import android.graphics.Rect;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.MenuItem;
import android.view.SurfaceHolder;
import android.view.MotionEvent;
import android.view.SurfaceView;
import android.content.Intent;

public class DrawImage extends Activity {

    public final static String LEFT_RID_PARAM = "LEFT_RESOURCE_ID";
    public final static String RIGHT_RID_PARAM = "RIGHT_RESOURCE_ID";

    private int mLeftResourceID;
    private int mRightResourceID;
    private final static int MENU_S3D_CONTROL = 1;

    private boolean mIsS3D = true;
    private S3DSurfaceView mS3DSurfaceView;
    
    private Real3D mReal3D;
    private Real3DInfo ss_info= new Real3DInfo(true, Real3D.REAL3D_TYPE_SS, 0);
    private Real3DInfo none_info= new Real3DInfo(true, Real3D.REAL3D_TYPE_NONE, 0);
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        mS3DSurfaceView = new S3DSurfaceView(this);
        setContentView(mS3DSurfaceView);
        Intent intent = getIntent();
        mLeftResourceID = intent.getIntExtra(LEFT_RID_PARAM, R.drawable.myhand_l);
        mRightResourceID = intent.getIntExtra(RIGHT_RID_PARAM, R.drawable.myhand_r);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        menu.add(Menu.NONE, MENU_S3D_CONTROL, Menu.NONE, R.string.real3d_off);
        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onPrepareOptionsMenu(Menu menu) {
        MenuItem item = menu.findItem(MENU_S3D_CONTROL);
        if (item == null)
            return super.onPrepareOptionsMenu(menu);
        if (mIsS3D)
            item.setTitle(R.string.real3d_off);
        else
            item.setTitle(R.string.real3d_on);
        return super.onPrepareOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        if (item.getItemId() == MENU_S3D_CONTROL) {
            mIsS3D = !mIsS3D;
            if (mIsS3D) {
                mReal3D.setReal3DInfo(ss_info);
            }
            else {
                mReal3D.setReal3DInfo(none_info);
            }
            mS3DSurfaceView.draw();
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    class S3DSurfaceView extends SurfaceView implements SurfaceHolder.Callback {
        private Point mWindowPos;

        // canvas size
        private int mCanvasWidth;
        private int mCanvasHeight;

        // image information
        private int mImgWidth;
        private int mImgHeight;

        private Rect mImgRect;
        private Rect mCanvasRect, mLeftCanvasRect, mRightCanvasRect;

        private Bitmap mLeftImage;
        private Bitmap mRightImage;

        public S3DSurfaceView(Context context) {
            super(context);
            mReal3D = new Real3D(getHolder());
            mReal3D.setReal3DInfo(ss_info);
            getHolder().addCallback(this);
        }

        public void draw() {
            Canvas c;
            c = getHolder().lockCanvas(null);
            if (c == null)
                return;
            drawSurfaceCanvas(c);
            getHolder().unlockCanvasAndPost(c);
        }

        public void drawSurfaceCanvas(Canvas canvas) {
            canvas.drawColor(Color.BLACK);
            if (mIsS3D) {
                canvas.drawBitmap(mLeftImage, mImgRect, mLeftCanvasRect, null);
                canvas.drawBitmap(mRightImage, mImgRect, mRightCanvasRect, null);
            } else {
                canvas.drawBitmap(mLeftImage, mImgRect, mCanvasRect, null);
            }
        }

        //@Override
        public void surfaceChanged(SurfaceHolder holder, int format, int width, int height) {
        }

        //@Override
        public void surfaceCreated(SurfaceHolder holder) {

            // get cavans size
            mCanvasWidth = getWidth() / 2;
            mCanvasHeight = getHeight();

            // size
            mWindowPos = new Point();
            mWindowPos.x = 800;
            mWindowPos.y = 480;

            Resources res = getResources();
            mLeftImage = BitmapFactory.decodeResource(res, mLeftResourceID);
            mRightImage = BitmapFactory.decodeResource(res, mRightResourceID);

            // get image size
            mImgWidth = mLeftImage.getWidth();
            mImgHeight = mRightImage.getHeight();

            mImgRect = new Rect(0, 0, mImgWidth - 1, mImgHeight - 1);

            mCanvasRect = new Rect(0, 0, getWidth(), getHeight());
            mLeftCanvasRect = new Rect(0, 0, mCanvasWidth - 1, mCanvasHeight - 1);
            mRightCanvasRect = new Rect(mCanvasWidth, 0, mCanvasWidth * 2 - 1, mCanvasHeight - 1);

            this.setClickable(true);
            draw();
        }

        //@Override
        public void surfaceDestroyed(SurfaceHolder holder) {
        }
        
        int preX, preY;
        Point down1, down2;
        Point move1, move2;

        @Override
        public boolean onTouchEvent(MotionEvent event) {
            int action = event.getAction() & MotionEvent.ACTION_MASK;
            int x = (int) event.getX();
            int y = (int) event.getY();

            switch (action) {
            case MotionEvent.ACTION_POINTER_DOWN:
                if (event.getPointerCount() > 1) {
                    System.out.println("multi-touch down!!");
                    down1 = new Point((int) event.getX(0), (int) event.getY(0));
                    down2 = new Point((int) event.getX(1), (int) event.getY(1));
                }
                break;
            case MotionEvent.ACTION_MOVE:
                if (event.getPointerCount() == 1) {
                    // single touch : move
                    move(preX - x, preY - y);
                    preX = x;
                    preY = y;
                } else {
                    // multi touch : zoom
                    move1 = new Point((int) event.getX(0), (int) event.getY(0));
                    move2 = new Point((int) event.getX(1), (int) event.getY(1));
                    zoom(down1, down2, move1, move2);
                    down1 = move1;
                    down2 = move2;
                }
                break;
            case MotionEvent.ACTION_UP:
                break;
            case MotionEvent.ACTION_DOWN:
                preX = x;
                preY = y;
                break;
            }
            draw();
            return true;
        }

        private void move(int offsetX, int offsetY) {
            float xUnit, yUnit;
            int moveX, moveY;
            xUnit = (float) mImgWidth / (float) mCanvasWidth;
            yUnit = (float) mImgHeight / (float) mCanvasHeight;

            moveX = (int) ((float) offsetX * xUnit);
            moveY = (int) ((float) offsetY * yUnit);

            // X
            if (moveX < 0) {
                if ((mImgRect.left + moveX) >= 0)
                    mImgRect.offset(moveX, 0);
            } else {
                if ((mImgRect.right + moveX) < mImgWidth)
                    mImgRect.offset(moveX, 0);
            }
            // Y
            if (moveY < 0) {
                if ((mImgRect.top + moveY) >= 0)
                    mImgRect.offset(0, moveY);
            } else {
                if ((mImgRect.bottom + moveY) < mImgHeight)
                    mImgRect.offset(0, moveY);
            }
        }

        private Rect makeRect(Point p1, Point p2) {
            int left, right, top, bottom;
            if (p1.x < p2.x) {
                left = p1.x;
                right = p2.x;
            } else {
                left = p2.x;
                right = p1.x;
            }
            if (p1.y < p2.y) {
                top = p1.y;
                bottom = p2.y;
            } else {
                top = p2.y;
                bottom = p1.y;
            }
            return new Rect(left, top, right, bottom);
        }

        void growRectInX(Rect r, int x) {
            int lOff, rOff;
            lOff = x / 2;
            rOff = x - lOff;
            r.left -= lOff;
            r.right += rOff;
        }

        private final static int MIN_SHOW_WIDTH = 20;
        private final static int MIN_SHOW_HEIGHT = 20;

        // not good
        private void zoom(Point p1, Point p2, Point c1, Point c2) {
            Rect preRect = makeRect(p1, p2);
            Rect postRect = makeRect(c1, c2);

            int diffX = postRect.width() - preRect.width();
            int diffY = postRect.height() - preRect.height();

            mImgRect.left += diffX / 2;
            mImgRect.right -= diffX - diffX / 2;
            mImgRect.top += diffY / 2;
            mImgRect.bottom -= diffY - diffY / 2;

            if (mImgRect.width() > mImgWidth) {
                mImgRect.left = 0;
                mImgRect.right = mImgWidth - 1;
            }
            if (mImgRect.height() > mImgHeight) {
                mImgRect.top = 0;
                mImgRect.bottom = mImgHeight - 1;
            }
            if (mImgRect.width() < MIN_SHOW_WIDTH)
                mImgRect.right = mImgRect.left + MIN_SHOW_WIDTH;
            if (mImgRect.height() < MIN_SHOW_HEIGHT)
                mImgRect.bottom = mImgRect.top + MIN_SHOW_HEIGHT;

            if (mImgRect.left < 0)
                mImgRect.offset(-mImgRect.left, 0);
            if (mImgRect.top < 0)
                mImgRect.offset(0, -mImgRect.top);
            if (mImgRect.right >= mImgWidth)
                mImgRect.offset(mImgWidth - mImgRect.right, 0);
            if (mImgRect.bottom >= mImgHeight)
                mImgRect.offset(0, mImgHeight - mImgRect.bottom);
        }
    }
    
    
    @Override
    public boolean onKeyUp(int keyCode, KeyEvent event) {
        //if (keyCode == Real3DConstant.KEYCODE_3D_HOTKEY) {
        if (keyCode == Real3DConstant.getReal3DHotKeyVal()) {
            mIsS3D = !mIsS3D;
            if (mIsS3D) {
                mReal3D.setReal3DInfo(ss_info);
            }
            else {
                mReal3D.setReal3DInfo(none_info);
            }
            mS3DSurfaceView.draw();
        }
        return super.onKeyUp(keyCode, event);
    }
}

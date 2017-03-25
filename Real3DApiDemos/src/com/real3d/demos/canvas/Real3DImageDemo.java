package com.real3d.demos.canvas;

import com.lge.real3d.Real3D;
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
import android.graphics.Paint; // import android.os.Bundle;
import android.util.Log;
import android.view.SurfaceHolder;
import android.view.MotionEvent;
import android.view.SurfaceView;
import android.content.Intent;

public class Real3DImageDemo extends Activity {
    
    final private static String TAG = "Real3DImageDemo";
    
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(new S3DSurfaceView(this));
    }

    class S3DSurfaceView extends SurfaceView implements SurfaceHolder.Callback {

        final private static int GRID_WIDTH = 250;
        final private static int GRID_HEIGHT = 200;

        final private static int ICON_H_MARGINE = 5;
        final private static int ICON_V_MARGINE = 10;
        final private static int ICON_WIDTH = GRID_WIDTH - ICON_H_MARGINE * 2;
        final private static int ICON_HEIGHT = GRID_HEIGHT - ICON_V_MARGINE * 2;

        final private static int IMAGE_COUNT = 2;

        private int mLeftImgesRID[] = { R.drawable.myhand_l, R.drawable.pig_l};

        private int mRightImgesRID[] = { R.drawable.myhand_r, R.drawable.pig_r};

        private Bitmap mLeftIcons[];
        private Bitmap mRightIcons[];

        private int mCanvasWidth;
        private int mCanvasHeight;
        
        // icon count in a row
        private int mIconPerLine;
        
        // selected icon
        private int mSelectedNo = -1;

        private Real3D mReal3D;
        public S3DSurfaceView(Context context) {
            super(context);
            mReal3D = new Real3D(getHolder());
            mReal3D.setReal3DInfo(new Real3DInfo(true, Real3D.REAL3D_TYPE_SS, Real3D.REAL3D_ORDER_LR));
            getHolder().addCallback(this);
        }
    
        private Rect getRectOfIcon(int no) {
            if (no < 0 || no >= IMAGE_COUNT)
                return null;
            int x, y;
            x = no % mIconPerLine;
            y = no / mIconPerLine;
            return new Rect(x * GRID_WIDTH, y * GRID_HEIGHT, (x + 1) * GRID_WIDTH - 1, (y + 1)
                    * GRID_HEIGHT - 1);
        }

        private Rect getLeftRectOfIcon(int no) {
            Rect r = getRectOfIcon(no);
            if (r == null)
                return null;
            r.left /= 2;
            r.right /= 2;
            return r;
        }

        private Rect getRightRectOfIcon(int no) {
            Rect r = getLeftRectOfIcon(no);
            if (r == null)
                return null;
            r.offset(mCanvasWidth / 2, 0);
            return r;
        }

        private int getIconFromPos(Point p) {
            int no;
            int x, y;
            x = p.x / ICON_WIDTH;
            y = p.y / ICON_HEIGHT;
            no = (y * mIconPerLine) + x;
            if (no < IMAGE_COUNT)
                return no;
            else
                return -1;
        }

        /**
         * 
         * @param iconNo -1 draw all. if not -1 draw icon area only
         */
        private void draw(int iconNo) {
            Canvas c;
            Rect leftDirty = null, rightDirty = null;
            if (iconNo != -1) {
                leftDirty = getLeftRectOfIcon(iconNo);
                rightDirty = getRightRectOfIcon(iconNo);
                if (leftDirty == null || rightDirty == null)
                    iconNo = -1;
            }
            c = getHolder().lockCanvas(null);
            drawCanvas(c, -1, true);
            drawCanvas(c, -1, false);
            getHolder().unlockCanvasAndPost(c);
        }

        public Rect iconRect(Rect r) {
            return new Rect(r.left + ICON_H_MARGINE, r.top + ICON_V_MARGINE, r.right
                    - ICON_H_MARGINE, r.bottom - ICON_V_MARGINE);
        }

        private Paint mPaint = new Paint();

        public void drawCanvas(Canvas canvas, int iconNo, boolean bLeft) {
            if (canvas == null) {
                Log.e(TAG, "No canvas");
                return;
            }
            int startX;
            if (bLeft) {
                startX = 0;
            } else {
                startX = mCanvasWidth / 2;
            }

            // erase background
            mPaint.setColor(Color.BLACK);
            canvas.drawRect(startX, 0, mCanvasWidth - 1, mCanvasHeight - 1, mPaint);
            for (int i = 0; i < IMAGE_COUNT; i++) {
                if (iconNo == -1 || i == iconNo) {
                    Rect gridRect;
                    Bitmap bitmap;
                    if (bLeft) {
                        gridRect = getLeftRectOfIcon(i);
                        bitmap = mLeftIcons[i];
                    } else {
                        gridRect = getRightRectOfIcon(i);
                        bitmap = mRightIcons[i];
                    }
                    if (gridRect != null && bitmap != null) {
                        if (i == mSelectedNo) {
                            if (bLeft)
                                mPaint.setColor(Color.RED);
                            else
                                mPaint.setColor(Color.BLUE);
                        } else
                            mPaint.setColor(Color.BLACK);
                        canvas.drawRect(gridRect, mPaint);
                        canvas.drawBitmap(mLeftIcons[i], null, iconRect(gridRect), null);
                    }
                }
            }
        }

        //@Override
        public void surfaceChanged(SurfaceHolder holder, int format, int width, int height) {
        }

        //@Override
        public void surfaceCreated(SurfaceHolder holder) {

            mCanvasWidth = getWidth();
            mCanvasHeight = getHeight();

            mIconPerLine = mCanvasWidth / GRID_WIDTH;

            mLeftIcons = new Bitmap[IMAGE_COUNT];
            mRightIcons = new Bitmap[IMAGE_COUNT];
            Resources res = getResources();
            for (int i = 0; i < IMAGE_COUNT; i++) {
                mLeftIcons[i] = Bitmap.createScaledBitmap(BitmapFactory.decodeResource(res,
                        mLeftImgesRID[i]), ICON_WIDTH, ICON_HEIGHT, false);
                mRightIcons[i] = Bitmap.createScaledBitmap(BitmapFactory.decodeResource(res,
                        mRightImgesRID[i]), ICON_WIDTH, ICON_HEIGHT, false);
            }

            this.setClickable(true);
            draw(-1);
        }

        //@Override
        public void surfaceDestroyed(SurfaceHolder holder) {
        }

        @Override
        public boolean onTouchEvent(MotionEvent event) {
            int action = event.getAction() & MotionEvent.ACTION_MASK;
            int x = (int) event.getX();
            int y = (int) event.getY();

            int pos;
            switch (action) {
            case MotionEvent.ACTION_UP:
                pos = getIconFromPos(new Point(x, y));
                if (pos != -1 && pos == mSelectedNo) {
                    // move next
                    Intent intent = new Intent(Real3DImageDemo.this, DrawImage.class);
                    intent.putExtra(DrawImage.LEFT_RID_PARAM, mLeftImgesRID[mSelectedNo]);
                    intent.putExtra(DrawImage.RIGHT_RID_PARAM, mRightImgesRID[mSelectedNo]);
                    mSelectedNo = -1;
                    startActivity(intent);
                }
                break;
            case MotionEvent.ACTION_DOWN:
                pos = getIconFromPos(new Point(x, y));
                if (pos != -1)
                    mSelectedNo = pos;
                break;
            case MotionEvent.ACTION_MOVE:
                pos = getIconFromPos(new Point(x, y));
                if (pos != mSelectedNo)
                    mSelectedNo = -1;
                break;
            }
            draw(-1);
            return true;
        }
    }
}

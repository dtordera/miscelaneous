package com.real3d.demos.camera;

import java.io.IOException;
import java.io.InputStream;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.FloatBuffer;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

import com.real3d.demos.R;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.opengl.GLU;
import android.opengl.GLUtils;
import android.opengl.GLSurfaceView.Renderer;

public class GLOpaqueRenderer implements Renderer {

    private int mWidth;
    private int mHeight;
    private float mEyeDistance = 0.1f;
    private Context mContext;
    private static float ROTATION_SPEED = 1.5f;
    private float mAngle = 0;
    private float mAngleOffset = ROTATION_SPEED;
    private float[] mFocusPoint = {0.0f, 0.0f, 1.0f};

    public GLOpaqueRenderer(Context context) {
        mContext = context;
        createSphere(0, 0, 0, 1, 16);
    }

    private int mEarthTextureID = -1;
    private int mMoonTextureID = -1;

    public void onSurfaceCreated(GL10 gl, EGLConfig config) {
        /*
         * By default, OpenGL enables features that improve quality but reduce
         * performance. One might want to tweak that especially on software
         * renderer.
         */
        gl.glDisable(GL10.GL_DITHER);

        /*
         * Some one-time OpenGL initialization can be made here probably based
         * on features of this particular context
         */
        gl.glHint(GL10.GL_PERSPECTIVE_CORRECTION_HINT, GL10.GL_FASTEST);

        gl.glClearColor(.0f, .0f, .0f, .0f);
        gl.glShadeModel(GL10.GL_FLAT);
        gl.glDisable(GL10.GL_LIGHTING);
        gl.glEnable(GL10.GL_DEPTH_TEST);
        gl.glEnable(GL10.GL_TEXTURE_2D);
        gl.glFrontFace(GL10.GL_CCW);

        mEarthTextureID = createTextureFromResource(gl, R.raw.earth);
        mMoonTextureID = createTextureFromResource(gl, R.raw.moon);
    }

    private int createTextureFromResource(GL10 gl, int resId) {
        int[] textures = new int[1];
        gl.glGenTextures(1, textures, 0);

        int texture = textures[0];

        gl.glBindTexture(GL10.GL_TEXTURE_2D, texture);

        gl.glTexParameterf(GL10.GL_TEXTURE_2D, GL10.GL_TEXTURE_MIN_FILTER, GL10.GL_LINEAR);
        gl.glTexParameterf(GL10.GL_TEXTURE_2D, GL10.GL_TEXTURE_MAG_FILTER, GL10.GL_LINEAR);

        gl.glTexParameterf(GL10.GL_TEXTURE_2D, GL10.GL_TEXTURE_WRAP_S, GL10.GL_REPEAT);
        gl.glTexParameterf(GL10.GL_TEXTURE_2D, GL10.GL_TEXTURE_WRAP_T, GL10.GL_REPEAT);

        gl.glTexEnvf(GL10.GL_TEXTURE_ENV, GL10.GL_TEXTURE_ENV_MODE, GL10.GL_REPLACE);

        InputStream is = mContext.getResources().openRawResource(resId);
        Bitmap bitmap = null;
        try {
            bitmap = BitmapFactory.decodeStream(is);
        } finally {
            try {
                is.close();
            } catch (IOException e) {
                // Ignore.
            }
        }

        GLUtils.texImage2D(GL10.GL_TEXTURE_2D, 0, bitmap, 0);
        bitmap.recycle();
        return texture;
    }

    public void onSurfaceChanged(GL10 gl, int width, int height) {
        mWidth = width;
        mHeight = height;

        gl.glViewport(0, 0, mWidth, mHeight);

        float ratio = (float) width / height;
        gl.glMatrixMode(GL10.GL_PROJECTION);
        gl.glLoadIdentity();
        gl.glFrustumf(-ratio, ratio, -1, 1, 1, 10);
        gl.glMatrixMode(GL10.GL_MODELVIEW);
        gl.glLoadIdentity();
    }

    private void setLeftEnv(GL10 gl) {
        gl.glViewport(0, 0, (int) mWidth / 2, (int) mHeight);

        gl.glMatrixMode(GL10.GL_MODELVIEW);
        gl.glLoadIdentity();
        GLU.gluLookAt(gl, - mEyeDistance, 0.0f, 4.5f, mFocusPoint[0], mFocusPoint[1], mFocusPoint[2], 0.0f, 1.0f, 0.0f);
    }

    private void setRightEnv(GL10 gl) {
        gl.glViewport((int) mWidth / 2, 0, (int) mWidth / 2, (int) mHeight);

        gl.glMatrixMode(GL10.GL_MODELVIEW);
        gl.glLoadIdentity();
        GLU.gluLookAt(gl, mEyeDistance, 0.0f, 4.5f, mFocusPoint[0], mFocusPoint[1], mFocusPoint[2], 0.0f, 1.0f, 0.0f);
    }

    public void onDrawFrame(GL10 gl) {
        mAngle += mAngleOffset;
        gl.glClear(GL10.GL_COLOR_BUFFER_BIT | GL10.GL_DEPTH_BUFFER_BIT);
        setLeftEnv(gl);
        draw(gl);
        setRightEnv(gl);
        draw(gl);
    }

    private void draw(GL10 gl) {
        // draw earth
        gl.glPushMatrix();
        gl.glRotatef(mAngle, 0, 1, 0);
        gl.glScalef(1.5f, 1.5f, 1.5f);
        gl.glBindTexture(GL10.GL_TEXTURE_2D, mEarthTextureID);
        gl.glEnableClientState(GL10.GL_VERTEX_ARRAY);
        gl.glEnableClientState(GL10.GL_TEXTURE_COORD_ARRAY);
        gl.glVertexPointer(3, GL10.GL_FLOAT, 0, mVertexBuffer);
        gl.glTexCoordPointer(2, GL10.GL_FLOAT, 0, mTextureBuffer);
        gl.glDrawArrays(GL10.GL_TRIANGLE_STRIP, 0, mVerticeCount);
        gl.glPopMatrix();
        // draw moon
        gl.glPushMatrix();
        gl.glRotatef(mAngle, 0, 1, 0);
        gl.glTranslatef(3, 0, 0);
        gl.glScalef(0.5f, 0.5f, 0.5f);
        gl.glBindTexture(GL10.GL_TEXTURE_2D, mMoonTextureID);
        gl.glDrawArrays(GL10.GL_TRIANGLE_STRIP, 0, mVerticeCount);
        gl.glPopMatrix();
    }

    // Based on a function Written by Paul Bourke.
    // http://astronomy.swin.edu.au/~pbourke/opengl/sphere/
    private static float TWOPI = 6.28318530717958f;
    private static float PIDIV2 = 1.57079632679489f;
    private FloatBuffer mVertexBuffer;
    private FloatBuffer mTextureBuffer;
    private int mVerticeCount;

    void createSphere(float cx, float cy, float cz, float r, int n) {
        float theta1 = 0.0f;
        float theta2 = 0.0f;
        float theta3 = 0.0f;

        float[] e = { 0, 0, 0 };
        float[] p = { 0, 0, 0 };
        float[] t = { 0, 0 };

        if (r < 0)
            r = -r;

        if (n < 4)
            n = 4;
        mVerticeCount = (n / 2) * ((n + 1) * 2);
        final int FLOAT_SIZE = 4;
        mVertexBuffer = ByteBuffer.allocateDirect(FLOAT_SIZE * mVerticeCount * 3).order(
                ByteOrder.nativeOrder()).asFloatBuffer();
        mVertexBuffer.position(0);
        mTextureBuffer = ByteBuffer.allocateDirect(FLOAT_SIZE * mVerticeCount * 2).order(
                ByteOrder.nativeOrder()).asFloatBuffer();
        mTextureBuffer.position(0);
        for (int i = 0; i < n / 2; ++i) {
            theta1 = i * TWOPI / n - PIDIV2;
            theta2 = (i + 1) * TWOPI / n - PIDIV2;

            for (int j = 0; j <= n; ++j) {
                theta3 = j * TWOPI / n;

                e[0] = (float) (Math.cos(theta2) * Math.cos(theta3));
                e[1] = (float) Math.sin(theta2);
                e[2] = (float) (Math.cos(theta2) * Math.sin(theta3));
                p[0] = cx + r * e[0];
                p[1] = cy + r * e[1];
                p[2] = cz + r * e[2];
                t[0] = (j / (float) n);
                t[1] = -2 * (i + 1) / (float) n;
                mVertexBuffer.put(p);
                mTextureBuffer.put(t);

                e[0] = (float) (Math.cos(theta1) * Math.cos(theta3));
                e[1] = (float) Math.sin(theta1);
                e[2] = (float) (Math.cos(theta1) * Math.sin(theta3));
                p[0] = cx + r * e[0];
                p[1] = cy + r * e[1];
                p[2] = cz + r * e[2];
                t[0] = (j / (float) n);
                t[1] = -2 * i / (float) n;
                mVertexBuffer.put(p);
                mTextureBuffer.put(t);
            }
        }
        mVertexBuffer.position(0);
        mTextureBuffer.position(0);
    }

    public void toggle() {
        if (mAngleOffset != ROTATION_SPEED) {
            mAngleOffset = ROTATION_SPEED;
        } else {
            mAngleOffset = 0;
        }
    }
}

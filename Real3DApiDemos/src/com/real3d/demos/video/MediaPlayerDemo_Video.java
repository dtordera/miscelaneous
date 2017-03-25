/*
 * Copyright (C) 2009 The Android Open Source Project
 * 
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */

package com.real3d.demos.video;

import com.lge.real3d.Real3D;
import com.lge.real3d.Real3DInfo;
import com.real3d.demos.R;

import android.app.Activity;
import android.media.AudioManager;
import android.media.MediaPlayer;
import android.media.MediaPlayer.OnBufferingUpdateListener;
import android.media.MediaPlayer.OnCompletionListener;
import android.media.MediaPlayer.OnPreparedListener;
import android.media.MediaPlayer.OnVideoSizeChangedListener;
import android.os.Bundle;
import android.util.Log;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import android.widget.Toast;

public class MediaPlayerDemo_Video extends Activity implements OnBufferingUpdateListener,
        OnCompletionListener, OnPreparedListener, OnVideoSizeChangedListener,
        SurfaceHolder.Callback {

    private static final String TAG = "MediaPlayerDemo";
    private int mVideoWidth;
    private int mVideoHeight;
    private MediaPlayer mMediaPlayer;
    private SurfaceView mPreview;
    private SurfaceHolder holder;
    private String path;
    private Bundle extras;
    private static final String MEDIA = "media";
    private static final int AUTO_DETECT_VIDEO = 1;
    private static final int MANUAL_SS_VIDEO = 2;
    private static final int MANUAL_TB_VIDEO = 3;
    private boolean mIsVideoSizeKnown = false;
    private boolean mIsVideoReadyToBePlayed = false;
    private Real3D mReal3D = null;

    /**
     * 
     * Called when the activity is first created.
     */
    @Override
    public void onCreate(Bundle icicle) {
        super.onCreate(icicle);
        setContentView(R.layout.mediaplayer_2);
        mPreview = (SurfaceView) findViewById(R.id.surface);
        holder = mPreview.getHolder();
        mReal3D = new Real3D(holder);
        holder.addCallback(this);
        holder.setType(SurfaceHolder.SURFACE_TYPE_PUSH_BUFFERS);
        extras = getIntent().getExtras();
    }

    private void playVideo(Integer Media) {
        doCleanUp();
        try {
            switch (Media) {
            case AUTO_DETECT_VIDEO:
                path = "/sdcard/SS_SEI.mp4";
                if (path == "") {
                    Toast.makeText(
                            MediaPlayerDemo_Video.this,
                            "Please edit MediaPlayerDemo_Video Activity, "
                                    + "and set the path variable to your media file path."
                                    + " Your media file must be stored on sdcard.",
                            Toast.LENGTH_LONG).show();
                    finish();
                    return;
                }

                // set default value. It is same to below comment.
                mReal3D.setReal3DInfo(new Real3DInfo());
                //mReal3D.setReal3DInfo(new Real3DInfo(false, Real3D.REAL3D_TYPE_NONE,
                //        Real3D.REAL3D_ORDER_LR));
                break;
            case MANUAL_SS_VIDEO:
                path = "/sdcard/SS_SEI.mp4";
                if (path == "") {
                    Toast.makeText(
                            MediaPlayerDemo_Video.this,
                            "Please edit MediaPlayerDemo_Video Activity, "
                                    + "and set the path variable to your media file path."
                                    + " Your media file must be stored on sdcard.",
                            Toast.LENGTH_LONG).show();
                    finish();
                    return;
                }
                mReal3D.setReal3DInfo(new Real3DInfo(true, Real3D.REAL3D_TYPE_SS,
                        Real3D.REAL3D_ORDER_LR));
                break;
            case MANUAL_TB_VIDEO:
                path = "/sdcard/TB_SEI.mp4";
                if (path == "") {
                    Toast.makeText(
                            MediaPlayerDemo_Video.this,
                            "Please edit MediaPlayerDemo_Video Activity, "
                                    + "and set the path variable to your media file path."
                                    + " Your media file must be stored on sdcard.",
                            Toast.LENGTH_LONG).show();
                    finish();
                    return;
                }
                mReal3D.setReal3DInfo(new Real3DInfo(true, Real3D.REAL3D_TYPE_TB,
                        Real3D.REAL3D_ORDER_LR));
                break;
            }

            // Create a new media player and set the listeners
            mMediaPlayer = new MediaPlayer();
            mMediaPlayer.setDataSource(path);
            mMediaPlayer.setDisplay(holder);
            mMediaPlayer.prepare();
            mMediaPlayer.setOnBufferingUpdateListener(this);
            mMediaPlayer.setOnCompletionListener(this);
            mMediaPlayer.setOnPreparedListener(this);
            mMediaPlayer.setOnVideoSizeChangedListener(this);
            mMediaPlayer.setAudioStreamType(AudioManager.STREAM_MUSIC);

        } catch (Exception e) {
            Log.e(TAG, "error: " + e.getMessage(), e);
        }
    }

    public void onBufferingUpdate(MediaPlayer arg0, int percent) {
        Log.d(TAG, "onBufferingUpdate percent:" + percent);

    }

    public void onCompletion(MediaPlayer arg0) {
        Log.d(TAG, "onCompletion called");
    }

    public void onVideoSizeChanged(MediaPlayer mp, int width, int height) {
        Log.v(TAG, "onVideoSizeChanged called");
        if (width == 0 || height == 0) {
            Log.e(TAG, "invalid video width(" + width + ") or height(" + height + ")");
            return;
        }
        mIsVideoSizeKnown = true;
        mVideoWidth = width;
        mVideoHeight = height;
        if (mIsVideoReadyToBePlayed && mIsVideoSizeKnown) {
            startVideoPlayback();
        }
    }

    public void onPrepared(MediaPlayer mediaplayer) {
        Log.d(TAG, "onPrepared called");
        mIsVideoReadyToBePlayed = true;
        Real3DInfo info = mReal3D.getReal3DInfo();
        if (info != null) {
            Log.d(TAG, "Real3D info :" + info.disableAutoDetection + " " + info.type + " "
                    + info.order);
        }
        if (mIsVideoReadyToBePlayed && mIsVideoSizeKnown) {
            startVideoPlayback();
        }
    }

    public void surfaceChanged(SurfaceHolder surfaceholder, int i, int j, int k) {
        Log.d(TAG, "surfaceChanged called");

    }

    public void surfaceDestroyed(SurfaceHolder surfaceholder) {
        Log.d(TAG, "surfaceDestroyed called");
    }

    public void surfaceCreated(SurfaceHolder holder) {
        Log.d(TAG, "surfaceCreated called");
        playVideo(extras.getInt(MEDIA));
    }

    @Override
    protected void onPause() {
        super.onPause();
        releaseMediaPlayer();
        doCleanUp();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        releaseMediaPlayer();
        doCleanUp();
    }

    private void releaseMediaPlayer() {
        if (mMediaPlayer != null) {
            mMediaPlayer.release();
            mMediaPlayer = null;
        }
    }

    private void doCleanUp() {
        mVideoWidth = 0;
        mVideoHeight = 0;
        mIsVideoReadyToBePlayed = false;
        mIsVideoSizeKnown = false;
    }

    private void startVideoPlayback() {
        holder.setFixedSize(mVideoWidth, mVideoHeight);
        mMediaPlayer.start();
    }
}

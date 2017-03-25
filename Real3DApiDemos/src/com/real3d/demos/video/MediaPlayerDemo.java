/*
 * Copyright (C) 2009 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.real3d.demos.video;

import com.real3d.demos.R;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;

public class MediaPlayerDemo extends Activity {
    private Button mAutoDetectVideo;
    private Button mManualSSVideo;
    private Button mManualTBVideo;
    private static final String MEDIA = "media";
    private static final int AUTO_DETECT_VIDEO = 1;
    private static final int MANUAL_SS_VIDEO = 2;
    private static final int MANUAL_TB_VIDEO = 3;

    @Override
    protected void onCreate(Bundle icicle) {
        super.onCreate(icicle);
        setContentView(R.layout.mediaplayer_1);

        mAutoDetectVideo = (Button) findViewById(R.id.auto);
        mAutoDetectVideo.setOnClickListener(mAutoVideoListener);
        mManualSSVideo = (Button) findViewById(R.id.manual_ss);
        mManualSSVideo.setOnClickListener(mManualSSVideoListener);
        mManualTBVideo = (Button) findViewById(R.id.manual_tb);
        mManualTBVideo.setOnClickListener(mManualTBVideoListener);
    }

    private OnClickListener mAutoVideoListener = new OnClickListener() {
        public void onClick(View v) {
            Intent intent =
                    new Intent(MediaPlayerDemo.this,
                            MediaPlayerDemo_Video.class);
            intent.putExtra(MEDIA, AUTO_DETECT_VIDEO);
            startActivity(intent);
        }
    };
    private OnClickListener mManualSSVideoListener = new OnClickListener() {
        public void onClick(View v) {
            Intent intent =
                    new Intent(MediaPlayerDemo.this,
                            MediaPlayerDemo_Video.class);
            intent.putExtra(MEDIA, MANUAL_SS_VIDEO);
            startActivity(intent);
        }
    };
    private OnClickListener mManualTBVideoListener = new OnClickListener() {
        public void onClick(View v) {
            Intent intent =
                    new Intent(MediaPlayerDemo.this,
                            MediaPlayerDemo_Video.class);
            intent.putExtra(MEDIA, MANUAL_TB_VIDEO);
            startActivity(intent);
        }
    };
}

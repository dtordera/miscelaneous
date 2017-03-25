/*
 * Copyright (C) 2007 The Android Open Source Project
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

package com.real3d.demos.camera;


import com.lge.real3d.Real3D;
import com.lge.real3d.Real3DInfo;
import com.real3d.demos.R;

import android.app.Activity;
import android.graphics.PixelFormat;
import android.opengl.GLSurfaceView;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;

// ----------------------------------------------------------------------

public class CameraPreviewWithOpengl extends Activity {
    private GLSurfaceView mGLView;
    private GLOpaqueRenderer mRenderer;
    private Real3D mReal3DForGL;
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // Hide the window title.
        requestWindowFeature(Window.FEATURE_NO_TITLE);

        View mainView = getLayoutInflater().inflate(R.layout.camera_opengl, null);

        mGLView = (GLSurfaceView) mainView.findViewById(R.id.gl_view);
        mReal3DForGL = new Real3D(mGLView.getHolder());
        mReal3DForGL.setReal3DInfo(new Real3DInfo(true, Real3D.REAL3D_TYPE_SS, Real3D.REAL3D_ORDER_LR));
        mRenderer = new GLOpaqueRenderer(this);
        mGLView.setEGLConfigChooser(8, 8, 8, 8, 16, 0);
        mGLView.setRenderer(mRenderer);
        mGLView.setRenderMode(GLSurfaceView.RENDERMODE_CONTINUOUSLY);
        mGLView.getHolder().setFormat(PixelFormat.TRANSLUCENT);
        
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
        setContentView(mainView);
    }
    @Override
    protected void onResume() {
        super.onResume();
        mGLView.onResume();
    }

    @Override
    protected void onPause() {
        super.onPause();
        mGLView.onPause();
    }
}

// ----------------------------------------------------------------------



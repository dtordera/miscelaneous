/*
 * Copyright (C) 2011 The Android Open Source Project
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

/*
 * This file is auto-generated. DO NOT MODIFY!
 * The source Renderscript file: /home/nnn/workspace/Balls/src/com/example/android/rs/balls/ball_physics.rs
 */
package com.example.android.rs.balls;

import android.renderscript.*;
import android.content.res.Resources;

/**
 * @hide
 */
public class ScriptC_ball_physics extends ScriptC {
    // Constructor
    public  ScriptC_ball_physics(RenderScript rs, Resources resources, int id) {
        super(rs, resources, id);
        mExportVar_gGravityVector = new Float2();
        mExportVar_gGravityVector.x = 0f;
        mExportVar_gGravityVector.y = 9.8f;
        mExportVar_gMinPos = new Float2();
        mExportVar_gMinPos.x = 0f;
        mExportVar_gMinPos.y = 0f;
        mExportVar_gMaxPos = new Float2();
        mExportVar_gMaxPos.x = 1280f;
        mExportVar_gMaxPos.y = 700f;
        __ScriptField_Ball = ScriptField_Ball.createElement(rs);
    }

    private Element __ScriptField_Ball;
    private final static int mExportVarIdx_balls = 0;
    private ScriptField_Ball mExportVar_balls;
    public void bind_balls(ScriptField_Ball v) {
        mExportVar_balls = v;
        if (v == null) bindAllocation(null, mExportVarIdx_balls);
        else bindAllocation(v.getAllocation(), mExportVarIdx_balls);
    }

    public ScriptField_Ball get_balls() {
        return mExportVar_balls;
    }

    private final static int mExportVarIdx_gGravityVector = 1;
    private Float2 mExportVar_gGravityVector;
    public void set_gGravityVector(Float2 v) {
        mExportVar_gGravityVector = v;
        FieldPacker fp = new FieldPacker(8);
        fp.addF32(v);
        setVar(mExportVarIdx_gGravityVector, fp);
    }

    public Float2 get_gGravityVector() {
        return mExportVar_gGravityVector;
    }

    private final static int mExportVarIdx_gMinPos = 2;
    private Float2 mExportVar_gMinPos;
    public void set_gMinPos(Float2 v) {
        mExportVar_gMinPos = v;
        FieldPacker fp = new FieldPacker(8);
        fp.addF32(v);
        setVar(mExportVarIdx_gMinPos, fp);
    }

    public Float2 get_gMinPos() {
        return mExportVar_gMinPos;
    }

    private final static int mExportVarIdx_gMaxPos = 3;
    private Float2 mExportVar_gMaxPos;
    public void set_gMaxPos(Float2 v) {
        mExportVar_gMaxPos = v;
        FieldPacker fp = new FieldPacker(8);
        fp.addF32(v);
        setVar(mExportVarIdx_gMaxPos, fp);
    }

    public Float2 get_gMaxPos() {
        return mExportVar_gMaxPos;
    }

    private final static int mExportForEachIdx_root = 0;
    public void forEach_root(Allocation ain, Allocation aout, ScriptField_BallControl.Item ctl) {
        // check ain
        if (!ain.getType().getElement().isCompatible(__ScriptField_Ball)) {
            throw new RSRuntimeException("Type mismatch with ScriptField_Ball!");
        }
        // check aout
        if (!aout.getType().getElement().isCompatible(__ScriptField_Ball)) {
            throw new RSRuntimeException("Type mismatch with ScriptField_Ball!");
        }
        // Verify dimensions
        Type tIn = ain.getType();
        Type tOut = aout.getType();
        if ((tIn.getCount() != tOut.getCount()) ||
            (tIn.getX() != tOut.getX()) ||
            (tIn.getY() != tOut.getY()) ||
            (tIn.getZ() != tOut.getZ()) ||
            (tIn.hasFaces() != tOut.hasFaces()) ||
            (tIn.hasMipmaps() != tOut.hasMipmaps())) {
            throw new RSRuntimeException("Dimension mismatch between input and output parameters!");
        }
        FieldPacker root_fp = new FieldPacker(16);
        root_fp.addU32(ctl.dimX);
        root_fp.addObj(ctl.ain);
        root_fp.addObj(ctl.aout);
        root_fp.addF32(ctl.dt);
        forEach(mExportForEachIdx_root, ain, aout, root_fp);
    }

    private final static int mExportFuncIdx_touch = 0;
    public void invoke_touch(float x, float y, float pressure, int id) {
        FieldPacker touch_fp = new FieldPacker(16);
        touch_fp.addF32(x);
        touch_fp.addF32(y);
        touch_fp.addF32(pressure);
        touch_fp.addI32(id);
        invoke(mExportFuncIdx_touch, touch_fp);
    }

}


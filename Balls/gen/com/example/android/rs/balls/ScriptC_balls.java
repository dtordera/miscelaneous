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
 * The source Renderscript file: /home/nnn/workspace/Balls/src/com/example/android/rs/balls/balls.rs
 */
package com.example.android.rs.balls;

import android.renderscript.*;
import android.content.res.Resources;

/**
 * @hide
 */
public class ScriptC_balls extends ScriptC {
    // Constructor
    public  ScriptC_balls(RenderScript rs, Resources resources, int id) {
        super(rs, resources, id);
    }

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

    private final static int mExportVarIdx_gPFPoints = 1;
    private ProgramFragment mExportVar_gPFPoints;
    public void set_gPFPoints(ProgramFragment v) {
        mExportVar_gPFPoints = v;
        setVar(mExportVarIdx_gPFPoints, v);
    }

    public ProgramFragment get_gPFPoints() {
        return mExportVar_gPFPoints;
    }

    private final static int mExportVarIdx_gPFLines = 2;
    private ProgramFragment mExportVar_gPFLines;
    public void set_gPFLines(ProgramFragment v) {
        mExportVar_gPFLines = v;
        setVar(mExportVarIdx_gPFLines, v);
    }

    public ProgramFragment get_gPFLines() {
        return mExportVar_gPFLines;
    }

    private final static int mExportVarIdx_partMesh = 3;
    private Mesh mExportVar_partMesh;
    public void set_partMesh(Mesh v) {
        mExportVar_partMesh = v;
        setVar(mExportVarIdx_partMesh, v);
    }

    public Mesh get_partMesh() {
        return mExportVar_partMesh;
    }

    private final static int mExportVarIdx_point = 4;
    private ScriptField_Point mExportVar_point;
    public void bind_point(ScriptField_Point v) {
        mExportVar_point = v;
        if (v == null) bindAllocation(null, mExportVarIdx_point);
        else bindAllocation(v.getAllocation(), mExportVarIdx_point);
    }

    public ScriptField_Point get_point() {
        return mExportVar_point;
    }

    private final static int mExportVarIdx_vpConstants = 5;
    private ScriptField_VpConsts mExportVar_vpConstants;
    public void bind_vpConstants(ScriptField_VpConsts v) {
        mExportVar_vpConstants = v;
        if (v == null) bindAllocation(null, mExportVarIdx_vpConstants);
        else bindAllocation(v.getAllocation(), mExportVarIdx_vpConstants);
    }

    public ScriptField_VpConsts get_vpConstants() {
        return mExportVar_vpConstants;
    }

    private final static int mExportVarIdx_physics_script = 6;
    private Script mExportVar_physics_script;
    public void set_physics_script(Script v) {
        mExportVar_physics_script = v;
        setVar(mExportVarIdx_physics_script, v);
    }

    public Script get_physics_script() {
        return mExportVar_physics_script;
    }

    private final static int mExportVarIdx_balls1 = 7;
    private ScriptField_Ball mExportVar_balls1;
    public void bind_balls1(ScriptField_Ball v) {
        mExportVar_balls1 = v;
        if (v == null) bindAllocation(null, mExportVarIdx_balls1);
        else bindAllocation(v.getAllocation(), mExportVarIdx_balls1);
    }

    public ScriptField_Ball get_balls1() {
        return mExportVar_balls1;
    }

    private final static int mExportVarIdx_balls2 = 8;
    private ScriptField_Ball mExportVar_balls2;
    public void bind_balls2(ScriptField_Ball v) {
        mExportVar_balls2 = v;
        if (v == null) bindAllocation(null, mExportVarIdx_balls2);
        else bindAllocation(v.getAllocation(), mExportVarIdx_balls2);
    }

    public ScriptField_Ball get_balls2() {
        return mExportVar_balls2;
    }

    private final static int mExportFuncIdx_initParts = 0;
    public void invoke_initParts(int w, int h) {
        FieldPacker initParts_fp = new FieldPacker(8);
        initParts_fp.addI32(w);
        initParts_fp.addI32(h);
        invoke(mExportFuncIdx_initParts, initParts_fp);
    }

}


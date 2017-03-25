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
 * The source Renderscript file: /home/nnn/workspace/FountainFbo/src/com/example/android/rs/fountainfbo/fountainfbo.rs
 */
package com.example.android.rs.fountainfbo;

import android.renderscript.*;
import android.content.res.Resources;

/**
 * @hide
 */
public class ScriptC_fountainfbo extends ScriptC {
    // Constructor
    public  ScriptC_fountainfbo(RenderScript rs, Resources resources, int id) {
        super(rs, resources, id);
    }

    private final static int mExportVarIdx_partMesh = 0;
    private Mesh mExportVar_partMesh;
    public void set_partMesh(Mesh v) {
        mExportVar_partMesh = v;
        setVar(mExportVarIdx_partMesh, v);
    }

    public Mesh get_partMesh() {
        return mExportVar_partMesh;
    }

    private final static int mExportVarIdx_gProgramVertex = 1;
    private ProgramVertex mExportVar_gProgramVertex;
    public void set_gProgramVertex(ProgramVertex v) {
        mExportVar_gProgramVertex = v;
        setVar(mExportVarIdx_gProgramVertex, v);
    }

    public ProgramVertex get_gProgramVertex() {
        return mExportVar_gProgramVertex;
    }

    private final static int mExportVarIdx_gColorBuffer = 2;
    private Allocation mExportVar_gColorBuffer;
    public void set_gColorBuffer(Allocation v) {
        mExportVar_gColorBuffer = v;
        setVar(mExportVarIdx_gColorBuffer, v);
    }

    public Allocation get_gColorBuffer() {
        return mExportVar_gColorBuffer;
    }

    private final static int mExportVarIdx_gProgramFragment = 3;
    private ProgramFragment mExportVar_gProgramFragment;
    public void set_gProgramFragment(ProgramFragment v) {
        mExportVar_gProgramFragment = v;
        setVar(mExportVarIdx_gProgramFragment, v);
    }

    public ProgramFragment get_gProgramFragment() {
        return mExportVar_gProgramFragment;
    }

    private final static int mExportVarIdx_gTextureProgramFragment = 4;
    private ProgramFragment mExportVar_gTextureProgramFragment;
    public void set_gTextureProgramFragment(ProgramFragment v) {
        mExportVar_gTextureProgramFragment = v;
        setVar(mExportVarIdx_gTextureProgramFragment, v);
    }

    public ProgramFragment get_gTextureProgramFragment() {
        return mExportVar_gTextureProgramFragment;
    }

    private final static int mExportVarIdx_point = 5;
    private ScriptField_Point mExportVar_point;
    public void bind_point(ScriptField_Point v) {
        mExportVar_point = v;
        if (v == null) bindAllocation(null, mExportVarIdx_point);
        else bindAllocation(v.getAllocation(), mExportVarIdx_point);
    }

    public ScriptField_Point get_point() {
        return mExportVar_point;
    }

    private final static int mExportFuncIdx_addParticles = 0;
    public void invoke_addParticles(int rate, float x, float y, int index, boolean newColor) {
        FieldPacker addParticles_fp = new FieldPacker(20);
        addParticles_fp.addI32(rate);
        addParticles_fp.addF32(x);
        addParticles_fp.addF32(y);
        addParticles_fp.addI32(index);
        addParticles_fp.addBoolean(newColor);
        addParticles_fp.skip(3);
        invoke(mExportFuncIdx_addParticles, addParticles_fp);
    }

}


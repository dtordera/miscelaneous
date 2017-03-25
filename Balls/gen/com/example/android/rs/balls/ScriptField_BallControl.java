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
public class ScriptField_BallControl extends android.renderscript.Script.FieldBase {
    static public class Item {
        public static final int sizeof = 16;

        long dimX;
        Allocation ain;
        Allocation aout;
        float dt;

        Item() {
        }

    }

    private Item mItemArray[];
    private FieldPacker mIOBuffer;
    public static Element createElement(RenderScript rs) {
        Element.Builder eb = new Element.Builder(rs);
        eb.add(Element.U32(rs), "dimX");
        eb.add(Element.ALLOCATION(rs), "ain");
        eb.add(Element.ALLOCATION(rs), "aout");
        eb.add(Element.F32(rs), "dt");
        return eb.create();
    }

    public  ScriptField_BallControl(RenderScript rs, int count) {
        mItemArray = null;
        mIOBuffer = null;
        mElement = createElement(rs);
        init(rs, count);
    }

    public  ScriptField_BallControl(RenderScript rs, int count, int usages) {
        mItemArray = null;
        mIOBuffer = null;
        mElement = createElement(rs);
        init(rs, count, usages);
    }

    private void copyToArrayLocal(Item i, FieldPacker fp) {
        fp.addU32(i.dimX);
        fp.addObj(i.ain);
        fp.addObj(i.aout);
        fp.addF32(i.dt);
    }

    private void copyToArray(Item i, int index) {
        if (mIOBuffer == null) mIOBuffer = new FieldPacker(Item.sizeof * getType().getX()/* count */);
        mIOBuffer.reset(index * Item.sizeof);
        copyToArrayLocal(i, mIOBuffer);
    }

    public synchronized void set(Item i, int index, boolean copyNow) {
        if (mItemArray == null) mItemArray = new Item[getType().getX() /* count */];
        mItemArray[index] = i;
        if (copyNow)  {
            copyToArray(i, index);
            FieldPacker fp = new FieldPacker(Item.sizeof);
            copyToArrayLocal(i, fp);
            mAllocation.setFromFieldPacker(index, fp);
        }

    }

    public synchronized Item get(int index) {
        if (mItemArray == null) return null;
        return mItemArray[index];
    }

    public synchronized void set_dimX(int index, long v, boolean copyNow) {
        if (mIOBuffer == null) mIOBuffer = new FieldPacker(Item.sizeof * getType().getX()/* count */);
        if (mItemArray == null) mItemArray = new Item[getType().getX() /* count */];
        if (mItemArray[index] == null) mItemArray[index] = new Item();
        mItemArray[index].dimX = v;
        if (copyNow)  {
            mIOBuffer.reset(index * Item.sizeof);
            mIOBuffer.addU32(v);
            FieldPacker fp = new FieldPacker(4);
            fp.addU32(v);
            mAllocation.setFromFieldPacker(index, 0, fp);
        }

    }

    public synchronized void set_ain(int index, Allocation v, boolean copyNow) {
        if (mIOBuffer == null) mIOBuffer = new FieldPacker(Item.sizeof * getType().getX()/* count */);
        if (mItemArray == null) mItemArray = new Item[getType().getX() /* count */];
        if (mItemArray[index] == null) mItemArray[index] = new Item();
        mItemArray[index].ain = v;
        if (copyNow)  {
            mIOBuffer.reset(index * Item.sizeof + 4);
            mIOBuffer.addObj(v);
            FieldPacker fp = new FieldPacker(4);
            fp.addObj(v);
            mAllocation.setFromFieldPacker(index, 1, fp);
        }

    }

    public synchronized void set_aout(int index, Allocation v, boolean copyNow) {
        if (mIOBuffer == null) mIOBuffer = new FieldPacker(Item.sizeof * getType().getX()/* count */);
        if (mItemArray == null) mItemArray = new Item[getType().getX() /* count */];
        if (mItemArray[index] == null) mItemArray[index] = new Item();
        mItemArray[index].aout = v;
        if (copyNow)  {
            mIOBuffer.reset(index * Item.sizeof + 8);
            mIOBuffer.addObj(v);
            FieldPacker fp = new FieldPacker(4);
            fp.addObj(v);
            mAllocation.setFromFieldPacker(index, 2, fp);
        }

    }

    public synchronized void set_dt(int index, float v, boolean copyNow) {
        if (mIOBuffer == null) mIOBuffer = new FieldPacker(Item.sizeof * getType().getX()/* count */);
        if (mItemArray == null) mItemArray = new Item[getType().getX() /* count */];
        if (mItemArray[index] == null) mItemArray[index] = new Item();
        mItemArray[index].dt = v;
        if (copyNow)  {
            mIOBuffer.reset(index * Item.sizeof + 12);
            mIOBuffer.addF32(v);
            FieldPacker fp = new FieldPacker(4);
            fp.addF32(v);
            mAllocation.setFromFieldPacker(index, 3, fp);
        }

    }

    public synchronized long get_dimX(int index) {
        if (mItemArray == null) return 0;
        return mItemArray[index].dimX;
    }

    public synchronized Allocation get_ain(int index) {
        if (mItemArray == null) return null;
        return mItemArray[index].ain;
    }

    public synchronized Allocation get_aout(int index) {
        if (mItemArray == null) return null;
        return mItemArray[index].aout;
    }

    public synchronized float get_dt(int index) {
        if (mItemArray == null) return 0;
        return mItemArray[index].dt;
    }

    public synchronized void copyAll() {
        for (int ct = 0; ct < mItemArray.length; ct++) copyToArray(mItemArray[ct], ct);
        mAllocation.setFromFieldPacker(0, mIOBuffer);
    }

    public synchronized void resize(int newSize) {
        if (mItemArray != null)  {
            int oldSize = mItemArray.length;
            int copySize = Math.min(oldSize, newSize);
            if (newSize == oldSize) return;
            Item ni[] = new Item[newSize];
            System.arraycopy(mItemArray, 0, ni, 0, copySize);
            mItemArray = ni;
        }

        mAllocation.resize(newSize);
        if (mIOBuffer != null) mIOBuffer = new FieldPacker(Item.sizeof * getType().getX()/* count */);
    }

}


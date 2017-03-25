package meves.apps.test;

import java.util.Random;

import android.app.Activity;
import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Rect;
import android.os.Bundle;
import android.view.View;

public class TerrainActivity extends Activity {
    /** Called when the activity is first created. */
    @Override public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(new TerrainView(this));
    }
    
    public static class TerrainView extends View {
    	Paint p;
    	Random rnd;
    
    	public TerrainView(Context context){
    		super(context);
    		p = new Paint();
//    		p.setAlpha(0xff);
    		
    		rnd=new Random();
    	}
    	
    	@Override protected void onDraw(Canvas canvas){
    		super .onDraw(canvas);

    		int w = this.getWidth();
    		int h = this.getHeight();
    		
    		p.setColor(0xffffff);
    		p.setAntiAlias(true);
    		canvas.drawRect(new Rect(0,0,w/2,h/2),p);    		
    		    		
    		for (int j=0;j<h;j++)
    		for (int i=1;i<w;i++)
    		{
    			p.setColor(0x0000ff);
    			canvas.drawRect(new Rect(i,j,i+1,j+1),p);
    		}
    	}    	
    }
}
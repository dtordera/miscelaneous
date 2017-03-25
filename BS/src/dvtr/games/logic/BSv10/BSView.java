package dvtr.games.logic.BSv10;

import android.content.Context;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.drawable.Drawable;
import android.view.View;

public class BSView extends View {

	Puzzle P;
	Bitmap[] bmps;
	Paint mPaint;

	public BSView(Context context) {
		super(context);
				
		InitGame();
		InitView();
	}
	
	public void InitView(){
	
        Resources r = this.getContext().getResources();		
        
		bmps = new Bitmap[8];
        
        setFocusable(true);
                        
		loadTile(K.A,r.getDrawable(R.drawable.pa));
		loadTile(K.M,r.getDrawable(R.drawable.pp));
		loadTile(K.X,r.getDrawable(R.drawable.px));
		loadTile(K.N,r.getDrawable(R.drawable.pn));
		loadTile(K.S,r.getDrawable(R.drawable.ps));
		loadTile(K.E,r.getDrawable(R.drawable.pe));
		loadTile(K.O,r.getDrawable(R.drawable.po));
		loadTile(K.B,r.getDrawable(R.drawable.pb));
		
		mPaint = new Paint();
		mPaint.setColor(Color.WHITE);
		mPaint.setAlpha(0xaa);
		mPaint.setAntiAlias(true);
		mPaint.setTextSize(24);
	}
	
	public void InitGame(){
		P = new FactoriaPuzzle(8,8,new int[]{4,3,3,2,2,2,1,1,1,1},true).Genera();                	
	}
	
    public void loadTile(byte key, Drawable tile) {
        Bitmap bitmap = Bitmap.createBitmap(45,45,Bitmap.Config.ARGB_8888);
        Canvas canvas = new Canvas(bitmap);
        tile.setBounds(0,0,45,45);
        tile.draw(canvas);
        
        bmps[key] = bitmap;
    }	
	
	public void onDraw(Canvas canvas){
//		super .onDraw(canvas);
		
		for (int j=0;j<P.R;j++)	
		{			
			for (int i=0;i<P.C;i++)			
			if (P.v(i,j) > -1)
				canvas.drawBitmap(bmps[P.v(i,j)],(i+1)*46,j*46,mPaint);
				
			canvas.drawText(""+P.SC[j],46*10,(j+1)*46-15,mPaint);				
		}
		
		for (int i=0;i<P.C;i++)
			canvas.drawText(""+P.SR[i],(i+1)*46,20,mPaint);
	}
}

package dvtr.games.logic.BSv10;

import android.app.Activity;
import android.os.Bundle;

public class BSGame extends Activity {

    public void onCreate(Bundle savedInstanceState) {
    
    	BSView mBSView = new BSView(this);
    
        super.onCreate(savedInstanceState);
        setContentView(mBSView);
    }
}

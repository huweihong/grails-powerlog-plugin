package com.si.powerlog

import com.si.powerlog.CometDService
import org.codehaus.groovy.grails.web.context.ServletContextHolder
import org.codehaus.groovy.grails.web.servlet.GrailsApplicationAttributes
import org.springframework.context.ApplicationContext

class CometDWriter extends Writer { 
     
    
     /** 
     * 发送消息到 CometD
     * @param cbuf 
     * @param off 
     * @param len 
     */ 
     private void sendMessage(char[] cbuf, int off, int len){ 
         ApplicationContext context =  (ApplicationContext) ServletContextHolder.getServletContext()?.getAttribute(GrailsApplicationAttributes.APPLICATION_CONTEXT); 		
         CometDService cometDService = (CometDService) context?.getBean("cometDService");
         
         cometDService?.pushLog(new String(cbuf, off, len),"/results/powerlog")
     } 

     //private static final Writer DEFAULT_WRITER = new OutputStreamWriter(System.out);

     @Override 
     public void write(char[] cbuf, int off, int len) throws IOException { 
        // DEFAULT_WRITER.write(cbuf, off, len); 
         sendMessage(cbuf, off, len); 
     } 

     @Override 
     public void flush() throws IOException { 
         //DEFAULT_WRITER.flush(); 
     } 

     @Override 
     public void close() throws IOException { 
         //DEFAULT_WRITER.close(); 
     } 
 } 
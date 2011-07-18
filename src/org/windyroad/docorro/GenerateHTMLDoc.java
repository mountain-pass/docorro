package org.windyroad.docorro;


import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.List;
import java.util.Iterator;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Request;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;

import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileItemFactory;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.w3c.dom.Document;

import com.sun.jersey.api.container.filter.LoggingFilter;

import org.windyroad.docorro.utils.*;



//Map URL to the generateSampleDoc
@Path("/generateSampleDoc")
public class GenerateHTMLDoc {
	@Context ServletContext context;
	//Allows to insert contextual objects into the class,
	//e.g. ServletContext, Request, Response, UriInfo
	@Context
	UriInfo uriInfo;
	@Context
	Request request;
	
	//Return a welcome page to the user in the browser
	@GET
	@Produces(MediaType.TEXT_HTML)
	public String sayWelcome(){
		System.out.println("This is a GET message---------");
		String endHTML="";
		String workingPath;
		try {
			//workingPath = context.getResource("/WEB-INF").getPath();
			StringBuffer fileData = new StringBuffer(1000);
			//Using the classLoader to get the file in the Classes
			//This method allow us to read the file from any web server
			InputStream uploadFileIS = GenerateHTMLDoc.class.getClassLoader().getResourceAsStream("/test/quick/UploadFile.html");
			BufferedReader reader = new BufferedReader(new InputStreamReader(uploadFileIS));
			//Tomcat use this
			//BufferedReader reader = new BufferedReader(new FileReader("../UploadFile.html"));
			char[] buf = new char[1024];
			int numRead=0;
			while((numRead=reader.read(buf))!=-1){
				String readData = String.valueOf(buf,0,numRead);
				fileData.append(readData);
				buf=new char[1024];
			}
			reader.close();
			endHTML = fileData.toString();
			return endHTML;
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(endHTML == ""){
			return "<html> " + "<title>" + "Docorro - Special Document Generation Thingy" + "</title>" + 
		"<body><h1>" +"Hello," +
				" Welcome to Docorro!!!!" + "</h1></body>" + "</html>";
		}else
		{
			return endHTML;
		}
	}
	
	// Push data to this interface (POST)
	@POST
	@Path("upload")
	@Produces(MediaType.TEXT_HTML)
	//@Consumes("mutipart/form-data")
	public String uploadDocument(@Context HttpServletRequest request) {
		String endHTML = "";
		try{
			LoggingFilter logFilter = new LoggingFilter();
			if(ServletFileUpload.isMultipartContent(request)){
				FileItemFactory factory = new DiskFileItemFactory();
				ServletFileUpload upload = new ServletFileUpload(factory);
				List<FileItem> items=null;
				try{
					items = upload.parseRequest(request);
				}catch (FileUploadException e){
					e.printStackTrace();
				}
				if(items!=null){
					Iterator<FileItem> iter = items.iterator();
					while(iter.hasNext()){
						FileItem item = iter.next();
						if(!item.isFormField() && item.getSize() >0){
							//System.out.println("The file name is: " + item.getName());
							Utilities util = new Utilities();
							Document doc = util.translateInputStreamIntoXMLDoc(item.getInputStream());
							endHTML = util.transformSchemeToDoc(doc);
						}
					}
				}
			}
			Response.ok().build();
			
		} catch(Exception e){
			//throw new WebApplicationException(e, Response.Status.INTERNAL_SERVER_ERROR);
			Utilities util = new Utilities();
			endHTML = util.getErrorPage();
		} finally{
			return endHTML;
		}
		
	}


}

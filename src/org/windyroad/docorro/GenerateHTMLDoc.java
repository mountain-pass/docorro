package org.windyroad.docorro;


import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.StringWriter;
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
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileItemFactory;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.w3c.dom.Document;
import org.xml.sax.SAXException;

import com.sun.jersey.api.container.filter.LoggingFilter;




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
			InputStream uploadFileIS = GenerateHTMLDoc.class.getClassLoader().getResourceAsStream("UploadFile.html");
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
		try{
			String endHTML = "";
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
							System.out.println("The file name is: " + item.getName());
							Document doc = translateItemIntoXMLDoc(item);
							endHTML = transformSchemeToDoc(doc);
							System.out.println("Output HTML --" + endHTML);
						}
							//can do the write later if needed
//							try{
//								String fileDirectory= new File(".").getAbsolutePath();
//								System.out.println(fileDirectory);
//								item.write(new File(fileDirectory + item.getName()));
//							}catch(Exception e){
//								e.printStackTrace();
//							}
					}
				}
			}
			Response.ok().build();
			//Using Servlet context declared at the top of the class
			return endHTML;
			
//			FormDataContentDisposition contentDisp = bodyPart.getFormDataContentDisposition();
//			InputStream in = bodyPart.getValueAs(InputStream.class);
//			String fileName = contentDisp.getFileName();
//			System.out.println("Here is the file name: " + fileName);
//			//FormDataBodyPart p = binaryData.getField("file");
//			//InputStream file = p.getValueAs(InputStream.class);
//			//File workingFile = writeToFile(binaryData);
//			System.out.println("This is a POST message");
//			//System.out.println("This is the user input: " + workingFile.getName());
//			URI uri = uriInfo.getAbsolutePath();
//			System.out.println("This is the current uri Path: " + uri.toString());
			
			
		} catch(Exception e){
			throw new WebApplicationException(e, Response.Status.INTERNAL_SERVER_ERROR);
		}
		
	}
	
	//Translate FileItem into a Document
	private Document translateItemIntoXMLDoc(FileItem item){
		try {
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder docBuilder = dbf.newDocumentBuilder();
			InputStream fileStream = item.getInputStream();
			Document doc = docBuilder.parse(fileStream);
			return doc;
		} catch (ParserConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SAXException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
		
	}
	
	//Parse Document Using SAXON and Docorro XSLT
	private String transformSchemeToDoc(Document doc){
		//Set the TransformFactory to use SAXON transformerFactoryImpl method
		System.setProperty("javax.xml.transform.TransformerFactory", "net.sf.saxon.TransformerFactoryImpl");

		try {

			//Create a transform factory instane
			TransformerFactory factory = TransformerFactory.newInstance();
			//Create a transformer for the stylesheet
			
			//String workingPath = context.getResource("/WEB-INF").getPath();
			String currentDirector = "/xslt/docorro.xslt";
			//Only use this for local TOMCAT
			//String currentDirector = "/Users/Sam/Documents/workspace/DocumentGenerator/WebContent/WEB-INF/xslt/docorro.xslt";
			InputStream xlstDoc = GenerateHTMLDoc.class.getClassLoader().getResourceAsStream(currentDirector);
			Transformer transformer = factory.newTransformer(new StreamSource(xlstDoc));
			
			DOMSource domSource = new DOMSource(doc);
			//Create a String writer
			StringWriter sw = new StringWriter();
			StreamResult result = new StreamResult(sw);
			transformer.transform(domSource, result);
			return sw.toString();
			
		} catch (TransformerConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (TransformerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	
	}


}

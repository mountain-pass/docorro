package org.windyroad.docorro.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.StringWriter;

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
import org.w3c.dom.Document;
import org.windyroad.docorro.GenerateHTMLDoc;
import org.xml.sax.SAXException;



public class Utilities {
	
	//Translate FileItem into a Document
	public Document translateInputStreamIntoXMLDoc(InputStream inputfile){
		try {
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder docBuilder = dbf.newDocumentBuilder();
			Document doc = docBuilder.parse(inputfile);
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
	public String transformSchemeToDoc(Document doc){
		//Set the TransformFactory to use SAXON transformerFactoryImpl method
		System.setProperty("javax.xml.transform.TransformerFactory", "net.sf.saxon.TransformerFactoryImpl");

		try {

			//Create a transform factory instane
			TransformerFactory factory = TransformerFactory.newInstance();
			//Create a transformer for the stylesheet
			
			//String workingPath = context.getResource("/WEB-INF").getPath();
			String workingXSLT = "/xslt/docorro.xslt";
			//Only use this for local TOMCAT
			//String currentDirector = "/Users/Sam/Documents/workspace/DocumentGenerator/WebContent/WEB-INF/xslt/docorro.xslt";
			InputStream xlstDoc = GenerateHTMLDoc.class.getClassLoader().getResourceAsStream(workingXSLT);
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
	
	
	//Load error page and return as string
	public String getErrorPage() throws IOException{
		StringBuffer fileData = new StringBuffer(1000);
		String errorPageDirectory = "/test/quick";
		InputStream errorPageIS = Utilities.class.getClassLoader().getResourceAsStream(errorPageDirectory +"/ErrorPage.html");
		BufferedReader reader = new BufferedReader(new InputStreamReader(errorPageIS));
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
		return fileData.toString();
	}


}

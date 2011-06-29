package test.org.windyroad.docorro.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;

import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;


import org.junit.*;
import static org.junit.Assert.*;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.windyroad.docorro.utils.*;


public class UtilititesTest {
	
	InputStream testData;
	
	@Before 
	public void setUp() throws FileNotFoundException {
		String currDir = System.getProperty("user.dir");
		File file = new File(currDir+"/src/test/org/windyroad/docorro/utils/testData.xml");
		testData = new FileInputStream(file);	
	}

	@Test
	public void Test_transalateInputStreamIntoXMLDoc() throws XPathExpressionException{
		System.out.println("Test translateInputStreamIntoXMLDoc");
		Utilities util = new Utilities();
		Document doc = util.translateInputStreamIntoXMLDoc(testData);
		XPathFactory factory = XPathFactory.newInstance();
		XPath xpath = factory.newXPath();
		XPathExpression expr = xpath.compile("//Business/Name/text()");
		Object result = expr.evaluate(doc, XPathConstants.NODESET);
		NodeList nodes = (NodeList) result;
		assertTrue(nodes.item(0).getNodeValue().equals("WindyRoad"));
		expr = xpath.compile("//Business/Projects/Project/Name/text()");
		result = expr.evaluate(doc, XPathConstants.NODESET);
		nodes = (NodeList) result;
		assertTrue(nodes.item(0).getNodeValue().equals("Docorro"));
		expr = xpath.compile("//Business/Projects/Project/Version/text()");
		result = expr.evaluate(doc, XPathConstants.NODESET);
		nodes = (NodeList) result;
		assertTrue(nodes.item(0).getNodeValue().equals("1.0"));
	}

}


package org;

import javax.xml.ws.Endpoint;
import org.windyroad.GenerateDocImpl;

public class WSPublisher {
	
	public static void main(String[] args) {
		Endpoint.publish("http://localhost:8080/WS/GenerateDoc",
				new GenerateDocImpl());
	}

}

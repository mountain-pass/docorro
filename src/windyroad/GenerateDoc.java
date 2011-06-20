package org.windyroad;

import javax.jws.WebMethod;
import javax.jws.WebService;

@WebService
public interface GenerateDoc {
	
	@WebMethod String sayHello(String name);

}

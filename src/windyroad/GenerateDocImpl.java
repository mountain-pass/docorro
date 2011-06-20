package org.windyroad;

import javax.jws.WebService;

@WebService(endpointInterface = "org.windyroad.GenerateDoc")
public class GenerateDocImpl implements GenerateDoc {
	
	@Override
	public String sayHello(String name){
		return "Hello, Wecome to Jax-ws " + name;
	}
	

}

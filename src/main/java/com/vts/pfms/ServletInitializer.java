package com.vts.pfms;

import java.util.Properties;

import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

public class ServletInitializer extends SpringBootServletInitializer {

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(PfmsApplication.class);
		/*	.properties(getProperties());*/
	}
		
		
		static Properties getProperties() 
		{
			Properties props = new Properties();
			props.put("spring.config.location","file:///C:/PMS/application.properties");
			return props;
		}
		
}

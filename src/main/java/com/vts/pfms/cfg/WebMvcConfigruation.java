//package com.vts.pfms.cfg;
//
//import org.springframework.boot.context.properties.ConfigurationProperties;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.ComponentScan;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.context.annotation.PropertySource;
//import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
//@Configuration
//
//@ComponentScan(basePackages = "com.vts.*")
//@ConfigurationProperties
//@PropertySource(value= "file:///${app.properties.path}")
//public class WebMvcConfigruation {
//                   
//		@Bean
//	    public BCryptPasswordEncoder passwordencoder(){
//	     return new BCryptPasswordEncoder();
//	    }
//}

package com.vts.pfms.cfg;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
@Configuration

@ComponentScan(basePackages = "com.vts.*")
@ConfigurationProperties
@PropertySource(value= "file:///${app.properties.path}")
public class WebMvcConfigruation implements WebMvcConfigurer {
                   
		@Bean
	    public BCryptPasswordEncoder passwordencoder(){
	     return new BCryptPasswordEncoder();
	    }
		
		 @Override
		    public void addCorsMappings(CorsRegistry registry) {
		        registry.addMapping("/**")  // This applies CORS to all endpoints
		                .allowedOrigins("http://192.168.1.22:3001")  // Replace with your frontend URL
		                .allowedMethods("GET", "POST", "PUT", "DELETE")  // Allowed HTTP methods
		                .allowedHeaders("Content-Type", "Authorization")  // Allowed headers
		                .allowCredentials(true);  // Allow credentials such as cookies or Authorization headers
		    }
}

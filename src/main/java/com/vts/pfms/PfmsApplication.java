package com.vts.pfms;

import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.web.client.RestTemplate;

@SpringBootApplication
public class PfmsApplication {


//	public static void main(String[] args) {
//		SpringApplication.run(PfmsApplication.class, args);
//	}

	@Bean
	   public RestTemplate getRestTemplate() {
	      return new RestTemplate();
	   }
	
}

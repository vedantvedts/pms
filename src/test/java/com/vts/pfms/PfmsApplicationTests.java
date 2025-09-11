package com.vts.pfms;

import java.time.LocalDateTime;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class PfmsApplicationTests {

	@Test
	void contextLoads() {
		System.out.println("LocalDateTime.now()" + LocalDateTime.now());
	}

}

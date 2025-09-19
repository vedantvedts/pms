package com.vts.pfms;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CspController {
	
	
	@PostMapping("/csp-report")
	@ResponseBody
	public void cspReport(@RequestBody String report) {
	    // For now just log to console
	    System.out.println("CSP Violation: " + report);

	    // Or send to your log framework
	    
	}


}

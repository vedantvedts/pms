package com.vts.pfms.login;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@FeignClient(name= "master-service", url = "${server_uri}"+"/master-service")
public interface PFMSLoginClient 
{
	@PostMapping("getLoginDetails.htm")
	public Login LoginDetails (@RequestParam String UserName);

}

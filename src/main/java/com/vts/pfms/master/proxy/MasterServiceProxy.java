package com.vts.pfms.master.proxy;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.vts.pfms.login.Login;

@FeignClient(name= "master-service", url = "${server_uri}"+"/master-service")
//@FeignClient(name= "master-service") // will work if its connected to naming server or service registry and load balancer
public interface MasterServiceProxy 
{
	@PostMapping("getLoginDetails.htm")
	public Login LoginDetails (@RequestParam String UserName);
}

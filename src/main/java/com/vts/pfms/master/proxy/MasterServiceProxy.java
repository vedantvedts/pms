package com.vts.pfms.master.proxy;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;

import com.vts.pfms.login.Login;

@FeignClient(name = "master-service", url = "${master_service_url:NA}")
public interface MasterServiceProxy {
    @PostMapping("getLoginDetails.htm")
    Login LoginDetails(@RequestHeader(name = "request_from", defaultValue = "VEDTS") String request_from,
                       @RequestParam("UserName") String UserName);
}


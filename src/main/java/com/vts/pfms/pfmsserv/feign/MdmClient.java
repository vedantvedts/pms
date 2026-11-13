package com.vts.pfms.pfmsserv.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import com.vts.pfms.login.AuthenticationRequest;
import com.vts.pfms.login.ErrorResponse;

@FeignClient(name = "MdmClient", url = "${mdm.url:NA}")
public interface MdmClient {

	@PostMapping( value = "/getAuthenticate")
    ResponseEntity<ErrorResponse> getAuthentication(@RequestBody AuthenticationRequest request);
}

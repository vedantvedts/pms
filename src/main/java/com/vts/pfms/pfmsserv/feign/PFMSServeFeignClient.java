package com.vts.pfms.pfmsserv.feign;

import java.util.List;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;

import com.vts.pfms.login.CCMView;

@FeignClient(name = "PFMSServeFeignClient", url = "${pfms_serv_url}")
public interface PFMSServeFeignClient {

    @PostMapping("/getCCMViewData")
    List<CCMView> getCCMViewData(@RequestHeader(name = "labcode") String LabCode);
}

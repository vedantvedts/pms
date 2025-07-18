package com.vts.pfms.userguide.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserGuideController {
	
	@GetMapping(value = "userGuide.htm")
	public String getUserGuide() {
		return "help/UserGuide";
	}
	
	@GetMapping(value = "CommitteeUserGuide.htm")
	public String getCommitteeUserGuide() {
		return "help/CommitteUserGuide";
	}
	
	@GetMapping(value = "ScheduleUserGuide.htm")
	public String getScheduleUserGuide() {
		return "help/ScheduleUserGuide";
	}
	
	@GetMapping(value = "ActionUserGuide.htm")
	public String getActionUserGuide() {
		return "help/ActionItemUserGuide";
	}
	
	@GetMapping(value = "MilestoneUserGuide.htm")
	public String getMilestoneUserGuide() {
		return "help/MilestoneUserGuide";
	}
	
	@GetMapping(value = "CARSUserGuide.htm")
	public String getCARSUserGuide() {
		return "help/CARSUserGuide";
	}

}

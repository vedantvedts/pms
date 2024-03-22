package com.vts.pfms.requirements.service;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.vts.pfms.FormatConverter;
import com.vts.pfms.project.dao.ProjectDao;
import com.vts.pfms.project.dto.PfmsInitiationRequirementDto;
import com.vts.pfms.project.model.PfmsInititationRequirement;
import com.vts.pfms.project.service.ProjectServiceImpl;
import com.vts.pfms.requirements.dao.RequirementDao;

@Service
public class RequirementServiceImpl implements RequirementService {

	@Value("${ApplicationFilesDrive}")
	String uploadpath;

	private static final Logger logger = LogManager.getLogger(RequirementServiceImpl.class);

	FormatConverter fc = new FormatConverter();
	private SimpleDateFormat sdf1 = fc.getSqlDateAndTimeFormat(); /* new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); */

	private SimpleDateFormat sdf = fc.getRegularDateFormat(); /* new SimpleDateFormat("dd-MM-yyyy"); */
	private SimpleDateFormat sdf2 = fc.getSqlDateFormat();
	private int year = Calendar.getInstance().get(Calendar.YEAR);
	private int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
	DecimalFormat df = new DecimalFormat("0.00");
	
	@Autowired
	RequirementDao dao;
	

	@Autowired
	ProjectDao prodao;
	
	@Override
	public List<Object[]> RequirementList(String initiationid, String projectId) throws Exception {
		return dao.RequirementList(initiationid,projectId);
	}
	@Override
	public long ProjectRequirementAdd(PfmsInitiationRequirementDto prd, String userId, String labCode)
			throws Exception {
		// TODO Auto-generated method stub
		PfmsInititationRequirement pir=new PfmsInititationRequirement();
		pir.setInitiationId(prd.getInitiationId());
		pir.setReqTypeId(prd.getReqTypeId());
		pir.setRequirementBrief(prd.getRequirementBrief());
		pir.setRequirementDesc(prd.getRequirementDesc());
		pir.setRequirementId(prd.getRequirementId());
		pir.setReqCount(prd.getReqCount());
		pir.setPriority(prd.getPriority());
		pir.setLinkedRequirements(prd.getLinkedRequirements());
		pir.setNeedType(prd.getNeedType());
		pir.setRemarks(prd.getRemarks());
		pir.setCategory(prd.getCategory());
		pir.setConstraints(prd.getConstraints());
		pir.setLinkedDocuments(prd.getLinkedDocuments());
		pir.setLinkedPara(prd.getLinkedPara());
		pir.setCreatedBy(userId);
		pir.setCreatedDate(sdf1.format(new Date()));
		pir.setIsActive(1);
		pir.setProjectId(prd.getProjectId());
		return prodao.ProjectRequirementAdd(pir);
	}
}

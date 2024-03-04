package com.vts.pfms.committee.service;

import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vts.pfms.FormatConverter;
import com.vts.pfms.committee.dao.CommitteeDao;
import com.vts.pfms.committee.dao.RODDao;
import com.vts.pfms.committee.dto.CommitteeScheduleDto;
import com.vts.pfms.committee.model.CommitteeSchedule;
import com.vts.pfms.committee.model.RODMaster;

@Service
public class RODServiceImpl implements RODService{

	private static final Logger logger = LogManager.getLogger(RODServiceImpl.class);
	
	FormatConverter fc=new FormatConverter();
	private SimpleDateFormat sdf1= fc.getSqlDateAndTimeFormat();  //new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private SimpleDateFormat sdf= fc.getRegularDateFormat();     //new SimpleDateFormat("dd-MM-yyyy");
	private SimpleDateFormat sdf2=	fc.getDateMonthShortName();   //new SimpleDateFormat("dd-MMM-yyyy");
	private SimpleDateFormat sdf3=	fc.getSqlDateFormat();			//	new SimpleDateFormat("yyyy-MM-dd");
	
	@Autowired
	RODDao dao;

	@Autowired
	CommitteeDao committeedao;
	
	@Override
	public List<Object[]> rodProjectScheduleListAll(String projectId) throws Exception {
		
		return dao.rodProjectScheduleListAll(projectId);
	}

	@Override
	public Object[] getRODMasterDetails(String rodNameId) throws Exception {
		
		return dao.getRODMasterDetails(rodNameId);
	}

	@Override
	public List<Object[]> rodProjectScheduleListAll(String projectId, String rodNameId) throws Exception {
		
		return dao.rodProjectScheduleListAll(projectId, rodNameId);
	}

	@Override
	public List<Object[]> rodNamesList() throws Exception {
		
		return dao.rodNamesList();
	}

	@Override
	public Long addNewRODName(RODMaster master) throws Exception {
		
		return dao.addNewRODName(master);
	}
	
	@Override
	public long RODScheduleAddSubmit(CommitteeScheduleDto committeescheduledto)throws Exception
	{
		logger.info(new Date() +"Inside SERVICE RODScheduleAddSubmit ");
		CommitteeSchedule committeeschedule = new  CommitteeSchedule(); 
		
		committeeschedule.setRODNameId(Long.parseLong(committeescheduledto.getRodNameId()));
		committeeschedule.setLabCode(committeescheduledto.getLabCode());	
		committeeschedule.setCommitteeId(committeescheduledto.getCommitteeId());
		committeeschedule.setProjectId(Long.parseLong(committeescheduledto.getProjectId()));
		committeeschedule.setScheduleStartTime(committeescheduledto.getScheduleStartTime());
		committeeschedule.setScheduleDate(new java.sql.Date(sdf.parse(committeescheduledto.getScheduleDate()).getTime()));
		committeeschedule.setScheduleSub("N");		
		committeeschedule.setScheduleFlag(committeescheduledto.getScheduleFlag());
		committeeschedule.setConfidential(Integer.parseInt(committeescheduledto.getConfidential()));
		committeeschedule.setDivisionId(Long.parseLong(committeescheduledto.getDivisionId()));
		committeeschedule.setInitiationId(Long.parseLong(committeescheduledto.getInitiationId()));
		committeeschedule.setPresentationFrozen("N");
		committeeschedule.setCreatedBy(committeescheduledto.getCreatedBy());
		committeeschedule.setCreatedDate(sdf1.format(new Date()));
		committeeschedule.setIsActive(1);
		String RODName= dao.getRODMasterDetails(committeescheduledto.getRodNameId().toString())[1].toString();
		String LabName=committeedao.LabDetails(committeeschedule.getLabCode())[1].toString();
		BigInteger SerialNo=committeedao.MeetingCount(new java.sql.Date(sdf.parse(committeescheduledto.getScheduleDate()).getTime()),committeescheduledto.getProjectId());
		String ProjectName=null;
		if(Long.parseLong(committeescheduledto.getProjectId())>0) 
		{
			ProjectName=committeedao.projectdetails(committeescheduledto.getProjectId())[4].toString();
		}
		else if(Long.parseLong(committeescheduledto.getDivisionId())>0) 
		{
			ProjectName="DIV";
		}
		else if(Long.parseLong(committeescheduledto.getInitiationId())>0) 
		{
			ProjectName="INI";
		}
		else
		{
			ProjectName="GEN";
		}
		Date ScheduledDate= (new java.sql.Date(sdf.parse(committeescheduledto.getScheduleDate()).getTime()));
		committeeschedule.setMeetingId(LabName.trim()+"/"+ProjectName.trim()+"/"+RODName.trim()+"/"+sdf2.format(ScheduledDate).toString().toUpperCase().replace("-", "")+"/"+SerialNo.add(new BigInteger("1")));
		return committeedao.CommitteeScheduleAddSubmit(committeeschedule);
	}

	@Override
	public Object[] RODScheduleEditData(String CommitteeScheduleId) throws Exception {
		
		return dao.RODScheduleEditData(CommitteeScheduleId);
	}
	
}

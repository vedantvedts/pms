package com.vts.pfms.committee.service;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.apache.commons.io.FilenameUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.vts.pfms.committee.dao.ActionDao;
import com.vts.pfms.committee.dao.ActionSelfDao;
import com.vts.pfms.committee.dto.ActionAssignDto;
import com.vts.pfms.committee.dto.ActionMainDto;
import com.vts.pfms.committee.dto.ActionSubDto;
import com.vts.pfms.committee.dto.RfaActionDto;
import com.vts.pfms.committee.model.ActionAssign;
import com.vts.pfms.committee.model.ActionAttachment;
import com.vts.pfms.committee.model.ActionMain;
import com.vts.pfms.committee.model.ActionSelf;
import com.vts.pfms.committee.model.ActionSub;
import com.vts.pfms.committee.model.FavouriteList;
import com.vts.pfms.committee.model.PfmsNotification;
import com.vts.pfms.committee.model.RfaAction;
import com.vts.pfms.committee.model.RfaAssign;
import com.vts.pfms.committee.model.RfaAttachment;
import com.vts.pfms.committee.model.RfaCC;
import com.vts.pfms.committee.model.RfaInspection;
import com.vts.pfms.committee.model.RfaTransaction;

@Service
public class ActionServiceImpl implements ActionService {
	
	private SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private  SimpleDateFormat rdf=new SimpleDateFormat("dd-MM-yyyy");
	private  SimpleDateFormat sdf2=new SimpleDateFormat("dd-MMM-yyyy");
	private  SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	
	@Value("${ApplicationFilesDrive}")
	String uploadpath;
	
	@Autowired
	ActionDao dao;
	
	private static final Logger logger=LogManager.getLogger(ActionServiceImpl.class);

	@Override
	public List<Object[]> EmployeeList(String LabCode) throws Exception {
		return dao.EmployeeList(LabCode);
	}

	@Override
	public List<Object[]> AssignedList(String EmpId) throws Exception {
		return dao.AssignedList(EmpId);
	}
	
	@Override
	public Object[] GetActionReAssignData(String Actionassignid)throws Exception
	{
		return dao.GetActionReAssignData(Actionassignid);
	}
	
	@Override
	public Object[] GetProjectData(String projectid)throws Exception
	{
		return dao.GetProjectData(projectid);
	}

	
	public long ActionMainInsert1(ActionMainDto main) throws Exception 
	{
		logger.info(new Date() +"Inside SERVICE ActionMainInsert1 ");
		long success=1;
		long unsuccess=0;
		Object[] lab=null;
		int count=0;
		String ProjectCode=null;
		try
		{
			lab=dao.LabDetails();
			count=dao.ActionGenCount(main.getProjectId(),main.getType());
			if(!main.getProjectId().equalsIgnoreCase("0"))
			{
				ProjectCode=dao.ProjectCode(main.getProjectId());
			}
		}
		catch (Exception e) 
		{
			logger.info(new Date() +"Inside SERVICE ActionMainInsert1 ",e);	
			return unsuccess;
		}
		String Project=null;
		if(!main.getProjectId().equalsIgnoreCase("0")) {
			if(main.getActionType().equalsIgnoreCase("S")) 
			{
				Object[] comishortname=dao.CommitteeShortName(main.getScheduleId());
				Project="/"+ProjectCode+"/"+comishortname[1]+"/";
			}else if(main.getActionType().equalsIgnoreCase("N")) {
				Project="/"+ProjectCode+"/";
				
			}else {
				Project="/"+ProjectCode+"/MIL/";
			}
		}else 
		{
			Project="/GEN/";
		}
		ActionMain actionmain=new ActionMain();
		
		if(main.getActionLinkId()!=null) {
			actionmain.setActionLinkId(Long.parseLong(main.getActionLinkId()));
		}else {
			actionmain.setActionLinkId(unsuccess);
		}
		actionmain.setActivityId(Long.parseLong(main.getActivityId()));
		actionmain.setActionType(main.getActionType());
		actionmain.setType(main.getType());
		actionmain.setActionItem(main.getActionItem());
		actionmain.setActionDate(new java.sql.Date(rdf.parse(main.getMeetingDate()).getTime()));
		actionmain.setCategory(main.getCategory());
		actionmain.setPriority(main.getPriority());
		actionmain.setProjectId(Long.parseLong(main.getProjectId()));
		actionmain.setScheduleMinutesId(Long.parseLong(main.getScheduleMinutesId()));
		actionmain.setCreatedBy(main.getCreatedBy());
		actionmain.setCreatedDate(sdf1.format(new Date()));
		actionmain.setIsActive(1);
		
		long result=dao.ActionMainInsert(actionmain);
		//for(int i=0;i<main.getAssigneeList().length;i++) {
		ActionAssign actionassign = new ActionAssign();

		count=count+1;
		if(lab!=null) {

		Date meetingdate= new SimpleDateFormat("yyyy-MM-dd").parse(main.getMeetingDate().toString());

		actionassign.setActionNo(lab[1]+Project+sdf2.format(meetingdate).toString().toUpperCase().replace("-", "")+"/"+count);
		
		}else {
			return unsuccess;
		}
		actionassign.setEndDate(new java.sql.Date(rdf.parse(main.getActionDate()).getTime()));
		actionassign.setActionMainId(result);
		actionassign.setPDCOrg(new java.sql.Date(rdf.parse(main.getActionDate()).getTime()));
//		actionassign.setAssigneeLabCode(main.getAssigneeLabCode());
//		actionassign.setAssignee(Long.parseLong(main.getAssigneeList()[i]));
//		actionassign.setAssignorLabCode(main.getAssignorLabCode());
//		actionassign.setAssignor(Long.parseLong(main.getAssignor()));
		actionassign.setRevision(0);
//		actionassign.setActionFlag("N");		
		actionassign.setActionStatus("A");
		actionassign.setCreatedBy(main.getCreatedBy());
		actionassign.setCreatedDate(sdf1.format(new Date()));
		actionassign.setIsActive(1);
		actionassign.setProgress(0);
		
		long assignid=  dao.ActionAssignInsert(actionassign);
		if(result>0) {
			Object[] data=dao.ActionNotification(String.valueOf(result) ,String.valueOf(assignid)).get(0);
			PfmsNotification notification=new PfmsNotification();
			notification.setEmpId(Long.parseLong(data[2].toString()));
			notification.setNotificationby(Long.parseLong(data[5].toString()));
			notification.setNotificationDate(sdf1.format(new Date()));
			notification.setScheduleId(unsuccess);
			notification.setCreatedBy(main.getCreatedBy());
			notification.setCreatedDate(sdf1.format(new Date()));
			notification.setIsActive(1);
			notification.setNotificationUrl("AssigneeList.htm");
		    notification.setNotificationMessage("An Action No "+data[7]+" Assigned by "+data[3]+", "+data[4]+".");
		    notification.setStatus("MAR");
            dao.ActionNotificationInsert(notification);
		}else {
			return unsuccess;
		}
		//}
		return success;
	}
	
//	@Override
//	public long ActionMainInsert(ActionMainDto main , ActionAssignDto assign) throws Exception 
//	{
//		try {
//			logger.info(new Date() +"Inside SERVICE ActionMainInsert ");
//			long success=1;
//			long unsuccess=0;
//			Object[] lab=null;
//			int count=0;
//			String ProjectCode=null;
//			try
//			{
//				lab=dao.LabDetails();
//				count=dao.ActionGenCount(main.getProjectId(),main.getType());
//				if(!main.getProjectId().equalsIgnoreCase("0"))
//				{
//					ProjectCode=dao.ProjectCode(main.getProjectId());
//				}
//			}
//			catch (Exception e) 
//			{	
//				logger.info(new Date() +"Inside SERVICE ActionMainInsert ",e);	
//				return unsuccess;
//			}
//			String Project=null;
//			
//			if(!main.getProjectId().equalsIgnoreCase("0")) {
//				if(main.getActionType().equalsIgnoreCase("S")) 
//				{
//					Object[] comishortname=dao.CommitteeShortName(main.getScheduleMinutesId());
//					Project="/"+ProjectCode+"/"+comishortname[1]+"/";
//				}
//				// Prudhvi - 13/03/2024
//				else if(main.getActionType().equalsIgnoreCase("R")) {
//					Object[] rodshortname=dao.rodShortName(main.getScheduleMinutesId());
//					Project="/"+ProjectCode+"/"+rodshortname[2]+"/";
//					main.setActionType("S");
//				}
//				else if(main.getActionType().equalsIgnoreCase("N")) {
//					Project="/"+ProjectCode+"/";
//					
//				}else {
//					Project="/"+ProjectCode+"/MIL/";
//				}
//			}else{
//				Project="/GEN/";
//			}
//			ActionMain actionmain=new ActionMain();
//			
//			if(main.getActionLinkId()!="" && main.getActionLinkId()!=null) {
//				actionmain.setActionLinkId(Long.parseLong(main.getActionLinkId()));
//			}else {
//				actionmain.setActionLinkId(unsuccess);
//			}
//			if(main.getMainId()!="" && main.getMainId()!=null ) {
//				if("0".equalsIgnoreCase(main.getMainId())) {
//					actionmain.setMainId(Long.parseLong(main.getActionParentId()));
//				}else {
//					actionmain.setMainId(Long.parseLong(main.getMainId()));
//				}
//				
//			}else {
//				actionmain.setMainId(0l);
//			}
//			actionmain.setActivityId(Long.parseLong(main.getActivityId()));
//			actionmain.setActionType(main.getActionType());
//			actionmain.setType(main.getType());
//			actionmain.setActionItem(main.getActionItem());
//			actionmain.setActionDate(java.sql.Date.valueOf(main.getMeetingDate()));
//			actionmain.setCategory(main.getCategory());
//			actionmain.setPriority(main.getPriority());
//			//actionmain.setActionStatus(main.getActionStatus());
//			actionmain.setProjectId(Long.parseLong(main.getProjectId()));
//			actionmain.setScheduleMinutesId(Long.parseLong(main.getScheduleMinutesId()));
//			actionmain.setCreatedBy(main.getCreatedBy());
//			actionmain.setCreatedDate(sdf1.format(new Date()));
//			actionmain.setIsActive(1);
//			if(main.getActionParentId()!="" && main.getActionParentId()!=null) {
//				actionmain.setParentActionId(Long.parseLong(main.getActionParentId()));
//			}else{
//				actionmain.setParentActionId(0l);
//			}
//			actionmain.setActionLevel(main.getActionLevel());
//			long result=dao.ActionMainInsert(actionmain);
//			//changed on 06-11
//			if(assign.getMultipleAssigneeList().size()>0) {
//				for(int i=0;i<assign.getMultipleAssigneeList().size();i++) {
//					ActionAssign actionassign = new ActionAssign();
//						
//					//count=count+1;
//					String actionCount=(count+1)+"-"+(i+1);
//
//					if(lab!=null && main.getLabName()!=null) {
//				    	 Date meetingdate= new SimpleDateFormat("yyyy-MM-dd").parse(main.getMeetingDate().toString());
//
//					     actionassign.setActionNo(main.getLabName()+Project+sdf2.format(meetingdate).toString().toUpperCase().replace("-", "")+"/"+actionCount);
//					}else {
//						return unsuccess;
//					}
//					
//					actionassign.setActionMainId(result);
//					actionassign.setPDCOrg(java.sql.Date.valueOf(sdf.format(rdf.parse(assign.getPDCOrg()))));
//					actionassign.setEndDate(java.sql.Date.valueOf(sdf.format(rdf.parse(assign.getPDCOrg()))));
//					actionassign.setAssigneeLabCode(assign.getAssigneeLabCode());
//					actionassign.setAssignee(Long.parseLong(assign.getMultipleAssigneeList().get(i)));
//					actionassign.setAssignorLabCode(assign.getAssignorLabCode());
//					actionassign.setAssignor(assign.getAssignor());
//					actionassign.setRevision(0);
////					actionassign.setActionFlag("N");		
//					actionassign.setActionStatus("A");
//					actionassign.setCreatedBy(main.getCreatedBy());
//					actionassign.setCreatedDate(sdf1.format(new Date()));
//					actionassign.setIsActive(1);
//					actionassign.setProgress(0);
//					long assignid=  dao.ActionAssignInsert(actionassign);
//					System.out.println("assignid---"+assignid);
//					if(result>0) {
//						Object[] data=dao.ActionNotification(String.valueOf(result) ,String.valueOf(assignid)).get(0);
//						PfmsNotification notification=new PfmsNotification();
//						notification.setEmpId(Long.parseLong(data[2].toString()));
//						notification.setNotificationby(Long.parseLong(data[5].toString()));
//						notification.setNotificationDate(sdf1.format(new Date()));
//						notification.setScheduleId(unsuccess);
//						notification.setCreatedBy(main.getCreatedBy());
//						notification.setCreatedDate(sdf1.format(new Date()));
//						notification.setIsActive(1);
//						if("I".equalsIgnoreCase(actionmain.getType())) {
//							notification.setNotificationUrl("ActionIssue.htm");
//							 notification.setNotificationMessage("An Issue No "+data[7]+" Assigned by "+data[3]+", "+data[4]+".");
//						} else {
//							notification.setNotificationUrl("AssigneeList.htm");
//							notification.setNotificationMessage("An Action No "+data[7]+" Assigned by "+data[3]+", "+data[4]+".");
//						}
//						notification.setStatus("MAR");
//			            dao.ActionNotificationInsert(notification);
//					}else {
//					return unsuccess;
//					}
//					}	
//		
//			}
//			//end
//			/*
//			 * if(assign.getAssigneeList()!=null) { for(int
//			 * i=0;i<assign.getAssigneeList().length;i++) { ActionAssign actionassign = new
//			 * ActionAssign();
//			 * 
//			 * count=count+1;
//			 * 
//			 * if(lab!=null && main.getLabName()!=null) { Date meetingdate= new
//			 * SimpleDateFormat("yyyy-MM-dd").parse(main.getMeetingDate().toString());
//			 * 
//			 * actionassign.setActionNo(main.getLabName()+Project+sdf2.format(meetingdate).
//			 * toString().toUpperCase().replace("-", "")+"/"+count); }else { return
//			 * unsuccess; }
//			 * 
//			 * 
//			 * actionassign.setActionMainId(result);
//			 * actionassign.setPDCOrg(java.sql.Date.valueOf(sdf.format(rdf.parse(assign.
//			 * getPDCOrg()))));
//			 * actionassign.setEndDate(java.sql.Date.valueOf(sdf.format(rdf.parse(assign.
//			 * getPDCOrg()))));
//			 * actionassign.setAssigneeLabCode(assign.getAssigneeLabCode());
//			 * actionassign.setAssignee(Long.parseLong(assign.getAssigneeList()[i]));
//			 * actionassign.setAssignorLabCode(assign.getAssignorLabCode());
//			 * actionassign.setAssignor(assign.getAssignor()); actionassign.setRevision(0);
//			 * // actionassign.setActionFlag("N"); actionassign.setActionStatus("A");
//			 * actionassign.setCreatedBy(main.getCreatedBy());
//			 * actionassign.setCreatedDate(sdf1.format(new Date()));
//			 * actionassign.setIsActive(1); actionassign.setProgress(0); long assignid=
//			 * dao.ActionAssignInsert(actionassign); if(result>0) { Object[]
//			 * data=dao.ActionNotification(String.valueOf(result)
//			 * ,String.valueOf(assignid)).get(0); PfmsNotification notification=new
//			 * PfmsNotification();
//			 * notification.setEmpId(Long.parseLong(data[2].toString()));
//			 * notification.setNotificationby(Long.parseLong(data[5].toString()));
//			 * notification.setNotificationDate(sdf1.format(new Date()));
//			 * notification.setScheduleId(unsuccess);
//			 * notification.setCreatedBy(main.getCreatedBy());
//			 * notification.setCreatedDate(sdf1.format(new Date()));
//			 * notification.setIsActive(1); if("I".equalsIgnoreCase(actionmain.getType())) {
//			 * notification.setNotificationUrl("ActionIssue.htm");
//			 * notification.setNotificationMessage("An Issue No "+data[7]+" Assigned by "
//			 * +data[3]+", "+data[4]+"."); } else {
//			 * notification.setNotificationUrl("AssigneeList.htm");
//			 * notification.setNotificationMessage("An Action No "+data[7]+" Assigned by "
//			 * +data[3]+", "+data[4]+"."); } notification.setStatus("MAR");
//			 * dao.ActionNotificationInsert(notification); }else { return unsuccess; } } }
//			 */
//			return success;
//		} catch (Exception e) {
//			logger.info(new Date() +"Inside SERVICE ActionMainInsert "+ e);	
//			e.printStackTrace();
//			return 0;
//		}
//	}

	
	

	@Override
	public long ActionMainInsert(ActionMainDto main , ActionAssignDto assign) throws Exception 
	{
		try {
			logger.info(new Date() +"Inside SERVICE ActionMainInsert ");
			long success=1;
			long unsuccess=0;
			Object[] lab=null;
			int count=0;
			int subcount=0;
			String ProjectCode=null;
			long mainid=0l;
			try
			{
				lab=dao.LabDetails();
				
				if(!main.getScheduleMinutesId().equalsIgnoreCase("0")) {
					List<Object[]>mainIds = dao.getMainIds(main.getScheduleMinutesId());
					
					if(mainIds.size()>0) {
						mainid=Long.parseLong(mainIds.get(0)[0].toString());
					String[] xyz=	mainIds.get(0)[2].toString().split("/");
						String []abc=xyz[xyz.length-1].split("-");
						
						if(abc.length>1) {
							
							count=Integer.parseInt(abc[0]);
							subcount=Integer.parseInt(abc[1]);
						}else {
							count=dao.ActionGenCount(main.getProjectId(),main.getType())+1;
						}
						
					}else {
						count=dao.ActionGenCount(main.getProjectId(),main.getType())+1;
					}
				}else {
				count=dao.ActionGenCount(main.getProjectId(),main.getType())+1;
				}
				if(!main.getProjectId().equalsIgnoreCase("0"))
				{
					ProjectCode=dao.ProjectCode(main.getProjectId());
				}
			}
			catch (Exception e) 
			{	
				logger.info(new Date() +"Inside SERVICE ActionMainInsert ",e);	
				return unsuccess;
			}
			String Project=null;
			
			if(!main.getProjectId().equalsIgnoreCase("0")) {
				if(main.getActionType().equalsIgnoreCase("S")) 
				{
					Object[] comishortname=dao.CommitteeShortName(main.getScheduleMinutesId());
					Project="/"+ProjectCode+"/"+comishortname[1]+"/";
				}
				// Prudhvi - 13/03/2024
				else if(main.getActionType().equalsIgnoreCase("R")) {
					Object[] rodshortname=dao.rodShortName(main.getScheduleMinutesId());
					Project="/"+ProjectCode+"/"+rodshortname[2]+"/";
					main.setActionType("S");
				}
				else if(main.getActionType().equalsIgnoreCase("N")) {
					Project="/"+ProjectCode+"/";
					
				}else {
					Project="/"+ProjectCode+"/MIL/";
				}
			}else{
				Project="/GEN/";
			}
			ActionMain actionmain=new ActionMain();
			
			if(main.getActionLinkId()!="" && main.getActionLinkId()!=null) {
				actionmain.setActionLinkId(Long.parseLong(main.getActionLinkId()));
			}else {
				actionmain.setActionLinkId(unsuccess);
			}
			if(main.getMainId()!="" && main.getMainId()!=null ) {
				if("0".equalsIgnoreCase(main.getMainId())) {
					actionmain.setMainId(Long.parseLong(main.getActionParentId()));
				}else {
					actionmain.setMainId(Long.parseLong(main.getMainId()));
				}
				
			}else {
				actionmain.setMainId(0l);
			}
			actionmain.setActivityId(Long.parseLong(main.getActivityId()));
			actionmain.setActionType(main.getActionType());
			actionmain.setType(main.getType());
			actionmain.setActionItem(main.getActionItem());
			actionmain.setActionDate(java.sql.Date.valueOf(main.getMeetingDate()));
			actionmain.setCategory(main.getCategory());
			actionmain.setPriority(main.getPriority());
			//actionmain.setActionStatus(main.getActionStatus());
			actionmain.setProjectId(Long.parseLong(main.getProjectId()));
			actionmain.setScheduleMinutesId(Long.parseLong(main.getScheduleMinutesId()));
			actionmain.setCreatedBy(main.getCreatedBy());
			actionmain.setCreatedDate(sdf1.format(new Date()));
			actionmain.setIsActive(1);
			if(main.getActionParentId()!="" && main.getActionParentId()!=null) {
				actionmain.setParentActionId(Long.parseLong(main.getActionParentId()));
			}else{
				actionmain.setParentActionId(0l);
			}
			actionmain.setActionLevel(main.getActionLevel());
			
			
			long result=0l;
			if(mainid>0) {
				result=mainid;
			}else {
			result=	dao.ActionMainInsert(actionmain);
			}
			
			
			//changed on 06-11
			if(assign.getMultipleAssigneeList().size()>0) {
				for(int i=0;i<assign.getMultipleAssigneeList().size();i++) {
					ActionAssign actionassign = new ActionAssign();
						
					//count=count+1;
					String actionCount=(count)+"-"+(subcount+i+1);

					if(lab!=null && main.getLabName()!=null) {
				    	 Date meetingdate= new SimpleDateFormat("yyyy-MM-dd").parse(main.getMeetingDate().toString());

					     actionassign.setActionNo(main.getLabName()+Project+sdf2.format(meetingdate).toString().toUpperCase().replace("-", "")+"/"+actionCount);
					}else {
						return unsuccess;
					}
					
					actionassign.setActionMainId(result);
					actionassign.setPDCOrg(java.sql.Date.valueOf(sdf.format(rdf.parse(assign.getPDCOrg()))));
					actionassign.setEndDate(java.sql.Date.valueOf(sdf.format(rdf.parse(assign.getPDCOrg()))));
					actionassign.setAssigneeLabCode(assign.getAssigneeLabCode());
					actionassign.setAssignee(Long.parseLong(assign.getMultipleAssigneeList().get(i)));
					actionassign.setAssignorLabCode(assign.getAssignorLabCode());
					actionassign.setAssignor(assign.getAssignor());
					actionassign.setRevision(0);
//					actionassign.setActionFlag("N");		
					actionassign.setActionStatus("A");
					actionassign.setCreatedBy(main.getCreatedBy());
					actionassign.setCreatedDate(sdf1.format(new Date()));
					actionassign.setIsActive(1);
					actionassign.setProgress(0);
					long assignid=  dao.ActionAssignInsert(actionassign);
					System.out.println("assignid---"+assignid);
					if(result>0) {
						Object[] data=dao.ActionNotification(String.valueOf(result) ,String.valueOf(assignid)).get(0);
						PfmsNotification notification=new PfmsNotification();
						notification.setEmpId(Long.parseLong(data[2].toString()));
						notification.setNotificationby(Long.parseLong(data[5].toString()));
						notification.setNotificationDate(sdf1.format(new Date()));
						notification.setScheduleId(unsuccess);
						notification.setCreatedBy(main.getCreatedBy());
						notification.setCreatedDate(sdf1.format(new Date()));
						notification.setIsActive(1);
						if("I".equalsIgnoreCase(actionmain.getType())) {
							notification.setNotificationUrl("ActionIssue.htm");
							 notification.setNotificationMessage("An Issue No "+data[7]+" Assigned by "+data[3]+", "+data[4]+".");
						} else {
							notification.setNotificationUrl("AssigneeList.htm");
							notification.setNotificationMessage("An Action No "+data[7]+" Assigned by "+data[3]+", "+data[4]+".");
						}
						notification.setStatus("MAR");
			            dao.ActionNotificationInsert(notification);
					}else {
					return unsuccess;
					}
					}	
		
			}
			//end
			/*
			 * if(assign.getAssigneeList()!=null) { for(int
			 * i=0;i<assign.getAssigneeList().length;i++) { ActionAssign actionassign = new
			 * ActionAssign();
			 * 
			 * count=count+1;
			 * 
			 * if(lab!=null && main.getLabName()!=null) { Date meetingdate= new
			 * SimpleDateFormat("yyyy-MM-dd").parse(main.getMeetingDate().toString());
			 * 
			 * actionassign.setActionNo(main.getLabName()+Project+sdf2.format(meetingdate).
			 * toString().toUpperCase().replace("-", "")+"/"+count); }else { return
			 * unsuccess; }
			 * 
			 * 
			 * actionassign.setActionMainId(result);
			 * actionassign.setPDCOrg(java.sql.Date.valueOf(sdf.format(rdf.parse(assign.
			 * getPDCOrg()))));
			 * actionassign.setEndDate(java.sql.Date.valueOf(sdf.format(rdf.parse(assign.
			 * getPDCOrg()))));
			 * actionassign.setAssigneeLabCode(assign.getAssigneeLabCode());
			 * actionassign.setAssignee(Long.parseLong(assign.getAssigneeList()[i]));
			 * actionassign.setAssignorLabCode(assign.getAssignorLabCode());
			 * actionassign.setAssignor(assign.getAssignor()); actionassign.setRevision(0);
			 * // actionassign.setActionFlag("N"); actionassign.setActionStatus("A");
			 * actionassign.setCreatedBy(main.getCreatedBy());
			 * actionassign.setCreatedDate(sdf1.format(new Date()));
			 * actionassign.setIsActive(1); actionassign.setProgress(0); long assignid=
			 * dao.ActionAssignInsert(actionassign); if(result>0) { Object[]
			 * data=dao.ActionNotification(String.valueOf(result)
			 * ,String.valueOf(assignid)).get(0); PfmsNotification notification=new
			 * PfmsNotification();
			 * notification.setEmpId(Long.parseLong(data[2].toString()));
			 * notification.setNotificationby(Long.parseLong(data[5].toString()));
			 * notification.setNotificationDate(sdf1.format(new Date()));
			 * notification.setScheduleId(unsuccess);
			 * notification.setCreatedBy(main.getCreatedBy());
			 * notification.setCreatedDate(sdf1.format(new Date()));
			 * notification.setIsActive(1); if("I".equalsIgnoreCase(actionmain.getType())) {
			 * notification.setNotificationUrl("ActionIssue.htm");
			 * notification.setNotificationMessage("An Issue No "+data[7]+" Assigned by "
			 * +data[3]+", "+data[4]+"."); } else {
			 * notification.setNotificationUrl("AssigneeList.htm");
			 * notification.setNotificationMessage("An Action No "+data[7]+" Assigned by "
			 * +data[3]+", "+data[4]+"."); } notification.setStatus("MAR");
			 * dao.ActionNotificationInsert(notification); }else { return unsuccess; } } }
			 */
			return success;
		} catch (Exception e) {
			logger.info(new Date() +"Inside SERVICE ActionMainInsert "+ e);	
			e.printStackTrace();
			return 0;
		}
	}
	@Override
	public List<Object[]> AssigneeList(String EmpId) throws Exception {
		dao.AssigneeSeenUpdate(EmpId);
		return dao.AssigneeList(EmpId);
	}

	@Override
	public List<Object[]> AssigneeData(String MainId ,String Assignid) throws Exception {
		logger.info(new Date() +"Inside SERVICE AssigneeData ");
		
		List<Object[]> list = dao.AssigneeData(MainId , Assignid);
		
		return list;
	}

	@Override
	public List<Object[]> SubList(String assignid) throws Exception {
		return dao.SubList(assignid);
	}

	@Override
	public ActionAssign getActionAssign(String actionassignId) throws Exception 
	{
		return dao.getActionAssign(actionassignId);
	}
	@Override
	public long ActionSubInsert(ActionSubDto main) throws Exception {
		logger.info(new Date() +"Inside SERVICE ActionSubInsert ");
		
		Timestamp instant= Timestamp.from(Instant.now());
		String LabCode = main.getLabCode();
		String timestampstr = instant.toString().replace(" ","").replace(":", "").replace("-", "").replace(".","");
		
		String Path = LabCode+"\\ActionData\\";
		ActionSub sub=new ActionSub();
		sub.setActionAssignId(Long.parseLong(main.getActionAssignId()));
		sub.setRemarks(main.getRemarks());
		sub.setProgress(Integer.parseInt(main.getProgress()));
		sub.setProgressDate(new java.sql.Date(rdf.parse(main.getProgressDate()).getTime()));
		sub.setCreatedBy(main.getCreatedBy());
		sub.setCreatedDate(sdf1.format(new Date()));
		sub.setIsActive(1);
		long subresult=dao.ActionSubInsert(sub);
		if(subresult>0) {
			ActionAssign updateassign=getActionAssign(main.getActionAssignId());
//			updateassign.setActionFlag("N");
			updateassign.setActionStatus("I");
			updateassign.setModifiedBy(main.getCreatedBy());
			updateassign.setModifiedDate(sdf1.format(new Date()));
			updateassign.setProgress(Integer.parseInt(main.getProgress()));
			updateassign.setProgressDate(sdf.format(rdf.parse(main.getProgressDate())));
			updateassign.setProgressRemark(main.getRemarks());
			dao.AssignUpdate(updateassign);
			
			if(main.getMultipartfile()!=null) {
			if(!main.getMultipartfile().isEmpty()) 
			{
				ActionAttachment attach=new ActionAttachment();
				attach.setAttachFilePath(Path);
				attach.setActionSubId(subresult);
				attach.setAttachName(main.getFileNamePath());
				attach.setCreatedBy(main.getCreatedBy());
				attach.setCreatedDate(sdf1.format(new Date()));
				attach.setAttachName("Action"+timestampstr+"."+FilenameUtils.getExtension(main.getMultipartfile().getOriginalFilename()));
				saveFile(uploadpath+Path, attach.getAttachName(), main.getMultipartfile());
				dao.ActionAttachInsert(attach);
			}
			}
			
		}else {
			subresult=0;
		}
		return subresult;
	}
	
    public static void saveFile(String uploadpath, String fileName, MultipartFile multipartFile) throws IOException 
    {
    	logger.info(new Date() +"Inside SERVICE saveFile ");
        Path uploadPath = Paths.get(uploadpath);
          
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }
        
        try (InputStream inputStream = multipartFile.getInputStream()) {
            Path filePath = uploadPath.resolve(fileName);
            Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException ioe) {       
            throw new IOException("Could not save image file: " + fileName, ioe);
        }     
    }

	@Override
	public ActionAttachment ActionAttachmentDownload(String achmentid) throws Exception {
		return dao.ActionAttachmentDownload(achmentid);
	}

	@Override
	public int ActionSubDelete(String id, String UserId) throws Exception {
		
		return dao.ActionSubDelete(id);
	}

	@Override
	public int ActionForward(String mainid ,String assignid, String UserId) throws Exception {
		logger.info(new Date() +"Inside SERVICE ActionForward ");
		long unsuccess=0;
		ActionAssign main=new ActionAssign();
		main.setActionAssignId(Long.parseLong(assignid));
//		main.setActionFlag("F");
		main.setActionStatus("F");
		main.setModifiedBy(UserId);
		main.setModifiedDate(sdf1.format(new Date()));
		int result=dao.MainForward(main);
		if(result>0) {
			Object[] data=dao.ActionNotification(mainid,assignid).get(0);
			PfmsNotification notification=new PfmsNotification();
			notification.setEmpId(Long.parseLong(data[5].toString()));
			notification.setNotificationby(Long.parseLong(data[2].toString()));
			notification.setNotificationDate(sdf1.format(new Date()));
			notification.setScheduleId(unsuccess);
			notification.setCreatedBy(main.getCreatedBy());
			notification.setCreatedDate(sdf1.format(new Date()));
			notification.setIsActive(1);
			if(data!=null && data[8]!=null && "I".equalsIgnoreCase(data[8].toString())) {
				notification.setNotificationUrl("ActionIssue.htm");
				notification.setNotificationMessage("An Issue No "+data[7]+" Forwarded by "+data[0]+", "+data[1]+"."); 
			}else {
				notification.setNotificationUrl("ActionForwardList.htm");
				notification.setNotificationMessage("An Action No "+data[7]+" Forwarded by "+data[0]+", "+data[1]+".");  
			}
		    notification.setStatus("MAR");
            dao.ActionNotificationInsert(notification);
		}else {
			result=0;
		}
		return result;
	}

	@Override
	public List<Object[]> ForwardList(String EmpId) throws Exception {
		return dao.ForwardList(EmpId);
	}

	@Override
	public long ActionClosed(String id, String Remarks, String UserId ,String assignid , String levelcount) throws Exception {
		logger.info(new Date() +"Inside Service ActionClosed ");
		long unsuccess=0;
		long result=0;
		
		if(levelcount!=null && Long.parseLong(levelcount)>1) {
			List<Object[]> actionslist = dao.ActionSubLevelsList(assignid);
			int startLevel = 0;
			
			if(actionslist.size()>0){
				startLevel = Integer.parseInt(actionslist.get(0)[3].toString());
			} 
			for(Object[] action:actionslist) {
				if(Integer.parseInt(action[3].toString()) == startLevel){
					
					ActionAssign assign=getActionAssign(action[10].toString());
//					assign.setActionFlag("Y");
					assign.setActionStatus("C");
					assign.setRemarks(Remarks);
					assign.setModifiedBy(UserId);
					assign.setModifiedDate(sdf1.format(new Date()));
					if(assign.getProgressDate()==null) {
						assign.setProgressDate(sdf.format(new Date())); 
					}
					assign.setClosedDate(sdf.format(new Date()));
					long result1=0;
							if(action[20]!=null && !"C".equalsIgnoreCase(action[20].toString())) {
								result1=dao.MainSendBack(assign);
							}
					if(result1>0) {
						result++;
						Object[] data=dao.ActionNotification(id,action[10].toString()).get(0);
						PfmsNotification notification=new PfmsNotification();
						notification.setEmpId(Long.parseLong(data[2].toString()));
						notification.setNotificationby(Long.parseLong(data[5].toString()));
						notification.setNotificationDate(sdf1.format(new Date()));
						notification.setScheduleId(unsuccess);
						notification.setCreatedBy(assign.getCreatedBy());
						notification.setCreatedDate(sdf1.format(new Date()));
						notification.setIsActive(1);
						notification.setNotificationUrl("ActionStatusList.htm");
					    notification.setNotificationMessage("An Action No "+data[7]+" Closed by "+data[3]+", "+data[4]+".");
					    notification.setStatus("MAR");
			            dao.ActionNotificationInsert(notification);
					}
					for(Object[] action_L1 : actionslist){
					 if(Integer.parseInt(action_L1[3].toString()) == startLevel+1 && Long.parseLong(action[0].toString()) == Long.parseLong(action_L1[1].toString())  
					&&  action[18].toString().trim().equalsIgnoreCase(action_L1[16].toString().trim()) 
					&& Long.parseLong(action[19].toString()) == Long.parseLong(action_L1[17].toString()) ){ 
						 
						 ActionAssign assign1=getActionAssign(action_L1[10].toString());
//							assign1.setActionAssignId(Long.parseLong(action_L1[10].toString()));
//							assign1.setActionFlag("Y");
							assign1.setActionStatus("C");
							assign1.setRemarks(Remarks);
							assign1.setModifiedBy(UserId);
							assign1.setModifiedDate(sdf1.format(new Date()));
							if(assign1.getProgressDate()==null) {
								assign1.setProgressDate(sdf.format(new Date())); 
							}
							assign1.setClosedDate(sdf.format(new Date()));
							long result2=0;
							if(action[20]!=null && !"C".equalsIgnoreCase(action_L1[20].toString())) {
								result2=dao.MainSendBack(assign1);
							}
							
							if(result2>0) {
								result++;
								Object[] data=dao.ActionNotification(id,action_L1[10].toString()).get(0);
								PfmsNotification notification=new PfmsNotification();
								notification.setEmpId(Long.parseLong(data[2].toString()));
								notification.setNotificationby(Long.parseLong(data[5].toString()));
								notification.setNotificationDate(sdf1.format(new Date()));
								notification.setScheduleId(unsuccess);
								notification.setCreatedBy(assign1.getCreatedBy());
								notification.setCreatedDate(sdf1.format(new Date()));
								notification.setIsActive(1);
								notification.setNotificationUrl("ActionStatusList.htm");
							    notification.setNotificationMessage("An Action No "+data[7]+" Closed by "+data[3]+", "+data[4]+".");
							    notification.setStatus("MAR");
					            dao.ActionNotificationInsert(notification);
							}
						 for(Object[] action_L2 : actionslist){ 
							 if(Integer.parseInt(action_L2[3].toString()) == startLevel+2 && Long.parseLong(action_L1[0].toString())== Long.parseLong(action_L2[1].toString())  
							&& action_L1[18].toString().trim().equalsIgnoreCase(action_L2[16].toString().trim()) 
							&& Long.parseLong(action_L1[19].toString()) == Long.parseLong(action_L2[17].toString()) ){ 
								 
								 ActionAssign assign2=getActionAssign(action_L2[10].toString());;
//									assign2.setActionAssignId(Long.parseLong(action_L2[10]+""));
//									assign2.setActionFlag("Y");
									assign2.setActionStatus("C");
									assign2.setRemarks(Remarks);
									assign2.setModifiedBy(UserId);
									assign2.setModifiedDate(sdf1.format(new Date()));
									if(assign2.getProgressDate()==null) {
										assign2.setProgressDate(sdf.format(new Date())); 
									}
									assign2.setClosedDate(sdf.format(new Date()));
									long result3=0;
									if(action[20]!=null && !"C".equalsIgnoreCase(action_L2[20].toString())) {
										result3=dao.MainSendBack(assign2);
									}
									if(result3>0) {
										result++;
										Object[] data=dao.ActionNotification(id,action_L2[10].toString()).get(0);
										PfmsNotification notification=new PfmsNotification();
										notification.setEmpId(Long.parseLong(data[2].toString()));
										notification.setNotificationby(Long.parseLong(data[5].toString()));
										notification.setNotificationDate(sdf1.format(new Date()));
										notification.setScheduleId(unsuccess);
										notification.setCreatedBy(assign2.getCreatedBy());
										notification.setCreatedDate(sdf1.format(new Date()));
										notification.setIsActive(1);
										notification.setNotificationUrl("ActionStatusList.htm");
									    notification.setNotificationMessage("An Action No "+data[7]+" Closed by "+data[3]+", "+data[4]+".");
									    notification.setStatus("MAR");
							            dao.ActionNotificationInsert(notification);
									}
								 for(Object[] action_L3 : actionslist){ 
									 if(Integer.parseInt(action_L3[3].toString()) == startLevel+3 && Long.parseLong(action_L2[0].toString())== Long.parseLong(action_L3[1].toString()) 
									&&  action_L2[18].toString().trim().equalsIgnoreCase(action_L3[16].toString().trim()) 
									&& Long.parseLong(action_L2[19].toString()) == Long.parseLong(action_L3[17].toString()) ){ 
										
										 ActionAssign assign3=getActionAssign(action_L3[10].toString());;
//											assign3.setActionAssignId(Long.parseLong(action_L3[10]+""));
//											assign3.setActionFlag("Y");
											assign3.setActionStatus("C");
											assign3.setRemarks(Remarks);
											assign3.setModifiedBy(UserId);
											assign3.setModifiedDate(sdf1.format(new Date()));
											assign3.setClosedDate(sdf.format(new Date()));
											if(assign3.getProgressDate()==null) {
												assign3.setProgressDate(sdf.format(new Date())); 
											}
											long result4=0;
											if(action[20]!=null && !"C".equalsIgnoreCase(action_L3[20].toString())) {
												result4=dao.MainSendBack(assign3);
											}
											 if(result4>0) {
												result++;
												Object[] data=dao.ActionNotification(id,action_L3[10].toString()).get(0);
												PfmsNotification notification=new PfmsNotification();
												notification.setEmpId(Long.parseLong(data[2].toString()));
												notification.setNotificationby(Long.parseLong(data[5].toString()));
												notification.setNotificationDate(sdf1.format(new Date()));
												notification.setScheduleId(unsuccess);
												notification.setCreatedBy(assign3.getCreatedBy());
												notification.setCreatedDate(sdf1.format(new Date()));
												notification.setIsActive(1);
												notification.setNotificationUrl("ActionStatusList.htm");
											    notification.setNotificationMessage("An Action No "+data[7]+" Closed by "+data[3]+", "+data[4]+".");
											    notification.setStatus("MAR");
									            dao.ActionNotificationInsert(notification);
											}
										 
										 for(Object[] action_L4 : actionslist){ 
											 
											 if(Integer.parseInt(action_L4[3].toString()) == startLevel+4 && Long.parseLong(action_L3[0].toString())== Long.parseLong(action_L4[1].toString())  
											&& action_L3[18].toString().trim().equalsIgnoreCase(action_L4[16].toString().trim()) 
											&& Long.parseLong(action_L3[19].toString()) == Long.parseLong(action_L4[17].toString()) ){ 
											
													 ActionAssign assign4=getActionAssign(action_L4[10].toString());;
														assign4.setActionAssignId(Long.parseLong(action_L4[10]+""));
//														assign4.setActionFlag("Y");
														assign4.setActionStatus("C");
														assign4.setRemarks(Remarks);
														assign4.setModifiedBy(UserId);
														assign4.setModifiedDate(sdf1.format(new Date()));
														assign4.setClosedDate(sdf.format(new Date()));
														if(assign4.getProgressDate()==null) {
															assign4.setProgressDate(sdf.format(new Date())); 
														}
														long result5=0;
															if(action[20]!=null && !"C".equalsIgnoreCase(action_L4[20].toString())) {
																result5=dao.MainSendBack(assign4);
															}
													if(result5>0) {
															result++;
															Object[] data=dao.ActionNotification(id,action_L4[10].toString()).get(0);
															PfmsNotification notification=new PfmsNotification();
															notification.setEmpId(Long.parseLong(data[2].toString()));
															notification.setNotificationby(Long.parseLong(data[5].toString()));
															notification.setNotificationDate(sdf1.format(new Date()));
															notification.setScheduleId(unsuccess);
															notification.setCreatedBy(assign4.getCreatedBy());
															notification.setCreatedDate(sdf1.format(new Date()));
															notification.setIsActive(1);
															notification.setNotificationUrl("ActionStatusList.htm");
														    notification.setNotificationMessage("An Action No "+data[7]+" Closed by "+data[3]+", "+data[4]+".");
														    notification.setStatus("MAR");
												           dao.ActionNotificationInsert(notification);
														}
	 
											 }
										 }
							   /*--------------------------- Level 4------------------ */
									 }
								 }
						    /*------------------------ Level 3-------------------*/
							 	}
							}
						 /*--------------------------Level 2------------------*/
					   }
					}
					/* ------------------------------Level 1---------- */
				}
			}
		}else {
			
			ActionAssign assign=getActionAssign(assignid);;
			assign.setActionAssignId(Long.parseLong(assignid));
//			assign.setActionFlag("Y");
			assign.setActionStatus("C");
			assign.setRemarks(Remarks);
			assign.setModifiedBy(UserId);
			assign.setModifiedDate(sdf1.format(new Date()));
			assign.setClosedDate(sdf.format(new Date()));
			if(assign.getProgressDate()==null) {
				assign.setProgressDate(sdf.format(new Date())); 
			}
			result=dao.MainSendBack(assign);
			if(result>0) {
				Object[] data=dao.ActionNotification(id,assignid).get(0);
				PfmsNotification notification=new PfmsNotification();
				notification.setEmpId(Long.parseLong(data[2].toString()));
				notification.setNotificationby(Long.parseLong(data[5].toString()));
				notification.setNotificationDate(sdf1.format(new Date()));
				notification.setScheduleId(unsuccess);
				notification.setCreatedBy(assign.getCreatedBy());
				notification.setCreatedDate(sdf1.format(new Date()));
				notification.setIsActive(1);
				if(data!=null && data[8]!=null && "I".equalsIgnoreCase(data[8].toString())) {
					notification.setNotificationUrl("ActionIssue.htm");
				    notification.setNotificationMessage("An Issue No "+data[7]+" Closed by "+data[3]+", "+data[4]+".");
				}else{
					notification.setNotificationUrl("ActionStatusList.htm");
				    notification.setNotificationMessage("An Action No "+data[7]+" Closed by "+data[3]+", "+data[4]+".");
				}
				notification.setStatus("MAR");
	            dao.ActionNotificationInsert(notification);
			}else {
				result=0;
			}
		}
				
		return result;
	}

	@Override
	public long ActionSendBack(String id, String Remarks, String UserId , String assignid) throws Exception {
		logger.info(new Date() +"Inside SERVICE ActionSendBack ");
		long unsuccess=0;
		ActionAssign assign=getActionAssign(assignid);
//		assign.setActionAssignId(Long.parseLong(assignid));
//		assign.setActionFlag("B");
		assign.setActionStatus("B");
		assign.setRemarks(Remarks);
		assign.setModifiedBy(UserId);
		assign.setModifiedDate(sdf1.format(new Date()));
		long result=dao.MainSendBack(assign);
		if(result>0) {
			Object[] data=dao.ActionNotification(id,assignid).get(0);
			PfmsNotification notification=new PfmsNotification();
			notification.setEmpId(Long.parseLong(data[2].toString()));
			notification.setNotificationby(Long.parseLong(data[5].toString()));
			notification.setNotificationDate(sdf1.format(new Date()));
			notification.setScheduleId(unsuccess);
			notification.setCreatedBy(assign.getCreatedBy());
			notification.setCreatedDate(sdf1.format(new Date()));
			notification.setIsActive(1);
			if(data!=null && data[8]!=null &&"I".equalsIgnoreCase(data[8].toString()) ) {
				notification.setNotificationUrl("ActionIssue.htm");
				 notification.setNotificationMessage("An Issue No "+data[7]+" Send Back by "+data[3]+", "+data[4]+".");
				   
			}else {
				notification.setNotificationUrl("AssigneeList.htm");
				 notification.setNotificationMessage("An Action No "+data[7]+" Send Back by "+data[3]+", "+data[4]+".");
				   
			}
			
		    notification.setStatus("MAR");
            dao.ActionNotificationInsert(notification);
		}else {
			result=0;
		}
		return result;
	}

	@Override
	public List<Object[]> StatusList(String EmpId,String fdate, String tdate) throws Exception {
		return dao.StatusList(EmpId, fdate, tdate);
	}

	@Override
	public List<Object[]> ActionList(String EmpId) throws Exception {
		return dao.ActionList(EmpId);
	}

	@Override
	public List<Object[]> CommitteeActionList(String EmpId) throws Exception {
		return dao.CommitteeActionList(EmpId);
	}

	@Override
	public Object[] CommitteeScheduleEditData(String CommitteeScheduleId) throws Exception {
		return dao.CommitteeScheduleEditData(CommitteeScheduleId);
	}

	@Override
	public List<Object[]> ScheduleActionList(String ScheduleId) throws Exception {
		return dao.ScheduleActionList(ScheduleId);
	}

	@Override
	public List<Object[]> MeetingContent(String ScheduleId) throws Exception {
		return dao.MeetingContent(ScheduleId);
	}

	@Override
	public List<Object[]> ActionNoSearch(String ActionMainId) throws Exception {
		return dao.ActionNoSearch("%"+ActionMainId+"%");
	}

	@Override
	public List<Object[]> AssigneeDetails(String assignid) throws Exception {
		return dao.AssigneeDetails(assignid);
	}

	@Override
	public String ScheduleActionItem(String ScheduleId) throws Exception {
		logger.info(new Date() +"Inside SERVICE ScheduleActionItem ");
		Object[] data=dao.ScheduleActionItem(ScheduleId).get(0);
		 String Item= data[1].toString().replaceAll("\\<.*?\\>", "");
		return Item;
	}

	@Override
	public List<Object[]> ActionReports(String EmpId, String Term, String Position,String Type,String LabCode) throws Exception {
		
		return dao.ActionReports(EmpId, Term, Position,Type,LabCode);
	}

	@Override
	public List<Object[]> ActionSearch(String EmpId, String No, String Position) throws Exception {
		return dao.ActionSearch(EmpId, "%"+No+"%", Position) ;
	}

	@Override
	public List<Object[]> ProjectList() throws Exception {
		return dao.ProjectList();
	}

	@Override
	public List<Object[]> ActionCountList(String ProjectId) throws Exception {
		return dao.ActionCountList(ProjectId);
	}

	@Override
	public List<Object[]> projectdetailsList(String EmpId) throws Exception {
		return dao.projectdetailsList(EmpId);
	}
	
	@Override
	public List<Object[]> allprojectdetailsList() throws Exception {
		return dao.allprojectdetailsList();
	}

	@Override
	public List<Object[]> ActionWiseReports(String Term, String ProjectId) throws Exception {
		return dao.ActionWiseReports(Term, ProjectId);
	}

	@Override
	public List<Object[]> ActionPdcReports(String Emp, String ProjectId,String Position, String From, String To) throws Exception {
		return dao.ActionPdcReports(Emp, ProjectId,Position, new java.sql.Date(rdf.parse(From).getTime()), new java.sql.Date(rdf.parse(To).getTime()));
	}

	@Override
	public int ActionExtendPdc(String id,String date, String UserId , String assignid) throws Exception {
		logger.info(new Date() +"Inside SERVICE ActionExtendPdc ");
		long unsuccess=0;
		int result=0;
		Object[] data=dao.ActionNotification(id , assignid).get(0);

		
		ActionAssign assign=new ActionAssign();
		assign.setRevision(1+Integer.parseInt(data[6].toString()));
		if(assignid!=null) {
		assign.setActionAssignId(Long.parseLong(assignid));
		}
		assign.setEndDate(new java.sql.Date(rdf.parse(date).getTime()));
		assign.setActionMainId(Long.parseLong(id));
		assign.setModifiedBy(UserId);
		assign.setModifiedDate(sdf1.format(new Date()));
		result=dao.ActionAssignRevisionEdit(assign);
		if(result>0) {
			
			PfmsNotification notification=new PfmsNotification();
			notification.setEmpId(Long.parseLong(data[2].toString()));
			notification.setNotificationby(Long.parseLong(data[5].toString()));
			notification.setNotificationDate(sdf1.format(new Date()));
			notification.setScheduleId(unsuccess);
			notification.setCreatedBy(assign.getCreatedBy());
			notification.setCreatedDate(sdf1.format(new Date()));
			notification.setIsActive(1);
			notification.setNotificationUrl("ActionStatusList.htm");
		    notification.setNotificationMessage("An Action No "+data[7]+" PDC Extended by "+data[3]+", "+data[4]+".");
		    notification.setStatus("MAR");
            dao.ActionNotificationInsert(notification);
		}else {
			result=0;
		}
		return result;
	}

	@Override
	public List<Object[]> ActionSelfList(String EmpId) throws Exception {
		return dao.ActionSelfList(EmpId);
	}

	@Override
	public List<Object[]> SearchDetails(String MainId , String assignid) throws Exception {
		return dao.SearchDetails(MainId , assignid);
	}
	
	
	@Override
	public List<Object[]> ActionWiseAllReport(String Term,String empid,String ProjectId) throws Exception {
		return dao.ActionWiseAllReport(Term,empid,ProjectId);
	}
	
	@Override
	public long ActionSelfReminderAddSubmit(ActionSelfDao actionselfdao) throws Exception {
		logger.info(new Date() +"Inside SERVICE ActionSelfReminderAddSubmit ");
		ActionSelf actionself=new ActionSelf();
		actionself.setEmpId(Long.parseLong(actionselfdao.getEmpId()));
		actionself.setActionDate(new java.sql.Date(rdf.parse(actionselfdao.getActionDate()).getTime()));
		actionself.setActionTime(actionselfdao.getActionTime());
		actionself.setActionItem(actionselfdao.getActionItem());
		actionself.setActionType(actionselfdao.getActionType());
		actionself.setCreatedBy(actionselfdao.getCreatedBy());
		actionself.setCreatedDate(sdf1.format(new Date()));
		actionself.setIsActive(1);		
		actionself.setLabCode(actionselfdao.getLabCode());
		return dao.ActionSelfReminderAddSubmit(actionself);
	}
	
	@Override
	public List<Object[]> ActionSelfReminderList(String empid,String fromdate,String todate) throws Exception 
	{
		return dao.ActionSelfReminderList(empid,fromdate,todate);
	}
	
	@Override
	public int ActionSelfReminderDelete(String actionid) throws Exception {
		return dao.ActionSelfReminderDelete(actionid);
	}

	@Override
	public List<Object[]> getActionAlertList() throws Exception {
	
		return dao.getActionAlertList();
	}

	@Override
	public List<Object[]> getActionToday(String empid,String ai) throws Exception {
	
		return dao.getActionToday(empid,ai);
	}

	@Override
	public List<Object[]> getActionTommo(String empid,String ai) throws Exception {
		
		return dao.getActionTommo(empid,ai);
	}

	@Override
	public List<Object[]> getMeetingAlertList() throws Exception {
		
		return dao.getMeetingAlertList();
	}

	@Override
	public List<Object[]> getMeetingToday(String empid) throws Exception {

		return dao.getMeetingToday(empid);
	}

	@Override
	public List<Object[]> getMeetingTommo(String empid) throws Exception {
	
		return dao.getMeetingTommo(empid);
	}
	
	@Override
	public List<Object[]> LoginProjectDetailsList(String empid,String Logintype,String LabCode)throws Exception
	{
		return dao.LoginProjectDetailsList(empid,Logintype,LabCode);
	}

	@Override
	public List<Object[]> AllEmpNameDesigList()throws Exception
	{
		return dao.AllEmpNameDesigList();
	}
	
	@Override
	public List<Object[]> ProjectEmpList(String projectid)throws Exception
	{
		return dao.ProjectEmpList(projectid);
	}
	
	
	@Override
	public List<Object[]> EmployeeDropdown(String empid,String logintype,String projectid)throws Exception
	{
		return dao.EmployeeDropdown(empid, logintype,projectid);
	}
	
	
	@Override
	public Object[] ActionDetailsAjax(String actionid , String assignid) throws Exception
	{
		return dao.ActionDetailsAjax(actionid , assignid);
	}
	
	@Override
	public int ActionMainEdit(ActionMain main) throws Exception
	{
		return dao.ActionMainEdit(main);
	}
	@Override
	 public int ActionAssignEdit(ActionAssign assign) throws Exception
	 {
		
		assign.setModifiedDate(sdf1.format(new Date()));
		return dao.ActionAssignEdit(assign);
	 }
	
	@Override
	public List<Object[]> AllLabList() throws Exception 
	{
		return dao.AllLabList();
	}
	@Override
	public Object[] GetActionMainData(String actionmainid)throws Exception
	{
		return dao.GetActionMainData(actionmainid);
	}
	@Override
	public List<Object[]> ClusterExpertsList() throws Exception
	{
		return dao.ClusterExpertsList();
	}
	
	@Override
	public List<Object[]> ClusterFilterExpertsList(String Labcode , String MainId)throws Exception
	{
		return dao.ClusterFilterExpertsList(Labcode,MainId);
	}
	@Override
	public Object[] LabInfoClusterLab(String LabCode) throws Exception 
	{
		return dao.LabInfoClusterLab(LabCode);
	}
	
	@Override
	public List<Object[]> LabEmployeeList(String LabCode) throws Exception {
		return dao.LabEmployeeList(LabCode);
	}
	@Override
	public List<Object[]> LabEmpListFilterForAction(String LabCode , String MainId) throws Exception
	{
		return dao.LabEmpListFilterForAction(LabCode,MainId);
	}
	
	 @Override
	 public List<Object[]> ActionSubLevelsList(String ActionAssignId) throws Exception
	 {
		 return dao.ActionSubLevelsList(ActionAssignId);
	 }
	 
	@Override
	public List<Object[]> ActionSubList(String assignid) throws Exception 
	{
		return dao.ActionSubList(assignid);
	}
	
	@Override
	public Object[] ActionAssignDataAjax(String assignid) throws Exception 
	{
		return dao.ActionAssignDataAjax(assignid);
	}	
	
	@Override
	public long ActionMainInsertFromOnboard(ActionMainDto main , ActionAssign assign) throws Exception 
	{
		try {
			logger.info(new Date() +"Inside SERVICE ActionMainInsertFromOnboard ");
			long success=1;
			long unsuccess=0;
			Object[] lab=null;
			int count=0;
			String ProjectCode=null;
			try
			{
				lab=dao.LabDetails();
				count=dao.ActionGenCount(main.getProjectId(),main.getType());
				if(!main.getProjectId().equalsIgnoreCase("0"))
				{
					ProjectCode=dao.ProjectCode(main.getProjectId());
				}
				
			}
			catch (Exception e) 
			{
				logger.info(new Date() +"Inside SERVICE ActionMainInsertFromOnboard ",e);	
				return unsuccess;
			}
			
			ActionMain actionmain=new ActionMain();
				actionmain.setActionLinkId(unsuccess);
				actionmain.setMainId(0l);
				actionmain.setActivityId(Long.parseLong(main.getActivityId()));
				actionmain.setActionType(main.getActionType());
				actionmain.setType(main.getType());
				actionmain.setActionItem(main.getActionItem());
				actionmain.setActionDate(java.sql.Date.valueOf(main.getActionDate()));
				actionmain.setCategory(main.getCategory());
				actionmain.setPriority(main.getPriority());
				actionmain.setProjectId(Long.parseLong(main.getProjectId()));
				actionmain.setScheduleMinutesId(Long.parseLong(main.getScheduleMinutesId()));
				actionmain.setCreatedBy(main.getCreatedBy());
				actionmain.setCreatedDate(sdf1.format(new Date()));
				actionmain.setIsActive(1);
				actionmain.setParentActionId(0l);
				actionmain.setActionLevel(1l);
			long result=dao.ActionMainInsert(actionmain);
			
			if(result>0) {
			ActionAssign actionassign = new ActionAssign();
				
			count=count+1;
			String Project=null;
			
			if(!main.getProjectId().equalsIgnoreCase("0")) {
				if(main.getActionType().equalsIgnoreCase("S")) 
				{
					Object[] comishortname=dao.CommitteeShortName(main.getScheduleId());
					Project="/"+ProjectCode+"/"+comishortname[1]+"/";
				}else if(main.getActionType().equalsIgnoreCase("N")) {
					Project="/"+ProjectCode+"/";
					
				}else {
					Project="/"+ProjectCode+"/MIL/";
				}
			}else{
				Project="/GEN/";
			}
			
			
			if(lab!=null && main.getLabName()!=null) {
		    	 
			     actionassign.setActionNo(main.getLabName()+Project+sdf2.format(java.sql.Date.valueOf(main.getActionDate())).toString().toUpperCase().replace("-", "")+"/"+count);
			}else {
				return unsuccess;
			}
			
			actionassign.setEndDate(assign.getEndDate());
			actionassign.setActionMainId(result);
			actionassign.setPDCOrg(assign.getPDCOrg());
			actionassign.setAssigneeLabCode(assign.getAssigneeLabCode());
			actionassign.setAssignee(assign.getAssignee());
			actionassign.setAssignorLabCode(assign.getAssignorLabCode());
			actionassign.setAssignor(assign.getAssignor());
			actionassign.setRevision(assign.getRevision());
//			actionassign.setActionFlag(assign.getActionFlag());		
			actionassign.setActionStatus(assign.getActionStatus());
			actionassign.setCreatedBy(main.getCreatedBy());
			actionassign.setCreatedDate(sdf1.format(new Date()));
			actionassign.setIsActive(1);
			actionassign.setProgress(0);
			long assignid=  dao.ActionAssignInsert(actionassign);
					
			}
			if(result>0) {
				return success;
			}else {
				return unsuccess;
			}
		} catch (Exception e) {
			logger.info(new Date() +"Inside SERVICE ActionMainInsertFromOnboard "+ e);	
			e.printStackTrace();
			return 0;
		}
	}
	@Override
	public List<Object[]> GetIssueList( String Empid )throws Exception
	{
		return dao.GetIssueList(Empid );
	}

	@Override
	public long IssueSubInsert(ActionSubDto main ) throws Exception {
		logger.info(new Date() +"Inside SERVICE IssueSubInsert ");
		
		Timestamp instant= Timestamp.from(Instant.now());
		String LabCode = main.getLabCode();
		String timestampstr = instant.toString().replace(" ","").replace(":", "").replace("-", "").replace(".","");
		
		String Path = LabCode+"\\IssueData\\";
		
		ActionSub sub=new ActionSub();
		sub.setActionAssignId(Long.parseLong(main.getActionAssignId()));
		sub.setRemarks(main.getRemarks());
		sub.setProgress(Integer.parseInt(main.getProgress()));
		sub.setProgressDate(new java.sql.Date(rdf.parse(main.getProgressDate()).getTime()));
		sub.setCreatedBy(main.getCreatedBy());
		sub.setCreatedDate(sdf1.format(new Date()));
		sub.setIsActive(1);
		long subresult=dao.ActionSubInsert(sub);
		if(subresult>0) {
			
			ActionAssign updateassign=getActionAssign(main.getActionAssignId());
//			updateassign.setActionFlag("N");
			updateassign.setActionStatus("A");
			updateassign.setModifiedBy(main.getCreatedBy());
			updateassign.setModifiedDate(sdf1.format(new Date()));
			updateassign.setProgress(Integer.parseInt(main.getProgress()));
			updateassign.setProgressDate(sdf.format(rdf.parse(main.getProgressDate())));
			updateassign.setProgressRemark(main.getRemarks());
			dao.AssignUpdate(updateassign);
			ActionAttachment attach=new ActionAttachment();
			
			attach.setAttachFilePath(Path);
			attach.setActionSubId(subresult);
			attach.setAttachName(main.getFileNamePath());
			if(!main.getMultipartfile().isEmpty()) {
				attach.setAttachName("Issue"+timestampstr+"."+FilenameUtils.getExtension(main.getMultipartfile().getOriginalFilename()));
				saveFile(uploadpath+Path, attach.getAttachName(), main.getMultipartfile());
			}else{
				attach.setAttachFilePath(null);
			}
			attach.setCreatedBy(main.getCreatedBy());
			attach.setCreatedDate(sdf1.format(new Date()));
			if(!main.getMultipartfile().isEmpty()) {
				dao.ActionAttachInsert(attach);
			}
		}else {
			subresult=0;
		}
		return subresult;
	}
	
	
	@Override
	public int IssueClosed(String id, String Remarks, String UserId ,String assignid ) throws Exception {
		logger.info(new Date() +"Inside Service IssueClosed ");
		
		long result=0;
		ActionAssign assign=getActionAssign(assignid);
		assign.setActionAssignId(Long.parseLong(assignid));
//		assign.setActionFlag("Y");
		assign.setActionStatus("C");
		assign.setRemarks(Remarks);
		assign.setModifiedBy(UserId);
		assign.setModifiedDate(sdf1.format(new Date()));
		assign.setClosedDate(sdf.format(new Date()));
		if(assign.getProgressDate()==null) {
			assign.setProgressDate(sdf.format(new Date())); 
		}
		 result=dao.MainSendBack(assign);
		if(result>0) {
			Object[] data=dao.ActionNotification(id,assignid).get(0);
			PfmsNotification notification=new PfmsNotification();
			notification.setEmpId(Long.parseLong(data[2].toString()));
			notification.setNotificationby(Long.parseLong(data[5].toString()));
			notification.setNotificationDate(sdf1.format(new Date()));
			notification.setScheduleId(0l);
			notification.setCreatedBy(assign.getCreatedBy());
			notification.setCreatedDate(sdf1.format(new Date()));
			notification.setIsActive(1);
			notification.setNotificationUrl("ActionStatusList.htm");
		    notification.setNotificationMessage("An Action No "+data[7]+" Closed by "+data[3]+", "+data[4]+".");
		    notification.setStatus("MAR");
            dao.ActionNotificationInsert(notification);
		}
		return 1;
	}
	@Override
	public List<Object[]> GetRecomendationList(String projectid ,  String committeid)throws Exception
	{
		return dao.GetRecomendationList(projectid,committeid);
	}
	@Override
	public List<Object[]> GetDecisionList(String projectid ,  String committeid)throws Exception
	{
		return dao.GetDecisionList(projectid,committeid);
	}
	
	@Override
	public List<Object[]> GetRecDecSoughtList(String projectid,String  committeeid , String type)throws Exception{
		return dao.GetRecDecSoughtList(projectid,committeeid,type);
	}
	
	@Override
	public List<Object[]> getActualDecOrRecSought(String scheduleid, String type)throws Exception
	{
		
		return dao.getActualDecOrRecSought(scheduleid , type);
	}
	
	@Override
	public List<Object[]> getDecOrRecSought(String scheduleid , String type)throws Exception
	{
		return dao.getDecOrRecSought(scheduleid, type);
	}

	@Override
    public List<Object[]> GetActionList(String empid)throws Exception
    {
    	return dao.GetActionList(empid);
    }

	@Override
	public List<Object[]> ActionMonitoring(String ProjectId , String Status)throws Exception
	{
		return dao.ActionMonitoring(ProjectId, Status);
	}
	@Override
	public List<Object[]> GetActionListForFevorite(String fromdate , String todate , String projectid , String  empid)throws Exception
	{
		return dao.GetActionListForFevorite( new java.sql.Date(rdf.parse(fromdate).getTime()),new java.sql.Date(rdf.parse(todate).getTime()) ,projectid,empid);
	}
	@Override
	public Long AddFavouriteList(String[] favoriteid , Long empid ,String userid)throws Exception
	{
		Long count =0l;
		for(int i=0; i<favoriteid.length;i++){
			FavouriteList fav = new FavouriteList();
			fav.setActionAssignId(Long.parseLong(favoriteid[i]));
			fav.setEmpId(empid);
			fav.setCreatedBy(userid);
			fav.setCreatedDate(sdf1.format(new Date()));
			fav.setIsActive(1);
			count=+ dao.AddFavouriteList(fav);
		}
		return count;
		
	}
	@Override
	public List<Object[]> GetFavouriteList(String empid)throws Exception
	{
		return dao.GetFavouriteList(empid);
	}
	@Override
	public List<Object[]> ProjectTypeList() throws Exception {

		return dao.ProjectTypeList();
	}

	@Override
	public List<Object[]> GetRfaActionList(String EmpId,String ProjectId,String fdate,String tdate) throws Exception 
	{
		
		return dao.GetRfaActionList(EmpId,ProjectId,fdate,tdate);
	}

	
	@Override
	public List<Object[]> PriorityList() throws Exception {
		
		return dao.PriorityList();
	}
	@Override
	public Long RfaActionSubmit(RfaActionDto rfa,String LabCode,String UserId,String[] assignee,String[] CCEmpName) throws Exception {
		
		logger.info(new Date() + "Inside Service RfaActionSubmit");
		
		try {
			
		String project = dao.ProjectCode(rfa.getProjectId().toString());
//		Object[] division = dao.GetDivisionCode(Division);
//		String DivisionCode = division[1].toString();
		List<Object[]> rfaDivType=dao.getRfaType();
		String RfaTypeName=null;
		
		for(Object[] obj : rfaDivType) {
			if(obj[0]!=null && obj[0].toString().equalsIgnoreCase(rfa.getRfaTypeId())) {
				RfaTypeName=obj[1].toString();
			}
		}
		Long RfaCount = dao.GetRfaCount(rfa.getRfaTypeId());
		String RfaNo=null;
		if(RfaCount<9) {
		    RfaNo = LabCode + "/" + project + "/" + RfaTypeName + "/" + ("0"+(RfaCount+1));
		}else {
			RfaNo = LabCode + "/" + project + "/" + RfaTypeName + "/" + (RfaCount+1);
		}

		String Path = LabCode+"\\RFAFiles\\";
		
		RfaAction rfa1= new RfaAction();
		
		rfa1.setRfaDate(rfa.getRfaDate());
		rfa1.setLabCode(LabCode);
		rfa1.setRfaNo(RfaNo);
		rfa1.setRfaTypeId(rfa.getRfaTypeId());
		rfa1.setProjectId(rfa.getProjectId());
		rfa1.setPriorityId(rfa.getPriorityId());
		rfa1.setStatement(rfa.getStatement());
		rfa1.setDescription(rfa.getDescription());
		rfa1.setReference(rfa.getReference());
		rfa1.setAssignorId(rfa.getAssignorId());
		rfa1.setRfaStatus("AA");
		rfa1.setCreatedBy(UserId);
		rfa1.setCreatedDate(sdf.format(new Date()));
		rfa1.setIsActive(1);
		
		long rfaIdAttach= dao.RfaActionSubmit(rfa1);
		
		RfaTransaction rfaTrans = new RfaTransaction();
		rfaTrans.setRfaId(rfaIdAttach);
		rfaTrans.setEmpId(Long.parseLong(rfa.getAssignorId()));
		rfaTrans.setRfaStatus("AA");
		rfaTrans.setActionBy(rfa.getAssignorId());
		rfaTrans.setActionDate(sdf1.format(new Date()));
		dao.updateRfaTransaction(rfaTrans);
		
		for(int i=0;i<assignee.length;i++) {

			RfaAssign assign = new RfaAssign();
			assign.setAssigneeid(Long.parseLong(assignee[i]));
			assign.setLabCode(LabCode);
			assign.setRfaId(rfaIdAttach);
			assign.setCreatedBy(UserId);
			assign.setCreatedDate(sdf.format(new Date()));
			assign.setIsActive(1);
			
			dao.RfaAssignInsert(assign);
		}
		
		for(int i=0;i<CCEmpName.length;i++) 
		{
			RfaCC rfaCC = new RfaCC();
			rfaCC.setRfaId(rfaIdAttach);
			rfaCC.setCCEmpId(Long.parseLong(CCEmpName[i]));
			rfaCC.setActionBy(rfa.getActionBy());
			rfaCC.setCreatedBy(UserId);
			rfaCC.setCreatedDate(sdf.format(new Date()));
			rfaCC.setIsActive(1);
			dao.rfaCCInsert(rfaCC);
		}
		
 if(!rfa.getAssignorAttachment().isEmpty()) {
		RfaAttachment rfaAttach=new RfaAttachment();
		rfaAttach.setRfaId(rfaIdAttach);
		rfaAttach.setFilesPath(Path);
		rfaAttach.setAssignorAttachment(rfa.getMultipartfile().getOriginalFilename());
		saveFile(uploadpath+Path, rfaAttach.getAssignorAttachment(), rfa.getMultipartfile());
		rfaAttach.setCreatedBy(UserId);
		rfaAttach.setCreatedDate(sdf.format(new Date()));
		rfaAttach.setIsActive(1);
		
	 dao.RfaAttachment(rfaAttach);
 }
		return rfaIdAttach;
		
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside Service RfaActionSubmit", e);
			return null;
		}

	}

	@Override
	public Object[] RfaActionEdit(String rfaid) throws Exception {
		
		return dao.RfaActionEdit(rfaid);
	}

	@Override
	public Object[] RfaLabDetails(String LabCode) throws Exception {
		 
		return dao.RfaLabDetails(LabCode);
	}

	@Override
	public Long RfaEditSubmit(RfaActionDto rfa,String[] assignee,String[] CCEmpName) throws Exception {
		
		String LabCode = rfa.getLabCode();
		String Path = LabCode + "\\RFAFiles\\";

		RfaAction action = new RfaAction();
			action.setRfaDate(rfa.getRfaDate());
			action.setPriorityId(rfa.getPriorityId());
			action.setRfaId(rfa.getRfaId());
			action.setStatement(rfa.getStatement());
			action.setDescription(rfa.getDescription());
			action.setReference(rfa.getReference());
			action.setModifiedBy(rfa.getModifiedBy());
			action.setModifiedDate(sdf1.format(new Date()));
			
			long count=dao.RfaEditSubmit(action);

		RfaAttachment rfaAttach=new RfaAttachment();
		
		Object[] obj = dao.RfaAttachmentDownload(rfa.getRfaId()+"");
		
		if(obj!=null) {// if already attachment is there 
			if(!rfa.getAssignorAttachment().isEmpty()) {
				
				int result=dao.deleterfaAttachment(rfa.getRfaId()); // deleting the existing attachement

				rfaAttach.setRfaId(rfa.getRfaId());
				rfaAttach.setFilesPath(Path);
				rfaAttach.setAssignorAttachment(rfa.getMultipartfile().getOriginalFilename());
				saveFile(uploadpath+Path, rfaAttach.getAssignorAttachment(), rfa.getMultipartfile());
				rfaAttach.setCreatedBy(rfa.getModifiedBy());
				rfaAttach.setCreatedDate(sdf1.format(new Date()));
				rfaAttach.setIsActive(1);
				dao.RfaAttachment(rfaAttach);
			}
		}
		else {
		
		if(!rfa.getAssignorAttachment().isEmpty()) {
			rfaAttach.setRfaId(rfa.getRfaId());
			rfaAttach.setFilesPath(Path);
			rfaAttach.setAssignorAttachment(rfa.getMultipartfile().getOriginalFilename());
			saveFile(uploadpath+Path, rfaAttach.getAssignorAttachment(), rfa.getMultipartfile());
			rfaAttach.setCreatedBy(rfa.getModifiedBy());
			rfaAttach.setCreatedDate(sdf1.format(new Date()));
			rfaAttach.setIsActive(1);
			dao.RfaAttachment(rfaAttach);
		}
		
		}
		
		//for assignee emplist edit start
		Long result=dao.UpdateAssigneeData(rfa.getRfaId()+""); // here first existing data isactive will be "0"
		for(int i=0;i<assignee.length;i++) 
		{
			RfaAssign assign = new RfaAssign();
			assign.setAssigneeid(Long.parseLong(assignee[i]));
			assign.setLabCode(LabCode);
			assign.setRfaId(rfa.getRfaId());
			assign.setCreatedBy(rfa.getModifiedBy());
			assign.setCreatedDate(sdf.format(new Date()));
			assign.setIsActive(1);
			dao.RfaAssignInsert(assign);                      //again it insert to table 
		}
		//for assignee emplist edit end
		
		System.out.println(Arrays.asList(CCEmpName)+"-------");
		
		//for CC emplist edit start
		Long result1=dao.updateRfaCC(rfa.getRfaId()+"");  // here first existing data isactive will be "0"
		for(int i=0;i<CCEmpName.length;i++) 
		{
			RfaCC rfaCC = new RfaCC();
			rfaCC.setRfaId(rfa.getRfaId());
			rfaCC.setCCEmpId(Long.parseLong(CCEmpName[i]));
			rfaCC.setActionBy(rfa.getActionBy());
			rfaCC.setModifiedBy(rfa.getModifiedBy());
			rfaCC.setModifiedDate(sdf.format(new Date()));
			rfaCC.setIsActive(1);
			dao.rfaCCInsert(rfaCC);                      //again it insert to table 
		}
		//for CC emplist edit end
		
		return count;
	}

	@Override
	public Object[] RfaPrintData(String rfaid) throws Exception {
		
		return dao.RfaPrintData(rfaid);
	}

	@Override
	public List<Object[]> RfaForwardList(String EmpId) throws Exception {
		
		return dao.RfaForwardList(EmpId);
	}
	@Override
	public List<Object[]> RfaInspectionApprovalList(String EmpId) throws Exception {
		
		return dao.RfaInspectionApprovalList(EmpId);
	}
	
	@Override
	public List<Object[]> RfaInspectionList(String EmpId) throws Exception {
		
		return dao.RfaInspectionList(EmpId);
	}
	
	@Override
	public List<Object[]> RfaForwardApprovedList(String EmpId) throws Exception {
		
		return dao.RfaForwardApprovedList(EmpId);
	}
	@Override
	public List<Object[]> RfaInspectionApprovedList(String EmpId) throws Exception {
		
		return dao.RfaInspectionApprovedList(EmpId);
	}
	

@Override
public Object[] getRfaAssign(String rfa) throws Exception {
	
	return dao.getRfaAssign(rfa);
}

@Override
public Long RfaModalSubmit(RfaInspection inspection,RfaActionDto rfa) throws Exception {
	
	inspection.setCreatedDate(sdf1.format(new Date()));
	
	String LabCode = rfa.getLabCode();
	String Path = LabCode + "\\RFAFiles\\";
	
	RfaAttachment rfaAttach=new RfaAttachment();
	
	Object[] obj = dao.RfaAttachmentDownload(rfa.getRfaId()+"");
	if(obj!=null) {// if already attachment is there 
		if(!rfa.getAssigneAttachment().isEmpty()) {
			
			rfaAttach.setRfaId(rfa.getRfaId());
			rfaAttach.setFilesPath(obj[2].toString());
			rfaAttach.setAssigneeAttachment(rfa.getMultipartfile().getOriginalFilename());
			saveFile(uploadpath+Path, rfaAttach.getAssigneeAttachment(), rfa.getMultipartfile());
			rfaAttach.setModifiedBy(rfa.getModifiedBy());
			rfaAttach.setModifiedDate(sdf1.format(new Date()));
			rfaAttach.setIsActive(1);
			dao.updateRfaAttachment(rfaAttach);
		}
	}
	else {
	
	if(!rfa.getAssigneAttachment().isEmpty()) {
		rfaAttach.setRfaId(rfa.getRfaId());
		rfaAttach.setFilesPath(Path);
		rfaAttach.setAssigneeAttachment(rfa.getMultipartfile().getOriginalFilename());
		saveFile(uploadpath+Path, rfaAttach.getAssigneeAttachment(), rfa.getMultipartfile());
		rfaAttach.setCreatedBy(rfa.getCreatedBy());
		rfaAttach.setCreatedDate(sdf1.format(new Date()));
		rfaAttach.setIsActive(1);
		dao.RfaAttachment(rfaAttach);
	}
	
 }
	RfaTransaction tr = new RfaTransaction();
	tr.setRfaId(rfa.getRfaId());
	tr.setRfaStatus("AAA");
	tr.setEmpId(inspection.getEmpId());
	tr.setActionBy(inspection.getEmpId()+"");
	tr.setActionDate(sdf1.format(new Date()));
	dao.updateRfaTransaction(tr);
	
	int result=dao.RfaActionUpdate(rfa.getRfaId().toString());
	
	return dao.RfaModalSubmit(inspection);
}

@Override
public Object[] RfaAssignAjax(String rfaId) throws Exception {
	
	return dao.RfaAssignAjax(rfaId);
}

@Override
public Long RfaModalUpdate(RfaInspection inspection,RfaActionDto rfa) throws Exception {
	inspection.setModifiedDate(sdf1.format(new Date()));

	String LabCode = rfa.getLabCode();
	String Path = LabCode + "\\RFAFiles\\";
	
	RfaAttachment rfaAttach=new RfaAttachment();
	
	Object[] obj = dao.RfaAttachmentDownload(rfa.getRfaId()+"");
	if(obj!=null) {// if already attachment is there 
		if(!rfa.getAssigneAttachment().isEmpty()) {
			
			rfaAttach.setRfaId(rfa.getRfaId());
			rfaAttach.setFilesPath(obj[2].toString());
			rfaAttach.setAssigneeAttachment(rfa.getMultipartfile().getOriginalFilename());
			saveFile(uploadpath+Path, rfaAttach.getAssigneeAttachment(), rfa.getMultipartfile());
			rfaAttach.setModifiedBy(rfa.getModifiedBy());
			rfaAttach.setCreatedDate(sdf1.format(new Date()));
			rfaAttach.setIsActive(1);
			dao.updateRfaAttachment(rfaAttach);
		}
	}
	else {
	
	if(!rfa.getAssigneAttachment().isEmpty()) {
		rfaAttach.setRfaId(rfa.getRfaId());
		rfaAttach.setFilesPath(Path);
		rfaAttach.setAssigneeAttachment(rfa.getMultipartfile().getOriginalFilename());
		saveFile(uploadpath+Path, rfaAttach.getAssigneeAttachment(), rfa.getMultipartfile());
		rfaAttach.setCreatedBy(rfa.getCreatedBy());
		rfaAttach.setCreatedDate(sdf1.format(new Date()));
		rfaAttach.setIsActive(1);
		dao.RfaAttachment(rfaAttach);
	}
	
 }
	
     long count=dao.RfaModalUpdate(inspection);
	
	 return count;

}
@Override
public Long RfaReturnList(String rfaStatus, String UserId, String rfa,String EmpId,String assignee,String assignor,String replyMsg) throws Exception {
	
    Object[] obj = dao.RfaList(rfa,EmpId);
    
    String Url="";
    
    List<String> ReturnStatus1  = Arrays.asList("AF","AX","AC","AV");
	List<String> ReturnStatus2  = Arrays.asList("RFA","AY","AR");
	
	String SetEmployee="";
	
	if(ReturnStatus1.contains(rfaStatus)) {
		SetEmployee=assignor;
		Url="RfaAction.htm";
	}if(ReturnStatus2.contains(rfaStatus)) {
		SetEmployee=assignee;
		//Url="RfaInspection.htm";
		Url="RfaInspection.htm";
	}if(rfaStatus.equalsIgnoreCase("REV") || rfaStatus.equalsIgnoreCase("REK") || rfaStatus.equalsIgnoreCase("RFC")) {
		SetEmployee=EmpId;
		Url="RfaAction.htm";
	}
	
	RfaAction rf= new RfaAction();
	
	RfaTransaction tr= new RfaTransaction();
	
	String newstatus="";
    
	if(rfaStatus.equalsIgnoreCase("AF")) {
		newstatus="RC";
	}
	if(rfaStatus.equalsIgnoreCase("REV") && assignor.equalsIgnoreCase(EmpId)) {
		newstatus="REV";
	}
	if(rfaStatus.equalsIgnoreCase("AC") || rfaStatus.equalsIgnoreCase("AX")) {
		newstatus="RV";
	}
	if(rfaStatus.equalsIgnoreCase("AV") ) {
		newstatus="RE";
	}
	if(rfaStatus.equalsIgnoreCase("RFA") ) {
		newstatus="RR";
	}
	if(rfaStatus.equalsIgnoreCase("AR") || rfaStatus.equalsIgnoreCase("AY")) {
		newstatus="RP";
	}
	if((rfaStatus.equalsIgnoreCase("REK"))) {
		newstatus="REK";
	}if((rfaStatus.equalsIgnoreCase("RFC"))) {
		newstatus="RFC";
	}
	
	rf.setRfaStatus(newstatus);   // for rfa action table
	
	tr.setEmpId(Long.parseLong(SetEmployee));  // for rfa transaction table
	tr.setRfaStatus(newstatus);
	tr.setRfaId(Long.parseLong(rfa));
	tr.setRemarks(replyMsg);
	tr.setActionBy(EmpId);
	tr.setActionDate(sdf1.format(new Date()));
	
	List<PfmsNotification> x = new ArrayList<>();  
	
	List<String> revokeList = Arrays.asList("REV","REK","RFC");

	PfmsNotification pf = new PfmsNotification();
	if(!revokeList.contains(newstatus)) {
	pf.setEmpId(Long.parseLong(SetEmployee));
	pf.setStatus("MAR");
	pf.setNotificationUrl(Url);
	pf.setNotificationMessage("RFA No"+" "+obj[2]+" "+"is returned by"+" "+obj[5]);
	pf.setIsActive(1);
	pf.setNotificationby(Long.parseLong(EmpId));
	pf.setNotificationDate(sdf1.format(new Date()));
	pf.setCreatedBy(UserId);
	pf.setCreatedDate(sdf1.format(new Date()));
	}
	x.add(pf);
	
    long count=dao.RfaReturnList(x,rf,tr,rfa);
	
    if(newstatus.equalsIgnoreCase("REK")) {
    	//if status is REK pass default 4
    	return 4l;
    }
    
	return count;
}

@Override
public String getAssignDetails(String empId, Long rfaId) throws Exception {
	return dao.getAssignDetails(empId,rfaId);
}

@Override
public Object[] getRfaAddData(String rfaId) throws Exception {
	return dao.getRfaAddData(rfaId);
}

@Override
public Object[] getRfaInspectionData(String rfaId) throws Exception {
	return dao.getRfaInspectionData(rfaId);
}


@Override
public List<Object[]> getrfaRemarks(String rfaId,String Status) throws Exception {
	return dao.getrfaRemarks(rfaId,Status);
}


@Override
public List<Object[]> ProjectApplicableCommitteeList(String projectid)throws Exception
{
	return dao.ProjectApplicableCommitteeList(projectid);
}

@Override
public List<Object[]> MeettingCount(String committeeid, String projectid) throws Exception {
	
	return dao.MeettingCount(committeeid,projectid);
}

@Override
public List<Object[]> MeettingList(String committeeid, String projectid, String scheduleid) throws Exception {
	
	return dao.MeettingList(committeeid,projectid,scheduleid);
}

@Override
public List<Object[]> MeettingActionList(String committeeid, String projectid, String scheduleid, String empId)
		throws Exception {
	
	return dao.MeettingActionList(committeeid,projectid,scheduleid,empId);
}
@Override
public List<Object[]> getAllEmployees(String flag) throws Exception {
	//new added
	return dao.getAllEmployees(flag);
}

@Override
public List<Object[]> getRfaModalEmpList(String labCode) throws Exception {
	
	return  dao.getRfaModalEmpList(labCode);
}

@Override
public List<Object[]> getRfaTDList(String labCode) throws Exception {
	
	return  dao.getRfaTDList(labCode);
}

@Override
public long RfaActionForward(String rfaStatus, String projectid, String UserId, String rfa, String EmpId, String rfaEmpId) throws Exception {
	
   Object[] obj = dao.RfaList(rfa,EmpId);
   
   String Url="";
   
   List<String> Status1  = Arrays.asList("AF","AX","AC");
   List<String> Status2  = Arrays.asList("RFA","AY","AR");
   String Status3 ="AV";
	
	
	if(Status1.contains(rfaStatus)) {
		Url="RfaActionForwardList.htm";
	}if(Status2.contains(rfaStatus)) {
		Url="RfaInspectionApproval.htm";
	}if(Status3.contains(rfaStatus)) {
		Url="RfaInspection.htm";
	}
 
	RfaAction rf = new RfaAction();
	rf.setRfaStatus(rfaStatus);

	
	if(rfaStatus.equalsIgnoreCase("ARC")) {
		rfaEmpId=EmpId;
	}
	
	List<String> assignId = new ArrayList<String>(); // For storing multiple assigneeid 

	for(Object[]Assignee:AssigneeEmpList()) {  
		if(Assignee[0].toString().equalsIgnoreCase(rfa)) {  // comparing with rfaid
			assignId.add(Assignee[3].toString());           // add all multiple assigneeid in assignId
		}
	}
	
	List<RfaTransaction> trans = new ArrayList<RfaTransaction>();
	
	
	if(rfaStatus.equalsIgnoreCase("AV")){
	  for(int i=0;i<assignId.size();i++) {
		  
	    RfaTransaction tr = new RfaTransaction();
	    
		tr.setRfaId(Long.parseLong(rfa));
		tr.setRfaStatus(rfaStatus);
		tr.setEmpId(Long.parseLong(assignId.get(i))); // Here multiple assigneeid store in transaction
		tr.setActionBy(EmpId);
		tr.setActionDate(sdf1.format(new Date()));
		trans.add(tr);
	  }
	}else {
		
		RfaTransaction tr = new RfaTransaction();
		
		tr.setRfaId(Long.parseLong(rfa));
		tr.setRfaStatus(rfaStatus);
		tr.setEmpId(Long.parseLong(rfaEmpId));
		tr.setActionBy(EmpId);
		tr.setActionDate(sdf1.format(new Date()));
		trans.add(tr);
	}
	
	List<PfmsNotification> x = new ArrayList<>();
	
	List<String> employee= new ArrayList<String>();
	
	if(rfaEmpId==null) {
		employee.addAll(assignId);
	}else {
		 employee.add(rfaEmpId);
	}
	
	
	if(!rfaStatus.equalsIgnoreCase("ARC")) {
	   for(String empId : employee) {
	PfmsNotification pf = new PfmsNotification();
	pf.setEmpId(Long.parseLong(empId));	
	pf.setStatus("MAR");
	pf.setNotificationUrl(Url);
	pf.setNotificationMessage("RFA No"+" "+obj[2]+" "+"Forwarded By"+" "+obj[5]);
	pf.setIsActive(1);
	pf.setNotificationby(Long.parseLong(EmpId));
	pf.setNotificationDate(sdf1.format(new Date()));
	pf.setCreatedBy(UserId);
	pf.setCreatedDate(sdf1.format(new Date()));
	x.add(pf);
	  }
	}
	
	long count=dao.RfaActionForward(x,rf,trans,rfa);

	return count;
}

@Override
public List<Object[]> getRfaTransList(String rfaTransId) throws Exception {
	
	return dao.getRfaTransList(rfaTransId);
}

@Override
public Object[] RfaAttachmentDownload(String rfaid) throws Exception {
	
	return dao.RfaAttachmentDownload(rfaid);
}

@Override
public List<Object[]> AssigneeEmpList() throws Exception {
	
	return dao.AssigneeEmpList();
}

/*
 * @Override public List<String> CCAssigneeList(String rfaid) throws Exception {
 * 
 * return dao.CCAssigneeList(rfaid); }
 */
@Override
public List<String> CCAssignorList(String rfaid) throws Exception {
	
	return dao.CCAssignorList(rfaid);
}

@Override
public List<Object[]> GetRfaActionList1(String Project, String fdate, String tdate) throws Exception {

	return dao.GetRfaActionList1(Project,fdate,tdate);
}

@Override
public List<Object[]> RfaProjectwiseList(String empId, String Project, String fdate, String tdate) throws Exception {
	
	return dao.RfaProjectwiseList(empId,Project,fdate,tdate);
}
@Override
public List<Object[]> getmodifieddate(String userId, int pid)throws Exception {
	// TODO Auto-generated method stub
	return dao.getmodifieddate(userId,pid);
}

@Override
public List<Object[]> getProjectByDirectorID(String empId)throws Exception {
	// TODO Auto-generated method stub
	return dao.getProjectByDirectorID(empId);
}

@Override
public List<Object[]> getRecentWeeklyUpdateDate(String string)throws Exception {
	// TODO Auto-generated method stub
	return dao.getRecentWeeklyUpdateDate(string);
	
}

@Override
public List<Object[]> getRiskDetails(String LabCode, int pid)throws Exception {
	// TODO Auto-generated method stub
	return dao.getRiskDetails(LabCode,pid);
}

@Override
public List<Object[]> getMilestoneDate( int pid)throws Exception {
	// TODO Auto-generated method stub
	return dao.getMilestoneDate(pid);
}

@Override
public List<Object[]> getMeetingDate(int pid)throws Exception {
	// TODO Auto-generated method stub
	return dao.getMeetingDate(pid);
}

@Override
public List<Object[]> getProdurementDate(int pid)throws Exception {
	// TODO Auto-generated method stub
	return dao.getProdurementDate(pid);
}

@Override
public List<Object[]> getAllRecentUpdateList(String projectId)throws Exception {
	// TODO Auto-generated method stub
	return dao.getAllRecentUpdateList(projectId);
}

@Override
public Object getEmpnameById(int EmpId)throws Exception {
	// TODO Auto-generated method stub
	return dao.getEmpnameById(EmpId);
}

@Override
public Object getProjectCodeById(int ProjectId)throws Exception {
	// TODO Auto-generated method stub
	return dao.getProjectCodeById(ProjectId);
}

@Override
public Object getProjectShortNameById(int ProjectId)throws Exception {
	// TODO Auto-generated method stub
	return dao.getProjectShortNameById(ProjectId);
}

@Override
public int ActionSubDeleteUpdate(String ActionAssignId, String progress, String progressDate, String progressRemarks) throws Exception {
	
	return dao.ActionSubDeleteUpdate(ActionAssignId,progress,progressDate,progressRemarks);
}

@Override
public int ActionRemarksEdit(String actionAssignId, String progress, String progressRemarks,String UserId) throws Exception {

	return dao.ActionRemarksEdit(actionAssignId,progress,progressRemarks,UserId);
}
@Override
public int actionSubRemarksEdit(String actionSubId, String progress, String progressRemarks, String UserId) throws Exception {
	return dao.actionSubRemarksEdit(actionSubId,progress,progressRemarks,UserId);
}

@Override
public List<String> rfaMailSend(String rfa) throws Exception {
	return dao.rfaMailSend(rfa);
}

@Override
public List<Object[]> getRfaNoTypeList() throws Exception {
	return dao.getRfaType();                       
}

@Override
public List<Object[]> RfaCCList() throws Exception {
	return dao.RfaCCList();
}

@Override
public List<Object[]> rfaTotalActionList(String projectid, String rfatypeid, String fdate, String tdate) {
	return dao.rfaTotalActionList(projectid,rfatypeid,fdate,tdate);
}

@Override
public int CommitteActionEdit(ActionAssignDto actionAssign) throws Exception {
	actionAssign.setModifiedDate(sdf1.format(new Date()));
	return dao.CommitteActionEdit(actionAssign);
}

@Override
public List<Object[]> RfaPendingCount(String empId) throws Exception {
	return dao.RfaPendingCount(empId);
}
@Override
public List<Object[]> ActionReportsNew(String EmpId, String Term, String Position,String Type,String LabCode,String loginType ) throws Exception {
	
	return dao.ActionReportsNew(EmpId, Term, Position,Type,LabCode,loginType);
}
}

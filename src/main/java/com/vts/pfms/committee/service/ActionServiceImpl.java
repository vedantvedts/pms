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
	
	@Override
	public long ActionMainInsert(ActionMainDto main , ActionAssignDto assign) throws Exception 
	{
		try {
			logger.info(new Date() +"Inside SERVICE ActionMainInsert ");
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
				logger.info(new Date() +"Inside SERVICE ActionMainInsert ",e);	
				return unsuccess;
			}
			String Project=null;
			
			if(!main.getProjectId().equalsIgnoreCase("0")) {
				if(main.getActionType().equalsIgnoreCase("S")) 
				{
					Object[] comishortname=dao.CommitteeShortName(main.getScheduleMinutesId());
					Project="/"+ProjectCode+"/"+comishortname[1]+"/";
				}else if(main.getActionType().equalsIgnoreCase("N")) {
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
			long result=dao.ActionMainInsert(actionmain);
			//changed on 06-11
			if(assign.getMultipleAssigneeList().size()>0) {
				for(int i=0;i<assign.getMultipleAssigneeList().size();i++) {
					ActionAssign actionassign = new ActionAssign();
						
					count=count+1;

					if(lab!=null && main.getLabName()!=null) {
				    	 Date meetingdate= new SimpleDateFormat("yyyy-MM-dd").parse(main.getMeetingDate().toString());

					     actionassign.setActionNo(main.getLabName()+Project+sdf2.format(meetingdate).toString().toUpperCase().replace("-", "")+"/"+count);
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
	public List<Object[]> GetRfaActionList(String fdate, String tdate, String ProjectId,String EmpId) throws Exception 
	{
		
		return dao.GetRfaActionList(fdate,tdate,ProjectId,EmpId);
	}

	@Override
	public List<Object[]> PriorityList() throws Exception {
		
		return dao.PriorityList();
	}
	@Override
	public Long RfaActionSubmit(RfaActionDto rfa,String LabCode,String UserId,String Division) throws Exception {
		logger.info(new Date() + "Inside Service RfaActionSubmit");
		try {
		String project = dao.ProjectCode(rfa.getProjectId().toString());
		Object[] division = dao.GetDivisionCode(Division);
		String DivisionCode = division[1].toString();
		Long RfaCount = dao.GetRfaCount();	
		String RfaNo = LabCode + "/" + project + "/" + DivisionCode + "/" + (RfaCount+1);
		
		RfaAction rfa1= new RfaAction();
		
		rfa1.setRfaDate(rfa.getRfaDate());
		rfa1.setLabCode(LabCode);
		rfa1.setProjectId(rfa.getProjectId());
		rfa1.setPriorityId(rfa.getPriorityId());
		rfa1.setAssigneeId(rfa.getAssigneeId());
		rfa1.setStatement(rfa.getStatement());
		rfa1.setDescription(rfa.getDescription());
		rfa1.setReference(rfa.getReference());
		rfa1.setAssignorId(rfa.getAssignorId());
		rfa1.setRfaStatus("AA");
		rfa1.setCreatedBy(UserId);
		rfa1.setCreatedDate(sdf.format(new Date()));
		rfa1.setIsActive(1);
		rfa1.setRfaNo(RfaNo);
		
		return dao.RfaActionSubmit(rfa1);
		
		
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
//	@Override
//	public int RfaInspectionEdit(String rfaid) throws Exception {
//		
//		return dao.RfaInspectionEdit(rfaid);
//	}
	

	@Override
	public Object[] RfaLabDetails(String LabCode) throws Exception {
		 
		return dao.RfaLabDetails(LabCode);
	}

	@Override
	public Long RfaEditSubmit(RfaActionDto rfa) throws Exception {
		
		RfaAction action = new RfaAction();
			action.setRfaDate(rfa.getRfaDate());
			action.setPriorityId(rfa.getPriorityId());
			action.setRfaId(rfa.getRfaId());
			action.setStatement(rfa.getStatement());
			action.setDescription(rfa.getDescription());
			action.setReference(rfa.getReference());
			action.setModifiedBy(rfa.getModifiedBy());
			action.setModifiedDate(sdf1.format(new Date()));	
		
		return dao.RfaEditSubmit(action);
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
public long RfaActionForward(String rfaStatus, String projectid, String UserId, String rfa,String EmpId,String Logintype,String assineeId) throws Exception {
	
	Object[] obj = dao.RfaList(rfa,EmpId);
	List<String> assigneFwd  = Arrays.asList("AV","RE","RR","RP");
	List<String> userFwd  = Arrays.asList("AA","REV","RC","RV");
	RfaAction rf= new RfaAction();
	
	RfaTransaction tr= new RfaTransaction();
	
	
	if(rfaStatus.equalsIgnoreCase("AA")) {
		rf.setRfaStatus("AF");
	}else if(rfaStatus.equalsIgnoreCase("AF")) {
		rf.setRfaStatus("AC");
	}else if(rfaStatus.equalsIgnoreCase("AC")) {
		rf.setRfaStatus("AV");
	}else if(rfaStatus.equalsIgnoreCase("AV")) {
		rf.setRfaStatus("RFA");
	}else if(rfaStatus.equalsIgnoreCase("AE")) {
		rf.setRfaStatus("AR");
	}else if(rfaStatus.equalsIgnoreCase("AR")) {
		rf.setRfaStatus("AP");
	}else if(rfaStatus.equalsIgnoreCase("REV")) {
		rf.setRfaStatus("AF");
	}else if(rfaStatus.equalsIgnoreCase("RC")) {
		rf.setRfaStatus("AF");
	}else if(rfaStatus.equalsIgnoreCase("RV")) {
		rf.setRfaStatus("AF");
	}else if(rfaStatus.equalsIgnoreCase("RE")) {
		rf.setRfaStatus("RFA");
	}else if(rfaStatus.equalsIgnoreCase("RFA")) {
		rf.setRfaStatus("AR");
	}else if(rfaStatus.equalsIgnoreCase("RR")) {
		rf.setRfaStatus("RFA");
	}else if(rfaStatus.equalsIgnoreCase("RP")) {
		rf.setRfaStatus("RFA");
	}else if(rfaStatus.equalsIgnoreCase("AP")) {
		rf.setRfaStatus("ARC");
	}
	
	if(rfaStatus.equalsIgnoreCase("AA")) {
		tr.setRfaId(Long.parseLong(rfa));
		tr.setRfaStatus("AF");
		tr.setEmpId(Long.parseLong(EmpId));
		tr.setActionBy(UserId);
		tr.setActionDate(sdf1.format(new Date()));
	}else if(rfaStatus.equalsIgnoreCase("AF")){
		tr.setRfaId(Long.parseLong(rfa));
		tr.setRfaStatus("AC");
		tr.setEmpId(Long.parseLong(EmpId));
		tr.setActionBy(UserId);
		tr.setActionDate(sdf1.format(new Date()));	
	}else if(rfaStatus.equalsIgnoreCase("REV")){
		tr.setRfaId(Long.parseLong(rfa));
		tr.setRfaStatus("AF");
		tr.setEmpId(Long.parseLong(EmpId));
		tr.setActionBy(UserId);
		tr.setActionDate(sdf1.format(new Date()));	
	}else if(rfaStatus.equalsIgnoreCase("RV")){
		tr.setRfaId(Long.parseLong(rfa));
		tr.setRfaStatus("AF");
		tr.setEmpId(Long.parseLong(EmpId));
		tr.setActionBy(UserId);
		tr.setActionDate(sdf1.format(new Date()));	
	}else if(rfaStatus.equalsIgnoreCase("RC")){
		tr.setRfaId(Long.parseLong(rfa));
		tr.setRfaStatus("AF");
		tr.setEmpId(Long.parseLong(EmpId));
		tr.setActionBy(UserId);
		tr.setActionDate(sdf1.format(new Date()));	
	}else if(rfaStatus.equalsIgnoreCase("AC")){
		tr.setRfaId(Long.parseLong(rfa));
		tr.setRfaStatus("AV");
		tr.setEmpId(Long.parseLong(EmpId));
		tr.setActionBy(UserId);
		tr.setActionDate(sdf1.format(new Date()));	
	}else if(rfaStatus.equalsIgnoreCase("AV")){
		tr.setRfaId(Long.parseLong(rfa));
		tr.setRfaStatus("RFA");
		tr.setEmpId(Long.parseLong(EmpId));
		tr.setActionBy(UserId);
		tr.setActionDate(sdf1.format(new Date()));	
	}else if(rfaStatus.equalsIgnoreCase("AE")){
		tr.setRfaId(Long.parseLong(rfa));
		tr.setRfaStatus("AR");
		tr.setEmpId(Long.parseLong(EmpId));
		tr.setActionBy(UserId);
		tr.setActionDate(sdf1.format(new Date()));	
	}else if(rfaStatus.equalsIgnoreCase("AR")){
		tr.setRfaId(Long.parseLong(rfa));
		tr.setRfaStatus("AP");
		tr.setEmpId(Long.parseLong(EmpId));
		tr.setActionBy(UserId);
		tr.setActionDate(sdf1.format(new Date()));	
	}else if(rfaStatus.equalsIgnoreCase("RE")){
		tr.setRfaId(Long.parseLong(rfa));
		tr.setRfaStatus("RFA");
		tr.setEmpId(Long.parseLong(EmpId));
		tr.setActionBy(UserId);
		tr.setActionDate(sdf1.format(new Date()));	
	}else if(rfaStatus.equalsIgnoreCase("RFA")){
		tr.setRfaId(Long.parseLong(rfa));
		tr.setRfaStatus("AR");
		tr.setEmpId(Long.parseLong(EmpId));
		tr.setActionBy(UserId);
		tr.setActionDate(sdf1.format(new Date()));	
	}else if(rfaStatus.equalsIgnoreCase("RR")){
		tr.setRfaId(Long.parseLong(rfa));
		tr.setRfaStatus("RFA");
		tr.setEmpId(Long.parseLong(EmpId));
		tr.setActionBy(UserId);
		tr.setActionDate(sdf1.format(new Date()));	
	}else if(rfaStatus.equalsIgnoreCase("RP")){
		tr.setRfaId(Long.parseLong(rfa));
		tr.setRfaStatus("RFA");
		tr.setEmpId(Long.parseLong(EmpId));
		tr.setActionBy(UserId);
		tr.setActionDate(sdf1.format(new Date()));	
	}else if(rfaStatus.equalsIgnoreCase("AP")){
		tr.setRfaId(Long.parseLong(rfa));
		tr.setRfaStatus("ARC");
		tr.setEmpId(Long.parseLong(EmpId));
		tr.setActionBy(UserId);
		tr.setActionDate(sdf1.format(new Date()));	
	}
	
	List<PfmsNotification> x = new ArrayList<>();
	
	List<String>emps= new ArrayList<>();
	emps = dao.ListEmps(UserId,projectid);
	
	if(userFwd.contains(rfaStatus) ) {
		for(int i=0;i<emps.size();i++) {
			
			PfmsNotification pf = new PfmsNotification();
			pf.setEmpId(Long.parseLong(emps.get(i).toString()));
			pf.setStatus("MAR");
			pf.setNotificationUrl("RfaActionForwardList.htm");
			pf.setNotificationMessage("RFA No"+" "+obj[2]+" "+"Forwarded By"+" "+obj[5]);
			pf.setIsActive(1);
			pf.setNotificationby(Long.parseLong(EmpId));
			pf.setNotificationDate(sdf1.format(new Date()));
			pf.setCreatedBy(UserId);
			pf.setCreatedDate(sdf1.format(new Date()));
			x.add(pf);
		}
	}else if(rfaStatus.equalsIgnoreCase("AF")) {
		
		String EmpTd="";
		if(Logintype.equalsIgnoreCase("D")) {
			EmpTd=dao.GetGhTdList(EmpId) + "";
			
		}else if(Logintype.equalsIgnoreCase("T")) {
			EmpTd=dao.GetDhTdList(EmpId) + "";
			
		}else if (Logintype.equalsIgnoreCase("P")) {
			EmpTd=dao.GetPdTdList(EmpId) + "";
		}
		PfmsNotification pf = new PfmsNotification();
		pf.setEmpId(Long.parseLong(EmpTd));
		pf.setStatus("MAR");
		pf.setNotificationUrl("RfaActionForwardList.htm");
		pf.setNotificationMessage("RFA No"+" "+obj[2]+" "+"Forwarded By"+" "+obj[5]);
		pf.setIsActive(1);
		pf.setNotificationby(Long.parseLong(EmpId));
		pf.setNotificationDate(sdf1.format(new Date()));
		pf.setCreatedBy(UserId);
		pf.setCreatedDate(sdf1.format(new Date()));
		x.add(pf);
	
	}else if(rfaStatus.equalsIgnoreCase("AC")) {
		Object[] assign = dao.RfaActionEdit(rfa);
		
		PfmsNotification pf = new PfmsNotification();
		pf.setEmpId(Long.parseLong(assign[9].toString()));
		pf.setStatus("MAR");
		pf.setNotificationUrl("RfaInspection.htm");
		pf.setNotificationMessage("RFA No"+" "+obj[2]+" "+"Forwarded By"+" "+obj[5]);
		pf.setIsActive(1);
		pf.setNotificationby(Long.parseLong(EmpId));
		pf.setNotificationDate(sdf1.format(new Date()));
		pf.setCreatedBy(UserId);
		pf.setCreatedDate(sdf1.format(new Date()));
		x.add(pf);
	
	}else if(assigneFwd.contains(rfaStatus)) {
		
            for(int i=0;i<emps.size();i++) {
			
			PfmsNotification pf = new PfmsNotification();
			pf.setEmpId(Long.parseLong(emps.get(i).toString()));
			pf.setStatus("MAR");
			pf.setNotificationUrl("RfaInspectionApproval.htm");
			pf.setNotificationMessage("RFA No"+" "+obj[2]+" "+"Forwarded By"+" "+obj[5]);
			pf.setIsActive(1);
			pf.setNotificationby(Long.parseLong(EmpId));
			pf.setNotificationDate(sdf1.format(new Date()));
			pf.setCreatedBy(UserId);
			pf.setCreatedDate(sdf1.format(new Date()));
			x.add(pf);
            }}
		else if(rfaStatus.equalsIgnoreCase("RFA")) {
			String EmpTd="";
			if(Logintype.equalsIgnoreCase("D")) {
				
				EmpTd=dao.GetGhTdList(EmpId) + "";
				
			}else if(Logintype.equalsIgnoreCase("T")) {
				
				EmpTd=dao.GetDhTdList(assineeId) + "";
				
			}else if (Logintype.equalsIgnoreCase("P")) {
				
				EmpTd=dao.GetPdTdList(EmpId) + "";
			}
			
			PfmsNotification pf = new PfmsNotification();
			pf.setEmpId(Long.parseLong(EmpTd));
			pf.setStatus("MAR");
			pf.setNotificationUrl("RfaInspectionApproval.htm");
			pf.setNotificationMessage("RFA No"+" "+obj[2]+" "+"Forwarded By"+" "+obj[5]);
			pf.setIsActive(1);
			pf.setNotificationby(Long.parseLong(EmpId));
			pf.setNotificationDate(sdf1.format(new Date()));
			pf.setCreatedBy(UserId);
			pf.setCreatedDate(sdf1.format(new Date()));
			x.add(pf);
		}else if(rfaStatus.equalsIgnoreCase("AR")) {
            	String empTd=null;
            	empTd=	dao.getUserId(rfa);
			PfmsNotification pf = new PfmsNotification();
			pf.setEmpId(Long.parseLong(empTd));
			pf.setStatus("MAR");
			pf.setNotificationUrl("RfaAction.htm");
			pf.setNotificationMessage("RFA No"+" "+obj[2]+" "+"Approved By"+" "+obj[5]);
			pf.setIsActive(1);
			pf.setNotificationby(Long.parseLong(EmpId));
			pf.setNotificationDate(sdf1.format(new Date()));
			pf.setCreatedBy(UserId);
			pf.setCreatedDate(sdf1.format(new Date()));
			x.add(pf);
		}else if(rfaStatus.equalsIgnoreCase("Ap")) {
		
            for(int i=0;i<emps.size();i++) {
			
			PfmsNotification pf = new PfmsNotification();
			pf.setEmpId(Long.parseLong(emps.get(i).toString()));
			pf.setStatus("MAR");
			pf.setNotificationUrl("RfaInspectionApproval.htm");
			pf.setNotificationMessage("RFA No"+" "+obj[2]+" "+"Forwarded By"+" "+obj[5]);
			pf.setIsActive(1);
			pf.setNotificationby(Long.parseLong(EmpId));
			pf.setNotificationDate(sdf1.format(new Date()));
			pf.setCreatedBy(UserId);
			pf.setCreatedDate(sdf1.format(new Date()));
			x.add(pf);
		}
		
	}else if(rfaStatus.equalsIgnoreCase("AE")) {
		
		String EmpTd="";
		if(Logintype.equalsIgnoreCase("D")) {
			
			EmpTd=dao.GetGhTdList(EmpId) + "";
			
		}else if(Logintype.equalsIgnoreCase("T")) {
			
			EmpTd=dao.GetDhTdList(assineeId) + "";
			
		}else if (Logintype.equalsIgnoreCase("P")) {
			
			EmpTd=dao.GetPdTdList(EmpId) + "";
		}
		
		PfmsNotification pf = new PfmsNotification();
		pf.setEmpId(Long.parseLong(EmpTd));
		pf.setStatus("MAR");
		pf.setNotificationUrl("RfaActionForwardList.htm");
		pf.setNotificationMessage("RFA No"+" "+obj[2]+" "+"Forwarded By"+" "+obj[5]);
		pf.setIsActive(1);
		pf.setNotificationby(Long.parseLong(EmpId));
		pf.setNotificationDate(sdf1.format(new Date()));
		pf.setCreatedBy(UserId);
		pf.setCreatedDate(sdf1.format(new Date()));
		x.add(pf);
	
	}
	
	long count=dao.RfaActionForward(x,rf,tr,rfa);
	
	return count;
}

@Override
public Object[] getRfaAssign(String rfa) throws Exception {
	
	return dao.getRfaAssign(rfa);
}

@Override
public Long RfaModalSubmit(RfaAssign assign) throws Exception {
	
	assign.setCreatedDate(sdf1.format(new Date()));
	
	return dao.RfaModalSubmit(assign);
}

@Override
public Object[] RfaAssignAjax(String rfaId) throws Exception {
	
	return dao.RfaAssignAjax(rfaId);
}

@Override
public Long RfaModalUpdate(RfaAssign assign) throws Exception {
	assign.setModifiedDate(sdf1.format(new Date()));
	return dao.RfaModalUpdate(assign);
}

@Override
public Long RfaReturnList(String rfaStatus,String UserId, String rfa,String EmpId,String createdBy,String replyMsg,String assignorId) throws Exception {
	
    Object[] obj = dao.RfaList(rfa,EmpId);
    List<String> userReturnStatus  = Arrays.asList("AF","AC");
	
	RfaAction rf= new RfaAction();
	
	RfaTransaction tr= new RfaTransaction();
	
	
	if(rfaStatus.equalsIgnoreCase("AC")) {
		rf.setRfaStatus("RC");
	}else if(rfaStatus.equalsIgnoreCase("AV")) {
		rf.setRfaStatus("RV");
	}else if(rfaStatus.equalsIgnoreCase("RFA")) {
		rf.setRfaStatus("RE");
	}else if(rfaStatus.equalsIgnoreCase("AF") && EmpId.equalsIgnoreCase(createdBy)) {
		rf.setRfaStatus("REV");
		tr.setRfaId(Long.parseLong(rfa));
		tr.setRfaStatus("REV");
		tr.setEmpId(Long.parseLong(EmpId));
		tr.setActionBy(UserId);
		tr.setActionDate(sdf1.format(new Date()));
	}else if(rfaStatus.equalsIgnoreCase("AF") && !EmpId.equalsIgnoreCase(createdBy)) {
		rf.setRfaStatus("RC");
		tr.setRfaId(Long.parseLong(rfa));
		tr.setRfaStatus("RC");
		tr.setEmpId(Long.parseLong(EmpId));
		tr.setActionBy(UserId);
		tr.setActionDate(sdf1.format(new Date()));
		tr.setRemarks(replyMsg);
	}
	if(rfaStatus.equalsIgnoreCase("AC")) {
		rf.setRfaStatus("RV");
		tr.setRfaId(Long.parseLong(rfa));
		tr.setRfaStatus("RV");
		tr.setEmpId(Long.parseLong(EmpId));
		tr.setActionBy(UserId);
		tr.setActionDate(sdf1.format(new Date()));
		tr.setRemarks(replyMsg);
	}if(rfaStatus.equalsIgnoreCase("AR")) {
		rf.setRfaStatus("RP");
		tr.setRfaId(Long.parseLong(rfa));
		tr.setRfaStatus("RP");
		tr.setEmpId(Long.parseLong(EmpId));
		tr.setActionBy(UserId);
		tr.setActionDate(sdf1.format(new Date()));
		tr.setRemarks(replyMsg);
	}if(rfaStatus.equalsIgnoreCase("RFA")&& !EmpId.equalsIgnoreCase(createdBy)) {
		rf.setRfaStatus("RR");
		tr.setRfaId(Long.parseLong(rfa));
		tr.setRfaStatus("RR");
		tr.setEmpId(Long.parseLong(EmpId));
		tr.setActionBy(UserId);
		tr.setActionDate(sdf1.format(new Date()));
		tr.setRemarks(replyMsg);
	}else if(rfaStatus.equalsIgnoreCase("AV")){
		tr.setRfaId(Long.parseLong(rfa));
		tr.setRfaStatus("RV");
		tr.setEmpId(Long.parseLong(EmpId));
		tr.setActionBy(UserId);
		tr.setActionDate(sdf1.format(new Date()));	
	}else if(rfaStatus.equalsIgnoreCase("RFA")&& EmpId.equalsIgnoreCase(createdBy)){
		
		tr.setRfaId(Long.parseLong(rfa));
		tr.setRfaStatus("RE");
		tr.setEmpId(Long.parseLong(EmpId));
		tr.setActionBy(UserId);
		tr.setActionDate(sdf1.format(new Date()));	
	}
	List<PfmsNotification> x = new ArrayList<>();
	String empTd="";
	if(userReturnStatus.contains(rfaStatus) && !EmpId.equalsIgnoreCase(createdBy)) {
	
	
	empTd=	dao.getUserId(rfa);
	PfmsNotification pf = new PfmsNotification();
	pf.setEmpId(Long.parseLong(empTd));
	pf.setStatus("MAR");
	pf.setNotificationUrl("RfaAction.htm");
	pf.setNotificationMessage("RFA No"+" "+obj[2]+" "+"Returned By"+" "+obj[5]);
	pf.setIsActive(1);
	pf.setNotificationby(Long.parseLong(EmpId));
	pf.setNotificationDate(sdf1.format(new Date()));
	pf.setCreatedBy(UserId);
	pf.setCreatedDate(sdf1.format(new Date()));
	x.add(pf);
	
	}else {
		if(!EmpId.equalsIgnoreCase(createdBy)) {
		empTd=	dao.getAssineeId(rfa);
		PfmsNotification pf = new PfmsNotification();
		pf.setEmpId(Long.parseLong(empTd));
		pf.setStatus("MAR");
		pf.setNotificationUrl("RfaInspection.htm");
		pf.setNotificationMessage("RFA No"+" "+obj[2]+" "+"Returned By"+" "+obj[5]);
		pf.setIsActive(1);
		pf.setNotificationby(Long.parseLong(EmpId));
		pf.setNotificationDate(sdf1.format(new Date()));
		pf.setCreatedBy(UserId);
		pf.setCreatedDate(sdf1.format(new Date()));
		x.add(pf);
	}}
    long count=dao.RfaReturnList(x,rf,tr,rfa);
	
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
public String getAssineeId(String rfa) throws Exception {
	return dao.getAssineId(rfa);
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
}

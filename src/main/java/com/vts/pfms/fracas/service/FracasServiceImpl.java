package com.vts.pfms.fracas.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.util.Date;
import java.util.List;

import org.apache.commons.io.FilenameUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.vts.pfms.FormatConverter;
import com.vts.pfms.committee.model.CommitteeMinutesAttachment;
import com.vts.pfms.committee.model.PfmsNotification;
import com.vts.pfms.fracas.dao.FracasDaoImpl;
import com.vts.pfms.fracas.dto.PfmsFracasAssignDto;
import com.vts.pfms.fracas.dto.PfmsFracasMainDto;
import com.vts.pfms.fracas.dto.PfmsFracasSubDto;
import com.vts.pfms.fracas.model.PfmsFracasAssign;
import com.vts.pfms.fracas.model.PfmsFracasAttach;
import com.vts.pfms.fracas.model.PfmsFracasMain;
import com.vts.pfms.fracas.model.PfmsFracasSub;

@Service
public class FracasServiceImpl implements FracasService {
	
	@Autowired FracasDaoImpl dao;
	FormatConverter fc=new FormatConverter();
	private SimpleDateFormat sdf1= fc.getSqlDateAndTimeFormat();  //new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private  SimpleDateFormat sdf= fc.getRegularDateFormat();     //new SimpleDateFormat("dd-MM-yyyy");
//	private  SimpleDateFormat sdf2=	fc.getDateMonthShortName();   //new SimpleDateFormat("dd-MMM-yyyy");
//	private SimpleDateFormat sdf3=	fc.getSqlDateFormat();			//	new SimpleDateFormat("yyyy-MM-dd");
	private static final Logger logger=LogManager.getLogger(FracasServiceImpl.class);
	
	@Value("${ApplicationFilesDrive}")
	String uploadpath;
	
	@Override
	public List<Object[]> ProjectsList(String empid,String Logintype, String LabCode) throws Exception
	{
		return dao.ProjectsList( empid, Logintype,  LabCode);
	}
	
	
	@Override
	public List<Object[]> EmployeeList(String LabCode) throws Exception 
	{
		return dao.EmployeeList(LabCode);
	}
	
	
	@Override
	public List<Object[]> FracasTypeList() throws Exception
	{
		return dao.FracasTypeList();
	}
	@Override
	public List<Object[]> ProjectFracasItemsList(String projectid,String LabCode) throws Exception
	{
		return dao.ProjectFracasItemsList(projectid, LabCode);
	}
	
	
	
	@Override
	public long FracasMainAddSubmit(PfmsFracasMainDto dto) throws Exception
	{
		logger.info(new Date() +"Inside DAO FracasMainAddSubmit ");		
		
		String LabCode= dto.getLabCode();
		Timestamp instant= Timestamp.from(Instant.now());
		String timestampstr = instant.toString().replace(" ","").replace(":", "").replace("-", "").replace(".","");
		
		String Path = LabCode+"\\FracasData\\";
		PfmsFracasMain model=new PfmsFracasMain();
		model.setFracasTypeId(Integer.parseInt(dto.getFracasTypeId()));
		model.setFracasItem(dto.getFracasItem());
		model.setFracasDate(sdf1.format(sdf.parse(dto.getFracasDate())));
		model.setProjectId(Long.parseLong(dto.getProjectId()));		
		model.setCreatedBy(dto.getCreatedBy());
		model.setCreatedDate(sdf1.format(new Date()));
		model.setIsActive(1);
		model.setLabCode(dto.getLabCode());
		long mainid=dao.FracasMainAddSubmit(model);
		
		if(!dto.getFracasMainAttach().isEmpty()) 
		{
			
			PfmsFracasAttach attach=new PfmsFracasAttach();
			attach.setFracasMainId(mainid);
			attach.setFilePath(Path);
			attach.setAttachName("Fracas"+timestampstr+"."+FilenameUtils.getExtension(dto.getFracasMainAttach().getOriginalFilename()));
			saveFile(uploadpath+Path, attach.getAttachName(), dto.getFracasMainAttach());
			attach.setFracasSubId(0);
			attach.setCreatedBy(dto.getCreatedBy());
			attach.setCreatedDate(sdf1.format(new Date()));			
			dao.FracasAttachAdd(attach);
		}	
		
		return mainid;
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
	public PfmsFracasAttach FracasAttachDownload(String fracasattachid) throws Exception
	{
		return dao.FracasAttachDownload(fracasattachid);
		
	}
	
	@Override
	public Object[] FracasItemData(String fracasmainid) throws Exception
	{
		return dao.FracasItemData(fracasmainid);
	}
	
	@Override
	public long FracasAssignSubmit(PfmsFracasAssignDto dto) throws Exception
	{
		logger.info(new Date() +"Inside DAO FracasAssignSubmit ");
		long subid=0;
		String[] asignee=dto.getAssignee();
		for(int i=0;i<asignee.length;i++)
		{
			subid=0;
			long temp=0;
			String fracasno="";
			Object[] fracasdata=dao.FracasItemData(dto.getFracasMainId());			
			Object[] labdata=dao.LabDetails();
			
			fracasno=fracasno+labdata[1];
			
			if(Long.parseLong(fracasdata[4].toString())==0) {
				fracasno=fracasno+"/GEN";
			}else {
				Object[] projectdata=dao.ProjectsData(fracasdata[4].toString());
				fracasno=fracasno+"/"+projectdata[1];
			}
			
			long assigncount=Long.parseLong(dao.FracasMainAssignCount(dto.getFracasMainId())[0].toString())+1;
			fracasno=fracasno+"/Item-"+dto.getFracasMainId()+"/"+assigncount;
			//fracasno=fracasno+"/"+assigncount;
					
			
			PfmsFracasAssign assign=new PfmsFracasAssign();
			assign.setFracasMainId(Long.parseLong(dto.getFracasMainId()));
			assign.setFracasAssignNo(fracasno);
			assign.setRemarks(dto.getRemarks());
			assign.setPDC(new java.sql.Date(sdf.parse(dto.getPDC()).getTime()));
			assign.setAssigner(Long.parseLong(dto.getAssigner()));
			assign.setAssignee(Long.parseLong(asignee[i]));
			assign.setAssignedDate(sdf1.format(new Date()));
			assign.setFracasStatus("A");
			assign.setCreatedBy(dto.getCreatedBy());
			assign.setCreatedDate(sdf1.format(new Date()));
			assign.setIsActive(1);
			subid=dao.FracasAssignSubmit(assign);
			
			
			
			if(subid>0) {
				PfmsNotification notification= new PfmsNotification();
				notification.setEmpId(assign.getAssignee());
				notification.setNotificationby(assign.getAssigner());
				notification.setNotificationDate(sdf1.format(new Date()));
				notification.setNotificationMessage("Action Pending For FRACAS Item "+fracasno+" Assigned on"+sdf1.format(new Date()));
				notification.setNotificationUrl("FracasAssigneeList.htm");
				notification.setCreatedBy(assign.getCreatedBy());
				notification.setCreatedDate(sdf1.format(new Date()));
				notification.setIsActive(1);
				notification.setScheduleId(temp);
				notification.setStatus("MAR");
				dao.FRACASNotificationInsert(notification);
			}
		}
		
		return subid;
	}
	
	@Override
	public List<Object[]> FracasAssignedList(String assignerempid,String fracasmainid) throws Exception
	{
		return dao.FracasAssignedList(assignerempid, fracasmainid);
	}
	
	@Override
	public List<Object[]> FracasAssigneeList(String assigneeid) throws Exception
	{
		return dao.FracasAssigneeList(assigneeid);
	}
	
	@Override
	public Object[] FracasAssignData(String fracasassignid) throws Exception
	{
		return dao.FracasAssignData(fracasassignid);
	}
	

	@Override
	public long FracasSubSubmit(PfmsFracasSubDto dto) throws Exception
	{
		logger.info(new Date() +"Inside DAO FracasSubSubmit ");
		String LabCode= dto.getLabCode();
		Timestamp instant= Timestamp.from(Instant.now());
		String timestampstr = instant.toString().replace(" ","").replace(":", "").replace("-", "").replace(".","");
		
		String Path = LabCode+"\\FracasData\\";
		PfmsFracasSub model=new PfmsFracasSub();
		model.setFracasAssignId(Long.parseLong(dto.getFracasAssignId()));
		model.setProgress(Integer.parseInt(dto.getProgress()));
		model.setProgressDate(sdf1.format(sdf.parse(dto.getProgressDate())));
		model.setRemarks(dto.getRemarks());
		model.setCreatedBy(dto.getCreatedBy());
		model.setCreatedDate(sdf1.format(new Date()));
		long subid=0;
		
		subid=dao.FracasSubSubmit(model);
		
		if(!dto.getAttachment().isEmpty() && subid!=0) 
		{
				
				PfmsFracasAttach attach=new PfmsFracasAttach();
				attach.setFracasMainId(0);
				attach.setFilePath(Path);
				attach.setAttachName("Fracas"+timestampstr+"."+FilenameUtils.getExtension(dto.getAttachment().getOriginalFilename()));
				saveFile(uploadpath+Path, attach.getAttachName(), dto.getAttachment());
				attach.setFracasSubId(subid);
				attach.setCreatedBy(dto.getCreatedBy());
				attach.setCreatedDate(sdf1.format(new Date()));			
				dao.FracasAttachAdd(attach);
		}
		return subid;
	}
	
	@Override
	public List<Object[]> FracasSubList(String fracasassignid) throws Exception
	{
		return dao.FracasSubList(fracasassignid);
	}
	
	
	@Override
	public int FracasAssignForwardUpdate(PfmsFracasAssignDto dto) throws Exception
	{
		dto.setModifiedDate(sdf1.format(new Date()));
		int ret= dao.FracasAssignForwardUpdate(dto);
		long temp=0;
		if(ret>0 && (dto.getFracasStatus().equalsIgnoreCase("F") || dto.getFracasStatus().equalsIgnoreCase("B")) ) {
			Object[] assigndata=dao.FracasAssignData(dto.getFracasAssignId());
			PfmsNotification notification= new PfmsNotification();
			if(dto.getFracasStatus().equalsIgnoreCase("F")) {
				notification.setEmpId(Long.parseLong(assigndata[4].toString()));
				notification.setNotificationby(Long.parseLong(assigndata[5].toString()));
				notification.setNotificationMessage("Review Pending For FRACAS Item "+assigndata[13]+" Forwarded on"+sdf1.format(new Date()));
				notification.setNotificationUrl("FracasToReviewList.htm");
			}
			else if(dto.getFracasStatus().equalsIgnoreCase("B"))
			{
				notification.setEmpId(Long.parseLong(assigndata[5].toString()));
				notification.setNotificationby(Long.parseLong(assigndata[4].toString()));
				notification.setNotificationMessage("Action Pending For FRACAS Item "+assigndata[13]+" Sent Back on"+sdf1.format(new Date()));
				notification.setNotificationUrl("FracasAssigneeList.htm");
			}
			notification.setNotificationDate(sdf1.format(new Date()));
			notification.setCreatedBy(dto.getModifiedBy());
			notification.setCreatedDate(sdf1.format(new Date()));
			notification.setIsActive(1);
			notification.setScheduleId(temp);
			notification.setStatus("MAR");
			dao.FRACASNotificationInsert(notification);
			
		}
		
		return ret;
	}
	
	@Override
	public List<Object[]> FracasToReviewList(String assignerempid) throws Exception
	{
		return dao.FracasToReviewList(assignerempid);
	}
	
	@Override
	public int FracasSubDelete(String fracassubid,String fracasattachid) throws Exception
	{
		logger.info(new Date() +"Inside DAO FracasSubDelete ");
		int ret=0;
		ret=dao.FracasSubDelete(fracassubid);
		if(ret>0 && fracasattachid!=null)
		{
			PfmsFracasAttach attachment = dao.FracasAttachDownload(fracasattachid);
			if(attachment!=null) {
				String filepath = uploadpath+attachment.getFilePath()+attachment.getAttachName();
				File file = new File(filepath);
				file.delete();
			}		
			ret=dao.FracasAttachDelete(fracasattachid);
		}
		return ret;
	}
		
	@Override
	public int FracasMainDelete(PfmsFracasMainDto dto) throws Exception
	{
		dto.setModifiedDate(sdf1.format(new Date()));
		return dao.FracasMainDelete(dto);
	}
	
	@Override
	public int FracasMainEdit(PfmsFracasMainDto dto) throws Exception
	{
		logger.info(new Date() +"Inside DAO FracasMainEdit ");
		
		String LabCode= dto.getLabCode();
		Timestamp instant= Timestamp.from(Instant.now());
		String timestampstr = instant.toString().replace(" ","").replace(":", "").replace("-", "").replace(".","");
		
		String Path = LabCode+"\\FracasData\\";
		dto.setModifiedDate(sdf1.format(new Date()));
		dto.setFracasDate(sdf1.format(sdf.parse(dto.getFracasDate())));
		int ret=dao.FracasMainEdit(dto);
		if(!dto.getFracasMainAttach().isEmpty() && ret >0) 
		{
			if(dto.getFracasMainAttachId()!=null) {
				PfmsFracasAttach attachment = dao.FracasAttachDownload(dto.getFracasMainAttachId());
				String filepath = uploadpath+attachment.getFilePath()+attachment.getAttachName();
				File file = new File(filepath);
				if(file.exists()) {	file.delete(); }
				dao.FracasAttachDelete(dto.getFracasMainAttachId());
			}
			
			PfmsFracasAttach attach=new PfmsFracasAttach();
			attach.setFracasMainId(Long.parseLong(dto.getFracasMainId()));
			attach.setAttachName("Fracas"+timestampstr+"."+FilenameUtils.getExtension(dto.getFracasMainAttach().getOriginalFilename()));
			attach.setFilePath(Path);
			saveFile(uploadpath+Path, attach.getAttachName(), dto.getFracasMainAttach());
			attach.setFracasSubId(0);
			attach.setCreatedBy(dto.getModifiedBy());
			attach.setCreatedDate(sdf1.format(new Date()));			
			dao.FracasAttachAdd(attach);
		}
		
		return ret;
	}
	
	@Override
	public List<Object[]> LoginProjectDetailsList(String empid,String Logintype,String LabCode)throws Exception
	{
		return dao.LoginProjectDetailsList(empid,Logintype,LabCode);
	}
		
}

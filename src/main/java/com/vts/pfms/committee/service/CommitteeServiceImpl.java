package com.vts.pfms.committee.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigInteger;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.Instant;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Random;
import java.util.stream.Collectors;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.vts.pfms.FormatConverter;
import com.vts.pfms.committee.dao.CommitteeDao;
import com.vts.pfms.committee.dto.CommitteeConstitutionApprovalDto;
import com.vts.pfms.committee.dto.CommitteeDto;
import com.vts.pfms.committee.dto.CommitteeInvitationDto;
import com.vts.pfms.committee.dto.CommitteeMainDto;
import com.vts.pfms.committee.dto.CommitteeMembersDto;
import com.vts.pfms.committee.dto.CommitteeMembersEditDto;
import com.vts.pfms.committee.dto.CommitteeMinutesAttachmentDto;
import com.vts.pfms.committee.dto.CommitteeMinutesDetailsDto;
import com.vts.pfms.committee.dto.CommitteeScheduleAgendaDto;
import com.vts.pfms.committee.dto.CommitteeScheduleDto;
import com.vts.pfms.committee.dto.CommitteeSubScheduleDto;
import com.vts.pfms.committee.dto.EmpAccessCheckDto;
import com.vts.pfms.committee.model.Committee;
import com.vts.pfms.committee.model.CommitteeConstitutionApproval;
import com.vts.pfms.committee.model.CommitteeConstitutionHistory;
import com.vts.pfms.committee.model.CommitteeDefaultAgenda;
import com.vts.pfms.committee.model.CommitteeDivision;
import com.vts.pfms.committee.model.CommitteeInitiation;
import com.vts.pfms.committee.model.CommitteeInvitation;
import com.vts.pfms.committee.model.CommitteeMain;
import com.vts.pfms.committee.model.CommitteeMeetingApproval;
import com.vts.pfms.committee.model.CommitteeMeetingDPFMFrozen;
import com.vts.pfms.committee.model.CommitteeMember;
import com.vts.pfms.committee.model.CommitteeMemberRep;
import com.vts.pfms.committee.model.CommitteeMinutesAttachment;
import com.vts.pfms.committee.model.CommitteeProject;
import com.vts.pfms.committee.model.CommitteeSchedule;
import com.vts.pfms.committee.model.CommitteeScheduleAgenda;
import com.vts.pfms.committee.model.CommitteeScheduleAgendaDocs;
import com.vts.pfms.committee.model.CommitteeScheduleMinutesDetails;
import com.vts.pfms.committee.model.CommitteeSubSchedule;
import com.vts.pfms.committee.model.PfmsNotification;
import com.vts.pfms.master.dto.ProjectFinancialDetails;
import com.vts.pfms.model.LabMaster;
import com.vts.pfms.print.model.MinutesFinanceList;

@Service
public class CommitteeServiceImpl implements CommitteeService{

	@Autowired CommitteeDao dao;
	
	@Autowired 	private JavaMailSender javaMailSender;
	
	@Autowired	BCryptPasswordEncoder encoder;

	FormatConverter fc=new FormatConverter();
	private SimpleDateFormat sdf1= fc.getSqlDateAndTimeFormat();  //new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private  SimpleDateFormat sdf= fc.getRegularDateFormat();     //new SimpleDateFormat("dd-MM-yyyy");
	private  SimpleDateFormat sdf2=	fc.getDateMonthShortName();   //new SimpleDateFormat("dd-MMM-yyyy");
	private SimpleDateFormat sdf3=	fc.getSqlDateFormat();			//	new SimpleDateFormat("yyyy-MM-dd");
	private static final Logger logger=LogManager.getLogger(CommitteeServiceImpl.class);
	
	@Value("${ApplicationFilesDrive}")
	String uploadpath;
	
	@Override
	public long CommitteeAdd(CommitteeDto committeeDto) throws Exception
	{
		logger.info(new Date() +"Inside CommitteeAdd ");	
		long count=0;
		String name=committeeDto.getCommitteeName(); 
		String sname=committeeDto.getCommitteeShortName();
		List<Object[]> CommitteeNamesCheck=dao.CommitteeNamesCheck(name,sname,committeeDto.getIsGlobal(),committeeDto.getLabCode());
		
		if(CommitteeNamesCheck.get(0)[1]!=null || CommitteeNamesCheck.get(0)[0]!=null)
		{
			if(Long.parseLong(CommitteeNamesCheck.get(0)[1].toString())>0)
			{
				return -2;
			} 
			if(Long.parseLong(CommitteeNamesCheck.get(0)[0].toString())>0)
			{
				return -1;
			}			
		}
		
		Committee committeeModel=new Committee();
		
		committeeModel.setLabCode(committeeDto.getLabCode());
		committeeModel.setCommitteeName(name);
		committeeModel.setCommitteeShortName(sname);
		committeeModel.setCommitteeType(committeeDto.getCommitteeType());
		committeeModel.setProjectApplicable(committeeDto.getProjectApplicable());
		
		committeeModel.setTechNonTech(committeeDto.getTechNonTech());
		committeeModel.setPeriodicNon(committeeDto.getPeriodicNon());
		committeeModel.setPeriodicDuration(Integer.parseInt(committeeDto.getPeriodicDuration()));
		committeeModel.setGuidelines(committeeDto.getGuidelines());
		committeeModel.setDescription(committeeDto.getDescription());
		committeeModel.setTermsOfReference(committeeDto.getTermsOfReference());
		committeeModel.setIsGlobal(Long.parseLong(committeeDto.getIsGlobal()));
		committeeModel.setCreatedBy(committeeDto.getCreatedBy());
		committeeModel.setCreatedDate(sdf1.format(new Date()));
		committeeModel.setIsActive(1);
		
		count = dao.CommitteeNewAdd(committeeModel);
		
		return count;
		
	}
	
	@Override
	public Object[]CommitteeNamesCheck(String name,String sname, String projectid,String LabCode) throws Exception
	{
		logger.info(new Date() +"Inside CommitteeNamesCheck ");	
		return dao.CommitteeNamesCheck(name,sname,projectid,LabCode).get(0);
	}
		
		
	
	@Override
	public List<Object[]> CommitteeListActive(String isglobal,String Projectapplicable, String LabCode) throws Exception
	{
		logger.info(new Date() +"Inside CommitteeListActive ");	
		return dao.CommitteeListActive(isglobal,Projectapplicable,LabCode); 
	}
	
	@Override
	public Object[] CommitteeDetails(String committeeid) throws Exception
	{
		logger.info(new Date() +"Inside CommitteeDetails ");	
		return dao.CommitteeDetails(committeeid);
	}
	
	@Override
	public long CommitteeEditSubmit(CommitteeDto committeeDto) throws Exception
	{
		logger.info(new Date() +"Inside CommitteeEditSubmit ");	
		String name=committeeDto.getCommitteeName(); 
		String sname=committeeDto.getCommitteeShortName();
		
		
		long committeeid=committeeDto.getCommitteeId();
		String shortname=committeeDto.getCommitteeShortName();
		String fullname=committeeDto.getCommitteeName();
		List<Object[]> CommitteeList=(List<Object[]>)dao.CommitteeListActive(committeeDto.getIsGlobal(),committeeDto.getProjectApplicable(),committeeDto.getLabCode());
		for(int i=0;i<CommitteeList.size();i++)
		{
			if(Long.parseLong(CommitteeList.get(i)[0].toString())!=committeeid)
			{
				if(CommitteeList.get(i)[1].toString().equals(shortname))
				{
					return -1;
				}
				if(CommitteeList.get(i)[2].toString().equals(fullname))
				{
					return -2;
				}
			}
		}
		
		Committee committeemodel=new Committee();
		
		committeemodel.setCommitteeId(committeeid);
		committeemodel.setCommitteeName(name);
		committeemodel.setCommitteeShortName(sname);
		committeemodel.setCommitteeType(committeeDto.getCommitteeType());
		committeemodel.setProjectApplicable(committeeDto.getProjectApplicable());
		
		committeemodel.setTechNonTech(committeeDto.getTechNonTech());
		committeemodel.setPeriodicNon(committeeDto.getPeriodicNon());
		committeemodel.setPeriodicDuration(Integer.parseInt(committeeDto.getPeriodicDuration()));
		committeemodel.setGuidelines(committeeDto.getGuidelines());
		committeemodel.setDescription(committeeDto.getDescription());
		committeemodel.setTermsOfReference(committeeDto.getTermsOfReference());
		committeemodel.setIsGlobal(Long.parseLong(committeeDto.getIsGlobal()));
		committeemodel.setModifiedBy(committeeDto.getModifiedBy());
		committeemodel.setModifiedDate(sdf1.format(new Date()));
		
		return dao.CommitteeEditSubmit(committeemodel);	
	}	
	
	
	@Override
	public List<Object[]> EmployeeList(String LabCode) throws Exception {
		return dao.EmployeeList(LabCode);
	}
	
	@Override
	public Object[] CommitteeName(String CommitteeId) throws Exception {
		return dao.CommitteeName(CommitteeId);
	}


	@Override
	public long CommitteeDetailsSubmit(CommitteeMainDto committeemaindto) throws Exception 
	{
		logger.info(new Date() +"Inside CommitteeDetailsSubmit ");
		CommitteeMain committeemain= new CommitteeMain();
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
		LocalDate fromDate = LocalDate.parse(committeemaindto.getValidFrom(), formatter);
		LocalDate toDate=fromDate.plusYears(5).minusDays(1);
		
		committeemain.setValidFrom(java.sql.Date.valueOf(fromDate));
		committeemain.setValidTo(java.sql.Date.valueOf(toDate));
		committeemain.setCreatedBy(committeemaindto.getCreatedBy());
		committeemain.setCreatedDate(sdf1.format(new Date()));
		committeemain.setCommitteeId(Long.parseLong(committeemaindto.getCommitteeId()));
		committeemain.setProjectId(Long.parseLong(committeemaindto.getProjectId()));
		committeemain.setInitiationId(Long.parseLong(committeemaindto.getInitiationId()));
		committeemain.setDivisionId(Long.parseLong(committeemaindto.getDivisionId()));
		committeemain.setPreApproved(committeemaindto.getPreApproved());
		if(committeemaindto.getPreApproved().equalsIgnoreCase("N")) {
			committeemain.setStatus("P");
			committeemain.setIsActive(0);
		}else if(committeemaindto.getPreApproved().equalsIgnoreCase("Y"))
		{
			committeemain.setStatus("A");
			committeemain.setIsActive(1);
		}
		if( committeemaindto.getPreApproved().equalsIgnoreCase("Y")) {
			long lastcommitteeid=dao.LastCommitteeId(committeemaindto.getCommitteeId(),committeemaindto.getProjectId(),committeemaindto.getDivisionId(),committeemaindto.getInitiationId());		
			if(lastcommitteeid!=0 )
			{
				CommitteeMain committeemain1= new CommitteeMain();
				
				committeemain1.setModifiedBy(committeemaindto.getCreatedBy());
				committeemain1.setModifiedDate(sdf1.format(new Date()));
				committeemain1.setValidTo(java.sql.Date.valueOf(fromDate.minusDays(1).toString()));
				committeemain1.setCommitteeMainId(lastcommitteeid);
					
				dao.UpdateCommitteemainValidto(committeemain1);
			}		
		}
		long mainid= dao.CommitteeDetailsSubmit(committeemain);		
		
		for(int i=1;i<=4;i++) 
		{
			CommitteeMember committeemember = new CommitteeMember(); 
			committeemember.setCommitteeMainId(mainid);
			if(i==1) 
			{
				committeemember.setEmpId(Long.parseLong(committeemaindto.getChairperson()));
				committeemember.setLabCode(committeemaindto.getCpLabCode());
				committeemember.setMemberType("CC");
			}
			else if(i==2)
				{
				if( Long.parseLong(committeemaindto.getCo_Chairperson())>0) 
				{
					committeemember.setEmpId(Long.parseLong(committeemaindto.getCo_Chairperson()));
					committeemember.setLabCode(committeemaindto.getLabCode());
					committeemember.setMemberType("CH");
				}
				else 
				{
					continue;
				}
			}
			else if(i==3)
			{
				committeemember.setEmpId(Long.parseLong(committeemaindto.getSecretary()));
				committeemember.setLabCode(committeemaindto.getMsLabCode());
				committeemember.setMemberType("CS");
			}
			else if(i==4)
			{
				if( Long.parseLong(committeemaindto.getProxySecretary())>0) 
				{
					committeemember.setEmpId(Long.parseLong(committeemaindto.getProxySecretary()) );
					committeemember.setLabCode(committeemaindto.getLabCode());
					committeemember.setMemberType("PS");
				}
				else 
				{
					continue;
				}
			}
			committeemember.setCreatedBy(committeemaindto.getCreatedBy());			
			committeemember.setCreatedDate(sdf1.format(new Date()));
			committeemember.setIsActive(1);
			dao.CommitteeMainMembersAdd(committeemember);
		}		
		
		String[] reps=committeemaindto.getReps();
		if(mainid>0 && reps!=null) {
					
			for(int i=0;i<reps.length;i++ ) 
			{
				CommitteeMemberRep repmems=new CommitteeMemberRep();
				repmems.setCommitteeMainId(mainid);
				repmems.setRepId(Integer.parseInt(reps[i]));
				repmems.setCreatedBy(committeemaindto.getCreatedBy());
				repmems.setCreatedDate(sdf1.format(new Date()));
				repmems.setIsActive(1);			
				dao.CommitteeRepMembersSubmit(repmems);
			}
		}
		
		if(committeemaindto.getPreApproved().equalsIgnoreCase("N"))
		{
			CommitteeConstitutionApproval approval=new CommitteeConstitutionApproval();
			approval.setCommitteeMainId(mainid);
			approval.setConstitutionStatus("CCR");
	//		approval.setRemarks(dto.getRemarks());
			approval.setActionBy(committeemaindto.getCreatedBy());
			approval.setActionDate(sdf1.format(new Date()));
			approval.setEmpid(Long.parseLong(committeemaindto.getCreatedByEmpid()));
			approval.setEmpLabid(Long.parseLong(committeemaindto.getCreatedByEmpidLabid()));
			approval.setConstitutedBy(Long.parseLong(committeemaindto.getCreatedByEmpid()));
			approval.setApprovalAuthority("0");
			dao.CommitteeConstitutionApprovalAdd(approval);
		}
		return mainid;
	}

	@Override
	public Long LastCommitteeId(String CommitteeId,String projectid,String divisionid,String initiationid) throws Exception {
		return dao.LastCommitteeId(CommitteeId, projectid, divisionid,initiationid );
	}
	
	@Override
	public List<Object[]> CommitteeMainList(String labcode) throws Exception {
		return dao.CommitteeMainList(labcode);
	}
	
	@Override
	public List<Object[]> CommitteeNonProjectList() throws Exception 
	{
		return dao.CommitteeNonProjectList();
	}


	
	@Override
	public List<Object[]> EmployeeListWithoutMembers(String committeemainid, String LabCode) throws Exception
	{
		logger.info(new Date() +"Inside SERVICE EmployeeListWithoutMembers ");
		List<Object[]> employeelist= dao.EmployeeListWithoutMembers(committeemainid,LabCode);
		return employeelist;
	}
	
	@Override
	public int CommitteeMemberDelete(String committeememberid, String modifiedby)throws Exception
	{
		logger.info(new Date() +"Inside SERVICE CommitteeMemberDelete ");
		CommitteeMember committeemember=new CommitteeMember();
		committeemember.setCommitteeMemberId(Long.parseLong(committeememberid));
		committeemember.setModifiedBy(modifiedby);
		committeemember.setModifiedDate(sdf1.format(new Date()));
		
		return dao.CommitteeMemberDelete(committeemember);
	}
	
	@Override
	public long CommitteeMainMembersAddSubmit(String committeemainid, String[] Member,String userid) throws Exception
	{
		logger.info(new Date() +"Inside SERVICE CommitteeMainMembersAddSubmit ");
		long count=0;
		for(int i=0;i< Member.length;i++)
		{
			CommitteeMember  committeemember=new CommitteeMember();
			committeemember.setCommitteeMainId(Long.parseLong(committeemainid));
			committeemember.setCreatedBy(userid);
			committeemember.setCreatedDate(sdf1.format(new Date()));
			committeemember.setEmpId(Long.parseLong(Member[i]));
			committeemember.setIsActive(1);
			count=dao.CommitteeMainMembersAdd(committeemember);
		}
		return count;
	}
	
	@Override
	public List<Object[]> EmployeeListNoMembers(String labid, String committeemainid) throws Exception
	{
		logger.info(new Date() +"Inside SERVICE EmployeeListNoMembers ");
		List<Object[]> employeelist= dao.ChairpersonEmployeeList( labid, committeemainid);	
		return employeelist;
	}

	@Override
	public long CommitteeScheduleAddSubmit(CommitteeScheduleDto committeescheduledto)throws Exception
	{
		logger.info(new Date() +"Inside SERVICE CommitteeScheduleAddSubmit ");
		CommitteeSchedule committeeschedule = new  CommitteeSchedule(); 
		
		committeeschedule.setLabCode(committeescheduledto.getLabCode());	
		committeeschedule.setCommitteeId(committeescheduledto.getCommitteeId());
		committeeschedule.setProjectId(Long.parseLong(committeescheduledto.getProjectId()));
		committeeschedule.setCreatedBy(committeescheduledto.getCreatedBy());
		committeeschedule.setScheduleStartTime(committeescheduledto.getScheduleStartTime());
		committeeschedule.setScheduleDate(new java.sql.Date(sdf.parse(committeescheduledto.getScheduleDate()).getTime()));
		committeeschedule.setCreatedDate(sdf1.format(new Date()));
		committeeschedule.setScheduleSub("N");		
		committeeschedule.setIsActive(1);
		committeeschedule.setScheduleFlag(committeescheduledto.getScheduleFlag());
		committeeschedule.setConfidential(Integer.parseInt(committeescheduledto.getConfidential()));
		committeeschedule.setDivisionId(Long.parseLong(committeescheduledto.getDivisionId()));
		committeeschedule.setInitiationId(Long.parseLong(committeescheduledto.getInitiationId()));
		
		String CommitteeName=dao.CommitteeName(committeescheduledto.getCommitteeId().toString())[2].toString();
		String LabName=dao.LabDetails(committeeschedule.getLabCode())[1].toString();
		BigInteger SerialNo=dao.MeetingCount(new java.sql.Date(sdf.parse(committeescheduledto.getScheduleDate()).getTime()),committeescheduledto.getProjectId());
		String ProjectName=null;
		if(Long.parseLong(committeescheduledto.getProjectId())>0) 
		{
			ProjectName=dao.projectdetails(committeescheduledto.getProjectId())[4].toString();
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
		committeeschedule.setMeetingId(LabName.trim()+"/"+ProjectName.trim()+"/"+CommitteeName.trim()+"/"+sdf2.format(ScheduledDate).toString().toUpperCase().replace("-", "")+"/"+SerialNo.add(new BigInteger("1")));
		return dao.CommitteeScheduleAddSubmit(committeeschedule);
	}
	
	@Override
	public List<Object[]> CommitteeScheduleListNonProject(String committeeid)throws Exception
	{
		return dao.CommitteeScheduleListNonProject(committeeid);
	}

	@Override
	public Object[] CommitteeScheduleEditData(String CommitteeScheduleId) throws Exception {

		return dao.CommitteeScheduleEditData(CommitteeScheduleId);
	}
	
	@Override
	public List<Object[]> AgendaReturnData(String CommitteeScheduleId) throws Exception {

		return dao.AgendaReturnData(CommitteeScheduleId);
	}

	@Override
	public List<Object[]> ProjectList(String LabCode) throws Exception {
		
		return dao.ProjectList(LabCode);
	}
	
	@Override
	public Long CommitteeAgendaSubmit(List<CommitteeScheduleAgendaDto> scheduleagendadtos) throws Exception {

		logger.info(new Date() +"Inside SERVICE CommitteeAgendaSubmit ");
		long ret=0;
		
		String committeescheduleid=scheduleagendadtos.get(0).getScheduleId();
		
		Iterator<CommitteeScheduleAgendaDto> iterator = scheduleagendadtos.iterator();
		
		while(iterator.hasNext()) 
		{
			CommitteeScheduleAgendaDto AgendaDto = iterator.next();
			CommitteeScheduleAgenda scheduleagenda=new CommitteeScheduleAgenda();
//			CommitteeSchedulesAttachment attachment = new CommitteeSchedulesAttachment();
			scheduleagenda.setPresentorLabCode(AgendaDto.getPresentorLabCode());
			scheduleagenda.setScheduleId(Long.parseLong(AgendaDto.getScheduleId()));
			scheduleagenda.setScheduleSubId(Long.parseLong(AgendaDto.getScheduleSubId()));
			scheduleagenda.setAgendaItem(AgendaDto.getAgendaItem());
			scheduleagenda.setPresenterId(Long.parseLong(AgendaDto.getPresenterId()));
			scheduleagenda.setDuration(Integer.parseInt(AgendaDto.getDuration()));
			scheduleagenda.setProjectId(Long.parseLong(AgendaDto.getProjectId()));
			scheduleagenda.setRemarks(AgendaDto.getRemarks());
			scheduleagenda.setCreatedBy(AgendaDto.getCreatedBy());
			scheduleagenda.setCreatedDate(sdf1.format(new Date()));
			scheduleagenda.setIsActive(Integer.parseInt(AgendaDto.getIsActive()));
//			if(AgendaDto.getDocId()!=null) {
//				scheduleagenda.setDocId(Long.parseLong(AgendaDto.getDocId()));
//			}else
//			{
//				scheduleagenda.setDocId(0);
//			}			

			List<Object[]> agendapriority=dao.CommitteeScheduleAgendaPriority(committeescheduleid);
			
			
			if(agendapriority.size()==0)
			{
				scheduleagenda.setAgendaPriority(1);
			}
			else if((Integer)agendapriority.get(0)[2]==0)
			{
				scheduleagenda.setAgendaPriority(1);
			}else {
				scheduleagenda.setAgendaPriority(((Integer)agendapriority.get(0)[2])+1);	
			}
			
			ret= dao.CommitteeAgendaSubmit(scheduleagenda);
			
			if(AgendaDto.getDocLinkIds()!=null) 
			{
				List<String> docids = Arrays.asList(AgendaDto.getDocLinkIds());
				List<String> existingdocids = new ArrayList<String>();
				for(int j=0; j<docids.size();j++) {
					System.out.println(!existingdocids.contains(docids.get(j)));
					if(!existingdocids.contains(docids.get(j))) 
					{
						CommitteeScheduleAgendaDocs doc= new CommitteeScheduleAgendaDocs();
						doc.setAgendaId(ret);
						doc.setFileDocId(Long.parseLong(docids.get(j)));
						doc.setIsActive(1);
						doc.setCreatedBy(AgendaDto.getCreatedBy());
						doc.setCreatedDate(sdf1.format(new Date()));
						dao.AgendaDocLinkAdd(doc);
						existingdocids.add(String.valueOf(docids.get(j)));
					}
				}
			}
		
		}
		return ret;
	}


	@Override
	public Long CommitteeScheduleAgendaEdit(CommitteeScheduleAgendaDto scheduleagendadto,String attachmentid) throws Exception
	{
		logger.info(new Date() +"Inside SERVICE CommitteeScheduleAgendaEdit ");
		CommitteeScheduleAgenda scheduleagenda=new CommitteeScheduleAgenda();
//		CommitteeSchedulesAttachment attachment = new CommitteeSchedulesAttachment();
		
		scheduleagenda.setScheduleAgendaId(Long.parseLong(scheduleagendadto.getScheduleAgendaId()));
		scheduleagenda.setAgendaItem(scheduleagendadto.getAgendaItem());
		scheduleagenda.setProjectId(Long.parseLong(scheduleagendadto.getProjectId()));
		scheduleagenda.setRemarks(scheduleagendadto.getRemarks());
		scheduleagenda.setModifiedBy(scheduleagendadto.getModifiedBy());
		scheduleagenda.setModifiedDate(sdf1.format(new Date()));
		scheduleagenda.setPresentorLabCode(scheduleagendadto.getPresentorLabCode());
		scheduleagenda.setPresenterId(Long.parseLong(scheduleagendadto.getPresenterId()));
		scheduleagenda.setDuration(Integer.parseInt(scheduleagendadto.getDuration()));
		
//		if(scheduleagendadto.getDocId()!=null) {
//			scheduleagenda.setDocId(Long.parseLong(scheduleagendadto.getDocId()));
//		}else
//		{
//			scheduleagenda.setDocId(0);
//		}		
		
		if(scheduleagendadto.getDocLinkIds()!=null) {
			List<String> docids = Arrays.asList(scheduleagendadto.getDocLinkIds());
			List<String> existingdocids = dao.AgendaAddedDocLinkIdList(scheduleagendadto.getScheduleAgendaId()) ;
			for(int j=0; j<docids.size();j++) {
				if(!existingdocids.contains(docids.get(j)) && !docids.get(j).equalsIgnoreCase("")) 
				{
					CommitteeScheduleAgendaDocs doc= new CommitteeScheduleAgendaDocs();
					doc.setAgendaId(Long.parseLong(scheduleagendadto.getScheduleAgendaId()));
					doc.setFileDocId(Long.parseLong(docids.get(j)));
					doc.setIsActive(1);
					doc.setCreatedBy(scheduleagendadto.getCreatedBy());
					doc.setCreatedDate(sdf1.format(new Date()));
					dao.AgendaDocLinkAdd(doc);
					existingdocids.add(docids.get(j));
				}
			}
		}
		
		
		long ret=0;
		ret=dao.CommitteeScheduleAgendaUpdate(scheduleagenda);
		
//		if(scheduleagendadto.getAgendaAttachment().length!=0 && attachmentid.equals("null"))
//		{
//			attachment.setScheduleAgendaId(Long.parseLong(scheduleagendadto.getScheduleAgendaId()));
//			attachment.setAgendaAttachment(scheduleagendadto.getAgendaAttachment());
//			attachment.setModifiedBy(scheduleagendadto.getCreatedBy());
//			attachment.setModifiedDate(sdf1.format(new Date()));
//			attachment.setAttachmentName(scheduleagendadto.getAttachmentName());
//			
//			ret=dao.CommitteeAgendaAttachment(attachment);
//		}
//		else if(scheduleagendadto.getAgendaAttachment().length!=0 && !attachmentid.equals("null")) 
//		{		
//			attachment.setAgendaAttachment(scheduleagendadto.getAgendaAttachment());
//			attachment.setAttachmentName(scheduleagendadto.getAttachmentName());
//			attachment.setModifiedBy(scheduleagendadto.getModifiedBy());
//			attachment.setModifiedDate(sdf1.format(new Date()));
//			attachment.setScheduleAttachmentId(Long.parseLong(attachmentid));
//			ret=0;
//			ret=dao.CommitteeScheduleAgendaAttachUpdate(attachment);
//		}
		
		return ret;
	}


	@Override
	public Long CommitteeAgendaPriorityUpdate(String[] agendaid,String[] priority) throws Exception
	{
		logger.info(new Date() +"Inside SERVICE CommitteeAgendaPriorityUpdate ");
			long ret=0;
			for(int i=0;i<agendaid.length;i++)
			{
				dao.CommitteeAgendaPriorityUpdate(agendaid[i],priority[i]);
			}
			return ret;
	
	}

	@Override
	public int CommitteeAgendaDelete(String committeescheduleagendaid, String attachmentid,String Modifiedby, String  scheduleid,String AgendaPriority) throws Exception
	{
		logger.info(new Date() +"Inside SERVICE CommitteeAgendaDelete ");
		List<Object[]> agendaslistafter=dao.CommitteeScheduleGetAgendasAfter(scheduleid,AgendaPriority);
		
		if(agendaslistafter.size()!=0) 
		{
			for(Object[] obj : agendaslistafter )
			{
				
				dao.CommitteeAgendaPriorityUpdate(obj[0].toString(),String.valueOf((Integer)obj[1]-1));
				
			}
		}
		
		
		dao.AgendaDocUnlink(committeescheduleagendaid, Modifiedby, sdf1.format(new Date()));
		
//		if(!attachmentid.equals("null")) 
//		{
//			dao.CommitteeAgendaAttachmentDelete(attachmentid);
//		}
		
		return dao.CommitteeAgendaDelete(committeescheduleagendaid,Modifiedby,sdf1.format(new Date()));
		
	}

//	@Override
//	public List<Object[]> CommitteeAgendaList1(String CommitteeScheduleId) throws Exception 
//	{
//		logger.info(new Date() +"Inside CommitteeAgendaList");
//		return dao.CommitteeAgendaList(CommitteeScheduleId);
//	}
	
	@Override
	public List<Object[]> AgendaList(String CommitteeScheduleId) throws Exception 
	{		
		return dao.AgendaList(CommitteeScheduleId);
	}

//	@Override
//	public CommitteeSchedulesAttachment CommitteeAgendaAttachDownload(String CommitteeAttachmentId) throws Exception {
//
//		logger.info(new Date() +"Inside CommitteeAgendaAttachDownload");
//		return dao.CommitteeAgendaAttachDownload(CommitteeAttachmentId);
//	}

	@Override 
	public Long CommitteeScheduleUpdate(CommitteeScheduleDto committeescheduledto) throws Exception {

		logger.info(new Date() +"Inside SERVICE CommitteeScheduleUpdate ");
		String meetingid = dao.CommitteeScheduleData(committeescheduledto.getScheduleId().toString())[12].toString();
		CommitteeSchedule committeeschedule=new  CommitteeSchedule();
		committeeschedule.setScheduleDate(new java.sql.Date(sdf.parse(committeescheduledto.getScheduleDate()).getTime()));
		committeeschedule.setScheduleStartTime(committeescheduledto.getScheduleStartTime());
		committeeschedule.setScheduleId(committeescheduledto.getScheduleId());
		committeeschedule.setModifiedBy(committeescheduledto.getCreatedBy());
		committeeschedule.setModifiedDate(sdf1.format(new Date()));
		
		String[] strarr=meetingid.split("/");
		meetingid=strarr[0].toString().trim() +"/"+strarr[1].toString().trim() +"/"+strarr[2].toString().trim() +"/"+sdf2.format(committeeschedule.getScheduleDate()).toString().toUpperCase().replace("-", "")+"/"+strarr[4].toString().trim() ;
		committeeschedule.setMeetingId(meetingid);
		return dao.CommitteeScheduleUpdate(committeeschedule);
	}

	@Override
	public List<Object[]> CommitteeMinutesSpecList(String CommitteeScheduleId) throws Exception {

		return dao.CommitteeMinutesSpecList(CommitteeScheduleId);
	}

	@Override
	public Long CommitteeMinutesInsert(CommitteeMinutesDetailsDto committeeminutesdetailsdto) throws Exception {

		logger.info(new Date() +"Inside SERVICE CommitteeMinutesInsert ");
		CommitteeScheduleMinutesDetails committeeminutesdetails = new CommitteeScheduleMinutesDetails();
		committeeminutesdetails.setScheduleId(Long.parseLong(committeeminutesdetailsdto.getScheduleId()));
		committeeminutesdetails.setScheduleSubId(Long.parseLong(committeeminutesdetailsdto.getScheduleSubId()));
		committeeminutesdetails.setMinutesId(Long.parseLong(committeeminutesdetailsdto.getMinutesId()));
		committeeminutesdetails.setMinutesSubId(Long.parseLong(committeeminutesdetailsdto.getMinutesSubId()));
		committeeminutesdetails.setMinutesSubOfSubId(Long.parseLong(committeeminutesdetailsdto.getMinutesSubOfSubId()));
		committeeminutesdetails.setDetails(committeeminutesdetailsdto.getDetails());
		committeeminutesdetails.setIDARCK(committeeminutesdetailsdto.getIDARCK());
		committeeminutesdetails.setCreatedBy(committeeminutesdetailsdto.getCreatedBy());
		committeeminutesdetails.setCreatedDate(sdf1.format(new Date()));
		committeeminutesdetails.setAgendaSubHead(committeeminutesdetailsdto.getAgendaSubHead());
		
		if(committeeminutesdetailsdto.getRemarks()=="" ) {
			
			committeeminutesdetails.setRemarks("Nil");
			
		}else {
			
			committeeminutesdetails.setRemarks(committeeminutesdetailsdto.getRemarks());
		}
		
		

		return dao.CommitteeMinutesInsert(committeeminutesdetails);
	}

	@Override
	public Object[] CommitteeMinutesSpecDesc(CommitteeMinutesDetailsDto committeeminutesdetailsdto) throws Exception {

		logger.info(new Date() +"Inside SERVICE CommitteeMinutesSpecDesc ");
		CommitteeScheduleMinutesDetails committeeminutesdetails = new CommitteeScheduleMinutesDetails();
		
		committeeminutesdetails.setMinutesId(Long.parseLong(committeeminutesdetailsdto.getMinutesId()));
		committeeminutesdetails.setMinutesSubId(Long.parseLong(committeeminutesdetailsdto.getMinutesSubId()));
		committeeminutesdetails.setMinutesSubOfSubId(Long.parseLong(committeeminutesdetailsdto.getMinutesSubOfSubId()));

		return dao.CommitteeMinutesSpecDesc(committeeminutesdetails);
	}
	
	@Override
	public Object[] CommitteeMinutesSpecEdit(CommitteeMinutesDetailsDto committeeminutesdetailsdto) throws Exception {

		logger.info(new Date() +"Inside SERVICE CommitteeMinutesSpecEdit ");
		CommitteeScheduleMinutesDetails committeeminutesdetails = new CommitteeScheduleMinutesDetails();
		committeeminutesdetails.setScheduleMinutesId(Long.parseLong(committeeminutesdetailsdto.getScheduleMinutesId()));
		
		return dao.CommitteeMinutesSpecEdit(committeeminutesdetails);
	}
	
	@Override
	public Long CommitteeMinutesUpdate(CommitteeMinutesDetailsDto committeeminutesdetailsdto) throws Exception {

		logger.info(new Date() +"Inside SERVICE CommitteeMinutesUpdate ");
		CommitteeScheduleMinutesDetails committeeminutesdetails = new CommitteeScheduleMinutesDetails();
		committeeminutesdetails.setScheduleId(Long.parseLong(committeeminutesdetailsdto.getScheduleId()));
		committeeminutesdetails.setScheduleSubId(Long.parseLong(committeeminutesdetailsdto.getScheduleSubId()));
		committeeminutesdetails.setMinutesId(Long.parseLong(committeeminutesdetailsdto.getMinutesId()));
		committeeminutesdetails.setDetails(committeeminutesdetailsdto.getDetails());
		committeeminutesdetails.setIDARCK(committeeminutesdetailsdto.getIDARCK());
		committeeminutesdetails.setModifiedBy(committeeminutesdetailsdto.getModifiedBy());
		committeeminutesdetails.setModifiedDate(sdf1.format(new Date()));
		committeeminutesdetails.setScheduleMinutesId(Long.parseLong(committeeminutesdetailsdto.getScheduleMinutesId()));
		committeeminutesdetails.setRemarks(committeeminutesdetailsdto.getRemarks());

		return dao.CommitteeMinutesUpdate(committeeminutesdetails);
	}
	
	
	@Override
	public long CommitteeSubScheduleSubmit(CommitteeSubScheduleDto committeesubscheduledto) throws Exception 
	{
		logger.info(new Date() +"Inside SERVICE CommitteeSubScheduleSubmit ");
		CommitteeSubSchedule committeesubschedule=new CommitteeSubSchedule();
		committeesubschedule.setScheduleId(Long.parseLong(committeesubscheduledto.getScheduleId()));
		committeesubschedule.setScheduleDate(new java.sql.Date(sdf.parse(committeesubscheduledto.getScheduleDate()).getTime()));
		committeesubschedule.setScheduleStartTime(committeesubscheduledto.getScheduleStartTime());
		committeesubschedule.setCreatedBy(committeesubscheduledto.getCreatedBy());
		committeesubschedule.setCreatedDate(sdf1.format(new Date()));
		committeesubschedule.setScheduleFlag("N");
		committeesubschedule.setIsActive(1);		
		
		return dao.CommitteeSubScheduleSubmit(committeesubschedule);
	}
	
	@Override
	public List<Object[]> CommitteeSubScheduleList(String scheduleid) throws Exception
	{
		return dao.CommitteeSubScheduleList(scheduleid);
	}


	@Override
	public List<Object[]> CommitteeScheduleMinutes(String scheduleid) throws Exception
	{
		return dao.CommitteeScheduleMinutes(scheduleid);
	}



	@Override
	public List<Object[]> CommitteeMinutesSpecdetails()throws Exception
	{
		return dao.CommitteeMinutesSpecdetails();
	}

	@Override
	public List<Object[]> CommitteeMinutesSub()throws Exception
	{
		return dao.CommitteeMinutesSub();
	}

	@Override
	public List<Object[]> CommitteeAttendance(String CommitteeScheduleId) throws Exception {

		return dao.CommitteeAttendance(CommitteeScheduleId);
	}

	
	@Override
	public int MeetingAgendaApproval(String CommitteeScheduleId, String UserId, String EmpId,String Option ) throws Exception 
	{

		logger.info(new Date() +"Inside SERVICE MeetingAgendaApproval ");
		CommitteeMeetingApproval approval=new CommitteeMeetingApproval();
		CommitteeSchedule schedule= new CommitteeSchedule();
		
		
		List<PfmsNotification> notifications=new ArrayList<PfmsNotification>();
		String Status=null;
		if(Option.equalsIgnoreCase("Agenda Approval")) {
			Status="MAF";
		}else {
			Status="MAS";
		}
		
		approval.setScheduleId(Long.parseLong(CommitteeScheduleId));
		approval.setEmpId(Long.parseLong(EmpId));
		approval.setMeetingStatus(Status);
		approval.setActionBy(UserId);
		approval.setActionDate(sdf1.format(new Date()));
		
		schedule.setScheduleId(Long.parseLong(CommitteeScheduleId));
		schedule.setScheduleFlag("MAF");
		schedule.setModifiedBy(UserId);
		schedule.setModifiedDate(sdf1.format(new Date()));
		
		
		Object[] CommitteMainMembersData=dao.CommitteMainMembersData(CommitteeScheduleId,"CC");
		if(CommitteMainMembersData!=null && CommitteMainMembersData.length > 0)
		{
			PfmsNotification cpnotification= new PfmsNotification();
			cpnotification.setEmpId(Long.parseLong(CommitteMainMembersData[0].toString()));
			cpnotification.setNotificationby(Long.parseLong(EmpId));
			cpnotification.setNotificationDate(sdf1.format(new Date()));
			cpnotification.setNotificationMessage("Agenda Pending Approval For " + CommitteMainMembersData[2].toString() );
			cpnotification.setNotificationUrl("MeetingApprovalAgenda.htm");
			cpnotification.setCreatedBy(UserId);
			cpnotification.setCreatedDate(sdf1.format(new Date()));
			cpnotification.setIsActive(1);
			cpnotification.setScheduleId(Long.parseLong(CommitteeScheduleId));
			cpnotification.setStatus(Status);				
			notifications.add(cpnotification);
		}	
		CommitteMainMembersData=dao.CommitteMainMembersData(CommitteeScheduleId,"CS");
		if(CommitteMainMembersData!=null && CommitteMainMembersData.length>0)
		{
			PfmsNotification msnotification= new PfmsNotification();			
			msnotification.setEmpId(Long.parseLong(CommitteMainMembersData[0].toString()));
			msnotification.setNotificationby(Long.parseLong(EmpId));
			msnotification.setNotificationDate(sdf1.format(new Date()));
			msnotification.setNotificationMessage("Agenda Pending Approval For " + CommitteMainMembersData[2].toString() );
			msnotification.setNotificationUrl("MeetingApprovalAgenda.htm");
			msnotification.setCreatedBy(UserId);
			msnotification.setCreatedDate(sdf1.format(new Date()));
			msnotification.setIsActive(1);
			msnotification.setScheduleId(Long.parseLong(CommitteeScheduleId));
			msnotification.setStatus(Status);			
			notifications.add(msnotification);		
		}
		
		CommitteMainMembersData=dao.CommitteMainMembersData(CommitteeScheduleId,"PS");
		if(CommitteMainMembersData!=null && CommitteMainMembersData.length>0 )
		{
			PfmsNotification psnotification= new PfmsNotification();
			psnotification.setEmpId(Long.parseLong(CommitteMainMembersData[0].toString()));
			psnotification.setNotificationby(Long.parseLong(EmpId));
			psnotification.setNotificationDate(sdf1.format(new Date()));
			psnotification.setNotificationMessage("Agenda Pending Approval For " + CommitteMainMembersData[2].toString() );
			psnotification.setNotificationUrl("MeetingApprovalAgenda.htm");
			psnotification.setCreatedBy(UserId);
			psnotification.setCreatedDate(sdf1.format(new Date()));
			psnotification.setIsActive(1);
			psnotification.setScheduleId(Long.parseLong(CommitteeScheduleId));
			psnotification.setStatus(Status);			
			notifications.add(psnotification);		
		}
		
		return dao.MeetingAgendaApproval(approval,schedule,notifications);
	}

	@Override
	public List<Object[]> MeetingApprovalAgendaList(String EmpId) throws Exception 
	{
		return dao.MeetingApprovalAgendaList(EmpId);
	}
	

	@Override
	public int MeetingAgendaApprovalSubmit(String ScheduleId, String Remarks, String UserId, String EmpId,String Option) throws Exception {

		logger.info(new Date() +"Inside SERVICE MeetingAgendaApprovalSubmit ");
		CommitteeSchedule schedule= new CommitteeSchedule();
		CommitteeMeetingApproval approval = new CommitteeMeetingApproval();
		PfmsNotification notification=new PfmsNotification();
		
		schedule.setScheduleId(Long.parseLong(ScheduleId));
		schedule.setModifiedBy(UserId);
		schedule.setModifiedDate(sdf1.format(new Date()));
		
		approval.setScheduleId(Long.parseLong(ScheduleId));
		approval.setEmpId(Long.parseLong(EmpId));
		approval.setRemarks(Remarks);
		approval.setActionBy(UserId);
		approval.setActionDate(sdf1.format(new Date()));
		
		
		Object[] CommitteeScheduleData=dao.CommitteeScheduleData(ScheduleId);
		
		Object[] NotificationData=dao.NotificationData(ScheduleId,EmpId,"MAF");
		if(NotificationData!=null) {
			notification.setEmpId(Long.parseLong(NotificationData[1].toString()));
		}else {
			notification.setEmpId(Long.parseLong("0"));
		}
		notification.setNotificationby(Long.parseLong(EmpId));
		notification.setNotificationDate(sdf1.format(new Date()));
		notification.setScheduleId(Long.parseLong(ScheduleId));
		notification.setCreatedBy(UserId);
		notification.setCreatedDate(sdf1.format(new Date()));
		notification.setIsActive(1);
		notification.setNotificationUrl("CommitteeScheduleView.htm?scheduleid="+Long.parseLong(ScheduleId));
		
		if(Option.equalsIgnoreCase("approve")) {
			schedule.setScheduleFlag("MAA");
			approval.setMeetingStatus("MAA");
			notification.setNotificationMessage("Agenda Approved for " + CommitteeScheduleData[8].toString());
			notification.setStatus("MAA");
		}
		if(Option.equalsIgnoreCase("return")) {
			schedule.setScheduleFlag("MAR");
			approval.setMeetingStatus("MAR");
			notification.setNotificationMessage("Agenda Returned for " + CommitteeScheduleData[8].toString());
			notification.setStatus("MAR");
		}
		
		return dao.MeetingAgendaApprovalSubmit(schedule,approval,notification);
	}
	
	
	
	@Override
	public Object[] CommitteeScheduleData(String committeescheduleid) throws Exception
	{
		return dao.CommitteeScheduleData(committeescheduleid);
	}
	
	@Override
	public Object[] CommitteeScheduleDataPro(String committeescheduleid, String projectid) throws Exception
	{
		return dao.CommitteeScheduleDataPro(committeescheduleid, projectid);
	}


	@Override
	public List<Object[]> CommitteeAtendance(String committeescheduleid) throws Exception
	{
		return dao.CommitteeAtendance(committeescheduleid);
	}
	
	
	@Override
	public List<Object[]> EmployeeListNoInvitedMembers(String scheduleid,String LabCode) throws Exception
	{
		return dao.EmployeeListNoInvitedMembers(scheduleid,LabCode);
	}
	
	@Override
	public List<Object[]> ExternalMembersNotInvited(String scheduleid) throws Exception
	{
		return dao.ExternalMembersNotInvited(scheduleid);
	}
	
	@Override
	public List<Object[]> ExternalMembersNotAddedCommittee(String committeemainid) throws Exception
	{
		return dao.ExternalMembersNotAddedCommittee(committeemainid);		
	}
	
	@Override
	public Long CommitteeInvitationCreate(CommitteeInvitationDto committeeinvitationdto) throws Exception 
	{
		logger.info(new Date() +"Inside SERVICE CommitteeInvitationCreate ");
		long ret=0;
		long slno=1;
		Object[] maxslno=dao.InvitationMaxSerialNo(committeeinvitationdto.getCommitteeScheduleId());
		if(maxslno[1]!=null && Long.parseLong(maxslno[1].toString())>0) 
		{
			slno=Long.parseLong(maxslno[1].toString())+1;
		}
	
		for(int i=0;i<committeeinvitationdto.getEmpIdList().size();i++) 
		{
			
			CommitteeInvitation committeeinvitation= new CommitteeInvitation();
			
			String MemberType[]=committeeinvitationdto.getEmpIdList().get(i).split(",");
			committeeinvitation.setCommitteeScheduleId(Long.parseLong(committeeinvitationdto.getCommitteeScheduleId()));
			
			committeeinvitation.setCreatedBy(committeeinvitationdto.getCreatedBy());
			committeeinvitation.setAttendance("P");
			committeeinvitation.setCreatedDate(sdf1.format(new Date()));
			committeeinvitation.setEmpId(Long.parseLong(MemberType[0]));
			if(committeeinvitationdto.getReptype()!= null && !committeeinvitationdto.getReptype().equals("0")) 
			{
				committeeinvitation.setMemberType(committeeinvitationdto.getReptype());
			}
			else 
			{
				committeeinvitation.setMemberType(MemberType[1]);
			}
			committeeinvitation.setDesigId(MemberType[2]);
			
			if(!committeeinvitationdto.getLabCodeList().isEmpty()) {
				committeeinvitation.setLabCode(committeeinvitationdto.getLabCodeList().get(i));
			}
			
			// Check weather this employee is already invited as committee member 
			if(dao.CommitteeInvitationCheck(committeeinvitation).size()>0)
			{
				continue;
			}
			else
			{
				committeeinvitation.setSerialNo(slno);
				
				slno++;
				ret=dao.CommitteeInvitationCreate(committeeinvitation);
			}
			
		}
		
		return ret; 
	}

	@Override
	public Long CommitteeInvitationDelete(String committeeinvitationid) throws Exception
	{
		logger.info(new Date() +"Inside SERVICE CommitteeInvitationDelete ");
		
		
			List<Object[]> serialnoafter=dao.CommitteeInvitationSerialNoAfter(committeeinvitationid);
			for(Object[] obj : serialnoafter)
			{
				dao.CommitteeInvitationSerialNoUpdate(obj[0].toString(), Long.parseLong(obj[1].toString())-1 );
			}
			
		long count=dao.CommitteeInvitationDelete(committeeinvitationid);
		return count;
	}


	@Override
	public Long CommitteeAttendanceToggle(String InvitationId) throws Exception {

		logger.info(new Date() +"Inside SERVICE CommitteeAttendanceToggle ");
		List<String> AttendanceList=dao.CommitteeAttendanceList(InvitationId);
		
		String Value=null;
		
		for(int i=0; i<AttendanceList.size();i++ ) {
			 Value=AttendanceList.get(i);	
		}
		
		long ret=dao.CommitteeAttendanceUpdate(InvitationId,Value);
			
		return ret;
	}



	@Override
	public Long ScheduleMinutesUnitUpdate(CommitteeMinutesDetailsDto detailsdto) throws Exception {
		
		logger.info(new Date() +"Inside SERVICE ScheduleMinutesUnitUpdate ");
		CommitteeScheduleMinutesDetails minutesdetails = new CommitteeScheduleMinutesDetails();
		minutesdetails.setScheduleId(Long.parseLong(detailsdto.getScheduleId()));
		minutesdetails.setScheduleSubId(1);
		minutesdetails.setMinutesId(Long.parseLong(detailsdto.getMinutesId()));
		minutesdetails.setMinutesSubId(Long.parseLong(detailsdto.getMinutesSubId()));
		minutesdetails.setMinutesSubOfSubId(Long.parseLong(detailsdto.getMinutesSubOfSubId()));
		minutesdetails.setCreatedBy(detailsdto.getCreatedBy());
		minutesdetails.setCreatedDate(sdf1.format(new Date()));
		
		return dao.ScheduleMinutesUnitUpdate(minutesdetails);
	}

	@Override
	public List<Object[]> MinutesUnitList(String CommitteeScheudleId) throws Exception {

		return dao.MinutesUnitList(CommitteeScheudleId);
	}
	
	@Override
	public List<Object[]> CommitteeAgendaPresenter(String scheduleid) throws Exception
	{
		return dao.CommitteeAgendaPresenter(scheduleid);
	}
	
	@Override
	public List<Object[]> PresenterRemovalEmpList(List<Object[]> Employeelist, List<Object[]> PresenterList) throws Exception
	{
		logger.info(new Date() +"Inside SERVICE PresenterRemovalEmpList ");
		for(int i=0;i<Employeelist.size();i++)
		{
			for(int j=0;j<PresenterList.size();j++)
			{
				if(Employeelist.get(i)[0].toString().equals(PresenterList.get(j)[0].toString()))
				{
					Employeelist.remove(i);						
				}
			}
		}
		return Employeelist;
	}

	
	
	
	@Override 
	public List<Object[]> LoginProjectDetailsList(String empid,String Logintype ,String LabCode) throws Exception
	{
		logger.info(new Date() +"Inside SERVICE LoginProjectDetailsList "); 
		List<Object[]> projectidlist=(ArrayList<Object[]>) dao.LoginProjectDetailsList(empid,Logintype,LabCode);  
		return projectidlist;
	}
	

	
	@Override
	public Object[] projectdetails(String projectid) throws Exception
	{
		return dao.projectdetails(projectid);
	}
	
	@Override
	public List<Object[]> ProjectScheduleListAll(String projectid) throws Exception
	{
		return dao.ProjectScheduleListAll(projectid);
	}
	@Override
	public List<Object[]> ProjectApplicableCommitteeList(String projectid)throws Exception
	{
		return dao.ProjectApplicableCommitteeList(projectid);
	}
	@Override
	public  int UpdateComitteeMainid(String committeemainid, String scheduleid ) throws Exception
	{
		return dao.UpdateComitteeMainid(committeemainid, scheduleid);
	}
	@Override
	public List<Object[]> ProjectCommitteeScheduleListAll(String projectid,String committeeid) throws Exception
	{
		return dao.ProjectCommitteeScheduleListAll(projectid, committeeid);
	}
	
	@Override
	public  List<Object[]> ChaipersonEmailId(String CommitteeMainId) throws Exception {

		return dao.ChaipersonEmailId(CommitteeMainId);
	}
	
	@Override
	public Object[] ProjectDirectorEmail(String ProjectId) throws Exception {

		return dao.ProjectDirectorEmail(ProjectId);
	}
	
	@Override
	public Object[] RtmddoEmail() throws Exception {

		return dao.RtmddoEmail();
	}

	@Override
	public String UpdateOtp(CommitteeScheduleDto committeescheduledto) throws Exception {

		logger.info(new Date() +"Inside SERVICE UpdateOtp ");
		CommitteeSchedule schedule=new CommitteeSchedule();
		schedule.setKickOffOtp(committeescheduledto.getKickOffOtp());
		schedule.setScheduleId(committeescheduledto.getScheduleId());
		schedule.setScheduleFlag(committeescheduledto.getScheduleFlag());
		
		return dao.UpdateOtp(schedule);

	}

	@Override
	public String KickOffOtp(String CommitteeScheduleId) throws Exception {

		return dao.KickOffOtp(CommitteeScheduleId);
	}

	

	@Override
	public List<Object[]> UserSchedulesList(String EmpId,String MeetingId) throws Exception {

		return dao.UserSchedulesList(EmpId,"%"+MeetingId+"%");
	}
	
	@Override
	public List<Object[]> MeetingSearchList(String MeetingId ,String LabCode) throws Exception {

		return dao.MeetingSearchList("%"+MeetingId+"%" ,LabCode);

	}

	@Override
	public long ProjectCommitteeAdd(String ProjectId, String[] Committee, String UserId) throws Exception {

		logger.info(new Date() +"Inside SERVICE ProjectCommitteeAdd ");
		long count=0;
		for(int i=0;i<Committee.length;i++) {
			Object[] committeedata=dao.CommitteeDetails(Committee[i]);
			CommitteeProject committeeproject=new CommitteeProject();
			committeeproject.setProjectId(Long.parseLong(ProjectId));
			committeeproject.setCommitteeId(Long.parseLong(Committee[i]));
			committeeproject.setCreatedBy(UserId);
			committeeproject.setCreatedDate(sdf1.format(new Date()));
			committeeproject.setDescription(committeedata[10].toString());
			committeeproject.setTermsOfReference(committeedata[11].toString());
			count=dao.ProjectCommitteeAdd(committeeproject);
		}
				
		return count;
	}
	
	
	@Override
	public long InitiationCommitteeAdd(String initiation, String[] Committee, String UserId) throws Exception {

		logger.info(new Date() +"Inside SERVICE InitiationCommitteeAdd ");
		long count=0;
		for(int i=0;i<Committee.length;i++) {
			Object[] committeedata=dao.CommitteeDetails(Committee[i]);
			CommitteeInitiation model=new CommitteeInitiation(); 
			model.setInitiationId(Long.parseLong(initiation));
			model.setCommitteeId(Long.parseLong(Committee[i]));
			model.setAutoSchedule("N");
			model.setCreatedBy(UserId);
			model.setCreatedDate(sdf1.format(new Date()));
			model.setDescription(committeedata[10].toString());
			model.setTermsOfReference(committeedata[11].toString());
			count=dao.InitiationCommitteeAdd(model);
		}
				
		return count;
	}


	@Override
	public List<Object[]> ProjectMasterList(String ProjectId) throws Exception {

		return dao.ProjectMasterList(ProjectId);
	}

	@Override
	public long ProjectCommitteeDelete( String[] CommitteeProject,String user) throws Exception {

		logger.info(new Date() +"Inside SERVICE ProjectCommitteeDelete ");
		long count=0;
		for(int i=0;i<CommitteeProject.length;i++) {
			CommitteeProject committeeproject=new CommitteeProject();
			committeeproject.setCommitteeProjectId(Long.parseLong(CommitteeProject[i]));		
			count=dao.ProjectCommitteeDelete(committeeproject);
		}				
		return count;
		
	}
	
	@Override
	public Object[] LabDetails(String LabCode)throws Exception
	{
		return dao.LabDetails(LabCode);
	}



	@Override
	public List<Object[]> ProjectCommitteesListNotAdded(String projectid,String LabCode) throws Exception {
		return dao.ProjectCommitteesListNotAdded(projectid, LabCode);		
	}



	@Override
	public List<Object[]> CommitteeAutoScheduleList(String ProjectId,String divisionid,String initiationid,String projectstatus) throws Exception {

		return dao.CommitteeAutoScheduleList(ProjectId,divisionid,initiationid,projectstatus);
	}
	
	@Override
	public List<Object[]> CommitteeAutoScheduleList(String ProjectId,String committeeid, String divisionid , String initiationid,String projectstatus) throws Exception 
	{
		return dao.CommitteeAutoScheduleList(ProjectId, committeeid,divisionid,initiationid,projectstatus);
	}
	
	@Override
	public Object[] CommitteeLastScheduleDate(String committeeid) throws Exception 
	{
		return dao.CommitteeLastScheduleDate(committeeid);
	}

	@Override
	public int CommitteeProjectUpdate(String ProjectId, String CommitteeId) throws Exception {

		return dao.CommitteeProjectUpdate(ProjectId,CommitteeId);
	}


	@Override
	public int UpdateMeetingVenue(CommitteeScheduleDto csdto) throws Exception
	{
		return dao.UpdateMeetingVenue(csdto);
	}

	@Override
	public long MinutesAttachmentAdd(CommitteeMinutesAttachmentDto dto) throws Exception 
	{
		logger.info(new Date() +"Inside SERVICE MinutesAttachmentAdd ");
		
		String LabCode= dto.getLabCode();
		Timestamp instant= Timestamp.from(Instant.now());
		String timestampstr = instant.toString().replace(" ","").replace(":", "").replace("-", "").replace(".","");
		
		String Path = LabCode+"\\CommitteeMinutesAttachmentFile\\";
		
		CommitteeMinutesAttachment attachment= new CommitteeMinutesAttachment();
		attachment.setScheduleId(Long.parseLong(dto.getScheduleId()));
		attachment.setFilePath(Path);
		attachment.setAttachmentName("minutesAttach"+timestampstr+"."+FilenameUtils.getExtension(dto.getMinutesAttachment().getOriginalFilename()));
		saveFile(uploadpath+Path, attachment.getAttachmentName(), dto.getMinutesAttachment());
		attachment.setCreatedBy(dto.getCreatedBy());
		attachment.setCreatedDate(sdf1.format(new Date()));		
		if(dto.getMinutesAttachmentId()!=null)
		{
			CommitteeMinutesAttachment attach = dao.MinutesAttachDownload(dto.getMinutesAttachmentId());
			String filepath = uploadpath+attach.getFilePath()+attach.getAttachmentName();
			File file = new File(filepath);
			if(file.exists()) {	file.delete(); }
			dao.MinutesAttachmentDelete(dto.getMinutesAttachmentId());
		}		
		return dao.MinutesAttachmentAdd(attachment);		
	}
	
	public void saveFile(String uploadpath, String fileName, MultipartFile multipartFile) throws IOException 
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
		   throw new IOException("Could not save file: " + fileName, ioe);
	   }     
	}
	@Override
	public int MinutesAttachmentDelete(String  attachmentid) throws Exception
	{
		CommitteeMinutesAttachment attachment = dao.MinutesAttachDownload(attachmentid);
		
		String filepath = uploadpath+attachment.getFilePath()+attachment.getAttachmentName();
		File file = new File(filepath);
		if(file.exists()) { file.delete(); }
		return dao.MinutesAttachmentDelete(attachmentid);
	}	
	@Override
	public List<Object[]> MinutesAttachmentList(String scheduleid ) throws Exception 
	{
		return dao.MinutesAttachmentList(scheduleid);
	}	
	@Override
	public CommitteeMinutesAttachment MinutesAttachDownload(String attachmentid) throws Exception 
	{
		return dao.MinutesAttachDownload(attachmentid);
	}	
	@Override
	public List<Object[]> PfmsCategoryList() throws Exception 
	{
		return dao.PfmsCategoryList();
	}
	
	@Override
	public int MeetingMinutesApproval(String CommitteeScheduleId, String UserId, String EmpId,String Option ) throws Exception 
	{
		logger.info(new Date() +"Inside SERVICE MeetingMinutesApproval ");
		CommitteeMeetingApproval approval=new CommitteeMeetingApproval();
		CommitteeSchedule schedule= new CommitteeSchedule();
	
		List<Object[]> AllActionAssignedCheck=dao.AllActionAssignedCheck(CommitteeScheduleId);
		for(Object[] obj:AllActionAssignedCheck)
		{
			if(obj[3]==null) {
				return -1;
			}
		}
		
		String Status=null;
		if(Option.equalsIgnoreCase("Minutes Approval")) {
			Status="MMF";
		}else {
			Status="MMS";
		}
		
		approval.setScheduleId(Long.parseLong(CommitteeScheduleId));
		approval.setEmpId(Long.parseLong(EmpId));
		approval.setMeetingStatus(Status);
		approval.setActionBy(UserId);
		approval.setActionDate(sdf1.format(new Date()));
		
		schedule.setScheduleId(Long.parseLong(CommitteeScheduleId));
		schedule.setScheduleFlag("MMF");
		schedule.setModifiedBy(UserId);
		schedule.setModifiedDate(sdf1.format(new Date()));
		
		Object[] CommitteMainData=dao.CommitteMainMembersData(CommitteeScheduleId,"CC");
		if(CommitteMainData!=null )
		{
			PfmsNotification notificationcp= new PfmsNotification();
			String ChairpersonId=CommitteMainData[0].toString();
			notificationcp.setEmpId(Long.parseLong(ChairpersonId));
			notificationcp.setNotificationby(Long.parseLong(EmpId));
			notificationcp.setNotificationDate(sdf1.format(new Date()));
			notificationcp.setNotificationMessage("Minutes Pending Approval For " + CommitteMainData[2].toString() );
			notificationcp.setNotificationUrl("MeetingApprovalAgenda.htm");
			notificationcp.setCreatedBy(UserId);
			notificationcp.setCreatedDate(sdf1.format(new Date()));
			notificationcp.setIsActive(1);
			notificationcp.setScheduleId(Long.parseLong(CommitteeScheduleId));
			notificationcp.setStatus(Status);
			dao.MeetingMinutesApprovalNotification(notificationcp);
		}
		
		CommitteMainData=dao.CommitteMainMembersData(CommitteeScheduleId,"CS");
		if(CommitteMainData!=null )
		{
			String secretary=CommitteMainData[0].toString();
			PfmsNotification notificationms= new PfmsNotification();
			notificationms.setEmpId(Long.parseLong(secretary));
			notificationms.setNotificationby(Long.parseLong(EmpId));
			notificationms.setNotificationDate(sdf1.format(new Date()));
			notificationms.setNotificationMessage("Minutes Pending Approval For " + CommitteMainData[2].toString() );
			notificationms.setNotificationUrl("MeetingApprovalAgenda.htm");
			notificationms.setCreatedBy(UserId);
			notificationms.setCreatedDate(sdf1.format(new Date()));
			notificationms.setIsActive(1);
			notificationms.setScheduleId(Long.parseLong(CommitteeScheduleId));
			notificationms.setStatus(Status);
			dao.MeetingMinutesApprovalNotification(notificationms);
		}
		CommitteMainData=dao.CommitteMainMembersData(CommitteeScheduleId,"PS");
		if(CommitteMainData!=null )
		{
			String secretary=CommitteMainData[0].toString();
			PfmsNotification notificationps= new PfmsNotification();
			notificationps.setEmpId(Long.parseLong(secretary));
			notificationps.setNotificationby(Long.parseLong(EmpId));
			notificationps.setNotificationDate(sdf1.format(new Date()));
			notificationps.setNotificationMessage("Minutes Pending Approval For " + CommitteMainData[2].toString() );
			notificationps.setNotificationUrl("MeetingApprovalAgenda.htm");
			notificationps.setCreatedBy(UserId);
			notificationps.setCreatedDate(sdf1.format(new Date()));
			notificationps.setIsActive(1);
			notificationps.setScheduleId(Long.parseLong(CommitteeScheduleId));
			notificationps.setStatus(Status);
			dao.MeetingMinutesApprovalNotification(notificationps);
		}
		
		return dao.MeetingMinutesApproval(approval,schedule);
	}

	@Override
	public List<Object[]> MeetingApprovalMinutesList(String EmpId) throws Exception {

		return dao.MeetingApprovalMinutesList(EmpId);
	}


	@Override
	public int MeetingMinutesApprovalSubmit(String ScheduleId, String Remarks, String UserId, String EmpId,String Option) throws Exception {

		logger.info(new Date() +"Inside SERVICE MeetingMinutesApprovalSubmit ");
		CommitteeSchedule schedule= new CommitteeSchedule();
		CommitteeMeetingApproval approval = new CommitteeMeetingApproval();
		PfmsNotification notification=new PfmsNotification();
		
		schedule.setScheduleId(Long.parseLong(ScheduleId));
		schedule.setModifiedBy(UserId);
		schedule.setModifiedDate(sdf1.format(new Date()));
		
		approval.setScheduleId(Long.parseLong(ScheduleId));
		approval.setEmpId(Long.parseLong(EmpId));
		approval.setRemarks(Remarks);
		approval.setActionBy(UserId);
		approval.setActionDate(sdf1.format(new Date()));
		
		Object[] NotificationData=dao.NotificationData(ScheduleId,EmpId,"MMF");
		Object[] CommitteeScheduleData=dao.CommitteeScheduleData(ScheduleId);
		
		if(NotificationData!=null) {
			notification.setEmpId(Long.parseLong(NotificationData[1].toString()));
		}else {
			notification.setEmpId(Long.parseLong("0"));
		}
		notification.setNotificationby(Long.parseLong(EmpId));
		notification.setNotificationDate(sdf1.format(new Date()));
		notification.setScheduleId(Long.parseLong(ScheduleId));
		notification.setCreatedBy(UserId);
		notification.setCreatedDate(sdf1.format(new Date()));
		notification.setIsActive(1);
		notification.setNotificationUrl("CommitteeScheduleView.htm?scheduleid="+Long.parseLong(ScheduleId));
		try {
			if(Option.equalsIgnoreCase("approve")) {
				schedule.setScheduleFlag("MMA");
				approval.setMeetingStatus("MMA");
				notification.setNotificationMessage("Minutes Approved for " + CommitteeScheduleData[8].toString());
				notification.setStatus("MMA");
			}
			if(Option.equalsIgnoreCase("return")) {
				schedule.setScheduleFlag("MMR");
				approval.setMeetingStatus("MMR");
				notification.setNotificationMessage("Minutes Returned for " + CommitteeScheduleData[8].toString());
				notification.setStatus("MMR");
			}
		}catch (Exception e) {
			logger.error(new Date() +" Inside SERVICE MeetingMinutesApprovalSubmit ", e);
		}
		return dao.MeetingMinutesApprovalSubmit(schedule,approval,notification);
	}
	
	@Override
	public List<Object[]> CommitteeAllAttendance(String CommitteeScheduleId) throws Exception {
		 
		return dao.CommitteeAllAttendance(CommitteeScheduleId);
	}

	@Override
	public List<Object[]> MeetingReports(String EmpId, String Term, String ProjectId,String divisionid,String initiationid,String logintype,String LabCode) throws Exception {

		return dao.MeetingReports(EmpId,Term,ProjectId,divisionid,initiationid,logintype,LabCode);
	}

	@Override
	public List<Object[]> MeetingReportListAll(String fdate, String tdate, String ProjectId) throws Exception {
		
		return dao.MeetingReportListAll(fdate,tdate,ProjectId);
	}
	
	@Override
	public List<Object[]> MeetingReportListEmp(String fdate, String tdate, String ProjectId, String EmpId)	throws Exception {		
		return dao.MeetingReportListEmp(fdate,tdate,ProjectId,EmpId);
	}
	
	
	@Override
	public Object[] KickOffMeeting(HttpServletRequest req,RedirectAttributes redir) throws Exception
	{
		logger.info(new Date() +"Inside SERVICE KickOffMeeting ");
		String CommitteeMainId=req.getParameter("committeemainid");
		String CommitteeScheduleId=req.getParameter("committeescheduleid");
		System.out.println(CommitteeMainId+"@@@@@@@@@@@@@"+CommitteeScheduleId);
		String Option=req.getParameter("sub");
		SimpleDateFormat sdf1=new SimpleDateFormat("dd-MM-yyyy");
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		DateTimeFormatter dtf=DateTimeFormatter.ofPattern("yyyy-MM-dd");
		
		Object[] scheduledata=dao.CommitteeScheduleData(CommitteeScheduleId);
		LocalDate scheduledate=LocalDate.parse(scheduledata[2].toString(),dtf);
	
		if(LocalDate.now().isAfter(scheduledate))
			{	
			CommitteeSchedule committeeschedule=new CommitteeSchedule(); 
			committeeschedule.setKickOffOtp(null);
			committeeschedule.setScheduleId(Long.parseLong(CommitteeScheduleId));
			committeeschedule.setScheduleFlag("MKV");
			String  ret=dao.UpdateOtp(committeeschedule);
			if (Integer.parseInt(ret)>0) {
			redir.addAttribute("result", "Meeting Kick Off Successful");
			} else {
			redir.addAttribute("result", "Meeting Kick Off UnSuccessful");
			}	
			Object[] returnobj=new Object[2];
			returnobj[0]=req;
			returnobj[1]=redir;
			return returnobj;
			
		}else if(!Option.equalsIgnoreCase("Validate")) 
		{		
			List<Object[]> Email=dao.ChaipersonEmailId(CommitteeMainId);
			Random random = new Random(); 
			int otp=random.nextInt(9000) + 1000;
			System.out.println(otp);
			CharSequence cs = String.valueOf(otp);
			String Otp=encoder.encode(cs);
			CommitteeSchedule committeeschedule=new CommitteeSchedule(); 
			committeeschedule.setKickOffOtp(Otp);
			committeeschedule.setScheduleId(Long.parseLong(CommitteeScheduleId));
			committeeschedule.setScheduleFlag("MKO");
			
			 	
			MimeMessage msg = javaMailSender.createMimeMessage();
			
			ArrayList<String> emails= new ArrayList<String>();
			for(Object[] obj : Email)
			{
				if(obj[0]!=null) {
					
					emails.add(obj[0].toString());
				}
			}
			     
			if(Email.get(0)[1].toString().equalsIgnoreCase("0")) 
			{
				Object[] RtmddoEmail=dao.RtmddoEmail();
					if(RtmddoEmail!=null) {
						emails.add(RtmddoEmail[0].toString());
					}
			}
				
				
			String [] ToEmail = emails.toArray(new String[emails.size()]);
			
			if (ToEmail.length>0) 
			{
				MimeMessageHelper helper = new MimeMessageHelper(msg, true);
				helper.setTo(ToEmail);
				helper.setSubject(req.getParameter("committeeshortname") + " Meeting OTP ");
				helper.setText(String.valueOf(otp) + " is the OTP for Verification of Meeting ( " + req.getParameter("meetingid") +" ) which is Scheduled at " + sdf1.format(sdf.parse(req.getParameter("meetingdate"))) + "(" + req.getParameter("meetingtime") + "). Kindly Do Not Share the OTP with Anyone." , true);				
				try
				{
					javaMailSender.send(msg);
				}catch (Exception e) {
					logger.error(new Date() +" Inside SERVICE KickOffMeeting ", e);
				}
				dao.UpdateOtp(committeeschedule);
				redir.addAttribute("result", " OTP Sent to Successfully !! ");
				redir.addFlashAttribute("otp", String.valueOf(otp));
			}else
			{
				redir.addAttribute("resultfail", "Email-ids' Not Found");
			}
 
		 }

		 else {
		 
			 if(req.getParameter("otpvalue")!=null) {
			 
			 String OtpDb=dao.KickOffOtp(CommitteeScheduleId);

		 		if(encoder.matches( req.getParameter("otpvalue"),OtpDb)) {
		 			
		 			CommitteeSchedule committeescheduledto=new CommitteeSchedule(); 
				 	committeescheduledto.setKickOffOtp(OtpDb);
				 	committeescheduledto.setScheduleId(Long.parseLong(CommitteeScheduleId));
				 	committeescheduledto.setScheduleFlag("MKV");
				 	String Validate=dao.UpdateOtp(committeescheduledto);
				 	
				 	if (Validate !=null) {
						redir.addAttribute("result", " OTP Validated Successfully ");
					} else {
						redir.addAttribute("result", " OTP Not Matched");
					}	
				 	
			 	}else {
			 		
			 		redir.addAttribute("resultfail", " OTP Not Matched");
			 	}
			 }
		 }
		 Object[] returnobj=new Object[2];
		 returnobj[0]=req;
		 returnobj[1]=redir;
		 return returnobj;
		 
	}
	
	@Override
	public int UpdateCommitteeInvitationEmailSent(String scheduleid)throws Exception
	{
		return dao.UpdateCommitteeInvitationEmailSent(scheduleid);
	}
	
//	@Override
//	public Object[] SendInvitationLetter(HttpServletRequest req,RedirectAttributes redir) throws Exception
//	{
//		logger.info(new Date() +"Inside SendInvitationLetter");
//		 List<Object[]> committeeinvitedlist=dao.CommitteeAtendance(req.getParameter("scheduleid"));
//		 Object[] scheduledata=dao.CommitteeScheduleEditData(req.getParameter("scheduleid"));
//		 SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
//		 ArrayList<String> emails= new ArrayList<String>();
//
//		 for(Object[] obj : committeeinvitedlist) {
//			 
//			 if(!obj[3].toString().equalsIgnoreCase("E") && obj[9].toString().equals("N") ) {				 
//				 emails.add(obj[8].toString());		
//			 }
//		 }
//		 
//		 
//		 String ProjectName="General Type";
//		 if(!scheduledata[9].toString().equalsIgnoreCase("0")) {
//			 
//			ProjectName= dao.projectdetails(scheduledata[9].toString())[1].toString();
//			 
//		 }
//		 
//		 String [] Email = emails.toArray(new String[emails.size()]);
//		 
//		 MimeMessage msg = javaMailSender.createMimeMessage();
//		 MimeMessageHelper helper = new MimeMessageHelper(msg, true);
//		 helper.setTo(Email);
//		 String Message="<p>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;This is to inform you that Meeting is Scheduled for the  <b>"+ scheduledata[7]  + "(" + scheduledata[8] + ")" +"</b> committee of <b>"+ ProjectName +"</b> and further details about the meeting is mentioned below. </p> <table style=\"align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 15px; max-width: 650px; font-size: 16px; border-collapse:collapse;\" >"
//		 		+ "<tr><th colspan=\"2\" style=\"text-align: left; font-weight: 700; width: 650px;border: 1px solid black; padding: 5px; padding-left: 15px\">Meeting Details </th></tr>"
//		 		 + "<tr><td style=\"border: 1px solid black; padding: 5px;text-align: left\"> Date :  </td>"
//		 		 + "<td style=\"border: 1px solid black; padding: 5px;text-align: left\">" + sdf.format(scheduledata[2])  + "</td></tr>"
//		 		 
//		 		 +"<tr>"
//				 + "<td style=\"border: 1px solid black; padding: 5px;text-align: left\"> Time : </td>"
//				 + "<td style=\"border: 1px solid black; padding: 5px;text-align: left\">" + scheduledata[3]  + "</td></tr>"
//				 +"<tr>"
//				 +"<td style=\"border: 1px solid black; padding: 5px;text-align: left\"> Venue</td>"
//				 +"<td style=\"border: 1px solid black; padding: 5px;text-align: left\">"+ scheduledata[12] +"</td>"
//				 +"</tr>"				 
//				 ;
//				 
//		 
//		 helper.setSubject( scheduledata[8] + " " +" Committee Invitation Letter");
//		 helper.setText( Message , true);
//		 javaMailSender.send(msg); 
//			     
//		 if (Email.length>0) {
//			 dao.UpdateCommitteeInvitationEmailSent(req.getParameter("scheduleid"));
//			redir.addAttribute("result", " Committee Invitation Letter Sent Successfully !! ");
//		 } 
//	 redir.addFlashAttribute("committeescheduleid",req.getParameter("scheduleid"));
//	 Object[] returnobj=new Object[2];
//	 returnobj[0]=req;
//	 returnobj[1]=redir;
//	 return returnobj;	 
//	}
	
	@Override
	public List<Object[]> MinutesViewAllActionList(String scheduleid) throws Exception {
		return dao.MinutesViewAllActionList( scheduleid); 
	}
	
//	@Override
//	public List<Object[]> NonProjectCommitteesList() throws Exception {		
//		logger.info(new Date() +"Inside NonProjectCommitteesList");
//		return dao.NonProjectCommitteesList();
//	}

	@Override
	public List<Object[]> ProjectCommitteesList(String LabCode) throws Exception {
		return dao.ProjectCommitteesList( LabCode);
	}

	@Override
	public List<Object[]> ExpertList() throws Exception {
		return dao.ExpertList();
	}

	@Override
	public List<Object[]> AllLabList() throws Exception {
		return dao.AllLabList();
	}

	@Override
	public List<Object[]> ClusterLabs(String LabCode) throws Exception 
	{
		return dao.ClusterLabs(LabCode);
	}

	@Override
	public List<Object[]> ExternalEmployeeListFormation(String CpLabCode,String committeemainid) throws Exception {
		return dao.InternalEmployeeListFormation(CpLabCode,committeemainid);
	}
	
	@Override
	public List<Object[]> ClusterExpertsList(String committeemainid) throws Exception
	{
		return dao.ClusterExpertsList(committeemainid);
	}

	@Override
	public List<Object[]> ClusterExpertsListForCommitteeSchdule() throws Exception
	{
		return dao.ClusterExpertsListForCommitteeSchdule();
	}
	
	@Override
	public List<Object[]> ChairpersonEmployeeListFormation(String LabCode,String committeemainid) throws Exception {
		return dao.ChairpersonEmployeeList(LabCode,committeemainid);
	}
	
	@Override
	public List<Object[]> PreseneterForCommitteSchedule(String LabCode)throws Exception
	{
		return dao.PreseneterForCommitteSchedule(LabCode);
	}
	
	
	@Override
	public Object[] LabInfoClusterLab(String LabCode) throws Exception 
	{
		return dao.LabInfoClusterLab(LabCode);
	}
	
	@Override
	public List<Object[]> ExternalEmployeeListInvitations(String labcode,String scheduleid) throws Exception {
		return dao.ExternalEmployeeListInvitations(labcode,scheduleid);
	}


	@Override
	public long CommitteeMembersInsert(CommitteeMembersDto dto) throws Exception {
		
		logger.info(new Date() +"Inside SERVICE CommitteeMembersInsert ");
		long count=0;
		
		ArrayList<String> emplist=new ArrayList<String>();
		ArrayList<String> lablist=new ArrayList<String>();
		ArrayList<String> membertype=new ArrayList<String>();
		
		if (dto.getInternalMemberIds()!=null) 
		{

			for(int i=0;i<dto.getInternalMemberIds().length;i++) {
				
				lablist.add(dto.getInternalLabCode());
				membertype.add("CI");
			}
			
			emplist.addAll(Arrays.asList(dto.getInternalMemberIds()));
		}
		
		if (dto.getExternalMemberIds()!=null) 
		{

			for(int i=0;i<dto.getExternalMemberIds().length;i++) {
				
				lablist.add(dto.getExternalLabCode());
				membertype.add("CW");
			}
			
			emplist.addAll(Arrays.asList(dto.getExternalMemberIds()));
		}
		
		if (dto.getExpertMemberIds() != null) {
			
			for(int i=0;i<dto.getExpertMemberIds().length;i++) {
				
				lablist.add("@EXP");
				membertype.add("CO");
			}
			emplist.addAll(Arrays.asList(dto.getExpertMemberIds()));
		}
		
		
		for(int i=0;i< emplist.size();i++)
		{
			CommitteeMember  committeemember=new CommitteeMember();
			committeemember.setCommitteeMainId(Long.parseLong(dto.getCommitteeMainId()));			
			committeemember.setEmpId(Long.parseLong(emplist.get(i)));
			committeemember.setLabCode(lablist.get(i));
			committeemember.setMemberType(membertype.get(i));
			committeemember.setCreatedBy(dto.getCreatedBy());
			committeemember.setCreatedDate(sdf1.format(new Date()));
			committeemember.setIsActive(1);
			count=dao.CommitteeMainMembersAdd(committeemember);
		}		
		
		return count;
	}

	
	
	@Override
	public List<Object[]> CommitteeAllMembers(String committeemainid) throws Exception {
		return dao.CommitteeAllMembers(committeemainid);
	}
	
	@Override
	public Object[] ProjectBasedMeetingStatusCount(String projectid) throws Exception
	{
		return dao.ProjectBasedMeetingStatusCount(projectid);
	}
	
		
	@Override
	public List<Object[]> allprojectdetailsList() throws Exception {
		return dao.allprojectdetailsList();
	}
	
	@Override
	public List<Object[]> PfmsMeetingStatusWiseReport(String projectid,String statustype) throws Exception
	{
		return dao.PfmsMeetingStatusWiseReport(projectid, statustype);
	}
	
	@Override
	public List<Object[]> ProjectCommitteeFormationCheckList(String projectid) throws Exception
	{
		return dao.ProjectCommitteeFormationCheckList(projectid);
	}
	
	@Override
	public Object[] ProjectCommitteeDescriptionTOR(String projectid,String Committeeid) throws Exception
	{
		return dao.ProjectCommitteeDescriptionTOR(projectid, Committeeid);	
	}
	
	@Override
	public Object[] DivisionCommitteeDescriptionTOR(String divisionid,String Committeeid) throws Exception
	{	
		return dao.DivisionCommitteeDescriptionTOR(divisionid, Committeeid);	
	}

	@Override
	public int ProjectCommitteeDescriptionTOREdit( CommitteeProject  committeeproject ) throws Exception
	{	
		committeeproject.setModifiedDate(sdf1.format(new Date()));
		return dao.ProjectCommitteeDescriptionTOREdit(committeeproject);
	}
	
	
	@Override
	public int DivisionCommitteeDescriptionTOREdit(CommitteeDivision committeedivision) throws Exception
	{	
		committeedivision.setModifiedDate(sdf1.format(new Date()));
		return dao.DivisionCommitteeDescriptionTOREdit(committeedivision);
	}

	@Override
	public long CommitteePreviousAgendaAdd(String scheduleidto,String[] fromagendaids,String userid) throws Exception {
		logger.info(new Date() +"Inside SERVICE CommitteePreviousAgendaAdd ");
		long count=0;
		for(int i=0;i<fromagendaids.length;i++)
		{			
			Object[] scheduletodata = dao.CommitteeScheduleEditData(scheduleidto);
			CommitteeScheduleAgenda scheduleagendafrom=dao.CommitteePreviousAgendaGet(fromagendaids[i]);
			CommitteeScheduleAgenda scheduleagendato=new CommitteeScheduleAgenda();			
			scheduleagendato.setScheduleId(Long.parseLong(scheduleidto));
			scheduleagendato.setScheduleSubId(scheduleagendafrom.getScheduleSubId());
			scheduleagendato.setAgendaItem(scheduleagendafrom.getAgendaItem());
			scheduleagendato.setPresentorLabCode(scheduleagendafrom.getPresentorLabCode());
			scheduleagendato.setPresenterId(scheduleagendafrom.getPresenterId());
			scheduleagendato.setDuration(scheduleagendafrom.getDuration());
			scheduleagendato.setProjectId(Long.parseLong(scheduletodata[9].toString()));
			scheduleagendato.setRemarks(scheduleagendafrom.getRemarks());
			scheduleagendato.setCreatedBy(userid);
			scheduleagendato.setCreatedDate(sdf1.format(new Date()));
			
			scheduleagendato.setIsActive(1);

			List<Object[]> agendapriority=dao.CommitteeScheduleAgendaPriority(scheduleidto);
			
			if(agendapriority.size()==0)
			{
				scheduleagendato.setAgendaPriority(1);
			}
			else if((Integer)agendapriority.get(0)[2]==0)
			{
				scheduleagendato.setAgendaPriority(1);
			}else {
				scheduleagendato.setAgendaPriority(((Integer)agendapriority.get(0)[2])+1);	
			}
			
			
			count=dao.CommitteeAgendaSubmit(scheduleagendato);
		}		
		return count;
	}

	@Override
	public int ScheduleMinutesUnitUpdate(String UnitId, String Unit, String UserId) throws Exception {
		
		String dt=sdf3.format(new Date());
		return dao.ScheduleMinutesUnitUpdate(UnitId, Unit, UserId,dt);
	}
	
	@Override
	public List<Object[]> divisionList() throws Exception {
		return dao.divisionList();
		
	}
	
	
	@Override
	public List<Object[]> LoginDivisionList(String empid) throws Exception {
		return dao.LoginDivisionList(empid);
	}
	
	@Override
	public List<Object[]> CommitteedivisionAssigned(String divisionid) throws Exception
	{
		return dao.CommitteedivisionAssigned(divisionid);
		
	}
	
	@Override
	public List<Object[]> CommitteedivisionNotAssigned(String divisionid, String LabCode ) throws Exception
	{
		return dao.CommitteedivisionNotAssigned(divisionid,  LabCode );
	}
	
	@Override
	public long DivisionCommitteeAdd(String divisionid, String[] Committee, String UserId) throws Exception 
	{
		logger.info(new Date() +"Inside SERVICE DivisionCommitteeAdd ");
		long count=0;
		for(int i=0;i<Committee.length;i++) {
			Object[] committeedata=dao.CommitteeDetails(Committee[i]);
			CommitteeDivision committeeproject=new CommitteeDivision();
			committeeproject.setDivisionId(Long.parseLong(divisionid));
			committeeproject.setCommitteeId(Long.parseLong(Committee[i]));
			committeeproject.setCreatedBy(UserId);
			committeeproject.setCreatedDate(sdf1.format(new Date()));
			committeeproject.setDescription(committeedata[10].toString());
			committeeproject.setTermsOfReference(committeedata[11].toString());
			count=dao.DivisionCommitteeAdd(committeeproject);
		}
				
		return count;
	}
	
	
	@Override
	public List<Object[]> DivisionCommitteeFormationCheckList(String divisionid) throws Exception
	{
		return dao.DivisionCommitteeFormationCheckList(divisionid);
	}
	
	@Override
	public long DivisionCommitteeDelete( String[] CommitteeProject,String user) throws Exception {

		logger.info(new Date() +"Inside SERVICE DivisionCommitteeDelete ");
		long count=0;
		for(int i=0;i<CommitteeProject.length;i++) {
			CommitteeDivision committeedivision=new CommitteeDivision();
			committeedivision.setCommitteeDivisionId(Long.parseLong(CommitteeProject[i]));		
			count=dao.DivisionCommitteeDelete(committeedivision);
			
		}				
		return count;
		
	}
	
	@Override
	public  Object[] DivisionData(String divisionid) throws Exception
	{
		return dao.DivisionData(divisionid);
	}
	
	
	@Override
	public List<Object[]> DivisionScheduleListAll(String divisionid) throws Exception
	{
		return dao.DivisionScheduleListAll(divisionid);
	}
	
	@Override
	public List<Object[]> DivisionCommitteeScheduleList(String divisionid,String committeeid) throws Exception
	{
		return dao.DivisionCommitteeScheduleList(divisionid, committeeid);
	}
	
	
	@Override
	public List<Object[]> DivisionCommitteeMainList(String divisionid) throws Exception 
	{
		return dao.DivisionCommitteeMainList(divisionid);
	}
	
	
	@Override
	public List<Object[]> DivisionMasterList(String divisionid) throws Exception 
	{
		return dao.DivisionMasterList(divisionid);
	}
		
	@Override
	public List<Object[]> DivCommitteeAutoScheduleList(String divisionid) throws Exception 
	{		
		return dao.DivCommitteeAutoScheduleList(divisionid);
	}

	@Override
	public List<Object[]> CommitteeActionList(String EmpId) throws Exception {
		return dao.CommitteeActionList(EmpId);
	}
	
	
	@Override
	public int CommitteeDivisionUpdate(String divisionid, String CommitteeId) throws Exception 
	{
		return dao.CommitteeDivisionUpdate(divisionid, CommitteeId);
	}

	@Override
	public List<Object[]> MinutesOutcomeList() throws Exception {
		
		return dao.MinutesOutcomeList();
	}

		
	
	@Override
	public List<Object[]> InitiatedProjectDetailsList()throws Exception
	{
		return dao.InitiatedProjectDetailsList();
	}

	@Override
	public List<Object[]> InitiationMasterList(String initiationid) throws Exception {
		return dao.InitiationMasterList(initiationid);
	}
	
	@Override
	public List<Object[]> InitiationCommitteeFormationCheckList(String initiationid) throws Exception
	{
		return dao.InitiationCommitteeFormationCheckList(initiationid);
	}

	@Override
	public List<Object[]> InitiationCommitteesListNotAdded(String initiationid,String LabCode) throws Exception 
	{
		return dao.InitiationCommitteesListNotAdded(initiationid, LabCode);
	}
	
	@Override
	public Long InvitationSerialnoUpdate(String[] newslno,String[] invitationid) throws Exception
	{
		logger.info(new Date() +"Inside SERVICE InvitationSerialnoUpdate ");
			long ret=0;
			for(int i=0;i<invitationid.length;i++)
			{
				dao.InvitationSerialnoUpdate(invitationid[i],newslno[i]);
			}
			return ret;
	
	}
	
	@Override
	public List<Object[]> CommitteeRepList() throws Exception
	{
		return dao.CommitteeRepList();
	}
	
	@Override
	public List<Object[]> CommitteeMemberRepList(String committeemainid) throws Exception
	{
		return dao.CommitteeMemberRepList(committeemainid);
	}
	
	@Override
	public List<Object[]> CommitteeRepNotAddedList(String committeemainid) throws Exception
	{
		return dao.CommitteeRepNotAddedList(committeemainid);
	}
	
	@Override
	public long CommitteeRepMemberAdd(String[] repids, String committeemainid, String createdby ) throws Exception
	{
		logger.info(new Date() +"Inside SERVICE CommitteeRepMemberAdd ");
		long count=0;
		for(int i=0;i<repids.length;i++ ) 
		{
			CommitteeMemberRep repmems=new CommitteeMemberRep();
			repmems.setCommitteeMainId(Long.parseLong(committeemainid));
			repmems.setRepId(Integer.parseInt(repids[i]));
			repmems.setCreatedBy(createdby);
			repmems.setCreatedDate(sdf1.format(new Date()));
			repmems.setIsActive(1);			
			count=dao.CommitteeRepMembersSubmit(repmems);
		}
		
		return count;
	}
	
	@Override
	public int CommitteeMemberRepDelete(String memberrepid) throws Exception
	{
		return dao.CommitteeMemberRepDelete(memberrepid);
		
	}
	
	
	@Override
	public List<Object[]> CommitteeAllMembersList(String committeemainid) throws Exception
	{
		return dao.CommitteeAllMembersList(committeemainid);		
	}
	
	@Override
	public int CommitteeMemberUpdate(CommitteeMember model) throws Exception {
		logger.info(new Date() +"Inside SERVICE CommitteeMemberUpdate ");
		model.setModifiedDate(sdf1.format(new Date()));
		return dao.CommitteeMemberUpdate(model);		
	}
	
	@Override
	public int CommitteeMainMemberUpdate(CommitteeMembersEditDto dto) throws Exception {	
		logger.info(new Date() +"Inside SERVICE CommitteeMainMemberUpdate ");
		
		int ret=0;
		// Update Chairperson
		CommitteeMember model=new CommitteeMember();
		model.setModifiedBy(dto.getModifiedBy());
		model.setModifiedDate(sdf1.format(new Date()));
		model.setCommitteeMemberId(Long.parseLong(dto.getChairpersonmemid()));
		
		model.setLabCode(dto.getCpLabCode());
		
		model.setEmpId(Long.parseLong(dto.getChairperson()));
		ret=dao.CommitteeMemberUpdate(model);		
				
		// Update or Remove or add  co-chairperson based on update
		model=new CommitteeMember();
		
		if(dto.getComemberid()!=null && Long.parseLong(dto.getCo_chairperson())==0)
		{
			model.setCommitteeMemberId(Long.parseLong(dto.getComemberid()));
			model.setModifiedBy(dto.getModifiedBy());
			model.setModifiedDate(sdf1.format(new Date()));
			dao.CommitteeMemberDelete(model);
		}
		else if(dto.getComemberid()!=null && Long.parseLong(dto.getCo_chairperson())>0)
		{
			model.setCommitteeMemberId(Long.parseLong(dto.getComemberid()));
			model.setLabCode(dto.getSesLabCode());
			model.setEmpId(Long.parseLong(dto.getCo_chairperson()));
			model.setModifiedBy(dto.getModifiedBy());
			model.setModifiedDate(sdf1.format(new Date()));
			ret=dao.CommitteeMemberUpdate(model);
		}
		else if(dto.getComemberid()==null && Long.parseLong(dto.getCo_chairperson())>0)
		{
				CommitteeMember newmodel=new CommitteeMember();
				newmodel.setLabCode(dto.getSesLabCode());
				newmodel.setEmpId(Long.parseLong(dto.getCo_chairperson()));
				newmodel.setMemberType("CH");
				newmodel.setCommitteeMainId(Long.parseLong(dto.getCommitteemainid()));
				newmodel.setCreatedBy(dto.getModifiedBy());
				newmodel.setCreatedDate(sdf1.format(new Date()));
				newmodel.setIsActive(1);
				dao.CommitteeMainMembersAdd(newmodel);
		}
			
		
		if(dto.getComemberid()!=null && Long.parseLong(dto.getCo_chairperson())==0)
		{
			model.setCommitteeMemberId(Long.parseLong(dto.getComemberid()));
			dao.CommitteeMemberDelete(model);
		}
		
		
		// Update Member Secretary
		model=new CommitteeMember();
		model.setModifiedBy(dto.getModifiedBy());
		model.setModifiedDate(sdf1.format(new Date()));
		model.setCommitteeMemberId(Long.parseLong(dto.getSecretarymemid()));
		model.setLabCode(dto.getMsLabCode());
		model.setEmpId(Long.parseLong(dto.getSecretary()));
		ret=dao.CommitteeMemberUpdate(model); 
		
		
		// Update, remove or add Proxy member Secretary based on update
		model=new CommitteeMember();
		
		if(dto.getProxysecretarymemid()!=null && Long.parseLong(dto.getProxysecretary())==0)
		{
			model.setCommitteeMemberId(Long.parseLong(dto.getProxysecretarymemid()));
			model.setModifiedBy(dto.getModifiedBy());
			model.setModifiedDate(sdf1.format(new Date()));
			dao.CommitteeMemberDelete(model);
		}
		else if(dto.getProxysecretarymemid()!=null && Long.parseLong(dto.getProxysecretary())>0)
		{
			model.setCommitteeMemberId(Long.parseLong(dto.getProxysecretarymemid()));
			model.setLabCode(dto.getSesLabCode());
			model.setModifiedBy(dto.getModifiedBy());
			model.setModifiedDate(sdf1.format(new Date()));
			model.setEmpId(Long.parseLong(dto.getProxysecretary()));
			
			ret=dao.CommitteeMemberUpdate(model);
		}
		else if(dto.getProxysecretarymemid()==null && Long.parseLong(dto.getProxysecretary())>0)
		{
				CommitteeMember newmodel=new CommitteeMember();
				newmodel.setLabCode(dto.getSesLabCode());
				newmodel.setEmpId(Long.parseLong(dto.getProxysecretary()));
				newmodel.setMemberType("PS");
				newmodel.setCommitteeMainId(Long.parseLong(dto.getCommitteemainid()));
				newmodel.setCreatedBy(dto.getModifiedBy());
				newmodel.setCreatedDate(sdf1.format(new Date()));
				newmodel.setIsActive(1);
				dao.CommitteeMainMembersAdd(newmodel);
		}
			
		
		
		
		return ret;
		
	}
	
	
	@Override
	public Object[] CommitteMainData(String committeemainid) throws Exception 
	{
		return dao.CommitteMainData(committeemainid);
	}
	
	@Override
	public long InitiationCommitteeDelete( String[] CommitteeProject,String user) throws Exception {

		logger.info(new Date() +"Inside SERVICE InitiationCommitteeDelete ");
		long count=0;
		for(int i=0;i<CommitteeProject.length;i++) {
			CommitteeInitiation model=new CommitteeInitiation();
			model.setCommitteeInitiationId(Long.parseLong(CommitteeProject[i]));		
			count=dao.InitiationCommitteeDelete(model);
		}				
		return count;
		
	}
	@Override
	public Object[] Initiationdetails(String initiationid) throws Exception
	{	
		return dao.Initiationdetails(initiationid);

	}
	
	@Override
	public Object[] InitiationCommitteeDescriptionTOR(String initiationid,String Committeeid) throws Exception
	{	
		return dao.InitiationCommitteeDescriptionTOR(initiationid, Committeeid);

	}
	
	@Override
	public int InitiationCommitteeDescriptionTOREdit(CommitteeInitiation committeeinitiation) throws Exception
	{	
		committeeinitiation.setModifiedDate(sdf1.format(new Date()));
		return dao.InitiationCommitteeDescriptionTOREdit(committeeinitiation);
	}
	
	@Override
	public List<Object[]> InitiaitionMasterList(String initiationid) throws Exception 
	{
		return dao.InitiaitionMasterList(initiationid);
	}
	@Override
	public int CommitteeInitiationUpdate(String initiationid, String CommitteeId) throws Exception 
	{
		return dao.CommitteeInitiationUpdate(initiationid,CommitteeId);
	}
	
	@Override
	public List<Object[]> InitiationCommitteeMainList(String initiationid) throws Exception 
	{
		return dao.InitiationCommitteeMainList(initiationid);
	}
	@Override
	public List<Object[]> InitiationScheduleListAll(String initiationid) throws Exception
	{
		return dao.InitiationScheduleListAll(initiationid);
	}
	
	@Override
	public List<Object[]> InitiationCommitteeScheduleList(String initiationid,String committeeid) throws Exception
	{
		return dao.InitiationCommitteeScheduleList(initiationid, committeeid);
	}
	@Override
	public Object[] ProposedCommitteeMainId(String committeemainid) throws Exception
	{
		return dao.ProposedCommitteeMainId(committeemainid);
	}
	
	@Override
	public Object[] GetProposedCommitteeMainId(String committeeid,String projectid,String divisionid,String initiationid) throws Exception
	{
		return dao.GetProposedCommitteeMainId(committeeid, projectid, divisionid, initiationid);		
	}
	
	@Override
	public Object[] CommitteeMainApprovalData(String committeemainid) throws Exception
	{
		return dao.CommitteeMainApprovalData(committeemainid);
	}
	

	@Override
	public List<Object[]> ApprovalStatusList(String committeemainid ) throws Exception
	{
		return dao.ApprovalStatusList(committeemainid);
	}
	
	@Override
	public long CommitteeMainApprove(CommitteeConstitutionApprovalDto dto ) throws Exception
	{
		logger.info(new Date() +"Inside SERVICE CommitteeMainApprove ");
		
		Object[] CommitteeMain = dao.CommitteeMainDetails(dto.getCommitteeMainId());
		
		int ret=0;		
		String operation=dto.getOperation();
		Object[] oldapprovaldata=dao.CommitteeMainApprovalData(dto.getCommitteeMainId());
		String constatusid=oldapprovaldata[5].toString();
		String approvalauth=oldapprovaldata[6].toString();
		CommitteeConstitutionApproval approval=new CommitteeConstitutionApproval();		
		
		if(dto.getRemarks()==null || dto.getRemarks().equals(""))
		{
			dto.setRemarks("NIL");
		}
		
		approval.setCommitteeMainId(Long.parseLong(dto.getCommitteeMainId()));	
		approval.setActionBy(dto.getActionBy());
		approval.setActionDate(sdf1.format(new Date()));
		approval.setRemarks(dto.getRemarks());
		//approval.setEmpid(Long.parseLong(dto.getEmpid()));
		//approval.setEmpLabid(Long.parseLong(dto.getEmpLabid()));
		approval.setApprovalAuthority(dto.getApprovalAuthority());
		Object[] notificationemployee = null;
		String notificationempid="";
		if(constatusid.equals("CCR") ) 
		{
			if(operation.equalsIgnoreCase("approve"))
			{
				constatusid="CFW";
				notificationemployee=dao.CommitteeMainApprovalDoData(dto.getCommitteeMainId());
				if(notificationemployee!=null) {
					notificationempid=	notificationemployee[0].toString();
				}
				
			}
		}
		else if(constatusid.equals("CFW")) 
		{
			if(operation.equalsIgnoreCase("approve"))
			{
				constatusid="RDO";
				notificationemployee=dao.DoRtmdAdEmpData();
				if(notificationemployee!=null) {
					notificationempid=	notificationemployee[0].toString();
				}
								
			}
			else if(operation.equalsIgnoreCase("return"))
			{
				constatusid="RTDO";	
				notificationemployee=dao.ComConstitutionEmpdetails(dto.getCommitteeMainId());
				if(notificationemployee!=null) {
					notificationempid=	notificationemployee[0].toString();
				}
			}
		}
		else if(constatusid.equals("RDO")) 
		{
			if(operation.equalsIgnoreCase("approve"))
			{
				constatusid="RDT";				
				notificationemployee=dao.DirectorEmpData(CommitteeMain[3].toString());
				if(notificationemployee!=null) {
					notificationempid=	notificationemployee[0].toString();
				}
			}
			else if(operation.equalsIgnoreCase("return"))
			{
				constatusid="RTR";
				notificationemployee=dao.CommitteeMainApprovalDoData(dto.getCommitteeMainId());
				if(notificationemployee!=null) {
					notificationempid=	notificationemployee[0].toString();
				}
			}
		}
		else if(constatusid.equals("RDT")) 
		{
			if(operation.equalsIgnoreCase("approve"))
			{
				constatusid="ADR";
				if(!approvalauth.equals(constatusid)) {
					constatusid="RDR";
				}
			}
			else if(operation.equalsIgnoreCase("return"))
			{
				constatusid="RTDR";
				notificationemployee=dao.DoRtmdAdEmpData();
				if(notificationemployee!=null) {
					notificationempid=	notificationemployee[0].toString();
				}
			}
		}
		else if(constatusid.equals("RDR")) 
		{
			if(operation.equalsIgnoreCase("approve"))
			{
				constatusid="ADG";
				if(!approvalauth.equals(constatusid)) {
					constatusid="RDG";
				}
			}
			else if(operation.equalsIgnoreCase("return"))
			{
				constatusid="RTDG";
			}
		}
		else if(constatusid.equals("RDG")) 
		{
			if(operation.equalsIgnoreCase("approve"))
			{
				constatusid="ASC";
				
			}
			else if(operation.equalsIgnoreCase("return"))
			{
				constatusid="RTSC";
			}
		}
		else if(constatusid.equals("RTSC")) 
		{
			if(operation.equalsIgnoreCase("approve"))
			{
				constatusid="RDG";
				
			}
			else if(operation.equalsIgnoreCase("return"))
			{
				constatusid="RTDG";
			}
		}
		
		else if(constatusid.equals("RTDG")) 
		{
			if(operation.equalsIgnoreCase("approve"))
			{
				constatusid="RDR";
				
			}
			else if(operation.equalsIgnoreCase("return"))
			{
				constatusid="RTDR";
				notificationemployee=dao.DoRtmdAdEmpData();
				if(notificationemployee!=null) {
					notificationempid=	notificationemployee[0].toString();
				}
			}
		}
		else if(constatusid.equals("RTDR")) 
		{
			if(operation.equalsIgnoreCase("approve"))
			{
				constatusid="RDT";
				/* dao.updatecommitteeapprovalauthority(approval); */
				notificationemployee=dao.DirectorEmpData(CommitteeMain[3].toString());
				if(notificationemployee!=null) {
					notificationempid=	notificationemployee[0].toString();
				}	
				
				
			}
			else if(operation.equalsIgnoreCase("return"))
			{
				constatusid="RTR";
				notificationemployee=dao.CommitteeMainApprovalDoData(dto.getCommitteeMainId());
				if(notificationemployee!=null) {
					notificationempid=	notificationemployee[0].toString();
				}	
			}
		}
		else if(constatusid.equals("RTR"))
		{
			if(operation.equalsIgnoreCase("approve"))
			{
				constatusid="RDO";
				notificationemployee=dao.DoRtmdAdEmpData();
				if(notificationemployee!=null) {
					notificationempid=	notificationemployee[0].toString();
				}			
			}
			else if(operation.equalsIgnoreCase("return"))
			{
				constatusid="RTDO";
				notificationempid=dao.ComConstitutionEmpdetails(dto.getCommitteeMainId())[0].toString();
			}
		}
		else if(constatusid.equals("RTDO")) 
		{
			if(operation.equalsIgnoreCase("approve"))
			{
				constatusid="CFW";
				notificationempid=dao.CommitteeMainApprovalDoData(dto.getCommitteeMainId())[0].toString();
				
			}			
		}		
			
		
		approval.setConstitutionStatus(constatusid);
		
		if((notificationempid==null || notificationempid.equals("") || Long.parseLong(notificationempid)==0 ) && !(approvalauth.equals(constatusid)) )
		{
			return -1;
		}
		if(constatusid.equalsIgnoreCase("RDT"))
		{
			dao.updatecommitteeapprovalauthority(approval);
		}
		CommitteeConstitutionHistory transaction=new CommitteeConstitutionHistory();
		transaction.setConstitutionApprovalId(Long.parseLong(oldapprovaldata[0].toString()));
		transaction.setCommitteeMainId(Long.parseLong(dto.getCommitteeMainId()));
		transaction.setRemarks(dto.getRemarks());
		transaction.setActionByLabid(Long.parseLong(dto.getEmpLabid()));
		transaction.setActionByEmpid(Long.parseLong(dto.getEmpid()));
		transaction.setActionDate(sdf1.format(new Date()));
		transaction.setConstitutionStatus(constatusid);
		dao.ConstitutionApprovalHistoryAdd(transaction);
		
		
		
		
		if(approvalauth.equals(constatusid))
		{
			Object[] committeemaindata=dao.CommitteMainData(dto.getCommitteeMainId());
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
			LocalDate fromDate = LocalDate.parse(committeemaindata[6].toString());
			
			long lastcommitteeid=dao.LastCommitteeId(committeemaindata[1].toString(),committeemaindata[2].toString(),committeemaindata[3].toString(),committeemaindata[4].toString());	
			if(lastcommitteeid!=0)
			{
				CommitteeMain committeemain1= new CommitteeMain();
				committeemain1.setModifiedBy(dto.getActionBy());
				committeemain1.setModifiedDate(sdf1.format(new Date()));
				committeemain1.setValidTo(java.sql.Date.valueOf(fromDate.minusDays(1).toString()));
				committeemain1.setCommitteeMainId(lastcommitteeid);					
				dao.UpdateCommitteemainValidto(committeemain1);
			}
			dto.setActionDate(sdf1.format(new Date()));
			dao.NewCommitteeMainIsActiveUpdate(dto);
		}
		long schid=0;
		
		if(notificationempid!=null && !notificationempid.equals("")) 
		{
			PfmsNotification notification= new PfmsNotification();
			notification.setNotificationby(Long.parseLong(dto.getEmpid()));
			notification.setEmpId(Long.parseLong(notificationempid));
			Object[] ConStatusdetail=dao.CommitteeConStatusDetails(constatusid);
			notification.setNotificationMessage("Action Pending For Committee Constitution "+ConStatusdetail[0]);
			notification.setNotificationUrl("CommitteeMainApprovalList.htm");
			notification.setNotificationDate(sdf1.format(new Date()));
			notification.setCreatedBy(dto.getActionBy());
			notification.setCreatedDate(sdf1.format(new Date()));
			notification.setIsActive(1);
			notification.setScheduleId(schid);
			notification.setStatus("MAR");
			dao.MeetingMinutesApprovalNotification(notification);
		}
		ret=dao.CommitteeApprovalUpdate(approval);		
		return ret;
	}
	
	
	@Override
	public List<Object[]> ProposedCommitteList() throws Exception
	{
		return dao.ProposedCommitteList();
	}
	
	@Override
	public List<Object[]> ProposedCommitteesApprovalList(String loginid,String EmpId) throws Exception
	{
		logger.info(new Date() +"Inside SERVICE ProposedCommitteList ");
		
		List<Object[]> ProposedCommitteesApprovalList=new ArrayList<Object[]>(); 
		Object[] logindata=dao.LoginData(loginid);
		
		String logintype=logindata[4].toString();
		ProposedCommitteesApprovalList.addAll(dao.ProposedCommitteesApprovalList(logintype, EmpId));
		
		return ProposedCommitteesApprovalList;
	}
	
	@Override
	public List<Object[]>  ComConstitutionApprovalHistory(String committeemainid) throws Exception
	{
		return dao.ComConstitutionApprovalHistory(committeemainid);
	}
	
	
	@Override
	public List<Object[]>  ConstitutionApprovalFlow(String committeemainid) throws Exception
	{
		logger.info(new Date() +"Inside SERVICE ConstitutionApprovalFlow ");
		List<Object[]> list=new ArrayList<Object[]>();
		Object[] CommitteeMain = dao.CommitteeMainDetails(committeemainid);
		Object[] temp=dao.ComConstitutionEmpdetails(committeemainid);
		if(temp!=null) {
			list.add(temp);
		}
		temp=dao.CommitteeMainApprovalDoData(committeemainid);
		
		if(temp!=null) {
			list.add(temp);
		}
		list.add(dao.DoRtmdAdEmpData());
		
		temp=dao.DirectorEmpData(CommitteeMain[3].toString());
		if(temp!=null) {
			list.add(temp);
		}
		return list;
	}
	
	@Override
	public int  CommitteeMinutesDelete(String scheduleminutesid) throws Exception
	{
		return dao.CommitteeMinutesDelete(scheduleminutesid);
	}
	
	@Override
	public int  CommitteeScheduleDelete(CommitteeScheduleDto dto) throws Exception
	{
		logger.info(new Date() +"Inside SERVICE CommitteeScheduleDelete ");
		dto.setModifiedDate(sdf1.format(new Date()));
		dao.CommitteeScheduleAgendaDelete(dto);
		dao.CommitteeScheduleInvitationDelete(dto);
		return dao.CommitteeScheduleDelete(dto);
	}
	
	@Override
	public int  ScheduleCommitteeEmpCheck(EmpAccessCheckDto dto) throws Exception
	{
		logger.info(new Date() +"Inside SERVICE ScheduleCommitteeEmpCheck ");
		String logintype = dto.getLogintype();
		String scheduleid = dto.getScheduleid();
		String empid = dto.getEmpid();
		Object Committeemainid = dto.getCommitteemainid();
		int committeecons = dto.getCommitteecons();
		String confidential = dto.getConfidential();
		int useraccess=0;
		
		ArrayList<String> logintypes=new ArrayList<String>( Arrays.asList("A","Z","Y","E","H","C","I") );
		ArrayList<String> memtypes=new ArrayList<String>( Arrays.asList("CS","CC","PS") );
			if(logintypes.contains(logintype)) 
			{
				useraccess=2;
				return useraccess;
			}
			if( committeecons>0 )
			{
				List<Object[]> ScheduleCommEmpCheck = dao.ScheduleCommitteeEmpCheck(scheduleid, empid);
				if(ScheduleCommEmpCheck.size()>0)
				{
					useraccess=2;
					return useraccess;
				}
			}
			if( useraccess==0 )
			{
				List<Object[]> ScheduleCommEmpCheck = dao.ScheduleCommitteeEmpinvitedCheck(scheduleid, empid);
				
				if(ScheduleCommEmpCheck.size()>0)
				{
					if(confidential.equals("1") || confidential.equals("2")) 
					{
						if(memtypes.contains(ScheduleCommEmpCheck.get(0)[2].toString())) {
							useraccess=2;
							return useraccess;
						}
					}else
					{
						useraccess=2;
						return useraccess;
					}
				}
			}
			
			
		
		return useraccess;		
	}
	
	@Override
	public List<Object[]> EmpScheduleData(String empid,String scheduleid) throws Exception 
	{
		return dao.EmpScheduleData(empid, scheduleid);
	}
	
	@Override
	public List<Object[]> DefaultAgendaList(String committeeid,String LabCode) throws Exception 
	{
		return dao.DefaultAgendaList(committeeid,LabCode);
	}
	
	@Override
	public List<Object[]> ProcurementStatusList(String projectid)throws Exception{
		return dao.ProcurementStatusList(projectid);
	}
	private SimpleDateFormat sdf4=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");	
		String todayDate=outputFormat.format(new Date()).toString();
	@Override
	public List<Object[]> ActionPlanSixMonths(String projectid)throws Exception
	{
		
		logger.info(new Date()  +"Inside SERVICE ActionPlanThreeMonths ");
	
//			List<Object[]> main=dao.MilestoneActivityList(projectid);
//			List<Object[]> MilestoneActivityA=new ArrayList<Object[]>();
//			List<Object[]> MilestoneActivityB=new ArrayList<Object[]>();
//			List<Object[]> MilestoneActivityC=new ArrayList<Object[]>();
//			List<Object[]> MilestoneActivityD=new ArrayList<Object[]>();
//			List<Object[]> MilestoneActivityE=new ArrayList<Object[]>();
//			
//				for(Object[] objmain:main ) {
//					List<Object[]>  MilestoneActivityA1=dao.MilestoneActivityLevel(objmain[0].toString(),"1");
//					MilestoneActivityA.addAll(MilestoneActivityA1);
//					
//					for(Object[] obj:MilestoneActivityA1) {
//						List<Object[]>  MilestoneActivityB1=dao.MilestoneActivityLevel(obj[0].toString(),"2");
//						MilestoneActivityB.addAll(MilestoneActivityB1);
//						
//						for(Object[] obj1:MilestoneActivityB1) {
//							List<Object[]>  MilestoneActivityC1=dao.MilestoneActivityLevel(obj1[0].toString(),"3");
//							MilestoneActivityC.addAll(MilestoneActivityC1);
//							
//							for(Object[] obj2:MilestoneActivityC1) {
//								List<Object[]>  MilestoneActivityD1=dao.MilestoneActivityLevel(obj2[0].toString(),"4");
//								MilestoneActivityD.addAll( MilestoneActivityD1);
//								
//								for(Object[] obj3:MilestoneActivityD1) {
//									List<Object[]>  MilestoneActivityE1=dao.MilestoneActivityLevel(obj3[0].toString(),"5");
//									MilestoneActivityE.addAll( MilestoneActivityE1);
//								}
//							}
//						}
//					}
//				}
//				
//				List<Object[]> MilestoneActivityAll=new ArrayList<Object[]>();
//				MilestoneActivityAll.addAll(main);
//				MilestoneActivityAll.addAll(MilestoneActivityA);
//				MilestoneActivityAll.addAll(MilestoneActivityB);
//				MilestoneActivityAll.addAll(MilestoneActivityC);
//				MilestoneActivityAll.addAll(MilestoneActivityC);
//				MilestoneActivityAll.addAll(MilestoneActivityE);
		List<Object[]>mainList=dao.ActionPlanSixMonths(projectid);
		List<Object[]>subList=new ArrayList<>();
		List<Object[]>actionList= new ArrayList<>();
		if(mainList.size()!=0) {
			subList=mainList.stream().filter(i->i[33].toString().equalsIgnoreCase("Y")).collect(Collectors.toList());
		}
		LocalDate futureDay=LocalDate.parse(todayDate).plusDays(180);
		if(subList.size()!=0) {
		actionList=subList.stream().filter(i ->i[26].toString().equalsIgnoreCase("0")|| LocalDate.parse(i[8].toString()).isBefore(futureDay)).collect(Collectors.toList());
		}
		return actionList;
		
		//	return dao.ActionPlanSixMonths(projectid);
		
	
	}
	
	@Override
	public Object[] ProjectDataDetails(String projectid) throws Exception 
	{
		return dao.ProjectDataDetails(projectid);
	}
	

	@Override 
	public List<Object[]> LastPMRCActions(long scheduleid,String committeeid,String proid,String isFrozen) throws Exception 
	{
		List<Object[]>lastPmrcActionList= new ArrayList<>();
		lastPmrcActionList=dao.LastPMRCActions(scheduleid, committeeid, proid, isFrozen);
		return dao.LastPMRCActions(scheduleid,committeeid,proid,isFrozen);
	}
	
	@Override
	public List<Object[]> CommitteeMinutesSpecNew()throws Exception
	{
		return dao.CommitteeMinutesSpecNew();
	}
	
	@Override 
	public List<Object[]> MilestoneSubsystems(String projectid) throws Exception {
		return dao.MilestoneSubsystems(projectid);
	}
	
	@Override 
	public List<Object[]> EmployeeScheduleReports(HttpServletRequest req,String empid,String rtype) throws Exception 
	{
		logger.info(new Date() +"Inside SERVICE EmployeeScheduleReports ");
		LocalDate fromdate=null;  
		LocalDate todate=null;
		String rtype1=rtype.toLowerCase();
		
			
		if(req.getParameter(rtype1+"fromdate")!=null && rtype.equalsIgnoreCase("D")) 
		{
			fromdate= todate =LocalDate.parse(sdf3.format(sdf.parse(req.getParameter((rtype1+"fromdate")))));
		}
		else if(req.getParameter(rtype1+"fromdate")!=null &&  rtype.equalsIgnoreCase("W"))
		{
			fromdate=LocalDate.parse(sdf3.format(sdf.parse(req.getParameter((rtype1+"fromdate")))));
			todate=LocalDate.parse(sdf3.format(sdf.parse(req.getParameter(rtype1+"todate"))));
		}
		else if(req.getParameter(rtype1+"fromdate")!=null &&  rtype.equalsIgnoreCase("M"))
		{
			
			String month = req.getParameter((rtype1+"fromdate")).split("-")[0];
			String year= req.getParameter((rtype1+"fromdate")).split("-")[1];
			
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMMM d, yyyy", Locale.ENGLISH);
			fromdate = LocalDate.parse(month+" 01, "+year, formatter);
						
			todate = fromdate.plusMonths(1).withDayOfMonth(1).minusDays(1);
			
			ArrayList<LocalDate> monthdays = new ArrayList<LocalDate>();
			for(LocalDate fromdate1 = LocalDate.parse(fromdate.toString());fromdate1.isBefore(todate)|| fromdate1.isEqual(todate) ; fromdate1=fromdate1.plusDays(1)) 
			{
				monthdays.add(LocalDate.parse(fromdate1.toString()));
			}
			req.setAttribute("monthdays", monthdays);
									
		}
		else if(rtype.equalsIgnoreCase("D")) 
		{
			todate=fromdate=LocalDate.now();
		}
		else if(rtype.equalsIgnoreCase("W")) 
		{
			LocalDate today = LocalDate.now();			
		    // Go backward to get Monday
		    LocalDate monday = today;
		    while (monday.getDayOfWeek() != DayOfWeek.MONDAY)
		    {
		      monday = monday.minusDays(1);
		    }
		    // Go forward to get Sunday
		    LocalDate sunday = today;
		    while (sunday.getDayOfWeek() != DayOfWeek.SUNDAY)
		    {
		    	sunday = sunday.plusDays(1);
		    }
		    fromdate=monday.minusDays(1);
		    todate=sunday.minusDays(1);
		}
		else if(rtype.equalsIgnoreCase("M")) // month dates
		{
			fromdate = LocalDate.now().withDayOfMonth(1);
			todate = LocalDate.now().plusMonths(1).withDayOfMonth(1).minusDays(1);
			
			ArrayList<LocalDate> monthdays = new ArrayList<LocalDate>();
			for(LocalDate fromdate1 = LocalDate.parse(fromdate.toString());fromdate1.isBefore(todate)|| fromdate1.isEqual(todate) ; fromdate1=fromdate1.plusDays(1)) 
			{
				monthdays.add(LocalDate.parse(fromdate1.toString()));
			}
			req.setAttribute("monthdays", monthdays);
					
		}
		req.setAttribute("fromdate", fromdate);
		req.setAttribute("todate", todate);
		return dao.EmployeeScheduleReports(empid, fromdate.toString(), todate.toString());
	}
	
	@Override
	public List<Object[]> EmployeeDropdown(String empid,String logintype,String projectid)throws Exception
	{
		return dao.EmployeeDropdown(empid, logintype, projectid);
	}
	@Override
	public List<Object[]> FileRepMasterListAll(String projectid,String LabCode)throws Exception
	{
		return dao.FileRepMasterListAll(projectid,LabCode);
	}
	
	@Override
	public Object[] AgendaDocLinkDownload(String filerepid)throws Exception
	{
		return dao.AgendaDocLinkDownload(filerepid);
	}
	
	@Override
	public List<Object[]> AgendaLinkedDocList(String scheduleid) throws Exception {
		return dao.AgendaLinkedDocList(scheduleid);
	}
	
	@Override
	public int AgendaUnlinkDoc(CommitteeScheduleAgendaDocs agendadoc) throws Exception 
	{
		logger.info(new Date() +"Inside SERVICE AgendaUnlinkDoc ");
		agendadoc.setModifiedDate(sdf1.format(new Date()));
		
		if(dao.AgendaUnlinkDoc(agendadoc)!=null) {
			return 1;
		}else {
			return 0;
		}
		 
	}
	
	@Override
	public int PreDefAgendaEdit(CommitteeDefaultAgenda agenda) throws Exception 
	{
		agenda.setModifiedDate(sdf1.format(new Date()));
		return dao.PreDefAgendaEdit(agenda);
	}
	
	@Override
	public long PreDefAgendaAdd(CommitteeDefaultAgenda agenda) throws Exception 
	{
		agenda.setCreatedDate(sdf1.format(new Date()));
		return dao.PreDefAgendaAdd(agenda);
	}
	
	@Override
	public int PreDefAgendaDelete(String agendaid) throws Exception 
	{
		return dao.PreDefAgendaDelete(agendaid);
	}
	
	@Override
	public int MeetingNo(Object[] scheduledata) throws Exception 
	{
		logger.info(new Date() +"Inside SERVICE MeetingNo ");
		int count=0;
		if(scheduledata[21].toString().equalsIgnoreCase("P")) {
			String scheduledate = scheduledata[2].toString(); 
			String projectid = scheduledata[9].toString();
			String committeeid = scheduledata[0].toString();
			count= dao.CommProScheduleList(projectid, committeeid,scheduledate);
		}
		return count;
	}

	@Override
	public long insertMinutesFinance(MinutesFinanceList finance) throws Exception {
		finance.setCreatedDate(sdf1.format(new Date()));
		return dao.insertMinutesFinance(finance);
	}

	@Override
	public long getLastPmrcId(String projectid, String committeeid, String scheduleId) throws Exception {
		
		return dao.getLastPmrcId(projectid, committeeid, scheduleId);
	}

	@Override
	public int updateMinutesFrozen(String schduleid) throws Exception {
		
		return dao.updateMinutesFrozen(schduleid);
	}

	@Override
	public List<ProjectFinancialDetails> getMinutesFinance(String scheduleid) throws Exception {
		logger.info(new Date() +"Inside SERVICE getMinutesFinance ");
		List<ProjectFinancialDetails> finlist=new ArrayList<ProjectFinancialDetails>();
		for(MinutesFinanceList list:dao.getMinutesFinance(scheduleid)) {
			ProjectFinancialDetails finance=new ProjectFinancialDetails();
			finance.setBudgetHeadDescription(list.getBudgetHeadDescription());
			finance.setBudgetHeadId(list.getBudgetHeadId());
			finance.setFeBalance(list.getFeBalance());
			finance.setFeDipl(list.getFeDipl());
			finance.setFeExpenditure(list.getFeExpenditure());
			finance.setFeOutCommitment(list.getFeOutCommitment());
            finance.setFeSanction(list.getFeSanction());
            finance.setProjectId(list.getProjectId());
            finance.setReBalance(list.getReBalance());
            finance.setReDipl(list.getReDipl());
            finance.setReExpenditure(list.getFeExpenditure());
            finance.setReOutCommitment(list.getReOutCommitment());
	        finance.setReSanction(list.getReSanction());
	        finance.setTotalSanction(list.getTotalSanction());
            finlist.add(finance);
		}
		
		return finlist;
	}

	@Override
	public List<Object[]> ClusterList() throws Exception {
		
		return dao.ClusterList();
	}
	
	@Override
	public Object[] getDefaultAgendasCount(String committeeId, String LabCode) throws Exception
	{
		return dao.getDefaultAgendasCount(committeeId, LabCode);
	}
	
	@Override
	public LabMaster LabDetailes(String LabCode) throws Exception {
		return dao.LabDetailes(LabCode);
	}
	
	@Override
	public long FreezeDPFMMinutes(CommitteeMeetingDPFMFrozen dpfm) throws Exception 
	{
		String meedtingId = dpfm.getMeetingId().replaceAll("[&.:?|<>/]", "").replace("\\", "") ;
		String LabCode = dpfm.getLabCode();
		String filepath = "\\"+LabCode.toUpperCase().trim()+"\\DPFM\\";
		int count=0;
		String filename = "DPFM-"+meedtingId;
		while(new File(uploadpath+filepath+"\\"+filename+".pdf").exists())
		{
			filename = filename+" ("+ ++count+")";
		}
		File file = dpfm.getDpfmfile();
		saveFile(uploadpath+filepath ,filename+".pdf" ,file );
		
		dpfm.setDPFMFileName(filename+".pdf");
		dpfm.setFrozenDPFMPath(filepath);
		dpfm.setFreezeTime(sdf1.format(new Date()));
		return dao.FreezeDPFMMinutesAdd(dpfm);
	}
	
	public void saveFile(String uploadpath, String fileName, File fileToSave) throws IOException 
	{
	   logger.info(new Date() +"Inside SERVICE saveFile ");
	   Path uploadPath = Paths.get(uploadpath);
	          
	   if (!Files.exists(uploadPath)) {
		   Files.createDirectories(uploadPath);
	   }
	        
	   try (InputStream inputStream = new FileInputStream(fileToSave)) {
		   Path filePath = uploadPath.resolve(fileName);
	       Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
	   } catch (IOException ioe) {       
		   throw new IOException("Could not save file: " + fileName, ioe);
	   }     
	}
	
	@Override
	public CommitteeMeetingDPFMFrozen getFrozenDPFMMinutes(String scheduleId)throws Exception
	{
		return dao.getFrozenDPFMMinutes(scheduleId);
	}
	@Override
	public List<Object[]> totalProjectMilestones(String projectid) throws Exception {
		return dao.totalProjectMilestones(projectid);
	}
	
}

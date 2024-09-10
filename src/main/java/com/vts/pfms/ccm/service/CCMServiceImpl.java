package com.vts.pfms.ccm.service;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.vts.pfms.FormatConverter;
import com.vts.pfms.ccm.dao.CCMDao;
import com.vts.pfms.ccm.model.CCMAchievements;
import com.vts.pfms.ccm.model.CCMPresentationSlides;
import com.vts.pfms.committee.dao.CommitteeDao;
import com.vts.pfms.committee.dto.CommitteeMembersEditDto;
import com.vts.pfms.committee.model.CommitteeMain;
import com.vts.pfms.committee.model.CommitteeMember;
import com.vts.pfms.committee.model.CommitteeSchedule;
import com.vts.pfms.committee.model.CommitteeScheduleAgenda;
import com.vts.pfms.login.PFMSCCMData;

@Service
public class CCMServiceImpl implements CCMService{
	
	private static final Logger logger = LogManager.getLogger(CCMServiceImpl.class);
	
	FormatConverter fc = new FormatConverter();
	private SimpleDateFormat sdtf = fc.getSqlDateAndTimeFormat();
	private SimpleDateFormat sdf = fc.getSqlDateFormat();
	private SimpleDateFormat rdf = new SimpleDateFormat("dd-MM-yyyy");
	
	@Autowired
	CCMDao dao;

	@Autowired
	CommitteeDao committeedao;
	
	@Value("${ApplicationFilesDrive}")
	String uploadpath;
	
	@Override
	public long ccmCommitteeMainMembersSubmit(CommitteeMembersEditDto dto, String action) throws Exception {
		try {
			
			Long commmitteeMainId = Long.parseLong(dto.getCommitteemainid());
			if(commmitteeMainId==0L) {
				
				LocalDate fromDate = LocalDate.now();
				
				CommitteeMain main = new CommitteeMain();
				main.setCommitteeId(Long.parseLong(dto.getCommitteeId()));
				main.setValidFrom(java.sql.Date.valueOf(fromDate));
				main.setValidTo(java.sql.Date.valueOf(fromDate.plusYears(5).minusDays(1)));
				main.setStatus("A");
				main.setPreApproved("Y");
				main.setIsActive(1);
				main.setCreatedBy(dto.getModifiedBy());
				main.setCreatedDate(sdtf.format(new Date()));
				main.setFormationDate(java.sql.Date.valueOf(fromDate));
				
				commmitteeMainId = committeedao.CommitteeDetailsSubmit(main);	
			}
			
			// Chairperson Add / Edit
			CommitteeMember mem1 = action.equalsIgnoreCase("Add")? new CommitteeMember() : dao.getCommitteeMemberById(dto.getChairpersonmemid());
			mem1.setCommitteeMainId(commmitteeMainId);
			mem1.setLabCode(dto.getSesLabCode());
			mem1.setEmpId(Long.parseLong(dto.getChairperson()));
			mem1.setMemberType("CC");
			if(action.equalsIgnoreCase("Add")) {
				mem1.setCreatedBy(dto.getModifiedBy());
				mem1.setCreatedDate(sdtf.format(new Date()));
				mem1.setIsActive(1);
				mem1.setSerialNo(1);
			}else {
				mem1.setModifiedBy(dto.getModifiedBy());
				mem1.setModifiedDate(sdtf.format(new Date()));
			}
			
			committeedao.CommitteeMainMembersAdd(mem1);
			
			// Co-Chairperson Add / Edit
			if(dto.getComemberid()!=null && Long.parseLong(dto.getCo_chairperson())==0)
			{
				mem1 = new CommitteeMember();
				mem1.setCommitteeMemberId(Long.parseLong(dto.getComemberid()));
				mem1.setModifiedBy(dto.getModifiedBy());
				mem1.setModifiedDate(sdtf.format(new Date()));
				committeedao.CommitteeMemberDelete(mem1);
			}
			if(dto.getCo_chairperson()!=null && Long.parseLong(dto.getCo_chairperson())>0) {
				mem1 = action.equalsIgnoreCase("Add") || dto.getComemberid()==null? new CommitteeMember() : dao.getCommitteeMemberById(dto.getComemberid());
				mem1.setCommitteeMainId(commmitteeMainId);
				mem1.setLabCode(dto.getSesLabCode());
				mem1.setEmpId(Long.parseLong(dto.getCo_chairperson()));
				mem1.setMemberType("CH");
				if(action.equalsIgnoreCase("Add") || dto.getComemberid()==null) {
					mem1.setCreatedBy(dto.getModifiedBy());
					mem1.setCreatedDate(sdtf.format(new Date()));
					mem1.setIsActive(1);
					mem1.setSerialNo(1);
				}else {
					mem1.setModifiedBy(dto.getModifiedBy());
					mem1.setModifiedDate(sdtf.format(new Date()));
				}
				
				committeedao.CommitteeMainMembersAdd(mem1);
			}
			
			// Member Secretary Add / Edit
			mem1 = action.equalsIgnoreCase("Add")? new CommitteeMember() : dao.getCommitteeMemberById(dto.getSecretarymemid());
			mem1.setCommitteeMainId(commmitteeMainId);
			mem1.setLabCode(dto.getSesLabCode());
			mem1.setEmpId(Long.parseLong(dto.getSecretary()));
			mem1.setMemberType("CS");
			if(action.equalsIgnoreCase("Add")) {
				mem1.setCreatedBy(dto.getModifiedBy());
				mem1.setCreatedDate(sdtf.format(new Date()));
				mem1.setIsActive(1);
				mem1.setSerialNo(1);
			}else {
				mem1.setModifiedBy(dto.getModifiedBy());
				mem1.setModifiedDate(sdtf.format(new Date()));
			}
			
			committeedao.CommitteeMainMembersAdd(mem1);
			
			// Member Secretary (Proxy) Add / Edit
			if(dto.getProxysecretarymemid()!=null && Long.parseLong(dto.getProxysecretarymemid())==0)
			{
				mem1 = new CommitteeMember();
				mem1.setCommitteeMemberId(Long.parseLong(dto.getProxysecretarymemid()));
				mem1.setModifiedBy(dto.getModifiedBy());
				mem1.setModifiedDate(sdtf.format(new Date()));
				committeedao.CommitteeMemberDelete(mem1);
			}
			if(dto.getProxysecretary()!=null && Long.parseLong(dto.getProxysecretary())>0) {
				mem1 = (action.equalsIgnoreCase("Add") || dto.getProxysecretarymemid()==null)? new CommitteeMember() : dao.getCommitteeMemberById(dto.getProxysecretarymemid());
				mem1.setCommitteeMainId(commmitteeMainId);
				mem1.setLabCode(dto.getSesLabCode());
				mem1.setEmpId(Long.parseLong(dto.getProxysecretary()));
				mem1.setMemberType("PS");
				if(action.equalsIgnoreCase("Add") || dto.getProxysecretarymemid()==null) {
					mem1.setCreatedBy(dto.getModifiedBy());
					mem1.setCreatedDate(sdtf.format(new Date()));
					mem1.setIsActive(1);
					mem1.setSerialNo(1);
				}else {
					mem1.setModifiedBy(dto.getModifiedBy());
					mem1.setModifiedDate(sdtf.format(new Date()));
				}
				
				committeedao.CommitteeMainMembersAdd(mem1);
			}
			
			return commmitteeMainId;

		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside CCMServiceImpl ccmCommitteeMainMembersUpdate "+e);
			return 0;
		}
		
	}

	@Override
	public List<CommitteeSchedule> getScheduleListByYear(String year) throws Exception {
		
		return dao.getScheduleListByYear(year);
	}

	@Override
	public CommitteeSchedule getCCMScheduleById(String ccmScheduleId) throws Exception {
		
		return dao.getCCMScheduleById(ccmScheduleId);
	}

	@Override
	public long addCCMSchedule(CommitteeSchedule schedule) throws Exception {
		if(schedule.getScheduleId()==null) {
			LocalDate localDate = LocalDate.parse(schedule.getScheduleDate().toString());
			String month = localDate.getMonth().toString().substring(0, 3);
			String scheduleType = schedule.getScheduleType();
			String seq = schedule.getLabCode()+(scheduleType.equalsIgnoreCase("C")?"/CCM/":"/DMC/")+(localDate.getYear())+"/"+month+"/";
			long maxCCMScheduleIdForMonth = dao.getMaxCCMScheduleIdForMonth(seq);
			schedule.setMeetingId(seq+(maxCCMScheduleIdForMonth+1));
		}
		
		return dao.addCCMSchedule(schedule);
	}
	
	@Override
	public long addCCMAgendaDetails(HttpServletRequest req, HttpSession ses, Map<String, MultipartFile> fileMap, String ccmScheduleId) throws Exception {
	    try {
	        String UserId = (String)ses.getAttribute("Username");
	        String labcode = (String)ses.getAttribute("labcode");

	        String Path = labcode + "\\CCM\\";
	        
	        // agenda 
	        int i = 0;
	        int mainpriority = dao.getMaxAgendaPriority(ccmScheduleId, "0");
	        int maxAgendaIndex = getMaxAgendaIndex(req, "agenda");
	        for (i = 0; i <= maxAgendaIndex; i++) {
	            if (req.getParameter("agenda[" + i + "].agendaItem") != null) {
	            	CommitteeScheduleAgenda agenda = new CommitteeScheduleAgenda();
	                agenda.setScheduleId(Long.parseLong(ccmScheduleId));
	                agenda.setParentScheduleAgendaId(0L);
	                agenda.setAgendaPriority(++mainpriority);
	                agenda.setAgendaItem(req.getParameter("agenda[" + i + "].agendaItem"));
	                agenda.setPresentorLabCode(req.getParameter("agenda[" + i + "].prepsLabCode"));
	                //agenda.setPresenterId(req.getParameter("agenda[" + i + "].presenterId"));
	                agenda.setPresenterId(req.getParameter("agenda[" + i + "].presenterId")!=null?Long.parseLong(req.getParameter("agenda[" + i + "].presenterId")): 0);
	                //agenda.setStartTime(req.getParameter("agenda[" + i + "].startTime"));
	                //agenda.setEndTime(req.getParameter("agenda[" + i + "].endTime"));
	                agenda.setDuration(req.getParameter("agenda[" + i + "].duration")!=null?Integer.parseInt(req.getParameter("agenda[" + i + "].duration")): 0);
	                agenda.setCreatedBy(UserId);
	                agenda.setCreatedDate(sdtf.format(new Date()));
	                agenda.setIsActive(1);
	                
	                Timestamp instant = Timestamp.from(Instant.now());
					String timestampstr = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");
					
	                MultipartFile attachment = fileMap.get("agenda[" + i + "].attachment");
	                if (attachment != null && !attachment.isEmpty()) {
	                    agenda.setFileName("File-" + timestampstr + "." + FilenameUtils.getExtension(attachment.getOriginalFilename()));
	                    saveFile(uploadpath + Path, agenda.getFileName(), attachment);
	                } else {
	                    agenda.setFileName(null);
	                }
	                
	                Long scheduleAgendaId = dao.addCCMScheduleAgenda(agenda);

	                // sub-agenda 
	                int j = 0;
	                int subpriority=0;
	                int maxSubAgendaIndex = getMaxSubAgendaIndex(req, "agenda[" + i + "].subAgendas");
	                for (j = 0; j <= maxSubAgendaIndex; j++) {
	                    if (req.getParameter("agenda[" + i + "].subAgendas[" + j + "].agendaItem") != null && !req.getParameter("agenda[" + i + "].subAgendas[" + j + "].agendaItem").isEmpty()) {
	                    	CommitteeScheduleAgenda subagenda = new CommitteeScheduleAgenda();
	                        subagenda.setScheduleId(Long.parseLong(ccmScheduleId));
	                        subagenda.setParentScheduleAgendaId(scheduleAgendaId);
	                        subagenda.setAgendaPriority(++subpriority);
	                        subagenda.setAgendaItem(req.getParameter("agenda[" + i + "].subAgendas[" + j + "].agendaItem"));
	                        subagenda.setPresentorLabCode(req.getParameter("agenda[" + i + "].subAgendas[" + j + "].prepsLabCode"));
	                        //subagenda.setPresenterId(req.getParameter("agenda[" + i + "].subAgendas[" + j + "].presenterId"));
	                        subagenda.setPresenterId(req.getParameter("agenda[" + i + "].subAgendas[" + j + "].presenterId")!=null? Long.parseLong(req.getParameter("agenda[" + i + "].subAgendas[" + j + "].presenterId")) : 0);
	                        subagenda.setDuration(req.getParameter("agenda[" + i + "].subAgendas[" + j + "].duration")!=null? Integer.parseInt(req.getParameter("agenda[" + i + "].subAgendas[" + j + "].duration")) : 0);
	                        //subagenda.setStartTime(req.getParameter("agenda[" + i + "].subAgendas[" + j + "].startTime"));
	                        //subagenda.setEndTime(req.getParameter("agenda[" + i + "].subAgendas[" + j + "].endTime"));
	                        subagenda.setCreatedBy(UserId);
	                        subagenda.setCreatedDate(sdtf.format(new Date()));
	                        subagenda.setIsActive(1);
	                        
	                        Timestamp instant2 = Timestamp.from(Instant.now());
	        				String timestampstr2 = instant2.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");
	        				
	                        MultipartFile subattachment = fileMap.get("agenda[" + i + "].subAgendas[" + j + "].attachment");
	                        if (subattachment != null && !subattachment.isEmpty()) {
	                            subagenda.setFileName("File-" + timestampstr2 + "." + FilenameUtils.getExtension(subattachment.getOriginalFilename()));
	                            saveFile(uploadpath + Path, subagenda.getFileName(), subattachment);
	                        } else {
	                            subagenda.setFileName(null);
	                        }
	                        
	                        dao.addCCMScheduleAgenda(subagenda);
	                    }
	                }
	            }
	        }
	        return 1;
	    } catch (Exception e) {
	        e.printStackTrace();
	        logger.error(new Date() + " Inside CCMServiceImpl ccmCommitteeMainMembersUpdate " + e);
	        return 0;
	    }
	}

	private int getMaxAgendaIndex(HttpServletRequest req, String prefix) {
	    int maxIndex = -1;
	    Enumeration<String> paramNames = req.getParameterNames();
	    while (paramNames.hasMoreElements()) {
	        String paramName = paramNames.nextElement();
	        if (paramName.startsWith(prefix)) {
	            String[] parts = paramName.split("\\[|\\]");
	            if (parts.length > 1) {
	                int index = Integer.parseInt(parts[1]);
	                if (index > maxIndex) {
	                    maxIndex = index;
	                }
	            }
	        }
	    }
	    return maxIndex;
	}

	private int getMaxSubAgendaIndex(HttpServletRequest req, String prefix) {
	    int maxIndex = -1;
	    Enumeration<String> paramNames = req.getParameterNames();
	    while (paramNames.hasMoreElements()) {
	        String paramName = paramNames.nextElement();
	        if (paramName.startsWith(prefix)) {
	            String[] parts = paramName.split("\\[|\\]");
	            if (parts.length > 3) {
	                int index = Integer.parseInt(parts[3]);
	                if (index > maxIndex) {
	                    maxIndex = index;
	                }
	            }
	        }
	    }
	    return maxIndex;
	}

	
	public static void saveFile(String uploadpath, String fileName, MultipartFile multipartFile) throws IOException {
		logger.info(new Date() + "Inside SERVICE saveFile ");
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
	public List<Object[]> getCCMScheduleAgendaListByCCMScheduleId(String ccmScheduleId) throws Exception {
		
		return dao.getCCMScheduleAgendaListByCCMScheduleId(ccmScheduleId);
	}

	@Override
	public CommitteeScheduleAgenda getCCMScheduleAgendaById(String ccmScheduleAgendaId) throws Exception {
		
		return dao.getCCMScheduleAgendaById(ccmScheduleAgendaId);
	}

	@Override
	public Long addCCMScheduleAgenda(CommitteeScheduleAgenda agenda, MultipartFile attachment, String labcode, int orgDuration) throws Exception {
		try {
			
			// Update Duration of Main Agenda
			if(orgDuration!=agenda.getDuration() && (agenda.getParentScheduleAgendaId()!=0)) {
				dao.updateCCMScheduleAgendaDuration(orgDuration, agenda.getDuration(), agenda.getParentScheduleAgendaId());
			}
			
			Timestamp instant = Timestamp.from(Instant.now());
	        String timestampstr = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");

	        String Path = labcode + "\\CCM\\";
			if (attachment != null && !attachment.isEmpty()) {
                agenda.setFileName("File-" + timestampstr + "." + FilenameUtils.getExtension(attachment.getOriginalFilename()));
                saveFile(uploadpath + Path, agenda.getFileName(), attachment);
            } 
			return dao.addCCMScheduleAgenda(agenda);
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside CCMServiceImpl ccmCommitteeMainMembersUpdate " + e);
			return 0L;
		}
		
	}

	@Override
	public Long ccmAgendaPriorityUpdate(String[] ccmScheduleAgendaId,String[] agendaPriority) throws Exception
	{
		try {
			for(int i=0;i<ccmScheduleAgendaId.length;i++)
			{
				dao.ccmAgendaPriorityUpdate(ccmScheduleAgendaId[i],agendaPriority[i]);
			}
			return 1L;
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside CCMServiceImpl ccmAgendaPriorityUpdate " + e);
			return 0L;
		}
	
	}

	@Override
	public long ccmScheduleAgendaDelete(String scheduleAgendaId, String userId, String ccmScheduleId, String agendaPriority) throws Exception {
		
		try {
			List<Object[]> ccmScheduleAgendasAfter = dao.getCCMScheduleAgendasAfter(ccmScheduleId, agendaPriority, "0");
			if(ccmScheduleAgendasAfter.size()>0) 
			{
				for(Object[] obj : ccmScheduleAgendasAfter )
				{
					dao.ccmAgendaPriorityUpdate(obj[0].toString(), String.valueOf((Integer)obj[1]-1));
				}
			}
			
			dao.ccmScheduleAgendaDelete(scheduleAgendaId, userId, sdtf.format(new Date()));
			dao.ccmScheduleSubAgendaDelete(scheduleAgendaId, userId, sdtf.format(new Date()));
			
			return 1;
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside CCMServiceImpl ccmScheduleAgendaDelete " + e);
			return 0;
		}
	}

	@Override
	public long addCCMAgendaDetails(HttpServletRequest req, HttpSession ses, MultipartFile[] attachments) throws Exception {
		try {
			String userId = (String)ses.getAttribute("Username");
			String labcode = (String)ses.getAttribute("labcode");
			
			String ccmScheduleId = req.getParameter("ccmScheduleId");
			String scheduleAgendaId = req.getParameter("scheduleAgendaId");
			String[] agendaItem = req.getParameterValues("agendaItem");
			String[] prepsLabCode = req.getParameterValues("prepsLabCode");
			String[] presenterId = req.getParameterValues("presenterId");
			String[] duration = req.getParameterValues("duration");
			

	        String Path = labcode + "\\CCM\\";
			int subPriority = dao.getMaxAgendaPriority(ccmScheduleId, scheduleAgendaId);
			
			int totalDuration = 0;
			for(int i=0; i<agendaItem.length; i++) {
				CommitteeScheduleAgenda agenda = new CommitteeScheduleAgenda();
                agenda.setScheduleId(Long.parseLong(ccmScheduleId));
                agenda.setParentScheduleAgendaId(Long.parseLong(scheduleAgendaId));
                agenda.setAgendaPriority(++subPriority);
                agenda.setAgendaItem(agendaItem[i]);
                agenda.setPresentorLabCode(prepsLabCode[i]);
                agenda.setPresenterId(Long.parseLong(presenterId[i]));
                agenda.setDuration(Integer.parseInt(duration[i]));
                agenda.setCreatedBy(userId);
                agenda.setCreatedDate(sdtf.format(new Date()));
                agenda.setIsActive(1);
                
                totalDuration+=agenda.getDuration();
                
                Timestamp instant = Timestamp.from(Instant.now());
				String timestampstr = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");
				
                if (attachments[i] != null && !attachments[i].isEmpty()) {
                    agenda.setFileName("File-" + timestampstr + "." + FilenameUtils.getExtension(attachments[i].getOriginalFilename()));
                    saveFile(uploadpath + Path, agenda.getFileName(), attachments[i]);
                } else {
                    agenda.setFileName(null);
                }
                
                dao.addCCMScheduleAgenda(agenda);
			}
			
			// Update Duration of Main Agenda
			if(totalDuration!=0) {
				dao.updateCCMScheduleAgendaDuration(0, totalDuration, Long.parseLong(scheduleAgendaId));
			}
			
			return 1;
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside CCMServiceImpl ccmScheduleAgendaDelete " + e);
			return 0;
		}
	}

	@Override
	public int ccmScheduleSubAgendaDelete(String scheduleAgendaId, String userId, String ccmScheduleId, String agendaPriority, String parentScheduleAgendaId) throws Exception {
		try {
			CommitteeScheduleAgenda agenda = dao.getCCMScheduleAgendaById(scheduleAgendaId);
			
			// Remove the Duration from Main Agenda
			if(agenda.getParentScheduleAgendaId()!=0) {
				dao.updateCCMScheduleAgendaDuration(agenda.getDuration(), 0, agenda.getParentScheduleAgendaId());
			}
			
			List<Object[]> ccmScheduleAgendasAfter = dao.getCCMScheduleAgendasAfter(ccmScheduleId, agendaPriority, parentScheduleAgendaId);

			if(ccmScheduleAgendasAfter!=null && ccmScheduleAgendasAfter.size()>0) 
			{
				for(Object[] obj : ccmScheduleAgendasAfter )
				{
					dao.ccmAgendaPriorityUpdate(obj[0].toString(), String.valueOf((Integer)obj[1]-1));
				}
			}
			
			return dao.ccmScheduleAgendaDelete(scheduleAgendaId, userId, sdtf.format(new Date()));
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside CCMServiceImpl ccmScheduleAgendaDelete " + e);
			return 0;
		}
		
	}

	@Override
	public Long getCommitteeMainIdByCommitteeCode(String committeeCode) throws Exception {
		
		return dao.getCommitteeMainIdByCommitteeCode(committeeCode);
	}

	@Override
	public Long getCommitteeIdByCommitteeCode(String committeeCode) throws Exception {
		
		return dao.getCommitteeIdByCommitteeCode(committeeCode);
	}

	@Override
	public Long getLatestScheduleId(String scheduleType) throws Exception {
		
		return dao.getLatestScheduleId(scheduleType);
	}

	@Override
	public Long getSecondLatestScheduleId(String scheduleType) throws Exception {
		
		return dao.getSecondLatestScheduleId(scheduleType);
	}
	
	@Override
	public List<String> getLatestScheduleMinutesIds(String scheduleId) throws Exception {
		
		return dao.getLatestScheduleMinutesIds(scheduleId);
	}

	@Override
	public List<Object[]> getClusterLabListByClusterId(String clusterId) throws Exception {
		
		return dao.getClusterLabListByClusterId(clusterId);
	}

	@Override
	public List<CommitteeSchedule> getScheduleListByScheduleType(String scheduleType) throws Exception {
		
		return dao.getScheduleListByScheduleType(scheduleType);
	}

	@Override
	public List<CCMAchievements> getCCMAchievementsByScheduleId(Long scheduleId, String topicType) throws Exception {
		
		return dao.getCCMAchievementsByScheduleId(scheduleId, topicType);
	}

	@Override
	public CCMAchievements getCCMAchievementsById(String achievementId) throws Exception {
		
		return dao.getCCMAchievementsById(achievementId);
	}

	@Override
	public long addCCMAchievements(CCMAchievements achmnts, MultipartFile imageAttachment, MultipartFile pdfAttachment, MultipartFile videoAttachment, String clusterId) throws Exception {
		
		Timestamp instant = Timestamp.from(Instant.now());
		String timestampstr = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");
		
		List<Object[]> clusterLabList = dao.getClusterLabListByClusterId(clusterId);
		String clusterLabCode = clusterLabList!=null && clusterLabList.size()>0 ?clusterLabList.stream().filter(e -> e[3].toString().equalsIgnoreCase("Y")).collect(Collectors.toList()).get(0)[2].toString():"";
		String Path = clusterLabCode + "\\CCM\\Achievements\\";
		
		// Image file save handling
		if (imageAttachment != null && !imageAttachment.isEmpty()) {
			 achmnts.setImageName("Image-" + timestampstr + "." + imageAttachment.getOriginalFilename().split("\\.")[1]);
             saveFile(uploadpath + Path, achmnts.getImageName(), imageAttachment);
         }
		
		// PDF / PPT file save handling
		if (pdfAttachment != null && !pdfAttachment.isEmpty()) {
			 achmnts.setAttachmentName("Attachment-" + timestampstr + "." + pdfAttachment.getOriginalFilename().split("\\.")[1]);
            saveFile(uploadpath + Path, achmnts.getAttachmentName(), pdfAttachment);
        }
		
		// Video file save handling
		if (videoAttachment != null && !videoAttachment.isEmpty()) {
			achmnts.setVideoName("Video-" + timestampstr + "." + videoAttachment.getOriginalFilename().split("\\.")[1]);
			saveFile(uploadpath + Path, achmnts.getVideoName(), videoAttachment);
		}
		
		return dao.addCCMAchievements(achmnts);
	}

	@Override
	public int ccmAchievementDelete(String achievementId) throws Exception {
		
		return dao.ccmAchievementDelete(achievementId);
	}

	@Override
	public List<Object[]> getCashOutGoList(String labCode) throws Exception {
		
		return dao.getCashOutGoList(labCode);
	}

	@Override
	public long addPFMSCCMData(PFMSCCMData ccmData) throws Exception {
		
		return dao.addPFMSCCMData(ccmData);
	}
	
	@Override
	public List<Object[]> getProjectListByLabCode(String labCode) throws Exception {
		
		return dao.getProjectListByLabCode(labCode);
	}

	@Override
	public CCMPresentationSlides getCCMPresentationSlidesByScheduleId(String scheduleId) throws Exception {
		
		return dao.getCCMPresentationSlidesByScheduleId(scheduleId);
	}
	
	@Override
	public CCMPresentationSlides getCCMPresentationSlidesById(String ccmPresSlideId) throws Exception {
		
		return dao.getCCMPresentationSlidesById(ccmPresSlideId);
	}
	
	@Override
	public long addCCMPresentationSlides(CCMPresentationSlides slide) throws Exception {

		return dao.addCCMPresentationSlides(slide);
	}
	
	@Override
	public Long getLastScheduleIdFromCurrentScheduleId(String ccmScheduleId) throws Exception {

		return dao.getLastScheduleIdFromCurrentScheduleId(ccmScheduleId);
	}
	
	@Override
	public List<String> getPreviousScheduleMinutesIds(String scheduleId) throws Exception {

		return dao.getPreviousScheduleMinutesIds(scheduleId);
	}
	
}

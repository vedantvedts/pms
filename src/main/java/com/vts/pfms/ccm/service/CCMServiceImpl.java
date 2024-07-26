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
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

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
import com.vts.pfms.ccm.model.CCMSchedule;
import com.vts.pfms.ccm.model.CCMScheduleAgenda;
import com.vts.pfms.committee.dao.CommitteeDao;
import com.vts.pfms.committee.dto.CommitteeMembersEditDto;
import com.vts.pfms.committee.model.CommitteeMember;

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
			// Chairperson Add / Edit
			CommitteeMember mem1 = action.equalsIgnoreCase("Add")? new CommitteeMember() : dao.getCommitteeMemberById(dto.getChairpersonmemid());
			mem1.setCommitteeMainId(Long.parseLong(dto.getCommitteemainid()));
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
				mem1.setCommitteeMainId(Long.parseLong(dto.getCommitteemainid()));
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
			mem1.setCommitteeMainId(Long.parseLong(dto.getCommitteemainid()));
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
				mem1.setCommitteeMainId(Long.parseLong(dto.getCommitteemainid()));
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
			
			return 1;

		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside CCMServiceImpl ccmCommitteeMainMembersUpdate "+e);
			return 0;
		}
		
	}

	@Override
	public List<CCMSchedule> getCCMScheduleList(String year) throws Exception {
		
		return dao.getCCMScheduleList(year);
	}

	@Override
	public CCMSchedule getCCMScheduleById(String ccmScheduleId) throws Exception {
		
		return dao.getCCMScheduleById(ccmScheduleId);
	}

	@Override
	public long addCCMSchedule(CCMSchedule ccmSchedule, String labcode) throws Exception {
		if(ccmSchedule.getCCMScheduleId()==null) {
			LocalDate localDate = LocalDate.parse(ccmSchedule.getMeetingDate().substring(0, 10));
			String month = localDate.getMonth().toString().substring(0, 3);
			long maxCCMScheduleIdForMonth = dao.getMaxCCMScheduleIdForMonth(month);
			ccmSchedule.setMeetingRefNo(labcode+"/CCM/"+(localDate.getYear())+"/"+month+"/"+(maxCCMScheduleIdForMonth+1));
		}
		
		return dao.addCCMSchedule(ccmSchedule);
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
	                CCMScheduleAgenda agenda = new CCMScheduleAgenda();
	                agenda.setCCMScheduleId(Long.parseLong(ccmScheduleId));
	                agenda.setParentScheduleAgendaId(0L);
	                agenda.setAgendaPriority(++mainpriority);
	                agenda.setAgendaItem(req.getParameter("agenda[" + i + "].agendaItem"));
	                agenda.setPresenterLabCode(req.getParameter("agenda[" + i + "].prepsLabCode"));
	                agenda.setPresenterId(req.getParameter("agenda[" + i + "].presenterId"));
	                //agenda.setStartTime(req.getParameter("agenda[" + i + "].startTime"));
	                //agenda.setEndTime(req.getParameter("agenda[" + i + "].endTime"));
	                agenda.setDuration(Integer.parseInt(req.getParameter("agenda[" + i + "].duration")));
	                agenda.setCreatedBy(UserId);
	                agenda.setCreatedDate(sdtf.format(new Date()));
	                agenda.setIsActive(1);
	                
	                Timestamp instant = Timestamp.from(Instant.now());
					String timestampstr = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");
					
	                MultipartFile attachment = fileMap.get("agenda[" + i + "].attachment");
	                if (attachment != null && !attachment.isEmpty()) {
	                    agenda.setAttatchmentPath("File-" + timestampstr + "." + FilenameUtils.getExtension(attachment.getOriginalFilename()));
	                    saveFile(uploadpath + Path, agenda.getAttatchmentPath(), attachment);
	                } else {
	                    agenda.setAttatchmentPath(null);
	                }
	                
	                Long scheduleAgendaId = dao.addCCMScheduleAgenda(agenda);

	                // sub-agenda 
	                int j = 0;
	                int subpriority=0;
	                int maxSubAgendaIndex = getMaxSubAgendaIndex(req, "agenda[" + i + "].subAgendas");
	                for (j = 0; j <= maxSubAgendaIndex; j++) {
	                    if (req.getParameter("agenda[" + i + "].subAgendas[" + j + "].agendaItem") != null && !req.getParameter("agenda[" + i + "].subAgendas[" + j + "].agendaItem").isEmpty()) {
	                        CCMScheduleAgenda subagenda = new CCMScheduleAgenda();
	                        subagenda.setCCMScheduleId(Long.parseLong(ccmScheduleId));
	                        subagenda.setParentScheduleAgendaId(scheduleAgendaId);
	                        subagenda.setAgendaPriority(++subpriority);
	                        subagenda.setAgendaItem(req.getParameter("agenda[" + i + "].subAgendas[" + j + "].agendaItem"));
	                        subagenda.setPresenterLabCode(req.getParameter("agenda[" + i + "].subAgendas[" + j + "].prepsLabCode"));
	                        subagenda.setPresenterId(req.getParameter("agenda[" + i + "].subAgendas[" + j + "].presenterId"));
	                        subagenda.setDuration(Integer.parseInt(req.getParameter("agenda[" + i + "].subAgendas[" + j + "].duration")));
	                        //subagenda.setStartTime(req.getParameter("agenda[" + i + "].subAgendas[" + j + "].startTime"));
	                        //subagenda.setEndTime(req.getParameter("agenda[" + i + "].subAgendas[" + j + "].endTime"));
	                        subagenda.setDuration(0);
	                        subagenda.setCreatedBy(UserId);
	                        subagenda.setCreatedDate(sdtf.format(new Date()));
	                        subagenda.setIsActive(1);
	                        
	                        Timestamp instant2 = Timestamp.from(Instant.now());
	        				String timestampstr2 = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");
	        				
	                        MultipartFile subattachment = fileMap.get("agenda[" + i + "].subAgendas[" + j + "].attachment");
	                        if (subattachment != null && !subattachment.isEmpty()) {
	                            subagenda.setAttatchmentPath("File-" + timestampstr + "." + FilenameUtils.getExtension(subattachment.getOriginalFilename()));
	                            saveFile(uploadpath + Path, subagenda.getAttatchmentPath(), subattachment);
	                        } else {
	                            subagenda.setAttatchmentPath(null);
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
	public CCMScheduleAgenda getCCMScheduleAgendaById(String ccmScheduleAgendaId) throws Exception {
		
		return dao.getCCMScheduleAgendaById(ccmScheduleAgendaId);
	}

	@Override
	public Long addCCMScheduleAgenda(CCMScheduleAgenda agenda, MultipartFile attachment, String labcode) throws Exception {
		try {
			Timestamp instant = Timestamp.from(Instant.now());
	        String timestampstr = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");

	        String Path = labcode + "\\CCM\\";
			if (attachment != null && !attachment.isEmpty()) {
                agenda.setAttatchmentPath("File-" + timestampstr + "." + FilenameUtils.getExtension(attachment.getOriginalFilename()));
                saveFile(uploadpath + Path, agenda.getAttatchmentPath(), attachment);
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
			for(int i=0; i<agendaItem.length; i++) {
				CCMScheduleAgenda agenda = new CCMScheduleAgenda();
                agenda.setCCMScheduleId(Long.parseLong(ccmScheduleId));
                agenda.setParentScheduleAgendaId(Long.parseLong(scheduleAgendaId));
                agenda.setAgendaPriority(++subPriority);
                agenda.setAgendaItem(agendaItem[i]);
                agenda.setPresenterLabCode(prepsLabCode[i]);
                agenda.setPresenterId(presenterId[i]);
                agenda.setDuration(Integer.parseInt(duration[i]));
                agenda.setCreatedBy(userId);
                agenda.setCreatedDate(sdtf.format(new Date()));
                agenda.setIsActive(1);
                
                Timestamp instant = Timestamp.from(Instant.now());
				String timestampstr = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");
				
                if (attachments[i] != null && !attachments[i].isEmpty()) {
                    agenda.setAttatchmentPath("File-" + timestampstr + "." + FilenameUtils.getExtension(attachments[i].getOriginalFilename()));
                    saveFile(uploadpath + Path, agenda.getAttatchmentPath(), attachments[i]);
                } else {
                    agenda.setAttatchmentPath(null);
                }
                
                dao.addCCMScheduleAgenda(agenda);
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
			List<Object[]> ccmScheduleAgendasAfter = dao.getCCMScheduleAgendasAfter(ccmScheduleId, agendaPriority, parentScheduleAgendaId);
			System.out.println("ccmScheduleAgendasAfter.size(): "+ccmScheduleAgendasAfter.size());
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
}

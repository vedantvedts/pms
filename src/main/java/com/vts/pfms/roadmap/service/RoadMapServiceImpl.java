package com.vts.pfms.roadmap.service;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vts.pfms.FormatConverter;
import com.vts.pfms.cars.dao.CARSDao;
import com.vts.pfms.committee.model.PfmsNotification;
import com.vts.pfms.roadmap.dao.RoadMapDao;
import com.vts.pfms.roadmap.dto.RoadMapApprovalDTO;
import com.vts.pfms.roadmap.dto.RoadMapDetailsDTO;
import com.vts.pfms.roadmap.model.AnnualTargets;
import com.vts.pfms.roadmap.model.RoadMap;
import com.vts.pfms.roadmap.model.RoadMapAnnualTargets;
import com.vts.pfms.roadmap.model.RoadMapTrans;

@Service
public class RoadMapServiceImpl implements RoadMapService{

	private static final Logger logger = LogManager.getLogger(RoadMapServiceImpl.class);

	FormatConverter fc = new FormatConverter();
	private SimpleDateFormat sdtf = fc.getSqlDateAndTimeFormat();
	private SimpleDateFormat sdf = fc.getSqlDateFormat();
	private SimpleDateFormat rdf=new SimpleDateFormat("dd-MM-yyyy");
	private SimpleDateFormat sdf2=new SimpleDateFormat("dd-MMM-yyyy");
	
	@Autowired
	RoadMapDao dao;
	
	@Autowired
	CARSDao carsdao;
	
	@Override
	public List<Object[]> roadMapList() throws Exception {
		
		return dao.roadMapList();
	}

	@Override
	public List<Object[]> divisionList(String labCode) throws Exception {
		
		return dao.divisionList(labCode);
	}

	@Override
	public List<Object[]> getProjectList(String labCode) throws Exception {
		
		return dao.getProjectList(labCode);
	}

	@Override
	public List<Object[]> getPreProjectList(String labcode) throws Exception {
		
		return dao.getPreProjectList(labcode);
	}

	@Override
	public Object[] getProjectDetails(String labcode, String projectId, String roadMapType) throws Exception {
		
		return dao.getProjectDetails(labcode, projectId, roadMapType);
	}

	@Override
	public RoadMap getRoadMapDetailsById(String roadMapId) throws Exception {
		
		return dao.getRoadMapDetailsById(roadMapId);
	}

	@Override
	public List<RoadMapAnnualTargets> getRoadMapAnnualTargetDetails(String roadMapId) throws Exception {
		
		return dao.getRoadMapAnnualTargetDetails(roadMapId);
	}

	@Override
	public long addRoadMapDetails(RoadMap roadMap) throws Exception {
		
		return dao.addRoadMapDetails(roadMap);
	}
	
	@Override
	public long addRoadMapDetails(RoadMapDetailsDTO dto) throws Exception {
		try {
			RoadMap roadMap = dto.getAction()!=null && dto.getAction().equalsIgnoreCase("Add")?new RoadMap(): dao.getRoadMapDetailsById(dto.getRoadMapId());
			
			roadMap.setRoadMapType(dto.getRoadMapType());
			roadMap.setProjectId(dto.getRoadMapType().equalsIgnoreCase("E")?(dto.getProjectId()!=null?Long.parseLong(dto.getProjectId()):0):0);
			roadMap.setInitiationId(dto.getRoadMapType().equalsIgnoreCase("P")?(dto.getInitiationId()!=null?Long.parseLong(dto.getInitiationId()):0):0);
			roadMap.setProjectTitle(dto.getProjectTitle());
			roadMap.setDivisionId(dto.getRoadMapType().equalsIgnoreCase("N")?(dto.getDivisionId()!=null?Long.parseLong(dto.getDivisionId()):0):0);
			roadMap.setStartDate(fc.RegularToSqlDate(dto.getStartDate()));
			roadMap.setEndDate(fc.RegularToSqlDate(dto.getEndDate()));
			roadMap.setDuration(fc.getDurationInMonths(dto.getStartDate(), dto.getEndDate()));
			roadMap.setAimObjectives(dto.getAimObjectives());
			roadMap.setScope(dto.getScope());
			roadMap.setReference(dto.getReference());
			roadMap.setOtherReference(dto.getOtherReference());
			roadMap.setProjectCost(dto.getProjectCost());
			
			System.out.println("dto.getAnnualYear().length: "+dto.getAnnualYear().length);

			// Remove Previously added Road Map Annual Targets
			dao.removeRoadMapAnnualTargets(dto.getRoadMapId());
			
			// Storing list of Annual Targets
			List<RoadMapAnnualTargets> roadMapAnnualTargets = new ArrayList<RoadMapAnnualTargets>();
			
			for(int i=0;i<dto.getAnnualYear().length;i++) {
				List<String[]> annualTargetList = dto.getAnnualTargetList();
				String[] annualTargets = annualTargetList.get(i);
				if(annualTargets!=null && annualTargets.length>0) {
					for(int j=0;j<annualTargets.length;j++) {
						RoadMapAnnualTargets targets = new RoadMapAnnualTargets();
						AnnualTargets at = dao.getAnnualTargetsById(annualTargets[j]);
						targets.setAnnualYear(dto.getAnnualYear()[i]);
						targets.setAnnualTargets(at);
						targets.setRoadMap(roadMap);
						targets.setCreatedBy(dto.getUsername());
						targets.setCreatedDate(sdtf.format(new Date()));
						targets.setIsActive(1);
						roadMapAnnualTargets.add(targets);
					}
				}
				
//				targets.setAnnualTarget(dto.getAnnualTarget()[i]);
//				targets.setOthers(dto.getOthers()[i]);
				
			}
			
			roadMap.setRoadMapAnnualTargets(roadMapAnnualTargets);
			
			if(dto.getAction()!=null && dto.getAction().equalsIgnoreCase("Add")) {
				roadMap.setMovedToASP("N");
				roadMap.setRoadMapStatusCode("RIN");
				roadMap.setCreatedBy(dto.getUsername());
				roadMap.setCreatedDate(sdtf.format(new Date()));
				roadMap.setIsActive(1);
				
				// Transaction
				List<RoadMapTrans> transactionList = new ArrayList<RoadMapTrans>();
				
				RoadMapTrans transaction = RoadMapTrans.builder()
										   .roadMap(roadMap)
										   .RoadMapStatusCode("RIN")
										   .ActionBy(dto.getEmpId())
										   .ActionDate(sdtf.format(new Date()))
										   .build();
				transactionList.add(transaction);
				roadMap.setRoadMapTrans(transactionList);
			}else {
				roadMap.setModifiedBy(dto.getUsername());
				roadMap.setModifiedDate(sdtf.format(new Date()));
				
			}
			
			return dao.addRoadMapDetails(roadMap);
		}catch (Exception e) {
			logger.error(new Date()+" Inside RoadMapServiceImpl addRoadMapDetails() "+e);
			e.printStackTrace();
			return 0;
		}
		
	}

	@Override
	public int removeRoadMapDetails(String roadMapId, String userId) throws Exception {
		
		return dao.removeRoadMapDetails(roadMapId, userId);
	}

	@Override
	public List<Object[]> roadMapTransApprovalData(String roadMapId) {
		
		return dao.roadMapTransApprovalData(roadMapId);
	}

	@Override
	public List<Object[]> roadMapTransList(String roadMapId) throws Exception {
		
		return dao.roadMapTransList(roadMapId);
	}

	@Override
	public List<Object[]> roadMapRemarksHistory(String roadMapId) throws Exception {
		
		return dao.roadMapRemarksHistory(roadMapId);
	}
	
	@Override
	public long roadMapApprovalForward(RoadMapApprovalDTO dto) throws Exception {
		
		try {
			String roadMapId = dto.getRoadMapId();
			String action = dto.getAction();
			String EmpId = dto.getEmpId();
			
			RoadMap roadMap = dao.getRoadMapDetailsById(roadMapId);
			String roadMapStatusCode = roadMap.getRoadMapStatusCode();
			
			List<String> roadmapforward = Arrays.asList("RIN","RRD","RRA","RRV");
			// This is for the moving the approval flow in forward direction.
			if(action.equalsIgnoreCase("A")) {
				if(roadmapforward.contains(roadMapStatusCode)) {
					if(roadMapStatusCode.equalsIgnoreCase("RIN")) {
						roadMap.setInitiatedBy(Long.parseLong(EmpId));
						roadMap.setInitiationDate(sdf.format(new Date()));
					}
					roadMap.setRoadMapStatusCode("RFW");
					
				}else {
					roadMap.setRoadMapStatusCode("RAD");
				}
			}
			// This is for return the approval form to the user or initiator. 
			else if(action.equalsIgnoreCase("R")){
				if(roadMapStatusCode.equalsIgnoreCase("RFW")) {
					roadMap.setRoadMapStatusCode("RRD");
				}
			}
			
			// Transaction
			List<RoadMapTrans> transactionList = new ArrayList<RoadMapTrans>();
			
			RoadMapTrans transaction = RoadMapTrans.builder()
									   .roadMap(roadMap)
									   .RoadMapStatusCode(roadMap.getRoadMapStatusCode())
									   .Remarks(dto.getRemarks())
									   .ActionBy(dto.getEmpId())
									   .ActionDate(sdtf.format(new Date()))
									   .build();
			transactionList.add(transaction);
			roadMap.setRoadMapTrans(transactionList);
			
			dao.addRoadMapDetails(roadMap);
			
			Object[] Director = carsdao.getLabDirectorData(dto.getLabCode());
			
			// Notification
			PfmsNotification notification = new PfmsNotification();
			if(action.equalsIgnoreCase("A")) {
				
				if(roadMap.getRoadMapStatusCode().equalsIgnoreCase("RFW")) {
					notification.setEmpId(Long.parseLong(Director[0].toString()));
					notification.setNotificationUrl("RoadMapApprovals.htm");
					notification.setNotificationMessage("Road Map Requested by DP&C");
				}else if(roadMap.getRoadMapStatusCode().equalsIgnoreCase("RAD")) {
					notification.setEmpId(roadMap.getInitiatedBy());
					notification.setNotificationUrl("RoadMapList.htm");
					notification.setNotificationMessage("Road Map Request Recommended");
				}
				
				notification.setNotificationby(Long.parseLong(EmpId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(dto.getUserId());
				notification.setCreatedDate(sdtf.format(new Date()));

				carsdao.addNotifications(notification);
			}
			else if(action.equalsIgnoreCase("R")){
				notification.setEmpId(roadMap.getInitiatedBy());
				notification.setNotificationUrl("RoadMapList.htm");
				notification.setNotificationMessage("Road Map Request Returned");
				notification.setNotificationby(Long.parseLong(EmpId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(dto.getUserId());
				notification.setCreatedDate(sdtf.format(new Date()));
			
				carsdao.addNotifications(notification);
			}
			return 1;
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside RoadMapServiceImpl roadMapApprovalForward "+e);
			return 0;
		}
	}

	@Override
	public long roadMapUserRevoke(String roadMapId, String userId, String empId) throws Exception {
		
		return roadMapStatusHandler(roadMapId,userId,empId,"RRV");
	}
	
	public long roadMapStatusHandler(String roadMapId, String userId, String empId, String roadMapStatusCode) throws Exception {
		try {
			
			RoadMap roadMap = dao.getRoadMapDetailsById(roadMapId);
			roadMap.setRoadMapStatusCode(roadMapStatusCode);
			if(roadMapStatusCode.equalsIgnoreCase("RMA")) {
				roadMap.setMovedToASP("Y");
				roadMap.setMovedToASPDate(sdf.format(new Date()));
			}else if(roadMapStatusCode.equalsIgnoreCase("RRA")) {
				roadMap.setMovedToASP("N");			
			}
			
			// Transaction
			List<RoadMapTrans> transactionList = new ArrayList<RoadMapTrans>();
			
			RoadMapTrans transaction = RoadMapTrans.builder()
									   .roadMap(roadMap)
									   .RoadMapStatusCode(roadMap.getRoadMapStatusCode())
									   .ActionBy(empId)
									   .ActionDate(sdtf.format(new Date()))
									   .build();
			transactionList.add(transaction);
			roadMap.setRoadMapTrans(transactionList);
						
			return dao.addRoadMapDetails(roadMap);
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
	}

	@Override
	public long roadMapDetailsMoveToASP(String roadMapId, String userId, String empId) throws Exception {
		
		return roadMapStatusHandler(roadMapId,userId,empId,"RMA");
	}

	@Override
	public List<Object[]> roadMapPendingList(String empId, String labCode) throws Exception {
		
		return dao.roadMapPendingList(empId, labCode);
	}

	@Override
	public List<Object[]> roadMapApprovedList(String empId, String fromDate, String toDate) throws Exception {
		
		return dao.roadMapApprovedList(empId, fromDate, toDate);
	}

	@Override
	public List<RoadMap> getRoadMapList() throws Exception {
		
		return dao.getRoadMapList();
	}

	@Override
	public List<Object[]> roadMapASPList() throws Exception {
		
		return dao.roadMapASPList();
	}
	
	@Override
	public long roadMapDetailsMoveBackToRoadMap(String roadMapId, String userId, String empId) throws Exception {
		
		return roadMapStatusHandler(roadMapId,userId,empId,"RRA");
	}

	@Override
	public List<AnnualTargets> getAnnualTargetsFromMaster() throws Exception {
		
		return dao.getAnnualTargetsFromMaster();
	}

	@Override
	public Long addAnnualTargets(AnnualTargets targets) throws Exception {
		
		return dao.addAnnualTargets(targets);
	}

	@Override
	public List<Object[]> getProjectMilestoneActivityList(String labCode) throws Exception {
		
		return dao.getProjectMilestoneActivityList(labCode);
	}
	
	@Override
	public List<Object[]> getPreProjectMilestoneActivityList() throws Exception {

		return dao.getPreProjectMilestoneActivityList();
	}
}

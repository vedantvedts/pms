package com.vts.pfms.requirements.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.vts.pfms.project.dao.ProjectDaoImpl;

@Transactional
@Repository
public class RequirementDaoImpl implements RequirementDao {
	private static final Logger logger=LogManager.getLogger(RequirementDaoImpl.class);
	java.util.Date loggerdate=new java.util.Date();
	
	@PersistenceContext
	EntityManager manager;
	
	
	private static final String REQLIST="SELECT a.InitiationReqId, a.requirementid,a.reqtypeid,a.requirementbrief,a.requirementdesc,a.priority,a.needtype,a.remarks,a.category,a.constraints,a.linkedrequirements,a.linkedDocuments,a.linkedPara,a.ProjectId FROM pfms_initiation_req a WHERE initiationid=:initiationid AND ProjectId=:ProjectId AND isActive='1' ORDER BY reqCount";
	@Override
	public List<Object[]> RequirementList(String intiationId,String projectId) throws Exception {
		// TODO Auto-generated method stub
		 Query query=manager.createNativeQuery(REQLIST);
		 query.setParameter("initiationid", intiationId);
		 query.setParameter("ProjectId", projectId);
		 List<Object[]> RequirementList=(List<Object[]> )query.getResultList();	
		return RequirementList;
	}
	
}

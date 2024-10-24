package com.vts.pfms.ms.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.vts.pfms.model.LabMaster;

@Repository
@Transactional
public class MSReqDaoImpl implements MSReqDao {

	private static final Logger logger = LogManager.getLogger(MSReqDaoImpl.class);
	
	@PersistenceContext
	EntityManager manager;
	
	@Override
	public List<LabMaster> getAllLabList() throws Exception {
		try {
			Query query = manager.createQuery("FROM LabMaster");
			return query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+ " Inside MSDaoImpl getAllLabList "+e);
			return new ArrayList<>();
		}
	}
}

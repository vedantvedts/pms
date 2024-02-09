package com.vts.pfms.producttree.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Repository;


import com.vts.pfms.producttree.model.ProductTree;

@Transactional
@Repository



public class ProductTreeDaoImpl implements ProductTreeDao{
	
	
	@PersistenceContext
	EntityManager manager;
	
	private static final Logger logger=LogManager.getLogger(ProductTreeDaoImpl.class);


	private static final String PRODUCTTREELIST="SELECT a.MainId,a.parentlevelid,a.levelid,a.levelname,a.projectid,b.ProjectName FROM pfms_product_tree a,project_master b WHERE MainId>0 AND a.projectid=b.projectid AND b.projectid=:projectId ORDER BY parentlevelid";
	
	
	@Override
	public long AddLevelName(ProductTree prod) throws Exception {
		manager.persist(prod);
		manager.flush();
		return prod.getMainId();
	}


	@Override
	public List<Object[]> getProductTreeList(String projectId) throws Exception {
		
        Query query=manager.createNativeQuery(PRODUCTTREELIST);
		query.setParameter("projectId", projectId);
		List<Object[]> ProductTreeList=(List<Object[]>)query.getResultList();		

		return ProductTreeList;
	}

}

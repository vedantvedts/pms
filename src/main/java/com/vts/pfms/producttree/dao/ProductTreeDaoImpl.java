package com.vts.pfms.producttree.dao;

import java.util.Date;
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


	private static final String PRODUCTTREELIST="SELECT a.MainId,a.parentlevelid,a.levelid,a.levelname,a.projectid,b.ProjectName,a.Stage,a.Module FROM pfms_product_tree a,project_master b WHERE MainId>0 AND a.projectid=b.projectid AND b.projectid=:projectId and a.isActive='1' ORDER BY parentlevelid";
	private static final String LEVELNAMEDELETE="UPDATE pfms_product_tree AS t1\r\n"
			+ "LEFT JOIN pfms_product_tree AS t2 ON t1.mainid = t2.parentlevelid\r\n"
			+ "LEFT JOIN pfms_product_tree AS t3 ON t2.mainid = t3.parentlevelid\r\n"
			+ "LEFT JOIN pfms_product_tree AS t4 ON t3.mainid = t4.parentlevelid\r\n"
			+ "SET t1.isActive = 0,t2.isActive = 0,t3.isActive = 0,t4.isActive = 0\r\n"
			+ "WHERE t1.mainid = :mainid  OR t2.mainid = :mainid OR t3.mainid = :mainid OR t4.mainid = :mainid";
	
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


	@Override
	public ProductTree getLevelNameById(long mainId) throws Exception {
		
		try {
			ProductTree mainid = manager.find(ProductTree.class, (mainId));
			return mainid;
		} catch (Exception e) {
			logger.error(new Date() + "Inside DAO getLevelNameById() "+e);
			e.printStackTrace();
			return null;
		}	
		
		
	}


	@Override
	public long LevelNameEdit(ProductTree pt) throws Exception {
		
		
		manager.merge(pt);
		manager.flush();
		return pt.getMainId();
	}


	@Override
	public long LevelNameDelete(ProductTree pt) throws Exception {
		
		Query query=manager.createNativeQuery(LEVELNAMEDELETE);
		
		query.setParameter("mainid", pt.getMainId());
		long count= (long) query.executeUpdate();
		
		return count;
	
		
	}

}

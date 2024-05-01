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
import com.vts.pfms.producttree.model.ProductTreeRev;

@Transactional
@Repository



public class ProductTreeDaoImpl implements ProductTreeDao{
	
	
	@PersistenceContext
	EntityManager manager;
	
	private static final Logger logger=LogManager.getLogger(ProductTreeDaoImpl.class);


	private static final String PRODUCTTREELIST="SELECT a.MainId,a.parentlevelid,a.levelid,a.levelname,a.projectid,b.ProjectName,a.Stage,a.Module,a.SubLevelId FROM pfms_product_tree a,project_master b WHERE MainId>0 AND a.projectid=b.projectid AND b.projectid=:projectId and a.isActive='1' ORDER BY parentlevelid";
	private static final String LEVELNAMEDELETE="UPDATE pfms_product_tree AS t1\r\n"
			+ "	LEFT JOIN pfms_product_tree AS t2 ON t1.mainid = t2.parentlevelid\r\n"
			+ "	LEFT JOIN pfms_product_tree AS t3 ON t2.mainid = t3.parentlevelid\r\n"
			+ "	LEFT JOIN pfms_product_tree AS t4 ON t3.mainid = t4.parentlevelid\r\n"
			+ "	LEFT JOIN pfms_product_tree AS t5 ON t4.parentlevelid = t5.mainid\r\n"
			+ "	LEFT JOIN pfms_product_tree AS t6 ON t5.parentlevelid = t6.mainid\r\n"
			+ "	LEFT JOIN pfms_product_tree AS t7 ON t6.parentlevelid = t7.mainid\r\n"
			+ "	SET\r\n"
			+ "	    t1.isActive = CASE WHEN t1.mainid = :mainid OR t1.parentlevelid = :mainid THEN 0 ELSE 1 END,\r\n"
			+ "	    t2.isActive = CASE WHEN t2.mainid = :mainid OR t2.parentlevelid = :mainid THEN 0 ELSE 1 END,\r\n"
			+ "	    t3.isActive = CASE WHEN t3.mainid = :mainid OR t3.parentlevelid = :mainid THEN 0 ELSE 1 END,\r\n"
			+ "	    t4.isActive = CASE WHEN t4.mainid = :mainid OR t4.parentlevelid = :mainid THEN 0 ELSE 1 END,\r\n"
			+ "	    t5.isActive = CASE WHEN t5.mainid = :mainid OR t5.parentlevelid = :mainid THEN 0 ELSE 1 END ,\r\n"
			+ "	    t6.isActive = CASE WHEN t6.mainid = :mainid OR t6.parentlevelid = :mainid THEN 0 ELSE 1 END , \r\n"
			+ "	    t7.isActive = CASE WHEN t7.mainid = :mainid OR t7.parentlevelid = :mainid THEN 0 ELSE 1 END \r\n"
			+ "\r\n"
			+ "	WHERE \r\n"
			+ "	t1.mainid = :mainid  OR t2.mainid = :mainid OR t3.mainid = :mainid OR t4.mainid = :mainid OR t5.mainid=:mainid\r\n"
			+ "	OR t6.mainid=:mainid OR t7.mainid=:mainid";
	
	private static final String REVISIONCOUNT="SELECT DISTINCT RevisionNo,DATE(CreatedDate),projectid FROM pfms_product_tree_rev WHERE projectid=:projectId ORDER BY RevisionNo DESC ";
	private static final String PRODUCTTREEREVISIONLIST="SELECT a.MainId,a.parentlevelid,a.levelid,a.levelname,a.projectid,b.ProjectName,a.Stage,a.Module,a.RevisionNo FROM pfms_product_tree_rev a,project_master b WHERE MainId>0 AND a.projectid=b.projectid AND b.projectid=:projectId AND a.isActive='1' AND a.RevisionNo=:revisionCount ORDER BY parentlevelid";
	
	
	
	
	
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


	@Override
	public long ProductTreeRevise(ProductTreeRev rev) throws Exception{
		
		manager.persist(rev);
		manager.flush();
		return rev.getRevId();
	}


	@Override
	public List<Object[]> getRevisionCount(String projectId) throws Exception{
		
		    Query query=manager.createNativeQuery(REVISIONCOUNT);
			query.setParameter("projectId", projectId);
			List<Object[]> RevisionCount=(List<Object[]>)query.getResultList();		

			return RevisionCount;
	}


	@Override
	public List<Object[]> getProductRevTreeList(String projectId, String revisionCount) throws Exception {
		
		 Query query=manager.createNativeQuery(PRODUCTTREEREVISIONLIST);
			query.setParameter("projectId", projectId);
			query.setParameter("revisionCount", revisionCount);
			List<Object[]> getProductRevTreeList=(List<Object[]>)query.getResultList();		

			return getProductRevTreeList;
	}

}

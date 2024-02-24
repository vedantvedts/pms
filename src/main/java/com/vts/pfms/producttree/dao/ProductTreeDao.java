package com.vts.pfms.producttree.dao;

import java.util.List;

import com.vts.pfms.producttree.model.ProductTree;
import com.vts.pfms.producttree.model.ProductTreeRev;

public interface ProductTreeDao {

	public long AddLevelName(ProductTree prod) throws Exception;

	public List<Object[]> getProductTreeList(String projectId) throws Exception;

	public ProductTree getLevelNameById(long mainId)  throws Exception;

	public long LevelNameEdit(ProductTree pt) throws Exception;

	public long LevelNameDelete(ProductTree pt) throws Exception;

	public List<Object[]> getRevisionCount(String projectId)throws Exception;

	public long ProductTreeRevise(ProductTreeRev rev)throws Exception;

	public List<Object[]> getProductRevTreeList(String projectId, String revisionCount) throws Exception;

	

}

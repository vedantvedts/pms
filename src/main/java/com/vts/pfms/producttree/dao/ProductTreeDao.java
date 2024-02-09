package com.vts.pfms.producttree.dao;

import java.util.List;

import com.vts.pfms.producttree.model.ProductTree;

public interface ProductTreeDao {

	public long AddLevelName(ProductTree prod) throws Exception;

	public List<Object[]> getProductTreeList(String projectId) throws Exception;

}

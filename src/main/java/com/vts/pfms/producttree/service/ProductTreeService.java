package com.vts.pfms.producttree.service;

import java.util.List;

import com.vts.pfms.producttree.dto.ProductTreeDto;
import com.vts.pfms.producttree.model.ProductTreeRev;

public interface ProductTreeService {

	public long AddLevelName(ProductTreeDto dto) throws Exception;

	public List<Object[]> getProductTreeList(String projectId) throws Exception;

	public long LevelNameEdit(ProductTreeDto dto,String Action) throws Exception;

	public long ProductTreeRevise(ProductTreeRev rev) throws Exception;

	public List<Object[]> getRevisionCount(String projectId) throws Exception;

	public List<Object[]> getProductRevTreeList(String projectId,String RevisionCount)throws Exception;

}

package com.vts.pfms.producttree.service;

import java.util.List;

import com.vts.pfms.producttree.dto.ProductTreeDto;

public interface ProductTreeService {

	public long AddLevelName(ProductTreeDto dto) throws Exception;

	public List<Object[]> getProductTreeList(String projectId) throws Exception;

}

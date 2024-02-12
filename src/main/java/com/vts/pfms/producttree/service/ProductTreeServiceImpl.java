package com.vts.pfms.producttree.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.vts.pfms.FormatConverter;
import com.vts.pfms.producttree.dao.ProductTreeDao;
import com.vts.pfms.producttree.dto.ProductTreeDto;
import com.vts.pfms.producttree.model.ProductTree;

@Service
public class ProductTreeServiceImpl implements ProductTreeService {

	@Autowired
	ProductTreeDao dao;
	
	FormatConverter fc=new FormatConverter();
	private  SimpleDateFormat rdf=fc.getRegularDateFormat();
	private  SimpleDateFormat sdf=fc.getSqlDateFormat();
	private  SimpleDateFormat sdtf=fc.getSqlDateAndTimeFormat();
	private  SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
	
	@Override
	public long AddLevelName(ProductTreeDto dto) throws Exception {
		
		
		ProductTree prod=new ProductTree();
		prod.setProjectId(dto.getProjectId());
		prod.setParentLevelId(dto.getParentLevelId());
		prod.setLevelId(dto.getLevelId());
		prod.setLevelName(dto.getLevelName());
		prod.setCreatedBy(dto.getCreatedBy());
		prod.setCreatedDate(fc.getSqlDateAndTimeFormat().format(new Date()));
		prod.setIsActive(1);
		
		return dao.AddLevelName(prod);
	}

	@Override
	public List<Object[]> getProductTreeList(String projectId) throws Exception {
		
		return dao.getProductTreeList(projectId);
	}

	@Override
	public long LevelNameEdit(ProductTreeDto dto,String Action) throws Exception {
		
		ProductTree pt=dao.getLevelNameById(dto.getMainId());
		
		
		if(Action.equalsIgnoreCase("E")) {
		pt.setMainId(dto.getMainId());
		pt.setLevelName(dto.getLevelName());
		pt.setStage(dto.getStage());
		pt.setModule(dto.getModule());
		pt.setModifiedBy(dto.getModifiedBy());
		pt.setModifiedDate(fc.getSqlDateAndTimeFormat().format(new Date()));
		
		return dao.LevelNameEdit(pt);
		
		}
		else if(Action.equalsIgnoreCase("D")) {
			
			pt.setMainId(dto.getMainId());
			return dao.LevelNameDelete(pt);
			
		}
		return 0;
		
		
	}
	
	
	

}

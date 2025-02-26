package com.vts.pfms.producttree.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import jakarta.persistence.criteria.CriteriaBuilder.In;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.vts.pfms.FormatConverter;
import com.vts.pfms.print.dao.PrintDao;
import com.vts.pfms.print.model.ProjectSlides;
import com.vts.pfms.producttree.dao.ProductTreeDao;
import com.vts.pfms.producttree.dto.ProductTreeDto;
import com.vts.pfms.producttree.model.ProductTree;
import com.vts.pfms.producttree.model.ProductTreeRev;
import com.vts.pfms.producttree.model.SystemProductTree;

@Service
public class ProductTreeServiceImpl implements ProductTreeService {

	@Autowired
	ProductTreeDao dao;
	@Autowired
	PrintDao printdao;
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
		prod.setSubLevelId(dto.getSubLevelId());
		prod.setLevelName(dto.getLevelName());
		prod.setCreatedBy(dto.getCreatedBy());
		prod.setCreatedDate(fc.getSqlDateAndTimeFormat().format(new Date()));
		prod.setIsActive(1);
		prod.setInitiationId(dto.getInitiationId());
		
		return dao.AddLevelName(prod);
	}

	@Override
	public List<Object[]> getProductTreeList(String projectId) throws Exception {
		
		return dao.getProductTreeList(projectId);
	}

	@Override
	public long LevelNameEdit(ProductTreeDto dto,String Action) throws Exception {
		
		ProductTree pt=dao.getLevelNameById(dto.getMainId());
		
		
		if(Action.equalsIgnoreCase("E") || Action.equalsIgnoreCase("TE")) {
		pt.setMainId(dto.getMainId());
		pt.setLevelName(dto.getLevelName());
		pt.setStage(dto.getStage());
		pt.setModule(dto.getModule());
		pt.setModifiedBy(dto.getModifiedBy());
		pt.setModifiedDate(fc.getSqlDateAndTimeFormat().format(new Date()));
		
		if(dto.getSubSystem()!=null) {
			
			String []subSystem = dto.getSubSystem().split("#");
			
			pt.setSystemMainId(Long.parseLong(subSystem[0]));
			pt.setLevelCode(subSystem[1]);
		}
		
		
		return dao.LevelNameEdit(pt);
		
		}
		else if(Action.equalsIgnoreCase("D") || Action.equalsIgnoreCase("TD")) {
			
			pt.setMainId(dto.getMainId());
			return dao.LevelNameDelete(pt);
			
		}
		return 0;
		
		
	}

	@Override
	public long ProductTreeRevise(ProductTreeRev rev ) throws Exception {
		
		
		return dao.ProductTreeRevise(rev);
		
	}

	@Override
	public List<Object[]> getRevisionCount(String projectId) throws Exception {
		
		return dao.getRevisionCount(projectId);
		
	}

	@Override
	public List<Object[]> getProductRevTreeList(String projectId,String RevisionCount) throws Exception {
		
		return dao.getProductRevTreeList(projectId,RevisionCount);
	}	
	
	@Override
	public List<Object[]> getAllSystemName() throws Exception {
		return dao.getAllSystemName();
	}
	
	@Override
	public long AddSystemLevelName(ProductTreeDto dto) throws Exception {
		SystemProductTree prod=new SystemProductTree();
		prod.setSid(dto.getProjectId());
		prod.setParentLevelId(dto.getParentLevelId());
		prod.setLevelId(dto.getLevelId());
		prod.setSubLevelId(dto.getSubLevelId());
		prod.setLevelName(dto.getLevelName());
		prod.setCreatedBy(dto.getCreatedBy());
		prod.setCreatedDate(fc.getSqlDateAndTimeFormat().format(new Date()));
		prod.setIsActive(1);
		prod.setLevelCode(dto.getLevelCode());
		return dao.AddSystemLevelName(prod);
	}
	
	@Override
	public List<Object[]> getSystemProductTreeList(String sid) throws Exception {
		return dao.getSystemProductTreeList(sid);
	}
	
	@Override
	public ProjectSlides getProjectSlides(String projectId) throws Exception {
		return dao.getProjectSlides(projectId);
	}
	
	@Override
	public long addProjectSlides(ProjectSlides ps) throws Exception {
		return printdao.AddProjectSlideData(ps);
	}
	
	@Override
	public List<Object[]> getProductTreeListInitiation(String initiationId) {
		return dao.getProductTreeListInitiation(initiationId);
	}
}
		

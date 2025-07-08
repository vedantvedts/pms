package com.vts.pfms.producttree.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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
		prod.setElementType(dto.getElementType());
		prod.setLevelCode(dto.getLevelCode());
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
		
		
//		List<String >list = new ArrayList<>();
//		List<String>mainIds = getMainIds(dto.getMainId()+"",list);
//		System.out.println(mainIds.toString()+"------");
//		for(String s:mainIds) {
//			ProductTree pt1=dao.getLevelNameById(Long.parseLong(s));
//			pt1.setMainId(Long.parseLong(s));
//			pt1.setIsSoftware(dto.getIsSoftware());
//			dao.LevelNameEdit(pt1);
//		}
//		
//		if(dto.getIsSoftware()!=null) {
//		pt.setIsSoftware(dto.getIsSoftware());	
//		}

		
		return dao.LevelNameEdit(pt);
		
		}
		else if(Action.equalsIgnoreCase("D") || Action.equalsIgnoreCase("TD")) {
			
			pt.setMainId(dto.getMainId());
			return dao.LevelNameDelete(pt);
			
		}
		return 0;
		
		
	}


//	private List<String> getMainIds(String mainId, List<String> list) {
//		try {
//		List<Object[]>subList = dao.getParentLevelIdbyMainId(mainId);
//		
//		if(subList==null || subList.size()==0) {
//			if(!list.contains(mainId)) {
//				list.add(mainId);
//			}
//		}else {
//			for(Object[]obj:subList) {
//				list.add(obj[0].toString());
//				getMainIds(obj[0].toString(),list);
//			}
//			
//		}
//		
//		
//		return list;
//		}
//		catch (Exception e) {
//		e.printStackTrace();
//		return list;
//		}
//	}
	
	private List<String> getSPTMainIds(String mainId, List<String> list) {
		try {
		List<Object[]>subList = dao.getSystemParentLevelIdbyMainId(mainId);
		
		if(subList==null || subList.size()==0) {
			if(!list.contains(mainId)) {
				list.add(mainId);
			}
		}else {
			for(Object[]obj:subList) {
				list.add(obj[0].toString());
				getSPTMainIds(obj[0].toString(),list);
			}
			
		}
		
		
		return list;
		}
		catch (Exception e) {
		e.printStackTrace();
		return list;
		}
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
		prod.setLevelType(dto.getLevelType());
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

	@Override
	public long systemLevelNameEdit(SystemProductTree dto, String Action) throws Exception {
		SystemProductTree spt=dao.getSystemLevelNameById(dto.getMainId());
		spt.setMainId(dto.getMainId());
		if( Action.equalsIgnoreCase("TE")) {
			
			List<String >list = new ArrayList<>();
			List<String>mainIds = getSPTMainIds(dto.getMainId()+"",list);
			for(String s:mainIds) {
				SystemProductTree spt1=dao.getSystemLevelNameById(Long.parseLong(s));
				spt1.setMainId(Long.parseLong(s));
				spt1.setLevelType(dto. getLevelType() );
				dao.systemLevelNameEdit(spt1);
			}
			
			if(dto.getLevelType()!=null) {
			spt.setLevelType(dto.getLevelType());	
			}
						
			spt.setLevelName(dto.getLevelName());
			spt.setLevelCode(dto.getLevelCode());
			spt.setLevelType(dto.getLevelType());
			spt.setModifiedBy(dto.getModifiedBy());
			spt.setModifiedDate(fc.getSqlDateAndTimeFormat().format(new Date()));
		
			return dao.systemLevelNameEdit(spt);		
		}else if(Action.equalsIgnoreCase("TD")) {
			return dao.systemLevelNameDelete(spt);			
		}
		return 0;
	}

}
		

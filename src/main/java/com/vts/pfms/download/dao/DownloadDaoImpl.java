package com.vts.pfms.download.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Repository;

@Transactional
@Repository
public class DownloadDaoImpl implements DownloadDao{

	@PersistenceContext
	EntityManager manager;
		
	private static final Logger logger=LogManager.getLogger(DownloadDaoImpl.class);
	
	
	
	private static final String AGENDADOCLINKDOWNLOAD  ="SELECT a.filerepid,b.filerepuploadid,b.filepath,b.filenameui,b.filename,b.filepass,b.ReleaseDoc,b.VersionDoc FROM file_rep_new a,file_rep_upload b WHERE a.filerepid=b.filerepid AND a.filerepid=:filerepid AND a.releasedoc=b.releasedoc AND a.versiondoc=b.versiondoc";
	private static final String PROJECTDATASPECSFILEDATA  ="SELECT projectdataid,projectid,filespath, systemspecsfilename,systemconfigimgname,producttreeimgname,pearlimgname FROM pfms_project_data WHERE projectdataid=:projectdataid";
	
	
	
	@Override
	public Object[] AgendaDocLinkDownload(String filerepid)throws Exception
	{
		logger.info(new java.util.Date() +"Inside AgendaDocLinkDownload");
		Query query=manager.createNativeQuery(AGENDADOCLINKDOWNLOAD);
		query.setParameter("filerepid", filerepid);
		List<Object[]> FileRepMasterListAll=(List<Object[]>)query.getResultList();
		if(FileRepMasterListAll.size()>0) {
		return FileRepMasterListAll.get(0);
		}else {
			return null;
		}
	}
	
	
	@Override
	public Object[] ProjectDataSpecsFileData(String projectdataid) throws Exception
	{
		logger.info(new java.util.Date() +"Inside ProjectDataSpecsFileData");
	
		Query query=manager.createNativeQuery(PROJECTDATASPECSFILEDATA);
		query.setParameter("projectdataid",projectdataid);
		Object[] ProjectDataSpecsFileData=(Object[])query.getSingleResult();
		return ProjectDataSpecsFileData;
		
	}
}

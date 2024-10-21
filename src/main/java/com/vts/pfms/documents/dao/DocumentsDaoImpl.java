package com.vts.pfms.documents.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.vts.pfms.documents.model.StandardDocuments;


@Transactional
@Repository
public class DocumentsDaoImpl implements DocumentsDao{

	
	@PersistenceContext
	EntityManager manager;
	
	
	private static final Logger logger=LogManager.getLogger(DocumentsDaoImpl.class);

	@Override
	public long standardDocumentInsert(StandardDocuments model) throws Exception {
		try {
			manager.persist(model);
			manager.flush();

		} catch (Exception e) {
			logger.error(new Date() +"Inside DAO insertSocDetailsData "+ e);
			e.printStackTrace();
		}
		return model.getStandardDocumentId();
	}
	
	
	private static final String STANDARDDOCUMENTSLIST="SELECT a.StandardDocumentId,a.DocumentName,a.Description,a.FilePath FROM pfms_standard_documents a WHERE a.IsActive='1'";
	@Override
	public List<Object[]> standardDocumentsList() throws Exception {
		try {
			Query query=manager.createNativeQuery(STANDARDDOCUMENTSLIST);
			return (List<Object[]>)query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	private static final String STANDARDATTCHMENTDATA="SELECT a.DocumentName,a.FilePath,a.Description FROM pfms_standard_documents a WHERE a.StandardDocumentId=:standardDocumentId";
	@Override
	public Object[] standardattachmentdata(String standardDocumentId) throws Exception {
		logger.info(new Date() + "Inside standardattachmentdata");
		try {
			Query query = manager.createNativeQuery(STANDARDATTCHMENTDATA);
			query.setParameter("standardDocumentId", standardDocumentId);
			Object[] standardattachmentdata = (Object[]) query.getSingleResult();
			return standardattachmentdata;

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl standardattachmentdata", e);
			return null;
		}
	}
	
	
	@Override
	public StandardDocuments StandardDocumentDataById(long StandartDocumentId) throws Exception {
		try{
			StandardDocuments standarddocumentdetails=manager.find(StandardDocuments.class, StandartDocumentId);
			return standarddocumentdetails;
		}catch (Exception e){
			logger.error(new Date()  + "Inside DAO StandardDocumentDataById() " + e);
			e.printStackTrace();
			return null;
		}
	}
	
	private static final String STANDARDDOCUMENTDELETE="UPDATE pfms_standard_documents a SET a.IsActive='0' WHERE a.StandardDocumentId=:standardDocumentId";
	@Override
	public long StandardDocumentDelete(long standardDocumentId) throws Exception {
		try {
			Query query =manager.createNativeQuery(STANDARDDOCUMENTDELETE);
			query.setParameter("standardDocumentId", standardDocumentId);
			return query.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
}

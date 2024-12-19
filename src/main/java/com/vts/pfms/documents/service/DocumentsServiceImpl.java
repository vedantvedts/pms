package com.vts.pfms.documents.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigInteger;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.vts.pfms.FormatConverter;
import com.vts.pfms.documents.dao.DocumentsDao;
import com.vts.pfms.documents.dto.StandardDocumentsDto;
import com.vts.pfms.documents.model.IGIApplicableDocs;
import com.vts.pfms.documents.model.IGIDocumentMembers;
import com.vts.pfms.documents.model.IGIDocumentShortCodes;
import com.vts.pfms.documents.model.IGIDocumentSummary;
import com.vts.pfms.documents.model.IGIInterface;
import com.vts.pfms.documents.model.PfmsApplicableDocs;
import com.vts.pfms.documents.model.PfmsIGIDocument;
import com.vts.pfms.documents.model.StandardDocuments;

@Service
public class DocumentsServiceImpl implements DocumentsService{

	@Value("${ApplicationFilesDrive}")
	String uploadpath;
	
	@Autowired
	DocumentsDao dao;
	
	private static final Logger logger=LogManager.getLogger(DocumentsServiceImpl.class);
	
	FormatConverter fc = new FormatConverter();
	private SimpleDateFormat sdtf = fc.getSqlDateAndTimeFormat();
	private SimpleDateFormat sdf = fc.getSqlDateFormat();
	private SimpleDateFormat rdf = fc.getRegularDateFormat();
	
	@Override
	public long InsertStandardDocuments(StandardDocumentsDto dto) throws Exception {
		try {
			Path fullpath=Paths.get(uploadpath, "StandardDocuments");
			File theDir = fullpath.toFile();
			if (!theDir.exists()){
				theDir.mkdirs();
			}
			StandardDocuments model= (dto!=null && dto.getSelectedStandardDocumentId()!=null && !dto.getSelectedStandardDocumentId().equalsIgnoreCase(""))? 
					dao.StandardDocumentDataById(Long.parseLong(dto.getSelectedStandardDocumentId()))
					:new StandardDocuments();
			model.setDocumentName(dto.getDocumentName());
			model.setDescription(dto.getDescription());

			if(dto.getAttachment()!=null && !dto.getAttachment().isEmpty()) {
				if(dto.getSelectedStandardDocumentId()!=null && !dto.getSelectedStandardDocumentId().equalsIgnoreCase("")) {
				File oldFile = new File(uploadpath + "\\" + model.getFilePath().toString());
				if (oldFile.exists()) {
					oldFile.delete();
				}
				}
				model.setFilePath("StandardDocuments"+File.separator+dto.getAttachment().getOriginalFilename());
				saveFile1(fullpath, dto.getAttachment().getOriginalFilename(), dto.getAttachment());
			}

			if(dto!=null && dto.getSelectedStandardDocumentId()!=null && !dto.getSelectedStandardDocumentId().equalsIgnoreCase("")) {
				model.setModifiedBy(dto.getCreatedBy());
				model.setModifiedDate(dto.getCreatedDate());
			}else {
				model.setCreatedBy(dto.getCreatedBy());
				model.setCreatedDate(dto.getCreatedDate());
				model.setIsActive(dto.getIsActive());
			}
			return dao.standardDocumentInsert(model);
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	public static int saveFile1(Path uploadPath, String fileName, MultipartFile multipartFile) throws IOException {
		logger.info(new Date() + "Inside SERVICE saveFile ");
		int result = 1;

		if (!Files.exists(uploadPath)) {
			Files.createDirectories(uploadPath);
		}
		try (InputStream inputStream = multipartFile.getInputStream()) {
			Path filePath = uploadPath.resolve(fileName);
			Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
		} catch (IOException ioe) {
			result = 0;
			throw new IOException("Could not save image file: " + fileName, ioe);
		} catch (Exception e) {
			result = 0;
			logger.error(new Date() + "Inside SERVICE saveFile " + e);
			e.printStackTrace();
		}
		return result;
	}
	
	@Override
	public List<Object[]> standardDocumentsList() throws Exception {
		return dao.standardDocumentsList();
	}
	
	@Override
	public Object[] standardattachmentdata(String standardDocumentId) throws Exception {
		return dao.standardattachmentdata(standardDocumentId);
	}
	
	@Override
	public long StandardDocumentDelete(long standardDocumentId) throws Exception {
		return dao.StandardDocumentDelete(standardDocumentId);
	}
	
	/* ************************************************ IGI Document ***************************************************** */
	@Override
	public List<Object[]> IgiDocumentList() throws Exception
	{
		return dao.IgiDocumentList();
	}
	
	@Override
	public long addPfmsIgiDocument(PfmsIGIDocument pfmsIgiDocument) throws Exception
	{
		return dao.addPfmsIgiDocument(pfmsIgiDocument);
	}
	
	@Override
	public List<Object[]> igiDocumentSummaryList(String igiDocId) throws Exception
	{
		return dao.igiDocumentSummaryList(igiDocId);
		
	}
	
	@Override
	public IGIDocumentSummary getIgiDocumentSummaryById(String SummaryId) throws Exception
	{
		return dao.getIgiDocumentSummaryById(SummaryId);
	}
	
	
	@Override
	public long addIgiDocumentSummary(IGIDocumentSummary rs) throws Exception
	{
		return dao.addIgiDocumentSummary(rs);
	}
	
	@Override
	public List<Object[]> igiDocumentMemberList(String igiDocId) throws Exception
	{
		return dao.igiDocumentMemberList(igiDocId);
	}
	
	@Override
	public List<Object[]> getDocmployeeListByIGIDocId(String labCode, String igiDocId) throws Exception
	{
		return dao.getDocmployeeListByIGIDocId(labCode, igiDocId);
	}

	@Override
	public long addIGIDocumentMembers(IGIDocumentMembers rm) throws Exception {
		
		int numberOfPersons= rm.getEmps().length; 
		
		String []assignee= rm.getEmps();
		long count=0;
		for(int i=0;i<numberOfPersons;i++) {
			IGIDocumentMembers r = new IGIDocumentMembers();

			r.setCreatedBy(rm.getCreatedBy());
			r.setCreatedDate(rm.getCreatedDate());
			r.setEmpId(Long.parseLong(assignee[i]));
			r.setIsActive(1);
			r.setIGIDocId(rm.getIGIDocId());

			count=dao.addIGIDocumentMembers(r);
			
		}
		return count;
	}
	
	@Override
	public int deleteIGIDocumentMembers(String igiMemeberId) throws Exception {
		
		return dao.deleteIGIDocumentMembers(igiMemeberId);
	}
	
	@Override
	public IGIDocumentMembers getIGIDocumentMembersById(Long IgiMemeberId) throws Exception {
		
		return dao.getIGIDocumentMembersById(IgiMemeberId);
	}
	
	@Override
	public long addIGIInterface(IGIInterface igiInterface) throws Exception {
		
		if(igiInterface.getInterfaceId()==null) {
			int interfaceCount = dao.getInterfaceCountByType(igiInterface.getInterfaceType());
			String[] split = igiInterface.getInterfaceType().split(" ");
			igiInterface.setInterfaceSeqNo((split[0].charAt(0)+""+split[1].charAt(0))+"_"+(interfaceCount+1));
		}
		return dao.addIGIInterface(igiInterface);
	}
	
	@Override
	public List<IGIInterface> getIGIInterfaceListByLabCode(String labCode) throws Exception {
		
		return dao.getIGIInterfaceListByLabCode(labCode);
	}
	
	@Override
	public PfmsIGIDocument getPfmsIGIDocumentById(String igiDocId) throws Exception {
		
		return dao.getPfmsIGIDocumentById(igiDocId);
	}
	
	@Override
	public IGIInterface getIGIInterfaceById(String interfaceId) throws Exception {

		return dao.getIGIInterfaceById(interfaceId);
	}
	
	@Override
	public BigInteger getDuplicateInterfaceCodeCount(String interfaceId, String interfaceCode) throws Exception {
		
		return dao.getDuplicateInterfaceCodeCount(interfaceId, interfaceCode);
	}
	
	@Override
	public List<IGIDocumentShortCodes> getIGIDocumentShortCodesList() throws Exception {
		
		return dao.getIGIDocumentShortCodesList();
	}
	
	@Override
	public int deleteIGIDocumentShortCodesByType(String shortCodeType) throws Exception {
		
		return dao.deleteIGIDocumentShortCodesByType(shortCodeType);
	}
	
	@Override
	public long addIGIDocumentShortCodes(List<IGIDocumentShortCodes> igiDocumentShortCodes) throws Exception {
		
		return dao.addIGIDocumentShortCodes(igiDocumentShortCodes);
	}
	
	@Override
	public List<PfmsApplicableDocs> getPfmsApplicableDocs() throws Exception {
		
		return dao.getPfmsApplicableDocs();
	}
	
	@Override
	public List<Object[]> getIGIApplicableDocs(String docFlag) throws Exception {
		
		return dao.getIGIApplicableDocs(docFlag);
	}
	
	@Override
	public long addIGIApplicableDocs(String igiDocId, String docFlag, String[] applicableDocIds, String userId) throws Exception {
		try {
			
			for(int i=0; i<applicableDocIds.length; i++) {
				IGIApplicableDocs applicableDoc = new IGIApplicableDocs();
				applicableDoc.setApplicableDocId(applicableDocIds[i]!=null? Long.parseLong(applicableDocIds[i]):0);
				applicableDoc.setDocFlag(docFlag);
				applicableDoc.setIGIDocId(igiDocId!=null?Long.parseLong(igiDocId):0);
				applicableDoc.setCreatedBy(userId);
				applicableDoc.setCreatedDate(sdtf.format(new Date()));
				applicableDoc.setIsActive(1);
				
				dao.addIGIApplicableDocs(applicableDoc);
			}
			return 1;
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
	}
	
	@Override
	public int deleteIGIApplicableDocument(String igiApplicableDocId) throws Exception {
		
		return dao.deleteIGIApplicableDocument(igiApplicableDocId);
	}
	
	/* ************************************************ IGI Document End ***************************************************** */

}

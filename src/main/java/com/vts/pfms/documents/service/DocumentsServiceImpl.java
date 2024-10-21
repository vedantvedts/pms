package com.vts.pfms.documents.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Date;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.vts.pfms.documents.dao.DocumentsDao;
import com.vts.pfms.documents.dto.StandardDocumentsDto;
import com.vts.pfms.documents.model.StandardDocuments;

@Service
public class DocumentsServiceImpl implements DocumentsService{

	@Value("${ApplicationFilesDrive}")
	String uploadpath;
	
	@Autowired
	DocumentsDao dao;
	
	private static final Logger logger=LogManager.getLogger(DocumentsServiceImpl.class);
	
	
	
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
	
}

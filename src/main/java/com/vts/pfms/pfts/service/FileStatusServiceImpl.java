package com.vts.pfms.pfts.service;

import java.math.BigInteger;
import java.util.Date;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vts.pfms.fracas.service.FracasServiceImpl;
import com.vts.pfms.pfts.dao.FileStatusDao;
import com.vts.pfms.pfts.model.PftsDemandImms;
import com.vts.pfms.pfts.model.PftsEventCreator;
import com.vts.pfms.pfts.model.PftsFileEvents;
import com.vts.pfms.pfts.model.PftsFileMilestone;
import com.vts.pfms.pfts.model.PftsFileStage;
import com.vts.pfms.pfts.model.PftsFileTracking;
import com.vts.pfms.pfts.model.PftsFileTrackingTransaction;

@Service
public class FileStatusServiceImpl implements FileStatusService 
{
	@Autowired
	FileStatusDao dao;
	
	private static final Logger logger=LogManager.getLogger(FracasServiceImpl.class);
	//logger.info(new Date() +"Inside ");
	@Override
	public List<PftsDemandImms> getResultAsDemandNo(String DemandNo) throws Exception
	{
		return dao.getResultAsDemandNo(DemandNo);
	}
	
	@Override
	public List<PftsDemandImms> getResultAsFileNo(String fileno) throws Exception
	{
		return dao.getResultAsFileNo(fileno);
	}
	
	@Override
	public List<PftsDemandImms> getResultAsPerItemSearch(String ItemFor) throws Exception
	{
		return dao.getResultAsPerItemSearch(ItemFor);
	}
	
	@Override
	public List<Object[]> getEventStatus(String demandNo) throws Exception
	{
		return dao.getEventStatus(demandNo);
	}
	
	@Override
	public List<PftsFileEvents> getEvent(String FtUserType) throws Exception
	{
		return dao.getEvent(FtUserType);
	}
	
	@Override
	public  List<PftsEventCreator> getEventCreator(char userType) throws Exception
	{
		return dao.getEventCreator(userType);
	}
	
	@Override
	public List<Object[]> getSupplyOrderFromMilestone(String DemandNo) throws Exception
	{
		return dao.getSupplyOrderFromMilestone(DemandNo);
	}
	
	@Override
	public List<Object[]> getSupplyOrderForFileClose(String demandNo)throws Exception
	{
		return dao.getSupplyOrderForFileClose(demandNo);
	}
	
	@Override
	public List<java.sql.Date> getEventDate(String demandNo) throws Exception
	{
		return dao.getEventDate(demandNo);
	}
	
	@Override
	public  List<PftsFileStage> getDetailsOfFileStage()throws Exception
    {
		return dao.getDetailsOfFileStage();
    }
	
	@Override
	public List<Boolean> checkIsActiveFromMilestone(String demandNo) throws Exception
	{
		return dao.checkIsActiveFromMilestone(demandNo);
	}
	@Override
	public  List<PftsFileEvents> getEventAsperFilestageId(String filestageId)throws Exception
	{
		return dao.getEventAsperFilestageId(filestageId);
	}
	
	@Override
	public BigInteger getFiletrackingId(String demandNo) throws Exception
	{
		return dao.getFiletrackingId(demandNo);
	}
	
	@Override
	public String getFileMileStone(String eventNumber) throws Exception
	{
		return dao.getFileMileStone(eventNumber);
	}
	
	@Override
	public List<Object[]> checkFileMileStone(String demandNo)  throws Exception
	{
		return dao.checkFileMileStone(demandNo);
	}
	
	@Override
	public int updateFileMileStone(PftsFileMilestone fileMilestone,String column) throws Exception
	{
		return dao.updateFileMileStone(fileMilestone, column);
	}
	
	@Override
	public long addFileMileStone(PftsFileMilestone fileMilestone) throws Exception
	{
		return dao.addFileMileStone(fileMilestone);
	}
	
	@Override
	public int addupdateEventStatus(PftsFileTracking dto,int filetrackingId,PftsFileTrackingTransaction tdto) throws Exception
	{
		return dao.addupdateEventStatus(dto, filetrackingId, tdto);
	}
	
	@Override
	public long addEventStatus(PftsFileTracking dto) throws Exception
	{
		return dao.addEventStatus(dto);
	}
	
	@Override
	public int addTransactionEvent(PftsFileTrackingTransaction transactionDto) throws Exception
	{
		return dao.addTransactionEvent(transactionDto);
	}
	
	@Override
	public List<Object[]> getEventStatusasPerFileTrackingId(int id) throws Exception
	{	
		return dao.getEventStatusasPerFileTrackingId(id);
	}
	
	@Override
	public int updateEventStatusas(int transactionId,int eventId,String eventDate,String modifiedBy,String moDate,String remarks, int fileTrackingId) throws Exception
	{
		return dao.updateEventStatusas(transactionId, eventId, eventDate, modifiedBy, moDate, remarks, fileTrackingId);
	}
	
	@Override
	public int fileClosed(PftsFileTrackingTransaction tranDto,PftsFileTracking trackingDto,int fileClosed)throws Exception
	{
		return dao.fileClosed(tranDto, trackingDto, fileClosed);
	}
	
	@Override
	public int fileClosedNoOrder(PftsFileTrackingTransaction tranDto,PftsFileTracking trackingDto,String demandNo) throws Exception
	{
		return dao.fileClosedNoOrder(tranDto, trackingDto, demandNo);
	}
	
}

package com.vts.pfms.pfts.dao;

import java.math.BigInteger;
import java.sql.Date;
import java.util.List;

import com.vts.pfms.pfts.model.PftsDemandImms;
import com.vts.pfms.pfts.model.PftsEventCreator;
import com.vts.pfms.pfts.model.PftsFileEvents;
import com.vts.pfms.pfts.model.PftsFileMilestone;
import com.vts.pfms.pfts.model.PftsFileStage;
import com.vts.pfms.pfts.model.PftsFileTracking;
import com.vts.pfms.pfts.model.PftsFileTrackingTransaction;

public interface FileStatusDao {

	public List<PftsDemandImms> getResultAsDemandNo(String DemandNo) throws Exception;
	public List<PftsDemandImms> getResultAsFileNo(String fileno) throws Exception;
	public List<PftsDemandImms> getResultAsPerItemSearch(String ItemFor) throws Exception;
	public List<Object[]> getEventStatus(String demandNo) throws Exception;
	public List<PftsFileEvents> getEvent(String FtUserType)throws Exception;
	public List<PftsEventCreator> getEventCreator(char userType)throws Exception;
	public List<Object[]> getSupplyOrderFromMilestone(String DemandNo)throws Exception;
	public List<Object[]> getSupplyOrderForFileClose(String demandNo)throws Exception;
	public List<Date> getEventDate(String demandNo)throws Exception;
	public List<PftsFileStage> getDetailsOfFileStage()throws Exception;
	public List<Boolean> checkIsActiveFromMilestone(String demandNo)throws Exception;
	public List<PftsFileEvents> getEventAsperFilestageId(String filestageId)throws Exception;
	public BigInteger getFiletrackingId(String demandNo)throws Exception;
	public String getFileMileStone(String eventNumber)throws Exception;
	public List<Object[]> checkFileMileStone(String demandNo)throws Exception;
	public int updateFileMileStone(PftsFileMilestone fileMilestone, String column)throws Exception;
	public long addFileMileStone(PftsFileMilestone fileMilestone)throws Exception;
	public int addupdateEventStatus(PftsFileTracking dto, int filetrackingId, PftsFileTrackingTransaction tdto)throws Exception;
	public long addEventStatus(PftsFileTracking dto)throws Exception;
	public int addTransactionEvent(PftsFileTrackingTransaction transactionDto)throws Exception;
	public List<Object[]> getEventStatusasPerFileTrackingId(int id)throws Exception;
	public int updateEventStatusas(int transactionId, int eventId, String eventDate, String modifiedBy, String moDate,String remarks, int fileTrackingId)throws Exception;
	public int fileClosed(PftsFileTrackingTransaction tranDto, PftsFileTracking trackingDto, int fileClosed)throws Exception;
	public int fileClosedNoOrder(PftsFileTrackingTransaction tranDto, PftsFileTracking trackingDto, String demandNo)throws Exception;
	

}

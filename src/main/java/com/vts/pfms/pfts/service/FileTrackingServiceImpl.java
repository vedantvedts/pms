package com.vts.pfms.pfts.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vts.pfms.pfts.dao.FileTrackingDao;
import com.vts.pfms.pfts.model.PftsDemandImms;

@Service
public class FileTrackingServiceImpl implements FileTrackingService 
{
	@Autowired
	FileTrackingDao dao;
	
	@Override
	public  List<PftsDemandImms>  DemandImmsListForFileTrackingByDemandNo(String DemandNo) throws Exception
    {
		return dao.DemandImmsListForFileTrackingByDemandNo(DemandNo);
    }
	
	@Override
	public  List<PftsDemandImms>  DemandImmsListForFileTrackingByProjectCode(String ProjectCode)throws Exception
    {
		return dao.DemandImmsListForFileTrackingByProjectCode(ProjectCode);
    }
	@Override
	public  List<PftsDemandImms>  DemandImmsListForFileTrackingByItemNomenclature(String ItemNomenclature)throws Exception
    {
		return dao.DemandImmsListForFileTrackingByItemNomenclature(ItemNomenclature);
    }
	
	@Override
	public Object[] CheckingDemandIdPresent(String DemandNo) throws Exception
    {
		return dao.CheckingDemandIdPresent(DemandNo);
    }
	
	@Override
	public   List<Object[]> FileTrackingFlowDetails(String FileTrackingId) throws Exception
	{
		return  dao.FileTrackingFlowDetails(FileTrackingId);
	}
	
	@Override
	public  Object[] DemandImmsMainDetailsByDemandId(String DemandNo) throws Exception
    {
		return  dao.DemandImmsMainDetailsByDemandId(DemandNo);
    }
}

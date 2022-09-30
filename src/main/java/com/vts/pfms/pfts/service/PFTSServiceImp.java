package com.vts.pfms.pfts.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vts.pfms.master.dto.DemandDetails;
import com.vts.pfms.pfts.dao.PFTSDao;
import com.vts.pfms.pfts.dto.DemandOrderDetails;
import com.vts.pfms.pfts.model.PFTSFile;
import com.vts.pfms.pfts.model.PftsFileOrder;

@Service
public class PFTSServiceImp implements PFTSService{
	
	@Autowired 
	PFTSDao dao;
	
	private  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
	private  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	@Override
	public List<Object[]> ProjectsList() throws Exception {

		return dao.ProjectsList();
	}
	
	@Override
	public List<Object[]> LoginProjectDetailsList(String empid,String Logintype,String LabCode)throws Exception
	{
		return dao.LoginProjectDetailsList(empid,Logintype,LabCode);
	}
	
	@Override
	public List<Object[]> getFileStatusList(String projectId) throws Exception {	
		return dao.getFileStatusList(projectId);
	}
	
	@Override
	public List<DemandDetails> getprevDemandFile(String projectId)throws Exception{
		
		List<Object[]> data =dao.getprevDemandFile(projectId);
		List<DemandDetails> pervDD=new ArrayList<>();
		if(data!=null && data.size()>0) {
			for(Object[] obj:data) {
				DemandDetails DD =new DemandDetails();
				DD.setProjectId(Long.parseLong(obj[0].toString()));
				DD.setDemandNo(obj[1].toString());
				DD.setDemandDate(obj[2].toString());
				DD.setItemFor(obj[3].toString());
				DD.setEstimatedCost(Double.parseDouble(obj[4].toString()));
				pervDD.add(DD);
			}
		}
		
	 return pervDD;	
	}
	
	@Override
	public Long addDemandfile(PFTSFile pf) throws Exception{
		return dao.addDemandfile(pf);
	}
	
	@Override
	public List<Object[]> getStatusList(String fileid)throws Exception{
		return dao.getStatusList(fileid);
	}

	@Override
	public int upadteDemandFile(String fileId, String statusId, String eventDate,String remarks)throws Exception{
	String update="";	

		switch(statusId) {
		    case "2" :
		    	update="SpcDate";
		    break ;	
		    case "3":
		    	update="EPCDate";
            break;
		    case "4":
		    	update="TenderDate";
		    break;	
		    case "5":
		    	update="TocDate";
			break;	
		    case "6":
		    	update="TecDate";
		    break;
		    case "7":
		    	update="TpcDate";
		    break;	
		    case "8":
		    	update="SanctionDate";
			break;	
		    case "9":
		    	update="OrderDate";
			break;	
		    case "10":
		    	update="RevisedDp";
			break;	
		    case "11":
		    	update="ReceiptDate";
			break;
		    case "12":
		    	update="InspectionDate";
		    break;
		    case "13":
		    	update="CrvDate";
	        break;
		    case "14":
		    	update="PaymentDate";
			break;	
		    case "15":
		    	update="PartialChequeDate";
		    break;	
		    case "16":
		    	update="FinalChequeDate";
		    break;
		}
		
		Date eventDateSql=new java.sql.Date(sdf.parse(eventDate).getTime());
		return dao.upadteDemandFile(fileId,statusId,eventDateSql,update, remarks);
	}
	
	@Override
	public long updateCostOnDemand(List<DemandOrderDetails> dd ,String fileId,String userid)throws Exception{
        long result=0; 
		for(DemandOrderDetails dod:dd) {
        	 PftsFileOrder pfo=new PftsFileOrder();
        	 pfo.setItemFor(dod.getItemFor());
        	 pfo.setOrderNo(dod.getOrderNo());
        	 pfo.setVendorName(dod.getVendorName());
        	 pfo.setDpDate(dod.getDpDate());
        	 pfo.setOrderDate(dod.getOrderDate());
        	 pfo.setOrderCost(dod.getOrderCost());
        	 pfo.setPftsFileId(Long.parseLong(fileId));
        	 pfo.setCreatedBy(userid);
        	 pfo.setCreatedDate(sdf1.format(new Date()));
        	 try {
        	 result=dao.addDemandfileOrder(pfo);
        	 }catch (Exception e) {
        		 
			}        
        }
	     return result;
	}

	@Override
	public int FileInActive(String fileId, String userId) throws Exception {
		
		return dao.FileInActive(fileId, userId);
	}
	
	
}

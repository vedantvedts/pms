package com.vts.pfms.OnBoardingRepository;

import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.NumberToTextConverter;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.vts.pfms.admin.model.DivisionMaster;
import com.vts.pfms.admin.service.AdminService;
import com.vts.pfms.committee.dto.ActionAssignDto;
import com.vts.pfms.committee.dto.ActionMainDto;
import com.vts.pfms.committee.model.ActionAssign;
import com.vts.pfms.committee.service.ActionService;
import com.vts.pfms.master.controller.MasterController;
import com.vts.pfms.master.model.DivisionGroup;
import com.vts.pfms.master.model.Employee;
import com.vts.pfms.master.service.MasterService;
import com.vts.pfms.project.model.ProjectMain;
import com.vts.pfms.project.service.ProjectService;

@Controller
public class OnBoardingController {

	@Autowired
	ProjectService projectservice;
	
	@Autowired
	ProjectMainRepository projectmainrepo;
	
	@Autowired
	MasterService service;
	
	@Autowired
	AdminService adminservice;
	
	@Autowired
	GroupMatsterRepository groupmasterrepo;
	
	@Autowired
	DivisionMasterRepository divisionmasterrepo;
	
	@Autowired
	EmployeeMasterRepository employeemasterrepo;
	
	@Autowired
	ActionService actionservice;
	
	private static final Logger logger=LogManager.getLogger(MasterController.class);
	private SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	 
	 @RequestMapping(value="GroupMasterExcelUpload.htm" ,method = RequestMethod.POST)
	 public String GroupmasterExcelUpload( RedirectAttributes redir,HttpServletRequest req ,HttpServletResponse res ,HttpSession ses)throws Exception
	 {
		 String UserId=(String)ses.getAttribute("Username");
		 String LabCode =(String) ses.getAttribute("labcode");
		 logger.info(new Date() +"Inside GroupMasterExcelUpload.htm "+UserId);
			 try{
				String action = req.getParameter("Action"); 
				
				if("GenerateExcel".equalsIgnoreCase(action)) {
					XSSFWorkbook workbook = new XSSFWorkbook();
					XSSFSheet sheet =  workbook.createSheet("Group master Details");
					XSSFRow row=sheet.createRow(0);
					
					CellStyle unlockedCellStyle = workbook.createCellStyle();
					unlockedCellStyle.setLocked(true);
					
					row.createCell(0).setCellValue("SN");
					row.createCell(1).setCellValue("Group Code");
					row.createCell(2).setCellValue("Group Name");

					int r=0;
					
						row=sheet.createRow(++r);
						row.createCell(0).setCellValue(String.valueOf(r));
						row.createCell(1).setCellValue("");
						row.createCell(2).setCellValue("");

					    res.setContentType("application/vnd.ms-excel");
			            res.setHeader("Content-Disposition", "attachment; filename=GroupMaster.xls");	
			            workbook.write(res.getOutputStream());
				}else if("UploadExcel".equalsIgnoreCase(action)){
			
					if(ServletFileUpload.isMultipartContent(req)) {
						try {
							
							List<FileItem> multiparts = new ServletFileUpload( new DiskFileItemFactory()).parseRequest(new ServletRequestContext(req));
							Part filePart = req.getPart("filename");

							 List<DivisionGroup> divisiongroup = new ArrayList<DivisionGroup>();
							 InputStream fileData = filePart.getInputStream();
							   
					            Workbook workbook = new XSSFWorkbook(fileData);
					 
					            Sheet sheet  = workbook.getSheetAt(0);
					            
					            int rowCount=sheet.getLastRowNum()-sheet.getFirstRowNum(); 				            
					            //iterate over all the row to print the data present in each cell.
					            for(int i=1;i<=rowCount;i++){
					                 
					                //get cell count in a row
					                int cellcount=sheet.getRow(i).getLastCellNum();         
					            	DivisionGroup dgm=new DivisionGroup();
					                
					                //iterate over each cell to print its value       
					                for(int j=1;j<cellcount;j++){

					                	
					                	if(sheet.getRow(i).getCell(j)!=null) {
					                		if(j==1) {
					                			switch (sheet.getRow(i).getCell(j).getCellType()){
					                            case Cell.CELL_TYPE_BLANK:
					                            	break;
					                            case Cell.CELL_TYPE_NUMERIC:
					                            	dgm.setGroupCode(String.valueOf((long) sheet.getRow(i).getCell(j).getNumericCellValue()));
					                            	break;
					                            case Cell.CELL_TYPE_STRING:
					                            	dgm.setGroupCode(sheet.getRow(i).getCell(j).getStringCellValue());
					                            	break;
							                	}
					                		}
					                		if(j==2) {
					                			switch (sheet.getRow(i).getCell(j).getCellType()){
					                            case Cell.CELL_TYPE_BLANK:
					                            	break;
					                            case Cell.CELL_TYPE_NUMERIC:
					                            	 dgm.setGroupName(String.valueOf(sheet.getRow(i).getCell(j).getNumericCellValue()));
					                            	 break;
					                            case Cell.CELL_TYPE_STRING:
					                            	 dgm.setGroupName(sheet.getRow(i).getCell(j).getStringCellValue().toString());
					                            	 break;
							                	}
					                		}
					                		
					                	}
					                	  
					                }
					                  dgm.setGroupHeadId(1l);
						              dgm.setLabCode(LabCode);
						              dgm.setIsActive(1);
						              dgm.setCreatedBy(UserId);
						              dgm.setCreatedDate(sdf1.format(new Date()));
						              if(dgm.getGroupCode()!=null && dgm.getGroupName()!=null) {
						            	  divisiongroup.add(dgm);
						              }
					            }
					        	List<DivisionGroup>  count= groupmasterrepo.saveAll(divisiongroup);
					        	
								if (count.size() > 0) {
									redir.addAttribute("result", "Group Added Successfully");
								} else {
									redir.addAttribute("resultfail", "Group Adding Unsuccessfully");
								}
								redir.addAttribute("Onboard","Yes");
								return "redirect:/GroupMaster.htm";
							
						} catch (Exception e) {
							e.printStackTrace();
						
						}
						
					}	
				}
						req.setAttribute("groupslist",service.GroupsList(LabCode) );
			          
				}catch(Exception e){
					e.printStackTrace();
					logger.error(new Date() +"Inside GroupMasterExcelUpload.htm "+UserId,e);
				}
		 
			 return "master/GroupsList";
	 }
	 
	 @RequestMapping(value="DivisionMasterExcelUpload.htm" ,method = RequestMethod.POST)
	 public String DivisionmasterExcelUpload( RedirectAttributes redir,HttpServletRequest req ,HttpServletResponse res ,HttpSession ses)throws Exception
	 {
		 String UserId=(String)ses.getAttribute("Username");
		 String LabCode =(String) ses.getAttribute("labcode");
		 logger.info(new Date() +"Inside DivisionMasterExcelUpload.htm "+UserId);
			 try{
				String action = req.getParameter("Action"); 
				
				if("GenerateExcel".equalsIgnoreCase(action)) {
					XSSFWorkbook workbook = new XSSFWorkbook();
					XSSFSheet sheet =  workbook.createSheet("Division master Details");
					XSSFRow row=sheet.createRow(0);
					
					CellStyle unlockedCellStyle = workbook.createCellStyle();
					unlockedCellStyle.setLocked(true);
					
					row.createCell(0).setCellValue("SN");
					row.createCell(1).setCellValue("Division Code");
					row.createCell(2).setCellValue("Division Name");

					int r=0;
					
						row=sheet.createRow(++r);
						row.createCell(0).setCellValue(String.valueOf(r));
						row.createCell(1).setCellValue("");
						row.createCell(2).setCellValue("");

					    res.setContentType("application/vnd.ms-excel");
			            res.setHeader("Content-Disposition", "attachment; filename=DivisionMaster.xls");	
			            workbook.write(res.getOutputStream());
				}else if("UploadExcel".equalsIgnoreCase(action)){
					
					if(ServletFileUpload.isMultipartContent(req)) {
						try {
							
							List<FileItem> multiparts = new ServletFileUpload( new DiskFileItemFactory()).parseRequest(new ServletRequestContext(req));
							Part filePart = req.getPart("filename");

							 List<DivisionMaster> div = new ArrayList<DivisionMaster>();
							 InputStream fileData = filePart.getInputStream();
							   
					            Workbook workbook = new XSSFWorkbook(fileData);
					 
					            Sheet sheet  = workbook.getSheetAt(0);
					            int rowCount=sheet.getLastRowNum()-sheet.getFirstRowNum(); 				            
					            //iterate over all the row to print the data present in each cell.
					            for(int i=1;i<=rowCount;i++){
					                 
					                //get cell count in a row
					                int cellcount=sheet.getRow(i).getLastCellNum();         
					            	DivisionMaster dmo=new DivisionMaster(); 
					                
					                //iterate over each cell to print its value       
					                for(int j=1;j<cellcount;j++){

					                	
					                	if(sheet.getRow(i).getCell(j)!=null) {
					                		if(j==1) {
					                			switch (sheet.getRow(i).getCell(j).getCellType()){
					                            case Cell.CELL_TYPE_BLANK:
					                            	break;
					                            case Cell.CELL_TYPE_NUMERIC:
					                            	dmo.setDivisionCode(String.valueOf((long) sheet.getRow(i).getCell(j).getNumericCellValue()));
					                            	break;
					                            case Cell.CELL_TYPE_STRING:
					                            	dmo.setDivisionCode(sheet.getRow(i).getCell(j).getStringCellValue());
					                            	break;
							                	}
					                		}
					                		if(j==2) {
					                			switch (sheet.getRow(i).getCell(j).getCellType()){
					                            case Cell.CELL_TYPE_BLANK:
					                            	break;
					                            case Cell.CELL_TYPE_NUMERIC:
					                            	 dmo.setDivisionName(String.valueOf(sheet.getRow(i).getCell(j).getNumericCellValue()));
					                            	 break;
					                            case Cell.CELL_TYPE_STRING:
					                            	 dmo.setDivisionName(sheet.getRow(i).getCell(j).getStringCellValue().toString());
					                            	 break;
							                	}
					                		}
					                		
					                	}
					                	 
					                }
					                  dmo.setLabCode(LabCode);
						              dmo.setGroupId(6l);
						              dmo.setDivisionHeadId(1l);
						              dmo.setIsActive(1);
						              dmo.setCreatedBy(UserId);
						              dmo.setCreatedDate(sdf1.format(new Date()));
						              if(dmo.getDivisionCode()!=null && dmo.getDivisionName()!=null) {
						            	  div.add(dmo);
						              }
					            }
					          List<DivisionMaster>  count= divisionmasterrepo.saveAll(div);
								if (count.size() > 0) {
									redir.addAttribute("result", "Division Added Successfully");
								} else {
									redir.addAttribute("resultfail", "Division Adding Unsuccessfully");
								}
								redir.addAttribute("Onboard","Yes");
								return "redirect:/DivisionMaster.htm";	
							
						} catch (Exception e) {
							e.printStackTrace();
						
						}
						
					}	
				}
						req.setAttribute("DivisionMasterList",adminservice.DivisionMasterList(LabCode) );
			          
				}catch(Exception e){
					e.printStackTrace();
					logger.error(new Date() +"Inside DivisionMasterExcelUpload.htm "+UserId,e);
				}
		 
			 return "admin/DivisionList";
		 
	 }
	 
	 @RequestMapping(value="EmployeeMasterExcelUpload.htm" ,method = RequestMethod.POST)
	 public String EmployeemasterExcelUpload( RedirectAttributes redir,HttpServletRequest req ,HttpServletResponse res ,HttpSession ses)throws Exception
	 {
		 String UserId=(String)ses.getAttribute("Username");
		 String LabCode =(String) ses.getAttribute("labcode");
		 logger.info(new Date() +"Inside EmployeeMasterExcelUpload.htm "+UserId);
			 try{
				String action = req.getParameter("Action"); 
				
				if("GenerateExcel".equalsIgnoreCase(action)) {
					XSSFWorkbook workbook = new XSSFWorkbook();
					XSSFSheet sheet =  workbook.createSheet("Employee master Details");
					XSSFRow row=sheet.createRow(0);
					
					CellStyle unlockedCellStyle = workbook.createCellStyle();
					unlockedCellStyle.setLocked(true);
					
					row.createCell(0).setCellValue("SN");
					row.createCell(1).setCellValue("Employee Number");
					row.createCell(2).setCellValue("Employee Name");
					row.createCell(3).setCellValue("Extention Number");
					row.createCell(4).setCellValue("Mobile Number");
					row.createCell(5).setCellValue("Email");
					row.createCell(6).setCellValue("Drona Email");
					row.createCell(7).setCellValue("Internet Email");

						row=sheet.createRow(1);
						row.createCell(0).setCellValue(String.valueOf(1));
						row.createCell(1).setCellValue("");
						row.createCell(2).setCellValue("");
						row.createCell(3).setCellValue("");
						row.createCell(4).setCellValue("");
						row.createCell(5).setCellValue("");
						row.createCell(6).setCellValue("");
						row.createCell(7).setCellValue("");
						

					    res.setContentType("application/vnd.ms-excel");
			            res.setHeader("Content-Disposition", "attachment; filename=EmployeeMaster.xls");	
			            workbook.write(res.getOutputStream());
				}else if("UploadExcel".equalsIgnoreCase(action)){
					
					if(ServletFileUpload.isMultipartContent(req)) {
						try {
							
							List<FileItem> multiparts = new ServletFileUpload( new DiskFileItemFactory()).parseRequest(new ServletRequestContext(req));
							Part filePart = req.getPart("filename");

							 List<Employee> employee = new ArrayList<Employee>();
							 InputStream fileData = filePart.getInputStream();
							   
					            Workbook workbook = new XSSFWorkbook(fileData);
					 
					            Sheet sheet  = workbook.getSheetAt(0);
					            int rowCount=sheet.getLastRowNum()-sheet.getFirstRowNum();      
					            
					             
					             //iterate over all the row to print the data present in each cell.
					            for(int i=1;i<=rowCount;i++){
					                 
					                //get cell count in a row
					                int cellcount=sheet.getRow(i).getLastCellNum();         
					                Employee emp = new Employee();
					                
					                //iterate over each cell to print its value       
					                for(int j=1;j<cellcount;j++){

					                	
					                	if(sheet.getRow(i).getCell(j)!=null) {
					                		if(j==1) {
					                			switch (sheet.getRow(i).getCell(j).getCellType()){
					                            case Cell.CELL_TYPE_BLANK:
					                            	break;
					                            case Cell.CELL_TYPE_NUMERIC:
					                            	emp.setEmpNo(String.valueOf((long) sheet.getRow(i).getCell(j).getNumericCellValue()));
					                            	break;
					                            case Cell.CELL_TYPE_STRING:
					                            	emp.setEmpNo(sheet.getRow(i).getCell(j).getStringCellValue());
					                            	break;
							                	}
					                		}
					                		if(j==2) {
					                			switch (sheet.getRow(i).getCell(j).getCellType()){
					                            case Cell.CELL_TYPE_BLANK:
					                            	break;
					                            case Cell.CELL_TYPE_NUMERIC:
					                            	 emp.setEmpName(String.valueOf(sheet.getRow(i).getCell(j).getNumericCellValue()));
					                            	 break;
					                            case Cell.CELL_TYPE_STRING:
					                            	 emp.setEmpName( sheet.getRow(i).getCell(j).getStringCellValue().toString());
					                            	 break;
							                	}
					                		}
					                		if(j==3) {
					                			switch (sheet.getRow(i).getCell(j).getCellType()){
					                            case Cell.CELL_TYPE_BLANK:
					                            	break;
					                            case Cell.CELL_TYPE_NUMERIC:
					                            	emp.setExtNo(String.valueOf((long)sheet.getRow(i).getCell(j).getNumericCellValue()));
					                            	break;
					                            case Cell.CELL_TYPE_STRING:
					                            	emp.setExtNo(sheet.getRow(i).getCell(j).getStringCellValue());
					                            	break;
							                	}
					                		}
					                		if(j==4) {
					                			switch (sheet.getRow(i).getCell(j).getCellType()){
					                            case Cell.CELL_TYPE_BLANK:
					                            	break;
					                            case Cell.CELL_TYPE_NUMERIC:
					                            	emp.setMobileNo(Long.parseLong(NumberToTextConverter.toText(sheet.getRow(i).getCell(j).getNumericCellValue())));
					                            	break;
					                            case Cell.CELL_TYPE_STRING:
					                            	emp.setMobileNo(Long.parseLong(sheet.getRow(i).getCell(j).getStringCellValue()));
					                            	break;
							                	}
					                		}
					                		if(j==5) {
					                			switch (sheet.getRow(i).getCell(j).getCellType()){
					                            case Cell.CELL_TYPE_BLANK:
					                            	break;
					                            case Cell.CELL_TYPE_NUMERIC:
					                            	emp.setEmail(String.valueOf(sheet.getRow(i).getCell(j).getNumericCellValue()));
					                            	break;
					                            case Cell.CELL_TYPE_STRING:
					                            	emp.setEmail(sheet.getRow(i).getCell(j).getStringCellValue());
					                            	break;
					                			}
					                		}
					                		if(j==6) {
					                			switch (sheet.getRow(i).getCell(j).getCellType()){
					                            case Cell.CELL_TYPE_BLANK:
					                            	break;
					                            case Cell.CELL_TYPE_NUMERIC:
					                            	emp.setDronaEmail(String.valueOf(sheet.getRow(i).getCell(j).getNumericCellValue()));
					                            	break;
					                            case Cell.CELL_TYPE_STRING:
					                            	emp.setDronaEmail(sheet.getRow(i).getCell(j).getStringCellValue());
					                            	break;
					                			}
					                		}
					                		if(j==7) {
					                			switch (sheet.getRow(i).getCell(j).getCellType()){
					                            case Cell.CELL_TYPE_BLANK:
					                            	break;
					                            case Cell.CELL_TYPE_NUMERIC:
					                            	emp.setInternetEmail(String.valueOf(sheet.getRow(i).getCell(j).getNumericCellValue()));
					                            	break;
					                            case Cell.CELL_TYPE_STRING:
					                            	emp.setInternetEmail(sheet.getRow(i).getCell(j).getStringCellValue());
					                            	break;
					                			}
					                		}
					                	}
					                	  
					                }
					                emp.setLabCode(LabCode);
					                emp.setSrNo(0l);
					                emp.setDivisionId(1l);
					                emp.setDesigId(1l);
					                emp.setIsActive(1);
					                emp.setCreatedBy(UserId);
					                emp.setCreatedDate(sdf1.format(new Date()));
					                if(emp.getEmpName()!=null && emp.getEmpNo()!=null) {
					                	employee.add(emp);
					                }
					                
					            }
					            
					            List<Employee> count =employeemasterrepo.saveAll(employee);
								if (count.size() > 0) {
									redir.addAttribute("result", "Employee Added Successfully");
								} else {
									redir.addAttribute("resultfail", "Employee Adding Unsuccessfully");
								}
								redir.addAttribute("Onboard","Yes");
								return "redirect:/Officer.htm";
							
						} catch (Exception e) {
							e.printStackTrace();
						
						}
						
					}	
				}
			           
				req.setAttribute("OfficerList", service.OfficerList().stream().filter(e-> e[11]!=null).filter(e-> LabCode.equalsIgnoreCase(e[11].toString())).collect(Collectors.toList()));  
			          
				}catch(Exception e){
					e.printStackTrace();
					logger.error(new Date() +"Inside EmployeeMasterExcelUpload.htm "+UserId,e);
				}
		 
			 return "master/OfficerMasterList";
		 
	 }
	 
	 @RequestMapping(value="ProjectMasterExcelUpload.htm" ,method = RequestMethod.POST)
	 public String ProjectmasterExcelUpload( RedirectAttributes redir,HttpServletRequest req ,HttpServletResponse res ,HttpSession ses)throws Exception
	 {
		 String UserId=(String)ses.getAttribute("Username");
		 String LabCode =(String) ses.getAttribute("labcode");
		 logger.info(new Date() +"Inside ProjectMasterExcelUpload.htm "+UserId);
			 try{
				String action = req.getParameter("Action"); 
				
				if("GenerateExcel".equalsIgnoreCase(action)) {
					XSSFWorkbook workbook = new XSSFWorkbook();
					XSSFSheet sheet =  workbook.createSheet("Project Master Details");
					XSSFRow row=sheet.createRow(0);
					
					CellStyle unlockedCellStyle = workbook.createCellStyle();
					unlockedCellStyle.setLocked(true);
					
					row.createCell(0).setCellValue("SN");
					row.createCell(1).setCellValue("Project Code");
					row.createCell(2).setCellValue("Project Name");
					row.createCell(3).setCellValue("Project No");
					row.createCell(4).setCellValue("Project Unit Code");
					row.createCell(5).setCellValue("Project Sanction Letter No");
					row.createCell(6).setCellValue("Total Sanction Cost");
					row.createCell(7).setCellValue("Sanction Cost FE");
					row.createCell(8).setCellValue("Sanction Cost RE");
					row.createCell(9).setCellValue("Nodal & Participating Lab");
					row.createCell(10).setCellValue("Scope");
					row.createCell(11).setCellValue("Objective");
					row.createCell(12).setCellValue("Deliverable");

					
						row=sheet.createRow(1);
						row.createCell(0).setCellValue(String.valueOf(1));
						row.createCell(1).setCellValue("");
						row.createCell(2).setCellValue("");
						row.createCell(3).setCellValue("");
						row.createCell(4).setCellValue("");
						row.createCell(5).setCellValue("");
						row.createCell(6).setCellValue("");
						row.createCell(7).setCellValue("");
						row.createCell(8).setCellValue("");
						row.createCell(9).setCellValue("");
						row.createCell(10).setCellValue("");
						row.createCell(11).setCellValue("");
						row.createCell(12).setCellValue("");
					    res.setContentType("application/vnd.ms-excel");
			            res.setHeader("Content-Disposition", "attachment; filename=ProjectMaster.xls");	
			            workbook.write(res.getOutputStream());
				}else if("UploadExcel".equalsIgnoreCase(action)){
					
					if(ServletFileUpload.isMultipartContent(req)) {
						try {
							
							List<FileItem> multiparts = new ServletFileUpload( new DiskFileItemFactory()).parseRequest(new ServletRequestContext(req));
							Part filePart = req.getPart("filename");

							 List<ProjectMain> projectmain = new ArrayList<ProjectMain>();
							 InputStream fileData = filePart.getInputStream();
							   
					            Workbook workbook = new XSSFWorkbook(fileData);
					 
					            Sheet sheet  = workbook.getSheetAt(0);
					            int rowCount=sheet.getLastRowNum()-sheet.getFirstRowNum();      
					            
					             
					             //iterate over all the row to print the data present in each cell.
					            for(int i=1;i<=rowCount;i++){
					                 
					                //get cell count in a row
					                int cellcount=sheet.getRow(i).getLastCellNum();         
					                ProjectMain protype=new ProjectMain();
					                
					                //iterate over each cell to print its value       
					                for(int j=1;j<cellcount;j++){

					                	if(sheet.getRow(i).getCell(j)!=null) {
					                		if(j==1) {
					                			switch (sheet.getRow(i).getCell(j).getCellType()){
					                            case Cell.CELL_TYPE_BLANK:
					                            	break;
					                            case Cell.CELL_TYPE_NUMERIC:
					                            	protype.setProjectCode(String.valueOf((long)sheet.getRow(i).getCell(j).getNumericCellValue()));
					                            	break;
					                            case Cell.CELL_TYPE_STRING:
					                            	protype.setProjectCode(sheet.getRow(i).getCell(j).getStringCellValue());
					                            	break;
							                	}
					                		}
					                		if(j==2) {
					                			switch (sheet.getRow(i).getCell(j).getCellType()){
					                            case Cell.CELL_TYPE_BLANK:
					                            	break;
					                            case Cell.CELL_TYPE_NUMERIC:
					                            	 protype.setProjectName(String.valueOf((long)sheet.getRow(i).getCell(j).getNumericCellValue()));
					                            	 break;
					                            case Cell.CELL_TYPE_STRING:
					                            	 protype.setProjectName( sheet.getRow(i).getCell(j).getStringCellValue().toString());
					                            	 break;
							                	}
					                		}
					                		if(j==3) {
					                			switch (sheet.getRow(i).getCell(j).getCellType()){
					                            case Cell.CELL_TYPE_BLANK:
					                            	break;
					                            case Cell.CELL_TYPE_NUMERIC:
					                            	protype.setProjectDescription(String.valueOf((long)sheet.getRow(i).getCell(j).getNumericCellValue()));
					                            	break;
					                            case Cell.CELL_TYPE_STRING:
					                            	protype.setProjectDescription(sheet.getRow(i).getCell(j).getStringCellValue());
					                            	break;
							                	}
					                		}
					                		
					                		if(j==4) {
					                			switch (sheet.getRow(i).getCell(j).getCellType()){
					                            case Cell.CELL_TYPE_BLANK:
					                            	break;
					                            case Cell.CELL_TYPE_NUMERIC:
					                            	protype.setUnitCode(String.valueOf((long)sheet.getRow(i).getCell(j).getNumericCellValue()));
					                            	break;
					                            case Cell.CELL_TYPE_STRING:
					                            	protype.setUnitCode(sheet.getRow(i).getCell(j).getStringCellValue());
					                            	break;
							                	}
					                		}
					                		if(j==5) {
					                			switch (sheet.getRow(i).getCell(j).getCellType()){
					                            case Cell.CELL_TYPE_BLANK:
					                            	break;
					                            case Cell.CELL_TYPE_NUMERIC:
					                            	protype.setSanctionNo(NumberToTextConverter.toText((long)sheet.getRow(i).getCell(j).getNumericCellValue()));
					                            	break;
					                            case Cell.CELL_TYPE_STRING:
					                            	protype.setSanctionNo(sheet.getRow(i).getCell(j).getStringCellValue());
					                            	break;
							                	}
					                		}
					                		if(j==6) {
					                			switch (sheet.getRow(i).getCell(j).getCellType()){
					                            case Cell.CELL_TYPE_BLANK:
					                            	break;
					                            case Cell.CELL_TYPE_NUMERIC:
					                            	protype.setTotalSanctionCost(sheet.getRow(i).getCell(j).getNumericCellValue());
					                            	break;
					                            case Cell.CELL_TYPE_STRING:
					                            	protype.setTotalSanctionCost(Double.parseDouble(sheet.getRow(i).getCell(j).getStringCellValue()));
					                            	break;
					                			}
					                		}
					                		if(j==7) {
					                			switch (sheet.getRow(i).getCell(j).getCellType()){
					                            case Cell.CELL_TYPE_BLANK:
					                            	break;
					                            case Cell.CELL_TYPE_NUMERIC:
					                            	protype.setSanctionCostFE(sheet.getRow(i).getCell(j).getNumericCellValue());
					                            	break;
					                            case Cell.CELL_TYPE_STRING:
					                            	protype.setSanctionCostFE(Double.parseDouble(sheet.getRow(i).getCell(j).getStringCellValue()));
					                            	break;
					                			}
					                		}
					                		if(j==8) {
					                			switch (sheet.getRow(i).getCell(j).getCellType()){
					                            case Cell.CELL_TYPE_BLANK:
					                            	break;
					                            case Cell.CELL_TYPE_NUMERIC:
					                            	protype.setSanctionCostRE(sheet.getRow(i).getCell(j).getNumericCellValue());
					                            	break;
					                            case Cell.CELL_TYPE_STRING:
					                            	protype.setSanctionCostRE(Double.parseDouble(sheet.getRow(i).getCell(j).getStringCellValue()));
					                            	break;
					                			}
					                		}
					                		if(j==9) {
					                			switch (sheet.getRow(i).getCell(j).getCellType()){
					                            case Cell.CELL_TYPE_BLANK:
					                            	break;
					                            case Cell.CELL_TYPE_NUMERIC:
					                            	protype.setLabParticipating(String.valueOf(NumberToTextConverter.toText((long)sheet.getRow(i).getCell(j).getNumericCellValue())));
					                            	break;
					                            case Cell.CELL_TYPE_STRING:
					                            	protype.setLabParticipating(sheet.getRow(i).getCell(j).getStringCellValue());
					                            	break;
							                	}
					                		}
					                		if(j==10) {
					                			switch (sheet.getRow(i).getCell(j).getCellType()){
					                            case Cell.CELL_TYPE_BLANK:
					                            	break;
					                            case Cell.CELL_TYPE_NUMERIC:
					                            	protype.setScope(String.valueOf((long)sheet.getRow(i).getCell(j).getNumericCellValue()));
					                            	break;
					                            case Cell.CELL_TYPE_STRING:
					                            	protype.setScope(sheet.getRow(i).getCell(j).getStringCellValue());
					                            	break;
					                			}
					                		}
					                		if(j==11) {
					                			switch (sheet.getRow(i).getCell(j).getCellType()){
					                            case Cell.CELL_TYPE_BLANK:
					                            	break;
					                            case Cell.CELL_TYPE_NUMERIC:
					                            	protype.setObjective(String.valueOf((long)sheet.getRow(i).getCell(j).getNumericCellValue()));
					                            	break;
					                            case Cell.CELL_TYPE_STRING:
					                            	protype.setObjective(sheet.getRow(i).getCell(j).getStringCellValue());
					                            	break;
					                			}
					                		}
					                		if(j==12) {
					                			switch (sheet.getRow(i).getCell(j).getCellType()){
					                            case Cell.CELL_TYPE_BLANK:
					                            	break;
					                            case Cell.CELL_TYPE_NUMERIC:
					                            	protype.setDeliverable(String.valueOf((long)sheet.getRow(i).getCell(j).getNumericCellValue()));
					                            	break;
					                            case Cell.CELL_TYPE_STRING:
					                            	protype.setDeliverable(sheet.getRow(i).getCell(j).getStringCellValue());
					                            	break;
					                			}
					                		}
					                		
					                	
					                	}
					                	  
					                }
					               
					                long millis=System.currentTimeMillis();  
					                java.sql.Date date=new java.sql.Date(millis);  
					                	protype.setPDC(date);
					                	protype.setSanctionDate(date);
					                	protype.setRevisionNo(0l);
						                protype.setProjSancAuthority("DG");
						                protype.setBoardReference("DMC");
						                protype.setProjectTypeId(1l);
						                protype.setCategoryId(1l);
						                protype.setProjectDirector(1l);
						                protype.setIsActive(1);
						                protype.setCreatedBy(UserId);
						                protype.setCreatedDate(sdf1.format(new Date()));
						                if(protype.getProjectCode()!=null && protype.getProjectName()!=null ) {
						                	projectmain.add(protype);
						                }
					                
					            }
					                           
					            List<ProjectMain> count = projectmainrepo.saveAll(projectmain);
								if (count.size() > 0) {
									redir.addAttribute("result", "Project Main Added Successfully");
								} else {
									redir.addAttribute("resultfail", "Project Main Adding Unsuccessfully");
								}
								redir.addAttribute("Onboard","Yes");
								return "redirect:/ProjectMain.htm";
							
						} catch (Exception e) {
							e.printStackTrace();
							redir.addAttribute("resultfail", "Project Main Adding Unsuccessfully");
							return "redirect:/ProjectMain.htm";
						}
					}	
				}
			           
				req.setAttribute("ProjectMainList", projectservice.ProjectMainList());     
				}catch(Exception e){
					e.printStackTrace();
					logger.error(new Date() +"Inside ProjectMasterExcelUpload.htm "+UserId,e);
				}
		 
			 return "project/ProjectMainList";
		 
	 }
	 
	 @RequestMapping(value="OnBoarding.htm" ,method = RequestMethod.GET)
	 public String OnBoarding( RedirectAttributes redir,HttpServletRequest req ,HttpServletResponse res ,HttpSession ses)throws Exception
	 {
		 String UserId=(String)ses.getAttribute("Username");
		 logger.info(new Date() +"Inside OnBoarding.htm "+UserId); 
		 try {
			}catch(Exception e){
					e.printStackTrace();
					logger.error(new Date() +"Inside OnBoarding.htm "+UserId,e);
			}
			 return "print/OnBoarding";
	 }
	 
	 @RequestMapping(value="ActionMainExcelUpload.htm" ,method = RequestMethod.POST)
	 public String ActionMainExcelUpload( RedirectAttributes redir,HttpServletRequest req ,HttpServletResponse res ,HttpSession ses)throws Exception
	 {
		 String UserId=(String)ses.getAttribute("Username");
		 String LabCode =(String) ses.getAttribute("labcode");
		 logger.info(new Date() +"Inside ActionMainExcelUpload.htm "+UserId);
			 try{
				String action = req.getParameter("Action"); 
				
				if("GenerateExcel".equalsIgnoreCase(action)) {
					XSSFWorkbook workbook = new XSSFWorkbook();
					XSSFSheet sheet =  workbook.createSheet("Project Master Details");
					XSSFRow row=sheet.createRow(0);
					
					CellStyle unlockedCellStyle = workbook.createCellStyle();
					unlockedCellStyle.setLocked(true);
					
					row.createCell(0).setCellValue("SN");
					row.createCell(1).setCellValue("Action Item");

						row=sheet.createRow(1);
						row.createCell(0).setCellValue(String.valueOf(1));
						row.createCell(1).setCellValue("");
			
					    res.setContentType("application/vnd.ms-excel");
			            res.setHeader("Content-Disposition", "attachment; filename=ActionMain.xls");	
			            workbook.write(res.getOutputStream());
				}else if("UploadExcel".equalsIgnoreCase(action)){
					
					if(ServletFileUpload.isMultipartContent(req)) {
						try {
							
							List<FileItem> multiparts = new ServletFileUpload( new DiskFileItemFactory()).parseRequest(new ServletRequestContext(req));
							Part filePart = req.getPart("filename");

							 Long count=0l;
							 InputStream fileData = filePart.getInputStream();
							   
					            Workbook workbook = new XSSFWorkbook(fileData);
					 
					            Sheet sheet  = workbook.getSheetAt(0);
					            int rowCount=sheet.getLastRowNum()-sheet.getFirstRowNum();      
					            
					             
					             //iterate over all the row to print the data present in each cell.
					            for(int i=1;i<=rowCount;i++){
					                 
					                //get cell count in a row
					                int cellcount=sheet.getRow(i).getLastCellNum();         
					                ActionMainDto actionmain=new ActionMainDto();
					                
					                //iterate over each cell to print its value       
					                for(int j=1;j<cellcount;j++){

					                	if(sheet.getRow(i).getCell(j)!=null) {
					                		if(j==1) {
					                			switch (sheet.getRow(i).getCell(j).getCellType()){
					                            case Cell.CELL_TYPE_BLANK:
					                            	break;
					                            case Cell.CELL_TYPE_NUMERIC:
					                            	actionmain.setActionItem(String.valueOf((long)sheet.getRow(i).getCell(j).getNumericCellValue()));
					                            	break;
					                            case Cell.CELL_TYPE_STRING:
					                            	actionmain.setActionItem(sheet.getRow(i).getCell(j).getStringCellValue());
					                            	break;
							                	}
					                		}
					                	}
					                	  
					                }
					               
					                long millis=System.currentTimeMillis();  
					                java.sql.Date date=new java.sql.Date(millis);  
					               
					                
					                	actionmain.setActionDate(LocalDate.now().plusMonths(4).toString());
					                	actionmain.setActionLevel(1l);
					                	actionmain.setMainId("0");
					                	actionmain.setActionParentId("0");
					                	actionmain.setActionType("N");
						                actionmain.setType("A");
						                actionmain.setProjectId("0");
						                actionmain.setActivityId("0");
						                actionmain.setScheduleMinutesId("0");
						                actionmain.setCategory("O");
						                actionmain.setPriority("M");
						                actionmain.setLabName(LabCode);
						                actionmain.setMeetingDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
						                actionmain.setCreatedBy(UserId);
						                actionmain.setCreatedDate(sdf1.format(new Date()));
						                if(actionmain.getActionItem()!=null  ) {
						                	ActionAssign assign = new ActionAssign();
						                		assign.setEndDate(java.sql.Date.valueOf(LocalDate.now().plusMonths(4)));
						                		assign.setPDCOrg(java.sql.Date.valueOf(LocalDate.now().plusMonths(4)));
							        			assign.setAssignee( (Long) ses.getAttribute("EmpId"));
							        			assign.setAssignor((Long) ses.getAttribute("EmpId"));
							        			assign.setAssigneeLabCode(LabCode);
							        			assign.setAssignorLabCode(LabCode);
							        			assign.setRevision(0);
							        			assign.setActionFlag("N");		
							        			assign.setActionStatus("A");
							        			assign.setCreatedBy(UserId);
							        			assign.setIsActive(1);
							        			count +=actionservice.ActionMainInsertFromOnboard(actionmain , assign);
						                }
					            }
					                           
					           
								if (count > 0) {
									redir.addAttribute("result", "Action Main Added Successfully");
								} else {
									redir.addAttribute("resultfail", "Action Main Adding Unsuccessfull");
								}
								redir.addAttribute("Onboard","Yes");
								return "redirect:/ActionLaunch.htm";
							
						}catch(Exception e){
							e.printStackTrace();
							redir.addAttribute("resultfail", "Action Main Adding Unsuccessfull");
							return "redirect:/ActionLaunch.htm";
						}
					}	
				} 
				}catch(Exception e){
					e.printStackTrace();
					logger.error(new Date() +"Inside ActionMainExcelUpload.htm "+UserId,e);
				}
		 
			 return "redirect:/ActionLaunch.htm";
		 
	 }
	 
	 
	 
}

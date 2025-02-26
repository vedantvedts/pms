package com.vts.pfms.OnBoardingRepository;

import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.NumberToTextConverter;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.vts.pfms.admin.dto.UserManageAdd;
import com.vts.pfms.admin.model.DivisionMaster;
import com.vts.pfms.admin.service.AdminService;
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
	
	private static final Logger logger=LogManager.getLogger(OnBoardingController.class);
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
					
					row.createCell(0).setCellValue("SN");sheet.setColumnWidth(0, 5000);
					row.createCell(1).setCellValue("Group Code");sheet.setColumnWidth(1, 5000);
					row.createCell(2).setCellValue("Group Name");sheet.setColumnWidth(2, 5000);

					int r=0;
					
						row=sheet.createRow(++r);
						row.createCell(0).setCellValue(String.valueOf(r));
						row.createCell(1).setCellValue("");
						row.createCell(2).setCellValue("");

					    res.setContentType("application/vnd.ms-excel");
			            res.setHeader("Content-Disposition", "attachment; filename=GroupMaster.xls");	
			            workbook.write(res.getOutputStream());
				}else if("UploadExcel".equalsIgnoreCase(action)){
			
					if (req.getContentType() != null && req.getContentType().startsWith("multipart/")) {
						try {
							
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
					                  dgm.setGroupHeadId((Long)ses.getAttribute("EmpId"));
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
								redir.addFlashAttribute("Onboard","Yes");
								return "redirect:/GroupMaster.htm";
							
						} catch (Exception e) {
							e.printStackTrace();
							redir.addFlashAttribute("Onboard","Yes");
							redir.addAttribute("resultfail", "Group Adding Unsuccessfully");
						}
						
					}	
				}
						req.setAttribute("groupslist",service.GroupsList(LabCode) );
			          
				}catch(Exception e){
					e.printStackTrace();
					redir.addFlashAttribute("Onboard","Yes");
					redir.addAttribute("resultfail", "Group Adding Unsuccessfully");
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
					
					row.createCell(0).setCellValue("SN");sheet.setColumnWidth(0, 5000);
					row.createCell(1).setCellValue("Division Code");sheet.setColumnWidth(1, 5000);
					row.createCell(2).setCellValue("Division Name");sheet.setColumnWidth(2, 5000);

					int r=0;
					
						row=sheet.createRow(++r);
						row.createCell(0).setCellValue(String.valueOf(r));
						row.createCell(1).setCellValue("");
						row.createCell(2).setCellValue("");

					    res.setContentType("application/vnd.ms-excel");
			            res.setHeader("Content-Disposition", "attachment; filename=DivisionMaster.xls");	
			            workbook.write(res.getOutputStream());
				}else if("UploadExcel".equalsIgnoreCase(action)){
					
					if (req.getContentType() != null && req.getContentType().startsWith("multipart/")) {
						try {
							
							Part filePart = req.getPart("filename");
							Object[] empdata =adminservice.EmployeeData(String.valueOf((Long)ses.getAttribute("EmpId")));
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
					                  if(empdata!=null && empdata[6]!=null){
					                	  dmo.setGroupId(Long.parseLong(empdata[6]+""));
					                  }else {
					                	  redir.addAttribute("resultfail", "Logged  In Employee Its Don't Have Group Id");
					                	  redir.addFlashAttribute("Onboard","Yes");
											return "redirect:/DivisionMaster.htm";	
					                  }
						              dmo.setDivisionHeadId((Long)ses.getAttribute("EmpId"));
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
								redir.addFlashAttribute("Onboard","Yes");
								return "redirect:/DivisionMaster.htm";	
							
						} catch (Exception e) {
							e.printStackTrace();
							redir.addFlashAttribute("Onboard","Yes");
							redir.addAttribute("resultfail", "Division Adding Unsuccessfully");
						}
						
					}	
				}
						req.setAttribute("DivisionMasterList",adminservice.DivisionMasterList(LabCode) );
			          
				}catch(Exception e){
					e.printStackTrace();
					redir.addFlashAttribute("Onboard","Yes");
					redir.addAttribute("resultfail", "Division Adding Unsuccessfully");
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
					
					row.createCell(0).setCellValue("SN");sheet.setColumnWidth(0, 5000);
					row.createCell(1).setCellValue("Employee Number");sheet.setColumnWidth(1, 5000);
					row.createCell(2).setCellValue("Employee Name");sheet.setColumnWidth(2, 5000);
					row.createCell(3).setCellValue("Extention Number");sheet.setColumnWidth(3, 5000);
					row.createCell(4).setCellValue("Mobile Number");sheet.setColumnWidth(4, 5000);
					row.createCell(5).setCellValue("Email");sheet.setColumnWidth(5, 5000);
					row.createCell(6).setCellValue("Drona Email");sheet.setColumnWidth(6, 5000);
					row.createCell(7).setCellValue("Internet Email");sheet.setColumnWidth(7, 5000);

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
					
					if (req.getContentType() != null && req.getContentType().startsWith("multipart/")) {
						try {
							
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
					                emp.setDivisionId((Long)ses.getAttribute("Division"));
					                emp.setDesigId(Long.parseLong(ses.getAttribute("DesgId").toString()));
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
								redir.addFlashAttribute("Onboard","Yes");
								return "redirect:/Officer.htm";
							
						} catch (Exception e) {
							e.printStackTrace();
							redir.addFlashAttribute("Onboard","Yes");
							redir.addAttribute("resultfail", "Employee Adding Unsuccessfully");
						}
						
					}	
				}
			           
				req.setAttribute("OfficerList", service.OfficerList().stream().filter(e-> e[11]!=null).filter(e-> LabCode.equalsIgnoreCase(e[11].toString())).collect(Collectors.toList()));  
			          
				}catch(Exception e){
					e.printStackTrace();
					redir.addFlashAttribute("Onboard","Yes");
					redir.addAttribute("resultfail", "Employee Adding Unsuccessfully");
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
				
				if("GenerateExcel".equalsIgnoreCase(action)){
					XSSFWorkbook workbook = new XSSFWorkbook();
					XSSFSheet sheet =  workbook.createSheet("Project Main Details");
					XSSFRow row=sheet.createRow(0);
					
					CellStyle unlockedCellStyle = workbook.createCellStyle();
					unlockedCellStyle.setLocked(true);
					
					row.createCell(0).setCellValue("SN");sheet.setColumnWidth(0, 5000);
					row.createCell(1).setCellValue("Project Code");sheet.setColumnWidth(1, 5000);
					row.createCell(2).setCellValue("Project Name");sheet.setColumnWidth(2, 5000);
					row.createCell(3).setCellValue("Project No");sheet.setColumnWidth(3, 5000);
					row.createCell(4).setCellValue("Project Unit Code");sheet.setColumnWidth(4, 5000);
					row.createCell(5).setCellValue("Project Sanction Letter No");sheet.setColumnWidth(5, 5000);
					row.createCell(6).setCellValue("Total Sanction Cost");sheet.setColumnWidth(6, 5000);
					row.createCell(7).setCellValue("Sanction Cost FE");sheet.setColumnWidth(7, 5000);
					//row.createCell(8).setCellValue("Sanction Cost RE");sheet.setColumnWidth(8, 5000);
					row.createCell(8).setCellValue("Nodal & Participating Lab");sheet.setColumnWidth(8, 5000);
					row.createCell(9).setCellValue("Scope");sheet.setColumnWidth(9, 5000);
					row.createCell(10).setCellValue("Objective");sheet.setColumnWidth(10, 5000);
					row.createCell(11).setCellValue("Deliverable");sheet.setColumnWidth(11, 5000);

					
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
						
					    res.setContentType("application/vnd.ms-excel");
			            res.setHeader("Content-Disposition", "attachment; filename=ProjectMain.xls");	
			            workbook.write(res.getOutputStream());
				}else if("UploadExcel".equalsIgnoreCase(action)){
					
					if (req.getContentType() != null && req.getContentType().startsWith("multipart/")) {
						try {
							
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
					                            	protype.setLabParticipating(String.valueOf(NumberToTextConverter.toText((long)sheet.getRow(i).getCell(j).getNumericCellValue())));
					                            	break;
					                            case Cell.CELL_TYPE_STRING:
					                            	protype.setLabParticipating(sheet.getRow(i).getCell(j).getStringCellValue());
					                            	break;
							                	}
					                		}
					                		if(j==9) {
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
					                		if(j==10) {
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
					                		if(j==11) {
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
					                
					                double sanccostRE=protype.getTotalSanctionCost()-protype.getSanctionCostFE();
					                	protype.setSanctionCostRE(sanccostRE);
					                	protype.setPDC(date);
					                	protype.setSanctionDate(date);
					                	protype.setRevisionNo(0l);
						                protype.setProjSancAuthority("DG");
						                protype.setBoardReference("DMC");
						                protype.setProjectTypeId(1l);
						                protype.setCategoryId(1l);
						                protype.setProjectDirector((Long)ses.getAttribute("EmpId"));
						                protype.setIsActive(1);
						                protype.setCreatedBy(UserId);
						                protype.setCreatedDate(sdf1.format(new Date()));
						                if(protype.getProjectCode()!=null && protype.getProjectName()!=null ) {
						                	projectmain.add(protype);
						                }else {
							                	redir.addAttribute("resultfail", "Please Check Excel Data Properly");
							                	redir.addFlashAttribute("Onboard","Yes");
											return "redirect:/ProjectMain.htm";
						                }
					                
					            }
					                           
					            List<ProjectMain> count = projectmainrepo.saveAll(projectmain);
								if (count.size() > 0) {
									redir.addAttribute("result", "Project Main Added Successfully");
								} else {
									redir.addAttribute("resultfail", "Project Main Adding Unsuccessfully");
								}
								redir.addFlashAttribute("Onboard","Yes");
								return "redirect:/ProjectMain.htm";
							
						} catch (Exception e) {
							e.printStackTrace();
							redir.addFlashAttribute("Onboard","Yes");
							redir.addAttribute("resultfail", "Project Main Adding Unsuccessfully");
							return "redirect:/ProjectMain.htm";
						}
					}	
				}
			           
				req.setAttribute("ProjectMainList", projectservice.ProjectMainList());     
				}catch(Exception e){
					e.printStackTrace();
					redir.addFlashAttribute("Onboard","Yes");
					redir.addAttribute("resultfail", "Project Main Adding Unsuccessfully");
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
		 String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		 String Logintype= (String)ses.getAttribute("LoginType");
		 logger.info(new Date() +"Inside ActionMainExcelUpload.htm "+UserId);
			 try{
				String action = req.getParameter("Action"); 
				
				if("GenerateExcel".equalsIgnoreCase(action)) {
					XSSFWorkbook workbook = new XSSFWorkbook();
					XSSFSheet sheet =  workbook.createSheet("Project Master Details");
					XSSFRow row=sheet.createRow(0);
					
				
				
					sheet.addMergedRegion(new CellRangeAddress(0,0,0,9));
				
					 XSSFCell headerCell = row.createCell(0);
					 headerCell.setCellValue("Note :- Action Type( A-Action , I-Issue , K-Risk)  Date Format (DD-MM-YYYY) Priority(H-High, L-Low , M-Medium , I-Immediate) Category(T-Technical , F-Finance M-Managerial ,L-Logistic , O-Others) \n Project Code :-General (GEN)  Note: Change the Excel Format in your Excel file (Right click on the cell---> Format Cell --->Number -->select category---> Date --->Type (YYYY-MM-DD))");
					 XSSFCellStyle cellstyle = workbook.createCellStyle();
					 XSSFFont font = workbook.createFont();		
					 font.setBold(true);
					 CellStyle cs = workbook.createCellStyle();  
			          cs.setWrapText(true);
			          cs.setFont(font);
			            headerCell.setCellStyle(cs);  
			            row.setHeightInPoints((2*sheet.getDefaultRowHeightInPoints()));  
			            sheet.autoSizeColumn(2);
					 
					CellStyle unlockedCellStyle = workbook.createCellStyle();
					unlockedCellStyle.setLocked(true);
					
					row=sheet.createRow(1);
					row.createCell(0).setCellValue("SN");sheet.setColumnWidth(0, 5000);
					row.createCell(1).setCellValue("Action Item");sheet.setColumnWidth(1, 5000);
					row.createCell(2).setCellValue("Project Code");sheet.setColumnWidth(2, 5000);
					row.createCell(3).setCellValue("Action Type");sheet.setColumnWidth(3, 5000);
					row.createCell(4).setCellValue("Action Date");sheet.setColumnWidth(4, 5000);
					row.createCell(5).setCellValue("PDC Date");sheet.setColumnWidth(5, 5000);
					row.createCell(6).setCellValue("Priority");sheet.setColumnWidth(6, 5000);
					row.createCell(7).setCellValue("Category");sheet.setColumnWidth(7, 5000);
					
					
						row=sheet.createRow(2);
						row.createCell(0).setCellValue(String.valueOf(1));
						row.createCell(1).setCellValue("");
						row.createCell(2).setCellValue("");
						row.createCell(3).setCellValue("");
						row.createCell(4).setCellValue("");
						row.createCell(5).setCellValue("");
						row.createCell(6).setCellValue("");
						row.createCell(7).setCellValue("");
			
					    res.setContentType("application/vnd.ms-excel");
			            res.setHeader("Content-Disposition", "attachment; filename=ActionMain.xls");	
			            workbook.write(res.getOutputStream());
				}else if("UploadExcel".equalsIgnoreCase(action)){
					
					if (req.getContentType() != null && req.getContentType().startsWith("multipart/")) {
						try {
							
							Part filePart = req.getPart("filename");

							 Long count=0l;
							 InputStream fileData = filePart.getInputStream();
							   
					            Workbook workbook = new XSSFWorkbook(fileData);
					 
					            Sheet sheet  = workbook.getSheetAt(0);
					            int rowCount=sheet.getLastRowNum()-sheet.getFirstRowNum();      
					            List<Object[]> projectlist = actionservice.LoginProjectDetailsList(EmpId, Logintype, LabCode);
					             
					             //iterate over all the row to print the data present in each cell.
					            for(int i=2;i<=rowCount;i++){
					                 
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
					                		if(j==2){
					                			switch (sheet.getRow(i).getCell(j).getCellType()){
					                            case Cell.CELL_TYPE_BLANK:
					                            	break;
					                            case Cell.CELL_TYPE_NUMERIC:
					                            	actionmain.setProjectId(String.valueOf((long)sheet.getRow(i).getCell(j).getNumericCellValue()));
					                            	break;
					                            case Cell.CELL_TYPE_STRING:
					                            	actionmain.setProjectId(sheet.getRow(i).getCell(j).getStringCellValue());
					                            	break;
							                	}
					                		}
					                		if(j==3) {
					                			switch (sheet.getRow(i).getCell(j).getCellType()){
					                            case Cell.CELL_TYPE_BLANK:
					                            	break;
					                            case Cell.CELL_TYPE_NUMERIC:
					                            	actionmain.setType(String.valueOf((long)sheet.getRow(i).getCell(j).getNumericCellValue()));
					                            	break;
					                            case Cell.CELL_TYPE_STRING:
					                            	actionmain.setType(sheet.getRow(i).getCell(j).getStringCellValue());
					                            	break;
							                	}
					                		}
					                		if(j==4) {
					                			switch (sheet.getRow(i).getCell(j).getCellType()){
					                            case Cell.CELL_TYPE_BLANK:
					                            	break;
					                            case Cell.CELL_TYPE_NUMERIC:
					                            	actionmain.setActionDate(String.valueOf((long)sheet.getRow(i).getCell(j).getNumericCellValue()));
					                            	break;
					                            case Cell.CELL_TYPE_STRING:
					                            	actionmain.setActionDate(sheet.getRow(i).getCell(j).getStringCellValue());
					                            	break;
							                	}
					                		}
					                		if(j==5) {
					                			switch (sheet.getRow(i).getCell(j).getCellType()){
					                            case Cell.CELL_TYPE_BLANK:
					                            	break;
					                            case Cell.CELL_TYPE_NUMERIC:
					                            	actionmain.setPDCDate(String.valueOf((long)sheet.getRow(i).getCell(j).getNumericCellValue()));
					                            	break;
					                            case Cell.CELL_TYPE_STRING:
					                            	actionmain.setPDCDate(sheet.getRow(i).getCell(j).getStringCellValue());
					                            	break;
							                	}
					                		}
					                		if(j==6) {
					                			switch (sheet.getRow(i).getCell(j).getCellType()){
					                            case Cell.CELL_TYPE_BLANK:
					                            	break;
					                            case Cell.CELL_TYPE_NUMERIC:
					                            	actionmain.setPriority(String.valueOf((long)sheet.getRow(i).getCell(j).getNumericCellValue()));
					                            	break;
					                            case Cell.CELL_TYPE_STRING:
					                            	actionmain.setPriority(sheet.getRow(i).getCell(j).getStringCellValue());
					                            	break;
							                	}
					                		}
					                		if(j==7) {
					                			switch (sheet.getRow(i).getCell(j).getCellType()){
					                            case Cell.CELL_TYPE_BLANK:
					                            	break;
					                            case Cell.CELL_TYPE_NUMERIC:
					                            	actionmain.setCategory(String.valueOf((long)sheet.getRow(i).getCell(j).getNumericCellValue()));
					                            	break;
					                            case Cell.CELL_TYPE_STRING:
					                            	actionmain.setCategory(sheet.getRow(i).getCell(j).getStringCellValue());
					                            	break;
							                	}
					                		}
					                	}
					                	  
					                }
					                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					                Date javaDate= DateUtil.getJavaDate(Double.parseDouble(actionmain.getActionDate()));
					                if(actionmain.getActionDate()!=null && actionmain.getPDCDate()!=null) {
					                	String actiondate = sdf.format(DateUtil.getJavaDate(Double.parseDouble(actionmain.getActionDate())));
						                String  pdcDate =  sdf.format(DateUtil.getJavaDate(Double.parseDouble(actionmain.getPDCDate())));
						                actionmain.setActionDate(actiondate);
						                actionmain.setPDCDate(pdcDate);
					                }else {
					                	redir.addFlashAttribute("Onboard","Yes");
					                	redir.addAttribute("resultfail", "Action Date and PDC Date Is Not Proper!");
										return "redirect:/ActionLaunch.htm";
					                }
					                if(actionmain.getProjectId().equalsIgnoreCase("GEN")) {
					                	actionmain.setProjectId("0");
					                }else {
					                	List<Object[]> proje= projectlist.stream().filter(e-> actionmain.getProjectId().equalsIgnoreCase(e[4].toString())).collect(Collectors.toList());
					                	if(proje!=null && proje.size()>0) {
					                		actionmain.setProjectId(proje.get(0)[0].toString());
					                	}else {
					                		redir.addFlashAttribute("Onboard","Yes");
					                		redir.addAttribute("resultfail", "Project Code data Is Not Proper!");
					                		return "redirect:/ActionLaunch.htm";
					                	}
					                }
					                	actionmain.setActionLevel(1l);
					                	actionmain.setMainId("0");
					                	actionmain.setActionParentId("0");
					                	actionmain.setActionType("N");
						                actionmain.setActivityId("0");
						                actionmain.setScheduleMinutesId("0");
						                actionmain.setLabName(LabCode);
						                actionmain.setMeetingDate(actionmain.getActionDate());
						                actionmain.setCreatedBy(UserId);
						                actionmain.setCreatedDate(sdf1.format(new Date()));
						                if(actionmain.getActionItem()!=null  ) {
						                	ActionAssign assign = new ActionAssign();
						                		assign.setEndDate(java.sql.Date.valueOf(actionmain.getPDCDate()));
						                		assign.setPDCOrg(java.sql.Date.valueOf(actionmain.getPDCDate()));
							        			assign.setAssignee( (Long) ses.getAttribute("EmpId"));
							        			assign.setAssignor((Long) ses.getAttribute("EmpId"));
							        			assign.setAssigneeLabCode(LabCode);
							        			assign.setAssignorLabCode(LabCode);
							        			assign.setRevision(0);
//							        			assign.setActionFlag("N");		
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
								redir.addFlashAttribute("Onboard","Yes");
								return "redirect:/ActionLaunch.htm";
							
						}catch(Exception e){
							e.printStackTrace();
							redir.addFlashAttribute("Onboard","Yes");
							redir.addAttribute("resultfail", "Action Main Adding Unsuccessfull");
							return "redirect:/ActionLaunch.htm";
						}
					}	
				} 
				}catch(Exception e){
					e.printStackTrace();
					redir.addFlashAttribute("Onboard","Yes");
					redir.addAttribute("resultfail", "Action Main Adding Unsuccessfull");
					logger.error(new Date() +"Inside ActionMainExcelUpload.htm "+UserId,e);
				}
		 
			 return "redirect:/ActionLaunch.htm";
	 }
	 
	 @RequestMapping(value="LoginExcelUpload.htm" ,method = {RequestMethod.POST,RequestMethod.GET})
	 public String LoginExcelUpload( RedirectAttributes redir,HttpServletRequest req ,HttpServletResponse res ,HttpSession ses)throws Exception
	 {
		 String UserId=(String)ses.getAttribute("Username");
		 String LabCode =(String) ses.getAttribute("labcode");
		 String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		 String Logintype= (String)ses.getAttribute("LoginType");
		 logger.info(new Date() +"Inside LoginExcelUpload.htm "+UserId);
			 try{
				String action = req.getParameter("Action"); 
				
				if("GenerateExcel".equalsIgnoreCase(action)) {
					XSSFWorkbook workbook = new XSSFWorkbook();
					XSSFSheet sheet =  workbook.createSheet("Login Master Details");
					XSSFRow row=sheet.createRow(0);
					
					sheet.addMergedRegion(new CellRangeAddress(0,0,0,4));
				
					 XSSFCell headerCell = row.createCell(0);
					 headerCell.setCellValue("Note :- Login Type( A-Admin , E-P&C DO , U-User ,T-GHDH , P-Project Director , Z-Director)  ");
					 XSSFCellStyle cellstyle = workbook.createCellStyle();
					 XSSFFont font = workbook.createFont();		
					 font.setBold(true);
					 CellStyle cs = workbook.createCellStyle();  
			          cs.setWrapText(true);
			          cs.setFont(font);
			            headerCell.setCellStyle(cs);  
			            row.setHeightInPoints((2*sheet.getDefaultRowHeightInPoints()));  
			            sheet.autoSizeColumn(2);
					 
					CellStyle unlockedCellStyle = workbook.createCellStyle();
					unlockedCellStyle.setLocked(true);
					
					row=sheet.createRow(1);
					row.createCell(0).setCellValue("SN");sheet.setColumnWidth(0, 5000);
					row.createCell(1).setCellValue("User Name");sheet.setColumnWidth(1, 5000);
					row.createCell(2).setCellValue("Employee Number");sheet.setColumnWidth(2, 5000);
					row.createCell(3).setCellValue("Login Type");sheet.setColumnWidth(3, 5000);
					
						row=sheet.createRow(2);
						row.createCell(0).setCellValue(String.valueOf(1));
						row.createCell(1).setCellValue("");
						row.createCell(2).setCellValue("");
						row.createCell(3).setCellValue("");
			
					    res.setContentType("application/vnd.ms-excel");
			            res.setHeader("Content-Disposition", "attachment; filename=LoginMaster.xls");	
			            workbook.write(res.getOutputStream());
				}else if("UploadExcel".equalsIgnoreCase(action)){
					
					if (req.getContentType() != null && req.getContentType().startsWith("multipart/")) {
						try {
							
							Part filePart = req.getPart("filename");

							 Long count=0l;
							 InputStream fileData = filePart.getInputStream();
							   
					            Workbook workbook = new XSSFWorkbook(fileData);
					 
					            Sheet sheet  = workbook.getSheetAt(0);
					            int rowCount=sheet.getLastRowNum()-sheet.getFirstRowNum();      
					            List<Object[]> officerlist= service.OfficerList();         
					    		
					             //iterate over all the row to print the data present in each cell.
					            for(int i=2;i<=rowCount;i++){
					                 
					                //get cell count in a row
					                int cellcount=sheet.getRow(i).getLastCellNum();         
					                UserManageAdd UserManageAdd=new UserManageAdd();
					                
					                //iterate over each cell to print its value       
					                for(int j=1;j<cellcount;j++){
					                	if(j==1) {
				                			switch (sheet.getRow(i).getCell(j).getCellType()){
				                            case Cell.CELL_TYPE_BLANK:
				                            	break;
				                            case Cell.CELL_TYPE_NUMERIC:
				                            	UserManageAdd.setUserName(NumberToTextConverter.toText((long)sheet.getRow(i).getCell(j).getNumericCellValue()));
				                            	break;
				                            case Cell.CELL_TYPE_STRING:
				                            	UserManageAdd.setUserName(sheet.getRow(i).getCell(j).getStringCellValue());
				                            	break;
						                	}
				                		}
					                	if(j==3) {
					                		
				                			switch (sheet.getRow(i).getCell(j).getCellType()){
				                            case Cell.CELL_TYPE_BLANK:
				                            	break;
				                            case Cell.CELL_TYPE_NUMERIC:
				                            	String logintype=NumberToTextConverter.toText((long)sheet.getRow(i).getCell(j).getNumericCellValue());
				                            	UserManageAdd.setLoginType(logintype);
				                            	break;
				                            case Cell.CELL_TYPE_STRING:
				                            	UserManageAdd.setLoginType(sheet.getRow(i).getCell(j).getStringCellValue());
				                            	break;
						                	}
				                		}
					                	if(j==2) {
					                		
				                			switch (sheet.getRow(i).getCell(j).getCellType()){
				                            case Cell.CELL_TYPE_BLANK:
				                            	break;
				                            case Cell.CELL_TYPE_NUMERIC:
				                            	String empno=NumberToTextConverter.toText((long)sheet.getRow(i).getCell(j).getNumericCellValue());
				                            	UserManageAdd.setEmployee(empno);
				                            	break;
				                            case Cell.CELL_TYPE_STRING:
				                            	UserManageAdd.setEmployee(sheet.getRow(i).getCell(j).getStringCellValue());
				                            	break;
						                	}
				                		}
					                }
					                String Userid = (String) ses.getAttribute("Username");
					                List<Object[]> emplist= officerlist.stream().filter(e-> UserManageAdd.getEmployee().equalsIgnoreCase(e[1].toString())).collect(Collectors.toList());
				                	if(emplist !=null && emplist.size()>0) {
				                		UserManageAdd.setEmployee(emplist.get(0)[0].toString());
				                		UserManageAdd.setDivision(emplist.get(0)[8].toString());
				                	}else {
				                		redir.addFlashAttribute("Onboard","Yes");
				                		redir.addAttribute("resultfail", "Employee No Is Not Proper!");
				                		return "redirect:/UserManagerList.htm";
				                	}
					    			UserManageAdd.setRole("1"); 
					               count +=adminservice.UserManagerInsertFromExcel(UserManageAdd , Userid);    
					            }
								if (count > 0) {
									redir.addAttribute("result", "USER ADD SUCCESSFULLY");
								} else {
									redir.addAttribute("resultfail", "USER ADD UNSUCCESSFUL");
								}
								redir.addFlashAttribute("Onboard","Yes");
								return "redirect:/UserManagerList.htm";
							
						}catch(Exception e){
							e.printStackTrace();
							redir.addFlashAttribute("Onboard","Yes");
							redir.addAttribute("resultfail", "USER ADD UNSUCCESSFUL");
							return "redirect:/UserManagerList.htm";
						}
					}	
				} 
				}catch(Exception e){
					e.printStackTrace();
					redir.addFlashAttribute("Onboard","Yes");
					redir.addAttribute("resultfail", "USER ADD UNSUCCESSFUL");
					logger.error(new Date() +"Inside LoginExcelUpload.htm "+UserId,e);
				}
		 
			 return "redirect:/UserManagerList.htm";
	 }
	 
}

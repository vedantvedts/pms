<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="com.vts.pfms.committee.model.Committee"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.vts.pfms.print.model.TechImages"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="java.util.Base64"%>
<%@page import="org.apache.commons.io.FilenameUtils"%>
<%@page import="com.vts.pfms.model.LabMaster"%>
<%@page import="com.vts.pfms.AESCryptor"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.text.Format"%>
<%@page import="java.util.Locale"%>
<%@page import="com.vts.pfms.master.dto.ProjectFinancialDetails"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.util.List"%> 
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@page import="com.vts.pfms.model.TotalDemand" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>  

    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<title>Briefing Paper</title>


<%

Committee committee=(Committee)request.getAttribute("committeeData");
String isprint=(String)request.getAttribute("isprint"); 
List<Object[]> projectattributes = (List<Object[]> )request.getAttribute("projectattributes");
List<TotalDemand> totalprocurementdetails = (List<TotalDemand>)request.getAttribute("TotalProcurementDetails");
String lablogo=(String)request.getAttribute("lablogo");
LabMaster labInfo=(LabMaster)request.getAttribute("labInfo");
String committeeid=(String)request.getAttribute("committeeid");
String filePath=(String)request.getAttribute("filePath");
String projectLabCode=(String)request.getAttribute("projectLabCode");
List<List<Object[]>> ebandpmrccount = (List<List<Object[]>>)request.getAttribute("ebandpmrccount");
String No2=null;
if(committee.getCommitteeShortName().trim().equalsIgnoreCase("PMRC")){ 
No2="P"+(Long.parseLong(ebandpmrccount.get(0).get(0)[1].toString())+1);
}else if(committee.getCommitteeShortName().trim().equalsIgnoreCase("EB")){
	No2="E"+(Long.parseLong(ebandpmrccount.get(0).get(1)[1].toString())+1);
}

%>

<style type="text/css">


p{
  text-align: justify;
  text-justify: inter-word;
}

 th
 {
 	border: 1px solid black;
 	text-align: center;
 	padding: 5px;
	overflow-wrap: break-word;
 }
 
 td
 {
 	border: 1px solid black;
 	text-align: left;
 	padding: 5px;
 	overflow-wrap: break-word;
 }

th, td
{

	word-break :normal;
}

.break
	{
		page-break-after: always;
		margin: 25px 0px 25px 0px;
	} 
	 
 #pageborder {
      position:fixed;
      left: 0;
      right: 0;
      top: 0;
      bottom: 0;
      border: 2px solid black;
    }     
 
@page {             
          size: 1120px 790px; 
          margin-top: 49px;
          margin-left: 72px;
          margin-right: 39px;
          margin-buttom: 49px; 	
          border: 1px solid black; 
          padding-top: 15px;
          
          @bottom-left {          		
        
             content : "The information in this Document is proprietary of <%=labInfo.getLabCode() %> /DRDO , MOD Government of India. Unauthorized possession/use is violating the Government procedure which may be liable for prosecution. ";
             margin-bottom: 30px;
             margin-right: 5px;
             font-size: 10px;
          }
             
           @bottom-right {          		
             content: "Page " counter(page) " of " counter(pages);
             margin-bottom: 30px;
             margin-right: 10px;
          }
           @top-right {
             
             content: "<%= projectattributes.get(0)[12] %>";
             margin-top: 30px;
             margin-right: 50px;
          }
          
          <%-- @top-left {
          	margin-top: 30px;
            margin-left: 10px;
            content: url("data:image/*;base64,<%=lablogo%>");  
          }   --%>     
          
            @top-left {
	          content: "Project: <%= projectattributes.get(0)[0] %>"; 
			  margin-top: 30px;
              margin-left: 50px;
             
  			}   
  			
  			@top-center {
	         content: "<%if(committee.getCommitteeShortName().trim().equalsIgnoreCase("PMRC")){ %>
			PMRC #<%=Long.parseLong(ebandpmrccount.get(0).get(0)[1].toString())+1 %>
			<%}else if(committee.getCommitteeShortName().trim().equalsIgnoreCase("EB")){ %>
   			EB #<%=Long.parseLong(ebandpmrccount.get(0).get(1)[1].toString())+1 %>
   			<%} %>"; 
			
			margin-top: 30px;
             
  			} 
          
 }
 .border
 {
 	border: 1px solid black;
 }
 .textleft{
 	text-align: left;
 }
 div
 {
  	width: 1000px;
 }
 
 th
 {
 	border: 1px solid black;
 	text-align: center;
 	padding: 5px;
 }
 
 td
 {
 	border: 1px solid black;
 	text-align: left;
 	padding: 5px;
 }
 
  
 .textcenter{
 	
 	text-align: center;
 }

 .sth
 {
 	   
 	   border: 1px solid black;
 }
 
 .std
 {
 	text-align: center;
 	border: 1px solid black;
 }
 
 
  #containers {
    width: 100%;
    height: 100%;
    margin: 0;
    padding: 0;
}

.anychart-credits {
   display: none;
}

.flex-container 
{
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

img
{

<%if(isprint!=null && isprint.equals("1")){%>
	margin-left: -15px;
<%}%>
}
 
.pname
{
	margin: 10px 0px 10px 20px;
}
 
 .completed{
	color: green;
	font-weight: 700;
}

.briefactive{
	color: blue;
	font-weight: 700;
}

.inprogress{
	color: #F66B0E;
	font-weight: 700;
}

.assigned{
	color: brown;
	font-weight: 700;
}

.notyet{
	color: purple;
	font-weight: 700;
}
.notassign{
	color:#AB0072;
	font-weight: 700;
}
.ongoing{
	color: #F66B0E;
	font-weight: 700;
}

.completed{
	color: green;
	font-weight: 700;
}

.delay{
	color: maroon;
	font-weight: 700;
}

.completeddelay{
	color:#BABD42;
	font-weight: 700;
}

.inactive{
	color: red;
	font-weight: 700;
}
 
.firstpage th{
	border:none !important
}
 
.executive{
	align-items: center;
} 

.sub-title{
	font-size : 20px !important;
	color: #145374 !important
}

.subtables{
	width: 970px !important;
}

.date-column{
	max-width:60px !important;
}
 
.status-column{
	max-width:10px !important;
} 

.resp-column{
	max-width:80px !important;
} 
 
.currency{
	color:#367E18 !important;
	font-style: italic;
} 


.subtables th{
	/* background-color: #001253 !important; 
	color: white !important;
	border-color: white; */
	color: #001253 !important;
	
}
 
.mainsubtitle{
	font-size : 18px !important;
	color:#882042 !important;
}
 
 
.projectattributetable th{
	text-align: left !important;
} 
 
</style>



</head>

<%
DecimalFormat df=new DecimalFormat("####################.##");
FormatConverter fc=new FormatConverter(); 
SimpleDateFormat sdf=fc.getRegularDateFormat();
SimpleDateFormat sdf1=fc.getSqlDateFormat(); int addcount=0; 
NFormatConvertion nfc=new NFormatConvertion();
Format format = com.ibm.icu.text.NumberFormat.getCurrencyInstance(new Locale("en", "in"));

String projectid=(String)request.getAttribute("projectid");
List<Object[]> projectdatadetails = (List<Object[]> )request.getAttribute("projectdatadetails");
List<List<Object[]>> lastpmrcminsactlist = (List<List<Object[]>>)request.getAttribute("lastpmrcminsactlist");
List<List<Object[]>> lastpmrcactions = (List<List<Object[]>>)request.getAttribute("lastpmrcactions");

List<Object[]> TechWorkDataList=(List<Object[]>)request.getAttribute("TechWorkDataList");
List<List<Object[]>> milestones= (List<List<Object[]>>)request.getAttribute("milestones");
List<List<Object[]>> milestonesubsystems = (List<List<Object[]>>)request.getAttribute("milestonesubsystems");
List<List<ProjectFinancialDetails>> projectFinancialDetails =(List<List<ProjectFinancialDetails>>)request.getAttribute("financialDetails");
List<List<Object[]>> ganttchartlist=(List<List<Object[]>>)request.getAttribute("ganttchartlist"); 
List<List<Object[]>> oldpmrcissueslist=(List<List<Object[]>>)request.getAttribute("oldpmrcissueslist");
List<List<Object[]>> riskmatirxdata = (List<List<Object[]>> )request.getAttribute("riskmatirxdata");
List<List<Object[]>> procurementOnDemand = (List<List<Object[]>>)request.getAttribute("procurementOnDemandlist");
List<List<Object[]>> procurementOnSanction = (List<List<Object[]>>)request.getAttribute("procurementOnSanctionlist");
List<List<Object[]>> actionplanthreemonths = (List<List<Object[]>>)request.getAttribute("actionplanthreemonths");
List<Object[]> lastpmrcdecisions = (List<Object[]> )request.getAttribute("lastpmrcdecisions");
List<Object[]> ProjectDetail=(List<Object[]>)request.getAttribute("ProjectDetails");
List<String> projectidlist = (List<String>)request.getAttribute("projectidlist");
List<List<Object[]>> ProjectRevList = (List<List<Object[]>>)request.getAttribute("ProjectRevList");


List<List<Object[]>> ReviewMeetingList=(List<List<Object[]>>)request.getAttribute("ReviewMeetingList");
List<List<Object[]>> ReviewMeetingListPMRC=(List<List<Object[]>>)request.getAttribute("ReviewMeetingListPMRC");

AESCryptor cryptor = new AESCryptor();
long ProjectCost = (long)request.getAttribute("ProjectCost");

List<List<TechImages>> TechImages = (List<List<TechImages>>)request.getAttribute("TechImages");

List<Object[]> MilestoneList=(List<Object[]>)request.getAttribute("MilestoneActivityList");
String levelid= (String) request.getAttribute("levelid");
List<List<Object[]>> MilestoneDetails6 = (List<List<Object[]>>)request.getAttribute("milestonedatalevel6");

String AppFilesPath= (String) request.getAttribute("AppFilesPath");
%>


<body>

	<div class="firstpage" id="firstpage"> 

		<div align="center" ><h1 style="color: #145374 !important;font-family: 'Muli'!important">Briefing Paper </h1></div>
		
		<div align="center" ><h2 style="color: #145374 !important">for</h2></div>
		
		<%if ( committeeid != null){ %>
			
			<div align="center" ><h2 style="color: #145374 !important" >
			<%if(committee.getCommitteeShortName().trim().equalsIgnoreCase("PMRC")){ %>
				PMRC #<%=Long.parseLong(ebandpmrccount.get(0).get(0)[1].toString())+1 %>
			<%}else if(committee.getCommitteeShortName().trim().equalsIgnoreCase("EB")){ %>
   				EB #<%=Long.parseLong(ebandpmrccount.get(0).get(1)[1].toString())+1 %>
   			<%} %> Meeting </h2></div>
		
			<div align="center" ><h2 style="color: #145374 !important"><%= projectattributes.get(0)[1] %> (<%= projectattributes.get(0)[0] %>)</h2></div>
		
		<%} %>	
		
		<table class="executive" style="align: center;margin-bottom:5px; margin-left: auto;margin-right:auto; max-width: 650px; font-size: 16px;"  >
		<%
		if(labInfo!=null){
		 %>
			<tr>			
				<th colspan="8" style="text-align: center; font-weight: 700;">
				<img class="logo" style="width:120px;height: 120px;margin-bottom: 5px"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> > 
				<br><br>
				</th>
				
			</tr>
			<tr>
				<th colspan="8" style="text-align: center; font-weight: 700;font-size: 22px"><br><br><%if(labInfo.getLabName()!=null){ %><%=labInfo.getLabName()  %><%}else{ %>LAB NAME<%} %></th>
			</tr>
			
			<% } %>
		
		
		<tr>
			<th colspan="8" style="text-align: center; font-weight: 700;font-size:15px"><br>Government of India, Ministry of Defence</th>
		</tr>
		<tr>
			<th colspan="8" style="text-align: center; font-weight: 700;font-size:15px">Defence Research & Development Organization</th>
		</tr>
		<tr>
			<th colspan="8" style="text-align: center; font-weight: 700;font-size:15px"><%if(labInfo.getLabAddress() !=null){ %><%=labInfo.getLabAddress()  %> , <%=labInfo.getLabCity() %><%}else{ %>LAB ADDRESS<%} %> <br><br><br></th>
		</tr>
		</table>			
		
		<br><br>
	</div>
<h1 class="break"></h1>
<%for(int z=0 ; z<projectidlist.size();z++){  %>
	<%if(z>0){ %><h1 class="break"></h1> <%} %>
	
	<div  id="detailContainer" align="center" >
	
<!-- ------------------------------------heading commented------------------------------------------------- -->	
	
<!-- ------------------------------------project attributes------------------------------------------------- -->
			<div style="margin-left: 10px;" align="left"><b class="sub-title">1. Project Attributes: </b></div>
			<%if(projectattributes.get(z)!=null){ %>
			
			<table class="subtables projectattributetable" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;   border-collapse:collapse;" >
										<tr>
											 <td style="width: 5px !important; padding: 5px; padding-left: 10px">(a)</td>
											 <th  style="width: 150px;padding: 5px; padding-left: 10px"><b>Project Title</b></th>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px"> <%=projectattributes.get(z)[1] %></td>
										</tr>
										<tr>
											 <td  style="padding: 5px; padding-left: 10px">(b)</td>
											 <th style="width: 150px;padding: 5px; padding-left: 10px"><b>Project No</b></th>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px"> <%=projectattributes.get(z)[0]%> </td>
										</tr>
										<tr>
											 <td  style=" padding: 5px; padding-left: 10px">(c)</td>
											 <th  style="width: 150px;padding: 5px; padding-left: 10px"><b>Category</b></th>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px"><%=projectattributes.get(z)[14]%></td>
										</tr>
										<tr>
											 <td  style="padding: 5px; padding-left: 10px">(d)</td>
											 <th  style="width: 150px;padding: 5px; padding-left: 10px"><b>Date of Sanction</b></th>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px"><%=sdf.format(sdf1.parse(projectattributes.get(z)[3].toString()))%></td>
										</tr>
										<tr>
											 <td  style="width: 20px; padding: 5px; padding-left: 10px">(e)</td>
											 <th  style="width: 150px;padding: 5px; padding-left: 10px"><b>Nodal and Participating Labs</b></th>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px"><%if(projectattributes.get(z)[15]!=null){ %><%=projectattributes.get(z)[15]%><%} %></td>
										</tr>
										<tr>
											 <td  style=" padding: 5px; padding-left: 10px">(f)</td>
											 <th  style="width: 150px;padding: 5px; padding-left: 10px"><b>Objective</b></th>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px;text-align: justify"> <%=projectattributes.get(z)[4]%></td>
										</tr>
										<tr>
											 <td  style="padding: 5px; padding-left: 10px">(g)</td>
											 <th  style="width: 150px;padding: 5px; padding-left: 10px"><b>Deliverables</b></th>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px"> <%=projectattributes.get(z)[5]%></td>
										</tr>
										<tr>
											 <td rowspan="2" style="padding: 5px; padding-left: 10px">(h)</td>
											 <th rowspan="2" style="width: 150px;padding: 5px; padding-left: 10px"><b>PDC</b></th>
											 
											<th colspan="2" style="text-align: center !important">Original</th>					
											<%if( ProjectRevList.get(z).size()>0){ %>	
												<th colspan="2" style="text-align: center !important">Revised</th>																			
											<%}else{ %>													 
										 		<th colspan="2" ></th>	
										 	<%} %>
										</tr>
								 		<tr>
								 			<%if( ProjectRevList.get(z).size()>0 ){ %>								
										 		<td colspan="2" style="text-align: center;"><%= sdf.format(sdf1.parse(ProjectRevList.get(z).get(0)[12].toString()))%> </td>
										 		<td colspan="2" style="text-align: center;">
											 		<%if(LocalDate.parse(projectattributes.get(z)[6].toString()).isEqual(LocalDate.parse(ProjectRevList.get(z).get(0)[12].toString())) ){ %>
											 			-
											 		<%}else{ %>
											 			<%= sdf.format(sdf1.parse(projectattributes.get(z)[6].toString()))%>
											 		<%} %>
										 		
										 		</td>
											<%}else{ %>													 
										 		<td colspan="2" style="text-align: center;"><%= sdf.format(sdf1.parse(projectattributes.get(z)[6].toString()))%></td>
												<td colspan="2" >-</td>
										 	<%} %>
										 		    
								 		</tr>
											 	
										<tr>
											<td rowspan="3" style="width: 30px; padding: 5px; padding-left: 10px">(i)</td>
											<th rowspan="3" style="padding-left: 10px"><b>Cost Breakup( &#8377; <span class="currency">Lakhs</span>)</b></th>
											
											<%if( ProjectRevList.get(z).size()>0 ){ %>
													<td style="width: 10% !important" >RE Cost</td>
													<td style="text-align: center;"><%=ProjectRevList.get(z).get(0)[17] %></td> 
													<td colspan="2" style="text-align: center;"><%=projectattributes.get(z)[8] %></td>
												</tr>
												
												
												<tr>
													<td style="width: 10% !important">FE Cost</td>		
													<td style="text-align: center;"><%=ProjectRevList.get(z).get(0)[16] %></td>					
													<td colspan="2" style="text-align: center;"><%=projectattributes.get(z)[9] %></td>
												</tr>
													
												<tr>	
													<td style="width: 10% !important">Total Cost</td>	
													<td style="text-align: center;"><%=ProjectRevList.get(z).get(0)[11] %></td>
											 		<td colspan="2" style="text-align: center;"><%=projectattributes.get(z)[7] %></td>
												</tr> 
														
											<%}else{ %>
													
													<td style="width: 10% !important">RE Cost</td>
													<td ><%=projectattributes.get(z)[8] %></td>
													<td colspan="2" ></td>
												</tr>
											
												<tr>
													<td style="width: 10% !important">FE Cost</td>		
													<td ><%=projectattributes.get(z)[9] %></td>					
													<td colspan="2"></td>
												</tr>
												
												<tr>	
													<td style="width: 10% !important" >Total Cost</td>	
													<td ><%=projectattributes.get(z)[7] %></td>
													<td colspan="2"></td>			
												</tr> 
											<%} %>
												
																			 	
										<tr>
											<td  style="width: 20px; padding: 5px; padding-left: 10px">(j)</td>
											<th style="width: 150px;padding: 5px; padding-left: 10px"><b>No. of EBs and PMRCs held</b> </th>
								 			<td colspan="2" ><b>EB :</b> <%=ebandpmrccount.get(z).get(1)[1] %></td>
								 			<td colspan="2"><b>PMRC :</b> <%=ebandpmrccount.get(z).get(0)[1] %></td>
								 			
										</tr>
										<tr>
											<td  style="width: 20px; padding: 5px; padding-left: 10px">(k)</td>
											<th  style="width: 210px;padding: 5px; padding-left: 10px"><b>Current Stage of Project</b></th>
											<td colspan="4" style=" width: 200px;color:white; padding: 5px; padding-left: 10px ; <%if(projectdatadetails.get(z)!=null){ %> background-color: <%=projectdatadetails.get(z)[11] %> ;   <%} %>" >
													 <span> <%if(projectdatadetails.get(z)!=null){ %><b><%=projectdatadetails.get(z)[10] %> </b>  <%}else{ %>Data Not Found<%} %></span>
											</td> 
										</tr>	
			</table>
		
			<% }else{ %>
				<div align="center"  style="margin: 25px;" > Complete Project Data Not Found </div>
			<%} %>
		</div>
<!-- ------------------------------------project attributes------------------------------------------------- -->
		<h1 class="break"></h1>
<!-- ------------------------------------system configuration and Specification------------------------------------------------- -->	
		<div style="margin-left: 10px;" align="left" class="sub-title"><b>2. Schematic Configuration</b></div><br>
		<div align="left" style="margin-top: 5px;margin-left: 10px;"><b class="mainsubtitle">2 (a) System Configuration : </b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<div align="center">
			<%if(projectdatadetails.get(z)!=null && projectdatadetails.get(z)[3]!=null){ %>
				
				<%if(new File(AppFilesPath+projectdatadetails.get(z)[2]+"\\"+projectdatadetails.get(z)[3]).exists()){ %>
				
					<%if(!FilenameUtils.getExtension(projectdatadetails.get(z)[3].toString()).equalsIgnoreCase("pdf") ){ %>
						
						<br>
						<img class="logo" style="max-width:25.5cm;max-height:20cm;"  src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(AppFilesPath+projectdatadetails.get(z)[2]+"\\"+projectdatadetails.get(z)[3])))%>" alt="confi" >
						
					<% }else{ %>
						<b>  System Configuration Annexure </b>
					<% }%>
				
				<%}else{ %>
					<br>
					File Missing in File System
				<%} %>
			
			
			<%}else{ %>
				<b> File Not Found</b>
			<%} %>
		</div> 
	</div>
	<h1 class="break"></h1>
		
	
		<div align="left" style="margin-left: 15px;margin-top: 5px;"><b class="mainsubtitle">2 (b) System Specification : </b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	
		<%if(projectdatadetails.get(z)!=null && projectdatadetails.get(z)[4]!=null){ %>
				
				<%if(new File(AppFilesPath+projectdatadetails.get(z)[2]+"\\"+projectdatadetails.get(z)[4]).exists()){ %>
				
					<%if(!FilenameUtils.getExtension(projectdatadetails.get(z)[4].toString()).equalsIgnoreCase("pdf") ){ %>
						<div align="center"><br>
							<img class="logo" style="max-width:25cm;max-height:17cm;"  src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(AppFilesPath+projectdatadetails.get(z)[2]+"\\"+projectdatadetails.get(z)[4])))%>" alt="Speci" >
						</div> 
					<% }else{ %>
						<b> System Specification Annexure </b>
					<% }%>
				
				<%}else{ %>
					<div align="center">
					<br>
					File Missing in File System
					</div>
				<%} %>
			
			
			<%}else{ %>
				<div align="center">
				<br>
				<b> File Not Found</b>
				</div>
			<%} %>
				
		
		
	</div>	
	<h1 class="break"></h1>
<!-- --------------------------------------------- ----------------------------------------------- -->
		<div align="left" style="margin-left: 10px;margin-top: 5px;"><b class="mainsubtitle">3. Overall Product tree/WBS:</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

				<%if(projectdatadetails.get(z)!=null && projectdatadetails.get(z)[5]!=null){ %>
				
				<%if(new File(AppFilesPath+projectdatadetails.get(z)[2]+"\\"+projectdatadetails.get(z)[5]).exists()){ %>
				
					<%if(!FilenameUtils.getExtension(projectdatadetails.get(z)[5].toString()).equalsIgnoreCase("pdf") ){ %>
						<div align="center"><br>
							<img class="logo" style="max-width:25cm;max-height:17cm;margin-bottom: 5px"  src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(AppFilesPath+projectdatadetails.get(z)[2]+"\\"+projectdatadetails.get(z)[5])))%>" alt="Speci" >
						</div> 
					<% }else{ %>
						<b> Overall Product tree/WBS Annexure </b>
					<% }%>
				
				<%}else{ %>
					<div align="center">
					<br>
					File Missing in File System
					</div>
				<%} %>
			
			
			<%}else{ %>
			<div align="center">
			<br>
				<b> File Not Found</b>
			</div>
			<%} %>
			
		</div>	
		
<!-- ------------------------------------system configuration and Specification------------------------------------------------- -->
	
		<h1 class="break"></h1> 
<!-- ----------------------------------------------4.Details of work------------------------------------------------- -->			

		<div align="left" style="margin-left: 10px;"><b class="sub-title">4. Particulars of Meeting</b></div><br>
		<div align="left" style="margin-left: 15px;"><b class="mainsubtitle">(a) <%if(committee.getCommitteeShortName().trim().equalsIgnoreCase("PMRC")){ %>
															   						Approval 
															   						<%}else { %>
															   						Ratification
															   						<%} %>  of <b>recommendations</b> of last <%=committee.getCommitteeShortName().trim().toUpperCase() %> Meeting (if any)</b></div>
		
		
			<table class="subtables" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px; border-collapse:collapse;" >
				<thead>
					<tr>
						<td colspan="6" style="border: 0">
							<p style="font-size: 10px;text-align: center"> 
								 <span class="notassign">NA</span> : Not Assigned &nbsp;&nbsp;
								 <span class="assigned">AA</span> : Activity Assigned &nbsp;&nbsp; 
								 <span class="notyet">NS</span> : Not yet Started &nbsp;&nbsp;
								 <span class="ongoing">OG</span> : On Going &nbsp;&nbsp; 
								 <span class="delay">DO</span> : Delay - On Going &nbsp;&nbsp; 
								 <span class="ongoing">RC</span> : Review & Close &nbsp;&nbsp;
								 <span class="delay">FD</span> : Forwarded With Delay &nbsp;&nbsp;
								 <span class="completed">CO</span> : Completed &nbsp;&nbsp; 
								 <span class="completeddelay">CD</span> : Completed with Delay &nbsp;&nbsp; 
								 <span class="inactive">IA</span> : InActive &nbsp;&nbsp;
								 <!-- <span class="ongoing">UF</span> : User Forwarded &nbsp;&nbsp; --> 
							 </p>
						</td>									
					</tr>
										
					<tr>
						<th  style="width: 15px !important;text-align: center;">SN</th>
						<th  style="width: 335px !important;">Recommendation Point</th>
						<th  style="width: 80px !important;"> PDC</th>
						<th  style="width: 210px !important;"> Responsibility</th>
						<th  style="width: 80px !important;">Status(Days)</th>
						<th  style="width: 250px !important; ">Remarks</th>
					</tr>
				</thead>
				<tbody>
					<%if(lastpmrcminsactlist.get(z).size()==0){ %>
						<tr><td colspan="6" style="text-align: center;" > Nil</td></tr>
					<%}
						else if(lastpmrcminsactlist.get(z).size()>0)
							{int i=1;
								for(Object[] obj:lastpmrcminsactlist.get(z)){
									if(obj[3].toString().equalsIgnoreCase("R")){%>
						<tr>
							<td  style="text-align: center;"><%=i %></td>
							<td  style="text-align: justify; "><%=obj[2] %></td>
							<td   style=" text-align: center;">
							<%if(obj[4]!= null){ %><%=sdf.format(sdf1.parse(obj[6+Integer.parseInt(obj[9].toString())].toString()	) )%><%}else{ %> <%} %>
						</td>
						<td>
							<%if(obj[4]!= null){ %>  
								<%=obj[12] %><%-- , <%=obj[13] %> --%>
							<%}else { %> <!-- <span class="notassign">NA</span>  --> <span class="">Not Assigned</span> <%} %> 
						</td>
						<td  style="text-align: center; ">
							<%if(obj[4]!= null){
									
								if(obj[18]!=null){ %>
									<%if(obj[10].toString().equals("I")&&obj[16].toString().equals("F")&&(LocalDate.parse(obj[17].toString()).isAfter(LocalDate.parse(obj[14].toString())) || LocalDate.parse(obj[17].toString()) .equals(LocalDate.parse(obj[14].toString())) )){ %>
										<span class="ongoing">RC</span>
								<%}else if(obj[10].toString().equals("I")&&obj[16].toString().equals("F")&&LocalDate.parse(obj[17].toString()).isBefore(LocalDate.parse(obj[14].toString()))){  %>
										<span class="delay">FD</span>
								<%}else if(obj[10].toString().equals("C")&&(LocalDate.parse(obj[17].toString()).isAfter(LocalDate.parse(obj[14].toString()))||obj[17].equals(obj[14]))){  %>
										<span class="completed">CO</span>
								<%}else if(obj[10].toString().equals("C") && LocalDate.parse(obj[17].toString()).isBefore(LocalDate.parse(obj[14].toString()))){  %>
									   <span class="completeddelay">CD 
									    (<%=  ChronoUnit.DAYS.between(LocalDate.parse(obj[17].toString()), LocalDate.parse(obj[14].toString()))   %>)  </span>
															   
								<%}else if(!obj[16].toString().equals("F") && !obj[10].toString().equals("C") &&(LocalDate.parse(obj[17].toString()).isAfter(LocalDate.now())||LocalDate.parse(obj[17].toString()).equals(LocalDate.now()))){  %> 
										<span class="ongoing">OG</span>
								<%}else if(!obj[16].toString().equals("F")&& !obj[10].toString().equals("C") && LocalDate.parse(obj[17].toString()).isBefore(LocalDate.now())){  %> 
										<span class="delay">DO
											 (<%= ChronoUnit.DAYS.between(LocalDate.parse(obj[17].toString()), LocalDate.now())  %>)   
										</span>
								<%} }else if(obj[10].toString().equals("C")){%>
								        <span class="completed">CO</span>
							    <% }else{ %>
							    		<span class="notyet">NS</span> 
								<%}}else { %> <span class="notassign">NA</span> <%} %> 
						</td>
						<td ><%if(obj[19]!=null){%><%=obj[19] %><%} %></td>
					</tr>		
					<%i++;}
						}%>
					<%if(i==1){ %> <tr><td colspan="6" style="text-align: center;" > Nil</td></tr>	<%} %>
											
					<%} %>
				</tbody>
										
			</table>
									
			<%if((Double.parseDouble(projectattributes.get(0)[7].toString())*100000)>1){ %>		
				<h1 class="break"></h1>
				 	<div align="left" style="margin-left: 15px;"><b class="mainsubtitle">(b) Last <%=committee.getCommitteeShortName().trim().toUpperCase() %>
														   						Meeting action points with Probable Date of completion (PDC), Actual Date of Completion (ADC) and current status.</b>
					</div>
   							
					<table class="subtables" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;   border-collapse:collapse;" >
						<thead>
							<tr>
								<td colspan="7" style="border: 0">
									<p style="font-size: 10px;text-align: center"> 
										 <span class="notassign">NA</span> : Not Assigned &nbsp;&nbsp;
										 <span class="assigned">AA</span> : Activity Assigned &nbsp;&nbsp; 
										 <span class="notyet">NS</span> : Not yet Started &nbsp;&nbsp;
										 <span class="ongoing">OG</span> : On Going &nbsp;&nbsp; 
										 <span class="delay">DO</span> : Delay - On Going &nbsp;&nbsp; 
										 <span class="ongoing">RC</span> : Review & Close &nbsp;&nbsp;
										 <span class="delay">FD</span> : Forwarded With Delay &nbsp;&nbsp;
										 <span class="completed">CO</span> : Completed &nbsp;&nbsp; 
										 <span class="completeddelay">CD</span> : Completed with Delay &nbsp;&nbsp; 
										 <span class="inactive">IA</span> : InActive &nbsp;&nbsp;
										 <!-- <span class="ongoing">UF</span> : User Forwarded &nbsp;&nbsp; --> 
									 </p>
								</td>									
							</tr>
										
							<tr>
								<th  style="width: 15px !important;text-align: center;  ">SN</th>
								<th  style="width: 300px; ">Action Point</th>
								<th  style="width: 80px; ">PDC</th>
								<th  style="width: 80px; "> ADC</th>
								<th  style="width: 210px; "> Responsibility</th>
								<th  style="width: 80px; ">Status(Days)</th>
								<th  style="width: 205px; ">Remarks</th>			
							</tr>
						</thead>
							
						<tbody>		
							<%if(lastpmrcactions.get(z).size()==0){ %>
								<tr><td colspan="7"  style="text-align: center;" > Nil</td></tr>
								<%}
								else if(lastpmrcactions.size()>0)
								{int i=1;
								for(Object[] obj:lastpmrcactions.get(z) ){ %>
								<tr>
												<td  style="text-align: center;"><%=i %></td>
												<td  style="text-align: justify ;"><%=obj[2] %></td>
												<td  style="text-align: center;" ><%= sdf.format(sdf1.parse(obj[3].toString()))%></td>
												<td   style="text-align: center;"> 
													<%if(obj[9].toString().equals("C")  && obj[13]!=null){ %>

														<%if(obj[15]!=null){ %>
													
													
															<%if(obj[9].toString().equals("I") && obj[14].toString().equals("F") && (LocalDate.parse(obj[4].toString()).isAfter(LocalDate.parse(obj[13].toString())) || LocalDate.parse(obj[4].toString()).isEqual(LocalDate.parse(obj[13].toString())) )){ %>
																<span class="ongoing"><%= sdf.format(sdf1.parse(obj[13].toString()))%> </span>
															<%}else if(obj[9].toString().equals("I") && obj[14].toString().equals("F") && LocalDate.parse(obj[4].toString()).isBefore(LocalDate.parse(obj[13].toString()))){  %>
																<span class="delay"><%= sdf.format(sdf1.parse(obj[13].toString()))%> </span>
															<%}else if(obj[9].toString().equals("C")&&(LocalDate.parse(obj[4].toString()).isAfter(LocalDate.parse(obj[13].toString()))||obj[4].equals(obj[13]))){  %>
																<span class="completed"><%= sdf.format(sdf1.parse(obj[13].toString()))%> </span>
															<%}else if(obj[9].toString().equals("C")&&LocalDate.parse(obj[4].toString()).isBefore(LocalDate.parse(obj[13].toString()))){  %>
															   <span class="completeddelay"><%= sdf.format(sdf1.parse(obj[13].toString()))%> </span>
															<%}else if( !obj[9].toString().equals("C") && !obj[14].toString().equals("F") &&(LocalDate.parse(obj[4].toString()).isAfter(LocalDate.now())|| LocalDate.parse(obj[4].toString()).isEqual(LocalDate.now()) )){  %> 
															<span class="ongoing"><%= sdf.format(sdf1.parse(obj[13].toString()))%> </span>
															<%}else if(!obj[9].toString().equals("C") && !obj[14].toString().equals("F") &&  LocalDate.parse(obj[4].toString()).isBefore(LocalDate.now())){  %> 
															<span class="delay"><%= sdf.format(sdf1.parse(obj[13].toString()))%> </span>
															<%}%>
														
														
														<%}else if(obj[9].toString().equals("C")){ %>
												        <span class="completed"><%= sdf.format(sdf1.parse(obj[13].toString()))%> </span>
												    <% }else{ %>
												      	<span class="notyet"><%= sdf.format(sdf1.parse(obj[13].toString()))%> </span> 
												<%} %> 
											
												<%}else{ %> - <%} %>
											</td>
												
												
												<td  > <%=obj[11] %><%-- , <%=obj[12] %> --%> </td>
												<td  style="text-align: center;"> 
													<%if(obj[15]!=null){ %>
													
														<%if(obj[9].toString().equals("I") && obj[14].toString().equals("F") && (LocalDate.parse(obj[4].toString()).isAfter(LocalDate.parse(obj[13].toString())) || LocalDate.parse(obj[4].toString()).isEqual(LocalDate.parse(obj[13].toString())) )){ %>
															<span class="ongoing">RC</span>
														<%}else if(obj[9].toString().equals("I") && obj[14].toString().equals("F") && LocalDate.parse(obj[4].toString()).isBefore(LocalDate.parse(obj[13].toString()))){  %>
															<span class="delay">FD</span>
														<%}else if(obj[9].toString().equals("C") && (LocalDate.parse(obj[4].toString()).isAfter(LocalDate.parse(obj[13].toString()))||obj[4].equals(obj[13]))){  %>
															<span class="completed">CO</span>
														<%}else if(obj[9].toString().equals("C") && LocalDate.parse(obj[4].toString()).isBefore(LocalDate.parse(obj[13].toString()))){  %>
														   	<span class="completeddelay">CD (<%= ChronoUnit.DAYS.between(LocalDate.parse(obj[4].toString()), LocalDate.parse(obj[13].toString())) %>) </span>
														<%}else if( !obj[9].toString().equals("C") && !obj[14].toString().equals("F") &&(LocalDate.parse(obj[4].toString()).isAfter(LocalDate.now())|| LocalDate.parse(obj[4].toString()).isEqual(LocalDate.now()) )){  %> 
															<span class="ongoing">OG</span>
														<%}else if(!obj[9].toString().equals("C") && !obj[14].toString().equals("F") &&  LocalDate.parse(obj[4].toString()).isBefore(LocalDate.now())){  %> 
															<span class="delay">DO (<%= ChronoUnit.DAYS.between(LocalDate.parse(obj[4].toString()), LocalDate.now())  %>)  </span>
														<%}%>
													
													<% }else if(obj[9].toString().equals("C")){ %>
												        <span class="completed">CO</span>
												    <% }else{ %>
												      	<span class="notyet">NS</span> 
													<%} %> 
												</td>	
												<td  style="text-align: justify ;"><%if(obj[16]!=null){%><%=obj[16] %><%} %></td>			
											</tr>			
										<%i++;
										}} %>
										</tbody>
										
									</table> 
								
								<%} %>
								<h1 class="break"></h1>
						<div align="left" style="margin-left: 15px;"><b class="mainsubtitle">(c) Details of Technical/ User Reviews (if any).</b></div>
						
						<div align="center">
							
							<div align="center" style="max-width:400px;float:left;">
							<table class="subtables" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;max-width:350px;  border-collapse:collapse;float:left;" >
								<thead>
									<tr>
										 <th  style="max-width: 70px; ">Committee</th>
										 <!-- <th  style="max-width: 200px; "> MeetingId</th> -->
										 <th  style="max-width: 80px; "> Date Held</th>
									</tr>
								</thead>
								<tbody>
									<%if(ReviewMeetingList.get(z).size()==0){ %>
									<tr><td colspan="6" style="text-align: center;" > Nil</td></tr>
									<% }
									else if(ReviewMeetingList.size()>0)
									{ 
										int i=1;
									
									for(Object[] obj:ReviewMeetingList.get(z)){ %>
										<tr>
											<td  style="max-width: 70px;font-size:12px !important; "><%=obj[1] %> #<%=i %></td>												
											<%-- <td  style="max-width: 200px;font-size:12px !important;" ><%= obj[4]%></td> --%>
											<td  style="max-width: 80px;text-align: center;font-size:12px !important; " ><%= sdf.format(sdf1.parse(obj[3].toString()))%></td>
										</tr>			
									<%i++;
									}}else{ %>
									<tr><td colspan="4" style="text-align: center;" > Nil</td></tr>
									<%} %> 
								</tbody>
							</table>
							</div>
							<div align="center" style="max-width:400px;float:right;">
								<table class="subtables" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;max-width:350px;  border-collapse:collapse; " >
									<thead>
										<tr>
											 <th  style="max-width: 70px; ">Committee</th>
											 <!-- <th  style="max-width: 200px; "> MeetingId</th> -->
											 <th  style="max-width: 80px; "> Date Held</th>
										</tr>
									</thead>
									<tbody>
										<%if(ReviewMeetingListPMRC.get(z).size()==0){ %>
										<tr><td colspan="6" style="text-align: center;" > Nil</td></tr>
										<%}
										else if(ReviewMeetingListPMRC.size()>0)
										  {int i=1;
										for(Object[] obj:ReviewMeetingListPMRC.get(z)){ %>
											<tr>
												<td  style="max-width: 70px;font-size:12px !important;"><%=obj[1] %> #<%=i %></td>												
												<%-- <td  style="max-width: 200px;font-size:12px !important;" ><%= obj[4]%></td> --%>
												<td  style="max-width: 80px;text-align: center;font-size:12px !important; " ><%= sdf.format(sdf1.parse(obj[3].toString()))%></td>
											</tr>			
										<%i++;
										}
										  
										  }else{ %>
											<tr><td colspan="4" style="text-align: center;" > Nil</td></tr>
										
									<%} %> 
								</tbody>
							</table>
						</div>
							
						</div>
			
			 <h1 class="break"></h1>
<!-- -------------------------------------------------------------------------------------------- -->
		<div align="left" style="margin-left: 10px;"><b class="sub-title">5. Milestones achieved prior to this  
						<%=committee.getCommitteeShortName().trim().toUpperCase() %>
   						Meeting
   						  period.  </b></div>
   						
			
			<table class="subtables" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;  border-collapse:collapse;" >
				
				<thead>
					<tr>
						<td colspan="8" style="border: 0">
							<p style="font-size: 10px;text-align: center"> 
								<span class="notassign">NA</span> : Not Assigned &nbsp;&nbsp;
								<span class="assigned">AA</span> : Activity Assigned &nbsp;&nbsp; 
								<span class="notyet">NS</span> : Not yet Started &nbsp;&nbsp;
								<span class="ongoing">OG</span> : On Going &nbsp;&nbsp; 
								<span class="delay">DO</span> : Delay - On Going &nbsp;&nbsp; 
								<span class="ongoing">RC</span> : Review & Close &nbsp;&nbsp;
								<span class="delay">FD</span> : Forwarded With Delay &nbsp;&nbsp;
								<span class="completed">CO</span> : Completed &nbsp;&nbsp; 
								<span class="completeddelay">CD</span> : Completed with Delay &nbsp;&nbsp; 
								<span class="inactive">IA</span> : InActive &nbsp;&nbsp;
								<!-- <span class="ongoing">UF</span> : User Forwarded &nbsp;&nbsp; --> 
							 </p>
		   				</td>									
					</tr>
				
					<tr>
						<th  style="width: 15px !important;text-align: center; ">SN</th> 
						<th  style="width: 20px; ">MS</th>
						<th  style="width: 375px; ">Milestones </th>
						<th  style="width: 100px; "> Original PDC </th>
						<th  style="width: 100px; "> Revised PDC</th>
						<th  style="width: 50px; ">Progress</th>
						<th  style="width: 80px; "> Status<!-- (Days) --></th>
						<th  style="width: 240px; "> Remarks</th>
					</tr>
				</thead>
										
				<tbody>
					<%if(milestones.get(z).size()==0){ %>
						<tr><td colspan="8" style="text-align: center;" > Nil</td></tr>
							<%}else if(milestones.get(z).size()>0)
							  {	
								int i=1;
								for(Object[] obj:milestones.get(z)){ 
									/* if(obj[10].toString().equalsIgnoreCase("3") ||obj[10].toString().equalsIgnoreCase("3") || obj[10].toString().equalsIgnoreCase("5")) */
									if(Integer.parseInt(obj[12].toString())>0)
									{ %>
										<tr>
											<td  style="text-align: center; "><%=i%></td> 
											<td  style="text-align: center;">M<%=obj[2]%></td>
											<td  style="text-align: justify"><%=obj[3] %></td>
											<td  style="text-align: center;" ><%= sdf.format(sdf1.parse(obj[5].toString()))%> </td>
											<td  style="text-align: center;">
												<%if(LocalDate.parse(obj[5].toString()).isEqual(LocalDate.parse(obj[7].toString())) ){ %>
											 		-
											 	<%}else{ %>
											 		<%= sdf.format(sdf1.parse(obj[7].toString()))%>
											 	<%} %>
											<%-- <%= sdf.format(sdf1.parse(obj[7].toString()))%> --%>
											</td>
											<td  style="text-align: center;"><%=obj[12] %>%	</td>
											<td   style="text-align: center;">
												<span class="<%if(obj[10].toString().equalsIgnoreCase("0")){%>assigned
														<%}else if(obj[10].toString().equalsIgnoreCase("1")) {%> notyet
														<%}else if(obj[10].toString().equalsIgnoreCase("2")) {%> ongoing
														<%}else if(obj[10].toString().equalsIgnoreCase("3")) {%> completed
														<%}else if(obj[10].toString().equalsIgnoreCase("4")) {%> delay 
														<%}else if(obj[10].toString().equalsIgnoreCase("5")) {%> completeddelay
														<%}else if(obj[10].toString().equalsIgnoreCase("6")) {%> inactive<%} %>	 " >
													<%=obj[11] %>	
												
													<%-- <%if(obj[10].toString().equalsIgnoreCase("5")) { %>
													(<%= ChronoUnit.DAYS.between(LocalDate.parse(obj[7].toString()), LocalDate.parse(obj[7].toString())) %>)
													<%} else if(obj[10].toString().equalsIgnoreCase("4")) { %>
													(<%= ChronoUnit.DAYS.between(LocalDate.parse(obj[7].toString()), LocalDate.now())  %>)
													<%} %> --%>
												
												</span>
											</td>
											<td  ><%if(obj[13]!=null){%><%=obj[13] %><%} %></td>
										</tr>			
									<% i++;
											}	
										}%>
										
									
										<%if(i==1){ %> <tr><td colspan="8" style="text-align: center;" >Nil</td></tr>	<% } %>	
										
								<%} %>
								</tbody>
								
							</table>
			
						 <h1 class="break"></h1>
<!-- ------------------------------------------------------------------------------------------------------------ -->

		<div align="left" style="margin-left: 10px;"><b class="sub-title">6. Details of work and current status of sub system with major milestones ( since last <%= committee.getCommitteeShortName().trim().toUpperCase() %> meeting ) period </b></div> 
						
			
			<div align="left" style="margin-left: 15px;"><b class="mainsubtitle"><br>(a) Work carried out, Achievements, test result etc.</b></div>
						
						<!-- Tharun code Start (For Filtering Milestone based on levels) -->					

						<table class="subtables" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;   border-collapse:collapse;" >
						
										<thead>
											<tr>
												<td colspan="9" style="border: 0">
													<p style="font-size: 10px;text-align: center"> 
														<span class="notassign">NA</span> : Not Assigned &nbsp;&nbsp;
														<span class="assigned">AA</span> : Activity Assigned &nbsp;&nbsp; 
														<span class="notyet">NS</span> : Not yet Started &nbsp;&nbsp;
														<span class="ongoing">OG</span> : On Going &nbsp;&nbsp; 
														<span class="delay">DO</span> : Delay - On Going &nbsp;&nbsp; 
														<span class="ongoing">RC</span> : Review & Close &nbsp;&nbsp;
														<span class="delay">FD</span> : Forwarded With Delay &nbsp;&nbsp;
														<span class="completed">CO</span> : Completed &nbsp;&nbsp; 
														<span class="completeddelay">CD</span> : Completed with Delay &nbsp;&nbsp; 
														<span class="inactive">IA</span> : InActive &nbsp;&nbsp;
														<!-- <span class="ongoing">UF</span> : User Forwarded &nbsp;&nbsp; --> 
													 </p>
								   				</td>									
											</tr>
										</thead>
										
							<tbody>
								<tr>
									<th  style="width: 20px; ">SN</th>
									<th  style="width: 30px; ">MS</th>
									<th  style="width: 30px; ">L</th>
									<th  style="width: 300px; ">System/ Subsystem/ Activities</th>
									<th  style="width: 110px; "> Original PDC</th>
									<th  style="width: 100px; "> Revised PDC</th>
									<th  style="width: 60px; "> Progress</th>
									<th  style="width: 50px; "> Status</th>
								 	<th  style="width: 270px; "> Remarks</th>

								<% if( MilestoneDetails6.get(z).size()>0){ 
									long count1=1;
									int milcountA=1;
									int milcountB=1;
									int milcountC=1;
									int milcountD=1;
									int milcountE=1;
								%>
									
									<% int serial=1; for(Object[] obj:MilestoneDetails6.get(z)){
										
										if(Integer.parseInt(obj[21].toString())<= Integer.parseInt(levelid) ){
										%>
										<tr>
											<td style="text-align: center"><%=serial%></td>
											<td style="text-align: center">M<%=obj[0] %></td>
									
											<td style="text-align: center">
												<%
												
												if(obj[21].toString().equals("0")) {%>
													<!-- L -->
												<%	milcountA=1;
													milcountB=1;
													milcountC=1;
													milcountD=1;
													milcountE=1;
												}else if(obj[21].toString().equals("1")) { %>
													A-<%=milcountA %>
												<% milcountA++;
													milcountB=1;
													milcountC=1;
													milcountD=1;
													milcountE=1;
												}else if(obj[21].toString().equals("2")) { %>
													B-<%=milcountB %>
												<%milcountB+=1;
												milcountC=1;
												milcountD=1;
												milcountE=1;
												}else if(obj[21].toString().equals("3")) { %>
													C-<%=milcountC %>
												<%milcountC+=1;
												milcountD=1;
												milcountE=1;
												}else if(obj[21].toString().equals("4")) { %>
													D-<%=milcountD %>
												<%
												milcountD+=1;
												milcountE=1;
												}else if(obj[21].toString().equals("5")) { %>
													E-<%=milcountE %>
												<%milcountE++;
												} %>
											</td>

											<td style="<%if(obj[21].toString().equals("0")) {%>font-weight: bold;<%}%>text-align: justify;">
												<%if(obj[21].toString().equals("0")) {%>
													<%=obj[10] %>
												<%}else if(obj[21].toString().equals("1")) { %>
													&nbsp;&nbsp;<%=obj[11] %>
												<%}else if(obj[21].toString().equals("2")) { %>
													&nbsp;&nbsp;<%=obj[12] %>
												<%}else if(obj[21].toString().equals("3")) { %>
													&nbsp;&nbsp;<%=obj[13] %>
												<%}else if(obj[21].toString().equals("4")) { %>
													&nbsp;&nbsp;<%=obj[14] %>
												<%}else if(obj[21].toString().equals("5")) { %>
													&nbsp;&nbsp;<%=obj[15] %>
												<%} %>
											</td>
											<td style="text-align: center;"><%=sdf.format(sdf1.parse(obj[9].toString())) %></td>
											<td style="text-align: center;">
											
											<%-- 	<%if(LocalDate.parse(obj[9].toString()).isEqual(LocalDate.parse(obj[8].toString())) ){ %>
											 		-
											 	<%}else{ %>
											 		<%=sdf.format(sdf1.parse(obj[8].toString())) %>
											 	<%} %> --%>
											
											<%-- <%=sdf.format(sdf1.parse(obj[8].toString())) %> --%>

												<%if(!LocalDate.parse(obj[9].toString()).isEqual(LocalDate.parse(obj[8].toString()))){ %>
												<%=sdf.format(sdf1.parse(obj[8].toString())) %>
												<%}else {%>
												-
												<%} %>
											</td>
											<td style="text-align: center"><%=obj[17] %>%</td>											
											<td style="text-align: center">
											<span class="<%if(obj[19].toString().equalsIgnoreCase("0")){%>assigned
														<%}else if(obj[19].toString().equalsIgnoreCase("1")) {%> notyet
														<%}else if(obj[19].toString().equalsIgnoreCase("2")) {%> ongoing
														<%}else if(obj[19].toString().equalsIgnoreCase("3")) {%> completed
														<%}else if(obj[19].toString().equalsIgnoreCase("4")) {%> delay 
														<%}else if(obj[19].toString().equalsIgnoreCase("5")) {%> completeddelay
														<%}else if(obj[19].toString().equalsIgnoreCase("6")) {%> inactive<%} %>	 " >
												<%=obj[22] %>	
											</span> 
											
											</td>
											<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;text-align: justify;"><%if(obj[23]!=null){%><%=obj[23]%><%} %></td>
									</tr>
									<%count1++; serial++;}} %>
								<% } else{ %>
									<tr><td colspan="9" style="text-align:center; "> Nil</td></tr>
								<%} %>
								</tbody>
								
							</table>
    
	
		<!-- Tharun code end -->
						
			
						
						<h1 class="break"></h1>
						 <div align="left" style="margin-left: 15px;"><b class="mainsubtitle">(b) TRL table with TRL at sanction stage and current stage indicating overall PRI.</b></div>
							<div>
						
								<% if(projectdatadetails.get(z)!=null && projectdatadetails.get(z)[6]!=null){ %>
				
									<%if(new File(AppFilesPath+projectdatadetails.get(z)[2]+"\\"+projectdatadetails.get(z)[6]).exists()){ %>
									
										<%if(!FilenameUtils.getExtension(projectdatadetails.get(z)[6].toString()).equalsIgnoreCase("pdf") ){ %>
											<div align="center"><br>
												<img class="logo" style="max-width:25cm;max-height:17cm;margin-bottom: 5px"  src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(AppFilesPath+projectdatadetails.get(z)[2]+"\\"+projectdatadetails.get(z)[6])))%>" alt="Speci" >
											</div> 
										<% }else{ %>
											 <b> TRL table with TRL at sanction stage Annexure </b>
										<% }%>
									
									<%}else{ %>
										<div align="center">
											<br>
											File Missing in File System
										</div>
									<%} %>
								
								
								<%}else{ %>
									<b> File Not Found</b>
								<%} %>
								
								
						</div>
											
						
						
						<h1 class="break"></h1>
			<div align="left" style="margin-left: 15px;"><b class="mainsubtitle">(c) Risk Matrix/Management Plan/Status. </b></div>
			
			
		<%-- <table class="subtables" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;  border-collapse:collapse;" >
										<thead>	
											<tr>
												<th style="width: 15px;text-align: center " rowspan="2">SN</th>
												<th style="width: 280px; ">Risk</th>
												<th style="width: 100px; "  > PDC</th>
												<th style="width: 110px; "> ADC</th>
												<th style="width: 200px; " > Responsibility</th>
												<th style="width: 50px; ">Status</th>
												<th style="width: 235px; ">Remarks</th>	
											</tr>
											
											<tr>
												<th  style="text-align: center "> Severity</th>
												<th  style="text-align: center "> Probability</th>
												<th  style="text-align: center "> RPN</th>
												<th  style=""> Mitigation Plans</th>
												<th  style="" colspan="2"> Impact</th>		
											</tr>
										
										</thead>
																		
										<tbody>
												<%if(riskmatirxdata.get(z).size()>0){
												int i=0;%> 
													<%for(Object[] obj : riskmatirxdata.get(z)){
													i++;%>
													<tr>
														<td style="text-align: center" rowspan="2"><%=i %></td>
														<td style="text-align: center;"><%=obj[0] %></td>
														<td style="text-align: center">
															<%=sdf.format(sdf1.parse(obj[17].toString())) %>
														</td>
														
														<td style="text-align: center">
															<%if(obj[15].toString().equals("C")  && obj[20]!=null){ %>

																<%if(obj[18]!=null){ %>
																	<%if(obj[15].toString().equals("I") && obj[16].toString().equals("F") && (LocalDate.parse(obj[17].toString()).isAfter(LocalDate.parse(obj[20].toString())) || LocalDate.parse(obj[17].toString()).isEqual(LocalDate.parse(obj[20].toString())) )){ %>
																		<span class="ongoing"><%= sdf.format(sdf1.parse(obj[20].toString()))%> </span>
																	<%}else if(obj[15].toString().equals("I") && obj[16].toString().equals("F") && LocalDate.parse(obj[17].toString()).isBefore(LocalDate.parse(obj[20].toString()))){  %>
																		<span class="delay"><%= sdf.format(sdf1.parse(obj[20].toString()))%> </span>
																	<%}else if(obj[15].toString().equals("C")&&(LocalDate.parse(obj[17].toString()).isAfter(LocalDate.parse(obj[20].toString()))||obj[17].equals(obj[20]))){  %>
																		<span class="completed"><%= sdf.format(sdf1.parse(obj[20].toString()))%> </span>
																	<%}else if(obj[15].toString().equals("C")&&LocalDate.parse(obj[17].toString()).isBefore(LocalDate.parse(obj[20].toString()))){  %>
																	   <span class="completeddelay"><%= sdf.format(sdf1.parse(obj[20].toString()))%> </span>
																	<%}else if(!obj[16].toString().equals("F")&&obj[15].toString().equals("I")&&(LocalDate.parse(obj[17].toString()).isAfter(LocalDate.parse(obj[20].toString()))|| LocalDate.parse(obj[17].toString()).isEqual(LocalDate.parse(obj[20].toString())) )){  %> 
																	<span class="ongoing"><%= sdf.format(sdf1.parse(obj[20].toString()))%> </span>
																	<%}else if(!obj[16].toString().equals("F")&&obj[15].toString().equals("I")&&LocalDate.parse(obj[17].toString()).isBefore(LocalDate.parse(obj[20].toString()))){  %> 
																	<span class="delay"><%= sdf.format(sdf1.parse(obj[20].toString()))%> </span>
																	<%}
																	}else if(obj[15].toString().equals("C")){ %>
																        <span class="completed"><%= sdf.format(sdf1.parse(obj[20].toString()))%> </span>
																    <% }else{ %>
																      	<span class="notyet"><%= sdf.format(sdf1.parse(obj[20].toString()))%> </span> 
																<%} %> 
																
															<%}else{ %>-<%} %>
														</td>
															
														<td  ><%=obj[7] %>,&nbsp;<%=obj[8] %></td>	
														<td style="text-align: center">
															
															<%if(obj[18]!=null){ %>
																<%if(obj[15].toString().equals("I") && obj[16].toString().equals("F") && (LocalDate.parse(obj[17].toString()).isAfter(LocalDate.parse(obj[20].toString())) || LocalDate.parse(obj[17].toString()).isEqual(LocalDate.parse(obj[20].toString())) )){ %>
																	<span class="ongoing">RC</span>
																<%}else if(obj[15].toString().equals("I") && obj[16].toString().equals("F") && LocalDate.parse(obj[17].toString()).isBefore(LocalDate.parse(obj[20].toString()))){  %>
																	<span class="delay">FD</span>
																<%}else if(obj[15].toString().equals("C")&&(LocalDate.parse(obj[17].toString()).isAfter(LocalDate.parse(obj[20].toString()))||obj[17].equals(obj[20]))){  %>
																	<span class="completed">CO</span>
																<%}else if(obj[15].toString().equals("C")&&LocalDate.parse(obj[17].toString()).isBefore(LocalDate.parse(obj[20].toString()))){  %>
																   <span class="completeddelay">CD (<%= ChronoUnit.DAYS.between(LocalDate.parse(obj[17].toString()), LocalDate.parse(obj[20].toString())) %>) </span>
																<%}else if(!obj[16].toString().equals("F")&&obj[15].toString().equals("I")&&(LocalDate.parse(obj[17].toString()).isAfter(LocalDate.now())|| LocalDate.parse(obj[17].toString()).isEqual(LocalDate.now()) )){  %> 
																<span class="ongoing">OG</span>
																<%}else if(!obj[16].toString().equals("F")&&obj[15].toString().equals("I")&&LocalDate.parse(obj[17].toString()).isBefore(LocalDate.now())){  %> 
																<span class="delay">DO</span>
															<%}
															}else if(obj[15].toString().equals("C")  && obj[20]!=null){ %>
														        <span class="completed">CO</span>
														    <% }else{ %>
														      	<span class="notyet">NS</span> 
															<% } %> 
														
														
														</td>
														<td style="text-align: center"><%if(obj[19]!=null){ %> <%=obj[19] %><%} %></td>
														
													</tr>	
													
													<tr>
														<td style="text-align: center;" ><%=obj[1] %></td>
														<td style="text-align: center;" ><%=obj[2] %></td>
														<td style="text-align: center;" ><%=obj[22] %></td>
														<td style="text-align: justify;" ><%=obj[3] %></td>
														<td style="text-align: justify;" colspan="2" ><%=obj[21] %></td>
													</tr>
															
													<%}%>
												<%}else{%>
													<tr><td colspan="7"  style="text-align: center;">Nil </td></tr>
												<%} %>
											</tbody>		
										</table> --%>
										
										
										<table class="subtables" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;  border-collapse:collapse;" >
										<thead>	
											<tr>
												<th style="width: 15px;text-align: center " rowspan="2">SN</th>
												<th style="width: 330px; " colspan="3">Risk</th>
												<th style="width: 90px; "  > PDC</th>
												<th style="width: 110px; "> ADC</th>
												<th style="width: 160px; " > Responsibility</th>
												<th style="width: 50px; ">Status</th>
												<th style="width: 215px; ">Remarks</th>	
											</tr>
											
											<tr>
												<th  style="text-align: center "> Severity</th>
												<th  style="text-align: center "> Probability</th>
												<th  style="text-align: center "> RPN</th>
												<th  style="" colspan="3" > Mitigation Plans</th>
												<th  style="" colspan="2"> Impact</th>		
											</tr>
										
										</thead>
																		
										<tbody>
												<%if(riskmatirxdata.get(z).size()>0){
												int i=0;%> 
													<%for(Object[] obj : riskmatirxdata.get(z)){
													i++;%>
													<tr>
														<td style="text-align: center" rowspan="2"><%=i %></td>
														<td style="text-align: justify;" colspan="3" ><%=obj[0] %></td>
														<td style="text-align: center">
															<%=sdf.format(sdf1.parse(obj[17].toString())) %>
														</td>
														
														<td style="text-align: center">
															<%if(obj[15].toString().equals("C")  && obj[20]!=null){ %>

																<%if(obj[18]!=null){ %>
																	<%if(obj[15].toString().equals("I") && obj[16].toString().equals("F") && (LocalDate.parse(obj[17].toString()).isAfter(LocalDate.parse(obj[20].toString())) || LocalDate.parse(obj[17].toString()).isEqual(LocalDate.parse(obj[20].toString())) )){ %>
																		<span class="ongoing"><%= sdf.format(sdf1.parse(obj[20].toString()))%> </span>
																	<%}else if(obj[15].toString().equals("I") && obj[16].toString().equals("F") && LocalDate.parse(obj[17].toString()).isBefore(LocalDate.parse(obj[20].toString()))){  %>
																		<span class="delay"><%= sdf.format(sdf1.parse(obj[20].toString()))%> </span>
																	<%}else if(obj[15].toString().equals("C")&&(LocalDate.parse(obj[17].toString()).isAfter(LocalDate.parse(obj[20].toString()))||obj[17].equals(obj[20]))){  %>
																		<span class="completed"><%= sdf.format(sdf1.parse(obj[20].toString()))%> </span>
																	<%}else if(obj[15].toString().equals("C")&&LocalDate.parse(obj[17].toString()).isBefore(LocalDate.parse(obj[20].toString()))){  %>
																	   <span class="completeddelay"><%= sdf.format(sdf1.parse(obj[20].toString()))%> </span>
																	<%}else if(!obj[16].toString().equals("F")&&obj[15].toString().equals("I")&&(LocalDate.parse(obj[17].toString()).isAfter(LocalDate.parse(obj[20].toString()))|| LocalDate.parse(obj[17].toString()).isEqual(LocalDate.parse(obj[20].toString())) )){  %> 
																	<span class="ongoing"><%= sdf.format(sdf1.parse(obj[20].toString()))%> </span>
																	<%}else if(!obj[16].toString().equals("F")&&obj[15].toString().equals("I")&&LocalDate.parse(obj[17].toString()).isBefore(LocalDate.parse(obj[20].toString()))){  %> 
																	<span class="delay"><%= sdf.format(sdf1.parse(obj[20].toString()))%> </span>
																	<%}
																	}else if(obj[15].toString().equals("C")){ %>
																        <span class="completed"><%= sdf.format(sdf1.parse(obj[20].toString()))%> </span>
																    <% }else{ %>
																      	<span class="notyet"><%= sdf.format(sdf1.parse(obj[20].toString()))%> </span> 
																<%} %> 
																
															<%}else{ %>-<%} %>
														</td>
															
														<td  ><%=obj[7] %><%-- ,&nbsp;<%=obj[8] %> --%></td>	
														<td style="text-align: center">
															
															<%if(obj[18]!=null){ %>
																<%if(obj[15].toString().equals("I") && obj[16].toString().equals("F") && (LocalDate.parse(obj[17].toString()).isAfter(LocalDate.parse(obj[20].toString())) || LocalDate.parse(obj[17].toString()).isEqual(LocalDate.parse(obj[20].toString())) )){ %>
																	<span class="ongoing">RC</span>
																<%}else if(obj[15].toString().equals("I") && obj[16].toString().equals("F") && LocalDate.parse(obj[17].toString()).isBefore(LocalDate.parse(obj[20].toString()))){  %>
																	<span class="delay">FD</span>
																<%}else if(obj[15].toString().equals("C")&&(LocalDate.parse(obj[17].toString()).isAfter(LocalDate.parse(obj[20].toString()))||obj[17].equals(obj[20]))){  %>
																	<span class="completed">CO</span>
																<%}else if(obj[15].toString().equals("C")&&LocalDate.parse(obj[17].toString()).isBefore(LocalDate.parse(obj[20].toString()))){  %>
																   <span class="completeddelay">CD (<%= ChronoUnit.DAYS.between(LocalDate.parse(obj[17].toString()), LocalDate.parse(obj[20].toString())) %>) </span>
																<%}else if(!obj[16].toString().equals("F")&&obj[15].toString().equals("I")&&(LocalDate.parse(obj[17].toString()).isAfter(LocalDate.now())|| LocalDate.parse(obj[17].toString()).isEqual(LocalDate.now()) )){  %> 
																<span class="ongoing">OG</span>
																<%}else if(!obj[16].toString().equals("F")&&obj[15].toString().equals("I")&&LocalDate.parse(obj[17].toString()).isBefore(LocalDate.now())){  %> 
																<span class="delay">DO</span>
															<%}
															}else if(obj[15].toString().equals("C")  && obj[20]!=null){ %>
														        <span class="completed">CO</span>
														    <% }else{ %>
														      	<span class="notyet">NS</span> 
															<% } %> 
														
														
														</td>
														<td style="text-align: justify"><%if(obj[19]!=null){ %> <%=obj[19] %><%} %></td>
														
													</tr>	
													
													<tr>
														<td style="text-align: center;" ><%=obj[1] %></td>
														<td style="text-align: center;" ><%=obj[2] %></td>
														<td style="text-align: center;" ><%=obj[22] %></td>
														<td style="text-align: justify;" colspan="3" ><%=obj[3] %></td>
														<td style="text-align: justify;" colspan="2" ><%=obj[21] %></td>
													</tr>
															
													<%}%>
												<%}else{%>
													<tr><td colspan="7"  style="text-align: center;">Nil </td></tr>
												<%} %>
											</tbody>		
										</table>
  

<!-- ----------------------------------------------5.Particulars of Meeting------------------------------------------------- -->
 <h1 class="break"></h1>
<!-- ----------------------------------------------6. Procurement Status------------------------------------------------- -->
			<div align="left" style="margin-left: 10px;"><b class="sub-title">7. Details of Procurement plan (Major Items): </b></div>
			
									<table class="subtables" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;   border-collapse:collapse;" >
										<thead>
											<tr>
											 	<th colspan="8" ><b class="mainsubtitle">Demand Details ( > <% if(projectdatadetails.get(0)!=null && projectdatadetails.get(0)[13] != null){ %>  <%=projectdatadetails.get(0)[13].toString().replaceAll("\\.\\d+$", "") %> <span class="currency">Lakhs</span> ) <%} else {%> - )<%} %> </b> </th>
											 </tr>
										
										
										<tr>
											<th  style="width: 15px !important;text-align: center;">SN</th>
											<th  style="width: 175px;">Demand No</th>
											<th  style="width: 100px; ">Demand Date</th>
											<th  colspan="2" style="width: 355px;"> Nomenclature</th>
											<th  style="width: 80px;"> Est. Cost-Lakh &#8377;</th>
											<th  style="width: 50px; "> Status</th>
											<th  style="width: 195px;">Remarks</th>
										</tr>
									</thead>
										    <% int k=0;
										    if(procurementOnDemand.get(z)!=null &&  procurementOnDemand.get(z).size()>0){
										    Double estcost=0.0;
										    Double socost=0.0;
										    for(Object[] obj : procurementOnDemand.get(z)){ 
										    	k++; %>
											<tr>
												<td style="text-align: center;"><%=k%></td>
												<td ><%=obj[1]%></td>
												<td style="text-align:center" ><%=sdf.format(sdf1.parse(obj[3].toString()))%></td>
												<td  colspan="2" ><%=obj[8]%></td>
												<td  style=" text-align:right;"> <%=format.format(new BigDecimal(obj[5].toString())).substring(1)%></td>
												<td  > <%=obj[10]%> </td>
												<td  ><%=obj[11]%> </td>		
											</tr>		
											<%
											estcost += Double.parseDouble(obj[5].toString());
										    }%>
										    
										    <tr>
										    	<td colspan="5" style="text-align: right;"><b>Total</b></td>
										    	<td style="text-align: right;"><b><%=df.format(estcost)%></b></td>
										    	
										    	<td colspan="2" style="text-align: right;"></td>

										    </tr>
										    
										    
										    <% }else{%>											
												<tr><td colspan="8"  style="text-align: center;">Nil </td></tr>
											<%} %>
										</table>
								
								
									<!-- </table>
									<div align="left" style="margin-left: 25px;"></div>
					 				<table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px; width: 980px;  border-collapse:collapse;" >
										<thead> -->
										
										<table class="subtables" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;  border-collapse:collapse;" >
										<thead>
											 <tr >
											 	<th colspan="8" ><b class="mainsubtitle">Order Placed ( > <% if(projectdatadetails.get(0)!=null && projectdatadetails.get(0)[13] != null){ %>  <%=projectdatadetails.get(0)[13].toString().replaceAll("\\.\\d+$", "") %> <span class="currency">Lakhs</span> ) <%} else {%> -  )<%} %> </b> </th>
											 </tr>
										 </thead>
										
										
										  	 	 <tr>	
											  	 	 <th rowspan="2" style="width: 15px !important;text-align: center;">SN</th>
											  	 	 <th style="width: 150px;">Demand No </th>
											  	 	 <th style="width: 80px;">Demand  Date</th>
													 <th  colspan="2" style="width: 295px;"> Nomenclature</th>
													 <th  style="width: 80px;"> Est. Cost-Lakh &#8377;</th>
													 <th  style="max-width: 50px; "> Status</th>
													 <th  style="max-width: 310px;">Remarks</th>
												</tr>
											<tr>
												
												 <th style="">Supply Order No</th>
												 <th  style="	">DP Date</th>
												 <th  colspan="2" style="	">Vendor Name</th>
												 <th  >Rev DP Date</th>											 
												 <th   colspan="2" >SO Cost-Lakh &#8377;</th>		
											 		
											</tr>
										    <%if(procurementOnSanction.get(z)!=null && procurementOnSanction.get(z).size()>0){
										    	k=0;
										    	 Double estcost=0.0;
												 Double socost=0.0;
												 String demand="";
										  	 	for(Object[] obj:procurementOnSanction.get(z))
										  	 	{ 
										  	 		if(obj[2]!=null){ 
										  	 		if(!obj[1].toString().equals(demand)){
										  	 			k++;
										  	 		%>
										  	 

												<tr>
												<td rowspan="2" style="text-align: center;"><%=k%></td>
												<td ><%=obj[1]%> </td>
												<td style="text-align:center" ><%=sdf.format(sdf1.parse(obj[3].toString()))%></td>
													<td   colspan="2" style="text-align: justify;"><%=obj[8]%></td>
													<td  style=" text-align:right;"> <%=format.format(new BigDecimal(obj[5].toString())).substring(1)%></td>
												    <td  > <%=obj[10]%> </td>
													<td  ><%=obj[11]%> </td>	
												</tr>
												<%demand=obj[1].toString();
												} %>
												<tr>
													
													<td ><% if(obj[2]!=null){%> <%=obj[2]%> <%}else{ %>-<%} %>
													</td>
													<td style="text-align:center" ><%if(obj[4]!=null){%> <%=sdf.format(sdf1.parse(obj[4].toString()))%> <%}else{ %> - <%} %></td>
													<td  colspan="2"> <%=obj[12] %>
													</td>
													<td style="text-align:center"><%if(obj[7]!=null){%> <%=sdf.format(sdf1.parse(obj[7].toString()))%><%}else{ %>-<%} %></td>
				                                    <td  colspan="2" style=" text-align: right;"><%if(obj[6]!=null){%> <%=format.format(new BigDecimal(obj[6].toString())).substring(1)%> <%} else{ %> - <%} %></td>												
				
												</tr>		
												<% }
										  	 		
										  	 		Double value = 0.00;
										  	 		if(obj[6]!=null){
										  	 			value=Double.parseDouble(obj[6].toString());
										  	 		}
										  	 		
										  	 		estcost += Double.parseDouble(obj[5].toString());
										  	 		socost +=  value;
										  	 		
										  	 	 } 
										   	%>
										   	 
										    <tr>
										    	<td colspan="6" style="text-align: right;"><b>Total</b></td>
										    	<td colspan="2" style="text-align: right;"><b><%=df.format(socost)%></b></td>
										    	
										    </tr>
										     <% }else{%>
											
												<tr><td colspan="8"  style="text-align: center;">Nil </td></tr>
											<%} %>
									</table> 
									
									<br>
									<table class="subtables" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;  border-collapse:collapse;" >
										 <thead>
											 <tr >
												 <th colspan="8" ><b class="mainsubtitle">Total Summary of Procurement</b></th>
											 </tr>
										 </thead>
										 
										 <tbody>
										<tr >
												 <th>No. of Demand</th>
												 <th>Est. Cost (<span>Lakh</span> &#8377;)</th>
										  	 	 <th>No. of Orders</th>
										  	 	 <th>SO Cost (<span>Lakh</span> &#8377;)</th>
										  	 	 <th>Expenditure (<span>Lakh</span> &#8377;)</th>
										</tr>
										 
										 <%if(totalprocurementdetails!=null && totalprocurementdetails.size()>0){ 
										 for(TotalDemand obj:totalprocurementdetails){
											 if(obj.getProjectId().equalsIgnoreCase(projectid)){
										 %>
										   <tr>
										      <td style="text-align: center;"><%=obj.getDemandCount() %></td>
										      <td style="text-align: center;"><%=obj.getEstimatedCost() %></td>
										      <td style="text-align: center;"><%=obj.getSupplyOrderCount()%></td>
										      <td style="text-align: center;"><%=obj.getTotalOrderCost() %></td>
										      <td style="text-align: center;"><%=obj.getTotalExpenditure() %></td>
										   </tr>
										   <%}}}else{%>
										   <tr>
										      <td class="std" colspan="5" style="text-align: center;">IBAS Server Could Not Be Connected</td>
										   </tr>
										   <%} %>
										   </tbody>
									  </table>
               
<!-- ----------------------------------------------6. Procurement Status------------------------------------------------- -->
 <h1 class="break"></h1>
<!-- ----------------------------------------------7. Overall financial Status------------------------------------------------- -->

		 
   					<div align="left" style="margin-left: 10px;"><b class="sub-title">8. Overall Financial Status </b></div><div align="right"><b><span class="currency" >(&#8377; <span>Crore</span>)</span></b></div>
						 
						  	<table  class="subtables" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;  border-collapse:collapse;" >
						  	    <thead>
		                           <tr>
		                         	<th colspan="2" style="text-align: center ;width:200px !important;"><b>Head</b></td>
		                         	<th colspan="2" style="text-align: center;width:120px !important;"><b>Sanction</b></td>
			                        <th colspan="2" style="text-align: center;width:120px !important;"><b>Expenditure</b></td>
			                        <th colspan="2" style="text-align: center;width:120px !important;"><b>Out Commitment</b> </td>
		                           	<th colspan="2" style="text-align: center;width:120px !important;"><b>Balance</b></td>
			                        <th colspan="2" style="text-align: center;width:120px !important;"><b>DIPL</b></td>
		                          	<th colspan="2" style="text-align: center;width:120px !important;"><b>Notional Balance</b></td>
			                      </tr>
			                      <tr>
				                    <th style="width:30px !important;text-align: center;" >SN</th>
				                    <th   style="width:180px !important;" width="10">Head</th>
				                    <th>RE</th>
				                    <th>FE</th>
				                    <th>RE</th>
				                    <th>FE</th>
			            	        <th>RE</th>
			                    	<th>FE</th>
		                  		    <th>RE</th>
				                    <th>FE</th>
				                    <th>RE</th>
				                    <th>FE</th>
				                    <th>RE</th>
				                    <th>FE</th>
		                       	  </tr>
			                    </thead>
			                    <tbody>
			                    <% 
		                		double totSanctionCost=0,totReSanctionCost=0,totFESanctionCost=0;
			                	double totExpenditure=0,totREExpenditure=0,totFEExpenditure=0;
			                 	double totCommitment=0,totRECommitment=0,totFECommitment=0,totalDIPL=0,totalREDIPL=0,totalFEDIPL=0;
				                double totBalance=0,totReBalance=0,totFeBalance=0,btotalRe=0,btotalFe=0;
				                int count=1;
			                        if(projectFinancialDetails!=null && projectFinancialDetails.size()>0 && projectFinancialDetails.get(z)!=null ){
			                      for(ProjectFinancialDetails projectFinancialDetail:projectFinancialDetails.get(z)){                       %>
			 
			                         <tr>
			<td align="center" style="max-width:50px !important;text-align: center;"><%=count++ %></td>
			<td ><b><%=projectFinancialDetail.getBudgetHeadDescription()%></b></td>
			<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getReSanction()) %></td>
			<%totReSanctionCost+=(projectFinancialDetail.getReSanction());%>
			<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getFeSanction())%></td>
			<%totFESanctionCost+=(projectFinancialDetail.getFeSanction());%>
			<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getReExpenditure()) %></td>
			<%totREExpenditure+=(projectFinancialDetail.getReExpenditure());%>
		    <td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getFeExpenditure())%></td>
			<%totFEExpenditure+=(projectFinancialDetail.getFeExpenditure());%>
		    <td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getReOutCommitment())%></td>
			<%totRECommitment+=(projectFinancialDetail.getReOutCommitment());%>
		    <td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getFeOutCommitment())%></td>
			<%totFECommitment+=(projectFinancialDetail.getFeOutCommitment());%>
			<td align="right"style="text-align: right;"><%=df.format(projectFinancialDetail.getReBalance()+projectFinancialDetail.getReDipl())%></td>
			<%btotalRe+=(projectFinancialDetail.getReBalance()+projectFinancialDetail.getReDipl());%>
			<td align="right"style="text-align: right;"><%=df.format(projectFinancialDetail.getFeBalance()+projectFinancialDetail.getFeDipl())%></td>
	       	<%btotalFe+=(projectFinancialDetail.getFeBalance()+projectFinancialDetail.getFeDipl());%>
		 <td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getReDipl())%></td>
			<%totalREDIPL+=(projectFinancialDetail.getReDipl());%>
		 <td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getFeDipl())%></td>
			<%totalFEDIPL+=(projectFinancialDetail.getFeDipl());%>
	<%-- 	<%double balance=(res.getDouble("SanctionCost")-(res.getDouble("Expenditure")+res.getDouble("OutCommitment")+res.getDouble("Dipl"));%> --%>
		 <td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getReBalance())%></td>
			<%totReBalance+=(projectFinancialDetail.getReBalance());%>
		 <td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getFeBalance())%></td>
			<%totFeBalance+=(projectFinancialDetail.getFeBalance());%>
		</tr>
			<%} }%>
			</tbody>
					<tr>
						<td colspan="2"><b>Total</b></td>
						<td align="right" style="text-align: right;"><%=df.format(totReSanctionCost)%></td>
						<td align="right" style="text-align: right;"><%=df.format(totFESanctionCost)%></td>
						<td align="right" style="text-align: right;"><%=df.format(totREExpenditure)%></td>
						<td align="right" style="text-align: right;"><%=df.format(totFEExpenditure)%></td>
						<td align="right" style="text-align: right;"><%=df.format(totRECommitment)%></td>
						<td align="right" style="text-align: right;"><%=df.format(totFECommitment)%></td>
						<td align="right" style="text-align: right;"><%=df.format(btotalRe)%></td>
						<td align="right" style="text-align: right;"><%=df.format(btotalFe)%></td>
						<td align="right" style="text-align: right;"><%=df.format(totalREDIPL)%></td>
						<td align="right" style="text-align: right;"><%=df.format(totalFEDIPL)%></td>
						<td align="right" style="text-align: right;"><%=df.format(totReBalance)%></td>
						<td align="right" style="text-align: right;"><%=df.format(totFeBalance)%></td>
					</tr>
					<tr>
						<td colspan="2"><b>GrandTotal</b></td>
						<td colspan="2" align="right" style="text-align: right;"><b><%=df.format(totReSanctionCost+totFESanctionCost)%></b></td>
						<td colspan="2" align="right" style="text-align: right;"><b><%=df.format(totREExpenditure+totFEExpenditure)%></b></td>
						<td colspan="2" align="right" style="text-align: right;"><b><%=df.format(totRECommitment+totFECommitment)%></b></td>
						<td colspan="2" align="right" style="text-align: right;"><b><%=df.format(btotalRe+btotalFe)%></b></td>
						<td colspan="2" align="right" style="text-align: right;"><b><%=df.format(totalREDIPL+totalFEDIPL)%></b></td>
						<td colspan="2" align="right" style="text-align: right;"><b><%=df.format(totReBalance+totFeBalance)%></b></td>
					</tr>
			                         
			                         
			                         
			                    
			                 
			     </tbody>
			</table>  	
  
 <h1 class="break"></h1>
<!-- ---------------------------------------------- -------------------------- ------------------------------------------------- -->
		<div align="left" style="margin-left: 10px;"><b>
		
				<%if(Integer.parseInt(committeeid)==2){ %>
   							<b class="sub-title">9. Action Plan for Next Six Months - Technical Milestones with Financial Outlay : </b>  
				<%}else { %>
							<b class="sub-title">9. Action Plan for Next Three Months - Technical Milestones with Financial Outlay : </b> 
				<%} %>
		
		
		</b></div>
		
			<!-- Tharun code after Level -->
		
				<table class="subtables" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;   border-collapse:collapse;" >
				
				
						<thead>
							<tr>
								<td colspan="9" style="border: 0">
									<p style="font-size: 10px;text-align: center"> 
									<span class="notassign">NA</span> : Not Assigned &nbsp;&nbsp;
									<span class="assigned">AA</span> : Activity Assigned &nbsp;&nbsp; 
									<span class="notyet">NS</span> : Not yet Started &nbsp;&nbsp;
									<span class="ongoing">OG</span> : On Going &nbsp;&nbsp; 
									<span class="delay">DO</span> : Delay - On Going &nbsp;&nbsp; 
									<span class="ongoing">RC</span> : Review & Close &nbsp;&nbsp;
									<span class="delay">FD</span> : Forwarded With Delay &nbsp;&nbsp;
									<span class="completed">CO</span> : Completed &nbsp;&nbsp; 
									<span class="completeddelay">CD</span> : Completed with Delay &nbsp;&nbsp; 
									<span class="inactive">IA</span> : InActive &nbsp;&nbsp;
									<!-- <span class="ongoing">UF</span> : User Forwarded &nbsp;&nbsp; --> 
									 </p>
								</td>									
							</tr>
							
								<tr>
									<th style="width: 15px !important;text-align: center;">SN</th>
									<th style="width: 20px; ">MS</th>
									<th style="width: 20px; ">L</th>
									<th style="width: 275px;">Action Plan </th>	
									<th style="width: 90px;" >PDC</th>	
									<th style="width: 210px;">Responsibility </th>
									<th style="width: 50px;">Progress </th>
					                <th style="width: 50px;padding-right: 5px !important ">Status</th>
					                <th style="width: 230px;">Remarks</th>
								</tr>
							</thead>
							<tbody>
								<%if(actionplanthreemonths.get(z).size()>0){ 
									long count1=1;
									int countA=1;
									int countB=1;
									int countC=1;
									int countD=1;
									int countE=1;
									%>
									<%int serialno=1; for(Object[] obj:actionplanthreemonths.get(z)){
										
										if(Integer.parseInt(obj[26].toString())<= Integer.parseInt(levelid) ){
										/*  if(obj[26].toString().equals("0")||obj[26].toString().equals("1")){ */
										%>
										
										<tr>
											<td style="text-align: center;"><%=serialno %></td>
											<td style="text-align: center">M<%=obj[22] %></td>
							
											<td style="text-align: center">
												<%
												
												if(obj[26].toString().equals("0")) {%>
													<!-- L -->
												<%countA=1;
													countB=1;
													countC=1;
													countD=1;
													countE=1;
												}else if(obj[26].toString().equals("1")) { %>
													A-<%=countA %>
												<% countA++;
												    countB=1;
												    countC=1;
													countD=1;
													countE=1;
												}else if(obj[26].toString().equals("2")) { %>
													B-<%=countB %>
												<%countB+=1;
												countC=1;
												countD=1;
												countE=1;
												}else if(obj[26].toString().equals("3")) { %>
													C-<%=countC %>
												<%countC+=1;
												countD=1;
												countE=1;
												}else if(obj[26].toString().equals("4")) { %>
													D-<%=countD %>
												<%
												countD+=1;
												countE=1;
												}else if(obj[26].toString().equals("5")) { %>
													E-<%=countE %>
												<%countE++;
												} %>
											</td>
											
											<td style="<%if(obj[26].toString().equals("0")) {%>font-weight: bold;<%}%>;text-align:justify ">
												<%if(obj[26].toString().equals("0")) {%>
													<%=obj[9] %>
												<%}else if(obj[26].toString().equals("1")) { %>
													&nbsp;&nbsp;<%=obj[10] %>
												<%}else if(obj[26].toString().equals("2")) { %>
													&nbsp;&nbsp;<%=obj[11] %>
												<%}else if(obj[26].toString().equals("3")) { %>
													&nbsp;&nbsp;<%=obj[12] %>
												<%}else if(obj[26].toString().equals("4")) { %>
													&nbsp;&nbsp;<%=obj[13] %>
												<%}else if(obj[26].toString().equals("5")) { %>
													&nbsp;&nbsp;<%=obj[14] %>
												<%} %>
											</td>
											<td  style="text-align:center"><%=sdf.format(sdf1.parse(obj[8].toString())) %></td>
											<td ><%=obj[24] %><%-- (<%=obj[25] %>) --%></td>
											<td style="text-align: center"><%=obj[16] %>%</td>											
											<td  style="text-align: center">
											<span class="<%if(obj[20].toString().equalsIgnoreCase("0")){%>assigned
												<%}else if(obj[20].toString().equalsIgnoreCase("1")) {%> notyet
												<%}else if(obj[20].toString().equalsIgnoreCase("2")) {%> ongoing
												<%}else if(obj[20].toString().equalsIgnoreCase("3")) {%> completed
												<%}else if(obj[20].toString().equalsIgnoreCase("4")) {%> delay 
												<%}else if(obj[20].toString().equalsIgnoreCase("5")) {%> completeddelay
												<%}else if(obj[20].toString().equalsIgnoreCase("6")) {%> inactive<%} %>	 status-column " >
												
												<%=obj[27] %>	
												<%-- <%if(obj[20].toString().equalsIgnoreCase("5")) { %>
												(<%= ChronoUnit.DAYS.between(LocalDate.parse(obj[9].toString()), LocalDate.parse(obj[8].toString())) %>)
												<%} %> --%>
											</span>
											
											</td>
											<td >
												<%if(obj[28]!=null){ %>
												<%=obj[28] %>
												<%} %>
											</td>
										</tr>
										
									<%count1++; serialno++;}} %>
								<%} else{ %>
								
								<tr><td colspan="9" style="text-align:center; "> Nil</td></tr>
								
								<%} %>
								
								</tbody>
								
									
								
							</table>
		
					<h1 class="break"></h1>
<!-- ----------------------------------------------8. Action plan for next three------------------------------------------------- -->
<!-- ----------------------------------------------9.GANTT chart---------------------------------------------------------- -->
			<div align="left" style="margin-left: 15px;">
					<b class="sub-title">10. PERT/GANTT chart of overall project schedule :
					<!--  [<span style="text-decoration: underline;">Original (as per Project sanction / Latest PDC extension) and Current</span>]: --> 
				</b>
			</div>
			
              <% if(new File(filePath+projectLabCode+"\\gantt\\grantt_"+projectidlist.get(z)+"_"+No2+".jpg").exists()){ %>
				<div style="font-weight: bold;" align="right" >
					<br>
					<span >
						<span style="margin:0px 0px 10px  10px;">Original : &ensp; <span style=" background-color: #046582;  padding: 0px 15px; border-radius: 3px;"></span></span>
						<span style="margin:0px 0px 10px  15px;">Ongoing : &ensp; <span style=" background-color: #81b214;  padding: 0px 15px;border-radius: 3px;"></span></span>
						<span style="margin:0px 0px 10px  15px;">Revised : &ensp; <span style=" background-color: #f25287; opacity: 0.5; padding: 0px 15px;border-radius: 3px;"></span></span>
					</span>
				</div>	
				<div align="center"><br>
					<img class="logo" style="max-width:25cm;max-height:17cm;margin-bottom: 5px" src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filePath+projectLabCode+"\\gantt\\grantt_"+projectidlist.get(z)+"_"+No2+".jpg")))%>" alt="confi" > 
				</div>
				
              <%} else if(new File(filePath+projectLabCode+"\\gantt\\grantt_"+projectidlist.get(z)+"_"+No2+".pdf").exists()){ %>
              
				<b>Grantt Chart Annexure</b>
				
		    <% }else{ %>
		    	<div align="center">
		    		<br>
		    		File Not Found
		    	</div>
			<%} %>

			<div>
						
<!-- -----------------------------------------------gantt chart js ------------------------------------------------------------------------------------------------------------------------------- -->						    		
				<%if(isprint!=null && isprint.equals("1")){%>
					<div class="row" style="width:650px; margin-left: 10px;">
						<div class="col-md-12" style="float: right;" align="center">
					  	 	<div class="flex-container" id="containers" ></div>
						</div>		
					</div>
				<%}else{ %>
					<br><br><br>
				<%} %>
						    	
			</div>	
			<h1 class="break"></h1>
<!-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- -->
			<div align="left" style="margin-left: 10px;"><b class="sub-title">11. Issues:</b></div>
			
			<table class="subtables" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;   border-collapse:collapse;" >
						<thead>
							<tr>
								<td colspan="7" style="border: 0">
									<p style="font-size: 10px;text-align: center"> 
									<span class="notassign">NA</span> : Not Assigned &nbsp;&nbsp;
									<span class="assigned">AA</span> : Activity Assigned &nbsp;&nbsp; 
									<span class="notyet">NS</span> : Not yet Started &nbsp;&nbsp;
									<span class="ongoing">OG</span> : On Going &nbsp;&nbsp; 
									<span class="delay">DO</span> : Delay - On Going &nbsp;&nbsp; 
									<span class="ongoing">RC</span> : Review & Close &nbsp;&nbsp;
									<span class="delay">FD</span> : Forwarded With Delay &nbsp;&nbsp;
									<span class="completed">CO</span> : Completed &nbsp;&nbsp; 
									<span class="completeddelay">CD</span> : Completed with Delay &nbsp;&nbsp; 
									<span class="inactive">IA</span> : InActive &nbsp;&nbsp;
									<!-- <span class="ongoing">UF</span> : User Forwarded &nbsp;&nbsp; --> 
									 </p>
								</td>									
							</tr>
										<tr>
											 <th  style="width: 20px !important;text-align: center;">SN</th>
											 <th  style="width: 270px;">Issue Point</th>
											 <th  style="width: 80px; "> PDC</th>
											 <th  style="width: 80px; "> ADC</th>
											 <th  style="width: 210px; ">Responsibility</th>
											 <th  style="width: 50px; ">Status</th>	
											 <th  style="width: 270px; ">Remarks</th>		
										</tr>
						</thead>
						<tbody>				
										<%if(oldpmrcissueslist.get(z).size()==0){ %>
										<tr><td colspan="7" style="text-align: center;" > Nil</td></tr>
										<%}
										else if(oldpmrcissueslist.get(z).size()>0)
										  {int i=1;
										for(Object[] obj:oldpmrcissueslist.get(z)){ %>
											<tr>
												<td  style="text-align: center;"><%=i %></td>
												<td  style="text-align: justify;"><%=obj[2] %></td>
												<td   style="text-align: center;" ><%= sdf.format(sdf1.parse(obj[4].toString()))%></td>
												<td  style="text-align: center;"> 
												<%if(obj[9].toString().equals("C")){ %>
												
												<%= sdf.format(sdf1.parse(obj[13].toString()))%> 
												<%}else{ %>- <%} %></td>
												<td > <%=obj[11] %><%-- <%=obj[12] %> --%></td>
												<td  style=";text-align: center;"> 
													<%if(obj[16]!=null){ %>
														<%if(obj[9].toString().equals("I")&&obj[15].toString().equals("F")&&(LocalDate.parse(obj[4].toString()).isAfter(LocalDate.parse(obj[13].toString()))||obj[4].equals(obj[13]) )){ %>
															<span class="ongoing">RC</span>
														<%}else if(obj[9].toString().equals("I")&&obj[15].toString().equals("F")&&LocalDate.parse(obj[4].toString()).isBefore(LocalDate.parse(obj[13].toString()))){  %>
															<span class="delay">FD</span>
														<%}else if(obj[9].toString().equals("C")&&(LocalDate.parse(obj[4].toString()).isAfter(LocalDate.parse(obj[13].toString()))||obj[17].equals(obj[13]))){  %>
															<span class="completed">CO</span>
														<%}else if(obj[9].toString().equals("C")&&LocalDate.parse(obj[4].toString()).isBefore(LocalDate.parse(obj[13].toString()))){  %>
														   <span class="completeddelay">CD (<%= ChronoUnit.DAYS.between(LocalDate.parse(obj[4].toString()), LocalDate.parse(obj[13].toString())) %>)</span>
														<%}else if(!obj[15].toString().equals("F")&&obj[9].toString().equals("I")&&(LocalDate.parse(obj[4].toString()).isAfter(LocalDate.now())||LocalDate.parse(obj[4].toString()).isEqual(LocalDate.now()))){  %> 
														<span class="ongoing">OG</span>
														<%}else if(!obj[15].toString().equals("F")&&obj[9].toString().equals("I")&&LocalDate.parse(obj[4].toString()).isBefore(LocalDate.now())){  %> 
														<span class="delay">DO</span>
														<% } else{ %>
														<span class="">-</span>
												
													<%}}else if(obj[9].toString().equals("C")){%>
												        <span class="completed">CO</span>
												      <% }else{ %><span class="notyet">NS</span> 
													<%} %>
												</td>	
												<td >
												<%if(obj[17]!=null){ %>
												<%=obj[17] %>
												<%} %>
												</td>			
											</tr>			
										<%i++;
										}} %>
								</tbody>			
							</table>
	
							<h1 class="break"></h1>		
<!-- -------------------------------------------------------------------------------------------------------------------------------------------------------- -->
						<div align="left" style="margin-left: 10px;"><b class="sub-title">12. Decision/Recommendations sought from <%=committee.getCommitteeShortName().trim().toUpperCase() %> Meeting :</b></div>
							<div align="left" style="margin: 10px;"><%if(lastpmrcdecisions.get(z)!=null && lastpmrcdecisions.get(z)[0]!=null && !lastpmrcdecisions.get(z)[0].toString().trim().equals("")){ %>
								<hr style="margin-right: 10px !important"><br>
							<div style="white-space: pre-wrap;font-weight: 600 !important;font-size:18px !important;padding:15px !important;"><%=lastpmrcdecisions.get(z)[0] %></div>
							<%}else{ %>
							<div align="center">
								Nil 
							</div>
										  	
							<br><br><br>
							<%} %></div>	
						<h1 class="break"></h1>								
<!-- -------------------------------------------------------------------------------------------------------------------------------------------------------- -->
									
					<div align="left" style="margin-left: 10px;"><b class="sub-title"> 
   							<%if(Integer.parseInt(committeeid)==2){ %>
   								13. Other Relevant Points (if any) and Technical Work Carried Out For Last Six Months
							<%}else { %>
								13. Other Relevant Points (if any) and Technical Work Carried Out For Last Three Months
							<%} %>
   						</b></div>
						<table class="subtables" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;  border-collapse:collapse;" >
							<tr>
								 <th  style="width: 80%; ">Other Relevant Points</th>
								 <!-- <th  style="width: 10%; ">Technical Work Carried</th> -->		
							</tr>
										
									<% if(TechWorkDataList.get(z)!=null){ %>
										<tr>
											<td><%=TechWorkDataList.get(z)[2] %></td>
										</tr>
								<%}else{ %>
									<tr><td colspan="2" style="text-align: left ;">Nil </td></tr>
								<%} %>
									
						</table>
						
						<% if(TechImages.size()>0){
							List<TechImages>  TechImagesList= TechImages.get(z); 
							if(TechImagesList.size()>0){%>
						<h1 class="break"></h1>	
						
						<b class="mainsubtitle"> &nbsp;&nbsp;Technical Images</b> 
						
						<%} }%>
					<div>
										
					<br>
					</div>
					
							<% if(TechImages.size()>0){
							List<TechImages>  TechImagesList= TechImages.get(z); 
							if(TechImagesList.size()>0){
							for(TechImages imges:TechImagesList){ %>
							<div>
	
								<table>
									<tr>
										<td style="border:0; padding-left: 1.5rem;"> 
											
											<%if(new File(filePath+projectLabCode+"\\TechImages\\"+imges.getTechImagesId()+"_"+imges.getImageName()).exists()){ %>
											<img style="max-width:25cm;max-height:17cm;margin-bottom: 5px" src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filePath+projectLabCode+"\\TechImages\\"+imges.getTechImagesId()+"_"+imges.getImageName())))%>" > 											
											<%} %>

										</td>
										<td style="border:0;">  
											
										</td>
									</tr>
								</table>
							</div>
							<br>
							<%}}} %>
						
						
<!-- ----------------------------------------------11.Decisions----------------------------------------------------------------- -->


<!-- ------------------------------------------------------------------------------------------------ -->
	
	
<!-- ------------------------------------------------------------------------------------------------ -->
<%} %>
<%-- 
<div style="margin-left: 15px;width: 980px;">
	<p style="text-indent: 50px; ">
		<b>he information in this Document is proprietary of &nbsp;<%=labInfo.getLabCode() %>/DRDO, 
		MOD Government of India. 
		Unauthorized possession/use is violating the Government procedure which may be liable for prosecution.</b>
	</p> 

</div>--%>

<h1 class="break"></h1> 

		<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
		<div align="center" style="text-align: center; vertical-align: middle ;font-size:60px;font-weight: 600;margin: auto; position: relative;color: #145374 !important" >THANK YOU</div>


</body>
</html>


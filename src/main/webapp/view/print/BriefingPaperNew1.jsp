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
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>  

    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<title>Briefing Paper</title>


<%String isprint=(String)request.getAttribute("isprint"); 
List<Object[]> projectattributes = (List<Object[]> )request.getAttribute("projectattributes");
String lablogo=(String)request.getAttribute("lablogo");
LabMaster labInfo=(LabMaster)request.getAttribute("labInfo");
String committeeid=(String)request.getAttribute("committeeid");
String filePath=(String)request.getAttribute("filePath");
List<List<Object[]>> ebandpmrccount = (List<List<Object[]>>)request.getAttribute("ebandpmrccount");
String No2=null;
SimpleDateFormat sdfg=new SimpleDateFormat("yyyy");
if(Long.parseLong(committeeid)==1){ 
No2="P"+(Long.parseLong(ebandpmrccount.get(0).get(0)[1].toString())+1);
}else if(Long.parseLong(committeeid)==2){
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
	          content: "<%if(Long.parseLong(committeeid)==1){ %>
			PMRC #<%=Long.parseLong(ebandpmrccount.get(0).get(0)[1].toString())+1 %>
			<%}else if(Long.parseLong(committeeid)==2){ %>
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
	width:25cm;
	height:17cm;
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
List<List<Object[]>> ReviewMeetingList=(List<List<Object[]>>)request.getAttribute("ReviewMeetingList");
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
AESCryptor cryptor = new AESCryptor();
long ProjectCost = (long)request.getAttribute("ProjectCost");

List<Object[]> MilestoneList=(List<Object[]>)request.getAttribute("MilestoneActivityList");
String levelid= (String) request.getAttribute("levelid");
List<List<Object[]>> MilestoneDetails6 = (List<List<Object[]>>)request.getAttribute("milestonedatalevel6");
String ApplicationFilesDrive= (String) request.getAttribute("ApplicationFilesDrive");

%>


<body>

	<div class="firstpage" id="firstpage"> 

		<div align="center" ><h1 style="color: #145374 !important;font-family: 'Muli'!important">Briefing Paper </h1></div>
		
		<div align="center" ><h2 style="color: #145374 !important">for</h2></div>
		
		<%if ( committeeid != null){ %>
			
			<div align="center" ><h2 style="color: #145374 !important" ><%if(Long.parseLong(committeeid)==1){ %>
			PMRC #<%=Long.parseLong(ebandpmrccount.get(0).get(0)[1].toString())+1 %>
			<%}else if(Long.parseLong(committeeid)==2){ %>
   							EB #<%=Long.parseLong(ebandpmrccount.get(0).get(1)[1].toString())+1 %>
   						<%} %> Meeting <%-- (<%= projectattributes.get(0)[0] %>) --%> </h2></div>
		
			<div align="center" ><h2><%= projectattributes.get(0)[1] %> (<%= projectattributes.get(0)[0] %>)</h2></div>
		
			<%-- <div align="center" ><h2><%if(PfmsInitiation[10]!=null){%> <%=sdf2.format(PfmsInitiation[10])%><%}else{ %>Month Year<%} %></h2></div> --%>
		<%} %>	
		
		<table class="executive" style="align: center;margin-bottom:5px; margin-left: auto;margin-right:auto; max-width: 650px; font-size: 16px;"  >
		<%
		if(labInfo!=null){
		 %>
			<tr>			
				<th colspan="8" style="text-align: center; font-weight: 700;">
				<img class="logo" style="width:120px;height: 120px;margin-bottom: 5px"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> > 

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

<%for(int z=0 ; z<projectidlist.size();z++){ %>
	<%if(z>0){ %><h1 class="break"></h1> <%} %>
	
	<div  id="detailContainer" align="center" >
	
<!-- ------------------------------------heading commented------------------------------------------------- -->	
	
			<%-- <div><h2>Briefing Paper For <%if(Long.parseLong(committeeid)==1){ %>
   							PMRC
   						<%}else if(Long.parseLong(committeeid)==2){ %>
   							EB
   						<%} %> Meeting (<%=projectattributes.get(z)[0] %>)</h2></div> --%>
			
<!-- ------------------------------------project attributes------------------------------------------------- -->
			<div style="margin-left: 10px;" align="left"><b>1. Project Attributes: </b></div>
			<%if(projectattributes.get(z)!=null){ %>
			<table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px; width: 980px;  border-collapse:collapse;" >
										<tr>
											 <td style="width: 20px; padding: 5px; padding-left: 10px">(a)</td>
											 <td  style="width: 150px;padding: 5px; padding-left: 10px"><b>Project Title</b></td>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px"> <%=projectattributes.get(z)[1] %></td>
										</tr>
										<tr>
											 <td  style="width: 20px; padding: 5px; padding-left: 10px">(b)</td>
											 <td  style="width: 150px;padding: 5px; padding-left: 10px"><b>Project No</b></td>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px"> <%=projectattributes.get(z)[0]%> </td>
										</tr>
										<tr>
											 <td  style="width: 20px; padding: 5px; padding-left: 10px">(c)</td>
											 <td  style="width: 150px;padding: 5px; padding-left: 10px"><b>Category</b></td>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px"><%=projectattributes.get(z)[14]%></td>
										</tr>
										<tr>
											 <td  style="width: 20px; padding: 5px; padding-left: 10px">(d)</td>
											 <td  style="width: 150px;padding: 5px; padding-left: 10px"><b>Date of Sanction</b></td>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px"><%=sdf.format(sdf1.parse(projectattributes.get(z)[3].toString()))%></td>
										</tr>
										<tr>
											 <td  style="width: 20px; padding: 5px; padding-left: 10px">(e)</td>
											 <td  style="width: 150px;padding: 5px; padding-left: 10px"><b>Nodal and Participating Labs</b></td>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px"><%if(projectattributes.get(z)[15]!=null){ %><%=projectattributes.get(z)[15]%><%} %></td>
										</tr>
										<tr>
											 <td  style="width: 20px; padding: 5px; padding-left: 10px">(f)</td>
											 <td  style="width: 150px;padding: 5px; padding-left: 10px"><b>Objective</b></td>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px"> <%=projectattributes.get(z)[4]%></td>
										</tr>
										<tr>
											 <td  style="width: 20px; padding: 5px; padding-left: 10px">(g)</td>
											 <td  style="width: 150px;padding: 5px; padding-left: 10px"><b>Deliverables</b></td>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px"> <%=projectattributes.get(z)[5]%></td>
										</tr>
										<tr>
											 <td rowspan="2" style="width: 20px; padding: 5px; padding-left: 10px">(h)</td>
											 <td rowspan="2" style="width: 150px;padding: 5px; padding-left: 10px"><b>PDC</b></td>
											 
											<th colspan="2">Original</th>					
											<%if( ProjectRevList.get(z).size()>0){ %>	
												<th colspan="2">Revised</th>																			
											<%}else{ %>													 
										 		<th colspan="2" ></th>	
										 	<%} %>
										</tr>
								 		<tr>
								 			<%if( ProjectRevList.get(z).size()>0 ){ %>								
										 		<td colspan="2" style="text-align: center;"><%= sdf.format(sdf1.parse(ProjectRevList.get(z).get(0)[12].toString()))%> </td>
										 		<td colspan="2" style="text-align: center;"><%= sdf.format(sdf1.parse(projectattributes.get(z)[6].toString()))%></td>
											<%}else{ %>													 
										 		<td colspan="2" style="text-align: center;"><%= sdf.format(sdf1.parse(projectattributes.get(z)[6].toString()))%></td>
												<td colspan="2" ></td>
										 	<%} %>
										 		    
								 		</tr>
											 	
										<tr>
											<%if( ProjectRevList.get(z).size()>0 ){ %>
												<td rowspan="3" style="width: 20px; padding: 5px; padding-left: 10px">(i)</td>
												<td rowspan="3" style=""><b>Cost Breakup</b>(In Lakhs)</td>
											<%}else{ %>	
												<td rowspan="2" style="width: 20px; padding: 5px; padding-left: 10px">(i)</td>
												<td rowspan="2" style=""><b>Cost Breakup</b>(In Lakhs)</td>
											<%} %>
											<th style="max-width: 10px !important"></th>
											<th >RE Cost</th>
											<th >FE Cost</th>
											<th >Total</th>
										</tr>
										
										<%if( ProjectRevList.get(z).size()>0 ){ %>	
													<tr>	
														<td ><b>Org</b></td>
											 			<td style="text-align: right;"><%=ProjectRevList.get(z).get(0)[11] %></td>
														<td style="text-align: right;"><%=ProjectRevList.get(z).get(0)[11] %></td>
														<td style="text-align: right;"><%=ProjectRevList.get(z).get(0)[11] %></td>
													</tr>
													<tr>			
														<td ><b>Rev</b></td>
											 			<td style="text-align: right;"><%=projectattributes.get(z)[8] %></td>
														<td style="text-align: right;"><%=projectattributes.get(z)[9] %></td>
														<td style="text-align: right;"><%=projectattributes.get(z)[7] %></td>
													</tr>
												<%}else{ %>													 
										 			
													<tr>		
														<td ><b>Org</b></td>					
											 			<td style="text-align: right;"><%=projectattributes.get(z)[8] %></td>
														<td style="text-align: right;"><%=projectattributes.get(z)[9] %></td>
														<td style="text-align: right;"><%=projectattributes.get(z)[7] %></td>
													</tr>
										 		<%} %>
													
																			 	
										<tr>
											<td  style="width: 20px; padding: 5px; padding-left: 10px">(j)</td>
											<td  style="width: 150px;padding: 5px; padding-left: 10px"><b>No. of EBs and PMRCs held</b> </td>
								 			<td colspan="2" ><b>EB :</b> <%=ebandpmrccount.get(z).get(1)[1] %></td>
								 			<td colspan="2"><b>PMRC :</b> <%=ebandpmrccount.get(z).get(0)[1] %></td>
								 			
										</tr>
										<tr>
											<td  style="width: 20px; padding: 5px; padding-left: 10px">(k)</td>
											<td  style="width: 210px;padding: 5px; padding-left: 10px"><b>Current Stage of Project</b></td>
											<td colspan="4" style=" width: 200px;color:white; padding: 5px; padding-left: 10px ; <%if(projectdatadetails.get(z)!=null){ %> background-color: <%=projectdatadetails.get(z)[11] %> ;   <%} %>" >
													 <span> <%if(projectdatadetails.get(z)!=null){ %><b><%=projectdatadetails.get(z)[10] %> </b>  <%}else{ %>Data Not Found<%} %></span>
											</td> 
										</tr>	
			</table>
			<%}else{ %>
				<div align="center"  style="margin: 25px;" > Complete Project Data Not Found </div>
			<%} %>
		</div>
<!-- ------------------------------------project attributes------------------------------------------------- -->
		<h1 class="break"></h1>
<!-- ------------------------------------system configuration and Specification------------------------------------------------- -->	
		<div style="margin-left: 10px;" align="left"><b>2. Schematic Configuration</b></div>
		<div align="left" style="margin-left: 15px;margin-top: 5px;"><b>2 (a) System Configuration : </b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		
			<%if(projectdatadetails.get(z)!=null && projectdatadetails.get(z)[3]!=null){
				if(!FilenameUtils.getExtension(projectdatadetails.get(z)[3].toString()).equalsIgnoreCase("pdf")){
				%>
				<div align="center"><br>
				<img class="logo" style="max-width:1150px;height:100%;margin-bottom: 5px"  src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(ApplicationFilesDrive+projectdatadetails.get(z)[2]+"\\"+projectdatadetails.get(z)[3])))%>" alt="confi" >
				</div> 
			<% }else{
		%>
			<b>  System Configuration Annexure </b>
		<% }}else{ %>
				<b> File Not Found</b>
			<%} %>
			<br>	
	</div>
	<h1 class="break"></h1>
		<div align="left" style="margin-left: 15px;margin-top: 5px;"><b>2 (b) System Specification : </b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<%if(projectdatadetails.get(z)!=null && projectdatadetails.get(z)[4]!=null){
			if(!FilenameUtils.getExtension(projectdatadetails.get(z)[4].toString()).equalsIgnoreCase("pdf")){
			%>
			   <div align="center"><br>
				<img class="logo" style="max-width:1150px;height:100%;margin-bottom: 5px"   src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(ApplicationFilesDrive+projectdatadetails.get(z)[2]+"\\"+projectdatadetails.get(z)[4])))%>" alt="Speci" > --%>
				</div> 
		<% }else{
		%>
			<b> System Specification Annexure </b>
		<% }}else{ %>
			<b>File Not Found</b>
		<%} %>
		<br>
	</div>	
	<h1 class="break"></h1>
<!-- --------------------------------------------- ----------------------------------------------- -->
		<div align="left" style="margin-left: 10px;margin-top: 5px;"><b>3. Overall Product tree/WBS:</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			<%if(projectdatadetails.get(z)!=null && projectdatadetails.get(z)[5]!=null){
				if(!FilenameUtils.getExtension(projectdatadetails.get(z)[5].toString()).equalsIgnoreCase("pdf")){
			%>
			     <div align="center"><br>
				<img class="logo" style="max-width:1150px;height:100%;margin-bottom: 5px"   src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(ApplicationFilesDrive+projectdatadetails.get(z)[2]+"\\"+projectdatadetails.get(z)[5])))%>" alt="Speci" >
				</div> 
		<% }else{
		%>
			<b> Overall Product tree/WBS Annexure </b>
		<% }}else{ %>

			<b> File Not Attached</b>
			
			<%} %>
		</div>	
		
<!-- ------------------------------------system configuration and Specification------------------------------------------------- -->
	
		<h1 class="break"></h1> 
<!-- ----------------------------------------------4.Details of work------------------------------------------------- -->			
		 <div align="center"><p style="font-size: 14px;text-align: center"> <span class="assigned">AA</span> : Activity Assigned &nbsp;&nbsp; <span class="notyet">NS</span> : Not yet Started &nbsp;&nbsp;  <span class="delay">DO</span> : Delay - On Going &nbsp;&nbsp; <span class="completeddelay">CD</span> : Completed with Delay &nbsp;&nbsp; <span class="inactive">IA</span> : InActive </div>
						  <div align="center"><p style="font-size: 14px;text-align: center"> <span class="ongoing">OG</span> : On Going &nbsp;&nbsp; <span class="completed">CO</span> : Completed &nbsp;&nbsp; <span class="notassign">NA</span> : Not Assigned &nbsp;&nbsp; <span class="ongoing">UF</span> : User Forwarded &nbsp;&nbsp; <span class="delay">FD</span> : Forwarded With Delay &nbsp;&nbsp; </div>
		<div align="left" style="margin-left: 10px;"><b>4. Particulars of Meeting.</b></div>
		<div align="left" style="margin-left: 15px;"><b>(a) <%if(Long.parseLong(committeeid)==1){ %>
															   						Approval 
															   						<%}else if(Long.parseLong(committeeid)==2){ %>
															   						Ratification
															   						<%}else if(Long.parseLong(committeeid)==0){ %>
															   						Ratification
															   						<%} %>  of <b>recommendations</b> of last <%if(Long.parseLong(committeeid)==1){ %>
															   						PMRC
															   						<%}else if(Long.parseLong(committeeid)==2){ %>
															   						EB
															   						<%}else if(Long.parseLong(committeeid)==0){ %>
															   						Meeting
															   						<%} %>   (if any)</b></div>
		
		
									<table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px; width: 980px;  border-collapse:collapse;" >
										<tr>
											 <th  style="width: 30px !important;">SN</th>
											 <th  style="max-width: 300px; ">Recommendation Point</th>
											 <th  style="max-width: 70px; "> PDC</th>
											 <th  style="max-width: 130px; "> Responsible agency/ Person</th>
											 <th  style="max-width: 40px; ">Status</th>
											 <th  style="max-width: 100px; ">Remarks</th>
										</tr>
										
										<%if(lastpmrcminsactlist.get(z).size()==0){ %>
										<tr><td colspan="6" style="text-align: center;" > Nil</td></tr>
										<%}
										else if(lastpmrcminsactlist.get(z).size()>0)
										{int i=1;
										for(Object[] obj:lastpmrcminsactlist.get(z)){
												if(obj[3].toString().equalsIgnoreCase("R")){%>
											<tr>
												<td  style="max-width: 30px;text-align: center;"><%=i %></td>
												<td  style="max-width: 300px; "><%=obj[2] %></td>
												<td  style="max-width: 70px; text-align: center;">
													<%if(obj[4]!= null){ %><%=sdf.format(sdf1.parse(obj[6+Integer.parseInt(obj[9].toString())].toString()	) )%><%}else{ %> <%} %>
												</td>
												<td  style="max-width: 130px; ">
													<%if(obj[4]!= null){ %>  
														<%=obj[12] %>, <%=obj[13] %>
													<%}else { %> <span class="notassign">NA</span> <%} %> 
												</td>
												<td  style="max-width: 100px;text-align: center; ">
													<%if(obj[4]!= null){if(obj[18]!=null){ %>
												<%if(obj[10].toString().equals("I")&&obj[16].toString().equals("F")&&(sdf.parse(obj[17].toString()).after(sdf.parse(obj[14].toString()))||obj[17].equals(obj[14]) )){ %>
													<span class="ongoing">UF</span>
												<%}else if(obj[10].toString().equals("I")&&obj[16].toString().equals("F")&&sdf.parse(obj[17].toString()).before(sdf.parse(obj[14].toString()))){  %>
													<span class="delay">FD</span>
												<%}else if(obj[10].toString().equals("C")&&(sdf.parse(obj[17].toString()).after(sdf.parse(obj[14].toString()))||obj[17].equals(obj[14]))){  %>
													<span class="completed">CO</span>
												<%}else if(obj[10].toString().equals("C")&&sdf.parse(obj[17].toString()).before(sdf.parse(obj[14].toString()))){  %>
												   <span class="completeddelay">CD</span>
												<%}else if(!obj[16].toString().equals("F")&&obj[10].toString().equals("I")&&(sdf.parse(obj[17].toString()).after(sdf.parse(obj[14].toString()))||obj[17].equals(obj[14]))){  %> 
												<span class="ongoing">OG</span>
												<%}else if(!obj[16].toString().equals("F")&&obj[10].toString().equals("I")&&sdf.parse(obj[17].toString()).before(sdf.parse(obj[14].toString()))){  %> 
												<span class="delay">DO</span>
												<%}else{ %>
												<span class="ongoing">OG</span>
												
												<%}}else if(obj[10].toString().equals("C")){%>
											        <span class="completed">CO</span>
											      <% }else{ %><span class="notyet">NS</span> 
												<%}}else { %> <span class="notassign">NA</span> <%} %> 
												</td>
												<td ><%if(obj[19]!=null){%><%=obj[19] %><%} %></td>
											</tr>		
										<%i++;}
										}%>
										<%if(i==1){ %> <tr><td colspan="6" style="text-align: center;" > Nil</td></tr>	<%} %>
										
										<%} %>
											
									</table>
									
						<%if((Double.parseDouble(projectattributes.get(0)[7].toString())*100000)>1){ %>		
						<h1 class="break"></h1>
						 	<div align="left" style="margin-left: 15px;"><b>(b) Last <%if(Long.parseLong(committeeid)==1){ %>
															   						PMRC / EB
															   						<%}else if(Long.parseLong(committeeid)==2){ %>
															   						EB
															   						<%}else if(Long.parseLong(committeeid)==0){ %>
															   						Meeting
															   						<%} %>  action points with Expected Date of completion (EDC)  and current status.</b>
   							</div>
							<table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px; width: 980px;  border-collapse:collapse;" >
										<tr>
									 		<th  style="width: 30px !important;  ">SN</th>
											 <th  style="max-width: 250px; ">Action Point</th>
											 <th  style="max-width: 60px; "> Expected Date of Completion (EDC)</th>
											 <th  style="max-width: 60px; "> Actual Date of Completion</th>
											 <th  style="max-width: 100px; "> Responsible agency/ Person</th>
											 <th  style="max-width: 40px; ">Status</th>
											 <th  style="max-width: 100px; ">Remarks</th>			
										</tr>
										
										<%if(lastpmrcactions.get(z).size()==0){ %>
										<tr><td colspan="7"  style="text-align: center;" > Nil</td></tr>
										<%}
										else if(lastpmrcactions.size()>0)
										  {int i=1;
										for(Object[] obj:lastpmrcactions.get(z)){ %>
											<tr>
												<td  style="max-width: 30px;text-align: center;"><%=i %></td>
												<td  style="max-width: 250px;text-align: justify ;"><%=obj[2] %></td>
												<td  style="max-width: 60px;text-align: center;" ><%= sdf.format(sdf1.parse(obj[3].toString()))%></td>
												<td  style="max-width: 60px;text-align: center;text-align: center;"> 
												<%if(obj[9].toString().equals("C")  && obj[13]!=null){ %>
												
												<%= sdf.format(sdf1.parse(obj[13].toString()))%> 
												<%}else{ %>-<%} %></td>
												<td  style="max-width: 140px;"> <%=obj[11] %>, <%=obj[12] %> </td>
												<td  style="max-width: 100px;text-align: center;"> 
												<%if(obj[15]!=null){ %>
												<%if(obj[9].toString().equals("I")&&obj[14].toString().equals("F")&&(sdf.parse(obj[4].toString()).after(sdf.parse(obj[13].toString()))||obj[4].equals(obj[13]) )){ %>
													<span class="ongoing">UF</span>
												<%}else if(obj[9].toString().equals("I")&&obj[14].toString().equals("F")&&sdf.parse(obj[4].toString()).before(sdf.parse(obj[13].toString()))){  %>
													<span class="delay">FD</span>
												<%}else if(obj[9].toString().equals("C")&&(sdf.parse(obj[4].toString()).after(sdf.parse(obj[13].toString()))||obj[4].equals(obj[13]))){  %>
													<span class="completed">CO</span>
												<%}else if(obj[9].toString().equals("C")&&sdf.parse(obj[4].toString()).before(sdf.parse(obj[13].toString()))){  %>
												   <span class="completeddelay">CD</span>
												<%}else if(!obj[14].toString().equals("F")&&obj[9].toString().equals("I")&&(sdf.parse(obj[4].toString()).after(sdf.parse(obj[13].toString()))||obj[4].equals(obj[13]))){  %> 
												<span class="ongoing">OG</span>
												<%}else if(!obj[14].toString().equals("F")&&obj[9].toString().equals("I")&&sdf.parse(obj[4].toString()).before(sdf.parse(obj[13].toString()))){  %> 
												<span class="delay">DO</span>
												<%}else{ %>
												<span class="ongoing">OG</span>
												
												<%}}else if(obj[9].toString().equals("C")){%>
											        <span class="completed">CO</span>
											      <% }else{ %><span class="notyet">NS</span> 
												<%} %> 
												</td>	
												<td  style="max-width: 100px;"><%if(obj[16]!=null){%><%=obj[16] %><%} %></td>			
											</tr>			
										<%i++;
										}} %>
									</table> 
								<%} %>
								<h1 class="break"></h1>
						<div align="left" style="margin-left: 15px;"><b>(c) Details of Technical/ User Reviews (if any).</b></div>
						
						<table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px; width: 980px;  border-collapse:collapse;" >
										<tr>
											 <th  style="width: 30px !important;  ">SN</th>
											 <th  style="max-width: 70px; ">Committee</th>
											 <th  style="max-width: 200px; "> MeetingId</th>
											 <th  style="max-width: 80px; "> Date Held</th>
										</tr>
										<tr><td colspan="4" style="text-align: center;" > Nil</td></tr>
										<%-- <%if(ReviewMeetingList.get(z).size()==0){ %>
										<tr><td colspan="6" style="text-align: center;" > Nil</td></tr>
										<%}
										else if(ReviewMeetingList.size()>0)
										  {int i=1;
										for(Object[] obj:ReviewMeetingList.get(z)){ %>
											<tr>
												<td  style="max-width: 30px;text-align: center;"><%=i %></td>
												<td  style="max-width: 70px;"><%=obj[1] %></td>												
												<td  style="max-width: 200px;" ><%= obj[4]%></td>
												<td  style="max-width: 80px;" ><%= sdf.format(sdf1.parse(obj[3].toString()))%></td>
											</tr>			
										<%i++;
										}} %> --%>
									</table>


				 <h1 class="break"></h1>
<!-- -------------------------------------------------------------------------------------------- -->
		<div align="left" style="margin-left: 10px;"><b>5. Milestones achieved prior to this  
						<%if(Long.parseLong(committeeid)==1){ %>
   						PMRC
   						<%}else if(Long.parseLong(committeeid)==2){ %>
   						EB
   						<%}else if(Long.parseLong(committeeid)==0){ %>
   						Meeting
   						<%} %>  period.  </b></div>
   						
			
			<table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px; width: 980px;  border-collapse:collapse;" >
									<tr>
										<th  style="width: 30px !important; ">SN</th> 
										<th  style="max-width: 30px; ">MS</th>
										<th  style="max-width: 230px; ">Milestones </th>
										<th  style="max-width: 80px; "> Original PDC </th>
										<th  style="max-width: 80px; "> Revised PDC</th>
										<th  style="max-width: 50px; ">Progress</th>
										<th  style="max-width: 70px; "> Status</th>
										<th  style="max-width: 70px; "> Remarks</th>
									</tr>
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
											<td  style="max-width: 30px;text-align: center; "><%=i%></td> 
											<td  style="max-width: 60px;text-align: center;">M<%=obj[2]%></td>
											<td  style="max-width: 230px;"><%=obj[3] %></td>
											<td  style="max-width: 80px;text-align: center;" ><%= sdf.format(sdf1.parse(obj[5].toString()))%> </td>
											<td  style="max-width: 80px;text-align: center;"> <%= sdf.format(sdf1.parse(obj[7].toString()))%></td>
											<td  style="max-width: 50px;text-align: center;"><%=obj[12] %>%	</td>
											<td  style="max-width: 70px;text-align: center;">
												<span class="<%if(obj[10].toString().equalsIgnoreCase("0")){%>assigned
														<%}else if(obj[10].toString().equalsIgnoreCase("1")) {%> notyet
														<%}else if(obj[10].toString().equalsIgnoreCase("2")) {%> ongoing
														<%}else if(obj[10].toString().equalsIgnoreCase("3")) {%> completed
														<%}else if(obj[10].toString().equalsIgnoreCase("4")) {%> delay 
														<%}else if(obj[10].toString().equalsIgnoreCase("5")) {%> completeddelay
														<%}else if(obj[10].toString().equalsIgnoreCase("6")) {%> inactive<%} %>	 " >
												<%=obj[11] %>	
											</span>
												</td>
											<td  style="max-width: 70px;"><%if(obj[13]!=null){%><%=obj[13] %><%} %></td>
										</tr>			
									<% i++;
											}	
										}%>
										
									
									<%if(i==1){ %> <tr><td colspan="8" style="text-align: center;" >Nil</td></tr>	<%} %>	
										
									<%} %>
									
								</table>
			
						 <h1 class="break"></h1>
<!-- ------------------------------------------------------------------------------------------------------------ -->

		<div align="left" style="margin-left: 10px;"><b>6. Details of work and current status of sub system with major milestones (since last <%if(Long.parseLong(committeeid)==1){ %>
															   						PMRC
															   						<%}else if(Long.parseLong(committeeid)==2){ %>
															   						EB
															   						<%}else if(Long.parseLong(committeeid)==0){ %>
															   						Meeting
															   						<%} %>) period </b></div> 
						
			
						<div align="left" style="margin-left: 15px;"><b>(a) Work carried out, Achievements, test result etc.</b></div>
						
						<!-- Tharun code Start (For Filtering Milestone based on levels) -->					

												<table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px; width:980px;   border-collapse:collapse;" >
								<tr>
									<th  style="max-width: 100px; ">MS</th>
									<th  style="max-width: 100px;width:40px ">L</th>
									<th  style="max-width: 300px;min-width:250px ">System/ Subsystem/ Activities</th>
									<th  style="max-width: 110px;width:100px "> Original PDC</th>
									<th  style="max-width: 150px;width:135px "> Revised PDC/impact on overall project</th>
									<th  style="max-width: 100px; "> Progress</th>
									<th  style="max-width: 70px; "> Present Status</th>
								 	<th  style="max-width: 100px; "> Remarks</th>
								</tr>
								<% if( MilestoneDetails6.get(z).size()>0){ 
									long count1=1;
									int milcountA=1;
									int milcountB=1;
									int milcountC=1;
									int milcountD=1;
									int milcountE=1;
									%>
									<%for(Object[] obj:MilestoneDetails6.get(z)){
										
										if(Integer.parseInt(obj[21].toString())<= Integer.parseInt(levelid) ){
										%>
										<tr>
											<td style="text-align:center">M<%=obj[0] %></td>
											<%-- <td style="text-align:center">
												<%if(obj[21].toString().equals("0")) {%>
													L
												<%}else if(obj[21].toString().equals("1")) { %>
													A-<%=obj[21] %>
												<%}else if(obj[21].toString().equals("2")) { %>
													B-<%=obj[21] %>
												<%}else if(obj[21].toString().equals("3")) { %>
													C-<%=obj[21] %>
												<%}else if(obj[21].toString().equals("4")) { %>
													D-<%=obj[21] %>
												<%}else if(obj[21].toString().equals("5")) { %>
													E-<%=obj[21] %>
												<%} %>
											</td> --%>
											<td style="text-align: center">
												<%
												
												if(obj[21].toString().equals("0")) {%>
													L
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
	
											<td style="<%if(obj[21].toString().equals("0")) {%>font-weight: bold;<%}%>">
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
											<td><%=sdf.format(sdf1.parse(obj[9].toString())) %></td>
											<td><%=sdf.format(sdf1.parse(obj[8].toString())) %></td>
											<td style="text-align:center"><%=obj[17] %>%</td>											
											<td style="text-align:center">
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
											<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;"><%if(obj[23]!=null){%><%=obj[23]%><%} %></td>
                                            
										</tr>
									<%count1++;}} %>
								<%} else{ %>
								<tr><td colspan="9" style="text-align:center; "> Nil</td></tr>
								
								
								<%} %>
							</table>
												
	
		<!-- Tharun code end -->
						
						
						<%-- <table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px; width: 980px;  border-collapse:collapse;" >
									<tr>
										 <th  style="width: 30px !important; ">SN</th>
										 <th  style="max-width: 100px; ">MS</th>
										 <th  style="max-width: 100px; ">L1</th>
										 <th  style="max-width: 200px; ">System/ Subsystem/ Activities</th>
										 <th  style="max-width: 110px; "> Original PDC</th>
										 <th  style="max-width: 110px; "> Revised PDC/impact on overall project</th>
										 <th  style="max-width: 40px; "> Progress</th>
										 <th  style="max-width: 30px; "> Status</th>
										 <th  style="max-width: 150px; "> Remarks</th>
									</tr>
									
									<%if(milestonesubsystems.get(z).size()==0){ %>
										<tr><td colspan="8" style="text-align: center;"> Nil</td></tr>
									<%}else if(milestonesubsystems.get(z).size()>0)
									  {int i=1;
									  int levelcount=0;
									  String leveltemp=null;
										for(Object[] obj:milestonesubsystems.get(z)){
											if(Integer.parseInt(obj[7].toString())>0){
												if(levelcount==0){		
													leveltemp=obj[8].toString();
												    }
												    if(leveltemp.equals(obj[8].toString())){
												    	levelcount++;
												    }else{
												    	leveltemp=obj[8].toString();
												    	levelcount=1;
												    }
											%>
										<tr>
											<td style=";text-align: center;"><%=i%></td>
											<td style="text-align: center;"> M<%=obj[8]%>  L1.<%=levelcount%></td>
											<td style="text-align: center;"> M<%=obj[8]%></td>
											<td style="text-align: center;"> <%=levelcount%></td>
											<td ><%=obj[2] %> </td>											
											<td style="text-align: center;"> <%= sdf.format(sdf1.parse(obj[3].toString()))%> </td>
											<td style="text-align: center;"><%= sdf.format(sdf1.parse(obj[4].toString()))%></td>
											<td style="text-align: center;"><%=obj[7] %> %</td>
											<td style="text-align: center;">
											<span class="<%if(obj[5].toString().equalsIgnoreCase("0")){%>assigned
														<%}else if(obj[5].toString().equalsIgnoreCase("1")) {%> notyet
														<%}else if(obj[5].toString().equalsIgnoreCase("2")) {%> ongoing
														<%}else if(obj[5].toString().equalsIgnoreCase("3")) {%> completed
														<%}else if(obj[5].toString().equalsIgnoreCase("4")) {%> delay 
														<%}else if(obj[5].toString().equalsIgnoreCase("5")) {%> completeddelay
														<%}else if(obj[5].toString().equalsIgnoreCase("6")) {%> inactive<%} %>	 " >
												<%=obj[6] %>	
											</span>
											
											</td>
											<td ><%if(obj[9]!=null){%><%=obj[9] %><%} %></td>
										</tr>
									<%i++;}}
										if(i==1){ %>
									<tr style="max-width: 150px; "><td colspan="8" style="text-align: center;">Nil</td></tr>
								<%} %>
								<%} %>
						</table> --%>
						
						<h1 class="break"></h1>
						 <div align="left" style="margin-left: 15px;"><b>(b) TRL table with TRL at sanction stage and current stage indicating overall PRI.</b></div>
							<div>
								<%if(projectdatadetails.get(z)!=null && projectdatadetails.get(z)[6]!=null){
			                      if(!FilenameUtils.getExtension(projectdatadetails.get(z)[6].toString()).equalsIgnoreCase("pdf")){
			                      %>
			                      <div align="center"><br>
				                  <img class="logo" style="max-width:1150px;height:100%;margin-bottom: 5px;margin-left: 10px;"   src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(ApplicationFilesDrive+projectdatadetails.get(z)[2]+"\\"+projectdatadetails.get(z)[6])))%>" alt="Speci" >
				                  </div> 
		                       <% }else{
		                                  %>
			                        <b> TRL table with TRL at sanction stage Annexure </b>
		                       <% }}else{ %>
								<b> <br> &nbsp;&nbsp;&nbsp; File Not Attached</b>
								
								<%} %>
						</div>
											
						
						
						<h1 class="break"></h1>
			<div align="left" style="margin-left: 15px;"><b>(c) Risk Matrix/Management Plan/Status. </b></div>
		<table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px; width: 980px;  border-collapse:collapse;" >
			
			<tr>
				 <th  style="max-width: 40px;  ">Risk Id</th>
				 <th  style="max-width: 250px; ">Description</th>
				 <th  style="max-width: 80px; "> Severity</th>
				 <th  style="max-width: 100px; "> Probability</th>
				 <th  style="max-width: 200px; "> Mitigation Plans</th>
				 
			</tr>
				<%if(riskmatirxdata.get(z).size()>0){
				int i=0;%> 
					<%for(Object[] obj : riskmatirxdata.get(z)){
					i++;%>
					<tr>
						<td  style="max-width: 40px;text-align: center"><%=i %></td>
						<td  style="max-width: 250px;"><%=obj[0] %></td>
						<td  style="max-width: 80px;" ><%=obj[1] %></td>
						<td  style="max-width: 100px;"><%=obj[2] %></td>
						<td  style="max-width: 200px;"><%=obj[3] %></td>										
					</tr>			
					<%}%>
				<%}else{%>
					<tr><td colspan="5"  style="text-align: center;">Nil </td></tr>
				<%} %>		
		</table> 

<!-- ----------------------------------------------5.Particulars of Meeting------------------------------------------------- -->
 <h1 class="break"></h1>
<!-- ----------------------------------------------6. Procurement Status------------------------------------------------- -->
			<div align="left" style="margin-left: 10px;"><b>7. Details of Procurement plan (Major Items): </b></div>
									<table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px; width: 980px;  border-collapse:collapse;" >
										<thead>
										<tr>
											 	<th colspan="8" >Demand Details</th>
											 </tr>
										</thead>
										
										<tr>
											<th  style="width: 30px !important;">SN</th>
											<th  style="max-width: 90px;">Demand No</th>
											<th  style="max-width: 90px; ">Demand Date</th>
											<th  colspan="2" style="max-width: 150px;"> Nomenclature</th>
											<th  style="max-width: 90px;"> Est. Cost-Lakh &#8377;</th>
											<th  style="max-width: 80px; "> Status</th>
											<th  style="max-width: 200px;">Remarks</th>
										</tr>
										    <% int k=0;
										    if(procurementOnDemand.get(z)!=null &&  procurementOnDemand.get(z).size()>0){
										    Double estcost=0.0;
										    Double socost=0.0;
										    for(Object[] obj : procurementOnDemand.get(z)){ 
										    	k++; %>
											<tr>
												<td ><%=k%></td>
												<td ><%=obj[1]%></td>
												<td  ><%=sdf.format(sdf1.parse(obj[3].toString()))%></td>
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
									<!-- </table>
									<div align="left" style="margin-left: 25px;"></div>
					 				<table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px; width: 980px;  border-collapse:collapse;" >
										<thead> -->
										<thead>
											 <tr >
												 <th colspan="8">Order Placed</th>
											 </tr>
										 </thead>
										<!-- </thead> -->
										
										  	 <tr>	
										  	 	 <th  style="width: 30px !important;">SN</th>
										  	 	 <th >Demand No </th>
										  	 	  <th >Demand  Date</th>
												 <th  colspan="2"> Nomenclature</th>
												 <th  > Est. Cost-Lakh &#8377;</th>
												 <th  style="max-width: 80px; "> Status</th>
												 <th  style="max-width: 200px;">Remarks</th>
												</tr>
											<tr>
												
												 <th  colspan="2" style="max-width: 150px;">Supply Order No</th>
												 <th  style="max-width: 90px;	">DP Date</th>
												 <th  colspan="2" style="max-width: 90px;	">Vendor Name</th>
												 <th  style="max-width: 80px;">Rev DP Date</th>											 
												 <th   colspan="2" style="max-width: 90px;">SO Cost-Lakh &#8377;</th>		
											 		
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
												<td ><%=k%></td>
												<td ><%=obj[1]%> </td>
												<td ><%=sdf.format(sdf1.parse(obj[3].toString()))%></td>
													<td   colspan="2"><%=obj[8]%></td>
													<td  style=" text-align:right;"> <%=format.format(new BigDecimal(obj[5].toString())).substring(1)%></td>
												    <td  > <%=obj[10]%> </td>
													<td  ><%=obj[11]%> </td>	
												</tr>
												<%demand=obj[1].toString();
												} %>
												<tr>
													
													<td  colspan="2"><% if(obj[2]!=null){%> <%=obj[2]%> <%}else{ %>-<%} %>
													</td>
													<td  ><%if(obj[4]!=null){%> <%=sdf.format(sdf1.parse(obj[4].toString()))%> <%}else{ %> - <%} %></td>
													<td  colspan="2"> <%=obj[12] %>
													</td>
													<td  ><%if(obj[7]!=null){%> <%=sdf.format(sdf1.parse(obj[7].toString()))%><%}else{ %>-<%} %></td>
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
               
<!-- ----------------------------------------------6. Procurement Status------------------------------------------------- -->
 <h1 class="break"></h1>
<!-- ----------------------------------------------7. Overall financial Status------------------------------------------------- -->

		 
   					<div align="left" style="margin-left: 10px;"><b>8. Overall Financial Status </b></div><div align="right"><b><i><span style="text-decoration: underline;">(In &#8377; Crore)</span></i></b></div>
						 
						  	<table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px; width: 980px;  border-collapse:collapse;" >
						  	    <thead>
		                           <tr>
		                         	<td colspan="2" style="text-align: center ;width:200px !important;"><b>Head</b></td>
		                         	<td colspan="2" style="text-align: center;"><b>Sanction</b></td>
			                        <td colspan="2" style="text-align: center;"><b>Expenditure</b></td>
			                        <td colspan="2" style="text-align: center;"><b>Out Commitment</b> </td>
		                           	<td colspan="2" style="text-align: center;"><b>Balance</b></td>
			                        <td colspan="2" style="text-align: center;"><b>DIPL</b></td>
		                          	<td colspan="2" style="text-align: center;"><b>Notional Balance</b></td>
			                      </tr>
			                      <tr>
				                    <th style="width:30px !important;" >SN</th>
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
		<div align="left" style="margin-left: 10px;"><b>9. Action Plan for Next six months - Technical Milestones with financial outlay : </b></div>
		
			<!-- Tharun code after Level -->
		
				<table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px; width: 980px;  border-collapse:collapse;" >
								<tr>
									<th style="width: 30px !important;">SN</th>
									<th style="width: 30px; ">MS</th>
									<th style="width: 40px; ">L</th>
									<th style="max-width: 220px;">Action Plan </th>	
									<th style="max-width: 80px;">Responsible Agency/ Person </th>
									<th style="max-width: 85px;">PDC</th>	
									<th style="max-width: 60px;">Progress </th>
					                <th style="max-width: 50px;">Status</th>
					                 <th style="max-width: 80px;">Remarks</th>
								</tr>
								<%if(actionplanthreemonths.get(z).size()>0){ 
									long count1=1;
									int countA=1;
									int countB=1;
									int countC=1;
									int countD=1;
									int countE=1;
									%>
									<%for(Object[] obj:actionplanthreemonths.get(z)){
										
										if(Integer.parseInt(obj[26].toString())<= Integer.parseInt(levelid) ){
										/*  if(obj[26].toString().equals("0")||obj[26].toString().equals("1")){ */
										%>
										<tr>
											<td style="text-align: center"><%=count1 %></td>
											<%-- <td>M <%=obj[22] %> <% if(!obj[26].toString().equals("0")) {%> L<%=obj[26] %> <%} %></td> --%>
											<td style="text-align: center">M<%=obj[22] %></td>
											
											<!-- Old Code -->
											<%-- <td><% if(!obj[26].toString().equals("0")) {%> L<%=obj[26] %> <%} else {%> L <%} %></td>
											<td>
												<%if(!obj[10].toString().trim().equals("")){ %>
													<%=obj[10] %>
												<%}else if(!obj[9].toString().trim().equals("")){ %>
													<%=obj[9] %>
												<%}else if(!obj[8].toString().trim().equals("")){ %>
													<%=obj[8] %>
												<%}else if(!obj[7].toString().trim().equals("")){ %>
													<%=obj[7] %>
												<%} %>
											</td> --%>
											
											<!-- New Code (tharun)-->
											
											<td style="text-align: center">
												<%
												
												if(obj[26].toString().equals("0")) {%>
													L
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
											
											<td style="<%if(obj[26].toString().equals("0")) {%>font-weight: bold;<%}%>">
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
											<td><%=obj[24] %>(<%=obj[25] %>)</td>
											<td><%=sdf.format(sdf1.parse(obj[8].toString())) %></td>
											<td style="text-align: center"><%=obj[16] %>%</td>											
											<td style="text-align: center">
											<span class="<%if(obj[20].toString().equalsIgnoreCase("0")){%>assigned
														<%}else if(obj[20].toString().equalsIgnoreCase("1")) {%> notyet
														<%}else if(obj[20].toString().equalsIgnoreCase("2")) {%> ongoing
														<%}else if(obj[20].toString().equalsIgnoreCase("3")) {%> completed
														<%}else if(obj[20].toString().equalsIgnoreCase("4")) {%> delay 
														<%}else if(obj[20].toString().equalsIgnoreCase("5")) {%> completeddelay
														<%}else if(obj[20].toString().equalsIgnoreCase("6")) {%> inactive<%} %>	 " >
												<%=obj[27] %>	
											</span>
											
											</td>
											<td  style="max-width: 80px;">
												<%if(obj[28]!=null){ %>
												<%=obj[28] %>
												<%} %>
												</td>
										</tr>
									<%count1++;}} %>
								<%} else{ %>
								<tr><td colspan="9" style="text-align:center; "> Nil</td></tr>
								
								
								<%} %>
							</table>
		
		
			<%-- <table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px; width: 980px;  border-collapse:collapse;" >
				<tr>
					<th style="width: 30px !important;">SN</th>
					<th style="max-width: 50px; ">MS</th>
					<th style="max-width: 50px; ">L</th>
					<th style="max-width: 200px;">Action Plan </th>	
					<th style="max-width: 80px;">Responsible Agency/ Person </th>
					<th style="max-width: 85px;">PDC</th>	
					<th style="max-width: 60px;">Progress </th>
					<th style="max-width: 40px;">Status</th>
					<th style="max-width: 150px;">Remarks</th>	
				</tr>
				<%if(actionplanthreemonths.get(z).size()>0){ 
									long count1=1;%>
									<%for(Object[] obj:actionplanthreemonths.get(z)){ 
									 if(obj[26].toString().equals("0")||obj[26].toString().equals("1")){
									%>
										<tr>
											<td style="text-align: center;"><%=count1 %></td>
											<td style="text-align: center;">M <%=obj[22] %> <% if(!obj[26].toString().equals("0")) {%> L<%=obj[26] %> <%} %></td>
											<td style="text-align: center;">M <%=obj[22] %></td>
											<td style="text-align: center;"><% if(!obj[26].toString().equals("0")) {%> L<%=obj[26] %> <%}else{ %> L <%} %></td>
											
											<td>
												<%if(!obj[10].toString().trim().equals("")){ %>
													<%=obj[10] %>
												<%}else if(!obj[9].toString().trim().equals("")){ %>
													<%=obj[9] %>
												<%}else if(!obj[8].toString().trim().equals("")){ %>
													<%=obj[8] %>
												<%}else if(!obj[7].toString().trim().equals("")){ %>
													<%=obj[7] %>
												<%} %>
											</td>
											<td><%=obj[24] %>(<%=obj[25] %>)</td>
											<td style="text-align: center;"><%=sdf.format(sdf1.parse(obj[8].toString())) %></td>
											<td style="text-align: center;"><%=obj[16] %>%</td>											
											<td style="text-align: center;">
											<span class="<%if(obj[20].toString().equalsIgnoreCase("0")){%>assigned
														<%}else if(obj[20].toString().equalsIgnoreCase("1")) {%> notyet
														<%}else if(obj[20].toString().equalsIgnoreCase("2")) {%> ongoing
														<%}else if(obj[20].toString().equalsIgnoreCase("3")) {%> completed
														<%}else if(obj[20].toString().equalsIgnoreCase("4")) {%> delay 
														<%}else if(obj[20].toString().equalsIgnoreCase("5")) {%> completeddelay
														<%}else if(obj[20].toString().equalsIgnoreCase("6")) {%> inactive<%} %>	 " >
												<%=obj[27] %>	
											</span>
											
											</td>
											<td  style="max-width: 150px;">
												<%if(obj[28]!=null){ %>
												<%=obj[28] %>
												<%} %>
												</td>
										</tr>
									<%count1++;}} %>
								<%}else{ %>
								<tr><td colspan="7" style="text-align:center; "> Nil</td></tr>
								
								
								<%} %>
			</table> --%>
			<h1 class="break"></h1>
<!-- ----------------------------------------------8. Action plan for next three months------------------------------------------------- -->
<!-- ----------------------------------------------9.GANTT chart---------------------------------------------------------- -->
			<div align="left" style="margin-left: 15px;">
				<b>10. PERT/GANTT chart of overall project schedule [<span style="text-decoration: underline;">Original</span> (as per Project sanction / Latest PDC extension) and <span style="text-decoration: underline;">Current</span>]: </b></div>
              <%
              if(new File(filePath+"\\grantt\\grantt_"+projectidlist.get(z)+"_"+No2+".jpg").exists()){
				%>
					
				<div align="center"><br>
				<img class="logo" style="max-width:950px;height:100%;margin-bottom: 5px"   src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(filePath+"\\grantt\\grantt_"+projectidlist.get(z)+"_"+No2+".jpg")))%>" alt="confi" > 
				</div> 
              <%}
              else if(new File(filePath+"\\grantt\\grantt_"+projectidlist.get(z)+"_"+No2+".pdf").exists()){
				
				%>
				<b>Grantt Chart Annexure</b>
		    <% }else{ %>
				<b> File Not Found</b>
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
					<br><br><br><br><br><br>
				<%} %>
						    	
			</div>	
			<h1 class="break"></h1>
<!-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- -->
			<div align="left" style="margin-left: 10px;"><b>11. Issues:</b></div>
			<table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px; width: 980px;  border-collapse:collapse;" >
										<tr>
											 <th  style="width: 30px !important;  ">SN</th>
											 <th  style="max-width: 240px; ">Issue Point</th>
											 <th  style="max-width: 60px; "> PDC</th>
											 <th  style="max-width: 80px; "> Actual Date of Completion</th>
											 <th  style="max-width: 100px; "> Responsible agency/ Person</th>
											 <th  style="max-width: 30px; ">Status</th>	
											 <th  style="max-width: 80px; ">Remarks</th>		
										</tr>
										
										<%if(oldpmrcissueslist.get(z).size()==0){ %>
										<tr><td colspan="7" style="text-align: center;" > Nil</td></tr>
										<%}
										else if(oldpmrcissueslist.get(z).size()>0)
										  {int i=1;
										for(Object[] obj:oldpmrcissueslist.get(z)){ %>
											<tr>
												<td  style="max-width: 30px;text-align: center;"><%=i %></td>
												<td  style="max-width: 250px;"><%=obj[2] %></td>
												<td  style="max-width: 60px;text-align: center;" ><%= sdf.format(sdf1.parse(obj[3].toString()))%></td>
												<td  style="max-width: 80px;text-align: center;"> 
												<%if(obj[9].toString().equals("C")){ %>
												
												<%= sdf.format(sdf1.parse(obj[13].toString()))%> 
												<%}else{ %>-<%} %></td>
												<td  style="max-width: 100px;"> <%=obj[11] %>, <%=obj[12] %></td>
												<td  style="max-width: 20px;text-align: center;"> 
													<%if(obj[16]!=null){ %>
												<%if(obj[9].toString().equals("I")&&obj[15].toString().equals("F")&&(sdf.parse(obj[4].toString()).after(sdf.parse(obj[13].toString()))||obj[4].equals(obj[13]) )){ %>
													<span class="ongoing">UF</span>
												<%}else if(obj[9].toString().equals("I")&&obj[15].toString().equals("F")&&sdf.parse(obj[4].toString()).before(sdf.parse(obj[13].toString()))){  %>
													<span class="delay">FD</span>
												<%}else if(obj[9].toString().equals("C")&&(sdf.parse(obj[4].toString()).after(sdf.parse(obj[13].toString()))||obj[17].equals(obj[13]))){  %>
													<span class="completed">CO</span>
												<%}else if(obj[9].toString().equals("C")&&sdf.parse(obj[4].toString()).before(sdf.parse(obj[13].toString()))){  %>
												   <span class="completeddelay">CD</span>
												<%}else if(!obj[15].toString().equals("F")&&obj[9].toString().equals("I")&&(sdf.parse(obj[4].toString()).after(sdf.parse(obj[13].toString()))||obj[4].equals(obj[13]))){  %> 
												<span class="ongoing">OG</span>
												<%}else if(!obj[15].toString().equals("F")&&obj[9].toString().equals("I")&&sdf.parse(obj[4].toString()).before(sdf.parse(obj[13].toString()))){  %> 
												<span class="delay">DO</span>
												<%}else{ %>
												<span class="ongoing">OG</span>
												
												<%}}else if(obj[9].toString().equals("C")){%>
											        <span class="completed">CO</span>
											      <% }else{ %><span class="notyet">NS</span> 
												<%} %>
												</td>	
												<td  style="max-width: 80px;">
												<%if(obj[17]!=null){ %>
												<%=obj[17] %>
												<%} %>
												</td>			
											</tr>			
										<%i++;
										}} %>
									</table>

							<h1 class="break"></h1>		
<!-- -------------------------------------------------------------------------------------------------------------------------------------------------------- -->
						<div align="left" style="margin-left: 10px;"><b>12. Decision/Recommendations sought from <%if(Long.parseLong(committeeid)==1){ %>
						 						PMRC
						   						<%}else if(Long.parseLong(committeeid)==2){ %>
						   						EB
						   						<%}else if(Long.parseLong(committeeid)==0){ %>
						   						Meeting
						   						<%} %>:</b></div>
									<div align="center"><%if(lastpmrcdecisions.get(z)!=null && lastpmrcdecisions.get(z)[0]!=null && !lastpmrcdecisions.get(z)[0].toString().trim().equals("")){ %>
													
														<%=lastpmrcdecisions.get(z)[0] %>
													<%}else{ %>
												  	Nil 
												  	<br><br><br>
												  	<%} %></div>	
						<h1 class="break"></h1>					
<!-- -------------------------------------------------------------------------------------------------------------------------------------------------------- -->
									
					<div align="left" style="margin-left: 10px;"><b>13. Other Relevant Points (if any) 
   							<%if(Integer.parseInt(committeeid)==2){ %>
   								and Technical Work Carried Out For Last Three Months
							<%}else { %>
								and Technical Work Carried Out For Last Six Months
							<%} %>
   						</b></div>
						<table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px; width: 980px;  border-collapse:collapse;" >
							<tr>
								 <th  style="width: 80%; ">Other Relevant Points</th>
								 <th  style="width: 10%; ">Technical Work Carried</th>		
							</tr>
										
									<% if(TechWorkDataList.get(z)!=null){ %>
										<tr>
											<td><%=TechWorkDataList.get(z)[2] %></td>
											<td>
												<%if(TechWorkDataList.get(z)[3]!=null && Long.parseLong(TechWorkDataList.get(z)[3].toString())>0){ %>
													
													<a href="<%="http://"+InetAddress.getLocalHost().getHostAddress()+":"+request.getServerPort()+request.getContextPath()+"/download/AttachDocLinkDownload.htm?filerepid="+cryptor.encryptParam(TechWorkDataList.get(z)[3] .toString())%>" target="_blank">Download</a>
													
												<%}else{ %>
													File Not Attached
												<%} %>
											</td>	
										</tr>
								<%}else{ %>
									<tr><td colspan="2" style="text-align: center;">Nil </td></tr>
								<%} %>
									
						</table>
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


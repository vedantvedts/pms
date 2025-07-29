<%@page import="java.nio.file.Paths"%>
<%@page import="java.nio.file.Path"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.net.Inet4Address"%>
<%@page import="com.vts.pfms.Zipper"%>
<%@page import="com.vts.pfms.model.TotalDemand"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="com.vts.pfms.committee.model.Committee"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="com.vts.pfms.print.model.TechImages"%>
<%@page import="com.vts.pfms.model.LabMaster"%>
<%@page import="com.vts.pfms.AESCryptor"%>
<%@page import="org.apache.commons.io.FilenameUtils"%>
<%@page import="java.io.File"%>
<%@page import="java.math.BigInteger"%>
<%@page import="java.text.Format"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.master.dto.ProjectFinancialDetails"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.time.LocalDate"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="shortcut icon" type="image/png" href="view/images/drdologo.png">
<jsp:include page="../static/dependancy.jsp"></jsp:include>
<spring:url value="/resources/css/slides-style.css" var="SlidesStyleCSS" />
<link href="${SlidesStyleCSS}" rel="stylesheet" />
<title>Briefing Presentation</title>
</head>
<body style="background-color: #F9F2DF66;" class="slides-container" id="slides-container">
	<%
	DecimalFormat df = new DecimalFormat("####################.##");
	FormatConverter fc = new FormatConverter();
	SimpleDateFormat sdf = fc.getRegularDateFormat();
	SimpleDateFormat sdf1 = fc.getSqlDateFormat();
    SimpleDateFormat inputFormat = new SimpleDateFormat("ddMMMyyyy");
    SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");	
	String todayDate=outputFormat.format(new Date()).toString();
	int addcount = 0;
	NFormatConvertion nfc = new NFormatConvertion();
	Format format = com.ibm.icu.text.NumberFormat.getCurrencyInstance(new Locale("en", "in"));
	String filePath = (String) request.getAttribute("filePath");
	String projectLabCode = (String) request.getAttribute("projectLabCode");
	List<Object[]> projectslist = (List<Object[]>) request.getAttribute("projectslist");
	String projectid = (String) request.getAttribute("projectid");
	Committee committee = (Committee) request.getAttribute("committeeData");
	String committeeid = (String) request.getAttribute("committeeid");
	List<Object[]> projectattributeslist = (List<Object[]>) request.getAttribute("projectattributes");
	List<List<Object[]>> ebandpmrccount = (List<List<Object[]>>) request.getAttribute("ebandpmrccount");
	List<List<Object[]>> milestonesubsystems = (List<List<Object[]>>) request.getAttribute("milestonesubsystems");
	List<List<Object[]>> milestones = (List<List<Object[]>>) request.getAttribute("milestones");
	List<List<Object[]>> lastpmrcactions = (List<List<Object[]>>) request.getAttribute("lastpmrcactions");
	List<List<Object[]>> lastpmrcminsactlist = (List<List<Object[]>>) request.getAttribute("lastpmrcminsactlist");
	List<List<Object[]>> ganttchartlist = (List<List<Object[]>>) request.getAttribute("ganttchartlist");
	List<Object[]> projectdatadetails = (List<Object[]>) request.getAttribute("projectdatadetails");
	List<List<Object[]>> oldpmrcissueslist = (List<List<Object[]>>) request.getAttribute("oldpmrcissueslist");

	List<List<ProjectFinancialDetails>> projectFinancialDetails = (List<List<ProjectFinancialDetails>>) request.getAttribute("financialDetails");
	List<List<Object[]>> procurementOnDemand = (List<List<Object[]>>) request.getAttribute("procurementOnDemandlist");
	List<List<Object[]>> procurementOnSanction = (List<List<Object[]>>) request.getAttribute("procurementOnSanctionlist");
	List<List<Object[]>> riskmatirxdata = (List<List<Object[]>>) request.getAttribute("riskmatirxdata");
	List<Object[]> lastpmrcdecisions = (List<Object[]>) request.getAttribute("lastpmrcdecisions");
	List<List<Object[]>> actionplanthreemonths = (List<List<Object[]>>) request.getAttribute("actionplanthreemonths");
	List<Object[]> TechWorkDataList = (List<Object[]>) request.getAttribute("TechWorkDataList");
	List<Object[]> ProjectDetail = (List<Object[]>) request.getAttribute("ProjectDetails");
	List<String> projectidlist = (List<String>) request.getAttribute("projectidlist");
	List<Object[]> pdffiles = (List<Object[]>) request.getAttribute("pdffiles");
	List<Object[]> milestoneactivitystatus = (List<Object[]>) request.getAttribute("milestoneactivitystatus");
	List<Object[]> MilestoneList = (List<Object[]>) request.getAttribute("MilestoneActivityList");
	String ProjectId = (String) request.getAttribute("projectid");
	List<TotalDemand> totalprocurementdetails = (List<TotalDemand>) request.getAttribute("TotalProcurementDetails");
	List<List<Object[]>> ReviewMeetingList = (List<List<Object[]>>) request.getAttribute("ReviewMeetingList");
	List<List<Object[]>> ReviewMeetingListPMRC = (List<List<Object[]>>) request.getAttribute("ReviewMeetingListPMRC");
	List<List<Object[]>> overallfinance = (List<List<Object[]>>)request.getAttribute("overallfinance");//b
	String IsIbasConnected=(String)request.getAttribute("IsIbasConnected");
	List<List<Object[]>> ProjectRevList = (List<List<Object[]>>) request.getAttribute("ProjectRevList");
	List<List<Object[]>> MilestoneDetails6 = (List<List<Object[]>>) request.getAttribute("milestonedatalevel6");//a
	List<List<TechImages>> TechImages = (List<List<TechImages>>) request.getAttribute("TechImages");
	Object[] committeeMetingsCount =  (Object[]) request.getAttribute("committeeMetingsCount");
	Object[] nextMeetVenue =  (Object[]) request.getAttribute("nextMeetVenue");
	List<Object[]> RecDecDetails = (List<Object[]>)request.getAttribute("recdecDetails");
	List<Object[]> otherMeetingList = (List<Object[]>)request.getAttribute("otherMeetingList");
	LabMaster labInfo=(LabMaster)request.getAttribute("labInfo");
	String lablogo = (String)request.getAttribute("lablogo");
	String Drdologo = (String)request.getAttribute("Drdologo");
	String pdc="";String mainpdc="";
	long ProjectCost = (long) request.getAttribute("ProjectCost");
	String levelid = (String) request.getAttribute("levelid");
	Committee committeeData = (Committee) request.getAttribute("committeeData");
	String CommitteeCode = committeeData.getCommitteeShortName().trim();
	
	//maps for pmrc and EB
	Map<Integer,String> mappmrc=(Map<Integer,String>)request.getAttribute("mappmrc");
	Map<Integer,String> mapEB=(Map<Integer,String>)request.getAttribute("mapEB");

	
	String ProjectCode="";
		for(int i=0;i<projectattributeslist.size();i++){
			ProjectCode = ProjectCode +projectattributeslist.get(i)[0].toString()  ;
			if(i!=projectattributeslist.size()-1)ProjectCode=ProjectCode+"/";
		}
	
	String MeetingNo = CommitteeCode+" #"+(Long.parseLong(committeeMetingsCount[1].toString())+1);
	LocalDate before6months = LocalDate.now().minusMonths(6);
	if(committeeData.getCommitteeShortName().trim().equalsIgnoreCase("PMRC")){ 
		before6months = LocalDate.now().minusMonths(3);
	}else if(committeeData.getCommitteeShortName().trim().equalsIgnoreCase("EB")){
		before6months = LocalDate.now().minusMonths(6);
	} 
	String thankYouImg = (String)request.getAttribute("thankYouImg");
	List<Object[]> RiskTypes = (List<Object[]>)request.getAttribute("RiskTypes");
	Map<Integer,String> treeMapLevOne =(Map<Integer,String>)request.getAttribute("treeMapLevOne");
	Map<Integer,String> treeMapLevTwo =(Map<Integer,String>)request.getAttribute("treeMapLevTwo");
		List<Object[]> envisagedDemandlist = (List<Object[]>)request.getAttribute("envisagedDemandlist");
	%>
	<div id="presentation-slides" class="carousel slide " data-ride="carousel">

		<div class="carousel-inner" align="center">
			
			<!-- ---------------------------------------- P-0  Div ----------------------------------------------------- -->
			<div class="carousel-item active">
				
				<div class="content" align="center" style="height:93vh !important;padding-top: 15px;">
					
					<div class="firstpage"  > 

						<div align="center" ><h2 style="color: #145374 !important;font-family: 'Muli'!important">Presentation</h2></div>
						<div align="center" ><h3 style="color: #145374 !important">for</h3></div>
							
						<div align="center" >
							<h3 style="color: #4C9100 !important" ><%=CommitteeCode %> #<%=Long.parseLong(committeeMetingsCount[1].toString())+1 %> Meeting </h3>
				   		</div>
						
						<div align="center" ><h3 style="color: #4C9100 !important"><%= projectattributeslist.get(0)[1] %> (<%= projectattributeslist.get(0)[0] %>)
						<%if(projectattributeslist.size()>1) {
						for(int item=1;item<projectattributeslist.size();item++){
						%>
						 <br>
						<span style="font-size: 1rem;"><%= projectattributeslist.get(item)[1] %> (<%= projectattributeslist.get(item)[0] %>) (SUB)</span>
						 <%}} %>
						</h3></div>
						
							<table class="executive home-table" style="align: center; margin-left: auto;margin-right:auto;border:0px;  font-size: 16px;"  >
								<tr>			
									<th colspan="8" style="text-align: center; font-weight: 700;">
									<img class="logo" style="width:120px;height: 120px;x"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> > 
									<br>
									</th>
									
								</tr>
							</table>	
						<% if(nextMeetVenue!=null){ %>
							<!-- <div style="border: 1px solid black;border-radius: 5px;max-width: 650px;"> -->
							<table style="align: center;width: 650px;  "  >
								<tr style="margin-top: 10px">
									 <th  style="text-align: center;font-size: 18px;border:0px !important; "> <u>Meeting Id </u> </th></tr><tr>
									 <th  style="text-align: center;font-size: 18px;border:0px !important;  "> <%=nextMeetVenue[1] %> </th>				
								 </tr>
							</table>
							<table style="align: left; width: 650px; "  >
								<tr>
									 <th  style="text-align: center; width: 50%;font-size: 18px;border:0px !important; "> <u> Meeting Date </u></th>
									 <th  style="text-align: center;  width: 50%;font-size: 18px;border:0px !important;  "><u> Meeting Time </u></th>
								</tr>
								<tr>
									<%-- <%LocalTime starttime = LocalTime.parse(LocalTime.parse(nextMeetVenue[3].toString(),DateTimeFormatter.ofPattern("HH:mm:ss")).format( DateTimeFormatter.ofPattern("HH:mm") ));   %> --%>
									 <td  style="text-align: center; width: 50%;font-size: 18px ;padding-top: 5px;border:0px !important;"> <b><%=sdf.format(sdf1.parse(nextMeetVenue[2].toString()))%></b></td>
									 <td  style="text-align: center; width: 50%;font-size: 18px ;padding-top: 5px;border:0px !important; "> <b><%=nextMeetVenue[3]/* starttime.format( DateTimeFormatter.ofPattern("hh:mm a") ) */%></b></td>
								</tr>
							</table>
							<table style="align: center; width: 650px;"  >
								<tr style="margin-top: 10px">
									 <th  style="text-align: center;font-size: 18px;border:0px !important; "> <u>Meeting Venue</u> </th></tr><tr>
									 <th  style="text-align: center;;font-size: 18px ;border:0px !important; "> <% if(nextMeetVenue[5]!=null){ %><%=nextMeetVenue[5] %> <%}else{ %> - <%} %></th>				
								 </tr>
							</table>
						<%}else{ %>
							<br><br><br><br><br><br><br><br><br>
						<%} %>
						
						<table class="executive home-table" style="align: center;margin-bottom:5px; margin-left: auto;margin-right:auto;border:0px;  font-size: 16px;"  >
						<% if(labInfo!=null){ %>
						<tr>
							<th colspan="8" style="text-align: center; font-weight: 700;font-size: 22px"><%if(labInfo.getLabName()!=null){ %><%=labInfo.getLabName()  %><%}else{ %>LAB NAME<%} %></th>
						</tr>
						<%}%>
						<tr>
							<th colspan="8" style="text-align: center; font-weight: 700;font-size:15px"><br>Government of India, Ministry of Defence</th>
						</tr>
						<tr>
							<th colspan="8" style="text-align: center; font-weight: 700;font-size:15px">Defence Research & Development Organization</th>
						</tr>
						<tr>
							<th colspan="8" style="text-align: center; font-weight: 700;font-size:15px"><%if(labInfo.getLabAddress() !=null){ %><%=labInfo.getLabAddress()  %> , <%=labInfo.getLabCity() %><%}else{ %>LAB ADDRESS<%} %> </th>
						</tr>
						</table>			
						
						
					</div>
					
				</div>
				
			</div>
			<!-- ----------------------------------------  P-0  Div ----------------------------------------------------- -->
			<!-- ---------------------------------------- P-1  Div ----------------------------------------------------- -->
			<%char ch='a';for (int z = 0; z < projectidlist.size(); z++) {mainpdc="PDC:"+sdf.format(sdf1.parse(projectattributeslist.get(0)[6].toString()));
			List<Object[]> revlist = ProjectRevList.get(z);Object[] projectattributes = projectattributeslist.get(z);pdc=pdc+"(PDC:"+sdf.format(sdf1.parse(projectattributes[6].toString()))+")<br>";%>
			<%if (projectattributes != null) {%>
			<div class="carousel-item ">
				<div class="content-header row ">
					<div class="col-md-1" ><img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> ></div>
					<div class="col-md-1" align="left" style="padding-top:5px;" ><b style="margin-left: -35px;"><%=ProjectCode %></b>
					<h6 style="font-size: 0.8rem;margin-left: -43px;"><%=pdc %></h6>
					</div>
					<div class="col-md-8"><h3>1<%if(projectidlist.size()>1) {%>(<%=(char)(ch++)%>)<%} %> . Project Attributes </h3></div>
					<div class="col-md-1" align="right"  style="padding-top:19px;" ><b style="margin-right: -35px;"><%=MeetingNo %></b></div>
					<div class="col-md-1"><img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
				</div>
				<div class="content" align="center">
				
					<b style="font-size: 25px;">Project : <%=ProjectDetail.get(z)[1]%><% if (z != 0) { %>(SUB)<% } %></b>
					<hr style="margin: 0.25rem 0rem;">
					<table class="subtables " style="font-size:1.1rem;align: left; margin-top: 10px; width:96% !important; border-collapse: collapse;">
						<tr>
							<td
								style="width: 5px !important; padding: 5px; padding-left: 10px">(a)</td>
							<td style="width: 280px; padding: 5px; padding-left: 10px"><b>Project
									Title</b></td>
							<td colspan="4" 
								style="width: 370px; padding: 5px; padding-left: 10px; font-weight: bold; color: #309322">
								<%=projectattributes[1]%><span style="float:right;background-color:#F86F03;color:white; padding:3px;">PDC -(<%=sdf.format(sdf1.parse(projectattributes[6].toString()))%>)</span></td>
						</tr>
						<tr>
							<td style="padding: 5px; padding-left: 10px">(b)</td>
							<td style="width: 150px; padding: 5px; padding-left: 10px"><b>Project
									Code</b></td>
							<td colspan="4" class="prjattr"
								style="width: 370px; padding: 5px; padding-left: 10px"><%=projectattributes[0]%>
							</td>
						</tr>
						<tr>
							<td style="padding: 5px; padding-left: 10px">(c)</td>
							<td style="width: 150px; padding: 5px; padding-left: 10px"><b>Category</b></td>
							<td colspan="4" class="prjattr"
								style="width: 370px; padding: 5px; padding-left: 10px"><%=projectattributes[14]%></td>
						</tr>
						<tr>
							<td style="padding: 5px; padding-left: 10px">(d)</td>
							<td style="width: 150px; padding: 5px; padding-left: 10px"><b>Date of Sanction</b></td>
							<td colspan="4" class="prjattr" style="width: 370px; padding: 5px; padding-left: 10px"><%=sdf.format(sdf1.parse(projectattributes[3].toString()))%></td>
						</tr>
						<tr>
							<td style="width: 20px; padding: 5px; padding-left: 10px">(e)</td>
							<td style="width: 150px; padding: 5px; padding-left: 10px"><b>Nodal
									and Participating Labs</b></td>
							<td colspan="4" class="prjattr"
								style="width: 370px; padding: 5px; padding-left: 10px">
								<%if (projectattributes[15] != null) {%><%=projectattributes[15]%><%}%>
							</td>
						</tr>
						<tr>
							<td style="padding: 5px; padding-left: 10px">(f)</td>
							<td style="width: 150px; padding: 5px; padding-left: 10px"><b>Objective</b></td>
							<td colspan="4"  class="prjattr"
								style="width: 370px; padding: 5px; padding-left: 10px; text-align: justify">
								<%=projectattributes[4]%></td>
						</tr>
						<tr>
							<td style="padding: 5px; padding-left: 10px">(g)</td>
							<td style="width: 150px; padding: 5px; padding-left: 10px"><b>Deliverables</b></td>
							<td colspan="4" class="prjattr"
								style="width: 370px; padding: 5px; padding-left: 10px"><%=projectattributes[5]%></td>
						</tr>
						<tr>
							<td rowspan="2" style="padding: 5px; padding-left: 10px">(h)</td>
							<td rowspan="2" 
								style="width: 150px; padding: 5px; padding-left: 10px"><b>PDC</b></td>

							<td colspan="2" style="text-align: center !important"><!-- Original -->&nbsp;</td>
							<%if (ProjectRevList.get(z).size() > 0) {%>
							<td colspan="2" style="text-align: center !important">Revised</td>
							<%} else {%><td colspan="2"></td><%}%>
						</tr>
						<tr>
							<%
							if (ProjectRevList.get(z).size() > 0) {
							%>
							<td colspan="2" style="text-align: center;" class="prjattr"><%=sdf.format(sdf1.parse(ProjectRevList.get(z).get(0)[12].toString()))%>
							</td>
							<td colspan="2" style="text-align: center;" class="prjattr">
								<% if (LocalDate.parse(projectattributes[6].toString()) .isEqual(LocalDate.parse(ProjectRevList.get(z).get(0)[12].toString()))) { %>
									- 
								<% } else { %><%=sdf.format(sdf1.parse(projectattributes[6].toString()))%>
								<% } %>
							</td>
							<%
							} else {
							%>
							<td colspan="2" style="text-align: center;" class="prjattr"><%=sdf.format(sdf1.parse(projectattributes[6].toString()))%></td>
							<td colspan="2"></td>
							<%
							}
							%>
						</tr>
						<tr>
							<td rowspan="3"
								style="width: 30px; padding: 5px; padding-left: 10px">(i)</td>
							<td rowspan="3" style="padding-left: 10px"><b>Cost
									Breakup( In &#8377; <span class="currency">Lakhs</span>)
							</b></td>

							<%
							if (ProjectRevList.get(z).size() > 0) {
							%>
							<td style="width: 10% !important;font-weight: bold">RE Cost</td>
							<td style="text-align: center;" class="prjattr"><%=ProjectRevList.get(z).get(0)[17]%></td>
							<td colspan="2" style="text-align: center;"class="prjattr" ><%=projectattributes[8]%></td>
						</tr>
						<tr>
							<td style="width: 10% !important;font-weight: bold">FE Cost</td>
							<td style="text-align: center;" class="prjattr"><%=ProjectRevList.get(z).get(0)[16]%></td>
							<td colspan="2" style="text-align: center;" class="prjattr"><%=projectattributes[9]%></td>
						</tr>
						<tr>
							<td style="width: 10% !important;font-weight: bold" >Total Cost</td>
							<td style="text-align: center;" class="prjattr"><%=ProjectRevList.get(z).get(0)[11]%></td>
							<td colspan="2" style="text-align: center;" class="prjattr"><%=projectattributes[7]%></td>
						</tr>
						<%
						} else {
						%>
						<td style="width: 10% !important;font-weight: bold" >RE Cost</td>
						<td class="prjattr"><%=projectattributes[8]%></td>
						<td colspan="2" class="prjattr"></td>
						</tr>
						<tr>
							<td style="width: 10% !important;font-weight: bold">FE Cost</td>
							<td class="prjattr"><%=projectattributes[9]%></td>
							<td colspan="2"></td>
						</tr>
						<tr>
							<td style="width: 10% !important;font-weight: bold">Total Cost</td>
							<td class="prjattr"><%=projectattributes[7]%></td>
							<td colspan="2"></td>
						</tr>
						<%
						}
						%>
						<tr>
							<td style="width: 20px; padding: 5px; padding-left: 10px">(j)</td>
							<td style="width: 150px; padding: 5px; padding-left: 10px"><b>No.
									of EBs and PMRCs held</b></td>
							<td colspan="2"><b>EB :</b><span class="prjattr"><%=ebandpmrccount.get(z).get(1)[1]%></span> </td>
							<td colspan="2"><b>PMRC :</b><span class="prjattr"> <%=ebandpmrccount.get(z).get(0)[1]%></span> </td>
						</tr>
						<tr>
							<td style="width: 20px; padding: 5px; padding-left: 10px">(k)</td>
							<td style="width: 210px; padding: 5px; padding-left: 10px"><b>Current
									Stage of Project</b></td>
							<td colspan="4"
								style=" width: 200px;color:white; padding: 5px; padding-left: 10px ; <%if (projectdatadetails.get(z) != null) {%> background-color: <%=projectdatadetails.get(z)[11]%> ;   <%}%>">
								<span> <%
								 if (projectdatadetails.get(z) != null) { %><b><%=projectdatadetails.get(z)[10]%>
							</b> <%} else {%>Data Not Found<%}%></span>
							</td>
						</tr>
					</table>
				</div></div>
					<%} else {%>
					<div align="center" style="margin: 25px;">Complete ProjectData Not Found</div>
					<%}%><%}%>
			<!-- ----------------------------------------  P-1  Div ----------------------------------------------------- -->
			<!-- ---------------------------------------- P-2a Div ----------------------------------------------------- -->
			<div class="carousel-item ">
				<div class="content-header row ">
					<div class="col-md-1" >
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
					<div class="col-md-1" align="left" style="padding-top:5px;" ><b style="margin-left: -35px;"><%=ProjectCode%></b><h6 style="font-size: 0.8rem;margin-left: -43px;"><%=mainpdc %></h6>
					</div>
					<div class="col-md-8"><h3>2. Schematic Configuration - (a) System Configuration</h3></div>
					<div class="col-md-1" align="right"  style="padding-top:19px;" ><b style="margin-right: -35px;"><%=MeetingNo %></b></div>
					<div class="col-md-1"><img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> ></div>
						</div>
				<div class="content">
					<%for (int z = 0; z < 1; z++) { %>
					<div align="left" style="margin-left: 15px;">
						<div align="center">
							<table style="width: 100%;">
								<%if (projectdatadetails.get(z) != null && projectdatadetails.get(z)[3] != null) {%>
								<tr>
									<td style="border: 0; text-align: left;">
										<form action="#" method="post" target="_blank">
											<b><%=ProjectDetail.get(z)[1]%><% if (z != 0) { %>(SUB<% } %> : </b>
											<span class="mainsubtitle"></span><span class="anchorlink" onclick="$('#config<%=ProjectDetail.get(z)[0]%>').toggle();" style="color: #C84B31; cursor: pointer;"><b>As on File Attached</b></span>
											<button type="submit" class="btn btn-sm " formaction="ProjectDataSystemSpecsFileDownload.htm" formmethod="post" formtarget="_blank">
												<i class="fa fa-download fa-lg"></i>
											</button>
											<input type="hidden" name="projectdataid" value="<%=projectdatadetails.get(z)[0]%>" /> 
											<input type="hidden" name="filename" value="sysconfig" /> 
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										</form>
									</td>
								</tr>
								<tr>
									<td style="border: 0; text-align: center;">
										<%if (FilenameUtils.getExtension(projectdatadetails.get(z)[3].toString()).equalsIgnoreCase("pdf")) {%>
										<iframe
											src="data:application/pdf;base64,<%=pdffiles.get(z)[0]%>#view=FitV" style="width:100%;height:70vh"
											id="config<%=ProjectDetail.get(z)[0]%>"> </iframe> <%
											 } else {
											 %>
										<img data-enlargable
										style="width: 98%!important; height:78vh;"
										src="data:image/<%=FilenameUtils.getExtension(projectdatadetails.get(z)[3].toString())%>;base64,<%=pdffiles.get(z)[0]%>"
										id="config<%=ProjectDetail.get(z)[0]%>"> <%
										 }
										 %>
									</td>
								</tr>
								<%
								} else {
								%>
								<tr>
									<td style="border: 0; text-align: left;"><b><%=ProjectDetail.get(z)[1]%><% if (z != 0) { %>(SUB<% } %> : </b><span class="mainsubtitle">System Configuration File Not Found</span></td>
								</tr>
								<%}%>
							</table>
						</div>
					</div>
					<%}%>
				</div>
			</div>
			<!-- ----------------------------------------  P-2a Div ----------------------------------------------------- -->
			<!-- ---------------------------------------- P-2b   Div ----------------------------------------------------- -->
			<div class="carousel-item ">
				<div class="content-header row ">
					<div class="col-md-1" >
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
					<div class="col-md-1" align="left" style="padding-top:5px;" >
						<b style="margin-left: -35px;"><%=ProjectCode %></b>
						<h6 style="font-size: 0.8rem;margin-left: -43px;"><%=mainpdc %></h6>
					</div>
					<div class="col-md-8">
						<h3>2. Schematic Configuration - (b) System Specifications</h3>
					</div>
					<div class="col-md-1" align="right"  style="padding-top:19px;" >
						<b style="margin-right: -35px;"><%=MeetingNo %></b>
					</div>
					<div class="col-md-1">
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
				</div>
				<div class="content">
					<%for (int z = 0; z < 1; z++){ %>
					<div align="left" style="margin-left: 15px;">
						<div align="center">
							<table style="width: 100%;">
								<%if (projectdatadetails.get(z) != null && projectdatadetails.get(z)[4] != null) {%>
								<tr>
									<td style="border: 0; text-align: left;">
										<form action="#" method="post" target="_blank">
											<b><%=ProjectDetail.get(z)[1]%> <% if (z != 0) { %>(SUB<% } %> : </b>
											<span class="mainsubtitle"></span><span class="anchorlink"
												onclick="$('#sysspecs<%=ProjectDetail.get(z)[0]%>').toggle();"
												style="color: #C84B31; cursor: pointer;"><b>As
													on File Attached</b></span>
											<button type="submit" class="btn btn-sm "
												formaction="ProjectDataSystemSpecsFileDownload.htm"
												formmethod="post" formtarget="_blank">
												<i class="fa fa-download fa-lg"></i>
											</button>
											<input type="hidden" name="projectdataid"
												value="<%=projectdatadetails.get(z)[0]%>" /> <input
												type="hidden" name="filename" value="sysspecs" /> <input
												type="hidden" name="${_csrf.parameterName}"
												value="${_csrf.token}" />
										</form>
									</td>
								</tr>
								<tr>
									<td style="border: 0; text-align: center;">
										<%if (FilenameUtils.getExtension(projectdatadetails.get(z)[4].toString()).equalsIgnoreCase("pdf")) {%>
										<iframe 
											src="data:application/pdf;base64,<%=pdffiles.get(z)[3]%>#view=FitV" style="width:100%;height:70vh"
											id="sysspecs<%=ProjectDetail.get(z)[0]%>" > </iframe> <%
										 } else {
										 %>
										<img data-enlargable
										style="width: 98%; height:78vh"
										src="data:image/<%=FilenameUtils.getExtension(projectdatadetails.get(z)[4].toString())%>;base64,<%=pdffiles.get(z)[3]%>"
										id="sysspecs<%=ProjectDetail.get(z)[0]%>"> <%
										 }
										 %>
									</td>
								</tr>
								<%
								} else {
								%>
								<tr>
									<td style="border: 0; text-align: left;"><b><%=ProjectDetail.get(z)[1]%><% if (z != 0) { %>(SUB<% } %> : </b><span class="mainsubtitle"> System Specifications File Not Found</span></td>
								</tr>
								<%}%>
							</table>
						</div>
					</div>
					<%}%>
				</div>
			</div>
			<!-- ---------------------------------------- P-2b   Div ----------------------------------------------------- -->
			<!-- ---------------------------------------- P-3  Overall Product tree/WBS Div ----------------------------------------------------- -->
			<div class="carousel-item ">
				<div class="content-header row ">
					<div class="col-md-1" >
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
					<div class="col-md-1" align="left" style="padding-top:5px;" >
						<b style="margin-left: -35px;"><%=ProjectCode %></b>
						<h6 style="font-size: 0.8rem;margin-left: -43px;"><%=mainpdc %></h6>
					</div>
					<div class="col-md-8">
						<h3>3. Overall Product Tree/WBS</h3>
					</div>
					<div class="col-md-1" align="right"  style="padding-top:19px;" >
						<b style="margin-right: -35px;"><%=MeetingNo %></b>
					</div>
					<div class="col-md-1">
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
					
				</div>

				<div class="content">
					<% for (int z = 0; z < 1; z++) { %>
					<% if (ProjectDetail.size() > 1) { %>
					<div style="margin-left: 1rem;">
						<b>Project : <%=ProjectDetail.get(z)[1]%> <% if (z != 0) {  %>(SUB)<% }  %> </b>
					</div>
					<% } %>
					<table style="width: 100%;">
						<%
						if (projectdatadetails.get(z) != null && projectdatadetails.get(z)[5] != null) {
						%>
						<tr>
							<td style="border: 0; padding-left: 1.5rem; text-align: left;">
								<form action="ProjectDataSystemSpecsFileDownload.htm"
									method="post" target="_blank">
									<span class="anchorlink"
										onclick="$('#protree<%=ProjectDetail.get(z)[0]%>').toggle();"
										style="color: #C84B31; cursor: pointer;"><b>As on
											File Attached</b></span>
									<button type="submit" class="btn btn-sm ">
										<i class="fa fa-download fa-lg"></i>
									</button>
									<input type="hidden" name="projectdataid"
										value="<%=projectdatadetails.get(z)[0]%>" /> <input
										type="hidden" name="filename" value="protree" /> <input
										type="hidden" name="${_csrf.parameterName}"
										value="${_csrf.token}" />
								</form>
							</td>
						</tr>
						<tr>
							<td style="border: 0; padding-left: 1.5rem; text-align: center;">
								<%
								if (FilenameUtils.getExtension(projectdatadetails.get(z)[5].toString()).equalsIgnoreCase("pdf")) {
								%>
								<iframe
									src="data:application/pdf;base64,<%=pdffiles.get(z)[1]%>#view=FitV" style="width:100%;height:70vh"
									id="protree<%=ProjectDetail.get(z)[0]%>"> </iframe> <%
								 } else {
								 %>
								<img data-enlargable style="width: 98%; height:78vh;"
								src="data:image/<%=FilenameUtils.getExtension(projectdatadetails.get(z)[5].toString())%>;base64,<%=pdffiles.get(z)[1]%>"
								id="protree<%=ProjectDetail.get(z)[0]%>"> <% } %>
							</td>

						</tr>
						<% } else { %>
						<tr>
							<td style="border: 0; padding-left: 1.5rem; text-align: left;">
								<span class="mainsubtitle">Overall Product tree/WBS File
									Not Found</span>
							</td>
						</tr>
						<% } %>
					</table>
					<% } %>
				</div>
			</div>
			<!-- ----------------------------------------  Overall Product tree/WBS Div ----------------------------------------------------- -->
			<!-- ---------------------------------------- P-4a  Particulars of Meeting Div ----------------------------------------------------- -->
			<div class="carousel-item ">
				<div class="content-header row ">
					<div class="col-md-1" >
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
					<div class="col-md-1" align="left" style="padding-top:5px;" >
						<b style="margin-left: -35px;"><%=ProjectCode %></b>
						<h6 style="font-size: 0.8rem;margin-left: -43px;"><%=mainpdc %></h6>
					</div>
					<div class="col-md-8">
						<h3>
							4 (a) <% if (committee.getCommitteeShortName().trim().equalsIgnoreCase("PMRC")) { %> Approval
							<% } else { %> Ratification <% } %> of <b>Recommendations</b> of last <%=committee.getCommitteeShortName().trim().toUpperCase()%> Meeting
						</h3>
					</div>
					<div class="col-md-1" align="right"  style="padding-top:19px;" >
						<b style="margin-right: -35px;"><%=MeetingNo %></b>
					</div>
					<div class="col-md-1">
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
				</div>
				<div class="content">
					<% for (int z = 0; z < 1; z++) { %>
					<% if (ProjectDetail.size() > 1) { %>
					<div>
						<b>Project : <%=ProjectDetail.get(z)[1]%> <% if (z != 0) {  %>(SUB)<% }  %> </b>
					</div>
					<% } %>
					<!-- CALL last_pmrc_actions_list_bpaper(:projectid,:committeeid); -->
					<table class="subtables" style="align: left; margin-top: 10px; border-collapse: collapse;">
						<thead>
							<tr>
								<td colspan="7" style="border: 0">
									<p style="font-size: 12px; text-align: center">
										<span class="notassign">NA</span> : Not Assigned &nbsp;&nbsp;
										<span class="assigned">AA</span> : Activity Assigned &nbsp;&nbsp; 
										<span class="ongoing">OG</span> : On Going &nbsp;&nbsp; 
										<span class="delay">DO</span> : Delay - On Going &nbsp;&nbsp; 
										<span class="ongoing">RC</span> : Review & Close &nbsp;&nbsp; 
										<span class="delay">FD</span> : Forwarded With Delay &nbsp;&nbsp; 
										<span class="completed">CO</span> :Completed &nbsp;&nbsp; 
										<span class="completeddelay">CD</span> : Completed with Delay &nbsp;&nbsp; 
										<span class="inactive">IA</span> : InActive &nbsp;&nbsp; 
										<span class="delaydays">DD</span> : Delayed days &nbsp;&nbsp;
									</p>
								</td>
							</tr>
							<tr>
								<th style="width: 15px !important; text-align: center;">SN</th>
								<th style="width: 20px !important;">ID</th>
								<th style="width: 315px !important;">Recommendation Point</th>
								<th style="width: 100px !important;">PDC</th>
								<th style="width: 200px !important;">Responsibility</th>
								<th style="width: 70px !important;">Status(DD)</th>
								<th style="width: 250px !important;">Remarks</th>
							</tr>
						</thead>
						<tbody>
							<% if (lastpmrcminsactlist.get(z).size() == 0) { %>
							<tr>
								<td colspan="7" style="text-align: center;">Nil</td>
							</tr>
							<%
							} else if (lastpmrcminsactlist.get(z).size() > 0) {
							int i = 1;String key2="";
							for (Object[] obj : lastpmrcminsactlist.get(z)) {
								if (obj[3].toString().equalsIgnoreCase("R")&& (obj[10]==null || !obj[10].toString().equals("C") || (obj[10].toString().equals("C") && obj[14]!=null &&  before6months.isBefore(LocalDate.parse(obj[14].toString()) ) ))      )
								{ %>
							<tr>
								<td style="text-align: center;"><%=i%></td>
															<td style="text-align: center;">
								<%if(obj[21]!=null && Long.parseLong(obj[21].toString())>0){ %>
									<button type="button" class="btn btn-sm "  onclick="ActionDetails( <%=obj[21] %>);" data-toggle="tooltip" data-placement="bottom" title="Action Details" style="font-weight:bold;" >
								<%if(committee.getCommitteeShortName().trim().equalsIgnoreCase("pmrc")){ %>
								<%for (Map.Entry<Integer, String> entry : mappmrc.entrySet()) {
									Date date = inputFormat.parse(obj[5].toString().split("/")[3]);
									 String formattedDate = outputFormat.format(date);
									 if(entry.getValue().equalsIgnoreCase(formattedDate)){
										 key2=entry.getKey().toString();
									 } }}else{%>
									 <%
									 for (Map.Entry<Integer, String> entry : mapEB.entrySet()) {
											Date date = inputFormat.parse(obj[5].toString().split("/")[3]);
											 String formattedDate = outputFormat.format(date);
											 if(entry.getValue().equalsIgnoreCase(formattedDate)){
												 key2=entry.getKey().toString();
											 }
									 }
									 %>
									 <%} %>
								<%=committee.getCommitteeShortName().trim().toUpperCase()+"-"+key2+"/"+obj[5].toString().split("/")[4] %>
									</button>
								<%}%>
							</td>
								<td style="text-align: justify;"> <%=obj[2]%> </td>
								<td style="text-align: center;">
								<%if(obj[8]!= null && !LocalDate.parse(obj[8].toString()).equals(LocalDate.parse(obj[7].toString())) ){ %><span style="color:black;font-weight: bold;"><%=sdf.format(sdf1.parse(obj[8].toString()))%></span><br><%} %>	
								<%if(obj[7]!= null && !LocalDate.parse(obj[7].toString()).equals(LocalDate.parse(obj[6].toString())) ){ %><span style="color:black;font-weight: bold;"><%=sdf.format(sdf1.parse(obj[7].toString()))%></span><br><%} %>
								<%if(obj[6]!= null){ %><span><%=sdf.format(sdf1.parse(obj[6].toString()))%></span><br><%} %>
								</td>
								<td>
									<% if (obj[4] != null) { %>
										<%=obj[12]%> <%-- , <%=obj[13] %> --%> 
									<% } else { %>
										Not Assigned 
									<%  } %>
								</td>
								<td style="text-align: center;">
									<%if(obj[4]!= null){ %> 
									<%	String actionstatus = obj[10].toString();
										int progress = obj[18]!=null ? Integer.parseInt(obj[18].toString()) : 0;
										LocalDate pdcorg = LocalDate.parse(obj[6].toString());
										LocalDate lastdate = obj[14]!=null ? LocalDate.parse(obj[14].toString()): null;
										LocalDate today = LocalDate.now();
									%> 
									<% if(lastdate!=null && actionstatus.equalsIgnoreCase("C") ){%>
											<%if(actionstatus.equals("C") && (pdcorg.isAfter(lastdate) || pdcorg.equals(lastdate))){%>
												<span class="completed">CO</span>
											<%}else if(actionstatus.equals("C") && pdcorg.isBefore(lastdate)){ %>	
												<span class="completeddelay">CD (<%= ChronoUnit.DAYS.between(pdcorg, lastdate) %>) </span>
											<%} %>	
										<%}else{ %>
											<%if(actionstatus.equals("F")  && (pdcorg.isAfter(lastdate) || pdcorg.isEqual(lastdate) )){ %>
												<span class="ongoing">RC</span>												
											<%}else if(actionstatus.equals("F")  && pdcorg.isBefore(lastdate)) { %>
												<span class="delay">FD</span>
											<%}else if(actionstatus.equals("A") && progress==0){  %>
												<span class="assigned">
													AA <%if(pdcorg.isBefore(today)){ %> (<%= ChronoUnit.DAYS.between(pdcorg, today)  %>) <%} %>
												</span>
											<%} else if(pdcorg.isAfter(today) || pdcorg.isEqual(today)){  %>
												<span class="ongoing">OG</span>
											<%}else if(pdcorg.isBefore(today)){  %>
												<span class="delay">DO (<%= ChronoUnit.DAYS.between(pdcorg, today)  %>)  </span>
											<%} %>									
									<%} %>
									<%}else { %><span class="notassign">NA</span><%} %>
							</td>
							<td><% if (obj[19] != null) { %><%=obj[19]%> <% } %></td>
						</tr>
						<% i++; }
						} %>
							<% if (i == 1) { %>
							<tr>
								<td colspan="7" style="text-align: center;">Nil</td>
							</tr>
							<% } %><% } %>
					</tbody>
				</table>
				<% } %>
				</div>
			</div>
			<!-- ----------------------------------------  P-4a Div ----------------------------------------------------- -->
			<!-- ---------------------------------------- P-4b Div ----------------------------------------------------- -->
			<div class="carousel-item ">
				<div class="content-header row ">
					<div class="col-md-1" >
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
					<div class="col-md-10">
						<h5 style="margin-top: 5px;">
						4 (b) Last <%=committee.getCommitteeShortName().trim().toUpperCase()%> Meeting Action Points with Probable Date of Completion (PDC), Actual Date of Completion (ADC) and Status
						</h5>
					</div>
					<div class="col-md-1"><img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
				</div>
				<div class="content">
					<% for (int z = 0; z < 1; z++) { %>
					<% if (ProjectDetail.size() > 1) { %>
					<div><b>Project : <%=ProjectDetail.get(z)[1]%> <% if (z != 0) {  %>(SUB)<% }  %> </b></div>
					<% } %>
					<%if ((Double.parseDouble(projectattributeslist.get(0)[7].toString()) * 100000) > 0) {%>
					<table class="subtables" style="align: left; margin-top: 10px; border-collapse: collapse;">
						<thead>
							<tr>
								<td colspan="7" style="border: 0">
									<p style="font-size: 12px; text-align: center">
										<span class="notassign">NA</span> : Not Assigned &nbsp;&nbsp;
										<span class="assigned">AA</span> : Activity Assigned &nbsp;&nbsp; 
										<span class="ongoing">OG</span> : On Going &nbsp;&nbsp; 
										<span class="delay">DO</span> : Delay - On Going &nbsp;&nbsp; 
										<span class="ongoing">RC</span> : Review & Close &nbsp;&nbsp; 
										<span class="delay">FD</span> : Forwarded With Delay &nbsp;&nbsp; 
										<span class="completed">CO</span> :Completed &nbsp;&nbsp; 
										<span class="completeddelay">CD</span> : Completed with Delay &nbsp;&nbsp; 
										<span class="inactive">IA</span> : InActive &nbsp;&nbsp; 
										<span class="delaydays">DD</span> : Delayed days &nbsp;&nbsp;
									</p>
								</td>
							</tr>
							<tr>
								<th style="width: 15px !important; text-align: center;">SN</th>
								<th style="width:30px;">ID</th>
								<th style="width: 280px;">Action Point</th>
								<th style="width: 95px;">ADC <br>PDC</th>
								<!-- <th style="width: 95px;">ADC</th> -->
								<th style="width: 205px;">Responsibility</th>
								<th style="width: 80px;">Status(DD)</th>
								<th style="width: 200px;">Remarks</th>
								<!-- <th style="width: 20px;">Info</th> -->
							</tr>
						</thead>
						<tbody>
							<% if (lastpmrcactions.get(z).size() == 0) { %>
							<tr>
								<td colspan="7" style="text-align: center;">Nil</td>
							</tr>
							<% } else if (lastpmrcactions.size() > 0) {
							int i = 1;String key="";
							for (Object[] obj : lastpmrcactions.get(z)) {
							%>
							<tr>
								<td style="text-align: center;"><%=i%></td>
								<td style="text-align: center;">
								<%if(obj[17]!=null && Long.parseLong(obj[17].toString())>0){ %>
								<button type="button" class="btn btn-sm" style="border-radius: 50px;font-weight: bold" onclick="ActionDetails( <%=obj[17] %>);" data-toggle="tooltip" data-placement="top" title="Action Details" >
								<%if(committee.getCommitteeShortName().trim().equalsIgnoreCase("pmrc")){ %>
								<%for (Map.Entry<Integer, String> entry : mappmrc.entrySet()) {
									Date date = inputFormat.parse(obj[1].toString().split("/")[3]);
									 String formattedDate = outputFormat.format(date);
									 if(entry.getValue().equalsIgnoreCase(formattedDate)){
										 key=entry.getKey().toString();
									 } }}else{%>
									 <%
									 for (Map.Entry<Integer, String> entry : mapEB.entrySet()) {
											Date date = inputFormat.parse(obj[1].toString().split("/")[3]);
											 String formattedDate = outputFormat.format(date);
											 if(entry.getValue().equalsIgnoreCase(formattedDate)){
												 key=entry.getKey().toString();
											 }
									 }
									 %>
									 <%} %>
								
								<%=committee.getCommitteeShortName().trim().toUpperCase()+"-"+key+"/"+obj[1].toString().split("/")[4] %>
								</button>
								<%}%> 
								<!--  -->
								</td>
								<td style="text-align: justify;"> <%=obj[2]%> </td>
								<td style="text-align: center;">
									<%	String actionstatus = obj[9].toString();
										int progress = obj[15]!=null ? Integer.parseInt(obj[15].toString()) : 0;
										LocalDate pdcorg = LocalDate.parse(obj[3].toString());
										LocalDate lastdate = obj[13]!=null ? LocalDate.parse(obj[13].toString()): null;
										LocalDate today = LocalDate.now();
										LocalDate endPdc=LocalDate.parse(obj[4].toString());
									%> 
					 				<% if(lastdate!=null && actionstatus.equalsIgnoreCase("C") ){%>
											<%if(actionstatus.equals("C") && (pdcorg.isAfter(lastdate) || pdcorg.equals(lastdate))){%>
											<span class="completed"><%= sdf.format(sdf1.parse(obj[13].toString()))%> </span>
											<%}else if(actionstatus.equals("C") && pdcorg.isBefore(lastdate)){ %>	
											<span class="completeddelay"><%= sdf.format(sdf1.parse(obj[13].toString()))%> </span>
											<%} %>	
										<%}else{ %>
												-									
										<%} %>
									<br>
									<span <%if(endPdc.isAfter(today) || endPdc.isEqual(today)) {%>style="color:black;font-weight: bold;" <%} else{%> style="color:maroon ;font-weight:bolder;" <%} %>>
									<%= sdf.format(sdf1.parse(obj[4].toString()))%> 
									</span>
									<%if(!pdcorg.equals(endPdc)) { %>
									<br>
									<span <%if(pdcorg.isAfter(today) || pdcorg.isEqual(today)) {%>style="color:black;font-weight: bold;" <%} else{%> style="color:maroon ;font-weight:bolder;" <%} %>>
									<%= sdf.format(sdf1.parse(obj[3].toString()))%> 
									</span>	
									<%} %>
								</td>
								<td><%=obj[11]%><%-- , <%=obj[12] %> --%></td>
								<td style="text-align: center;">
									<% if(lastdate!=null && actionstatus.equalsIgnoreCase("C") ){ %>
											<%if(actionstatus.equals("C") && (pdcorg.isAfter(lastdate) || pdcorg.equals(lastdate))){%>
												<span class="completed">CO</span>
											<%}else if(actionstatus.equals("C") && pdcorg.isBefore(lastdate)){ %>	
												<span class="completeddelay">CD (<%= ChronoUnit.DAYS.between(pdcorg, lastdate) %>) </span>
											<%} %>	
										<%}else{ %>
											<%if(actionstatus.equals("F")  && (pdcorg.isAfter(lastdate) || pdcorg.isEqual(lastdate) )){ %>
												<span class="ongoing">RC</span>												
											<%}else if(actionstatus.equals("F")  && pdcorg.isBefore(lastdate)) { %>
												<span class="delay">FD</span>
											<%}else if(actionstatus.equals("A") && progress==0){  %>
												<span class="assigned">
													AA <%if(pdcorg.isBefore(today)){ %> (<%= ChronoUnit.DAYS.between(pdcorg, today)  %>) <%} %>
												</span>
											<%} else if(pdcorg.isAfter(today) || pdcorg.isEqual(today)){  %>
												<span class="ongoing">OG</span>
											<%}else if(pdcorg.isBefore(today)){  %>
												<span class="delay">DO (<%= ChronoUnit.DAYS.between(pdcorg, today)  %>)  </span>
											<%} %>					
																			
										<%} %>
								</td>
								<td style="text-align: justify;">
									<% if (obj[16] != null) { %><%=obj[16]%> <% } %>
								</td>

								
							</tr>
							<% i++; }
							} %>
						</tbody>

					</table>

					<% } %>
					<% } %>				
				</div>

			</div>

			<!-- ----------------------------------------  P-4b Div ----------------------------------------------------- -->

			<!-- ---------------------------------------- P-4c  Div ----------------------------------------------------- -->

			<div class="carousel-item ">
				<div class="content-header row ">
					<div class="col-md-1" >
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
					<div class="col-md-1" align="left" style="padding-top:5px;" >
						<b style="margin-left: -35px;"><%=ProjectCode %></b>
						<h6 style="font-size: 0.8rem;margin-left: -43px;"><%=mainpdc %></h6>
					</div>
					<div class="col-md-8">
						<h3>4 (c) Details of Technical/ User Reviews</h3>
					</div>
					<div class="col-md-1" align="right"  style="padding-top:19px;" >
						<b style="margin-right: -35px;"><%=MeetingNo %></b>
					</div>
					<div class="col-md-1">
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
				</div>
				<div class="content">
					<% for (int z = 0; z < 1; z++) { %>
						<% if (ProjectDetail.size() > 1) { %>
						<div>
							<b>Project : <%=ProjectDetail.get(z)[1]%> <% if (z != 0) {  %>(SUB)<% }  %> </b>
						</div>
						<% } %>
						<div align="center">
							<form action="CommitteeMinutesNewDownload.htm" method="get" target="_blank">
									
								<div align="center" style="width:990px">
									<div align="center" style="margin-left:25px;max-width:300px;float:left;">
										<table class="subtables" style="align: left; margin-top: 10px; margin-left: 25px; max-width: 350px; border-collapse: collapse; float: left;">
											<thead>
												<tr>
													 <th  style="width: 140px; ">Committee</th>
													 <th  style="width: 140px; "> Date Held</th>
												</tr>
											</thead>
											<tbody>
												<%if(ReviewMeetingList.get(z).size()==0){ %>
												<tr><td colspan="6" style="text-align: center;" > Nil</td></tr>
												<%}
												else if(ReviewMeetingList.size()>0)
												  {int i=1;
												for(Object[] obj:ReviewMeetingList.get(z)){ %>
													<tr>
														<td >
															<button class="btn btn-link" style="padding:0px;margin:0px;" name="committeescheduleid" value="<%=obj[0]%>">
																<%=obj[1]%> #<%=i %>
															</button>
														</td>												
														<td  style="text-align: center; " ><%= sdf.format(sdf1.parse(obj[3].toString()))%></td>
													</tr>				
												<%i++;
												}}else{ %>
												<tr><td colspan="4" style="text-align: center;" > Nil</td></tr>
												<%} %> 
										</tbody>
									</table>
									</div>
								
									<%int t=1; %>
									<div align="center" style="max-width:300px; display:inline-block; ;">
										<table class="subtables" style="align: left; margin-top: 10px; margin-left: 25px; max-width: 350px; border-collapse: collapse; float: left;">
											<thead>
												<tr>
													 <th  style="width: 140px; ">Committee</th>
													 <th  style="width: 140px; "> Date Held</th>
												</tr>
											</thead>
											<tbody>
												<%if(ReviewMeetingListPMRC.get(z).size()==0){ %>
													<tr><td colspan="6" style="text-align: center;" > Nil</td></tr>
												<%} else if(ReviewMeetingListPMRC.size()>0)
												  { 
													for(Object[] obj:ReviewMeetingListPMRC.get(z)){ %>
												<%if(t<=20){ %>
													<tr>
														<td>
															<button class="btn btn-link" style="padding:0px;margin:0px;" name="committeescheduleid" value="<%=obj[0]%>">
																<%=obj[1]%> #<%=t++ %>
															</button>
														</td>												
														<td  style="text-align: center; " ><%= sdf.format(sdf1.parse(obj[3].toString()))%></td>
													</tr>			
												<%};
												}}else{ %>
												
													<tr><td colspan="4" style="text-align: center;" > Nil</td></tr>
												
											<%} %> 
										</tbody>
									</table>
									</div>
									<% if(t>20) { %>
									<div align="left" style="max-width:300px; float:right; ;">
										<table class="subtables" style="align: left; margin-top: 10px; margin-left: 25px; max-width: 350px; border-collapse: collapse; float: left;">
											<thead>
												<tr>
													 <th  style="width: 140px; ">Committee</th>
													 <th  style="width: 140px; "> Date Held</th>
												</tr>
											</thead>
											<tbody>
												<%if(ReviewMeetingListPMRC.get(z).size()==0){ %>
												<tr><td colspan="6" style="text-align: center;" > Nil</td></tr>
												<%}
												else if(ReviewMeetingListPMRC.size()>0)
												  {
												for(Object[] obj:ReviewMeetingListPMRC.get(z).stream().skip(20).collect(Collectors.toList())){ %>
													<tr>
														<td>
														<button class="btn btn-link" style="padding:0px;margin:0px;" name="committeescheduleid" value="<%=obj[0]%>">
														<%=obj[1]%> #<%=t %>
														</button>
														</td>												
														<td  style="text-align: center; " ><%= sdf.format(sdf1.parse(obj[3].toString()))%></td>
													</tr>			
												<%t++;}}else{ %><tr><td colspan="4" style="text-align: center;" > Nil</td></tr><%} %> 
										</tbody>
									</table>
									</div>
									<%} %>
									
									<div  class="mt-2" style="float: right">
									<button type="button" class="btn btn-sm " onclick="showMeetingModal()" data-toggle="tooltip" data-placement="right" title="Other Meetings"><i class="fa fa-info-circle fa-lg " style="color: #145374" aria-hidden="true"></i></button>
									</div>
								</div>
							</form>
						</div>
					<% } %>
				</div></div>
			<!-- ----------------------------------------   P-4c Div ----------------------------------------------------- -->
			<!-- ---------------------------------------- P-5  Milestones achieved prior Div ----------------------------------------------------- -->
			<div class="carousel-item ">
				<div class="content-header row ">
					<div class="col-md-1" >
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
					<div class="col-md-1" align="left" style="padding-top:5px;" >
						<b style="margin-left: -35px;"><%=ProjectCode %></b>
						<h6 style="font-size: 0.8rem;margin-left: -43px;"><%=mainpdc %></h6>
					</div>
					<div class="col-md-8">
						<h3> 5. Milestones Achieved Prior to this <%=CommitteeCode%> Period</h3>
					</div>
					<div class="col-md-1" align="right"  style="padding-top:19px;" >
						<b style="margin-right: -35px;"><%=MeetingNo %></b>
					</div>
					<div class="col-md-1">
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
					
				</div>
				
				<div class="content">

					<% for (int z = 0; z < 1; z++) { %>
					<% if (ProjectDetail.size() > 1) { %>
					<div>
						<b>Project : <%=ProjectDetail.get(z)[1]%> <% if (z != 0) {  %>(SUB)<% }  %> </b>
					</div>
					<%
					}
					%>
					<form action="MilestoneActivityList.htm" target="_blank" style="float: right;">
						<button class="btn btn-sm " style="background-color: #D3D3D3; margin-right: 5px; float: right;" data-toggle="tooltip" data-placement="bottom" title="Milestone Data">
							<i class="fa fa-info-circle " style="font-size: 1.5rem; color: #145374;" aria-hidden="true"></i>
						</button>
						<input type="hidden" name="ProjectId" value="<%=projectid%>">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					</form>

					<!-- CALL Pfms_Milestone_Level_Prior(:projectid) -->
					<table class="subtables" style="align: left; margin-top: 10px;  margin-left: 25px; border-collapse: collapse;">
						<thead>
							<tr>
								<td colspan="10" style="border: 0">
									<p style="font-size: 12px; text-align: center">
										<span class="notassign">NA</span> : Not Assigned &nbsp;&nbsp;
										<span class="assigned">AA</span> : Activity Assigned &nbsp;&nbsp; 
										<span class="ongoing">OG</span> : On Going &nbsp;&nbsp; 
										<span class="delay">DO</span> : Delay - On Going &nbsp;&nbsp; 
										<span class="ongoing">RC</span> : Review & Close &nbsp;&nbsp; 
										<span class="delay">FD</span> : Forwarded With Delay &nbsp;&nbsp; 
										<span class="completed">CO</span> :Completed &nbsp;&nbsp; 
										<span class="completeddelay">CD</span> : Completed with Delay &nbsp;&nbsp; 
										<span class="inactive">IA</span> : InActive &nbsp;&nbsp; 
										<span class="delaydays">DD</span> : Delayed days &nbsp;&nbsp;
									</p>
								</td>
							</tr>

							<tr>
								<th style="width: 20px;">SN</th>
								<th style="width: 30px;">MS</th>
								<th style="width: 60px;">L</th>
								<th style="width: 350px;">System/ Subsystem/ Activities</th>
								<th style="width: 100px;">ADC<br>PDC</th>
								<!-- <th style="width: 150px;">ADC</th> -->
								<th style="width: 60px;">Progress</th>
								<th style="width: 50px;">Status(DD)</th>
								<th style="width: 350px;">Remarks</th>
								<th style="width: 30px;">Info</th>
							</tr>
						</thead>
						<%
						if (milestones.get(z).size() > 0) {
							long count1 = 1;
							int milcountA = 1;
							int milcountB = 1;
							int milcountC = 1;
							int milcountD = 1;
							int milcountE = 1;
						%>
						<%
						int serial = 1;int milestonecount=0;// to remember milestonecount
						for (Object[] obj : milestones.get(z)) {
						if(obj[21].toString().equals("1")){
						}
					if(Integer.parseInt(obj[21].toString())<= Integer.parseInt(levelid)  ){
							%>
						<tr>
							<td style="text-align: center"><%=serial%></td>
							<td>M<%=obj[0]%></td>

							<td style="text-align: center">
								<%
								if (obj[21].toString().equals("0")) {
								%> <!-- L --> <%
								 milcountA = 1;
								 milcountB = 1;
								 milcountC = 1;
								 milcountD = 1;
								 milcountE = 1;
								 } else if (obj[21].toString().equals("1")) {
										for(Map.Entry<Integer,String>entry:treeMapLevOne.entrySet()){
											if(entry.getKey().toString().equalsIgnoreCase(obj[2].toString())){%>
												<%=entry.getValue() %>
										<%}} 
									 
								 %>
								<%
					
								} else if (obj[21].toString().equals("2")) {
									for(Map.Entry<Integer,String>entry:treeMapLevTwo.entrySet()){
										if(entry.getKey().toString().equalsIgnoreCase(obj[3].toString())){%>
											<%=entry.getValue() %>
									<%}}	
									
								%> <%-- B-<%=milcountB%> --%>
								<%
						
								} else if (obj[21].toString().equals("3")) {
								%> C-<%=milcountC%>
								<%
								milcountC += 1;
								milcountD = 1;
								milcountE = 1;
								} else if (obj[21].toString().equals("4")) {
								%> D-<%=milcountD%>
								<%
								milcountD += 1;
								milcountE = 1;
								} else if (obj[21].toString().equals("5")) {
								%> E-<%=milcountE%>
								<%
								milcountE++;
								}
								%>
							</td>

							<td
								style="<%if (obj[21].toString().equals("0")) {%>font-weight: bold;<%}%>">
								<%
								if (obj[21].toString().equals("0")) {
								%> <%=obj[10]%> <%
									 } else if (obj[21].toString().equals("1")) {
									 %>
																	&nbsp;&nbsp;<%=obj[11]%> <%
									 } else if (obj[21].toString().equals("2")) {
									 %>
																	&nbsp;&nbsp;<%=obj[12]%> <%
									 } else if (obj[21].toString().equals("3")) {
									 %>
																	&nbsp;&nbsp;<%=obj[13]%> <%
									 } else if (obj[21].toString().equals("4")) {
									 %>
																	&nbsp;&nbsp;<%=obj[14]%> <% } else if (obj[21].toString().equals("5")) { %>
																	&nbsp;&nbsp;<%=obj[15]%> <% } %>
							</td>
							<td style="text-align: center">

								
								<% 
								LocalDate StartDate = LocalDate.parse(obj[7].toString());
								LocalDate EndDate = LocalDate.parse(obj[8].toString());
								LocalDate OrgEndDate = LocalDate.parse(obj[9].toString());
								int Progess = Integer.parseInt(obj[17].toString());
								LocalDate CompletionDate =obj[24]!=null ? LocalDate.parse(obj[24].toString()) : null;
								LocalDate Today = LocalDate.now();
								%>
								<% if ((obj[19].toString().equalsIgnoreCase("3") || obj[19].toString().equalsIgnoreCase("5")) && obj[24] != null) { %>	
									<span 
										<%if(Progess==0){ %>
											class="assigned"
										<%} else if(Progess>0 && Progess<100 && (OrgEndDate.isAfter(Today) || OrgEndDate.isEqual(Today) )){ %>
											class="ongoing"
										<%} else if( Progess>0 && Progess<100 && (OrgEndDate.isBefore(Today) )){ %>
											class="delay"
										<%} else if((CompletionDate!=null && ( CompletionDate.isBefore(OrgEndDate) ||  CompletionDate.isEqual(OrgEndDate)))){ %>
											class="completed"
										<%} else if((CompletionDate!=null && CompletionDate.isAfter(OrgEndDate) )){ %>
											class="completeddelay"
										<%}else if(CompletionDate!=null && Progess==0 &&  ( EndDate.isAfter(Today) ||  EndDate.isEqual(Today)) ){ %>
											class="inactive"
										<%}else{ %>
											class="assigned"
										<%} %>
										> <%=sdf.format(sdf1.parse(obj[24].toString()))%> </span>
									
								 <% } else {  %> <span>- </span><% } %>
								<br>
								<% if (!LocalDate.parse(obj[8].toString()).isEqual(LocalDate.parse(obj[9].toString()))) {
									boolean incident=true;
									%>
								<span style="color: black;font-weight: bold;"><%=sdf.format(sdf1.parse(obj[8].toString()))%></span><br> 
								<%}%> 
								<span style="color: black;font-weight: bold;"><%=sdf.format(sdf1.parse(obj[9].toString()))%></span>
								
							</td>
					
							<td style="text-align: center"><%=obj[17]%>%</td>
							
							
							<td style="text-align: center">	
								
									<%if(Progess==0){ %>
										<span class="assigned"> AA </span>
									<%} else if(Progess>0 && Progess<100 && (OrgEndDate.isAfter(Today) || OrgEndDate.isEqual(Today) )){ %>
										<span class="ongoing"> OG </span>
									<%} else if( Progess>0 && Progess<100 && (OrgEndDate.isBefore(Today) )){ %>
										<span class="delay"> DO (<%=ChronoUnit.DAYS.between(OrgEndDate, LocalDate.now())%>)</span>
									<%} else if((CompletionDate!=null && ( CompletionDate.isBefore(OrgEndDate) ||  CompletionDate.isEqual(OrgEndDate)))){ %>
										<span class="completed"> CO</span>
									<%} else if((CompletionDate!=null && CompletionDate.isAfter(OrgEndDate) )){ %>
										<span class="completeddelay">CD (<%=ChronoUnit.DAYS.between(OrgEndDate, CompletionDate)%>)</span>
									<%}else if(CompletionDate!=null && Progess==0 &&  ( EndDate.isAfter(Today) ||  EndDate.isEqual(Today)) ){ %>
										<span class="inactive">IA</span>
									<%}else{ %>
										<span class="assigned">AA</span>
									<%} %>
								
							</td>
							
							<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;">
								<% if (obj[23] != null) { %><%=obj[23]%> <% } %>
							</td>
							<td style="text-align: center">
							<%if (obj[21].toString().equals("0")) {%>
								<a data-toggle="modal" data-target="#exampleModal1" data-id="milestonemodal<%=obj[0]%>" class="milestonemodal" data-whatever="@mdo" style=" cursor: pointer"> 
									<i class="fa fa-info-circle fa-lg " style="color: #145374" aria-hidden="true"></i>
								</a>
								<%} %>
							</td>
						</tr>
						<%
						count1++;serial++;}}
						%>
						<% } else { %>
						<tr><td colspan="10" style="text-align: center;">Nil</td></tr>
						<% } %>
					</table>
					<div id="milestoneactivitychange"></div>
					<% } %>
				</div>
			</div>
			<!-- ----------------------------------------  Milestones achieved prior Div ----------------------------------------------------- -->
			<!-- ---------------------------------------- P-6a Div ----------------------------------------------------- -->
			<div class="carousel-item ">
				<div class="content-header row ">
					<div class="col-md-1" >
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
					<div class="col-md-1" align="left" style="padding-top:5px;" >
						<b style="margin-left: -35px;"><%=ProjectCode %></b>
						<h6 style="font-size: 0.8rem;margin-left: -43px;"><%=mainpdc %></h6>
					</div>
					<div class="col-md-8">
						<h3>6 (a) Work Carried Out, Achievements, Test Result etc.</h3>
					</div>
					<div class="col-md-1" align="right"  style="padding-top:19px;" >
						<b style="margin-right: -35px;"><%=MeetingNo %></b>
					</div>
					<div class="col-md-1">
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
					
				</div>

				<div class="content">

					<% for (int z = 0; z < 1; z++) { %>
					<% if (ProjectDetail.size() > 1) { %>
					<div>
						<b>Project : <%=ProjectDetail.get(z)[1]%> <% if (z != 0) {  %>(SUB)<% }  %> </b>
					</div>
					<% } %>
					<div align="left" style="margin-left: 15px;">
						<% if (z == 0) { %>
						<form action="FilterMilestone.htm" method="POST">
							<button class="btn btn-sm back" style="float: right; margin-top: 5px; text-transform: capitalize !important;" formtarget="blank">Filter</button>
							<input type="hidden" name="projectidvalue"  value="<%=projectid%>">
							<input type="hidden" name="committeidvalue" value="<%=committeeid%>" >
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						</form>
						<% } %>
					</div>
					<table class="subtables" style="align: left; margin-top: 10px; margin-left: 25px; border-collapse: collapse;">
						<thead>
							<tr>
								<td colspan="10" style="border: 0">
									<p style="font-size: 12px; text-align: center">
										<span class="notassign">NA</span> : Not Assigned &nbsp;&nbsp;
										<span class="assigned">AA</span> : Activity Assigned &nbsp;&nbsp; 
										<span class="ongoing">OG</span> : On Going &nbsp;&nbsp; 
										<span class="delay">DO</span> : Delay - On Going &nbsp;&nbsp; 
										<span class="ongoing">RC</span> : Review & Close &nbsp;&nbsp; 
										<span class="delay">FD</span> : Forwarded With Delay &nbsp;&nbsp; 
										<span class="completed">CO</span> :Completed &nbsp;&nbsp; 
										<span class="completeddelay">CD</span> : Completed with Delay &nbsp;&nbsp; 
										<span class="inactive">IA</span> : InActive &nbsp;&nbsp; 
										<span class="delaydays">DD</span> : Delayed days &nbsp;&nbsp;
									</p>
								</td>
							</tr>
							<tr>
								<th style="width: 20px;">SN</th>
								<th style="width: 30px;">MS</th>
								<th style="width: 60px;">L</th>
								<th style="width: 450px;">System/ Subsystem/ Activities</th>
								<th style="width: 150px;">PDC</th>
								<th style="width: 60px;">Progress</th>
								<th style="width: 50px;">Status(DD)</th>
								<th style="width: 310px;">Remarks</th>
								<th style="width: 30px;">Info</th>
							</tr>
						</thead>
						<%
						if (MilestoneDetails6.get(z).size() > 0) {
							long count1 = 1;
							int milcountA = 1;
							int milcountB = 1;
							int milcountC = 1;
							int milcountD = 1;
							int milcountE = 1;
						%>
						<%
						int serial = 1;
						for (Object[] obj : MilestoneDetails6.get(z)) {
						if (Integer.parseInt(obj[21].toString()) <= Integer.parseInt(levelid)) {
						%>
						<tr>
							<td style="text-align: center"><%=serial%></td>
							<td>M<%=obj[0]%></td>
							<td style="text-align: center">
								<%
								if (obj[21].toString().equals("0")) {
								%> <!-- L --> <%
								 milcountA = 1;
								 milcountB = 1;
								 milcountC = 1;
								 milcountD = 1;
								 milcountE = 1;
								 } else if (obj[21].toString().equals("1")) {
								 for(Map.Entry<Integer,String>entry:treeMapLevOne.entrySet()){
								if(entry.getKey().toString().equalsIgnoreCase(obj[2].toString())){%>
								<%=entry.getValue() %>
										<%}}
								 %> <%-- A-<%=milcountA%> --%>
								<%
							
								} else if (obj[21].toString().equals("2")) {
									for(Map.Entry<Integer,String>entry:treeMapLevTwo.entrySet()){
										if(entry.getKey().toString().equalsIgnoreCase(obj[3].toString())){%>
											<%=entry.getValue() %>
									<%}}
								%><%--  B-<%=milcountB%> --%>
								<%
						
								} else if (obj[21].toString().equals("3")) {
								%> C-<%=milcountC%>
								<%
								milcountC += 1;
								milcountD = 1;
								milcountE = 1;
								} else if (obj[21].toString().equals("4")) {
								%> D-<%=milcountD%>
								<%
								milcountD += 1;
								milcountE = 1;
								} else if (obj[21].toString().equals("5")) {
								%> E-<%=milcountE%>
								<%
								milcountE++;
								}
								%>
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
							<% 
								LocalDate StartDate = LocalDate.parse(obj[7].toString());
								LocalDate EndDate = LocalDate.parse(obj[8].toString());
								LocalDate OrgEndDate = LocalDate.parse(obj[9].toString());
								int Progess = Integer.parseInt(obj[17].toString());
								LocalDate CompletionDate =obj[24]!=null ? LocalDate.parse(obj[24].toString()) : null;
								LocalDate Today = LocalDate.now();
							%>
							<td style="text-align: center">
								<% if (!LocalDate.parse(obj[8].toString()).isEqual(LocalDate.parse(obj[9].toString()))) { %>
									<span <%if(LocalDate.parse(obj[8].toString()).isBefore(LocalDate.parse(todayDate))) {%>style="color:brown;font-weight: bold"<%}else{%>style="color:black;font-weight: bold" <%} %>>
									<%=sdf.format(sdf1.parse(obj[8].toString()))%></span><br> 
								<% } %> 
							<span <%if( LocalDate.parse(obj[8].toString()).isEqual(LocalDate.parse(obj[9].toString())) && LocalDate.parse(obj[9].toString()).isBefore(LocalDate.parse(todayDate))) {%> style="color:brown;font-weight: bold"<%}else{ %>style="color:black;font-weight: bold"<%} %>><%=sdf.format(sdf1.parse(obj[9].toString()))%></span>
							</td>
							<td style="text-align: center"><%=obj[17]%>%</td>
							<td style="text-align: center">
							
								
								
									<%if(Progess==0){ %>
										<span class="assigned"> AA </span>
									<%} else if(Progess>0 && Progess<100 && (OrgEndDate.isAfter(Today) || OrgEndDate.isEqual(Today) )){ %>
										<span class="ongoing"> OG </span>
									<%} else if( Progess>0 && Progess<100 && (OrgEndDate.isBefore(Today) )){ %>
										<span class="delay"> DO (<%=ChronoUnit.DAYS.between(OrgEndDate, LocalDate.now())%>)</span>
									<%} else if((CompletionDate!=null && ( CompletionDate.isBefore(OrgEndDate) ||  CompletionDate.isEqual(OrgEndDate)))){ %>
										<span class="completed"> CO</span>
									<%} else if((CompletionDate!=null && CompletionDate.isAfter(OrgEndDate) )){ %>
										<span class="completeddelay">CD (<%=ChronoUnit.DAYS.between(OrgEndDate, CompletionDate)%>)</span>
									<%}else if(CompletionDate!=null && Progess==0 &&  ( EndDate.isAfter(Today) ||  EndDate.isEqual(Today)) ){ %>
										<span class="inactive">IA</span>
									<%}else{ %>
										<span class="assigned">AA</span>
									<%} %>
								
							</td>
							<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;">
								<% if (obj[23] != null) {
								%><%=obj[23]%>
								<%}%>
							</td>
							<td style="text-align: center">
							<%
								if (obj[21].toString().equals("0")) {%>
								<a data-toggle="modal" data-target="#exampleModal1" data-id="milestonemodal<%=obj[0]%>" class="milestonemodal" data-whatever="@mdo" style=" cursor: pointer"> 
									<i class="fa fa-info-circle fa-lg " style="color: #145374" aria-hidden="true"></i>
								</a>
								<%} %>
							</td>
						</tr>
						<% count1++;
						serial++;
						}
						} %>
						<% } else { %>
						<tr>
							<td colspan="10" style="text-align: center;">Nil</td>
						</tr>


						<%}%>
					</table>

					<%}%></div></div>
			<!-- ----------------------------------------   P-6a Div ----------------------------------------------------- -->
			<!-- ---------------------------------------- P-6b Div ----------------------------------------------------- -->
			<div class="carousel-item ">

				<div class="content-header row ">
					
					<div class="col-md-1" >
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
					<div class="col-md-1" align="left" style="padding-top:5px;" >
						<b style="margin-left: -35px;"><%=ProjectCode %></b>
						<h6 style="font-size: 0.8rem;margin-left: -43px;"><%=mainpdc %></h6>
					</div>
					<div class="col-md-8">
						<h4>6 (b) TRL Table with TRL at Sanction stage and Current stage Indicating Overall PRI</h4>
					</div>
					<div class="col-md-1" align="right"  style="padding-top:19px;" >
						<b style="margin-right: -35px;"><%=MeetingNo %></b>
					</div>
					<div class="col-md-1">
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
					
				</div>

				<div class="content">

					<% for (int z = 0; z < 1; z++) { %>
						<% if (ProjectDetail.size() > 1) { %>
							<div>
								<b>Project : <%=ProjectDetail.get(z)[1]%> <% if (z != 0) {  %>(SUB)<% }  %> </b>
							</div>
						<% } %>
					<div>
						<table style="width: 100%;">
							<% if (projectdatadetails.get(z) != null && projectdatadetails.get(z)[6] != null) { %>
							<tr>
								<td style="border: 0;">
									<form action="ProjectDataSystemSpecsFileDownload.htm" method="post" target="_blank">
										<span class="anchorlink" onclick="$('#pearl<%=ProjectDetail.get(z)[0]%>').toggle();" style="color: #C84B31; cursor: pointer;">
											<b>As on File Attached</b>
										</span>
										<button type="submit" class="btn btn-sm "> <i class="fa fa-download fa-lg"></i> </button>
										<input type="hidden" name="projectdataid" value="<%=projectdatadetails.get(z)[0]%>" /> 
										<input type="hidden" name="filename" value="pearl" /> 
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									</form>
								</td>
							</tr>
							<tr>
									<td style="border: 0;text-align: center;" >
									<%  if (FilenameUtils.getExtension(projectdatadetails.get(z)[6].toString()).equalsIgnoreCase("pdf")) {  %>
										<div class="col-md-12" style="position: relative;width: 100%;padding-bottom: calc(8.5/ 11 * 100%);">
										<iframe  src="data:application/pdf;base64,<%=pdffiles.get(z)[2]%>#view=FitV" style="width:100%;height:70vh" id="pearl<%=ProjectDetail.get(z)[0]%>"> </iframe> 
									</div>
									<% } else { %>
										<img data-enlargable style="width:75%;height:75vh;" src="data:image/<%=FilenameUtils.getExtension(projectdatadetails.get(z)[6].toString())%>;base64,<%=pdffiles.get(z)[2]%>"id="pearl<%=ProjectDetail.get(z)[0]%>"> 
									<% } %>
								</td>
							</tr>

							<% } else { %>
								<tr>
									<td style="border: 0;">File Not Found</td>
								</tr>
							<% } %>

						</table>
					</div>

					<% } %>
				</div></div>
			<!-- ----------------------------------------   P-6b Div ----------------------------------------------------- -->
			<!-- ---------------------------------------- P-6c Div ----------------------------------------------------- -->
			<div class="carousel-item ">
				<div class="content-header row ">
					<div class="col-md-1" >
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
					<div class="col-md-1" align="left" style="padding-top:5px;" >
						<b style="margin-left: -35px;"><%=ProjectCode %></b>
						<h6 style="font-size: 0.8rem;margin-left: -43px;"><%=mainpdc %></h6>
					</div>
					<div class="col-md-8">
						<h3>6 (c) Risk Matrix/Management Plan/Status</h3>
					</div>
					<div class="col-md-1" align="right"  style="padding-top:19px;" >
						<b style="margin-right: -35px;"><%=MeetingNo %></b>
					</div>
					<div class="col-md-1">
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div></div><div class="content">
					<% for (int z = 0; z < 1; z++) { %>
					<% if (ProjectDetail.size() > 1) { %>
					<div>
						<b>Project : <%=ProjectDetail.get(z)[1]%> <% if (z != 0) {  %>(SUB)<% }  %> </b>
					</div>
					<% } %>

					<!-- <div align="left" style="margin-left: 15px;"><span class="mainsubtitle">(c) Risk Matrix/Management Plan/Status.</span> </div> -->

					<table class="subtables" style="align: left; margin-top: 10px; margin-left: 25px; border-collapse: collapse;">
						<thead>

							<tr>
								<td colspan="10" style="border: 0">
									<p style="font-size: 12px; text-align: center">
									<span class="notassign">NA</span> : Not Assigned &nbsp;&nbsp;
									<span class="assigned">AA</span> : Activity Assigned &nbsp;&nbsp; 
									<span class="ongoing">OG</span> : On Going &nbsp;&nbsp; 
									<span class="delay">DO</span> : Delay - On Going &nbsp;&nbsp; 
									<span class="ongoing">RC</span> : Review & Close &nbsp;&nbsp; 
									<span class="delay">FD</span> : Forwarded With Delay &nbsp;&nbsp; 
									<span class="completed">CO</span> :Completed &nbsp;&nbsp; 
									<span class="completeddelay">CD</span> : Completed with Delay &nbsp;&nbsp; 
									<span class="inactive">IA</span> : InActive &nbsp;&nbsp; 
									<span class="delaydays">DD</span> : Delayed days &nbsp;&nbsp;
									</p>
								</td>
							</tr>
							<tr>
								<td colspan="10" style="border:0;text-align: right; "><b>RPN :</b> Risk Priority Number</td>
							</tr>
							<tr>
								<th style="width: 15px; text-align: center" rowspan="2">SN</th>
								<th style="width: 20px;" rowspan="2">ID</th>
								<th style="width: 425px;" colspan="3">Risk
									<a data-toggle="modal" class="fa faa-pulse animated " data-target="#RiskTypesModal" data-whatever="@mdo" style="padding: 0px 1.5rem;cursor:pointer"><i class="fa fa-info-circle " style="font-size: 1.3rem;color: " aria-hidden="true"></i> </a>
								</th>
								<th style="width: 100px;" rowspan="1">ADC<br>PDC</th>
								<!-- <th style="width: 100px;" rowspan="1">ADC</th> -->
								<th style="width: 160px;" rowspan="1">Responsibility</th>
								<th style="width: 50px;" rowspan="1">Status(DD)</th>
								<th style="width: 200px;" rowspan="1">Remarks</th>
								
							</tr>
							<tr>
								<th style="text-align: center; width: 110px;">Severity<br>(1-10)</th>
								<th style="text-align: center; width: 110px;">Probability<br>(1-10)</th>
								<th style="text-align: center; width: 110px;">RPN<br>(1-100)</th>
								<th style="width: 200px" colspan="3">Mitigation Plans</th>
								<th style="width: 205px" colspan="2">Impact</th>
							</tr>

						</thead>

						<tbody>
							<% 	if (riskmatirxdata.get(z).size() > 0) { 
								int i = 0; %>
							<% 	for (Object[] obj : riskmatirxdata.get(z)) {
								i++; %>
							<tr>
								<td style="text-align: center" rowspan="2"><%=i%></td>
								
																<td style="text-align: center;" rowspan="2">
									<%if(obj[25]!=null && Long.parseLong(obj[25].toString())>0){
										String []tempArray=obj[13].toString().split("/");
										String tempRisk=tempArray[tempArray.length-1];
										%>
										<button type="button" class="btn btn-sm "  onclick="ActionDetails( <%=obj[25] %>);" data-toggle="tooltip" data-placement="bottom" title="Action Details" style="font-weight: bold" >
											<!-- <i class="fa fa-info-circle fa-lg " style="color: #145374" aria-hidden="true"></i> -->
										<%=tempRisk %>
										</button>
									<%}%>
								</td>
								<td style="text-align: justify; " colspan="3">
									<%=obj[0]%>  <span style="color: #3D60FF;font-weight: bold;"> - <%=obj[23] %><%=obj[24]%></span>
								</td>
								<td style="text-align: center" rowspan="1">
										<%	String actionstatus = obj[15].toString();
										LocalDate pdcorg = LocalDate.parse(obj[9].toString());
										LocalDate enddate = LocalDate.parse(obj[17].toString());
										LocalDate lastdate = obj[20]!=null ? LocalDate.parse(obj[20].toString()): null;
										LocalDate today = LocalDate.now();
										int progress = obj[18]!=null ? Integer.parseInt(obj[18].toString()) : 0;
									%> 
									<% if(lastdate!=null && actionstatus.equalsIgnoreCase("C") ){%>
										<%if(actionstatus.equals("C") && (pdcorg.isAfter(lastdate) || pdcorg.equals(lastdate))){%>
											<span class="completed"><%= sdf.format(sdf1.parse(obj[20].toString()))%> </span>
										<%}else if(actionstatus.equals("C") && pdcorg.isBefore(lastdate)){ %>	
											<span class="completeddelay"><%= sdf.format(sdf1.parse(obj[20].toString()))%> </span>
										<%} %>	
									<%}else{ %>
										-									
									<%} %>
								<br>
									
									<%if(!enddate.equals(pdcorg)){ %>
									<%=sdf.format(sdf1.parse(obj[17].toString()))%>
									<br>
									<%} %>
									<%=sdf.format(sdf1.parse(obj[9].toString()))%>
								</td>
								<td rowspan="1"><%=obj[7]%><%-- ,&nbsp;<%=obj[8] %> --%></td>
								<td style="text-align: center" rowspan="1">
									<% if(lastdate!=null && actionstatus.equalsIgnoreCase("C") ){ %>
										<%if(actionstatus.equals("C") && (pdcorg.isAfter(lastdate) || pdcorg.equals(lastdate))){%>
											<span class="completed">CO</span>
										<%}else if(actionstatus.equals("C") && pdcorg.isBefore(lastdate)){ %>	
											<span class="completeddelay">CD (<%= ChronoUnit.DAYS.between(pdcorg, lastdate) %>) </span>
										<%} %>	
									<%}else{ %>
										<%if(actionstatus.equals("F")  && (pdcorg.isAfter(lastdate) || pdcorg.isEqual(lastdate) )){ %>
											<span class="ongoing">RC</span>												
										<%}else if(actionstatus.equals("F")  && pdcorg.isBefore(lastdate)) { %>
											<span class="delay">FD</span>
										<%}else if(actionstatus.equals("A") && progress==0){  %>
											<span class="assigned">
												AA <%if(pdcorg.isBefore(today)){ %> (<%= ChronoUnit.DAYS.between(pdcorg, today)  %>) <%} %>
											</span>
										<%} else if(pdcorg.isAfter(today) || pdcorg.isEqual(today)){  %>
											<span class="ongoing">OG</span>
										<%}else if(pdcorg.isBefore(today)){  %>
											<span class="delay">DO (<%= ChronoUnit.DAYS.between(pdcorg, today)  %>)  </span>
										<%} %>					
																							
									<%} %>

								</td>
								<td style="text-align: justify" rowspan="1">
									<% if (obj[19] != null) { %> <%=obj[19]%> <% } %>
								</td>
							</tr>
							<tr>
								<td style="text-align: center;"><%=obj[1]%></td>
								<td style="text-align: center;"><%=obj[2]%></td>
								<td style="text-align: center;">
									<%=obj[22]%>
									<% int RPN =Integer.parseInt(obj[22].toString());
											if(RPN>=1 && RPN<=25){ %>(Low)
											<%}else if(RPN>=26 && RPN<=50){ %>(Medium)
											<%}else if(RPN>=51 && RPN<=75){ %>(High)
											<%}else if(RPN>=76){ %>(Very High)
											<%} %>
								</td>
								<td style="text-align: justify;" colspan="3"><%=obj[3]%></td>
								<td style="text-align: justify;" colspan="2"><%=obj[21]%></td>
							</tr>

							<% if (riskmatirxdata.get(z).size() > i) { %>
							<tr>
								<td colspan="10" style="color: transparent;">.</td>
							</tr>
							<% } %>

							<% } %>

							<% } else { %>
							<tr>
								<td colspan="10" style="text-align: center;">Nil</td>
							</tr>
							<% } %>
						</tbody>
					</table>

					<% } %>
				</div>
			</div>
			<!-- ----------------------------------------   P-6c Div ----------------------------------------------------- -->

			<!-- ---------------------------------------- P-7a  Details of Procurement Plan Div ----------------------------------------------------- -->
<% int chapter=1;int chapter2=1;
for (int z = 0; z < projectidlist.size(); z++){  %>
			<div class="carousel-item ">

				<div class="content-header row ">
					
					<div class="col-md-1" >
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
					<div class="col-md-1" align="left" style="padding-top:5px;" >
						<b style="margin-left: -35px;"><%=ProjectCode %></b>
						<h6 style="font-size: 0.8rem;margin-left: -43px;"><%=pdc %></h6>
					</div>
					<div class="col-md-8">
						<h3>7 (a<%if(projectidlist.size()>1) {%><%="."+chapter++%><%} %>) Details of Procurement Plan (Major Items) (<%=ProjectDetail.get(z)[1]%>)</h3>
					</div>
					<div class="col-md-1" align="right"  style="padding-top:19px;" >
						<b style="margin-right: -35px;"><%=MeetingNo %></b>
					</div>
					<div class="col-md-1">
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
					
				</div>

				<div class="content">
					
					<% if (ProjectDetail.size() > 1) { %>
					<div>
						<b>Project : <%=ProjectDetail.get(z)[1]%> <% if (z != 0) {  %>(SUB)<% }  %> </b>
					</div>
					<% } %>
					
									<table class="subtables" style=" margin-left: 8px;margin-top:5px;font-size: 16px; border-collapse: collapse;border: 1px solid black" >
										<thead>
										<tr>
											<th colspan="11" style="text-align: right;"> <span class="currency" >(In &#8377; Lakhs)</span></th>
										</tr>
										 <tr>
										 	<th colspan="11" class="std">Demand Details ( > &#8377; <% if (projectdatadetails.get(0) != null && projectdatadetails.get(0)[13] != null) { %>
													<%=projectdatadetails.get(0)[13].toString().replaceAll("\\.\\d+$", "")%> ) <% } else { %> - )<% } %>
												
											</th>
										</tr>
										</thead>
										
										<tr>
											<th class="std" style="border: 1px solid black;width: 30px !important;">SN</th>
											<th class="std" style="border: 1px solid black;max-width:90px;">Demand No<br>Demand Date</th>
<!-- 											<th class="std" style="border: 1px solid black;max-width:90px; ">Demand Date</th>
 -->											<th class="std" colspan="4" style="border: 1px solid black;max-width: 150px;"> Nomenclature</th>
											<th class="std" style="border: 1px solid black;max-width:90px;"> Est. Cost</th>
											<th class="std" style="border: 1px solid black;max-width:80px; "> Status</th>
											<th class="std" colspan="3" style="border: 1px solid black;max-width:200px;">Remarks</th>
										</tr>
										    <% int k=0;
										    if(procurementOnDemand.get(z)!=null &&  procurementOnDemand.get(z).size()>0){
										    Double estcost=0.0;
										    Double socost=0.0;
										    for(Object[] obj : procurementOnDemand.get(z)){ 
										    	k++; %>
											<tr>
												<td class="std"  style=" border: 1px solid black;"><%=k%></td>
												<td class="std"  style=" border: 1px solid black;"><%=obj[1]%><br><%=sdf.format(sdf1.parse(obj[3].toString()))%></td>
<%-- 												<td class="std"  style=" border: 1px solid black;"><%=sdf.format(sdf1.parse(obj[3].toString()))%></td>
 --%>												<td class="std" colspan="4" ><%=obj[8]%></td>
												<td class="std" style=" text-align:right;"> <%=format.format(new BigDecimal(obj[5].toString())).substring(1)%></td>
												<td class="std"  style=" border: 1px solid black;"> <%=obj[10]%> </td>
												<td class="std" colspan="3" style=" border: 1px solid black;"><%=obj[11]%> </td>		
											</tr>		
											<%
											estcost += Double.parseDouble(obj[5].toString());
										    }%>
										    
										    <tr>
										    	<td class="std" colspan="8" style="text-align: right;"><b>Total</b></td>
										    	<td class="std" style="text-align: right;"><b><%=df.format(estcost)%></b></td>
										    	
										    	<td class="std" colspan="2" style="text-align: right;"></td>

										    </tr>
										    
										    
										    <% }else{%>											
												<tr><td colspan="11" style="border: 1px solid black;text-align: center;" class="std" >Nil </td></tr>
											<%} %>
											<!-- ********************************Future Demand Start *********************************** -->
											<tr>
											<th class="std" colspan="11" style="border: 1px solid black"><span class="mainsubtitle">Future Demand</span></th>
											</tr>
											<tr>
												 <th class="std" style="border: 1px solid black;width: 15px !important;text-align: center;">SN</th>
													 <th class="std"  colspan="4" style="border: 1px solid black;;width: 295px;"> Nomenclature</th>
													 <th class="std" style="border: 1px solid black;width: 80px;"> Est. Cost-Lakh &#8377;</th>
													 <th class="std" style="border: 1px solid black;max-width:50px; "> Status</th>
													 <th class="std" colspan="4" style="border: 1px solid black;max-width: 310px;">Remarks</th>
											</tr>
										
										    			    <% int a=0;
										    if(envisagedDemandlist!=null &&  envisagedDemandlist.size()>0){
										    Double estcost=0.0;
										    Double socost=0.0;
										    for(Object[] obj : envisagedDemandlist){ 
										    	a++; %>
											<tr>
												<td class="std"  style=" border: 1px solid black;"><%=a%></td>
												<td class="std" colspan="4" style="border: 1px solid black;" ><%=obj[3]%></td>
												<td class="std" style="border: 1px solid black; text-align:right;"> <%=format.format(new BigDecimal(obj[2].toString())).substring(1)%></td>
												<td class="std"  style=" border: 1px solid black;"> <%=obj[6]%> </td>
												<td class="std" colspan="4" style="border: 1px solid black;"><%=obj[4]%> </td>		
											</tr>		
											<%
												estcost += Double.parseDouble(obj[2].toString());
										    }%>
										    
										    <tr>
										    	<td  class="std"colspan="7" style="border: 1px solid black;text-align: right;"><b>Total</b></td>
										    	<td class="std" style="border: 1px solid black;text-align: right;" colspan="4"><b><%=df.format(estcost)%></b></td>
										    </tr>
										    
										    
										    <% }else{%>											
												<tr><td colspan="11" style="border: 1px solid black;text-align: center;" class="std" >Nil </td></tr>
											<%} %>
											
									<!-- ********************************Future Demand End *********************************** -->
											
											 <tr >
											 
												<th  class="std"  colspan="11">Orders Placed ( > &#8377; <% if (projectdatadetails.get(0) != null && projectdatadetails.get(0)[13] != null) { %>
													<%=projectdatadetails.get(0)[13].toString().replaceAll("\\.\\d+$", "")%> ) <% } else { %> - )<% } %>
												</th>
											 </tr>
										
										  	 <tr>	
										  	 	 <th class="std" rowspan="1" style="border: 1px solid black;width: 30px !important;">SN</th>
										  	 	 <th class="std" style="border: 1px solid black;width:150px;">Demand No <br>Demand  Date</th>
										  	 	<!--  <th class="std" style="border: 1px solid black;" >Demand  Date</th> -->
												 <th class="std" colspan="2" style="border: 1px solid black;"> Nomenclature</th>
												 <th class="std"  style=" border: 1px solid black;width: 150px;">Supply Order No <br> SO Date </th>
												 <th class="std"  colspan="1" style="border: 1px solid black;width:100px">SO Cost-Lakh &#8377;</th>
												<!--  <th class="std" style="border: 1px solid black;max-width:90px;	">DP Date</th> -->
													 <th class="std" style="border: 1px solid black;width:100px;">DP Date<br> Rev DP</th>
												 <th class="std" colspan="2" style="border: 1px solid black;width: 200px;">Vendor Name</th>
												 <th class="std" style="border: 1px solid black;max-width:80px; "> Status</th>
												<th class="std" style="border: 1px solid black;width:200px; "> Remarks</th>
												</tr>
											
											
											<%if(procurementOnSanction.get(z)!=null && procurementOnSanction.get(z).size()>0){ 
												  int rowk=0;
										    	  Double estcost=0.0;
												  Double socost=0.0;
												  String demand="";
												  List<Object[]> list = new ArrayList<>();
												  for(Object[] obj:procurementOnSanction.get(z)){ 
													if(obj[2]!=null){
														if(!obj[1].toString().equalsIgnoreCase(demand)){
															rowk++;
											  	 		 	 list = procurementOnSanction.get(z).stream().filter(e-> e[0].toString().equalsIgnoreCase(obj[0].toString())).collect(Collectors.toList());
														}
													}
													  
											%>
					<tr>
					<td <%if(!obj[1].toString().equalsIgnoreCase(demand)){ %>  style="border: 1px solid black;border-bottom:none;"<%} else{ %> style="border: 1px solid black;border-bottom:none;border-top:none;"<%} %>>
					<%if(!obj[1].toString().equalsIgnoreCase(demand)){ %>
					<%=rowk %>
					<%} %>
					</td>
					<td <%if(!obj[1].toString().equalsIgnoreCase(demand)){ %> style="border: 1px solid black;border-bottom:none;"<%} else{ %> style="border: 1px solid black;border-bottom:none;border-top:none;"<%} %>>
					<%if(!obj[1].toString().equalsIgnoreCase(demand)){ %><%if(obj[1]!=null) {%> <%=obj[1].toString()%><% }else{ %>-<%} %><br>
					<%=sdf.format(sdf1.parse(obj[3].toString()))%>
					<%} %>
					</td>
					<td colspan="2" <%if(!obj[1].toString().equalsIgnoreCase(demand)){ %> style="border: 1px solid black;border-bottom:none;"<%} else{ %> style="border: 1px solid black;border-bottom:none;border-top:none;"<%} %>>
					<%if(!obj[1].toString().equalsIgnoreCase(demand)){ %>
					<%=obj[8]%>
					<%} %>
					</td>
				<td style="border: 1px solid black;text-align: center;">
				<% if(obj[2]!=null){%> <%=obj[2]%> <%}else{ %>-<%} %><br>
					<%if(obj[16]!=null){%> <%=sdf.format(sdf1.parse(obj[16].toString()))%> <%}else{ %> - <%} %>
				</td>
				<td style="border: 1px solid black;text-align: right"><%if(obj[6]!=null){%> <%=format.format(new BigDecimal(obj[6].toString())).substring(1)%> <%} else{ %> - <%} %></td>
				<td style="border: 1px solid black;">
				<%if(obj[4]!=null){%> <%=sdf.format(sdf1.parse(obj[4].toString()))%> <%}else{ %> - <%} %><br>
				<span style="text-align: center"><%if(obj[7]!=null){if(!obj[7].toString().equals("null")){%> <%=sdf.format(sdf1.parse(obj[7].toString()))%><%}}else{ %>-<%} %></span>	</td>
					<td colspan="2" style="border: 1px solid black;"><%=obj[12] %> </td>
					<td <%if(!obj[1].toString().equalsIgnoreCase(demand)){ %> style="border: 1px solid black;border-bottom:none;"<%} else{ %> style="border: 1px solid black;border-bottom:none;border-top:none;"<%} %>>
						<%if(!obj[1].toString().equalsIgnoreCase(demand)){ %>
					<%=obj[10]%>
					<%} %>
					
					</td>					
					<td <%if(!obj[1].toString().equalsIgnoreCase(demand)){ %> style="border: 1px solid black;border-bottom:none;"<%} else{ %> style="border: 1px solid black;border-bottom:none;border-top:none;"<%} %>>
						<%if(!obj[1].toString().equalsIgnoreCase(demand)){ %>
					<%=obj[11].toString()%>
					<%} %>
					</td>
					</tr>
											<%
											demand = obj[1].toString();
											Double value = 0.00;
								  	 		if(obj[6]!=null){
								  	 			value=Double.parseDouble(obj[6].toString());
								  	 		}
								  	 		
								  	 		estcost += Double.parseDouble(obj[5].toString());
								  	 		socost +=  value;
											}
											%>
											
												<tr>
										    	<td colspan="5" class="std" style="text-align: right;border: 1px solid black;"><b>Total</b></td>
										    	<td colspan="1" class="std" style="text-align: right;border: 1px solid black;"><b><%=df.format(socost)%></b></td>
										    	<td colspan="5" class="std" style="text-align: right;border: 1px solid black;"></td>
										   		 </tr>	
										 <% }else{%>
											
												<tr><td colspan="8" style="border: 1px solid black;" class="std"  style="text-align: center;">Nil </td></tr>
											<%} %>
									</table> 
					<table class="subtables" style="align: left; margin-top: 10px; margin-left: 25px;margin-bottom:10px;  border-collapse: collapse;">
						<thead>
							<tr>
								<th colspan="5" style="text-align: right; border: 0px;"><span class="currency">(In &#8377; Lakhs)</span></th>
							</tr>
							<tr>
								<th colspan="5"><span class="mainsubtitle">Total Summary of Procurement</span></th>
							</tr>
						</thead>

						<tbody>
							<tr>
								<th>No. of Demand</th>
								<th>Est. Cost</th>
								<th>No. of Orders</th>
								<th>SO Cost</th>
								<th>Expenditure</th>
							</tr>

							<% if (totalprocurementdetails != null && totalprocurementdetails.size() > 0) {
								for (TotalDemand obj : totalprocurementdetails) {
									if (obj.getProjectId().equalsIgnoreCase(projectidlist.get(z))) { %>
							<tr>
								<td style="text-align: center;"><%=obj.getDemandCount()%></td>
								<td style="text-align: center;"><%=obj.getEstimatedCost()%></td>
								<td style="text-align: center;"><%=obj.getSupplyOrderCount()%></td>
								<td style="text-align: center;"><%=obj.getTotalOrderCost()%></td>
								<td style="text-align: center;"><%=obj.getTotalExpenditure()%></td>
							</tr>
							<% } } } else { %>
							<tr>
								<td class="std" colspan="5" style="text-align: center;">IBAS
									Server Could Not Be Connected</td>
							</tr>
							<% } %>
						</tbody>
					</table>
			
				
				</div>

			</div>


			<!-- ----------------------------------------  Details of Procurement Plan Div ----------------------------------------------------- -->
			
			<!-- ---------------------------------------- P-7b  Procurement status Report Div ----------------------------------------------------- -->

 <%--for (int z = 0; z < projectidlist.size(); z++) { %> --%>
			<div class="carousel-item ">

				<div class="content-header row ">
					
					<div class="col-md-1" >
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
					<div class="col-md-1" align="left" style="padding-top:5px;" >
						<b style="margin-left: -35px;"><%=ProjectCode %></b>
						<h6 style="font-size: 0.8rem;margin-left: -43px;"><%=pdc %></h6>
					</div>
					<div class="col-md-8">
						<h3>7 (b<%if(projectidlist.size()>1) {%><%="."+(chapter2++)%><%} %>) Procurement Status <%if(projectidlist.size()>1) {%> (<%=ProjectDetail.get(z)[1]%> ) <%} %></h3>
					</div>
					<div class="col-md-1" align="right"  style="padding-top:19px;" >
						<b style="margin-right: -35px;"><%=MeetingNo %></b>
					</div>
					<div class="col-md-1">
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
					
				</div>

				<div class="content">
					
					<%
					if (ProjectDetail.size() > 1) {
					%>
					<div>
						<b>Project : <%=ProjectDetail.get(z)[1]%> <% if (z != 0) {  %>(SUB)<% }  %> </b>
					</div>
					<% } %>

			
							 		<table  style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px; border-collapse:collapse;width: 1375px;font-size: 12px;" >
									<thead>
										<tr>
											<th colspan="29" style="text-align: right; border: 0px;"><span class="currency">(In &#8377; Lakhs)</span></th>
										</tr>
										<tr>
											<th colspan="29" ><span class="mainsubtitle">Procurement Status</span></th>
									 	</tr>
									 	<tr>
											<th style="width: 40x">SN</th>
											<th style="width: 280px;">Item Name</th>
											<th style="width: 155px;">Est/SO Cost <br><span class="currency" style="font-weight: bold;" >(In &#8377; Lakhs)</span></th>
										<%for(int i=0;i<=25;i++) {%>
										<th style="width: 35px"><%=i %></th>
										<%} %>
									 	</tr>
									</thead>
									<tbody>
								    <%	List<Object[]> procuremntsList = new ArrayList<>();
											if( procurementOnDemand.get(z)!=null ){  procuremntsList.addAll(procurementOnDemand.get(z)); }
											if( procurementOnSanction.get(z)!=null ){  procuremntsList.addAll(procurementOnSanction.get(z)); }
									%>
									     <%int psn=0; for(Object[] proc : procuremntsList){psn++; %>
											  <tr>
												<td style="text-align:center; "><%=psn %></td>
												<td>
													<%if(proc[8].toString().length()>60){ %>
													<%=proc[8].toString().substring(0,60) %> ...
													<%}else{ %>
													<%=proc[8]%>
													<%} %>
												</td>
												<td style="text-align: right;">
													<%if(proc[9].toString().equalsIgnoreCase("S")){ %>
														<%=proc[6] %>
													<%}else{ %>
														<%=proc[5] %>
													<%} %>
												</td>
												<td style="background-color: green;"></td>
												<% int filestatus = Integer.parseInt(proc[13].toString());
													int tempstatus = filestatus;
												%>
												<%for(int tdc=1;tdc<=25;tdc++){ %>
												
													<%if(filestatus>11){  filestatus--;  } %>
													<%if(filestatus>25){  filestatus--;  } %>
													
													
													<%if(tdc < (tempstatus)){ %>
														<td style="background-color: green;"></td>
													<%}else if(tdc == (tempstatus)){ %>
														<td style="background-color: green;text-align: center;color: white ">*</td>
													<%}else if(tdc >(tempstatus)){ %>
														<td style=""></td>
													<%} %>
													
												<%} %>
											</tr>
									<%}if(envisagedDemandlist!=null && envisagedDemandlist.size()>0){
										for(Object[] envi : envisagedDemandlist){psn++; %>
										<tr>
												<td style="text-align:center; "><%=psn %></td>
												<td><%=envi[3] %></td>
												<td style="text-align: right;"><%=envi[2] %></td>
												<td style="background-color: #F96E16;text-align: center; ">*</td>
												<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
												</tr>
										<%}} %>

										
										<%if(psn ==0 && envisagedDemandlist.size()==0 ){ %>
											<tr>
										      <td colspan="29" style="text-align: center;">Nil</td>
										   </tr>
										<%} %>
										
								 	</tbody>
								</table>
								<table class="subtables" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;width:1370px !important;  border-collapse:collapse;font-size: 12px;" >
								    <tr>
										<td>0</td>
										<td>Demand to be Initiated</td>
										<td>7</td>
										<td>TCEC Approved</td>
										<td>14</td>
										<td>CDR</td>
										<td>21</td>
										<td>Inward Inspection Clearance</td>
									</tr>
									<tr>
							            <td>1</td>
										<td>Demand Initiated</td>
										<td>8</td>
										<td>TPC Approved</td>
										<td>15</td>
										<td>Acceptance of Critical BoM by Dev Partner</td>
										<td>22</td>
										<td>Payment Process</td>
									</tr>
									<tr>
										<td>2</td>
										<td>SPC Cleared</td>
									    <td>9</td>
										<td>Financial Sanction</td>
										<td>16</td>
										<td>Realization Completed</td>
										<td>23</td>
										<td>Partially Paid</td>
									</tr>
									<tr>
										<td>3</td>
										<td>Demand Approved</td>
									    <td>10</td>
										<td>Order Placement</td>
										<td>17</td>
										<td>FAT Completed</td>
										<td>24</td>
										<td>Payment Released</td>
									</tr>
									<tr>
										<td>4</td>
										<td>Tender Enquiry Floated</td>
										<td>11</td>
										<td>PDR</td>
										<td>18</td>
										<td>ATP/QTP Completed</td>
										<td>25</td>
										<td>Available for Integration</td>
									</tr>
									<tr>
										<td>5</td>
										<td>Receipt of Quotations</td>
										<td>12</td>
										<td>SO for Critical BoM by Dev Partner</td>
										<td>19</td>
										<td>Delivery at Stores</td>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<td>6</td>
										<td>Tender Opening</td>
										<td>13</td>
										<td>DDR</td>
										<td>20	</td>
										<td>SAT / SoFT</td>
										<td></td>
										<td></td>
									</tr>
								</table>
					</div></div><% } %>
			<!-- ---------------------------------------- Procurement status Report Div ----------------------------------------------------- -->

			<!-- ---------------------------------------- P-8  Overall Financial Status Div ----------------------------------------------------- -->
	<% char fch='a'; for (int z = 0; z < projectidlist.size(); z++) {%>
			<div class="carousel-item ">

				<div class="content-header row ">
					
					<div class="col-md-1" >
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
					<div class="col-md-1" align="left" style="padding-top:5px;" >
						<b style="margin-left: -35px;"><%=ProjectCode %></b>
						<h6 style="font-size: 0.8rem;margin-left: -43px;"><%=pdc %></h6>
					</div>
					<div class="col-md-8">
						<h3>8<%if(projectidlist.size()>1) {%> (<%=(fch++) %>) <%} %>.  Overall Financial Status</h3>
					</div>
					<div class="col-md-1" align="right"  style="padding-top:19px;" >
						<b style="margin-right: -35px;"><%=MeetingNo %></b>
					</div>
					<div class="col-md-1">
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
					
				</div>

				<div class="content">
					<%
						double totSanctionCost=0,totReSanctionCost=0,totFESanctionCost=0;
	                	double totExpenditure=0,totREExpenditure=0,totFEExpenditure=0;
	                 	double totCommitment=0,totRECommitment=0,totFECommitment=0,totalDIPL=0,totalREDIPL=0,totalFEDIPL=0;
		                double totBalance=0,totReBalance=0,totFeBalance=0,btotalRe=0,btotalFe=0;
						%>
					<% if (ProjectDetail.size() > 1) { %>
					<div>
						<b>Project : <%=ProjectDetail.get(z)[1]%> <% if (z != 0) {  %>(SUB)<% }  %> </b>
					</div>
					<% } %>

					<br>
					<table class="subtables" >
						<thead>
							<tr>
								<td colspan="14" style="text-align: right; border: 0px;"><span
									class="currency"><b>(In &#8377; Crore)</b></span></td>
							</tr>
							<tr>
								<th colspan="2" style="text-align: center; width: 200px !important;">Head </th>
								<th colspan="2" style="text-align: center; width: 120px !important;">Sanction </th>
								<th colspan="2" style="text-align: center; width: 120px !important;">Expenditure </th>
								<th colspan="2" style="text-align: center; width: 120px !important;">Out Commitment </th>
								<th colspan="2" style="text-align: center; width: 120px !important;">Balance </th>
								<th colspan="2" style="text-align: center; width: 120px !important;">DIPL </th>
								<th colspan="2" style="text-align: center; width: 120px !important;">Notional Balance </th>
							</tr>
							<tr>
								<th style="width: 30px !important; text-align: center;">SN</th>
								<th style="width: 180px !important;" width="10">Head</th>
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
			          <%if(IsIbasConnected==null || IsIbasConnected.equalsIgnoreCase("Y")) { %>
			                    <tbody>
			                    <% 

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
										<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getReBalance())%></td>
										<%totReBalance+=(projectFinancialDetail.getReBalance());%>
										<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getFeBalance())%></td>
										<%totFeBalance+=(projectFinancialDetail.getFeBalance());%>
									</tr>
			<%} }%>

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
			     <%}else{ %>
			     <tbody id="tbody<%=ProjectDetail.get(z)[0].toString()%>">
			     <%int count=0;
			     if(overallfinance!=null && overallfinance.size()>0 && overallfinance.get(z)!=null && overallfinance.get(z).size()>0)  {
			    	for(Object[]obj:overallfinance.get(z)){ 
			    	 %>
			    	 <tr>
			   <td align="center" style="max-width:50px !important;text-align: center;"><%=++count %></td>
				<td style="text-align: justify ;"><b><%=obj[4].toString()%></b></td>
				<td style="text-align: right;"><%=obj[5].toString()%></td>
				<td style="text-align: right;"><%=obj[6].toString()%></td>
				<td style="text-align: right;"><%=obj[7].toString()%></td>
				<td style="text-align: right;"><%=obj[8].toString()%></td>
				<td style="text-align: right;"><%=obj[9].toString()%></td>
				<td style="text-align: right;"><%=obj[10].toString()%></td>
				<td style="text-align: right;"><%=obj[11].toString()%></td>
				<td style="text-align: right;"><%=obj[12].toString()%></td>
				<td style="text-align: right;"><%=obj[13].toString()%></td>
				<td style="text-align: right;"><%=obj[14].toString()%></td>
				<td style="text-align: right;"><%=obj[15].toString()%></td>
				<td style="text-align: right;"><%=obj[16].toString()%></td>
				</tr>
			     <%}%>
			    	 	<tr>
						<td colspan="2"><b>Total</b></td>
						<td align="right" style="text-align: right;"><%=overallfinance.get(z).get(0)[17].toString()%></td>
						<td align="right" style="text-align: right;"><%=overallfinance.get(z).get(0)[18].toString()%></td>
						<td align="right" style="text-align: right;"><%=overallfinance.get(z).get(0)[19].toString()%></td>
						<td align="right" style="text-align: right;"><%=overallfinance.get(z).get(0)[20].toString()%></td>
						<td align="right" style="text-align: right;"><%=overallfinance.get(z).get(0)[21].toString()%></td>
						<td align="right" style="text-align: right;"><%=overallfinance.get(z).get(0)[22].toString()%></td>
						<td align="right" style="text-align: right;"><%=overallfinance.get(z).get(0)[23].toString()%></td>
						<td align="right" style="text-align: right;"><%=overallfinance.get(z).get(0)[24].toString()%></td>
						<td align="right" style="text-align: right;"><%=overallfinance.get(z).get(0)[25].toString()%></td>
						<td align="right" style="text-align: right;"><%=overallfinance.get(z).get(0)[26].toString()%></td>
						<td align="right" style="text-align: right;"><%=overallfinance.get(z).get(0)[27].toString()%></td>
						<td align="right" style="text-align: right;"><%=overallfinance.get(z).get(0)[28].toString()%></td>
					</tr>
			     	<tr>
						<td colspan="2"><b>GrandTotal</b></td>
						<td colspan="2" align="right" style="text-align: right;"><b><%=Double.parseDouble(overallfinance.get(z).get(0)[17].toString())  +Double.parseDouble(overallfinance.get(z).get(0)[18].toString())%></b></td>
						<td colspan="2" align="right" style="text-align: right;"><b><%=Double.parseDouble(overallfinance.get(z).get(0)[19].toString())  +Double.parseDouble(overallfinance.get(z).get(0)[20].toString())%></b></td>
						<td colspan="2" align="right" style="text-align: right;"><b><%=Double.parseDouble(overallfinance.get(z).get(0)[21].toString())  +Double.parseDouble(overallfinance.get(z).get(0)[22].toString())%></b></td>
						<td colspan="2" align="right" style="text-align: right;"><b><%=Double.parseDouble(overallfinance.get(z).get(0)[23].toString())  +Double.parseDouble(overallfinance.get(z).get(0)[24].toString())%></b></td>
						<td colspan="2" align="right" style="text-align: right;"><b><%=Double.parseDouble(overallfinance.get(z).get(0)[25].toString())  +Double.parseDouble(overallfinance.get(z).get(0)[26].toString())%></b></td>
						<td colspan="2" align="right" style="text-align: right;"><b><%=Double.parseDouble(overallfinance.get(z).get(0)[27].toString())  +Double.parseDouble(overallfinance.get(z).get(0)[28].toString())%></b></td>				     
			     	</tr>
			     <%}else{%> 
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
			     <% }%>
			     </tbody>
			     <% } %>
					</table></div></div>
			<% } %>
			<!-- ----------------------------------------  Overall Financial Status Div ----------------------------------------------------- -->

			<!-- ---------------------------------------- P-9  Action Plan for Div ----------------------------------------------------- -->

			<div class="carousel-item ">

				<div class="content-header row ">
					
					<div class="col-md-1" >
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
					<div class="col-md-1" align="left" style="padding-top:5px;" >
						<b style="margin-left: -35px;"><%=ProjectCode %></b>
						<h6 style="font-size: 0.8rem;margin-left: -43px;"><%=mainpdc %></h6>
					</div>
					<div class="col-md-8">
						<h3>
							<% if (CommitteeCode.equalsIgnoreCase("EB")) { %>
								9. Action Plan for Next Six Months
							<% } else { %>
								9. Action Plan for Next Three Months
							<% } %>
						</h3>
					</div>
					<div class="col-md-1" align="right"  style="padding-top:19px;" >
						<b style="margin-right: -35px;"><%=MeetingNo %></b>
					</div>
					<div class="col-md-1">
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
					
				</div>

				<div class="content">
					<% for (int z = 0; z < 1; z++) { %>
					<% if (ProjectDetail.size() > 1) { %>
					<div>
						<b>Project : <%=ProjectDetail.get(z)[1]%> <% if (z != 0) {  %>(SUB)<% }  %> </b>
					</div>
					<% } %>

					<!-- CALL Pfms_Milestone_PDC_New(:projectid, :interval) -->
					<table class="subtables" style="align: left; margin-top: 10px;  margin-left: 25px; border-collapse: collapse;">
						<thead>
							<tr>
								<td colspan="10" style="border: 0">
									<p style="font-size: 12px; text-align: center">
										<span class="notassign">NA</span> : Not Assigned &nbsp;&nbsp;
										<span class="assigned">AA</span> : Activity Assigned &nbsp;&nbsp; 
										<span class="ongoing">OG</span> : On Going &nbsp;&nbsp; 
										<span class="delay">DO</span> : Delay - On Going &nbsp;&nbsp; 
										<span class="ongoing">RC</span> : Review & Close &nbsp;&nbsp; 
										<span class="delay">FD</span> : Forwarded With Delay &nbsp;&nbsp; 
										<!-- <span class="completed">CO</span> :Completed &nbsp;&nbsp; 
										<span class="completeddelay">CD</span> : Completed with Delay &nbsp;&nbsp;  -->
										<span class="inactive">IA</span> : InActive &nbsp;&nbsp; 
										<span class="delaydays">DD</span> : Delayed days &nbsp;&nbsp;
									</p>
								</td>
							</tr>

							<tr>
								<th style="width: 15px !important; text-align: center;">SN</th>
								<th style="width: 20px;">MS</th>
								<th style="width: 40px;">L</th>
								<th style="width: 265px;">Action Plan</th>
								<th style="width: 110px;">PDC</th>
								<%if(!session.getAttribute("labcode").toString().equalsIgnoreCase("ADE")) {%>
									<th style="width: 200px;">Responsibility </th>
									<%} %>
								<th style="width: 50px;">Progress</th>
								<th style="width: 50px; padding-right: 5px !important;">Status(DD)</th>
								<th style="width: 220px;">Remarks</th>
								<th style="width: 30px;">Info</th>
							</tr>
						</thead>
						<tbody>
							<%
							if (actionplanthreemonths.get(z).size() > 0) {
								long count1 = 1;
								int countA = 1;
								int countB = 1;
								int countC = 1;
								int countD = 1;
								int countE = 1;

								int serialno = 1;
								for (Object[] obj : actionplanthreemonths.get(z)) {

									if (Integer.parseInt(obj[26].toString()) <= Integer.parseInt(levelid)) {
								/*  if(obj[26].toString().equals("0")||obj[26].toString().equals("1")){ */
							%>

							<tr>
								<td style="text-align: center;"><%=serialno%></td>
								<td style="text-align: center">M<%=obj[22]%></td>
								<td style="text-align: center">
									<%
									if (obj[26].toString().equals("0")) {
									%> <!-- L --> <%
									 countA = 1;
									 countB = 1;
									 countC = 1;
									 countD = 1;
									 countE = 1;
									 } else if (obj[26].toString().equals("1")) {
											for(Map.Entry<Integer,String>entry:treeMapLevOne.entrySet()){
												if(entry.getKey().toString().equalsIgnoreCase(obj[2].toString())){%>
													<%=entry.getValue() %>
											<%}}  
									 %> 
									 
									 
									 <%-- A-<%=countA%>  --%><%
									/*  countA++;
									 countB = 1;
									 countC = 1;
									 countD = 1;
									 countE = 1; */
									 } else if (obj[26].toString().equals("2")) {
										 
										 for(Map.Entry<Integer,String>entry:treeMapLevTwo.entrySet()){
												if(entry.getKey().toString().equalsIgnoreCase(obj[3].toString())){%>
													<%=entry.getValue() %>
											<%}}  
									 %> <%-- B-<%=countB%> --%> <%
								/* 	 countB += 1;
									 countC = 1;
									 countD = 1;
									 countE = 1; */
									 } else if (obj[26].toString().equals("3")) {
									 %> C-<%=countC%> <%
									 countC += 1;
									 countD = 1;
									 countE = 1;
									 } else if (obj[26].toString().equals("4")) {
									 %> D-<%=countD%> <%
									 countD += 1;
									 countE = 1;
									 } else if (obj[26].toString().equals("5")) {
									 %> E-<%=countE%> <%
									 countE++;
									 }
									 %>
								</td>

								<td style="<%if (obj[26].toString().equals("0")) { %>font-weight: bold;<%}%>;text-align:justify ">
									<% if (obj[26].toString().equals("0")) { %> <%=obj[9]%> 
									<%}else if (obj[26].toString().equals("1")) { %>&nbsp;&nbsp;<%=obj[10]%> 
									<%}else if (obj[26].toString().equals("2")) { %>&nbsp;&nbsp;<%=obj[11]%> 
									<%}else if (obj[26].toString().equals("3")) { %>&nbsp;&nbsp;<%=obj[12]%> 
									<%}else if (obj[26].toString().equals("4")) { %>&nbsp;&nbsp;<%=obj[13]%> 
									<%}else if (obj[26].toString().equals("5")) { %>&nbsp;&nbsp;<%=obj[14]%> 
									<%}%>
								</td>
								<td style="text-align: center">
									<%
									if (!LocalDate.parse(obj[8].toString()).isEqual(LocalDate.parse(obj[29].toString())) ) {%>
									<span <%if(LocalDate.parse(obj[8].toString()).isBefore(LocalDate.parse(todayDate))) {%> style="color:maroon;font-weight: bold;"<%}else{ %>style="color:black; font-weight: bold;"<%} %>><%=sdf.format(sdf1.parse(obj[8].toString()))%></span><br> 
									<%}%> 
								<span <% if (LocalDate.parse(obj[8].toString()).isEqual(LocalDate.parse(obj[29].toString()))&& LocalDate.parse(obj[29].toString()).isBefore(LocalDate.parse(todayDate))){%>style="color:maroon;font-weight: bold;"<%}else if(LocalDate.parse(obj[8].toString()).isEqual(LocalDate.parse(obj[29].toString()))) {%>style="font-weight: bold;"<%} %>><%=sdf.format(sdf1.parse(obj[29].toString()))%></span>
								</td>
																<%if(!session.getAttribute("labcode").toString().equalsIgnoreCase("ADE")) {%>
								
								<td><%=obj[24]%><%-- (<%=obj[25] %>) --%></td>
								
								<%} %>
								<td style="text-align: center"><%=obj[16]%>%</td>
								
								<% 
									LocalDate StartDate = LocalDate.parse(obj[7].toString());
									LocalDate EndDate = LocalDate.parse(obj[8].toString());
									LocalDate OrgEndDate = LocalDate.parse(obj[29].toString());
									int Progess = Integer.parseInt(obj[16].toString());
									LocalDate CompletionDate =obj[18]!=null ? LocalDate.parse(obj[18].toString()) : null;
									LocalDate Today = LocalDate.now();
								%>
								<td style="text-align: center">
									<%if(Progess==0){ %>
										<span class="assigned"> AA </span>
									<%} else if(Progess>0 && Progess<100 && (OrgEndDate.isAfter(Today) || OrgEndDate.isEqual(Today) )){ %>
										<span class="ongoing"> OG </span>
									<%} else if( Progess>0 && Progess<100 && (OrgEndDate.isBefore(Today) )){ %>
										<span class="delay"> DO (<%=ChronoUnit.DAYS.between(OrgEndDate, LocalDate.now())%>)</span>
									<%} else if((CompletionDate!=null && ( CompletionDate.isBefore(OrgEndDate) ||  CompletionDate.isEqual(OrgEndDate)))){ %>
										<span class="completed"> CO</span>
									<%} else if((CompletionDate!=null && CompletionDate.isAfter(OrgEndDate) )){ %>
										<span class="completeddelay">CD (<%=ChronoUnit.DAYS.between(OrgEndDate, CompletionDate)%>)</span>
									<%}else if(CompletionDate!=null && Progess==0 &&  ( EndDate.isAfter(Today) ||  EndDate.isEqual(Today)) ){ %>
										<span class="inactive">IA</span>
									<%}else{ %>
										<span class="assigned">AA</span>
									<%} %>
												
								</td>
								<td>
									<% if (obj[28] != null) { %> <%=obj[28]%> <% } %>
								</td>
								<td style="text-align: center">
						
									<a data-toggle="modal" data-target="#exampleModal1" data-id="milestonemodal<%=obj[0]%>" class="milestonemodal" data-whatever="@mdo" style=" cursor: pointer"> 
										<i class="fa fa-info-circle fa-lg " style="color: #145374" aria-hidden="true"></i>
									</a>
		
								</td>
							</tr>
							<% count1++;
							serialno++; }
								} %>
							<% } else { %>
								<tr>
									<td colspan="10" style="text-align: center;">Nil</td>
								</tr>
							<% } %>
						</tbody>
					</table>
					<% } %>
				</div>
			</div>
			<!-- ---------------------------------------- Action Plan for Div ----------------------------------------------------- -->

			<!-- ---------------------------------------- P-10  GANTT chart of overall project Div ----------------------------------------------------- -->

			<div class="carousel-item ">

				<div class="content-header row ">
					
					<div class="col-md-1" >
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
					<div class="col-md-1" align="left" style="padding-top:5px;" >
						<b style="margin-left: -35px;"><%=ProjectCode %></b>
						<h6 style="font-size: 0.8rem;margin-left: -43px;"><%=mainpdc %></h6>
					</div>
					<div class="col-md-8">
						<h3>10. GANTT Chart of Overall Project Schedule</h3>
					</div>
					<div class="col-md-1" align="right"  style="padding-top:19px;" >
						<b style="margin-right: -35px;"><%=MeetingNo %></b>
					</div>
					<div class="col-md-1">
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
					
				</div>


				<div class="content">
					<%
					for (int z = 0; z < 1; z++) {
					%>
					<div>
						<%
						if (ProjectDetail.size() > 1) {
						%>
						<div>
							<b>Project : <%=ProjectDetail.get(z)[1]%> <% if (z != 0) {  %>(SUB)<% }  %> </b>
						</div>
						<%
						}
						%>
						<div class="row">
							<div class="col-md-9 ">
								
							</div>
							<div class="col-md-1" align="right">
								<label style="margin-top: 10px; float: right;">Interval
									: &nbsp;&nbsp; </label>
							</div>
							<div class="col-md-2" align="left" style="margin-top: 10px;">
								<select class="form-control selectdee " name="interval_<%=projectidlist.get(z)%>" id="interval_<%=projectidlist.get(z)%>" required="required" data-live-search="true" style="width: 150px !important">
									<option value="quarter">Quarterly</option>
									<option value="half">Half-Yearly</option>
									<option value="year">Yearly</option>
									<option value="month">Monthly</option>
								</select>
							</div>
						</div>
						<!-- ---------------------------------gantt chart js ------------------------------------------------------ -->

						<div class="row" style="margin-top: 10px; font-weight: bold;">
							<div class="col-md-4"></div>
							<div class="col-md-4"></div>
							<div class="col-md-4">
								<div style="font-weight: bold;">
									<span style="margin: 0px 0px 10px 10px;">Original :&ensp; <span style="background-color: #046582; padding: 0px 15px; border-radius: 3px;"></span></span> 
									<span style="margin: 0px 0px 10px 15px;">Ongoing :&ensp; <span style="background-color: #81b214; padding: 0px 15px; border-radius: 3px;"></span> </span> 
									<span style="margin: 0px 0px 10px 15px;">Revised :&ensp; <span style="background-color: #f25287; opacity: 0.5; padding: 0px 15px; border-radius: 3px;"></span> </span>
								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-md-12" style="float: right;" align="center">
								<div class="flex-container containers" id="containers_<%=projectidlist.get(z)%>"></div>
							</div>
						</div>
					</div>
					<% } %>
				</div>
			</div>
			<!-- ---------------------------------------- GANTT chart of overall project Div ----------------------------------------------------- -->
			<!-- ---------------------------------------- P-11 Issues Div ----------------------------------------------------- -->
			<div class="carousel-item ">

				<div class="content-header row ">
					
					<div class="col-md-1" >
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
					<div class="col-md-1" align="left" style="padding-top:5px;" >
						<b style="margin-left: -35px;"><%=ProjectCode %></b>
						<h6 style="font-size: 0.8rem;margin-left: -43px;"><%=mainpdc %></h6>
					</div>
					<div class="col-md-8">
						<h3>11. Issues</h3>
					</div>
					<div class="col-md-1" align="right"  style="padding-top:19px;" >
						<b style="margin-right: -35px;"><%=MeetingNo %></b>
					</div>
					<div class="col-md-1">
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
					
				</div>

				<div class="content">
					<% for (int z = 0; z < 1; z++) { %>

					<% if (ProjectDetail.size() > 1) { %>
					<div>
						<b>Project : <%=ProjectDetail.get(z)[1]%> <% if (z != 0) {  %>(SUB)<% }  %> </b>
					</div>
					<% } %>
					<!-- CALL Old_Issues_List(:projectid); -->
					<table class="subtables" style="align: left; margin-top: 10px;  margin-left: 25px; border-collapse: collapse;">
						<thead>
							<tr>
								<td colspan="7" style="border: 0">
									<p style="font-size: 12px; text-align: center">
										<span class="notassign">NA</span> : Not Assigned &nbsp;&nbsp;
										<span class="assigned">AA</span> : Activity Assigned &nbsp;&nbsp; 
										<span class="ongoing">OG</span> : On Going &nbsp;&nbsp; 
										<span class="delay">DO</span> : Delay - On Going &nbsp;&nbsp; 
										<span class="ongoing">RC</span> : Review & Close &nbsp;&nbsp; 
										<span class="delay">FD</span> : Forwarded With Delay &nbsp;&nbsp; 
										<span class="completed">CO</span> :Completed &nbsp;&nbsp; 
										<span class="completeddelay">CD</span> : Completed with Delay &nbsp;&nbsp; 
										<span class="inactive">IA</span> : InActive &nbsp;&nbsp; 
										<span class="delaydays">DD</span> : Delayed days &nbsp;&nbsp;
									</p>
								</td>
							</tr>
							<tr>
								<th style="width: 20px !important; text-align: center;">SN</th>
								<th style="width: 20px;">ID</th>
								<th style="width: 350px;">Issue Point</th>
								<th style="width: 100px;">ADC <br> PDC</th>
								<!-- <th style="width: 100px;">ADC</th> -->
								<th style="width: 200px;">Responsibility</th>
								<th style="width: 50px;">Status(DD)</th>
								<th style="width: 220px;">Remarks</th>
							</tr>
						</thead>
						<tbody>
							<% if (oldpmrcissueslist.get(z).size() == 0) { %>
							<tr>
								<td colspan="7" style="text-align: center;">Nil</td>
							</tr>
							<% } else if (oldpmrcissueslist.get(z).size() > 0) {
							int i = 1;
							for (Object[] obj : oldpmrcissueslist.get(z)) {
								if(!obj[9].toString().equals("C")  || (obj[9].toString().equals("C") && obj[13]!=null && before6months.isBefore(LocalDate.parse(obj[13].toString())) )){ %>
							<tr>
								<td style="text-align: center;"><%=i%></td>
									<td style="text-align: center;" >
									<%if(obj[18]!=null && Long.parseLong(obj[18].toString())>0){
										String []temp=obj[1].toString().split("/");
										String tempString=temp[temp.length-1];
										%>
										<button type="button" class="btn btn-sm font-weight-bold"  onclick="ActionDetails( <%=obj[18] %>);" data-toggle="tooltip" data-placement="bottom" title="Action Details" >
										<%=tempString %>
										</button>
									<%}%>
								</td>
								<td style="text-align: justify;"> <%=obj[2]%> </td>
								<td style="text-align: center;">
																	<%	String actionstatus = obj[9].toString();
										int progress = obj[16]!=null ? Integer.parseInt(obj[16].toString()) : 0;
										LocalDate pdcorg = LocalDate.parse(obj[3].toString());
										LocalDate endDate = LocalDate.parse(obj[4].toString());
										LocalDate lastdate = obj[13]!=null ? LocalDate.parse(obj[13].toString()): null;
										LocalDate today = LocalDate.now();
									%> 
									<% if(lastdate!=null && actionstatus.equalsIgnoreCase("C") ){%>
										<%if(actionstatus.equals("C") && (pdcorg.isAfter(lastdate) || pdcorg.equals(lastdate))){%>
											<span class="completed"><%= sdf.format(sdf1.parse(obj[13].toString()))%> </span>
										<%}else if(actionstatus.equals("C") && pdcorg.isBefore(lastdate)){ %>	
											<span class="completeddelay"><%= sdf.format(sdf1.parse(obj[13].toString()))%> </span>
										<%} %>	
									<%}else{ %>
										-									
									<%} %>
									<br>
									<%if(!pdcorg.equals(endDate)) {%>
									<%=sdf.format(sdf1.parse(obj[4].toString()))%><br>
									<%} %>
									<%=sdf.format(sdf1.parse(obj[3].toString()))%>
								</td>
						<!-- 		<td style="text-align: center;">

								</td> -->
								<td><%=obj[11]%><%-- <%=obj[12] %> --%></td>
								<td style="text-align: center;">
									<%if(obj[4]!= null){ %> 
														
										<% if(lastdate!=null && actionstatus.equalsIgnoreCase("C") ){%>
											<%if(actionstatus.equals("C") && (pdcorg.isAfter(lastdate) || pdcorg.equals(lastdate))){%>
												<span class="completed">CO</span>
											<%}else if(actionstatus.equals("C") && pdcorg.isBefore(lastdate)){ %>	
												<span class="delay">CD (<%= ChronoUnit.DAYS.between(pdcorg, today)  %>)  </span>
											<%} %>	
										<%}else{ %>
											<%if(actionstatus.equals("F")  && (pdcorg.isAfter(lastdate) || pdcorg.isEqual(lastdate) )){ %>
												<span class="ongoing">RC</span>												
											<%}else if(actionstatus.equals("F")  && pdcorg.isBefore(lastdate)) { %>
												<span class="delay">FD</span>
											<%}else if(actionstatus.equals("A") && progress==0){  %>
												<span class="assigned">
													AA <%if(pdcorg.isBefore(today)){ %> (<%= ChronoUnit.DAYS.between(pdcorg, today)  %>) <%} %>
												</span>
											<%} else if(pdcorg.isAfter(today) || pdcorg.isEqual(today)){  %>
												<span class="ongoing">OG</span>
											<%}else if(pdcorg.isBefore(today)){  %>
												<span class="delay">DO (<%= ChronoUnit.DAYS.between(pdcorg, today)  %>)  </span>
											<%} %>										
										<%} %>
									<%}else { %>
										-
									<%} %>
								</td>
								<td>
									<% if (obj[17] != null) { %> <%=obj[17]%> <% } %>
								</td>
							
							</tr>
							<% i++; }}
							} %>
						</tbody>
					</table>
					<% } %>
				</div>

			</div>
			<!-- ---------------------------------------- Issues Div ----------------------------------------------------- -->
			<!-- ---------------------------------------- P-12 Decision/Recommendations sought Div ----------------------------------------------------- -->
			<div class="carousel-item ">
				<div class="content-header row ">
					<div class="col-md-1" >
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
					<div class="col-md-1" align="left" style="padding-top:5px;" >
						<b style="margin-left: -35px;"><%=ProjectCode %></b>
						<h6 style="font-size: 0.8rem;margin-left: -43px;"><%=mainpdc %></h6>
					</div>
					<div class="col-md-8">
						<h3> 12. Decision/Recommendations Sought from <%=CommitteeCode%> </h3>
					</div>
					<div class="col-md-1" align="right"  style="padding-top:19px;" >
						<b style="margin-right: -35px;"><%=MeetingNo %></b>
					</div>
					<div class="col-md-1">
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
				</div>
				<div class="content align-items-center" align="left">
					<table class="subtables" style="align: left; margin-top: 10px; border-collapse: collapse; width:100%;">
											<thead>
												<tr><th style="width: 5%;">SN</th><th style="width: 5%;">Type</th><th style="width: 85%;">Details</th></tr>
											</thead>
											<tbody>
												<%int i=0; if(RecDecDetails!=null && RecDecDetails.size()>0){ 
												for(Object[] obj :RecDecDetails){%>
												<tr>
													<td style="width: 5%; text-align: center;"> <%=++i%></td>
													<td style="width: 5%; text-align: center;"> <%=obj[2]%></td>
													<td style="width: 85%;  word-wrap: break-word;"> <%=obj[3]%></td>
												</tr>
												<%}}else{%><td colspan="3" style="text-align: center;"> No Data Available!</td><%}%>
											</tbody>
					</table>
				</div>
			</div>
			<!-- ---------------------------------------- Decision/Recommendations sought Div ----------------------------------------------------- -->
			<!-- ---------------------------------------- P-13a  Other Relevant Points Div ----------------------------------------------------- -->

			<div class="carousel-item ">
				<div class="content-header row ">
					<div class="col-md-1" >
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
					<div class="col-md-1" align="left" style="padding-top:5px;" >
						<b style="margin-left: -35px;"><%=ProjectCode %></b>
						<h6 style="font-size: 0.8rem;margin-left: -43px;"><%=mainpdc %></h6>
					</div>
					<div class="col-md-8">
						<h3>13 (a) Other Relevant Points</h3>
					</div>
					<div class="col-md-1" align="right"  style="padding-top:19px;" >
						<b style="margin-right: -35px;"><%=MeetingNo %></b>
					</div>
					<div class="col-md-1">
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
				</div>
				<div class="content">
					<% for (int z = 0; z < 1; z++) { %>
					<div align="left">
						<b>Project : <%=ProjectDetail.get(z)[1]%> <% if (z != 0) {  %>(SUB)<% }  %> </b>
					</div>
					<div class="card-body" style="width: 100%">
						<form action="TechnicalWorkDataAdd.htm" method="post">
							<div class="row" align="left">
								<div class="row" style="width: 100%; margin-left: 0.5rem; margin-top: -0.5rem;">
									<div class="col-12">
										<div>
							<% if (TechWorkDataList.get(z) != null) { %> <%=TechWorkDataList.get(z)[2]%> <%}%>
						</div></div></div></div>
						</form>
					</div>
					<% } %>
				</div>

			</div>


			<!-- ----------------------------------------p-13a Other Relevant Points Div ----------------------------------------------------- -->

			<!-- ---------------------------------------- P-13b Technical Work Carried Div ----------------------------------------------------- -->

			<div class="carousel-item ">

				<div class="content-header row ">
					
					<div class="col-md-1" >
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
					<div class="col-md-1" align="left" style="padding-top:5px;" >
						<b style="margin-left: -35px;"><%=ProjectCode %></b>
						<h6 style="font-size: 0.8rem;margin-left: -43px;"><%=mainpdc %></h6>
					</div>
					<div class="col-md-8">
						<h3>
							<% if (CommitteeCode.equalsIgnoreCase("EB")) { %>
								13 (b) Technical Work Carried Out For Last Six Months
							<% } else { %>
								13 (b) Technical Work Carried Out For Last Three Months
							<% } %>
						</h3>
					</div>
					<div class="col-md-1" align="right"  style="padding-top:19px;" >
						<b style="margin-right: -35px;"><%=MeetingNo %></b>
					</div>
					<div class="col-md-1">
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
					
				</div>

				<div class="content">

					<% ArrayList<String> FileExtList = new ArrayList<String>( Arrays.asList("jpg", "jpeg", "png", "pdf", "JPG", "JPEG", "PNG", "PDF"));
					
					for (int z = 0; z < 1; z++) {
					%>
					<div class="card-body" style="width: 100%">

						<div class="row" align="center" >
							<div class="col-6" style="text-align: left;">

								<form action="TechnicalWorkDataAdd.htm" method="post">
									<% if (TechWorkDataList.get(z) != null) { %>
									<input type="hidden" name="TechDataId" value="<%=TechWorkDataList.get(z)[0]%>"> <b>Project : <%=ProjectDetail.get(z)[1]%> <% if (z != 0) {  %>(SUB)<% }  %> </b> <span class="mainsubtitle">Technical Work Carried (Attachment)</span>
									<% if (TechWorkDataList.get(z)[3] != null && Long.parseLong(TechWorkDataList.get(z)[3].toString()) > 0) { %>
									<button type="button" class="btn" title="Download Document"
										onclick="FileDownload1('<%=TechWorkDataList.get(z)[3]%>');">
										<i class="fa fa-download" aria-hidden="true"> </i>
									</button>
									<input type="hidden" class="hidden" name="attachid"
										id="attachid_<%=projectidlist.get(z)%>"
										value="<%=TechWorkDataList.get(z)[3]%>">
									<% } else { %>
									<input type="hidden" class="hidden" name="attachid"
										id="attachid_<%=projectidlist.get(z)%>" value="0">
									<%}%><% } %>
								</form>
							</div>
						</div>
						<br>
						<div class="row">
							<div class="col-md-12" style="position: relative;width: 100%;padding-bottom: calc(8.5 / 11 * 100%);">
									
								<% 
								try{
								if (TechWorkDataList.get(z) != null && TechWorkDataList.get(z)[3] != null && Long.parseLong(TechWorkDataList.get(z)[3].toString()) > 0) { %>
								<% Object[] TechWork = TechWorkDataList.get(z);
								String fileExt = FilenameUtils.getExtension(TechWork[8].toString());
								String tecdata = TechWorkDataList.get(z)[6].toString().replaceAll("[/\\\\]", ",");
				        		String[] fileParts = tecdata.split(",");
				        		String zipName = String.format(TechWorkDataList.get(z)[7].toString()+TechWorkDataList.get(z)[11].toString()+"-"+TechWorkDataList.get(z)[10].toString()+".zip");
				        		Path techPath = null;
				        		if(fileParts.length == 4){
				        			techPath = Paths.get(filePath, fileParts[0],fileParts[1],fileParts[2],fileParts[3],zipName);
				        		}else{
				        			techPath = Paths.get(filePath, fileParts[0],fileParts[1],fileParts[2],fileParts[3],fileParts[4],zipName);
				        		}
								if (FileExtList.contains(fileExt) ) {%>
								<% String path = request.getServletContext().getRealPath("/view/temp");
								Zipper zip = new Zipper();
								zip.unpack(techPath.toString(), path, TechWorkDataList.get(z)[9].toString());
								File techattachfile = new File(path+File.separator+ TechWork[8]); %>

								<% if (fileExt.equalsIgnoreCase("pdf")) {%>
								<iframe  src="data:application/pdf;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(techattachfile))%>#view=FitV" style="width:100%;height:70vh" id="pearl<%=ProjectDetail.get(z)[0]%>"></iframe>
								<% } else { %>
								<img data-enlargable style="width: 98%;height:70vh;" src="data:image/<%=fileExt%>;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(techattachfile))%>">
								<% } %>
								<% techattachfile.delete(); 
								} %><% }}
								catch(Exception e){
									
								}
								
								%>
							</div>
							</div>
							</div>
					<% } %>
				</div></div>
			<!-- ---------------------------------------- p-13b Technical Work Carried Div ----------------------------------------------------- -->

			<!-- ---------------------------------------- P-13c  Technical Images Div ----------------------------------------------------- -->
			<div class="carousel-item ">
				<div class="content-header row ">
					
					<div class="col-md-1" >
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(Drdologo!=null ){ %> src="data:image/*;base64,<%=Drdologo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
					<div class="col-md-1" align="left" style="padding-top:5px;" >
						<b style="margin-left: -35px;"><%=ProjectCode %></b>
						<h6 style="font-size: 0.8rem;margin-left: -43px;"><%=mainpdc %></h6>
					</div>
					<div class="col-md-8">
						<h3>13 (c) Technical Images</h3>
					</div>
					<div class="col-md-1" align="right"  style="padding-top:19px;" >
						<b style="margin-right: -35px;"><%=MeetingNo %></b>
					</div>
					<div class="col-md-1">
						<img class="logo" style="width: 45px;margin-left: 5px;margin-top: -2px;"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> >
					</div>
				</div>
				<div class="content">
					<% for (int z = 0; z < 1; z++) { %>
					<div align="left"> <b style="font-size: 20px;">Project : <%=ProjectDetail.get(z)[1]%><% if (z != 0) { %>(SUB<% } %></b> </div>
					<div align="center">
						<span class="mainsubtitle">Technical Images</span>
						<hr>
						<% if (TechImages.size() > 0) {
							List<TechImages> TechImagesList = TechImages.get(z);
							if (TechImagesList.size() > 0) {
								for (TechImages imges : TechImagesList) { %>
								<% Path imagePath = Paths.get(filePath,projectLabCode,"TechImages",(imges.getTechImagesId() + "_" + imges.getImageName()));
								if (imagePath.toFile().exists()) { %>
								<img data-enlargable style="height:70vh; margin-bottom: 5px" src="data:image/*;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(imagePath.toFile()))%>">
								<hr>
								<%}%><%}}}%>
					</div>
					<%}%>
				</div>
			</div>

		<!-- ---------------------------------------- p-13c Technical Images Div ----------------------------------------------------- -->
		
		<!-- ---------------------------------------- P-14  Thank you Div ----------------------------------------------------- -->

			<div class="carousel-item ">
				<div class="content" style="border: 0px solid black;padding-top: 50px;border-radius: 20px;position: relative;height: 93vh !important;">
					<!-- <div style=" position: absolute ;top: 40%;left: 34%;">
						<h1 style="font-size: 5rem;">Thank You !</h1>
					</div> -->
					<div class="content" >
					<%if(thankYouImg!=null ){ %>
					<img class="" style="width: 100%; height: 100%;"  src="data:image/*;base64,<%=thankYouImg%>"  > 
						<%}else{ %>
							<div style=" position: absolute ;top: 40%;left: 34%;">
						<h1 style="font-size: 5rem;">Thank You !</h1>
					</div>
				<%} %>
				</div>
				</div>
			</div>
		<!-- ---------------------------------------- P-14  Thank you Div ----------------------------------------------------- -->
		</div>
		<a class="carousel-control-prev" href="#presentation-slides" role="button" data-slide="prev" style="width: 0%; padding-left: 20px;"> <span aria-hidden="true">
			<i class="fa fa-chevron-left fa-2x" style="color: #000000" aria-hidden="true"></i></span> <span class="sr-only">Previous</span>
		</a> <a class="carousel-control-next" href="#presentation-slides" role="button" data-slide="next" style="width: 0%; padding-right: 20px;"> <span aria-hidden="true">
			<i class="fa fa-chevron-right fa-2x" style="color: #000000" aria-hidden="true"></i></span> <span class="sr-only">Next</span>
		</a>
		<%int slideCount=0;%>
		<ol class="carousel-indicators">
			<li data-target="#presentation-slides" data-slide-to="<%=slideCount++ %>"  class="carousel-indicator active" data-toggle="tooltip" data-placement="top" title="Start"><b><i class="fa fa-home" aria-hidden="true"></i></b></li>
			<%char ch1='a';for (int z = 0; z < projectidlist.size(); z++) {%>
			<li data-target="#presentation-slides" data-slide-to="<%=slideCount++ %>"  class="carousel-indicator" data-toggle="tooltip" data-placement="top" title="1. Project Attributes (<%=ProjectDetail.get(z)[1]%>)"><b>1 <%if(projectidlist.size()>1) {%>(<%=(char)(ch1++)%>)<%} %></b></li>
			<%} %>
			<li data-target="#presentation-slides" data-slide-to="<%=slideCount++ %>" class="carousel-indicator" data-toggle="tooltip" data-placement="top" title="2 (a) System Configuration"><b>2 (a) </b></li>
			<li data-target="#presentation-slides" data-slide-to="<%=slideCount++ %>" class="carousel-indicator" data-toggle="tooltip" data-placement="top" title="2 (b) System Specifications"><b>2 (b) </b></li>
			<li data-target="#presentation-slides" data-slide-to="<%=slideCount++ %>" class="carousel-indicator" data-toggle="tooltip" data-placement="top" title="3. Overall Product tree/WBS"><b>3</b></li>
			<li data-target="#presentation-slides" data-slide-to="<%=slideCount++ %>" class="carousel-indicator" data-toggle="tooltip" data-placement="top" title='4 (a) <%if (committee.getCommitteeShortName().trim().equalsIgnoreCase("PMRC")) {%> Approval <%} else {%> Ratification <%}%>  of recommendations of last <%=committee.getCommitteeShortName().trim().toUpperCase()%> Meeting'><b>4(a)</b></li>
			<li data-target="#presentation-slides" data-slide-to="<%=slideCount++ %>" class="carousel-indicator" data-toggle="tooltip" data-placement="top" title="4 (b) Last <%=committee.getCommitteeShortName().trim().toUpperCase()%> Meeting action points with Probable Date of completion (PDC), Actual Date of Completion (ADC) and status"><b>4(b)</b></li>
			<li data-target="#presentation-slides" data-slide-to="<%=slideCount++ %>" class="carousel-indicator" data-toggle="tooltip" data-placement="top" title="4 (c) Details of Technical/ User Reviews"><b>4 (c)</b></li>
			<li data-target="#presentation-slides" data-slide-to="<%=slideCount++ %>" class="carousel-indicator" data-toggle="tooltip" data-placement="top" title="5. Milestones achieved prior to this Meeting"><b>5</b></li>
			<li data-target="#presentation-slides" data-slide-to="<%=slideCount++ %>" class="carousel-indicator" data-toggle="tooltip" data-placement="top" title="6 (a) Work carried out, Achievements, test result etc"><b>6(a)</b></li>
			<li data-target="#presentation-slides" data-slide-to="<%=slideCount++ %>" class="carousel-indicator" data-toggle="tooltip" data-placement="top" title="6 (b) TRL table with TRL at sanction stage and current stage indicating overall PRI"><b>6(b)</b></li>
			<li data-target="#presentation-slides" data-slide-to="<%=slideCount++ %>" class="carousel-indicator" data-toggle="tooltip" data-placement="top" title="6 (c) Risk Matrix/Management Plan/Status."><b>6 (c)</b></li>
			<%int chapter7a=1 ; int chapter7b=1;for (int z = 0; z < projectidlist.size(); z++) {%>
			<li data-target="#presentation-slides" data-slide-to="<%=slideCount++ %>" class="carousel-indicator" data-toggle="tooltip" data-placement="top" title="7 (a<%if(projectidlist.size()>1) {%><%="."+chapter7a%><%} %>) Details of Procurement Plan (<%=ProjectDetail.get(z)[1]%>)"><b>7(a<%if(projectidlist.size()>1) {%><%="."+chapter7a++%><%} %>)</b></li>
			
			<li data-target="#presentation-slides" data-slide-to="<%=slideCount++ %>" class="carousel-indicator" data-toggle="tooltip" data-placement="top" title="7 (b<%if(projectidlist.size()>1) {%><%="."+chapter7b%><%} %>) Procurement Status (<%=ProjectDetail.get(z)[1]%>)"><b>7(b<%if(projectidlist.size()>1) {%><%="."+chapter7b++%><%} %>)</b></li>
			<%} %>
				<%char ch6='a';for (int z = 0; z < projectidlist.size(); z++) {%>
			<li data-target="#presentation-slides" data-slide-to="<%=slideCount++ %>" class="carousel-indicator" data-toggle="tooltip" data-placement="top" title="8. (<%=(char)(ch6) %>)  Overall Financial Status <%if(projectidlist.size()>1) {%>(<%=ProjectDetail.get(z)[1]%>) <%}%>"><b>8<%if(projectidlist.size()>1) {%>(<%=(char)(ch6++)%>)<%} %></b></li>
			<%} %>
			<li data-target="#presentation-slides" data-slide-to="<%=slideCount++ %>" class="carousel-indicator" data-toggle="tooltip" data-placement="top" title="9. Action Plan"><b>9</b></li>
			<li data-target="#presentation-slides" data-slide-to="<%=slideCount++ %>" class="carousel-indicator" data-toggle="tooltip" data-placement="top" title="10. GANTT chart of overall project schedule"><b>10</b></li>
			<li data-target="#presentation-slides" data-slide-to="<%=slideCount++ %>" class="carousel-indicator" data-toggle="tooltip" data-placement="top" title="11. Issues"><b>11</b></li>
			<li data-target="#presentation-slides" data-slide-to="<%=slideCount++ %>" class="carousel-indicator" data-toggle="tooltip" data-placement="top" title="12. Decision/Recommendations"><b>12</b></li>
			<li data-target="#presentation-slides" data-slide-to="<%=slideCount++ %>" class="carousel-indicator" data-toggle="tooltip" data-placement="top" title="13 (a) Other Relevant Points"><b>13 (a)</b></li>
			<li data-target="#presentation-slides" data-slide-to="<%=slideCount++ %>" class="carousel-indicator" data-toggle="tooltip" data-placement="top" title="13 (b) Technical Work Carried out"><b>13 (b)</b></li>
			<li data-target="#presentation-slides" data-slide-to="<%=slideCount++ %>" class="carousel-indicator" data-toggle="tooltip" data-placement="top" title="13 (c) Technical Images"><b>13 (c)</b></li>
			<li data-target="#presentation-slides" data-slide-to="<%=slideCount++ %>" class="carousel-indicator" data-toggle="tooltip" data-placement="top" title="Thank You"><b>End</b></li>
			<li data-slide-to="21" style="background-color:  #000000;width: 35px;margin-left: 20px;" class="carousel-indicator content_full_screen" data-toggle="tooltip" data-placement="top" title="Full Screen Mode"><b><i class="fa fa-expand fa-lg" aria-hidden="true"></i></b></li>
			<li data-slide-to="21" style="background-color:  #000000;width: 35px;margin-left: 20px;" class="carousel-indicator content_reg_screen" data-toggle="tooltip" data-placement="top" title="Exit Full Screen Mode"><b><i class="fa fa-compress fa-lg" aria-hidden="true"></i></b></li>
		</ol>
	</div>
	<!-- ------------------------------------------------- MODALS -------------------------------------------------- -->

	<div class="modal fade " id="exampleModal1" tabindex="-1" aria-labelledby="exampleModalLabel1" aria-hidden="true">
		<div class="modal-dialog modal-xl modal-dialog-jump">
			<div class="modal-content">
				<div class="modal-body">
					<div class="container-fluid">
						<div class="row">
							<div class="col-md-12">
								<div class="card shadow-nohover" style="margin-top: -0px;">
									<div class="row card-header">
										<div class="col-md-10">
											<h5>
												<%
												if (ProjectId != null) {
													Object[] ProjectDetail123 = (Object[]) request.getAttribute("ProjectDetailsMil");
												%>
												<%=ProjectDetail123[2]%>
												(
												<%=ProjectDetail123[1]%>
												)
												<%
												}
												%>
											</h5>
										</div>
									</div>
									<div class="card-body">
										<div class="table-responsive">
											<table class="table  table-hover table-bordered">
												<thead>
													<tr>
														<th>Expand</th>
														<th style="text-align: left; max-width: 15px;">Mil-No</th>
														<th style="text-align: left; max-width: 200px;">Milestone Activity</th>
														<th>Start Date</th>
														<th>End Date</th>
														<th style="text-align: left; max-width: 200px;">First OIC</th>
														<th style="text-align: center; max-width: 50px;">Weightage</th>
														<th style="text-align: center; max-width: 80px;">Progress</th>

													</tr>
												</thead>
												<tbody>
													<%
													int count = 1;
													if (MilestoneList != null && MilestoneList.size() > 0) {
														for (Object[] obj : MilestoneList) {
													%>
													<tr class="milestonemodalwhole"
														id="milestonemodal<%=obj[5]%>">
														<td style="width: 2% !important;" class="center"><span
															class="clickable" data-toggle="collapse"
															id="row<%=count%>" data-target=".row<%=count%>">
																<button class="btn btn-sm btn-success"
																	id="btn<%=count%>"
																	onclick="ChangeButton('<%=count%>')">
																	<i class="fa fa-plus" id="fa<%=count%>"></i>
																</button>
														</span></td>
														<td style="text-align: left; width: 7%;">Mil-<%=obj[5]%></td>
														<%-- <td class="width-30px"><%=obj[1]%></td> --%>
														<td
															style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important; max-width: 20% !important; min-width: 20% !important;"><%=obj[4]%></td>

														<td style="width: 8% !important;"><%=sdf.format(obj[2])%></td>
														<td style="width: 8% !important;"><%=sdf.format(obj[3])%></td>
														<td style="width: 15% !important;"><%=obj[6]%></td>
														<td style="width: 9% !important;" align="center"><%=obj[13]%></td>
														<td>
															<%
															if (!obj[12].toString().equalsIgnoreCase("0")) {
															%>
															<div class="progress"
																style="background-color: #cdd0cb !important; height: 1.4rem !important;">
																<div
																	class="progress-bar progress-bar-striped
															<%if (obj[14].toString().equalsIgnoreCase("2")) {%>
															 bg-success
															<%} else if (obj[14].toString().equalsIgnoreCase("3")) {%>
															  bg-info
															<%} else if (obj[14].toString().equalsIgnoreCase("4")) {%>
															  bg-danger
															<%} else if (obj[14].toString().equalsIgnoreCase("5")) {%>
															  bg-warning
															<%}%>
															"
																	role="progressbar" style=" width: <%=obj[12]%>%;  "
																	aria-valuenow="25" aria-valuemin="0"
																	aria-valuemax="100">
																	<%=obj[12]%>
																</div>
															</div> <%
															 } else {
															 %>
															<div class="progress"
																style="background-color: #cdd0cb !important; height: 1.4rem !important;">
																<div class="progress-bar" role="progressbar"
																	style="width: 100%; background-color: #cdd0cb !important; color: black; font-weight: bold;">
																	Not Started</div>
															</div> <%
															 }
															 %>
														</td>
													</tr>
													<tr class="collapse row<%=count%>"
														style="font-weight: bold;">
														<td></td>
														<td>Sub</td>
														<td>Activity</td>
														<td>Start Date</td>
														<td>End Date</td>
														<td>Date Of Completion</td>
														<td>Sub Weightage</td>
														<td>Sub Progress</td>
														<td></td>
													</tr>
													<%
													int countA = 1;
													List<Object[]> MilestoneA = (List<Object[]>) request.getAttribute(count + "MilestoneActivityA");
													if (MilestoneA != null && MilestoneA.size() > 0) {
														for (Object[] objA : MilestoneA) {
															List<Object[]> MilestoneB = (List<Object[]>) request.getAttribute(count + "MilestoneActivityB" + countA);
													%>
													<tr class="collapse row<%=count%>">
														<td style="width: 2% !important;" class="center"></td>
														<td style="text-align: left; width: 5%;">A-<%=countA%></td>
														<%-- <td class="width-30px"><%=obj[1]%></td> --%>
														<td
															style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important; max-width: 20% !important; min-width: 20% !important;"><%=objA[4]%></td>

														<td class="width-30px"><%=sdf.format(objA[2])%></td>
														<td style="width: 8% !important;"><%=sdf.format(objA[3])%></td>


														<td class="width-30px">
															<%
															if (objA[9].toString().equalsIgnoreCase("3") || objA[9].toString().equalsIgnoreCase("5")) {
															%>
															<%
															if (objA[7] != null) {
															%> <%=sdf.format(objA[7])%> <%
															 } else {
															 %><%=objA[8]%>
															<%
															}
															%> <%
															 } else {
															 %> <%=objA[8]%> <%
															 }
															 %>
														</td>
														<td align="center"><%=objA[6]%></td>
														<td>
															<%
															if (!objA[5].toString().equalsIgnoreCase("0")) {
															%>
															<div class="progress"
																style="background-color: #cdd0cb !important; height: 1.4rem !important;">
																<div
																	class="progress-bar progress-bar-striped
															<%if (objA[9].toString().equalsIgnoreCase("2")) {%>
															 bg-success
															<%} else if (objA[9].toString().equalsIgnoreCase("3")) {%>
															  bg-info
															<%} else if (objA[9].toString().equalsIgnoreCase("4")) {%>
															  bg-danger
															<%} else if (objA[9].toString().equalsIgnoreCase("5")) {%>
															  bg-warning
															<%}%>
															"
																	role="progressbar" style=" width: <%=objA[5]%>%;  "
																	aria-valuenow="25" aria-valuemin="0"
																	aria-valuemax="100">
																	<%=objA[5]%>
																</div>
															</div> <%
															 } else {
															 %>
															<div class="progress"
																style="background-color: #cdd0cb !important; height: 1.4rem !important;">
																<div class="progress-bar" role="progressbar"
																	style="width: 100%; background-color: #cdd0cb !important; color: black; font-weight: bold;">
																	Not Started</div>
															</div> <%
															 }
															 %>
														</td>
														<td>
														</td>
													</tr>
													<%
													int countB = 1;
													if (MilestoneB != null && MilestoneB.size() > 0) {
														for (Object[] objB : MilestoneB) {
															List<Object[]> MilestoneC = (List<Object[]>) request.getAttribute(count + "MilestoneActivityC" + countA + countB);
													%>
													<tr class="collapse row<%=count%>">
														<td style="width: 2% !important;" class="center"></td>
														<td style="text-align: left; width: 5%;">
															&nbsp;&nbsp;&nbsp;B-<%=countB%></td>
														<%-- <td class="width-30px"><%=obj[1]%></td> --%>
														<td
															style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important; max-width: 20% !important; min-width: 20% !important;"><%=objB[4]%></td>

														<td class="width-30px"><%=sdf.format(objB[2])%></td>
														<td style="width: 8% !important;"><%=sdf.format(objB[3])%></td>

														<td class="width-30px">
															<%
															if (objB[9].toString().equalsIgnoreCase("3") || objB[9].toString().equalsIgnoreCase("5")) {
															%>
															<%
															if (objB[7] != null) {
															%> <%=sdf.format(objB[7])%> <%
															 } else {
															 %><%=objB[8]%>
															<%
															}
															%> <%
															 } else {
															 %> <%=objB[8]%> <%
															 }
															 %>
														</td>
														<td align="center"><%=objB[6]%></td>
														<td>
															<%
															if (!objB[5].toString().equalsIgnoreCase("0")) {
															%>
															<div class="progress"
																style="background-color: #cdd0cb !important; height: 1.4rem !important;">
																<div
																	class="progress-bar progress-bar-striped
															<%if (objB[9].toString().equalsIgnoreCase("2")) {%>
															 bg-success
															<%} else if (objB[9].toString().equalsIgnoreCase("3")) {%>
															  bg-info
															<%} else if (objB[9].toString().equalsIgnoreCase("4")) {%>
															  bg-danger
															<%} else if (objB[9].toString().equalsIgnoreCase("5")) {%>
															  bg-warning
															<%}%>
															"
																	role="progressbar" style=" width: <%=objB[5]%>%;  "
																	aria-valuenow="25" aria-valuemin="0"
																	aria-valuemax="100">
																	<%=objB[5]%>
																</div>
															</div> <%
															 } else {
															 %>
															<div class="progress"
																style="background-color: #cdd0cb !important; height: 1.4rem !important;">
																<div class="progress-bar" role="progressbar"
																	style="width: 100%; background-color: #cdd0cb !important; color: black; font-weight: bold;">
																	Not Started</div>
															</div> <%
															 }
															 %>
														</td>
														<td>
														</td>
													</tr>
													<%
													int countC = 1;
													if (MilestoneC != null && MilestoneC.size() > 0) {
														for (Object[] objC : MilestoneC) {
															List<Object[]> MilestoneD = (List<Object[]>) request.getAttribute(count + "MilestoneActivityD" + countA + countB + countC);
													%>
													<tr class="collapse row<%=count%>">
														<td style="width: 2% !important;" class="center"></td>
														<td style="text-align: left; width: 5%;">
															&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C-<%=countC%></td>
														<%-- <td class="width-30px"><%=obj[1]%></td> --%>
														<td
															style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important; max-width: 20% !important; min-width: 20% !important;"><%=objC[4]%></td>

														<td class="width-30px"><%=sdf.format(objC[2])%></td>
														<td style="width: 8% !important;"><%=sdf.format(objC[3])%></td>

														<td class="width-30px">
															<%
															if (objC[9].toString().equalsIgnoreCase("3") || objC[9].toString().equalsIgnoreCase("5")) {
															%>
															<%
															if (objC[7] != null) {
															%> <%=sdf.format(objC[7])%> <%
															 } else {
															 %><%=objC[8]%>
															<%
															}
															%> <%
															 } else {
															 %> <%=objC[8]%> <%
															 }
															 %>
														</td>
														<td align="center"><%=objC[6]%></td>
														<td>
															<%
															if (!objC[5].toString().equalsIgnoreCase("0")) {
															%>
															<div class="progress"
																style="background-color: #cdd0cb !important; height: 1.4rem !important;">
																<div
																	class="progress-bar progress-bar-striped
															<%if (objC[9].toString().equalsIgnoreCase("2")) {%>
															 bg-success
															<%} else if (objC[9].toString().equalsIgnoreCase("3")) {%>
															  bg-info
															<%} else if (objC[9].toString().equalsIgnoreCase("4")) {%>
															  bg-danger
															<%} else if (objC[9].toString().equalsIgnoreCase("5")) {%>
															  bg-warning
															<%}%>
															"
																	role="progressbar" style=" width: <%=objC[5]%>%;  "
																	aria-valuenow="25" aria-valuemin="0"
																	aria-valuemax="100">
																	<%=objC[5]%>
																</div>
															</div> <%
															 } else {
															 %>
															<div class="progress"
																style="background-color: #cdd0cb !important; height: 1.4rem !important;">
																<div class="progress-bar" role="progressbar"
																	style="width: 100%; background-color: #cdd0cb !important; color: black; font-weight: bold;">
																	Not Started</div>
															</div> <%
 }
 %>
														</td>
														<td></td>
													</tr>
													<%
													int countD = 1;
													if (MilestoneD != null && MilestoneD.size() > 0) {
														for (Object[] objD : MilestoneD) {
															List<Object[]> MilestoneE = (List<Object[]>) request.getAttribute(count + "MilestoneActivityE" + countA + countB + countC + countD);
													%>
													<tr class="collapse row<%=count%>">
														<td style="width: 2% !important;" class="center"></td>
														<td style="text-align: left; width: 5%;">
															&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D-<%=countD%></td>
														<%-- <td class="width-30px"><%=obj[1]%></td> --%>
														<td
															style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important; max-width: 20% !important; min-width: 20% !important;"><%=objD[4]%></td>

														<td class="width-30px"><%=sdf.format(objB[2])%></td>
														<td style="width: 8% !important;"><%=sdf.format(objB[3])%></td>

														<td class="width-30px">
														<%
														if (objD[9].toString().equalsIgnoreCase("3") || objD[9].toString().equalsIgnoreCase("5")) {
														%>
														<%
														if (objD[7] != null) {
														%> <%=sdf.format(objD[7])%> <%
														 } else {
														 %><%=objD[8]%>
														<%
														}
														%> <%
														 } else {
														 %> <%=objD[8]%> <%
														 }
														 %>
														</td>
														<td align="center"><%=objD[6]%></td>
														<td>
															<%
															if (!objD[5].toString().equalsIgnoreCase("0")) {
															%>
															<div class="progress"
																style="background-color: #cdd0cb !important; height: 1.4rem !important;">
																<div
																	class="progress-bar progress-bar-striped
															<%if (objD[9].toString().equalsIgnoreCase("2")) {%>
															 bg-success
															<%} else if (objD[9].toString().equalsIgnoreCase("3")) {%>
															  bg-info
															<%} else if (objD[9].toString().equalsIgnoreCase("4")) {%>
															  bg-danger
															<%} else if (objD[9].toString().equalsIgnoreCase("5")) {%>
															  bg-warning
															<%}%>
															"
																	role="progressbar" style=" width: <%=objD[5]%>%;  "
																	aria-valuenow="25" aria-valuemin="0"
																	aria-valuemax="100">
																	<%=objD[5]%>
																</div>
															</div> <%
															 } else {
															 %>
															<div class="progress"
																style="background-color: #cdd0cb !important; height: 1.4rem !important;">
																<div class="progress-bar" role="progressbar"
																	style="width: 100%; background-color: #cdd0cb !important; color: black; font-weight: bold;">
																	Not Started</div>
															</div> <%
															 }
															 %>
														</td>


														<td></td>
													</tr>
													<%
													int countE = 1;
													if (MilestoneE != null && MilestoneE.size() > 0) {
														for (Object[] objE : MilestoneE) {
													%>
													<tr class="collapse row<%=count%>">
														<td style="width: 2% !important;" class="center"></td>
														<td style="text-align: left; width: 5%;">
															&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;E-<%=countE%></td>
														<%-- <td class="width-30px"><%=obj[1]%></td> --%>
														<td
															style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important; max-width: 20% !important; min-width: 20% !important;"><%=objE[4]%></td>

														<td class="width-30px"><%=sdf.format(objE[2])%></td>
														<td style="width: 8% !important;"><%=sdf.format(objE[3])%></td>

														<td class="width-30px">
															<%
															if (objE[9].toString().equalsIgnoreCase("3") || objE[9].toString().equalsIgnoreCase("5")) {
															%>
															<%
															if (objE[7] != null) {
															%> <%=sdf.format(objE[7])%> <%
															} else {
															 %><%=objE[8]%>
															<%
															}
															%> <%
															} else {
															%> <%=objE[8]%> <%
															}
															%>
														</td>
														<td align="center"><%=objE[6]%></td>
														<td>
															<%
															if (!objE[5].toString().equalsIgnoreCase("0")) {
															%>
															<div class="progress"
																style="background-color: #cdd0cb !important; height: 1.4rem !important;">
																<div
																	class="progress-bar progress-bar-striped
															<%if (objC[9].toString().equalsIgnoreCase("2")) {%>
															 bg-success
															<%} else if (objE[9].toString().equalsIgnoreCase("3")) {%>
															  bg-info
															<%} else if (objE[9].toString().equalsIgnoreCase("4")) {%>
															  bg-danger
															<%} else if (objE[9].toString().equalsIgnoreCase("5")) {%>
															  bg-warning
															<%}%>
															"
																	role="progressbar" style=" width: <%=objE[5]%>%;  "
																	aria-valuenow="25" aria-valuemin="0"
																	aria-valuemax="100">
																	<%=objE[5]%>
																</div>
															</div> <%
														 } else {
														 %>
															<div class="progress"
																style="background-color: #cdd0cb !important; height: 1.4rem !important;">
																<div class="progress-bar" role="progressbar"
																	style="width: 100%; background-color: #cdd0cb !important; color: black; font-weight: bold;">
																	Not Started</div>
															</div> <%
														 }
														 %>
														</td>
														<td>
														</td>
													</tr>
													<%
													countE++;
													}
													}
													%><%countD++;}}%><%countC++;}}%><%countB++;}}	%><%countA++;}} else {%>
													<tr class="collapse row<%=count%>">
														<td colspan="9" style="text-align: center" class="center">No
															Sub List Found</td>
													</tr>
													<%}%><%count++;}} else {%>
													<tr><td colspan="9" style="text-align: center" class="center">No List Found</td></tr><%}%>
												</tbody>
											</table></div></div></div></div></div></div></div></div></div></div>


	<div class="modal fade" id="LevelModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header" style="background-color: #C4DDFF">
					<h5 class="modal-title" id="exampleModalLabel"
						style="color: #145374; font-weight: bold;">Set Milestone
						Level</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-md-4">
							<h6>
								<b>Project : </b>
								<% for (int z = 0; z < projectidlist.size(); z++) { %>
									<% if (z == 0) { %><%=ProjectDetail.get(z)[1]%> <% } %>
								<% } %>
							</h6>
						</div>
						<div class="col-md-3">
							<h6>
								<b>Committee :</b> <%=CommitteeCode%>
							</h6>
						</div>
						<div class="col-md-1">
							<b>Level</b>
						</div>
						<div class="col-md-4">
							<select class="form-control" name="LevelValue"
								required="required" data-live-search="true"
								data-container="body" id="levelvalue">
								<option <%if (levelid.equalsIgnoreCase("1")) {%> selected <%}%>
									value="1">Level A</option>
								<option <%if (levelid.equalsIgnoreCase("2")) {%> selected <%}%>
									value="2">Level B</option>
								<option <%if (levelid.equalsIgnoreCase("3")) {%> selected <%}%>
									value="3">Level C</option>
								<option <%if (levelid.equalsIgnoreCase("4")) {%> selected <%}%>
									value="4">Level D</option>
								<option <%if (levelid.equalsIgnoreCase("5")) {%> selected <%}%>
									value="5">Level E</option>
							</select>
						</div>

					</div>
				</div>
				<div class="modal-footer"></div>
			</div>
		</div>
	</div>



	<!-- ------------------------------------------------- MODALS -------------------------------------------------- -->


	<form method="POST" action="FileUnpack.htm" id="downloadform" target="_blank">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
		<input type="hidden" name="FileUploadId" id="FileUploadId" value="" />
	</form>


	<form method="get" action="AgendaDocLinkDownload.htm" id="downloadform1" target="_blank">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" name="filerepid" id="filerepid" value="" />
	</form>

	<form method="POST" action="MilestoneLevelUpdate.htm" id="milestonelevelform">

		<input type="hidden" name="projectid" id="projectid"> 
		<input type="hidden" name="committeeid" id="committeeid"> 
		<input type="hidden" name="milestonelevelid" id="milestonelevelid" /> 
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>

<!-- -------------------------------------------------------------- action modal ----------------------------------------------------- -->

	<div class=" modal bd-example-modal-lg" tabindex="-1" role="dialog" id="action_modal">
		<div class="modal-dialog modal-lg modal-dialog-jump" role="document">
			<div class="modal-content">
				<div class="modal-header" style="background-color: #FFE0AD; ">
					<div class="row w-100"  >
						<div class="col-md-12" >
							<h5 class="modal-title" id="modal_action_no" style="font-weight:700; color: #A30808;"></h5>
						</div>
					</div>
					
					 <button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" align="center">
					<form action="#" method="post" autocomplete="off"  >
						<table style="width: 100%;">
							<tr>
								<td style="width:20%;padding: 5px;border :0;font-weight: bold;"> Action Item :</td>
								<td class="tabledata" style="width:80%;padding: 5px;word-wrap:break-word;border :0;" colspan="3" id="modal_action_item"></td>
							</tr>
							<tr>
								<td style="padding: 5px;border :0;font-weight: bold;" >Assign Date :</td>
								<td style="padding: 5px;border :0;" id="modal_action_date"></td>
								<td style="padding: 5px;border :0;font-weight: bold;" >PDC :</td>
								<td style="padding: 5px;border :0;" id="modal_action_PDC"></td>
							</tr>
							<tr>
								<td style="padding: 5px;border :0;font-weight: bold;" >Assignor :</td>
								<td style="padding: 5px;border :0;" class="tabledata" id="modal_action_assignor"></td>
								<td style="padding: 5px;border :0;font-weight: bold;" >Assignee :</td>
								<td style="padding: 5px;border :0;" class="tabledata" id="modal_action_assignee"></td>
							</tr>
							<tr>
								<td style="padding: 5px;border :0;font-weight: bold;" >Final Progress :</td>
								<td style="padding: 5px;border :0;" id="modal_action_progress"></td>
								<td style="padding: 5px;border :0;font-weight: bold;" > Type :</td>
								<td style="padding: 5px;font-weight: bold;color:#A30808 ;border :0;" id="modal_action_type"></td>
							</tr>
							
						</table>
						</form>
						<hr>
						<form action="#" method="get">
						
						<table class="table table-bordered table-hover table-striped table-condensed " id="" style="width: 100%">
							<thead> 
								<tr style="background-color: #055C9D; color: white;">
									<th style="text-align: center;width:5% !important;">SN</th>
									<th style="text-align: center;width:15% !important;">Progress Date</th>
									<th style="text-align: center;width:15% !important;"> Progress</th>
									<th style="width:60% !important;">Remarks</th>
									<th style="text-align: center;width:5% !important;">Download</th>
								</tr>
							</thead>
							<tbody id="modal_progress_table_body">
								
							</tbody>
						</table>
						</form>
					
				</div>
				
			</div>
		</div>
	</div>

<!-- -------------------------------------------------------------- action modal ----------------------------------------------------- -->
<!-- -------------------------------------------- Risk Types Modal  -------------------------------------------------------- -->

		<div class="modal fade" id="RiskTypesModal" tabindex="-1" role="dialog" aria-labelledby="RiskTypesModalCenterTitle" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered modal-dialog-jump"  style="max-width: 60% !important;">
		
				<div class="modal-content" >
					   
				    <div class="modal-header" style="background-color: rgba(0,0,0,.03);">
				      
				    	<h4 class="modal-title"  style="color: #145374">Risk Types</h4>
	
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close" >
				          <span aria-hidden="true">&times;</span>
				        </button>
				        				        
				    </div>
					<div class="modal-body"  style="padding: 0.5rem !important;">
							
							<div class="card-body" style="min-height:30% ;max-height: 93% !important;overflow-y: auto;">
			
								<div class="row" align="center">
									<div class="table-responsive"> 
										<table class="table table-bordered table-hover table-striped table-condensed " style="width:70%">
											<thead>
												<tr>
													<th style="width:10%">SN</th>
													<th style="width:20%">Risk Type</th>
													<th style="width:70%">Description</th>
												</tr>
											</thead>
											<tbody>
												<% int riskcount=0;
												for(Object[] risktype : RiskTypes ){ %>
												<tr>
													<td style="text-align: center;"><%=++riskcount %></td>
													<td style="text-align: center;"><b>I<%=risktype[2] %></b></td>
													<td>Internal <%=risktype[1] %></td>
												</tr>
												<%} %>
												<%for(Object[] risktype : RiskTypes ){ %>
												<tr>
													<td style="text-align: center;"><%=++riskcount %></td>
													<td style="text-align: center;"><b>E<%=risktype[2] %></b></td>
													<td>External <%=risktype[1] %></td>
												</tr>
												<%} %>
											</tbody>
										</table>
									</div>	
											
				             	</div>					
							</div>
						
					</div>
				</div>
			</div> 
		</div>
		
<!-- --------------------------------------------  Risk Types Modal   -------------------------------------------------------- -->
	<div class="modal fade " id="meetingModal" tabindex="-1" aria-labelledby="exampleModalLabel1" aria-hidden="true">
		<div class="modal-dialog modal-xl modal-dialog-jump">
			<div class="modal-content">
				<div class="modal-body">
					<div class="container-fluid">
						<div class="row">
							<div class="col-md-12">
								<div class="card shadow-nohover" style="margin-top: -0px;">
									<div class="row card-header">
										<div class="col-md-10">
											<h5>
												<%
												if (ProjectId != null) {
													Object[] ProjectDetail123 = (Object[]) request.getAttribute("ProjectDetailsMil");
												%>
												<%=ProjectDetail123[2]%>
												(
												<%=ProjectDetail123[1]%>
												)
												<%
												}
												%>
											</h5>
										</div>
									</div>
									<div class="card-body">
						<%if(otherMeetingList!=null && otherMeetingList.size()>0) {%>
						<div align="left"><b><%="Other Meetings" %></b></div>
						<div align="left"><table class="subtables" style="align: left; margin-top: 10px; margin-left: 25px; max-width: 350px; border-collapse: collapse;">
						<thead><tr> <th style="width: 140px; ">Committee</th> <th  style="width: 140px; "> Date Held</th></tr></thead>
						<%for(Object[]obj:otherMeetingList) {%>
						<tbody><tr><td><a class="btn btn-link" style="padding:0px;margin:0px;" href="CommitteeMinutesViewAllDownload.htm?committeescheduleid=<%=obj[0]%>" target="blank"><%=obj[2]%></a>
								</td>												
								<td  style="text-align: center; " ><%= sdf.format(sdf1.parse(obj[1].toString()))%></td>
								</tr>
									</tbody><%}%></table></div> <%} %>
									</div></div></div></div></div></div></div></div></div>


<script type="text/javascript">

$('.content_reg_screen').hide();
$('.content_full_screen, .content_reg_screen').on('click', function(e){
	  
	  if (document.fullscreenElement) {
	    	document.exitFullscreen();
	  } else {
		  $('.slides-container').get(0).requestFullscreen();
	  }
	});

$('.content_full_screen').on('click', function(e){ contentFullScreen() });

$('.content_reg_screen').on('click', function(e){ contentRegScreen() });

function contentFullScreen()
{
	$('.content_full_screen').hide();
	$('.content_reg_screen').show();
	openFullscreen();
}

function contentRegScreen()
{
	$('.content_reg_screen').hide();
	$('.content_full_screen').show();
	closeFullscreen();
}
/* Get the documentElement (<html>) to display the page in fullscreen */
var elem = document.documentElement;

/* View in fullscreen */
function openFullscreen() {
  if (elem.requestFullscreen) {
    elem.requestFullscreen();
  } else if (elem.webkitRequestFullscreen) { /* Safari */
    elem.webkitRequestFullscreen();
  } else if (elem.msRequestFullscreen) { /* IE11 */
    elem.msRequestFullscreen();
  }
}

/* Close fullscreen */
function closeFullscreen() {
  if (document.exitFullscreen) {
    document.exitFullscreen();
  } else if (document.webkitExitFullscreen) { /* Safari */
    document.webkitExitFullscreen();
  } else if (document.msExitFullscreen) { /* IE11 */
    document.msExitFullscreen();
  }
}
</script>
<script type="text/javascript">
$('.carousel').carousel({
	  interval: false,
	  keyboard: true,
	})

$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})

$('#levelvalue').on('change', function(){
	$('#milestonelevelid').val($(this).find(":selected").val());
	$('#projectid').val(<%=projectid%>);
	$('#committeeid').val(<%=committeeid%>);
	$('#milestonelevelform').submit();
})

$( document).on("click", ".milestonemodal", function () {
	var milId = $(this).data('id');
    $('.milestonemodalwhole').hide();
    $('.collapse').removeClass('show'); 
   $('#row'+milId.substring(14)).click(); 
 	$('#'+milId).show();
});
function milactivitychange6(val){
	if(val.value=='A'){
		$('#milestonechangetableajax6').hide();
		$('#milestoneactivitychangetable6').show();
	}else{
	var Proid = <%=projectid%>;	
	$('#milestoneactivitychangetable6').hide();
	
	 $.ajax({
		type : "GET",
		url : "MilestoneActivityChange.htm",
		data : {
			projectid : Proid,
			milactivitystatusid : val.value,			
		},
		datatype: 'json',
		success : function(result)
			{
				var result= JSON.parse(result);
				var values= Object.keys(result).map(function(e){
					return result[e];
				})	
							
				var s = "<table id='milestonechangetableajax6' style='align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px; width: 980px;  border-collapse:collapse;'><tr><th  style='width: 30px !important;'>SN</th><th  style='max-width: 40px; '>MS No.</th><th  style='max-width: 230px; '>Milestones </th><th  style='max-width: 80px;'> Original PDC </th><th  style='max-width: 80px;'> Revised PDC</th>"
							+ "<th  style='max-width: 50px; '>Progress</th><th  style='max-width: 70px;'> Status</th><th  style='max-width: 70px;'> Remarks</th></tr>";
				
							if(values[0].length==0){
								
								s+= "<tr><td colspan=8' style='text-align: center;' > Nil</td></tr>";
								
							}else{
								
								for(var i=0;i<values[0].length;i++){
									 if(parseInt(values[0][i][12])>0){ 
										s+= "<tr><td  style='max-width: 30px;'>" +parseInt(i+1)+ "</td><td  style='max-width: 40px;'>M"+values[0][i][2]+"</td><td  style='max-width: 230px;'>"+values[0][i][3]+"</td><td  style='max-width: 80px;' >"+formatDate(values[0][i][5])+" </td><td  style='max-width: 80px;'>"+formatDate(values[0][i][7])+"</td>"
										+"<td  style='max-width: 50px;'>"+values[0][i][12]+"</td><td  style='max-width: 70px;'>"+values[0][i][11]+"	</td><td  style='max-width: 70px;'>"+values[0][i][13]+"</td></tr>";
									 } 
								}
							}
						s+="</table>"	
				$('#milestoneactivitychange').html(s);
			}
	}) 		
	}
}
	 function formatDate(date) {
		    var d = new Date(date),
		        month = '' + (d.getMonth() + 1),
		        day = '' + d.getDate(),
		        year = d.getFullYear();
		    if (month.length < 2) 
		        month = '0' + month;
		    if (day.length < 2) 
		        day = '0' + day;
		    return [day, month, year].join('-');
		}
</script>
<script type="text/javascript">
function FileDownload(fileid1)
{
	$('#FileUploadId').val(fileid1);
	$('#downloadform').submit();
}
function FileDownload1(fileid1)
{
	$('#filerepid').val(fileid1);
	$('#downloadform1').submit();
}
</script>
	<script type="text/javascript">
function setattchidvalue(attachid, attchName)
{
	var $projectid=$('#AttachProjectId').val();
	$('#attachid_'+$projectid).val(attachid);
	$('#attachname_'+$projectid).html(attchName);
	$('#exampleModalCenter1').modal('hide');
	$('#attachmentmodal').modal('hide');
}
</script>
	<%
	for (int z = 0; z < 1; z++) {
	%>
	<script>
									function chartprint_<%=projectidlist.get(z)%>(type,interval){ 
								    	  var data = [
								    		  
 											<%for (Object[] obj : ganttchartlist.get(z)) {%>
								    		  {
								    		    id: "<%=obj[3]%>",
								    		    name: "<%=obj[2]%>",
								    		    <%if(!obj[9].toString().equalsIgnoreCase("0") && !obj[9].toString().equalsIgnoreCase("1")){ %>
								    		    baselineStart: "<%=obj[6]%>",
								    		    baselineEnd: "<%=obj[7]%>",
								    		    baseline: {fill: "#f25287 0.5", stroke: "0.0 #f25287"},
								    		    actualStart: "<%=obj[4]%>",
								    		    actualEnd: "<%=obj[5]%>",
								    		    actual: {fill: "#29465B", stroke: "0.8 #29465B"},
								    		    baselineProgressValue: "<%= Math.round((int)obj[8])%>%",
								    		    progress: {fill: "#81b214 0.0", stroke: "0.0 #150e56"},
								    		    progressValue: "<%= Math.round((int)obj[8])%>%",
								    		    <%} else{%>
								    		    baselineStart: "<%=obj[4]%>",
								    		    baselineEnd: "<%=obj[5]%>",
								    		    baseline: {fill: "#29465B", stroke: "0.8 #29465B"},
								    		    baselineProgressValue: "<%= Math.round((int)obj[8])%>%",
								    		    progress: {fill: "#81b214 0.0", stroke: "0.0 #150e56"},
								    		    progressValue: "<%= Math.round((int)obj[8])%>%",
								    		    <%}%>
								    		    rowHeight: "55",
								    		  },
								    		  <%}%>
								    		  ];
								    		// create a data tree
								    		var treeData = anychart.data.tree(data, "as-tree");
								    		// create a chart
								    		var chart = anychart.ganttProject();
								    		// set the data
								    		chart.data(treeData);   
								        	// set the container id
								        	chart.container("containers_<%=projectidlist.get(z)%>");  
								        	// initiate drawing the chart
								        	chart.draw();    
								        	// fit elements to the width of the timeline
								        	chart.fitAll();
								        	var timeline = chart.getTimeline();
										    // configure labels of elements
										    timeline.elements().labels().fontWeight(600);
										    timeline.elements().labels().fontSize("14px");
										    timeline.elements().labels().fontColor("#FF6F00");
								        
								        	 chart.getTimeline().tooltip().useHtml(true);    
								        	 chart.getTimeline().tooltip().format(
									        		 function() {
									        		        var actualStart = this.getData("actualStart") ? this.getData("actualStart") : this.getData("baselineStart");
									        		        var actualEnd = this.getData("actualEnd") ? this.getData("actualEnd") : this.getData("baselineEnd");
									        		        var reDate=this.getData("actualStart") ;
									        		        var html="";
									        		        if(reDate===undefined){
									        		        	html="";
									        		         	html= "<span style='font-weight:600;font-size:10pt'> Actual : "+ anychart.format.dateTime(actualStart, 'dd MMM yyyy') + " - " + anychart.format.dateTime(actualEnd, 'dd MMM yyyy') + "</span><br>" + "Progress: " + this.getData("baselineProgressValue") + "<br>"
									        		        }else{
									        		        	html="";
										        		        html="<span style='font-weight:600;font-size:10pt'> Actual : "+anychart.format.dateTime(actualStart, 'dd MMM yyyy') + " - " +anychart.format.dateTime(actualEnd, 'dd MMM yyyy') + "</span><br>" +"<span style='font-weight:600;font-size:10pt'> Revised : " +anychart.format.dateTime(this.getData("baselineStart"), 'dd MMM yyyy') + " - " +anychart.format.dateTime(this.getData("baselineEnd"), 'dd MMM yyyy') + "</span><br>" +"Progress: " + this.getData("baselineProgressValue") + "<br>"
									        		        }
									        		        return html;
									        		    }
										        ); 
								        
								        /* Title */
								        var title = chart.title();
										title.enabled(true);
										title.text("<%=ProjectDetail.get(z)[2]%> ( <%=ProjectDetail.get(z)[1]%> ) Gantt Chart");
										title.fontColor("#64b5f6");
										title.fontSize(18);
										title.fontWeight(600);
										title.padding(5);
										<%-- <%} %> --%>
								        chart.rowHoverFill("#8fd6e1 0.3");
								        chart.rowSelectedFill("#8fd6e1 0.3");
								        chart.rowStroke("0.5 #64b5f6");
								        chart.columnStroke("0.5 #64b5f6");
								        chart.defaultRowHeight(35);
								     	chart.headerHeight(90);
								     	/* Hiding the middle column */
								     	chart.splitterPosition("17.4%");
								     	
								     	var dataGrid = chart.dataGrid();
								     	dataGrid.rowEvenFill("gray 0.3");
								     	dataGrid.rowOddFill("gray 0.1");
								     	dataGrid.rowHoverFill("#ffd54f 0.3");
								     	dataGrid.rowSelectedFill("#ffd54f 0.3");
								     	dataGrid.columnStroke("2 #64b5f6");
								     	dataGrid.headerFill("#64b5f6 0.2");
								     	
								     	/* Title */
								     	var column_1 = chart.dataGrid().column(0);
								     	column_1.labels().fontWeight(600);
								     	column_1.labels().useHtml(true);
								     	column_1.labels().fontColor("#055C9D");
								     	
								     	var column_2 = chart.dataGrid().column(1);
								     	column_2.title().text("Milestone");
								     	column_2.title().fontColor("#145374");
								     	column_2.title().fontWeight(600);
										chart.dataGrid().column(0).width(25);
								     	
								     	chart.dataGrid().tooltip().useHtml(true);
								     	if(interval==="year"){
								     		/* Yearly */
									     	chart.getTimeline().scale().zoomLevels([["year"]]);
									     	var header = chart.getTimeline().header();
									     	header.level(2).format("{%value}-{%endValue}");
									     	header.level(1).format("{%value}-{%endValue}"); 
								     	}
								     	
								     	if(interval==="half"){
								     		/* Half-yearly */
									     	chart.getTimeline().scale().zoomLevels([["semester", "year"]]);
									     	var header = chart.getTimeline().header();
									     	header.level(2).format("{%value}-{%endValue}");
									     	var header = chart.getTimeline().header();
									     	header.level(0).format(function() {
								     			var duration = '';
								     			if(this.value=='Q1')
								     				duration='H1';
								     			if(this.value=='Q3')
								     				duration='H2'
								     		  return duration;
								     		});
								     	}
								     	
								     	if(interval==="quarter"){
								     		/* Quarterly */
									     	chart.getTimeline().scale().zoomLevels([["quarter", "semester","year"]]);
									     	var header = chart.getTimeline().header();
									     	header.level(1).format(function() {
								     			var duration = '';
								     			if(this.value=='Q1')
								     				duration='H1';
								     			if(this.value=='Q3')
								     				duration='H2'
								     		  return duration;
								     		});
								     	}
								     	
								     	if(interval==="month"){
								     		/* Monthly */
									     	chart.getTimeline().scale().zoomLevels([["month", "quarter","year"]]);
								     	}
								     	
								     	else if(interval===""){
															     		
								     		/* Quarterly */
									     	chart.getTimeline().scale().zoomLevels([["quarter", "semester","year"]]);
									     	var header = chart.getTimeline().header();
									     	header.level(1).format(function() {
								     			var duration = '';
								     			if(this.value=='Q1')
								     				duration='H1';
								     			if(this.value=='Q3')
								     				duration='H2'
								     		  return duration;
								     		});
								     		
								     	}
								     	
								     	/* chart.getTimeline().scale().fiscalYearStartMonth(4); */
								     	/* Header */
								     	var header = chart.getTimeline().header();
								     	header.level(0).fill("#64b5f6 0.2");
								     	header.level(0).stroke("#64b5f6");
								     	header.level(0).fontColor("#145374");
								     	header.level(0).fontWeight(600);
								     	
								     	/* Marker */
								     	var marker_1 = chart.getTimeline().lineMarker(0);
								     	marker_1.value("current");
								     	marker_1.stroke("2 #dd2c00");
								     	
								     	/* Progress */
								     	var timeline = chart.getTimeline();
								     	
								     	timeline.tasks().labels().useHtml(true);
								     	timeline.tasks().labels().format(function() {
								     	  if (this.progress == 1) {
								     	    return "<span style='color:orange;font-weight:bold;font-family:'Lato';'></span>";
								     	  } else {
								     	    return "<span style='color:black;font-weight:bold'></span>";
								     	  }
								     	});
								     	
								    // calculate height
								     	var traverser = treeData.getTraverser();
								        var itemSum = 0;
								        var rowHeight = chart.defaultRowHeight();
								        while (traverser.advance()){
								           if (traverser.get('rowHeight')) {
								          itemSum += traverser.get('rowHeight');
								        } else {
								        	itemSum += rowHeight;
								        }
								        if (chart.rowStroke().thickness != null) {
								        	itemSum += chart.rowStroke().thickness;
								        } else {
								          itemSum += 1;
								        }
								        }
								        itemSum += chart.headerHeight();
								        var menu = chart.contextMenu();
									} 
		
		 $( document ).ready(function(){
	    	  
	    	  chartprint_<%=projectidlist.get(z)%>('type','');
	      })
	      
	      
	      function ChartPrint_<%=projectidlist.get(z)%>(){
	    	  var interval_<%=projectidlist.get(z)%> = $("#interval_<%=projectidlist.get(z)%>").val();
	    	  $('#containers_<%=projectidlist.get(z)%>').empty();
	    	  chartprint_<%=projectidlist.get(z)%>('print',interval_<%=projectidlist.get(z)%>);
	     }
	     
	 
				$('#interval_<%=projectidlist.get(z)%>').on('change',function(){
					
					$('#containers_<%=projectidlist.get(z)%>').empty();
					var interval_<%=projectidlist.get(z)%> = $("#interval_<%=projectidlist.get(z)%>").val()
					chartprint_<%=projectidlist.get(z)%>('type',interval_<%=projectidlist.get(z)%>);
					
				})
		
		</script>
	<% } %>
<script type="text/javascript">
function ActionDetails(InAssignId)
{
		$("#modal_progress_table").DataTable().destroy();
		
		$.ajax({		
			type : "GET",
			url : "ActionAssignDataAjax.htm",
			data : {
				ActionAssignid : InAssignId
			},
			datatype : 'json',
			success : function(result) {
				var result = JSON.parse(result);
				
				$('#modal_action_item').html(result[1]);
				$('#modal_action_no').html(result[2]);
				$('#modal_action_date').html(moment(new Date(result[5]) ).format('DD-MM-YYYY'));
				$('#modal_action_PDC').html(moment(new Date(result[6]) ).format('DD-MM-YYYY'));
				$('#modal_action_assignor').html(result[8]);
				$('#modal_action_assignee').html(result[9]);
				
				var InActionType = result[10];
				var ActionType = 'Action';
				
				if(InActionType==='A')
				{
					ActionType = 'Action';
				}
				else if(InActionType==='I')
				{
					ActionType = 'Issue';
				}
				else if(InActionType==='D')
				{
					ActionType = 'Decision';
				}
				else if(InActionType==='R')
				{
					ActionType = 'Recommendation';
				}
				else if(InActionType==='C')
				{
					ActionType = 'Comment';
				}
				else if(InActionType==='K')
				{
					ActionType = 'Risk';
				}
				
				$('#modal_action_type').html(ActionType);
				
				var InProgress = '0'
				if(result[4]!=null){
					InProgress=result[4]+'';
				}
				
				if(InProgress.trim() === '0')
				{
					var progressBar ='<div class="progress" style="background-color:#cdd0cb !important;height: 1.5rem !important;">'; 
					progressBar += 		'<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >';
					progressBar +=		'Not Started'
					progressBar +=		'</div>'; 
					progressBar += '</div>'; 
				}
				else
				{
					var progressBar ='<div class="progress" style="background-color:#cdd0cb !important;height:1.5rem !important; ">'; 
					progressBar += 		'<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: '+InProgress+'%;  " aria-valuemin="0" aria-valuemax="100" >';
					progressBar +=		InProgress
					progressBar +=		'</div>'; 
					progressBar += '</div>'; 
				}
				$('#modal_action_progress').html(progressBar);
			}
		});
		$.ajax({		
			type : "GET",
			url : "ActionSubListAjax.htm",
			data : {
				ActionAssignid : InAssignId
			},
			datatype : 'json',
			success :  function(result) {
				var result = JSON.parse(result);
				
				
				var htmlStr='';
				if(result.length> 0){
					for(var v=0;v<result.length;v++)
						{
						htmlStr += '<tr>';
						htmlStr += '<td class="tabledata" style="text-align: center;" >'+ (v+1) + '</td>';
						htmlStr += '<td class="tabledata" style="text-align: center;" >'+ moment(new Date(result[v][3]) ).format('DD-MM-YYYY') + '</td>';
						htmlStr += '<td class="tabledata" style="text-align: center;" >'+ result[v][2] + ' %</td>';
						htmlStr += '<td class="tabledata" >'+ result[v][4] + '</td>';
						if(result[v][5]=== null)
						{
						htmlStr += '<td class="tabledata" style="text-align: center;">-</td>';
						}
						else
						{
						htmlStr += '<td class="tabledata" style="text-align: center;"><button type="submit" class="btn btn-sm" name="ActionSubId" value="'+ result[v][5] + '" target="blank" formaction="ActionDataAttachDownload.htm" ><i class="fa fa-download"></i></button></td>';
						}
						htmlStr += '</tr>';
					}
				}
				else
				{
					htmlStr += '<tr>';
					htmlStr += '<td colspan="5" style="text-align: center;"> Progress Not Updated </td>';
					htmlStr += '</tr>';
				}
				setModalDataTable();
				$('#modal_progress_table_body').html(htmlStr);
				
				
				$('#action_modal').modal('toggle');
			}
		});
	}
	setModalDataTable();
	function setModalDataTable()
	{
		$("#modal_progress_table").DataTable({
			"lengthMenu": [ 5, 10,25, 50, 75, 100 ],
			"pagingType": "simple",
			"pageLength": 5
		});
	}
	
	function ListOfMilestones(){
		var totalMilestones=[];
		var totalCompletedMilestones=[];
		var totalProgressedMilestones=[];
		}
	function showMeetingModal(){
		$('#meetingModal').modal('show');
	}
</script>
</body>
</html>
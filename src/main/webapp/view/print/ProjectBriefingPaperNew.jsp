<%@page import="java.math.MathContext"%>
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
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.time.LocalDate"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/ckeditor/ckeditor.js" var="ckeditor" />
<script src="${ckeditor}"></script>
<spring:url value="/resources/ckeditor/contents.css" var="contentCss" />
<link href="${contentCss}" rel="stylesheet" />

<title>Briefing </title>
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
 
  }
 .textcenter{
 	
 	text-align: center;
 }
 .border
 {
 	border: 1px solid black;
 }
 .textleft{
 	text-align: left;
 }
 
 .containers {
    width: 100%;
    height: 100%;
    margin: 0;
    padding: 0;
}

.anychart-credits {
   display: none;
}

.flex-container {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

summary[role=button] {
  background-color: white;
  color: black;
  border: 1px solid black ;
  border-radius:5px;
  padding: 0.5rem;
  cursor: pointer;
  
}
summary[role=button]:hover
 {
color: white;
border-radius:15px;
background-color: #4a47a3;

}
 summary[role=button]:focus
{
color: white;
border-radius:5px;
background-color: #4a47a3;
border: 0px ;

}
summary::marker{
	
}
details { 
  margin-bottom: 5px;  
}
details  .content {
background-color:white;
padding: 0 1rem ;
align: center;
border: 1px solid black;
}

}

.anchorlink{
	cursor: pointer;
	color: #C84B31;
}
.anchorlink:hover {
    text-decoration: underline;
}

</style>


<!-- --------------  tree   ------------------- -->
<style>
ul, #myUL {
  list-style-type: none;
}

#myUL {
  margin: 0;
  padding: 0;
}

.caret {
  cursor: pointer;
  -webkit-user-select: none; /* Safari 3.1+ */
  -moz-user-select: none; /* Firefox 2+ */
  -ms-user-select: none; /* IE 10+ */
  user-select: none;
}

.caret::before {
  content: "  \25B7";
  color: black;
  display: inline-block;
  margin-right: 6px;
}

.caret-down::before {
  content: "\25B6  ";
  -ms-transform: rotate(90deg); /* IE 9 */
  -webkit-transform: rotate(90deg); /* Safari */'
  transform: rotate(90deg);  
}

.caret-last {
  cursor: pointer;
  -webkit-user-select: none; /* Safari 3.1+ */
  -moz-user-select: none; /* Firefox 2+ */
  -ms-user-select: none; /* IE 10+ */
  user-select: none;
}


.caret-last::before {
  content: "\25B7";
  color: black;
  display: inline-block;
  margin-right: 6px;
}


.nested {
  display: none;
}

.active {
  display: block;
}
</style>

<!-- ---------------- tree ----------------- -->
<!-- -------------- model  tree   ------------------- -->
<style>

.caret-1 {
  cursor: pointer;
  -webkit-user-select: none; /* Safari 3.1+ */
  -moz-user-select: none; /* Firefox 2+ */
  -ms-user-select: none; /* IE 10+ */
  user-select: none;
}

.caret-last-1 {
  cursor: pointer;
  -webkit-user-select: none; /* Safari 3.1+ */
  -moz-user-select: none; /* Firefox 2+ */
  -ms-user-select: none; /* IE 10+ */
  user-select: none;
}


.caret-last-1::before {
  content: "\25B7" ;
  color: black;
  display: inline-block;
  margin-right: 6px;
}

.caret-1::before {
  content: "\25B7" ;
  color: black;
  display: inline-block;
  margin-right: 6px;
}

.caret-down-1::before {
  content: "\25B6";
  -ms-transform: rotate(90deg); /* IE 9 */
  -webkit-transform: rotate(90deg); /* Safari */'
  transform: rotate(90deg);  
}

.nested-1 {
  display: none;
}

.active-1 {
  display: block;
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

.delaydays
{
	color:#000000;
	font-weight: 700;
}

.select2-container{
	float:right !important;
	margin-top: 5px;
	
}

.modal-xl{
	max-width: 1400px;
}

.sub-title{
	font-size : 20px !important;
	color: #145374 !important
}

.subtables{
	width: 1100px !important;
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
 
 .spinner {
    position: fixed;
    top: 40%;
    left: 20%;
    margin-left: -50px; /* half width of the spinner gif */
    margin-top: -50px; /* half height of the spinner gif */
    text-align:center;
    z-index:1234;
    overflow: auto;
    width: 1000px; /* width of the spinner gif */
    height: 1020px; /*hight of the spinner gif +2px to fix IE8 issue */
}

</style>






<meta charset="ISO-8859-1">

</head>
<body >
<%
DecimalFormat df=new DecimalFormat("####################.##");
FormatConverter fc=new FormatConverter(); 
SimpleDateFormat sdf=fc.getRegularDateFormat();
SimpleDateFormat sdf1=fc.getSqlDateFormat();


int addcount=0; 
NFormatConvertion nfc=new NFormatConvertion();
Format format = com.ibm.icu.text.NumberFormat.getCurrencyInstance(new Locale("en", "in"));
String filePath=(String)request.getAttribute("filePath");
String projectLabCode=(String)request.getAttribute("projectLabCode");
List<Object[]> projectslist=(List<Object[]>)request.getAttribute("projectslist");
String projectid=(String)request.getAttribute("projectid");
String committeeid=(String)request.getAttribute("committeeid");
Committee committee=(Committee)request.getAttribute("committeeData");

List<Object[]> projectattributeslist = (List<Object[]> )request.getAttribute("projectattributes");
List<List<Object[]>> ebandpmrccount = (List<List<Object[]>> )request.getAttribute("ebandpmrccount");
List<List<Object[]>> milestonesubsystems= (List<List<Object[]>>)request.getAttribute("milestonesubsystems");
List<List<Object[]>> milestones= (List<List<Object[]>>)request.getAttribute("milestones");
List<List<Object[]>> lastpmrcactions = (List<List<Object[]>>)request.getAttribute("lastpmrcactions");
List<List<Object[]>> lastpmrcminsactlist = (List<List<Object[]>>)request.getAttribute("lastpmrcminsactlist");
List<List<Object[]>> ganttchartlist=(List<List<Object[]>>)request.getAttribute("ganttchartlist");
List<Object[]> projectdatadetails = (List<Object[]> )request.getAttribute("projectdatadetails");
List<List<Object[]>> oldpmrcissueslist=(List<List<Object[]>>)request.getAttribute("oldpmrcissueslist");

List<List<ProjectFinancialDetails>> projectFinancialDetails = (List<List<ProjectFinancialDetails>>)request.getAttribute("financialDetails");
List<List<Object[]>> procurementOnDemand = (List<List<Object[]>>)request.getAttribute("procurementOnDemandlist");
List<List<Object[]>> procurementOnSanction = (List<List<Object[]>>)request.getAttribute("procurementOnSanctionlist");
List<List<Object[]>> riskmatirxdata = (List<List<Object[]>>)request.getAttribute("riskmatirxdata");
List<Object[]> lastpmrcdecisions = (List<Object[]>)request.getAttribute("lastpmrcdecisions");
List<List<Object[]>> actionplanthreemonths = (List<List<Object[]>>)request.getAttribute("actionplanthreemonths");
List<Object[]> TechWorkDataList=(List<Object[]>)request.getAttribute("TechWorkDataList");
List<Object[]> ProjectDetail=(List<Object[]>)request.getAttribute("ProjectDetails"); 
List<String> projectidlist = (List<String>)request.getAttribute("projectidlist");
List<Object[]> pdffiles=(List<Object[]>)request.getAttribute("pdffiles");
List<Object[]> milestoneactivitystatus =(List<Object[]>)request.getAttribute("milestoneactivitystatus");
List<Object[]> MilestoneList=(List<Object[]>)request.getAttribute("MilestoneActivityList");
String ProjectId=(String)request.getAttribute("projectid");
List<TotalDemand> totalprocurementdetails = (List<TotalDemand>)request.getAttribute("TotalProcurementDetails");
List<List<Object[]>> ReviewMeetingList=(List<List<Object[]>>)request.getAttribute("ReviewMeetingList");
List<List<Object[]>> ReviewMeetingListPMRC=(List<List<Object[]>>)request.getAttribute("ReviewMeetingListPMRC");

List<List<Object[]>> ProjectRevList = (List<List<Object[]>>)request.getAttribute("ProjectRevList");
List<List<Object[]>> MilestoneDetails6 = (List<List<Object[]>>)request.getAttribute("milestonedatalevel6");
List<List<TechImages>> TechImages = (List<List<TechImages>>)request.getAttribute("TechImages");

List<Object[]> SpecialCommitteesList = (List<Object[]>)request.getAttribute("SpecialCommitteesList");


Committee committeeData=(Committee)request.getAttribute("committeeData");
long ProjectCost = (long)request.getAttribute("ProjectCost"); 
String levelid= (String) request.getAttribute("levelid");

String No2=null;
SimpleDateFormat sdfg=new SimpleDateFormat("yyyy");
if(committeeData.getCommitteeShortName().trim().equalsIgnoreCase("PMRC")){ 
No2="P"+(Long.parseLong(ebandpmrccount.get(0).get(0)[1].toString())+1);
}else if(committeeData.getCommitteeShortName().trim().equalsIgnoreCase("EB")){
	No2="E"+(Long.parseLong(ebandpmrccount.get(0).get(1)[1].toString())+1);
				} 
 
%>



<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	
	<div align="center">
	
		<div class="alert alert-danger" role="alert">
	                     <%=ses1 %>
	                    </div></div>
		<%}if(ses!=null){ %>
		<div align="center">
		<div class="alert alert-success" role="alert" >
	                     <%=ses %>
        </div>
            
    </div>
<%} %>
 
 
 <div id="spinner" class="spinner" style="display:none;">
                <img id="img-spinner" style="width: 200px;height: 200px;" src="view/images/spinner1.gif" alt="Loading"/>
                </div>
 
 

<div class="container-fluid">
		<div class="row" id="main">
			<div class="col-md-12">
				<div class="card shadow-nohover">
					<div class="row card-header">
			   			<div class="col-md-4">
							<h3>Project Briefing Paper</h3>
						</div>							
						<div class="col-md-8 justify-content-end" style="float: right;">
						<form method="post" action="ProjectBriefingPaper.htm" id="projectchange">
							<table >
								<tr>
									<td  style="border: 0 "><h6>Project </h6></td>
									<td  style="border: 0 ">
										
										<select class="form-control items" name="projectid"  required="required" style="width:200px;" data-live-search="true" data-container="body" onchange="submitForm('projectchange');">
											<%for(Object[] obj : projectslist){ %>
												<option <%if(projectid!=null && projectid.equals(obj[0].toString())) { %>selected <%} %>value=<%=obj[0]%> ><%=obj[4] %></option>
											<%} %>
										</select>
									</td>
									<td  style="border: 0 "><h6>Committee</h6></td>
									<td  style="border: 0 ">
										
										<select class="form-control items" name="committeeid"  required="required" style="width:200px;" data-live-search="true" data-container="body" onchange="submitForm('projectchange');">
											
											<%for(Object[] comm : SpecialCommitteesList){ %>
												<%if((Double.parseDouble(projectattributeslist.get(0)[7].toString())*100000)>500 && !comm[1].toString().equalsIgnoreCase("PMRC")){ %>
													
													<option <%if(Long.parseLong(committeeid)==Long.parseLong(comm[0].toString())){ %>selected<%} %> value="<%=comm[0] %>" ><%=comm[1] %></option>
													
												<%}else if(comm[1].toString().equalsIgnoreCase("PMRC")){ %>
													
													<option <%if(Long.parseLong(committeeid)==Long.parseLong(comm[0].toString())){ %>selected<%} %> value="<%=comm[0] %>" ><%=comm[1] %></option>
														
												<%} %>
												
											<%} %>
												
										</select>
										
									</td>
									
									<td style="border: 0 "> 
										<button  type="submit" class="btn btn-sm" style="border: 0 ;border-radius: 3px;" formmethod="GET" formaction="ProjectBriefingDownload.htm" formtarget="_blank">
											<i class="fa fa-download fa-lg" aria-hidden="true"></i>
										</button>
									</td>
									<td style="border: 0 "> 
										<button  type="submit" class="btn btn-sm " formmethod="POST" formaction="ProjectBriefingFreeze.htm" onclick="return confirm('Are You Sure To Freeze Briefing Paper for Next Scheduled Meeting ?')" title="Freeze" style="border: 0 ;border-radius: 3px;">
											<i class="fa fa-certificate fa-lg" style="color:red; " aria-hidden="true"></i>
										</button>
									</td>
									<td style="border: 0 "> 
										<button  type="submit" class="btn btn-sm " formmethod="POST" formaction="BriefingPresentation.htm" formtarget="_blank" title="Presentation" style="border: 0 ;border-radius: 3px;">
											<img alt="" src="view/images/presentation.png">
										</button>
									</td>
									
									<td style="border: 0 "><button  type="button" class="btn btn-sm back"  data-toggle="modal" data-target="#LevelModal"  style="float: right;margin-top: 5px;text-transform: capitalize !important;"  >Mil Level (<%=levelid %>)</button></td>
								</tr>
							</table>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								<input type="hidden" name="projectid" value="<%=projectid%>"/>
								<input type="hidden" name="committeeid" value="<%=committeeid%>"/>	
							</form>				
						</div>
					 </div>
					 
	
						<div class="card-body">	
						
							 <details>					
							    <summary role="button" tabindex="0"><b>1. Project Attributes </b>  </summary>
								<div class="content">
									<% 
									for(int z=0;z<projectidlist.size();z++)
									{
										List<Object[]>  revlist= ProjectRevList.get(z); 
										Object[] projectattributes =projectattributeslist.get(z);	%>  
										<%if(projectattributes!=null){ %>
										
										<div>
											<b>Project : <%=ProjectDetail.get(z)[1] %> 	<%if(z!=0){ %>(SUB)<%} %>	</b>
											<%-- <form action="ProjectSubmit.htm" method="post" target="_blank">
												<b>Project : <%=ProjectDetail.get(z)[1] %> 	<%if(z!=0){ %>(SUB)<%} %>	</b>
												<button type="submit" name="action" value="edit"  class="btn btn-sm edit" style="padding : 3px;" > <i class="fa fa-pencil-square-o fa-lg" style="color: black" aria-hidden="true"></i> </button>
												<input type="hidden" name="ProjectId" value="<%=ProjectDetail.get(z)[0] %>">
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
											</form> --%>
										</div>	
										
										
									<table class="subtables projectattributetable" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;   border-collapse:collapse;" >
										<tr>
											 <td style="width: 5px !important; padding: 5px; padding-left: 10px">(a)</td>
											 <td style="width: 150px;padding: 5px; padding-left: 10px"><b>Project Title</b></td>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px"> <%=projectattributes[1] %></td>
										</tr>
										<tr>
											 <td  style="padding: 5px; padding-left: 10px">(b)</td>
											 <td style="width: 150px;padding: 5px; padding-left: 10px"><b>Project Code</b></td>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px"> <%=projectattributes[0]%> </td>
										</tr>
										<tr>
											 <td  style=" padding: 5px; padding-left: 10px">(c)</td>
											 <td  style="width: 150px;padding: 5px; padding-left: 10px"><b>Category</b></td>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px"><%=projectattributes[14]%></td>
										</tr>
										<tr>
											 <td  style="padding: 5px; padding-left: 10px">(d)</td>
											 <td  style="width: 150px;padding: 5px; padding-left: 10px"><b>Date of Sanction</b></td>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px"><%=sdf.format(sdf1.parse(projectattributes[3].toString()))%></td>
										</tr>
										<tr>
											 <td  style="width: 20px; padding: 5px; padding-left: 10px">(e)</td>
											 <td  style="width: 150px;padding: 5px; padding-left: 10px"><b>Nodal and Participating Labs</b></td>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px"><%if(projectattributes[15]!=null){ %><%=projectattributes[15]%><%} %></td>
										</tr>
										<tr>
											 <td  style=" padding: 5px; padding-left: 10px">(f)</td>
											 <td  style="width: 150px;padding: 5px; padding-left: 10px"><b>Objective</b></td>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px;text-align: justify"> <%=projectattributes[4]%></td>
										</tr>
										<tr>
											 <td  style="padding: 5px; padding-left: 10px">(g)</td>
											 <td  style="width: 150px;padding: 5px; padding-left: 10px"><b>Deliverables</b></td>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px"> <%=projectattributes[5]%></td>
										</tr>
										<tr>
											 <td rowspan="2" style="padding: 5px; padding-left: 10px">(h)</td>
											 <td rowspan="2" style="width: 150px;padding: 5px; padding-left: 10px"><b>PDC</b></td>
											 
											<td colspan="2" style="text-align: center !important">Original</td>					
											<%if( ProjectRevList.get(z).size()>0){ %>	
												<td colspan="2" style="text-align: center !important">Revised</td>																			
											<%}else{ %>													 
										 		<td colspan="2" ></td>	
										 	<%} %>
										</tr>
								 		<tr>
								 			<%if( ProjectRevList.get(z).size()>0 ){ %>								
										 		<td colspan="2" style="text-align: center;"><%= sdf.format(sdf1.parse(ProjectRevList.get(z).get(0)[12].toString()))%> </td>
										 		<td colspan="2" style="text-align: center;">
											 		<%if(LocalDate.parse(projectattributes[6].toString()).isEqual(LocalDate.parse(ProjectRevList.get(z).get(0)[12].toString())) ){ %>
											 			-
											 		<%}else{ %>
											 			<%= sdf.format(sdf1.parse(projectattributes[6].toString()))%>
											 		<%} %>
										 		
										 		</td>
											<%}else{ %>													 
										 		<td colspan="2" style="text-align: center;"><%= sdf.format(sdf1.parse(projectattributes[6].toString()))%></td>
												<td colspan="2" ></td>
										 	<%} %>
										 		    
								 		</tr>
											 	
										<tr>
											<td rowspan="3" style="width: 30px; padding: 5px; padding-left: 10px">(i)</td>
											<td rowspan="3" style="padding-left: 10px"><b>Cost Breakup( &#8377; <span class="currency">Lakhs</span>)</b></td>
											
											<%if( ProjectRevList.get(z).size()>0 ){ %>
													<td style="width: 10% !important" >RE Cost</td>
													<td style="text-align: center;"><%=ProjectRevList.get(z).get(0)[17] %></td> 
													<td colspan="2" style="text-align: center;"><%=projectattributes[8] %></td>
												</tr>
												
												
												<tr>
													<td style="width: 10% !important">FE Cost</td>		
													<td style="text-align: center;"><%=ProjectRevList.get(z).get(0)[16] %></td>					
													<td colspan="2" style="text-align: center;"><%=projectattributes[9] %></td>
												</tr>
													
												<tr>	
													<td style="width: 10% !important">Total Cost</td>	
													<td style="text-align: center;"><%=ProjectRevList.get(z).get(0)[11] %></td>
											 		<td colspan="2" style="text-align: center;"><%=projectattributes[7] %></td>
												</tr> 
														
											<%}else{ %>
													
													<td style="width: 10% !important">RE Cost</td>
													<td ><%=projectattributes[8] %></td>
													<td colspan="2" ></td>
												</tr>
											
												<tr>
													<td style="width: 10% !important">FE Cost</td>		
													<td ><%=projectattributes[9] %></td>					
													<td colspan="2"></td>
												</tr>
												
												<tr>	
													<td style="width: 10% !important" >Total Cost</td>	
													<td ><%=projectattributes[7] %></td>
													<td colspan="2"></td>			
												</tr> 
											<%} %>
												
																			 	
										<tr>
											<td  style="width: 20px; padding: 5px; padding-left: 10px">(j)</td>
											<td style="width: 150px;padding: 5px; padding-left: 10px"><b>No. of EBs and PMRCs held</b> </td>
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
											<div align="center" style="margin: 25px;"> Complete Project Data Not Found </div>
										<%} %>
									<% } %>
							</div>
						</details>


<!--  ---------------------------------------------------------------------------------------------------------------------------------------------  -->		
				
						<details>
	   						<summary role="button" tabindex="0"><b>2. Schematic Configuration</b>   </summary>
	   						<div class="content">
	   						<%for(int z=0;z<projectidlist.size();z++){ %>
	   						<div align="left" style="margin-left: 15px;">
	   							
								<%-- <%if(ProjectDetail.size()>1){ %> --%>
										<div>
											<form action="ProjectData.htm" method="post" target="_blank">
												<b>Project : <%=ProjectDetail.get(z)[1] %> 	<%if(z!=0){ %>(SUB)<%} %>	</b>
												<button type="submit" name="action" value="edit"  class="btn btn-sm edit" style="padding : 3px;" > <i class="fa fa-pencil-square-o fa-lg" style="color: black" aria-hidden="true"></i> </button>
												<input type="hidden" name="projectid" value="<%=ProjectDetail.get(z)[0] %>">
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
											</form>
										</div>	
								<%-- <%} %> --%>
	   							<table >
									<tr>
										<td style="border:0;"> 
										
										
											<%if(projectdatadetails.get(z)!=null && projectdatadetails.get(z)[3]!=null){ %>
												<form action="ProjectDataSystemSpecsFileDownload.htm"  method="post" target="_blank" >	
													2 (a) System Configuration. &nbsp; <span class="anchorlink" onclick="$('#config<%=ProjectDetail.get(z)[0] %>').toggle();" style="color: #C84B31;cursor: pointer;" ><b>As on File Attached</b></span>
													<button  type="submit" class="btn btn-sm "  ><i class="fa fa-download fa-lg" ></i></button>
													<input type="hidden" name="projectdataid" value="<%=projectdatadetails.get(z)[0]%>"/>
													<input type="hidden" name="filename" value="sysconfig"/>
													<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
												</form>	
												
												
												<%if(FilenameUtils.getExtension(projectdatadetails.get(z)[3].toString()).equalsIgnoreCase("pdf")){ %>
													<iframe	width="1200" height="600" src="data:application/pdf;base64,<%=pdffiles.get(z)[0]%>"  id="config<%=ProjectDetail.get(z)[0] %>" style="display: none" > </iframe>
												<%}else{ %>
													<img style="max-width:25cm;max-height:17cm;display: none" src="data:image/<%=FilenameUtils.getExtension(projectdatadetails.get(z)[3].toString()) %>;base64,<%=pdffiles.get(z)[0]%>"  id="config<%=ProjectDetail.get(z)[0] %>"  > 											
												<%} %>

											<%}else{ %>
												2 (a) System Configuration. &nbsp; File Not Found
											<%} %>
										
										
										</td>
											
									</tr>
								</table>
							
							</div>
							<div align="left" style="margin-left: 15px;">
							<table >
								<tr>
									<td style="border:0;"> 
										<%if(projectdatadetails.get(z)!=null && projectdatadetails.get(z)[4]!=null){ %>
											<form action="ProjectDataSystemSpecsFileDownload.htm"  method="post" target="_blank" >	
															
												2 (b) System Specifications. &nbsp; <span class="anchorlink" onclick="$('#sysspecs<%=ProjectDetail.get(z)[0] %>').toggle();" style="color: #C84B31;cursor: pointer;" ><b>As on File Attached</b></span>
												<button  type="submit" class="btn btn-sm "  ><i class="fa fa-download fa-lg" ></i></button>
												<input type="hidden" name="projectdataid" value="<%=projectdatadetails.get(z)[0]%>"/>
												<input type="hidden" name="filename" value="sysspecs"/>
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
											</form>
											<%if(FilenameUtils.getExtension(projectdatadetails.get(z)[4].toString()).equalsIgnoreCase("pdf")){ %>
												<iframe	width="1200" height="600" src="data:application/pdf;base64,<%=pdffiles.get(z)[3]%>"  id="sysspecs<%=ProjectDetail.get(z)[0] %>" style="display: none" > </iframe>
											<%}else{ %>
												<img style="max-width:25cm;max-height:17cm;display: none" src="data:image/<%=FilenameUtils.getExtension(projectdatadetails.get(z)[4].toString()) %>;base64,<%=pdffiles.get(z)[3]%>"  id="sysspecs<%=ProjectDetail.get(z)[0] %>"  > 											
											<%} %>
												
										<%}else{ %>
											2 (b) System Specifications. &nbsp; File Not Found
										<%} %>
									
									
									
									</td>
									<td style="border:0;">  
									
									</td>
								</tr>
							</table>
							</div>
							<%} %>
							</div>
						</details>
	
	<!--  ---------------------------------------------------------------------------------------------------------------------------------------------  -->
							
						<details>
	   						<summary role="button" tabindex="0"><b>3. Overall Product tree/WBS</b> </summary>
							
							<%for(int z=0;z<projectidlist.size();z++){ %>
							<div>
								<%if(ProjectDetail.size()>1){ %>
									<div style="margin-left:1rem; ">
										<b>Project : <%=ProjectDetail.get(z)[1] %> 	<%if(z!=0){ %>(SUB)<%} %>	</b>
									</div>	
								<%} %>
								<table>
									<tr>
										<td style="border:0; padding-left: 1.5rem;"> 
											<%if(projectdatadetails.get(z)!=null && projectdatadetails.get(z)[5]!=null){ %>
											
												<form action="ProjectDataSystemSpecsFileDownload.htm"  method="post" target="_blank" >	
													Overall Product tree/WBS &nbsp; :  &nbsp;<span class="anchorlink" onclick="$('#protree<%=ProjectDetail.get(z)[0] %>').toggle();" style="color: #C84B31;cursor: pointer;" ><b>As on File Attached</b></span>	
													<button  type="submit" class="btn btn-sm "  ><i class="fa fa-download fa-lg" ></i></button>
													<input type="hidden" name="projectdataid" value="<%=projectdatadetails.get(z)[0]%>"/>
													<input type="hidden" name="filename" value="protree"/>
													<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
												</form>	
												
												
												<%if(FilenameUtils.getExtension(projectdatadetails.get(z)[5].toString()).equalsIgnoreCase("pdf")){ %>
													<iframe	width="1200" height="600" src="data:application/pdf;base64,<%=pdffiles.get(z)[1]%>"  id="protree<%=ProjectDetail.get(z)[0] %>" style="display: none" > </iframe>
												<%}else{ %>
													<img style="max-width:25cm;max-height:17cm;display: none" src="data:image/<%=FilenameUtils.getExtension(projectdatadetails.get(z)[5].toString()) %>;base64,<%=pdffiles.get(z)[1]%>"  id="protree<%=ProjectDetail.get(z)[0] %>"  > 											
												<%} %>
												
											<%}else{ %>
												Overall Product tree/WBS &nbsp; File Not Found
											<%} %>
										
										</td>
										<td style="border:0;">  
											
										</td>
									</tr>
								</table>
							</div>
							<%} %>
						</details>
 
<!--  ---------------------------------------------------------------------------------------------------------------------------------------------  -->		
				
						<details>
   						<summary role="button" tabindex="0"><b>4. Particulars of Meeting </b> </summary>
   						
   						<div class="content">
   							<%for(int z=0;z<projectidlist.size();z++){ %>
   								<h1 class="break"></h1>
   								
   								  	<%if(ProjectDetail.size()>1){ %>
										<div>
											<b>Project : <%=ProjectDetail.get(z)[1] %> 	<%if(z!=0){ %>(SUB)<%} %>	</b>
										</div>	
									<%} %>	
								   <div align="left" style="margin-left: 15px;">(a) <%if(committee.getCommitteeShortName().trim().equalsIgnoreCase("PMRC")){ %>
															   						Approval 
															   						<%}else { %>
															   						Ratification
															   						<%} %>  of <b>recommendations</b> of last <%=committee.getCommitteeShortName().trim().toUpperCase() %> Meeting (if any)</div>
															   						
							
			<table class="subtables" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px; border-collapse:collapse;" >
				<thead>
					<tr>
						<td colspan="6" style="border: 0">
							<p style="font-size: 10px;text-align: center"> 
								<span class="notassign">NA</span> : Not Assigned &nbsp;&nbsp;
								<span class="assigned">AA</span> : Activity Assigned &nbsp;&nbsp; 
								<span class="ongoing">OG</span> : On Going &nbsp;&nbsp; 
								<span class="delay">DO</span> : Delay - On Going &nbsp;&nbsp; 
								<span class="ongoing">RC</span> : Review & Close &nbsp;&nbsp;
								<span class="delay">FD</span> : Forwarded With Delay &nbsp;&nbsp;
								<span class="completed">CO</span> : Completed &nbsp;&nbsp; 
								<span class="completeddelay">CD</span> : Completed with Delay &nbsp;&nbsp; 
								<span class="inactive">IA</span> : InActive &nbsp;&nbsp;
								<span class="delaydays">DD</span> : Delayed days &nbsp;&nbsp; 
							</p>
						</td>									
					</tr>
										
					<tr>
						<th  style="width: 15px !important;text-align: center;">SN</th>
						<th  style="width: 315px !important;">Recommendation Point</th>
						<th  style="width: 100px !important;"> PDC</th>
						<th  style="width: 210px !important;"> Responsibility</th>
						<th  style="width: 80px !important;">Status(DD)</th>
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
							<td style="text-align: center;"><%=i %></td>
							<td style="text-align: justify; "><%=obj[2] %></td>
							<td style=" text-align: center;">
								<%if(obj[8]!= null){ %><br><%=sdf.format(sdf1.parse(obj[8].toString()))%><%} %>		
								<%if(obj[7]!= null){ %><br><%=sdf.format(sdf1.parse(obj[7].toString()))%><%} %>
								<%if(obj[4]!= null){ %><%=sdf.format(sdf1.parse(obj[6].toString()))%><%} %>
							</td>
							<td>
								<%if(obj[4]!= null){ %>  
									<%=obj[12] %><%-- , <%=obj[13] %> --%>
								<%}else { %><span class="">Not Assigned</span> <%} %> 
							</td>
							<td  style="text-align: center; ">
								<%if(obj[4]!= null){
									
								if(obj[18]!=null){ %>
									<%if(obj[10].toString().equals("I")&&obj[16].toString().equals("F")&&(LocalDate.parse(obj[6].toString()).isAfter(LocalDate.parse(obj[14].toString())) || LocalDate.parse(obj[6].toString()) .equals(LocalDate.parse(obj[14].toString())) )){ %>
										<span class="ongoing">RC</span>
								<%}else if(obj[10].toString().equals("I")&&obj[16].toString().equals("F")&&LocalDate.parse(obj[6].toString()).isBefore(LocalDate.parse(obj[14].toString()))){  %>
										<span class="delay">FD</span>
								<%}else if(obj[10].toString().equals("C")&&(LocalDate.parse(obj[6].toString()).isAfter(LocalDate.parse(obj[14].toString()))||obj[6].equals(obj[14]))){  %>
										<span class="completed">CO</span>
								<%}else if(obj[10].toString().equals("C") && LocalDate.parse(obj[6].toString()).isBefore(LocalDate.parse(obj[14].toString()))){  %>
									   <span class="completeddelay">CD 
									   (<%=  ChronoUnit.DAYS.between(LocalDate.parse(obj[6].toString()), LocalDate.parse(obj[14].toString()))   %>) 
									   </span>
								<%}else if(!obj[16].toString().equals("F") && !obj[10].toString().equals("C") &&(LocalDate.parse(obj[6].toString()).isAfter(LocalDate.now())||LocalDate.parse(obj[6].toString()).equals(LocalDate.now()))){  %>
										<span class="ongoing">OG</span>
								<%}else if(!obj[16].toString().equals("F")&& !obj[10].toString().equals("C") && LocalDate.parse(obj[6].toString()).isBefore(LocalDate.now())){  %> 
										<span class="delay">DO
											 (<%= ChronoUnit.DAYS.between(LocalDate.parse(obj[6].toString()), LocalDate.now())  %>)   
										</span>
								<%} }else if(obj[10].toString().equals("C")){%>
								        <span class="completed">CO</span>
							    <% }else{ %>
							    		<span class="assigned">AA</span> 
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
				
							
							
		 <%if((Double.parseDouble(projectattributeslist.get(0)[7].toString())*100000)>1){ %>
								  
		  	<div align="left" style="margin-left: 15px;">(b) Last <%=committee.getCommitteeShortName().trim().toUpperCase() %>
															   						Meeting action points with Probable Date of completion (PDC), Actual Date of Completion (ADC) and current status.</div>
					<table class="subtables" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;   border-collapse:collapse;" >
						<thead>
							<tr>
								<td colspan="7" style="border: 0">
									<p style="font-size: 10px;text-align: center"> 
										<span class="notassign">NA</span> : Not Assigned &nbsp;&nbsp;
										<span class="assigned">AA</span> : Activity Assigned &nbsp;&nbsp; 
										<span class="ongoing">OG</span> : On Going &nbsp;&nbsp; 
										<span class="delay">DO</span> : Delay - On Going &nbsp;&nbsp; 
										<span class="ongoing">RC</span> : Review & Close &nbsp;&nbsp;
										<span class="delay">FD</span> : Forwarded With Delay &nbsp;&nbsp;
										<span class="completed">CO</span> : Completed &nbsp;&nbsp; 
										<span class="completeddelay">CD</span> : Completed with Delay &nbsp;&nbsp; 
										<span class="inactive">IA</span> : InActive &nbsp;&nbsp;
										<span class="delaydays">DD</span> : Delayed days &nbsp;&nbsp; 
									</p>
								</td>									
							</tr>
										
							<tr>
								<th  style="width: 15px !important;text-align: center;  ">SN</th>
								<th  style="width: 280px; ">Action Point</th>
								<th  style="width: 100px; ">PDC</th>
								<th  style="width: 100px; "> ADC</th>
								<th  style="width: 210px; "> Responsibility</th>
								<th  style="width: 80px; ">Status(DD)</th>
								<th  style="width: 205px; ">Remarks</th>			
							</tr>
						</thead>
							
						<tbody>		
							<%if(lastpmrcactions.get(z).size()==0){ %>
								<tr><td colspan="7"  style="text-align: center;" > Nil</td></tr>
								<%}
								else if(lastpmrcactions.size()>0)
								{int i=1;
								for(Object[] obj:lastpmrcactions.get(z)){ %>
								<tr>
									<td  style="text-align: center;"><%=i %></td>
									<td  style="text-align: justify ;"><%=obj[2] %></td>
									<td  style="text-align: center;" >
										<%-- <%= sdf.format(sdf1.parse(obj[3].toString()))%> --%>
										<%if(obj[6]!= null){ %><br><%=sdf.format(sdf1.parse(obj[6].toString()))%><% } %>
										<%if(obj[5]!= null){ %><br><%=sdf.format(sdf1.parse(obj[5].toString()))%><% } %>
										<%=sdf.format(sdf1.parse(obj[3].toString()))%>
									</td>
									<td   style="text-align: center;"> 
										<%if(obj[9].toString().equals("C")  && obj[13]!=null){ %>

											<%if(obj[15]!=null){ %>
													
													
												<%if(obj[9].toString().equals("I") && obj[14].toString().equals("F") && (LocalDate.parse(obj[3].toString()).isAfter(LocalDate.parse(obj[13].toString())) || LocalDate.parse(obj[3].toString()).isEqual(LocalDate.parse(obj[13].toString())) )){ %>
													<span class="ongoing"><%= sdf.format(sdf1.parse(obj[13].toString()))%> </span>
												<%}else if(obj[9].toString().equals("I") && obj[14].toString().equals("F") && LocalDate.parse(obj[3].toString()).isBefore(LocalDate.parse(obj[13].toString()))){  %>
													<span class="delay"><%= sdf.format(sdf1.parse(obj[13].toString()))%> </span>
												<%}else if(obj[9].toString().equals("C")&&(LocalDate.parse(obj[3].toString()).isAfter(LocalDate.parse(obj[13].toString()))||obj[3].equals(obj[13]))){  %>
													<span class="completed"><%= sdf.format(sdf1.parse(obj[13].toString()))%> </span>
												<%}else if(obj[9].toString().equals("C")&&LocalDate.parse(obj[3].toString()).isBefore(LocalDate.parse(obj[13].toString()))){  %>
												   <span class="completeddelay"><%= sdf.format(sdf1.parse(obj[13].toString()))%> </span>
												<%}else if( !obj[9].toString().equals("C") && !obj[14].toString().equals("F") &&(LocalDate.parse(obj[3].toString()).isAfter(LocalDate.now())|| LocalDate.parse(obj[3].toString()).isEqual(LocalDate.now()) )){  %> 
													<span class="ongoing"><%= sdf.format(sdf1.parse(obj[13].toString()))%> </span>
												<%}else if(!obj[9].toString().equals("C") && !obj[14].toString().equals("F") &&  LocalDate.parse(obj[3].toString()).isBefore(LocalDate.now())){  %> 
													<span class="delay"><%= sdf.format(sdf1.parse(obj[13].toString()))%> </span>
												<%}%>
														
														
										<%}else if(obj[9].toString().equals("C")){ %>
									        <span class="completed"><%= sdf.format(sdf1.parse(obj[13].toString()))%> </span>
									    <% }else{ %>
									      	<span class="assigned"><%= sdf.format(sdf1.parse(obj[13].toString()))%> </span> 
										<%} %> 
										
										<%}else{ %> - <%} %>
											
									</td>
									<td> <%=obj[11] %><%-- , <%=obj[12] %> --%> </td>
									<td  style="text-align: center;" > 
										<%if(obj[15]!=null){ %>
													
											<%if(obj[9].toString().equals("I") && obj[14].toString().equals("F") && (LocalDate.parse(obj[3].toString()).isAfter(LocalDate.parse(obj[13].toString())) || LocalDate.parse(obj[3].toString()).isEqual(LocalDate.parse(obj[13].toString())) )){ %>
												<span class="ongoing">RC</span>
											<%}else if(obj[9].toString().equals("I") && obj[14].toString().equals("F") && LocalDate.parse(obj[3].toString()).isBefore(LocalDate.parse(obj[13].toString()))){  %>
												<span class="delay">FD</span>
											<%}else if(obj[9].toString().equals("C") && (LocalDate.parse(obj[3].toString()).isAfter(LocalDate.parse(obj[13].toString()))||obj[3].equals(obj[13]))){  %>
												<span class="completed">CO</span>
											<%}else if(obj[9].toString().equals("C") && LocalDate.parse(obj[3].toString()).isBefore(LocalDate.parse(obj[13].toString()))){  %>
											   	<span class="completeddelay">CD (<%= ChronoUnit.DAYS.between(LocalDate.parse(obj[3].toString()), LocalDate.parse(obj[13].toString())) %>) </span>
											<%}else if( !obj[9].toString().equals("C") && !obj[14].toString().equals("F") &&(LocalDate.parse(obj[3].toString()).isAfter(LocalDate.now())|| LocalDate.parse(obj[3].toString()).isEqual(LocalDate.now()) )){  %> 
												<span class="ongoing">OG</span>
											<%}else if(!obj[9].toString().equals("C") && !obj[14].toString().equals("F") &&  LocalDate.parse(obj[3].toString()).isBefore(LocalDate.now())){  %> 
												<span class="delay">DO (<%= ChronoUnit.DAYS.between(LocalDate.parse(obj[3].toString()), LocalDate.now())  %>)  </span>
											<%}%>
													
										<% }else if(obj[9].toString().equals("C")){ %>
									        <span class="completed">CO</span>
									    <% }else{ %>
									      	<span class="assigned">AA</span> 
										<%} %> 
									</td>	
									<td  style="text-align: justify ;"><%if(obj[16]!=null){%><%=obj[16] %><%} %></td>			
								</tr>			
							<%i++;
							}} %>
							</tbody>
									
						</table> 
								
					<%} %>
								
					<div align="left" style="margin-left: 15px;">(c) Details of Technical/ User Reviews (if any).</div>
						
							
						<div align="center">
								<!-- <div align="center" style="max-width:400px;float:left;"> -->
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
										<%}
										else if(ReviewMeetingList.size()>0)
										  {int i=1;
										for(Object[] obj:ReviewMeetingList.get(z)){ %>
											<tr>
												
												<td  style="max-width: 70px;"><%=obj[1] %> #<%=i %></td>												
												<%-- <td  style="max-width: 200px;" ><%= obj[4]%></td> --%>
												<td  style="max-width: 80px;text-align: center; " ><%= sdf.format(sdf1.parse(obj[3].toString()))%></td>
											</tr>			
										<%i++;
										}}else{ %>
										<tr><td colspan="4" style="text-align: center;" > Nil</td></tr>
										<%} %> 
								</tbody>
							</table>
							<!-- </div> -->
							<!-- <div align="center" style="max-width:400px;float:right;"> -->
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
												<td  style="max-width: 70px;"><%=obj[1] %> #<%=i %></td>												
												<%-- <td  style="max-width: 200px;" ><%= obj[4]%></td> --%>
												<td  style="max-width: 80px;text-align: center; " ><%= sdf.format(sdf1.parse(obj[3].toString()))%></td>
											</tr>			
										<%i++;
										}}else{ %>
										
											<tr><td colspan="4" style="text-align: center;" > Nil</td></tr>
										
									<%} %> 
								</tbody>
							</table>
						<!-- </div> -->
					</div>
			
															
					<%} %>
				</div>
					
						</details>
						
<!--  ---------------------------------------------------------------------------------------------------------------------------------------------  -->				
	
						<details>
   						<summary role="button" tabindex="0"><b>5. Milestones achieved prior to this <%=committeeData.getCommitteeShortName().trim().toUpperCase() %> period.</b>  </summary>
							<div class="content">
				
								<%for(int z=0;z<projectidlist.size();z++){ %>
									<%if(ProjectDetail.size()>1){ %>
										<div>
											<b>Project : <%=ProjectDetail.get(z)[1] %> 	<%if(z!=0){ %>(SUB)<%} %>	</b>
										</div>	
									<%} %>	
				
							<table  class="subtables" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;  border-collapse:collapse;" >
								<thead>
								<tr>
									<td colspan="10" style="border: 0">
										<p style="font-size: 10px;text-align: center"> 
											 <span class="notassign">NA</span> : Not Assigned &nbsp;&nbsp;
											 <span class="assigned">AA</span> : Activity Assigned &nbsp;&nbsp; 
											 <span class="ongoing">OG</span> : On Going &nbsp;&nbsp; 
											 <span class="delay">DO</span> : Delay - On Going &nbsp;&nbsp; 
											 <span class="ongoing">RC</span> : Review & Close &nbsp;&nbsp;
											 <span class="delay">FD</span> : Forwarded With Delay &nbsp;&nbsp;
											 <span class="completed">CO</span> : Completed &nbsp;&nbsp; 
											 <span class="completeddelay">CD</span> : Completed with Delay &nbsp;&nbsp; 
											 <span class="inactive">IA</span> : InActive &nbsp;&nbsp;
											 <span class="delaydays">DD</span> : Delayed days &nbsp;&nbsp; 
										 </p>
									</td>									
								</tr>
								
									<tr>
										<th  style="width: 20px; ">SN</th>
										<th  style="width: 30px; ">MS</th>
										<th  style="width: 60px; ">L</th>
										<th  style="width: 350px; ">System/ Subsystem/ Activities</th>
										<th  style="width: 150px; "> PDC</th>
										<th  style="width: 150px; "> ADC</th>
										<th  style="width: 60px; "> Progress</th>
										<th  style="width: 50px; "> Status(DD)</th>
									 	<th  style="width: 260px; "> Remarks</th>
									 	<th  style="max-width: 30px; "> Info </th>
									</tr>
								</thead>
									<% if( milestones.get(z).size()>0){
										long count1=1;
										int milcountA=1;
										int milcountB=1;
										int milcountC=1;
										int milcountD=1;
										int milcountE=1;
										
										%>
										<%int serial=1;for(Object[] obj:milestones.get(z)){
											
											if(Integer.parseInt(obj[21].toString())<= Integer.parseInt(levelid) ){
											%>
											<tr>
												<td style="text-align: center"><%=serial%></td>
												<td>M<%=obj[0] %></td>
												
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
												<td style="text-align: center">
													<%if(! LocalDate.parse(obj[8].toString()).isEqual(LocalDate.parse(obj[9].toString())) ){ %> 
														<%= sdf.format(sdf1.parse(obj[8].toString()))%><br> 
													<%}%>
													<%=sdf.format(sdf1.parse(obj[9].toString())) %>
												</td>
												<td style="text-align: center">
													<%if((obj[19].toString().equalsIgnoreCase("3") || obj[19].toString().equalsIgnoreCase("5") )&& obj[24]!=null){ %>
														<span class="<%if(obj[19].toString().equalsIgnoreCase("0")){%>assigned
																<%}else if(obj[19].toString().equalsIgnoreCase("1")) {%> assigned
																<%}else if(obj[19].toString().equalsIgnoreCase("2")) {%> ongoing
																<%}else if(obj[19].toString().equalsIgnoreCase("3")) {%> completed
																<%}else if(obj[19].toString().equalsIgnoreCase("4")) {%> delay 
																<%}else if(obj[19].toString().equalsIgnoreCase("5")) {%> completeddelay
																<%}else if(obj[19].toString().equalsIgnoreCase("6")) {%> inactive<%} %>	 " >
														 
															<%= sdf.format(sdf1.parse(obj[24].toString()))%> 
														</span>
													<%}else{%>
														-
													<%} %>
												</td>
												<td style="text-align: center"><%=obj[17] %>%</td>											
												<td style="text-align: center">
													<span class="<%if(obj[19].toString().equalsIgnoreCase("0")){%>assigned
															<%}else if(obj[19].toString().equalsIgnoreCase("1")) {%> assigned
															<%}else if(obj[19].toString().equalsIgnoreCase("2")) {%> ongoing
															<%}else if(obj[19].toString().equalsIgnoreCase("3")) {%> completed
															<%}else if(obj[19].toString().equalsIgnoreCase("4")) {%> delay 
															<%}else if(obj[19].toString().equalsIgnoreCase("5")) {%> completeddelay
															<%}else if(obj[19].toString().equalsIgnoreCase("6")) {%> inactive<%} %>	 " >
														<%=obj[22] %>	
														
														<%if((obj[19].toString().equalsIgnoreCase("3") || obj[19].toString().equalsIgnoreCase("5") )&& obj[24]!=null){ %>
															(<%= ChronoUnit.DAYS.between(LocalDate.parse(obj[9].toString()), LocalDate.parse(obj[24].toString())) %>) 
														<%}else if(obj[19].toString().equalsIgnoreCase("4")){ %>
															(<%= ChronoUnit.DAYS.between(LocalDate.parse(obj[9].toString()), LocalDate.now()) %>)
														<%} %>	
													</span>
												
												</td>
												<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;"><%if(obj[23]!=null){%><%=obj[23]%><%} %></td>
	                                            <td >
													<a  data-toggle="modal" data-target="#exampleModal1" data-id="milestonemodal<%=obj[0] %>" class="milestonemodal" data-whatever="@mdo" style="padding: 0px 1.5rem;cursor:pointer" >
														<i class="fa fa-info-circle " style="font-size: 1.3rem;color:#145374 " aria-hidden="true"></i> 
													</a>
												</td>
											</tr>
										<%count1++;serial++;}} %>
									<%} else{ %>
									<tr><td colspan="9" style="text-align:center; "> Nil</td></tr>
									
									
									<%} %>
							</table>
			
			
								<div id="milestoneactivitychange" ></div>
								
							<%} %>
						</div>
						</details>

<!--  ---------------------------------------------------------------------------------------------------------------------------------------------  -->					
						<details>
   						<summary role="button" tabindex="0" id="leveltab"><b>6. Details of work and current status of sub system with major milestones (since last <%=committeeData.getCommitteeShortName().trim().toUpperCase()%>)</b>  </summary>
						<div class="content">
							
							<%for(int z=0;z<projectidlist.size();z++){ %>
								<%if(ProjectDetail.size()>1){ %>
									<div>
										<b>Project : <%=ProjectDetail.get(z)[1] %> 	<%if(z!=0){ %>(SUB)<%} %>	</b>
									</div>	
								<%} %>	
								<div align="left" style="margin-left: 15px;">(a) Work carried out, Achievements, test result etc.
									   <%if(z==0){ %>
										<form action="FilterMilestone.htm" method="POST">  
											<button class="btn btn-sm back"    style="float: right;margin-top: 5px;text-transform: capitalize !important; " formtarget="blank"> Filter</button> 
											<input type="hidden" name="projectidvalue" <%if( projectid!=null ){%> value="<%=projectid%>" <%}%>>
											<input type="hidden" name="committeidvalue" <%if(committeeid!=null){%> value="<%=committeeid %>" <%}%>>
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										</form>
										<%}%> 
								</div>
								<div align="left" style="margin-left: 20px;"><b>Present Status:</b>
								
								</div>
								
								
								
			<!-- Tharun code Start (For Filtering Milestone based on levels) -->		
			
			
						<table  class="subtables" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;  border-collapse:collapse;" >
							<thead>
							<tr>
								<td colspan="10" style="border: 0">
									<p style="font-size: 10px;text-align: center"> 
										 <span class="notassign">NA</span> : Not Assigned &nbsp;&nbsp;
										 <span class="assigned">AA</span> : Activity Assigned &nbsp;&nbsp; 
										 <span class="ongoing">OG</span> : On Going &nbsp;&nbsp; 
										 <span class="delay">DO</span> : Delay - On Going &nbsp;&nbsp; 
										 <span class="ongoing">RC</span> : Review & Close &nbsp;&nbsp;
										 <span class="delay">FD</span> : Forwarded With Delay &nbsp;&nbsp;
										 <span class="completed">CO</span> : Completed &nbsp;&nbsp; 
										 <span class="completeddelay">CD</span> : Completed with Delay &nbsp;&nbsp; 
										 <span class="inactive">IA</span> : InActive &nbsp;&nbsp;
										 <span class="delaydays">DD</span> : Delayed days &nbsp;&nbsp; 
									 </p>
								</td>									
							</tr>
							
							<tr>
								<th  style="width: 20px; ">SN</th>
								<th  style="width: 30px; ">MS</th>
								<th  style="width: 60px; ">L</th>
								<th  style="width: 350px; ">System/ Subsystem/ Activities</th>
								<th  style="width: 150px; "> PDC</th>
								<th  style="width: 150px; "> ADC</th>
								<th  style="width: 60px; "> Progress</th>
								<th  style="width: 50px; "> Status(DD)</th>
							 	<th  style="width: 260px; "> Remarks</th>
							 	<th  style="max-width: 30px; "> Info </th>
							</tr>
							</thead>
								<% if( MilestoneDetails6.get(z).size()>0) { 
									long count1=1;
									int milcountA=1;
									int milcountB=1;
									int milcountC=1;
									int milcountD=1;
									int milcountE=1;
									
									%>
									<%int serial=1;for(Object[] obj:MilestoneDetails6.get(z)){
										
										if(Integer.parseInt(obj[21].toString())<= Integer.parseInt(levelid) ){
										%>
										<tr>
											<td style="text-align: center"><%=serial%></td>
											<td>M<%=obj[0] %></td>
											
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
											<td style="text-align: center">
												<%if(! LocalDate.parse(obj[8].toString()).isEqual(LocalDate.parse(obj[9].toString())) ){ %> 
													<%= sdf.format(sdf1.parse(obj[8].toString()))%><br> 
												<%}%>
												<%=sdf.format(sdf1.parse(obj[9].toString())) %>
											</td>
											<td style="text-align: center">
												<%if((obj[19].toString().equalsIgnoreCase("3") || obj[19].toString().equalsIgnoreCase("5") )&& obj[24]!=null){ %>
													<span class="<%if(obj[19].toString().equalsIgnoreCase("0")){%>assigned
															<%}else if(obj[19].toString().equalsIgnoreCase("1")) {%> assigned
															<%}else if(obj[19].toString().equalsIgnoreCase("2")) {%> ongoing
															<%}else if(obj[19].toString().equalsIgnoreCase("3")) {%> completed
															<%}else if(obj[19].toString().equalsIgnoreCase("4")) {%> delay 
															<%}else if(obj[19].toString().equalsIgnoreCase("5")) {%> completeddelay
															<%}else if(obj[19].toString().equalsIgnoreCase("6")) {%> inactive<%} %>	 " >
													 
														<%= sdf.format(sdf1.parse(obj[24].toString()))%> 
													</span>
												<%}else{%>
													-
												<%} %>
											</td>
											<td style="text-align: center"><%=obj[17] %>%</td>											
											<td style="text-align: center">
											<span class="<%if(obj[19].toString().equalsIgnoreCase("0")){%>assigned
														<%}else if(obj[19].toString().equalsIgnoreCase("1")) {%> assigned
														<%}else if(obj[19].toString().equalsIgnoreCase("2")) {%> ongoing
														<%}else if(obj[19].toString().equalsIgnoreCase("3")) {%> completed
														<%}else if(obj[19].toString().equalsIgnoreCase("4")) {%> delay 
														<%}else if(obj[19].toString().equalsIgnoreCase("5")) {%> completeddelay
														<%}else if(obj[19].toString().equalsIgnoreCase("6")) {%> inactive<%} %>	 " >
												<%=obj[22] %>	
												<%if((obj[19].toString().equalsIgnoreCase("3") || obj[19].toString().equalsIgnoreCase("5") )&& obj[24]!=null){ %>
													(<%= ChronoUnit.DAYS.between(LocalDate.parse(obj[9].toString()), LocalDate.parse(obj[24].toString())) %>) 
												<%}else if(obj[19].toString().equalsIgnoreCase("4")){ %>
													(<%= ChronoUnit.DAYS.between(LocalDate.parse(obj[9].toString()), LocalDate.now()) %>)
												<%} %>
												
											</span>
											
											</td>
											<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;"><%if(obj[23]!=null){%><%=obj[23]%><%} %></td>
                                            <td >
												<a  data-toggle="modal" data-target="#exampleModal1" data-id="milestonemodal<%=obj[0] %>" class="milestonemodal" data-whatever="@mdo" style="padding: 0px 1.5rem;cursor:pointer" >
													<i class="fa fa-info-circle " style="font-size: 1.3rem;color:#145374 " aria-hidden="true"></i> 
												</a>
											</td>
										</tr>
									<%count1++;serial++;}} %>
								<%} else{ %>
								<tr><td colspan="9" style="text-align:center; "> Nil</td></tr>
								
								
								<%} %>
							</table>

								<!--  Commenting Old Data End-->
							
								<div align="left" style="margin-left: 15px;">(b) TRL table with TRL at sanction stage and current stage indicating overall PRI.</div>
									
								<div>
									<table  >
										<tr><td style="border:0;"></td>
											<td style="border:0;">  
											<%if(projectdatadetails.get(z)!=null && projectdatadetails.get(z)[6]!=null ){ %>
												<form action="ProjectDataSystemSpecsFileDownload.htm"  method="post" target="_blank" >	
													<span class="anchorlink" onclick="$('#pearl<%=ProjectDetail.get(z)[0] %>').toggle();"  style="color: #C84B31;cursor: pointer;" ><b>As on File Attached</b></span>
													<button  type="submit" class="btn btn-sm "  ><i class="fa fa-download fa-lg" ></i></button>
													<input type="hidden" name="projectdataid" value="<%=projectdatadetails.get(z)[0]%>"/>
													<input type="hidden" name="filename" value="pearl"/>
													<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
												</form>	
												
												<%if(FilenameUtils.getExtension(projectdatadetails.get(z)[6].toString()).equalsIgnoreCase("pdf")){ %>
													<iframe	width="1200" height="600" src="data:application/pdf;base64,<%=pdffiles.get(z)[2]%>"  id="pearl<%=ProjectDetail.get(z)[0] %>" style="display: none" > </iframe>
												<%}else{ %>
													<img style="max-width:25cm;max-height:17cm;display: none" src="data:image/<%=FilenameUtils.getExtension(projectdatadetails.get(z)[6].toString()) %>;base64,<%=pdffiles.get(z)[2]%>"  id="pearl<%=ProjectDetail.get(z)[0] %>"  >											
												<%} %>
												
												
											<% }else{ %>
												File Not Found
											<%} %>
										</td>
										</tr>
									</table>
								</div>
								<div align="left" style="margin-left: 15px;">(c) Risk Matrix/Management Plan/Status. </div>

									<table class="subtables" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;  border-collapse:collapse;" >
										<thead>	
											
											<tr>
												<td colspan="9" style="border: 0">
													<p style="font-size: 10px;text-align: center"> 
														<span class="notassign">NA</span> : Not Assigned &nbsp;&nbsp;
														<span class="assigned">AA</span> : Activity Assigned &nbsp;&nbsp; 
														<span class="ongoing">OG</span> : On Going &nbsp;&nbsp; 
														<span class="delay">DO</span> : Delay - On Going &nbsp;&nbsp; 
														<span class="ongoing">RC</span> : Review & Close &nbsp;&nbsp;
														<span class="delay">FD</span> : Forwarded With Delay &nbsp;&nbsp;
														<span class="completed">CO</span> : Completed &nbsp;&nbsp; 
														<span class="completeddelay">CD</span> : Completed with Delay &nbsp;&nbsp; 
														<span class="inactive">IA</span> : InActive &nbsp;&nbsp;
														<span class="delaydays">DD</span> : Delayed days &nbsp;&nbsp; 
													</p>
								   				</td>									
											</tr>
							
											<tr>
												<th style="width: 15px;text-align: center " rowspan="2">SN</th>
												<th style="width: 330px; "  colspan="3">Risk</th>
												<th style="width: 100px; " rowspan="1" > PDC</th>
												<th style="width: 100px; " rowspan="1"> ADC</th>
												<th style="width: 160px; " rowspan="1"> Responsibility</th>
												<th style="width: 50px; " rowspan="1">Status(DD)</th>
												<th style="width: 215px;" rowspan="1">Remarks</th>	
											</tr>
										<!-- 	<tr>
												<th  style="text-align: center;width: 100px;"> Category</th>
												<th  style="text-align: center;width: 100px;" colspan="2"> Type</th>
											</tr> -->
											<tr>
												<th  style="text-align: center;width: 110px; " > Severity</th>
												<th  style="text-align: center;width: 110px;"> Probability</th>
												<th  style="text-align: center;width: 110px;"> RPN</th>
												<th  style="width:210px" colspan="3" > Mitigation Plans</th>
												<th  style="width:215px" colspan="2"> Impact</th>		
											</tr>
										
										</thead>
																		
										<tbody>
												<%if(riskmatirxdata.get(z).size()>0){
												int i=0;
												%> 
													<%for(Object[] obj : riskmatirxdata.get(z)){
													i++;%>
													<tr>
														<td style="text-align: center" rowspan="2"><%=i %></td>
														<td style="text-align: justify;color: red; " colspan="3" >
															<%=obj[0] %><span style="color: #3D60FF;font-weight: bold;"> - <%=obj[23] %><%=obj[24]%></span>
														</td>
														<td style="text-align: center" rowspan="1">
															<%if(obj[11]!= null){ %><br><%=sdf.format(sdf1.parse(obj[11].toString()))%><%} %>
															<%if(obj[10]!= null){ %><br><%=sdf.format(sdf1.parse(obj[10].toString()))%><%} %>
															<%=sdf.format(sdf1.parse(obj[9].toString())) %>
														</td>
														
														<td style="text-align: center" rowspan="1">
															<%if(obj[15].toString().equals("C")  && obj[20]!=null){ %>

																<%if(obj[18]!=null){ %>
																	<%if(obj[15].toString().equals("I") && obj[16].toString().equals("F") && (LocalDate.parse(obj[9].toString()).isAfter(LocalDate.parse(obj[20].toString())) || LocalDate.parse(obj[9].toString()).isEqual(LocalDate.parse(obj[20].toString())) )){ %>
																		<span class="ongoing"><%= sdf.format(sdf1.parse(obj[20].toString()))%> </span>
																	<%}else if(obj[15].toString().equals("I") && obj[16].toString().equals("F") && LocalDate.parse(obj[9].toString()).isBefore(LocalDate.parse(obj[20].toString()))){  %>
																		<span class="delay"><%= sdf.format(sdf1.parse(obj[20].toString()))%> </span>
																	<%}else if(obj[15].toString().equals("C")&&(LocalDate.parse(obj[9].toString()).isAfter(LocalDate.parse(obj[20].toString()))||obj[9].equals(obj[20]))){  %>
																		<span class="completed"><%= sdf.format(sdf1.parse(obj[20].toString()))%> </span>
																	<%}else if(obj[15].toString().equals("C")&&LocalDate.parse(obj[9].toString()).isBefore(LocalDate.parse(obj[20].toString()))){  %>
																	   <span class="completeddelay"><%= sdf.format(sdf1.parse(obj[20].toString()))%> </span>
																	<%}else if(!obj[16].toString().equals("F")&&obj[15].toString().equals("I")&&(LocalDate.parse(obj[9].toString()).isAfter(LocalDate.parse(obj[20].toString()))|| LocalDate.parse(obj[9].toString()).isEqual(LocalDate.parse(obj[20].toString())) )){  %> 
																	<span class="ongoing"><%= sdf.format(sdf1.parse(obj[20].toString()))%> </span>
																	<%}else if(!obj[16].toString().equals("F")&&obj[15].toString().equals("I")&&LocalDate.parse(obj[9].toString()).isBefore(LocalDate.parse(obj[20].toString()))){  %> 
																	<span class="delay"><%= sdf.format(sdf1.parse(obj[20].toString()))%> </span>
																	<%}
																	}else if(obj[15].toString().equals("C")){ %>
																        <span class="completed"><%= sdf.format(sdf1.parse(obj[20].toString()))%> </span>
																    <% }else{ %>
																      	<span class="assigned"><%= sdf.format(sdf1.parse(obj[20].toString()))%> </span> 
																<%} %> 
																
															<%}else{ %>-<%} %>
														</td>
															
														<td  rowspan="1"><%=obj[7] %><%-- ,&nbsp;<%=obj[8] %> --%></td>	
														<td style="text-align: center" rowspan="1">
															
															<%if(obj[18]!=null){ %>
																<%if(obj[15].toString().equals("I") && obj[16].toString().equals("F") && (LocalDate.parse(obj[9].toString()).isAfter(LocalDate.parse(obj[20].toString())) || LocalDate.parse(obj[9].toString()).isEqual(LocalDate.parse(obj[20].toString())) )){ %>
																	<span class="ongoing">RC</span>
																<%}else if(obj[15].toString().equals("I") && obj[16].toString().equals("F") && LocalDate.parse(obj[9].toString()).isBefore(LocalDate.parse(obj[20].toString()))){  %>
																	<span class="delay">FD</span>
																<%}else if(obj[15].toString().equals("C")&&(LocalDate.parse(obj[9].toString()).isAfter(LocalDate.parse(obj[20].toString()))||obj[9].equals(obj[20]))){  %>
																	<span class="completed">CO</span>
																<%}else if(obj[15].toString().equals("C")&&LocalDate.parse(obj[9].toString()).isBefore(LocalDate.parse(obj[20].toString()))){  %>
																   <span class="completeddelay">CD (<%= ChronoUnit.DAYS.between(LocalDate.parse(obj[9].toString()), LocalDate.parse(obj[20].toString())) %>) </span>
																<%}else if(!obj[16].toString().equals("F")&&obj[15].toString().equals("I")&&(LocalDate.parse(obj[9].toString()).isAfter(LocalDate.now())|| LocalDate.parse(obj[9].toString()).isEqual(LocalDate.now()) )){  %> 
																<span class="ongoing">OG</span>
																<%}else if(!obj[16].toString().equals("F")&&obj[15].toString().equals("I")&&LocalDate.parse(obj[9].toString()).isBefore(LocalDate.now())){  %> 
																<span class="delay">DO (<%= ChronoUnit.DAYS.between(LocalDate.parse(obj[9].toString()), LocalDate.now()) %>) </span>
															<%}
															}else if(obj[15].toString().equals("C")  && obj[20]!=null){ %>
														        <span class="completed">CO</span>
														    <% }else{ %>
														      	<span class="assigned">AA</span> 
															<% } %> 
											
														</td>
														<td style="text-align: justify" rowspan="1"><%if(obj[19]!=null){ %> <%=obj[19] %><%} %></td>
														
													</tr>	
													<%-- <tr>
														<td style="text-align: center;" ><% if(obj[23].toString().equalsIgnoreCase("I")){ %> Internal<%}else{ %>External<%} %></td>
														<td style="text-align: center;" colspan="2" ><%=obj[24] %></td>
													</tr> --%>
													
													<tr>
														<td style="text-align: center;" ><%=obj[1] %></td>
														<td style="text-align: center;" ><%=obj[2] %></td>
														<td style="text-align: center;" ><%=obj[22] %></td>
														<td style="text-align: justify;" colspan="3" ><%=obj[3] %></td>
														<td style="text-align: justify;" colspan="2" ><%=obj[21] %></td>
													</tr>
													
													<%if(riskmatirxdata.get(z).size() > i){ %>
														<tr>
															<td colspan="9" style="color:transparent ;">.</td>
														</tr>
													<%} %>		
															
													<%}%>
													
													
												<%}else{%>
													<tr><td colspan="7"  style="text-align: center;">Nil </td></tr>
												<%} %>
												
												
												
											</tbody>		
										</table>
										
									<% } %>
									</div>
							
									
						</details>
<!--  ---------------------------------------------------------------------------------------------------------------------------------------------  -->

						<details>
   						<summary role="button" tabindex="0"><b>7. Details of Procurement Plan (Major Items)</b>  </summary>
						<div class="content">
							<%for(int z=0;z<projectidlist.size();z++){ %>
								<%if(ProjectDetail.size()>1){ %>
									<div>
										<b>Project : <%=ProjectDetail.get(z)[1] %> 	<%if(z!=0){ %>(SUB)<%} %>	</b>
									</div>	
								<%} %>
									
							   	<table style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px; width: 980px;  border-collapse:collapse;" >
										 <thead>
											 <tr>
											 	<th colspan="8" ><span class="mainsubtitle">Demand Details ( > &#8377; <% if(projectdatadetails.get(0)!=null && projectdatadetails.get(0)[13] != null){ %>  <%=projectdatadetails.get(0)[13].toString().replaceAll("\\.\\d+$", "") %> <span class="currency">Lakhs</span> ) <%} else {%> -  )<%} %> </span> </th>
											 </tr>
										</thead>
										
										
										<tr>
											<th  style="width: 15px !important;text-align: center;">SN</th>
											<th  style="width: 175px;">Demand No</th>
											<th  style="width: 100px; ">Demand Date</th>
											<th  colspan="2" style="width: 355px;"> Nomenclature</th>
											<th  style="width: 80px;"> Est. Cost-Lakh &#8377;</th>
											<th  style="width: 50px; "> Status</th>
											<th  style="width: 195px;">Remarks</th>
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
									
										<thead>
											 <tr >
											 	<th colspan="8" ><span class="mainsubtitle">Order Placed ( > &#8377; <% if(projectdatadetails.get(0)!=null && projectdatadetails.get(0)[13] != null){ %>  <%=projectdatadetails.get(0)[13].toString().replaceAll("\\.\\d+$", "") %> <span class="currency">Lakhs</span> ) <%} else {%> -  )<%} %> </span> </th>
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
									
								
																	
								<%} %>
								
								<br>
									<table class="subtables" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;width:980px !important;  border-collapse:collapse;" >
										 <thead>
											 <tr >
												 <th colspan="8" ><span class="mainsubtitle">Total Summary of Procurement</span></th>
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
               
							</div>
						</details>

<!--  ---------------------------------------------------------------------------------------------------------------------------------------------  -->						
						<details>
   						<summary role="button" tabindex="0"><b>8. Overall Financial Status  <i style="text-decoration: underline;">(&#8377; Crore)</i> </b> </summary>
   						
						  	<div class="content">
						  	<%for(int z=0;z<projectidlist.size();z++){ %>
						  	<%if(ProjectDetail.size()>1){ %>
								<div>
									<b>Project : <%=ProjectDetail.get(z)[1] %> 	<%if(z!=0){ %>(SUB)<%} %>	</b>
								</div>	
							<%} %>	
						  	
						  	<br>				 
						  	<table  class="subtables" style="width: 980px;">
						  	    <thead>
		                           <tr>
		                         	<th colspan="2" style="text-align: center ;width:200px !important;">Head</td>
		                         	<th colspan="2" style="text-align: center;width:120px !important;">Sanction</td>
			                        <th colspan="2" style="text-align: center;width:120px !important;">Expenditure</td>
			                        <th colspan="2" style="text-align: center;width:120px !important;">Out Commitment </td>
		                           	<th colspan="2" style="text-align: center;width:120px !important;">Balance</td>
			                        <th colspan="2" style="text-align: center;width:120px !important;">DIPL</td>
		                          	<th colspan="2" style="text-align: center;width:120px !important;">Notional Balance</td>
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
  
  
							<%} %>
							
							</div> 		
						
						</details>
<!--  ---------------------------------------------------------------------------------------------------------------------------------------------  -->						
					<details>
						<%if(committeeData.getCommitteeShortName().trim().equalsIgnoreCase("EB")){ %>
   							<summary role="button" tabindex="0"><b>9. Action Plan for Next Six months </b>    </summary>
						<%}else { %>
							<summary role="button" tabindex="0"><b>9. Action Plan for Next Three months </b>    </summary>
						<%} %>
						
						<div class="content">
						<%for(int z=0;z<projectidlist.size();z++){ %>
							<%if(ProjectDetail.size()>1){ %>
								<div>
									<b>Project : <%=ProjectDetail.get(z)[1] %> 	<%if(z!=0){ %>(SUB)<%} %>	</b>
								</div>	
							<%} %>
					
					
				<table class="subtables" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;   border-collapse:collapse;" >
				
				
						<thead>
							<tr>
								<td colspan="9" style="border: 0">
									<p style="font-size: 10px;text-align: center"> 
									<span class="notassign">NA</span> : Not Assigned &nbsp;
									<span class="assigned">AA</span> : Activity Assigned &nbsp;
									<span class="ongoing">OG</span> : On Going &nbsp;
									<span class="delay">DO</span> : Delay - On Going &nbsp;
									<span class="ongoing">RC</span> : Review & Close &nbsp;
									<span class="delay">FD</span> : Forwarded With Delay &nbsp;
									<span class="completed">CO</span> : Completed &nbsp;
									<span class="completeddelay">CD</span> : Completed with Delay &nbsp;
									<span class="inactive">IA</span> : InActive &nbsp;
									<span class="delaydays">DD</span> : Delayed days &nbsp;&nbsp; 
									 </p>
								</td>									
							</tr>
							
							<tr>
									<th style="width: 15px !important;text-align: center;">SN</th>
									<th style="width: 20px; ">MS</th>
									<th style="width: 50px; ">L</th>
									<th style="width: 275px;">Action Plan </th>	
									<th style="width: 110px;" >PDC</th>	
									<th style="width: 210px;">Responsibility </th>
									<th style="width: 50px;">Progress </th>
					                <th style="width: 50px;padding-right: 5px !important; ">Status(DD)</th>
					             	<th style="width: 100px;" >FO ( &#x20B9; Cr)</th>
					                <th style="width: 220px;">Remarks</th>
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
											<td  style="text-align:center">
												
												<%if(! LocalDate.parse(obj[8].toString()).isEqual(LocalDate.parse(obj[29].toString())) ){ %> 
													<%=sdf.format(sdf1.parse(obj[8].toString())) %> 
												<%}%>
												<%=sdf.format(sdf1.parse(obj[29].toString())) %>
												
											
											</td>
											<td ><%=obj[24] %><%-- (<%=obj[25] %>) --%></td>
											<td style="text-align: center"><%=obj[16] %>%</td>											
											<td  style="text-align: center">
											<span class="<%if(obj[20].toString().equalsIgnoreCase("0")){%>assigned
												<%}else if(obj[20].toString().equalsIgnoreCase("1")) {%> assigned
												<%}else if(obj[20].toString().equalsIgnoreCase("2")) {%> ongoing
												<%}else if(obj[20].toString().equalsIgnoreCase("3")) {%> completed
												<%}else if(obj[20].toString().equalsIgnoreCase("4")) {%> delay 
												<%}else if(obj[20].toString().equalsIgnoreCase("5")) {%> completeddelay
												<%}else if(obj[20].toString().equalsIgnoreCase("6")) {%> inactive<%} %>	 status-column " >
												
												<%=obj[27] %>	
												
												<%if((obj[20].toString().equalsIgnoreCase("3") || obj[20].toString().equalsIgnoreCase("5") )&& obj[18]!=null){ %>
													(<%= ChronoUnit.DAYS.between(LocalDate.parse(obj[29].toString()), LocalDate.parse(obj[18].toString())) %>) 
												<%}else if(obj[20].toString().equalsIgnoreCase("4")){ %>
													(<%= ChronoUnit.DAYS.between(LocalDate.parse(obj[29].toString()), LocalDate.now()) %>)
												<%} %>
												
											</span>
											
											</td>
											<td align="center"><%if(obj[30]!=null){ %>
												<%= nfc.convert(Double.parseDouble(obj[30].toString())/10000000)%>
												<%}else{%>-<%}%></td>
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
		
		
						<%} %>
						</div>
					
					</details>
<!--  ---------------------------------------------------------------------------------------------------------------------------------------------  -->						
						
					<details>
   						<summary role="button" tabindex="0"><b>10. GANTT chart of overall project schedule <!-- [<span style="text-decoration: underline;">Original </span>(as per Project sanction / Latest PDC extension) and <span style="text-decoration: underline;">Current</span>] --></b>    </summary>
   						
						    <div class="content">
							    <%for(int z=0;z<projectidlist.size();z++){ %>
							    <div>
							    	<%if(ProjectDetail.size()>1){ %>
										<div>
											<b>Project : <%=ProjectDetail.get(z)[1] %> 	<%if(z!=0){ %>(SUB)<%} %>	</b>
										</div>	
									<%} %>	
								    <div class="row">
								    	<div class="col-md-9 ">
											<form method="post" style="float: right;margin-top:13px;" enctype="multipart/form-data" >
												<input type="file" name="FileAttach" id="FileAttach"  required="required"  accept="application/pdf,image/jpeg"/>
												<input type="hidden" name="ChartName"  value="grantt_<%=projectidlist.get(z)%>_<%=No2%>"> 
												<button type="submit" class="btn btn-sm back" formaction="GanttChartUpload.htm"  style="margin-right: 50px;margin" >Upload</button>
												<button type="submit" formtarget="_blank" class="btn btn-sm back" formaction="GanttChartSub.htm" formnovalidate="formnovalidate" style="float:right; background-color: #DE834D; font-weight: 600;border:0px;">Sub Level</button>
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
												<input type="hidden" name="ProjectId" id="ProjectId" value="<%=projectidlist.get(z)%>"> 
												<input type="hidden" name="committeeid" value="<%=committeeid%>">
											</form>
										</div>
										<div class="col-md-3" style="float:right;margin-top:10px;  ">
											<label>Interval : &nbsp;&nbsp;&nbsp; </label>
											<select class="form-control selectdee " name="interval_<%=projectidlist.get(z)%>" id="interval_<%=projectidlist.get(z)%>" required="required"  data-live-search="true"  style="width:150px !important" >
				                                <option value="quarter"> Quarterly </option>
				                                <option value="half" >Half-Yearly</option>
				                                <option value="year" >Yearly</option>
				                                <option value="month"> Monthly </option>
											</select>
										</div>
									</div>
	<!-- -----------------------------------------------gantt chart js ------------------------------------------------------------------------------------------------------------------------------- -->						    		
									
										
											<div class="row" style="margin-top: 10px;font-weight: bold;"   >
												<div class="col-md-4"></div>
												<div class="col-md-4"></div>
												<div class="col-md-4">
													<div style="font-weight: bold; " >
														<span style="margin:0px 0px 10px  10px;">Original :&ensp; <span style=" background-color: #046582;  padding: 0px 15px; border-radius: 3px;"></span></span>
														<span style="margin:0px 0px 10px  15px;">Ongoing :&ensp; <span style=" background-color: #81b214;  padding: 0px 15px;border-radius: 3px;"></span></span>
														<span style="margin:0px 0px 10px  15px;">Revised :&ensp; <span style=" background-color: #f25287; opacity: 0.5; padding: 0px 15px;border-radius: 3px;"></span></span>
													</div>
												</div>
											</div>
										
									<div class="row">
										<div class="col-md-12" style="float: right;" align="center">
										   	<div class="flex-container containers" id="containers_<%=projectidlist.get(z)%>"  ></div>
										</div>		
									</div>		
								</div>
							<%} %>							
						</div>
					
					</details>
<!--  ---------------------------------------------------------------------------------------------------------------------------------------------  -->						
					<details>
   						<summary role="button" tabindex="0"><b>11. Issues</b></summary>
   						
						   <div class="content">
						   			<%for(int z=0;z<projectidlist.size();z++){ %>		
						   			
						   			<%if(ProjectDetail.size()>1){ %>
										<div>
											<b>Project : <%=ProjectDetail.get(z)[1] %> 	<%if(z!=0){ %>(SUB)<%} %>	</b>
										</div>	
									<%} %>	
										   		 
									
			<table class="subtables" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;   border-collapse:collapse;" >
						<thead>
							<tr>
								<td colspan="7" style="border: 0">
									<p style="font-size: 10px;text-align: center"> 
										<span class="notassign">NA</span> : Not Assigned &nbsp;&nbsp;
										<span class="assigned">AA</span> : Activity Assigned &nbsp;&nbsp; 
										<span class="ongoing">OG</span> : On Going &nbsp;&nbsp; 
										<span class="delay">DO</span> : Delay - On Going &nbsp;&nbsp; 
										<span class="ongoing">RC</span> : Review & Close &nbsp;&nbsp;
										<span class="delay">FD</span> : Forwarded With Delay &nbsp;&nbsp;
										<span class="completed">CO</span> : Completed &nbsp;&nbsp; 
										<span class="completeddelay">CD</span> : Completed with Delay &nbsp;&nbsp; 
										<span class="inactive">IA</span> : InActive &nbsp;&nbsp;
										<span class="delaydays">DD</span> : Delayed days &nbsp;&nbsp; 
									</p>
								</td>									
							</tr>
							<tr>
								<th  style="width: 20px !important;text-align: center;">SN</th>
								<th  style="width: 270px;">Issue Point</th>
								<th  style="width: 100px; "> PDC</th>
								<th  style="width: 100px; "> ADC</th>
								<th  style="width: 210px; ">Responsibility</th>
								<th  style="width: 50px; " >Status(DD)</th>	
								<th  style="width: 230px; ">Remarks</th>		
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
												<td   style="text-align: center;" >
													<%if(obj[6] != null){ %> <%= sdf.format(sdf1.parse(obj[6].toString()))%> <%} %>
													<%if(obj[5] != null){ %> <%= sdf.format(sdf1.parse(obj[5].toString()))%> <%} %>
													<%= sdf.format(sdf1.parse(obj[3].toString()))%>
												</td>
												<td  style="text-align: center;"> 
													<%if(obj[13]!=null && obj[9].toString().equals("C")){ %> <%= sdf.format(sdf1.parse(obj[13].toString()))%> <%}else{ %>- <%} %>
												</td>
												<td > <%=obj[11] %><%-- <%=obj[12] %> --%></td>
												<td  style=";text-align: center;"> 
													<%if(obj[16]!=null && obj[13]!=null){ %>
														<%if(obj[9].toString().equals("I")&&obj[15].toString().equals("F")&&(LocalDate.parse(obj[3].toString()).isAfter(LocalDate.parse(obj[13].toString()))||  LocalDate.parse(obj[3].toString()).isEqual(LocalDate.parse(obj[13].toString()))  )){ %>
															<span class="ongoing">RC</span>
														<%}else if(obj[9].toString().equals("I")&&obj[15].toString().equals("F")&&LocalDate.parse(obj[3].toString()).isBefore(LocalDate.parse(obj[13].toString()))){  %>
															<span class="delay">FD</span>
														<%}else if(obj[9].toString().equals("C")&&( LocalDate.parse(obj[3].toString()).isAfter(LocalDate.parse(obj[13].toString())) || LocalDate.parse(obj[3].toString()).isEqual(LocalDate.parse(obj[13].toString())) )){  %>
															<span class="completed">CO</span>
														<%}else if(obj[9].toString().equals("C")&&LocalDate.parse(obj[3].toString()).isBefore(LocalDate.parse(obj[13].toString()))){  %>
														   <span class="completeddelay">CD (<%= ChronoUnit.DAYS.between(LocalDate.parse(obj[3].toString()), LocalDate.parse(obj[13].toString())) %>)</span>
														<%}else if(!obj[15].toString().equals("F")&& !obj[9].toString().equals("C")&&(LocalDate.parse(obj[3].toString()).isAfter(LocalDate.now()) || LocalDate.parse(obj[3].toString()).isEqual(LocalDate.now()))){  %> 
														<span class="ongoing">OG</span>
														<%}else if(!obj[15].toString().equals("F")&& !obj[9].toString().equals("C")&&LocalDate.parse(obj[3].toString()).isBefore(LocalDate.now())){  %> 
														<span class="delay">DO (<%= ChronoUnit.DAYS.between(LocalDate.parse(obj[3].toString()), LocalDate.now()) %>) </span>
														<%}else{ %>
														<span class="ongoing">OG</span>
												
													<%}}else if(obj[9].toString().equals("C")){%>
												        <span class="completed">CO</span>
												      <% }else{ %><span class="assigned">AA</span> 
													<%} %>
												</td>	
												<td > <%if(obj[17]!=null){ %> <%=obj[17] %> <%} %> </td>			
											</tr>			
										<%i++;
										}} %>
								</tbody>			
							</table>
	
								<%} %>
						   </div>	
						   
					</details>
<!--  ---------------------------------------------------------------------------------------------------------------------------------------------  -->

					<details>
   						<summary role="button" tabindex="0"><b>12. Decision/Recommendations sought from <%=committeeData.getCommitteeShortName().trim().toUpperCase() %></b>     </summary>
   						
						  <div class="content">
						  <%for(int z=0;z<projectidlist.size();z++){ %>
						  	<%if(ProjectDetail.size()>1){ %>
								<div>
									<b>Project : <%=ProjectDetail.get(z)[1] %> 	<%if(z!=0){ %>(SUB)<%} %>	</b>
								</div>	
							<%} %>	
							<%if(lastpmrcdecisions.get(z)!=null && lastpmrcdecisions.get(z)[0]!=null && !lastpmrcdecisions.get(z)[0].toString().trim().equals("")){ %>
							
								<%=lastpmrcdecisions.get(z)[0] %>
							<%}else{ %>
						  	Nil 
						  	
						  	<%} %>
						  
						  <%} %>
						  	<br><br><br><br><br>
						  </div>	
						   
					</details>						
					
<!--  ---------------------------------------------------------------------------------------------------------------------------------------------  -->						
					<details>
   						<summary role="button" tabindex="0"><b>13. Other Relevant Points (if any) 
   							<%if(committeeData.getCommitteeShortName().trim().equalsIgnoreCase("EB")){ %>
   								and Technical Work Carried Out For Last Six Months
							<%}else { %>
								and Technical Work Carried Out For Last Three Months
							<%} %>
   						
   						
   						</b></summary>
   						
						  <div class="content">
						  	<%for(int z=0;z<projectidlist.size();z++){ %>
								<div>
									<b>Project : <%=ProjectDetail.get(z)[1] %> 	<%if(z!=0){ %>(SUB)<%} %>	</b>
								</div>	
								
								<div class="card-body" style="width:100%"  >
								
									<form action="TechnicalWorkDataAdd.htm" method="post">
										<div class="row"align="center" >
											<div class="row" style="width:100%;margin-left: 0.5rem; margin-top: -0.5rem;">
												<div class="col-12">
													<textarea class="form-control" name="RelevantPoints" id="ckeditor" rows="5" cols="50" maxlength="5"><%if(TechWorkDataList.get(z)!=null){ %> <%=TechWorkDataList.get(z)[2] %> <%}%></textarea>
												</div>	
												
											</div>
										</div>
										<div class="row" align="center" style="margin-top:15px;" >
										<div class="col-2"></div>
										<div class="col-3" style="text-align: right;margin-top: 5px;">	<label><b>Technical Work Carried (Attachment)</b></label></div>
											

												<div class="col-2" style="text-align: left;">
													<span id="attachname_<%=projectidlist.get(z)%>" ></span>
													<%if(TechWorkDataList.get(z)==null){ %>
														<input type="hidden" name="TechDataId" value="0">
														<input type="hidden" class="hidden" name="attachid" id="attachid_<%=projectidlist.get(z)%>" value="0">
													<%}else{ %>
														<input type="hidden" name="TechDataId" value="<%=TechWorkDataList.get(z)[0]%>">
														<%if(TechWorkDataList.get(z)[3]!=null && Long.parseLong(TechWorkDataList.get(z)[3].toString())>0){ %>
														<button type="button" class="btn" title="Download Document"  onclick="FileDownload1('<%=TechWorkDataList.get(z)[3]%>');"  ><i class="fa fa-download" aria-hidden="true"> </i></button>
														<input type="hidden" class="hidden" name="attachid" id="attachid_<%=projectidlist.get(z)%>" value="<%=TechWorkDataList.get(z)[3]%>">
														<%} else{%>
														<input type="hidden" class="hidden" name="attachid" id="attachid_<%=projectidlist.get(z)%>" value="0">
														<%} %>
													<%} %>
													
													
													
													<button type="button" class="btn btn-primary btnfileattachment"  title="Link Document" id="" onclick="openMainModal('0','a',<%=projectidlist.get(z)%>) ;" ><i class="fa fa-link" aria-hidden="true"></i></button>
												
													<input type="hidden" name="projectid" value="<%=projectidlist.get(z)%>">
													<input type="hidden" name="committeeid" value="<%=committeeid%>">
													<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

											<%if(TechWorkDataList.get(z)==null){ %>
												<button type="submit" class="btn btn-sm submit" name="submit" value="submit" onclick="return confirm('Are You Sure To Submit ?');">SUBMIT</button>
											<%}else{ %>
												<button type="submit" class="btn btn-sm edit" name="submit" value="submit" onclick="return confirm('Are You Sure To Edit ?');">EDIT</button>
											<%} %>
											</div>
										</div>
									</form>								
								
								<b>Technical Images</b> 
								<div class="row">
									<form action="ProjectTechImages.htm" method="post" style="float: left;margin-top:5px;" enctype="multipart/form-data" >
										<input type="file" name="FileAttach" id="FileAttach" required="required"  accept="image/jpeg"/> 
										<button type="submit" class="btn btn-sm back">Upload</button>
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
										<input type="hidden" name="committeeid" value="<%=committeeid%>">
										<input type="hidden" name="ProjectId"  value="<%=projectidlist.get(z)%>"> 
									</form>
											
								</div>
							<% if(TechImages.size()>0){
							List<TechImages>  TechImagesList= TechImages.get(z); 
							if(TechImagesList.size()>0){
							for(TechImages imges:TechImagesList){ %>
							<div class="row">
	
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
						
								
								</div>
								
								
								
							
								
						  <%} %>
						  </div>
					
					
					</details>
<!--   --------------------------------------------------------------------------------------------------------------------------------------------- --> 
					<details>
   						<summary role="button" tabindex="0"><b>Note</b></summary>
						  <div class="content">
							
								1) Agenda mentioned in Chapter 5 on Project Monitoring and Review be
									referred while making briefing papers.
								<br>	
								2) Action plan as mentioned at SN. 9 should mandatorily form part of EB
									minutes which should be released within two weeks of meeting. If the minutes
									of meeting to be vetted by outside offices cut off dates should be given beyond
									which minutes would be assumed to be approved.
								<br>
								3) Apex Board format may be similar to EB format modified to cover Agenda of
									Apex Board (refer Chapter 5 on Project Monitoring and Review).
								<br>
								4) Detailed technical discussions on each sub systems to be deliberated and
									recorded during PMRC. Ratification points from the higher monitoring body to
									be clearly mentioned in the minutes.
								<br>
								5) For PDC extension cases, the defendable reason why PDC could not be
									adhered & remedial steps to be taken to avoid further PDC extension may also
									be presented as per the table given below & recorded in minutes.
						  </div>	
					</details>
				
		</div>
	</div>
			</div>
		</div>
	</div>
		
		

<!--  -----------------------------------------------agenda attachment ---------------------------------------------- -->

			<div class="modal" tabindex="-1" role="dialog" id="attachmentmodal" aria-labelledby="myLargeModalLabel" aria-hidden="true">
 				 <div class="modal-dialog modal-dialog-centered " style="max-width: 75% !important; ">
   					 <div class="modal-content">
   						 <div class="modal-header">
					        <h4 class="modal-title" style="color: #145374">Select Document for linking</h4>
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					          <span aria-hidden="true">&times;</span>
					        </button>
						 </div>
						<div class="modal-body">   
		<!-- --------------------------------------------left page ----------------------------------------------------->
							<div class="col-md-12" >		
		<!-- -------------------------------- tree ----------------------------- -->
								<div class="row" style="height: 28rem; overflow-y:auto;verflow-x:auto; " id="submodules">		
											
								</div>
		<!-- -------------------------------- tree end ----------------------------- -->				
							</div>
		<!-- ------------------------------------------left page end --------------------------------------------- -->
						</div>	
					</div> 
				</div> 
			</div>
<!--  -----------------------------------------------agenda attachment ---------------------------------------------- -->


<!-- --------------------------------------------  model start  -------------------------------------------------------- -->

		<div class="modal fade" id="exampleModalCenter1" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered "  style="max-width: 60% !important;">
		
				<div class="modal-content" >
					   
				    <div class="modal-header" style="background-color: rgba(0,0,0,.03);">
				      
				    	<h4 class="modal-title" id="model-card-header" style="color: #145374"></h4>
	
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close" >
				          <span aria-hidden="true">&times;</span>
				        </button>
				        				        
				    </div>
					<div class="modal-body"  style="padding: 0.5rem !important;">
							
							<div class="card-body" style="min-height:30% ;max-height: 93% !important;overflow-y: auto;">
			
								<div class="row">
										<div class="col-md-8">
											<div style="margin-top: 5px;" id="fileuploadlist">
							
											</div>
										</div>
										
				             		</div>					
							</div>
						
					</div>
				</div>
			</div> 
		</div>
		
		<input type="hidden" name="projectid" id="AttachProjectId" value="" />
<!-- --------------------------------------------  model end  -------------------------------------------------------- -->


<!--------------------------------------------------- Milestone Model -----------------------------------------------  -->

<div class="modal fade " id="exampleModal1" tabindex="-1" aria-labelledby="exampleModalLabel1" aria-hidden="true">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
					      
				<div class="modal-body">
					
					
					
   <div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover" style="margin-top: -0px;">
				<div class="row card-header">
			     <div class="col-md-10">
					<h5 ><%if(ProjectId!=null){
						Object[] ProjectDetail123=(Object[])request.getAttribute("ProjectDetailsMil");
						%>
						<%=ProjectDetail123[2] %> ( <%=ProjectDetail123[1] %> ) 
					<%} %>
					</h5>
					</div>
					
					 </div>
					<div class="card-body">
					
                                              <div class="table-responsive"> 
												<table class="table  table-hover table-bordered">
													<thead>

														<tr>
															<th>Expand</th>
															<th style="text-align: left;max-width: 15px;">Mil-No</th>
														<!-- 	<th style="text-align: left;">Project Name</th> -->
															<th style="text-align: left;max-width: 200px;">Milestone Activity</th>
															<th >Start Date</th>
															<th >End Date</th>	
															<th  style="text-align: left;max-width: 200px;">First OIC </th>
															<th  style="text-align: center;max-width: 50px;">Weightage</th>	
															<th  style="text-align: center;max-width: 80px;">Progress</th>												

														</tr>
													</thead>
													<tbody>
													
														<%int  count=1;
														
														 	if(MilestoneList!=null&&MilestoneList.size()>0){
											
															for(Object[] obj: MilestoneList){ %>
														<tr class="milestonemodalwhole" id="milestonemodal<%=obj[5] %>"  >
															<td style="width:2% !important; " class="center">
																<span class="clickable" data-toggle="collapse" id="row<%=count %>" data-target=".row<%=count %>">
																	<button class="btn btn-sm btn-success" id="btn<%=count %>"  onclick="ChangeButton('<%=count %>')">
																		<i class="fa fa-plus"  id="fa<%=count%>"></i>
																	 </button>
																</span>
															</td>
															<td style="text-align: left;width: 7%;"> Mil-<%=obj[5]%></td>
															<%-- <td class="width-30px"><%=obj[1]%></td> --%>
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=obj[4] %></td>
															
															<td  style="width:8% !important; "><%=sdf.format(obj[2])%></td>
															<td style="width:8% !important; "><%=sdf.format(obj[3])%></td>
															<td  style="width:15% !important; "><%=obj[6]%></td>
															<td  style="width:9% !important; " align="center"><%=obj[13]%></td>	
															<td>
															<%if(!obj[12].toString().equalsIgnoreCase("0")){ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar progress-bar-striped
															<%if(obj[14].toString().equalsIgnoreCase("2")){ %>
															 bg-success
															<%} else if(obj[14].toString().equalsIgnoreCase("3")){ %>
															  bg-info
															<%} else if(obj[14].toString().equalsIgnoreCase("4")){ %>
															  bg-danger
															<%} else if(obj[14].toString().equalsIgnoreCase("5")){ %>
															  bg-warning
															<%}  %>
															" role="progressbar" style=" width: <%=obj[12] %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
															<%=obj[12] %>
															</div> 
															</div> <%}else{ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Not Started
															</div>
															</div> <%} %>
															</td>
																
		
														</tr>
														 <tr class="collapse row<%=count %>" style="font-weight: bold;">
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
                                                         <% int countA=1;
                                                            List<Object[]> MilestoneA=(List<Object[]>)request.getAttribute(count+"MilestoneActivityA");
														 	if(MilestoneA!=null&&MilestoneA.size()>0){
															for(Object[] objA: MilestoneA){
	                                                            List<Object[]> MilestoneB=(List<Object[]>)request.getAttribute(count+"MilestoneActivityB"+countA);
	
																%>
														<tr class="collapse row<%=count %>">
															<td style="width:2% !important; " class="center"> </td>
															<td style="text-align: left;width: 5%;"> A-<%=countA%></td>
															<%-- <td class="width-30px"><%=obj[1]%></td> --%>
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=objA[4] %></td>
															
															<td class="width-30px"><%=sdf.format(objA[2])%></td>
															<td style="width:8% !important; "><%=sdf.format(objA[3])%></td>
															
															
															<td class="width-30px"><%if(objA[9].toString().equalsIgnoreCase("3")||objA[9].toString().equalsIgnoreCase("5")){ %>
														     <%if(objA[7]!=null){ %>   <%=sdf.format(objA[7]) %> <%}else{ %><%=objA[8] %> <%} %>
														         <%}else{ %>
														         <%=objA[8] %>
															 <%} %></td>
															 <td align="center"><%=objA[6] %></td>
															<td>
															<%if(!objA[5].toString().equalsIgnoreCase("0")){ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar progress-bar-striped
															<%if(objA[9].toString().equalsIgnoreCase("2")){ %>
															 bg-success
															<%} else if(objA[9].toString().equalsIgnoreCase("3")){ %>
															  bg-info
															<%} else if(objA[9].toString().equalsIgnoreCase("4")){ %>
															  bg-danger
															<%} else if(objA[9].toString().equalsIgnoreCase("5")){ %>
															  bg-warning
															<%}  %>
															" role="progressbar" style=" width: <%=objA[5] %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
															<%=objA[5] %>
															</div> 
															</div> <%}else{ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Not Started
															</div>
															</div> <%} %>
															</td>						
													
                                                         <td></td>
                                                         </tr>
                                                         <% int countB=1;
														 	if(MilestoneB!=null&&MilestoneB.size()>0){
															for(Object[] objB: MilestoneB){
	                                                            List<Object[]> MilestoneC=(List<Object[]>)request.getAttribute(count+"MilestoneActivityC"+countA+countB);
	
																%>
														<tr class="collapse row<%=count %>">
															<td style="width:2% !important; " class="center"> </td>
															<td style="text-align: left;width: 5%;"> &nbsp;&nbsp;&nbsp;B-<%=countB%></td>
															<%-- <td class="width-30px"><%=obj[1]%></td> --%>
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=objB[4] %></td>
															
															<td class="width-30px"><%=sdf.format(objB[2])%></td>
															<td style="width:8% !important; "><%=sdf.format(objB[3])%></td>
															
															<td class="width-30px"><%if(objB[9].toString().equalsIgnoreCase("3")||objB[9].toString().equalsIgnoreCase("5")){ %>
														      <%if(objB[7]!=null){ %>   <%=sdf.format(objB[7]) %> <%}else{ %><%=objB[8] %> <%} %>
														         <%}else{ %>
														         <%=objB[8] %>
															 <%} %></td>
															  <td align="center"><%=objB[6] %></td>
															<td>
															<%if(!objB[5].toString().equalsIgnoreCase("0")){ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar progress-bar-striped
															<%if(objB[9].toString().equalsIgnoreCase("2")){ %>
															 bg-success
															<%} else if(objB[9].toString().equalsIgnoreCase("3")){ %>
															  bg-info
															<%} else if(objB[9].toString().equalsIgnoreCase("4")){ %>
															  bg-danger
															<%} else if(objB[9].toString().equalsIgnoreCase("5")){ %>
															  bg-warning
															<%}  %>
															" role="progressbar" style=" width: <%=objB[5] %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
															<%=objB[5] %>
															</div> 
															</div> <%}else{ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Not Started
															</div>
															</div> <%} %>
															</td>
															
														 													
                                                         <td></td>
                                                         </tr>
                                                         <% int countC=1;
														 	if(MilestoneC!=null&&MilestoneC.size()>0){
															for(Object[] objC: MilestoneC){
													         List<Object[]> MilestoneD=(List<Object[]>)request.getAttribute(count+"MilestoneActivityD"+countA+countB+countC);
																%>
														<tr class="collapse row<%=count %>">
															<td style="width:2% !important; " class="center"> </td>
															<td style="text-align: left;width: 5%;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C-<%=countC%></td>
															<%-- <td class="width-30px"><%=obj[1]%></td> --%>
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=objC[4] %></td>
															
															<td class="width-30px"><%=sdf.format(objC[2])%></td>
															<td style="width:8% !important; "><%=sdf.format(objC[3])%></td>
															
															<td class="width-30px"><%if(objC[9].toString().equalsIgnoreCase("3")||objC[9].toString().equalsIgnoreCase("5")){ %>
														     <%if(objC[7]!=null){ %>   <%=sdf.format(objC[7]) %> <%}else{ %><%=objC[8] %> <%} %>
														         <%}else{ %>
														         <%=objC[8] %>
															 <%} %></td>	
															  <td align="center"><%=objC[6] %></td>
															<td>
															<%if(!objC[5].toString().equalsIgnoreCase("0")){ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar progress-bar-striped
															<%if(objC[9].toString().equalsIgnoreCase("2")){ %>
															 bg-success
															<%} else if(objC[9].toString().equalsIgnoreCase("3")){ %>
															  bg-info
															<%} else if(objC[9].toString().equalsIgnoreCase("4")){ %>
															  bg-danger
															<%} else if(objC[9].toString().equalsIgnoreCase("5")){ %>
															  bg-warning
															<%}  %>
															" role="progressbar" style=" width: <%=objC[5] %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
															<%=objC[5] %>
															</div> 
															</div> <%}else{ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Not Started
															</div>
															</div> <%} %>
															</td>
															
														
                                                         <td></td>
                                                         </tr>
                                                         <% int countD=1;
														 	if(MilestoneD!=null&&MilestoneD.size()>0){
															for(Object[] objD: MilestoneD){
	                                                            List<Object[]> MilestoneE=(List<Object[]>)request.getAttribute(count+"MilestoneActivityE"+countA+countB+countC+countD);
	
																%>
														<tr class="collapse row<%=count %>">
															<td style="width:2% !important; " class="center"> </td>
															<td style="text-align: left;width: 5%;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D-<%=countD%></td>
															<%-- <td class="width-30px"><%=obj[1]%></td> --%>
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=objD[4] %></td>
															
															<td class="width-30px"><%=sdf.format(objB[2])%></td>
															<td style="width:8% !important; "><%=sdf.format(objB[3])%></td>
															
															<td class="width-30px"><%if(objD[9].toString().equalsIgnoreCase("3")||objD[9].toString().equalsIgnoreCase("5")){ %>
														      <%if(objD[7]!=null){ %>   <%=sdf.format(objD[7]) %> <%}else{ %><%=objD[8] %> <%} %>
														         <%}else{ %>
														         <%=objD[8] %>
															 <%} %></td>
															  <td align="center"><%=objD[6] %></td>
															<td>
															<%if(!objD[5].toString().equalsIgnoreCase("0")){ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar progress-bar-striped
															<%if(objD[9].toString().equalsIgnoreCase("2")){ %>
															 bg-success
															<%} else if(objD[9].toString().equalsIgnoreCase("3")){ %>
															  bg-info
															<%} else if(objD[9].toString().equalsIgnoreCase("4")){ %>
															  bg-danger
															<%} else if(objD[9].toString().equalsIgnoreCase("5")){ %>
															  bg-warning
															<%}  %>
															" role="progressbar" style=" width: <%=objD[5] %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
															<%=objD[5] %>
															</div> 
															</div> <%}else{ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Not Started
															</div>
															</div> <%} %>
															</td>
															
														 													
                                                         <td></td>
                                                         </tr>
                                                         <% int countE=1;
														 	if(MilestoneE!=null&&MilestoneE.size()>0){
															for(Object[] objE: MilestoneE){ %>
														<tr class="collapse row<%=count %>">
															<td style="width:2% !important; " class="center"> </td>
															<td style="text-align: left;width: 5%;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;E-<%=countE%></td>
															<%-- <td class="width-30px"><%=obj[1]%></td> --%>
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=objE[4] %></td>
															
															<td class="width-30px"><%=sdf.format(objE[2])%></td>
															<td style="width:8% !important; "><%=sdf.format(objE[3])%></td>
															
															<td class="width-30px"><%if(objE[9].toString().equalsIgnoreCase("3")||objE[9].toString().equalsIgnoreCase("5")){ %>
														     <%if(objE[7]!=null){ %>   <%=sdf.format(objE[7]) %> <%}else{ %><%=objE[8] %> <%} %>
														         <%}else{ %>
														         <%=objE[8] %>
															 <%} %></td>	
															  <td align="center"><%=objE[6] %></td>
															<td>
															<%if(!objE[5].toString().equalsIgnoreCase("0")){ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar progress-bar-striped
															<%if(objC[9].toString().equalsIgnoreCase("2")){ %>
															 bg-success
															<%} else if(objE[9].toString().equalsIgnoreCase("3")){ %>
															  bg-info
															<%} else if(objE[9].toString().equalsIgnoreCase("4")){ %>
															  bg-danger
															<%} else if(objE[9].toString().equalsIgnoreCase("5")){ %>
															  bg-warning
															<%}  %>
															" role="progressbar" style=" width: <%=objE[5] %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
															<%=objE[5] %>
															</div> 
															</div> <%}else{ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Not Started
															</div>
															</div> <%} %>
															</td>
															
														
                                                         <td></td>
                                                         </tr>
												<% countE++;} }%>
												<% countD++;} }%>
												<% countC++;} }%>
												<% countB++;} }%>
												<% countA++;} }else{%>
												<tr class="collapse row<%=count %>">
													<td colspan="9" style="text-align: center" class="center">No Sub List Found</td>
												</tr>
												<%} %>
												<% count++; } }else{%>
												<tr >
													<td colspan="9" style="text-align: center" class="center">No List Found</td>
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
				
					      
			</div>
		</div>
	</div>

	<div class="modal fade" id="LevelModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg" role="document">
	    <div class="modal-content">
	      <div class="modal-header" style="background-color: #C4DDFF">
	        <h5 class="modal-title" id="exampleModalLabel" style="color:#145374;font-weight: bold;">Set Milestone Level</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	      	<div class="row">
	      		<div class="col-md-4">
	      			<h6><b>Project : </b>
	      			<%for(int z=0;z<projectidlist.size();z++){ %>
	      				<%if(z==0){ %><%=ProjectDetail.get(z)[1] %> <%} %> 
	      			<%} %>
	      			</h6>
	      		</div>
	      		<div class="col-md-3">
	      			<h6>
	      				<b>Committee :</b> 
	      				<%=committeeData.getCommitteeShortName().trim().toUpperCase() %>
	      			</h6>
	      		</div>
	      		<div class="col-md-1"><b>Level</b></div>
	      		<div class="col-md-4">
	      			<select class="form-control" name="LevelValue"  required="required" data-live-search="true" data-container="body" id="levelvalue">
						<option <%if(levelid.equalsIgnoreCase("1")) {%> selected <%} %>   value="1">Level A</option>
						<option <%if(levelid.equalsIgnoreCase("2")) {%> selected <%} %> value="2">Level B</option>
						<option <%if(levelid.equalsIgnoreCase("3")) {%> selected <%} %> value="3">Level C</option>
						<option <%if(levelid.equalsIgnoreCase("4")) {%> selected <%} %> value="4">Level D</option>
						<option <%if(levelid.equalsIgnoreCase("5")) {%> selected <%} %> value="5">Level E</option>
					</select>	
	      		</div>
	      		
	      	</div>
	      </div>
	      <div class="modal-footer">
	        
	      </div>
	    </div>
	  </div>
	</div>
	





<form method="POST" action="FileUnpack.htm"  id="downloadform" target="_blank"> 
	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
	<input type="hidden" name="FileUploadId" id="FileUploadId" value="" />
</form>
	
		
<form method="get" action="AgendaDocLinkDownload.htm"  id="downloadform1" target="_blank"> 
	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
	<input type="hidden" name="filerepid" id="filerepid" value="" />
</form>
	
<form method="POST" action="MilestoneLevelUpdate.htm"  id="milestonelevelform" > 
	
	<input type="hidden" name="projectid" id="projectid">
	<input type="hidden" name="committeeid" id="committeeid" >
	<input type="hidden" name="milestonelevelid" id="milestonelevelid" />
	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
</form>	


<!--  -----------------------------------------------Tech data attachment js ---------------------------------------------- -->

	

<script>


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
    $('#row'+milId.charAt(milId.length-1)).click();
 	$('#'+milId).show();

});





function milactivitychange(val){
	
	if(val.value=='A'){
		
		$('#milestonechangetableajax').hide();
		$('#milestoneactivitychangetable').show();
		
		
	}else{
	
	var Proid = <%=projectid%>;	
	$('#milestoneactivitychangetable').hide();
	
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
							
				var s = "<table id='milestonechangetableajax' style='align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px; width: 980px;  border-collapse:collapse;'><tr><th  style='width: 30px !important;'>SN</th><th  style='max-width: 40px; '>MS No.</th><th  style='max-width: 230px; '>Milestones </th><th  style='max-width: 80px;'> Original PDC </th><th  style='max-width: 80px;'> Revised PDC</th>"
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

function openMainModal(agendatempid,addedit,Proid)
{
	
	$('#AttachProjectId').val(Proid); 
	
	
	$.ajax({
			type : "GET",
			url : "FileRepMasterListAllAjax.htm",
			data : {
				projectid : Proid,
							
			},
			datatype: 'json',
			success : function(result)
				{
					var result= JSON.parse(result);
					var values= Object.keys(result).map(function(e){
						return result[e];
					})	
	
					var values1=values;
					var values2=values;
					var values3=values;
					var values4=values;
					var values5=values;

			
				/* --------------------------------------------------tree making--------------------------------------------------------- */			
					var str='<ul>';
					for(var v1=0;v1<values1.length;v1++)
					{ 
						if(values1[v1][1]===0)
						{  
							str +='<li> <span class="caret" id="system'+values1[v1][0]+'" onclick="onclickchangeMain(this);"  >'+values1[v1][3] +'</span> <ul  class="nested"> <li>'; 
					 /* ----------------------------------------level 1------------------------------------- */	
								for(var v2=0;v2<values2.length;v2++)
								{ 
									if( values2[v2][1]==values1[v1][0] )
									{  
										str += '<li> <span class="caret" id="system'+values2[v2][0]+'" onclick="onclickchangeMain(this);"  >' +values2[v2][3]+'</span>';
										str +=  '<span> <button type="button" id="upbutton'+values2[v2][0]+'" class="btn" data-target="#exampleModalCenter" style="background-color: transparent;margin: -5px 0px;" onclick="modalbox(\''+ values1[v1][0] +'\',\''+values1[v1][3]+'\' ,\''+values2[v2][0]+'\',\''+values2[v2][3]+'\', \'-\',\'\',\'-\',\'\',\'-\',\'\',1)"> ';
										str +=  '<i class="fa fa-arrow-right" style="color: #007bff" aria-hidden="true"></i> </button>';
										str +='<ul  class="nested"> <li>'; 
								/* ----------------------------------------level 2------------------------------------- */
											for(var v3=0;v3<values3.length;v3++)
											{ 
												if( values3[v3][1]==values2[v2][0] )
												{  
													str += '<li> <span class="caret" id="system'+values3[v3][0]+'"  onclick="onclickchangeMain(this);"  >' +values3[v3][3]+'</span>';
													str +=  '<span> <button type="button" id="upbutton'+values3[v3][0]+'" class="btn" data-target="#exampleModalCenter" style="background-color: transparent;margin: -5px 0px;" onclick="modalbox(\''+ values1[v1][0] +'\',\''+values1[v1][3]+'\' ,\''+values2[v2][0]+'\',\''+values2[v2][3]+'\',\''+values3[v3][0]+'\',\''+values3[v3][3]+'\',\'-\',\'\',\'-\',\'\',2)"> ';
													str +=  '<i class="fa fa-arrow-right" style="color: #007bff" aria-hidden="true"></i> </button>';
													str +='<ul  class="nested"> <li>'; 
											/* ----------------------------------------level 3------------------------------------- */
														for(var v4=0;v4<values4.length;v4++)
														{ 
															if( values4[v4][1]==values3[v3][0] )
															{  
																str += '<li> <span class="caret" id="system'+values4[v4][0]+'" onclick="onclickchangeMain(this);"  >' +values4[v4][3]+'</span>';
																str +=  '<span> <button type="button" id="upbutton'+values4[v4][0]+'" class="btn" data-target="#exampleModalCenter" style="background-color: transparent;margin: -5px 0px;" onclick="modalbox(\''+ values1[v1][0] +'\',\''+values1[v1][3]+'\' ,\''+values2[v2][0]+'\',\''+values2[v2][3]+'\',\''+values3[v3][0]+'\',\''+values3[v3][3]+'\',\''+values4[v4][0]+'\',\''+values4[v4][3]+'\',\'-\',\'\',3)"> ';
																str +=  '<i class="fa fa-arrow-right" style="color: #007bff" aria-hidden="true"></i> </button>';
																str +='<ul  class="nested"> <li>'; 
														/* ----------------------------------------level 4------------------------------------- */
																	for(var v5=0;v5<values5.length;v5++)
																	{ 
																		if( values5[v5][1]==values4[v4][0] )
																		{  
																			str += '<li> <span class="caret-last" id="system'+values5[v5][0]+'" onclick="onclickchangeMain(this);"  >' +values5[v5][3]+'</span>';
																			str +=  '<span> <button type="button" id="upbutton'+values5[v5][0]+'" class="btn" data-target="#exampleModalCenter" style="background-color: transparent;margin: -5px 0px;" onclick="modalbox(\''+ values1[v1][0] +'\',\''+values1[v1][3]+'\' ,\''+values2[v2][0]+'\',\''+values2[v2][3]+'\',\''+values3[v3][0]+'\',\''+values3[v3][3]+'\',\''+values4[v4][0]+'\',\''+values4[v4][3]+'\',\''+values4[v5][0]+'\',\''+values4[v5][3]+'\',4)"> ';
																			str +=  '<i class="fa fa-arrow-right" style="color: #007bff" aria-hidden="true"></i> </button>';
																			
																		}
																	} 
																	
														/* ----------------------------------------level 4------------------------------------- */			
																str +=	'</li> </ul> </li>';
															}
														} 
														
											/* ----------------------------------------level 3------------------------------------- */			
													str +=	'</li> </ul> </li>';
												}
											} 
											
								/* ----------------------------------------level 2------------------------------------- */			
										str +=	'</li> </ul> </li>';
									}
								} 
							
				 	/* ----------------------------------------level 1------------------------------------- */
											
							str +='</li> 	</ul> 	</li>';	
						} 
					} 
			/* --------------------------------------------------tree making--------------------------------------------------------- */
					str += '</ul>';
				
							
				$('#submodules').html(str);
				$('#attachmentmodal').modal('show');
				var toggler = document.getElementsByClassName("caret");
				var i;
				for (i = 0; i <toggler.length; i++) {
				  toggler[i].addEventListener("click", function() {	
					this.parentElement.querySelector(".nested").classList.toggle("active");   
				    this.classList.toggle("caret-down");
				  });
				}
			}
	
	});
	
}



function setattchidvalue(attachid, attchName)
{
	var $projectid=$('#AttachProjectId').val();
	$('#attachid_'+$projectid).val(attachid);
	$('#attachname_'+$projectid).html(attchName);
	$('#exampleModalCenter1').modal('hide');
	$('#attachmentmodal').modal('hide');
}


</script>


<script type="text/javascript">

function onclickchangeMain(ele)
{
	elements = document.getElementsByClassName('caret');
	for (var i1 = 0; i1 < elements.length; i1++) {
		$(elements[i1]).css("color", "black");
		$(elements[i1]).css("font-weight", "");
	}
	elements = document.getElementsByClassName('caret-last');
	for (var i1 = 0; i1 < elements.length; i1++) {
		$(elements[i1]).css("color", "black");
		$(elements[i1]).css("font-weight", "");
	}
	$(ele).css("color", "green");
	$(ele).css("font-weight", "700");
}


function onclickchange(ele)
{
	elements = document.getElementsByClassName('caret-1');
    for (var i1 = 0; i1 < elements.length; i1++) {
    	$(elements[i1]).css("color", "black");
    	$(elements[i1]).css("font-weight", "");
    }
    elements = document.getElementsByClassName('caret-last-1');
    for (var i1 = 0; i1 < elements.length; i1++) {
    	$(elements[i1]).css("color", "black");
    	$(elements[i1]).css("font-weight", "");
    }
$(ele).css("color", "green");
$(ele).css("font-weight", "700");

}


$(document).ready(function(){

	
	
	var toggler = document.getElementsByClassName("caret");
	var i;
	for (i = 0; i <toggler.length; i++) {
	  toggler[i].addEventListener("click", function() {	
		this.parentElement.querySelector(".nested").classList.toggle("active");   
	    this.classList.toggle("caret-down");
	  });
	}
});

function setmodelheader(m,l1,l2,l3,l4,lev,project,divid){
	
	/* var modelhead=project+'  <i class="fa fa-long-arrow-right" aria-hidden="true"></i>  '+m; */
	
	var modelhead=m;
	
	if(lev>=1)
	{
		 modelhead +='  <i class="fa fa-long-arrow-right" aria-hidden="true"></i>  '+l1; 
	}
	if(lev>=2)
	{
		modelhead +='  <i class="fa fa-long-arrow-right" aria-hidden="true"></i>  '+l2;
	}
	if(lev>=3)
	{
		modelhead +='  <i class="fa fa-long-arrow-right" aria-hidden="true"></i>  '+l3;
	}
	if(lev>=4)
	{
		modelhead +='  <i class="fa fa-long-arrow-right" aria-hidden="true"></i>  '+l4;
	}
	$('#'+divid).html(modelhead);
}


function modalbox(mid,mname,l1,lname1,l2,lname2,l3,lname3,l4,lname4,lev)
{
		
		var $projectid=$('#AttachProjectId').val();		
		setmodelheader(mname,lname1,lname2,lname3,lname4,lev,$('#projectname').val(),'model-card-header');		
		$('#amendmentbox').css('display','none');
		$('#submitversion').val('');
		$('#prevversion').text('');
		$('#downloadbtn').remove();
		$('#FileName').prop('readonly',false);
		$('#FileName').val('');
		$('#modeldescshow').text('');
		$('#uploadbox').css('display','none');
		$('#ammendmentbox').css('display','none');
		
		$.ajax({
				type : "GET",
				url : "FileHistoryListAjax.htm",
				data : {
					projectid : $projectid,
					mainsystemval : mid,
					sublevel : lev ,
					s1:l1,
					s2:l2,
					s3:l3,
					s4:l4,				
				},
				datatype: 'json',
				success : function(result)
					{
						var result= JSON.parse(result);
						var values= Object.keys(result).map(function(e){
						return result[e];
					})			
					
						/* --------------------------------------------ajax nested--------------------------------------- */		
							
							 $.ajax({
									type : "GET",
									url : "FileDocMasterListAll.htm",
									data : {
										projectid : $projectid,		
									},
									datatype: 'json',
									success : function(result1)
											{
												var result1= JSON.parse(result1);
												var values1= Object.keys(result1).map(function(e){
													return result1[e];
												})
														
												var values2=values1;
												/* --------------------------------------------------tree making--------------------------------------------------------- */			
													var str='<ul>';
													for(var v1=0;v1<values1.length;v1++)
													{ 
														if(values1[v1][2]===1)
														{  
															str +='<li> <span class="caret-1" id="docsysl1'+values1[v1][0]+'" onclick="onclickchange(this);" >'+values1[v1][3] +'</span> <ul  class="nested-1"> <li>'; 
													 /* ----------------------------------------level 1------------------------------------- */	
																for(var v2=0;v2<values2.length;v2++)
																{ 
																	if(values1[v2][2]===2 && values2[v2][1]==values1[v1][0] )
																	{  
																		str += '<li> <span class="caret-1" id="docsysl2'+values2[v2][0]+'" onclick="onclickchange(this);" >' +values2[v2][3]+'</span> <ul  class="nested-1"> <li>'; 
																/* ----------------------------------------level 2------------------------------------- */
																			
																			for(var v3=0;v3<values.length;v3++)
																			{ 
																				if(  values[v3][1]==values2[v2][0])
																				{
																					str += '<li>';
																					
																					if(values[v3][4]!=0)
																					{
																						str += '<input type="radio" class="selectradio" onchange="setattchidvalue(\''+ values[v3][4] +'\', \''+values[v3][3] +'\');" ></button>' ;
																					}else
																					{
																						str += '<input type="radio" class="selectradio" disabled ></button>' ;
																					}
																					
																					str +=' <span class="caret-last-1" id="docsysl3'+values[v3][0]+'" onclick="onclickchange(this);">'+values[v3][3]+'('+values[v3][9]+')</span>';
																						
																					/*  str +='<span><button type="button" class="btn"  style="background-color: transparent;margin: -3px 0px;" onclick="showuploadbox(\''+values1[v1][3]+'\',\''+values2[v2][3]+'\',\''+values[v3][3]+'\',\''+values[v3][8]+'\',\''+values[v3][6]+'\',\''+values[v3][0]+'\',\''+values[v3][9]+'\',\''+values[v3][10]+'\',\''+values1[v1][0]+'\',\''+values2[v2][0] +'\')" >'; 																					
																					str +=		'<i class="fa fa-upload" style="color: #007bff" aria-hidden="true"></i>';
																					str +=		'</button>';  */
																					if(values[v3][4]!=0)
																					{ 
																						str +=' <span class="version">Ver '+values[v3][8]+'.'+values[v3][6];
																						str +=		' <button type="radio" name="selectattach" class="btn"  style="background-color: transparent;margin: -5px 0px;" onclick="FileDownload(\''+values[v3][4]+'\')">';                                     
																						str += 			'<i class="fa fa-download" aria-hidden="true"></i>';
																						str +=		'</button> ';
																				
																						/* str +=		'  <button type="button" class="btn"  style="background-color: #CFFFFE;padding : 0px 5px 3px;margin: 0px -10px;border: 0.1px solid grey;" onclick="showamuploadbox(\''+values1[v1][3]+'\',\''+values2[v2][3]+'\',\''+values[v3][3]+'\',\''+values[v3][8]+'\',\''+values[v3][6]+'\',\''+values[v3][0]+'\',\''+values[v3][9]+'\',\''+values[v3][10]+'\',\''+values1[v1][0]+'\',\''+values2[v2][0] +'\',\''+values[v3][4]+'\')" >';                                     
																						str  += 			' Amendment <img style="height:20px; width: 20px; " src="view/images/amendment-icon-2.png"> ';   /* <i class="fa fa-plus" style="color: #3DB2FF" aria-hidden="true"></i> <i class="fa fa-upload" style="color: #007bff" aria-hidden="true"></i> 
																						str +=		'</button> </span>'; */
																						
																						str += '</span>';
																					} 
																							
																							
																					str +='	</span> </li>';
																						
																				}
																			}			
																	
																			
																/* ----------------------------------------level 2------------------------------------- */			
																		str +=	'</li> </ul> </li>';
																	}
																} 
															
												 	/* ----------------------------------------level 1------------------------------------- */
																			
															str +='</li> 	</ul> 	</li>';	
														} 
													} 
												/* --------------------------------------------------tree making--------------------------------------------------------- */
													str += '</ul>';
													
													$('#fileuploadlist').html(str);
													
													var toggler = document.getElementsByClassName("caret-1");
													$('#s1').val(l1);
													$('#s2').val(l2);
													$('#s3').val(l3);
													$('#s4').val(l4);
													$('#mainsystemval').val(mid);
													$('#sublevel').val(lev);
													$('#Path').val(mname+'/'+lname1);
													
													var i;
													for (i = 0; i <toggler.length; i++) {
													  toggler[i].addEventListener("click", function() {	
														this.parentElement.querySelector(".nested-1").classList.toggle("active-1");   
													    this.classList.toggle("caret-down-1");
													  });
													}
													$('#exampleModalCenter1').modal('show');
															
															/* if($doclev1>0)
															{
																$('#docsysl1'+$doclev1).click();
															}
															if($doclev2>0)
															{
																$('#docsysl2'+$doclev2).click();
															}
															if($doclev3>0)
															{
																$('#docsysl3'+$doclev3).css("font-weight", "700")
															}
															
															$doclev1=0;
															$doclev2=0;
															$doclev3=0;
													 */
													
											},
											error: function(XMLHttpRequest, textStatus, errorThrown) {
												alert("Internal Error Occured !!");
									            alert("Status: " + textStatus);
									            alert("Error: " + errorThrown); 
									        }  
											
							 		})
							 
						/* --------------------------------------------ajax nested--------------------------------------- */
						
					
				},
				error: function(XMLHttpRequest, textStatus, errorThrown) {
					alert("Internal Error Occured !!");
		            alert("Status: " + textStatus);
		            alert("Error: " + errorThrown); 
		        }  
		 })
				
}


</script>


<!--  -----------------------------------------------agenda attachment js ---------------------------------------------- -->
			
	<% for(int z=0;z<projectidlist.size();z++){ %>
		<script>
								    	  
									function chartprint_<%=projectidlist.get(z)%>(type,interval){ 
								    	  var data = [
								    		  
 											<%for(Object[] obj : ganttchartlist.get(z)){%>
								    		  
								    		  {
								    		    id: "<%=obj[3]%>",
								    		    name: "<%=obj[2]%>",
								    		    baselineStart: "<%=obj[6]%>",
								    		    baselineEnd: "<%=obj[7]%>",
								    		    baseline: {fill: "#f25287 0.5", stroke: "0.5 #dd2c00"},
								    		    actualStart: "<%=obj[4]%>",
								    		    actualEnd: "<%=obj[5]%>",
								    		    actual: {fill: "#046582", stroke: "0.8 #150e56"},
								    		    progressValue: "<%=obj[8]%>%",
								    		    progress: {fill: "#81b214 0.5", stroke: "0.5 #150e56"},
								    		    rowHeight: "35",						    		   
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
								        
								        	 chart.getTimeline().tooltip().useHtml(true);    
										        chart.getTimeline().tooltip().format(
										          "<span style='font-weight:600;font-size:10pt'> Actual : " +
										          "{%actualStart}{dateTimeFormat:dd MMM yyyy} - " +
										          "{%actualEnd}{dateTimeFormat:dd MMM yyyy}</span><br>" +
										          "<span style='font-weight:600;font-size:10pt'> Revised : " +
										          "{%baselineStart}{dateTimeFormat:dd MMM yyyy} - " +
										          "{%baselineEnd}{dateTimeFormat:dd MMM yyyy}</span><br>" +
										          "Progress: {%progress}<br>" 
										        ); 
										        
								        
								        
								       
								        /* Title */
								        
								        var title = chart.title();
										title.enabled(true);
										title.text("<%=ProjectDetail.get(z)[2] %> ( <%=ProjectDetail.get(z)[1] %> ) Gantt Chart");
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
								     	column_1.title().enabled(false);
								     	
								     	var column_2 = chart.dataGrid().column(1);
								     	column_2.title().text("Milestone");
								     	column_2.title().fontColor("#145374");
								     	column_2.title().fontWeight(600);
								     	
								     	
								     
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
								     	    return "<span style='color:orange;font-weight:bold;font-family:'Lato';'>Completed</span>";
								     	  } else {
								     	    return "<span style='color:black;font-weight:bold'>" +
								     	           this.progress * 100 + "</span>%";
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
								        
								
								        

								   		<%-- anychart.onDocumentReady(function () { 
								   		    var nammme="<%=projectidlist.get(z)%>";
								            document.getElementById("containers_"+nammme).style.height = String(itemSum) + 'px';
								            setTimeout(function() {
								            
								            	 //chart.shareAsJpg(function (response) {
								            	    //    alert(response);
								            	    //});
								              
 								             //chart.saveAsJpg({"width":1200, "height": 600,"quality": 2.0,"forceTransparentWhite": false,"filename": "Grantt_"+nammme});
								             //chart.saveAsPdf('a4', true, 100, 100, 'Grantt_'+nammme);
								              //chart.print();
								              setTimeout(function() {
								                //document.getElementById('containers').style.height = '100%';
								              },3000);
								            },1000);
								          });  --%>
									    
								          
									} 
								  
	
		
		 $( document ).ready(function(){
	    	  
	    	  chartprint_<%=projectidlist.get(z)%>('type','');
	      })
	      
	      
	      function ChartPrint_<%=projectidlist.get(z)%>(){
		   		console.log("#interval_<%=projectidlist.get(z) %>");
	    	  var interval_<%=projectidlist.get(z) %> = $("#interval_<%=projectidlist.get(z) %>").val();
	    	  $('#containers_<%=projectidlist.get(z) %>').empty();
	    	  chartprint_<%=projectidlist.get(z)%>('print',interval_<%=projectidlist.get(z) %>);
	     }
	     
	 
				$('#interval_<%=projectidlist.get(z) %>').on('change',function(){
					
					$('#containers_<%=projectidlist.get(z) %>').empty();
					var interval_<%=projectidlist.get(z) %> = $("#interval_<%=projectidlist.get(z) %>").val()
					chartprint_<%=projectidlist.get(z)%>('type',interval_<%=projectidlist.get(z) %>);
					
				})
		

		
		</script>
				
	<% } %>
				
<script type="text/javascript">

function submitForm(frmid)
{ 
  
	        $('body').css("filter", "blur(0.8px)");
	        $('#main').hide();
	        $('#spinner').show();
	  
	
	document.getElementById(frmid).submit(); 
} 
</script>

<script type="text/javascript">

$('.edititemsdd').select2();
$('.items').select2();
$("table").on('click','.tr_clone_addbtn' ,function() {
   $('.items').select2("destroy");        
   var $tr = $('.tr_clone').last('.tr_clone');
   var $clone = $tr.clone();
   $tr.after($clone);
   $('.items').select2();
   $clone.find('.items' ).select2('val', '');    
   $clone.find("input").val("").end();
   /* $clone.find("input:number").val("").end();
   	  $clone.find("input:file").val("").end() 
   */  
});
</script>



<script type="text/javascript">


CKEDITOR.replace( 'ckeditor', {
	
	maxlength: '4000',
	toolbar: [{
	          name: 'clipboard',
	          items: ['PasteFromWord', '-', 'Undo', 'Redo']
	        },
	        {
	          name: 'basicstyles',
	          items: ['Bold', 'Italic', 'Underline', 'Strike', 'RemoveFormat', 'Subscript', 'Superscript']
	        },
	        {
	          name: 'links',
	          items: ['Link', 'Unlink']
	        },
	        {
	          name: 'paragraph',
	          items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote']
	        },
	        {
	          name: 'insert',
	          items: ['Image', 'Table']
	        },
	        {
	          name: 'editing',
	          items: ['Scayt']
	        },
	        '/',

	        {
	          name: 'styles',
	          items: ['Format', 'Font', 'FontSize']
	        },
	        {
	          name: 'colors',
	          items: ['TextColor', 'BGColor', 'CopyFormatting']
	        },
	        {
	          name: 'align',
	          items: ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock']
	        },
	        {
	          name: 'document',
	          items: ['Print', 'PageBreak', 'Source']
	        }
	      ],
	     
	    removeButtons: 'Underline,Strike,Subscript,Superscript,Anchor,Styles,Specialchar',

		customConfig: '',

		disallowedContent: 'img{width,height,float}',
		extraAllowedContent: 'img[width,height,align]',

		height: 500,
		
		contentsCss: [CKEDITOR.basePath +'mystyles.css' ],

		
		bodyClass: 'document-editor',

		
		format_tags: 'p;h1;h2;h3;pre',

		
		removeDialogTabs: 'image:advanced;link:advanced',
		
		stylesSet: [
		
			{ name: 'Marker', element: 'span', attributes: { 'class': 'marker' } },
			{ name: 'Cited Work', element: 'cite' },
			{ name: 'Inline Quotation', element: 'q' },

			
			{
				name: 'Special Container',
				element: 'div',
				styles: {
					padding: '5px 10px',
					background: '#eee',
					border: '1px solid #ccc'
				}
			},
			{
				name: 'Compact table',
				element: 'table',
				attributes: {
					cellpadding: '5',
					cellspacing: '0',
					border: '1',
					bordercolor: '#ccc'
				},
				styles: {
					'border-collapse': 'collapse'
				}
			},
			{ name: 'Borderless Table', element: 'table', styles: { 'border-style': 'hidden', 'background-color': '#E6E6FA' } },
			{ name: 'Square Bulleted List', element: 'ul', styles: { 'list-style-type': 'square' } },
			


]
		
		
		
	} );

$(document).ready(function() {
	var locked=0;
	   var editAbstract=CKEDITOR.instances.ckeditor;

	   editAbstract.on("key",function(e) {      
	                           
	      var maxLength=e.editor.config.maxlength;
	      e.editor.document.on("keyup",function() {KeyUp(e.editor,maxLength,"letterCount",e);});
	      e.editor.document.on("paste",function() {KeyUp(e.editor,maxLength,"letterCount",e);});
	      e.editor.document.on("blur",function() {KeyUp(e.editor,maxLength,"letterCount",e);});
	   },editAbstract.element.$);

	   //function to handle the count check
	   function KeyUp(editorID,maxLimit,infoID,editor) 
	   {
		   var text=editor.editor.getData().replace(/<("[^"]*"|'[^']*'|[^'">])*>/gi, '').replace(/^\s+|\s+$/g, '');
		   $("#"+infoID).text(text.length);
		   if( text.length  >= maxLimit )
		   {
		      if ( !locked )
		      {
		    	 // Record the last legal content.
		         editAbstract.fire('saveSnapshot'), 
		         locked = 1;			                      
		         editor.cancel();			         
		      }
		      else if( text.length > maxLimit ){ // Rollback the illegal one.
		    	 alert('Cannot Insert content longer than '+maxLimit+' Characters');
		         editAbstract.execCommand( 'undo' );			         
		      }
		      else{
		    	  locked = 0;
		      }
		   }
			
	   }   
	   
	  
	   
	});

</script>






</body>
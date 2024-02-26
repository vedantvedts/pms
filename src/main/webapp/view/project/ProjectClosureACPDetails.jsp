<%@page import="java.text.DecimalFormat"%>
<%@page import="com.vts.pfms.master.dto.ProjectFinancialDetails"%>
<%@page import="com.vts.pfms.project.model.ProjectMasterRev"%>
<%@page import="com.vts.pfms.IndianRupeeFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.projectclosure.model.ProjectClosureACPAchievements"%>
<%@page import="com.vts.pfms.projectclosure.model.ProjectClosureACPTrialResults"%>
<%@page import="com.vts.pfms.projectclosure.model.ProjectClosureACPConsultancies"%>
<%@page import="com.vts.pfms.projectclosure.model.ProjectClosureACPProjects"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.vts.pfms.projectclosure.model.ProjectClosureACP"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.project.model.ProjectMaster"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/projectdetails.css" var="projetdetailscss" />
<spring:url value="/resources/ckeditor/ckeditor.js" var="ckeditor" />
<spring:url value="/resources/ckeditor/contents.css" var="contentCss" />
<script src="${ckeditor}"></script>
<link href="${contentCss}" rel="stylesheet" />
<link href="${projetdetailscss}" rel="stylesheet" />


<style type="text/css">

.tab-pane p{
	text-align: justify;
	
}

.card-body{
	padding: 0rem !important;
}
.navigation_btn{
	margin: 1%;
}

 .b{
	background-color: #ebecf1;	
}
.a{
	background-color: #d6e0f0;
}

.nav-link{
	text-align: left;
}
.nav-tabs>.nav-item>.nav-link{
	padding: 11px 15px !important;
}
body { 
   font-family : "Lato", Arial, sans-serif !important;
   overflow-x: hidden;
}

input,select,table,div,label,span {
font-family : "Lato", Arial, sans-serif !important;
}
.text-center{
	text-align: left !imporatant;
}

.control-label,.mandatory{
float: left;
font-weight: bold;
font-size: 1rem;
}
.control-label{
color: purple;
}
</style>

<style type="text/css">

.panel-info {
	border-color: #bce8f1;
}
.panel {
	margin-bottom: 10px;
	background-color: #fff;
	border: 1px solid transparent;
	border-radius: 4px;
	-webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
	box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
}
.panel-heading {
	background-color: #FFF !important;
	border-color: #bce8f1 !important;
	border-bottom: 2px solid #466BA2 !important;
	color: #1d5987;
}
.panel-title {
	margin-top: 0;
	margin-bottom: 0;
	font-size: 13px;
	color: inherit;
	font-weight: bold;
	display: contents;
}

.panel-info>.panel-heading {
	color: #31708f;
	background-color: #d9edf7;
	border-color: #bce8f1;
}

* {
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

div {
	display: block;
}


.olre-body .panel-info .panel-heading {
	background-color: #FFF !important;
	border-color: #bce8f1 !important;
	border-bottom: 2px solid #466BA2 !important;
}

.panel-info>.panel-heading {
	color: #31708f;
	background-color: #d9edf7;
	border-color: #bce8f1;
}

.panel-heading {
	padding: 18px 15px;
	border-bottom: 1px solid transparent;
	border-top-left-radius: 3px;
	border-top-right-radius: 3px;
}

.p-5 {
	padding: 5px;
}

* {
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

user agent stylesheet
div {
	display: block;
}

.panel-info {
	border-color: #bce8f1;
}

.rsqr-column{
 float : left;
}

.scrollclass::-webkit-scrollbar {
    width:7px;
}
.scrollclass::-webkit-scrollbar-track {
    -webkit-box-shadow:inset 0 0 6px rgba(0,0,0,0.3); 
    border-radius:5px;
}
.scrollclass::-webkit-scrollbar-thumb {
    border-radius:5px;
  /*   -webkit-box-shadow: inset 0 0 6px black;  */
	background-color: gray;
}
.scrollclass::-webkit-scrollbar-thumb:hover {
	-webkit-box-shadow: inset 0 0 6px black;
 	transition: 0.5s;
}


.trup{
	padding:6px 10px 6px 10px ;			
	border-radius: 5px;
	font-size: 14px;
	font-weight: 600;
}
.trdown{
	padding:0px 10px 5px 10px ;			
	border-bottom-left-radius : 5px; 
	border-bottom-right-radius: 5px;
	font-size: 14px;
	font-weight: 600;
}



p
{
	text-align: justify !important;
  	text-justify: inter-word;
}
p,td,th
{
  word-wrap: break-word;
  word-break: normal ;
}

.textunderline{
	text-decoration: underline;
}


</style>

<style type="text/css">
.input-group-text{
font-weight: bold;
}

label{
	/* font-weight: 800; */
	font-size: 16px;
	/* color:#07689f; */
} 

hr{
	margin-top: -2px;
	margin-bottom: 12px;
}

.form-group {
    margin-top: 0.5rem;
    margin-bottom: 1rem;
}

</style>

<style type="text/css">

#tabledata{
 margin-left : 30px;
 border-collapse : collapse;
 /* border : 1px solid black; */
 width : 98.5%;
}
#tabledata th{
 text-align : center;
 font-size: 14px;
}
#tabledata td{
 text-align : left;
 vertical-align: top;
 word-wrap: break-word;
 word-break: normal;
}
#tabledata td,th{
 /* border : 1px solid black; */
 padding : 5px;
}

#projectdatatable{
 border-collapse : collapse;
 border : 1px solid #c9c7c7; 
}
#projectdatatable th{
 text-align : center;
 font-size: 14px;
 border : 1px solid #c9c7c7 !important; 
}
#projectdatatable td{
 text-align : left;
 vertical-align: top;
 white-space: normal;
 word-wrap: break-word;
 word-break: normal;
}
#projectdatatable td{
 border : 1px solid #c9c7c7 !important; 
 padding : 5px;
}

#projectdatatablep{
 border-collapse : collapse;
 border : 1px solid black; 
}
#projectdatatablep th{
 text-align : center;
 font-size: 14px;
  border : 1px solid black; 
  padding : 5px;
}
#projectdatatablep td{
 text-align : left;
 vertical-align: top;
 white-space: normal;
 word-wrap: break-word;
 word-break: normal;
 border : 1px solid black; 
 padding : 5px;
}

</style>

</head>
<body>
<%
ProjectMaster projectMaster = (ProjectMaster)request.getAttribute("ProjectDetails");
ProjectMasterRev projectMasterRev = (ProjectMasterRev)request.getAttribute("ProjectMasterRevDetails");
ProjectClosureACP acp = (ProjectClosureACP)request.getAttribute("ProjectClosureACPData");

Object[] potherdetails = (Object[])request.getAttribute("ProjectOriginalRevDetails");
List<ProjectClosureACPProjects> linkedprojectsdata = (List<ProjectClosureACPProjects>)request.getAttribute("ACPProjectsData");
List<ProjectClosureACPConsultancies> consultancies = (List<ProjectClosureACPConsultancies>)request.getAttribute("ACPConsultanciesData");
List<ProjectClosureACPTrialResults> trialresults = (List<ProjectClosureACPTrialResults>)request.getAttribute("ACPTrialResultsData");
List<ProjectClosureACPAchievements> achievements = (List<ProjectClosureACPAchievements>)request.getAttribute("ACPAchivementsData");

List<ProjectClosureACPProjects> subprojects = linkedprojectsdata!=null && linkedprojectsdata.size()>0 ? linkedprojectsdata.stream().filter(e -> e.getACPProjectType().equalsIgnoreCase("S")).collect(Collectors.toList()): new ArrayList<>();
List<ProjectClosureACPProjects> carscapsiprojects = linkedprojectsdata!=null && linkedprojectsdata.size()>0 ? linkedprojectsdata.stream().filter(e -> !e.getACPProjectType().equalsIgnoreCase("S")).collect(Collectors.toList()): new ArrayList<>();
/* List<ProjectClosureACPProjects> carsprojects = linkedprojectsdata!=null && linkedprojectsdata.size()>0 ? linkedprojectsdata.stream().filter(e -> e.getACPProjectType().equalsIgnoreCase("R")).collect(Collectors.toList()): new ArrayList<>();
List<ProjectClosureACPProjects> capsiprojects = linkedprojectsdata!=null && linkedprojectsdata.size()>0 ? linkedprojectsdata.stream().filter(e -> e.getACPProjectType().equalsIgnoreCase("P")).collect(Collectors.toList()): new ArrayList<>(); */

List<Object[]> acpApprovalEmpData = (List<Object[]>)request.getAttribute("ACPApprovalEmpData");
List<Object[]> acpRemarksHistory = (List<Object[]>)request.getAttribute("ACPRemarksHistory");

List<Object[]> labList = (List<Object[]>)request.getAttribute("LabList");

String acpTabId = (String)request.getAttribute("acpTabId");
String projectId = (String)request.getAttribute("projectId");
String isApproval = (String)request.getAttribute("isApproval");
String Details=(String)request.getAttribute("details");

List<String> acpforward = Arrays.asList("AIN","ARG","ARA","ARP","ARL","ARD","ARO","ARN","ARC","ARV");
List<String> acpapprove = Arrays.asList("AAP","AAL","AAD","AAO","AAN","AAC");

Object[] Director = (Object[])request.getAttribute("Director");
Object[] GDDPandC = (Object[])request.getAttribute("GDDPandC");
Object[] LAO = (Object[])request.getAttribute("LAO");
Object[] AD = (Object[])request.getAttribute("AD");
Object[] GD = (Object[])request.getAttribute("GDDetails");
Object[] PDData = (Object[])request.getAttribute("PDData");
Object[] emp = (Object[])request.getAttribute("EmpData");

String labcode = (String)session.getAttribute("labcode");

FormatConverter fc = new FormatConverter();
SimpleDateFormat sdtf = fc.getSqlDateAndTimeFormat();
SimpleDateFormat sdf = fc.getSqlDateFormat();
SimpleDateFormat rdf = fc.getRegularDateFormat();
DecimalFormat df = new DecimalFormat("####################.##");

String statuscode = acp!=null?acp.getClosureStatusCode():null;

int isMain = projectMaster.getIsMainWC();
Double sanctionCost = projectMaster.getTotalSanctionCost();

List<String> projectidlist = (List<String>) request.getAttribute("projectidlist");
List<List<ProjectFinancialDetails>> projectFinancialDetails = (List<List<ProjectFinancialDetails>>) request.getAttribute("financialDetails");
%>

<% String ses=(String)request.getParameter("result"); 
 	String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<div align="center">
		<div class="alert alert-danger" role="alert">
	    <%=ses1 %>
	    </div>
	</div>
	<%}if(ses!=null){ %>
	<div align="center">
		<div class="alert alert-success" role="alert" >
	    	<%=ses %>
		</div>
	</div>
<%} %>

<div class="container-fluid">
	<div class="row">
   		<div class="col-md-12">
       		<div class="card slider">
       			<!-- This is for Slider Headers -->
         		<div class="card-header slider_header" style="padding:0px; font-size:12px!important; height: 0%;">
             		<h4 class="category">Administrative Closure - <%if(projectMaster!=null) {%><%=projectMaster.getProjectShortName()+" ("+projectMaster.getProjectCode()+")" %> <%} %>

             			<a class="btn btn-info btn-sm  shadow-nohover back"
             				<%if(isApproval!=null && isApproval.equalsIgnoreCase("Y") ) {%>
               					href="ProjectClosureApprovals.htm"
               				<%} else if(isApproval!=null &&  isApproval.equalsIgnoreCase("N") ) {%>
               					href="ProjectClosureApprovals.htm?val=app"
               				<%} else{%> 
               					href="ProjectClosureList.htm"
               				<%} %>
             		
             			  style="color: white!important;float: right;">Back</a>
             		</h4>
             		<hr style="margin: -8px 0px !important;">
             		<ul class="nav nav-tabs justify-content-center" role="tablist" style="padding-bottom: 0px;" >

            			<li class="nav-item" id="nav-acpdetails">
             				<%if(acpTabId!=null && acpTabId.equalsIgnoreCase("1")){ %> 
             		    		<a class="nav-link active " data-toggle="tab" href="#acpdetails" id="nav" role="tab">
             				<%}else{ %>
              			 		<a class="nav-link  " data-toggle="tab" href="#acpdetails" role="tab">
               				<%} %>  
               					
                	         	Closure Details
              			 		</a>
            			</li>

            			<li class="nav-item" id="nav-acpforward">
            	     		<%if(acpTabId!=null && acpTabId.equalsIgnoreCase("2")){ %>
              					<a class="nav-link active" data-toggle="tab" href="#acpforward" id="nav"role="tab" >
              				<%}else{ %>
              					<a class="nav-link" data-toggle="tab" href="#acpforward" role="tab" >
               				<%} %>
                  				Closure Forward
              					</a>
            			</li>
            			
              		</ul>
         		</div>
         		
         		<!-- This is for Tab Panes -->
         		<div class="card">
         			<div class="tab-content text-center" style="margin-top : 0.2rem;">
         				<!-- *********** Administrative Closure Details ***********      --> 
               			<%if(acpTabId!=null && acpTabId.equalsIgnoreCase("1")){ %> 
         					<div class="tab-pane active" id="acpdetails" role="tabpanel">
         				<%}else{ %>
              				<div class="tab-pane " id="acpdetails" role="tabpanel">
               			<%} %>
               					<div class="container-fluid">
		        					<div class="row">
		            					<div class="col-md-12 details_container">
						        			<div class="tab-vertical">
						        				<!-- Side tabs headings  -->
						        				<ul class="nav nav-tabs" id="myTab3" role="tablist">
						            
						            				<%-- <li class="nav-item"> 
							                			<a class="nav-link <%if(Details!=null&&Details.equalsIgnoreCase("expenditure")){ %> active <%} %> <%if(Details==null){ %> active <%} %>" id="expenditure-vertical-tab" data-toggle="tab" href="#expenditure-vertical" role="tab" aria-controls="home" aria-selected="true">
							                				Expenditure &emsp; <img src="view/images/check.png" align="right">
							                			</a>
						                			</li> --%>
						                			
						                			<li class="nav-item">
						            					<a class="nav-link <%if(Details!=null&&Details.equalsIgnoreCase("aimobjectives")){ %> active <%} %>  <%if(Details==null){ %> active <%} %>" id="aimobjectives-vertical-tab" data-toggle="tab" href="#aimobjectives-vertical" role="tab" aria-controls="home" aria-selected="false">
						            						Aim & Objectives &emsp;<%if(acp!=null && acp.getACPAim()!=null && acp.getACPObjectives()!=null) {%> <img src="view/images/check.png" align="right"> <%} %>
						            					</a> 
													</li>
													
													<%-- <li class="nav-item">
						            					<a class="nav-link <%if(Details!=null&&Details.equalsIgnoreCase("prototypes")){ %> active <%} %>  " id="prototypes-vertical-tab" data-toggle="tab" href="#prototypes-vertical" role="tab" aria-controls="contact" aria-selected="false">
						            						No of Prototypes <img src="view/images/check.png" align="right">
						            					</a> 
													</li> --%>
													
													<li class="nav-item">
						            					<a class="nav-link <%if(Details!=null&&Details.equalsIgnoreCase("subprojects")){ %> active <%} %>  " id="subprojects-vertical-tab" data-toggle="tab" href="#subprojects-vertical" role="tab" aria-controls="contact" aria-selected="false">
						            						List of Sub-Projects &emsp;<%if(subprojects!=null && subprojects.size()>0) {%> <img src="view/images/check.png" align="right"> <%} %>
						            					</a> 
													</li>
													
													<li class="nav-item">
						            					<a class="nav-link <%if(Details!=null&&Details.equalsIgnoreCase("carscapsi")){ %> active <%} %>  " id="carscapsi-vertical-tab" data-toggle="tab" href="#carscapsi-vertical" role="tab" aria-controls="contact" aria-selected="false">
						            						List of CARS / CAPSI &emsp;<%if(carscapsiprojects!=null && carscapsiprojects.size()>0 ) {%> <img src="view/images/check.png" align="right"> <%} %>
						            					</a> 
													</li>
													
													<li class="nav-item">
						            					<a class="nav-link <%if(Details!=null&&Details.equalsIgnoreCase("consultancies")){ %> active <%} %>  " id="consultancies-vertical-tab" data-toggle="tab" href="#consultancies-vertical" role="tab" aria-controls="contact" aria-selected="false">
						            						List of Consultancies &emsp;<%if(consultancies!=null && consultancies.size()>0) {%> <img src="view/images/check.png" align="right"> <%} %>
						            					</a> 
													</li>
													
													<li class="nav-item">
						            					<a class="nav-link <%if(Details!=null&&Details.equalsIgnoreCase("facilitiescreated")){ %> active <%} %>  " id="facilitiescreated-vertical-tab" data-toggle="tab" href="#facilitiescreated-vertical" role="tab" aria-controls="contact" aria-selected="false">
						            						Facilities Created &emsp;<%if(acp!=null && acp.getFacilitiesCreated()!=null) {%> <img src="view/images/check.png" align="right"> <%} %>
						            					</a> 
													</li>
													
													<li class="nav-item">
						            					<a class="nav-link <%if(Details!=null&&Details.equalsIgnoreCase("trialresults")){ %> active <%} %>  " id="trialresults-vertical-tab" data-toggle="tab" href="#trialresults-vertical" role="tab" aria-controls="contact" aria-selected="false">
						            						Trial Results &emsp;<%if(trialresults!=null && trialresults.size()>0) {%> <img src="view/images/check.png" align="right"> <%} %>
						            					</a> 
													</li>
													
													<li class="nav-item">
						            					<a class="nav-link <%if(Details!=null&&Details.equalsIgnoreCase("achievements")){ %> active <%} %>  " id="achievements-vertical-tab" data-toggle="tab" href="#achievements-vertical" role="tab" aria-controls="contact" aria-selected="false">
						            						Achievements &emsp;<%if(achievements!=null && achievements.size()>0) {%> <img src="view/images/check.png" align="right"> <%} %>
						            					</a> 
													</li>
													
													<li class="nav-item">
						            					<a class="nav-link <%if(Details!=null&&Details.equalsIgnoreCase("recommendations")){ %> active <%} %>  " id="recommendations-vertical-tab" data-toggle="tab" href="#recommendations-vertical" role="tab" aria-controls="contact" aria-selected="false">
						            						Recommendations &emsp;<%if(acp!=null && acp.getMonitoringCommittee()!=null) {%> <img src="view/images/check.png" align="right"> <%} %>
						            					</a> 
													</li>
													
													<li class="nav-item">
						            					<a class="nav-link <%if(Details!=null&&Details.equalsIgnoreCase("others")){ %> active <%} %>  " id="others-vertical-tab" data-toggle="tab" href="#others-vertical" role="tab" aria-controls="contact" aria-selected="false">
						            						Others &emsp;<%if(acp!=null && acp.getExpndAsOn()!=null){ %> <img src="view/images/check.png" align="right"> <%} %>
						            					</a> 
													</li>
						                		</ul>
						                		
						                		<!-- Side tab Details -->
						                		<div class="tab-content" id="myTabContent3">
						                		
						                			<!-- Aim & Objectives Side bar Details  -->
						                			<div class="tab-pane fade <%if(Details!=null&&Details.equalsIgnoreCase("aimobjectives")){ %> show active <%} %> <%if(Details==null){ %> show active <%} %> " id="aimobjectives-vertical" role="tabpanel" aria-labelledby="aimobjectives-vertical-tab">
						                				
						                				<!-- Aim & Objectives showing as Doc -->
						                				<div id="aimobjectivesdiv">
						                					<div class="row">
							                            		<div class="col-md-10" align="left">
							                            			<h4 style="font-family: 'Lato',sans-serif;color: #005086"><b>Aim & Objectives</b></h4>
							                            		</div>
			                            	
								                   				<div class="col-md-2" style="margin-bottom: 5px">
																	<button class="share-button" style="border: none;font-size:13px" onclick="AllowEdit('aimobjectives')" id="" value="EDIT" >
														  				<span><i class="fa fa-pencil" aria-hidden="true"></i></span>
														  				<input type="submit"  class="edit-btn" name="sub" value="EDIT">
																	</button>
																</div>       			  	
				                            				</div>
				                            				
				                            				<hr>
				                            				
				                            				<div class="row">
				                            					<div class="col-md-12" align="left">
 																	<label style="margin-top:0px; margin-left:0px;font-weight: 800; margin-bottom:0px;	font-size: 20px; color:#07689f;">
 																		<b style="font-family: 'Lato',sans-serif;font-size: large;">Aim</b>
 																	</label>
 																</div>
				                            				</div>
				                            				<div class="row">
				                            					<div class="col-md-12" align="left">
 																	<p>
 																		<%if(acp!=null && acp.getACPAim()!=null) {%>
 																			<%=acp.getACPAim().replaceAll("\n", "<br>") %> 
 																		<%} %>
 																	</p>
 																</div>
 															</div>
															
															<hr>
															
															<div class="row">
																<div class="col-md-12" align="left">
																	<label style="margin-top:0px; margin-left:0px;font-weight: 800;margin-bottom:0px;font-size: 20px; color:#07689f;">
																		<b style="font-family: 'Lato',sans-serif;font-size: large;">Objectives</b>
																	</label>
																</div>
															</div>
															
															<div class="row">
				                            					<div class="col-md-12" align="left">
 																	<p><%if(acp!=null && acp.getACPObjectives()!=null) {%><%=acp.getACPObjectives() %> <%} %></p>
 																</div>
 															</div>				                
															
						                				</div>
						                				
						                				<!-- Aim & Objectives Add / Edit -->
					                					<form action="ProjectClosureACPDetailsSubmit.htm" method="POST" name="myform1" id="myform1" >	
															<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
															<input type="hidden" name="projectId" value="<%=projectId %>" />
															<div class="row"> 
																<div class="col-md-12"  >
																	<div class="card" >
																		<div class="card-body">
																			<div class="row" style="margin-left: 2%;margin-right: 2%;">
																	        	<div class="col-md-12" style="">
																	        		<div class="form-group">
																	                	<label class="control-label">Aim:</label><span class="mandatory">*</span>
																	                    <textarea class="form-control form-control" name="acpAim" maxlength="5000" rows="2" cols="65" style="font-size: 15px;" 
					                              		  								 placeholder="Enter maximum 5000 charecters" required><%if(acp!=null && acp.getACPAim()!=null){ %><%=acp.getACPAim() %><%} %></textarea> 
																	                </div>
																	            </div>
											       	 						</div>
																		</div>
																		<div class="card-body">
																	    	
																	 		<div class="row"  style="margin-left: 3%;margin-right: 2%;">
																	 			<label class="control-label">Objectives: </label><span class="mandatory">*</span>
																				<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
																					<div id="objectivesnote" class="center"> </div>
																					<input type="hidden" id="objectiveshidden" value="<%if(acp!=null && acp.getACPObjectives()!=null) {%><%=acp.getACPObjectives() %><%}%>">
																				</div>
																	  			<textarea name="acpObjectives" style="display:none;"></textarea>
																				<input type="hidden" name="details" value="aimobjectives"> 
																	 			
																	 		</div>  
																	 		<div class="row"  style="margin-left: 3%;margin-right: 2%;text-align: left;">
																	 			<div class="col-md-12">
																	 				<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
																	 			</div>
																	 		</div>	
																	 		
																	 	</div>
																	 		
																	 	<div class="form-group" align="center" >
																	 		<%if(acp!=null && acp.getACPAim()!=null && acp.getACPObjectives()!=null) {%>
																				<button type="submit" class="btn btn-sm btn-warning btn-sm edit btn-acp" name="Action" value="Edit" onclick="return confirm('Are you sure to Update?');" >UPDATE</button>
																				
																				<button type="button" class="btn btn-sm" style="border: none;font-size:13px;margin-left: 1%;padding: 7px 10px 7px 10px;" onclick="CloseEdit('aimobjectives')"
																				 formnovalidate="formnovalidate" data-toggle="tooltip" data-placement="top" title="Close">
																		  			<i class="fa fa-times fa-lg" aria-hidden="true" style="color: red;"></i>
																		  		</button>
																				
																			<%} else{%>
																				<button type="submit" class="btn btn-sm btn-primary btn-sm submit btn-acp" name="Action" value="Add" onclick="return confirm('Are you sure to Submit?');" >SUBMIT</button>
																			<%} %>
																		</div>
																	</div>
																		
																</div>
															</div>
														</form>
						                				
						                			</div>
						                			
						                			<!-- Sub-Projects Side bar Details -->
						                			<div class="tab-pane fade <%if(Details!=null&&Details.equalsIgnoreCase("subprojects")){ %> show active <%} %> " id="subprojects-vertical" role="tabpanel" aria-labelledby="subprojects-vertical-tab">
						                				
						                				<!-- Sub-Projects showing as Doc -->
						                				<div id="subprojectsdiv">
						                					<div class="row">
							                            		<div class="col-md-10" align="left">
							                            			<h4 style="font-family: 'Lato',sans-serif;color: #005086"><b>List of Sub-Projects</b></h4>
							                            		</div>
			                            	
								                   				<div class="col-md-2" style="margin-bottom: 5px">
																	<button class="share-button" style="border: none;font-size:13px" onclick="AllowEdit('subprojects')" id="" value="EDIT" >
														  				<span><i class="fa fa-pencil" aria-hidden="true"></i></span>
														  				<input type="submit"  class="edit-btn" name="sub" value="EDIT">
																	</button>
																</div>       			  	
				                            				</div>
				                            				
				                            				<hr>
				                            				
				                            				<table id="projectdatatable" style="width:100%;" >
																<thead style = "background-color: #055C9D; color: white;text-align: center;">
																	<tr>
																		<th style="width: 5%;">SN</th>
																    	<th style="width: 20%;">Projects Name</th>
																    	<th style="width: 10%;">Project No</th>
																    	<th style="width: 15%;">Agency</th>
																    	<th style="width: 10%;">Cost (&#8377;)</th>
																    	<th style="width: 20%;">Status</th>
																    	<th style="">Achievement</th>
																	</tr>
																</thead>
																<tbody>
																	<%if(subprojects!=null && subprojects.size()>0) {
																		int subprojectslno = 0;
																		for(ProjectClosureACPProjects sub :subprojects) {%>
																		<tr>
																			<td style="width: 5%;text-align: center;"><%=++subprojectslno %></td>
																			<td style="width: 20%;"><%=sub.getACPProjectName() %> </td>
																			<td style="width: 10%;text-align: center;"><%=sub.getACPProjectNo() %> </td>
																			<td style="width: 15%;"><%=sub.getProjectAgency() %> </td>
																			<td style="width: 10%;text-align: right;"><%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(sub.getProjectCost())) %> </td>
																			<td style="width: 20%;"><%=sub.getProjectStatus() %> </td>
																			<td style=""><%=sub.getProjectAchivements() %> </td>
																		</tr>
																	<%} }%>	
																</tbody>
															</table>		                
															
						                				</div>
						                				
						                				<!-- Sub-Projects Add / Edit -->
						                				<form action="ProjectClosureACPProjectDetailsSubmit.htm" method="POST" name="myform2" id="myform2">
						                					<table style="width:100%; " id="subprojectstable">
																<thead style = "background-color: #055C9D; color: white;text-align: center;border: none !important;">
																	<tr>
																    	<th style="width: ;padding: 0px 5px 0px 5px;">Projects Name</th>
																    	<th style="width: ;padding: 0px 5px 0px 5px;">Project No</th>
																    	<th style="width: ;padding: 0px 5px 0px 5px;">Agency</th>
																    	<th style="width: ;padding: 0px 5px 0px 5px;">Cost (&#8377;)</th>
																    	<th style="width: ;padding: 0px 5px 0px 5px;">Status</th>
																    	<th style="width: ;padding: 0px 5px 0px 5px;">Achievement</th>
																		<td style="width: 5%;">
																			<button type="button" class=" btn btn_add_subprojects "> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button>
																		</td>
																	</tr>
																</thead>
																<tbody>
																	<%if(subprojects!=null && subprojects.size()>0) {
																		for(ProjectClosureACPProjects sub :subprojects) {%>
																		<tr class="tr_clone_subprojects">
																			<td style="width: ;padding: 10px 5px 0px 5px;" >
																				<input type="text" class="form-control item" name="acpProjectName" value="<%if(sub.getACPProjectName()!=null) {%><%=sub.getACPProjectName() %><%} %>" placeholder="Enter Sub-Project Name" maxlength="1000" required="required" >
																			</td>	
																			<td style="width: ;padding: 10px 5px 0px 5px;">
																				<input type="text" class="form-control item" name="acpProjectNo" value="<%if(sub.getACPProjectNo()!=null) {%><%=sub.getACPProjectNo() %><%} %>" placeholder="Enter Sub-Project No." maxlength="200" required="required" >
																			</td>	
																			<td style="width: ;padding: 10px 5px 0px 5px;">
																				<input type="text" class="form-control item" name="projectAgency" value="<%if(sub.getProjectAgency()!=null) {%><%=sub.getProjectAgency() %><%} %>" placeholder="Enter Agency Details" maxlength="1000" required="required" >
																			</td>	
																			<td style="width: ;padding: 10px 5px 0px 5px;">
																				<input type="number" class="form-control item" name="projectCost" value="<%if(sub.getProjectCost()!=null) {%><%=sub.getProjectCost() %><%} %>" placeholder="Enter Project Cost" maxlength="15" required="required" step="0.01" >
																			</td>
																			<td style="width: ;padding: 10px 5px 0px 5px;">
																				<input type="text" class="form-control item" name="projectStatus" value="<%if(sub.getProjectStatus()!=null) {%><%=sub.getProjectStatus() %><%} %>" placeholder="Enter Project Status" maxlength="500" required="required" >
																			</td>
																			<td style="width: ;padding: 10px 5px 0px 5px;">
																				<input type="text" class="form-control item" name="projectAchivements" value="<%if(sub.getProjectAchivements()!=null) {%><%=sub.getProjectAchivements() %><%} %>" placeholder="Enter Achievement Details" maxlength="2000" required="required" >
																			</td>
																			<td style="width: 5% ; ">
																				<button type="button" class=" btn btn_rem_subprojects" > <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>
																			</td>									
																		</tr>
																	<%} } else {%>
																		<tr class="tr_clone_subprojects">
																			<td style="width: ;padding: 10px 5px 0px 5px;" >
																				<input type="text" class="form-control item" name="acpProjectName" maxlength="1000" placeholder="Enter Sub-Project Name" required="required" >
																			</td>	
																			<td style="width: ;padding: 10px 5px 0px 5px;">
																				<input type="text" class="form-control item" name="acpProjectNo" maxlength="200" placeholder="Enter Sub-Project No." required="required" >
																			</td>	
																			<td style="width: ;padding: 10px 5px 0px 5px;">
																				<input type="text" class="form-control item" name="projectAgency" maxlength="1000" placeholder="Enter Agency Details" required="required" >
																			</td>	
																			<td style="width: ;padding: 10px 5px 0px 5px;">
																				<input type="number" class="form-control item" name="projectCost" maxlength="15" placeholder="Enter Project Cost" required="required" step="0.01" >
																			</td>
																			<td style="width: ;padding: 10px 5px 0px 5px;">
																				<input type="text" class="form-control item" name="projectStatus" maxlength="500" placeholder="Enter Project Status" required="required" >
																			</td>
																			<td style="width: ;padding: 10px 5px 0px 5px;">
																				<input type="text" class="form-control item" name="projectAchivements" maxlength="2000" placeholder="Enter Achievement Details" required="required" >
																			</td>
																			<td style="width: 5% ; ">
																				<button type="button" class=" btn btn_rem_subprojects " > <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>
																			</td>	
																		</tr>
																	<%} %>
																</tbody>
															</table>
															<div align="center" style="margin-top: 15px;">
																
																<%if(subprojects!=null && subprojects.size()>0) {%>
																	<button type="submit" class="btn btn-sm btn-warning edit mt-2 btn-acp" name="Action" value="Edit" onclick="return confirm('Are you sure to update?')">UPDATE</button>
																	
																	<button type="button" class="btn btn-sm" style="border: none;font-size:13px;margin-left: 1%;padding: 7px 10px 7px 10px;margin-top: 0.5%;" onclick="CloseEdit('subprojects')"
																	 formnovalidate="formnovalidate" data-toggle="tooltip" data-placement="top" title="Close">
																		<i class="fa fa-times fa-lg" aria-hidden="true" style="color: red;"></i>
																	</button>
																	
																<%} else{%> 
																	<button type="submit" class="btn btn-sm submit btn-acp" name="Action" value="Add" onclick="return confirm('Are you sure to submit?')">SUBMIT</button>
																<%} %>
																<input type="hidden" name="projectId" value="<%=projectId%>">
																<input type="hidden" name="details" value="subprojects" />
																<input type="hidden" name="acpProjectTypeFlag" value="S" />
																<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
																
															</div>
						                				</form>
						                			</div>
						                			
						                			<!-- CARS / CAPSI Side bar Details -->
						                			<div class="tab-pane fade <%if(Details!=null&&Details.equalsIgnoreCase("carscapsi")){ %> show active <%} %> " id="carscapsi-vertical" role="tabpanel" aria-labelledby="carscapsi-vertical-tab">
						                				
						                				<!-- CARS / CAPSI showing as Doc -->
						                				<div id="carscapsidiv">
						                					<div class="row">
							                            		<div class="col-md-10" align="left">
							                            			<h4 style="font-family: 'Lato',sans-serif;color: #005086"><b> List of CARS / CAPSI</b></h4>
							                            		</div>
			                            	
								                   				<div class="col-md-2" style="margin-bottom: 5px">
																	<button class="share-button" style="border: none;font-size:13px" onclick="AllowEdit('carscapsi')" id="" value="EDIT" >
														  				<span><i class="fa fa-pencil" aria-hidden="true"></i></span>
														  				<input type="submit"  class="edit-btn" name="sub" value="EDIT">
																	</button>
																</div>       			  	
				                            				</div>
				                            				
				                            				<hr>
				                            				
				                            				<table id="projectdatatable" style="width:100%;" >
																<thead style = "background-color: #055C9D; color: white;text-align: center;">
																	<tr>
																		<th style="width: 5%;">SN</th>
																    	<th style="width: 5%;">CARS / CAPSI</th>
																    	<th style="width: 20%;">CARS / CAPSI Name</th>
																    	<th style="width: 10%;">CARS / CAPSI No</th>
																    	<th style="width: 15%;">Agency</th>
																    	<th style="width: 10%;">Cost (&#8377;)</th>
																    	<th style="width: 15%;">Status</th>
																    	<th style="">Achievement</th>
																	</tr>
																</thead>
																<tbody>
																	<%if(carscapsiprojects !=null && carscapsiprojects.size()>0) {
																		int carscapsiprojectslno = 0;
																		for(ProjectClosureACPProjects carscapsi :carscapsiprojects) {%>
																		<tr>
																			<td style="width: 5%;text-align: center;"><%=++carscapsiprojectslno %></td>
																			<td style="width: 5%;">
																				<%if(carscapsi.getACPProjectType()!=null && carscapsi.getACPProjectType().equalsIgnoreCase("R")) {%>
																					CARS
																				<%} else{%>
																					CAPSI
																				<%} %>
																			</td>
																			<td style="width: 20%;"><%=carscapsi.getACPProjectName() %> </td>
																			<td style="width: 10%;text-align: center;"><%=carscapsi.getACPProjectNo() %> </td>
																			<td style="width: 15%;"><%=carscapsi.getProjectAgency() %> </td>
																			<td style="width: 10%;text-align: right;"><%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(carscapsi.getProjectCost())) %> </td>
																			<td style="width: 20%;"><%=carscapsi.getProjectStatus() %> </td>
																			<td style=""><%=carscapsi.getProjectAchivements() %> </td>
																		</tr>
																	<%} }%>	
																</tbody>
															</table>		                
															
						                				</div>
						                				
						                				<!-- Sub-Projects Add / Edit -->
						                				<form action="ProjectClosureACPProjectDetailsSubmit.htm" method="POST" name="myform3" id="myform3">
						                					<table style="width:100%; " id="carscapsitable">
																<thead style = "background-color: #055C9D; color: white;text-align: center;">
																	<tr>
																    	<th style="width: ;padding: 0px 5px 0px 5px;">CARS / CAPSI</th>
																    	<th style="width: ;padding: 0px 5px 0px 5px;">CARS / CAPSI Name</th>
																    	<th style="width: ;padding: 0px 5px 0px 5px;">CARS / CAPSI No</th>
																    	<th style="width: ;padding: 0px 5px 0px 5px;">Agency</th>
																    	<th style="width: ;padding: 0px 5px 0px 5px;">Cost (&#8377;)</th>
																    	<th style="width: ;padding: 0px 5px 0px 5px;">Status</th>
																    	<th style="width: ;padding: 0px 5px 0px 5px;">Achievement</th>
																		<td style="width: 5%;">
																			<button type="button" class=" btn btn_add_carscapsi "> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button>
																		</td>
																	</tr>
																</thead>
																<tbody>
																	<%if(carscapsiprojects!=null && carscapsiprojects.size()>0) {
																		for(ProjectClosureACPProjects carscapsi :carscapsiprojects) {%>
																		<tr class="tr_clone_carscapsi">
																			<td style="width: ;padding: 10px 5px 0px 5px;">
																				<select class="form-control" name="acpProjectType" required>
																					<option value="R" <%if(carscapsi.getACPProjectType()!=null && carscapsi.getACPProjectType().equalsIgnoreCase("R")) {%>selected<%} %> >CARS</option>
																					<option value="P" <%if(carscapsi.getACPProjectType()!=null && carscapsi.getACPProjectType().equalsIgnoreCase("P")) {%>selected<%} %> >CAPSI</option>
																				</select>
																			</td>
																			<td style="width: ;padding: 10px 5px 0px 5px;" >
																				<input type="text" class="form-control item" name="acpProjectName" value="<%if(carscapsi.getACPProjectName()!=null) {%><%=carscapsi.getACPProjectName() %><%} %>" placeholder="Enter Sub-Project Name" maxlength="1000" required="required" >
																			</td>	
																			<td style="width: ;padding: 10px 5px 0px 5px;">
																				<input type="text" class="form-control item" name="acpProjectNo" value="<%if(carscapsi.getACPProjectNo()!=null) {%><%=carscapsi.getACPProjectNo() %><%} %>" placeholder="Enter Sub-Project No." maxlength="200" required="required" >
																			</td>	
																			<td style="width: ;padding: 10px 5px 0px 5px;">
																				<input type="text" class="form-control item" name="projectAgency" value="<%if(carscapsi.getProjectAgency()!=null) {%><%=carscapsi.getProjectAgency() %><%} %>" placeholder="Enter Agency Details" maxlength="1000" required="required" >
																			</td>	
																			<td style="width: ;padding: 10px 5px 0px 5px;">
																				<input type="number" class="form-control item" name="projectCost" value="<%if(carscapsi.getProjectCost()!=null) {%><%=carscapsi.getProjectCost() %><%} %>" placeholder="Enter Project Cost" maxlength="15" required="required" step="0.01" >
																			</td>
																			<td style="width: ;padding: 10px 5px 0px 5px;">
																				<input type="text" class="form-control item" name="projectStatus" value="<%if(carscapsi.getProjectStatus()!=null) {%><%=carscapsi.getProjectStatus() %><%} %>" placeholder="Enter Project Status" maxlength="500" required="required" >
																			</td>
																			<td style="width: ;padding: 10px 5px 0px 5px;">
																				<input type="text" class="form-control item" name="projectAchivements" value="<%if(carscapsi.getProjectAchivements()!=null) {%><%=carscapsi.getProjectAchivements() %><%} %>" placeholder="Enter Achievement Details" maxlength="2000" required="required" >
																			</td>
																			<td style="width: 5% ; ">
																				<button type="button" class=" btn btn_rem_carscapsi" > <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>
																			</td>									
																		</tr>
																	<%} } else {%>
																		<tr class="tr_clone_carscapsi">
																			<td style="width: ;padding: 10px 5px 0px 5px;">
																				<select class="form-control" name="acpProjectType" required>
																					<option value="R" >CARS</option>
																					<option value="P" >CAPSI</option>
																				</select>
																			</td>
																			<td style="width: ;padding: 10px 5px 0px 5px;" >
																				<input type="text" class="form-control item" name="acpProjectName" maxlength="1000" placeholder="Enter Sub-Project Name" required="required" >
																			</td>	
																			<td style="width: ;padding: 10px 5px 0px 5px;">
																				<input type="text" class="form-control item" name="acpProjectNo" maxlength="200" placeholder="Enter Sub-Project No." required="required" >
																			</td>	
																			<td style="width: ;padding: 10px 5px 0px 5px;">
																				<input type="text" class="form-control item" name="projectAgency" maxlength="1000" placeholder="Enter Agency Details" required="required" >
																			</td>	
																			<td style="width: ;padding: 10px 5px 0px 5px;">
																				<input type="number" class="form-control item" name="projectCost" maxlength="15" placeholder="Enter Project Cost" required="required" step="0.01" >
																			</td>
																			<td style="width: ;padding: 10px 5px 0px 5px;">
																				<input type="text" class="form-control item" name="projectStatus" maxlength="500" placeholder="Enter Project Status" required="required" >
																			</td>
																			<td style="width: ;padding: 10px 5px 0px 5px;">
																				<input type="text" class="form-control item" name="projectAchivements" maxlength="2000" placeholder="Enter Achievement Details" required="required" >
																			</td>
																			<td style="width: 5% ; ">
																				<button type="button" class=" btn btn_rem_carscapsi " > <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>
																			</td>	
																		</tr>
																	<%} %>
																</tbody>
															</table>
															<div align="center" style="margin-top: 15px;">
																
																<%if(carscapsiprojects!=null && carscapsiprojects.size()>0) {%>
																	<button type="submit" class="btn btn-sm btn-warning edit mt-2 btn-acp" name="Action" value="Edit" onclick="return confirm('Are you sure to update?')">UPDATE</button>
																	
																	<button type="button" class="btn btn-sm" style="border: none;font-size:13px;margin-left: 1%;padding: 7px 10px 7px 10px;margin-top: 0.5%;" onclick="CloseEdit('carscapsi')"
																	 formnovalidate="formnovalidate" data-toggle="tooltip" data-placement="top" title="Close">
																		<i class="fa fa-times fa-lg" aria-hidden="true" style="color: red;"></i>
																	</button>
																	
																<%} else{%> 
																	<button type="submit" class="btn btn-sm submit btn-acp" name="Action" value="Add" onclick="return confirm('Are you sure to submit?')">SUBMIT</button>
																<%} %>
																<input type="hidden" name="projectId" value="<%=projectId%>">
																<input type="hidden" name="details" value="carscapsi" />
																<input type="hidden" name="acpProjectTypeFlag" value="O" />
																<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
																
															</div>
						                				</form>
						                			</div>
						                			
						                			<!-- Consultancies Side bar Details -->
						                			<div class="tab-pane fade <%if(Details!=null&&Details.equalsIgnoreCase("consultancies")){ %> show active <%} %> " id="consultancies-vertical" role="tabpanel" aria-labelledby="consultancies-vertical-tab">
						                				
						                				<!-- Consultancies showing as Doc -->
						                				<div id="consultanciesdiv">
						                					<div class="row">
							                            		<div class="col-md-10" align="left">
							                            			<h4 style="font-family: 'Lato',sans-serif;color: #005086"><b> List of Consultancies</b></h4>
							                            		</div>
			                            	
								                   				<div class="col-md-2" style="margin-bottom: 5px">
																	<button class="share-button" style="border: none;font-size:13px" onclick="AllowEdit('consultancies')" id="" value="EDIT" >
														  				<span><i class="fa fa-pencil" aria-hidden="true"></i></span>
														  				<input type="submit"  class="edit-btn" name="sub" value="EDIT">
																	</button>
																</div>       			  	
				                            				</div>
				                            				
				                            				<hr>
				                            				
				                            				<table id="projectdatatable" style="width:100%;" >
																<thead style = "background-color: #055C9D; color: white;text-align: center;">
																	<tr>
																		<th style="width: 5%;">SN</th>
																    	<th style="width: 35%;">Aim</th>
																    	<th style="width: 30%;">Agency</th>
																    	<th style="width: 20%;">Amount (&#8377;)</th>
																    	<th style="width: 10%;">Date</th>
																	</tr>
																</thead>
																<tbody>
																	<%if(consultancies !=null && consultancies.size()>0) {
																		int consultancieslno = 0;
																		for(ProjectClosureACPConsultancies consultancy :consultancies) {%>
																		<tr>
																			<td style="width: 5%;text-align: center;"><%=++consultancieslno %></td>
																			<td style="width: 35%;"><%=consultancy.getConsultancyAim() %> </td>
																			<td style="width: 30%;"><%=consultancy.getConsultancyAgency() %> </td>
																			<td style="width: 20%;text-align: right;"><%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(consultancy.getConsultancyCost())) %> </td>
																			<td style="width: 10%;text-align: center;"><%=fc.SqlToRegularDate(consultancy.getConsultancyDate()) %> </td>
																		</tr>
																	<%} }%>	
																</tbody>
															</table>		                
															
						                				</div>
						                				
						                				<!-- Consultancies Add / Edit -->
						                				<form action="ProjectClosureACPConsultancyDetailsSubmit.htm" method="POST" name="myform4" id="myform4">
						                					<table style="width:100%; " id="consultanciestable">
																<thead style = "background-color: #055C9D; color: white;text-align: center;">
																	<tr>
																    	<th style="width: 40%;padding: 0px 5px 0px 5px;">Aim</th>
																    	<th style="width: 25%;padding: 0px 5px 0px 5px;">Agency</th>
																    	<th style="width: 20%;padding: 0px 5px 0px 5px;">Amount (&#8377;)</th>
																    	<th style="width: 10%;padding: 0px 5px 0px 5px;">Date</th>
																		<td style="width: 5%;">
																			<button type="button" class=" btn btn_add_consultancies "> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button>
																		</td>
																	</tr>
																</thead>
																<tbody>
																	<%if(consultancies !=null && consultancies.size()>0) {
																		for(ProjectClosureACPConsultancies consultancy :consultancies) {%>
																		<tr class="tr_clone_consultancies">
																			<td style="width: 40%;padding: 10px 5px 0px 5px;" >
																				<input type="text" class="form-control item" name="consultancyAim" value="<%if(consultancy.getConsultancyAim()!=null) {%><%=consultancy.getConsultancyAim() %><%} %>" placeholder="Enter Consultancy Aim" maxlength="3000" required="required" >
																			</td>	
																			<td style="width: 25%;padding: 10px 5px 0px 5px;">
																				<input type="text" class="form-control item" name="consultancyAgency" value="<%if(consultancy.getConsultancyAgency()!=null) {%><%=consultancy.getConsultancyAgency() %><%} %>" placeholder="Enter Consultancy Agency" maxlength="2000" required="required" >
																			</td>	
																			<td style="width: 10%;padding: 10px 5px 0px 5px;">
																				<input type="number" class="form-control item" name="consultancyCost" value="<%if(consultancy.getConsultancyCost()!=null) {%><%=consultancy.getConsultancyCost() %><%} %>" placeholder="Enter Consultancy Amount" maxlength="15" required="required" step="0.01" >
																			</td>
																			<td style="width: 20%;padding: 10px 5px 0px 5px;">
																				<input type="text" class="form-control item" name="consultancyDate" id="consultancyDate" value="<%if(consultancy.getConsultancyDate()!=null) {%><%=consultancy.getConsultancyDate() %><%} %>" required="required" >
																			</td>	
																			<td style="width: 5% ; ">
																				<button type="button" class=" btn btn_rem_consultancies" > <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>
																			</td>									
																		</tr>
																	<%} } else {%>
																		<tr class="tr_clone_consultancies">
																			<td style="width: 40%;padding: 10px 5px 0px 5px;" >
																				<input type="text" class="form-control item" name="consultancyAim" placeholder="Enter Consultancy Aim" maxlength="3000" required="required" >
																			</td>	
																			<td style="width: 25%;padding: 10px 5px 0px 5px;">
																				<input type="text" class="form-control item" name="consultancyAgency" placeholder="Enter Consultancy Agency" maxlength="2000" required="required" >
																			</td>	
																			<td style="width: 10%;padding: 10px 5px 0px 5px;">
																				<input type="number" class="form-control item" name="consultancyCost" placeholder="Enter Consultancy Amount" maxlength="15" required="required" step="0.01" >
																			</td>
																			<td style="width: 20%;padding: 10px 5px 0px 5px;">
																				<input type="text" class="form-control item" name="consultancyDate" id="consultancyDate" readonly="readonly" required="required" style="background: #fff;" >
																			</td>
																			<td style="width: 5% ; ">
																				<button type="button" class=" btn btn_rem_consultancies " > <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>
																			</td>	
																		</tr>
																	<%} %>
																</tbody>
															</table>
															<div align="center" style="margin-top: 15px;">
																
																<%if(consultancies !=null && consultancies.size()>0) {%>
																	<button type="submit" class="btn btn-sm btn-warning edit mt-2 btn-acp" name="Action" value="Edit" onclick="return confirm('Are you sure to update?')">UPDATE</button>
																	
																	<button type="button" class="btn btn-sm" style="border: none;font-size:13px;margin-left: 1%;padding: 7px 10px 7px 10px;margin-top: 0.5%;" onclick="CloseEdit('consultancies')"
																	 formnovalidate="formnovalidate" data-toggle="tooltip" data-placement="top" title="Close">
																		<i class="fa fa-times fa-lg" aria-hidden="true" style="color: red;"></i>
																	</button>
																	
																<%} else{%> 
																	<button type="submit" class="btn btn-sm submit btn-acp" name="Action" value="Add" onclick="return confirm('Are you sure to submit?')">SUBMIT</button>
																<%} %>
																<input type="hidden" name="projectId" value="<%=projectId%>">
																<input type="hidden" name="details" value="consultancies" />
																<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
																
															</div>
						                				</form>
						                			</div>
						                			
						                			<!-- Facilities Created Side bar Details -->
						                			<div class="tab-pane fade <%if(Details!=null&&Details.equalsIgnoreCase("facilitiescreated")){ %> show active <%} %> " id="facilitiescreated-vertical" role="tabpanel" aria-labelledby="facilitiescreated-vertical-tab">
						                				
						                				<!-- Facilities Created showing as Doc -->
						                				<div id="facilitiescreateddiv">
						                					<div class="row">
							                            		<div class="col-md-10" align="left">
							                            			<h4 style="font-family: 'Lato',sans-serif;color: #005086"><b>Details of Facilities Created</b></h4>
							                            		</div>
			                            	
								                   				<div class="col-md-2" style="margin-bottom: 5px">
																	<button class="share-button" style="border: none;font-size:13px" onclick="AllowEdit('facilitiescreated')" id="" value="EDIT" >
														  				<span><i class="fa fa-pencil" aria-hidden="true"></i></span>
														  				<input type="submit"  class="edit-btn" name="sub" value="EDIT">
																	</button>
																</div>       			  	
				                            				</div>
															
															<hr>
															
															<div class="row">
																<div class="col-md-12" align="left">
																	<label style="margin-top:0px; margin-left:0px;font-weight: 800;margin-bottom:0px;font-size: 20px; color:#07689f;">
																		<b style="font-family: 'Lato',sans-serif;font-size: large;">Facilities Created</b>
																	</label>
																</div>
															</div>
															
															<div class="row">
				                            					<div class="col-md-12" align="left">
 																	<p><%if(acp!=null && acp.getFacilitiesCreated()!=null) {%><%=acp.getFacilitiesCreated() %> <%} %></p>
 																</div>
 															</div>				                
															
						                				</div>
						                				
						                				<!-- Facilities Created Add / Edit -->
					                					<form action="ProjectClosureACPDetailsSubmit.htm" method="POST" name="myform5" id="myform5" >	
															<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
															<input type="hidden" name="projectId" value="<%=projectId %>" />
															<div class="row"> 
																<div class="col-md-12"  >
																	<div class="card" >
																		
																		<div class="card-body">
																	    	
																	 		<div class="row"  style="margin-left: 3%;margin-right: 2%;">
																	 			<label class="control-label">Details of Facilities Created: </label><span class="mandatory">*</span>
																				<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
																					<div id="facilitiesnote" class="center"> </div>
																					<input type="hidden" id="facilitiescreatedhidden" value="<%if(acp!=null && acp.getFacilitiesCreated()!=null) {%><%=acp.getFacilitiesCreated() %><%}%>">
																				</div>
																	  			<textarea name="facilitiesCreated" style="display:none;"></textarea>
																				<input type="hidden" name="details" value="facilitiescreated"> 
																	 			
																	 		</div>  
																	 		<div class="row"  style="margin-left: 3%;margin-right: 2%;text-align: left;">
																	 			<div class="col-md-12">
																	 				<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
																	 			</div>
																	 		</div>	
																	 		
																	 	</div>
																	 		
																	 	<div class="form-group" align="center" >
																	 		<%if(acp!=null && acp.getFacilitiesCreated()!=null) {%>
																				<button type="submit" class="btn btn-sm btn-warning btn-sm edit btn-acp" name="Action" value="Edit" onclick="return confirm('Are you sure to Update?');" >UPDATE</button>
																				
																				<button type="button" class="btn btn-sm" style="border: none;font-size:13px;margin-left: 1%;padding: 7px 10px 7px 10px;" onclick="CloseEdit('facilitiescreated')"
																				 formnovalidate="formnovalidate" data-toggle="tooltip" data-placement="top" title="Close">
																					<i class="fa fa-times fa-lg" aria-hidden="true" style="color: red;"></i>
																				</button>
																					
																			<%} else{%>
																				<button type="submit" class="btn btn-sm btn-primary btn-sm submit btn-acp" name="Action" value="Add" onclick="return confirm('Are you sure to Submit?');" >SUBMIT</button>
																			<%} %>
																		</div>
																	</div>
																		
																</div>
															</div>
														</form>
														
						                			</div>
						                			
						                			<!-- Trial Results Side bar Details -->
						                			<div class="tab-pane fade <%if(Details!=null&&Details.equalsIgnoreCase("trialresults")){ %> show active <%} %> " id="trialresults-vertical" role="tabpanel" aria-labelledby="trialresults-vertical-tab">
						                				
						                				<!-- Trial Results showing as Doc -->
						                				<div id="trialresultsdiv">
						                					<div class="row">
							                            		<div class="col-md-10" align="left">
							                            			<h4 style="font-family: 'Lato',sans-serif;color: #005086"><b>Trial Results</b></h4>
							                            		</div>
			                            	
								                   				<div class="col-md-2" style="margin-bottom: 5px">
																	<button class="share-button" style="border: none;font-size:13px" onclick="AllowEdit('trialresults')" id="" value="EDIT" >
														  				<span><i class="fa fa-pencil" aria-hidden="true"></i></span>
														  				<input type="submit"  class="edit-btn" name="sub" value="EDIT">
																	</button>
																</div>       			  	
				                            				</div>
				                            				
				                            				<hr>
				                            				
				                            				<div class="row">
				                            					<div class="col-md-12" align="left">
 																	<label style="margin-top:0px; margin-left:0px;font-weight: 800; margin-bottom:0px;	font-size: 20px; color:#07689f;">
 																		<b style="font-family: 'Lato',sans-serif;font-size: large;">Brief</b>
 																	</label>
 																</div>
				                            				</div>
				                            				<div class="row">
				                            					<div class="col-md-12" align="left">
 																	<p>
 																		<%if(acp!=null && acp.getTrialResults()!=null) {%>
 																			<%=acp.getTrialResults().replaceAll("\n", "<br>") %> 
 																		<%} %>
 																	</p>
 																</div>
 															</div>
															
															<hr>
															
															<div class="row">
				                            					<div class="col-md-12" align="left">
 																	<label style="margin-top:0px; margin-left:0px;font-weight: 800; margin-bottom:0px;	font-size: 20px; color:#07689f;">
 																		<b style="font-family: 'Lato',sans-serif;font-size: large;">Attachments</b>
 																	</label>
 																</div>
				                            				</div>
															<table id="projectdatatable" style="width:100%;" >
																<thead style = "background-color: #055C9D; color: white;text-align: center;">
																	<tr>
																		<th style="width: 5%;">SN</th>
																    	<th style="width: 75%;">Description</th>
																    	<th style="width: 20%;">Action</th>
																	</tr>
																</thead>
																<tbody>
																	<%if(trialresults!=null && trialresults.size()>0) {
																		int trialresultsslno = 0;
																		for(ProjectClosureACPTrialResults results :trialresults) {%>
																		<tr>
																			<td style="width: 5%;text-align: center;"><%=++trialresultsslno %></td>
																			
																			<td style="width: 75%;"><%=results.getDescription() %> </td>
																			<td style="width: 20%;text-align: center;">
																				<%if(results.getAttachment()!=null && !results.getAttachment().isEmpty()) {%>
																					<button type="submit" form="myform6" class="btn btn-sm" style="padding: 5px 8px;" id="attachedfile" name="attachmentfile" formmethod="post" formnovalidate="formnovalidate"
                            					 		  				 			 value="<%=results.getTrialResultsId() %>" formaction="ProjectClosureACPTrialResultsFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Attatchment Download">
                            					 										<i class="fa fa-download fa-lg"></i>
                            					 									</button>
																				<%} %>
																			</td>
																		</tr>
																	<%} }%>	
																</tbody>
															</table>		                
															
						                				</div>
						                				
						                				<!-- Trial Results Add / Edit -->
					                					<form action="ProjectClosureACPTrialResultsSubmit.htm" method="POST" name="myform6" id="myform6" enctype="multipart/form-data">	
															<input type="hidden" name="projectId" value="<%=projectId%>">
																<input type="hidden" name="details" value="trialresults" />
																<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
															<div class="row"> 
																<div class="col-md-12"  >
																	<div class="card" >
																		<div class="card-body">
																			<div class="row" style="margin-left: 2%;margin-right: 2%;">
																	        	<div class="col-md-12" style="">
																	        		<div class="form-group">
																	                	<label class="control-label">Brief:</label><span class="mandatory">*</span>
																	                    <textarea class="form-control form-control" name="trialResults" maxlength="5000" rows="3" cols="65" style="font-size: 15px;" 
					                              		  								 placeholder="Enter maximum 5000 charecters" required><%if(acp!=null && acp.getTrialResults()!=null){ %><%=acp.getTrialResults() %><%} %></textarea> 
																	                </div>
																	            </div>
											       	 						</div>
																		</div>
																		<div class="card-body">
																	    	<div class="row"  style="margin-left: 3%;margin-right: 2%;">
																	 			<label class="control-label">Attachments: </label><span class="mandatory">*</span>
																	 		</div>
																	 		
																	 		<table style="width: 94%;margin-left: 3%;" id="trialresultstable">
																				<thead style = "background-color: #055C9D; color: white;text-align: center;">
																					<tr>
																				    	<th style="width: 40%;padding: 0px 5px 0px 5px;">Description</th>
																				    	<th style="width: 25%;padding: 0px 5px 0px 5px;">Attachment</th>
																				    	<%if(acp!=null && acp.getTrialResults()!=null) {%>
																				    	<th style="width: 10%;padding: 0px 5px 0px 5px;">Action</th>
																						<%} %>
																						<td style="width: 5%;">
																							<button type="button" class=" btn btn_add_trialresults "> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button>
																						</td>
																					</tr>
																				</thead>
																				<tbody>
																					<%if(trialresults !=null && trialresults.size()>0) {
																						for(ProjectClosureACPTrialResults results :trialresults) {%>
																						<tr class="tr_clone_trialresults">
																							<td style="width: 40%;padding: 10px 5px 0px 5px;" >
																								<input type="text" class="form-control item" name="description" value="<%if(results.getDescription()!=null) {%><%=results.getDescription() %><%} %>" placeholder="Enter maximum 2000 charecters" maxlength="2000" >
																							</td>	
																							<td style="width: 25%;padding: 10px 5px 0px 5px;">
																								<input type="file" class="form-control item" name="attachment" accept=".pdf">
																								<input type="hidden" name="attatchmentname" value="<%if(results.getAttachment()!=null && !results.getAttachment().isEmpty()) {%><%=results.getAttachment() %><%} %>">
																							</td>
																							<td style="width: 10%;padding: 10px 5px 0px 5px;" id="actiontd">
																								<%if(results.getAttachment()!=null && !results.getAttachment().isEmpty()) {%>
																									<button type="submit" class="btn btn-sm" style="padding: 5px 8px;" id="attachedfile" name="attachmentfile" formmethod="post" formnovalidate="formnovalidate"
                            					 		  				 							 value="<%=results.getTrialResultsId() %>" formaction="ProjectClosureACPTrialResultsFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Attatchment Download">
                            					 														<i class="fa fa-download fa-lg"></i>
                            					 													</button>
																								<%} %>
																							</td>	
																							<td style="width: 5% ; ">
																								<button type="button" class=" btn btn_rem_trialresults " > <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>
																							</td>									
																						</tr>
																					<%} } else {%>
																						<tr class="tr_clone_trialresults">
																							<td style="width: 40%;padding: 10px 5px 0px 5px;" >
																								<input type="text" class="form-control item" name="description" placeholder="Enter maximum 2000 charecters" maxlength="2000" >
																							</td>	
																							<td style="width: 25%;padding: 10px 5px 0px 5px;">
																								<input type="file" class="form-control item" name="attachment" accept=".pdf" required>
																							</td>	
																							<td style="width: 5% ; ">
																								<button type="button" class=" btn btn_rem_trialresults " > <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>
																							</td>	
																						</tr>
																					<%} %>
																				</tbody>
																			</table>	
																	 		
																	 	</div>
																	 		
																	 	<div class="form-group" align="center" >
																	 		<%if(acp!=null && acp.getTrialResults()!=null) {%>
																				<button type="submit" class="btn btn-sm btn-warning btn-sm edit btn-acp" name="Action" value="Edit" onclick="return confirm('Are you sure to Update?');" >UPDATE</button>
																				
																				<button type="button" class="btn btn-sm" style="border: none;font-size:13px;margin-left: 1%;padding: 7px 10px 7px 10px;" onclick="CloseEdit('trialresults')"
																				 formnovalidate="formnovalidate" data-toggle="tooltip" data-placement="top" title="Close">
																					<i class="fa fa-times fa-lg" aria-hidden="true" style="color: red;"></i>
																				</button>
																					
																			<%} else{%>
																				<button type="submit" class="btn btn-sm btn-primary btn-sm submit btn-acp" name="Action" value="Add" onclick="return confirm('Are you sure to Submit?');" >SUBMIT</button>
																			<%} %>
																		</div>
																	</div>
																		
																</div>
															</div>
														</form>
						                				
						                			</div>
						                			
						                			<!-- Achievements Side bar Details -->
						                			<div class="tab-pane fade <%if(Details!=null&&Details.equalsIgnoreCase("achievements")){ %> show active <%} %> " id="achievements-vertical" role="tabpanel" aria-labelledby="achievements-vertical-tab">
						                				
						                				<!-- Achievements showing as Doc -->
						                				<div id="achievementsdiv">
						                					<div class="row">
							                            		<div class="col-md-10" align="left">
							                            			<h4 style="font-family: 'Lato',sans-serif;color: #005086"><b>Achievements (based on Aim & Objectives)</b></h4>
							                            		</div>
			                            	
								                   				<div class="col-md-2" style="margin-bottom: 5px">
																	<button class="share-button" style="border: none;font-size:13px" onclick="AllowEdit('achievements')" id="" value="EDIT" >
														  				<span><i class="fa fa-pencil" aria-hidden="true"></i></span>
														  				<input type="submit"  class="edit-btn" name="sub" value="EDIT">
																	</button>
																</div>       			  	
				                            				</div>
				                            				
				                            				<hr>
				                            				
															<div class="row">
				                            					<div class="col-md-12" align="left">
 																	<label style="margin-top:0px; margin-left:0px;font-weight: 800; margin-bottom:0px;	font-size: 20px; color:#07689f;">
 																		<b style="font-family: 'Lato',sans-serif;font-size: large;">Achievements</b>
 																	</label>
 																</div>
				                            				</div>
															<table id="projectdatatable" style="width:100%;" >
																<thead style = "background-color: #055C9D; color: white;text-align: center;">
																	<tr>
																		<th style="width: 5%;">SN</th>
																    	<th style="width: 35%;">Targets as Envisaged</th>
																    	<th style="width: 35%;">Targets as Achieved</th>
																    	<th style="width: 25%;">Remarks</th>
																	</tr>
																</thead>
																<tbody>
																	<%if(achievements!=null && achievements.size()>0) {
																		int achievementsslno = 0;
																		for(ProjectClosureACPAchievements achieve :achievements) {%>
																		<tr>
																			<td style="width: 5%;text-align: center;"><%=++achievementsslno %></td>
																			<td style="width: 35%;"><%=achieve.getEnvisaged() %> </td>
																			<td style="width: 35%;"><%=achieve.getAchieved() %> </td>
																			<td style="width: 25%;"><%=achieve.getRemarks() %> </td>
																		</tr>
																	<%} }%>	
																</tbody>
															</table>		                
															
						                				</div>
						                				
						                				<!-- Achievements Add / Edit -->
						                				<form action="ProjectClosureACPAchievementDetailsSubmit.htm" method="POST" name="myform7" id="myform7">
						                					<table style="width:100%; " id="achievementstable">
																<thead style = "background-color: #055C9D; color: white;text-align: center;">
																	<tr>
																    	<th style="width: 35%;padding: 0px 5px 0px 5px;">Targets as Envisaged</th>
																    	<th style="width: 35%;padding: 0px 5px 0px 5px;">Targets as Achieved</th>
																    	<th style="width: 25%;padding: 0px 5px 0px 5px;">Remarks</th>
																		<td style="width: 5%;">
																			<button type="button" class=" btn btn_add_achievements "> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button>
																		</td>
																	</tr>
																</thead>
																<tbody>
																	<%if(achievements !=null && achievements.size()>0) {
																		for(ProjectClosureACPAchievements achieve :achievements) {%>
																		<tr class="tr_clone_achievements">
																			<td style="width: 40%;padding: 10px 5px 0px 5px;" >
																				<input type="text" class="form-control item" name="envisaged" value="<%if(achieve.getEnvisaged()!=null) {%><%=achieve.getEnvisaged() %><%} %>" placeholder="Enter maximum 5000 characters" maxlength="5000" required="required" >
																			</td>	
																			<td style="width: 25%;padding: 10px 5px 0px 5px;">
																				<input type="text" class="form-control item" name="achieved" value="<%if(achieve.getAchieved()!=null) {%><%=achieve.getAchieved() %><%} %>" placeholder="Enter maximum 5000 characters" maxlength="5000" required="required" >
																			</td>	
																			<td style="width: 20%;padding: 10px 5px 0px 5px;">
																				<input type="text" class="form-control item" name="remarks" value="<%if(achieve.getRemarks()!=null) {%><%=achieve.getRemarks() %><%} %>" placeholder="Enter maximum 2000 characters" >
																			</td>	
																			<td style="width: 5% ; ">
																				<button type="button" class=" btn btn_rem_achievements" > <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>
																			</td>									
																		</tr>
																	<%} } else {%>
																		<tr class="tr_clone_achievements">
																			<td style="width: 40%;padding: 10px 5px 0px 5px;" >
																				<input type="text" class="form-control item" name="envisaged" placeholder="Enter maximum 5000 characters" maxlength="5000" required="required" >
																			</td>	
																			<td style="width: 25%;padding: 10px 5px 0px 5px;">
																				<input type="text" class="form-control item" name="achieved" placeholder="Enter maximum 5000 characters" maxlength="5000" required="required" >
																			</td>	
																			<td style="width: 20%;padding: 10px 5px 0px 5px;">
																				<input type="text" class="form-control item" name="remarks" placeholder="Enter maximum 2000 characters">
																			</td>
																			<td style="width: 5% ; ">
																				<button type="button" class=" btn btn_rem_achievements " > <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>
																			</td>	
																		</tr>
																	<%} %>
																</tbody>
															</table>
															<div align="center" style="margin-top: 15px;">
																
																<%if(achievements !=null && achievements.size()>0) {%>
																	<button type="submit" class="btn btn-sm btn-warning edit mt-2 btn-acp" name="Action" value="Edit" onclick="return confirm('Are you sure to update?')">UPDATE</button>
																	
																	<button type="button" class="btn btn-sm" style="border: none;font-size:13px;margin-left: 1%;padding: 7px 10px 7px 10px;margin-top: 0.5%;" onclick="CloseEdit('achievements')"
																	 formnovalidate="formnovalidate" data-toggle="tooltip" data-placement="top" title="Close">
																		<i class="fa fa-times fa-lg" aria-hidden="true" style="color: red;"></i>
																	</button>
																	
																<%} else{%> 
																	<button type="submit" class="btn btn-sm submit btn-acp" name="Action" value="Add" onclick="return confirm('Are you sure to submit?')">SUBMIT</button>
																<%} %>
																<input type="hidden" name="projectId" value="<%=projectId%>">
																<input type="hidden" name="details" value="achievements" />
																<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
																
															</div>
						                				</form>
						                				
						                			</div>	
						                			
						                			<!-- Recommendations Side bar Details -->
						                			<div class="tab-pane fade <%if(Details!=null&&Details.equalsIgnoreCase("recommendations")){ %> show active <%} %> " id="recommendations-vertical" role="tabpanel" aria-labelledby="recommendations-vertical-tab">
						                				
						                				<!-- Recommendations showing as Doc -->
						                				<div id="recommendationsdiv">
						                					<div class="row">
							                            		<div class="col-md-10" align="left">
							                            			<h4 style="font-family: 'Lato',sans-serif;color: #005086"><b>Recommendation of highest Monitoring Committee</b></h4>
							                            		</div>
			                            	
								                   				<div class="col-md-2" style="margin-bottom: 5px">
																	<button class="share-button" style="border: none;font-size:13px" onclick="AllowEdit('recommendations')" id="" value="EDIT" >
														  				<span><i class="fa fa-pencil" aria-hidden="true"></i></span>
														  				<input type="submit"  class="edit-btn" name="sub" value="EDIT">
																	</button>
																</div>       			  	
				                            				</div>
				                            				
				                            				<hr>
				                            				
															<div class="row">
				                            					<div class="col-md-2" align="left">
 																	<label style="margin-top:0px; margin-left:0px;font-weight: 800; margin-bottom:0px;	font-size: 20px; color:#07689f;">
 																		<b style="font-family: 'Lato',sans-serif;font-size: large;">Minutes of Meeting</b>
 																	</label>
 																	<form action="#">
 																		<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
																		<input type="hidden" name="projectId" value="<%=projectId %>" />
 																		<%if(acp!=null && acp.getMonitoringCommitteeAttach()!=null){ %>
				                            					 			<button type="submit" class="btn btn-sm" style="padding: 5px 8px;" name="filename" formmethod="post" formnovalidate="formnovalidate"
				                            					 		  	 value="monitoringcommitteefile" formaction="ProjectClosureACPFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Monitoring Committee Recommendations Download">
				                            					 				<i class="fa fa-download fa-lg"></i>
				                            					 			</button>
		                            					 				<%} %>
 																	</form>
 																</div>
 																<%-- <div class="col-md-6" align="left">
 																	<form action="#">
 																		<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
																		<input type="hidden" name="projectId" value="<%=projectId %>" />
 																		<%if(acp!=null && acp.getMonitoringCommitteeAttach()!=null){ %>
				                            					 			<button type="submit" class="btn btn-sm" style="padding: 5px 8px;" name="filename" formmethod="post" formnovalidate="formnovalidate"
				                            					 		  	 value="monitoringcommitteefile" formaction="ProjectClosureACPFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Monitoring Committee Recommendations Download">
				                            					 				<i class="fa fa-download fa-lg"></i>
				                            					 			</button>
		                            					 				<%} %>
 																	</form>
 																</div> --%>
				                            				</div>
				                            				
				                            				<hr>
				                            				
															<div class="row">
				                            					<div class="col-md-12" align="left">
 																	<label style="margin-top:0px; margin-left:0px;font-weight: 800; margin-bottom:0px;	font-size: 20px; color:#07689f;">
 																		<b style="font-family: 'Lato',sans-serif;font-size: large;">Recommendations</b>
 																	</label>
 																</div>
				                            				</div>
															<div class="row">
				                            					<div class="col-md-12" align="left">
 																	<p><%if(acp!=null && acp.getMonitoringCommittee()!=null) {%><%=acp.getMonitoringCommittee() %> <%} %></p>
 																</div>
 															</div>
 															
						                				</div>
						                				
						                				<!-- Recommendations Add / Edit -->
					                					<form action="ProjectClosureACPDetailsSubmit.htm" method="POST" name="myform8" id="myform8" enctype="multipart/form-data" >	
															<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
															<input type="hidden" name="projectId" value="<%=projectId %>" />
															<div class="row"> 
																<div class="col-md-12"  >
																	<div class="card" >
																		
																		<div class="card-body">
																			<div class="row mt-2"  style="margin-left: 3%;margin-right: 2%;">
																				<div class="col-md-4">
																					<label class="control-label">Minutes of Meeting: </label><span class="mandatory">*</span>
																					<%if(acp!=null && acp.getMonitoringCommitteeAttach()!=null){ %>
				                            					 						<button type="submit" class="btn btn-sm" style="padding: 5px 8px;" name="filename" formmethod="post" formnovalidate="formnovalidate"
				                            					 		  				 	value="monitoringcommitteefile" formaction="ProjectClosureACPFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Monitoring Committee Recommendations Download">
				                            					 							<i class="fa fa-download fa-lg"></i>
				                            					 						</button>
		                            					 							<%} %>
		                              		      									<input type="file" class="form-control modals" name="monitoringCommitteeAttach" <%if(acp==null || (acp!=null && acp.getMonitoringCommitteeAttach()==null)) {%>required<%} %> accept=".pdf">
																				</div>
																	 		</div>
																		</div>
																		<br>
																		<div class="card-body">
																	    	
																	 		<div class="row"  style="margin-left: 3%;margin-right: 2%;">
																	 			<label class="control-label" style="margin-left: 1%;">Recommendation of highest Monitoring Committee: </label><span class="mandatory">*</span>
																				<div class="col-md-12"  align="left" style="margin-left: 0px;width:100% " >
																					<div id="recommendationsnote" class="center"> </div>
																					<input type="hidden" id="recommendationshidden" value="<%if(acp!=null && acp.getMonitoringCommittee()!=null) {%><%=acp.getMonitoringCommittee() %><%}%>">
																				</div>
																	  			<textarea name="monitoringCommittee" style="display:none;"></textarea>
																				<input type="hidden" name="details" value="recommendations"> 
																	 			
																	 		</div>  
																	 		<div class="row"  style="margin-left: 3%;margin-right: 2%;text-align: left;">
																	 			<div class="col-md-12">
																	 				<span style="color: red;">Note:-  </span><b style="font-weight: normal;">Editor works like Ms-Word/Ms-Excel, Need to use shortcuts key ( E.g.-Next line in table cells- Shift+Enter ) </b>
																	 			</div>
																	 		</div>	
																	 		
																	 	</div>
																	 		
																	 	<div class="form-group" align="center" >
																	 		<%if(acp!=null && acp.getMonitoringCommittee()!=null) {%>
																				<button type="submit" class="btn btn-sm btn-warning btn-sm edit btn-acp" name="Action" value="Edit" onclick="return confirm('Are you sure to Update?');" >UPDATE</button>
																				
																				<button type="button" class="btn btn-sm" style="border: none;font-size:13px;margin-left: 1%;padding: 7px 10px 7px 10px;" onclick="CloseEdit('recommendations')"
																				 formnovalidate="formnovalidate" data-toggle="tooltip" data-placement="top" title="Close">
																					<i class="fa fa-times fa-lg" aria-hidden="true" style="color: red;"></i>
																				</button>
																					
																			<%} else{%>
																				<button type="submit" class="btn btn-sm btn-primary btn-sm submit btn-acp" name="Action" value="Add" onclick="return confirm('Are you sure to Submit?');" >SUBMIT</button>
																			<%} %>
																		</div>
																	</div>
																		
																</div>
															</div>
														</form>
						                				
						                			</div>
						                			
						                			<!-- Others Side bar Details -->
						                			<div class="tab-pane fade <%if(Details!=null&&Details.equalsIgnoreCase("others")){ %> show active <%} %> " id="others-vertical" role="tabpanel" aria-labelledby="others-vertical-tab">
						                    			
						                    			<!-- Others showing as Doc -->
														<div id="othersdiv">
						                					<div class="row">
							                            		<div class="col-md-10" align="left">
							                            			<h4 style="font-family: 'Lato',sans-serif;color: #005086"><b>Other Details</b></h4>
							                            		</div>
			                            	
								                   				<div class="col-md-2" style="margin-bottom: 5px">
																	<button class="share-button" style="border: none;font-size:13px" onclick="AllowEdit('others')" id="" value="EDIT" >
														  				<span><i class="fa fa-pencil" aria-hidden="true"></i></span>
														  				<input type="submit"  class="edit-btn" name="sub" value="EDIT">
																	</button>
																</div>       			  	
				                            				</div>
				                            				
				                            				<hr>
				                            				
				                            				<div class="row">
				                            					<div class="col-md-4" align="left">
				                            						<label style="margin-top:0px; margin-left:0px;font-weight: 800; margin-bottom:0px;	font-size: 20px; color:#07689f;">
				                            							<b style="font-family: 'Lato',sans-serif;font-size: large;">Expenditure Details</b>
				                            						</label>
				                            					</div>
				                            				</div>
				                            				<div class="row">
				                            					<!-- <div class="col-md-1"></div> -->
				                            					<div class="col-md-2" align="left">
				                            						As on: &emsp;<%if(acp!=null && acp.getExpndAsOn()!=null) {%><%=fc.SqlToRegularDate(acp.getExpndAsOn()) %> <%} else{%>-<%} %> 
				                            					</div>
				                            					<div class="col-md-2" align="left">
				                            						Total: &emsp;<%if(acp!=null && acp.getTotalExpnd()!=null) {%><%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(acp.getTotalExpnd())) %><%} else{%>-<%} %>
				                            					</div>
				                            					<div class="col-md-2" align="left">
				                            						Total FE: &emsp;<%if(acp!=null && acp.getTotalExpndFE()!=null) {%><%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(acp.getTotalExpndFE())) %><%} else{%>-<%} %>
				                            					</div>
				                            				</div>
				                            				
				                            				<hr>
				                            				
				                            				<div class="row">
				                            					<div class="col-md-4" align="left">
				                            						<label style="margin-top:0px; margin-left:0px;font-weight: 800; margin-bottom:0px;	font-size: 20px; color:#07689f;">
				                            							<b style="font-family: 'Lato',sans-serif;font-size: large;">Prototype Details</b>
				                            						</label>
				                            					</div>
				                            				</div>
				                            				
				                            				<div class="row">
				                            					<div class="col-md-2" align="left">
				                            						No of Prototypes: &emsp;<%if(acp!=null && acp.getPrototyes()!=0) {%><%=acp.getPrototyes() %> <%} else{%>0<%} %>
				                            					</div>
				                            				</div>
				                            				
				                            				<hr>
				                            				
															<div class="row">
				                            					<div class="col-md-12" align="left">
 																	<label style="margin-top:0px; margin-left:0px;font-weight: 800; margin-bottom:0px;	font-size: 20px; color:#07689f;">
 																		<b style="font-family: 'Lato',sans-serif;font-size: large;">Technical Report Details</b>
 																	</label>
 																</div>
				                            				</div>
															<div class="row">
				                            					<div class="col-md-12" align="left">
 																	Technical Report No.: &emsp;<%if(acp!=null && acp.getTechReportNo()!=null) {%><%=acp.getTechReportNo() %><%} else{%>-<%} %>
 																</div>
 															</div>
				                            				
				                            				<hr>
				                            				
															<div class="row">
				                            					<div class="col-md-4" align="left">
 																	<label style="margin-top:0px; margin-left:0px;font-weight: 800; margin-bottom:0px;	font-size: 20px; color:#07689f;">
 																		<b style="font-family: 'Lato',sans-serif;font-size: large;">Certificate from Lab MMG/Store Section</b>
 																	</label>
 																	<form action="#">
 																		<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
																		<input type="hidden" name="projectId" value="<%=projectId %>" />
 																		<%if(acp!=null && acp.getCertificateFromLab()!=null){ %>
				                            					 			<button type="submit" class="btn btn-sm" style="padding: 5px 8px;" name="filename" formmethod="post" formnovalidate="formnovalidate"
				                            					 		  	 value="certificatefromlabfile" formaction="ProjectClosureACPFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Certificate from Lab MMG/Store Section Download">
				                            					 				<i class="fa fa-download fa-lg"></i>
				                            					 			</button>
		                            					 				<%} %>
 																	</form>
 																</div>
				                            				</div>
				                            				
						                				</div>
						                    			
						                    			<!-- Others Add / Edit -->
						                    			<form action="ProjectClosureACPDetailsSubmit.htm" method="POST" name="myform9" id="myform9" enctype="multipart/form-data">
															<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
												    		<input type="hidden" name="projectId" value="<%=projectId%>">
												    		<input type="hidden" name="details" value="others">
												    		<div class="row" style="margin-left: 2%;margin-right: 2%;">
												    				
												    			<div class="col-md-2" style="">
														        	<div class="form-group">
														                <label class="control-label">Expenditure as on:</label><span class="mandatory">*</span>
														                	<input  class="form-control form-control" type="text" name="expndAsOn" id="expndAsOn"
														                     value="<%if(acp!=null && acp.getExpndAsOn()!=null) {%><%=fc.SqlToRegularDate(acp.getExpndAsOn()) %><%} %>" readonly style="background: #fff;" > 
														            </div>
												            	</div>
													        	<div class="col-md-2" style="">
													        		<div class="form-group">
													                	<label class="control-label">Total Expenditure (<span style="font-size: 14px;">&#x20B9;</span>):</label><span class="mandatory">*</span>
													                    <input  class="form-control form-control" type="number" step="0.01" name="totalExpnd" placeholder="Enter Total Expenditure" maxlength="15"
													                     value="<%if(acp!=null && acp.getTotalExpnd()!=null) {%><%=acp.getTotalExpnd() %><%} %>" required> 
													                </div>
													            </div>
													        	<div class="col-md-2" style="">
													        		<div class="form-group">
													                	<label class="control-label">Total FE Expenditure (<span style="font-size: 14px;">&#x20B9;</span>):</label><span class="mandatory">*</span>
													                    <input  class="form-control form-control" type="number" step="0.01" name="totalExpndFE" placeholder="Enter Total Expenditure FE" maxlength="15"
													                     value="<%if(acp!=null && acp.getTotalExpndFE()!=null) {%><%=acp.getTotalExpndFE() %><%} %>" required> 
													                </div>
													            </div>
													            <div class="col-md-2">
													            	<div class="form-group">
													                	<label class="control-label">No of Prototypes:</label><span class="mandatory">*</span>
													                    <input  class="form-control form-control" type="number" name="noofprototypes" placeholder="Enter No of Prototypes" maxlength="10"
													                     value="<%if(acp!=null && acp.getPrototyes()!=0) {%><%=acp.getPrototyes() %><%} %>" required> 
													                </div>
													            </div>
														            
													            <div class="col-md-2">
													            	<div class="form-group">
													                	<label class="control-label">Tech Report No:</label><span class="mandatory">*</span>
													                    <input  class="form-control form-control" type="text" name="techReportNo" placeholder="Enter Technical Report No" maxlength="100"
													                     value="<%if(acp!=null && acp.getTechReportNo()!=null) {%><%=acp.getTechReportNo() %><%} %>" required> 
													                </div>
													            </div>
												    		</div>
											    			<div class="row" style="margin-left: 2%;margin-right: 2%;">
											    				<div class="col-md-4">
													            	<div class="form-group">
											                			<label class="control-label">Certificate from Lab MMG / Store Section:</label><span class="mandatory">*</span>
													                	<%if(acp!=null && acp.getCertificateFromLab()!=null){ %>
	                            					 						<button type="submit" class="btn btn-sm" style="padding: 5px 8px;" name="filename" formmethod="post" formnovalidate="formnovalidate"
	                            					 		  				 	value="labcertificatefile" formaction="ProjectClosureACPFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Certifciate from Lab Download">
	                            					 							<i class="fa fa-download fa-lg"></i>
	                            					 						</button>
	                            					 					<%} %>
                             		      								<input type="file" class="form-control modals" name="labCertificateAttach" <%if(acp==null || (acp!=null && acp.getCertificateFromLab()==null)) {%>required<%} %> accept=".pdf">
											                		</div>
													            </div>
											    			</div>
											    			<div align="center">
											    				<%if(acp!=null && acp.getExpndAsOn()!=null){ %>
																	<button type="submit" class="btn btn-sm btn-warning edit btn-acp" name="Action" value="Edit" onclick="return confirm('Are you sure to update?')" >UPDATE</button>
																	
																	<button type="button" class="btn btn-sm" style="border: none;font-size:13px;margin-left: 1%;padding: 7px 10px 7px 10px;" onclick="CloseEdit('others')"
																	 formnovalidate="formnovalidate" data-toggle="tooltip" data-placement="top" title="Close">
																		<i class="fa fa-times fa-lg" aria-hidden="true" style="color: red;"></i>
																	</button>
																<%}else{ %>
																	<button type="submit" class="btn btn-sm btn-success submit btn-acp" name="Action" value="Add" onclick="return confirm('Are you sure to submit?')" >SUBMIT</button>
																<%} %>
											    			</div>
												    	</form>
                                			
													</div>
						                		</div>
						        			</div>
						        		</div>
						        	</div>
						        </div>
						        <div style="display: flex;justify-content: space-between;">
               						<div></div>
		               				<div class="navigation_btn"  style="text-align: center;">
		               					<%if( (subprojects!=null && subprojects.size()>0) && (carscapsiprojects!=null && carscapsiprojects.size()>0) && (consultancies!=null && consultancies.size()>0) &&
		                 						  (trialresults!=null && trialresults.size()>0) && (achievements!=null && achievements.size()>0) &&
		                   						  (acp!=null && acp.getACPAim()!=null && acp.getFacilitiesCreated()!=null && acp.getMonitoringCommittee()!=null && acp.getExpndAsOn()!=null) ){ %>
				               				<form action="#">
				               					<button type="submit" class="btn btn-sm " formaction="ProjectClosureACPDownload.htm" formtarget="_blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="Administrative closure Download" 
				               					 style="background-color: purple;border: none;color: white;font-weight: bold;">
				               						Print Administrative Closure
				               					</button>
				               					<input type="hidden" name="projectId" value="<%=projectId%>">
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				               				</form>
			               				<%} %>
									</div>
		               				<div class="navigation_btn"  style="text-align: right;">
            							<a class="btn btn-info btn-sm  shadow-nohover back" href="ProjectClosureList.htm" style="color: white!important">Back</a>
										<button class="btn btn-info btn-sm next">Next</button>
									</div>
               					</div>			
               					
               			<%if(acpTabId!=null && acpTabId.equalsIgnoreCase("1")){ %> 
         					</div>
         				<%}else{ %>
              				</div>
               			<%} %>
               			
               			<!-- *********** Administrative Closure Forward ***********      --> 
               			<%if(acpTabId!=null && acpTabId.equalsIgnoreCase("2")){ %> 
         					<div class="tab-pane active" id="acpforward" role="tabpanel">
         				<%}else{ %>
              				<div class="tab-pane " id="acpforward" role="tabpanel">
               			<%} %>
               					<%if( (subprojects!=null && subprojects.size()>0) && (carscapsiprojects!=null && carscapsiprojects.size()>0) && (consultancies!=null && consultancies.size()>0) &&
               						  (trialresults!=null && trialresults.size()>0) && (achievements!=null && achievements.size()>0) &&
               						  (acp!=null && acp.getACPAim()!=null && acp.getFacilitiesCreated()!=null && acp.getMonitoringCommittee()!=null && acp.getExpndAsOn()!=null) ) {%>
               					
               						<div class="col-md-8 mt-2">
               							<div class="card" style="border: 1px solid rgba(0,0,0,.125);margin-left: 25%; <%if(isApproval==null) {%>max-height: 600px;<%} else{%>max-height: 700px;<%} %>  overflow-y: auto;">
               								<div class="card-body mt-2 ml-4">
               									<form action="#">
               										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                   									<input type="hidden" name="projectId" value="<%=projectId%>">
                   									<div class="mt-2" align="center">
			               								<h5 style="font-weight: bold;margin-top: 1.5rem;">
				               								AUDIT OF STATEMENT OF ACCOUNTS (EXPENDITURE) AND ADMINISTRATIVE CLOSURE OF PROJECT / PROGRAMME
			               								 </h5>
			               								 <h5 style="font-weight: bold;">Part - I</h5>
			               							</div>
			               							<%int slno=0; %>
    												<table id="tabledata">
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">Name of Lab</td>
												    		<td>: <%=labcode %> </td>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">Title of the Project/Programme</td>
												    		<td>: <%=projectMaster.getProjectName() %> </td>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">Date of Sanction</td>
												    		<td>: <%if(projectMaster!=null && projectMaster.getSanctionDate()!=null) {%><%=fc.SqlToRegularDate(projectMaster.getSanctionDate().toString()) %><%} else{%><%} %></td>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">Category of Project</td>
												    		<td>: <%if(potherdetails!=null && potherdetails[0]!=null) {%><%=potherdetails[0] %><%} %> </td>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td colspan="1" style="width: 40%;">Cost (original & revised)</td>
												    		<td>:</td>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"></td>
												    		<td colspan="">
												    			<table id="projectdatatablep" style="width: 100%;/* margin-left: 2%; */" >
																	<thead style = "/* background-color: #055C9D; color: white; */text-align: center;">
																		<tr>
																	    	<th style="width: 20%;">Cost (&#8377;)</th>
																	    	<th style="width: 40%;">Original</th>
																	    	<th style="width: 40%;">Revised</th>
																		</tr>
																	</thead>
																	<tbody>
																		<tr>
																			<td>RE</td>
																			<td style="text-align: right;">
																				<%if(potherdetails!=null && potherdetails[1]!=null) {%>
																					<%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(potherdetails[1].toString())) %>
																				<%} else{%>
																					--
																				<%} %>
																			</td>
																			<td style="text-align: right;">
																				<%if(potherdetails!=null && potherdetails[4]!=null) {%>
																					<%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(potherdetails[4].toString())) %>
																				<%} else{%>
																					--
																				<%} %>
																			</td>
																		</tr>
																		<tr>
																			<td>FE</td>
																			<td style="text-align: right;">
																				<%if(potherdetails!=null && potherdetails[2]!=null) {%>
																					<%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(potherdetails[2].toString())) %>
																				<%} else{%>
																					--
																				<%} %>
																			</td>
																			<td style="text-align: right;">
																				<%if(potherdetails!=null && potherdetails[5]!=null) {%>
																					<%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(potherdetails[5].toString())) %>
																				<%} else{%>
																					--
																				<%} %>
																			</td>
																		</tr>
																		<tr>
																			<td>Total (FE)</td>
																			<td style="text-align: right;">
																				<%if(potherdetails!=null && potherdetails[3]!=null) {%>
																					<%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(potherdetails[3].toString())) %>
																				<%} else{%>
																					--
																				<%} %>
																			</td>
																			<td style="text-align: right;">
																				<%if(potherdetails!=null && potherdetails[6]!=null) {%>
																					<%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(potherdetails[6].toString())) %>
																				<%} else{%>
																					--
																				<%} %>
																			</td>
																		</tr>
																	</tbody>
																</table>
												    		</td>
												    		<td></td>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">PDC of the Project</td>
												    		<td>:</td>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"></td>
												    		<td style="width: 40%;">
												    			<table id="projectdatatablep" style="width: 100%;/* margin-left: 2%; */" >
																	<thead style = "/* background-color: #055C9D; color: white; */text-align: center;">
																		<tr>
																	    	<th style="width: 30%;">Original</th>
																	    	<th style="width: 30%;">Revised</th>
																	    	<th style="width: 40%;">No of Revisions</th>
																		</tr>
																	</thead>
																	<tbody>
																		<tr>
																			<td style="text-align: center;">
																				<%if(potherdetails!=null && potherdetails[7]!=null) {%>
																					<%=fc.SqlToRegularDate(potherdetails[7].toString()) %>
																				<%} else{%>
																					--
																				<%} %>
																			</td>
																			<td style="text-align: center;">
																				<%if(potherdetails!=null && potherdetails[8]!=null) {%>
																					<%=fc.SqlToRegularDate(potherdetails[8].toString()) %>
																				<%} else{%>
																					--
																				<%} %>
																			</td>
																			<td style="text-align: center;">
																				<%if(potherdetails!=null && potherdetails[9]!=null) {%>
																					<%=potherdetails[9] %>
																				<%} %>
																			</td>
																		</tr>
																	</tbody>
																</table>
												    		</td>
												    		<td></td>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">Expenditure ( as on <%if(acp.getExpndAsOn()!=null) {%><%=fc.SqlToRegularDate(acp.getExpndAsOn()) %> <%} else{%>-<%} %> )</td>
												    		<td>
												    			: Total(<span style="font-size: 12px;">&#x20B9;</span>)
												    				<span style="text-decoration: underline;">
												    					<%if(acp.getTotalExpnd()!=null) {%><%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(acp.getTotalExpnd())) %> <%} %>
												    				</span>
												    			 (FE<span style="text-decoration: underline;">
												    					<%if(acp.getTotalExpndFE()!=null) {%><%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(acp.getTotalExpndFE())) %> <%} %>
												    				</span>)	
												    		</td>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">Aim & Objectives</td>
												    		<td>: <%if(acp.getACPAim()!=null) {%><%=acp.getACPAim() %><%} %> <br>
												    			  <%if(acp.getACPObjectives()!=null) {%><%=acp.getACPObjectives() %> <%} %>
												    		</td>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">No of Prototypes</td>
												    		<td>: <%if(acp.getPrototyes()!=0) {%><%=acp.getPrototyes() %><%} %> </td>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">List of sub-projects</td>
												    		<td>: </td>
												    	</tr>
												    	<tr>
												    		<td colspan="3">
												    			<table id="projectdatatablep" style="width: 95%;margin-left: 2%;" >
																	<thead style = "/* background-color: #055C9D; color: white; */text-align: center;">
																		<tr>
																			<th style="width: 5%;">SN</th>
																	    	<th style="width: 15%;">Projects Name</th>
																	    	<th style="width: 10%;">Project No</th>
																	    	<th style="width: 15%;">Agency</th>
																	    	<th style="width: 10%;">Cost (&#8377;)</th>
																	    	<th style="width: 20%;">Status</th>
																	    	<th style="">Achievement</th>
																		</tr>
																	</thead>
																	<tbody>
																		<%if(subprojects!=null && subprojects.size()>0) {
																			int subprojectslno = 0;
																			for(ProjectClosureACPProjects sub :subprojects) {%>
																			<tr>
																				<td style="width: 5%;text-align: center;"><%=++subprojectslno %></td>
																				<td style="width: 15%;"><%=sub.getACPProjectName() %> </td>
																				<td style="width: 10%;text-align: center;"><%=sub.getACPProjectNo() %> </td>
																				<td style="width: 15%;"><%=sub.getProjectAgency() %> </td>
																				<td style="width: 10%;text-align: right;"><%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(sub.getProjectCost())) %> </td>
																				<td style="width: 20%;"><%=sub.getProjectStatus() %> </td>
																				<td style=""><%=sub.getProjectAchivements() %> </td>
																			</tr>
																		<%} }%>	
																	</tbody>
																</table>
												    		</td>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">List of CARS / CAPSI</td>
												    		<td>: </td>
												    	</tr>
												    	<tr>
												    		<td colspan="3">
												    			<table id="projectdatatablep" style="width: 95%;margin-left: 2%;" >
																	<thead style = "/* background-color: #055C9D; color: white; */text-align: center;">
																		<tr>
																			<th style="width: 5%;">SN</th>
																	    	<th style="width: 5%;">CARS / CAPSI</th>
																	    	<th style="width: 15%;">CARS / CAPSI Name</th>
																	    	<th style="width: 10%;">CARS / CAPSI No</th>
																	    	<th style="width: 15%;">Agency</th>
																	    	<th style="width: 10%;">Cost (&#8377;)</th>
																	    	<th style="width: 15%;">Status</th>
																	    	<th style="width: 15%;">Achievement</th>
																		</tr>
																	</thead>
																	<tbody>
																		<%if(carscapsiprojects !=null && carscapsiprojects.size()>0) {
																			int carscapsiprojectslno = 0;
																			for(ProjectClosureACPProjects carscapsi :carscapsiprojects) {%>
																			<tr>
																				<td style="width: 5%;text-align: center;"><%=++carscapsiprojectslno %></td>
																				<td style="width: 5%;">
																					<%if(carscapsi.getACPProjectType()!=null && carscapsi.getACPProjectType().equalsIgnoreCase("R")) {%>
																						CARS
																					<%} else{%>
																						CAPSI
																					<%} %>
																				</td>
																				<td style="width: 15%;"><%=carscapsi.getACPProjectName() %> </td>
																				<td style="width: 10%;text-align: center;"><%=carscapsi.getACPProjectNo() %> </td>
																				<td style="width: 15%;"><%=carscapsi.getProjectAgency() %> </td>
																				<td style="width: 10%;text-align: right;"><%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(carscapsi.getProjectCost())) %> </td>
																				<td style="width: 20%;"><%=carscapsi.getProjectStatus() %> </td>
																				<td style="width: 15%;"><%=carscapsi.getProjectAchivements() %> </td>
																			</tr>
																		<%} }%>	
																	</tbody>
																</table>
												    		</td>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">List of Consultancies</td>
												    		<td>: </td>
												    	</tr>
												    	<tr>
												    		<td colspan="3">
												    			<table id="projectdatatablep" style="width: 95%;margin-left: 2%;" >
																<thead style = "/* background-color: #055C9D; color: white; */text-align: center;">
																	<tr>
																		<th style="width: 5%;">SN</th>
																    	<th style="width: 35%;">Aim</th>
																    	<th style="width: 25%;">Agency</th>
																    	<th style="width: 20%;">Amount (&#8377;)</th>
																    	<th style="width: 10%;">Date</th>
																	</tr>
																</thead>
																<tbody>
																	<%if(consultancies !=null && consultancies.size()>0) {
																		int consultancieslno = 0;
																		for(ProjectClosureACPConsultancies consultancy :consultancies) {%>
																		<tr>
																			<td style="width: 5%;text-align: center;"><%=++consultancieslno %></td>
																			<td style="width: 35%;"><%=consultancy.getConsultancyAim() %> </td>
																			<td style="width: 25%;"><%=consultancy.getConsultancyAgency() %> </td>
																			<td style="width: 20%;text-align: right;"><%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(consultancy.getConsultancyCost())) %> </td>
																			<td style="width: 10%;text-align: center;"><%=fc.SqlToRegularDate(consultancy.getConsultancyDate()) %> </td>
																		</tr>
																	<%} }%>	
																</tbody>
															</table>
												    		</td>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">Details of Facilities created (as proposed in the programme) </td>
												    		<td>: </td>
												    	</tr>
												    	<tr>
												    		<td colspan="3">
												    			<span><%if(acp.getFacilitiesCreated()!=null) {%><%=acp.getFacilitiesCreated() %><%} %></span>
												    		</td>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">Trial Results </td>
												    		<td>: </td>
												    	</tr>
												    	<tr>
												    		<td colspan="1"></td>
												    		<td colspan="2">
												    			<span><%if(acp.getTrialResults()!=null) {%><%=acp.getTrialResults() %><%} %></span>
												    		</td>
												    	</tr>
												    	<tr>
												    		<td colspan="3">
												    			<table id="projectdatatablep" style="width: 95%;margin-left: 2%;" >
																	<thead style = "/* background-color: #055C9D; color: white; */text-align: center;">
																		<tr>
																			<th style="width: 5%;">SN</th>
																	    	<th style="width: 70%;">Description</th>
																	    	<th style="width: 20%;">Action</th>
																		</tr>
																	</thead>
																	<tbody>
																		<%if(trialresults!=null && trialresults.size()>0) {
																			int trialresultsslno = 0;
																			for(ProjectClosureACPTrialResults results :trialresults) {%>
																			<tr>
																				<td style="width: 5%;text-align: center;"><%=++trialresultsslno %></td>
																				
																				<td style="width: 70%;"><%=results.getDescription() %> </td>
																				<td style="width: 20%;text-align: center;">
																					<%if(results.getAttachment()!=null && !results.getAttachment().isEmpty()) {%>
																						<button type="submit" form="myform6" class="btn btn-sm" style="padding: 5px 8px;" id="attachedfile" name="attachmentfile" formmethod="post" formnovalidate="formnovalidate"
	                            					 		  				 			 value="<%=results.getTrialResultsId() %>" formaction="ProjectClosureACPTrialResultsFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Attatchment Download">
	                            					 										<i class="fa fa-download fa-lg"></i>
	                            					 									</button>
																					<%} %>
																				</td>
																			</tr>
																		<%} }%>	
																	</tbody>
																</table>
												    		</td>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">Achievements</td>
												    		<td>: </td>
												    	</tr>
												    	<tr>
												    		<td colspan="3">
												    			<table id="projectdatatablep" style="width: 95%;margin-left: 2%;" >
																	<thead style = "/* background-color: #055C9D; color: white; */text-align: center;">
																		<tr>
																			<th style="width: 5%;">SN</th>
																	    	<th style="width: 32.5%;">Targets as Envisaged</th>
																	    	<th style="width: 32.5%;">Targets as Achieved</th>
																	    	<th style="width: 25%;">Remarks</th>
																		</tr>
																	</thead>
																	<tbody>
																		<%if(achievements!=null && achievements.size()>0) {
																			int achievementsslno = 0;
																			for(ProjectClosureACPAchievements achieve :achievements) {%>
																			<tr>
																				<td style="width: 5%;text-align: center;"><%=++achievementsslno %></td>
																				<td style="width: 32.5%;"><%=achieve.getEnvisaged() %> </td>
																				<td style="width: 32.5%;"><%=achieve.getAchieved() %> </td>
																				<td style="width: 25%;"><%=achieve.getRemarks() %> </td>
																			</tr>
																		<%} }%>	
																	</tbody>
																</table>
												    		</td>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td colspan="2" style="width: 40%;">Recommendation of highest Monitoring Committee Meeting for Administrative Closure of the Project</td>
												    	</tr>
												    	<tr>
												    		<td colspan="1"></td>
												    		<td colspan="2">
												    			<span>
												    				<%if(acp.getMonitoringCommittee()!=null) {%><%=acp.getMonitoringCommittee() %><%} %>
												    				<%if(acp!=null && acp.getMonitoringCommitteeAttach()!=null){ %>
					                            						<button type="submit" class="btn btn-sm" style="padding: 5px 8px;" name="filename" formmethod="post" formnovalidate="formnovalidate"
					                            					 	 value="monitoringcommitteefile" formaction="ProjectClosureACPFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Monitoring Committee Recommendations Download">
					                            					 		<i class="fa fa-download"></i>
					                            					 	</button>
		                            					 			<%} %>
												    			</span>
												    		</td>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td colspan="2" style="width: 40%;">Certificate from Lab MMG/Store Section stating no outstanding commitment, no live supply order or contracts & warranty is enclosed. List of payments, to be made due to contractual obligation be enclosed. </td>
												    	</tr>
												    	<tr>
												    		<td colspan="1"></td>
												    		<td colspan="2">
												    			<%if(acp!=null && acp.getCertificateFromLab()!=null){ %>
	                            					 				<button type="submit" class="btn btn-sm" style="padding: 5px 8px;" name="filename" formmethod="post" formnovalidate="formnovalidate"
	                            					 		  		 value="labcertificatefile" formaction="ProjectClosureACPFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Certifciate from Lab Download">
	                            					 					<i class="fa fa-download"></i>
	                            					 				</button>
	                            					 			<%} %>
												    		</td>
												    	</tr>
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td style="width: 40%;">Certified that objectives set for the project have been met as per Technical Report No.</td>
												    		<td>: <%if(acp.getTechReportNo()!=null) {%><%=acp.getTechReportNo() %><%} %> </td>
												    	</tr>
												    </table>
												    
												    <br>
			               		   					
			               		   					<!-- Signature and timestamp of PD -->
			               		   					
													<div style="width: 96%;text-align: right;margin-right: 10px;line-height: 10px;margin-top: 30px;">
		               								 	<div style="font-size: 15px;">Project Director</div>
						               					<%for(Object[] apprInfo : acpApprovalEmpData){ %>
						   			   					<%if(apprInfo[8].toString().equalsIgnoreCase("AFW")){ %>
						   								<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
						   								<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
						   								<label style="font-size: 12px; ">[Forwarded On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
						   			    				<%break;}} %>  
							            			</div>
							            			
							            			<!-- Signature and timestamp of Recommending officers -->
							            			<%for(Object[] apprInfo : acpApprovalEmpData) {%>
							            			 	<div style="width: 96%;text-align: left;margin-left: 10px;line-height: 10px;margin-top: 50px;margin-left: 40px;">
							            			 		<%if(apprInfo[8].toString().equalsIgnoreCase("AAG")){ %>
							            			 			<div style="font-size: 15px;"> Signature of GD</div>
								   								<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
								   								<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
								   								<label style="font-size: 12px; ">[Recommended On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
							   			    				<%} else if(apprInfo[8].toString().equalsIgnoreCase("AAA")) {%> 
							   			    					<div style="font-size: 15px;"> Signature of AD</div>
							   			    					<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
								   								<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
								   								<label style="font-size: 12px; ">[Recommended On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
							   			    				<%} else if(apprInfo[8].toString().equalsIgnoreCase("AAP")) {%> 
							   			    					<div style="font-size: 15px;"> Signature of GD-DP&C</div>
							   			    					<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
								   								<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
								   								<label style="font-size: 12px; ">[Recommended On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
							   			    				
							   			    				<%} %>
							            			 	</div>	
							            			 <%} %>
							            			
							            			<br>
							            			<hr style="height: 1px;background-color: black;">
							            			<br>
							            			
							            			<div class="" align="center">
			               								 <h5 style="font-weight: bold;">Part - II</h5>
			               								 <h5 style="font-weight: bold;">
				               								Statement of Accounts (Expenditure)
			               								 </h5>
			               							</div>
			               							
			               							<table id="tabledata">
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td colspan="2" style="">
												    			It is certified that the project
												    			<%if(projectMaster!=null) {%>
												    				<%if(projectMaster.getProjectName()!=null) {%><%=projectMaster.getProjectName() %><%} %>
												    				(<%if(projectMaster.getProjectShortName()!=null) {%><%=projectMaster.getProjectShortName() %> <%} %>)
												    			
												    			 No. <%if(projectMaster.getSanctionNo()!=null) {%><%=projectMaster.getSanctionNo() %> <%} %>
												    			 has incurred the expenditure of 
												    			 <%if(acp.getTotalExpnd()!=null) {%><%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(acp.getTotalExpnd())) %><%} %>
												    			 including FE
												    			 <%if(acp.getTotalExpndFE()!=null) {%><%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(acp.getTotalExpndFE())) %><%} %>
																 against the sanctioned cost of
																 <%if(projectMaster.getTotalSanctionCost()!=null) {%><%=IndianRupeeFormat.getRupeeFormat(projectMaster.getTotalSanctionCost()) %><%} %>
																 including FE
																 <%if(projectMaster.getSanctionCostFE()!=null) {%><%=IndianRupeeFormat.getRupeeFormat(projectMaster.getSanctionCostFE()) %><%} %>
																 as per the enclosed Audited Statement of Expenditure.
																<%} %>
																<br><br>
																<span style="margin-left: 5%;">All the stores/equipment undertaken in the project has been accounted for.</span>
												    			
												    		</td>
												    	</tr>
			               							</table>
			               							<br>
			               		   					
			               		   					<!-- Signature and timestamp of Lab Accounts Officer -->
			               		   					
													<div style="width: 96%;text-align: right;margin-right: 10px;line-height: 10px;margin-top: 30px;">
		               								 	<div style="font-size: 15px;">(Lab Accounts Officer or equivalent)</div>
						               					<%for(Object[] apprInfo : acpApprovalEmpData){ %>
						   			   					<%if(apprInfo[8].toString().equalsIgnoreCase("AAL")){ %>
						   								<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
						   								<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
						   								<label style="font-size: 12px; ">[Approved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
						   			    				<%break;}} %>  
							            			</div>
							            			
			               							<br>
							            			<hr style="height: 1px;background-color: black;">
							            			<br>
							            			
							            			<div class="" align="center">
			               								 <h5 style="font-weight: bold;">Part - III</h5>
			               								 <h5 style="font-weight: bold;">
				               								The Statement of Accounts (Expenditure) of the project has been audited and reconciled.
			               								 </h5>
			               							</div>
			               							
			               							<br><br><br>
			               							<div class="" align="center">
			               								<span>Audit Authorities</span> <br>
			               								<span>(Local Audit Officer / CDA R&D)</span> <br>
			               								<span>(Signature with name and office seal)</span>
			               							</div>
			               							
			               							<br>
							            			<hr style="height: 1px;background-color: black;">
							            			<br>
							            			
							            			<!-- Signature and timestamp of Approving officers -->
							            			<%for(Object[] apprInfo : acpApprovalEmpData) {%>
							            			 	<div style="width: 96%;text-align: left;margin-left: 40px;line-height: 10px;margin-top: 50px;">
							            			 		<%if(apprInfo[8].toString().equalsIgnoreCase("AAD")){ %>
							            			 			<div style="font-size: 15px;"> Signature of Director</div>
								   								<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
								   								<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
								   								<label style="font-size: 12px; ">[Approved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
							   			    				<%} else if(apprInfo[8].toString().equalsIgnoreCase("AAO")) {%> 
							   			    					<div style="font-size: 15px;"> Signature of O/o DG (ECS)</div>
							   			    					<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
								   								<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
								   								<label style="font-size: 12px; ">[Approved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10)) %>]</label>
								   							<%} else if(apprInfo[8].toString().equalsIgnoreCase("AAN")) {%> 
							   			    					<div style="font-size: 15px;"> Signature of DG (Nodal)</div>
							   			    					<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
								   								<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
								   								<label style="font-size: 12px; ">[Approved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10)) %>]</label>	
							   			    				<%} else if(apprInfo[8].toString().equalsIgnoreCase("AAC")) {%> 
							   			    					<div style="font-size: 15px;"> Signature of CFA</div>
							   			    					<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
								   								<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
								   								<label style="font-size: 12px; ">[Approved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10)) %>]</label>
							   			    				
							   			    				<%} %>
							            			 	</div>	
							            			 <%} %>
							            			 
							            			 <br>
							            			 
							            			 <table id="tabledata">
												    	<tr>
												    		<td style="width: 4%;"><%=++slno %>.</td>
												    		<td colspan="2" style="">
												    			Expenditure Status 
												    		</td>
												    	</tr>
												    	<tr>
												    		<!-- <td style="width: 4%;"></td> -->
												    		<td colspan="3">
												    			<%-- <%
												    			if(projectidlist!=null && projectidlist.size()>0) {
												    			for (int z = 0; z < projectidlist.size(); z++) { %> --%>
												    			<table id="projectdatatablep" style="width: 95%;margin-left: 2%;" >
																	<thead style = "/* background-color: #055C9D; color: white; */text-align: center;">
																		<tr>
																			<th colspan="2" style="text-align: center; width: 200px !important;">Head </th>
																			<th colspan="3" style="text-align: center; width: 120px !important;">Sanction </th>
																			<th colspan="3" style="text-align: center; width: 120px !important;">Expenditure </th>
																			<th colspan="3" style="text-align: center; width: 120px !important;">O/s Commitments </th>
																			<th colspan="3" style="text-align: center; width: 120px !important;">Balance </th>
																			<!-- <th colspan="2" style="text-align: center; width: 120px !important;">DIPL </th>
																			<th colspan="2" style="text-align: center; width: 120px !important;">Notional Balance </th> -->
																		</tr>
																		<tr>
																			<th style="width: 30px !important; text-align: center;">SN</th>
																			<th style="width: 180px !important;" width="10">Head</th>
																			<th>IC</th>
																			<th>FE</th>
																			<th>Total</th>
																			<th>IC</th>
																			<th>FE</th>
																			<th>Total</th>
																			<th>IC</th>
																			<th>FE</th>
																			<th>Total</th>
																			<th>IC</th>
																			<th>FE</th>
																			<th>Total</th>
																			<!-- <th>IC</th>
																			<th>FE</th>
																			<th>IC</th>
																			<th>FE</th> -->
																		</tr>
																	</thead>
																	<tbody>
																		<%
																		double totSanctionCost = 0, totReSanctionCostCap = 0, totFESanctionCostCap = 0, totReFESantionCostCap = 0, totReSanctionCostRev = 0, totFESanctionCostRev = 0, totReFESantionCostRev = 0;
																		double totExpenditure = 0, totREExpenditureCap = 0, totFEExpenditureCap = 0, totReFEExpenditureCap = 0, totREExpenditureRev = 0, totFEExpenditureRev = 0, totReFEExpenditureRev = 0 ;
																		double totCommitment = 0, totRECommitmentCap = 0, totFECommitmentCap = 0, totReFECommitmentCap = 0, totRECommitmentRev = 0, totFECommitmentRev= 0, totReFECommitmentRev = 0;
																		double totBalance = 0, btotalReCap = 0, btotalFeCap = 0, totReFeBalanceCap = 0, btotalReRev = 0, btotalFeRev = 0, totReFeBalanceRev = 0;
																		
																		int count = 1;
																		if (projectFinancialDetails != null && projectFinancialDetails.size() > 0 && projectFinancialDetails.get(0) != null) {
																			List <ProjectFinancialDetails> revenue = projectFinancialDetails.get(0).stream().filter(e -> e.getBudgetHeadId()==1).collect(Collectors.toList());
																			List <ProjectFinancialDetails> capital = projectFinancialDetails.get(0).stream().filter(e -> e.getBudgetHeadId()==2).collect(Collectors.toList());
																		%>
																		
																		<!-- Revenue -->
																		<%if(revenue!=null && capital.size()>0) {
																			int i=0;
																			for (ProjectFinancialDetails projectFinancialDetail : revenue) {
																		%>
																		<tr>
																			<td align="center" style="max-width: 50px !important; text-align: center;"><%=count++%></td>
																			<%-- <%if(i++==0) {%> 
																				<td rowspan="<%=revenue.size()+1%>" style="transform : rotate(270deg); width : 4%; text-align: center;" >
																			 		REVENUE
																			 	</td>
																			<%} %> --%>
																			<td style=""><b><%=projectFinancialDetail.getBudgetHeadDescription()%></b></td>
																			<!-- Sanction Cost -->
																			<!-- IC -->
																			<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getReSanction())%></td>
																			<% totReSanctionCostRev += (projectFinancialDetail.getReSanction()); %>
																			<!-- FE -->
																			<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getFeSanction())%></td>
																			<% totFESanctionCostRev += (projectFinancialDetail.getFeSanction()); %>
																			<!-- Total -->
																			<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getReSanction() + projectFinancialDetail.getFeSanction()) %> </td>
																			<% totReFESantionCostRev +=projectFinancialDetail.getReSanction() + projectFinancialDetail.getFeSanction();%>
																			
																			<!-- Expenditure Cost -->
																			<!-- IC -->
																			<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getReExpenditure())%></td>
																			<% totREExpenditureRev += (projectFinancialDetail.getReExpenditure()); %>
																			<!-- FE -->
																			<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getFeExpenditure())%></td>
																			<% totFEExpenditureRev += (projectFinancialDetail.getFeExpenditure()); %>
																			<!-- Total -->
																			<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getReExpenditure() + projectFinancialDetail.getFeExpenditure())%></td>
																			<% totReFEExpenditureRev += (projectFinancialDetail.getReExpenditure() + projectFinancialDetail.getFeExpenditure()); %>
																			
																			<!-- O/s Commitments Cost -->
																			<!-- IC -->
																			<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getReOutCommitment())%></td>
																			<% totRECommitmentRev += (projectFinancialDetail.getReOutCommitment()); %>
																			<!-- FE -->
																			<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getFeOutCommitment() )%></td>
																			<% totFECommitmentRev += (projectFinancialDetail.getFeOutCommitment() ); %>
																			<!-- Total -->
																			<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getReOutCommitment() + projectFinancialDetail.getFeOutCommitment())%></td>
																			<% totReFECommitmentRev += (projectFinancialDetail.getReOutCommitment() + projectFinancialDetail.getFeOutCommitment()); %>
																			
																			<!-- Balance Cost -->
																			<!-- IC -->
																			<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getReBalance() + projectFinancialDetail.getReDipl())%></td>
																			<% btotalReRev += (projectFinancialDetail.getReBalance() + projectFinancialDetail.getReDipl()); %>
																			<!-- FE -->
																			<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getFeBalance() + projectFinancialDetail.getFeDipl())%></td>
																			<% btotalFeRev += (projectFinancialDetail.getFeBalance() + projectFinancialDetail.getFeDipl()); %>
																			<!-- Total -->
																			<td align="right" style="text-align: right;"><%=df.format((projectFinancialDetail.getReBalance() + projectFinancialDetail.getReDipl()) + (projectFinancialDetail.getFeBalance() + projectFinancialDetail.getFeDipl()) )%></td>
																			<% totReFeBalanceRev += ((projectFinancialDetail.getReBalance() + projectFinancialDetail.getReDipl()) + (projectFinancialDetail.getFeBalance() + projectFinancialDetail.getFeDipl()) ); %>
																			
																			<%-- <td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getReDipl())%></td>
																			<% totalREDIPL += (projectFinancialDetail.getReDipl()); %>
																			<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getFeDipl())%></td>
																			<% totalFEDIPL += (projectFinancialDetail.getFeDipl()); %>
																			
																			<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getReBalance())%></td>
																			<% totReBalanceCap += (projectFinancialDetail.getReBalance()); %>
																			<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getFeBalance())%></td>
																			<% totFeBalanceCap += (projectFinancialDetail.getFeBalance()); %> --%>
																		</tr>
																		<%}} %>
																		</tbody>
																		<tbody>
																			<tr>
																				<td colspan="2" style="text-align: right;"><b>Total (Revenue)</b></td>
																				<!-- Sanction Cost -->
																				<td align="right" style="text-align: right;"><%=df.format(totReSanctionCostRev)%></td>
																				<td align="right" style="text-align: right;"><%=df.format(totFESanctionCostRev)%></td>
																				<td align="right" style="text-align: right;"><%=df.format(totReFESantionCostRev)%></td>
																				<!-- Expenditure Cost -->
																				<td align="right" style="text-align: right;"><%=df.format(totREExpenditureRev)%></td>
																				<td align="right" style="text-align: right;"><%=df.format(totFEExpenditureRev)%></td>
																				<td align="right" style="text-align: right;"><%=df.format(totReFEExpenditureRev)%></td>
																				<!-- O/s Commitments Cost -->
																				<td align="right" style="text-align: right;"><%=df.format(totRECommitmentRev)%></td>
																				<td align="right" style="text-align: right;"><%=df.format(totFECommitmentRev)%></td>
																				<td align="right" style="text-align: right;"><%=df.format(totReFECommitmentRev)%></td>
																				<!-- Balance Cost -->
																				<td align="right" style="text-align: right;"><%=df.format(btotalReRev)%></td>
																				<td align="right" style="text-align: right;"><%=df.format(btotalFeRev)%></td>
																				<td align="right" style="text-align: right;"><%=df.format(totReFeBalanceRev)%></td>
																				
																				<%-- <td align="right" style="text-align: right;"><%=df.format(totalREDIPL)%></td>
																				<td align="right" style="text-align: right;"><%=df.format(totalFEDIPL)%></td>
																				<td align="right" style="text-align: right;"><%=df.format(totReBalanceCap)%></td>
																				<td align="right" style="text-align: right;"><%=df.format(totFeBalanceCap)%></td> --%>
																			</tr>

																	</tbody>
																	<tbody>
																		<!-- Capital -->
																		<%if(capital!=null && capital.size()>0) {
																			int j=0;
																			for (ProjectFinancialDetails projectFinancialDetail : capital) {
																		%>
																		
																		<tr>
																			<td align="center" style="max-width: 50px !important; text-align: center;"><%=count++%></td>
																			<%-- <%if(j++==0) {%> 
																				<td rowspan="<%=capital.size()+1%>" style="transform : rotate(270deg); width : 4%; text-align: center;" >
																			 		CAPITAL
																			 	</td>
																			<%} %> --%>
																			<td><b><%=projectFinancialDetail.getBudgetHeadDescription()%></b></td>
																			<!-- Sanction Cost -->
																			<!-- IC -->
																			<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getReSanction())%></td>
																			<% totReSanctionCostCap += (projectFinancialDetail.getReSanction()); %>
																			<!-- FE -->
																			<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getFeSanction())%></td>
																			<% totFESanctionCostCap += (projectFinancialDetail.getFeSanction()); %>
																			<!-- Total -->
																			<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getReSanction() + projectFinancialDetail.getFeSanction()) %> </td>
																			<% totReFESantionCostCap +=projectFinancialDetail.getReSanction() + projectFinancialDetail.getFeSanction();%>
																			
																			<!-- Expenditure Cost -->
																			<!-- IC -->
																			<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getReExpenditure())%></td>
																			<% totREExpenditureCap += (projectFinancialDetail.getReExpenditure()); %>
																			<!-- FE -->
																			<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getFeExpenditure())%></td>
																			<% totFEExpenditureCap += (projectFinancialDetail.getFeExpenditure()); %>
																			<!-- Total -->
																			<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getReExpenditure() + projectFinancialDetail.getFeExpenditure())%></td>
																			<% totReFEExpenditureCap += (projectFinancialDetail.getReExpenditure() + projectFinancialDetail.getFeExpenditure()); %>
																			
																			<!-- O/s Commitments Cost -->
																			<!-- IC -->
																			<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getReOutCommitment())%></td>
																			<% totRECommitmentCap += (projectFinancialDetail.getReOutCommitment()); %>
																			<!-- FE -->
																			<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getFeOutCommitment() )%></td>
																			<% totFECommitmentCap += (projectFinancialDetail.getFeOutCommitment() ); %>
																			<!-- Total -->
																			<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getReOutCommitment() + projectFinancialDetail.getFeOutCommitment())%></td>
																			<% totReFECommitmentCap += (projectFinancialDetail.getReOutCommitment() + projectFinancialDetail.getFeOutCommitment()); %>
																			
																			<!-- Balance Cost -->
																			<!-- IC -->
																			<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getReBalance() + projectFinancialDetail.getReDipl())%></td>
																			<% btotalReCap += (projectFinancialDetail.getReBalance() + projectFinancialDetail.getReDipl()); %>
																			<!-- FE -->
																			<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getFeBalance() + projectFinancialDetail.getFeDipl())%></td>
																			<% btotalFeCap += (projectFinancialDetail.getFeBalance() + projectFinancialDetail.getFeDipl()); %>
																			<!-- Total -->
																			<td align="right" style="text-align: right;"><%=df.format((projectFinancialDetail.getReBalance() + projectFinancialDetail.getReDipl()) + (projectFinancialDetail.getFeBalance() + projectFinancialDetail.getFeDipl()) )%></td>
																			<% totReFeBalanceCap += ((projectFinancialDetail.getReBalance() + projectFinancialDetail.getReDipl()) + (projectFinancialDetail.getFeBalance() + projectFinancialDetail.getFeDipl()) ); %>
																			
																			<%-- <td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getReDipl())%></td>
																			<% totalREDIPL += (projectFinancialDetail.getReDipl()); %>
																			<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getFeDipl())%></td>
																			<% totalFEDIPL += (projectFinancialDetail.getFeDipl()); %>
																			
																			<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getReBalance())%></td>
																			<% totReBalanceCap += (projectFinancialDetail.getReBalance()); %>
																			<td align="right" style="text-align: right;"><%=df.format(projectFinancialDetail.getFeBalance())%></td>
																			<% totFeBalanceCap += (projectFinancialDetail.getFeBalance()); %> --%>
																		</tr>
																		<%}} %>
																		
																		<%}%>
																	</tbody>
																	<tbody>
																		<tr>
																			<td colspan="2" style="text-align: right;"><b>Total (Capital)</b></td>
																			<!-- Sanction Cost -->
																			<td align="right" style="text-align: right;"><%=df.format(totReSanctionCostCap)%></td>
																			<td align="right" style="text-align: right;"><%=df.format(totFESanctionCostCap)%></td>
																			<td align="right" style="text-align: right;"><%=df.format(totReFESantionCostCap)%></td>
																			<!-- Expenditure Cost -->
																			<td align="right" style="text-align: right;"><%=df.format(totREExpenditureCap)%></td>
																			<td align="right" style="text-align: right;"><%=df.format(totFEExpenditureCap)%></td>
																			<td align="right" style="text-align: right;"><%=df.format(totReFEExpenditureCap)%></td>
																			<!-- O/s Commitments Cost -->
																			<td align="right" style="text-align: right;"><%=df.format(totRECommitmentCap)%></td>
																			<td align="right" style="text-align: right;"><%=df.format(totFECommitmentCap)%></td>
																			<td align="right" style="text-align: right;"><%=df.format(totReFECommitmentCap)%></td>
																			<!-- Balance Cost -->
																			<td align="right" style="text-align: right;"><%=df.format(btotalReCap)%></td>
																			<td align="right" style="text-align: right;"><%=df.format(btotalFeCap)%></td>
																			<td align="right" style="text-align: right;"><%=df.format(totReFeBalanceCap)%></td>
																			
																			<%-- <td align="right" style="text-align: right;"><%=df.format(totalREDIPL)%></td>
																			<td align="right" style="text-align: right;"><%=df.format(totalFEDIPL)%></td>
																			<td align="right" style="text-align: right;"><%=df.format(totReBalanceCap)%></td>
																			<td align="right" style="text-align: right;"><%=df.format(totFeBalanceCap)%></td> --%>
																		</tr>
																		<tr>
																			<td colspan="2" style="text-align: right;"><b>GrandTotal (Rev + Cap) </b></td>
																			<!-- Sanction Cost -->
																			<td align="right" style="text-align: right;"><%=df.format(totReSanctionCostRev + totReSanctionCostCap)%></td>
																			<td align="right" style="text-align: right;"><%=df.format(totFESanctionCostRev + totFESanctionCostCap)%></td>
																			<td align="right" style="text-align: right;"><%=df.format(totReFESantionCostRev + totReFESantionCostCap)%></td>
																			<!-- Expenditure Cost -->
																			<td align="right" style="text-align: right;"><%=df.format(totREExpenditureRev + totREExpenditureCap)%></td>
																			<td align="right" style="text-align: right;"><%=df.format(totFEExpenditureRev + totFEExpenditureCap)%></td>
																			<td align="right" style="text-align: right;"><%=df.format(totReFEExpenditureRev + totReFEExpenditureCap)%></td>
																			<!-- O/s Commitments Cost -->
																			<td align="right" style="text-align: right;"><%=df.format(totRECommitmentRev + totRECommitmentCap)%></td>
																			<td align="right" style="text-align: right;"><%=df.format(totFECommitmentRev + totFECommitmentCap)%></td>
																			<td align="right" style="text-align: right;"><%=df.format(totReFECommitmentRev + totReFECommitmentCap)%></td>
																			<!-- Balance Cost -->
																			<td align="right" style="text-align: right;"><%=df.format(btotalReRev + btotalReCap)%></td>
																			<td align="right" style="text-align: right;"><%=df.format(btotalFeRev + btotalFeCap)%></td>
																			<td align="right" style="text-align: right;"><%=df.format(totReFeBalanceRev + totReFeBalanceCap)%></td>
																		</tr>
																		<%-- <tr>
																			<td colspan="2"><b>GrandTotal</b></td>
																			<td colspan="3" align="right" style="text-align: right;"><b><%=df.format(totReSanctionCostCap + totFESanctionCostCap)%></b></td>
																			<td colspan="3" align="right" style="text-align: right;"><b><%=df.format(totREExpenditureCap + totFEExpenditureCap)%></b></td>
																			<td colspan="3" align="right" style="text-align: right;"><b><%=df.format(totRECommitmentCap + totFECommitmentCap)%></b></td>
																			<td colspan="3" align="right" style="text-align: right;"><b><%=df.format(btotalReCap + btotalFeCap)%></b></td>
																			<td colspan="2" align="right" style="text-align: right;"><b><%=df.format(totalREDIPL + totalFEDIPL)%></b></td>
																			<td colspan="2" align="right" style="text-align: right;"><b><%=df.format(totReBalanceCap + totFeBalanceCap)%></b></td>
																		</tr> --%>

																	</tbody>
																</table>
																<%-- <%}} %> --%>
												    		</td>
												    	</tr>
			               							</table>
			               							
			               							
			               							
			               							<!-- Remarks History -->
							            			 <div class="row mt-2" style="margin-left: 30px;">
														<%if(acpRemarksHistory.size()>0){ %>
															<div class="col-md-8" align="left" style="margin: 10px 0px 5px 25px; padding:0px;border: 1px solid black;border-radius: 5px;">
																<%if(acpRemarksHistory.size()>0){ %>
																	<table style="margin: 3px;padding: 0px">
																		<tr>
																			<td style="border:none;padding: 0px">
																			<h6 style="text-decoration: underline;">Remarks :</h6> 
																			</td>											
																		</tr>
																		<%for(Object[] obj : acpRemarksHistory){%>
																		<tr>
																			<td style="border:none;width: 80%;overflow-wrap: anywhere;padding: 0px">
																				<%=obj[3]%>&nbsp; :
																				<span style="border:none; color: blue;">	<%=obj[1] %></span>
																			</td>
																		</tr>
																		<%} %>
																	</table>
																<%} %>
															</div>
														<%} %>
					   								</div>
			               							
			               							<div class="row mt-2 mb-4">
														<div class="col-md-12" align="center">
															<%if(statuscode!=null && acpforward.contains(statuscode)) {%>
																<div class="ml-2" align="left">
									   								<b >Remarks :</b><br>
									   								<textarea rows="3" cols="65" name="remarks" id="remarksarea"></textarea>
								         						</div>
																<button type="submit" class="btn btn-sm submit" name="Action" formaction="ProjectClosureACPApprovalSubmit.htm" value="A" onclick="return confirm('Are you Sure to Submit ?');">Forward</button>
															<%} %>
															<%if(isApproval!=null && isApproval.equalsIgnoreCase("Y")) {%>
																<%if(statuscode!=null && ( statuscode.contains("AAD")  || statuscode.contains("AAO") || statuscode.contains("AAN") ) ) {%>
																	<div class="row externalapproval" style="">
																		<div class="col-md-3">
																			<label class="control-label">Lab</label><span class="mandatory">*</span>
																			<select class="form-control selectdee" id="LabCode" name="LabCode" onchange="LabcodeSubmit()" data-live-search="true"  required="required">
		        																<option disabled="disabled" value="" selected="selected"> Select</option>
																					<%if (labList != null && labList.size() > 0) {
																						for (Object[] obj : labList) {
																					%>
																						<option value=<%=obj[2].toString()%>><%=obj[2].toString()%></option>
																					<%}}%>
																			</select>
																		</div>
																		<div class="col-md-3">
																			<label class="control-label">Approval Officer</label><span class="mandatory">*</span>
				  															<select class="form-control selectdee" id="approverEmpId" name="approverEmpId" data-live-search="true" required>
				  																<option disabled="disabled" value="" selected="selected"> Select</option>
				  															</select>
																		</div>
																		<div class="col-md-2">
																			<label class="control-label" >Approval Date</label><span class="mandatory">*</span>
			          														<input type="text" class="form-control" id="approvalDate" name="approvalDate">
																		</div>
																		<div class="col-md-4"></div>
																		
																	</div>
																<%} %>
																
																<div class="ml-2" align="left">
									   								<b >Remarks :</b><br>
									   								<textarea rows="3" cols="65" name="remarks" id="remarksarea"></textarea>
								         						</div>
								         						<%if(statuscode!=null && acpapprove.contains(statuscode)) {%>
								         						<button type="submit" class="btn btn-sm btn-success" id="finalSubmission" formaction="ProjectClosureACPApprovalSubmit.htm" name="Action" value="A" onclick="return confirm('Are You Sure To Approve?');" style="font-weight: 600;">
										    						Approve	
									      						</button>
									      						
									      						<button type="submit" class="btn btn-sm btn-danger" id="finalSubmission" formaction="ProjectClosureACPApprovalSubmit.htm" name="Action" value="R" onclick="return validateTextBox();" style="font-weight: 600;background-color: #ff2d00;">
										 							Return
																</button>
								         						<%} else{%>
																<button type="submit" class="btn btn-sm btn-success" id="finalSubmission" formaction="ProjectClosureACPApprovalSubmit.htm" name="Action" value="A" onclick="return confirm('Are You Sure To Recommend?');" style="font-weight: 600;">
										    						Recommend	
									      						</button>
									      						
									      						<button type="submit" class="btn btn-sm btn-danger" id="finalSubmission" formaction="ProjectClosureACPApprovalSubmit.htm" name="Action" value="R" onclick="return validateTextBox();" style="font-weight: 600;background-color: #ff2d00;">
										 							Return
																</button>
															<%} }%>
														</div>
                   									</div>
                   									
                   								</form>
                   							</div>
                   						</div>
                   					</div>
               					<%} else{%>
			               			<div class="mt-4" style="display: flex;justify-content: center; align-items: center;">
			               				<h4 style="font-weight: bold;color: red;">Please fill Administrative Closure Details..!</h4>
			               			</div>
               					<%} %>
               					
               					<div style="display: flex;justify-content: space-between;">
	               					<div></div>
		               				<div>
		               					<%if(isApproval==null) {%>
		               					<div class="row"  >
				 		  					<div class="col-md-12" style="text-align: center;"><b>Approval Flow For Administrative Closure Approval</b></div>
				 	    				</div>
				 	    				<div class="row"  style="text-align: center; padding-top: 10px; padding-bottom: 15px; " >
			              					<table align="center"  >
			               						<tr>
			               							<td class="trup" style="background: linear-gradient(to top, #3c96f7 10%, transparent 115%);">
			                							PD -  <%if(PDData!=null) {%><%=PDData[2] %> <%} else{%>GD<%} %>
			                						</td>
			                		
		                        					<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						<td class="trup" style="background: linear-gradient(to top, #eb76c3 10%, transparent 115%);">
			                							GD - <%if(GD!=null) {%><%=GD[1] %> <%} else{%>GD<%} %>
			                	    				</td>
			                	    				
			                	    				<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						<td class="trup" style="background: linear-gradient(to top, #9b999a 10%, transparent 115%);">
			                							AD - <%if(AD!=null) {%><%=AD[1] %> <%} else{%>AD<%} %>
			                	    				</td>
			                	    				
			                	    				<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						<td class="trup" style="background: linear-gradient(to top, #76ebcb 10%, transparent 115%);">
			                							GD-DP&C - <%if(GDDPandC!=null) {%><%=GDDPandC[1] %> <%} else{%>GD-DP&C<%} %>
			                	    				</td>
			                	    				
			                	    				<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						<td class="trup" style="background: linear-gradient(to top, #f2a610 10%, transparent 115%);">
			                							Lab Accounting Officer - <%if(LAO!=null) {%><%=LAO[1] %> <%} else{%>LAO<%} %>
			                	    				</td>
			                	    				
			                	    				<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						<td class="trup" style="background: linear-gradient(to top, #13f816 10%, transparent 115%);">
			                							Director - <%if(Director!=null) {%><%=Director[1] %> <%} else{%>Director<%} %>
			                	    				</td>
			                	    				
			                	    				<%if(isMain!=0 && sanctionCost<=10000000) {
			                							
			                						}else if(isMain!=0 && (sanctionCost>10000000 && sanctionCost<=750000000)) {
			                							
			                						}else {%>
			                	    				<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						
			                						<td class="trup" style="background: linear-gradient(to top, #96de1c 10%, transparent 115%);">
			                							O/o DG(ECS) - O/o DG(ECS)
			                	    				</td>
			                	    				<%} %>
			                	    				
			                	    				<%if(isMain==0 && sanctionCost>750000000) {%>
			                	    				<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						
			                						<td class="trup" style="background: linear-gradient(to top, #ff7200 10%, transparent 115%);">
			                							 DG(Nodal) - DG(Nodal)
			                	    				</td>
			                	    				<%} %>
			                	    				
			                	    				<%if(!(isMain!=0 && sanctionCost<=10000000)) {%>
			                	    				<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						
			                						<td class="trup" style="background: linear-gradient(to top, #00c7e4 10%, transparent 115%);">
			                							CFA - CFA
			                	    				</td>
			                	    				<%} %>
			               						</tr> 	
			               	    			</table>			             
					 					</div>
					 					<%} %>
		               				</div>
		               				<div class="navigation_btn"  style="text-align: right;">
		            					<a class="btn btn-info btn-sm  shadow-nohover previous" >Previous</a>
										<button class="btn btn-info btn-sm next">Next</button>
									</div>
               					</div>
               			<%if(acpTabId!=null && acpTabId.equalsIgnoreCase("2")){ %> 
         					</div>
         				<%}else{ %>
              				</div>
               			<%} %>
               			
               		</div>
               	</div>
         	</div>
         </div>
	</div>
</div>

<script type="text/javascript">
// Date Picker for Expediture as on
$('#expndAsOn').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	/* "minDate" :datearray,   */
	 /* "startDate" : new Date(), */
	 "maxDate" : new Date(), 
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});	

// Date Picker for Consultancy Date
$('#consultancyDate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	/* "minDate" :datearray,   */
	 /* "startDate" : new Date(), */
	 "maxDate" : new Date(), 
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});	
</script>

<script type="text/javascript">

 function bootstrapTabControl(){
	  var i, items = $('.nav-link'), pane = $('.tab-pane');
	  // next
	  $('.next').on('click', function(){
	      for(i = 0; i < items.length; i++){
	          if($(items[i]).hasClass('active') == true){
	              break;
	          }
	      }
	      if(i < items.length - 1){
	          $(items[i+1]).trigger('click');
	      }

	  });
	  // Prev
	  $('.previous').on('click', function(){
	      for(i = 0; i < items.length; i++){
	          if($(items[i]).hasClass('active') == true){
	              break;
	          }
	      }
	      if(i != 0){
	          $(items[i-1]).trigger('click');
	      }
	  });
	}
	bootstrapTabControl(); 

</script>


<script type="text/javascript">
/* button disabling for ACP Approval */
<%if((acp!=null && acpforward.contains(acp.getClosureStatusCode())) || acp==null) {%>
$('.btn-acp').prop('disabled',false);
<%} else{%>
$('.btn-acp').prop('disabled',true);
<%} %>

/* tabs hiding for ACP approval */
<%if(isApproval!=null && (isApproval.equalsIgnoreCase("Y") || isApproval.equalsIgnoreCase("N"))) {%>
   $('.navigation_btn').hide();
   $('#nav-acpdetails').hide();
<%} %>
</script>

<!-- Remarks Handling -->
<script type="text/javascript">
function validateTextBox() {
    if (document.getElementById("remarksarea").value.trim() != "") {
    	return confirm('Are You Sure To Return?');
    	
    } else {
        alert("Please enter Remarks to Return");
        return false;
    }
}
function disapprove() {
    if (document.getElementById("remarksarea").value.trim() != "") {
    	return confirm('Are You Sure To Disappove?');
    	
    } else {
        alert("Please enter Remarks to Disapprove");
        return false;
    }
}
</script>

<script type="text/javascript">
function LabcodeSubmit() {
	   var LabCode = document.getElementById("LabCode").value;
	   $('#approverEmpId').empty();
	   $.ajax({
	       type: "GET",
	       url: "GetLabcodeEmpList.htm",
	       data: {
	       	LabCode: LabCode
	       },
	       dataType: 'json',
	       success: function(result) {
	               	for (var i = 0; i < result.length; i++) {
	                       var data = result[i];
	                       var optionValue = data[0];
	                       var optionText = data[1].trim() + ", " + data[3]; 
	                       var option = $("<option></option>").attr("value", optionValue).text(optionText);
	                       $('#approverEmpId').append(option); 
	                   }
	                   $('#approverEmpId').selectpicker('refresh');
	               
	           }
	   });
	}
	
$('#approvalDate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	/* "minDate" :datearray,   */
	 /* "startDate" : new Date(), */
	 "maxDate" : new Date(), 
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});	
</script>

<script type="text/javascript">

/* ----------------- CKEDITOR Configuration ------------------------------------ */
var editor_config = {
		toolbar : [
				{
					name : 'clipboard',
					items : [ 'PasteFromWord', '-', 'Undo', 'Redo' ]
				},
				{
					name : 'basicstyles',
					items : [ 'Bold', 'Italic', 'Underline', 'Strike',
							'RemoveFormat', 'Subscript', 'Superscript' ]
				},
				{
					name : 'links',
					items : [ 'Link', 'Unlink' ]
				},
				{
					name : 'paragraph',
					items : [ 'NumberedList', 'BulletedList', '-',
							'Outdent', 'Indent', '-', 'Blockquote' ]
				},
				{
					name : 'insert',
					items : [ 'Image', 'Table' ]
				},
				{
					name : 'editing',
					items : [ 'Scayt' ]
				},
				'/',

				{
					name : 'styles',
					items : [ 'Format', 'Font', 'FontSize' ]
				},
				{
					name : 'colors',
					items : [ 'TextColor', 'BGColor', 'CopyFormatting' ]
				},
				{
					name : 'align',
					items : [ 'JustifyLeft', 'JustifyCenter',
							'JustifyRight', 'JustifyBlock' ]
				}, {
					name : 'document',
					items : [ 'Print', 'PageBreak', 'Source' ]
				} ],

		removeButtons : 'Underline,Strike,Subscript,Superscript,Anchor,Styles,Specialchar',

		customConfig : '',

		disallowedContent : 'img{width,height,float}',
		extraAllowedContent : 'img[width,height,align]',

		height : 300,

		contentsCss : [ CKEDITOR.basePath + 'mystyles.css' ],

		bodyClass : 'document-editor',

		format_tags : 'p;h1;h2;h3;pre',

		removeDialogTabs : 'image:advanced;link:advanced',

		stylesSet : [

		{
			name : 'Marker',
			element : 'span',
			attributes : {
				'class' : 'marker'
			}
		}, {
			name : 'Cited Work',
			element : 'cite'
		}, {
			name : 'Inline Quotation',
			element : 'q'
		},

		{
			name : 'Special Container',
			element : 'div',
			styles : {
				padding : '5px 10px',
				background : '#eee',
				border : '1px solid #ccc'
			}
		}, {
			name : 'Compact table',
			element : 'table',
			attributes : {
				cellpadding : '6',
				cellspacing : '0',
				border : '1',
				bordercolor : '#ccc'
			},
			styles : {
				'border-collapse' : 'collapse'
			}
		}, {
			name : 'Borderless Table',
			element : 'table',
			styles : {
				'border-style' : 'hidden',
				'background-color' : '#E6E6FA'
			}
		}, {
			name : 'Square Bulleted List',
			element : 'ul',
			styles : {
				'list-style-type' : 'square'
			}
		}, {
			filebrowserUploadUrl : '/path/to/upload-handler'
		}, ]
	};
	

/* -------------------------- Form Submission with CKEDITOR Data -------------------------------------------- */

$('#myform1').submit(function() {

	  var data =CKEDITOR.instances['objectivesnote'].getData();
	  $('textarea[name=acpObjectives]').val(data);

});

$('#myform5').submit(function() {

	  var data =CKEDITOR.instances['facilitiesnote'].getData();
	  $('textarea[name=facilitiesCreated]').val(data);

});

$('#myform8').submit(function() {

	  var data =CKEDITOR.instances['recommendationsnote'].getData();
	  $('textarea[name=monitoringCommittee]').val(data);

});

/* ------------------------ Using CKEDITOR Configuration ------------------------ */
CKEDITOR.replace('objectivesnote', editor_config);
CKEDITOR.replace('facilitiesnote', editor_config);
CKEDITOR.replace('recommendationsnote', editor_config);	
</script>

<script type="text/javascript">


$( document ).ready(function() {
	
	/* ----------------------- Aim & Objectives ------------------------ */ 
	<%if(acp!=null && acp.getACPAim()!=null && acp.getACPObjectives()!=null) {%>
		$('#myform1').hide();
		$('#aimobjectivesdiv').show();
		 var html=$('#objectiveshidden').val();
		
		CKEDITOR.instances['objectivesnote'].setData(html);
		
	<%} else{%>
		$('#myform1').show();
		$('#aimobjectivesdiv').hide();
	<%} %>
	
	/* ----------------------- Sub-Projects ------------------------ */ 
	<%if(subprojects!=null && subprojects.size()>0) {%>
		$('#myform2').hide();
		$('#subprojectsdiv').show();
	<%} else{%>
		$('#myform2').show();
		$('#subprojectsdiv').hide();
	<%} %>
	
	/* ----------------------- CARS / CAPSI ------------------------ */ 
	<%if(carscapsiprojects!=null && carscapsiprojects.size()>0) {%>
		$('#myform3').hide();
		$('#carscapsidiv').show();
	<%} else{%>
		$('#myform3').show();
		$('#carscapsidiv').hide();
	<%} %>
	
	/* ----------------------- Consultancies ------------------------ */ 
	<%if(consultancies!=null && consultancies.size()>0) {%>
		$('#myform4').hide();
		$('#consultanciesdiv').show();
	<%} else{%>
		$('#myform4').show();
		$('#consultanciesdiv').hide();
	<%} %>
	
	/* ----------------------- Facilities Created ------------------------ */
	<%if(acp!=null && acp.getFacilitiesCreated()!=null) {%>
		$('#myform5').hide();
		$('#facilitiescreateddiv').show();
	 	var html=$('#facilitiescreatedhidden').val();
	
		CKEDITOR.instances['facilitiesnote'].setData(html);
	
	<%} else{%>
		$('#myform5').show();
		$('#facilitiescreateddiv').hide();
	<%} %>
	
	/* ----------------------- Trial Results ------------------------ */
	<%if(acp!=null && acp.getTrialResults()!=null) {%>
		$('#myform6').hide();
		$('#trialresultsdiv').show();
	<%} else{%>
		$('#myform6').show();
		$('#trialresultsdiv').hide();
	<%} %>
	
	/* ----------------------- Achievements ------------------------ */
	<%if(achievements!=null && achievements.size()>0) {%>
		$('#myform7').hide();
		$('#achievementsdiv').show();
	<%} else{%>
		$('#myform7').show();
		$('#achievementsdiv').hide();
	<%} %>
	
	/* ----------------------- Recommendations ------------------------ */
	<%if(acp!=null && acp.getMonitoringCommittee()!=null) {%>
		$('#myform8').hide();
		$('#recommendationsdiv').show();
		
		var html=$('#recommendationshidden').val();
		
		CKEDITOR.instances['recommendationsnote'].setData(html);
	<%} else{%>
		$('#myform8').show();
		$('#recommendationsdiv').hide();
	<%} %>
	
	/* ----------------------- Others ------------------------ */
	<%if(acp!=null && acp.getExpndAsOn()!=null) {%>
		$('#myform9').hide();
		$('#othersdiv').show();
	<%} else{%>
		$('#myform9').show();
		$('#othersdiv').hide();
	<%} %>
});


</script>

<script type="text/javascript">

function AllowEdit(openingtab){
	if(openingtab=='aimobjectives'){
		$('#myform1').show();
		$('#aimobjectivesdiv').hide();
	}else if(openingtab=='subprojects'){
		$('#myform2').show();
		$('#subprojectsdiv').hide();
	}else if(openingtab=='carscapsi'){
		$('#myform3').show();
		$('#carscapsidiv').hide();
	}else if(openingtab=='consultancies'){
		$('#myform4').show();
		$('#consultanciesdiv').hide();
	}else if(openingtab=='facilitiescreated'){
		$('#myform5').show();
		$('#facilitiescreateddiv').hide();
	}else if(openingtab=='trialresults'){
		$('#myform6').show();
		$('#trialresultsdiv').hide();
	}else if(openingtab=='achievements'){
		$('#myform7').show();
		$('#achievementsdiv').hide();
	}else if(openingtab=='recommendations'){
		$('#myform8').show();
		$('#recommendationsdiv').hide();
	}else if(openingtab=='others'){
		$('#myform9').show();
		$('#othersdiv').hide();
	}
}

function CloseEdit(closingtab){
	if(closingtab=='aimobjectives'){
		$('#myform1').hide();
		$('#aimobjectivesdiv').show();
	}else if(closingtab=='subprojects'){
		$('#myform2').hide();
		$('#subprojectsdiv').show();
	}else if(closingtab=='carscapsi'){
		$('#myform3').hide();
		$('#carscapsidiv').show();
	}else if(closingtab=='consultancies'){
		$('#myform4').hide();
		$('#consultanciesdiv').show();
	}else if(closingtab=='facilitiescreated'){
		$('#myform5').hide();
		$('#facilitiescreateddiv').show();
	}else if(closingtab=='trialresults'){
		$('#myform6').hide();
		$('#trialresultsdiv').show();
	}else if(closingtab=='achievements'){
		$('#myform7').hide();
		$('#achievementsdiv').show();
	}else if(closingtab=='recommendations'){
		$('#myform8').hide();
		$('#recommendationsdiv').show();
	}else if(closingtab=='others'){
		$('#myform9').hide();
		$('#othersdiv').show();
	}
}
</script>

<script type="text/javascript">
/* ----------------------------------- Sub-Projects -------------------------- */
/* Cloning (Adding) the table body rows for Sub-Projects */
$("#subprojectstable").on('click','.btn_add_subprojects' ,function() {
	
	var $tr = $('.tr_clone_subprojects').last('.tr_clone_subprojects');
	var $clone = $tr.clone();
	$tr.after($clone);
	
	$clone.find("input").val("").end();
	
});


/* Cloning (Removing) the table body rows for Sub-Projects */
$("#subprojectstable").on('click','.btn_rem_subprojects' ,function() {
	
var cl=$('.tr_clone_subprojects').length;
	
if(cl>1){
   var $tr = $(this).closest('.tr_clone_subprojects');
  
   var $clone = $tr.remove();
   $tr.after($clone);
   
}
   
});

/* ----------------------------------- CARS / CAPSI -------------------------- */
/* Cloning (Adding) the table body rows for CARS / CAPSI */
$("#carscapsitable").on('click','.btn_add_carscapsi' ,function() {
	
	var $tr = $('.tr_clone_carscapsi').last('.tr_clone_carscapsi');
	var $clone = $tr.clone();
	
	$tr.after($clone);
	$clone.find("input").val("").end();
	
});


/* Cloning (Removing) the table body rows for CARS / CAPSI */
$("#carscapsitable").on('click','.btn_rem_carscapsi' ,function() {
	
var cl=$('.tr_clone_carscapsi').length;
	
if(cl>1){
   var $tr = $(this).closest('.tr_clone_carscapsi');
  
   var $clone = $tr.remove();
   $tr.after($clone);
   
}
   
});

/* ----------------------------------- Consultancies -------------------------- */
/* Cloning (Adding) the table body rows for Consultancies */
$("#consultanciestable").on('click','.btn_add_consultancies' ,function() {
	
	var $tr = $('.tr_clone_consultancies').last('.tr_clone_consultancies');
	var $clone = $tr.clone();
	
	$tr.after($clone);
	$clone.find("input").val("").end();
	$clone.find('#consultancyDate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		/* "minDate" :datearray,   */
		 /* "startDate" : new Date(), */
		 "maxDate" : new Date(), 
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
	
});


/* Cloning (Removing) the table body rows for Consultancies */
$("#consultanciestable").on('click','.btn_rem_consultancies' ,function() {
	
var cl=$('.tr_clone_consultancies').length;
	
if(cl>1){
   var $tr = $(this).closest('.tr_clone_consultancies');
  
   var $clone = $tr.remove();
   $tr.after($clone);
   
}
   
});

/* ----------------------------------- Trial Results -------------------------- */
/* Cloning (Adding) the table body rows for Trial Results */
$("#trialresultstable").on('click','.btn_add_trialresults' ,function() {
	
	var $tr = $('.tr_clone_trialresults').last('.tr_clone_trialresults');
	var $clone = $tr.clone();
	
	$tr.after($clone);
	
	$clone.find("#attachedfile").hide();
	$clone.find("input").val("").end();
	
});


/* Cloning (Removing) the table body rows for Trial Results */
$("#trialresultstable").on('click','.btn_rem_trialresults' ,function() {
	
var cl=$('.tr_clone_trialresults').length;
	
if(cl>1){
   var $tr = $(this).closest('.tr_clone_trialresults');
  
   var $clone = $tr.remove();
   $tr.after($clone);
   
}
   
});

/* ----------------------------------- Achievements -------------------------- */
/* Cloning (Adding) the table body rows for Achievements */
$("#achievementstable").on('click','.btn_add_achievements' ,function() {
	
	var $tr = $('.tr_clone_achievements').last('.tr_clone_achievements');
	var $clone = $tr.clone();
	
	$tr.after($clone);
	
	$clone.find("input").val("").end();
	
});


/* Cloning (Removing) the table body rows for Achievements */
$("#achievementstable").on('click','.btn_rem_achievements' ,function() {
	
var cl=$('.tr_clone_achievements').length;
	
if(cl>1){
   var $tr = $(this).closest('.tr_clone_achievements');
  
   var $clone = $tr.remove();
   $tr.after($clone);
   
}
   
});
</script>
</body>
</html>
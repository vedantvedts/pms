<%@page import="java.util.Date"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.vts.pfms.cars.model.CARSSoCMilestones"%>
<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.cars.model.CARSSoC"%>
<%@page import="com.vts.pfms.cars.model.CARSInitiation"%>
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
.buttonEd {
	float: right;
	margin-top: -0.5rem;
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

#socforwardtable, #milestonestable, #desctable{
	width : 98%;
	/* border : 1px solid black; */
	 margin-top : 1rem; 
	font-size: 14px;
}
#socforwardtable td, #milestonestable td, #desctable td{
	border : 1px solid black;
	text-align: left;
	padding : 3px;
}

#socforwardtable th, #milestonestable th, #desctable th{
	border : 1px solid black;
	text-align: center;
	padding : 3px;
}

#socforwardtable td:first-child {
    text-align: center;
    width: 5%;
}

#socforwardtable td:second-child {
    width: 23%;
}
#socforwardtable td:third-child {
    width: 70%;
}

#desctable td:first-child {
    text-align: center;
}

.soccontainer{
	text-align: left;
 
}
.socheading{
	font-weight: bold;
	margin-top: 1rem;
}
.soccontent{
	width: 96%;
	margin-left: 20px;
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
</head>
<body>
<%
String dpcTabId = (String)request.getAttribute("dpcTabId"); 
CARSInitiation carsIni = (CARSInitiation)request.getAttribute("CARSInitiationData"); 
CARSSoC carsSoC =(CARSSoC)request.getAttribute("CARSSoCData"); 
List<CARSSoCMilestones> milestones = (List<CARSSoCMilestones>)request.getAttribute("CARSSoCMilestones");
List<Object[]> dpcSoCRemarksHistory = (List<Object[]>)request.getAttribute("CARSDPCSoCRemarksHistory");
List<Object[]> dpcSoCApprovalEmpData = (List<Object[]>)request.getAttribute("DPCSoCApprovalEmpData");

String isApproval = (String)request.getAttribute("isApproval");

FormatConverter fc = new FormatConverter();
SimpleDateFormat sdtf = fc.getSqlDateAndTimeFormat();
SimpleDateFormat sdf = fc.getSqlDateFormat();
SimpleDateFormat rdf = fc.getRegularDateFormat();

String expenditure = carsSoC.getDPCExpenditure();
expenditure = expenditure!=null?expenditure.replace("\n", "<br>"):expenditure;

List<String> dpcsocforward = Arrays.asList("SFG","SFP","SID","SGR","SPR","SRC","SRM","SRF","SRR","SRI","RDG","SRD");
List<String> approvebutton = Arrays.asList("SDF","SAD","SAI","ADG");

Object[] emp = (Object[])request.getAttribute("EmpData");
Object[] PDs = (Object[])request.getAttribute("PDEmpIds");

Object[] GHDPandC = (Object[])request.getAttribute("GHDPandC");
Object[] GDDPandC = (Object[])request.getAttribute("GDDPandC");
Object[] ChairmanRPB = (Object[])request.getAttribute("ChairmanRPB");
Object[] MMFDAG = (Object[])request.getAttribute("MMFDAG");
Object[] GDDFandMM = (Object[])request.getAttribute("GDDFandMM");
Object[] Director = (Object[])request.getAttribute("Director");

String EmpId = ((Long) session.getAttribute("EmpId")).toString();
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
         		<div class="card-header slider_header" style="padding:0px; font-size:12px!important; height: 120px;">
             		<h3 class="category">D-P&C SoC Details
             			<a class="btn btn-info btn-sm  shadow-nohover back"
             			<%if(isApproval!=null && isApproval.equalsIgnoreCase("P") ) {%>
               				href="CARSRSQRApprovals.htm"
               			<%} else if(isApproval!=null && isApproval.equalsIgnoreCase("Q") ) {%>
               				href="CARSRSQRApprovals.htm?val=app"
               			<%} else {%>
             			    href="CARSRSQRApprovedList.htm?PageLoad=S"
             			<%} %> 
             			  style="color: white!important;float: right;">Back</a>
             		</h3>
             		<hr style="margin: -8px 0px !important;">
             		<ul class="nav nav-tabs justify-content-center" role="tablist" style="padding-bottom: 0px;" >
            			<li class="nav-item" id="nav-socdetails">
             				<%if(dpcTabId!=null && dpcTabId.equalsIgnoreCase("1")){ %> 
             		    		<a class="nav-link active " data-toggle="tab" href="#socdetails" id="nav" role="tab">
             				<%}else{ %>
              			 		<a class="nav-link  " data-toggle="tab" href="#socdetails" role="tab">
               				<%} %>  
                	         	SoC Details
              			 		</a>
            			</li>

            			<li class="nav-item" id="nav-socforward">
            	     		<%if(dpcTabId!=null && dpcTabId.equalsIgnoreCase("2")){ %>
              					<a class="nav-link active" data-toggle="tab" href="#socforward" id="nav"role="tab" >
              				<%}else{ %>
              					<a class="nav-link" data-toggle="tab" href="#socforward" role="tab" >
               				<%} %>
                  				SoC Forward
              					</a>
            			</li>
            			
              		</ul>
         		</div>
         		
         		<!-- This is for Tab Panes -->
         		<div class="card">
         			<div class="tab-content text-center" style="margin-top : 0.2rem;">
         				<!-- *********** SoC Details ***********      --> 
               			<%if(dpcTabId!=null && dpcTabId.equalsIgnoreCase("1")){ %> 
         					<div class="tab-pane active" id="socdetails" role="tabpanel">
         				<%}else{ %>
              				<div class="tab-pane " id="socdetails" role="tabpanel">
               			<%} %>
               		 			<form action="CARSDPCSoCEdit.htm" method="POST" name="inieditform" id="inieditform">
               		 				<input type="hidden" name="carsInitiationId" value="<%=carsIni.getCARSInitiationId()%>">
               		 				<input type="hidden" name="carsSocId" value="<%=carsSoC.getCARSSoCId()%>">
               						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
               						<div class="row">
               			    			<div class="col-md-12" style="margin-left: 60px;margin-right: 60px;">
               			    				<!-- First row of SoC Details  -->
               			     				<div class="row details">
                       							<div class="column b" style="width: 94.5%;border-bottom-left-radius: 5px;border-bottom-right-radius: 5px;">
                           							<label class="control-label">Introduction</label><span class="mandatory">*</span>
                             						<textarea  class="form-control form-control" name="dpcIntroduction" id="dpcIntroduction" rows="4" cols="65" style="font-size: 15px;"
                             		 				 placeholder="Enter SoC Introduction" required><%if(carsSoC!=null && carsSoC.getDPCIntroduction()!=null){ %><%=carsSoC.getDPCIntroduction()%><%} %></textarea>
                       							</div>
                        					</div>
               			    				<!-- Second row of SoC Details  -->
               			     				<div class="row details">
                       							<div class="column b" style="width: 47.25%;border-bottom-left-radius: 5px;border-bottom-right-radius: 5px;">
                           							<label class="control-label">Expenditure Head</label><span class="mandatory">*</span>
                             						<textarea  class="form-control form-control" name="dpcExpenditure" id="dpcExpenditure" rows="4" cols="65" style="font-size: 15px;"
                             		 				 placeholder="Enter Expenditure Head" required><%if(carsSoC!=null && carsSoC.getDPCExpenditure()!=null){ %><%=carsSoC.getDPCExpenditure()%><%} %></textarea>
                       							</div>
                       							<div class="column b" style="width: 47.25%;border-bottom-left-radius: 5px;border-bottom-right-radius: 5px;">
                           							<label class="control-label">Additional Points</label>
                             						<textarea  class="form-control form-control" name="dpcAdditional" id="dpcAdditional" rows="4" cols="65" style="font-size: 15px;"
                             		 				 placeholder="Enter Additional Points ( if any )" ><%if(carsSoC!=null && carsSoC.getDPCAdditional()!=null){ %><%=carsSoC.getDPCAdditional()%><%} %></textarea>
                       							</div>
                        					</div>
               			    			</div>
               			    		</div>
               			    		<br>
              						<div align="center">
										<%if(carsSoC!=null && carsSoC.getDPCIntroduction()!=null){ %>
											<button type="submit" class="btn btn-sm btn-warning edit btn-soc" name="Action" value="Edit" onclick="return confirm('Are you sure to update?')" >UPDATE</button>
										<%}else{ %>
											<button type="submit" class="btn btn-sm btn-success submit btn-soc" name="Action" value="Add" onclick="return confirm('Are you sure to submit?')" >SUBMIT</button>
										<%} %>
									</div>
               					</form>
               				
               					<div class="navigation_btn"  style="text-align: right;">
            						<a class="btn btn-info btn-sm  shadow-nohover back" href="CARSRSQRApprovedList.htm?PageLoad=S" style="color: white!important">Back</a>
									<button class="btn btn-info btn-sm next">Next</button>
								</div>
               			<%if(dpcTabId!=null && dpcTabId.equalsIgnoreCase("1")){ %> 
         					</div>
         				<%}else{ %>
              				</div>
               			<%} %>
               			
               			<!-- *********** SoC Forward *********** --> 
               			<%if(dpcTabId!=null && dpcTabId.equalsIgnoreCase("2")){ %> 
         					<div class="tab-pane active" id="socforward" role="tabpanel">
         				<%}else{ %>
              				<div class="tab-pane " id="socforward" role="tabpanel">
		               	<%} %>
		               			<%if(carsSoC!=null && carsSoC.getDPCIntroduction()!=null) {%>
		               				<div class="col-md-8 mt-1">
               							<div class="card" style="border: 1px solid rgba(0,0,0,.125);margin-left: 25%;max-height: 550px;overflow-y: auto;">
               								<div class="card-body mt-2 ml-4">
               									<form action="#">
               										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			               		   					<input type="hidden" name="carsInitiationId" value="<%=carsIni.getCARSInitiationId()%>">
			               		   					<input type="hidden" name="carsSocId" value="<%=carsSoC.getCARSSoCId()%>">
			               		   					<div class="mt-2" align="center">
               											<h5 style="font-weight: bold;margin-top: 1.5rem;">Statement of Case for availing CARS
               											&emsp;<button type="submit" class="btn btn-sm" formaction="CARSDPCSoCDownload.htm" name="carsInitiationId" value="<%=carsIni.getCARSInitiationId() %>" formtarget="blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="Download">
								  	 							<i class="fa fa-download" aria-hidden="true"></i>
															  </button>
               											</h5>
               										</div>
			               		   					<div class="soccontainer">
			               		   						<div style="width: 97%;">
			               		   							<h5 class="socheading"><span>1.</span> <span style="text-decoration: underline;">Introduction</span></h5>
				               		   						<div class="soccontent">
				               		   							<p style="text-indent: 21px;font-size: 15px;"><%=carsSoC.getDPCIntroduction() %></p>
				               		   						</div>
			               		   						</div>
			               		   						<div>
			               		   							<h5 class="socheading"><span>2.</span> <span style="text-decoration: underline;">The Summary of the CARS is as under</span></h5>
			               		   							<div class="soccontent">
			               		   								<table id="socforwardtable">
						               		   						<tr>
						               		   							<th style="width: 5%;">SN</th>
						               		   							<th style="width: 23%;">Subject</th>
						               		   							<th style="width: 70%;">Details</th>
						               		   						</tr>
						               		   						<tr>
						               		   							<td>1.</td>
						               		   							<td>CARS Title</td>
						               		   							<td><%=carsIni.getInitiationTitle() %></td>
						               		   						</tr>
						               		   						<tr>
						               		   							<td>2.</td>
						               		   							<td>File No</td>
						               		   							<td><%=carsIni.getCARSNo() %></td>
						               		   						</tr>
						               		   						<tr>
						               		   							<td>3.</td>
						               		   							<td>Deliverables</td>
						               		   							<td>-do-</td>
						               		   						</tr>
						               		   						<tr>
						               		   							<td>4.</td>
						               		   							<td>Service Type</td>
						               		   							<td>General Revenue</td>
						               		   						</tr>
						               		   						<tr>
						               		   							<td>5.</td>
						               		   							<td>Estimated cost of service</td>
						               		   							<td><%=carsIni.getAmount() %></td>
						               		   						</tr>
						               		   						<tr>
						               		   							<td>6.</td>
						               		   							<td>CARS PDC</td>
						               		   							<td><%=carsIni.getDuration() %></td>
						               		   						</tr>
						               		   						<tr>
						               		   							<td>7.</td>
						               		   							<td>Expenditure Head</td>
						               		   							<td><%=expenditure %></td>
						               		   						</tr>
						               		   						<tr>
						               		   							<td>8.</td>
						               		   							<td>CFA approval as per DFP</td>
						               		   							<td>Under Sl. No: 2.4 of DFP dated 18 Dec 2019</td>
						               		   						</tr>
						               		   						<tr>
						               		   							<td>9.</td>
						               		   							<td>Additional Points</td>
						               		   							<td><%if(carsSoC.getDPCAdditional()!=null && !carsSoC.getDPCAdditional().isEmpty()) {%><%=carsSoC.getDPCAdditional() %><%} else{%>-<%} %></td>
						               		   						</tr>
			               		   								</table>
			               		   							</div>
			               		   						</div>
			               		   						
			               		   						<div>
			               		   							<h5 class="socheading"><span>3.</span> <span style="text-decoration: underline;">Description</span></h5>
				               		   						<div class="soccontent">
				               		   							<p style="font-size: 15px;">
				               		   								<%=carsIni.getRSPInstitute() %> has submitted the &#39;Summary of Offer&#39; for Rs <span class="textunderline"><%=carsIni.getAmount() %></span>
				               		   								(inclusive of GST) for duration of <span class="textunderline"><%=carsIni.getDuration() %></span> months. Required schedule of payments is given below.
				               		   							</p>
				               		   							<table id="milestonestable">
				               		   								<tr>
				               		   								  <th style="width: 10%;">Milestone No.</th>
				               		   								  <th style="width: 28%;">Task Description</th>
				               		   								  <th style="width: 10%;">Months</th>
				               		   								  <th style="width: 25%;">Deliverables</th>
				               		   								  <th style="width: 25%;">Payment Terms</th>
				               		   								</tr>
				               		   								<%if(milestones!=null && milestones.size()>0) {
				               		   									for(CARSSoCMilestones mil : milestones){
				               		   						
				               		   								%>
					               		   								<tr>
					               		   									<td style="width: 10%;text-align: center;"><%=mil.getMilestoneNo() %></td>
					               		   									<td style="width: 28%;"><%=mil.getTaskDesc() %></td>
					               		   									<td style="width: 10%;text-align: center;"><%=mil.getMonths() %></td>
					               		   									<td style="width: 25%;"><%=mil.getDeliverables() %></td>
					               		   									<td style="width: 25%;"><%=mil.getPaymentTerms() %></td>
					               		   								</tr>
				               		   								<%}} %>
				               		   								
				               		   							</table>
				               		   							<br>
				               		   							<p style="font-size: 15px;">
				               		   								The Contract for Acquisition of Professional Services to be placed on <%=carsIni.getRSPInstitute() %> (CARS) file is submitted with the following documents.
				               		   							</p>
				               		   							<table id="desctable">
						               		   						<tr>
						               		   							<th style="width: 5%;">SN</th>
						               		   							<th style="width: 70%;">Description</th>
						               		   							<th style="width: 23%;">Reference</th>
						               		   						</tr>
						               		   						<tr>
						               		   							<td style="text-align: center;">1.</td>
						               		   							<td>Statement of Case for availing CARS, Research Service Qualitative Requirement</td>
						               		   							<td>Annexure A</td>
						               		   						</tr>
						               		   						<tr>
						               		   							<td>2.</td>
						               		   							<td>Recommendation of RSQR by CARS Scrutinising Committee</td>
						               		   							<td>Annexure B</td>
						               		   						</tr>
						               		   						<tr>
						               		   							<td>3.</td>
						               		   							<td>CARS proposal and Summary of Offer from RSP</td>
						               		   							<td>Annexure C</td>
						               		   						</tr>
						               		   						<tr>
						               		   							<td>4.</td>
						               		   							<td>Recommendation by Group/ Project Director on the response of the academic institution on RSQR</td>
						               		   							<td>Annexure D</td>
						               		   						</tr>
						               		   						<tr>
						               		   							<td>5.</td>
						               		   							<td>Draft Contract Copy</td>
						               		   							<td>Annexure E</td>
						               		   						</tr>
						               		   					</table>
				               		   						</div>
				               		   						
			               		   						</div>
			               		   						
			               		   						<div style="width: 97%;">
			               		   							<h5 class="socheading"><span>4.</span> <span style="text-decoration: underline;font">Approval Sought</span></h5>
				               		   						<div class="soccontent">
				               		   							<p style="text-indent: 21px;font-size: 15px;">
				               		   								The case is being submitted along with the above-mentioned documents for obtaining the Concurrence cum 
				               		   								Financial sanction and approval from Competent Financial Authority (CFA) for placement of 
				               		   								Contract for Acquisition of Research Services (CARS) on <%=carsIni.getRSPInstitute() %> at a cost of Rs. <span class="textunderline"><%=carsIni.getAmount() %></span> please.
				               		   							</p>
				               		   						</div>
			               		   						</div>
			               		   						
			               		   					</div>
			               		   					<br>
			               		   					
			               		   					<!-- Signatures and timestamps -->
			               		   					
													<div style="width: 96%;text-align: right;margin-right: 10px;line-height: 10px;margin-top: 30px;">
		               								 	<div style="font-size: 15px;"> Signature of GH-DP&C</div>
						               					<%for(Object[] apprInfo : dpcSoCApprovalEmpData){ %>
						   			   					<%if(apprInfo[8].toString().equalsIgnoreCase("SFD")){ %>
						   								<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<br>
						   								<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
						   								<label style="font-size: 12px; ">[Forwarded On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
						   			    				<%break;}} %>  
							            			 </div>
							            			 
							            			 <%for(Object[] apprInfo : dpcSoCApprovalEmpData) {%>
							            			 	<div style="width: 96%;text-align: left;margin-left: 10px;line-height: 10px;margin-top: 50px;">
							            			 		
							            			 		<%if(apprInfo[8].toString().equalsIgnoreCase("SGD")){ %>
							            			 			<div style="font-size: 15px;"> Signature of GD-DP&C</div>
								   								<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<br>
								   								<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
								   								<label style="font-size: 12px; ">[Recommended On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
							   			    				<%} else if(apprInfo[8].toString().equalsIgnoreCase("SPD")) {%> 
							   			    					<div style="font-size: 15px;"> Signature of PD</div>
							   			    					<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<br>
								   								<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
								   								<label style="font-size: 12px; ">[Recommended On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
							   			    				<%} else if(apprInfo[8].toString().equalsIgnoreCase("SCR")) {%> 
							   			    					<div style="font-size: 15px;"> Signature of Chairman RPB</div>
							   			    					<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<br>
								   								<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
								   								<label style="font-size: 12px; ">[Recommended On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
							   			    				<%} else if(apprInfo[8].toString().equalsIgnoreCase("SMA")) {%> 
							   			    					<div style="font-size: 15px;"> Signature of MMFD AG</div>
							   			    					<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<br>
								   								<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
								   								<label style="font-size: 12px; ">[Recommended On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
							   			    				<%} else if(apprInfo[8].toString().equalsIgnoreCase("SDF")) {%> 
							   			    					<div style="font-size: 15px;"> Signature of GD DF&MM</div>
							   			    					<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<br>
								   								<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
								   								<label style="font-size: 12px; ">[Recommended On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
							   			    					
							   			    				<%} %>
							   			    				<%if(carsIni.getAmount()!=null && Double.parseDouble(carsIni.getAmount())<=1000000) {%>
							   			    					<% if(apprInfo[8].toString().equalsIgnoreCase("SAD")) {%> 
							   			    						<div style="font-size: 15px;"> Signature of Director</div>
							   			    						<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<br>
								   									<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
								   									<label style="font-size: 12px; ">[Approved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("SDD")) {%> 
							   			    						<div style="font-size: 15px;"> Signature of Director</div>
							   			    						<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<br>
								   									<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
								   									<label style="font-size: 12px; ">[Disapproved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
							   			    					<%} %>
							   			    				<%} else if(carsIni.getAmount()!=null && (Double.parseDouble(carsIni.getAmount())>1000000 && Double.parseDouble(carsIni.getAmount())<=5000000) ) {%>
							   			    					<% if(apprInfo[8].toString().equalsIgnoreCase("SAI")) {%>
							   			    						<div style="font-size: 15px;"> Signature of IFA, O/o DG (ECS)</div>
							   			    						<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<br>
								   									<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
								   									<label style="font-size: 12px; ">[Approved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("SDI")) {%> 
							   			    						<div style="font-size: 15px;"> Signature of IFA, O/o DG (ECS)</div>
							   			    						<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<br>
								   									<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
								   									<label style="font-size: 12px; ">[Disapproved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("SAD")) {%> 
							   			    						<div style="font-size: 15px;"> Signature of Director</div>
							   			    						<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<br>
								   									<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
								   									<label style="font-size: 12px; ">[Approved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("SDD")) {%> 
							   			    						<div style="font-size: 15px;"> Signature of Director</div>
							   			    						<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<br>
								   									<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
								   									<label style="font-size: 12px; ">[Disapproved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
							   			    					<%} %>
							   			    				<%} else if(carsIni.getAmount()!=null && (Double.parseDouble(carsIni.getAmount())>5000000 && Double.parseDouble(carsIni.getAmount())<=7500000)) {%>
							   			    					<% if(apprInfo[8].toString().equalsIgnoreCase("SAD")) {%> 
							   			    						<div style="font-size: 15px;"> Signature of Director</div>
							   			    						<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<br>
								   									<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
								   									<label style="font-size: 12px; ">[Approved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("SDD")) {%> 
							   			    						<div style="font-size: 15px;"> Signature of Director</div>
							   			    						<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<br>
								   									<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
								   									<label style="font-size: 12px; ">[Disapproved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("SAI")) {%>
							   			    						<div style="font-size: 15px;"> Signature of IFA, O/o DG (ECS)</div>
							   			    						<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<br>
								   									<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
								   									<label style="font-size: 12px; ">[Approved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("SDI")) {%> 
							   			    						<div style="font-size: 15px;"> Signature of IFA, O/o DG (ECS)</div>
							   			    						<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<br>
								   									<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
								   									<label style="font-size: 12px; ">[Disapproved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("ADG")) {%>
							   			    						<div style="font-size: 15px;"> Signature of DG (ECS)</div>
							   			    						<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<br>
								   									<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
								   									<label style="font-size: 12px; ">[Approved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("DDG")) {%> 
							   			    						<div style="font-size: 15px;"> Signature of DG (ECS)</div>
							   			    						<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<br>
								   									<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
								   									<label style="font-size: 12px; ">[Disapproved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
							   			    					<%} %>
							   			    				<%} %>
							            			 	</div>	
							            			 <%} %>
													
			               		   					<!-- Remarks -->
			               		   					<div class="row mt-2">
														<%if(dpcSoCRemarksHistory.size()>0){ %>
															<div class="col-md-8" align="left" style="margin: 10px 0px 5px 25px; padding:0px;border: 1px solid black;border-radius: 5px;">
																<%if(dpcSoCRemarksHistory.size()>0){ %>
																	<table style="margin: 3px;padding: 0px">
																		<tr>
																			<td style="border:none;padding: 0px">
																			<h6 style="text-decoration: underline;">Remarks :</h6> 
																			</td>											
																		</tr>
																		<%for(Object[] obj : dpcSoCRemarksHistory){%>
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
															<%if(carsIni!=null && dpcsocforward.contains(carsIni.getCARSStatusCode()) && ( GHDPandC!=null && EmpId.equalsIgnoreCase(GHDPandC[0].toString()) ) ) {%>
																<div class="ml-2" align="left">
									   								<b >Remarks :</b><br>
									   								<textarea rows="3" cols="65" name="remarks" id="remarksarea"></textarea>
								         						</div>
																<button type="submit" class="btn btn-sm submit" id="" name="Action" formaction="DPCSoCApprovalSubmit.htm" formnovalidate="formnovalidate" value="A" onclick="return confirm('Are you Sure to Submit ?');" >Forward</button>
															<%} %>
															<%if(isApproval!=null && isApproval.equalsIgnoreCase("P")) {%>
																<div class="ml-2" align="left">
									   								<b >Remarks :</b><br>
									   								<textarea rows="3" cols="65" name="remarks" id="remarksarea"></textarea>
								         						</div>
								         						<%if(carsIni!=null && approvebutton.contains(carsIni.getCARSStatusCode())) {%>
								         						<button type="submit" class="btn btn-sm btn-success" id="finalSubmission" formaction="DPCSoCApprovalSubmit.htm" name="Action" value="A" onclick="return confirm('Are You Sure To Approve?');" style="font-weight: 600;">
										    						Approve	
									      						</button>
									      						
									      						<button type="submit" class="btn btn-sm btn-danger" id="finalSubmission" formaction="DPCSoCApprovalSubmit.htm" name="Action" value="D" onclick="return disapprove();" style="font-weight: 600;">
										   	 						Disapprove	
									      						</button>
									      						<button type="submit" class="btn btn-sm btn-danger" id="finalSubmission" formaction="DPCSoCApprovalSubmit.htm" name="Action" value="R" onclick="return validateTextBox();" style="font-weight: 600;background-color: #ff2d00;">
										 							Return
																</button>
								         						<%} else{%>
																<button type="submit" class="btn btn-sm btn-success" id="finalSubmission" formaction="DPCSoCApprovalSubmit.htm" name="Action" value="A" onclick="return confirm('Are You Sure To Recommend?');" style="font-weight: 600;">
										    						Recommend	
									      						</button>
									      						
									      						<button type="submit" class="btn btn-sm btn-danger" id="finalSubmission" formaction="DPCSoCApprovalSubmit.htm" name="Action" value="R" onclick="return validateTextBox();" style="font-weight: 600;background-color: #ff2d00;">
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
               							<h4 style="font-weight: bold;color: red;">Please fill the SoC Details..!</h4>
               						</div>
               					<%} %>
               					
               					<div style="display: flex;justify-content: space-between;">
               						<div></div>
		               				<div>
		               					<%if(carsIni!=null && isApproval==null) {%>
		               					<div class="row"  >
				 		  					<div class="col-md-12" style="text-align: center;"><b>Approval Flow For DP&C SoC Forward</b></div>
				 	    				</div>
				 	    				<div class="row"  style="text-align: center; padding-top: 10px; padding-bottom: 15px; " >
			              					<table align="center"  >
			               						<tr>
			               							<td class="trup" style="background: linear-gradient(to top, #3c96f7 10%, transparent 115%);">
			                							GH-DP&C - <%if(GHDPandC!=null) {%><%=GHDPandC[1] %> <%} else{%>GH-DP&C<%} %>
			                						</td>
			                		
		                        					<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						
			                						<td class="trup" style="background: linear-gradient(to top, #eb76c3 10%, transparent 115%);">
			                							GD-DP&C - <%if(GDDPandC!=null) {%><%=GDDPandC[1] %> <%} else{%>GD-DP&C<%} %>
			                	    				</td>
			                	    				
		                        					<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						
			                						<td class="trup" style="background: linear-gradient(to top, #b9bcb3 10%, transparent 115%);">
			                							<%if(carsIni.getFundsFrom().equalsIgnoreCase("0")) {%>
	                										Chairman RPB - <%if(ChairmanRPB!=null) {%><%=ChairmanRPB[1] %> <%} else{%>Chairman RPB<%} %>
	                									<%} else{%>
	                										PD - <%if(PDs!=null) {%><%=PDs[2] %><%} else{%>PD<%} %>
	                									<%} %>
			                	    				</td>
			                	    				
		                        					<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						
			                						<td class="trup" style="background: linear-gradient(to top, #857af4 10%, transparent 115%);">
			                							MMFD AG - <%if(MMFDAG!=null) {%><%=MMFDAG[1] %> <%} else{%>MMFD AG<%} %>
			                	    				</td>
			                	    				
		                        					<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						
			                						<td class="trup" style="background: linear-gradient(to top, #00c7e4 10%, transparent 115%);">
			                							GD DF&MM - <%if(GDDFandMM!=null) {%><%=GDDFandMM[1] %> <%} else{%>GD DF&MM<%} %>
			                	    				</td>
			                	    				
			                	    				<%if(carsIni.getAmount()!=null && Double.parseDouble(carsIni.getAmount())<=1000000) {%>
			                	    					<td rowspan="2">
			                								<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                							</td>
			                						
				                						<td class="trup" style="background: linear-gradient(to top, #09f21b 10%, transparent 115%);">
				                							DIRECTOR - <%if(Director!=null) {%><%=Director[1] %> <%} else{%>DIRECTOR<%} %>
				                	    				</td>
			                	    					
			                	    				<%} %>
			                	    				
			                	    				<%if(carsIni.getAmount()!=null && (Double.parseDouble(carsIni.getAmount())>1000000 && Double.parseDouble(carsIni.getAmount())<=5000000) ) {%>
			                	    					<td rowspan="2">
			                								<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                							</td>
			                						
				                						<td class="trup" style="background: linear-gradient(to top, #f28309 10%, transparent 115%);">
				                							IFA, O/o DG (ECS) - 
				                	    				</td>
				                	    				
				                	    				<td rowspan="2">
			                								<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                							</td>
			                						
				                						<td class="trup" style="background: linear-gradient(to top, #09f21b 10%, transparent 115%);">
				                							DIRECTOR - <%if(Director!=null) {%><%=Director[1] %> <%} else{%>DIRECTOR<%} %>
				                	    				</td>
			                	    				<%} %>
			                	    				
			                	    				<%if(carsIni.getAmount()!=null && (Double.parseDouble(carsIni.getAmount())>5000000 && Double.parseDouble(carsIni.getAmount())<=7500000)) {%>
				                	    				
				                	    				<td rowspan="2">
			                								<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                							</td>
			                						
				                						<td class="trup" style="background: linear-gradient(to top, #09f21b 10%, transparent 115%);">
				                							DIRECTOR - <%if(Director!=null) {%><%=Director[1] %> <%} else{%>DIRECTOR<%} %>
				                	    				</td>
				                	    				
				                	    				<td rowspan="2">
			                								<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                							</td>
			                						
				                						<td class="trup" style="background: linear-gradient(to top, #f28309 10%, transparent 115%);">
				                							IFA, O/o DG (ECS) - IFA, O/o DG (ECS)
				                	    				</td>
				                	    				
				                	    				<td rowspan="2">
			                								<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                							</td>
			                						
				                						<td class="trup" style="background: linear-gradient(to top, #ef5efa 10%, transparent 115%);">
				                							DG (ECS) - DG (ECS)
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
               					
		               	<%if(dpcTabId!=null && dpcTabId.equalsIgnoreCase("2")){ %> 
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
/* button disabling for SoC Approval */
<%if((dpcsocforward.contains(carsIni.getCARSStatusCode()))) {%>
$('.btn-soc').prop('disabled',false);
<%} else{%>
$('.btn-soc').prop('disabled',true);
<%} %>

/* tabs hiding for SoC approval */
<%if(isApproval!=null && (isApproval.equalsIgnoreCase("P") || isApproval.equalsIgnoreCase("Q") )) {%>
   $('.navigation_btn').hide();
   $('#nav-socdetails').hide();
<%} %>
</script>
</body>
</html>
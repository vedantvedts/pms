<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.IndianRupeeFormat"%>
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
<link href="${projetdetailscss}" rel="stylesheet" />
<%-- <spring:url value="/resources/ckeditor/ckeditor.js" var="ckeditor" />
<spring:url value="/resources/ckeditor/contents.css" var="contentCss" />
<script src="${ckeditor}"></script>
<link href="${contentCss}" rel="stylesheet" /> --%>
<spring:url value="/resources/summernote-lite.js" var="SummernoteJs" />
<spring:url value="/resources/summernote-lite.css" var="SummernoteCss" />
<script src="${SummernoteJs}"></script>
<link href="${SummernoteCss}" rel="stylesheet" />
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
   font-family : "Lato", Arial, sans-serif ;
   overflow-x: hidden;
}

input,select,table,div,label,span {
font-family : "Lato", Arial, sans-serif ;
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
	vertical-align: top;
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

.externalapproval{
border : 1px solid #ced4da;
padding: 20px;
border-radius : 0.25rem;
width: 70%;
margin-left: -30%;
}

#alldocstable {
	width : 70%;
	/* border : 1px solid black; */
	margin-top : 1.5rem;
	font-size: 15px;
	margin-left: 10rem;
}
#alldocstable th{
	border : 1px solid black;
	text-align: center;
	padding : 5px;
}
#alldocstable td{
	border : 1px solid black;
	text-align: left;
	padding : 3px;
	vertical-align: top;
}
#alldocstable td:first-child,#alldocstable td:nth-child(3){ 
	text-align: center; 
}

.cssideheading{
	font-size: 17px;
}

.cssideheadingdata{
	font-size: 16px !important;
	color: white;
	font
}

#select2-LabCode-container,#select2-approverEmpId-container{
	text-align: left;
}

/* Summer Note styles */
.note-editor {
	width: 95% !important;
	margin: 1rem 2.5rem;
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
expenditure = expenditure!=null?expenditure.replaceAll("\n", "<br>"):expenditure;

List<String> dpcsocforwardstatus = Arrays.asList("SFG","SFP","SID","SGR","SPR","SRC","SRM","SRF","SRR","SRI","RDG","SRJ","SRS","SRD");
List<String> dpcsocapprovestatus = Arrays.asList("SDF","SAD","SAI","ADG","SAJ","SAS");
List<String> dpcsocexternalapprovestatus = Arrays.asList("SAI","ADG","SAJ","SAS");

Object[] emp = (Object[])request.getAttribute("EmpData");
Object[] PDs = (Object[])request.getAttribute("PDEmpIds");

Object[] GHDPandC = (Object[])request.getAttribute("GHDPandC");
Object[] GDDPandC = (Object[])request.getAttribute("GDDPandC");
Object[] ChairmanRPB = (Object[])request.getAttribute("ChairmanRPB");
Object[] MMFDAG = (Object[])request.getAttribute("MMFDAG");
Object[] GDDFandMM = (Object[])request.getAttribute("GDDFandMM");
Object[] Director = (Object[])request.getAttribute("Director");

String EmpId = ((Long) session.getAttribute("EmpId")).toString();

String statuscode = carsIni.getCARSStatusCode();
String statuscodeNext = carsIni.getCARSStatusCodeNext();
String amount = carsSoC.getSoCAmount();
String carsInitiationId = carsIni!=null?carsIni.getCARSInitiationId()+"":"0";
String carsSoCId = carsSoC!=null?carsSoC.getCARSSoCId()+"":"0";

List<Object[]> labList = (List<Object[]>)request.getAttribute("LabList");
%>

<% 
    String ses = (String) request.getParameter("result");
    String ses1 = (String) request.getParameter("resultfail");
    if (ses1 != null) { %>
    <div align="center">
        <div class="alert alert-danger" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses1) %>
        </div>
    </div>
<% }if (ses != null) { %>
    <div align="center">
        <div class="alert alert-success" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses) %>
        </div>
    </div>
<% } %>

<div class="container-fluid">
	<div class="row">
   		<div class="col-md-12">
       		<div class="card slider">
       			<!-- This is for Slider Headers -->
         		<div class="card-header slider_header" style="padding:0px; font-size: 12px!important; height: 0%;">
             		<h3 class="category">D-P&C SoC Details - 
             		
             			<button type="button" class="btn btn-sm btn-info" style="text-align: left;min-width: 80%;max-width: 80%;background: darkcyan;border: darkcyan;white-space: normal;">
             				<div>
					        	<div class="row">
					        		<div class="col-md-1">
					        			<span class="cssideheading">Title:</span>
					                </div>
					            	<div class="col-md-11" style="margin-left: -5%;">
					                	<span class="cssideheadingdata"><%if(carsIni!=null && carsIni.getInitiationTitle()!=null) {%><%=StringEscapeUtils.escapeHtml4(carsIni.getInitiationTitle()) %> <%} else{%>-<%} %></span>
					                </div>
					                
					            </div>
					                	
					            <div class="row">
					            	<div class="col-md-4">
					                	<span class="cssideheading">CARS. No:</span>
					                	&emsp;<span class="cssideheadingdata"><%if(carsIni!=null && carsIni.getCARSNo()!=null) {%><%=StringEscapeUtils.escapeHtml4(carsIni.getCARSNo()) %> <%} else{%>-<%} %></span>
					            	</div>
					            <div class="col-md-1"></div>
					            <div class="col-md-3">
					            	<span class="cssideheading">Funds from:</span>
					                &emsp;<span class="cssideheadingdata">
					                	<%if(carsIni!=null && carsIni.getFundsFrom()!=null && carsIni.getFundsFrom().equalsIgnoreCase("0")) {%>
					                		Buildup
					                	<%} else{%>
					                		<%if(PDs!=null && PDs[3]!=null) {%><%=StringEscapeUtils.escapeHtml4(PDs[3].toString())+" ("+PDs[0]!=null?StringEscapeUtils.escapeHtml4(PDs[0].toString()): " - "+")" %><%} %>
					                	<%} %>
					                	</span>
					            </div>
					            <div class="col-md-1"></div>
					            	<div class="col-md-3">
					                	<span class="cssideheading">Amount:</span>
					                		&emsp;<span class="cssideheadingdata">
					                		<%if(carsSoC!=null && carsSoC.getSoCAmount()!=null) {%>
					                			<%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(StringEscapeUtils.escapeHtml4(carsSoC.getSoCAmount()))) %>
					                		<%} else{%>-<%} %>
					                	</span>
					                </div>
					            </div>
					                		
					        </div>
             			</button>
             			
             			<a class="btn btn-info btn-sm  shadow-nohover back"
             			<%if(isApproval!=null && isApproval.equalsIgnoreCase("P") ) {%>
               				href="CARSRSQRApprovals.htm"
               			<%} else if(isApproval!=null && isApproval.equalsIgnoreCase("Q") ) {%>
               				href="CARSRSQRApprovals.htm?val=app"
               			<%} else {%>
             			    href="CARSRSQRApprovedList.htm?AllListTabId=2"
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
            			
            			<li class="nav-item" id="nav-alldocs">
		            	     <%if(dpcTabId!=null && dpcTabId.equalsIgnoreCase("3")){ %>
		              			<a class="nav-link active" data-toggle="tab" href="#alldocs" id="nav"role="tab" >
		              		<%}else{ %>
		              			<a class="nav-link" data-toggle="tab" href="#alldocs" role="tab" >
		               		<%} %>
                  				All Docs
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
               			    					<div class="column b" style="width: 94.5%;border-top-left-radius: 5px;border-top-right-radius: 5px;">
               			    						<label class="control-label">Introduction</label><span class="mandatory">*</span>
               			    					</div>
               			    				</div>
               			     				<div class="row details" style="margin-top: -1%;">
                       							
                             						<%-- <textarea  class="form-control form-control" name="dpcIntroduction" id="dpcIntroduction" rows="4" cols="65" style="font-size: 15px;"
                             		 				 placeholder="Enter SoC Introduction" required><%if(carsSoC!=null && carsSoC.getDPCIntroduction()!=null){ %><%=carsSoC.getDPCIntroduction()%><%} %></textarea> --%>
                       								<div class="column b" style="width: 94.5%;">
														<div id="dpcIntroductionnote" class="center"> </div>
														<%-- <input type="hidden" id="dpcIntroductionhidden" value="<%if(carsSoC!=null && carsSoC.getDPCIntroduction()!=null){ %><%=carsSoC.getDPCIntroduction()%><%} %>"> --%>
														<textarea id="dpcIntroductionhidden" style="display:none;"><%if(carsSoC!=null && carsSoC.getDPCIntroduction()!=null){ %><%=StringEscapeUtils.escapeHtml4(carsSoC.getDPCIntroduction())%><%} %></textarea>
														<textarea name="dpcIntroduction" style="display:none;"></textarea>
                       							</div>
                        					</div>
               			    				<!-- Second row of SoC Details  -->
               			     				<div class="row details">
                       							<div class="column b" style="width: 47.25%;border-bottom-left-radius: 5px;border-bottom-right-radius: 5px;">
                           							<label class="control-label">Expenditure Head</label><span class="mandatory">*</span>
                             						<textarea  class="form-control form-control" name="dpcExpenditure" id="dpcExpenditure" rows="4" cols="65" style="font-size: 15px;" maxlength="2000"
                             		 				 placeholder="Enter Expenditure Head" required><%if(carsSoC!=null && carsSoC.getDPCExpenditure()!=null){ %><%=StringEscapeUtils.escapeHtml4(carsSoC.getDPCExpenditure())%><%} %></textarea>
                       							</div>
                       							<div class="column b" style="width: 47.25%;border-bottom-left-radius: 5px;border-bottom-right-radius: 5px;">
                           							<label class="control-label">Additional Points</label>
                             						<textarea  class="form-control form-control" name="dpcAdditional" id="dpcAdditional" rows="4" cols="65" style="font-size: 15px;" maxlength="1000"
                             		 				 placeholder="Enter Additional Points ( if any )" ><%if(carsSoC!=null && carsSoC.getDPCAdditional()!=null){ %><%=StringEscapeUtils.escapeHtml4(carsSoC.getDPCAdditional())%><%} %></textarea>
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
            						<a class="btn btn-info btn-sm  shadow-nohover back" href="CARSRSQRApprovedList.htm?AllListTabId=2" style="color: white!important">Back</a>
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
				               		   							<p style="text-indent: 21px;font-size: 15px;"><%=carsSoC.getDPCIntroduction()!=null?StringEscapeUtils.escapeHtml4(carsSoC.getDPCIntroduction()): " - " %></p>
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
						               		   							<td><%=carsIni.getInitiationTitle()!=null?StringEscapeUtils.escapeHtml4(carsIni.getInitiationTitle()): " - " %></td>
						               		   						</tr>
						               		   						<tr>
						               		   							<td>2.</td>
						               		   							<td>File No</td>
						               		   							<td><%=carsIni.getCARSNo()!=null?StringEscapeUtils.escapeHtml4(carsIni.getCARSNo()): " - " %></td>
						               		   						</tr>
						               		   						<!-- <tr>
						               		   							<td>3.</td>
						               		   							<td>Deliverables</td>
						               		   							<td>-do-</td>
						               		   						</tr> -->
						               		   						<tr>
						               		   							<td>3.</td>
						               		   							<td>Service Type</td>
						               		   							<td>General Revenue</td>
						               		   						</tr>
						               		   						<tr>
						               		   							<td>4.</td>
						               		   							<td>Estimated cost of service (&#8377;)</td>
						               		   							<td><%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(StringEscapeUtils.escapeHtml4(amount))) %></td>
						               		   						</tr>
						               		   						<tr>
						               		   							<td>5.</td>
						               		   							<td>CARS PDC</td>
						               		   							<td><%=carsSoC.getSoCDuration()!=null?StringEscapeUtils.escapeHtml4(carsSoC.getSoCDuration()): " - " %></td>
						               		   						</tr>
						               		   						<tr>
						               		   							<td>6.</td>
						               		   							<td>Expenditure Head</td>
						               		   							<td><%=expenditure!=null?StringEscapeUtils.escapeHtml4(expenditure): " - " %></td>
						               		   						</tr>
						               		   						<tr>
						               		   							<td>7.</td>
						               		   							<td>CFA approval as per DFP</td>
						               		   							<td>Under Sl. No: 2.4 of DFP dated 18 Dec 2019</td>
						               		   						</tr>
						               		   						<tr>
						               		   							<td>8.</td>
						               		   							<td>Additional Points</td>
						               		   							<td><%if(carsSoC.getDPCAdditional()!=null && !carsSoC.getDPCAdditional().isEmpty()) {%><%=StringEscapeUtils.escapeHtml4(carsSoC.getDPCAdditional()) %><%} else{%>-<%} %></td>
						               		   						</tr>
			               		   								</table>
			               		   							</div>
			               		   						</div>
			               		   						
			               		   						<div>
			               		   							<h5 class="socheading"><span>3.</span> <span style="text-decoration: underline;">Description</span></h5>
				               		   						<div class="soccontent">
				               		   							<p style="font-size: 15px;">
				               		   								<%=carsIni.getRSPInstitute()!=null?StringEscapeUtils.escapeHtml4(carsIni.getRSPInstitute()): " - "+", "+carsIni.getRSPCity()!=null?StringEscapeUtils.escapeHtml4(carsIni.getRSPCity()): " - " %> has submitted the &#39;Summary of Offer&#39; for Rs <span class="textunderline"><%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(StringEscapeUtils.escapeHtml4(amount))) %></span>
				               		   								(inclusive of GST) for duration of <span class="textunderline"><%=carsSoC.getSoCDuration()!=null?StringEscapeUtils.escapeHtml4(carsSoC.getSoCDuration()): " - " %></span> months. Required schedule of payments is given below.
				               		   							</p>
				               		   							<table id="milestonestable">
				               		   								<tr>
				               		   								  <th style="width: 10%;">Milestone No.</th>
				               		   								  <th style="width: 28%;">Task Description</th>
				               		   								  <th style="width: 5%;">Months</th>
				               		   								  <th style="width: 25%;">Deliverables</th>
				               		   								  <th style="width: 5%;">Payment <br>( In % )</th>
				               		   								  <th style="width: 10%;">Amount (&#8377;)</th>
				               		   								  <th style="width: 15%;">Remarks</th>
				               		   								</tr>
				               		   								<%if(milestones!=null && milestones.size()>0) {
				               		   									for(CARSSoCMilestones mil : milestones){
				               		   						
				               		   								%>
					               		   								<tr>
					               		   									<td style="width: 10%;text-align: center;"><%=mil.getMilestoneNo()!=null?StringEscapeUtils.escapeHtml4(mil.getMilestoneNo()): " - " %></td>
					               		   									<td style="width: 28%;"><%=mil.getTaskDesc()!=null?StringEscapeUtils.escapeHtml4(mil.getTaskDesc()): " - " %></td>
					               		   									<td style="width: 5%;text-align: center;"><%="T0 + "+mil.getMonths()!=null?StringEscapeUtils.escapeHtml4(mil.getMonths()): " - " %></td>
					               		   									<td style="width: 25%;"><%=mil.getDeliverables()!=null?StringEscapeUtils.escapeHtml4(mil.getDeliverables()): " - " %></td>
					               		   									<td style="width: 5%;text-align: center;"><%=mil.getPaymentPercentage()!=null?StringEscapeUtils.escapeHtml4(mil.getPaymentPercentage()): " - " %></td>
					               		   									<td style="width: 10%;text-align: right;"><%if(mil.getActualAmount()!=null) {%><%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(StringEscapeUtils.escapeHtml4(mil.getActualAmount()))) %><%} else{%>-<%} %></td>
					               		   									<td style="width: 15%;"><%if(mil.getPaymentTerms()!=null) {%><%=StringEscapeUtils.escapeHtml4(mil.getPaymentTerms()) %><%} else{%>-<%} %></td>
					               		   								</tr>
				               		   								<%}} %>
				               		   								
				               		   							</table>
				               		   							<br>
				               		   							<p style="font-size: 15px;">
				               		   								The Contract for Acquisition of Professional Services to be placed on <%=carsIni.getRSPInstitute()!=null?StringEscapeUtils.escapeHtml4(carsIni.getRSPInstitute()): " - "+", "+carsIni.getRSPCity()!=null?StringEscapeUtils.escapeHtml4(carsIni.getRSPCity()): " - " %> (CARS) file is submitted with the following documents.
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
				               		   							<%if(carsSoC!=null && carsSoC.getDPCApprovalSought()!=null && !carsSoC.getDPCApprovalSought().isEmpty() && ( GHDPandC!=null && EmpId.equalsIgnoreCase(GHDPandC[0].toString()) ) ) {%>
				               		   								<textarea class="form-control" name="approvalSought" rows="4" required><%=StringEscapeUtils.escapeHtml4(carsSoC.getDPCApprovalSought()) %></textarea>
				               		   							<%} else if(carsSoC!=null && carsSoC.getDPCApprovalSought()!=null && !carsSoC.getDPCApprovalSought().isEmpty() && ( GHDPandC!=null && !EmpId.equalsIgnoreCase(GHDPandC[0].toString()) ) ){%>
					               		   							<p style="text-indent: 21px;font-size: 15px;">
																		<%=StringEscapeUtils.escapeHtml4(carsSoC.getDPCApprovalSought().replaceAll("\n", "<br>")) %>
																	</p>
				               		   							<%} else{%>
				               		   								<textarea class="form-control" name="approvalSought" rows="4" maxlength="3000" required>The case is being submitted along with the above-mentioned documents for obtaining the Concurrence cum Financial sanction and approval from Competent Financial Authority (CFA) for placement of Contract for Acquisition of Research Services (CARS) on <%=carsIni.getRSPInstitute()!=null?StringEscapeUtils.escapeHtml4(carsIni.getRSPInstitute()): " - "+", "+carsIni.getRSPCity()!=null?StringEscapeUtils.escapeHtml4(carsIni.getRSPCity()): " - " %> at a cost of Rs. <%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(StringEscapeUtils.escapeHtml4(amount))) %> please.</textarea>
				               		   							<%} %>
				               		   						</div>
			               		   						</div>
			               		   						
			               		   					</div>
			               		   					<br>
			               		   					
			               		   					<!-- Signatures and timestamps -->
			               		   					
													<div style="width: 96%;text-align: right;margin-right: 10px;line-height: 10px;margin-top: 30px;">
		               								 	<div style="font-size: 15px;"> Signature of GH-DP&C</div>
						               					<%for(Object[] apprInfo : dpcSoCApprovalEmpData){ %>
						   			   					<%if(apprInfo[8].toString().equalsIgnoreCase("SFD")){ %>
						   								<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]!=null?StringEscapeUtils.escapeHtml4(apprInfo[2].toString()): " - "%></label>,<!-- <br> -->
						   								<label style="text-transform: capitalize;"><%=apprInfo[3]!=null?StringEscapeUtils.escapeHtml4(apprInfo[3].toString()): " - "%></label><br>
						   								<label style="font-size: 12px; ">[Forwarded On:&nbsp; <%= apprInfo[4]!=null?fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(0, 10)))  +" "+StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(11,19)): " - " %>]</label>
						   			    				<%break;}} %>  
							            			 </div>
							            			 
							            			 <%for(Object[] apprInfo : dpcSoCApprovalEmpData) {%>
							            			 	<div style="width: 96%;text-align: left;margin-left: 10px;line-height: 10px;margin-top: 50px;">
							            			 		
							            			 		<%if(apprInfo[8].toString().equalsIgnoreCase("SGD")){ %>
							            			 			<div style="font-size: 15px;"> Signature of GD-DP&C</div>
								   								<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]!=null?StringEscapeUtils.escapeHtml4(apprInfo[2].toString()): " - "%></label>,<!-- <br> -->
								   								<label style="text-transform: capitalize;"><%=apprInfo[3]!=null?StringEscapeUtils.escapeHtml4(apprInfo[3].toString()): " - "%></label><br>
								   								<label style="font-size: 12px; ">[Recommended On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(0, 10)))  +" "+StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(11,19)): " - "  %>]</label>
							   			    				<%} else if(apprInfo[8].toString().equalsIgnoreCase("SPD")) {%> 
							   			    					<div style="font-size: 15px;"> Signature of PD</div>
							   			    					<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]!=null?StringEscapeUtils.escapeHtml4(apprInfo[2].toString()): " - "%></label>,<!-- <br> -->
								   								<label style="text-transform: capitalize;"><%=apprInfo[3]!=null?StringEscapeUtils.escapeHtml4(apprInfo[3].toString()): " - "%></label><br>
								   								<label style="font-size: 12px; ">[Recommended On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(0, 10)))  +" "+StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(11,19)): " - " %>]</label>
							   			    				<%} else if(apprInfo[8].toString().equalsIgnoreCase("SCR")) {%> 
							   			    					<div style="font-size: 15px;"> Signature of Chairman RPB</div>
							   			    					<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]!=null?StringEscapeUtils.escapeHtml4(apprInfo[2].toString()): " - "%></label>,<!-- <br> -->
								   								<label style="text-transform: capitalize;"><%=apprInfo[3]!=null?StringEscapeUtils.escapeHtml4(apprInfo[3].toString()): " - "%></label><br>
								   								<label style="font-size: 12px; ">[Recommended On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(0, 10)))  +" "+StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(11,19)): " - "  %>]</label>
							   			    				<%} else if(apprInfo[8].toString().equalsIgnoreCase("SMA")) {%> 
							   			    					<div style="font-size: 15px;"> Signature of MMFD AG</div>
							   			    					<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]!=null?StringEscapeUtils.escapeHtml4(apprInfo[2].toString()): " - "%></label>,<!-- <br> -->
								   								<label style="text-transform: capitalize;"><%=apprInfo[3]!=null?StringEscapeUtils.escapeHtml4(apprInfo[3].toString()): " - "%></label><br>
								   								<label style="font-size: 12px; ">[Recommended On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(0, 10)))  +" "+StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(11,19)): " - " %>]</label>
							   			    				<%} else if(apprInfo[8].toString().equalsIgnoreCase("SDF")) {%> 
							   			    					<div style="font-size: 15px;"> Signature of GD DF&MM</div>
							   			    					<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]!=null?StringEscapeUtils.escapeHtml4(apprInfo[2].toString()): " - "%></label>,<!-- <br> -->
								   								<label style="text-transform: capitalize;"><%=apprInfo[3]!=null?StringEscapeUtils.escapeHtml4(apprInfo[3].toString()): " - "%></label><br>
								   								<label style="font-size: 12px; ">[Recommended On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(0, 10)))  +" "+StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(11,19)): " - "  %>]</label>
							   			    					
							   			    				<%} %>
							   			    				<%if(amount!=null && Double.parseDouble(amount)<=1000000) {%>
							   			    					<% if(apprInfo[8].toString().equalsIgnoreCase("SAD")) {%> 
							   			    						<div style="font-size: 15px;"> Signature of Director</div>
							   			    						<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]!=null?StringEscapeUtils.escapeHtml4(apprInfo[2].toString()): " - "%></label>,<!-- <br> -->
								   									<label style="text-transform: capitalize;"><%=apprInfo[3]!=null?StringEscapeUtils.escapeHtml4(apprInfo[3].toString()): " - "%></label><br>
								   									<label style="font-size: 12px; ">[Approved On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(0, 10)))  +" "+StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(11,19)): " - "  %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("SDD")) {%> 
							   			    						<div style="font-size: 15px;"> Signature of Director</div>
							   			    						<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]!=null?StringEscapeUtils.escapeHtml4(apprInfo[2].toString()): " - "%></label>,<!-- <br> -->
								   									<label style="text-transform: capitalize;"><%=apprInfo[3]!=null?StringEscapeUtils.escapeHtml4(apprInfo[3].toString()): " - "%></label><br>
								   									<label style="font-size: 12px; ">[Disapproved On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(0, 10)))  +" "+StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(11,19)): " - "  %>]</label>
							   			    					<%} %>
							   			    				<%} else if(amount!=null && (Double.parseDouble(amount)>1000000 && Double.parseDouble(amount)<=5000000) ) {%>
							   			    					<% if(apprInfo[8].toString().equalsIgnoreCase("SAI")) {%>
							   			    						<div style="font-size: 15px;"> Signature of IFA, O/o DG (ECS)</div>
							   			    						<label style="text-transform: capitalize;margin-top: 15px !important;"><%if(apprInfo[2]!=null) {%> <%=StringEscapeUtils.escapeHtml4(apprInfo[2].toString())%> <%} else{%><%=apprInfo[10]!=null?StringEscapeUtils.escapeHtml4(apprInfo[10].toString()): " - " %> <%} %></label>,<!-- <br> -->
								   									<label style="text-transform: capitalize;"><%if(apprInfo[3]!=null) {%> <%=StringEscapeUtils.escapeHtml4(apprInfo[3].toString())%> <%} else{%>IFA, O/o DG (ECS) <%} %></label><br>
								   									<label style="font-size: 12px; ">[Approved On:&nbsp; <%=  apprInfo[4]!=null?fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(0, 10))) : " - "  %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("SDI")) {%> 
							   			    						<div style="font-size: 15px;"> Signature of IFA, O/o DG (ECS)</div>
							   			    						<label style="text-transform: capitalize;margin-top: 15px !important;"><%if(apprInfo[2]!=null) {%> <%=StringEscapeUtils.escapeHtml4(apprInfo[2].toString())%> <%} else{%><%=apprInfo[10]!=null?StringEscapeUtils.escapeHtml4(apprInfo[10].toString()): " - " %> <%} %></label>,<!-- <br> -->
								   									<label style="text-transform: capitalize;"><%if(apprInfo[3]!=null) {%> <%=StringEscapeUtils.escapeHtml4(apprInfo[3].toString())%> <%} else{%>IFA, O/o DG (ECS) <%} %></label><br>
								   									<label style="font-size: 12px; ">[Disapproved On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(0, 10))) : " - "   %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("SAD")) {%> 
							   			    						<div style="font-size: 15px;"> Signature of Director</div>
							   			    						<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]!=null?StringEscapeUtils.escapeHtml4(apprInfo[2].toString()): " - "%></label>,<!-- <br> -->
								   									<label style="text-transform: capitalize;"><%=apprInfo[3]!=null?StringEscapeUtils.escapeHtml4(apprInfo[3].toString()): " - "%></label><br>
								   									<label style="font-size: 12px; ">[Approved On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(0, 10)))  +" "+StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(11,19)): " - "  %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("SDD")) {%> 
							   			    						<div style="font-size: 15px;"> Signature of Director</div>
							   			    						<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]!=null?StringEscapeUtils.escapeHtml4(apprInfo[2].toString()): " - "%></label>,<!-- <br> -->
								   									<label style="text-transform: capitalize;"><%=apprInfo[3]!=null?StringEscapeUtils.escapeHtml4(apprInfo[3].toString()): " - "%></label><br>
								   									<label style="font-size: 12px; ">[Disapproved On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(0, 10)))  +" "+StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(11,19)): " - " %>]</label>
							   			    					<%} %>
							   			    				<%} else if(amount!=null && (Double.parseDouble(amount)>5000000 && Double.parseDouble(amount)<=30000000)) {%>
							   			    					<% if(apprInfo[8].toString().equalsIgnoreCase("SAD")) {%> 
							   			    						<div style="font-size: 15px;"> Signature of Director</div>
							   			    						<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]!=null?StringEscapeUtils.escapeHtml4(apprInfo[2].toString()): " - "%></label>,<!-- <br> -->
								   									<label style="text-transform: capitalize;"><%=apprInfo[3]!=null?StringEscapeUtils.escapeHtml4(apprInfo[3].toString()): " - "%></label><br>
								   									<label style="font-size: 12px; ">[Approved On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(0, 10)))  +" "+StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(11,19)): " - "  %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("SDD")) {%> 
							   			    						<div style="font-size: 15px;"> Signature of Director</div>
							   			    						<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]!=null?StringEscapeUtils.escapeHtml4(apprInfo[2].toString()): " - "%></label>,<!-- <br> -->
								   									<label style="text-transform: capitalize;"><%=apprInfo[3]!=null?StringEscapeUtils.escapeHtml4(apprInfo[3].toString()): " - "%></label><br>
								   									<label style="font-size: 12px; ">[Disapproved On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(0, 10)))  +" "+StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(11,19)): " - " %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("SAI")) {%>
							   			    						<div style="font-size: 15px;"> Signature of IFA, O/o DG (ECS)</div>
							   			    						<label style="text-transform: capitalize;margin-top: 15px !important;"><%if(apprInfo[2]!=null) {%> <%=StringEscapeUtils.escapeHtml4(apprInfo[2].toString())%> <%} else{%><%=apprInfo[10]!=null?StringEscapeUtils.escapeHtml4(apprInfo[10].toString()): " - " %> <%} %></label>,<!-- <br> -->
								   									<label style="text-transform: capitalize;"><%if(apprInfo[3]!=null) {%> <%=StringEscapeUtils.escapeHtml4(apprInfo[3].toString())%> <%} else{%>IFA, O/o DG (ECS) <%} %></label><br>
								   									<label style="font-size: 12px; ">[Approved On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(0, 10))) : " - "   %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("SDI")) {%> 
							   			    						<div style="font-size: 15px;"> Signature of IFA, O/o DG (ECS)</div>
							   			    						<label style="text-transform: capitalize;margin-top: 15px !important;"><%if(apprInfo[2]!=null) {%> <%=StringEscapeUtils.escapeHtml4(apprInfo[2].toString())%> <%} else{%><%=apprInfo[10]!=null?StringEscapeUtils.escapeHtml4(apprInfo[10].toString()): " - "  %> <%} %></label>,<!-- <br> -->
								   									<label style="text-transform: capitalize;"><%if(apprInfo[3]!=null) {%> <%=StringEscapeUtils.escapeHtml4(apprInfo[3].toString())%> <%} else{%>IFA, O/o DG (ECS) <%} %></label><br>
								   									<label style="font-size: 12px; ">[Disapproved On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(0, 10))) : " - "  %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("ADG")) {%>
							   			    						<div style="font-size: 15px;"> Signature of DG (ECS)</div>
							   			    						<label style="text-transform: capitalize;margin-top: 15px !important;"><%if(apprInfo[2]!=null) {%> <%=StringEscapeUtils.escapeHtml4(apprInfo[2].toString())%> <%} else{%><%=apprInfo[10]!=null?StringEscapeUtils.escapeHtml4(apprInfo[10].toString()): " - "  %> <%} %></label>,<!-- <br> -->
								   									<label style="text-transform: capitalize;"><%if(apprInfo[3]!=null) {%> <%=StringEscapeUtils.escapeHtml4(apprInfo[3].toString())%> <%} else{%>DG (ECS) <%} %></label><br>
								   									<label style="font-size: 12px; ">[Approved On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(0, 10))) : " - "  %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("DDG")) {%> 
							   			    						<div style="font-size: 15px;"> Signature of DG (ECS)</div>
							   			    						<label style="text-transform: capitalize;margin-top: 15px !important;"><%if(apprInfo[2]!=null) {%> <%=StringEscapeUtils.escapeHtml4(apprInfo[2].toString())%> <%} else{%><%=apprInfo[10]!=null?StringEscapeUtils.escapeHtml4(apprInfo[10].toString()): " - "  %> <%} %></label>,<!-- <br> -->
								   									<label style="text-transform: capitalize;"><%if(apprInfo[3]!=null) {%> <%=StringEscapeUtils.escapeHtml4(apprInfo[3].toString())%> <%} else{%>DG (ECS) <%} %></label><br>
								   									<label style="font-size: 12px; ">[Disapproved On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(0, 10))) : " - "   %>]</label>
							   			    					<%} %>
							   			    				<%} else if(amount!=null && (Double.parseDouble(amount)>30000000)) {%>	
							   			    					<% if(apprInfo[8].toString().equalsIgnoreCase("SAD")) {%> 
							   			    						<div style="font-size: 15px;"> Signature of Director</div>
							   			    						<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]!=null?StringEscapeUtils.escapeHtml4(apprInfo[2].toString()): " - "%></label>,<!-- <br> -->
								   									<label style="text-transform: capitalize;"><%=apprInfo[3]!=null?StringEscapeUtils.escapeHtml4(apprInfo[3].toString()): " - "%></label><br>
								   									<label style="font-size: 12px; ">[Approved On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(0, 10)))  +" "+StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(11,19)): " - " %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("SDD")) {%> 
							   			    						<div style="font-size: 15px;"> Signature of Director</div>
							   			    						<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]!=null?StringEscapeUtils.escapeHtml4(apprInfo[2].toString()): " - "%></label>,<!-- <br> -->
								   									<label style="text-transform: capitalize;"><%=apprInfo[3]!=null?StringEscapeUtils.escapeHtml4(apprInfo[3].toString()): " - "%></label><br>
								   									<label style="font-size: 12px; ">[Disapproved On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(0, 10)))  +" "+StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(11,19)): " - "  %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("SAJ")) {%>
							   			    						<div style="font-size: 15px;"> Signature of JSA</div>
							   			    						<label style="text-transform: capitalize;margin-top: 15px !important;"><%if(apprInfo[2]!=null) {%> <%=StringEscapeUtils.escapeHtml4(apprInfo[2].toString())%> <%} else{%><%=apprInfo[10] !=null?StringEscapeUtils.escapeHtml4(apprInfo[10].toString()): " - " %> <%} %></label>,<!-- <br> -->
								   									<label style="text-transform: capitalize;"><%if(apprInfo[3]!=null) {%> <%=StringEscapeUtils.escapeHtml4(apprInfo[3].toString())%> <%} else{%>JSA <%} %></label><br>
								   									<label style="font-size: 12px; ">[Approved On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(0, 10))) : " - "   %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("SDJ")) {%> 
							   			    						<div style="font-size: 15px;"> Signature of JSA</div>
							   			    						<label style="text-transform: capitalize;margin-top: 15px !important;"><%if(apprInfo[2]!=null) {%> <%=StringEscapeUtils.escapeHtml4(apprInfo[2].toString())%> <%} else{%><%=apprInfo[10] !=null?StringEscapeUtils.escapeHtml4(apprInfo[10].toString()): " - " %> <%} %></label>,<!-- <br> -->
								   									<label style="text-transform: capitalize;"><%if(apprInfo[3]!=null) {%> <%=StringEscapeUtils.escapeHtml4(apprInfo[3].toString())%> <%} else{%>JSA <%} %></label><br>
								   									<label style="font-size: 12px; ">[Disapproved On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(0, 10))) : " - "   %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("SAS")) {%>
							   			    						<div style="font-size: 15px;"> Signature of SECY</div>
							   			    						<label style="text-transform: capitalize;margin-top: 15px !important;"><%if(apprInfo[2]!=null) {%> <%=StringEscapeUtils.escapeHtml4(apprInfo[2].toString())%> <%} else{%><%=apprInfo[10]!=null?StringEscapeUtils.escapeHtml4(apprInfo[10].toString()): " - "  %> <%} %></label>,<!-- <br> -->
								   									<label style="text-transform: capitalize;"><%if(apprInfo[3]!=null) {%> <%=StringEscapeUtils.escapeHtml4(apprInfo[3].toString())%> <%} else{%>SECY <%} %></label><br>
								   									<label style="font-size: 12px; ">[Approved On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(0, 10))) : " - "   %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("SDS")) {%> 
							   			    						<div style="font-size: 15px;"> Signature of SECY</div>
							   			    						<label style="text-transform: capitalize;margin-top: 15px !important;"><%if(apprInfo[2]!=null) {%> <%=StringEscapeUtils.escapeHtml4(apprInfo[2].toString())%> <%} else{%><%=apprInfo[10]!=null?StringEscapeUtils.escapeHtml4(apprInfo[10].toString()): " - "  %> <%} %></label>,<!-- <br> -->
								   									<label style="text-transform: capitalize;"><%if(apprInfo[3]!=null) {%> <%=StringEscapeUtils.escapeHtml4(apprInfo[3].toString())%> <%} else{%>SECY <%} %></label><br>
								   									<label style="font-size: 12px; ">[Disapproved On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(0, 10))) : " - "   %>]</label>
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
																				<%if(obj[3]!=null) {%> <%=StringEscapeUtils.escapeHtml4(obj[3].toString())%> <%} else{%><%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()): " - " %> <%} %> &nbsp; :
																				<span style="border:none; color: blue;"><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %></span>
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
															<%if(statuscode!=null && dpcsocforwardstatus.contains(statuscode) && ( GHDPandC!=null && EmpId.equalsIgnoreCase(GHDPandC[0].toString()) ) ) {%>
																<div class="ml-2" align="left">
									   								<b >Remarks :</b><br>
									   								<textarea rows="3" cols="65" name="remarks" id="remarksarea" maxlength="1000" ></textarea>
								         						</div>
																<button type="submit" class="btn btn-sm submit" id="" name="Action" formaction="DPCSoCApprovalSubmit.htm" formnovalidate="formnovalidate" value="A" onclick="return confirm('Are you Sure to Submit ?');" >Forward</button>
															<%} %>
															<%if(isApproval!=null && isApproval.equalsIgnoreCase("P")) {%>
																<%if(dpcsocexternalapprovestatus.contains(statuscodeNext) ) {%>
																	<div class="row externalapproval" style="">
																		<div class="col-md-3">
																			<label class="control-label">Lab</label><span class="mandatory">*</span>
																			<select class="form-control selectdee" id="LabCode" name="LabCode" onchange="LabcodeSubmit()" data-live-search="true"  required="required">
		        																<option disabled="disabled" value="" selected="selected"> Select</option>
																					<%if (labList != null && labList.size() > 0) {
																						for (Object[] obj : labList) {
																					%>
																						<option value=<%=obj[2].toString()%>><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%></option>
																					<%}}%>
																					<option value="@EXP">Expert</option>
																			</select>
																		</div>
																		<div class="col-md-5">
																			<label class="control-label">Approval Officer</label><span class="mandatory">*</span>
				  															<select class="form-control selectdee" id="approverEmpId" name="approverEmpId" data-live-search="true" required>
				  																<option disabled="disabled" value="" selected="selected"> Select</option>
				  															</select>
																		</div>
																		<div class="col-md-4">
																			<label class="control-label" >Approval Date</label><span class="mandatory">*</span>
			          														<input type="text" class="form-control" id="approvalDate" name="approvalDate">
																		</div>
																		
																	</div>
																<%} %>
																<div class="ml-2" align="left">
									   								<b >Remarks :</b><br>
									   								<textarea rows="3" cols="65" name="remarks" id="remarksarea" maxlength="1000"></textarea>
								         						</div>
								         						<%if(carsIni!=null && dpcsocapprovestatus.contains(statuscode)) {%>
								         						<button type="submit" class="btn btn-sm btn-success" id="finalSubmission" formaction="DPCSoCApprovalSubmit.htm" name="Action" value="A" onclick="return confirm('Are You Sure To Approve?');" style="font-weight: 600;">
										    						Approve	
									      						</button>
									      						
									      						<!-- <button type="submit" class="btn btn-sm btn-danger" id="finalSubmission" formaction="DPCSoCApprovalSubmit.htm" name="Action" value="D" onclick="return disapprove();" style="font-weight: 600;">
										   	 						Disapprove	
									      						</button> -->
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
			                							GH-DP&C - <%if(GHDPandC!=null) {%><%=StringEscapeUtils.escapeHtml4(GHDPandC[1].toString()) %> <%} else{%>GH-DP&C<%} %>
			                						</td>
			                		
		                        					<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						
			                						<td class="trup" style="background: linear-gradient(to top, #eb76c3 10%, transparent 115%);">
			                							GD-DP&C - <%if(GDDPandC!=null) {%><%=StringEscapeUtils.escapeHtml4(GDDPandC[1].toString()) %> <%} else{%>GD-DP&C<%} %>
			                	    				</td>
			                	    				
		                        					<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						
			                						<td class="trup" style="background: linear-gradient(to top, #b9bcb3 10%, transparent 115%);">
			                							<%if(carsIni.getFundsFrom().equalsIgnoreCase("0")) {%>
	                										Chairman RPB - <%if(ChairmanRPB!=null) {%><%=StringEscapeUtils.escapeHtml4(ChairmanRPB[1].toString()) %> <%} else{%>Chairman RPB<%} %>
	                									<%} else{%>
	                										PD - <%if(PDs!=null) {%><%=StringEscapeUtils.escapeHtml4(PDs[2].toString()) %><%} else{%>PD<%} %>
	                									<%} %>
			                	    				</td>
			                	    				
		                        					<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						
			                						<td class="trup" style="background: linear-gradient(to top, #857af4 10%, transparent 115%);">
			                							MMFD AG - <%if(MMFDAG!=null) {%><%=StringEscapeUtils.escapeHtml4(MMFDAG[1].toString()) %> <%} else{%>MMFD AG<%} %>
			                	    				</td>
			                	    				
		                        					<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						
			                						<td class="trup" style="background: linear-gradient(to top, #00c7e4 10%, transparent 115%);">
			                							GD DF&MM - <%if(GDDFandMM!=null) {%><%=StringEscapeUtils.escapeHtml4(GDDFandMM[1].toString()) %> <%} else{%>GD DF&MM<%} %>
			                	    				</td>
			                	    				
			                	    				<%if(amount!=null && Double.parseDouble(amount)<=1000000) {%>
			                	    					<td rowspan="2">
			                								<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                							</td>
			                						
				                						<td class="trup" style="background: linear-gradient(to top, #09f21b 10%, transparent 115%);">
				                							DIRECTOR - <%if(Director!=null) {%><%=StringEscapeUtils.escapeHtml4(Director[1].toString()) %> <%} else{%>DIRECTOR<%} %>
				                	    				</td>
			                	    					
			                	    				<%} %>
			                	    				
			                	    				<%if(amount!=null && (Double.parseDouble(amount)>1000000 && Double.parseDouble(amount)<=5000000) ) {%>
			                	    					<td rowspan="2">
			                								<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                							</td>
			                						
				                						<td class="trup" style="background: linear-gradient(to top, #f28309 10%, transparent 115%);">
				                							IFA, O/o DG (ECS) - IFA, O/o DG (ECS)
				                	    				</td>
				                	    				
				                	    				<td rowspan="2">
			                								<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                							</td>
			                						
				                						<td class="trup" style="background: linear-gradient(to top, #09f21b 10%, transparent 115%);">
				                							DIRECTOR - <%if(Director!=null) {%><%=StringEscapeUtils.escapeHtml4(Director[1].toString()) %> <%} else{%>DIRECTOR<%} %>
				                	    				</td>
			                	    				<%} %>
			                	    				
			                	    				<%if(amount!=null && (Double.parseDouble(amount)>5000000 && Double.parseDouble(amount)<=30000000)) {%>
				                	    				
				                	    				<td rowspan="2">
			                								<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                							</td>
			                						
				                						<td class="trup" style="background: linear-gradient(to top, #09f21b 10%, transparent 115%);">
				                							DIRECTOR - <%if(Director!=null) {%><%=StringEscapeUtils.escapeHtml4(Director[1].toString()) %> <%} else{%>DIRECTOR<%} %>
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
			                	    				
			                	    				<%if(amount!=null && (Double.parseDouble(amount)>30000000)) {%>
				                	    				
				                	    				<td rowspan="2">
			                								<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                							</td>
			                						
				                						<td class="trup" style="background: linear-gradient(to top, #09f21b 10%, transparent 115%);">
				                							DIRECTOR - <%if(Director!=null) {%><%=StringEscapeUtils.escapeHtml4(Director[1].toString()) %> <%} else{%>DIRECTOR<%} %>
				                	    				</td>
				                	    				
				                	    				<td rowspan="2">
			                								<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                							</td>
			                						
				                						<td class="trup" style="background: linear-gradient(to top, #f28309 10%, transparent 115%);">
				                							JSA - JSA
				                	    				</td>
				                	    				
				                	    				<td rowspan="2">
			                								<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                							</td>
			                						
				                						<td class="trup" style="background: linear-gradient(to top, #ef5efa 10%, transparent 115%);">
				                							SECY - SECY
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
		               	
		               	<!-- *********** All Documents ***********      --> 
		               	<%if(dpcTabId!=null && dpcTabId.equalsIgnoreCase("3")){ %> 
		         			<div class="tab-pane active" id="alldocs" role="tabpanel">
		         		<%}else{ %>
		              		<div class="tab-pane " id="alldocs" role="tabpanel">
		               	<%} %>
		               			<%if(carsIni!=null) {%>
		               				<div class="col-md-8 mt-4">
		               					<div class="card" style="border: 1px solid rgba(0,0,0,.125);margin-left: 25%;">
		               						<div class="card-body mt-2 ml-4">
			               						<form action="#">
			               							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			               							<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId%>">
			               							<input type="hidden" name="carsSocId" value="<%=carsSoCId%>">
			               							<table id="alldocstable">
			               								<thead>
			               									<tr>
			               										<th style="width: 10%;">SN</th>
			               										<th>Subject</th>
			               										<th style="width: 10%;">Action</th>
			               									</tr>
			               								</thead>
			               								<tbody>
			               									<%int docsslno=0; %>
			               									<tr>
			               										<td><%=++docsslno %></td>
			               										<td>RSQR</td>
			               										<td>
				               											<button type="submit" class="btn btn-sm" <%if(carsIni.getInitiationApprDate()!=null) {%>formaction="CARSRSQRDownload.htm"<%} else {%>formaction="CARSRSQRDownloadBeforeFreeze.htm"<%} %>  formtarget="_blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="RSQR Download" >
																			<i class="fa fa-download fa-lg" aria-hidden="true"></i>
																		</button>
			               										</td>
			               									</tr>
			               									<tr>
			               										<td><%=++docsslno %></td>
			               										<td>RSQR Approval Download</td>
			               										<td>
				               											<button type="submit" class="btn btn-sm" formaction="CARSRSQRApprovalDownload.htm" formmethod="post" formnovalidate="formnovalidate" 
				               											 formtarget="blank" formmethod="post" data-toggle="tooltip" data-placement="top" title="RSQR Approval Download">
											  	 							<i class="fa fa-download fa-lg" aria-hidden="true"></i>
																		</button>
			               										</td>
			               									</tr>
			               									<tr>
			               										<td><%=++docsslno %></td>
			               										<td>Invitation for Summary of Offer</td>
			               										<td>
			               											<%if(carsIni!=null && carsIni.getInitiationApprDate()!=null) {%>
			               												<button type="submit" class="btn btn-sm" formaction="CARSInvForSoODownload.htm" formmethod="post" formnovalidate="formnovalidate"
			               												 formtarget="blank" data-toggle="tooltip" data-placement="top" title="Inv for SoO Download">
																			<i class="fa fa-download fa-lg" aria-hidden="true"></i>
																		</button>
			               											<%} else {%>
		                            					 				-
		                            					 			<%} %>
			               										</td>
			               									</tr>
			               									<tr>
			               										<td><%=++docsslno %></td>
			               										<td>Summary of Offer</td>
			               										<td>
			               											<%if(carsSoC!=null && carsSoC.getSoOUpload()!=null) {%>
				                            					 		<button type="submit" class="btn btn-sm" name="filename" formaction="CARSSoCFileDownload.htm" formmethod="post" formnovalidate="formnovalidate"
				                            					 		  value="soofile" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="SoO Download">
				                            					 			<i class="fa fa-download fa-lg"></i>
				                            					 		</button>
		                            					 			<%} else {%>
		                            					 				-
		                            					 			<%} %>
			               										</td>
			               									</tr>
			               									<tr>
			               										<td><%=++docsslno %></td>
			               										<td>Feasibility Report</td>
			               										<td>
			               											<%if(carsSoC!=null && carsSoC.getFRUpload()!=null) {%>
				                            					 		<button type="submit" class="btn btn-sm" name="filename" formaction="CARSSoCFileDownload.htm" formmethod="post" formnovalidate="formnovalidate"
				                            					 		  value="frfile" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Feasibility Report Download">
				                            					 			<i class="fa fa-download fa-lg"></i>
				                            					 		</button>
		                            					 			<%} else {%>
		                            					 				-
		                            					 			<%} %>
			               										</td>
			               									</tr>
			               									<tr>
			               										<td><%=++docsslno %></td>
			               										<td>Final RSQR ( Annexure-I )</td>
			               										<td>
			               											<%if(carsIni!=null && carsIni.getInitiationApprDate()!=null) {%>
		               													<button type="submit" class="btn btn-sm" formaction="CARSFinalRSQRDownload.htm" formnovalidate="formnovalidate" 
		               													formtarget="_blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="Final RSQR Download" >
		               														<i class="fa fa-download fa-lg"></i>
		               													</button>
		               												<%} else {%>
		                            					 				-
		                            					 			<%} %>
			               										</td>
			               									</tr>
			               									<tr>
			               										<td><%=++docsslno %></td>
			               										<td>Milestones & Deliverables ( Annexure-II )</td>
			               										<td>
			               											<%if(milestones!=null && milestones.size()>0) {%>
		               													<button type="submit" class="btn btn-sm" formaction="CARSSoCMilestonesDownload.htm" formnovalidate="formnovalidate" 
		               													formtarget="_blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="Milestones Download">
		               														<i class="fa fa-download fa-lg"></i>
		               													</button>
		               												<%} else {%>
		                            					 				-
		                            					 			<%} %>
			               										</td>
			               									</tr>
			               									<tr>
			               										<td><%=++docsslno %></td>
			               										<td>Execution Plan ( Annexure-IV )</td>
			               										<td>
			               											<%if(carsSoC!=null && carsSoC.getExecutionPlan()!=null) {%>
				                            					 		<button type="submit" class="btn btn-sm" name="filename" formaction="CARSSoCFileDownload.htm" formnovalidate="formnovalidate" formmethod="post"
				                            					 		  value="exeplanfile" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Execution Plan Download">
				                            					 			<i class="fa fa-download fa-lg"></i>
				                            					 		</button>
		                            					 			<%} else {%>
		                            					 				-
		                            					 			<%} %>
			               										</td>
			               									</tr>
			               									<tr>
			               										<td><%=++docsslno %></td>
			               										<td>Statement of Case ( SoC )</td>
			               										<td>
			               											<%if(carsSoC!=null && milestones!=null && milestones.size()>0) {%>
			               												<button type="submit" class="btn btn-sm" formaction="CARSSoCDownload.htm" formnovalidate="formnovalidate" formmethod="post"
			               												  formtarget="blank" data-toggle="tooltip" data-placement="top" title="SoC Download">
										  	 								<i class="fa fa-download fa-lg" aria-hidden="true"></i>
																		</button>
			               											<%} else {%>
		                            					 				-
		                            					 			<%} %>
			               										</td>
			               									</tr>
			               									<tr>
			               										<td><%=++docsslno %></td>
			               										<td>Minutes of Meeting ( MoM )</td>
			               										<td>
			               											<%if(carsSoC!=null && carsSoC.getMoMUpload()!=null) {%>
		                            					 				<button type="submit" class="btn btn-sm" name="filename" formaction="CARSSoCFileDownload.htm" formmethod="post" formnovalidate="formnovalidate"
		                            					 				value="momfile" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="MoM Download">
		                            					 					<i class="fa fa-download fa-lg"></i>
		                            					 				</button>
		                            					 			<%} else {%>
		                            					 				-
		                            					 			<%} %>
			               										</td>
			               									</tr>
			               									<tr>
			               										<td><%=++docsslno %></td>
			               										<td>D-P&C SoC</td>
			               										<td>
			               											<%if(carsSoC!=null && carsSoC.getDPCIntroduction()!=null) {%>
			               												<button type="submit" class="btn btn-sm" formaction="CARSDPCSoCDownload.htm" formmethod="GET" formnovalidate="formnovalidate" 
			               												formtarget="blank" data-toggle="tooltip" data-placement="top" title="D-P&C SoC Download">
								  	 										<i class="fa fa-download fa-lg" aria-hidden="true"></i>
															  			</button>
			               											<%} else {%>
		                            					 				-
		                            					 			<%} %>
			               										</td>
			               									</tr>
			               									
			               								</tbody>
			               							</table>
			               							<br>
			               						</form>
		               						</div>
		               					</div>
		               				</div>
		               			<%} %>
		               			<div class="navigation_btn"  style="text-align: right;">
		            				<a class="btn btn-info btn-sm  shadow-nohover previous" >Previous</a>
									<button class="btn btn-info btn-sm next">Next</button>
								</div>
		               	<%if(dpcTabId!=null && dpcTabId.equalsIgnoreCase("9")){ %> 
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
<%if((dpcsocforwardstatus.contains(carsIni.getCARSStatusCode()))) {%>
$('.btn-soc').prop('disabled',false);
<%} else{%>
$('.btn-soc').prop('disabled',true);
<%} %>

/* tabs hiding for SoC approval */
<%if(isApproval!=null && (isApproval.equalsIgnoreCase("P") || isApproval.equalsIgnoreCase("Q") )) {%>
   $('.navigation_btn').hide();
   $('#nav-socdetails').hide();
   $('#nav-alldocs').hide();
<%} %>
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
	    	   if (result != null && LabCode!='@EXP') {
	                for (var i = 0; i < result.length; i++) {
	                    var data = result[i];
	                    var optionValue = data[0];
	                    var optionText = data[1].trim() + ", " + data[3]; 
	                    var option = $("<option></option>").attr("value", optionValue).text(optionText);
	                    $('#approverEmpId').append(option); 
	                }
	                $('#approverEmpId').selectpicker('refresh');
	                }else{
	                	for (var i = 0; i < result.length; i++) {
	                        var data = result[i];
	                        var optionValue = data[0];
	                        var optionText = data[1].trim() + ", " + data[3]; 
	                        var option = $("<option></option>").attr("value", optionValue).text(optionText);
	                        $('#approverEmpId').append(option); 
	                    }
	                    $('#approverEmpId').selectpicker('refresh');
	                }
	               /* 	for (var i = 0; i < result.length; i++) {
	                       var data = result[i];
	                       var optionValue = data[0];
	                       var optionText = data[1].trim() + ", " + data[3]; 
	                       var option = $("<option></option>").attr("value", optionValue).text(optionText);
	                       $('#approverEmpId').append(option); 
	                   }
	                   $('#approverEmpId').selectpicker('refresh'); */
	               
	           }
	   });
	}

$('#approvalDate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	//"minDate" :new Date(), 
	//"startDate" : new Date(),
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

</script>

<script type="text/javascript">

/* ----------------- CKEDITOR Configuration ------------------------------------ */
/* var editor_config = {
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
	}; */
	
	/* -------------------------- Define a common Summernote configuration -------------------------------------------- */
	var summernoteConfig = {
	    width: 900,
	    toolbar: [
	        ['style', ['bold', 'italic', 'underline', 'clear']],
	        ['font', ['fontsize', 'fontname', 'color', 'superscript', 'subscript']],
	        ['insert', ['picture', 'table']],
	        ['para', ['ul', 'ol', 'paragraph']],
	        ['height', ['height']]
	    ],
	    fontSizes: ['8', '9', '10', '11', '12', '14', '16', '18', '24', '36', '48', '64', '82', '150'],
	    fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', 'Helvetica', 'Impact', 'Tahoma', 'Times New Roman', 'Verdana','Segoe UI','Segoe UI Emoji','Segoe UI Symbol'],
	    buttons: {
	        superscript: function() {
	            return $.summernote.ui.button({
	                contents: '<sup>S</sup>',
	                tooltip: 'Superscript',
	                click: function() {
	                    document.execCommand('superscript');
	                }
	            }).render();
	        },
	        subscript: function() {
	            return $.summernote.ui.button({
	                contents: '<sub>S</sub>',
	                tooltip: 'Subscript',
	                click: function() {
	                    document.execCommand('subscript');
	                }
	            }).render();
	        }
	    },
	    height: 300
	};
	
/* -------------------------- Form Submission with CKEDITOR Data -------------------------------------------- */

$('#inieditform').submit(function() {

	  /* var data =CKEDITOR.instances['dpcIntroductionnote'].getData(); */
	  
	  var data = $('#dpcIntroductionnote').summernote('code');
	  $('textarea[name=dpcIntroduction]').val(data);

});

/* ------------------------ Using CKEDITOR Configuration ------------------------ */
/* CKEDITOR.replace('dpcIntroductionnote', editor_config); */

/* ------------------------ Using Summernote Configuration ------------------------ */
$('#dpcIntroductionnote').summernote(summernoteConfig);


$( document ).ready(function() {
	
	/* ----------------------- Aim & Objectives ------------------------ */ 
	<%if(carsSoC!=null && carsSoC.getDPCIntroduction()!=null) {%>

		 var html=$('#dpcIntroductionhidden').val();
		
		/* CKEDITOR.instances['dpcIntroductionnote'].setData(html); */
		$('#dpcIntroductionnote').summernote('code', html);
	<%} %>
});	
</script>
</body>
</html>
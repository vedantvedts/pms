<%@page import="com.vts.pfms.cars.model.CARSSoC"%>
<%@page import="com.vts.pfms.IndianRupeeFormat"%>
<%@page import="com.vts.pfms.cars.model.CARSContract"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.vts.pfms.cars.model.CARSSoCMilestones"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.vts.pfms.cars.model.CARSOtherDocDetails"%>
<%@page import="java.util.List"%>
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
}
#alldocstable td:first-child,#alldocstable td:nth-child(3){ 
	text-align: center; 
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

</head>
<body>

<%
String mpDocsTabId = (String)request.getAttribute("mpDocsTabId"); 
String isApproval = (String)request.getAttribute("isApproval");

CARSInitiation carsIni = (CARSInitiation)request.getAttribute("CARSInitiationData"); 
CARSSoC carsSoC = (CARSSoC)request.getAttribute("CARSSoCData"); 
CARSContract carsContract = (CARSContract)request.getAttribute("CARSContractData"); 
List<CARSSoCMilestones> milestones = (List<CARSSoCMilestones>)request.getAttribute("CARSSoCMilestones");

List<CARSOtherDocDetails> otherdocdetails = (List<CARSOtherDocDetails>)request.getAttribute("CARSOtherDocDetailsData");
List<Object[]> othersMPRemarksHistory = (List<Object[]>)request.getAttribute("CARSOthersMPRemarksHistory");
List<Object[]> othersMPApprovalEmpData = (List<Object[]>)request.getAttribute("OthersMPApprovalEmpData");

String MilestoneNo = (String)request.getAttribute("MilestoneNo"); 

List<CARSSoCMilestones> milestonedetailsbymilestoneno = milestones.stream().filter(e-> MilestoneNo.equalsIgnoreCase(e.getMilestoneNo())).collect(Collectors.toList());
CARSSoCMilestones milestonedetails = milestonedetailsbymilestoneno!=null && milestonedetailsbymilestoneno.size()>0? milestonedetailsbymilestoneno.get(0):null;

List<CARSOtherDocDetails> mpdetailslist = otherdocdetails.stream().filter(e-> "M".equalsIgnoreCase(e.getOtherDocType()) && MilestoneNo.equalsIgnoreCase(e.getMilestoneNo())).collect(Collectors.toList());
CARSOtherDocDetails mpdetails = mpdetailslist!=null && mpdetailslist.size()>0?mpdetailslist.get(0):null;



List<String> mpforwardstatus = Arrays.asList("CAD","MIN","MRA","MRC","MRD","MRV");

Object[] GHDPandC = (Object[])request.getAttribute("GHDPandC");
Object[] GDDPandC = (Object[])request.getAttribute("GDDPandC");
Object[] ADDPandC = (Object[])request.getAttribute("ADDPandC");
Object[] Chairperson = (Object[])request.getAttribute("Chairperson");
Object[] Director = (Object[])request.getAttribute("Director");
Object[] PDs = (Object[])request.getAttribute("PDEmpIds");

FormatConverter fc = new FormatConverter();
SimpleDateFormat rdf = fc.getRegularDateFormat();
SimpleDateFormat sdf = fc.getSqlDateFormat();

String labcode =(String)session.getAttribute("labcode");
String EmpId =((Long) session.getAttribute("EmpId")).toString();

long carsInitiationId = carsIni.getCARSInitiationId();
String statuscode = mpdetails!=null?mpdetails.getOthersStatusCode():"N";

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
         		<div class="card-header slider_header" style="padding:0px; font-size:12px!important; height: 150px;">
             		<h3 class="category">Payment Details - 
             		
             			<button type="button" class="btn btn-sm btn-info" style="text-align: left;width: 70%;background: blueviolet;border: blueviolet;">
             				<div>
					        	<div class="row">
					            	<div class="col-md-12">
					                	<span class="cssideheading">Title:</span>
					                			&emsp;<span class="cssideheadingdata"><%if(carsIni!=null && carsIni.getInitiationTitle()!=null) {%><%=carsIni.getInitiationTitle() %> <%} else{%>-<%} %></span>
					                </div>
					            </div>
					                	
					            <div class="row">
					            	<div class="col-md-4">
					                	<span class="cssideheading">CARS. No:</span>
					                	&emsp;<span class="cssideheadingdata"><%if(carsIni!=null && carsIni.getCARSNo()!=null) {%><%=carsIni.getCARSNo() %> <%} else{%>-<%} %></span>
					            	</div>
					            <div class="col-md-1"></div>
					            <div class="col-md-3">
					            	<span class="cssideheading">Funds from:</span>
					                &emsp;<span class="cssideheadingdata">
					                	<%if(carsIni!=null && carsIni.getFundsFrom()!=null && carsIni.getFundsFrom().equalsIgnoreCase("0")) {%>
					                		Buildup
					                	<%} else{%>
					                		<%if(PDs!=null && PDs[4]!=null) {%><%=PDs[4] %><%} %>
					                	<%} %>
					                	</span>
					            </div>
					            <div class="col-md-1"></div>
					            	<div class="col-md-3">
					                	<span class="cssideheading">Amount:</span>
					                		&emsp;<span class="cssideheadingdata">
					                		<%if(carsSoC!=null && carsSoC.getSoCAmount()!=null) {%>
					                			<%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(carsSoC.getSoCAmount())) %>
					                		<%} else{%>-<%} %>
					                	</span>
					                </div>
					            </div>
					                		
					        </div>
             			</button>
             		
             			<a class="btn btn-info btn-sm  shadow-nohover back"
             			<%if(isApproval!=null && isApproval.equalsIgnoreCase("M") ) {%>
               				href="CARSRSQRApprovals.htm"
               			<%} else if(isApproval!=null && isApproval.equalsIgnoreCase("N") ) {%>
               				href="CARSRSQRApprovals.htm?val=app"
               			<%} else {%>
             			    href="CARSOtherDocsList.htm?carsInitiationId=<%=carsInitiationId %>"
             			<%} %> 
             			  style="color: white!important;float: right;">Back</a>
             		</h3>
             		<hr style="margin: -8px 0px !important;">
             		<ul class="nav nav-tabs justify-content-center" role="tablist" style="padding-bottom: 0px;" >

            			<li class="nav-item" id="nav-mpdetails">
             				<%if(mpDocsTabId!=null && mpDocsTabId.equalsIgnoreCase("1")){ %> 
             		    		<a class="nav-link active " data-toggle="tab" href="#mpdetails" id="nav" role="tab">
             				<%}else{ %>
              			 		<a class="nav-link  " data-toggle="tab" href="#mpdetails" role="tab">
               				<%} %>  
               					
                	         	Doc Details
              			 		</a>
            			</li>

            			<li class="nav-item" id="nav-mpapproval">
            	     		<%if(mpDocsTabId!=null && mpDocsTabId.equalsIgnoreCase("2")){ %>
              					<a class="nav-link active" data-toggle="tab" href="#mpapproval" id="nav"role="tab" >
              				<%}else{ %>
              					<a class="nav-link" data-toggle="tab" href="#mpapproval" role="tab" >
               				<%} %>
                  				Payment Approval
              					</a>
            			</li>
            			
            			<li class="nav-item" id="nav-docuploads">
		            	     <%if(mpDocsTabId!=null && mpDocsTabId.equalsIgnoreCase("3")){ %>
		              			<a class="nav-link active" data-toggle="tab" href="#docuploads" id="nav"role="tab" >
		              		<%}else{ %>
		              			<a class="nav-link" data-toggle="tab" href="#docuploads" role="tab" >
		               		<%} %>
                  				Doc Upload
              					</a>
            			</li>
              		</ul>
         		</div>
         		
         		<!-- This is for Tab Panes -->
         		<div class="card">
         			<div class="tab-content text-center" style="margin-top : 0.2rem;">
         				<!-- *********** Others Details ***********      --> 
               			<%if(mpDocsTabId!=null && mpDocsTabId.equalsIgnoreCase("1")){ %> 
         					<div class="tab-pane active" id="mpdetails" role="tabpanel">
         				<%}else{ %>
              				<div class="tab-pane " id="mpdetails" role="tabpanel">
               			<%} %>
               					<div class="container">
									<div class="row" style="width: 140%; margin-left: -15rem;">
										<div class="col-md-12">
											<div class="card shadow-nohover" >
												<div class="card-header" style=" /* background: linear-gradient(to right, #334d50, #cbcaa5); */ /* background-color:rgba(6,103,200,1); */ background-color: #055C9D;text-align: left;">
								                    <b class="text-white" style=""><%if(MilestoneNo!=null && !MilestoneNo.equalsIgnoreCase("MIL-1")) {%>Milestone<%} else{%>Initial Advance<%} %> Payment Details: </b> 
								                    <hr>
								                    <span class="text-white" style="float:right;font-weight: 600"> </span>
							        			</div> 
												<div class="card-body">
								        		
													<form action="CARSMPDocDetailsSubmit.htm" method="POST" enctype="multipart/form-data">
														<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
												    	<input type="hidden" name="carsInitiationId" value="<%=carsIni.getCARSInitiationId()%>">
												    	<input type="hidden" name="otherDocDetailsId" value="<%if(mpdetails!=null){%><%=mpdetails.getOtherDocDetailsId() %><%}%>">
												    	<input type="hidden" name="otherDocType" value="M">
												    	<input type="hidden" name="MilestoneNo" value="<%=MilestoneNo%>">
												    	<div class="row" style="margin-left: 2%;margin-right: 2%;">
												    		
												        	<div class="col-md-3" style="">
														        		<div class="form-group">
														                	<label class="control-label">Date:</label><span class="mandatory">*</span>
														                    <input  class="form-control form-control" type="text" name="mpOtherDocDate" id="mpOtherDocDate"
														                     value="<%if(mpdetails!=null && mpdetails.getOtherDocDate()!=null) {%><%=fc.SqlToRegularDate(mpdetails.getOtherDocDate()) %><%} %>" required readonly> 
														                </div>
														            </div>
														        	
														        	<div class="col-md-3" style="">
														        		<div class="form-group">
														                	<label class="control-label">Flag-A</label><span class="mandatory">*</span>
														                    <%if(mpdetails!=null && mpdetails.getAttachFlagA()!=null) {%>
						                            					 		<button type="submit" class="btn btn-sm" style="padding: 5px 8px;margin-right: 15em;" name="filename" formmethod="post" formnovalidate="formnovalidate"
						                            					 		  value="flagAFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
						                            					 			<i class="fa fa-download fa-lg"></i>
						                            					 		</button>
                            					 							<%} %>
                              		      									<input type="file" class="form-control modals" name="attatchFlagA" <%if(mpdetails==null) {%>required<%} %> accept=".pdf">
														                </div>
														            </div>
														        	<div class="col-md-3" style="">
														        		<div class="form-group">
														                	<label class="control-label">Flag-B</label><span class="mandatory">*</span>
														                    <%if(mpdetails!=null && mpdetails.getAttachFlagB()!=null) {%>
						                            					 		<button type="submit" class="btn btn-sm" style="padding: 5px 8px;margin-right: 15em;" name="filename" formmethod="post" formnovalidate="formnovalidate"
						                            					 		  value="flagBFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
						                            					 			<i class="fa fa-download fa-lg"></i>
						                            					 		</button>
                            					 							<%} %>
                              		      									<input type="file" class="form-control modals" name="attatchFlagB" <%if(mpdetails==null) {%>required<%} %> accept=".pdf">
														                </div>
														            </div>
														            <%if(MilestoneNo!=null && !MilestoneNo.equalsIgnoreCase("MIL-1")) {%>
														        	<div class="col-md-3" style="">
														        		<div class="form-group">
														                	<label class="control-label">Flag-C</label><span class="mandatory">*</span>
														                    <%if(mpdetails!=null && mpdetails.getAttachFlagC()!=null) {%>
						                            					 		<button type="submit" class="btn btn-sm" style="padding: 5px 8px;margin-right: 15em;" name="filename" formmethod="post" formnovalidate="formnovalidate"
						                            					 		  value="flagCFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
						                            					 			<i class="fa fa-download fa-lg"></i>
						                            					 		</button>
                            					 							<%} %>
                              		      									<input type="file" class="form-control modals" name="attatchFlagC" <%if(mpdetails==null) {%>required<%} %> accept=".pdf">
														                </div>
														            </div>
														            <%} %>
														        </div>
														        
														        <div class="row" style="margin-left: 2%;margin-right: 2%;">
														        	<div class="col-md-3" style="">
														        		<div class="form-group">
														                	<label class="control-label">Invoice No:</label><span class="mandatory">*</span>
														                    <input  class="form-control form-control" type="text" name="invoiceNo" id="invoiceNo" maxlength="50" placeholder="Enter Inovice No"
														                     value="<%if(mpdetails!=null) {%><%=mpdetails.getInvoiceNo() %><%} %>" oninput="this.value=this.value.replace(/[^a-zA-Z0-9]/g, '').replace(/(\..*?)\..*/g, '$1');" required> 
														                </div>
														            </div>
														        	<div class="col-md-3" style="">
														        		<div class="form-group">
														                	<label class="control-label">Invoice Date:</label><span class="mandatory">*</span>
														                    <input  class="form-control form-control" type="text" name="invoiceDate" id="invoiceDate"
														                     value="<%if(mpdetails!=null) {%><%=fc.SqlToRegularDate(mpdetails.getInvoiceDate()) %><%} %>" required readonly> 
														                </div>
														            </div>
														        	<%-- <div class="col-md-3" style="">
														        		<div class="form-group">
														                	<label class="control-label">Milestone No:</label><span class="mandatory">*</span>
														                     <select class="form-control selectdee" id="milestoneNo" name="milestoneNo" data-live-search="true"  required="required">
		        																<option disabled="disabled" value="" selected="selected"> Select</option>
																					<%if (milestones != null && milestones.size() > 0) {
																						for (CARSSoCMilestones mil : milestones) {
																					%>
																						<option value=<%=mil.getMilestoneNo()%> <%if(mpdetails!=null && mpdetails.getMilestoneNo()!=null && mpdetails.getMilestoneNo().equalsIgnoreCase(mil.getMilestoneNo())) {%>selected<%} %> ><%=mil.getMilestoneNo()%></option>
																					<%}}%>
																			</select>
														                </div>
														            </div> --%>
														        </div>
														        
														         <div class="row" style="margin-left: 2%;margin-right: 2%;">
														        	<div class="col-md-2">
														        		<div class="form-group">
														        			<label class="control-label">Info <button type="button" id="mpInfo" value="1" class="btn btn-info btn-sm" style="padding: 0px 5px 0px 5px;background: blueviolet;border: none;"><i class="fa fa-info-circle" aria-hidden="true"></i></button></label>
														        		</div>
														        	</div>
														        	<div class="col-md-10" id="mpInfoContent" style="text-align: left;margin-left: -10%;">
														        		<div class="form-group" style="width: 110%;">
														        			<span style="color: crimson;">Flag-A : </span> <span>Reference is made to the CARS .</span> <br>
														        			<span style="color: fuchsia;">Flag-B : </span> <span>Invoice. </span> <br>
														        			<%if(MilestoneNo!=null && !MilestoneNo.equalsIgnoreCase("MIL-1")) {%>
														        			<span style="color: blue;">Flag-C : </span> <span>Recommendation of CARS Review committee for releasing the proposed milestone payment is placed.</span> 
														        			<%} %>
														        		</div>
														        	</div>
														        </div>
												        
												    	<div align="center">
															<%if(mpdetails!=null){ %>
																<button type="submit" class="btn btn-sm btn-warning edit btn-mp" name="Action" value="Edit" onclick="return confirm('Are you sure to update?')" >UPDATE</button>
															<%}else{ %>
																<button type="submit" class="btn btn-sm btn-success submit btn-mp" name="Action" value="Add" onclick="return confirm('Are you sure to submit?')" >SUBMIT</button>
															<%} %>
														</div>
												    </form>
								    				<br>
												    
												</div>
											</div>
										</div>
									</div>
								</div>
               			
               					<div class="navigation_btn"  style="text-align: right;">
            						<a class="btn btn-info btn-sm  shadow-nohover back" href="CARSOtherDocsList.htm?carsInitiationId=<%=carsInitiationId %>" style="color: white!important">Back</a>
									<button class="btn btn-info btn-sm next">Next</button>
								</div>
               			<%if(mpDocsTabId!=null && mpDocsTabId.equalsIgnoreCase("1")){ %> 
         					</div>
         				<%}else{ %>
              				</div>
               			<%} %>
               			
               			<!-- *********** Payment Approval ***********      --> 
               			<%if(mpDocsTabId!=null && mpDocsTabId.equalsIgnoreCase("2")){ %> 
         					<div class="tab-pane active" id="mpapproval" role="tabpanel">
         				<%}else{ %>
              				<div class="tab-pane " id="mpapproval" role="tabpanel">
               			<%} %>
               					<%if(mpdetails!=null) {%>
		               				<div class="col-md-8 mt-1">
               							<div class="card" style="border: 1px solid rgba(0,0,0,.125);margin-left: 25%;max-height: 500px;overflow-y: auto;">
               								<div class="card-body mt-2 ml-4">
               									<form action="#">
               										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			               		   					<input type="hidden" name="carsInitiationId" value="<%=carsIni.getCARSInitiationId()%>">
			               		   					<input type="hidden" name="otherDocDetailsId" value="<%if(mpdetails!=null){%><%=mpdetails.getOtherDocDetailsId() %><%}%>">
			               		   					<input type="hidden" name="otherDocType" value="M">
			               		   					<input type="hidden" name="MilestoneNo" value="<%=MilestoneNo%>">
			               		   					<div class="mt-2" align="center">
               											<h5 style="font-weight: bold;margin-top: 1.5rem;"><%=labcode %></h5>
               											
               											<span style="font-size: larger; text-decoration: underline;">Directorate of Planning & Coordination</span>
               										</div>
               										
               										<div class="row">
					               		   				<div class="col-md-3">
					               		   					<span>No:</span> <span><%=carsContract.getContractNo() %> </span>
					               		   				</div>
					               		   				<div class="col-md-6">
					               		   				</div>
					               		   				<div class="col-md-3">
					               		   					<span>Date:</span> <span><%if(mpdetails.getOtherDocDate()!=null) {%> <%=fc.SqlToRegularDate(mpdetails.getOtherDocDate()) %><%} else{%><%=rdf.format(new Date()) %><%} %> </span>
					               		   				</div>
			               		   					</div>
			               		   					<hr>
					               		   			<div class="row">
					               		   				<div class="col-md-12 mt-2" align="center">
		               										<h5 style="font-weight: bold;margin-top: 1.5rem;">Approval for <%if(MilestoneNo!=null && !MilestoneNo.equalsIgnoreCase("MIL-1")) {%>Milestone<%} else{%>Initial Advance<%} %> Payment </h5>
		               											
		               										<span style="font-size: large;"><%=carsIni.getInitiationTitle() %> </span>
		               									</div>
					               		   			</div>
			               		   					<br>
			               		   					<%int paymentslno=0; %>
					               		   			<div class="row">
					               		   				<div class="col-md-12" style="text-align: left;">
					               		   					<span>
					               		   						<%=++paymentslno %>) Reference is made to the CARS Contract No. 
					               		   						<%if(carsContract!=null) {%><%=carsContract.getContractNo() %> <%} %>
					               		   						dt. <%if(carsContract!=null && carsContract.getContractDate()!=null) {%><%=fc.SqlToRegularDate(carsContract.getContractDate()) %> <%} %>
					               		   						. (Flag-A)
					               		   					</span>
					               		   					<span>
					               		   						<%if(mpdetails!=null && mpdetails.getAttachFlagA()!=null) {%>
							                            			<button type="submit" class="btn btn-sm" style="padding: 5px 8px;margin-right: 15em;" name="filename" formmethod="post" formnovalidate="formnovalidate"
							                            				value="flagAFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
							                            				<i class="fa fa-download"></i>
							                            			</button>
		                          					 			<%} %>
					               		   					</span>
					               		   					
					               		   				</div>
					               		   			</div>
					               		   			<div class="row">
					               		   				<div class="col-md-12" style="text-align: left;">
					               		   					<%if(MilestoneNo!=null && !MilestoneNo.equalsIgnoreCase("MIL-1")) {%>
					               		   						<span>
					               		   							<%=++paymentslno %>) <%if(carsIni!=null) {%><%=carsIni.getRSPInstitute()+", "+carsIni.getRSPCity() %> <%} %> has submitted
						               		   						 invoice No. <%if(mpdetails!=null && mpdetails.getInvoiceNo()!=null) {%><%=mpdetails.getInvoiceNo() %> <%} %>
						               		   						 dt. <%if(mpdetails!=null && mpdetails.getInvoiceDate()!=null) {%><%=fc.SqlToRegularDate(mpdetails.getInvoiceDate()) %> <%} %>
						               		   						 for Payment towards Milestone No <%=MilestoneNo %>
						               		   						 for an amount of Rs. <%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(milestonedetails.getActualAmount())) %>
						               		   						 and the invoice is placed opposite (Flag-B).
					               		   						</span>
					               		   					<%} else{%>
						               		   					<span>
						               		   						<%=++paymentslno %>) <%if(carsIni!=null) {%><%=carsIni.getRSPInstitute()+", "+carsIni.getRSPCity() %> <%} %> has submitted
						               		   						 invoice No. <%if(mpdetails!=null && mpdetails.getInvoiceNo()!=null) {%><%=mpdetails.getInvoiceNo() %> <%} %>
						               		   						 dt. <%if(mpdetails!=null && mpdetails.getInvoiceDate()!=null) {%><%=fc.SqlToRegularDate(mpdetails.getInvoiceDate()) %> <%} %>
						               		   						 for Initial Advance Payment of Rs. <%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(milestonedetails.getActualAmount())) %>
						               		   						 and the invoice is placed opposite (Flag-B).
						               		   					</span>
					               		   					<%} %>
					               		   					<span>
					               		   						<%if(mpdetails!=null && mpdetails.getAttachFlagB()!=null) {%>
							                            			<button type="submit" class="btn btn-sm" style="padding: 5px 8px;margin-right: 15em;" name="filename" formmethod="post" formnovalidate="formnovalidate"
							                            				value="flagBFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
							                            				<i class="fa fa-download"></i>
							                            			</button>
		                          					 			<%} %>
					               		   					</span>
					               		   				</div>
					               		   			</div>
					               		   			
					               		   			<%if(MilestoneNo!=null && !MilestoneNo.equalsIgnoreCase("MIL-1")) {%>
					               		   			<div class="row">
					               		   				<div class="col-md-12" style="text-align: left;">
					               		   					<span>
					               		   						<%=++paymentslno %>) Recommendation of CARS Review committee for releasing the proposed milestone payment is placed at Flag-C.
					               		   					</span>
					               		   					<span>
					               		   						<%if(mpdetails!=null && mpdetails.getAttachFlagC()!=null) {%>
							                            			<button type="submit" class="btn btn-sm" style="padding: 5px 8px;margin-right: 15em;" name="filename" formmethod="post" formnovalidate="formnovalidate"
							                            				value="flagCFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
							                            				<i class="fa fa-download"></i>
							                            			</button>
		                          					 			<%} %>
					               		   					</span>
					               		   				</div>
					               		   			</div>
					               		   			<%} %>
					               		   			
					               		   			<div class="row">
					               		   				<div class="col-md-12" style="text-align: left;">
					               		   					<span>
					               		   						<%=++paymentslno %>) This is put up for the perusal and approval of the CFA for release of the payment stated above.
					               		   					</span>
					               		   					
					               		   				</div>
					               		   			</div>
					               		   			
			               		   					<br>
			               		   					
					               		   			<!-- Signatures and timestamps -->
					               		   			<div style="width: 96%;text-align: right;margin-right: 10px;line-height: 10px;margin-top: 30px;">
				               							<div style="font-size: 15px;"> Signature of GD-DP&C</div>
								               			<%for(Object[] apprInfo : othersMPApprovalEmpData){ %>
								   			   				<%if(apprInfo[8].toString().equalsIgnoreCase("MFW")){ %>
								   								<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
								   								<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
								   								<label style="font-size: 12px; ">[Forwarded On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
								   			    		<%break;}} %>  
									            	</div>
							            	
									            	<%for(Object[] apprInfo : othersMPApprovalEmpData) {%>
									            		<div style="width: 96%;text-align: left;margin-left: 10px;line-height: 10px;margin-top: 50px;">
										            			 		
										            		<%if(apprInfo[8].toString().equalsIgnoreCase("MFA")){ %>
									            				<div style="font-size: 15px;"> Signature of AD-P&C</div>
										   						<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
										   						<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
										   						<label style="font-size: 12px; ">[Recommended On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
										   					<%} else if(apprInfo[8].toString().equalsIgnoreCase("MFC")) {%> 
									   			    			<div style="font-size: 15px;"> Signature of Chairperson (CARS Committee)</div>
									   			    			<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
										   						<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
										   						<label style="font-size: 12px; ">[Approved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
										   					<%} else if(apprInfo[8].toString().equalsIgnoreCase("MAD")) {%> 
									   			    			<div style="font-size: 15px;"> Signature of Director</div>
									   			    			<label style="text-transform: capitalize;margin-top: 15px !important;"><%=apprInfo[2]%></label>,<!-- <br> -->
										   						<label style="text-transform: capitalize;"><%=apprInfo[3]%></label><br>
										   						<label style="font-size: 12px; ">[Approved On:&nbsp; <%=fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19) %>]</label>
									   			    					
									   			    		<%} %>
									   			    	</div>
									   			    <%} %>
							   			    
									   			    <!-- Remarks -->
					               		   			<div class="row mt-2">
														<%if(othersMPRemarksHistory.size()>0){ %>
															<div class="col-md-8" align="left" style="margin: 10px 0px 5px 25px; padding:0px;border: 1px solid black;border-radius: 5px;">
																<%if(othersMPRemarksHistory.size()>0){ %>
																	<table style="margin: 3px;padding: 0px">
																		<tr>
																			<td style="border:none;padding: 0px">
																				<h6 style="text-decoration: underline;">Remarks :</h6> 
																			</td>											
																		</tr>
																		<%for(Object[] obj : othersMPRemarksHistory){%>
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
															<%if(statuscode!=null && mpforwardstatus.contains(statuscode) && ( GDDPandC!=null && EmpId.equalsIgnoreCase(GDDPandC[0].toString()) ) ) {%>
																<div class="ml-2" align="left">
									   								<b >Remarks :</b><br>
									   								<textarea rows="3" cols="65" name="remarks" id="remarksarea"></textarea>
								         						</div>
																<button type="submit" class="btn btn-sm submit" id="" name="Action" formaction="OthersMPApprovalSubmit.htm" formnovalidate="formnovalidate" value="A" onclick="return confirm('Are you Sure to Submit ?');" >Forward</button>
															<%} %>
															<%if(isApproval!=null && isApproval.equalsIgnoreCase("M")) {%>
																
																<div class="ml-2" align="left">
									   								<b >Remarks :</b><br>
									   								<textarea rows="3" cols="65" name="remarks" id="remarksarea"></textarea>
								         						</div>
								         						<%if(statuscode!=null && statuscode.equalsIgnoreCase("MFC")) {%>
								         						<button type="submit" class="btn btn-sm btn-success" id="finalSubmission" formaction="OthersMPApprovalSubmit.htm" name="Action" value="A" onclick="return confirm('Are You Sure To Approve?');" style="font-weight: 600;">
										    						Approve	
									      						</button>
									      						
									      						<!-- <button type="submit" class="btn btn-sm btn-danger" id="finalSubmission" formaction="OthersMPApprovalSubmit.htm" name="Action" value="D" onclick="return disapprove();" style="font-weight: 600;">
										   	 						Disapprove	
									      						</button> -->
									      						<button type="submit" class="btn btn-sm btn-danger" id="finalSubmission" formaction="OthersMPApprovalSubmit.htm" name="Action" value="R" onclick="return validateTextBox();" style="font-weight: 600;background-color: #ff2d00;">
										 							Return
																</button>
								         						<%} else{%>
																<button type="submit" class="btn btn-sm btn-success" id="finalSubmission" formaction="OthersMPApprovalSubmit.htm" name="Action" value="A" onclick="return confirm('Are You Sure To Recommend?');" style="font-weight: 600;">
										    						Recommend	
									      						</button>
									      						
									      						<button type="submit" class="btn btn-sm btn-danger" id="finalSubmission" formaction="OthersMPApprovalSubmit.htm" name="Action" value="R" onclick="return validateTextBox();" style="font-weight: 600;background-color: #ff2d00;">
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
               							<h4 style="font-weight: bold;color: red;">Please fill the Payment Details..!</h4>
               						</div>
               					<%} %>   
			               		
			               		<div style="display: flex;justify-content: space-between;">
               						<div></div>
		               				<div>
		               					<%if(carsIni!=null && isApproval==null) {%>
		               					<div class="row"  >
				 		  					<div class="col-md-12" style="text-align: center;"><b>Approval Flow For Payment Approval</b></div>
				 	    				</div>
				 	    				<div class="row"  style="text-align: center; padding-top: 10px; padding-bottom: 15px; " >
			              					<table align="center"  >
			               						<tr>
			               							<td class="trup" style="background: linear-gradient(to top, #3c96f7 10%, transparent 115%);">
			                							GD-DP&C - <%if(GDDPandC!=null) {%> <%=GDDPandC[1] %> <%} else {%> GD-DP&C <%} %>
			                						</td>
			                		
		                        					<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						
			                						<td class="trup" style="background: linear-gradient(to top, #eb76c3 10%, transparent 115%);">
			                							AD-D&C - <%if(ADDPandC!=null) {%> <%=ADDPandC[1] %> <%} else {%> AD-P&C <%} %>
			                	    				</td>
			                		
		                        					<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						
			                						<td class="trup" style="background: linear-gradient(to top, #00c7e4 10%, transparent 115%);">
			                							Chairperson (CARS Committee) - <%if(Chairperson!=null) {%> <%=Chairperson[1] %> <%} else {%> Chairperson (CARS Committee) <%} %>
			                	    				</td>
			                	    				
			                	    				<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						
			                						<td class="trup" style="background: linear-gradient(to top, #09f21b 10%, transparent 115%);">
			                							Director - <%if(Director!=null) {%> <%=Director[1] %> <%} else {%> Director <%} %>
			                	    				</td>
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

               			<%if(mpDocsTabId!=null && mpDocsTabId.equalsIgnoreCase("2")){ %> 
         					</div>
         				<%}else{ %>
              				</div>
               			<%} %>
               			
               			<!-- *********** Doc Upload ***********      --> 
               			<%if(mpDocsTabId!=null && mpDocsTabId.equalsIgnoreCase("3")){ %> 
         					<div class="tab-pane active" id="docuploads" role="tabpanel">
         				<%}else{ %>
              				<div class="tab-pane " id="docuploads" role="tabpanel">
               			<%} %>
               					<%if(mpdetails!=null) {%>
		               				<div class="col-md-8 mt-4">
		               					<div class="card" style="border: 1px solid rgba(0,0,0,.125);margin-left: 25%;">
		               						<div class="card-body mt-2 ml-4">
			               						<form action="#">
			               							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			               							<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId%>">
			               							<input type="hidden" name="otherDocDetailsId" value="<%if(mpdetails!=null){%><%=mpdetails.getOtherDocDetailsId() %><%}%>">
			               							<input type="hidden" name="otherDocType" value="M">
			               							<input type="hidden" name="MilestoneNo" value="<%=MilestoneNo%>">
			               							<table id="alldocstable">
			               								<thead>
			               									<tr>
			               										<th style="width: 10%;">SN</th>
			               										<th>Subject</th>
			               										<th style="width: 10%;">Action</th>
			               									</tr>
			               								</thead>
			               								<tbody>
			               									<%int paymentslno=0; %>
			               									<tr>
			               										<td><%=++paymentslno %>.</td>
			               										<td><%if(MilestoneNo!=null && !MilestoneNo.equalsIgnoreCase("MIL-1")) {%>Milestone<%} else{%>Initial Advance<%} %> Payment Approval form</td>
			               										<td>
			               											<button type="submit" class="btn btn-sm" formaction="CARSMPDownload.htm"  formtarget="_blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="CARS Contract Signature Download" >
																		<i class="fa fa-download fa-lg" aria-hidden="true"></i>
																	</button>
			               										</td>
			               									</tr>
			               									
			               									<tr>
			               										<td><%=++paymentslno %>.</td>
			               										<td>
			               											<span>
						               		   							Reference is made to the CARS Contract No. 
						               		   							<%if(carsContract!=null) {%><%=carsContract.getContractNo() %> <%} %>
						               		   							dt. <%if(carsContract!=null && carsContract.getContractDate()!=null) {%><%=fc.SqlToRegularDate(carsContract.getContractDate()) %> <%} %>
						               		   							. (Flag-A)
					               		   							</span>
			               										</td>
			               										<td>
			               											<%if(mpdetails!=null && mpdetails.getAttachFlagA()!=null) {%>
							                            			<button type="submit" class="btn btn-sm" style="padding: 5px 8px;" name="filename" formmethod="post" formnovalidate="formnovalidate"
							                            				value="flagAFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
							                            				<i class="fa fa-download fa-lg"></i>
							                            			</button>
                            					 					<%} else {%>
                            					 						-
                            					 					<%} %>
			               										</td>
			               									</tr>
			               									<tr>
			               										<td><%=++paymentslno %>.</td>
			               										<td>
			               											<%if(MilestoneNo!=null && !MilestoneNo.equalsIgnoreCase("MIL-1")) {%>
							               		   						<span>
							               		   							 <%if(carsIni!=null) {%><%=carsIni.getRSPInstitute()+", "+carsIni.getRSPCity() %> <%} %> has submitted
								               		   						 invoice No. <%if(mpdetails!=null && mpdetails.getInvoiceNo()!=null) {%><%=mpdetails.getInvoiceNo() %> <%} %>
								               		   						 dt. <%if(mpdetails!=null && mpdetails.getInvoiceDate()!=null) {%><%=fc.SqlToRegularDate(mpdetails.getInvoiceDate()) %> <%} %>
								               		   						 for Payment towards Milestone No <%=MilestoneNo %>
								               		   						 for an amount of Rs. <%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(milestonedetails.getActualAmount())) %>
								               		   						 and the invoice is placed opposite (Flag-B).
							               		   						</span>
							               		   					<%} else{%>
								               		   					<span>
								               		   						 <%if(carsIni!=null) {%><%=carsIni.getRSPInstitute()+", "+carsIni.getRSPCity() %> <%} %> has submitted
								               		   						 invoice No. <%if(mpdetails!=null && mpdetails.getInvoiceNo()!=null) {%><%=mpdetails.getInvoiceNo() %> <%} %>
								               		   						 dt. <%if(mpdetails!=null && mpdetails.getInvoiceDate()!=null) {%><%=fc.SqlToRegularDate(mpdetails.getInvoiceDate()) %> <%} %>
								               		   						 for Initial Advance Payment of Rs. <%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(milestonedetails.getActualAmount())) %>
								               		   						 and the invoice is placed opposite (Flag-B).
								               		   					</span>
							               		   					<%} %>
			               										</td>
			               										<td>
			               											<%if(mpdetails!=null && mpdetails.getAttachFlagB()!=null) {%>
								                            			<button type="submit" class="btn btn-sm" style="padding: 5px 8px;" name="filename" formmethod="post" formnovalidate="formnovalidate"
								                            				value="flagBFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
								                            				<i class="fa fa-download fa-lg"></i>
								                            			</button>
		                          					 				<%} %>
			               										</td>
			               									</tr>
			               									<%if(MilestoneNo!=null && !MilestoneNo.equalsIgnoreCase("MIL-1")) {%>
			               									<tr>
			               										<td><%=++paymentslno %>.</td>
			               										<td>
			               											Recommendation of CARS Review committee for releasing the proposed milestone payment is placed. (Flag-C)
			               										</td>
			               										<td>
			               											<%if(mpdetails!=null && mpdetails.getAttachFlagC()!=null) {%>
								                            			<button type="submit" class="btn btn-sm" style="padding: 5px 8px;" name="filename" formmethod="post" formnovalidate="formnovalidate"
								                            				value="flagCFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
								                            				<i class="fa fa-download fa-lg"></i>
								                            			</button>
		                          					 				<%} %>
			               										</td>
			               									</tr>
			               									<%} %>
			               									<tr>
			               										<td><%=++paymentslno %>.</td>
			               										<td>Uploaded Payment Approval form (After approval)</td>
			               										<td>
			               											<%if(mpdetails!=null && mpdetails.getUploadOtherDoc()!=null) {%>
								                            			<button type="submit" class="btn btn-sm" style="padding: 5px 8px;" name="filename" formmethod="post" formnovalidate="formnovalidate"
								                            				value="fileOtherDoc" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
								                            				<i class="fa fa-download fa-lg"></i>
								                            			</button>
		                          					 				<%} else{%>
		                          					 				 Not Uploaded
		                          					 				<%} %>
			               										</td>
			               									</tr>
			               								</tbody>
			               							</table>
			               						</form>
			               						
			               						<%if( (statuscode!=null && statuscode.equalsIgnoreCase("MAD") ) || (mpdetails!=null && mpdetails.getUploadOtherDoc()!=null)) {%>
			               							<br> <hr>
			               							
               										<form action="CARSMPDocUpload.htm" method="post" enctype="multipart/form-data">
	               										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	               		   								<input type="hidden" name="carsInitiationId" value="<%=carsIni.getCARSInitiationId()%>">
	               		   								<input type="hidden" name="otherDocDetailsId" value="<%if(mpdetails!=null){%><%=mpdetails.getOtherDocDetailsId() %><%}%>">
	               		   								<input type="hidden" name="otherDocType" value="C">
	               		   								<input type="hidden" name="MilestoneNo" value="<%=MilestoneNo%>">
	               		   								<br>
               											<div class="row">
               												<div class="col-md-3"></div>
						               			    		<div class="col-md-4" style="margin-left: 60px;">
						               			     			<div class="row details">
						                        					<div class="" style="width: 90%;border-top-left-radius: 5px;">
						                            					 <label class="control-label">Upload <%if(MilestoneNo!=null && !MilestoneNo.equalsIgnoreCase("MIL-1")) {%>Milestone<%} else{%>Initial Advance<%} %> Payment Approval form</label><span class="mandatory">*</span> 
						                            					 <%if(mpdetails!=null && mpdetails.getUploadOtherDoc()!=null) {%>
						                            					 	<button type="submit" class="btn btn-sm" style="padding: 5px 8px;margin-left: -2rem;" name="filename" formmethod="post" formnovalidate="formnovalidate"
						                            					 	value="fileOtherDoc" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="CARS Payment Approval Download">
						                            					 		<i class="fa fa-download fa-lg"></i>
						                            					 	</button>
						                            					 <%} %>
						                              		      		<input type="file" class="form-control modals" name="uploadOtherDoc" required accept=".pdf" >
						                        					</div>
						                        				</div>
						                        			</div>
						                        			<div class="col-md-4">
						                        				<div align="left" style="margin-top: 2.2rem;">
																	<button type="submit" class="btn btn-sm btn-success submit" formmethod="post" onclick="return confirm('Are you sure to Upload?')" >UPLOAD</button>
																</div>
						                        			</div>
                        								</div>
                        								<br>
               										</form>
               									<%} %>
			               					</div>
			               				</div>
			               			</div>
	               				<%} else{%>
               						<div class="mt-4" style="display: flex;justify-content: center; align-items: center;">
               							<h4 style="font-weight: bold;color: red;">Please fill the Payment Details..!</h4>
               						</div>
               					<%} %>
               					<div class="navigation_btn"  style="text-align: right;">
		            				<a class="btn btn-info btn-sm  shadow-nohover previous" >Previous</a>
									<button class="btn btn-info btn-sm next">Next</button>
								</div>
               			<%if(mpDocsTabId!=null && mpDocsTabId.equalsIgnoreCase("3")){ %> 
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
$('#mpOtherDocDate').daterangepicker({
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

$('#invoiceDate').daterangepicker({
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

//Onclick showing / Closing the info content

/* For MP Details Content */
$( "#mpInfo" ).on( "click", function() {
	var mpInfo = $('#mpInfo').val();
	if(mpInfo=="0"){
		$('#mpInfo').val('1');
		$('#mpInfoContent').show();
	
	}else{
		$('#mpInfo').val('0');
		$('#mpInfoContent').hide();
		}
} );

</script> 

<script type="text/javascript">
/* button disabling for MP Approval */
<%if((statuscode!=null && mpforwardstatus.contains(statuscode)) || statuscode.equalsIgnoreCase("N")) {%>
$('.btn-mp').prop('disabled',false);
<%} else{%>
$('.btn-mp').prop('disabled',true);
<%} %>

/* tabs hiding for MP approval */
<%if(isApproval!=null && (isApproval.equalsIgnoreCase("M") || isApproval.equalsIgnoreCase("N") )) {%>
   $('.navigation_btn').hide();
   $('#nav-mpdetails').hide();
   $('#nav-docuploads').hide();
<%} %>
</script>
         		
</body>
</html>
<%@page import="com.vts.pfms.cars.model.CARSSoC"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.vts.pfms.cars.model.CARSContract"%>
<%@page import="com.vts.pfms.IndianRupeeFormat"%>
<%@page import="com.vts.pfms.cars.model.CARSSoCMilestones"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.vts.pfms.cars.model.CARSOtherDocDetails"%>
<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.cars.model.CARSInitiation"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
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
 }
 
 td
 {
 	border: 1px solid black;
 	text-align: left;
 	padding: 5px;
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
 
 #containers {
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




.input-group-text {
	font-weight: bold;
}

label {
	font-weight: 800;
	font-size: 16px;
	color: #07689f;
}

hr {
	margin-top: -2px;
	margin-bottom: 12px;
}

.card b {
	font-size: 20px;
}
		
input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
    /* display: none; <- Crashes Chrome on hover */
    -webkit-appearance: none;
    margin: 0; /* <-- Apparently some margin are still there even though it's hidden */
}

input[type=number] {
    -moz-appearance:textfield; /* Firefox */
}
		
</style>

<style type="text/css">

/* icon styles */
.cc-rockmenu {
	color: fff;
	padding: 0px 5px;
	font-family: 'Lato', sans-serif;
}

.cc-rockmenu .rolling {
	display: inline-block;
	cursor: pointer;
	width: 34px;
	height: 30px;
	text-align: left;
	overflow: hidden;
	transition: all 0.3s ease-out;
	white-space: nowrap;
}

.cc-rockmenu .rolling:hover {
	width: 108px;
}

.cc-rockmenu .rolling .rolling_icon {
	float: left;
	z-index: 9;
	display: inline-block;
	width: 28px;
	height: 52px;
	box-sizing: border-box;
	margin: 0 5px 0 0;
}

.cc-rockmenu .rolling .rolling_icon:hover .rolling {
	width: 312px;
}

.cc-rockmenu .rolling i.fa {
	font-size: 20px;
	padding: 6px;
}

.cc-rockmenu .rolling span {
	display: block;
	font-weight: bold;
	padding: 2px 0;
	font-size: 14px;
	font-family: 'Muli', sans-serif;
}

.cc-rockmenu .rolling p {
	margin: 0;
}
.btn-status {
  position: relative;
  z-index: 1; 
}

.btn-status:hover {
  transform: scale(1.05);
  z-index: 5;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
}

.modal-dialog-jump {
  animation: jumpIn 1.5s ease;
}

@keyframes jumpIn {
  0% {
    transform: scale(0.1);
    opacity: 0;
  }
  70% {
    transform: scale(1);
  }
  100% {
    transform: scale(1);
    opacity: 1;
  }
}



label{
  font-weight: bold;
  font-size: 20px;
}

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
}
.panel-info > .panel-heading {
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

element.style {
}
.olre-body .panel-info .panel-heading {
    background-color: #FFF !important;
    border-color: #bce8f1 !important;
    border-bottom: 2px solid #466BA2 !important;

}
.panel-info > .panel-heading {
    color: #31708f;
    background-color: #d9edf7;
    border-color: #bce8f1;
}

.p-5 {
    padding: 5px;
}
.panel-heading {
    padding: 10px 15px;
    border-bottom: 1px solid transparent;
    border-top-left-radius: 3px;
    border-top-right-radius: 3px;
}
* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
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


.cssideheading{
	font-size: 17px;
}

.cssideheadingdata{
	font-size: 15px;
	color: black;
}


/* icon styles2 */
.cc-rockmenu2 {
	color: fff;
	padding: 0px 5px;
	font-family: 'Lato', sans-serif;
}

.cc-rockmenu2 .rolling2 {
	display: inline-block;
	cursor: pointer;
	width: 20px;
	height: 20px;
	text-align: left;
	overflow: hidden;
	transition: all 0.3s ease-out;
	white-space: nowrap;
}

.cc-rockmenu2 .rolling2:hover {
	width: 108px;
}

.cc-rockmenu2 .rolling2 .rolling_icon2 {
	float: left;
	z-index: 9;
	display: inline-block;
	width: 28px;
	height: 20px;
	box-sizing: border-box;
	margin: 0 5px 0 0;
}

.cc-rockmenu2 .rolling2 .rolling_icon2:hover .rolling {
	width: 312px;
}

.cc-rockmenu2 .rolling2 i.fa {
	font-size: 20px;
	padding: 6px;
}

.cc-rockmenu2 .rolling2 span {
	display: block;
	font-weight: bold;
	padding: 2px 0;
	font-size: 12px;
	font-family: 'Muli', sans-serif;
}

.cc-rockmenu2 .rolling2 p {
	margin: 0;
}
</style>
</head>
<body>
<%

CARSInitiation carsIni = (CARSInitiation)request.getAttribute("CARSInitiationData"); 
CARSSoC carsSoC = (CARSSoC)request.getAttribute("CARSSoCData"); 
CARSContract carsContract = (CARSContract)request.getAttribute("CARSContractData"); 
List<CARSSoCMilestones> milestones = (List<CARSSoCMilestones>)request.getAttribute("CARSSoCMilestones");
List<CARSOtherDocDetails> otherdocdetails = (List<CARSOtherDocDetails>)request.getAttribute("CARSOtherDocDetailsData");

Object[] statusdetails = (Object[])request.getAttribute("CARSStatusDetails");
List<Object[]> mpstatusdetailslist = (List<Object[]>)request.getAttribute("CARSMPStatusDetails");
List<Object[]> mpstatusdetails =null;
Object[] mpstatus =null;

List<CARSOtherDocDetails> csdetailslist = otherdocdetails.stream().filter(e-> "C".equalsIgnoreCase(e.getOtherDocType())).collect(Collectors.toList());
List<CARSOtherDocDetails> ptcdetailslist = null;
CARSOtherDocDetails ptcdetails = null;

CARSOtherDocDetails csdetails = csdetailslist!=null && csdetailslist.size()>0?csdetailslist.get(0):null;


FormatConverter fc = new FormatConverter();
SimpleDateFormat sdtf = fc.getSqlDateAndTimeFormat();
SimpleDateFormat sdf = fc.getSqlDateFormat();
SimpleDateFormat rdf = fc.getRegularDateFormat();

long carsInitiationId = carsIni.getCARSInitiationId();

Object[] PDs = (Object[])request.getAttribute("PDEmpIds");
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

<br>
<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			<div class="card shadow-nohover">
				<div class="row card-header" style="background: none;">
			   		<div class="col-md-6">
						<h4>Other Doc Details
							<button type="button" id="carsInfo" value="1" class="btn btn-info btn-sm" style="padding: 0px 5px 0px 5px;border: none;"><i class="fa fa-info-circle" aria-hidden="true"></i></button>
						</h4>
						
					</div>
				
					<div class="col-md-6 justify-content-end" style="float: right;margin-top: -0.25rem;">
						<div class="form-inline" style="justify-content: end;">
							<a class="btn btn-info btn-sm  shadow-nohover back" href="CARSRSQRApprovedList.htm?AllListTabId=3" style="color: white!important;float: right;">Back</a>  
						</div>
					</div>
				</div>
				<br>
				<div class="row" style="margin-left: 5rem;" id="carsInfoHeading">
					<div class="col-md-11">
						<div class="card shadow-nohover" style="margin-left: 1.3rem;max-width: 100%;min-width: 100%;">
							<div class="card-header" style=" /* background: linear-gradient(to right, #334d50, #cbcaa5); */ /* background-color:rgba(6,103,200,1); */ background-color: #0ba4b7;text-align: left;">
								<b class="text-white" style="">CARS Details: </b>
							</div> 
						</div>
					</div>
				</div>
				<div class="row" style="margin-left: 5rem;" id="carsInfoContent">
					<div class="col-md-11" align="left" style="margin-left: 20px;">
					    <div class="panel panel-info">
					      	<div class="panel-heading">
					        	<h4 class="panel-title">
					          		<div>
					              		<div class="row">
					                		<div class="col-md-12">
					                			<span class="cssideheading">Title:</span>
					                			&emsp;<span class="cssideheadingdata"><%if(carsIni!=null && carsIni.getInitiationTitle()!=null) {%><%=carsIni.getInitiationTitle() %> <%} else{%>-<%} %></span>
					                		</div>
					                	</div>
					                	<br>
					                	<div class="row">
					                		<div class="col-md-4">
					                			<span class="cssideheading">CARS. No:</span>
					                			&emsp;<span class="cssideheadingdata"><%if(carsIni!=null && carsIni.getCARSNo()!=null) {%><%=carsIni.getCARSNo() %> <%} else{%>-<%} %></span>
					                		</div>
					                		<div class="col-md-4">
					                			<span class="cssideheading">Funds from:</span>
					                			&emsp;<span class="cssideheadingdata">
					                			<%if(carsIni!=null && carsIni.getFundsFrom()!=null && carsIni.getFundsFrom().equalsIgnoreCase("0")) {%>
					                				Buildup
					                			 <%} else{%>
					                			 	 <%if(PDs!=null && PDs[4]!=null) {%><%=PDs[4] %><%} %>
					                			 <%} %></span>
					                		</div>
					                		<div class="col-md-4">
					                			<span class="cssideheading">Amount:</span>
					                			&emsp;<span class="cssideheadingdata">
					                				<%if(carsSoC!=null && carsSoC.getSoCAmount()!=null) {%>
					                					<%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(carsSoC.getSoCAmount())) %>
					                				<%} else{%>-<%} %></span>
					                		</div>
					                	</div>
					                		
					                </div>
					        	</h4>
					   		</div>
						</div>
					</div>
				</div>
				<br>
					                			
				<%if(csdetailslist!=null && csdetailslist.size()>0) {%>
					<div class="row" style="margin-left: 5rem;">
						<div class="col-md-11">
							<div class="card shadow-nohover" style="margin-left: 1.3rem;max-width: 100%;min-width: 100%;">
								<div class="card-header" style=" /* background: linear-gradient(to right, #334d50, #cbcaa5); */ /* background-color:rgba(6,103,200,1); */ background-color: #055C9D;text-align: left;">
								    <b class="text-white" style="">Contract Signature Details: </b> 
							    </div> 
							</div>
						</div>
					</div>
					<div class="row" style="margin-left: 5rem;">
						<div class="col-md-11" align="left" style="margin-left: 20px;">
					    	<div class="panel panel-info">
					      		<div class="panel-heading">
					        		<h4 class="panel-title">
					          			<div>
					              			<div class="row">
					                			<div class="col-md-2">
					                				<span class="cssideheading">Date:</span>
					                				&emsp;<span class="cssideheadingdata"><%if(csdetails!=null && csdetails.getOtherDocDate()!=null) {%><%=fc.SqlToRegularDate(csdetails.getOtherDocDate()) %> <%} else{%>-<%} %></span>
					                			</div>
					                			<div class="col-md-3">
					                				<span class="cssideheading">File No:</span>
					                				&emsp;<span class="cssideheadingdata"><%if(carsContract!=null && carsContract.getContractNo()!=null) {%><%=carsContract.getContractNo() %> <%} else{%>-<%} %></span>
					                			</div>
					                			<div class="col-md-4">
					                				<form action="#" method="post" id="transform">
					                					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					                				</form>
					                				<span class="cssideheading">Status:</span>
					                				&emsp;<span>
					                					
					                					<button type="submit" form="transform" class="btn btn-sm btn-link w-50 btn-status" formaction="CARSTransStatus.htm" formnovalidate="formnovalidate" value="<%=carsInitiationId %>" name="carsInitiationId"  data-toggle="tooltip" data-placement="top" title="Transaction History" style=" color: <%if(statusdetails!=null) {%><%=statusdetails[3] %><%} %>; font-weight: 600;" formtarget="_blank">
													    	<%if(statusdetails!=null) {%><%=statusdetails[2] %><%} else{%>--<%} %> <i class="fa fa-telegram" aria-hidden="true" style="float: right;margin-top: 0.3rem;"></i>
													    </button>
					                				</span>
					                			</div>
					                			<div class="col-md-3">
					                				<span class="cssideheading">Action:</span>
					                				&emsp; <span>
					                					<button type="submit" form="transform" class="btn btn-sm" name="carsInitiationId" value="<%=carsInitiationId %>" formaction="CARSContractSignatureDetails.htm" formnovalidate="formnovalidate" formmethod="post" data-toggle="tooltip" data-placement="top" title="Contract Details">
													  		<div class="cc-rockmenu2">
																<div class="rolling2" >
																	<figure class="rolling_icon2">
																		<img src="view/images/clipboard.png" style="width: 18px;">
																	</figure>
																	<span>CS Details</span>
																</div>
															</div>
														</button>
														<%if(statusdetails[1]!=null && statusdetails[1].toString().equalsIgnoreCase("CFW") ) {%>
						                                	<button type="submit" form="transform" class="btn btn-sm" name="carsInitiationId" value="<%=carsInitiationId %>" formaction="CARSCSDocRevoke.htm" formnovalidate="formnovalidate" formmethod="post" onclick="return confirm('Are you sure to revoke?')">
																<div class="cc-rockmenu2">
																	<div class="rolling2">
																		<figure class="rolling_icon2">
																			<img src="view/images/userrevoke.png" style="width: 20px !important;">
																		</figure>
																		<span>Revoke</span>
																	</div>
																</div>
															</button>
												    	<%} %>
					                				</span>
					                			</div>
					              			</div>
					          			</div>
					        		</h4>
					      		</div>
					    	</div>
					  	</div>
					</div>				
				<%} else{%>
					
					<div align="center">
						<form action="#" method="post">
							<input type="hidden" name="carsInitiationId" value=<%=carsInitiationId%> />
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<button type="submit" class="btn btn-sm add" formaction="CARSContractSignatureDetails.htm" id="" >Contract Signature</button>
						</form>
	                </div>
	                
				<%} %>
				<br> <hr> <br>
				<div class="row" style="margin-left: 5rem;">
					<div class="col-md-11">
						<div class="card shadow-nohover" style="margin-left: 1.3rem;max-width: 100%;min-width: 100%;">
							<div class="card-header" style=" /* background: linear-gradient(to right, #334d50, #cbcaa5); */ /* background-color:rgba(6,103,200,1); */ background-color: #055C9D;text-align: left;">
								<b class="text-white" style="">Payment Details: </b> 
							</div> 
						</div>
					</div>
				</div>
				<div class="row" style="margin-left: 5rem;">
					<div class="col-md-11" align="left" style="margin-left: 20px;">
						<div class="table-responsive">
							<table class="table table-bordered table-hover table-striped table-condensed"  id="">
								<thead>
						        	<tr>
						            	<th style="width: 30%;color: #055C9D;">Description</th>
						            	<!-- <th style="width: 10%;color: #055C9D;">Milestone No.</th> -->
						            	<!-- <th style="width: 28%;">Task Description</th> -->
						            	<th style="width: 10%;color: #055C9D;">Months</th>
						            	<!-- <th style="width: 25%;">Deliverables</th> -->
						             	<!-- <th style="width: 10%;color: #055C9D;">Payment ( In % )</th> -->
						            	<th style="width: 10%;color: #055C9D;">Amount (&#8377; )</th>
						            	<!-- <th style="width: 15%;">Remarks</th> -->
						            	<!-- <th style="color: #055C9D;">Status</th> -->
						            	<th style="width: 20%;color: #055C9D;">Action</th>
						            </tr>
					            </thead>
					            <tbody>
					            	<%-- <%if(milestones!=null && milestones.size()>0) {
					               		for(CARSSoCMilestones mil : milestones){
					               	%>
						            	<tr>
						               		<td style="width: 10%;text-align: center;"><%=mil.getMilestoneNo() %></td>
						               		<td style="width: 28%;"><%=mil.getTaskDesc() %></td>
						               		<td style="width: 10%;text-align: center;"><%="T0 + "+mil.getMonths() %></td>
						               		<td style="width: 25%;"><%=mil.getDeliverables() %></td>
						               		<td style="width: 10%;text-align: center;"><%=mil.getPaymentPercentage() %></td>
						               		<td style="width: 10%;text-align: right;"><%if(mil.getActualAmount()!=null) {%><%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(mil.getActualAmount())) %><%} else{%>-<%} %></td>
						               		<td style="width: 15%;"><%if(mil.getPaymentTerms()!=null) {%><%=mil.getPaymentTerms() %><%} else{%>-<%} %></td>
						               		<td></td>
						               		<td></td>
						               	</tr>
					               	<%}} %> --%>
					               	<%if(milestones!=null && milestones.size()>0) { char a='a';%>
							    		<tr>
							    			<td style="text-align : left;word-wrap: break-word;word-break: normal;vertical-align: top;">&nbsp;(a) Initial Advance &nbsp;&nbsp;(<%=milestones.get(0).getPaymentPercentage() %>%) </td>
							    			<%-- <td style="text-align : center;vertical-align: top;"><%=milestones.get(0).getMilestoneNo() %></td> --%>
							    			<td style="text-align : center;vertical-align: top;">T0</td>
							    			<td style="text-align : right;vertical-align: top;">
							    				<%if(milestones.get(0).getActualAmount()!=null) {%>
							    					<%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(milestones.get(0).getActualAmount())) %>
							    				<%} else{%>
							    					-
							    				<%} %>
							    				&nbsp;&nbsp;
							    			</td>
							    			<%-- <td style="text-align : center;">
							    				<form action="#" method="post" >
							    					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							    					<input type="hidden" name="milestoneNo" value="<%=milestones.get(0).getMilestoneNo()%>">
							    					<button type="submit" class="btn btn-sm btn-link w-50 btn-status" formaction="CARSTransStatus.htm" formnovalidate="formnovalidate" value="<%=carsInitiationId %>" name="carsInitiationId"  data-toggle="tooltip" data-placement="top" title="Transaction History" style=" color: <%if(statusdetails!=null) {%><%=statusdetails[3] %><%} %>; font-weight: 600;" formtarget="_blank">
														<%if(statusdetails!=null) {%><%=statusdetails[2] %><%} else{%>--<%} %> <i class="fa fa-telegram" aria-hidden="true" style="float: right;margin-top: 0.3rem;"></i>
													</button>
							    				</form>
							    			</td> --%>
							    			<td style="text-align: center;">
							    				<form action="#" method="post">
		                                        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		                                        	<input type="hidden" name="MilestoneNo" value="<%=milestones.get(0).getMilestoneNo()%>">
		                                        	<button class="editable-clicko" name="carsInitiationId" value="<%=carsInitiationId %>" formaction="CARSMilestonePaymentDetails.htm" formnovalidate="formnovalidate" formmethod="post" data-toggle="tooltip" data-placement="top" title="Payment Details">
														<div class="cc-rockmenu">
															<div class="rolling">
																<figure class="rolling_icon">
																	<img src="view/images/clipboard.png">
																</figure>
																<span>Details</span>
															</div>
														</div>
												    </button>
												    <%
												    mpstatusdetails = mpstatusdetailslist.stream().filter(e-> e[4].toString().equalsIgnoreCase(milestones.get(0).getMilestoneNo())).collect(Collectors.toList());
												    mpstatus = mpstatusdetails!=null&& mpstatusdetails.size()>0?mpstatusdetails.get(0):null;
												    %>
												    <%if(mpstatus!=null && mpstatus[1]!=null && mpstatus[1].toString().equalsIgnoreCase("MFW") ) {%>
						                            	<button class="editable-clicko" name="carsInitiationId" value="<%=carsInitiationId %>" formaction="CARSMPDocRevoke.htm" formmethod="post" onclick="return confirm('Are you sure to revoke?')">
															<div class="cc-rockmenu">
																<div class="rolling">
																	<figure class="rolling_icon">
																		<img src="view/images/userrevoke.png" style="width: 22px !important;">
																	</figure>
																	<span>Revoke</span>
																</div>
															</div>
														</button>
												    <%} %>
												    <%if(mpstatus!=null && mpstatus[1]!=null && mpstatus[1].toString().equalsIgnoreCase("MAD") ) {%>
												    	<%
												    	ptcdetailslist = otherdocdetails.stream().filter(e-> "P".equalsIgnoreCase(e.getOtherDocType()) && milestones.get(0).getMilestoneNo().equalsIgnoreCase(e.getMilestoneNo())).collect(Collectors.toList());
												    	ptcdetails = ptcdetailslist!=null && ptcdetailslist.size()>0 ? ptcdetailslist.get(0): null;
												    	long otherdocdetailsid = ptcdetails!=null?ptcdetails.getOtherDocDetailsId():0;
												    	String otherdocdate = ptcdetails!=null?ptcdetails.getOtherDocDate():null;
												    	otherdocdate = otherdocdate!=null?fc.SqlToRegularDate(otherdocdate):rdf.format(new Date());
												    	
												    	%>
												    	<button type="button" class="btn btn-sm" data-toggle="modal" onclick="openCalendar('<%=carsInitiationId%>','<%=otherdocdetailsid%>','<%=milestones.get(0).getMilestoneNo() %>','<%=otherdocdate %>')" style="margin-top: -0.8rem;">
													  		<div class="cc-rockmenu">
																<div class="rolling">
																	<figure class="rolling_icon">
																		<img src="view/images/calendar.png">
																	</figure>
																	<span>Date</span>
																</div>
															</div>
														</button>
												    	<button class="editable-clicko" name="carsInitiationId" value="<%=carsInitiationId %>" formaction="CARSMilestonePaymentLetterDownload.htm"  formtarget="blank" formmethod="post" formnovalidate="formnovalidate" data-toggle="tooltip" data-placement="top" title="Download"
												    	  <%if(ptcdetails==null) {%>type="button" onclick="return alert('Please fill date of payment')"<%} %>>
															<div class="cc-rockmenu">
																<div class="rolling">
																	<figure class="rolling_icon">
																		<img src="view/images/letter.png" style="width: 22px !important;">
																	</figure>
																	<span>Payment Letter</span>
																</div>
															</div>
														</button>
												    <%} %>
		                                        </form>
							    			</td>
							    		</tr>
							    		<% for(int i=1;i<milestones.size()-1;i++) { %>
							    		<tr>
							    			<td style="text-align : left;vertical-align: top;">&nbsp;(<%=++a %>) Performance Milestone-<%=(i+1) %> of RSQR &nbsp;&nbsp;(<%=milestones.get(i).getPaymentPercentage() %>%) </td>
							    			<%-- <td style="text-align : center;vertical-align: top;"><%=milestones.get((i)).getMilestoneNo() %> </td> --%>
							    			<td style="text-align : center;vertical-align: top;">T0+<%=milestones.get((i)).getMonths() %> </td>
							    			<td style="text-align : right;vertical-align: top;">
							    				<%if(milestones.get(i).getActualAmount()!=null) {%>
							    					<%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(milestones.get(i).getActualAmount())) %>
							    				<%} else{%>
							    					-
							    				<%} %>
							    				&nbsp;&nbsp;
							    			</td>
							    			<%-- <td style="text-align : center;">
							    				<form action="#" method="post" >
							    					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							    					<input type="hidden" name="milestoneNo" value="<%=milestones.get(i).getMilestoneNo()%>">
							    					<button type="submit" class="btn btn-sm btn-link w-50 btn-status" formaction="CARSMPTransStatus.htm" formnovalidate="formnovalidate" value="<%=carsInitiationId %>" name="carsInitiationId"  data-toggle="tooltip" data-placement="top" title="Transaction History" style=" color: <%if(statusdetails!=null) {%><%=statusdetails[3] %><%} %>; font-weight: 600;" formtarget="_blank">
														<%if(statusdetails!=null) {%><%=statusdetails[2] %><%} else{%>--<%} %> <i class="fa fa-telegram" aria-hidden="true" style="float: right;margin-top: 0.3rem;"></i>
													</button>
							    				</form>
							    			</td> --%>
							    			<td style="text-align: center;">
							    				<form action="#" method="post">
		                                        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		                                        	<input type="hidden" name="MilestoneNo" value="<%=milestones.get(i).getMilestoneNo()%>">
		                                        	<button class="editable-clicko" name="carsInitiationId" value="<%=carsInitiationId %>" formaction="CARSMilestonePaymentDetails.htm" formnovalidate="formnovalidate" formmethod="post" data-toggle="tooltip" data-placement="top" title="Payment Details">
														<div class="cc-rockmenu">
															<div class="rolling">
																<figure class="rolling_icon">
																	<img src="view/images/clipboard.png">
																</figure>
																<span>Details</span>
															</div>
														</div>
												    </button>
												    <%
												    String mil = milestones.get(i).getMilestoneNo();
												    mpstatusdetails = mpstatusdetailslist.stream().filter(e-> e[4].toString().equalsIgnoreCase(mil)).collect(Collectors.toList());
												    mpstatus = mpstatusdetails!=null&& mpstatusdetails.size()>0?mpstatusdetails.get(0):null;
												    %>
												    <%if(mpstatus!=null && mpstatus[1]!=null && mpstatus[1].toString().equalsIgnoreCase("MFW") ) {%>
						                            	<button class="editable-clicko" name="carsInitiationId" value="<%=carsInitiationId %>" formaction="CARSMPDocRevoke.htm" formmethod="post" onclick="return confirm('Are you sure to revoke?')">
															<div class="cc-rockmenu">
																<div class="rolling">
																	<figure class="rolling_icon">
																		<img src="view/images/userrevoke.png" style="width: 22px !important;">
																	</figure>
																	<span>Revoke</span>
																</div>
															</div>
														</button>
												    <%} %>
												    
												    <%if(mpstatus!=null && mpstatus[1]!=null && mpstatus[1].toString().equalsIgnoreCase("MAD") ) {%>
												    	<%
												    	ptcdetailslist = otherdocdetails.stream().filter(e-> "P".equalsIgnoreCase(e.getOtherDocType()) && mil.equalsIgnoreCase(e.getMilestoneNo())).collect(Collectors.toList());
												    	ptcdetails = ptcdetailslist!=null && ptcdetailslist.size()>0 ? ptcdetailslist.get(0): null;
												    	long otherdocdetailsid = ptcdetails!=null?ptcdetails.getOtherDocDetailsId():0;
												    	String otherdocdate = ptcdetails!=null?ptcdetails.getOtherDocDate():null;
												    	otherdocdate = otherdocdate!=null?fc.SqlToRegularDate(otherdocdate):rdf.format(new Date());
												    	
												    	%>
												    	<button type="button" class="btn btn-sm" data-toggle="modal" onclick="openCalendar('<%=carsInitiationId%>','<%=otherdocdetailsid%>','<%=milestones.get(0).getMilestoneNo() %>','<%=otherdocdate %>')" style="margin-top: -0.8rem;">
													  		<div class="cc-rockmenu">
																<div class="rolling">
																	<figure class="rolling_icon">
																		<img src="view/images/calendar.png">
																	</figure>
																	<span>Date</span>
																</div>
															</div>
														</button>
												    	<button class="editable-clicko" name="carsInitiationId" value="<%=carsInitiationId %>" formaction="CARSMilestonePaymentLetterDownload.htm"  formtarget="blank" formmethod="post" formnovalidate="formnovalidate" data-toggle="tooltip" data-placement="top" title="Download"
												    	  <%if(ptcdetails==null) {%>type="button" onclick="return alert('Please fill date of payment')"<%} %>>
															<div class="cc-rockmenu">
																<div class="rolling">
																	<figure class="rolling_icon">
																		<img src="view/images/letter.png" style="width: 22px !important;">
																	</figure>
																	<span>Payment Letter</span>
																</div>
															</div>
														</button>
												    <%} %>
												    
		                                        </form>
							    			</td>
							    		</tr>
							    		<%}%>
							    		<tr>
							    			<td style="text-align : left;word-wrap: break-word;word-break: normal;vertical-align: top;">&nbsp;(<%=++a %>) on submission of final report &nbsp;&nbsp;(<%=milestones.get(milestones.size()-1).getPaymentPercentage() %>%) </td>
							    			<%-- <td style="text-align : center;vertical-align: top;"><%=milestones.get(milestones.size()-1).getMilestoneNo() %> </td> --%>
							    			<td style="text-align : center;vertical-align: top;">T0+<%=milestones.get(milestones.size()-1).getMonths() %> </td>
							    			<td style="text-align : right;vertical-align: top;">
							    				<%if(milestones.get(milestones.size()-1).getActualAmount()!=null) {%>
							    					<%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(milestones.get(milestones.size()-1).getActualAmount())) %>
							    				<%} else{%>
							    					-
							    				<%} %>
							    				&nbsp;&nbsp;
							    			</td>
							    			<%-- <td style="text-align : center;">
							    				<form action="#" method="post" >
							    					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							    					<input type="hidden" name="milestoneNo" value="<%=milestones.get(milestones.size()-1).getMilestoneNo()%>">
							    					<button type="submit" class="btn btn-sm btn-link w-50 btn-status" formaction="CARSMPTransStatus.htm" formnovalidate="formnovalidate" value="<%=carsInitiationId %>" name="carsInitiationId"  data-toggle="tooltip" data-placement="top" title="Transaction History" style=" color: <%if(statusdetails!=null) {%><%=statusdetails[3] %><%} %>; font-weight: 600;" formtarget="_blank">
														<%if(statusdetails!=null) {%><%=statusdetails[2] %><%} else{%>--<%} %> <i class="fa fa-telegram" aria-hidden="true" style="float: right;margin-top: 0.3rem;"></i>
													</button>
							    				</form>
							    			</td> --%>
							    			<td style="text-align: center;">
							    				<form action="#" method="post">
		                                        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		                                        	<input type="hidden" name="MilestoneNo" value="<%=milestones.get(milestones.size()-1).getMilestoneNo()%>">
		                                        	<button class="editable-clicko" name="carsInitiationId" value="<%=carsInitiationId %>" formaction="CARSMilestonePaymentDetails.htm" formnovalidate="formnovalidate" formmethod="post" data-toggle="tooltip" data-placement="top" title="Payment Details">
														<div class="cc-rockmenu">
															<div class="rolling">
																<figure class="rolling_icon">
																	<img src="view/images/clipboard.png">
																</figure>
																<span>Details</span>
															</div>
														</div>
												    </button>
												    <%
												    mpstatusdetails = mpstatusdetailslist.stream().filter(e-> e[4].toString().equalsIgnoreCase(milestones.get(milestones.size()-1).getMilestoneNo())).collect(Collectors.toList());
												    mpstatus = mpstatusdetails!=null && mpstatusdetails.size()>0?mpstatusdetails.get(0):null;
												    %>
												    <%if(mpstatus!=null && mpstatus[1]!=null && mpstatus[1].toString().equalsIgnoreCase("MFW") ) {%>
						                            	<button class="editable-clicko" name="carsInitiationId" value="<%=carsInitiationId %>" formaction="CARSMPDocRevoke.htm" formmethod="post" onclick="return confirm('Are you sure to revoke?')">
															<div class="cc-rockmenu">
																<div class="rolling">
																	<figure class="rolling_icon">
																		<img src="view/images/userrevoke.png" style="width: 22px !important;">
																	</figure>
																	<span>Revoke</span>
																</div>
															</div>
														</button>
												    <%} %>
												    
												    <%if(mpstatus!=null && mpstatus[1]!=null && mpstatus[1].toString().equalsIgnoreCase("MAD") ) {%>
												    	<%
												    	ptcdetailslist = otherdocdetails.stream().filter(e-> "P".equalsIgnoreCase(e.getOtherDocType()) && milestones.get(milestones.size()-1).getMilestoneNo().equalsIgnoreCase(e.getMilestoneNo())).collect(Collectors.toList());
												    	ptcdetails = ptcdetailslist!=null && ptcdetailslist.size()>0 ? ptcdetailslist.get(0): null;
												    	long otherdocdetailsid = ptcdetails!=null?ptcdetails.getOtherDocDetailsId():0;
												    	String otherdocdate = ptcdetails!=null?ptcdetails.getOtherDocDate():null;
												    	otherdocdate = otherdocdate!=null?fc.SqlToRegularDate(otherdocdate):rdf.format(new Date());
												    	
												    	%>
												    	<button type="button" class="btn btn-sm" data-toggle="modal" onclick="openCalendar('<%=carsInitiationId%>','<%=otherdocdetailsid%>','<%=milestones.get(0).getMilestoneNo() %>','<%=otherdocdate %>')" style="margin-top: -0.8rem;">
													  		<div class="cc-rockmenu">
																<div class="rolling">
																	<figure class="rolling_icon">
																		<img src="view/images/calendar.png">
																	</figure>
																	<span>Date</span>
																</div>
															</div>
														</button>
												    	<button class="editable-clicko" name="carsInitiationId" value="<%=carsInitiationId %>" formaction="CARSMilestonePaymentLetterDownload.htm"  formtarget="blank" formmethod="post" formnovalidate="formnovalidate" data-toggle="tooltip" data-placement="top" title="Download"
												    	  <%if(ptcdetails==null) {%>type="button" onclick="return alert('Please fill date of payment')"<%} %>>
															<div class="cc-rockmenu">
																<div class="rolling">
																	<figure class="rolling_icon">
																		<img src="view/images/letter.png" style="width: 22px !important;">
																	</figure>
																	<span>Payment Letter</span>
																</div>
															</div>
														</button>
												    <%} %>
												    
		                                        </form>
							    			</td>
							    		</tr>
			    					<%} %>
					            </tbody>
					        </table>
						</div>
					</div>
				</div>  
				<form action="">
					<div class="container">
												
						<!-- The Modal -->
						<div class="modal" id="myModal" style="margin-top: 10%;">
							<div class="modal-dialog">
								<div class="modal-dialog modal-dialog-jump modal-lg modal-dialog-centered">
									<div class="modal-content">
												     
										<!-- Modal Header -->
										<div class="modal-header">
											<h4 class="modal-title">Choose date of Payment</h4>
											<button type="button" class="close" data-dismiss="modal">&times;</button>
										</div>
										<!-- Modal body -->
										<div class="modal-body">
											<div class="form-inline">
												<div class="form-group w-100">
													<label>Payment Date : &nbsp;&nbsp;&nbsp;</label> 
												    <input class="form-control" type="text" name="ptcOtherDocDate" id="ptcOtherDocDate" required readonly>
												</div>
											</div>
										</div>
												      
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
										<input type="hidden" name="carsInitiationId" id="carsInitiationId">
										<input type="hidden" name="otherDocDetailsId" id="otherDocDetailsId">
										<input type="hidden" name="MilestoneNo" id="MilestoneNo">
										<!-- Modal footer -->
										<div class="modal-footer" style="justify-content: center;">
											<button type="submit" formaction="CARSPaymentDocDetailsSubmit.htm"  class="btn btn-sm submit" onclick="return confirm('Are You Sure To Submit?');" >SUBMIT</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>   
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">

$('#ptcOtherDocDate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	/* "minDate" :datearray,   */
	 "startDate" : new Date(),
	 "maxDate" : new Date(),
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});	 


function openCalendar(carsIniId, otherdocdetailsid, milestoneno, otherdocdate){
	$('#myModal').modal('show');
	$('#carsInitiationId').val(carsIniId);
	$('#otherDocDetailsId').val(otherdocdetailsid);
	$('#MilestoneNo').val(milestoneno);
	$('#ptcOtherDocDate').val(otherdocdate);
}

$(function () {
	$('[data-toggle="tooltip"]').tooltip()
});	


$(document).ready(function() {
    $('#myTable').DataTable( {
    	 "paging":   false,
         "ordering": false,
         "info":     false,
         "filter": false
    } );
} );

</script>

<script type="text/javascript">

//Onclick showing / Closing the info content

/* For CARS Details Content */
$( "#carsInfo" ).on( "click", function() {
	var carsInfo = $('#carsInfo').val();
	if(carsInfo=="0"){
		$('#carsInfo').val('1');
		$('#carsInfoContent').show();
		$('#carsInfoHeading').show();
	
	}else{
		$('#carsInfo').val('0');
		$('#carsInfoContent').hide();
		$('#carsInfoHeading').hide();
		}
} );

</script> 
</body>
</html>
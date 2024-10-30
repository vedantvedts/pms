<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.vts.pfms.IndianRupeeFormat"%>
<%@page import="com.vts.pfms.cars.model.CARSSoC"%>
<%@page import="com.vts.pfms.cars.model.CARSSoCMilestones"%>
<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.cars.model.CARSContract"%>
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

.flex-container {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
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

</style>
</head>
<body>
<%
CARSInitiation carsIni = (CARSInitiation)request.getAttribute("carsInitiationData"); 
CARSSoC carsSoC = (CARSSoC)request.getAttribute("carsSoCData"); 
CARSContract carsContract = (CARSContract)request.getAttribute("carsContractData"); 
List<CARSSoCMilestones> milestones = (List<CARSSoCMilestones>)request.getAttribute("carsSoCMilestones");
List<Object[]> milestoneProgressList = (List<Object[]>)request.getAttribute("milestoneProgressList");


Object[] PDs = (Object[])request.getAttribute("PDEmpIds");

FormatConverter fc = new FormatConverter();

long carsInitiationId = carsIni.getCARSInitiationId();
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
						<h4>CARS Milestones Monitor
							<button type="button" id="carsInfo" value="1" class="btn btn-info btn-sm" style="padding: 0px 5px 0px 5px;border: none;"><i class="fa fa-info-circle" aria-hidden="true"></i></button>
						</h4>
						
					</div>
				
					<div class="col-md-6 justify-content-end" style="float: right;margin-top: -0.25rem;">
						<div class="form-inline" style="justify-content: end;">
							<a class="btn btn-info btn-sm  shadow-nohover back" href="CARSInitiationList.htm" style="color: white!important;float: right;">Back</a>  
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
				
				<div class="row" style="margin-left: 5rem;">
					<div class="col-md-11" align="left" style="margin-left: 20px;">
						<div class="table-responsive">
							<table class="table table-bordered table-hover table-striped table-condensed"  id="">
								<thead>
						        	<tr>
						            	<th style="width: 30%;color: #055C9D;">Description</th>
						            	<th style="width: 10%;color: #055C9D;">Months</th>
						            	<th style="width: 10%;color: #055C9D;">EDP</th>
						            	<th style="width: 10%;color: #055C9D;">Amount (&#8377;)</th>
						            	<!-- <th style="color: #055C9D;">Progress</th> -->
						            	<th style="width: 20%;color: #055C9D;">Action</th>
						            </tr>
					            </thead>
					            <tbody>
					            	
					               	<%if(milestones!=null && milestones.size()>0) { char a='a'; Object[] progressData = null;%>
							    		<tr>
							    			<td style="text-align : left;word-wrap: break-word;word-break: normal;vertical-align: top;">&nbsp;(a) Initial Advance &nbsp;&nbsp;(<%=milestones.get(0).getPaymentPercentage() %>%) </td>
							    			<td style="text-align : center;vertical-align: top;">T0*</td>
							    			<td style="text-align : center;vertical-align: top;">
							    				<%if(carsContract.getT0Date()!=null) {%><%=fc.SqlToRegularDate(carsContract.getT0Date()) %><%} %> 
							    			</td>
							    			<td style="text-align : right;vertical-align: top;">
							    				<%if(milestones.get(0).getActualAmount()!=null) {%>
							    					<%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(milestones.get(0).getActualAmount())) %>
							    				<%} else{%>
							    					-
							    				<%} %>
							    				&nbsp;&nbsp;
							    			</td>
							    			
							    			<td>
							    				<form action="#" method="POST" name="myfrm" >
							    					<div class="d-flex justify-content-center">
							    						<button  class="editable-click" name="Action" value="Actions" formaction="CARSMilestonesMonitorDetails.htm">
															<div class="cc-rockmenu">
														 		<div class="rolling">	
									                        		<figure class="rolling_icon"><img src="view/images/preview3.png" ></figure>
									                        		<span>Actions</span>
									                      		</div>
									                     	</div>
											        	</button> 
											        	<button  class="editable-click" name="Action" value="MilestoneProgress" formaction="CARSMilestonesProgressDetails.htm" style="width: 50%;">
													        <%
													        progressData = milestoneProgressList!=null && milestoneProgressList.size()>0?milestoneProgressList.stream().filter(e -> e[5].toString().equalsIgnoreCase(milestones.get(0).getMilestoneNo())).findFirst().orElse(null): null;
													        %>
													        <%if(progressData!=null) {%>
																<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
																	<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=progressData[2] %>%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
																		<%=progressData[2] %>
																	</div> 
																</div>	
															<%}else{ %>
																<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
																	<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
																		0
																	</div>
																</div>
															<%} %>
														</button>
							    					</div>
												        
													<input type="hidden" name="carsSoCMilestoneId" value="<%=milestones.get(0).getCARSSoCMilestoneId()%>"/>
													<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId%>"/>
													<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
														
												</form>
							    			</td>
							    		</tr>
							    		<% for(int i=1;i<milestones.size()-1;i++) { 
							    			String milestoneNo = milestones.get(i).getMilestoneNo();
							    		%>
							    		<tr>
							    			<td style="text-align : left;vertical-align: top;">&nbsp;(<%=++a %>) Performance Milestone-<%=(i) %> of RSQR &nbsp;&nbsp;(<%=milestones.get(i).getPaymentPercentage() %>%) </td>
							    			<td style="text-align : center;vertical-align: top;">T0+<%=milestones.get((i)).getMonths() %> </td>
							    			<td style="text-align : center;vertical-align: top;">
							    				<%if(carsContract.getT0Date()!=null) {
							    					LocalDate sqldate = LocalDate.parse(carsContract.getT0Date()).plusMonths(Long.parseLong(milestones.get((i)).getMonths()));
							    				%>
							    					<%=fc.SqlToRegularDate(sqldate.toString()) %> 
							    				<%} %>	
							    			</td>
							    			<td style="text-align : right;vertical-align: top;">
							    				<%if(milestones.get(i).getActualAmount()!=null) {%>
							    					<%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(milestones.get(i).getActualAmount())) %>
							    				<%} else{%>
							    					-
							    				<%} %>
							    				&nbsp;&nbsp;
							    			</td>
							    			<td>
							    				<form action="#" method="POST" name="myfrm"  style="display: inline">
													<div class="d-flex justify-content-center">	
														<button  class="editable-click" name="Action" value="Actions" formaction="CARSMilestonesMonitorDetails.htm">
															<div class="cc-rockmenu">
														 		<div class="rolling">	
									                        		<figure class="rolling_icon"><img src="view/images/preview3.png" ></figure>
									                        		<span>Actions</span>
									                      		</div>
									                     	</div>
												        </button>   
													
														<button  class="editable-click" name="Action" value="MilestoneProgress" formaction="CARSMilestonesProgressDetails.htm" style="width: 50%;">
													        <%
													        progressData = milestoneProgressList!=null && milestoneProgressList.size()>0?milestoneProgressList.stream().filter(e -> e[5].toString().equalsIgnoreCase(milestoneNo)).findFirst().orElse(null): null;
													        %>
													        <%if(progressData!=null) {%>
																<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
																	<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=progressData[2] %>%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
																		<%=progressData[2] %>
																	</div> 
																</div>	
															<%}else{ %>
																<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
																	<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
																		0
																	</div>
																</div>
															<%} %>
														</button>   
											        </div>		
													<input type="hidden" name="carsSoCMilestoneId" value="<%=milestones.get(i).getCARSSoCMilestoneId()%>"/>
													<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId%>"/>
													<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
														
												</form>
							    			</td>
							    		</tr>
							    		<%}%>
							    		<%if(milestones.size()>1) {%>
							    		<tr>
							    			<td style="text-align : left;word-wrap: break-word;word-break: normal;vertical-align: top;">&nbsp;(<%=++a %>) on submission of final report &nbsp;&nbsp;(<%=milestones.get(milestones.size()-1).getPaymentPercentage() %>%) </td>
							    			<td style="text-align : center;vertical-align: top;">T0+<%=milestones.get(milestones.size()-1).getMonths() %> </td>
							    			<td style="text-align : center;vertical-align: top;">
							    				<%if(carsContract.getT0Date()!=null) {
							    					LocalDate sqldate = LocalDate.parse(carsContract.getT0Date()).plusMonths(Long.parseLong(milestones.get((milestones.size()-1)).getMonths()));
							    				%>
							    					<%=fc.SqlToRegularDate(sqldate.toString()) %> 
							    				<%} %>	
							    			</td>
							    			<td style="text-align : right;vertical-align: top;">
							    				<%if(milestones.get(milestones.size()-1).getActualAmount()!=null) {%>
							    					<%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(milestones.get(milestones.size()-1).getActualAmount())) %>
							    				<%} else{%>
							    					-
							    				<%} %>
							    				&nbsp;&nbsp;
							    			</td>
							    			<td style="text-align: center;">
							    				<form action="#" method="POST" name="myfrm"  style="display: inline">
													<div class="d-flex justify-content-center">		
														<button  class="editable-click" name="Action" value="Actions" formaction="CARSMilestonesMonitorDetails.htm">
															<div class="cc-rockmenu">
														 		<div class="rolling">	
									                        		<figure class="rolling_icon"><img src="view/images/preview3.png" ></figure>
									                        		<span>Actions</span>
									                      		</div>
									                     	</div>
												        </button>   
													
														<button  class="editable-click" name="Action" value="MilestoneProgress" formaction="CARSMilestonesProgressDetails.htm" style="width: 50%;">
													        <%
													        progressData = milestoneProgressList!=null && milestoneProgressList.size()>0?milestoneProgressList.stream().filter(e -> e[5].toString().equalsIgnoreCase(milestones.get(milestones.size()-1).getMilestoneNo())).findFirst().orElse(null): null;
													        %>
													        <%if(progressData!=null) {%>
																<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
																	<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=progressData[2] %>%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
																		<%=progressData[2] %>
																	</div> 
																</div>	
															<%}else{ %>
																<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
																	<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
																		0
																	</div>
																</div>
															<%} %>
														</button>     
											        </div>		
													<input type="hidden" name="carsSoCMilestoneId" value="<%=milestones.get(milestones.size()-1).getCARSSoCMilestoneId()%>"/>
													<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId%>"/>
													<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
														
												</form>
							    			</td>
							    		</tr>
							    		<%} %>
			    					<%} %>
					            </tbody>
					        </table>
						</div>
					</div>
				</div>  
				<div class="row" style="margin-left: 5rem;">
					<div class="col-md-11" align="left" style="margin-left: 20px;">
						<label style="font-size: 17px;">*EDP</label> - <span>Expected Date of Payment</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>	
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
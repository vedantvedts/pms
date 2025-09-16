<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.cars.model.CARSOtherDocDetails"%>
<%@page import="com.vts.pfms.cars.model.CARSContract"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.vts.pfms.IndianRupeeFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.cars.model.CARSSoCMilestones"%>
<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.model.LabMaster"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>CARS Presentation</title>
<jsp:include page="../static/dependancy.jsp"></jsp:include>
<spring:url value="/resources/css/slides-style.css" var="SlidesStyleCSS" />
<link href="${SlidesStyleCSS}" rel="stylesheet" />
<spring:url value="/resources/css/cars/CARSReportPresentation.css" var="carsReportPresentation" />
<link href="${carsReportPresentation}" rel="stylesheet" />
<spring:url value="/resources/css/cars/carscommon.css" var="carscommon11" />
<link href="${carscommon11}" rel="stylesheet" />

<style type="text/css">
</style>
</head>
<body class="slides-container body-bg" id="slides-container">
	<%
		LabMaster labInfo=(LabMaster)request.getAttribute("labInfo");
		String lablogo = (String)request.getAttribute("lablogo");
		List<Object[]> initiationList = (List<Object[]>)request.getAttribute("initiationList");
		List<CARSContract> allCARSContractList = (List<CARSContract>)request.getAttribute("allCARSContractList");
		List<CARSSoCMilestones> allCARSSoCMilestonesList = (List<CARSSoCMilestones>)request.getAttribute("allCARSSoCMilestonesList");
		List<Object[]> allMilestoneProgressList = (List<Object[]>)request.getAttribute("allMilestoneProgressList");
		List<CARSOtherDocDetails> allCARSOtherDocDetailsList = (List<CARSOtherDocDetails>)request.getAttribute("allCARSOtherDocDetailsList");
		FormatConverter fc = new FormatConverter();
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
	
	<div id="presentation-slides" class="carousel slide " data-ride="carousel">
		<div class="carousel-inner" align="center">
			<!-- ---------------------------------------- P-0  Div ----------------------------------------------------- -->
			<div class="carousel-item active">
					
				<div class="content div-hei" align="center">
						
					<div class="firstpage"  > 
		
						<div class="mt-2" align="center"><h2 class="pres-title">Presentation</h2></div>
						<div align="center" ><h2 class="pres-title">of</h2></div>
								
						<div align="center" >
							<h2 class="pres-title" >CARS Projects</h2>
				   		</div>
						
						<div align="center" ><h2 class="pres-title"></h2></div>
						
						<table class="executive home-table tab-1"   >
							<tr>			
								<th colspan="8" class="text-center fw-700" >
									<img class="logo l-wh120"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Logo"<%}else{ %> alt="File Not Found" <%} %> > 
									<br>
								</th>
							</tr>
						</table>	
						<br><br><br><br>

						<br><br><br><br><br>
						<table class="executive home-table tab-2"  >
							<% if(labInfo!=null){ %>
								<tr>
									<th colspan="8" class="pres-title tab-2-th-1"> <h2 class="h2-col"> <%if(labInfo.getLabName()!=null){ %><%=StringEscapeUtils.escapeHtml4(labInfo.getLabName())  %><%}else{ %>LAB NAME<%} %> ( <%if(labInfo!=null && labInfo.getLabCode() !=null){ %><%=StringEscapeUtils.escapeHtml4(labInfo.getLabCode())%><%} %> ) </h2> </th>
								</tr>
							<%}%>
							<tr>
								<th colspan="8" class="tab-2-th" >Government of India, Ministry of Defence</th>
							</tr>
							<tr>
								<th colspan="8" class="tab-2-th" >Defence Research & Development Organization</th>
							</tr>
							<tr>
								<th colspan="8" class="tab-2-th" ><%if(labInfo.getLabAddress() !=null){ %><%=StringEscapeUtils.escapeHtml4(labInfo.getLabAddress())  %> , <%=labInfo.getLabCity()!=null?StringEscapeUtils.escapeHtml4(labInfo.getLabCity()): "" %><%}else{ %>LAB ADDRESS<%} %> </th>
							</tr>
						</table>
					</div>
						
				</div>
					
			</div>
			
			<!-- ----------------------------------------  P-0  Div End----------------------------------------------------- -->
			
			<!-- ----------------------------------------  P-1  Div ----------------------------------------------------- -->
			<div class="carousel-item">

				<div class="content-header row ">
					
					<div class="col-md-1" >
						
					</div>
					<div class="col-md-2 dis-in" align="left"  >
						<b class="refNoHeading"></b>
					</div>
					<div class="col-md-7">
						<h3 class="slideNames">CARS List</h3>
					</div>
					<div class="col-md-1 pt-19" align="right" >
						<b class="mr-minus-35"><%="" %></b>
					</div>
					<div class="col-md-1">
					</div>
					
				</div>
				
				<div class="content" >
					<div class="container-fluid mt-3">
						<table class="table table-bordered table-hover table-condensed data-table">
			     	    	<thead class="thead-bg">
			            		<tr>
			                    	<th class="width-5">SN</th>
			                       	<th class="width-20">CARS No</th> 
			                       	<th class="width-40">Title</th>
			                       	<th class="width-10">Funds From</th>
			                       	<th class="width-15">Duration (Months)</th>
			                       	<th class="width-10">Cost (Lakhs)</th>
			                    </tr>
			              	</thead> 
				            <tbody>
				            	<%if(initiationList!=null && initiationList.size()>0) {
				            		int slno = 1;
				            		for(Object[] obj : initiationList) {
				            			String amount = String.format("%.2f", Double.parseDouble(obj[20]!=null?obj[20].toString():obj[13].toString())/100000);
				            	%>
				            		<tr class="clickable cursor" data-target="#presentation-slides" data-slide-to="<%=(slno+1)%>" data-toggle="tooltip" data-placement="top" title="" >
				            			<td class="center"><%=slno %></td>
	                                    <td class="center"><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()):"-" %></td>
	                                    <td class="left"><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()):"-" %></td>
	                                    <td class="left"><%=obj[18]!=null?StringEscapeUtils.escapeHtml4(obj[18].toString()):"-" %></td>
	                                    <td class="center"><%=obj[33]!=null?StringEscapeUtils.escapeHtml4(obj[33].toString()):(obj[8]!=null?StringEscapeUtils.escapeHtml4(obj[8].toString()):"-") %></td>
	                                    <td class="right"><%=amount!=null?StringEscapeUtils.escapeHtml4(amount): " - " %></td>
				            		</tr>
				            	<%++slno;} }%>
				            </tbody>
				    	</table>
				    </div>	 
				</div>
			</div>
			
			<!-- ----------------------------------------  P-1  Div End----------------------------------------------------- -->
			
			<!-- ----------------------------------------  Presentation of CARS Projects Div ----------------------------------------------------- -->
			<%if(initiationList!=null && initiationList.size()>0) {
				int slno = 0;
				for(Object[] obj : initiationList) {
					String carsInitiationId = obj[0].toString();
					String amount = String.format("%.2f", Double.parseDouble(obj[20]!=null?obj[20].toString():obj[13].toString())/100000);
					String duration = obj[33]!=null?obj[33].toString():(obj[8]!=null?obj[8].toString():"0");
					
					// Contract Data
					CARSContract carsContract = allCARSContractList!=null && allCARSContractList.size()>0?allCARSContractList.stream().filter(e -> e.getCARSInitiationId()==Long.parseLong(carsInitiationId)).findFirst().orElse(null):null;
					// Milestones Data
					List<CARSSoCMilestones> milestones = allCARSSoCMilestonesList!=null && allCARSSoCMilestonesList.size()>0? allCARSSoCMilestonesList.stream().filter(e -> e.getCARSInitiationId()==Long.parseLong(carsInitiationId)).collect(Collectors.toList()) : new ArrayList<CARSSoCMilestones>(); 
					// Milestones Progress Data
					List<Object[]> milestoneProgressList = allMilestoneProgressList!=null && allMilestoneProgressList.size()>0? allMilestoneProgressList.stream()
							.filter(e -> Long.parseLong(e[6].toString())==Long.parseLong(carsInitiationId)).collect(Collectors.toList()) : new ArrayList<Object[]>();
					
					// Other Doc Details Data
					List<CARSOtherDocDetails> otherDocDetails = allCARSOtherDocDetailsList!=null && allCARSOtherDocDetailsList.size()>0? allCARSOtherDocDetailsList.stream()
							.filter(e -> e.getCARSInitiationId()==Long.parseLong(carsInitiationId)).collect(Collectors.toList()) : new ArrayList<CARSOtherDocDetails>();
					
					List<CARSOtherDocDetails> ptcdetailslist = null;
					CARSOtherDocDetails ptcdetails = null;		
			%>
				<div class="carousel-item">
	
					<div class="content-header row ">
						
						<div class="col-md-1" >
							
						</div>
						<div class="col-md-2 dis-in" align="left"   >
							<b class="refNoHeading"></b>
						</div>
						<div class="col-md-7">
							<h3 class="slideNames"><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %></h3>
						</div>
						<div class="col-md-1 pt-19" align="right"   >
							<b class="mr-minus-35" ><%="" %></b>
						</div>
						<div class="col-md-1">
						</div>
						
					</div>
					
					<div class="content" >
						<div class="container-fluid mt-3">
						
							<div class="card-container">
    							<!-- Project Information Card -->
							    <div class="card card-project-info">
							        <h1 class="card-title">CARS Information</h1>
							        <div class="card-section">
							            <span class="label">Title:</span> 
							            <span class="value"><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()):"-" %></span>
							        </div>
							        <div class="card-section">
							            <span class="label">Current Status:</span> 
							            <span class="value"><%=obj[34]!=null?StringEscapeUtils.escapeHtml4(obj[34].toString()):"-" %></span>
							        </div>
							    </div>
    
    							<!-- Duration and Dates Card -->
							    <div class="card card-duration">
							        <h2 class="card-title">Cost & Duration</h2>
							        <div class="card-section">
							            <span class="label">Funds from:</span> 
							            <span class="value"><%=obj[18]!=null?StringEscapeUtils.escapeHtml4(obj[8].toString()):"-" %></span>
							        </div>
							        <div class="card-section">
							            <span class="label">Cost:</span> 
							            <span class="value"><%=amount %> Lakhs</span>
							        </div>
							        <div class="card-section">
							            <span class="label">Start Date:</span>
							            <span class="value">
							                <% if (carsContract != null && carsContract.getContractDate() != null) { %>
							                    <%= fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(carsContract.getContractDate())) %>
							                <% } else { %> - <% } %>
							            </span>
							        </div>
							        <div class="card-section">
							            <span class="label">PDC:</span>
							            <span class="value">
							                <% if (carsContract != null && carsContract.getT0Date() != null) { 
							                    LocalDate sqldate = LocalDate.parse(carsContract.getT0Date())
							                                    .plusMonths(Long.parseLong(milestones.get(milestones.size() - 1).getMonths())); %>
							                    <%= fc.SqlToRegularDate(sqldate.toString()) %>
							                <% } else { %> - <% } %>
							            </span>
							        </div>
							        <div class="card-section">
							            <span class="label">Duration:</span> 
							            <span class="value"><%=duration!=null?StringEscapeUtils.escapeHtml4(duration): " - " %> <%if(Integer.parseInt(duration)>1) {%>Months<%} else{%>Month<%} %> </span>
							        </div>
							    </div>

							    <!-- RSP Information Card -->
							    <div class="card card-rsp-info">
							        <h2 class="card-title">Research Service Provider (RSP)</h2>
							        <div class="card-section">
							            <span class="label">Name:</span>
							            <span class="value"><%= obj[26]!=null?StringEscapeUtils.escapeHtml4(obj[26].toString()): " - " %> . <%=obj[27]!=null?StringEscapeUtils.escapeHtml4(obj[27].toString()): " - " %>, <%= obj[28]!=null?StringEscapeUtils.escapeHtml4(obj[28].toString()): " - " %></span>
							        </div>
							        <div class="card-section">
							            <span class="label">Address:</span>
							            <span class="value">
							                <%= obj[21]!=null?StringEscapeUtils.escapeHtml4(obj[21].toString()): " - " %>, <%= obj[22]!=null?StringEscapeUtils.escapeHtml4(obj[22].toString()): " - " %>, <%= obj[23]!=null?StringEscapeUtils.escapeHtml4(obj[23].toString()): " - " %>, <%= obj[24]!=null?StringEscapeUtils.escapeHtml4(obj[24].toString()): " - " %> - <%= obj[25]!=null?StringEscapeUtils.escapeHtml4(obj[25].toString()): " - " %> <br>
							                Phone: <%= obj[30]!=null?StringEscapeUtils.escapeHtml4(obj[30].toString()): " - " %><br>
							                Email: <%= obj[31]!=null?StringEscapeUtils.escapeHtml4(obj[31].toString()): " - " %><br>
							                Fax: <%= obj[32]!=null?StringEscapeUtils.escapeHtml4(obj[32].toString()): " - " %>
							            </span>
							        </div>
							    </div>
							</div>
	
							<!-- --------------------------------------- Milestone Data ---------------------------------------------------- -->
		                	<table class="data-table mt-4" >
								<thead>
						        	<tr>
						            	<th class="width-20 col-55">Description</th>
						            	<th class="width-10 col-55">Months</th>
						            	<th class="width-10 col-55">EDP</th>
						            	<th class="width-10 col-55">Amount (&#8377;)</th>
						            	<th class="width-10 col-55">Status</th>
						            	<th class="width-20 col-55">Action</th>
						            </tr>
					            </thead>
					            <tbody>
					            	
					               	<%if(milestones!=null && milestones.size()>0) { char a='a'; Object[] progressData = null;%>
							    		<tr>
							    			<td class="v-top-3">&nbsp;(a) Initial Advance &nbsp;&nbsp;(<%=StringEscapeUtils.escapeHtml4(milestones.get(0).getPaymentPercentage()) %>%) </td>
							    			<td class="v-top">T0*</td>
							    			<td class="v-top">
							    				<%if(carsContract!=null && carsContract.getT0Date()!=null) {%><%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(carsContract.getT0Date())) %><%} %> 
							    			</td>
							    			<td class="v-top-2">
							    				<%if(milestones.get(0).getActualAmount()!=null) {%>
							    					<%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(StringEscapeUtils.escapeHtml4(milestones.get(0).getActualAmount()))) %>
							    				<%} else{%>
							    					-
							    				<%} %>
							    				&nbsp;&nbsp;
							    			</td>
							    			<td class="text-center">
							    				<%
												  	ptcdetailslist = otherDocDetails.stream().filter(e-> "P".equalsIgnoreCase(e.getOtherDocType()) && milestones.get(0).getMilestoneNo().equalsIgnoreCase(e.getMilestoneNo())).collect(Collectors.toList());
													ptcdetails = ptcdetailslist!=null && ptcdetailslist.size()>0 ? ptcdetailslist.get(0): null;
												    	
												%>
												<%if(ptcdetails!=null) {%>
													<button type="button" class="btn btn-sm w-50 btn-status btn-success text-center fw-bold" >Paid</button>
												<%} else{%>
													<button type="button" class="btn btn-sm w-50 btn-status btn-danger text-center fw-bold" >Pending</button>
												<%} %>
							    			</td>
							    			<td class="center">
							    				<form action="#" method="POST" name="myfrm" >
							    					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
							    					<input type="hidden" name="carsSoCMilestoneId" value="<%=milestones.get(0).getCARSSoCMilestoneId()%>"/>
													<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId%>"/>
							    					<input type="hidden" name="presFlag" value="A">
							    					
							    					<div class="d-flex justify-content-center">
							    						<button  class="editable-click" name="Action" value="Actions" formaction="CARSMilestonesMonitorDetails.htm">
															<div class="cc-rockmenu">
														 		<div class="rolling">	
									                        		<figure class="rolling_icon"><img src="view/images/preview3.png" ></figure>
									                        		<span>Actions</span>
									                      		</div>
									                     	</div>
											        	</button> 
											        	<button  class="editable-click w-50" name="Action" value="MilestoneProgress" formaction="CARSMilestonesProgressDetails.htm" >
													        <%
													        progressData = milestoneProgressList!=null && milestoneProgressList.size()>0?milestoneProgressList.stream().filter(e -> e[5].toString().equalsIgnoreCase(milestones.get(0).getMilestoneNo())).findFirst().orElse(null): null;
													        %>
													        <%if(progressData[2]!=null) {%>
																<div class="progress pro-bg" >
																	<div class="progress-bar progress-bar-striped width-<%=progressData[2].toString().trim() %>" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
																		<%=StringEscapeUtils.escapeHtml4(progressData[2].toString()) %>
																	</div> 
																</div>	
															<%}else{ %>
																<div class="progress pro-bg" >
																	<div class="progress-bar prog-bar-bg" role="progressbar"  >
																		0
																	</div>
																</div>
															<%} %>
														</button>
							    					</div>
												</form>
							    			</td>
							    		</tr>
							    		<% for(int i=1;i<milestones.size()-1;i++) { 
							    			String milestoneNo = milestones.get(i).getMilestoneNo();
							    		%>
							    		<tr>
							    			<td class="v-top-4">&nbsp;(<%=++a %>) Performance Milestone-<%=(i) %> of RSQR &nbsp;&nbsp;(<%=milestones.get(i).getPaymentPercentage()!=null?StringEscapeUtils.escapeHtml4(milestones.get(i).getPaymentPercentage()): " - " %>%) </td>
							    			<td class="v-top">T0+<%=milestones.get((i)).getMonths()!=null?StringEscapeUtils.escapeHtml4(milestones.get(i).getMonths()): " - "%> </td>
							    			<td class="v-top">
							    				<%if(carsContract!=null && carsContract.getT0Date()!=null) {
							    					LocalDate sqldate = LocalDate.parse(carsContract.getT0Date()).plusMonths(Long.parseLong(milestones.get((i)).getMonths()));
							    				%>
							    					<%=fc.SqlToRegularDate(sqldate.toString()) %> 
							    				<%} %>	
							    			</td>
							    			<td class="v-top-2">
							    				<%if(milestones.get(i).getActualAmount()!=null) {%>
							    					<%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(StringEscapeUtils.escapeHtml4(milestones.get(i).getActualAmount()))) %>
							    				<%} else{%>
							    					-
							    				<%} %>
							    				&nbsp;&nbsp;
							    			</td>
							    			<td class="text-center">
							    				<%
							    					ptcdetailslist = otherDocDetails.stream().filter(e-> "P".equalsIgnoreCase(e.getOtherDocType()) && milestoneNo.equalsIgnoreCase(e.getMilestoneNo())).collect(Collectors.toList());
										    		ptcdetails = ptcdetailslist!=null && ptcdetailslist.size()>0 ? ptcdetailslist.get(0): null;
							    				%>
							    				<%if(ptcdetails!=null) {%>
													<button type="button" class="btn btn-sm w-50 btn-status btn-success text-center fw-bold">Paid</button>
												<%} else{%>
													<button type="button" class="btn btn-sm w-50 btn-status btn-danger text-center fw-bold" >Pending</button>
												<%} %>
							    			</td>
							    			<td class="center">
							    				<form action="#" method="POST" name="myfrm" class="d-inline">
							    					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
							    					<input type="hidden" name="carsSoCMilestoneId" value="<%=milestones.get(i).getCARSSoCMilestoneId()%>"/>
													<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId%>"/>
							    					<input type="hidden" name="presFlag" value="A">
													
													<div class="d-flex justify-content-center">	
														<button  class="editable-click" name="Action" value="Actions" formaction="CARSMilestonesMonitorDetails.htm">
															<div class="cc-rockmenu">
														 		<div class="rolling">	
									                        		<figure class="rolling_icon"><img src="view/images/preview3.png" ></figure>
									                        		<span>Actions</span>
									                      		</div>
									                     	</div>
												        </button>   
													
														<button  class="editable-click w-50" name="Action" value="MilestoneProgress" formaction="CARSMilestonesProgressDetails.htm">
													        <%
													        progressData = milestoneProgressList!=null && milestoneProgressList.size()>0?milestoneProgressList.stream().filter(e -> e[5].toString().equalsIgnoreCase(milestoneNo)).findFirst().orElse(null): null;
													        %>
													        <%if(progressData[2]!=null) {%>
																<div class="progress pro-bg" >
																	<div class="progress-bar progress-bar-striped width-<%=progressData[2].toString().trim() %>" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
																		<%=StringEscapeUtils.escapeHtml4(progressData[2].toString()) %>
																	</div> 
																</div>	
															<%}else{ %>
																<div class="progress pro-bg" >
																	<div class="progress-bar prog-bar-bg" role="progressbar"   >
																		0
																	</div>
																</div>
															<%} %>
														</button>   
											        </div>		
														
												</form>
							    			</td>
							    		</tr>
							    		<%}%>
							    		<%if(milestones.size()>1) {%>
							    		<tr>
							    			<td class="v-top-3">&nbsp;(<%=++a %>) on submission of final report &nbsp;&nbsp;(<%=milestones.get(milestones.size()-1).getPaymentPercentage()!=null?StringEscapeUtils.escapeHtml4(milestones.get(milestones.size()-1).getPaymentPercentage()): " - " %>%) </td>
							    			<td class="v-top">T0+<%=milestones.get(milestones.size()-1).getMonths()!=null?StringEscapeUtils.escapeHtml4(milestones.get(milestones.size()-1).getMonths()): " - " %> </td>
							    			<td class="v-top">
							    				<%if(carsContract!=null && carsContract.getT0Date()!=null) {
							    					LocalDate sqldate = LocalDate.parse(carsContract.getT0Date()).plusMonths(Long.parseLong(milestones.get((milestones.size()-1)).getMonths()));
							    				%>
							    					<%=fc.SqlToRegularDate(sqldate.toString()) %> 
							    				<%} %>	
							    			</td>
							    			<td class="v-top-2">
							    				<%if(milestones.get(milestones.size()-1).getActualAmount()!=null) {%>
							    					<%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(StringEscapeUtils.escapeHtml4(milestones.get(milestones.size()-1).getActualAmount()))) %>
							    				<%} else{%>
							    					-
							    				<%} %>
							    				&nbsp;&nbsp;
							    			</td>
							    			<td class="text-center">
							    				<%
							    				ptcdetailslist = otherDocDetails.stream().filter(e-> "P".equalsIgnoreCase(e.getOtherDocType()) && milestones.get(milestones.size()-1).getMilestoneNo().equalsIgnoreCase(e.getMilestoneNo())).collect(Collectors.toList());
										    	ptcdetails = ptcdetailslist!=null && ptcdetailslist.size()>0 ? ptcdetailslist.get(0): null;
							    				%>
							    				<%if(ptcdetails!=null) {%>
													<button type="button" class="btn btn-sm w-50 btn-status btn-success text-center fw-bold" >Paid</button>
												<%} else{%>
													<button type="button" class="btn btn-sm w-50 btn-status btn-danger text-center fw-bold" >Pending</button>
												<%} %>
							    			</td>
							    			<td  class="center">
							    				<form action="#" method="POST" name="myfrm"  class="d-inline">
							    					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
							    					<input type="hidden" name="carsSoCMilestoneId" value="<%=milestones.get(milestones.size()-1).getCARSSoCMilestoneId()%>"/>
													<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId%>"/>
							    					<input type="hidden" name="presFlag" value="A">
													<div class="d-flex justify-content-center">		
														<button  class="editable-click" name="Action" value="Actions" formaction="CARSMilestonesMonitorDetails.htm">
															<div class="cc-rockmenu">
														 		<div class="rolling">	
									                        		<figure class="rolling_icon"><img src="view/images/preview3.png" ></figure>
									                        		<span>Actions</span>
									                      		</div>
									                     	</div>
												        </button>   
													
														<button  class="editable-click w-50" name="Action" value="MilestoneProgress" formaction="CARSMilestonesProgressDetails.htm" >
													        <%
													        progressData = milestoneProgressList!=null && milestoneProgressList.size()>0?milestoneProgressList.stream().filter(e -> e[5].toString().equalsIgnoreCase(milestones.get(milestones.size()-1).getMilestoneNo())).findFirst().orElse(null): null;
													        %>
													        <%if(progressData[2]!=null) {%>
																<div class="progress pro-bg" >
																	<div class="progress-bar progress-bar-striped width-<%=progressData[2].toString().trim() %>" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
																		<%=StringEscapeUtils.escapeHtml4(progressData[2].toString()) %>
																	</div> 
																</div>	
															<%}else{ %>
																<div class="progress pro-bg" >
																	<div class="progress-bar prog-bar-bg" role="progressbar"  >
																		0
																	</div>
																</div>
															<%} %>
														</button>     
											        </div>		
													 
														
												</form>
							    			</td>
							    		</tr>
							    		<%} %>
			    					<%} else{%>
			    						<tr>
			    							<td colspan="6" class="center">No Data Available</td>
			    						</tr>
			    					<%} %>
					            </tbody>
					        </table>
						</div>	
					</div>
				</div>
			<%} }%>	
			
			<!-- ----------------------------------------  Presentation of CARS Projects Div End----------------------------------------------------- -->
					
		</div>
		
		<a class="carousel-control-prev w-0 pl-20" href="#presentation-slides" role="button" data-slide="prev" > <span aria-hidden="true">
			<i class="fa fa-chevron-left fa-2x col-00" aria-hidden="true"></i></span> <span class="sr-only">Previous</span>
		</a> <a class="carousel-control-next w-0 pr-20" href="#presentation-slides" role="button" data-slide="next"> <span aria-hidden="true">
			<i class="fa fa-chevron-right fa-2x col-00" aria-hidden="true"></i></span> <span class="sr-only">Next</span>
		</a>

		<ol class="carousel-indicators">
			<li data-target="#presentation-slides" data-slide-to="0" class="carousel-indicator active" data-toggle="tooltip" data-placement="top" title="Start"><b><i class="fa fa-home" aria-hidden="true"></i></b></li>
			<li data-target="#presentation-slides" data-slide-to="1" class="carousel-indicator" data-toggle="tooltip" data-placement="top" title="CARS List"><b><i class="fa fa-list" aria-hidden="true"></i></b></li>
			<%if(initiationList!=null && initiationList.size()>0) {
				int slno = 1;
				for(Object[] obj : initiationList) {
			%>
				<li data-target="#presentation-slides" data-slide-to="<%=slno+1 %>" class="carousel-indicator" data-toggle="tooltip" data-placement="top" title="<%=obj[2] %>"><b><%=slno++ %></b></li>
			<%}} %>
			<!-- <li data-target="#presentation-slides" data-slide-to="2" class="carousel-indicator" data-toggle="tooltip" data-placement="top" title="End"><b>End</b></li> -->
			<li data-slide-to="1" class="carousel-indicator content_full_screen li-sty" data-toggle="tooltip" data-placement="top" title="Full Screen Mode"><b><i class="fa fa-expand fa-lg" aria-hidden="true"></i></b></li>
			<li data-slide-to="1" class="carousel-indicator li-sty content_reg_screen" data-toggle="tooltip" data-placement="top" title="Exit Full Screen Mode"><b><i class="fa fa-compress fa-lg" aria-hidden="true"></i></b></li>
			<li class="li-sty-2">
				<a target="_blank" href="CARSPresentationDownload.htm" data-toggle="tooltip" title="Download CARS Presentation" >
					<i class="fa fa-download icon-sty" aria-hidden="true"></i>
				</a>	
			</li>
		</ol>
		
	</div>		

	
<script type="text/javascript">

window.setTimeout(function() {
    $(".alert").fadeTo(500, 0).slideUp(500, function(){
        $(this).remove(); 
    });
}, 4000);

$('.carousel').carousel({
	  interval: false,
	  keyboard: true,
	})

$(function () {
	$('[data-toggle="tooltip"]').tooltip()
})

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

</script>	
</body>
</html>
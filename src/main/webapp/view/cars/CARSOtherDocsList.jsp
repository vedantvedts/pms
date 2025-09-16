<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.time.LocalDate"%>
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
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/cars/CARSOtherDocsList.css" var="carsOtherDocsList" />
<link href="${carsOtherDocsList}" rel="stylesheet" />
<spring:url value="/resources/css/cars/carscommon.css" var="carscommon3" />
<link href="${carscommon3}" rel="stylesheet" />
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

<br>
<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			<div class="card shadow-nohover">
				<div class="row card-header bg-none" >
			   		<div class="col-md-6">
						<h4>Other Doc Details
							<button type="button" id="carsInfo" value="1" class="btn btn-info btn-sm h4-odd"><i class="fa fa-info-circle" aria-hidden="true"></i></button>
						</h4>
						
					</div>
				
					<div class="col-md-6 justify-content-end f-right mt-minus-25">
						<div class="form-inline jc-end" >
							<a class="btn btn-info btn-sm  shadow-nohover back f-right" href="CARSRSQRApprovedList.htm?AllListTabId=3" >Back</a>  
						</div>
					</div>
				</div>
				<br>
				<div class="row ml-5rem" id="carsInfoHeading">
					<div class="col-md-11">
						<div class="card shadow-nohover header-margin" >
							<div class="card-header header-bg" >
								<b class="text-white" >CARS Details: </b>
							</div> 
						</div>
					</div>
				</div>
				<div class="row ml-5rem" id="carsInfoContent">
					<div class="col-md-11 ml-20" align="left" >
					    <div class="panel panel-info">
					      	<div class="panel-heading">
					        	<h4 class="panel-title">
					          		<div>
					              		<div class="row">
					                		<div class="col-md-12">
					                			<span class="cssideheading">Title:</span>
					                			&emsp;<span class="cssideheadingdata"><%if(carsIni!=null && carsIni.getInitiationTitle()!=null) {%><%=StringEscapeUtils.escapeHtml4(carsIni.getInitiationTitle()) %> <%} else{%>-<%} %></span>
					                		</div>
					                	</div>
					                	<br>
					                	<div class="row">
					                		<div class="col-md-4">
					                			<span class="cssideheading">CARS. No:</span>
					                			&emsp;<span class="cssideheadingdata"><%if(carsIni!=null && carsIni.getCARSNo()!=null) {%><%=StringEscapeUtils.escapeHtml4(carsIni.getCARSNo()) %> <%} else{%>-<%} %></span>
					                		</div>
					                		<div class="col-md-4">
					                			<span class="cssideheading">Funds from:</span>
					                			&emsp;<span class="cssideheadingdata">
					                			<%if(carsIni!=null && carsIni.getFundsFrom()!=null && carsIni.getFundsFrom().equalsIgnoreCase("0")) {%>
					                				Buildup
					                			 <%} else{%>
					                			 	 <%if(PDs!=null && PDs[4]!=null) {%><%=StringEscapeUtils.escapeHtml4(PDs[4].toString()) %><%} %>
					                			 <%} %></span>
					                		</div>
					                		<div class="col-md-4">
					                			<span class="cssideheading">Amount:</span>
					                			&emsp;<span class="cssideheadingdata">
					                				<%if(carsSoC!=null && carsSoC.getSoCAmount()!=null) {%>
					                					<%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(StringEscapeUtils.escapeHtml4(carsSoC.getSoCAmount()))) %>
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
					<div class="row ml-5rem" >
						<div class="col-md-11">
							<div class="card shadow-nohover header-margin" >
								<div class="card-header header-bg-1" >
								    <b class="text-white" >Contract Signature Details: </b> 
							    </div> 
							</div>
						</div>
					</div>
					<div class="row ml-5rem" >
						<div class="col-md-11 ml-20" align="left">
					    	<div class="panel panel-info">
					      		<div class="panel-heading">
					        		<h4 class="panel-title">
					          			<div>
					              			<div class="row">
					                			<div class="col-md-2">
					                				<span class="cssideheading">Date:</span>
					                				&emsp;<span class="cssideheadingdata"><%if(csdetails!=null && csdetails.getOtherDocDate()!=null) {%><%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(csdetails.getOtherDocDate())) %> <%} else{%>-<%} %></span>
					                			</div>
					                			<div class="col-md-3">
					                				<span class="cssideheading">File No:</span>
					                				&emsp;<span class="cssideheadingdata"><%if(carsContract!=null && carsContract.getContractNo()!=null) {%><%=StringEscapeUtils.escapeHtml4(carsContract.getContractNo()) %> <%} else{%>-<%} %></span>
					                			</div>
					                			<div class="col-md-4">
					                				<form action="#" method="post" id="transform">
					                					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					                				</form>
					                				<span class="cssideheading">Status:</span>
					                				&emsp;<span>
					                					
					                					<button type="submit" form="transform" class="btn btn-sm btn-link-1 w-50 btn-status fw-600 color-<%=statusdetails[3].toString().replace("#", "").trim() %>" formaction="CARSTransStatus.htm" formnovalidate="formnovalidate" value="<%=carsInitiationId %>" name="carsInitiationId"  data-toggle="tooltip" data-placement="top" title="Transaction History"  formtarget="_blank">
													    	<%if(statusdetails!=null && statusdetails[2]!=null ) {%><%=StringEscapeUtils.escapeHtml4(statusdetails[2].toString()) %><%} else{%>--<%} %> <i class="fa fa-telegram f-right mt-1" aria-hidden="true" ></i>
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
																		<img src="view/images/clipboard.png" class="w-18-px">
																	</figure>
																	<span>CS Details</span>
																</div>
															</div>
														</button>
														<button type="button" class="btn btn-sm" data-toggle="modal" onclick="openCalendar2('<%=carsInitiationId%>')" >
											  	 			<div class="cc-rockmenu2">
																<div class="rolling2">
																	<figure class="rolling_icon2">
																		<img src="view/images/calendar.png" class="w-18-px">
																	</figure>
																	<span>Date</span>
																</div>
															</div>
														</button>
					                					<button type="submit" form="transform" class="btn btn-sm" name="carsInitiationId" value="<%=carsInitiationId %>" formaction="CARSFinalSoOLetter.htm" formtarget="_blank" formnovalidate="formnovalidate" formmethod="post" data-toggle="tooltip" data-placement="top" title="Contract Letter">
													  		<div class="cc-rockmenu2">
																<div class="rolling2" >
																	<figure class="rolling_icon2">
																		<img src="view/images/letter.png" class="w-18-px">
																	</figure>
																	<span>Letter</span>
																</div>
															</div>
														</button>
														<%if(statusdetails[1]!=null && statusdetails[1].toString().equalsIgnoreCase("CFW") ) {%>
						                                	<button type="submit" form="transform" class="btn btn-sm" name="carsInitiationId" value="<%=carsInitiationId %>" formaction="CARSCSDocRevoke.htm" formnovalidate="formnovalidate" formmethod="post" onclick="return confirm('Are you sure to revoke?')">
																<div class="cc-rockmenu2">
																	<div class="rolling2">
																		<figure class="rolling_icon2">
																			<img src="view/images/userrevoke.png" class="w-20-xp">
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
				<div class="row ml-5rem" >
					<div class="col-md-11">
						<div class="card shadow-nohover header-margin">
							<div class="card-header header-bg-1" >
								<b class="text-white" >Payment Details: </b> 
							</div> 
						</div>
					</div>
				</div>
				<div class="row ml-5rem" >
					<div class="col-md-11 ml-20" align="left" >
						<div class="table-responsive">
							<table class="table table-bordered table-hover table-striped table-condensed"  id="">
								<thead>
						        	<tr>
						            	<th class="w-30 col-055" >Description</th>
						            	<th class="w-10 col-055" >Months</th>
						            	<th class="w-10 col-055" >EDP</th>
						            	<th class="w-10 col-055" >Amount (&#8377;)</th>
						            	<th class="col-055" >Status</th>
						            	<th class="w-20 col-055" >Action</th>
						            </tr>
					            </thead>
					            <tbody>
					               	<%if(milestones!=null && milestones.size()>0) { char a='a';%>
							    		<tr>
							    			<td class="text-left wv-top" >&nbsp;(a) Initial Advance &nbsp;&nbsp;(<%=milestones.get(0).getPaymentPercentage()!=null?StringEscapeUtils.escapeHtml4(milestones.get(0).getPaymentPercentage()): " - " %>%) </td>
							    			<td class="text-center v-top">T0*</td>
							    			<td class="text-center v-top">
							    				<%if(carsContract.getT0Date()!=null) {%><%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(carsContract.getT0Date())) %><%} %> 
							    			</td>
							    			<td class="text-right v-top" >
							    				<%if(milestones.get(0).getActualAmount()!=null) {%>
							    					<%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(StringEscapeUtils.escapeHtml4(milestones.get(0).getActualAmount()))) %>
							    				<%} else{%>
							    					-
							    				<%} %>
							    				&nbsp;&nbsp;
							    			</td>
							    			<td class="d-flex justify-content-center align-items-center">
							    				<%
												  	ptcdetailslist = otherdocdetails.stream().filter(e-> "P".equalsIgnoreCase(e.getOtherDocType()) && milestones.get(0).getMilestoneNo().equalsIgnoreCase(e.getMilestoneNo())).collect(Collectors.toList());
													ptcdetails = ptcdetailslist!=null && ptcdetailslist.size()>0 ? ptcdetailslist.get(0): null;
												    	
												%>
												<%if(ptcdetails!=null) {%>
													<button type="button" class="btn btn-sm w-50 btn-status btn-success d-flex justify-content-center align-items-center fw-bold"  >Paid</button>
												<%} else{%>
													<button type="button" class="btn btn-sm w-50 btn-status btn-danger d-flex justify-content-center align-items-center fw-bold" >Pending</button>
												<%} %>
							    			</td>
							    			<td class="text-center">
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
																		<img src="view/images/userrevoke.png" class="w-22-px" >
																	</figure>
																	<span>Revoke</span>
																</div>
															</div>
														</button>
												    <%} %>
												    <%if(mpstatus!=null && mpstatus[1]!=null && mpstatus[1].toString().equalsIgnoreCase("MAD") ) {%>
												    	<%
												    		long otherdocdetailsid = ptcdetails!=null?ptcdetails.getOtherDocDetailsId():0;
												    		String otherdocdate = ptcdetails!=null?ptcdetails.getOtherDocDate():null;
												    		otherdocdate = otherdocdate!=null?fc.SqlToRegularDate(otherdocdate):rdf.format(new Date());
												    	%>
												    	<button type="button" class="btn btn-sm mt-minus-8" data-toggle="modal" onclick="openCalendar('<%=carsInitiationId%>','<%=otherdocdetailsid%>','<%=milestones.get(0).getMilestoneNo() %>','<%=otherdocdate %>')" >
													  		<div class="cc-rockmenu">
																<div class="rolling">
																	<figure class="rolling_icon">
																		<img src="view/images/calendar.png">
																	</figure>
																	<span>Date</span>
																</div>
															</div>
														</button>
												    	<button class="editable-clicko" name="carsInitiationId" value="<%=carsInitiationId %>" formaction="CARSMilestonePaymentLetterDownload.htm"  formtarget="blank" formmethod="post" formnovalidate="formnovalidate" data-toggle="tooltip" data-placement="top" title="Payment Letter Download"
												    	  <%if(ptcdetails==null) {%>type="button" onclick="return alert('Please fill date of payment')"<%} %>>
															<div class="cc-rockmenu">
																<div class="rolling">
																	<figure class="rolling_icon">
																		<img src="view/images/letter.png " class="w-22-px">
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
							    			<td class="text-left v-top " >&nbsp;(<%=++a %>) Performance Milestone-<%=(i) %> of RSQR &nbsp;&nbsp;(<%=milestones.get(i).getPaymentPercentage()!=null?StringEscapeUtils.escapeHtml4(milestones.get(i).getPaymentPercentage()): " - " %>%) </td>
							    			<td class="text-center v-top " >T0+<%=milestones.get((i)).getMonths()!=null?StringEscapeUtils.escapeHtml4(milestones.get((i)).getMonths()): " - " %> </td>
							    			<td class="text-center v-top " >
							    				<%if(carsContract.getT0Date()!=null) {
							    					LocalDate sqldate = LocalDate.parse(carsContract.getT0Date()).plusMonths(Long.parseLong(milestones.get((i)).getMonths()));
							    				%>
							    					<%=fc.SqlToRegularDate(sqldate.toString()) %> 
							    				<%} %>	
							    			</td>
							    			<td class="text-right v-top " >
							    				<%if(milestones.get(i).getActualAmount()!=null) {%>
							    					<%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(StringEscapeUtils.escapeHtml4(milestones.get(i).getActualAmount()))) %>
							    				<%} else{%>
							    					-
							    				<%} %>
							    				&nbsp;&nbsp;
							    			</td>
							    			<td class="d-flex justify-content-center align-items-center " >
							    				<%
							    					String mil = milestones.get(i).getMilestoneNo();
							    					ptcdetailslist = otherdocdetails.stream().filter(e-> "P".equalsIgnoreCase(e.getOtherDocType()) && mil.equalsIgnoreCase(e.getMilestoneNo())).collect(Collectors.toList());
										    		ptcdetails = ptcdetailslist!=null && ptcdetailslist.size()>0 ? ptcdetailslist.get(0): null;
							    				%>
							    				<%if(ptcdetails!=null) {%>
													<button type="button" class="btn btn-sm w-50 btn-status btn-success d-flex justify-content-center align-items-center fw-bold" >Paid</button>
												<%} else{%>
													<button type="button" class="btn btn-sm w-50 btn-status btn-danger d-flex justify-content-center align-items-center fw-bold" >Pending</button>
												<%} %>
							    			</td>
							    			<td class="text-center" >
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
												    
												    mpstatusdetails = mpstatusdetailslist.stream().filter(e-> e[4].toString().equalsIgnoreCase(mil)).collect(Collectors.toList());
												    mpstatus = mpstatusdetails!=null&& mpstatusdetails.size()>0?mpstatusdetails.get(0):null;
												    %>
												    <%if(mpstatus!=null && mpstatus[1]!=null && mpstatus[1].toString().equalsIgnoreCase("MFW") ) {%>
						                            	<button class="editable-clicko" name="carsInitiationId" value="<%=carsInitiationId %>" formaction="CARSMPDocRevoke.htm" formmethod="post" onclick="return confirm('Are you sure to revoke?')">
															<div class="cc-rockmenu">
																<div class="rolling">
																	<figure class="rolling_icon">
																		<img src="view/images/userrevoke.png" class="w-22-px">
																	</figure>
																	<span>Revoke</span>
																</div>
															</div>
														</button>
												    <%} %>
												    
												    <%if(mpstatus!=null && mpstatus[1]!=null && mpstatus[1].toString().equalsIgnoreCase("MAD") ) {%>
												    	<%
												    	
												    	long otherdocdetailsid = ptcdetails!=null?ptcdetails.getOtherDocDetailsId():0;
												    	String otherdocdate = ptcdetails!=null?ptcdetails.getOtherDocDate():null;
												    	otherdocdate = otherdocdate!=null?fc.SqlToRegularDate(otherdocdate):rdf.format(new Date());
												    	
												    	%>
												    	<button type="button" class="btn btn-sm mt-minus-8" data-toggle="modal" onclick="openCalendar('<%=carsInitiationId%>','<%=otherdocdetailsid%>','<%=mil %>','<%=otherdocdate %>')">
													  		<div class="cc-rockmenu">
																<div class="rolling">
																	<figure class="rolling_icon">
																		<img src="view/images/calendar.png">
																	</figure>
																	<span>Date</span>
																</div>
															</div>
														</button>
												    	<button class="editable-clicko" name="carsInitiationId" value="<%=carsInitiationId %>" formaction="CARSMilestonePaymentLetterDownload.htm"  formtarget="blank" formmethod="post" formnovalidate="formnovalidate" data-toggle="tooltip" data-placement="top" title="Payment Letter Download"
												    	  <%if(ptcdetails==null) {%>type="button" onclick="return alert('Please fill date of payment')"<%} %>>
															<div class="cc-rockmenu">
																<div class="rolling">
																	<figure class="rolling_icon">
																		<img src="view/images/letter.png" class="w-22-px" >
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
							    		<%if(milestones.size()>1) {%>
							    		<tr>
							    			<td class="text-left wv-top " >&nbsp;(<%=++a %>) on submission of final report &nbsp;&nbsp;(<%=milestones.get(milestones.size()-1).getPaymentPercentage()!=null?StringEscapeUtils.escapeHtml4(milestones.get(milestones.size()-1).getPaymentPercentage()): " - " %>%) </td>
							    			<td class="text-center v-top " >T0+<%=milestones.get(milestones.size()-1).getMonths()!=null?StringEscapeUtils.escapeHtml4(milestones.get(milestones.size()-1).getMonths()): " - " %> </td>
							    			<td class="text-center v-top " >
							    				<%if(carsContract.getT0Date()!=null) {
							    					LocalDate sqldate = LocalDate.parse(carsContract.getT0Date()).plusMonths(Long.parseLong(milestones.get((milestones.size()-1)).getMonths()));
							    				%>
							    					<%=fc.SqlToRegularDate(sqldate.toString()) %> 
							    				<%} %>	
							    			</td>
							    			<td class="text-right v-top ">
							    				<%if(milestones.get(milestones.size()-1).getActualAmount()!=null) {%>
							    					<%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(StringEscapeUtils.escapeHtml4(milestones.get(milestones.size()-1).getActualAmount()))) %>
							    				<%} else{%>
							    					-
							    				<%} %>
							    				&nbsp;&nbsp;
							    			</td>
							    			<td class="d-flex justify-content-center align-items-center">
							    				<%
							    				ptcdetailslist = otherdocdetails.stream().filter(e-> "P".equalsIgnoreCase(e.getOtherDocType()) && milestones.get(milestones.size()-1).getMilestoneNo().equalsIgnoreCase(e.getMilestoneNo())).collect(Collectors.toList());
										    	ptcdetails = ptcdetailslist!=null && ptcdetailslist.size()>0 ? ptcdetailslist.get(0): null;
							    				%>
							    				<%if(ptcdetails!=null) {%>
													<button type="button" class="btn btn-sm w-50 btn-status btn-success d-flex justify-content-center align-items-center fw-bold" >Paid</button>
												<%} else{%>
													<button type="button" class="btn btn-sm w-50 btn-status btn-danger d-flex justify-content-center align-items-center fw-bold" >Pending</button>
												<%} %>
							    			</td>
							    			<td class="text-center">
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
																		<img src="view/images/userrevoke.png" class="w-22-px" >
																	</figure>
																	<span>Revoke</span>
																</div>
															</div>
														</button>
												    <%} %>
												    
												    <%if(mpstatus!=null && mpstatus[1]!=null && mpstatus[1].toString().equalsIgnoreCase("MAD") ) {%>
												    	<%
												    	
												    	long otherdocdetailsid = ptcdetails!=null?ptcdetails.getOtherDocDetailsId():0;
												    	String otherdocdate = ptcdetails!=null?ptcdetails.getOtherDocDate():null;
												    	otherdocdate = otherdocdate!=null?fc.SqlToRegularDate(otherdocdate):rdf.format(new Date());
												    	
												    	%>
												    	<button type="button" class="btn btn-sm mt-minus-8" data-toggle="modal" onclick="openCalendar('<%=carsInitiationId%>','<%=otherdocdetailsid%>','<%=milestones.get(milestones.size()-1).getMilestoneNo() %>','<%=otherdocdate %>')" >
													  		<div class="cc-rockmenu">
																<div class="rolling">
																	<figure class="rolling_icon">
																		<img src="view/images/calendar.png">
																	</figure>
																	<span>Date</span>
																</div>
															</div>
														</button>
												    	<button class="editable-clicko" name="carsInitiationId" value="<%=carsInitiationId %>" formaction="CARSMilestonePaymentLetterDownload.htm"  formtarget="blank" formmethod="post" formnovalidate="formnovalidate" data-toggle="tooltip" data-placement="top" title="Payment Letter Download"
												    	  <%if(ptcdetails==null) {%>type="button" onclick="return alert('Please fill date of payment')"<%} %>>
															<div class="cc-rockmenu">
																<div class="rolling">
																	<figure class="rolling_icon">
																		<img src="view/images/letter.png" class="w-22-px">
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
			    					<%} %>
					            </tbody>
					        </table>
						</div>
					</div>
				</div>  
				<div class="row ml-5rem"  >
					<div class="col-md-11 ml-20" align="left" >
						<label class="input-font" >*EDP</label> - <span>Expected Date of Payment</span>
					</div>
				</div>
				
				<form action="">
					<div class="container">
												
						<!-- The Modal -->
						<div class="modal modal-mt-10" id="myModal">
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
										<div class="modal-footer modal-jc">
											<button type="submit" formaction="CARSPaymentDocDetailsSubmit.htm"  class="btn btn-sm submit" onclick="return confirm('Are You Sure To Submit?');" >SUBMIT</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					
				</form> 
				<form action="FinalSoODateSubmit.htm" method="post">
					<div class="container">
													
						<!-- The Modal -->
						<div class="modal modal-mt-10" id="myModal2">
					 		<div class="modal-dialog">
					 			<div class="modal-dialog modal-dialog-jump modal-lg modal-dialog-centered">
						    		<div class="modal-content">
						     
						        		<!-- Modal Header -->
						        		<div class="modal-header">
						          			<h4 class="modal-title">Choose date for Letter</h4>
						          			<button type="button" class="close" data-dismiss="modal">&times;</button>
						        		</div>
						        		<!-- Modal body -->
						        		<div class="modal-body">
						        			<div class="form-inline">
						        				<div class="form-group w-100">
						               				<label>Date : &nbsp;&nbsp;&nbsp;</label> 
						              	 			<input class="form-control" type="text" name="calendardate" id="calendardate" required readonly>
						      					</div>
						      				</div>
						      			</div>
						      
						        		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
						        		<input type="hidden" name="carsInitiationId" id="carsInitiationId2">
						        		<!-- Modal footer -->
						        		<div class="modal-footer modal-jc">
						        			<button type="submit"  class="btn btn-sm submit" onclick="return confirm('Are You Sure To Submit?');" >SUBMIT</button>
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
function openCalendar2(carsIniId){
	console.log(carsIniId);
	$('#myModal2').modal('show');
	$('#carsInitiationId2').val(carsIniId);
}


$('#calendardate').daterangepicker({
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

</script>

<script type="text/javascript">




function openCalendar(carsIniId, otherdocdetailsid, milestoneno, otherdocdate){
	console.log(otherdocdetailsid);
	$('#myModal').modal('show');
	$('#carsInitiationId').val(carsIniId);
	$('#otherDocDetailsId').val(otherdocdetailsid);
	$('#MilestoneNo').val(milestoneno);
	
	// Parse the otherdocdate string using moment.js
    var parsedDate = moment(otherdocdate, 'DD-MM-YYYY').toDate();

    // Initialize daterangepicker with custom startDate
    $('#ptcOtherDocDate').daterangepicker({
        "singleDatePicker" : true,
        "linkedCalendars" : false,
        "showCustomRangeLabel" : true,
        "maxDate" : new Date(),
        "cancelClass" : "btn-default",
        showDropdowns : true,
        locale : {
            format : 'DD-MM-YYYY'
        },
        startDate: parsedDate // Set custom startDate
    });		 
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
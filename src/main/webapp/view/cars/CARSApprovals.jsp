<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/cars/CARSApprovals.css" var="carsapprovals" />
<link href="${carsapprovals}" rel="stylesheet" />
<spring:url value="/resources/css/cars/carscommon.css" var="carscommon6" />
<link href="${carscommon6}" rel="stylesheet" />

</head>
<body>
<%	
	
	List<Object[]> PendingList =(List<Object[]>)request.getAttribute("PendingList");
	List<Object[]> ApprovedList =(List<Object[]>)request.getAttribute("ApprovedList");
	String fromdate = (String)request.getAttribute("fromdate");
	String todate   = (String)request.getAttribute("todate");
	
	String tab   = (String)request.getAttribute("tab");
	
	FormatConverter fc = new FormatConverter();
	SimpleDateFormat sdf = fc.getSqlDateFormat();
	SimpleDateFormat rdf = fc.getRegularDateFormat();
	
	String loginType = (String)session.getAttribute("LoginType");
	
	List<Object[]> DPandCSoCPendingList =(List<Object[]>)request.getAttribute("DPandCSoCPendingList");
	List<Object[]> DPandCSoCApprovedList =(List<Object[]>)request.getAttribute("DPandCSoCApprovedList");
	
	List<Object[]> CSPendingList =(List<Object[]>)request.getAttribute("CSPendingList");
	List<Object[]> CSApprovedList =(List<Object[]>)request.getAttribute("CSApprovedList");
	
	List<Object[]> MPPendingList =(List<Object[]>)request.getAttribute("MPPendingList"); 
	List<Object[]> MPApprovedList =(List<Object[]>)request.getAttribute("MPApprovedList");

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
				<div class="card shadow-nohover">
					<div class="row card-header">
			   			<div class="col-md-6">
							<h4>CARS Approvals</h4>
						</div>
					</div>
					<div class="card-body">

						<div class="row w-100 mb-2">
							<div class="col-12">
         						<ul class="nav nav-pills mb-3 p-0 nav-pills-2" id="pills-tab" role="tablist">
		  							<li class="nav-item w-50"  >
		    							<div class="nav-link active text-center" id="pills-mov-property-tab" data-toggle="pill" data-target="#pills-mov-property" role="tab" aria-controls="pills-mov-property" aria-selected="true">
			   								<span>Pending</span> 
											<span class="badge badge-danger badge-counter count-badge ml-0">
				   		 						<%if((PendingList.size() + DPandCSoCPendingList.size() + CSPendingList.size() + MPPendingList.size() )>99 ){ %>
				   									99+
				   								<%}else{ %>
				   								<%=PendingList.size() + DPandCSoCPendingList.size() + CSPendingList.size() + MPPendingList.size() %>
												<%} %>			   			
				  							</span> 
		    							</div>
		  							</li>
		  							<li class="nav-item w-50">
		    							<div class="nav-link text-center" id="pills-imm-property-tab" data-toggle="pill" data-target="#pills-imm-property" role="tab" aria-controls="pills-imm-property" aria-selected="false">
		    	 							<span>Approved</span> 
		    	 							<span class="badge badge-danger badge-counter count-badge ml-0" >
				   		 						<%if((ApprovedList.size() + DPandCSoCApprovedList.size() + CSApprovedList.size() + MPApprovedList.size() )>99){ %>
				   									99+
				   								<%}else{ %>
				   								<%=ApprovedList.size() + DPandCSoCApprovedList.size() + CSApprovedList.size() + MPApprovedList.size()%>
												<%} %>			   			
				  							</span> 
		    							</div>
		  							</li>
								</ul>
	   						</div>
						</div>
	
						<!-- Pending List -->
						<div class="card">					
							<div class="card-body">
								<div class="container-fluid" >
           							<div class="tab-content" id="pills-tabContent">
            							<div class="tab-pane fade show active" id="pills-mov-property" role="tabpanel" aria-labelledby="pills-mov-property-tab">
		    								<form action="#" method="POST" id="">
            									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
             									<div class="table-responsive">
              										<table class="table table-hover  table-striped table-condensed table-bordered table-fixed" id="myTable">
														<thead>
															<tr>
					   											<th>SN</th>
					   											<th>Initiated By</th>
					   											<th>EmpNo</th>
					   											<th>CARSNo</th>
					   											<th>Date</th>
					   											<th>Approval for</th>
                       											<th>Action</th>
                  											</tr>
														</thead>
                 										<tbody>
                       										<% int SN=0;
					   										    if(PendingList!=null && PendingList.size()>0){
                         							 			for(Object[] form:PendingList ){
                      							 			%>
                        									<tr>
                            									<td class="width-5 text-center" ><%=++SN%></td>
                            									<td class="width-30" ><%=form[2]!=null?StringEscapeUtils.escapeHtml4(form[2].toString()): " - "%>, <%=form[3]!=null?StringEscapeUtils.escapeHtml4(form[3].toString()): " - "%></td>
                            									<td class="width-10 text-center" ><%=form[1]!=null?StringEscapeUtils.escapeHtml4(form[1].toString()): " - "%></td>
                            									<td class="width-15 text-center" ><%=form[6]!=null?StringEscapeUtils.escapeHtml4(form[6].toString()): " - "%></td>
                            									<td class="width-10 text-center" ><%=form[5]!=null?fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(form[5].toString())):" - "%></td>
                            									<td class="width-10 text-center" ><%=form[7]!=null?StringEscapeUtils.escapeHtml4(form[7].toString()): " - "%></td>
                            									<td class="width-20 text-center" >
                            										<%if(form[7]!=null && form[7].toString().equalsIgnoreCase("RSQR")) {%>
                            										<button type="submit" class="btn btn-sm view-icon fw-600" formaction="CARSInitiationDetails.htm" name="carsInitiationIdApprovals" value="<%=form[4]%>/Y/3" data-toggle="tooltip" data-placement="top" title="CARS RSQR Approval" >
								   										<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<img src="view/images/preview3.png">
																				</figure>
																				<span>Preview</span>
																			</div>
																		</div>
																	</button>
																	<button type="submit" class="btn btn-sm" formaction="CARSRSQRDownloadBeforeFreeze.htm" name="carsInitiationId" value="<%=form[4]%>" formtarget="blank" formmethod="post" data-toggle="tooltip" data-placement="top" title="RSQR Download">
								  	 									<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<img src="view/images/clipboard.png">
																				</figure>
																				<span>RSQR</span>
																			</div>
																		</div>
																	</button>				
																	<button type="submit" class="btn btn-sm" formaction="CARSRSQRApprovalDownload.htm" name="carsInitiationId" value="<%=form[4]%>" formtarget="blank" formmethod="post" data-toggle="tooltip" data-placement="top" title="Download">
								  	 									<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<img src="view/images/document.png">
																				</figure>
																				<span>RSQR Approval</span>
																			</div>
																		</div>
																	</button>
																	
          															
																	<%} else if(form[7]!=null && form[7].toString().equalsIgnoreCase("SoC")) {%>
																	<button type="submit" class="btn btn-sm view-icon fw-600" formaction="CARSInitiationDetails.htm" name="carsInitiationIdApprovals" value="<%=form[4]%>/S/7" data-toggle="tooltip" data-placement="top" title="CARS SoC" >
								   										<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<img src="view/images/preview3.png">
																				</figure>
																				<span>Preview</span>
																			</div>
																		</div>
																	</button>
																	<button type="submit" class="btn btn-sm" formaction="CARSFinalRSQRDownload.htm" name="carsInitiationId" value="<%=form[4]%>" formtarget="blank" formmethod="post" data-toggle="tooltip" data-placement="top" title="Final RSQR Download">
								  	 									<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<img src="view/images/clipboard.png">
																				</figure>
																				<span>Final RSQR</span>
																			</div>
																		</div>
																	</button>				
																	<button type="submit" class="btn btn-sm" formaction="CARSSoCDownload.htm" name="carsInitiationId" value="<%=form[4]%>" formtarget="blank" formmethod="post" data-toggle="tooltip" data-placement="top" title="Download">
								  	 									<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<img src="view/images/document.png">
																				</figure>
																				<span>SoC</span>
																			</div>
																		</div>
																	</button>
																	
                            										<%} %>
						 										</td>
                        									</tr>
                       										<%} }%>
                       										
                       										<!-- D-P&C SoC Pending List -->
                       										<%
                       											if(DPandCSoCPendingList!=null && DPandCSoCPendingList.size()>0){
                         							 			for(Object[] form:DPandCSoCPendingList ){
                       										%>
                       										<tr>
                       											<td class="width-5 text-center" ><%=++SN%></td>
                            									<td class="width-30 " ><%=form[9]!=null?StringEscapeUtils.escapeHtml4(form[9].toString()): " - "%>, <%=form[10]!=null?StringEscapeUtils.escapeHtml4(form[10].toString()): " - "%></td>
                            									<td class="width-10 text-center"><%=form[8]!=null?StringEscapeUtils.escapeHtml4(form[8].toString()): " - "%></td>
                            									<td class="width-15 text-center"><%=form[6]!=null?StringEscapeUtils.escapeHtml4(form[6].toString()): " - "%></td>
                            									<td class="width-10 text-center"><%=form[5]!=null?fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(form[5].toString())):" - "%></td>
                            									<td class="width-10 text-center"><%=form[7]!=null?StringEscapeUtils.escapeHtml4(form[7].toString()): " - "%></td>
                            									<td class="width-20 text-center">
                            										<button type="submit" class="btn btn-sm view-icon fw-600" formaction="CARSDPCSoCDetails.htm" name="carsInitiationIdSoCApprovals" value="<%=form[4]%>/P/2" data-toggle="tooltip" data-placement="top" title="CARS DPC SoC" >
								   										<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<img src="view/images/preview3.png">
																				</figure>
																				<span>Preview</span>
																			</div>
																		</div>
																	</button>
																	<button type="submit" class="btn btn-sm" formaction="CARSDPCSoCDownload.htm" name="carsInitiationId" value="<%=form[4]%>" formtarget="blank" formmethod="post" data-toggle="tooltip" data-placement="top" title="Download">
								  	 									<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<img src="view/images/document.png">
																				</figure>
																				<span>SoC</span>
																			</div>
																		</div>
																	</button>
                            									</td>
                       										</tr>
                       										<%} }%>
                       										
                       										<!-- Contract Signature Pending List -->
                       										<%
                       											if(CSPendingList!=null && CSPendingList.size()>0){
                         							 			for(Object[] form: CSPendingList ){
                       										%>
                       										<tr>
                       											<td class="width-5 text-center" ><%=++SN%></td>
                            									<td class="width-30" ><%=form[9]!=null?StringEscapeUtils.escapeHtml4(form[9].toString()): " - "%>, <%=form[10]!=null?StringEscapeUtils.escapeHtml4(form[10].toString()): " - "%></td>
                            									<td class="width-10 text-center" ><%=form[8]!=null?StringEscapeUtils.escapeHtml4(form[8].toString()): " - "%></td>
                            									<td class="width-15 text-center" ><%=form[6]!=null?StringEscapeUtils.escapeHtml4(form[6].toString()): " - "%></td>
                            									<td class="width-10 text-center"><%=form[5]!=null?fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(form[5].toString())):" - "%></td>
                            									<td class="width-10 text-center" ><%=form[7]!=null?StringEscapeUtils.escapeHtml4(form[7].toString()): " - "%></td>
                            									<td class="width-20 text-center" >
                            										<button type="submit" class="btn btn-sm view-icon fw-600" formaction="CARSContractSignatureDetails.htm" name="carsInitiationIdCSDocApprovals" value="<%=form[4]%>/C/2" data-toggle="tooltip" data-placement="top" title="CARS Contract Signature"  >
								   										<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<img src="view/images/preview3.png">
																				</figure>
																				<span>Preview</span>
																			</div>
																		</div>
																	</button>
																	<button type="submit" class="btn btn-sm" formaction="CARSCSDownload.htm" name="carsInitiationId" value="<%=form[4]%>" formtarget="blank" formmethod="post" data-toggle="tooltip" data-placement="top" title="Download">
								  	 									<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<img src="view/images/document.png">
																				</figure>
																				<span>Contract Signature</span>
																			</div>
																		</div>
																	</button>
                            										
                            									</td>
                       										</tr>
                       										<%} }%>
                       										
                       										<!-- Milestone Payment Pending List -->
                       										<%
                       											if(MPPendingList!=null && MPPendingList.size()>0){
                         							 			for(Object[] form: MPPendingList ){
                       										%>
                       										<tr>
                       											<td class="width-5 text-center"><%=++SN%></td>
                            									<td class="width-30"><%=form[9]!=null?StringEscapeUtils.escapeHtml4(form[9].toString()): " - "%>, <%=form[10]!=null?StringEscapeUtils.escapeHtml4(form[10].toString()): " - "%></td>
                            									<td class="width-10 text-center"><%=form[8]!=null?StringEscapeUtils.escapeHtml4(form[8].toString()): " - "%></td>
                            									<td class="width-15 text-center"><%=form[6]!=null?StringEscapeUtils.escapeHtml4(form[6].toString()): " - "%></td>
                            									<td class="width-10 text-center"><%=form[5]!=null?fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(form[5].toString())):" - "%></td>
                            									<td class="width-10 text-center"><%=form[7]!=null?StringEscapeUtils.escapeHtml4(form[7].toString()): " - "%></td>
                            									<td class="width-20 text-center">
                            										<button type="submit" class="btn btn-sm view-icon fw-600" formaction="CARSMilestonePaymentDetails.htm" name="carsInitiationIdMPDocApprovals" value="<%=form[4]%>/M/2/<%=form[11] %>" data-toggle="tooltip" data-placement="top" title="CARS Payment Approval" >
								   										<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<img src="view/images/preview3.png">
																				</figure>
																				<span>Preview</span>
																			</div>
																		</div>
																	</button>
																	<button type="submit" class="btn btn-sm" formaction="CARSMPDownload.htm" name="carsInitiationIdMPDocDownload" value="<%=form[4]%>/<%=form[11] %>" formtarget="blank" formmethod="post" data-toggle="tooltip" data-placement="top" title="Download">
								  	 									<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<img src="view/images/document.png">
																				</figure>
																				<span>Payment Approval</span>
																			</div>
																		</div>
																	</button>
                            										
                            									</td>
                       										</tr>
                       										<%} }%>
                       										
                 										</tbody>  
            										</table>
          										</div>
         									</form>
			  							</div>
 
										<!-- Approved List -->	
										<div class="tab-pane fade" id="pills-imm-property" role="tabpanel" aria-labelledby="pills-imm-property-tab">	
											<div class="card-body main-card " >	
												<form method="post" action="CARSRSQRApprovals.htm" >
													<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
													<input type="hidden" name="tab" value="closed"/>
														<div class="row w-100 mt-2 mb-2">
															<div class="col-md-12 f-right">
																<table class="f-right">
																	<tr>
																		<td> From Date :&nbsp; </td>
							        									<td> 
																			<input type="text" class="form-control input-sm mydate" onchange="this.form.submit()"  readonly="readonly"  <%if(fromdate!=null){%>
								        										value="<%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(fromdate))%>" <%}%> value=""  id="fromdate" name="fromdate"  required="required"   > 
																		</td>
																		<td></td>
																		<td >To Date :&nbsp;</td>
																		<td>					
																			<input type="text"  class="form-control input-sm mydate" onchange="this.form.submit()"  readonly="readonly" <%if(todate!=null){%>
								        	 									value="<%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(todate))%>" <%}%>  value=""  id="todate" name="todate"  required="required"  > 							
																		</td>
																	</tr>
																</table>
					 										</div>
					 									</div>
												</form>
												<div class="row" >
		 											<div class="col-md-12">
														<form action="#" method="POST" id="">
            												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
             													<div class="table-responsive">
              														<table class="table table-hover  table-striped table-condensed table-bordered table-fixed" id="myTable1">
																		<thead>
																			<tr>
					   															<th>SN</th>
					  															<th>Initiated By</th>
					  															<th>EmpNo</th>
					   															<th>CARSNo</th>
					   															<th>Approval for</th>
                       															<th>Status</th>
                       															<th>Action</th>
                  															</tr>
																		</thead>
                 														<tbody>
                      													    <%	int SNA=0;
                      													    	if(ApprovedList!=null && ApprovedList.size()>0) {
                          															for(Object[] form:ApprovedList ) {
                       													    %>
                        													<tr>
                            													<td class="width-5 text-center" ><%=++SNA%></td>
                            													<td class="width-22 text-left" ><%=form[2]!=null?StringEscapeUtils.escapeHtml4(form[2].toString()): " - "%>, <%=form[3]!=null?StringEscapeUtils.escapeHtml4(form[3].toString()): " - "%></td>
                            													<td class="width-5 text-center" ><%=form[1]!=null?StringEscapeUtils.escapeHtml4(form[1].toString()): " - " %> </td>
                            													<td class="width-15 text-center" ><%=form[6]!=null?StringEscapeUtils.escapeHtml4(form[6].toString()): " - " %> </td>
                            													<td class="width-8 text-center"><%=form[12]!=null?StringEscapeUtils.escapeHtml4(form[12].toString()): " - " %> </td>
                            													<td class="width-25 text-center" >
                            														<%if(form[12]!=null && form[12].toString().equalsIgnoreCase("RSQR")) {%>
																					<button type="submit" class="btn btn-sm btn-link-1 w-50 btn-status fw-600 color-<%= form[9].toString().replace("#", "").trim() %>" formaction="CARSRSQRTransStatus.htm" value="<%=form[4] %>" name="carsInitiationId"  data-toggle="tooltip" data-placement="top" title="Transaction History" formtarget="_blank">
								    													<%=form[8]!=null?StringEscapeUtils.escapeHtml4(form[8].toString()): " - " %> <i class="fa fa-telegram f-right mt-1" aria-hidden="true" ></i>
								    												</button>
								    												<%} else if(form[12]!=null && form[12].toString().equalsIgnoreCase("SoC")) {%>
								    												<button type="submit" class="btn btn-sm btn-link-1 w-50 btn-status fw-600 color-<%= form[9].toString().replace("#", "").trim() %>" formaction="CARSSoCTransStatus.htm" value="<%=form[4] %>" name="carsInitiationId"  data-toggle="tooltip" data-placement="top" title="Transaction History" formtarget="_blank">
								    													<%=form[8]!=null?StringEscapeUtils.escapeHtml4(form[8].toString()): " - " %> <i class="fa fa-telegram f-right mt-1" aria-hidden="true"></i>
								    												</button>
								    												<%} %>
						 														</td>
						 														<td class="width-20 text-center">
						 															<%if(form[12]!=null && form[12].toString().equalsIgnoreCase("RSQR")) {%>
						 															<button type="submit" class="btn btn-sm view-icon fw-600" formaction="CARSInitiationDetails.htm" name="carsInitiationIdApprovals" value="<%=form[4]%>/N/3" data-toggle="tooltip" data-placement="top" title="CARS RSQR Approval"  >
								   														<div class="cc-rockmenu">
																							<div class="rolling">
																								<figure class="rolling_icon">
																									<img src="view/images/preview3.png">
																								</figure>
																								<span>Preview</span>
																							</div>
																						</div>
																					</button>
																					<button type="submit" class="btn btn-sm" formaction="CARSRSQRDownload.htm" name="carsInitiationId" value="<%=form[4]%>" formtarget="blank" formmethod="post" data-toggle="tooltip" data-placement="top" title="RSQR Download">
								  	 													<div class="cc-rockmenu">
																							<div class="rolling">
																								<figure class="rolling_icon">
																									<img src="view/images/clipboard.png">
																								</figure>
																								<span>RSQR</span>
																							</div>
																						</div>
																					</button>
																					<button type="submit" class="btn btn-sm" formaction="CARSRSQRApprovalDownload.htm" name="carsInitiationId" value="<%=form[4]%>" formtarget="blank" formmethod="post" data-toggle="tooltip" data-placement="top" title="Download">
								  	 													<div class="cc-rockmenu">
																							<div class="rolling">
																								<figure class="rolling_icon">
																									<img src="view/images/document.png">
																								</figure>
																								<span>Approval</span>
																							</div>
																						</div>
																					</button>
																					
						 															<%} else if(form[12]!=null && form[12].toString().equalsIgnoreCase("SoC")) {%>
						 															<button type="submit" class="btn btn-sm view-icon fw-600" formaction="CARSInitiationDetails.htm" name="carsInitiationIdApprovals" value="<%=form[4]%>/T/7" data-toggle="tooltip" data-placement="top" title="CARS SoC">
								   														<div class="cc-rockmenu">
																							<div class="rolling">
																								<figure class="rolling_icon">
																									<img src="view/images/preview3.png">
																								</figure>
																								<span>Preview</span>
																							</div>
																						</div>
																					</button>
																					<button type="submit" class="btn btn-sm" formaction="CARSFinalRSQRDownload.htm" name="carsInitiationId" value="<%=form[4]%>" formtarget="blank" formmethod="post" data-toggle="tooltip" data-placement="top" title="Final RSQR Download">
								  	 													<div class="cc-rockmenu">
																							<div class="rolling">
																								<figure class="rolling_icon">
																									<img src="view/images/clipboard.png">
																								</figure>
																								<span>Final RSQR</span>
																							</div>
																						</div>
																					</button>
																					<button type="submit" class="btn btn-sm" formaction="CARSSoCDownload.htm" name="carsInitiationId" value="<%=form[4]%>" formtarget="blank" formmethod="post" data-toggle="tooltip" data-placement="top" title="Download">
								  	 													<div class="cc-rockmenu">
																							<div class="rolling">
																								<figure class="rolling_icon">
																									<img src="view/images/document.png">
																								</figure>
																								<span>SoC</span>
																							</div>
																						</div>
																					</button>
									
                            														<%} %>
            
						 														</td>
                        													</tr>
                       													 	<%} }%>
                       													 	
                       													 	<!-- D-P&C SoC Approved List -->
                       													 	<%
                      													    	if(DPandCSoCApprovedList!= null && DPandCSoCApprovedList.size()>0) {
                          															for(Object[] form:DPandCSoCApprovedList ) {
                       													    %>
                        													<tr>
                            													<td class="width-5 text-center"><%=++SNA%></td>
                            													<td class="width-22 text-left"><%=form[14]!=null?StringEscapeUtils.escapeHtml4(form[14].toString()): " - "%>, <%=form[15]!=null?StringEscapeUtils.escapeHtml4(form[15].toString()): " - "%></td>
                            													<td class="width-5 text-center"><%=form[13]!=null?StringEscapeUtils.escapeHtml4(form[13].toString()): " - " %> </td>
                            													<td class="width-15 text-center" ><%=form[6]!=null?StringEscapeUtils.escapeHtml4(form[6].toString()): " - " %> </td>
                            													<td class="width-8 text-center" ><%=form[12]!=null?StringEscapeUtils.escapeHtml4(form[12].toString()): " - " %> </td>
                            													<td class="width-30 text-center" >
								    												<button type="submit" class="btn btn-sm btn-link-1 w-50 btn-status fw-600 color-<%= form[9].toString().replace("#", "").trim() %>" formaction="CARSDPCSoCTransStatus.htm" value="<%=form[4] %>" name="carsInitiationId"  data-toggle="tooltip" data-placement="top" title="Transaction History" formtarget="_blank">
								    													<%=form[8]!=null?StringEscapeUtils.escapeHtml4(form[8].toString()): " - " %> <i class="fa fa-telegram f-right mt-1" aria-hidden="true"></i>
								    												</button>
						 														</td>
						 														<td class="width-15 text-center">
						 															<button type="submit" class="btn btn-sm view-icon fw-600" formaction="CARSDPCSoCDetails.htm" name="carsInitiationIdSoCApprovals" value="<%=form[4]%>/Q/2" data-toggle="tooltip" data-placement="top" title="CARS SoC"  >
								   														<div class="cc-rockmenu">
																							<div class="rolling">
																								<figure class="rolling_icon">
																									<img src="view/images/preview3.png">
																								</figure>
																								<span>Preview</span>
																							</div>
																						</div>
																					</button>
																					<button type="submit" class="btn btn-sm" formaction="CARSDPCSoCDownload.htm" name="carsInitiationId" value="<%=form[4]%>" formtarget="blank" formmethod="post" data-toggle="tooltip" data-placement="top" title="Download">
								  	 													<div class="cc-rockmenu">
																							<div class="rolling">
																								<figure class="rolling_icon">
																									<img src="view/images/document.png">
																								</figure>
																								<span>SoC</span>
																							</div>
																						</div>
																					</button>
						 														</td>
                        													</tr>
                       													 	<%} }%>
                       													 	
                       													 	<!-- Contract Signature Approved List -->
                       													 	<%
                      													    	if(CSApprovedList!= null && CSApprovedList.size()>0) {
                          															for(Object[] form:CSApprovedList ) {
                       													    %>
                        													<tr>
                            													<td class="width-5 text-center"><%=++SNA%></td>
                            													<td class="width-22 text-left" ><%=form[14]!=null?StringEscapeUtils.escapeHtml4(form[14].toString()): " - "%>, <%=form[15]!=null?StringEscapeUtils.escapeHtml4(form[15].toString()): " - "%></td>
                            													<td class="width-5 text-center" ><%=form[13]!=null?StringEscapeUtils.escapeHtml4(form[13].toString()): " - " %> </td>
                            													<td class="width-15 text-center"><%=form[6]!=null?StringEscapeUtils.escapeHtml4(form[6].toString()): " - " %> </td>
                            													<td class="width-8 text-center" ><%=form[12]!=null?StringEscapeUtils.escapeHtml4(form[12].toString()): " - " %> </td>
                            													<td class="width-30 text-center">
								    												<button type="submit" class="btn btn-sm btn-link-1 w-50 btn-status  fw-600 color-<%= form[9].toString().replace("#", "").trim() %>" formaction="CARSTransStatus.htm" value="<%=form[4] %>" name="carsInitiationId"  data-toggle="tooltip" data-placement="top" title="Transaction History"  formtarget="_blank">
								    													<%=form[8]!=null?StringEscapeUtils.escapeHtml4(form[8].toString()): " - " %> <i class="fa fa-telegram f-right mt-1" aria-hidden="true"  ></i>
								    												</button>
						 														</td>
						 														<td class="width-15 text-center">
						 															<button type="submit" class="btn btn-sm view-icon fw-600" formaction="CARSContractSignatureDetails.htm" name="carsInitiationIdCSDocApprovals" value="<%=form[4]%>/D/2" data-toggle="tooltip" data-placement="top" title="CARS Contract Signature" >
								   														<div class="cc-rockmenu">
																							<div class="rolling">
																								<figure class="rolling_icon">
																									<img src="view/images/preview3.png">
																								</figure>
																								<span>Preview</span>
																							</div>
																						</div>
																					</button>
																					<button type="submit" class="btn btn-sm" formaction="CARSCSDownload.htm" name="carsInitiationId" value="<%=form[4]%>" formtarget="blank" formmethod="post" data-toggle="tooltip" data-placement="top" title="Download">
								  	 													<div class="cc-rockmenu">
																							<div class="rolling">
																								<figure class="rolling_icon">
																									<img src="view/images/document.png">
																								</figure>
																								<span>Contract Signature</span>
																							</div>
																						</div>
																					</button>
						 														</td>
                        													</tr>
                       													 	<%} }%>
                       													 	
                       													 	<!-- Milestone Payment Approved List -->
                       													 	<%
                      													    	if(MPApprovedList!= null && MPApprovedList.size()>0) {
                          															for(Object[] form:MPApprovedList ) {
                       													    %>
                        													<tr>
                            													<td class="width-5 text-center"><%=++SNA%></td>
                            													<td class="width-22 text-left" ><%=form[14]!=null?StringEscapeUtils.escapeHtml4(form[14].toString()): " - "%>, <%=form[15]!=null?StringEscapeUtils.escapeHtml4(form[15].toString()): " - "%></td>
                            													<td class="width-5 text-center" ><%=form[13]!=null?StringEscapeUtils.escapeHtml4(form[13].toString()): " - " %> </td>
                            													<td class="width-15 text-center" ><%=form[6]!=null?StringEscapeUtils.escapeHtml4(form[6].toString()): " - " %> </td>
                            													<td class="width-8 text-center" ><%=form[12]!=null?StringEscapeUtils.escapeHtml4(form[12].toString()): " - " %> </td>
                            													<td class="width-30 text-center">
								    												<button type="submit" class="btn btn-sm btn-link-1 w-50 btn-status  fw-600 color-<%= form[9].toString().replace("#", "").trim() %>" formaction="CARSTransStatus.htm" value="<%=form[4] %>" name="carsInitiationId"  data-toggle="tooltip" data-placement="top" title="Transaction History" formtarget="_blank">
								    													<%=form[8]!=null?StringEscapeUtils.escapeHtml4(form[8].toString()): " - " %> <i class="fa fa-telegram f-right mt-1" aria-hidden="true" ></i>
								    												</button>
						 														</td>
						 														<td class="width-15 text-center">
						 															<button type="submit" class="btn btn-sm view-icon fw-600" formaction="CARSMilestonePaymentDetails.htm" name="carsInitiationIdMPDocApprovals" value="<%=form[4]%>/N/2/<%=form[16] %>" data-toggle="tooltip" data-placement="top" title="CARS Payment Approval"  >
								   														<div class="cc-rockmenu">
																							<div class="rolling">
																								<figure class="rolling_icon">
																									<img src="view/images/preview3.png">
																								</figure>
																								<span>Preview</span>
																							</div>
																						</div>
																					</button>
																					<button type="submit" class="btn btn-sm" formaction="CARSMPDownload.htm" name="carsInitiationIdMPDocDownload" value="<%=form[4]%>/<%=form[16]%>" formtarget="blank" formmethod="post" data-toggle="tooltip" data-placement="top" title="Download">
								  	 													<div class="cc-rockmenu">
																							<div class="rolling">
																								<figure class="rolling_icon">
																									<img src="view/images/document.png">
																								</figure>
																								<span>Payment Approval</span>
																							</div>
																						</div>
																					</button>
						 														</td>
                        													</tr>
                       													 	<%} }%>
                       													 	
                   														</tbody>
                 													</table>
                												</div> 
               												</form>
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
				</div>
		</div>
</div>
					
<script type="text/javascript">
$("#myTable1,#myTable").DataTable({
    "lengthMenu": [ 50, 75, 100],
    "pagingType": "simple"

});

$('#fromdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	/* "minDate" :datearray,   */
	 <%-- "startDate" : new Date('<%=fromdate%>'), --%> 
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});
	
	
	$('#todate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		<%-- "startDate" : new Date('<%=todate%>'), --%> 
		"minDate" :$("#fromdate").val(),  
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});

	 /* $(document).ready(function(){
		   $('#fromdate, #todate').change(function(){
		       $('#myform').submit();
		    });
		});  */

	<%if(tab!=null && tab.equals("closed")){%>
	
		$('#pills-imm-property-tab').click();
	
	<%}%>
	<% String val = request.getParameter("val");
	if(val!=null && val.equalsIgnoreCase("app")){%>
		$('#pills-imm-property-tab').click();
	<%}%>
	
	
	$(function () {
		$('[data-toggle="tooltip"]').tooltip()
		});	
	
</script>

</body>
</html>
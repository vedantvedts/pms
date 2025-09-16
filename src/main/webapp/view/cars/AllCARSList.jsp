<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.util.List"%>
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
<spring:url value="/resources/css/cars/AllCARSList.css" var="allcarslist" />
<link href="${allcarslist}" rel="stylesheet" />
<spring:url value="/resources/css/cars/carscommon.css" var="carscommon5" />
<link href="${carscommon5}" rel="stylesheet" />


</head>
<body>
<%
List<Object[]> ApprovedList =(List<Object[]>)request.getAttribute("ApprovedList");
List<Object[]> MoMUploadedList =(List<Object[]>)request.getAttribute("MoMUploadedList");
List<Object[]> CARSFinalApprovedList =(List<Object[]>)request.getAttribute("CARSFinalApprovedList");
String rsqrfromdate = (String)request.getAttribute("rsqrfromdate");
String rsqrtodate   = (String)request.getAttribute("rsqrtodate");

FormatConverter fc = new FormatConverter();

String AllListTabId   = (String)request.getAttribute("AllListTabId");

String socfromdate = (String)request.getAttribute("socfromdate");
String soctodate   = (String)request.getAttribute("soctodate");

String carsfromdate = (String)request.getAttribute("carsfromdate");
String carstodate   = (String)request.getAttribute("carstodate");
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
         		<div class="card-header slider_header card-head-bg">
             		<h3 class="category">All CARS Details</h3>
             		<hr class="hr-margin">
             		<ul class="nav nav-tabs justify-content-center pb-0" role="tablist" >
            			<li class="nav-item" id="nav-rsqrapproved">
             				<%if(AllListTabId!=null&&AllListTabId.equalsIgnoreCase("1")){ %> 
             		    		<a class="nav-link active " data-toggle="tab" href="#rsqrapproved" id="nav" role="tab">
             				<%}else{ %>
              			 		<a class="nav-link  " data-toggle="tab" href="#rsqrapproved" role="tab">
               				<%} %>  
                	         	RSQR Approved
              			 		</a>
            			</li>

            			<li class="nav-item" id="nav-soc">
            	     		<%if(AllListTabId!=null&&AllListTabId.equalsIgnoreCase("2")){ %>
              					<a class="nav-link active" data-toggle="tab" href="#soc" id="nav"role="tab" >
              				<%}else{ %>
              					<a class="nav-link" data-toggle="tab" href="#soc" role="tab" >
               				<%} %>
                  				SoC
              					</a>
            			</li>
            			<li class="nav-item" id="nav-cars03">
            	     		<%if(AllListTabId!=null&&AllListTabId.equalsIgnoreCase("3")){ %>
              					<a class="nav-link active" data-toggle="tab" href="#cars03" id="nav"role="tab" >
              				<%}else{ %>
              					<a class="nav-link" data-toggle="tab" href="#cars03" role="tab" >
               				<%} %>
                  				CARS-03
              					</a>
            			</li>
            			
              		</ul>
         		</div>
         		<!-- This is for Tab Panes -->
         		<div class="card">
         			<div class="tab-content text-center mt-1">
               			
         				<!-- *********** RSQR Approved List  ***********      -->
               			<%if(AllListTabId!=null&&AllListTabId.equalsIgnoreCase("1")){ %> 
         					<div class="tab-pane active" id="rsqrapproved" role="tabpanel">
         				<%}else{ %>
              				<div class="tab-pane " id="rsqrapproved" role="tabpanel">
               			<%} %>
               				
								<div class="card-body">
									<form method="post" action="CARSRSQRApprovedList.htm" >
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
										<div class="row w-100 mt-2 mb-2">
											<div class="col-md-12 f-right">
												<table class="f-right">
													<tr>
														<td> From Date :&nbsp; </td>
												        <td> 
															<input type="text" class="form-control input-sm mydate" onchange="this.form.submit()"  readonly="readonly"  <%if(rsqrfromdate!=null){%>
													        	value="<%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(rsqrfromdate))%>" <%}%> value=""  id="rsqrfromdate" name="rsqrfromdate"  required="required"   > 
														</td>
														<td></td>
														<td >To Date :&nbsp;</td>
														<td>					
															<input type="text"  class="form-control input-sm mydate" onchange="this.form.submit()"  readonly="readonly" <%if(rsqrtodate!=null){%>
													        	 value="<%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(rsqrtodate))%>" <%}%>  value=""  id="rsqrtodate" name="rsqrtodate"  required="required"  > 							
														</td>
													</tr>
												</table>
										 	</div>
										</div>
										<input type="hidden" name="AllListTabId" value="1">
									</form>	
									<form action="" method="POST" id="circularForm">
					            		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					            		<div class="row w-98 m-10">
											<div class="col-md-12" >
											<div class="table-responsive text-left">
						                		<table class="table table-hover  table-striped table-condensed table-bordered table-fixed" id="rsqrTable" >
													<thead class="tab-bg">
														<tr>
										   					<th>SN</th>
										  					<th>Initiated By</th>
										   					<th>CARSNo</th>
										   					<th>Amount</th>
					                       					<th >Status</th>
					                       					<th >Action</th>
					                  					</tr>
													</thead>
					                 				<tbody>
					                      				<% 
					                      				   if(ApprovedList.size()>0){
					                      				   int SNA=0;
					                          			   for(Object[] form:ApprovedList ){
					                          				   if(form[12].toString().equalsIgnoreCase("RSQR")) {
					                       				%>
					                        			<tr>
					                            			<td class="width-5 text-center"><%=++SNA%></td>
					                            			<td class="width-20 text-left" ><%=form[2]!=null?StringEscapeUtils.escapeHtml4(form[2].toString()): " - "%> (<%=form[1]!=null?StringEscapeUtils.escapeHtml4(form[1].toString()): " - "%>), <%=form[3]!=null?StringEscapeUtils.escapeHtml4(form[3].toString()): " - "%></td>
					                            			<td class="width-15 text-center" ><%=form[6]!=null?StringEscapeUtils.escapeHtml4(form[6].toString()): " - " %> </td>
					                            			<td class="width-10 text-right" ><%=form[11]!=null?StringEscapeUtils.escapeHtml4(form[11].toString()): " - " %> </td>
					                            			<td class="width-28 text-center" >
																<button type="submit" class="btn btn-sm btn-link-1 w-50 btn-status fw-600 color-<%=form[9].toString().replace("#","")  %>" formaction="CARSRSQRTransStatus.htm" value="<%=form[4] %>" name="carsInitiationId"  data-toggle="tooltip" data-placement="top" title="Transaction History" formtarget="_blank">
													    			<%=form[8]!=null?StringEscapeUtils.escapeHtml4(form[8].toString()): " - " %> <i class="fa fa-telegram f-right mt-2" aria-hidden="true" ></i>
													    		</button>
											 				</td>
											 				<td class="width-20 text-center" >
					                            				<button type="submit" class="btn btn-sm view-icon fw-600" formaction="CARSInitiationDetails.htm" name="carsInitiationId" value="<%=form[4]%>" data-toggle="tooltip" data-placement="top" title="CARS RSQR Approval" >
													   				<div class="cc-rockmenu">
																		<div class="rolling">
																			<figure class="rolling_icon">
																				<img src="view/images/preview3.png">
																			</figure>
																			<span>Preview</span>
																		</div>
																	</div>
																</button>
																<button type="submit" class="btn btn-sm" formaction="CARSRSQRDownload.htm" name="carsInitiationId" value="<%=form[4]%>" formtarget="blank" formmethod="post" data-toggle="tooltip" data-placement="top" title="Download">
													  	 			<div class="cc-rockmenu">
																		<div class="rolling">
																			<figure class="rolling_icon">
																				<img src="view/images/clipboard.png">
																			</figure>
																			<span>RSQR</span>
																		</div>
																	</div>
																</button>
																<button type="button" class="btn btn-sm" data-toggle="modal" onclick="openCalendar('<%=form[4]%>')" >
													  	 			<div class="cc-rockmenu">
																		<div class="rolling">
																			<figure class="rolling_icon">
																				<img src="view/images/calendar.png">
																			</figure>
																			<span>SoO Inv</span>
																		</div>
																	</div>
																</button>
																<button type="submit" class="btn btn-sm" formaction="CARSInvForSoODownload.htm" name="carsInitiationId" value="<%=form[4]%>" formtarget="blank" formmethod="post" data-toggle="tooltip" data-placement="top" title="Download">
													  	 			<div class="cc-rockmenu">
																		<div class="rolling">
																			<figure class="rolling_icon">
																				<img src="view/images/letter.png">
																			</figure>
																			<span>Inv for SoO</span>
																		</div>
																	</div>
																</button>
																<button type="submit" class="btn btn-sm" formaction="SoOProFormWordDownload.htm" name="carsInitiationId" value="<%=form[4]%>" formmethod="get" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Summary Offer of Provision of Research Services Download">
																	<div class="cc-rockmenu">
																		<div class="rolling">
																			<figure class="rolling_icon">
																				<img src="view/images/worddoc.png" class="w-28-px">
																			</figure>
																			<span>Pro form</span>
																		</div>
																	</div>
																</button>
															</td>
					                        			</tr>
					                       			<%} } }else{%>
					                       				<tr>
					                       					<td colspan="6" class="text-center">No data available in table</td>
					                       				</tr>
					                       			<%} %>
					                   			    </tbody>
					                 		    </table>
						                	</div>
						                	</div>
						                	</div>
						                	<input type="hidden" name="isApproval" value="A">
					          				<input type="hidden" name="TabId" value="3">
						                </form>
						                <form action="">
							                <div class="container">
												
												<!-- The Modal -->
												<div class="modal mt-10-p" id="myModal" >
											 		<div class="modal-dialog">
											 			<div class="modal-dialog modal-dialog-jump modal-lg modal-dialog-centered">
												    		<div class="modal-content">
												     
												        		<!-- Modal Header -->
												        		<div class="modal-header">
												          			<h4 class="modal-title">Choose date for Inv for SoO</h4>
												          			<button type="button" class="close" data-dismiss="modal">&times;</button>
												        		</div>
												        		<!-- Modal body -->
												        		<div class="modal-body">
												        			<div class="form-inline">
												        				<div class="form-group w-100">
												               				<label>SoO Date : &nbsp;&nbsp;&nbsp;</label> 
												              	 			<input class="form-control" type="text" name="calendardate" id="calendardate" required readonly>
												      					</div>
												      				</div>
												      			</div>
												      
												        		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
												        		<input type="hidden" name="carsInitiationId" id="carsInitiationId">
												        		<!-- Modal footer -->
												        		<div class="modal-footer js-c" > 
												        			<button type="submit" formaction="InvForSoODateSubmit.htm"  class="btn btn-sm submit" onclick="return confirm('Are You Sure To Submit?');" >SUBMIT</button>
												       			</div>
												      		</div>
											    		</div>
											  		</div>
											  	</div>
											</div>
										</form>
									</div>
               						<div class="navigation_btn text-right" >
            							<a class="btn btn-info btn-sm  shadow-nohover previous" >Previous</a>
										<button class="btn btn-info btn-sm next">Next</button>
									</div>
               			<%if(AllListTabId!=null&&AllListTabId.equalsIgnoreCase("1")){ %> 
         					</div>
         				<%}else{ %>
              				</div>
               			<%} %> 
               			
               			<!-- *********** SoC***********      --> 
               			<%if(AllListTabId!=null&&AllListTabId.equalsIgnoreCase("2")){ %> 
         					<div class="tab-pane active" id="soc" role="tabpanel">
         				<%}else{ %>
              				<div class="tab-pane " id="soc" role="tabpanel">
               			<%} %>
               					<div class="card-body">
									<form method="post" action="CARSRSQRApprovedList.htm" >
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
										<div class="row w-100 mt-2 mb-2" >
											<div class="col-md-12 f-right">
												<table class="f-right">
													<tr>
														<td> From Date :&nbsp; </td>
												        <td> 
															<input type="text" class="form-control input-sm mydate" onchange="this.form.submit()"  readonly="readonly"  <%if(socfromdate!=null){%>
													        	value="<%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(socfromdate))%>" <%}%> value=""  id="socfromdate" name="socfromdate"  required="required"   > 
														</td>
														<td></td>
														<td >To Date :&nbsp;</td>
														<td>					
															<input type="text"  class="form-control input-sm mydate" onchange="this.form.submit()"  readonly="readonly" <%if(soctodate!=null){%>
													        	 value="<%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(soctodate))%>" <%}%>  value=""  id="soctodate" name="soctodate"  required="required"  > 							
														</td>
													</tr>
												</table>
										 	</div>
										</div>
										<input type="hidden" name="AllListTabId" value="2">
									</form>	
									<form action="" method="POST" id="circularForm">
					            		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					            		<div class="row w-98 mt-10">
											<div class="col-md-12" >
												<div class="table-responsive text-left" >
							                		<table class="table table-hover  table-striped table-condensed table-bordered table-fixed" id="rsqrTable" >
														<thead class="tab-bg">
															<tr>
											   					<th>SN</th>
											  					<th>Initiated By</th>
											   					<th>CARSNo</th>
											   					<th>Amount</th>
						                       					<th>Status</th>
						                       					<th>Action</th>
						                  					</tr>
														</thead>
						                 				<tbody>
						                      				<% 
						                      				   if(MoMUploadedList!=null && MoMUploadedList.size()>0){
						                      				   int SNA=0;
						                          			   for(Object[] form: MoMUploadedList ){
						                       				%>
						                        			<tr>
						                            			<td class="width-5 text-center" ><%=++SNA%></td>
						                            			<td class="width-20 text-left" ><%=form[9]!=null?StringEscapeUtils.escapeHtml4(form[9].toString()): " - "%> (<%=form[13]!=null?StringEscapeUtils.escapeHtml4(form[13].toString()): " - "%>), <%=form[14]!=null?StringEscapeUtils.escapeHtml4(form[14].toString()): " - "%></td>
						                            			<td class="width-15 text-center"><%=form[2]!=null?StringEscapeUtils.escapeHtml4(form[2].toString()): " - " %> </td>
						                            			<td class="width-10 text-right" ><%=form[15]!=null?StringEscapeUtils.escapeHtml4(form[15].toString()): " - " %> </td>
						                            			<td class="width-33 text-center" >
																	<button type="submit" class="btn btn-sm btn-link-1 color-<%=form[11].toString().replace("#","").trim() %> fw-600 w-50 btn-status" formaction="CARSTransStatus.htm" value="<%=form[0]%>" name="carsInitiationId"  data-toggle="tooltip" data-placement="top" title="Transaction History" formtarget="_blank">
														    			<%=form[10]!=null?StringEscapeUtils.escapeHtml4(form[10].toString()): " - " %> <i class="fa fa-telegram f-right mt-1" aria-hidden="true"></i>
														    		</button>
												 				</td>
												 				<td class="width-15 text-center" >
						                            				<button type="submit" class="btn btn-sm view-icon fw-600" formaction="CARSDPCSoCDetails.htm" name="carsInitiationId" value="<%=form[0]%>" data-toggle="tooltip" data-placement="top" title="SoC Details"  >
														   				<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<img src="view/images/clipboard.png">
																				</figure>
																				<span>Details</span>
																			</div>
																		</div>
																	</button>
																	<%if(form[12]!=null && form[12].toString().equalsIgnoreCase("SFD") ) {%>
							                                       	 	<button class="editable-click" name="carsInitiationId" value="<%=form[0] %>" formaction="CARSSoCDPCRevoke.htm" formmethod="post" onclick="return confirm('Are you sure to revoke?')">
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
																</td>
						                        			</tr>
						                       			<%} }else{%>
						                       				<tr>
						                       					<td colspan="6" class="text-center">No data available in table</td>
						                       				</tr>
						                       			<%} %>
						                   			    </tbody>
						                 		    </table>
							                	</div>
						                	</div>
						                </div>
						            </form>
								</div>
               					<div class="navigation_btn text-right" >
            						<a class="btn btn-info btn-sm  shadow-nohover previous" >Previous</a>
									<button class="btn btn-info btn-sm next">Next</button>
								</div>
               			<%if(AllListTabId!=null&&AllListTabId.equalsIgnoreCase("2")){ %> 
         					</div>
         				<%}else{ %>
              				</div>
               			<%} %>
               			
               			<!-- *********** CARS-03 ***********      --> 
               			<%if(AllListTabId!=null&&AllListTabId.equalsIgnoreCase("3")){ %> 
         					<div class="tab-pane active" id="cars03" role="tabpanel">
         				<%}else{ %>
              				<div class="tab-pane " id="cars03" role="tabpanel">
               			<%} %>
               					<div class="card-body">
									<form method="post" action="CARSRSQRApprovedList.htm" >
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
										<div class="row w-100 mt-2 mb-2">
											<div class="col-md-12 f-right" >
												<table class="f-right">
													<tr>
														<td> From Date :&nbsp; </td>
												        <td> 
															<input type="text" class="form-control input-sm mydate" onchange="this.form.submit()"  readonly="readonly"  <%if(carsfromdate!=null){%>
													        	value="<%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(carsfromdate))%>" <%}%> value=""  id="carsfromdate" name="carsfromdate"  required="required"   > 
														</td>
														<td></td>
														<td >To Date :&nbsp;</td>
														<td>					
															<input type="text"  class="form-control input-sm mydate" onchange="this.form.submit()"  readonly="readonly" <%if(carstodate!=null){%>
													        	 value="<%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(carstodate))%>" <%}%>  value=""  id="carstodate" name="carstodate"  required="required"  > 							
														</td>
													</tr>
												</table>
										 	</div>
										</div>
										<input type="hidden" name="AllListTabId" value="3">
									</form>	
									<form action="" method="POST" id="circularForm">
					            		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					            		<div class="row w-98 m-10">
											<div class="col-md-12" >
												<div class="table-responsive text-left">
							                		<table class="table table-hover  table-striped table-condensed table-bordered table-fixed" id="rsqrTable" >
														<thead class="tab-bg">
															<tr>
											   					<th>SN</th>
											  					<th>Initiated By</th>
											   					<th>CARSNo</th>
											   					<th>Amount</th>
						                       					<th>Status</th>
						                       					<th>Action</th>
						                  					</tr>
														</thead>
						                 				<tbody>
						                      				<% 
						                      				   if(CARSFinalApprovedList!=null && CARSFinalApprovedList.size()>0){
						                      				   int SNA=0;
						                          			   for(Object[] form: CARSFinalApprovedList ){
						                       				%>
						                        			<tr>
						                            			<td class="width-5 text-center"><%=++SNA%></td>
						                            			<td class="width-20 text-left" ><%=form[9]!=null?StringEscapeUtils.escapeHtml4(form[9].toString()): " - "%> (<%=form[13]!=null?StringEscapeUtils.escapeHtml4(form[13].toString()): " - "%>), <%=form[14]!=null?StringEscapeUtils.escapeHtml4(form[14].toString()): " - "%></td>
						                            			<td class="width-15 text-center"><%=form[2]!=null?StringEscapeUtils.escapeHtml4(form[2].toString()): " - " %> </td>
						                            			<td class="width-10 text-right" ><%=form[15]!=null?StringEscapeUtils.escapeHtml4(form[15].toString()): " - " %> </td>
						                            			<td class="width-33 text-center" >
																	<button type="submit" class="btn btn-sm btn-link-1 w-50 btn-status fw-600 color-<%=form[11].toString().replace("#", "") %>" formaction="CARSTransStatus.htm" value="<%=form[0]%>" name="carsInitiationId"  data-toggle="tooltip" data-placement="top" title="Transaction History"  formtarget="_blank">
														    			<%=form[10]!=null?StringEscapeUtils.escapeHtml4(form[10].toString()): " - " %> <i class="fa fa-telegram mt-1 f-right" aria-hidden="true" ></i>
														    		</button>
												 				</td>
												 				<td class="width-15 text-center" >
						                            				<button type="submit" class="btn btn-sm view-icon fw-600" formaction="CARSDPCFinalReportDetails.htm" name="carsInitiationId" value="<%=form[0]%>" data-toggle="tooltip" data-placement="top" title="CARS-03 Details" >
														   				<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<img src="view/images/clipboard.png">
																				</figure>
																				<span>Details</span>
																			</div>
																		</div>
																	</button>
																	<%if(form[16]!=null && form[16].toString()!="0") {%>
						                            				<button type="submit" class="btn btn-sm view-icon fw-600" formaction="CARSOtherDocsList.htm" name="carsInitiationId" value="<%=form[0]%>" data-toggle="tooltip" data-placement="top" title="Other Documents Details" >
														   				<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<img src="view/images/multipledocs.png" class="w-30-px">
																				</figure>
																				<span>Other Docs</span>
																			</div>
																		</div>
																	</button>
																	<%} %>
																</td>
						                        			</tr>
						                       			<%} }else{%>
						                       				<tr>
						                       					<td colspan="6" class="text-center">No data available in table</td>
						                       				</tr>
						                       			<%} %>
						                   			    </tbody>
						                 		    </table>
							                	</div>
						                	</div>
						                </div>
						            </form>
								</div>
               					<div class="navigation_btn text-right">
            						<a class="btn btn-info btn-sm  shadow-nohover previous" >Previous</a>
									<button class="btn btn-info btn-sm next">Next</button>
								</div>
               			<%if(AllListTabId!=null&&AllListTabId.equalsIgnoreCase("3")){ %> 
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

$("#myTable").DataTable({
    "lengthMenu": [ 5,10,25,50,75,100],
    "pagingType": "simple"
});

$('#rsqrfromdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	/* "minDate" :datearray,   */
	 "startDate" : new Date('<%=rsqrfromdate%>'), 
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});
	
	
	$('#rsqrtodate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		"startDate" : new Date('<%=rsqrtodate%>'), 
		"minDate" :$("#rsqrfromdate").val(),  
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});

	 $(document).ready(function(){
		   $('#rsqrfromdate, #rsqrtodate').change(function(){
		       $('#myform').submit();
		    });
		}); 

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
	 
	 
	 $('#socfromdate').daterangepicker({
			"singleDatePicker" : true,
			"linkedCalendars" : false,
			"showCustomRangeLabel" : true,
			/* "minDate" :datearray,   */
			 "startDate" : new Date('<%=socfromdate%>'), 
			"cancelClass" : "btn-default",
			showDropdowns : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});
			
			
	 $('#soctodate').daterangepicker({
				"singleDatePicker" : true,
				"linkedCalendars" : false,
				"showCustomRangeLabel" : true,
				"startDate" : new Date('<%=soctodate%>'), 
				"minDate" :$("#socfromdate").val(),  
				"cancelClass" : "btn-default",
				showDropdowns : true,
				locale : {
					format : 'DD-MM-YYYY'
				}
		}); 
	 
	 $('#carsfromdate').daterangepicker({
			"singleDatePicker" : true,
			"linkedCalendars" : false,
			"showCustomRangeLabel" : true,
			/* "minDate" :datearray,   */
			 "startDate" : new Date('<%=carsfromdate%>'), 
			"cancelClass" : "btn-default",
			showDropdowns : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});
			
			
	 $('#carstodate').daterangepicker({
				"singleDatePicker" : true,
				"linkedCalendars" : false,
				"showCustomRangeLabel" : true,
				"startDate" : new Date('<%=carstodate%>'), 
				"minDate" :$("#carsfromdate").val(),  
				"cancelClass" : "btn-default",
				showDropdowns : true,
				locale : {
					format : 'DD-MM-YYYY'
				}
		}); 
	 
</script>

<script type="text/javascript">
function openCalendar(carsIniId){
	$('#myModal').modal('show');
	$('#carsInitiationId').val(carsIniId);
}

$(function () {
	$('[data-toggle="tooltip"]').tooltip()
});	

$(document).ready(function() {
    $('#rsqrTable').DataTable( {
    	 "paging":   false,
         "ordering": false,
         "info":     false
    } );
} );

</script>

<!-- Script tag for Initiation -->
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
</body>
</html>
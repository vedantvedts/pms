<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.text.SimpleDateFormat"%>
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

<spring:url value="/resources/css/projectModule/closureApprovals.css" var="closureApprovalsCss"/>
<link rel="stylesheet" type="text/css" href="${closureApprovalsCss}">
</head>
<body>
<%
List<Object[]> SoCPendingList =(List<Object[]>)request.getAttribute("SoCPendingList");
List<Object[]> SoCApprovedList =(List<Object[]>)request.getAttribute("SoCApprovedList");
List<Object[]> ACPPendingList =(List<Object[]>)request.getAttribute("ACPPendingList");
List<Object[]> ACPApprovedList =(List<Object[]>)request.getAttribute("ACPApprovedList");
List<Object[]> TechClosurePendingList=(List<Object[]>)request.getAttribute("TechClosurePendingList");
List<Object[]> TechClosureApprovedList=(List<Object[]>)request.getAttribute("TechClosureApprovedList");
List<Object[]> EmployeeList=(List<Object[]>)request.getAttribute("TotalEmployeeList");
List<Object[]>  LabList=(List<Object[]>)request.getAttribute("LabList");




String fromdate = (String)request.getAttribute("fromdate");
String todate   = (String)request.getAttribute("todate");

String tab   = (String)request.getAttribute("tab");

FormatConverter fc = new FormatConverter();
SimpleDateFormat sdf = fc.getSqlDateFormat();
SimpleDateFormat rdf = fc.getRegularDateFormat();
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
						<h4>Project Closure Approvals</h4>
					</div>
				</div>
				<div class="card-body">

					<div class="row w-100 mb10px">
						<div class="col-12">
         					<ul class="nav nav-pills mb-3 tablist-bgcolor" id="pills-tab" role="tablist">
		  						<li class="nav-item w-50">
		    						<div class="nav-link active text-center"s id="pills-mov-property-tab" data-toggle="pill" data-target="#pills-mov-property" role="tab" aria-controls="pills-mov-property" aria-selected="true">
			   							<span>Pending</span> 
										<span class="badge badge-danger badge-counter count-badge ml-0">
				   		 					<%if((SoCPendingList.size() + ACPPendingList.size() + TechClosurePendingList.size())>99 ){ %>
				   								99+
				   							<%}else{ %>
				   								<%=SoCPendingList.size() + ACPPendingList.size() + TechClosurePendingList.size() %>
											<%} %>			   			
				  						</span> 
		    						</div>
		  						</li>
		  						<li class="nav-item w-50">
		    						<div class="nav-link text-center" id="pills-imm-property-tab" data-toggle="pill" data-target="#pills-imm-property" role="tab" aria-controls="pills-imm-property" aria-selected="false">
		    	 						<span>Approved</span> 
		    	 						<span class="badge badge-danger badge-counter count-badge ml-0">
				   		 					<%if((SoCApprovedList.size() + ACPApprovedList.size() + TechClosureApprovedList.size())>99){ %>
				   								99+
				   							<%}else{ %>
				   								<%=SoCApprovedList.size() + ACPApprovedList.size()+TechClosureApprovedList.size()%>
											<%} %>			   			
				  						</span> 
		    						</div>
		  						</li>
							</ul>
	   					</div>
					</div>
	
					
					<div class="card">					
						<div class="card-body">
							<div class="container-fluid" >
           						<div class="tab-content" id="pills-tabContent">
           						
           							<!-- Pending List -->
            						<div class="tab-pane fade show active" id="pills-mov-property" role="tabpanel" aria-labelledby="pills-mov-property-tab">
		    							<form action="#" method="POST" id="">
            								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
             								<div class="table-responsive">
              									<table class="table table-hover  table-striped table-condensed table-bordered table-fixed" id="myTable">
													<thead>
														<tr>
					   										<th>SN</th>
					   										<th>Initiated By</th>
					   										<th>Project</th>
					   										<!-- <th>CARSNo</th> -->
					   										<th>Date</th>
					   										<th>Approval for</th>
                       										<th>Action</th>
                  										</tr>
													</thead>
                 									<tbody>
                 										<!-- Project Closure SoC Pending List -->
                       									<% int SN=0;
					   										if(SoCPendingList!=null && SoCPendingList.size()>0){
                         							 			for(Object[] form:SoCPendingList ){
                      							 		%>
                        									<tr>
                            									<td class="text-center width5per"><%=++SN%></td>
                            									<td class="width30per"><%=form[2]!=null?StringEscapeUtils.escapeHtml4(form[2].toString()): " - "%>, <%=form[3]!=null?StringEscapeUtils.escapeHtml4(form[3].toString()): " - "%> (<%=form[1]!=null?StringEscapeUtils.escapeHtml4(form[1].toString()): " - "%>)</td>
                            									<td class="text-center width10per"><%=form[8]!=null?StringEscapeUtils.escapeHtml4(form[8].toString()): " - "%> (<%=form[9]!=null?StringEscapeUtils.escapeHtml4(form[9].toString()): " - "%>)</td>
                            									<td class="text-center width10per"><%=fc.SqlToRegularDate(form[5].toString())%></td>
                            									<td class="text-center width10per"><%=form[7]!=null?StringEscapeUtils.escapeHtml4(form[7].toString()): " - "%></td>
                            									<td class="text-center width20per">
                            										
																	<button type="submit" class="btn btn-sm view-icon fw-600" formaction="ProjectClosureSoCDetails.htm" name="closureSoCApprovals" value="<%=form[4]%>/Y/2" data-toggle="tooltip" data-placement="top" title="Closure SoC">
								   										<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<img src="view/images/preview3.png">
																				</figure>
																				<span>Preview</span>
																			</div>
																		</div>
																	</button>
																				
																	<button type="submit" class="btn btn-sm" formaction="ProjectClosureSoCDownload.htm" name="closureId" value="<%=form[4]%>" formtarget="blank" formmethod="post" data-toggle="tooltip" data-placement="top" title="Download">
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
                       									
                       									<!-- Administrative Closure Pending List -->
                       									<% 
					   										if(ACPPendingList!=null && ACPPendingList.size()>0){
                         							 			for(Object[] form:ACPPendingList ){
                      							 		%>
                        									<tr>
                            									<td class="text-center width5per"><%=++SN%></td>
                            									<td class="width30per"><%=form[2]!=null?StringEscapeUtils.escapeHtml4(form[2].toString()): " - "%>, <%=form[3]!=null?StringEscapeUtils.escapeHtml4(form[3].toString()): " - "%> (<%=form[1]!=null?StringEscapeUtils.escapeHtml4(form[1].toString()): " - "%>)</td>
                            									<td class="text-center width10per"><%=form[8]!=null?StringEscapeUtils.escapeHtml4(form[8].toString()): " - "%> (<%=form[9]!=null?StringEscapeUtils.escapeHtml4(form[9].toString()): " - "%>)</td>
                            									<td class="text-center width10per"><%=fc.SqlToRegularDate(form[5].toString())%></td>
                            									<td class="text-center width10per"><%=form[7]!=null?StringEscapeUtils.escapeHtml4(form[7].toString()): " - "%></td>
                            									<td class="text-center width20per">
                            										
																	<button type="submit" class="btn btn-sm view-icon fw-600" formaction="ProjectClosureACPDetails.htm" name="closureACPApprovals" value="<%=form[4]%>/Y/2" data-toggle="tooltip" data-placement="top" title="Administrative Closure">
								   										<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<img src="view/images/preview3.png">
																				</figure>
																				<span>Preview</span>
																			</div>
																		</div>
																	</button>
																				
																	<button type="submit" class="btn btn-sm" formaction="ProjectClosureACPDownload.htm" name="closureId" value="<%=form[4]%>" formtarget="blank" formmethod="post" data-toggle="tooltip" data-placement="top" title="Download">
								  	 									<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<img src="view/images/document.png">
																				</figure>
																				<span>ACR</span>
																			</div>
																		</div>
																	</button>
																	
						 										</td>
                        									</tr>
                       									<%} }%>
                       									
                       									<!-- Technical Closure Report Pending List -->
                       									<% 
					   										if(TechClosurePendingList!=null && TechClosurePendingList.size()>0){
					   											
                         							 			for(Object[] form:TechClosurePendingList ){
                      							 		%>
                        									<tr>
                            									<td class="text-center width2per"><%=++SN%></td>
                            									<td class="width10per"><%=form[2]!=null?StringEscapeUtils.escapeHtml4(form[2].toString()): " - "%>, <%=form[3]!=null?StringEscapeUtils.escapeHtml4(form[3].toString()): " - "%> (<%=form[1]!=null?StringEscapeUtils.escapeHtml4(form[1].toString()): " - "%>)</td>
                            									<td class="text-center width5per"><%=form[8]!=null?StringEscapeUtils.escapeHtml4(form[8].toString()):" - "%> (<%=form[9]!=null?StringEscapeUtils.escapeHtml4(form[9].toString()): " - "%>)</td>
                            									<td class="text-center width5per"><%=fc.SqlToRegularDate(form[5].toString())%></td>
                            									<td class="text-center width5per"><%=form[7]!=null?StringEscapeUtils.escapeHtml4(form[7].toString()): " - "%></td>
                            									<td class="text-center width20per">
                            									
                            									
                            									
                            											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            											<div class="d-flex w-100">
                            												<div class="w-70">
                            													<textarea rows="2" cols="70" class="form-control width98per" name="remarks"  id="remarksarea" maxlength="2000" placeholder="Enter remarks here( max 250 characters )"></textarea>
                            												</div>
																			<div class="w-30">
																			<%if(form[12]!=null && form[12].toString().equalsIgnoreCase("TDG")) { %>
																			
																			      <button type="button" class="btn btn-sm btn-success mt-1 fw-500" name="Action" value="A"  onclick="OpenApproveModal('<%=form[10] %>','<%=form[4] %>')">
																						 Approve
								                                                   </button>
								                                                   
								                                                   
								                                                   
								                                                   <button type="button" class="btn btn-sm btn-danger mt-1 fw-500" name="Action" value="R"  onclick="OpenReturnModal('<%=form[10] %>','<%=form[4] %>')"
																					        > Return
																				</button>
																			
																			
																			<%}else{ %>
																				<button type="submit" class="btn btn-sm btn-success mt-1 fw-500" name="TechAndClosureId" value="<%=form[4]%>/<%=form[10]%>/A" formaction="projectTechClosureApprovalSubmit.htm" formmethod="GET" formnovalidate
																				 onclick="return confirm('Are You Sure To Recommend );">
																						 Recommend
								                                               </button>
								                                               
								                                               
								                                               <button type="submit" class="btn btn-sm btn-danger mt-1 fw-500" name="TechAndClosureId" value="<%=form[4]%>/<%=form[10]%>/R" formaction="projectTechClosureApprovalSubmit.htm" formmethod="GET" formnovalidate="formnovalidate"
																					onclick="return confirm('Are You Sure To Return');"> Return
																				</button>
								                                               
								                                               <%} %>
								                                               
																				
																			</div>
																			
																			
																			
																				<button type="submit" class="btn btn-sm fw-600" formaction="TechnicalClosureReportDownload.htm" formtarget="blank" name="TechAndClosureId" value="<%=form[4]%>/<%=form[10]%>" data-toggle="tooltip" data-placement="top" title="Download">
								   										            <i class="fa fa-download"></i>
								   									             </button> 
																				
																		</div>
																	
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
											<form method="post" action="ProjectClosureApprovals.htm" >
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
												<input type="hidden" name="tab" value="closed"/>
												<div class="row w-100 mt10px mb10px">
												<div class="col-md-12 float-right">
														<table class="float-right">
															<tr>
																<td> From Date :&nbsp; </td>
							        							<td> 
																	<input type="text" class="form-control input-sm mydate" onchange="this.form.submit()"  readonly="readonly"  <%if(fromdate!=null){%>
								        							  value="<%=fc.SqlToRegularDate(fromdate)%>" <%}%> value=""  id="fromdate" name="fromdate"  required="required"   > 
																</td>
																<td></td>
																<td >To Date :&nbsp;</td>
																<td>					
																	<input type="text"  class="form-control input-sm mydate" onchange="this.form.submit()"  readonly="readonly" <%if(todate!=null){%>
								        	 						  value="<%=fc.SqlToRegularDate(todate)%>" <%}%>  value=""  id="todate" name="todate"  required="required"  > 							
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
					   													<th>Project</th>
					   													<th >Approval for</th>
                       													<th >Status</th>
                       													<th >Action</th>
                  													</tr>
																</thead>
                 												<tbody>
                 													<!-- Project Closure SoC Approved List -->
                      												<%	int SNA=0;
                      													if(SoCApprovedList!=null && SoCApprovedList.size()>0) {
                          													for(Object[] form:SoCApprovedList ) {
                       												%>
                        											<tr>
                            											<td class="text-center width5per"><%=++SNA%></td>
                            											<td class="text-left width22per"><%=form[2]!=null?StringEscapeUtils.escapeHtml4(form[2].toString()): " - "%>, <%=form[3]!=null?StringEscapeUtils.escapeHtml4(form[3].toString()): " - "%> (<%=form[1]!=null?StringEscapeUtils.escapeHtml4(form[1].toString()): " - "%>)</td>
                            											<td class="text-center width10per"><%=form[13]!=null?StringEscapeUtils.escapeHtml4(form[13].toString()): " - "%> (<%=form[14]!=null?StringEscapeUtils.escapeHtml4(form[14].toString()): " - "%></td>
                            											<td class="text-center width8per"><%=form[12]!=null?StringEscapeUtils.escapeHtml4(form[12].toString()): " - " %> </td>
                            											<td class="text-center w-25">
                            											<%
																		   String colorCode = (String) form[9];
																		   String className = "C" + colorCode.replace("#", "").toUpperCase();
																		%>
                            												<button type="submit" class="btn btn-sm btn-link w-50 btn-status fw-600 <%=className%>" formaction="ProjectClosureSoCTransStatus.htm" value="<%=form[4] %>" name="closureId"  data-toggle="tooltip" data-placement="top" title="Transaction History" formtarget="_blank">
								    											<%=form[8]!=null?StringEscapeUtils.escapeHtml4(form[8].toString()): " - " %> <i class="fa fa-telegram flright-mt03" aria-hidden="true"></i>
								    										</button>
						 												</td>
						 												<td class="text-center width20per">
						 													<button type="submit" class="btn btn-sm view-icon fw-600" formaction="ProjectClosureSoCDetails.htm" name="closureSoCApprovals" value="<%=form[4]%>/N/2" data-toggle="tooltip" data-placement="top" title="Closure SoC">
								   												<div class="cc-rockmenu">
																					<div class="rolling">
																						<figure class="rolling_icon">
																							<img src="view/images/preview3.png">
																						</figure>
																						<span>Preview</span>
																					</div>
																				</div>
																			</button>
																					
																			<button type="submit" class="btn btn-sm" formaction="ProjectClosureSoCDownload.htm" name="closureId" value="<%=form[4]%>" formtarget="blank" formmethod="post" data-toggle="tooltip" data-placement="top" title="Download">
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
                       												
                       												<!-- Administrative Closure Approved List -->
                       												<%	
                      													if(ACPApprovedList!=null && ACPApprovedList.size()>0) {
                          													for(Object[] form:ACPApprovedList ) {
                       												%>
                        											<tr>
                            											<td class="text-center width22per"><%=++SNA%></td>
                            											<td class="text-left width22per"><%=form[2]!=null?StringEscapeUtils.escapeHtml4(form[2].toString()): " - "%>, <%=form[3]!=null?StringEscapeUtils.escapeHtml4(form[3].toString()): " - "%> (<%=form[1]!=null?StringEscapeUtils.escapeHtml4(form[1].toString()): " - "%>)</td>
                            											<td class="text-center width10per"><%=form[13]!=null?StringEscapeUtils.escapeHtml4(form[13].toString()): " - "%> (<%=form[14]!=null?StringEscapeUtils.escapeHtml4(form[14].toString()): " - "%>)</td>
                            											<td class="text-center width8per"><%=form[12]!=null?StringEscapeUtils.escapeHtml4(form[12].toString()): " - " %> </td>
                            											<td class="text-center w-25">
                            											<%
																		   String colorCode = (String) form[9];
																		   String className = "C" + colorCode.replace("#", "").toUpperCase();
																		%>
                            												<button type="submit" class="btn btn-sm btn-link w-50 btn-status fw-600 <%=className%>" formaction="ProjectClosureACPTransStatus.htm" value="<%=form[4] %>" name="closureId"  data-toggle="tooltip" data-placement="top" title="Transaction History" formtarget="_blank">
								    											<%=form[8]!=null?StringEscapeUtils.escapeHtml4(form[8].toString()): " - " %> <i class="fa fa-telegram flright-mt03" aria-hidden="true"></i>
								    										</button>
						 												</td>
						 												<td class="text-center width20per">
						 													<button type="submit" class="btn btn-sm view-icon fw-600" formaction="ProjectClosureACPDetails.htm" name="closureACPApprovals" value="<%=form[4]%>/N/2" data-toggle="tooltip" data-placement="top" title="Administrative Closure">
								   												<div class="cc-rockmenu">
																					<div class="rolling">
																						<figure class="rolling_icon">
																							<img src="view/images/preview3.png">
																						</figure>
																						<span>Preview</span>
																					</div>
																				</div>
																			</button>
																					
																			<button type="submit" class="btn btn-sm" formaction="ProjectClosureACPDownload.htm" name="closureId" value="<%=form[4]%>" formtarget="blank" formmethod="post" data-toggle="tooltip" data-placement="top" title="Download">
								  	 											<div class="cc-rockmenu">
																					<div class="rolling">
																						<figure class="rolling_icon">
																							<img src="view/images/document.png">
																						</figure>
																						<span>ACR</span>
																					</div>
																				</div>
																			</button>
						 												</td>
                        											</tr>
                       												<%} }%>
                       												
                       												<%---------------Technical Closure Report Approved List---------------------%>
                       												
                       												<%	
                      													if(TechClosureApprovedList!=null && TechClosureApprovedList.size()>0) {
                          													for(Object[] form:TechClosureApprovedList ) {
                       												%>
                        											<tr>
                            											<td class="text-center width5per"><%=++SNA%></td>
                            											<td class="text-left width22per"><%=form[2]!=null?StringEscapeUtils.escapeHtml4(form[2].toString()): " - "%>, <%=form[3]!=null?StringEscapeUtils.escapeHtml4(form[3].toString()): " - "%> (<%=form[1]!=null?StringEscapeUtils.escapeHtml4(form[1].toString()): " - "%>)</td>
                            											<td class="text-center width10per"><%=form[13]!=null?StringEscapeUtils.escapeHtml4(form[13].toString()): " - "%> (<%=form[14]!=null?StringEscapeUtils.escapeHtml4(form[14].toString()): " - "%>)</td>
                            											<td class="text-center width8per"><%=form[12]!=null?StringEscapeUtils.escapeHtml4(form[12].toString()): " - "%> </td>
                            											<td class="text-center w-25">
                            											<%
																		   String colorCode = (String) form[9];
																		   String className = "C" + colorCode.replace("#", "").toUpperCase();
																		%>
                            												<button form="tcrtrans" type="submit" class="btn btn-sm btn-link w-50 btn-status fw-600 <%=className%>" formaction="ProjectTechClosureTransStatus.htm" value="<%=form[15] %>" name="TechClosureId"  data-toggle="tooltip" data-placement="top" title="Transaction History" formtarget="_blank">
								    											<%=form[8]!=null?StringEscapeUtils.escapeHtml4(form[8].toString()): " - " %> <i class="fa fa-telegram flright-mt03" aria-hidden="true"></i>
								    										</button>
						 												</td>
						 												<td class="text-center width20per">
						 													<button type="submit" class="btn btn-sm fw-600" formaction="TechnicalClosureReportDownload.htm" formtarget="blank" name="TechAndClosureId" value="<%=form[4]%>/<%=form[15]%>" data-toggle="tooltip" data-placement="top" title="Download">
                                                                                         <i class="fa fa-download"></i>
								   									             </button> 	
																			
						 												</td>
                        											</tr>
                       												<%} }%>
                       												
                   												</tbody>
                 											</table>
                										</div> 
               										</form>
               										
               										<form action="#" id="tcrtrans"><input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/></form>
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


<div class="modal fade" id="ApprovalModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-jump" role="document">
    <div class="modal-content w-100">
      
        
           <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true" class="text-light red-color">&times;</span>
          </button>
      
      <div class="modal-body">
        <form action="projectTechClosureApprovalSubmit.htm" method="get" >
            <div class="row" >
		       <div class="col-md-8">
				<label class="control-label">Lab</label><span class="mandatory">*</span>
				<select class="form-control selectdee" id="LabCode" name="LabCode" onchange="LabcodeSubmit()" data-width="100%" data-live-search="true" required >
				       <option value="0" selected disabled >Select</option>
							<%if (LabList != null && LabList.size() > 0) {
								for (Object[] obj : LabList) { %>
								<option value=<%=obj[2].toString()%>><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%></option>
							<%}}%>
				        <option value="@EXP">Expert</option>
			     </select>
			 </div>  
			
			 <div class="col-md-7">
				<label class="control-label">Approval Officer</label><span class="mandatory">*</span>
				  <select class="form-control selectdee" id="approverEmpId" name="approverEmpId" data-width="100%" data-live-search="true" required>
						<option value="0" selected disabled >Select</option>
				</select>
			</div> 
			
			
			 <div class="col-md-7">
				<label class="control-label-datetype" ></label><span class="mandatory">*</span>
				<input type="text" class="form-control" id="approvalDate" name="approvalDate" readonly>
			</div>
		
			<div class="col-md-12" align="center">
			<br>
		         <button  type="submit" class="btn btn-sm submit" onclick="return confirm ('Are you sure to submit?')">SUBMIT</button>
		    </div>
		     
         </div>
         
          <input type="hidden" name="TechAndClosureId"  id="TechAndclosureId" value="" > 
          <input type="hidden" name="remarks"  id="remarks" value="">
         <!-- <input type="hidden" name="TechnicalClsoureId" id="TechClosureId" value="" >
         <input type="hidden" name="ClosureId" id="ClosureId" value="" >
         <input type="hidden" name="Action"  value="A" >  -->
         
      </form>
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
		<%-- "startDate" : new Date('<%=todate%>'),  --%>
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
	
	
	function OpenApproveModal(TechClosureId,ClosureId){
		
		$('#remarks').val($('#remarksarea').val()); 
		
		/* $('#TechClosureId').val(TechClosureId);
		$('#ClosureId').val(ClosureId); */
		var combinedValue = ClosureId + '/' + TechClosureId + '/A';
		$('#TechAndclosureId').val(combinedValue);
		$('.control-label-datetype').html('Approval Date');
		
		$('#ApprovalModal').modal('toggle');
	}
	
	function OpenReturnModal(TechClosureId,ClosureId){
		
		$('#remarks').val($('#remarksarea').val()); 
		/* $('#TechClosureId').val(TechClosureId);
		$('#ClosureId').val(ClosureId); */
		var combinedValue = ClosureId + '/' + TechClosureId + '/R';
		$('#TechAndclosureId').val(combinedValue);
		$('.control-label-datetype').html('Return Date');
		
		$('#ApprovalModal').modal('toggle');
	}
	
	
	
	function LabcodeSubmit() {
		   var LabCode = document.getElementById("LabCode").value;
		   $('#approverEmpId').empty();
		   $.ajax({
		       type: "GET",
		       url: "GetLabCodeEmpList.htm",
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
		                $('#approverEmpId').select2();
		                }else{
		                	for (var i = 0; i < result.length; i++) {
		                        var data = result[i];
		                        var optionValue = data[0];
		                        var optionText = data[1].trim() + ", " + data[3]; 
		                        var option = $("<option></option>").attr("value", optionValue).text(optionText);
		                        $('#approverEmpId').append(option); 
		                    }
		                    $('#approverEmpId').select2();
		                }
		            
		           }
		   });
		}
	
	
	$('#approvalDate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
	
	
</script>

</body>
</html>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<style type="text/css">
#button {
   float: left;
   width: 80%;
   padding: 5px;
   background: #dcdfe3;
   color: black;
   font-size: 17px;
   border:none;
   border-left: none;
   cursor: pointer;
}

th{
 text-align : center;
}

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
</style>
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
			<div class="card shadow-nohover">
				<div class="row card-header">
			   		<div class="col-md-6">
						<h4>Project Closure Approvals</h4>
					</div>
				</div>
				<div class="card-body">

					<div class="row w-100" style="margin-bottom: 10px;">
						<div class="col-12">
         					<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist" style="background-color: #E1E5E8;padding:0px;">
		  						<li class="nav-item" style="width: 50%;"  >
		    						<div class="nav-link active" style="text-align: center;" id="pills-mov-property-tab" data-toggle="pill" data-target="#pills-mov-property" role="tab" aria-controls="pills-mov-property" aria-selected="true">
			   							<span>Pending</span> 
										<span class="badge badge-danger badge-counter count-badge" style="margin-left: 0px;">
				   		 					<%if((SoCPendingList.size() + ACPPendingList.size() + TechClosurePendingList.size())>99 ){ %>
				   								99+
				   							<%}else{ %>
				   								<%=SoCPendingList.size() + ACPPendingList.size() + TechClosurePendingList.size() %>
											<%} %>			   			
				  						</span> 
		    						</div>
		  						</li>
		  						<li class="nav-item"  style="width: 50%;">
		    						<div class="nav-link" style="text-align: center;" id="pills-imm-property-tab" data-toggle="pill" data-target="#pills-imm-property" role="tab" aria-controls="pills-imm-property" aria-selected="false">
		    	 						<span>Approved</span> 
		    	 						<span class="badge badge-danger badge-counter count-badge" style="margin-left: 0px;">
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
					   										<th style="">SN</th>
					   										<th style="">Initiated By</th>
					   										<th>Project</th>
					   										<!-- <th>CARSNo</th> -->
					   										<th style="">Date</th>
					   										<th style="">Approval for</th>
                       										<th style="">Action</th>
                  										</tr>
													</thead>
                 									<tbody>
                 										<!-- Project Closure SoC Pending List -->
                       									<% int SN=0;
					   										if(SoCPendingList!=null && SoCPendingList.size()>0){
                         							 			for(Object[] form:SoCPendingList ){
                      							 		%>
                        									<tr>
                            									<td style="text-align: center;width: 5%;"><%=++SN%></td>
                            									<td style="width: 30%;"><%=form[2]+", "+form[3]+" ("+form[1]+")"%></td>
                            									<td style="text-align: center;width: 10%;"><%=form[8]+" ("+form[9]+")"%></td>
                            									<td style="text-align: center;width: 10%;"><%=fc.SqlToRegularDate(form[5].toString())%></td>
                            									<td style="text-align: center;width: 10%;"><%=form[7]%></td>
                            									<td style="text-align: center;width: 20%;">
                            										
																	<button type="submit" class="btn btn-sm view-icon" formaction="ProjectClosureSoCDetails.htm" name="closureSoCApprovals" value="<%=form[4]%>/Y/2" data-toggle="tooltip" data-placement="top" title="Closure SoC" style="font-weight: 600;" >
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
                            									<td style="text-align: center;width: 5%;"><%=++SN%></td>
                            									<td style="width: 30%;"><%=form[2]+", "+form[3]+" ("+form[1]+")"%></td>
                            									<td style="text-align: center;width: 10%;"><%=form[8]+" ("+form[9]+")"%></td>
                            									<td style="text-align: center;width: 10%;"><%=fc.SqlToRegularDate(form[5].toString())%></td>
                            									<td style="text-align: center;width: 10%;"><%=form[7]%></td>
                            									<td style="text-align: center;width: 20%;">
                            										
																	<button type="submit" class="btn btn-sm view-icon" formaction="ProjectClosureACPDetails.htm" name="closureACPApprovals" value="<%=form[4]%>/Y/2" data-toggle="tooltip" data-placement="top" title="Administrative Closure" style="font-weight: 600;" >
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
                            									<td style="text-align: center;width: 2%;"><%=++SN%></td>
                            									<td style="width: 10%;"><%=form[2]+", "+form[3]+" ("+form[1]+")"%></td>
                            									<td style="text-align: center;width: 5%;"><%=form[8]+" ("+form[9]+")"%></td>
                            									<td style="text-align: center;width: 5%;"><%=fc.SqlToRegularDate(form[5].toString())%></td>
                            									<td style="text-align: center;width: 5%;"><%=form[7]%></td>
                            									<td style="text-align: center;width: 20%;">
                            									
                            									
                            									
                            											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            											<div class="d-flex w-100">
                            												<div class="w-70">
                            													<textarea rows="2" cols="70" class="form-control" name="remarks"  id="remarksarea" maxlength="2000" placeholder="Enter remarks here( max 250 characters )" style="width:98%;"></textarea>
                            												</div>
																			<div class="w-30">
																			<%if(form[12]!=null && form[12].toString().equalsIgnoreCase("TDG")) { %>
																			
																			      <button type="button" class="btn btn-sm btn-success mt-1" name="Action" value="A"  onclick="OpenApproveModal('<%=form[10] %>','<%=form[4] %>')"
																				      style="font-weight: 500" >
																						 Approve
								                                                   </button>
								                                                   
								                                                   
								                                                   
								                                                   <button type="button" class="btn btn-sm btn-danger mt-1" name="Action" value="R"  onclick="OpenReturnModal('<%=form[10] %>','<%=form[4] %>')" style="font-weight: 500"
																					        > Return
																				</button>
																			
																			
																			<%}else{ %>
																				<button type="submit" class="btn btn-sm btn-success mt-1" name="TechAndClosureId" value="<%=form[4]%>/<%=form[10]%>/A" formaction="projectTechClosureApprovalSubmit.htm" formmethod="GET" formnovalidate
																				 style="font-weight: 500" onclick="return confirm('Are You Sure To Recommend );">
																						 Recommend
								                                               </button>
								                                               
								                                               
								                                               <button type="submit" class="btn btn-sm btn-danger mt-1" name="TechAndClosureId" value="<%=form[4]%>/<%=form[10]%>/R" formaction="projectTechClosureApprovalSubmit.htm" formmethod="GET" formnovalidate="formnovalidate" style="font-weight: 500"
																					onclick="return confirm('Are You Sure To Return');"> Return
																				</button>
								                                               
								                                               <%} %>
								                                               
																				
																			</div>
																			
																			
																			
																				<button type="submit" class="btn btn-sm" formaction="TechnicalClosureReportDownload.htm" formtarget="blank" name="TechAndClosureId" value="<%=form[4]%>/<%=form[10]%>" data-toggle="tooltip" data-placement="top" title="Download" style="font-weight: 600;" >
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
												<div class="row w-100" style="margin-top: 10px;margin-bottom: 10px;">
													<div class="col-md-12" style="float: right;">
														<table style="float: right;">
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
					   													<th style="">Approval for</th>
                       													<th style="width: ">Status</th>
                       													<th style="width: ">Action</th>
                  													</tr>
																</thead>
                 												<tbody>
                 													<!-- Project Closure SoC Approved List -->
                      												<%	int SNA=0;
                      													if(SoCApprovedList!=null && SoCApprovedList.size()>0) {
                          													for(Object[] form:SoCApprovedList ) {
                       												%>
                        											<tr>
                            											<td style="text-align: center;width: 5%;"><%=++SNA%></td>
                            											<td style="text-align: left;width: 22%;"><%=form[2]+", "+form[3]+" ("+form[1]+")"%></td>
                            											<%-- <td style="text-align: center;width: 5%;"><%=form[1] %> </td> --%>
                            											<td style="text-align: center;width: 10%;"><%=form[13]+" ("+form[14]+")"%></td>
                            											<td style="text-align: center;width: 8%;"><%=form[12] %> </td>
                            											<td style="text-align: center;width: 25%;">
                            												<button type="submit" class="btn btn-sm btn-link w-50 btn-status" formaction="ProjectClosureSoCTransStatus.htm" value="<%=form[4] %>" name="closureId"  data-toggle="tooltip" data-placement="top" title="Transaction History" style=" color: <%=form[9] %>; font-weight: 600;" formtarget="_blank">
								    											<%=form[8] %> <i class="fa fa-telegram" aria-hidden="true" style="float: right;margin-top: 0.3rem;"></i>
								    										</button>
						 												</td>
						 												<td style="text-align: center;width: 20%;">
						 													<button type="submit" class="btn btn-sm view-icon" formaction="ProjectClosureSoCDetails.htm" name="closureSoCApprovals" value="<%=form[4]%>/N/2" data-toggle="tooltip" data-placement="top" title="Closure SoC" style="font-weight: 600;" >
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
                            											<td style="text-align: center;width: 5%;"><%=++SNA%></td>
                            											<td style="text-align: left;width: 22%;"><%=form[2]+", "+form[3]+" ("+form[1]+")"%></td>
                            											<%-- <td style="text-align: center;width: 5%;"><%=form[1] %> </td> --%>
                            											<td style="text-align: center;width: 10%;"><%=form[13]+" ("+form[14]+")"%></td>
                            											<td style="text-align: center;width: 8%;"><%=form[12] %> </td>
                            											<td style="text-align: center;width: 25%;">
                            												<button type="submit" class="btn btn-sm btn-link w-50 btn-status" formaction="ProjectClosureACPTransStatus.htm" value="<%=form[4] %>" name="closureId"  data-toggle="tooltip" data-placement="top" title="Transaction History" style=" color: <%=form[9] %>; font-weight: 600;" formtarget="_blank">
								    											<%=form[8] %> <i class="fa fa-telegram" aria-hidden="true" style="float: right;margin-top: 0.3rem;"></i>
								    										</button>
						 												</td>
						 												<td style="text-align: center;width: 20%;">
						 													<button type="submit" class="btn btn-sm view-icon" formaction="ProjectClosureACPDetails.htm" name="closureACPApprovals" value="<%=form[4]%>/N/2" data-toggle="tooltip" data-placement="top" title="Administrative Closure" style="font-weight: 600;" >
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
                            											<td style="text-align: center;width: 5%;"><%=++SNA%></td>
                            											<td style="text-align: left;width: 22%;"><%=form[2]+", "+form[3]+" ("+form[1]+")"%></td>
                            											<%-- <td style="text-align: center;width: 5%;"><%=form[1] %> </td> --%>
                            											<td style="text-align: center;width: 10%;"><%=form[13]+" ("+form[14]+")"%></td>
                            											<td style="text-align: center;width: 8%;"><%=form[12] %> </td>
                            											<td style="text-align: center;width: 25%;">
                            												<button form="tcrtrans" type="submit" class="btn btn-sm btn-link w-50 btn-status" formaction="ProjectTechClosureTransStatus.htm" value="<%=form[15] %>" name="TechClosureId"  data-toggle="tooltip" data-placement="top" title="Transaction History" style=" color: <%=form[9] %>; font-weight: 600;" formtarget="_blank">
								    											<%=form[8] %> <i class="fa fa-telegram" aria-hidden="true" style="float: right;margin-top: 0.3rem;"></i>
								    										</button>
						 												</td>
						 												<td style="text-align: center;width: 20%;">
						 													<button type="submit" class="btn btn-sm" formaction="TechnicalClosureReportDownload.htm" formtarget="blank" name="TechAndClosureId" value="<%=form[4]%>/<%=form[15]%>" data-toggle="tooltip" data-placement="top" title="Download" style="font-weight: 600;" >
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
    <div class="modal-content" style="width:100%;">
      
        
           <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true" class="text-light" style="color:red;">&times;</span>
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
								<option value=<%=obj[2].toString()%>><%=obj[2].toString()%></option>
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
<%@page import="org.apache.commons.text.StringEscapeUtils"%>
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

.left {
	text-align: left;
}
.center{
	text-align: center;
}
.right{
	text-align: right;
}
</style>
</head>
<body>
<%
List<Object[]> reqPendingList = (List<Object[]>)request.getAttribute("reqPendingList");
List<Object[]> reqApprovedList = (List<Object[]>)request.getAttribute("reqApprovedList");
List<Object[]> testPlanPendingList = (List<Object[]>)request.getAttribute("testPlanPendingList");
List<Object[]> testPlanApprovedList = (List<Object[]>)request.getAttribute("testPlanApprovedList");
List<Object[]> specificationPendingList = (List<Object[]>)request.getAttribute("specificationPendingList");
List<Object[]> specificationApprovedList = (List<Object[]>)request.getAttribute("specificationApprovedList");
List<Object[]> igiDocPendingList = (List<Object[]>)request.getAttribute("igiDocPendingList");
List<Object[]> igiDocApprovedList = (List<Object[]>)request.getAttribute("igiDocApprovedList");
List<Object[]> icdDocPendingList = (List<Object[]>)request.getAttribute("icdDocPendingList");
List<Object[]> icdDocApprovedList = (List<Object[]>)request.getAttribute("icdDocApprovedList");
List<Object[]> irsDocPendingList = (List<Object[]>)request.getAttribute("irsDocPendingList");
List<Object[]> irsDocApprovedList = (List<Object[]>)request.getAttribute("irsDocApprovedList");
List<Object[]> iddDocPendingList = (List<Object[]>)request.getAttribute("iddDocPendingList");
List<Object[]> iddDocApprovedList = (List<Object[]>)request.getAttribute("iddDocApprovedList");

int pendingListSize = (reqPendingList!=null && reqPendingList.size()>0? reqPendingList.size(): 0)
						+ (testPlanPendingList!=null && testPlanPendingList.size()>0? testPlanPendingList.size(): 0)
						+ (specificationPendingList!=null && specificationPendingList.size()>0? specificationPendingList.size(): 0)
						+ (igiDocPendingList!=null && igiDocPendingList.size()>0? igiDocPendingList.size(): 0)
						+ (icdDocPendingList!=null && icdDocPendingList.size()>0? icdDocPendingList.size(): 0) 
						+ (irsDocPendingList!=null && irsDocPendingList.size()>0? irsDocPendingList.size(): 0)
						+ (iddDocPendingList!=null && iddDocPendingList.size()>0? iddDocPendingList.size(): 0) ;

int approvedListSize = (reqApprovedList!=null && reqApprovedList.size()>0? reqApprovedList.size(): 0)
						+ (testPlanApprovedList!=null && testPlanApprovedList.size()>0? testPlanApprovedList.size(): 0)
						+ (specificationApprovedList!=null && specificationApprovedList.size()>0? specificationApprovedList.size(): 0)
						+ (igiDocApprovedList!=null && igiDocApprovedList.size()>0? igiDocApprovedList.size(): 0)
						+ (icdDocApprovedList!=null && icdDocApprovedList.size()>0? icdDocApprovedList.size(): 0) 
						+ (irsDocApprovedList!=null && irsDocApprovedList.size()>0? irsDocApprovedList.size(): 0) 
						+ (iddDocApprovedList!=null && iddDocApprovedList.size()>0? iddDocApprovedList.size(): 0) ;

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
						<h4>Document Approvals</h4>
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
				   		 					<%if(pendingListSize>99){ %>
				   								99+
				   							<%}else{ %>
				   								<%=pendingListSize %>
											<%} %>			   			
				  						</span> 
		    						</div>
		  						</li>
		  						<li class="nav-item"  style="width: 50%;">
		    						<div class="nav-link" style="text-align: center;" id="pills-imm-property-tab" data-toggle="pill" data-target="#pills-imm-property" role="tab" aria-controls="pills-imm-property" aria-selected="false">
		    	 						<span>Approved</span> 
		    	 						<span class="badge badge-danger badge-counter count-badge" style="margin-left: 0px;">
				   		 					<%if(approvedListSize>99){ %>
				   								99+
				   							<%}else{ %>
				   								<%=approvedListSize %>
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
		    							<%-- <form action="#" method="POST" id="">
            								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>
             								<div class="table-responsive">
              									<table class="table table-hover  table-striped table-condensed table-bordered table-fixed" id="myTable">
													<thead>
														<tr>
					   										<th width="3%">SN</th>
					   										<th width="18%">Initiated By</th>
					   										<th width="15%">Project</th>
					   										<th width="8%">Date</th>
					   										<th width="10%">Approval for</th>
                       										<th width="10%">Attachment</th>
                       										<th width="36%">Action</th>
                  										</tr>
													</thead>
                 									<tbody>
                 										<!-- Requirement Document Pending List -->
                       									<% int SN=0;
					   										if(reqPendingList!=null && reqPendingList.size()>0){
                         							 			for(Object[] form:reqPendingList ){
                      							 		%>
                        									<tr>
                            									<td class="center"><%=++SN%></td>
                            									<td ><%=form[2]!=null?StringEscapeUtils.escapeHtml4(form[2].toString()): " - "+", "+form[3]!=null?StringEscapeUtils.escapeHtml4(form[3].toString()): " - "%></td>
                            									<td class="center">
                            										<%=form[11]!=null?StringEscapeUtils.escapeHtml4(form[11].toString()):form[12]!=null?StringEscapeUtils.escapeHtml4(form[12].toString()): " - " %>
                            										<%if(form[13]!=null) {%>
                            											(<%=StringEscapeUtils.escapeHtml4(form[13].toString())%>)
                            										<%} %>
                            									</td>
                            									<td class="center"><%=form[5]!=null?fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(form[5].toString())):" - "%></td>
                            									<td class="center"><%=form[6]!=null?StringEscapeUtils.escapeHtml4(form[6].toString()): " - "%></td>
                            									<td class="center"> 
                            										<form action="#" id="pendingform_status_<%=SN%>">
																		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
																		<input type="hidden" name="reqInitiationId" value="<%=form[4]%>"> 
																		<span id="downloadform">
																			<button type="submit" class="btn btn-sm" formnovalidate="formnovalidate" formmethod="GET" formtarget="_blank" formaction="RequirementDocumentDownlodPdf.htm"
																				data-toggle="tooltip" data-placement="top" title="" data-original-title="Requirement Document">
																				&emsp;<i class="fa fa-download fa-lg" aria-hidden="true"></i>
																			</button>
																		</span>
																	</form>
                            									</td>
                            									<td class="center">
                            										<form action="ProjectRequirementApprovalSubmit.htm" id="pendingform_action_<%=SN%>">
                            											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            											<input type="hidden" name="reqInitiationId" value="<%=form[4]%>"> 
                            											<div class="d-flex ">
                            												<div class="">
                            													<textarea rows="2" cols="52" class="form-control" name="remarks" maxlength="1000" placeholder="Enter remarks here( max 1000 characters )" required></textarea>
                            												</div>
																			<div class="ml-2" align="right">
																				<button class="btn btn-sm btn-success mt-1" name="Action" value="A" formmethod="GET" formnovalidate="formnovalidate"
																					style="font-weight: 500" onclick="return confirm('Are You Sure To Forward this Project Document?');">
																					<%if (form[14].toString().equalsIgnoreCase("RFW")) {%>
																						Forward
																					<%} else {%>
																						Approve
																					<%}%>
																				</button>
																				<button class="btn btn-sm btn-danger mt-1" name="Action" value="R" formmethod="GET" style="font-weight: 500"
																					onclick="return confirm('Are You Sure To return this Project Document?');">
																					Return
																				</button>
																			</div>
																		</div>
																	</form>
																	<%-- <button type="submit" class="btn btn-sm view-icon" formaction="ProjectClosureSoCDetails.htm" name="closureSoCApprovals" value="<%=form[4]%>/Y/2" data-toggle="tooltip" data-placement="top" title="Closure SoC" style="font-weight: 600;" >
								   										<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<img src="view/images/preview3.png">
																				</figure>
																				<span>Preview</span>
																			</div>
																		</div>
																	</button> --%>
																				
																	<%-- <button type="submit" class="btn btn-sm" formaction="ProjectClosureSoCDownload.htm" name="closureId" value="<%=form[4]%>" formtarget="blank" formmethod="post" data-toggle="tooltip" data-placement="top" title="Download">
								  	 									<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<img src="view/images/document.png">
																				</figure>
																				<span>SoC</span>
																			</div>
																		</div>
																	</button> --%>
																	
						 										</td>
                        									</tr>
                       									<%} }%>
                       									<!-- Requirement Document Pending List End -->
                       									
                 										<!-- Test Plan Document Pending List -->
                       									<% 
					   										if(testPlanPendingList!=null && testPlanPendingList.size()>0){
                         							 			for(Object[] form:testPlanPendingList ){
                      							 		%>
                        									<tr>
                            									<td class="center"><%=++SN%></td>
                            									<td ><%=form[2]!=null?StringEscapeUtils.escapeHtml4(form[2].toString()): " - "+", "+form[3]!=null?StringEscapeUtils.escapeHtml4(form[3].toString()): " - "%></td>
                            									<td class="center">
                            										<%=form[11]!=null?StringEscapeUtils.escapeHtml4(form[11].toString()):form[12]!=null?StringEscapeUtils.escapeHtml4(form[12].toString()): " - " %>
                            										<%if(form[13]!=null) {%>
                            											(<%=StringEscapeUtils.escapeHtml4(form[13].toString())%>)
                            										<%} %>
                            									</td>
                            									<td class="center"><%=form[5]!=null?fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(form[5].toString())):" - "%></td>
                            									<td class="center"><%=form[6]!=null?StringEscapeUtils.escapeHtml4(form[6].toString()): " - "%></td>
                            									<td class="center"> 
                            										<form action="#" id="pendingform_status_<%=SN%>">
																		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
																		<input type="hidden" name="testPlanInitiationId" value="<%=form[4]%>"> 
																		<span id="downloadform">
																			<button type="submit" class="btn btn-sm" formnovalidate="formnovalidate" formmethod="GET" formtarget="_blank" formaction="TestPlanDownlodPdf.htm"
																				data-toggle="tooltip" data-placement="top" title="" data-original-title="Test Plan Document">
																				&emsp;<i class="fa fa-download fa-lg" aria-hidden="true"></i>
																			</button>
																		</span>
																	</form>
                            									</td>
                            									<td class="center">
                            										<form action="ProjectTestPlanApprovalSubmit.htm" id="pendingform_action_<%=SN%>">
                            											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            											<input type="hidden" name="testPlanInitiationId" value="<%=form[4]%>"> 
                            											<div class="d-flex ">
                            												<div class="">
                            													<textarea rows="2" cols="52" class="form-control" name="remarks" maxlength="1000" placeholder="Enter remarks here( max 1000 characters )" required></textarea>
                            												</div>
																			<div class="ml-2" align="right">
																				<button class="btn btn-sm btn-success mt-1" name="Action" value="A" formmethod="GET" formnovalidate="formnovalidate"
																					style="font-weight: 500" onclick="return confirm('Are You Sure To Forward this Project Document?');">
																					<%if (form[14].toString().equalsIgnoreCase("RFW")) {%>
																						Forward
																					<%} else {%>
																						Approve
																					<%}%>
																				</button>
																				<button class="btn btn-sm btn-danger mt-1" name="Action" value="R" formmethod="GET" style="font-weight: 500"
																					onclick="return confirm('Are You Sure To return this Project Document?');">
																					Return
																				</button>
																			</div>
																		</div>
																	</form>
																
																	
						 										</td>
                        									</tr>
                       									<%} }%>
                       									<!-- Test Plan Document Pending List End -->
                       									
                       									<!-- Specification Document Pending List  -->
                       									<% 
					   										if(specificationPendingList!=null && specificationPendingList.size()>0){
                         							 			for(Object[] form : specificationPendingList ){
                      							 		%>
                        									<tr>
                            									<td class="center"><%=++SN%></td>
                            									<td ><%=form[2]!=null?StringEscapeUtils.escapeHtml4(form[2].toString()): " - "+", "+form[3]!=null?StringEscapeUtils.escapeHtml4(form[3].toString()): " - "%></td>
                            									<td class="center">
                            										<%=form[11]!=null?StringEscapeUtils.escapeHtml4(form[11].toString()):form[12]!=null?StringEscapeUtils.escapeHtml4(form[12].toString()): " - " %>
                            										<%if(form[13]!=null) {%>
                            											(<%=StringEscapeUtils.escapeHtml4(form[13].toString())%>)
                            										<%} %>
                            									</td>
                            									<td class="center"><%=form[5]!=null?fc.SqlToRegularDate(form[5].toString()):" - "%></td>
                            									<td class="center"><%=form[6]!=null?StringEscapeUtils.escapeHtml4(form[6].toString()): " - "%></td>
                            									<td class="center"> 
                            										<form action="#" id="pendingform_status_<%=SN%>">
																		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
																		<input type="hidden" name="SpecsInitiationId" value="<%=form[4]%>"> 
																		<span id="downloadform">
																			<button type="submit" class="btn btn-sm bg-transparent" formnovalidate="formnovalidate" formmethod="GET" formtarget="_blank" formaction="SpecificationdPdf.htm"
																				data-toggle="tooltip" data-placement="top" title="" data-original-title="Specification Document">
																				&emsp;<i class="fa fa-download fa-lg" aria-hidden="true"></i>
																			</button>
																		</span>
																	</form>
                            									</td>
                            									<td class="center">
                            										<form action="SpecificationApproval.htm" id="pendingform_action_<%=SN%>">
                            											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            											<input type="hidden" name="SpecsInitiationId" value="<%=form[4]%>"> 
                            											<div class="d-flex ">
                            												<div class="">
                            													<textarea rows="2" cols="52" class="form-control" name="remarks" maxlength="1000" placeholder="Enter remarks here( max 1000 characters )" required></textarea>
                            												</div>
																			<div class="ml-2" align="right">
																				<button class="btn btn-sm btn-success mt-1" name="Action" value="A" formmethod="GET" formnovalidate="formnovalidate"
																					style="font-weight: 500" onclick="return confirm('Are You Sure To Forward this Project Document?');">
																					<%if (form[14].toString().equalsIgnoreCase("RFW")) {%>
																						Forward
																					<%} else {%>
																						Approve
																					<%}%>
																				</button>
																				<button class="btn btn-sm btn-danger mt-1" name="Action" value="R" formmethod="GET" style="font-weight: 500"
																					onclick="return confirm('Are You Sure To return this Project Document?');">
																					Return
																				</button>
																			</div>
																		</div>
																	</form>
																
																	
						 										</td>
                        									</tr>
                       									<%} }%>
                       									<!-- Specification Document Pending List End -->
                       									
                       									<!-- IGI Document Pending List -->
                       									<% 
					   										if(igiDocPendingList!=null && igiDocPendingList.size()>0){
                         							 			for(Object[] form : igiDocPendingList ){
                      							 		%>
                        									<tr>
                            									<td class="center"><%=++SN%></td>
                            									<td ><%=form[2]!=null?StringEscapeUtils.escapeHtml4(form[2].toString()): " - "+", "+form[3]!=null?StringEscapeUtils.escapeHtml4(form[3].toString()): " - "%></td>
                            									<td class="center">
                            										For Lab
                            									</td>
																<td class="center"><%=form[5]!=null?fc.SqlToRegularDate(form[5].toString()):" - "%></td>
                            									<td class="center"><%=form[6]!=null?StringEscapeUtils.escapeHtml4(form[6].toString()): " - "%></td>
                            									<td class="center"> 
                            										<form action="#" id="pendingform_status_<%=SN%>">
																		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
																		<input type="hidden" name="igiDocId" value="<%=form[4]%>"> 
																		<input type="hidden" name="isPdf" value="Y"> 
																		<span id="downloadform">
																			<button type="submit" class="btn btn-sm bg-transparent" formnovalidate="formnovalidate" formmethod="GET" formtarget="_blank" formaction="IGIDocumentDetails.htm"
																				data-toggle="tooltip" data-placement="top" title="" data-original-title="IGI Document">
																				&emsp;<i class="fa fa-download fa-lg" aria-hidden="true"></i>
																			</button>
																		</span>
																	</form>
                            									</td>
                            									<td class="center">
                            										<form action="IGIDocumentApprovalSubmit.htm" id="pendingform_action_<%=SN%>">
                            											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            											<input type="hidden" name="docId" value="<%=form[4]%>"> 
                            											<input type="hidden" name="docType" value="A"> 
                            											<div class="d-flex ">
                            												<div class="">
                            													<textarea rows="2" cols="52" class="form-control" name="remarks" maxlength="1000" placeholder="Enter remarks here( max 1000 characters )" required></textarea>
                            												</div>
																			<div class="ml-2" align="right">
																				<button class="btn btn-sm btn-success mt-1" name="Action" value="A" formmethod="GET" formnovalidate="formnovalidate"
																					style="font-weight: 500" onclick="return confirm('Are You Sure To Forward this IGI Document?');">
																					<%if (form[8].toString().equalsIgnoreCase("RFW")) {%>
																						Forward
																					<%} else {%>
																						Approve
																					<%}%>
																				</button>
																				<button class="btn btn-sm btn-danger mt-1" name="Action" value="R" formmethod="GET" style="font-weight: 500"
																					onclick="return confirm('Are You Sure To return this IGI Document?');">
																					Return
																				</button>
																			</div>
																		</div>
																	</form>
																
																	
						 										</td>
                        									</tr>
                       									<%} }%>
                       									<!-- IGI Document Pending List End-->
                       									
                       									<!-- ICD Document Pending List -->
                       									<% 
					   										if(icdDocPendingList!=null && icdDocPendingList.size()>0){
                         							 			for(Object[] form : icdDocPendingList ){
                      							 		%>
                        									<tr>
                            									<td class="center"><%=++SN%></td>
                            									<td ><%=form[2]!=null?StringEscapeUtils.escapeHtml4(form[2].toString()): " - "+", "+form[3]!=null?StringEscapeUtils.escapeHtml4(form[3].toString()): " - "%></td>
                            									<td class="center">
                            										<%=form[11]!=null?StringEscapeUtils.escapeHtml4(form[11].toString()):form[10]!=null?StringEscapeUtils.escapeHtml4(form[10].toString()): " - " %>
                            									</td>
                            									<td class="center"><%=form[5]!=null?fc.SqlToRegularDate(form[5].toString()):" - "%></td>
                            									<td class="center"><%=form[6]!=null?StringEscapeUtils.escapeHtml4(form[6].toString()): " - "%></td>
                            									<td class="center"> 
                            										<form action="#" id="pendingform_status_<%=SN%>">
																		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
																		<input type="hidden" name="icdDocId" value="<%=form[4]%>"> 
																		<input type="hidden" name="isPdf" value="Y"> 
																		<span id="downloadform">
																			<button type="submit" class="btn btn-sm bg-transparent" formnovalidate="formnovalidate" formmethod="GET" formtarget="_blank" formaction="ICDDocumentDetails.htm"
																				data-toggle="tooltip" data-placement="top" title="" data-original-title="ICD Document">
																				&emsp;<i class="fa fa-download fa-lg" aria-hidden="true"></i>
																			</button>
																		</span>
																	</form>
                            									</td>
                            									<td class="center">
                            										<form action="ICDDocumentApprovalSubmit.htm" id="pendingform_action_<%=SN%>">
                            											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            											<input type="hidden" name="docId" value="<%=form[4]%>"> 
                            											<input type="hidden" name="docType" value="B"> 
                            											<div class="d-flex ">
                            												<div class="">
                            													<textarea rows="2" cols="52" class="form-control" name="remarks" maxlength="1000" placeholder="Enter remarks here( max 1000 characters )" required></textarea>
                            												</div>
																			<div class="ml-2" align="right">
																				<button class="btn btn-sm btn-success mt-1" name="Action" value="A" formmethod="GET" formnovalidate="formnovalidate"
																					style="font-weight: 500" onclick="return confirm('Are You Sure To Forward this ICD Document?');">
																					<%if (form[12].toString().equalsIgnoreCase("RFW")) {%>
																						Forward
																					<%} else {%>
																						Approve
																					<%}%>
																				</button>
																				<button class="btn btn-sm btn-danger mt-1" name="Action" value="R" formmethod="GET" style="font-weight: 500"
																					onclick="return confirm('Are You Sure To return this ICD Document?');">
																					Return
																				</button>
																			</div>
																		</div>
																	</form>
						 										</td>
                        									</tr>
                       									<%} }%>
                       									<!-- ICD Document Pending List End -->
                       									
                       									<!-- IRS Document Pending List -->
                       									<% 
					   										if(irsDocPendingList!=null && irsDocPendingList.size()>0){
                         							 			for(Object[] form : irsDocPendingList ){
                      							 		%>
                        									<tr>
                            									<td class="center"><%=++SN%></td>
                            									<td ><%=form[2]!=null?StringEscapeUtils.escapeHtml4(form[2].toString()): " - "+", "+form[3]!=null?StringEscapeUtils.escapeHtml4(form[3].toString()): " - "%></td>
                            									<td class="center">
                            										<%=form[11]!=null?StringEscapeUtils.escapeHtml4(form[11].toString()):form[10]!=null?StringEscapeUtils.escapeHtml4(form[10].toString()): " - " %>
                            									</td>
                            									<td class="center"><%=form[5]!=null?fc.SqlToRegularDate(form[5].toString()):" - "%></td>
                            									<td class="center"><%=form[6]!=null?StringEscapeUtils.escapeHtml4(form[6].toString()): " - "%></td>
                            									<td class="center"> 
                            										<form action="#" id="pendingform_status_<%=SN%>">
																		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
																		<input type="hidden" name="irsDocId" value="<%=form[4]%>"> 
																		<input type="hidden" name="isPdf" value="Y"> 
																		<span id="downloadform">
																			<button type="submit" class="btn btn-sm bg-transparent" formnovalidate="formnovalidate" formmethod="GET" formtarget="_blank" formaction="IRSDocumentDetails.htm"
																				data-toggle="tooltip" data-placement="top" title="" data-original-title="IRS Document">
																				&emsp;<i class="fa fa-download fa-lg" aria-hidden="true"></i>
																			</button>
																		</span>
																	</form>
                            									</td>
                            									<td class="center">
                            										<form action="IRSDocumentApprovalSubmit.htm" id="pendingform_action_<%=SN%>">
                            											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            											<input type="hidden" name="docId" value="<%=form[4]%>"> 
                            											<input type="hidden" name="docType" value="C"> 
                            											<div class="d-flex ">
                            												<div class="">
                            													<textarea rows="2" cols="52" class="form-control" name="remarks" maxlength="1000" placeholder="Enter remarks here( max 1000 characters )" required></textarea>
                            												</div>
																			<div class="ml-2" align="right">
																				<button class="btn btn-sm btn-success mt-1" name="Action" value="A" formmethod="GET" formnovalidate="formnovalidate"
																					style="font-weight: 500" onclick="return confirm('Are You Sure To Forward this IRS Document?');">
																					<%if (form[12].toString().equalsIgnoreCase("RFW")) {%>
																						Forward
																					<%} else {%>
																						Approve
																					<%}%>
																				</button>
																				<button class="btn btn-sm btn-danger mt-1" name="Action" value="R" formmethod="GET" style="font-weight: 500"
																					onclick="return confirm('Are You Sure To return this IRS Document?');">
																					Return
																				</button>
																			</div>
																		</div>
																	</form>
						 										</td>
                        									</tr>
                       									<%} }%>
                       									<!-- IRS Document Pending List End -->
                       									
                       									<!-- IDD Document Pending List -->
                       									<% 
					   										if(iddDocPendingList!=null && iddDocPendingList.size()>0){
                         							 			for(Object[] form : iddDocPendingList ){
                      							 		%>
                        									<tr>
                            									<td class="center"><%=++SN%></td>
                            									<td ><%=form[2]!=null?StringEscapeUtils.escapeHtml4(form[2].toString()): " - "+", "+form[3]!=null?StringEscapeUtils.escapeHtml4(form[3].toString()): " - "%></td>
                            									<td class="center">
                            										<%=form[11]!=null?StringEscapeUtils.escapeHtml4(form[11].toString()):form[10]!=null?StringEscapeUtils.escapeHtml4(form[10].toString()): " - " %>
                            									</td>
                            									<td class="center"><%=form[5]!=null?fc.SqlToRegularDate(form[5].toString()):" - "%></td>
                            									<td class="center"><%=form[6]!=null?StringEscapeUtils.escapeHtml4(form[6].toString()): " - "%></td>
                            									<td class="center"> 
                            										<form action="#" id="pendingform_status_<%=SN%>">
																		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
																		<input type="hidden" name="iddDocId" value="<%=form[4]%>"> 
																		<input type="hidden" name="isPdf" value="Y"> 
																		<span id="downloadform">
																			<button type="submit" class="btn btn-sm bg-transparent" formnovalidate="formnovalidate" formmethod="GET" formtarget="_blank" formaction="IDDDocumentDetails.htm"
																				data-toggle="tooltip" data-placement="top" title="" data-original-title="IDD Document">
																				&emsp;<i class="fa fa-download fa-lg" aria-hidden="true"></i>
																			</button>
																		</span>
																	</form>
                            									</td>
                            									<td class="center">
                            										<form action="IDDDocumentApprovalSubmit.htm" id="pendingform_action_<%=SN%>">
                            											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            											<input type="hidden" name="docId" value="<%=form[4]%>"> 
                            											<input type="hidden" name="docType" value="D"> 
                            											<div class="d-flex ">
                            												<div class="">
                            													<textarea rows="2" cols="52" class="form-control" name="remarks" maxlength="1000" placeholder="Enter remarks here( max 1000 characters )" required></textarea>
                            												</div>
																			<div class="ml-2" align="right">
																				<button class="btn btn-sm btn-success mt-1" name="Action" value="A" formmethod="GET" formnovalidate="formnovalidate"
																					style="font-weight: 500" onclick="return confirm('Are You Sure To Forward this IRS Document?');">
																					<%if (form[12].toString().equalsIgnoreCase("RFW")) {%>
																						Forward
																					<%} else {%>
																						Approve
																					<%}%>
																				</button>
																				<button class="btn btn-sm btn-danger mt-1" name="Action" value="R" formmethod="GET" style="font-weight: 500"
																					onclick="return confirm('Are You Sure To return this IRS Document?');">
																					Return
																				</button>
																			</div>
																		</div>
																	</form>
						 										</td>
                        									</tr>
                       									<%} }%>
                       									<!-- IDD Document Pending List End -->
                       									
                 									</tbody>  
            									</table>
          									</div>
         								<!-- </form> -->
			  						</div>
 
									<!-- Approved List -->	
									<div class="tab-pane fade" id="pills-imm-property" role="tabpanel" aria-labelledby="pills-imm-property-tab">	
										<div class="card-body main-card " >	
											<form method="post" action="DocumentApprovals.htm" >
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
													<%-- <form action="#" method="POST" id="">
            											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>
             											<div class="table-responsive">
              												<table class="table table-hover  table-striped table-condensed table-bordered table-fixed" id="myTable1">
																<thead>
																	<tr>
					   													<th width="5%">SN</th>
					  													<th width="22%">Initiated By</th>
					   													<th width="10%">Project</th>
					   													<th width="8%">Approval for</th>
                       													<th width="25%">Status</th>
                       													<th width="20%">Action</th>
                  													</tr>
																</thead>
                 												<tbody>
                 													<!-- Requirement Document Approved List -->
                      												<%	int SNA=0;
                      													if(reqApprovedList!=null && reqApprovedList.size()>0) {
                          													for(Object[] form:reqApprovedList ) {
                       												%>
                        											<tr>
                            											<td class="center"><%=++SNA%></td>
                            											<td ><%=form[2]!=null?StringEscapeUtils.escapeHtml4(form[2].toString()): " - "+", "+form[3]!=null?StringEscapeUtils.escapeHtml4(form[3].toString()): " - "+" ("+form[1]!=null?StringEscapeUtils.escapeHtml4(form[1].toString()): " - "+")"%></td>
                            											<%-- <td style="text-align: center;width: 5%;"><%=form[1] %> </td> --%>
                            											<td class="center">
                            												<%=form[15]!=null?StringEscapeUtils.escapeHtml4(form[15].toString()):form[16]!=null?StringEscapeUtils.escapeHtml4(form[16].toString()): " - " %>
		                            										<%if(form[17]!=null) {%>
		                            											(<%=StringEscapeUtils.escapeHtml4(form[17].toString())%>)
		                            										<%} %>
                            											</td>
		                            									<td class="center"><%=form[6]!=null?StringEscapeUtils.escapeHtml4(form[6].toString()): " - "%></td>
                            											<td class="center">
                            												<form action="#" id="approvalform_status_<%=SNA%>">
																				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
																				<input type="hidden" name="reqInitiationId" value="<%=form[4]%>"> 
																				<input type="hidden" name="docType" value="R"> 
																				<button type="submit" class="btn btn-sm btn-link w-50 btn-status" formaction="ProjectRequirementTransStatus.htm" data-toggle="tooltip" data-placement="top" title="Transaction History" style=" color: <%=form[9] %>; font-weight: 600;" formtarget="_blank">
								    												<%=form[8]!=null?StringEscapeUtils.escapeHtml4(form[8].toString()): " - " %> <i class="fa fa-telegram" aria-hidden="true" style="float: right;margin-top: 0.3rem;"></i>
								    											</button>
																			</form>
                            												
						 												</td>
						 												<td class="center">
						 													<form action="#" id="approvalform_doc_<%=SNA%>">
																				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
																				<input type="hidden" name="reqInitiationId" value="<%=form[4]%>"> 
																				<span id="downloadform">
																					<button type="submit" class="btn btn-sm" formnovalidate="formnovalidate" formmethod="GET" formtarget="_blank" <%if(form[10]!=null && ("RFA".equalsIgnoreCase(form[10].toString()) ||  "RAM".equalsIgnoreCase(form[10].toString()))) {%>formaction="RequirementDocumentDownlodPdfFreeze.htm"<%}else {%>formaction="RequirementDocumentDownlodPdf.htm"<%} %> 
																						data-toggle="tooltip" data-placement="top" title="" data-original-title="Requirement Document">
																						<i class="fa fa-download fa-lg" aria-hidden="true"></i>
																					</button>
																				</span>
																			</form>
						 													<%-- <button type="submit" class="btn btn-sm view-icon" formaction="ProjectClosureSoCDetails.htm" name="closureSoCApprovals" value="<%=form[4]%>/N/2" data-toggle="tooltip" data-placement="top" title="Closure SoC" style="font-weight: 600;" >
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
																			</button> --%>
						 												</td>
                        											</tr>
                       												<%} }%>
                       												<!-- Requirement Document Approved List End -->
                       												
                 													<!-- Test Plan Document Approved List -->
                      												<%	
                      													if(testPlanApprovedList!=null && testPlanApprovedList.size()>0) {
                          													for(Object[] form:testPlanApprovedList ) {
                       												%>
                        											<tr>
                            											<td class="center"><%=++SNA%></td>
                            											<td ><%=form[2]!=null?StringEscapeUtils.escapeHtml4(form[2].toString()): " - "+", "+form[3]!=null?StringEscapeUtils.escapeHtml4(form[3].toString()): " - "+" ("+form[1]!=null?StringEscapeUtils.escapeHtml4(form[1].toString()): " - "+")"%></td>
                            											<%-- <td style="text-align: center;width: 5%;"><%=form[1] %> </td> --%>
                            											<td class="center">
                            												<%=form[15]!=null?StringEscapeUtils.escapeHtml4(form[15].toString()):form[16]!=null?StringEscapeUtils.escapeHtml4(form[16].toString()): " - " %>
		                            										<%if(form[17]!=null) {%>
		                            											(<%=StringEscapeUtils.escapeHtml4(form[17].toString())%>)
		                            										<%} %>
                            											</td>
                            											<td class="center"><%=form[6]!=null?StringEscapeUtils.escapeHtml4(form[6].toString()): " - "%></td>
                            											<td class="center">
                            												<form action="#" id="approvalform_status_<%=SNA%>">
																				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
																				<input type="hidden" name="testPlanInitiationId" value="<%=form[4]%>"> 
																				<input type="hidden" name="docType" value="T"> 
																				<button type="submit" class="btn btn-sm btn-link w-50 btn-status" formaction="ProjectDocTransStatus.htm" data-toggle="tooltip" data-placement="top" title="Transaction History" style=" color: <%=form[9] %>; font-weight: 600;" formtarget="_blank">
								    												<%=form[8]!=null?StringEscapeUtils.escapeHtml4(form[8].toString()): " - " %> <i class="fa fa-telegram" aria-hidden="true" style="float: right;margin-top: 0.3rem;"></i>
								    											</button>
																			</form>
                            												
						 												</td>
						 												<td class="center">
						 													<form action="#" id="approvalform_doc_<%=SNA%>">
																				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
																				<input type="hidden" name="testPlanInitiationId" value="<%=form[4]%>"> 
																				<span id="downloadform">
																					<button type="submit" class="btn btn-sm" formnovalidate="formnovalidate" formmethod="GET" formtarget="_blank" <%if(form[10]!=null && ("RFA".equalsIgnoreCase(form[10].toString()) ||  "RAM".equalsIgnoreCase(form[10].toString()))) {%>formaction="TestPlanDownlodPdfFreeze.htm"<%}else {%>formaction="TestPlanDownlodPdf.htm"<%} %>
																						data-toggle="tooltip" data-placement="top" title="" data-original-title="Test Plan Document">
																						<i class="fa fa-download fa-lg" aria-hidden="true"></i>
																					</button>
																				</span>
																			</form>
						 													<%-- <button type="submit" class="btn btn-sm view-icon" formaction="ProjectClosureSoCDetails.htm" name="closureSoCApprovals" value="<%=form[4]%>/N/2" data-toggle="tooltip" data-placement="top" title="Closure SoC" style="font-weight: 600;" >
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
																			</button> --%>
						 												</td>
                        											</tr>
                       												<%} }%>
                       												<!-- Test Plan Document Approved List End -->
                       												
                 													<!-- Specifications Document Approved List -->
                      												<%	
                      													if(specificationApprovedList!=null && specificationApprovedList.size()>0) {
                          													for(Object[] form:specificationApprovedList ) {
                       												%>
                        											<tr>
                            											<td class="center"><%=++SNA%></td>
                            											<td ><%=form[2]!=null?StringEscapeUtils.escapeHtml4(form[2].toString()): " - "+", "+form[3]!=null?StringEscapeUtils.escapeHtml4(form[3].toString()): " - "+" ("+form[1]!=null?StringEscapeUtils.escapeHtml4(form[1].toString()): " - "+")"%></td>
                            											<%-- <td style="text-align: center;width: 5%;"><%=form[1] %> </td> --%>
                            											<td class="center">
                            												<%=form[15]!=null?StringEscapeUtils.escapeHtml4(form[15].toString()):form[16]!=null?StringEscapeUtils.escapeHtml4(form[16].toString()): " - " %>
		                            										<%if(form[17]!=null) {%>
		                            											(<%=StringEscapeUtils.escapeHtml4(form[17].toString())%>)
		                            										<%} %>
                            											</td>
                            											<td class="center"><%=form[6]!=null?StringEscapeUtils.escapeHtml4(form[6].toString()): " - "%></td>
                            											<td class="center">
                            												<form action="#" id="approvalform_status_<%=SNA%>">
																				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
																				<input type="hidden" name="SpecsInitiationId" value="<%=form[4]%>"> 
																				<input type="hidden" name="docType" value="S"> 
																				<button type="submit" class="btn btn-sm btn-link w-50 btn-status" formaction="ProjectDocTransStatus.htm" data-toggle="tooltip" data-placement="top" title="Transaction History" style=" color: <%=form[9] %>; font-weight: 600;" formtarget="_blank">
								    												<%=form[8]!=null?StringEscapeUtils.escapeHtml4(form[8].toString()): " - "%> <i class="fa fa-telegram" aria-hidden="true" style="float: right;margin-top: 0.3rem;"></i>
								    											</button>
																			</form>
                            												
						 												</td>
						 												<td class="center">
						 													<%-- <form action="#" id="approvalform_doc_<%=SNA%>">
																				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
																				<input type="hidden" name="SpecsInitiationId" value="<%=form[4]%>"> 
																				<span id="downloadform">
																					<button type="submit" class="btn btn-sm" formnovalidate="formnovalidate" formmethod="GET" formtarget="_blank" <%if(form[10]!=null && ("RFA".equalsIgnoreCase(form[10].toString()) ||  "RAM".equalsIgnoreCase(form[10].toString()))) {%>formaction="SpecificationDownlodPdfFreeze.htm"<%}else {%>formaction="SpecificationDownlodPdf.htm"<%} %>
																						data-toggle="tooltip" data-placement="top" title="" data-original-title="Specification Document">
																						<i class="fa fa-download fa-lg" aria-hidden="true"></i>
																					</button>
																				</span>
																			</form> --%>
						 													<%-- <button type="submit" class="btn btn-sm view-icon" formaction="ProjectClosureSoCDetails.htm" name="closureSoCApprovals" value="<%=form[4]%>/N/2" data-toggle="tooltip" data-placement="top" title="Closure SoC" style="font-weight: 600;" >
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
																			</button> --%>
						 												</td>
                        											</tr>
                       												<%} }%>
                       												<!-- Specifications Document Approved List End -->
                       												
                       												<!-- IGI Document Approved List -->
                       												<%	
                      													if(igiDocApprovedList!=null && igiDocApprovedList.size()>0) {
                          													for(Object[] form : igiDocApprovedList ) {
                       												%>
                        											<tr>
                            											<td class="center"><%=++SNA%></td>
                            											<td ><%=form[2]!=null?StringEscapeUtils.escapeHtml4(form[2].toString()): " - "+", "+form[3]!=null?StringEscapeUtils.escapeHtml4(form[3].toString()): " - "+" ("+form[1]!=null?StringEscapeUtils.escapeHtml4(form[1].toString()): " - "+")"%></td>
                            											<%-- <td style="text-align: center;width: 5%;"><%=form[1] %> </td> --%>
                            											<td class="center">
                            												For Lab
                            											</td>
                            											<td class="center"><%=form[6]!=null?StringEscapeUtils.escapeHtml4(form[6].toString()): " - "%></td>
                            											<td class="center">
                            												<form action="#" id="approvalform_status_<%=SNA%>">
																				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
																				<input type="hidden" name="docId" value="<%=form[4]%>"> 
																				<input type="hidden" name="docType" value="A"> 
																				<button type="submit" class="btn btn-sm btn-link w-50 btn-status" formaction="IGIDocTransStatus.htm" data-toggle="tooltip" data-placement="top" title="Transaction History" style=" color: <%=form[9] %>; font-weight: 600;" formtarget="_blank">
								    												<%=form[8]!=null?StringEscapeUtils.escapeHtml4(form[8].toString()): " - " %> <i class="fa fa-telegram" aria-hidden="true" style="float: right;margin-top: 0.3rem;"></i>
								    											</button>
																			</form>
                            												
						 												</td>
						 												<td class="center"> 
		                            										<form action="#" id="approvalform_doc_<%=SNA%>">
																				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
																				<input type="hidden" name="igiDocId" value="<%=form[4]%>"> 
																				<input type="hidden" name="isPdf" value="Y"> 
																				<span id="downloadform">
																					<button type="submit" class="btn btn-sm bg-transparent" formnovalidate="formnovalidate" formmethod="GET" formtarget="_blank" formaction="IGIDocumentDetails.htm"
																						data-toggle="tooltip" data-placement="top" title="" data-original-title="IGI Document">
																						&emsp;<i class="fa fa-download fa-lg" aria-hidden="true"></i>
																					</button>
																				</span>
																			</form>
		                            									</td>
                        											</tr>
                       												<%} }%>
                       												<!-- IGI Document Approved List End -->
                       												
                       												<!-- ICD Document Approved List -->
                       												<%	
                      													if(icdDocApprovedList!=null && icdDocApprovedList.size()>0) {
                          													for(Object[] form : icdDocApprovedList ) {
                       												%>
                        											<tr>
                            											<td class="center"><%=++SNA%></td>
                            											<td ><%=form[2]!=null?StringEscapeUtils.escapeHtml4(form[2].toString()): " - "+", "+form[3]!=null?StringEscapeUtils.escapeHtml4(form[3].toString()): " - "+" ("+form[1]!=null?StringEscapeUtils.escapeHtml4(form[1].toString()): " - "+")"%></td>
                            											<%-- <td style="text-align: center;width: 5%;"><%=form[1] %> </td> --%>
                            											<td class="center">
                            												<%=form[15]!=null?StringEscapeUtils.escapeHtml4(form[15].toString()):form[14]!=null?StringEscapeUtils.escapeHtml4(form[14].toString()): " - " %>
                            											</td>
                            											<td class="center"><%=form[6]!=null?StringEscapeUtils.escapeHtml4(form[6].toString()): " - "%></td>
                            											<td class="center">
                            												<form action="#" id="approvalform_status_<%=SNA%>">
																				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
																				<input type="hidden" name="docId" value="<%=form[4]%>"> 
																				<input type="hidden" name="docType" value="B"> 
																				<button type="submit" class="btn btn-sm btn-link w-50 btn-status" formaction="IGIDocTransStatus.htm" data-toggle="tooltip" data-placement="top" title="Transaction History" style=" color: <%=form[9] %>; font-weight: 600;" formtarget="_blank">
								    												<%=form[8]!=null?StringEscapeUtils.escapeHtml4(form[8].toString()): " - " %> <i class="fa fa-telegram" aria-hidden="true" style="float: right;margin-top: 0.3rem;"></i>
								    											</button>
																			</form>
                            												
						 												</td>
						 												<td class="center"> 
		                            										<form action="#" id="approvalform_doc_<%=SNA%>">
																				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
																				<input type="hidden" name="icdDocId" value="<%=form[4]%>"> 
																				<input type="hidden" name="isPdf" value="Y"> 
																				<span id="downloadform">
																					<button type="submit" class="btn btn-sm bg-transparent" formnovalidate="formnovalidate" formmethod="GET" formtarget="_blank" formaction="ICDDocumentDetails.htm"
																						data-toggle="tooltip" data-placement="top" title="" data-original-title="ICD Document">
																						&emsp;<i class="fa fa-download fa-lg" aria-hidden="true"></i>
																					</button>
																				</span>
																			</form>
		                            									</td>
                        											</tr>
                       												<%} }%>
                       												<!-- ICD Document Approved List End -->
                       												
                       												<!-- IRS Document Approved List -->
                       												<%	
                      													if(irsDocApprovedList!=null && irsDocApprovedList.size()>0) {
                          													for(Object[] form : irsDocApprovedList ) {
                       												%>
                        											<tr>
                            											<td class="center"><%=++SNA%></td>
                            											<td ><%=form[2]!=null?StringEscapeUtils.escapeHtml4(form[2].toString()): " - "+", "+form[3]!=null?StringEscapeUtils.escapeHtml4(form[3].toString()): " - "+" ("+form[1]!=null?StringEscapeUtils.escapeHtml4(form[1].toString()): " - "+")"%></td>
                            											<%-- <td style="text-align: center;width: 5%;"><%=form[1] %> </td> --%>
                            											<td class="center">
                            												<%=form[15]!=null?StringEscapeUtils.escapeHtml4(form[15].toString()):form[14]!=null?StringEscapeUtils.escapeHtml4(form[14].toString()): " - " %>
                            											</td>
                            											<td class="center"><%=form[6]!=null?StringEscapeUtils.escapeHtml4(form[6].toString()): " - "%></td>
                            											<td class="center">
                            												<form action="#" id="approvalform_status_<%=SNA%>">
																				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
																				<input type="hidden" name="docId" value="<%=form[4]%>"> 
																				<input type="hidden" name="docType" value="C"> 
																				<button type="submit" class="btn btn-sm btn-link w-50 btn-status" formaction="IGIDocTransStatus.htm" data-toggle="tooltip" data-placement="top" title="Transaction History" style=" color: <%=form[9] %>; font-weight: 600;" formtarget="_blank">
								    												<%=form[8]!=null?StringEscapeUtils.escapeHtml4(form[8].toString()): " - " %> <i class="fa fa-telegram" aria-hidden="true" style="float: right;margin-top: 0.3rem;"></i>
								    											</button>
																			</form>
                            												
						 												</td>
						 												<td class="center"> 
		                            										<form action="#" id="approvalform_doc_<%=SNA%>">
																				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
																				<input type="hidden" name="irsDocId" value="<%=form[4]%>"> 
																				<input type="hidden" name="isPdf" value="Y"> 
																				<span id="downloadform">
																					<button type="submit" class="btn btn-sm bg-transparent" formnovalidate="formnovalidate" formmethod="GET" formtarget="_blank" formaction="IRSDocumentDetails.htm"
																						data-toggle="tooltip" data-placement="top" title="" data-original-title="IRS Document">
																						&emsp;<i class="fa fa-download fa-lg" aria-hidden="true"></i>
																					</button>
																				</span>
																			</form>
		                            									</td>
                        											</tr>
                       												<%} }%>
                       												<!-- IRS Document Approved List End -->
                       												
                       												<!-- IDD Document Approved List -->
                       												<%	
                      													if(iddDocApprovedList!=null && iddDocApprovedList.size()>0) {
                          													for(Object[] form : iddDocApprovedList ) {
                       												%>
                        											<tr>
                            											<td class="center"><%=++SNA%></td>
                            											<td ><%=form[2]!=null?StringEscapeUtils.escapeHtml4(form[2].toString()): " - "+", "+form[3]!=null?StringEscapeUtils.escapeHtml4(form[3].toString()): " - "+" ("+form[1]!=null?StringEscapeUtils.escapeHtml4(form[1].toString()): " - "+")"%></td>
                            											<%-- <td style="text-align: center;width: 5%;"><%=form[1] %> </td> --%>
                            											<td class="center">
                            												<%=form[15]!=null?StringEscapeUtils.escapeHtml4(form[15].toString()):form[14]!=null?StringEscapeUtils.escapeHtml4(form[14].toString()): " - " %>
                            											</td>
                            											<td class="center"><%=form[6]!=null?StringEscapeUtils.escapeHtml4(form[6].toString()): " - "%></td>
                            											<td class="center">
                            												<form action="#" id="approvalform_status_<%=SNA%>">
																				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
																				<input type="hidden" name="docId" value="<%=form[4]%>"> 
																				<input type="hidden" name="docType" value="D"> 
																				<button type="submit" class="btn btn-sm btn-link w-50 btn-status" formaction="IGIDocTransStatus.htm" data-toggle="tooltip" data-placement="top" title="Transaction History" style=" color: <%=form[9] %>; font-weight: 600;" formtarget="_blank">
								    												<%=form[8]!=null?StringEscapeUtils.escapeHtml4(form[8].toString()): " - " %> <i class="fa fa-telegram" aria-hidden="true" style="float: right;margin-top: 0.3rem;"></i>
								    											</button>
																			</form>
                            												
						 												</td>
						 												<td class="center"> 
		                            										<form action="#" id="approvalform_doc_<%=SNA%>">
																				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
																				<input type="hidden" name="irsDocId" value="<%=form[4]%>"> 
																				<input type="hidden" name="isPdf" value="Y"> 
																				<span id="downloadform">
																					<button type="submit" class="btn btn-sm bg-transparent" formnovalidate="formnovalidate" formmethod="GET" formtarget="_blank" formaction="IDDDocumentDetails.htm"
																						data-toggle="tooltip" data-placement="top" title="" data-original-title="IDD Document">
																						&emsp;<i class="fa fa-download fa-lg" aria-hidden="true"></i>
																					</button>
																				</span>
																			</form>
		                            									</td>
                        											</tr>
                       												<%} }%>
                       												<!-- IDD Document Approved List End -->
                       												
                   												</tbody>
                 											</table>
                										</div> 
               										<!-- </form> -->
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
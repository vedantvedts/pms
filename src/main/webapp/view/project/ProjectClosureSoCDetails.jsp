<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.model.LabMaster"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.vts.pfms.projectclosure.model.ProjectClosure"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.vts.pfms.projectclosure.model.ProjectClosureSoC"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.project.model.ProjectMaster"%>
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
<spring:url value="/resources/css/projectModule/soc.css" var="socCss"/>
<link rel="stylesheet" type="text/css" href="${socCss}">
<script src="${ckeditor}"></script>
<link href="${contentCss}" rel="stylesheet" />
<link href="${projetdetailscss}" rel="stylesheet" />
</head>
<body>

<%

ProjectMaster projectMaster = (ProjectMaster)request.getAttribute("ProjectDetails");
ProjectClosure closure = (ProjectClosure)request.getAttribute("ProjectClosureDetails");
ProjectClosureSoC soc = (ProjectClosureSoC)request.getAttribute("ProjectClosureSoCData");
LabMaster labMaster = (LabMaster)request.getAttribute("labMasterData");

Object[] potherdetails = (Object[])request.getAttribute("ProjectOriginalRevDetails");
Object[] expndDetails = (Object[])request.getAttribute("ProjectExpenditureDetails");

List<Object[]> socApprovalEmpData = (List<Object[]>)request.getAttribute("SoCApprovalEmpData");
List<Object[]> socRemarksHistory = (List<Object[]>)request.getAttribute("SoCRemarksHistory");

List<Object[]> labList = (List<Object[]>)request.getAttribute("LabList");

String socTabId = (String)request.getAttribute("socTabId");
String closureId = (String)request.getAttribute("closureId");
String isApproval = (String)request.getAttribute("isApproval");

List<String> socforward = Arrays.asList("SIN","SRG","SRA","SRP","SRD","SRC","SRV");

List<String> closurecategory = Arrays.asList("Completed Successfully","Partial Success","Stage Closure","Cancellation");
List<String> dmcdirection = Arrays.asList("Recommended","Not Recommended","Not Applicable");

Object[] Director = (Object[])request.getAttribute("Director");
Object[] GDDPandC = (Object[])request.getAttribute("GDDPandC");
Object[] AD = (Object[])request.getAttribute("AD");
Object[] GD = (Object[])request.getAttribute("GDDetails");
Object[] PDData = (Object[])request.getAttribute("PDData");
Object[] emp = (Object[])request.getAttribute("EmpData");


String labcode = (String)session.getAttribute("labcode");

FormatConverter fc = new FormatConverter();
SimpleDateFormat sdtf = fc.getSqlDateAndTimeFormat();
SimpleDateFormat sdf = fc.getSqlDateFormat();
SimpleDateFormat rdf = fc.getRegularDateFormat();

DecimalFormat df = new DecimalFormat("#.####");
df.setMinimumFractionDigits(4); 
String statuscode = closure!=null?closure.getClosureStatusCode():null;
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
         		<div class="card-header slider_header card-header1">
             		<h4 class="category">Project Closure SoC - <%if(projectMaster!=null) {%><%=projectMaster.getProjectShortName()!=null?StringEscapeUtils.escapeHtml4(projectMaster.getProjectShortName()): " - "%> (<%=projectMaster.getProjectCode()!=null?StringEscapeUtils.escapeHtml4(projectMaster.getProjectCode()): " - " %>) <%} %>

             			<a class="btn btn-info btn-sm  shadow-nohover back back-btn"
             				<%if(isApproval!=null && isApproval.equalsIgnoreCase("Y") ) {%>
               					href="ProjectClosureApprovals.htm"
               				<%} else if(isApproval!=null &&  isApproval.equalsIgnoreCase("N") ) {%>
               					href="ProjectClosureApprovals.htm?val=app"
               				<%} else{%> 
               					href="ProjectClosureList.htm"
               				<%} %>
             		
             			  >Back</a>
             		</h4>
             		<hr class="margin-80">
             		<ul class="nav nav-tabs justify-content-center padding-bottom-0" role="tablist">

            			<li class="nav-item" id="nav-socdetails">
             				<%if(socTabId!=null && socTabId.equalsIgnoreCase("1")){ %> 
             		    		<a class="nav-link active " data-toggle="tab" href="#socdetails" id="nav" role="tab">
             				<%}else{ %>
              			 		<a class="nav-link  " data-toggle="tab" href="#socdetails" role="tab">
               				<%} %>  
               					
                	         	SoC Details
              			 		</a>
            			</li>

            			<li class="nav-item" id="nav-socforward">
            	     		<%if(socTabId!=null && socTabId.equalsIgnoreCase("2")){ %>
              					<a class="nav-link active" data-toggle="tab" href="#socforward" id="nav"role="tab" >
              				<%}else{ %>
              					<a class="nav-link" data-toggle="tab" href="#socforward" role="tab" >
               				<%} %>
                  				SoC Forward
              					</a>
            			</li>
            			
              		</ul>
         		</div>
         		
         		<!-- This is for Tab Panes -->
         		<div class="card">
         			<div class="tab-content text-left mt02rem">
         				<!-- *********** SoC Details ***********      --> 
               			<%if(socTabId!=null && socTabId.equalsIgnoreCase("1")){ %> 
         					<div class="tab-pane active" id="socdetails" role="tabpanel">
         				<%}else{ %>
              				<div class="tab-pane " id="socdetails" role="tabpanel">
               			<%} %>
               					<div class="container">
									<div class="row container-row">
										<div class="col-md-12">
											<div class="card shadow-nohover" >
												<div class="card-header card-header-bg">
								                    <b class="text-white">SoC Details: </b> 
								                    <hr>
								                    <span class="text-white float-right fw-600"> </span>
							        			</div> 
												<div class="card-body">
								        		
													<form action="ProjectClosureSoCDetailsSubmit.htm" method="POST" enctype="multipart/form-data">
														<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
												    	<input type="hidden" name="closureId" value="<%=closureId%>">
												    	<div class="row ml2-mr2">
												    	
												        	<div class="col-md-2">
												        		<div class="form-group">
												                	<label class="control-label">QR No:</label>
												                    <input  class="form-control form-control" type="text" name="qrNo" placeholder="Enter QRNo" 
												                     value="<%if(soc!=null && soc.getQRNo()!=null) {%><%=soc.getQRNo()!=null?StringEscapeUtils.escapeHtml4(soc.getQRNo()): " - " %><%} %>" > 
												                </div>
												            </div>
												            
												            <div class="col-md-2">
												        		<div class="form-group">
												                	<label class="control-label">Direction of DMC:</label><span class="mandatory">*</span>
												                	<select name="dmcDirection" id="dmcDirection" class="form-control  form-control selectdee" data-width="100%" data-live-search="true" required>
			                											<option value="0" disabled="disabled" selected="selected">--Select--</option>
												               			<%
												                			for(String direction: dmcdirection ){
												                		%>
																			<option value="<%=direction%>" <%if(soc!=null && soc.getDMCDirection()!=null){ if(direction.equalsIgnoreCase(soc.getDMCDirection())){%>selected="selected" <%}} %>  class="text-left"><%=direction!=null?StringEscapeUtils.escapeHtml4(direction): " - " %></option>
																		<%} %>
																	</select>
																	</div>
												            </div>
												            
												        </div>
												        
												        <div class="row ml2-mr2">
												        	<div class="col-md-6">
												        		<div class="form-group">
												                	<label class="control-label">Present Status:</label><span class="mandatory">*</span>
												                    <textarea class="form-control form-control fs15px" name="presentStatus" maxlength="5000" rows="2" cols="65" 
                              		  								 placeholder="Enter Present Status" required><%if(soc!=null && soc.getPresentStatus()!=null){ %><%=soc.getPresentStatus() %><%} %></textarea> 
												                </div>
												            </div>
												            <div class="col-md-6">
												        		<div class="form-group">
												                	<label class="control-label">Detailed reasons/considerations for closure:</label><span class="mandatory">*</span>
												                    <textarea class="form-control form-control fs15px" name="reason" maxlength="5000" rows="2" cols="65" 
                              		  								 placeholder="Enter Detailed reasons/considerations for closure" required><%if(soc!=null && soc.getReason()!=null){ %><%=soc.getReason() %><%} %></textarea> 
												                </div>
												            </div>
												        </div>
												        
												        <div class="row ml2-mr2" id="recommendationdiv">
												        	<div class="col-md-12">
												        		<div class="form-group">
												                	<label class="control-label">Recommendation of Review Committee for Project success:</label><span class="mandatory">*</span>
												                    <textarea class="form-control form-control fs15px" name="recommendation" maxlength="5000" rows="2" cols="65" 
                              		  								 placeholder="Enter Recommendation of Review Committee for Project success"><%if(soc!=null && soc.getRecommendation()!=null){ %><%=soc.getRecommendation() %><%} %></textarea> 
												                </div>
												            </div>
												        </div>
												        
												        <div class="row ml2-mr2">
												        	<div class="col-md-6">
												        		<div class="form-group">
												                	<label class="control-label">Recommendations of the highest monitoring committee for closure:</label><span class="mandatory">*</span>
												                    <textarea class="form-control form-control fs15px" name="monitoringCommittee" maxlength="5000" rows="2" cols="65" 
                              		  								 placeholder="Enter Minutes of Monitoring Committee Meetings held so far and recommendations of the highest monitoring committee for closure of the project/programme" required><%if(soc!=null && soc.getMonitoringCommittee()!=null){ %><%=soc.getMonitoringCommittee() %><%} %></textarea> 
												                </div>
												            </div>
												            <div class="col-md-6">
												        		<div class="form-group">
												                	<label class="control-label">Other relevant details:</label>
												                    <textarea class="form-control form-control fs15px" name="otherRelevant" maxlength="5000" rows="2" cols="65" 
                              		  								 placeholder="Enter Other relevant details" ><%if(soc!=null && soc.getOtherRelevant()!=null){ %><%=soc.getOtherRelevant() %><%} %></textarea> 
												                </div>
												            </div>
												        </div>
												        
												        <div class="row ml2-mr2">
												        	<div class="col-md-3">
												        		<div class="form-group">
												                	<label class="control-label">Monitoring Committee:</label><span class="mandatory">*</span>
												                	<%if(soc!=null && soc.getMonitoringCommitteeAttach()!=null){ %>
                            					 						<button type="submit" class="btn btn-sm padding5px8px" name="filename" formmethod="post" formnovalidate="formnovalidate"
                            					 		  				 	value="monitoringcommitteefile" formaction="ProjectClosureSoCFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Monitoring Committee Recommendations Download">
                            					 							<i class="fa fa-download fa-lg"></i>
                            					 						</button>
                            					 					<%} %>
                              		      							<input type="file" class="form-control modals" name="monitoringCommitteeAttach" <%if(soc==null) {%>required<%} %> accept=".pdf">
												                </div>
												            </div>
												            <div class="col-md-3">
												        		<div class="form-group">
												                	<label class="control-label">Lessons Learnt:</label><span class="mandatory">*</span>
												                    <%if(soc!=null && soc.getLessonsLearnt()!=null){ %>
                            					 						<button type="submit" class="btn btn-sm padding5px8px" name="filename" formmethod="post" formnovalidate="formnovalidate"
                            					 		  				 	value="lessonslearntfile" formaction="ProjectClosureSoCFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Lessons Learnt Download">
                            					 							<i class="fa fa-download fa-lg"></i>
                            					 						</button>
                            					 					<%} %>
                              		      							<input type="file" class="form-control modals" name="lessonsLearnt" <%if(soc==null) {%>required<%} %> accept=".pdf">
												                </div>
												            </div>
												            
												        </div>
												        
								               			<div align="center" class="mt1rem-mb1rem">
															<%if(soc!=null){ %>
															    <input type="hidden" name="closureId" value="<%=soc.getClosureId()%>">
																<button type="submit" class="btn btn-sm btn-warning edit btn-soc" name="Action" value="Edit" onclick="return confirm('Are you sure to update?')" >UPDATE</button>
															<%}else{ %>
																<button type="submit" class="btn btn-sm btn-success submit btn-soc" name="Action" value="Add" onclick="return confirm('Are you sure to submit?')" >SUBMIT</button>
															<%} %>
														</div>
						
												    </form>
												</div>
											</div>
               							</div>
               						</div>
               					</div>
               					<div class="displex-juscont">
               						<div></div>
		               				<div class="navigation_btn text-center">
		               					<%if(soc!=null){ %>
				               				<form action="">
				               					<button type="submit" class="btn btn-sm soc-btn" formaction="ProjectClosureSoCDownload.htm" formtarget="_blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="SoC Download">SoC</button>
				               					<input type="hidden" name="closureId" value="<%=closureId%>">
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				               				</form>
			               				<%} %>
									</div>
		               				<div class="navigation_btn text-right">
            							<a class="btn btn-info btn-sm  shadow-nohover back white-color" href="ProjectClosureList.htm">Back</a>
										<button class="btn btn-info btn-sm next">Next</button>
									</div>
               					</div>
               					
               			<%if(socTabId!=null && socTabId.equalsIgnoreCase("1")){ %> 
         					</div>
         				<%}else{ %>
              				</div>
               			<%} %>
               			
               			<!-- *********** SoC Forward ***********      --> 
               			<%if(socTabId!=null && socTabId.equalsIgnoreCase("2")){ %> 
         					<div class="tab-pane active" id="socforward" role="tabpanel">
         				<%}else{ %>
              				<div class="tab-pane " id="socforward" role="tabpanel">
               			<%} %>
               					<%if(soc!=null) {%>
               						<div class="col-md-8 mt-2">
               						<%
									   String maxHeightClass = (isApproval == null) ? "mh-600" : "mh-700";
									%>
               							<div class="card card-custom <%=maxHeightClass%>">
               								<div class="card-body mt-2 ml-4">
               									<form action="#">
               										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                   									<input type="hidden" name="closureId" value="<%=closureId%>">
                   									<input type="hidden" name="closureSoCId" value="<%=soc.getClosureSoCId()%>">
			               							<div class="mt-2" align="center">
			               								<h5 class="heading-size">STATEMENT OF CASE FOR PROJECT COMPLETED WITH
				               								<%if(closure!=null) {
				               								 String category = closure.getClosureCategory();
				               								%>
				               									<%if(category.equalsIgnoreCase("Partial Success")){%>
				               									PARTIAL SUCCESS
				               									<%} else if(category.equalsIgnoreCase("Stage Closure")){%>
				               									STAGE CLOSURE
				               									<%} else if(category.equalsIgnoreCase("Cancellation")){%>
				               									CANCELLATION
				               									<%} %>
				               								<%} %>
			               								 </h5>
			               							</div>
			               							<%int slno=0; %>
    												<table id="tabledata">
												    	<tr>
												    		<td class="width4per""><%=++slno %>.</td>
												    		<td class="width40per"">Name of Lab/Est</td>
												    		<td>: <%=labMaster.getLabName()!=null?StringEscapeUtils.escapeHtml4(labMaster.getLabName()): " - "%> (<%= labMaster.getLabCode()!=null?StringEscapeUtils.escapeHtml4(labMaster.getLabCode()): " - " %>), <%=labMaster.getLabAddress()!=null?StringEscapeUtils.escapeHtml4(labMaster.getLabAddress()): " - "%> </td>
												    	</tr>
												    	<tr>
												    		<td class="width4per""><%=++slno %>.</td>
												    		<td class="width40per"">Title of the Project/Programme</td>
												    		<td>: <%=projectMaster.getProjectName()!=null?StringEscapeUtils.escapeHtml4(projectMaster.getProjectName()): " - "%> </td>
												    	</tr>
												    	<tr>
												    		<td class="width4per""><%=++slno %>.</td>
												    		<td class="width40per"">Project/Programme No.</td>
												    		<td>: <%=projectMaster.getSanctionNo()!=null?StringEscapeUtils.escapeHtml4(projectMaster.getSanctionNo()): " - " %> </td>
												    	</tr>
												    	<tr>
												    		<td class="width4per""><%=++slno %>.</td>
												    		<td class="width40per"">Category of Project</td>
												    		<td>: <%if(potherdetails!=null && potherdetails[0]!=null) {%><%=StringEscapeUtils.escapeHtml4(potherdetails[0].toString()) %><%} %> </td>
												    	</tr>
												    	<tr>
												    		<td class="width4per""><%=++slno %>.</td>
												    		<td class="width40per"">Sponsoring Agency and QR No.</td>
												    		<td>: <%if(projectMaster.getEndUser()!=null) {%> <%=StringEscapeUtils.escapeHtml4(projectMaster.getEndUser()) %><%} else{%>--<%} %> and <%if(soc.getQRNo()!=null && !soc.getQRNo().isEmpty()) {%> <%=StringEscapeUtils.escapeHtml4(soc.getQRNo()) %><%} else{%>NA<%} %> </td>
												    	</tr>
												    	<tr>
												    		<td class="width4per""><%=++slno %>.</td>
												    		<td class="width40per"">Date of Sanction</td>
												    		<td>: <%if(projectMaster.getSanctionDate()!=null) {%><%=fc.SqlToRegularDate(projectMaster.getSanctionDate()+"") %><%} %> </td>
												    	</tr>
												    	<tr>
												    		<td class="width4per""><%=++slno %>.</td>
												    		<td class="width40per"">PDC original given and <br> Subsequent amendment, if any </td>
												    		<td>: <%if(projectMaster.getPDC()!=null) {%><%=fc.SqlToRegularDate(projectMaster.getPDC()+"") %><%} %>
												    		
												    		<br>: <%if(potherdetails!=null && potherdetails[8]!=null) {%><%=fc.SqlToRegularDate(potherdetails[8].toString()) %><%} else{%>--<%} %>
												    		</td>
												    	</tr>
												    	<tr>
												    		<td class="width4per""><%=++slno %>.</td>
												    		<td class="width40per"">Sanctioned Cost ( <span class="fs12px">&#x20B9;</span> Cr) </td>
												    		<td>: Total 
												    			<span class="txt-decoration">
												    				<%=df.format(projectMaster.getTotalSanctionCost()/10000000) %>
												    			</span> Cr (FE 
												    			<span class="txt-decoration">
												    				<%=df.format(projectMaster.getSanctionCostRE()/10000000 ) %>
												    			</span> Cr)
												    		</td>
												    	</tr> 
												    	<tr>
												    		<td class="width4per""><%=++slno %>.</td>
												    		<td class="width40per"">Statement of Accounts ( as on <%-- <%if(soc.getExpndAsOn()!=null) {%><%=fc.SqlToRegularDate(soc.getExpndAsOn()) %><%} %> --%> )</td>
												    		<td>: Expenditure incurred (<span class="fs12px">&#x20B9;</span> Cr) 
												    		: Total <span class="txt-decoration">
												    			<%-- <%=String.format("%.2f", Double.parseDouble(soc.getTotalExpnd())/10000000 ) %> --%>
												    			<%if(expndDetails!=null && expndDetails[0]!=null) {%>
												    				<%=df.format(Double.parseDouble(expndDetails[0].toString())/10000000 ) %> 
												    			<%} %>
												    		</span> Cr 
												    		(FE <span class="txt-decoration">
												    			<%-- <%=String.format("%.2f", Double.parseDouble(soc.getTotalExpndFE())/10000000 ) %> --%>
												    			<%if(expndDetails!=null && expndDetails[1]!=null) {%>
												    				<%=df.format(Double.parseDouble(expndDetails[1].toString())/10000000 ) %> 
												    			<%} %>
												    			</span> Cr)
												    		</td>
												    	</tr>
												    	<tr>
												    		<td class="width4per""><%=++slno %>.</td>
												    		<td class="width40per"">Present Status</td>
												    		<td>: <%=soc.getPresentStatus()!=null?StringEscapeUtils.escapeHtml4(soc.getPresentStatus()): " - " %> </td>
												    	</tr>
												    	<tr>
												    		<td class="width4per""><%=++slno %>.</td>
												    		<td class="width40per"">Detailed reasons/considerations for Project <%=closure.getClosureCategory() %> </td>
												    		<td>: <%if(soc.getReason()!=null) {%><%=StringEscapeUtils.escapeHtml4(soc.getReason()) %> <%} else{%>-<%} %> </td>
												    	</tr>
												    	<tr>
												    		<td class="width4per""><%=++slno %>.</td>
												    		<td class="width40per"">Recommendation of Review Committee for Project success (as applicable)</td>
												    		<td>: <%if(soc.getRecommendation()!=null && !soc.getRecommendation().isEmpty()) {%><%=StringEscapeUtils.escapeHtml4(soc.getRecommendation()) %> <%} else{%>NA<%} %> </td>
												    	</tr>
												    	<tr>
												    		<td class="width4per""><%=++slno %>.</td>
												    		<td class="width40per"">
												    			Minutes of Monitoring Committee Meetings held so far and recommendations 
												 				of the highest monitoring committee for closure of the project/programme
												 			</td>
												    		<td>: <%=soc.getMonitoringCommittee()!=null?StringEscapeUtils.escapeHtml4(soc.getMonitoringCommittee()): " - " %>
												    			<button type="submit" class="btn btn-sm padding5px8px" name="filename" formmethod="post" formnovalidate="formnovalidate"
                            					 	 		     value="monitoringcommitteefile" formaction="ProjectClosureSoCFileDownload.htm" data-toggle="tooltip" data-placement="top" title="Monitoring Committee Download">
                            					 				 	<i class="fa fa-download fa-lg"></i>
                            					 				</button>
												    		</td>
												    	</tr>
												    	<tr>
												    		<td class="width4per""><%=++slno %>.</td>
												    		<td class="width40per"">Direction of DMC</td>
												    		<td>: <%=soc.getDMCDirection()!=null?StringEscapeUtils.escapeHtml4(soc.getDMCDirection()): " - " %> </td>
												    	</tr>
												    	<tr>
												    		<td class="width4per""><%=++slno %>.</td>
												    		<td class="width40per"">Lessons Learnt</td>
												    		<td>: 
												    		<button type="submit" class="btn btn-sm padding5px8px" name="filename" formmethod="post" formnovalidate="formnovalidate"
                            					 	 		 value="lessonslearntfile" formaction="ProjectClosureSoCFileDownload.htm" data-toggle="tooltip" data-placement="top" title="Lessons learnt Download">
                            					 				<i class="fa fa-download fa-lg"></i>
                            					 			</button>
												    		</td>
												    	</tr>
												    	<tr>
												    		<td class="width4per""><%=++slno %>.</td>
												    		<td class="width40per"">Other relevant details</td>
												    		<td>: <%if(soc.getOtherRelevant()!=null && !soc.getOtherRelevant().isEmpty()) {%><%=StringEscapeUtils.escapeHtml4(soc.getOtherRelevant())%> <%} else{%>--<%} %></td>
												    	</tr>
   	 												</table>
   	 												
   	 												<br>
			               		   					
			               		   					<!-- Signatures and timestamps -->
			               		   					
													<div class="sign-timestamp">
		               								 	<div class="fs15px">Project Director</div>
						               					<%for(Object[] apprInfo : socApprovalEmpData){ %>
						   			   					<%if(apprInfo[8].toString().equalsIgnoreCase("SFW")){ %>
						   								<label class="txt-transform mt-15"><%=apprInfo[2]!=null?StringEscapeUtils.escapeHtml4(apprInfo[2].toString()): " - "%></label>,<!-- <br> -->
						   								<label class="txt-transform"><%=apprInfo[3]!=null?StringEscapeUtils.escapeHtml4(apprInfo[3].toString()): " - "%></label><br>
						   								<label class="fs12px">[Forwarded On:&nbsp; <%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString()).substring(0, 10))  +" "+apprInfo[4]!=null?StringEscapeUtils.escapeHtml4(apprInfo[4].toString()).substring(11,19):" - "  %>]</label>
						   			    				<%break;}} %>  
							            			 </div>
							            			 
							            			 <%for(Object[] apprInfo : socApprovalEmpData) {%>
							            			 	<div class="appr-info">
							            			 		<%if(apprInfo[8].toString().equalsIgnoreCase("SAG")){ %>
							            			 			<div class="fs15px"> Signature of GD</div>
								   								<label class="txt-transform mt-15"><%=apprInfo[2]!=null?StringEscapeUtils.escapeHtml4(apprInfo[2].toString()): " - "%></label>,<!-- <br> -->
								   								<label class="txt-transform"><%=apprInfo[3]!=null?StringEscapeUtils.escapeHtml4(apprInfo[3].toString()): " - "%></label><br>
								   								<label class="fs12px" ">[Recommended On:&nbsp; <%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString()).substring(0, 10))  +" "+apprInfo[4]!=null?StringEscapeUtils.escapeHtml4(apprInfo[4].toString()).substring(11,19):" - " %>]</label>
							   			    				<%} else if(apprInfo[8].toString().equalsIgnoreCase("SAA")) {%> 
							   			    					<div class="fs15px"> Signature of AD</div>
							   			    					<label class="txt-transform mt-15"><%=apprInfo[2]!=null?StringEscapeUtils.escapeHtml4(apprInfo[2].toString()): " - "%></label>,<!-- <br> -->
								   								<label class="txt-transform"><%=apprInfo[3]!=null?StringEscapeUtils.escapeHtml4(apprInfo[3].toString()): " - "%></label><br>
								   								<label class="fs12px" ">[Recommended On:&nbsp; <%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString()).substring(0, 10))  +" "+apprInfo[4]!=null?StringEscapeUtils.escapeHtml4(apprInfo[4].toString()).substring(11,19):" - "  %>]</label>
							   			    				<%} else if(apprInfo[8].toString().equalsIgnoreCase("SAP")) {%> 
							   			    					<div class="fs15px"> Signature of GD-DP&C</div>
							   			    					<label class="txt-transform mt-15"><%=apprInfo[2]!=null?StringEscapeUtils.escapeHtml4(apprInfo[2].toString()): " - "%></label>,<!-- <br> -->
								   								<label class="txt-transform"><%=apprInfo[3]!=null?StringEscapeUtils.escapeHtml4(apprInfo[3].toString()): " - "%></label><br>
								   								<label class="fs12px" ">[Recommended On:&nbsp; <%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString()).substring(0, 10))  +" "+apprInfo[4]!=null?StringEscapeUtils.escapeHtml4(apprInfo[4].toString()).substring(11,19) :" - " %>]</label>
							   			    				<%} else if(apprInfo[8].toString().equalsIgnoreCase("SAD")) {%> 
							   			    					<div class="fs15px"> Signature of Director</div>
							   			    					<label class="txt-transform mt-15"><%=apprInfo[2]!=null?StringEscapeUtils.escapeHtml4(apprInfo[2].toString()): " - "%></label>,<!-- <br> -->
								   								<label class="txt-transform"><%=apprInfo[3]!=null?StringEscapeUtils.escapeHtml4(apprInfo[3].toString()): " - "%></label><br>
								   								<label class="fs12px" ">[Recommended On:&nbsp; <%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString()).substring(0, 10))  +" "+apprInfo[4]!=null?StringEscapeUtils.escapeHtml4(apprInfo[4].toString()).substring(11,19):" - "  %>]</label>
							   			    				<%} else if(apprInfo[8].toString().equalsIgnoreCase("SAC")) {%> 
							   			    					<div class="fs15px"> Signature of Competent Authority</div>
							   			    					<label class="txt-transform mt-15"><%=apprInfo[2]!=null?StringEscapeUtils.escapeHtml4(apprInfo[2].toString()): " - "%></label>,<!-- <br> -->
								   								<label class="txt-transform"><%=apprInfo[3]!=null?StringEscapeUtils.escapeHtml4(apprInfo[3].toString()): " - "%></label><br>
								   								<label class="fs12px" ">[Approved On:&nbsp; <%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString()).substring(0, 10)) %>]</label>
							   			    			
							   			    				<%} %>
							            			 	</div>	
							            			 <%} %>
							            			 
							            			 <!-- Remarks History -->
							            			 <div class="row mt-2 ml18px">
														<%if(socRemarksHistory.size()>0){ %>
															<div class="col-md-8 remark-history" align="left">
																<%if(socRemarksHistory.size()>0){ %>
																	<table class="mr3-pd0">
																		<tr>
																			<td class="bdnone-pd0">
																			<h6 class="txt-decoration">Remarks :</h6> 
																			</td>											
																		</tr>
																		<%for(Object[] obj : socRemarksHistory){%>
																		<tr>
																			<td class="soc-remark-history">
																				<%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - "%>&nbsp; :
																				<span class="bdnone-colorblue">	<%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %></span>
																			</td>
																		</tr>
																		<%} %>
																	</table>
																<%} %>
															</div>
														<%} %>
					   								</div>
							            			
							            			<div class="row mt-2 mb-4 ml18px">
														<div class="col-md-12" align="center">
															<%if(statuscode!=null && socforward.contains(statuscode)) {%>
																<div class="ml-2" align="left">
									   								<b >Remarks :</b><br>
									   								<textarea rows="3" cols="65" name="remarks" id="remarksarea"></textarea>
								         						</div>
																<button type="submit" class="btn btn-sm submit" name="Action" formaction="ProjectClosureSoCApprovalSubmit.htm" value="A" onclick="return confirm('Are you Sure to Submit ?');">Forward</button>
															<%} %>
															<%if(isApproval!=null && isApproval.equalsIgnoreCase("Y")) {%>
																<%if(statuscode!=null && statuscode.contains("SAD")  ) {%>
																	<div class="row externalapproval">
																		<div class="col-md-3">
																			<label class="control-label">Lab</label><span class="mandatory">*</span>
																			<select class="form-control selectdee" id="LabCode" name="LabCode" onchange="LabcodeSubmit()" data-live-search="true"  required="required">
		        																<option disabled="disabled" value="" selected="selected"> Select</option>
																					<%if (labList != null && labList.size() > 0) {
																						for (Object[] obj : labList) {
																					%>
																						<option value=<%=obj[2].toString()%>><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%></option>
																					<%}}%>
																					<option value="@EXP">Expert</option>
																			</select>
																		</div>
																		<div class="col-md-3">
																			<label class="control-label">Approval Officer</label><span class="mandatory">*</span>
				  															<select class="form-control selectdee" id="approverEmpId" name="approverEmpId" data-live-search="true" required>
				  																<option disabled="disabled" value="" selected="selected"> Select</option>
				  															</select>
																		</div>
																		<div class="col-md-2">
																			<label class="control-label" >Approval Date</label><span class="mandatory">*</span>
			          														<input type="text" class="form-control" id="approvalDate" name="approvalDate">
																		</div>
																		<div class="col-md-4"></div>
																		
																	</div>
																<%} %>
																
																<div class="ml-2" align="left">
									   								<b >Remarks :</b><br>
									   								<textarea rows="3" cols="65" name="remarks" id="remarksarea"></textarea>
								         						</div>
								         						<%if(statuscode!=null && (statuscode.contains("SAP") || statuscode.contains("SAD"))) {%>
								         						<button type="submit" class="btn btn-sm btn-success fw-600" id="finalSubmission" formaction="ProjectClosureSoCApprovalSubmit.htm" name="Action" value="A" onclick="return confirm('Are You Sure To Approve?');">
										    						Approve	
									      						</button>
									      						
									      						<button type="submit" class="btn btn-sm btn-danger fw-600 return-btn-color" id="finalSubmission" formaction="ProjectClosureSoCApprovalSubmit.htm" name="Action" value="R" onclick="return validateTextBox();">
										 							Return
																</button>
								         						<%} else{%>
																<button type="submit" class="btn btn-sm btn-success fw-600" id="finalSubmission" formaction="ProjectClosureSoCApprovalSubmit.htm" name="Action" value="A" onclick="return confirm('Are You Sure To Recommend?');">
										    						Recommend	
									      						</button>
									      						
									      						<button type="submit" class="btn btn-sm btn-danger fw-600 return-btn-color" id="finalSubmission" formaction="ProjectClosureSoCApprovalSubmit.htm" name="Action" value="R" onclick="return validateTextBox();">
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
			               			<div class="mt-4 heading-2">
			               				<h4 class="heading-2-size">Please fill SoC Details..!</h4>
			               			</div>
               					<%} %>
               					
               					<div class="disflex-juscont">
	               					<div></div>
		               				<div>
		               					<%if(isApproval==null) {%>
		               					<div class="row"  >
				 		  					<div class="col-md-12 text-center"><b>Approval Flow For SoC Approval</b></div>
				 	    				</div>
				 	    				<div class="row txt-pt10-pb15">
			              					<table align="center"  >
			               						<tr>
			               							<td class="trup pd-data">
			                							PD -  <%=PDData[2]!=null?StringEscapeUtils.escapeHtml4(PDData[2].toString()): " - " %>
			                						</td>
			                		
		                        					<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						<td class="trup gd-data">
			                							GD - <%if(GD!=null) {%><%=GD[1]!=null?StringEscapeUtils.escapeHtml4(GD[1].toString()): " - " %> <%} else{%>GD<%} %>
			                	    				</td>
			                	    				
			                	    				<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						<td class="trup ad-data">
			                							AD - <%if(AD!=null) {%><%=AD[1]!=null?StringEscapeUtils.escapeHtml4(AD[1].toString()): " - " %> <%} else{%>AD<%} %>
			                	    				</td>
			                	    				
			                	    				<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						<td class="trup dpnc-data">
			                							GD-DP&C - <%if(GDDPandC!=null) {%><%=GDDPandC[1]!=null?StringEscapeUtils.escapeHtml4(GDDPandC[1].toString()): " - " %> <%} else{%>GD-DP&C<%} %>
			                	    				</td>
			                	    				
			                	    				<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						<td class="trup director-data">
			                							Director - <%if(Director!=null) {%><%=Director[1]!=null?StringEscapeUtils.escapeHtml4(Director[1].toString()): " - " %> <%} else{%>Director<%} %>
			                	    				</td>
			                	    				
			                	    				<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						
			                						<td class="trup ca-data">
			                							Competent Authority - Competent Authority
			                	    				</td>
			               						</tr> 	
			               	    			</table>			             
					 					</div>
					 					<%} %>
		               				</div>
		               				<div class="navigation_btn text-right">
		            					<a class="btn btn-info btn-sm  shadow-nohover previous" >Previous</a>
										<button class="btn btn-info btn-sm next">Next</button>
									</div>
               					</div>
               			
               			<%if(socTabId!=null && socTabId.equalsIgnoreCase("2")){ %> 
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
$('#expndAsOn').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	/* "minDate" :datearray,   */
	 /* "startDate" : new Date(), */
	 "maxDate" : new Date(), 
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});	
</script>

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

<!-- <script type="text/javascript">
$(document).ready(function(){
	closurecategorychange();
});

function closurecategorychange(){
	var closureCategory = $('#closureCategory').val();
	
	if(closureCategory=='Completed Successfully' || closureCategory=='Partial Success'){
		$('#recommendationdiv').show();
		$('#recommendation').prop('required', true);
	}else{
		$('#recommendationdiv').hide();
		$('#recommendation').prop('required', false);
	}
}
</script> -->

<script type="text/javascript">
/* button disabling for SoC Approval */
<%if((soc!=null && socforward.contains(closure.getClosureStatusCode())) || soc==null) {%>
$('.btn-soc').prop('disabled',false);
<%} else{%>
$('.btn-soc').prop('disabled',true);
<%} %>

/* tabs hiding for SoC approval */
<%if(isApproval!=null && (isApproval.equalsIgnoreCase("Y") || isApproval.equalsIgnoreCase("N"))) {%>
   $('.navigation_btn').hide();
   $('#nav-socdetails').hide();
<%} %>
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
function LabcodeSubmit() {
	   var LabCode = document.getElementById("LabCode").value;
	   $('#approverEmpId').empty();
	   $.ajax({
	       type: "GET",
	       url: "GetLabcodeEmpList.htm",
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
	/* "minDate" :datearray,   */
	 /* "startDate" : new Date(), */
	 "maxDate" : new Date(), 
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});	
</script>
</body>
</html>
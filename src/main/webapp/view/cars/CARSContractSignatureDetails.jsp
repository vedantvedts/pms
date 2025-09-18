<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.cars.model.CARSSoC"%>
<%@page import="com.vts.pfms.IndianRupeeFormat"%>
<%@page import="com.vts.pfms.cars.model.CARSContract"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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
<spring:url value="/resources/css/projectdetails.css" var="projetdetailscss" />
<spring:url value="/resources/ckeditor/ckeditor.js" var="ckeditor" />
<spring:url value="/resources/ckeditor/contents.css" var="contentCss" />
<script src="${ckeditor}"></script>
<link href="${contentCss}" rel="stylesheet" />
<link href="${projetdetailscss}" rel="stylesheet" />
<spring:url value="/resources/css/cars/CARSContractSignatureDetails.css" var="carscontractSignatureDetails" />
<link href="${carscontractSignatureDetails}" rel="stylesheet" />


</head>
<body>
<%
String csDocsTabId = (String)request.getAttribute("csDocsTabId"); 
String isApproval = (String)request.getAttribute("isApproval");

CARSInitiation carsIni = (CARSInitiation)request.getAttribute("CARSInitiationData"); 
CARSSoC carsSoC = (CARSSoC)request.getAttribute("CARSSoCData"); 
CARSContract carsContract = (CARSContract)request.getAttribute("CARSContractData"); 
List<CARSOtherDocDetails> otherdocdetails = (List<CARSOtherDocDetails>)request.getAttribute("CARSOtherDocDetailsData");
List<Object[]> othersCSRemarksHistory = (List<Object[]>)request.getAttribute("CARSOthersCSRemarksHistory");
List<Object[]> othersCSApprovalEmpData = (List<Object[]>)request.getAttribute("OthersCSApprovalEmpData");

List<CARSOtherDocDetails> csdetailslist = otherdocdetails.stream().filter(e-> "C".equalsIgnoreCase(e.getOtherDocType())).collect(Collectors.toList());

CARSOtherDocDetails csdetails = csdetailslist!=null && csdetailslist.size()>0?csdetailslist.get(0):null;

List<String> csforwardstatus = Arrays.asList("SAD","SAI","ADG","SAS","CIN","CRA","CRD","CRV");

Object[] GHDPandC = (Object[])request.getAttribute("GHDPandC");
Object[] GDDPandC = (Object[])request.getAttribute("GDDPandC");
Object[] ADDPandC = (Object[])request.getAttribute("ADDPandC");
Object[] Director = (Object[])request.getAttribute("Director");
Object[] PDs = (Object[])request.getAttribute("PDEmpIds");

FormatConverter fc = new FormatConverter();
SimpleDateFormat rdf = fc.getRegularDateFormat();
SimpleDateFormat sdf = fc.getSqlDateFormat();

String labcode =(String)session.getAttribute("labcode");
String EmpId =((Long) session.getAttribute("EmpId")).toString();

long carsInitiationId = carsIni.getCARSInitiationId();
String statuscode = carsIni.getCARSStatusCode();

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
         		<div class="card-header slider_header p-0 f-12 h-0-p"  >
             		<h3 class="category">Contract Details - 
             			
             			<button type="button" class="btn btn-sm btn-info btn-det" >
             				<div>
					        	<div class="row">
					        		<div class="col-md-1">
					        			<span class="cssideheading">Title:</span>
					                </div>
					            	<div class="col-md-11 ml-minus-5" >
					                	<span class="cssideheadingdata"><%if(carsIni!=null && carsIni.getInitiationTitle()!=null) {%><%=StringEscapeUtils.escapeHtml4(carsIni.getInitiationTitle()) %> <%} else{%>-<%} %></span>
					                </div>
					                
					            </div>
					                	
					            <div class="row">
					            	<div class="col-md-4">
					                	<span class="cssideheading">CARS. No:</span>
					                	&emsp;<span class="cssideheadingdata"><%if(carsIni!=null && carsIni.getCARSNo()!=null) {%><%=StringEscapeUtils.escapeHtml4(carsIni.getCARSNo()) %> <%} else{%>-<%} %></span>
					            	</div>
					            <div class="col-md-1"></div>
					            <div class="col-md-3">
					            	<span class="cssideheading">Funds from:</span>
					                &emsp;<span class="cssideheadingdata">
					                	<%if(carsIni!=null && carsIni.getFundsFrom()!=null && carsIni.getFundsFrom().equalsIgnoreCase("0")) {%>
					                		Buildup
					                	<%} else{%>
					                		<%if(PDs!=null && PDs[3]!=null) {%><%=StringEscapeUtils.escapeHtml4(PDs[3].toString())%> (<%=PDs[0]!=null?StringEscapeUtils.escapeHtml4(PDs[0].toString()): " - " %>)<%} %>
					                	<%} %>
					                	</span>
					            </div>
					            <div class="col-md-1"></div>
					            	<div class="col-md-3">
					                	<span class="cssideheading">Amount:</span>
					                		&emsp;<span class="cssideheadingdata">
					                		<%if(carsSoC!=null && carsSoC.getSoCAmount()!=null) {%>
					                			<%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(carsSoC.getSoCAmount())) %>
					                		<%} else{%>-<%} %>
					                	</span>
					                </div>
					            </div>
					                		
					        </div>
             			</button>
             			
             			<a class="btn btn-info btn-sm  shadow-nohover back text-white f-right"
             			<%if(isApproval!=null && isApproval.equalsIgnoreCase("C") ) {%>
               				href="CARSRSQRApprovals.htm"
               			<%} else if(isApproval!=null && isApproval.equalsIgnoreCase("D") ) {%>
               				href="CARSRSQRApprovals.htm?val=app"
               			<%} else {%>
             			    href="CARSOtherDocsList.htm?carsInitiationId=<%=carsInitiationId %>"
             			<%} %> >Back</a>
             		</h3>
             		<hr class="mar-8">
             		<ul class="nav nav-tabs justify-content-center pb-0" role="tablist" >

            			<li class="nav-item" id="nav-csdetails">
             				<%if(csDocsTabId!=null && csDocsTabId.equalsIgnoreCase("1")){ %> 
             		    		<a class="nav-link active " data-toggle="tab" href="#csdetails" id="nav" role="tab">
             				<%}else{ %>
              			 		<a class="nav-link  " data-toggle="tab" href="#csdetails" role="tab">
               				<%} %>  
               					
                	         	Doc Details
              			 		</a>
            			</li>

            			<li class="nav-item" id="nav-csapproval">
            	     		<%if(csDocsTabId!=null && csDocsTabId.equalsIgnoreCase("2")){ %>
              					<a class="nav-link active" data-toggle="tab" href="#csapproval" id="nav"role="tab" >
              				<%}else{ %>
              					<a class="nav-link" data-toggle="tab" href="#csapproval" role="tab" >
               				<%} %>
                  				Contract Approval
              					</a>
            			</li>
            			
            			<li class="nav-item" id="nav-docuploads">
		            	     <%if(csDocsTabId!=null && csDocsTabId.equalsIgnoreCase("3")){ %>
		              			<a class="nav-link active" data-toggle="tab" href="#docuploads" id="nav"role="tab" >
		              		<%}else{ %>
		              			<a class="nav-link" data-toggle="tab" href="#docuploads" role="tab" >
		               		<%} %>
                  				Doc Upload
              					</a>
            			</li>
              		</ul>
         		</div>
         		<!-- This is for Tab Panes -->
         		<div class="card">
         			<div class="tab-content text-center mt-1">
         				<!-- *********** Others Details ***********      --> 
               			<%if(csDocsTabId!=null && csDocsTabId.equalsIgnoreCase("1")){ %> 
         					<div class="tab-pane active" id="csdetails" role="tabpanel">
         				<%}else{ %>
              				<div class="tab-pane " id="csdetails" role="tabpanel">
               			<%} %>
               					<div class="container">
									<div class="row w-140"  >
										<div class="col-md-12">
											<div class="card shadow-nohover" >
												<div class="card-header header-bg"  >
								                    <b class="text-white" >CARS Contract Signature Details: </b> 
								                    <hr>
								                    <span class="text-white f-right fw-600" > </span>
							        			</div> 
												<div class="card-body">
								        		
													<form action="CARSCSDocDetailsSubmit.htm" method="POST" enctype="multipart/form-data">
														<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
												    	<input type="hidden" name="carsInitiationId" value="<%=carsIni.getCARSInitiationId()%>">
												    	<input type="hidden" name="otherDocDetailsId" value="<%if(csdetails!=null){%><%=csdetails.getOtherDocDetailsId() %><%}%>">
												    	<input type="hidden" name="otherDocType" value="C">
												    	<div class="row mlr-2" >
												    		
												        	<div class="col-md-3" >
												        		<div class="form-group">
												                	<label class="control-label">Date:</label><span class="mandatory">*</span>
												                    <input  class="form-control form-control" type="text" name="csOtherDocDate" id="csOtherDocDate"
												                     value="<%if(csdetails!=null && csdetails.getOtherDocDate()!=null) {%><%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(csdetails.getOtherDocDate())) %><%} %>" required readonly> 
												                </div>
												            </div>
												        	
												        	<div class="col-md-3" >
												        		<div class="form-group">
												                	<label class="control-label">Flag-A</label><span class="mandatory">*</span>
												                    <%if(csdetails!=null && csdetails.getAttachFlagA()!=null) {%>
				                            					 		<button type="submit" class="btn btn-sm btn-sub-doc" name="filename" formmethod="post" formnovalidate="formnovalidate"
				                            					 		  value="flagAFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
				                            					 			<i class="fa fa-download fa-lg"></i>
				                            					 		</button>
                          					 						<%} %>
                            		      							<input type="file" class="form-control modals" name="attatchFlagA" <%if(csdetails==null) {%>required<%} %> accept=".pdf">
												                </div>
												            </div>
												        	<div class="col-md-3" >
												        		<div class="form-group">
												                	<label class="control-label">Flag-B</label><span class="mandatory">*</span>
												                    <%if(csdetails!=null && csdetails.getAttachFlagB()!=null) {%>
				                            					 		<button type="submit" class="btn btn-sm btn-sub-doc" name="filename" formmethod="post" formnovalidate="formnovalidate"
				                            					 		  value="flagBFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
				                            					 			<i class="fa fa-download fa-lg"></i>
				                            					 		</button>
                          					 						<%} %>
                            		      							<input type="file" class="form-control modals" name="attatchFlagB" <%if(csdetails==null) {%>required<%} %> accept=".pdf">
												                </div>
												            </div>
												        	<div class="col-md-3" >
												        		<div class="form-group">
												                	<label class="control-label">Flag-C</label><span class="mandatory">*</span>
												                    <%if(csdetails!=null && csdetails.getAttachFlagC()!=null) {%>
				                            					 		<button type="submit" class="btn btn-sm btn-sub-doc" name="filename" formmethod="post" formnovalidate="formnovalidate"
				                            					 		  value="flagCFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
				                            					 			<i class="fa fa-download fa-lg"></i>
				                            					 		</button>
                          					 						<%} %>
                            		      							<input type="file" class="form-control modals" name="attatchFlagC" <%if(csdetails==null) {%>required<%} %> accept=".pdf">
												                </div>
												            </div>
												        </div>
												        
												        <div class="row mlr-2" >
												        	<div class="col-md-2">
												        		<div class="form-group">
												        			<label class="control-label">Info <button type="button" id="csInfo" value="1" class="btn btn-info btn-sm btn-in-fo" ><i class="fa fa-info-circle" aria-hidden="true"></i></button></label>
												        		</div>
												        	</div>
												        	<div class="col-md-10" id="csInfoContent" >
												        		<div class="form-group w-110">
												        			<span class="col-crimson">Flag-A : </span> <span>SoC from for CARS collaboration with Institute/ University has been approved by CFA.</span> <br>
												        			<span class="col-fuchsia">Flag-B : </span> <span>The final RSQR, Milestones and payment terms are attached. </span> <br>
												        			<span class="col-blue">Flag-C : </span> <span>The contract signed by competent authority of the RSP is placed opposite for CFA's signature please.</span> 
												        		</div>
												        	</div>
												        </div>
												        
												    	<div align="center">
															<%if(csdetails!=null){ %>
																<button type="submit" class="btn btn-sm btn-warning edit btn-cs" name="Action" value="Edit" onclick="return confirm('Are you sure to update?')" >UPDATE</button>
															<%}else{ %>
																<button type="submit" class="btn btn-sm btn-success submit btn-cs" name="Action" value="Add" onclick="return confirm('Are you sure to submit?')" >SUBMIT</button>
															<%} %>
														</div>
												    </form>
								    				<br>
												    
												</div>
											</div>
										</div>
									</div>
								</div>
               					<div class="navigation_btn text-right" >
            						<a class="btn btn-info btn-sm text-white shadow-nohover back" href="CARSOtherDocsList.htm?carsInitiationId=<%=carsInitiationId %>">Back</a>
									<button class="btn btn-info btn-sm next">Next</button>
								</div>
               			<%if(csDocsTabId!=null && csDocsTabId.equalsIgnoreCase("1")){ %> 
         					</div>
         				<%}else{ %>
              				</div>
               			<%} %>
               			
               			<!-- *********** Contract Signature Approval ***********      --> 
               			<%if(csDocsTabId!=null && csDocsTabId.equalsIgnoreCase("2")){ %> 
         					<div class="tab-pane active" id="csapproval" role="tabpanel">
         				<%}else{ %>
              				<div class="tab-pane " id="csapproval" role="tabpanel">
               			<%} %>
               					<%if(csdetails!=null) {%>
		               				<div class="col-md-8 mt-1">
               							<div class="card card-mg">
               								<div class="card-body mt-2 ml-4">
               									<form action="#">
               										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			               		   					<input type="hidden" name="carsInitiationId" value="<%=carsIni.getCARSInitiationId()%>">
			               		   					<input type="hidden" name="otherDocDetailsId" value="<%if(csdetails!=null){%><%=csdetails.getOtherDocDetailsId() %><%}%>">
			               		   					<input type="hidden" name="otherDocType" value="C">
			               		   					<div class="mt-2" align="center">
               											<h5 class="lab-code"><%=labcode %></h5>
               											
               											<span class="span-dir">Directorate of Planning & Coordination</span>
               										</div>
               										
               										<div class="row">
					               		   				<!-- <div class="col-md-1"></div> -->
					               		   				<div class="col-md-3">
					               		   					<span>No:</span> <span><%=carsContract.getContractNo() !=null?StringEscapeUtils.escapeHtml4(carsContract.getContractNo()): " - "%> </span>
					               		   				</div>
					               		   				<div class="col-md-6">
					               		   				</div>
					               		   				<div class="col-md-3">
					               		   					<span>Date:</span> <span><%if(csdetails.getOtherDocDate()!=null) {%> <%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(csdetails.getOtherDocDate())) %><%} else{%><%=rdf.format(new Date()) %><%} %> </span>
					               		   				</div>
					               		   				<!-- <div class="col-md-1"></div> -->
			               		   					</div>
			               		   					<hr>
					               		   			<div class="row">
					               		   				<div class="col-md-12 mt-2" align="center">
		               										<h5 class="lab-code">CARS contract signature</h5>
		               											
		               										<span class="span-font-l"><%=carsIni.getInitiationTitle()!=null?StringEscapeUtils.escapeHtml4(carsIni.getInitiationTitle()): " - " %> </span>
		               									</div>
					               		   			</div>
			               		   					<br>
					               		   			<div class="row">
					               		   				<!-- <div class="col-md-1"></div> -->
					               		   				<div class="col-md-12 text-left" >
					               		   					<span>
					               		   						1)	SoC from 
					               		   						<%if(carsIni!=null && carsIni.getFundsFrom().equalsIgnoreCase("0")) {%>
					               		   							Directorate
					               		   						<%} else{%>
					               		   							<%if(PDs[4]!=null) {%><%=StringEscapeUtils.escapeHtml4(PDs[4].toString()) %><%} else{%>-<%} %>
					               		   						<%} %>  
					               		   						for CARS collaboration with <%if(carsIni!=null) {%><%=carsIni.getRSPInstitute()!=null?StringEscapeUtils.escapeHtml4(carsIni.getRSPInstitute()): " - "%>, <%=carsIni.getRSPCity()!=null?StringEscapeUtils.escapeHtml4(carsIni.getRSPCity()): " - " %> <%} %> has been approved by CFA. (Flag-A)
					               		   					</span>
					               		   					<span>
					               		   						<%if(csdetails!=null && csdetails.getAttachFlagA()!=null) {%>
							                            			<button type="submit" class="btn btn-sm btn-sub-doc"  name="filename" formmethod="post" formnovalidate="formnovalidate"
							                            				value="flagAFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
							                            				<i class="fa fa-download"></i>
							                            			</button>
		                          					 			<%} %>
					               		   					</span>
					               		   					
					               		   				</div>
					               		   				<!-- <div class="col-md-1"></div> -->
					               		   			</div>
					               		   			<div class="row">
					               		   				<!-- <div class="col-md-1"></div> -->
					               		   				<div class="col-md-12 text-left" >
					               		   					<span>
					               		   						2)	The final RSQR, Milestones and payment terms are attached. (Flag-B)
					               		   					</span>
					               		   					<span>
					               		   						<%if(csdetails!=null && csdetails.getAttachFlagB()!=null) {%>
							                            			<button type="submit" class="btn btn-sm btn-sub-doc" name="filename" formmethod="post" formnovalidate="formnovalidate"
							                            				value="flagBFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
							                            				<i class="fa fa-download"></i>
							                            			</button>
		                          					 			<%} %>
					               		   					</span>
					               		   				</div>
					               		   				<!-- <div class="col-md-1"></div> -->
					               		   			</div>
					               		   			<div class="row">
					               		   				<!-- <div class="col-md-1"></div> -->
					               		   				<div class="col-md-12 text-left" >
					               		   					<span>
					               		   						3)	The contract signed by competent authority of the RSP is placed opposite for CFA's signature please.  (Flag-C) 
					               		   					</span>
					               		   					<span>
					               		   						<%if(csdetails!=null && csdetails.getAttachFlagC()!=null) {%>
							                            			<button type="submit" class="btn btn-sm btn-sub-doc" name="filename" formmethod="post" formnovalidate="formnovalidate"
							                            				value="flagCFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
							                            				<i class="fa fa-download"></i>
							                            			</button>
		                          					 			<%} %>
					               		   					</span>
					               		   				</div>
					               		   				<!-- <div class="col-md-1"></div> -->
					               		   			</div>
			               		   					<br>
			               		   					
					               		   			<!-- Signatures and timestamps -->
					               		   			<div class="tab-div">
				               							<div class="input-font"> Signature of GD-DP&C</div>
								               			<%for(Object[] apprInfo : othersCSApprovalEmpData){ %>
								   			   				<%if(apprInfo[8].toString().equalsIgnoreCase("CFW")){ %>
								   								<label class="text-uppercase mt-3"><%=apprInfo[2]!=null?StringEscapeUtils.escapeHtml4(apprInfo[2].toString()): " - "%></label>,<!-- <br> -->
								   								<label class="text-uppercase"><%=apprInfo[3]!=null?StringEscapeUtils.escapeHtml4(apprInfo[3].toString()): " - "%></label><br>
								   								<label class="f-12">[Forwarded On:&nbsp; <%=apprInfo[4]!=null?(fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString()).substring(0, 10)) +" "+ StringEscapeUtils.escapeHtml4(apprInfo[4].toString()).substring(11,19)):" - " %>]</label>
								   			    		<%break;}} %>  
									            	</div>
							            	
									            	<%for(Object[] apprInfo : othersCSApprovalEmpData) {%>
									            		<div class="div-tab">
										            			 		
										            		<%if(apprInfo[8].toString().equalsIgnoreCase("CFA")){ %>
									            				<div class="input-font" > Signature of AD-P&C</div>
										   						<label class="text-uppercase mt-3" ><%=apprInfo[2]!=null?StringEscapeUtils.escapeHtml4(apprInfo[2].toString()): " - "%></label>,<!-- <br> -->
										   						<label class="text-uppercase" ><%=apprInfo[3]!=null?StringEscapeUtils.escapeHtml4(apprInfo[3].toString()): " - "%></label><br>
										   						<label  class="f-12" >[Recommended On:&nbsp; <%=apprInfo[4]!=null?(fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString()).substring(0, 10)) +" "+ StringEscapeUtils.escapeHtml4(apprInfo[4].toString()).substring(11,19)):" - " %>]</label>
										   					<%} else if(apprInfo[8].toString().equalsIgnoreCase("CAD")) {%> 
									   			    			<div class="input-font"> Signature of Director</div>
									   			    			<label class="text-uppercase mt-3" ><%=apprInfo[2]!=null?StringEscapeUtils.escapeHtml4(apprInfo[2].toString()): " - "%></label>,<!-- <br> -->
										   						<label class="text-uppercase"><%=apprInfo[3]!=null?StringEscapeUtils.escapeHtml4(apprInfo[3].toString()): " - "%></label><br>
										   						<label class="f-12">[Approved On:&nbsp; <%=apprInfo[4]!=null?(fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString()).substring(0, 10)) +" "+ StringEscapeUtils.escapeHtml4(apprInfo[4].toString()).substring(11,19)):" - " %>]</label>
									   			    					
									   			    		<%} %>
									   			    	</div>
									   			    <%} %>
							   			    
									   			    <!-- Remarks -->
					               		   			<div class="row mt-2">
														<%if(othersCSRemarksHistory.size()>0){ %>
															<div class="col-md-8 div-margin" align="left">
																<%if(othersCSRemarksHistory.size()>0){ %>
																	<table class="m-1 p-0">
																		<tr>
																			<td class="bor-none p-0" >
																				<h6 class="text-ul">Remarks :</h6> 
																			</td>											
																		</tr>
																		<%for(Object[] obj : othersCSRemarksHistory){%>
																			<tr>
																				<td class="cs-td">
																					<%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - "%>&nbsp; :
																					<span class="bor-none col-blue">	<%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %></span>
																				</td>
																			</tr>
																		<%} %>
																	</table>
																<%} %>
															</div>
														<%} %>
							   						</div>
							   						
							   						<div class="row mt-2 mb-4">
														<div class="col-md-12" align="center">
															<%if(statuscode!=null && csforwardstatus.contains(statuscode) && ( GDDPandC!=null && EmpId.equalsIgnoreCase(GDDPandC[0].toString()) ) ) {%>
																<div class="ml-2" align="left">
									   								<b >Remarks :</b><br>
									   								<textarea rows="3" cols="65" name="remarks" id="remarksarea"></textarea>
								         						</div>
																<button type="submit" class="btn btn-sm submit" id="" name="Action" formaction="OthersCSApprovalSubmit.htm" formnovalidate="formnovalidate" value="A" onclick="return confirm('Are you Sure to Submit ?');" >Forward</button>
															<%} %>
															<%if(isApproval!=null && isApproval.equalsIgnoreCase("C")) {%>
																
																<div class="ml-2" align="left">
									   								<b >Remarks :</b><br>
									   								<textarea rows="3" cols="65" name="remarks" id="remarksarea"></textarea>
								         						</div>
								         						<%if(statuscode!=null && statuscode.equalsIgnoreCase("CFA")) {%>
								         						<button type="submit" class="btn btn-sm btn-success fw-600" id="finalSubmission" formaction="OthersCSApprovalSubmit.htm" name="Action" value="A" onclick="return confirm('Are You Sure To Approve?');">
										    						Approve	
									      						</button>
									      						<button type="submit" class="btn btn-sm btn-danger btn-bg-1 fw-600" id="finalSubmission" formaction="OthersCSApprovalSubmit.htm" name="Action" value="R" onclick="return validateTextBox();">
										 							Return
																</button>
								         						<%} else{%>
																<button type="submit" class="btn btn-sm btn-success fw-600" id="finalSubmission" formaction="OthersCSApprovalSubmit.htm" name="Action" value="A" onclick="return confirm('Are You Sure To Recommend?');" >
										    						Recommend	
									      						</button>
									      						
									      						<button type="submit" class="btn btn-sm btn-danger fw-600 btn-bg-1" id="finalSubmission" formaction="OthersCSApprovalSubmit.htm" name="Action" value="R" onclick="return validateTextBox();" >
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
               						<div class="mt-4 txt-cen">
               							<h4 class="mandatory fw-bold">Please fill the Contract Signature Details..!</h4>
               						</div>
               					<%} %>   
			               		
			               		<div class="div-jc">
               						<div></div>
		               				<div>
		               					<%if(carsIni!=null && isApproval==null) {%>
		               					<div class="row"  >
				 		  					<div class="col-md-12 text-center"><b>Approval Flow For Contract Signature</b></div>
				 	    				</div>
				 	    				<div class="row text-center pt-2 pb-3"  >
			              					<table align="center"  >
			               						<tr>
			               							<td class="trup trup-bg-1">
			                							GD-DP&C - <%if(GDDPandC!=null) {%> <%=StringEscapeUtils.escapeHtml4(GDDPandC[1].toString()) %> <%} else {%> GD-DP&C <%} %>
			                						</td>
			                		
		                        					<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						
			                						<td class="trup trup-bg-2" >
			                							AD-D&C - <%if(ADDPandC!=null) {%> <%=StringEscapeUtils.escapeHtml4(ADDPandC[1].toString()) %> <%} else {%> AD-P&C <%} %>
			                	    				</td>
			                	    				
			                	    				<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						
			                						<td class="trup trup-bg-3" >
			                							DIRECTOR - <%if(Director!=null) {%> <%=StringEscapeUtils.escapeHtml4(Director[1].toString()) %> <%} else {%> DIRECTOR <%} %>
			                	    				</td>
			               						</tr> 	
			               	    			</table>			             
					 					</div>
					 					<%} %>
		               				</div>
		               				<div class="navigation_btn text-right"  >
		            					<a class="btn btn-info btn-sm  shadow-nohover previous" >Previous</a>
										<button class="btn btn-info btn-sm next">Next</button>
									</div>
               					</div>

               			<%if(csDocsTabId!=null && csDocsTabId.equalsIgnoreCase("2")){ %> 
         					</div>
         				<%}else{ %>
              				</div>
               			<%} %>
               			
               			<!-- *********** Doc Upload ***********      --> 
               			<%if(csDocsTabId!=null && csDocsTabId.equalsIgnoreCase("3")){ %> 
         					<div class="tab-pane active" id="docuploads" role="tabpanel">
         				<%}else{ %>
              				<div class="tab-pane " id="docuploads" role="tabpanel">
               			<%} %>
               					<%if(csdetails!=null) {%>
		               				<div class="col-md-8 mt-4">
		               					<div class="card card-m-bg">
		               						<div class="card-body mt-2 ml-4">
			               						<form action="#">
			               							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			               							<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId%>">
			               							<input type="hidden" name="otherDocDetailsId" value="<%if(csdetails!=null){%><%=csdetails.getOtherDocDetailsId() %><%}%>">
			               							<input type="hidden" name="otherDocType" value="C">
			               							<table id="alldocstable">
			               								<thead>
			               									<tr>
			               										<th class="w-10" >SN</th>
			               										<th>Subject</th>
			               										<th class="w-10" >Action</th>
			               									</tr>
			               								</thead>
			               								<tbody>
			               									<tr>
			               										<td>1.</td>
			               										<td>Contract Signature Approval form</td>
			               										<td>
			               											<button type="submit" class="btn btn-sm" formaction="CARSCSDownload.htm"  formtarget="_blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="CARS Contract Signature Download" >
																		<i class="fa fa-download fa-lg" aria-hidden="true"></i>
																	</button>
			               										</td>
			               									</tr>
			               									<tr>
			               										<td>2.</td>
			               										<td>
			               											SoC from 
																	<%if(carsIni!=null && carsIni.getFundsFrom().equalsIgnoreCase("0")) {%>
																		Directorate
																	<%} else{%>
																	<%if(PDs!=null) {%><%=StringEscapeUtils.escapeHtml4(PDs[4].toString()) %><%} else{%>-<%} %>
																	<%} %>  
																	for CARS collaboration with <%if(carsIni!=null) {%><%=StringEscapeUtils.escapeHtml4(carsIni.getRSPInstitute())+", "+StringEscapeUtils.escapeHtml4(carsIni.getRSPCity()) %> <%} %> has been approved by CFA. (Flag-A)
			               										</td>
			               										<td>
			               											<%if(csdetails!=null && csdetails.getAttachFlagA()!=null) {%>
							                            			<button type="submit" class="btn btn-sm btn-sum-doc-up"  name="filename" formmethod="post" formnovalidate="formnovalidate"
							                            				value="flagAFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
							                            				<i class="fa fa-download fa-lg"></i>
							                            			</button>
                            					 					<%} else {%>
                            					 						-
                            					 					<%} %>
			               										</td>
			               									</tr>
			               									<tr>
			               										<td>3.</td>
			               										<td>The final RSQR, Milestones and payment terms are attached. (Flag-B)</td>
			               										<td>
			               											<%if(csdetails!=null && csdetails.getAttachFlagB()!=null) {%>
								                            			<button type="submit" class="btn btn-sm btn-sum-doc-up" name="filename" formmethod="post" formnovalidate="formnovalidate"
								                            				value="flagBFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
								                            				<i class="fa fa-download fa-lg"></i>
								                            			</button>
		                          					 				<%} %>
			               										</td>
			               									</tr>
			               									<tr>
			               										<td>4.</td>
			               										<td>The contract signed by competent authority of the RSP is placed opposite for CFA's signature please. (Flag-C)</td>
			               										<td>
			               											<%if(csdetails!=null && csdetails.getAttachFlagC()!=null) {%>
								                            			<button type="submit" class="btn btn-sm btn-sum-doc-up" name="filename" formmethod="post" formnovalidate="formnovalidate"
								                            				value="flagCFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
								                            				<i class="fa fa-download fa-lg"></i>
								                            			</button>
		                          					 				<%} %>
			               										</td>
			               									</tr>
			               									<tr>
			               										<td>5.</td>
			               										<td>Uploaded Contract Signature Approval form (After approval)</td>
			               										<td>
			               											<%if(csdetails!=null && csdetails.getUploadOtherDoc()!=null) {%>
								                            			<button type="submit" class="btn btn-sm btn-sum-doc-up" name="filename" formmethod="post" formnovalidate="formnovalidate"
								                            				value="fileOtherDoc" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
								                            				<i class="fa fa-download fa-lg"></i>
								                            			</button>
		                          					 				<%} else{%>
		                          					 				 Not Uploaded
		                          					 				<%} %>
			               										</td>
			               									</tr>
			               								</tbody>
			               							</table>
			               						</form>
			               						
			               						<%if( (statuscode!=null && statuscode.equalsIgnoreCase("CAD") ) || (csdetails!=null && csdetails.getUploadOtherDoc()!=null)) {%>
			               							<br> <hr>
			               							
               										<form action="CARSCSDocUpload.htm" method="post" enctype="multipart/form-data">
	               										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	               		   								<input type="hidden" name="carsInitiationId" value="<%=carsIni.getCARSInitiationId()%>">
	               		   								<input type="hidden" name="otherDocDetailsId" value="<%if(csdetails!=null){%><%=csdetails.getOtherDocDetailsId() %><%}%>">
	               		   								<input type="hidden" name="otherDocType" value="C">
	               		   								<br>
               											<div class="row">
               												<div class="col-md-3"></div>
						               			    		<div class="col-md-4 ml-60">
						               			     			<div class="row details">
						                        					<div class="div-lab">
						                            					 <label class="control-label">Upload Contract Signature form</label><span class="mandatory">*</span> 
						                            					 <%if(csdetails!=null && csdetails.getUploadOtherDoc()!=null) {%>
						                            					 	<button type="submit" class="btn btn-sm btn-sum-doc-up ml-minus-5rem" name="filename" formmethod="post" formnovalidate="formnovalidate"
						                            					 	value="fileOtherDoc" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="CARS Contract Signature Download">
						                            					 		<i class="fa fa-download fa-lg"></i>
						                            					 	</button>
						                            					 <%} %>
						                              		      		<input type="file" class="form-control modals" name="uploadOtherDoc" required accept=".pdf" >
						                        					</div>
						                        				</div>
						                        			</div>
						                        			<div class="col-md-4">
						                        				<div align="left" class="mt-2-2rem">
																	<button type="submit" class="btn btn-sm btn-success submit" formmethod="post" onclick="return confirm('Are you sure to Upload?')" >UPLOAD</button>
																</div>
						                        			</div>
                        								</div>
                        								<br>
               										</form>
               									<%} %>
			               					</div>
			               				</div>
			               			</div>
	               				<%} %>				
               					<div class="navigation_btn text-right">
		            				<a class="btn btn-info btn-sm  shadow-nohover previous" >Previous</a>
									<button class="btn btn-info btn-sm next">Next</button>
								</div>
               			<%if(csDocsTabId!=null && csDocsTabId.equalsIgnoreCase("3")){ %> 
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
$('#csOtherDocDate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	//"minDate" :new Date(), 
	//"startDate" : new Date(),
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

</script>     

<script type="text/javascript">

//Onclick showing / Closing the info content

/* For CS Details Content */
$( "#csInfo" ).on( "click", function() {
	var csInfo = $('#csInfo').val();
	if(csInfo=="0"){
		$('#csInfo').val('1');
		$('#csInfoContent').show();
	
	}else{
		$('#csInfo').val('0');
		$('#csInfoContent').hide();
		}
} );

</script> 

<script type="text/javascript">
/* button disabling for CS Approval */
<%if((csforwardstatus.contains(carsIni.getCARSStatusCode()))) {%>
$('.btn-cs').prop('disabled',false);
<%} else{%>
$('.btn-cs').prop('disabled',true);
<%} %>

/* tabs hiding for CS approval */
<%if(isApproval!=null && (isApproval.equalsIgnoreCase("C") || isApproval.equalsIgnoreCase("D") )) {%>
   $('.navigation_btn').hide();
   $('#nav-csdetails').hide();
   $('#nav-docuploads').hide();
<%} %>
</script>

</body>
</html>
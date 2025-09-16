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
<spring:url value="/resources/css/cars/CARSMilestonePaymentDetails.css" var="carsMilestonePaymentDetails" />
<link href="${carsMilestonePaymentDetails}" rel="stylesheet" />
 
</head>
<body>

<%
String mpDocsTabId = (String)request.getAttribute("mpDocsTabId"); 
String isApproval = (String)request.getAttribute("isApproval");

CARSInitiation carsIni = (CARSInitiation)request.getAttribute("CARSInitiationData"); 
CARSSoC carsSoC = (CARSSoC)request.getAttribute("CARSSoCData"); 
CARSContract carsContract = (CARSContract)request.getAttribute("CARSContractData"); 
List<CARSSoCMilestones> milestones = (List<CARSSoCMilestones>)request.getAttribute("CARSSoCMilestones");

List<CARSOtherDocDetails> otherdocdetails = (List<CARSOtherDocDetails>)request.getAttribute("CARSOtherDocDetailsData");
List<Object[]> othersMPRemarksHistory = (List<Object[]>)request.getAttribute("CARSOthersMPRemarksHistory");
List<Object[]> othersMPApprovalEmpData = (List<Object[]>)request.getAttribute("OthersMPApprovalEmpData");

String MilestoneNo = (String)request.getAttribute("MilestoneNo"); 

List<CARSSoCMilestones> milestonedetailsbymilestoneno = milestones.stream().filter(e-> MilestoneNo.equalsIgnoreCase(e.getMilestoneNo())).collect(Collectors.toList());
CARSSoCMilestones milestonedetails = milestonedetailsbymilestoneno!=null && milestonedetailsbymilestoneno.size()>0? milestonedetailsbymilestoneno.get(0):null;

List<CARSOtherDocDetails> mpdetailslist = otherdocdetails.stream().filter(e-> "M".equalsIgnoreCase(e.getOtherDocType()) && MilestoneNo.equalsIgnoreCase(e.getMilestoneNo())).collect(Collectors.toList());
CARSOtherDocDetails mpdetails = mpdetailslist!=null && mpdetailslist.size()>0?mpdetailslist.get(0):null;

List<String> mpforwardstatus = Arrays.asList("CAD","MIN","MRA","MRC","MRD","MRV");

Object[] GHDPandC = (Object[])request.getAttribute("GHDPandC");
Object[] GDDPandC = (Object[])request.getAttribute("GDDPandC");
Object[] ADDPandC = (Object[])request.getAttribute("ADDPandC");
Object[] Chairperson = (Object[])request.getAttribute("Chairperson");
Object[] Director = (Object[])request.getAttribute("Director");
Object[] PDs = (Object[])request.getAttribute("PDEmpIds");

FormatConverter fc = new FormatConverter();
SimpleDateFormat rdf = fc.getRegularDateFormat();
SimpleDateFormat sdf = fc.getSqlDateFormat();

String labcode =(String)session.getAttribute("labcode");
String EmpId =((Long) session.getAttribute("EmpId")).toString();

long carsInitiationId = carsIni.getCARSInitiationId();
String statuscode = mpdetails!=null?mpdetails.getOthersStatusCode():"N";

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
         		<div class="card-header slider_header card-header-p" >
             		<h3 class="category">Payment Details - 
             		
             			<button type="button" class="btn btn-sm btn-info btn-bg-doc" >
             				<div>
					        	<div class="row">
					        		<div class="col-md-1">
					        			<span class="cssideheading">Title:</span>
					                </div>
					            	<div class="col-md-11 ml-minus-5">
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
					                		<%if(PDs!=null && PDs[3]!=null) {%><%=StringEscapeUtils.escapeHtml4(PDs[3].toString())%> (<%=PDs[0]!=null?StringEscapeUtils.escapeHtml4(PDs[0].toString()): " - "%>)<%} %>
					                	<%} %>
					                	</span>
					            </div>
					            <div class="col-md-1"></div>
					            	<div class="col-md-3">
					                	<span class="cssideheading">Amount:</span>
					                		&emsp;<span class="cssideheadingdata">
					                		<%if(carsSoC!=null && carsSoC.getSoCAmount()!=null) {%>
					                			<%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(StringEscapeUtils.escapeHtml4(carsSoC.getSoCAmount()))) %>
					                		<%} else{%>-<%} %>
					                	</span>
					                </div>
					            </div>
					                		
					        </div>
             			</button>
             		
             			<a class="btn btn-info btn-sm  shadow-nohover back f-right text-white"
             			<%if(isApproval!=null && isApproval.equalsIgnoreCase("M") ) {%>
               				href="CARSRSQRApprovals.htm"
               			<%} else if(isApproval!=null && isApproval.equalsIgnoreCase("N") ) {%>
               				href="CARSRSQRApprovals.htm?val=app"
               			<%} else {%>
             			    href="CARSOtherDocsList.htm?carsInitiationId=<%=carsInitiationId %>"
             			<%} %> >Back</a>
             		</h3>
             		<hr class="hr-m-minus">
             		<ul class="nav nav-tabs justify-content-center pb-0" role="tablist" >

            			<li class="nav-item" id="nav-mpdetails">
             				<%if(mpDocsTabId!=null && mpDocsTabId.equalsIgnoreCase("1")){ %> 
             		    		<a class="nav-link active " data-toggle="tab" href="#mpdetails" id="nav" role="tab">
             				<%}else{ %>
              			 		<a class="nav-link  " data-toggle="tab" href="#mpdetails" role="tab">
               				<%} %>  
               					
                	         	Doc Details
              			 		</a>
            			</li>

            			<li class="nav-item" id="nav-mpapproval">
            	     		<%if(mpDocsTabId!=null && mpDocsTabId.equalsIgnoreCase("2")){ %>
              					<a class="nav-link active" data-toggle="tab" href="#mpapproval" id="nav"role="tab" >
              				<%}else{ %>
              					<a class="nav-link" data-toggle="tab" href="#mpapproval" role="tab" >
               				<%} %>
                  				Payment Approval
              					</a>
            			</li>
            			
            			<li class="nav-item" id="nav-docuploads">
		            	     <%if(mpDocsTabId!=null && mpDocsTabId.equalsIgnoreCase("3")){ %>
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
               			<%if(mpDocsTabId!=null && mpDocsTabId.equalsIgnoreCase("1")){ %> 
         					<div class="tab-pane active" id="mpdetails" role="tabpanel">
         				<%}else{ %>
              				<div class="tab-pane " id="mpdetails" role="tabpanel">
               			<%} %>
               					<div class="container">
									<div class="row w-140 ml-minus-15rem">
										<div class="col-md-12">
											<div class="card shadow-nohover" >
												<div class="card-header card-header-bg">
								                    <b class="text-white"><%if(MilestoneNo!=null && !MilestoneNo.equalsIgnoreCase("MIL-0")) {%>Milestone<%} else{%>Initial Advance<%} %> Payment Details: </b> 
								                    <hr>
								                    <span class="text-white f-right fw-600" > </span>
							        			</div> 
												<div class="card-body">
								        		
													<form action="CARSMPDocDetailsSubmit.htm" method="POST" enctype="multipart/form-data">
														<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
												    	<input type="hidden" name="carsInitiationId" value="<%=carsIni.getCARSInitiationId()%>">
												    	<input type="hidden" name="otherDocDetailsId" value="<%if(mpdetails!=null){%><%=mpdetails.getOtherDocDetailsId() %><%}%>">
												    	<input type="hidden" name="otherDocType" value="M">
												    	<input type="hidden" name="MilestoneNo" value="<%=MilestoneNo%>">
												    	<div class="row mlr-2">
												    		
												        	<div class="col-md-3" >
														        		<div class="form-group">
														                	<label class="control-label">Date:</label><span class="mandatory">*</span>
														                    <input  class="form-control form-control" type="text" name="mpOtherDocDate" id="mpOtherDocDate"
														                     value="<%if(mpdetails!=null && mpdetails.getOtherDocDate()!=null) {%><%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(mpdetails.getOtherDocDate())) %><%} %>" required readonly> 
														                </div>
														            </div>
														        	
														        	<div class="col-md-3">
														        		<div class="form-group">
														                	<label class="control-label">Flag-A</label><span class="mandatory">*</span>
														                    <%if(mpdetails!=null && mpdetails.getAttachFlagA()!=null) {%>
						                            					 		<button type="submit" class="btn btn-sm btn-sub-doc"  name="filename" formmethod="post" formnovalidate="formnovalidate"
						                            					 		  value="flagAFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
						                            					 			<i class="fa fa-download fa-lg"></i>
						                            					 		</button>
                            					 							<%} %>
                              		      									<input type="file" class="form-control modals" name="attatchFlagA" <%if(mpdetails==null) {%>required<%} %> accept=".pdf">
														                </div>
														            </div>
														        	<div class="col-md-3">
														        		<div class="form-group">
														                	<label class="control-label">Flag-B</label><span class="mandatory">*</span>
														                    <%if(mpdetails!=null && mpdetails.getAttachFlagB()!=null) {%>
						                            					 		<button type="submit" class="btn btn-sm btn-sub-doc" name="filename" formmethod="post" formnovalidate="formnovalidate"
						                            					 		  value="flagBFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
						                            					 			<i class="fa fa-download fa-lg"></i>
						                            					 		</button>
                            					 							<%} %>
                              		      									<input type="file" class="form-control modals" name="attatchFlagB" <%if(mpdetails==null) {%>required<%} %> accept=".pdf">
														                </div>
														            </div>
														            <%if(MilestoneNo!=null && !MilestoneNo.equalsIgnoreCase("MIL-0")) {%>
														        	<div class="col-md-3">
														        		<div class="form-group">
														                	<label class="control-label">Flag-C</label><span class="mandatory">*</span>
														                    <%if(mpdetails!=null && mpdetails.getAttachFlagC()!=null) {%>
						                            					 		<button type="submit" class="btn btn-sm btn-sub-doc" name="filename" formmethod="post" formnovalidate="formnovalidate"
						                            					 		  value="flagCFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
						                            					 			<i class="fa fa-download fa-lg"></i>
						                            					 		</button>
                            					 							<%} %>
                              		      									<input type="file" class="form-control modals" name="attatchFlagC" <%if(mpdetails==null) {%>required<%} %> accept=".pdf">
														                </div>
														            </div>
														            <%} %>
														        </div>
														        
														        <div class="row mlr-2">
														        	<div class="col-md-3" >
														        		<div class="form-group">
														                	<label class="control-label">Invoice No:</label><span class="mandatory">*</span>
														                    <input  class="form-control form-control" type="text" name="invoiceNo" id="invoiceNo" maxlength="50" placeholder="Enter Inovice No"
														                     value="<%if(mpdetails!=null) {%><%=StringEscapeUtils.escapeHtml4(mpdetails.getInvoiceNo()) %><%} %>" required> 
														                </div>
														            </div>
														        	<div class="col-md-3">
														        		<div class="form-group">
														                	<label class="control-label">Invoice Date:</label><span class="mandatory">*</span>
														                    <input  class="form-control form-control" type="text" name="invoiceDate" id="invoiceDate"
														                     value="<%if(mpdetails!=null) {%><%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(mpdetails.getInvoiceDate())) %><%} %>" required readonly> 
														                </div>
														            </div>
														        	
														        </div>
														        
														         <div class="row mlr-2">
														        	<div class="col-md-2">
														        		<div class="form-group">
														        			<label class="control-label">Info <button type="button" id="mpInfo" value="1" class="btn btn-info btn-sm btn-in-fo" ><i class="fa fa-info-circle" aria-hidden="true"></i></button></label>
														        		</div>
														        	</div>
														        	<div class="col-md-10 text-left ml-minus-10" id="mpInfoContent" >
														        		<div class="form-group w-110">
														        			<span class="col-crimson" >Flag-A : </span> <span>Reference is made to the CARS .</span> <br>
														        			<span class="col-fuchsia">Flag-B : </span> <span>Invoice. </span> <br>
														        			<%if(MilestoneNo!=null && !MilestoneNo.equalsIgnoreCase("MIL-0")) {%>
														        			<span class="col-blue">Flag-C : </span> <span>Recommendation of CARS Review committee for releasing the proposed milestone payment is placed.</span> 
														        			<%} %>
														        		</div>
														        	</div>
														        </div>
												        
												    	<div align="center">
															<%if(mpdetails!=null){ %>
																<button type="submit" class="btn btn-sm btn-warning edit btn-mp" name="Action" value="Edit" onclick="return confirm('Are you sure to update?')" >UPDATE</button>
															<%}else{ %>
																<button type="submit" class="btn btn-sm btn-success submit btn-mp" name="Action" value="Add" onclick="return confirm('Are you sure to submit?')" >SUBMIT</button>
															<%} %>
														</div>
												    </form>
								    				<br>
												    
												</div>
											</div>
										</div>
									</div>
								</div>
               			
               					<div class="navigation_btn text-right">
            						<a class="btn btn-info btn-sm  shadow-nohover back text-white" href="CARSOtherDocsList.htm?carsInitiationId=<%=carsInitiationId %>">Back</a>
									<button class="btn btn-info btn-sm next">Next</button>
								</div>
               			<%if(mpDocsTabId!=null && mpDocsTabId.equalsIgnoreCase("1")){ %> 
         					</div>
         				<%}else{ %>
              				</div>
               			<%} %>
               			
               			<!-- *********** Payment Approval ***********      --> 
               			<%if(mpDocsTabId!=null && mpDocsTabId.equalsIgnoreCase("2")){ %> 
         					<div class="tab-pane active" id="mpapproval" role="tabpanel">
         				<%}else{ %>
              				<div class="tab-pane " id="mpapproval" role="tabpanel">
               			<%} %>
               					<%if(mpdetails!=null) {%>
		               				<div class="col-md-8 mt-1">
               							<div class="card card-div" >
               								<div class="card-body mt-2 ml-4">
               									<form action="#">
               										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			               		   					<input type="hidden" name="carsInitiationId" value="<%=carsIni.getCARSInitiationId()%>">
			               		   					<input type="hidden" name="otherDocDetailsId" value="<%if(mpdetails!=null){%><%=mpdetails.getOtherDocDetailsId() %><%}%>">
			               		   					<input type="hidden" name="otherDocType" value="M">
			               		   					<input type="hidden" name="MilestoneNo" value="<%=MilestoneNo%>">
			               		   					<div class="mt-2" align="center">
               											<h5 class="lab-code"><%=labcode %></h5>
               											
               											<span class="span-dir">Directorate of Planning & Coordination</span>
               										</div>
               										
               										<div class="row">
					               		   				<div class="col-md-3">
					               		   					<span>No:</span> <span><%=carsContract.getContractNo()!=null?StringEscapeUtils.escapeHtml4(carsContract.getContractNo()): " - " %> </span>
					               		   				</div>
					               		   				<div class="col-md-6">
					               		   				</div>
					               		   				<div class="col-md-3">
					               		   					<span>Date:</span> <span><%if(mpdetails.getOtherDocDate()!=null) {%> <%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(mpdetails.getOtherDocDate())) %><%} else{%><%=rdf.format(new Date()) %><%} %> </span>
					               		   				</div>
			               		   					</div>
			               		   					<hr>
					               		   			<div class="row">
					               		   				<div class="col-md-12 mt-2" align="center">
		               										<h5 class="lab-code">Approval for <%if(MilestoneNo!=null && !MilestoneNo.equalsIgnoreCase("MIL-0")) {%>Milestone<%} else{%>Initial Advance<%} %> Payment </h5>
		               											
		               										<span class="fs-large"><%=carsIni.getInitiationTitle()!=null?StringEscapeUtils.escapeHtml4(carsIni.getInitiationTitle()): " - " %> </span>
		               									</div>
					               		   			</div>
			               		   					<br>
			               		   					<%int paymentslno=0; %>
					               		   			<div class="row">
					               		   				<div class="col-md-12 text-left">
					               		   					<span>
					               		   						<%=++paymentslno %>) Reference is made to the CARS Contract No. 
					               		   						<%if(carsContract!=null) {%><%=StringEscapeUtils.escapeHtml4(carsContract.getContractNo()) %> <%} %>
					               		   						dt. <%if(carsContract!=null && carsContract.getContractDate()!=null) {%><%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(carsContract.getContractDate())) %> <%} %>
					               		   						. (Flag-A)
					               		   					</span>
					               		   					<span>
					               		   						<%if(mpdetails!=null && mpdetails.getAttachFlagA()!=null) {%>
							                            			<button type="submit" class="btn btn-sm btn-sub-doc" name="filename" formmethod="post" formnovalidate="formnovalidate"
							                            				value="flagAFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
							                            				<i class="fa fa-download"></i>
							                            			</button>
		                          					 			<%} %>
					               		   					</span>
					               		   					
					               		   				</div>
					               		   			</div>
					               		   			<div class="row">
					               		   				<div class="col-md-12 text-left" >
					               		   					<%if(MilestoneNo!=null && !MilestoneNo.equalsIgnoreCase("MIL-0")) {%>
					               		   						<span>
					               		   							<%=++paymentslno %>) <%if(carsIni!=null) {%><%=StringEscapeUtils.escapeHtml4(carsIni.getRSPInstitute())+", "+StringEscapeUtils.escapeHtml4(carsIni.getRSPCity()) %> <%} %> has submitted
						               		   						 invoice No. <%if(mpdetails!=null && mpdetails.getInvoiceNo()!=null) {%><%=StringEscapeUtils.escapeHtml4(mpdetails.getInvoiceNo()) %> <%} %>
						               		   						 dt. <%if(mpdetails!=null && mpdetails.getInvoiceDate()!=null) {%><%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(mpdetails.getInvoiceDate())) %> <%} %>
						               		   						 for Payment towards Milestone No <%=MilestoneNo!=null?StringEscapeUtils.escapeHtml4(MilestoneNo): " - " %>
						               		   						 for an amount of Rs. <%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(StringEscapeUtils.escapeHtml4(milestonedetails.getActualAmount()))) %>
						               		   						 and the invoice is placed opposite (Flag-B).
					               		   						</span>
					               		   					<%} else{%>
						               		   					<span>
						               		   						<%=++paymentslno %>) <%if(carsIni!=null) {%><%=StringEscapeUtils.escapeHtml4(carsIni.getRSPInstitute())+", "+StringEscapeUtils.escapeHtml4(carsIni.getRSPCity()) %> <%} %> has submitted
						               		   						 invoice No. <%if(mpdetails!=null && mpdetails.getInvoiceNo()!=null) {%><%=StringEscapeUtils.escapeHtml4(mpdetails.getInvoiceNo()) %> <%} %>
						               		   						 dt. <%if(mpdetails!=null && mpdetails.getInvoiceDate()!=null) {%><%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(mpdetails.getInvoiceDate())) %> <%} %>
						               		   						 for Initial Advance Payment of Rs. <%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(StringEscapeUtils.escapeHtml4(milestonedetails.getActualAmount()))) %>
						               		   						 and the invoice is placed opposite (Flag-B).
						               		   					</span>
					               		   					<%} %>
					               		   					<span>
					               		   						<%if(mpdetails!=null && mpdetails.getAttachFlagB()!=null) {%>
							                            			<button type="submit" class="btn btn-sm btn-sub-doc" name="filename" formmethod="post" formnovalidate="formnovalidate"
							                            				value="flagBFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
							                            				<i class="fa fa-download"></i>
							                            			</button>
		                          					 			<%} %>
					               		   					</span>
					               		   				</div>
					               		   			</div>
					               		   			
					               		   			<%if(MilestoneNo!=null && !MilestoneNo.equalsIgnoreCase("MIL-0")) {%>
					               		   			<div class="row">
					               		   				<div class="col-md-12 text-left" >
					               		   					<span>
					               		   						<%=++paymentslno %>) Recommendation of CARS Review committee for releasing the proposed milestone payment is placed at Flag-C.
					               		   					</span>
					               		   					<span>
					               		   						<%if(mpdetails!=null && mpdetails.getAttachFlagC()!=null) {%>
							                            			<button type="submit" class="btn btn-sm btn-sub-doc" name="filename" formmethod="post" formnovalidate="formnovalidate"
							                            				value="flagCFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
							                            				<i class="fa fa-download"></i>
							                            			</button>
		                          					 			<%} %>
					               		   					</span>
					               		   				</div>
					               		   			</div>
					               		   			<%} %>
					               		   			
					               		   			<div class="row">
					               		   				<div class="col-md-12 text-left" >
					               		   					<span>
					               		   						<%=++paymentslno %>) This is put up for the perusal and approval of the CFA for release of the payment stated above.
					               		   					</span>
					               		   					
					               		   				</div>
					               		   			</div>
					               		   			
			               		   					<br>
			               		   					
					               		   			<!-- Signatures and timestamps -->
					               		   			<div class="div-tab">
				               							<div class="input-font"> Signature of GD-DP&C</div>
								               			<%for(Object[] apprInfo : othersMPApprovalEmpData){ %>
								   			   				<%if(apprInfo[8].toString().equalsIgnoreCase("MFW")){ %>
								   								<label class="text-uppercase mt-3" ><%=apprInfo[2]!=null?StringEscapeUtils.escapeHtml4(apprInfo[2].toString()): " - "%></label>,<!-- <br> -->
								   								<label class="text-uppercase " ><%=apprInfo[3]!=null?StringEscapeUtils.escapeHtml4(apprInfo[3].toString()): " - "%></label><br>
								   								<label class="fs-12" >[Forwarded On:&nbsp; <%= apprInfo[4] !=null? (fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(0, 10)))  +" "+StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(11,19))):" - " %>]</label>
								   			    		<%break;}} %>  
									            	</div>
							            	
									            	<%for(Object[] apprInfo : othersMPApprovalEmpData) {%>
									            		<div class="tab-div">
										            			 		
										            		<%if(apprInfo[8].toString().equalsIgnoreCase("MFA")){ %>
									            				<div class="input-font"> Signature of AD-P&C</div>
										   						<label class="text-uppercase mt-3"><%=apprInfo[2]!=null?StringEscapeUtils.escapeHtml4(apprInfo[2].toString()): " - "%></label>,<!-- <br> -->
										   						<label class="text-uppercase "><%=apprInfo[3]!=null?StringEscapeUtils.escapeHtml4(apprInfo[3].toString()): " - "%></label><br>
										   						<label class="fs-12">[Recommended On:&nbsp; <%= apprInfo[4] !=null? (fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(0, 10)))  +" "+StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(11,19))):" - " %>]</label>
										   					<%} else if(apprInfo[8].toString().equalsIgnoreCase("MFC")) {%> 
									   			    			<div class="input-font"> Signature of Chairperson (CARS Committee)</div>
									   			    			<label class="text-uppercase mt-3"><%=apprInfo[2]!=null?StringEscapeUtils.escapeHtml4(apprInfo[2].toString()): " - "%></label>,<!-- <br> -->
										   						<label class="text-uppercase " ><%=apprInfo[3]!=null?StringEscapeUtils.escapeHtml4(apprInfo[3].toString()): " - "%></label><br>
										   						<label class="fs-12" >[Approved On:&nbsp; <%= apprInfo[4] !=null? (fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(0, 10)))  +" "+StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(11,19))):" - "%>]</label>
										   					<%} else if(apprInfo[8].toString().equalsIgnoreCase("MAD")) {%> 
									   			    			<div class="input-font"> Signature of Director</div>
									   			    			<label class="text-uppercase mt-3" ><%=apprInfo[2]!=null?StringEscapeUtils.escapeHtml4(apprInfo[2].toString()): " - "%></label>,<!-- <br> -->
										   						<label class="text-uppercase "><%=apprInfo[3]!=null?StringEscapeUtils.escapeHtml4(apprInfo[3].toString()): " - "%></label><br>
										   						<label class="fs-12" >[Approved On:&nbsp; <%= apprInfo[4] !=null? (fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(0, 10)))  +" "+StringEscapeUtils.escapeHtml4(apprInfo[4].toString().substring(11,19))):" - " %>]</label>
									   			    					
									   			    		<%} %>
									   			    	</div>
									   			    <%} %>
							   			    
									   			    <!-- Remarks -->
					               		   			<div class="row mt-2">
														<%if(othersMPRemarksHistory.size()>0){ %>
															<div class="col-md-8 div-rem" align="left" >
																<%if(othersMPRemarksHistory.size()>0){ %>
																	<table class="m-1 p-0">
																		<tr>
																			<td class="bor-none p-0" >
																				<h6 class="text-ul">Remarks :</h6> 
																			</td>											
																		</tr>
																		<%for(Object[] obj : othersMPRemarksHistory){%>
																			<tr>
																				<td class="mp-rem">
																					<%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - "%>&nbsp; :
																					<span class="bor-none col-blue">	<%=obj[1] !=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%></span>
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
															<%if(statuscode!=null && mpforwardstatus.contains(statuscode) && ( GDDPandC!=null && EmpId.equalsIgnoreCase(GDDPandC[0].toString()) ) ) {%>
																<div class="ml-2" align="left">
									   								<b >Remarks :</b><br>
									   								<textarea rows="3" cols="65" name="remarks" id="remarksarea"></textarea>
								         						</div>
																<button type="submit" class="btn btn-sm submit" id="" name="Action" formaction="OthersMPApprovalSubmit.htm" formnovalidate="formnovalidate" value="A" onclick="return confirm('Are you Sure to Submit ?');" >Forward</button>
															<%} %>
															<%if(isApproval!=null && isApproval.equalsIgnoreCase("M")) {%>
																
																<div class="ml-2" align="left">
									   								<b >Remarks :</b><br>
									   								<textarea rows="3" cols="65" name="remarks" id="remarksarea"></textarea>
								         						</div>
								         						<%if(statuscode!=null && statuscode.equalsIgnoreCase("MFC")) {%>
								         						<button type="submit" class="btn btn-sm btn-success fw-600" id="finalSubmission" formaction="OthersMPApprovalSubmit.htm" name="Action" value="A" onclick="return confirm('Are You Sure To Approve?');">
										    						Approve	
									      						</button>
									      						<button type="submit" class="btn btn-sm btn-danger btn-ret-bg fw-600" id="finalSubmission" formaction="OthersMPApprovalSubmit.htm" name="Action" value="R" onclick="return validateTextBox();">
										 							Return
																</button>
								         						<%} else{%>
																<button type="submit" class="btn btn-sm btn-success fw-600" id="finalSubmission" formaction="OthersMPApprovalSubmit.htm" name="Action" value="A" onclick="return confirm('Are You Sure To Recommend?');">
										    						Recommend	
									      						</button>
									      						
									      						<button type="submit" class="btn btn-sm btn-danger fw-600 btn-ret-bg" id="finalSubmission" formaction="OthersMPApprovalSubmit.htm" name="Action" value="R" onclick="return validateTextBox();">
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
               						<div class="mt-4 dis-cen">
               							<h4 class="mandatory fw-bold">Please fill the Payment Details..!</h4>
               						</div>
               					<%} %>   
			               		
			               		<div class="dis-jc">
               						<div></div>
		               				<div>
		               					<%if(carsIni!=null && isApproval==null) {%>
		               					<div class="row"  >
				 		  					<div class="col-md-12 text-center" ><b>Approval Flow For Payment Approval</b></div>
				 	    				</div>
				 	    				<div class="row text-center pt-2 pb-3"   >
			              					<table align="center"  >
			               						<tr>
			               							<td class="trup trup-bg-1" >
			                							GD-DP&C - <%if(GDDPandC!=null) {%> <%=StringEscapeUtils.escapeHtml4(GDDPandC[1].toString()) %> <%} else {%> GD-DP&C <%} %>
			                						</td>
			                		
		                        					<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						
			                						<td class="trup trup-bg-2">
			                							AD-D&C - <%if(ADDPandC!=null) {%> <%=StringEscapeUtils.escapeHtml4(ADDPandC[1].toString()) %> <%} else {%> AD-P&C <%} %>
			                	    				</td>
			                		
		                        					<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						
			                						<td class="trup trup-bg-3">
			                							Chairperson (CARS Committee) - <%if(Chairperson!=null) {%> <%=StringEscapeUtils.escapeHtml4(Chairperson[1].toString()) %> <%} else {%> Chairperson (CARS Committee) <%} %>
			                	    				</td>
			                	    				
			                	    				<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						
			                						<td class="trup trup-bg-4">
			                							Director - <%if(Director!=null) {%> <%=StringEscapeUtils.escapeHtml4(Director[1].toString()) %> <%} else {%> Director <%} %>
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

               			<%if(mpDocsTabId!=null && mpDocsTabId.equalsIgnoreCase("2")){ %> 
         					</div>
         				<%}else{ %>
              				</div>
               			<%} %>
               			
               			<!-- *********** Doc Upload ***********      --> 
               			<%if(mpDocsTabId!=null && mpDocsTabId.equalsIgnoreCase("3")){ %> 
         					<div class="tab-pane active" id="docuploads" role="tabpanel">
         				<%}else{ %>
              				<div class="tab-pane " id="docuploads" role="tabpanel">
               			<%} %>
               					<%if(mpdetails!=null) {%>
		               				<div class="col-md-8 mt-4">
		               					<div class="card card-bg-head" >
		               						<div class="card-body mt-2 ml-4">
			               						<form action="#">
			               							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			               							<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId%>">
			               							<input type="hidden" name="otherDocDetailsId" value="<%if(mpdetails!=null){%><%=mpdetails.getOtherDocDetailsId() %><%}%>">
			               							<input type="hidden" name="otherDocType" value="M">
			               							<input type="hidden" name="MilestoneNo" value="<%=MilestoneNo%>">
			               							<table id="alldocstable">
			               								<thead>
			               									<tr>
			               										<th class="w-10">SN</th>
			               										<th>Subject</th>
			               										<th class="w-10">Action</th>
			               									</tr>
			               								</thead>
			               								<tbody>
			               									<%int paymentslno=0; %>
			               									<tr>
			               										<td><%=++paymentslno %>.</td>
			               										<td><%if(MilestoneNo!=null && !MilestoneNo.equalsIgnoreCase("MIL-0")) {%>Milestone<%} else{%>Initial Advance<%} %> Payment Approval form</td>
			               										<td>
			               											<button type="submit" class="btn btn-sm" formaction="CARSMPDownload.htm"  formtarget="_blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="CARS Contract Signature Download" >
																		<i class="fa fa-download fa-lg" aria-hidden="true"></i>
																	</button>
			               										</td>
			               									</tr>
			               									
			               									<tr>
			               										<td><%=++paymentslno %>.</td>
			               										<td>
			               											<span>
						               		   							Reference is made to the CARS Contract No. 
						               		   							<%if(carsContract!=null) {%><%=StringEscapeUtils.escapeHtml4(carsContract.getContractNo()) %> <%} %>
						               		   							dt. <%if(carsContract!=null && carsContract.getContractDate()!=null) {%><%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(carsContract.getContractDate())) %> <%} %>
						               		   							. (Flag-A)
					               		   							</span>
			               										</td>
			               										<td>
			               											<%if(mpdetails!=null && mpdetails.getAttachFlagA()!=null) {%>
							                            			<button type="submit" class="btn btn-sm btn-bg-doc-p" name="filename" formmethod="post" formnovalidate="formnovalidate"
							                            				value="flagAFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
							                            				<i class="fa fa-download fa-lg"></i>
							                            			</button>
                            					 					<%} else {%>
                            					 						-
                            					 					<%} %>
			               										</td>
			               									</tr>
			               									<tr>
			               										<td><%=++paymentslno %>.</td>
			               										<td>
			               											<%if(MilestoneNo!=null && !MilestoneNo.equalsIgnoreCase("MIL-0")) {%>
							               		   						<span>
							               		   							 <%if(carsIni!=null) {%><%=StringEscapeUtils.escapeHtml4(carsIni.getRSPInstitute())+", "+StringEscapeUtils.escapeHtml4(carsIni.getRSPCity()) %> <%} %> has submitted
								               		   						 invoice No. <%if(mpdetails!=null && mpdetails.getInvoiceNo()!=null) {%><%=StringEscapeUtils.escapeHtml4(mpdetails.getInvoiceNo()) %> <%} %>
								               		   						 dt. <%if(mpdetails!=null && mpdetails.getInvoiceDate()!=null) {%><%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(mpdetails.getInvoiceDate())) %> <%} %>
								               		   						 for Payment towards Milestone No <%=MilestoneNo!=null?StringEscapeUtils.escapeHtml4(MilestoneNo): " - " %>
								               		   						 for an amount of Rs. <%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(StringEscapeUtils.escapeHtml4(milestonedetails.getActualAmount()))) %>
								               		   						 and the invoice is placed opposite (Flag-B).
							               		   						</span>
							               		   					<%} else{%>
								               		   					<span>
								               		   						 <%if(carsIni!=null) {%><%=StringEscapeUtils.escapeHtml4(carsIni.getRSPInstitute())+", "+StringEscapeUtils.escapeHtml4(carsIni.getRSPCity()) %> <%} %> has submitted
								               		   						 invoice No. <%if(mpdetails!=null && mpdetails.getInvoiceNo()!=null) {%><%=StringEscapeUtils.escapeHtml4(mpdetails.getInvoiceNo()) %> <%} %>
								               		   						 dt. <%if(mpdetails!=null && mpdetails.getInvoiceDate()!=null) {%><%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(mpdetails.getInvoiceDate())) %> <%} %>
								               		   						 for Initial Advance Payment of Rs. <%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(StringEscapeUtils.escapeHtml4(milestonedetails.getActualAmount()))) %>
								               		   						 and the invoice is placed opposite (Flag-B).
								               		   					</span>
							               		   					<%} %>
			               										</td>
			               										<td>
			               											<%if(mpdetails!=null && mpdetails.getAttachFlagB()!=null) {%>
								                            			<button type="submit" class="btn btn-sm btn-bg-doc-p" name="filename" formmethod="post" formnovalidate="formnovalidate"
								                            				value="flagBFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
								                            				<i class="fa fa-download fa-lg"></i>
								                            			</button>
		                          					 				<%} %>
			               										</td>
			               									</tr>
			               									<%if(MilestoneNo!=null && !MilestoneNo.equalsIgnoreCase("MIL-0")) {%>
			               									<tr>
			               										<td><%=++paymentslno %>.</td>
			               										<td>
			               											Recommendation of CARS Review committee for releasing the proposed milestone payment is placed. (Flag-C)
			               										</td>
			               										<td>
			               											<%if(mpdetails!=null && mpdetails.getAttachFlagC()!=null) {%>
								                            			<button type="submit" class="btn btn-sm btn-bg-doc-p" name="filename" formmethod="post" formnovalidate="formnovalidate"
								                            				value="flagCFile" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
								                            				<i class="fa fa-download fa-lg"></i>
								                            			</button>
		                          					 				<%} %>
			               										</td>
			               									</tr>
			               									<%} %>
			               									<tr>
			               										<td><%=++paymentslno %>.</td>
			               										<td>Uploaded Payment Approval form (After approval)</td>
			               										<td>
			               											<%if(mpdetails!=null && mpdetails.getUploadOtherDoc()!=null) {%>
								                            			<button type="submit" class="btn btn-sm btn-bg-doc-p" name="filename" formmethod="post" formnovalidate="formnovalidate"
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
			               						
			               						<%if( (statuscode!=null && statuscode.equalsIgnoreCase("MAD") ) || (mpdetails!=null && mpdetails.getUploadOtherDoc()!=null)) {%>
			               							<br> <hr>
			               							
               										<form action="CARSMPDocUpload.htm" method="post" enctype="multipart/form-data">
	               										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	               		   								<input type="hidden" name="carsInitiationId" value="<%=carsIni.getCARSInitiationId()%>">
	               		   								<input type="hidden" name="otherDocDetailsId" value="<%if(mpdetails!=null){%><%=mpdetails.getOtherDocDetailsId() %><%}%>">
	               		   								<input type="hidden" name="otherDocType" value="C">
	               		   								<input type="hidden" name="MilestoneNo" value="<%=MilestoneNo%>">
	               		   								<br>
               											<div class="row">
               												<div class="col-md-3"></div>
						               			    		<div class="col-md-4 ml-60" >
						               			     			<div class="row details">
						                        					<div class="w-90">
						                            					 <label class="control-label">Upload <%if(MilestoneNo!=null && !MilestoneNo.equalsIgnoreCase("MIL-0")) {%>Milestone<%} else{%>Initial Advance<%} %> Payment Approval form</label><span class="mandatory">*</span> 
						                            					 <%if(mpdetails!=null && mpdetails.getUploadOtherDoc()!=null) {%>
						                            					 	<button type="submit" class="btn btn-sm btn-minus-2" name="filename" formmethod="post" formnovalidate="formnovalidate"
						                            					 	value="fileOtherDoc" formaction="CARSOtherDocAttachedFileDownload.htm" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="CARS Payment Approval Download">
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
	               				<%} else{%>
               						<div class="mt-4 dis-cen">
               							<h4 class="fw-bold mandatory">Please fill the Payment Details..!</h4>
               						</div>
               					<%} %>
               					<div class="navigation_btn text-right"  >
		            				<a class="btn btn-info btn-sm  shadow-nohover previous" >Previous</a>
									<button class="btn btn-info btn-sm next">Next</button>
								</div>
               			<%if(mpDocsTabId!=null && mpDocsTabId.equalsIgnoreCase("3")){ %> 
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
$('#mpOtherDocDate').daterangepicker({
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

$('#invoiceDate').daterangepicker({
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

/* For MP Details Content */
$( "#mpInfo" ).on( "click", function() {
	var mpInfo = $('#mpInfo').val();
	if(mpInfo=="0"){
		$('#mpInfo').val('1');
		$('#mpInfoContent').show();
	
	}else{
		$('#mpInfo').val('0');
		$('#mpInfoContent').hide();
		}
} );

</script> 

<script type="text/javascript">
/* button disabling for MP Approval */
<%if((statuscode!=null && mpforwardstatus.contains(statuscode)) || statuscode.equalsIgnoreCase("N")) {%>
$('.btn-mp').prop('disabled',false);
<%} else{%>
$('.btn-mp').prop('disabled',true);
<%} %>

/* tabs hiding for MP approval */
<%if(isApproval!=null && (isApproval.equalsIgnoreCase("M") || isApproval.equalsIgnoreCase("N") )) {%>
   $('.navigation_btn').hide();
   $('#nav-mpdetails').hide();
   $('#nav-docuploads').hide();
<%} %>
</script>
         		
</body>
</html>
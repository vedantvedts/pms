<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.IndianRupeeFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.vts.pfms.cars.model.CARSSoCMilestones"%>
<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.cars.model.CARSSoC"%>
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
<link href="${projetdetailscss}" rel="stylesheet" />
<%-- <spring:url value="/resources/ckeditor/ckeditor.js" var="ckeditor" />
<spring:url value="/resources/ckeditor/contents.css" var="contentCss" />
<script src="${ckeditor}"></script>
<link href="${contentCss}" rel="stylesheet" /> --%>
<spring:url value="/resources/summernote-lite.js" var="SummernoteJs" />
<spring:url value="/resources/summernote-lite.css" var="SummernoteCss" />
<script src="${SummernoteJs}"></script>
<link href="${SummernoteCss}" rel="stylesheet" />

<spring:url value="/resources/css/cars/DPCSoCDetails.css" var="dpcsoCDetails" />
<link href="${dpcsoCDetails}" rel="stylesheet" />

<spring:url value="/resources/css/cars/carscommon.css" var="carscommon10" />
<link href="${carscommon10}" rel="stylesheet" />

</head>
<body>
<%
String dpcTabId = (String)request.getAttribute("dpcTabId"); 
CARSInitiation carsIni = (CARSInitiation)request.getAttribute("CARSInitiationData"); 
CARSSoC carsSoC =(CARSSoC)request.getAttribute("CARSSoCData"); 
List<CARSSoCMilestones> milestones = (List<CARSSoCMilestones>)request.getAttribute("CARSSoCMilestones");
List<Object[]> dpcSoCRemarksHistory = (List<Object[]>)request.getAttribute("CARSDPCSoCRemarksHistory");
List<Object[]> dpcSoCApprovalEmpData = (List<Object[]>)request.getAttribute("DPCSoCApprovalEmpData");

String isApproval = (String)request.getAttribute("isApproval");

FormatConverter fc = new FormatConverter();
SimpleDateFormat sdtf = fc.getSqlDateAndTimeFormat();
SimpleDateFormat sdf = fc.getSqlDateFormat();
SimpleDateFormat rdf = fc.getRegularDateFormat();

String expenditure = carsSoC.getDPCExpenditure();
expenditure = expenditure!=null?expenditure.replaceAll("\n", "<br>"):expenditure;

List<String> dpcsocforwardstatus = Arrays.asList("SFG","SFP","SID","SGR","SPR","SRC","SRM","SRF","SRR","SRI","RDG","SRJ","SRS","SRD");
List<String> dpcsocapprovestatus = Arrays.asList("SDF","SAD","SAI","ADG","SAJ","SAS");
List<String> dpcsocexternalapprovestatus = Arrays.asList("SAI","ADG","SAJ","SAS");

Object[] emp = (Object[])request.getAttribute("EmpData");
Object[] PDs = (Object[])request.getAttribute("PDEmpIds");

Object[] GHDPandC = (Object[])request.getAttribute("GHDPandC");
Object[] GDDPandC = (Object[])request.getAttribute("GDDPandC");
Object[] ChairmanRPB = (Object[])request.getAttribute("ChairmanRPB");
Object[] MMFDAG = (Object[])request.getAttribute("MMFDAG");
Object[] GDDFandMM = (Object[])request.getAttribute("GDDFandMM");
Object[] Director = (Object[])request.getAttribute("Director");

String EmpId = ((Long) session.getAttribute("EmpId")).toString();

String statuscode = carsIni.getCARSStatusCode();
String statuscodeNext = carsIni.getCARSStatusCodeNext();
String amount = carsSoC.getSoCAmount();
String carsInitiationId = carsIni!=null?carsIni.getCARSInitiationId()+"":"0";
String carsSoCId = carsSoC!=null?carsSoC.getCARSSoCId()+"":"0";

List<Object[]> labList = (List<Object[]>)request.getAttribute("LabList");
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
         		<div class="card-header slider_header p-0 fs-12 hei-0" >
             		<h3 class="category">D-P&C SoC Details - 
             		
             			<button type="button" class="btn btn-sm btn-info btn-bg-head">
             				<div>
					        	<div class="row">
					        		<div class="col-md-1">
					        			<span class="cssideheading">Title:</span>
					                </div>
					            	<div class="col-md-11 ml-minus-5">
					                	<span class="cssideheadingdata"><%if(carsIni!=null && carsIni.getInitiationTitle()!=null) {%><%=carsIni.getInitiationTitle() %> <%} else{%>-<%} %></span>
					                </div>
					                
					            </div>
					                	
					            <div class="row">
					            	<div class="col-md-4">
					                	<span class="cssideheading">CARS. No:</span>
					                	&emsp;<span class="cssideheadingdata"><%if(carsIni!=null && carsIni.getCARSNo()!=null) {%><%=carsIni.getCARSNo() %> <%} else{%>-<%} %></span>
					            	</div>
					            <div class="col-md-1"></div>
					            <div class="col-md-3">
					            	<span class="cssideheading">Funds from:</span>
					                &emsp;<span class="cssideheadingdata">
					                	<%if(carsIni!=null && carsIni.getFundsFrom()!=null && carsIni.getFundsFrom().equalsIgnoreCase("0")) {%>
					                		Buildup
					                	<%} else{%>
					                		<%if(PDs!=null && PDs[3]!=null) {%><%=PDs[3].toString()%> (<%=PDs[0]!=null?PDs[0].toString(): " - "%>)<%} %>
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
             			<%if(isApproval!=null && isApproval.equalsIgnoreCase("P") ) {%>
               				href="CARSRSQRApprovals.htm"
               			<%} else if(isApproval!=null && isApproval.equalsIgnoreCase("Q") ) {%>
               				href="CARSRSQRApprovals.htm?val=app"
               			<%} else {%>
             			    href="CARSRSQRApprovedList.htm?AllListTabId=2"
             			<%} %> 
             			  >Back</a>
             		</h3>
             		<hr class="hr-m-minus">
             		<ul class="nav nav-tabs justify-content-center pb-0" role="tablist">
            			<li class="nav-item" id="nav-socdetails">
             				<%if(dpcTabId!=null && dpcTabId.equalsIgnoreCase("1")){ %> 
             		    		<a class="nav-link active " data-toggle="tab" href="#socdetails" id="nav" role="tab">
             				<%}else{ %>
              			 		<a class="nav-link  " data-toggle="tab" href="#socdetails" role="tab">
               				<%} %>  
                	         	SoC Details
              			 		</a>
            			</li>

            			<li class="nav-item" id="nav-socforward">
            	     		<%if(dpcTabId!=null && dpcTabId.equalsIgnoreCase("2")){ %>
              					<a class="nav-link active" data-toggle="tab" href="#socforward" id="nav"role="tab" >
              				<%}else{ %>
              					<a class="nav-link" data-toggle="tab" href="#socforward" role="tab" >
               				<%} %>
                  				SoC Forward
              					</a>
            			</li>
            			
            			<li class="nav-item" id="nav-alldocs">
		            	     <%if(dpcTabId!=null && dpcTabId.equalsIgnoreCase("3")){ %>
		              			<a class="nav-link active" data-toggle="tab" href="#alldocs" id="nav"role="tab" >
		              		<%}else{ %>
		              			<a class="nav-link" data-toggle="tab" href="#alldocs" role="tab" >
		               		<%} %>
                  				All Docs
              					</a>
            			</li>
              		</ul>
         		</div>
         		
         		<!-- This is for Tab Panes -->
         		<div class="card">
         			<div class="tab-content text-center mt-1">
         				<!-- *********** SoC Details ***********      --> 
               			<%if(dpcTabId!=null && dpcTabId.equalsIgnoreCase("1")){ %> 
         					<div class="tab-pane active" id="socdetails" role="tabpanel">
         				<%}else{ %>
              				<div class="tab-pane " id="socdetails" role="tabpanel">
               			<%} %>
               		 			<form action="CARSDPCSoCEdit.htm" method="POST" name="inieditform" id="inieditform">
               		 				<input type="hidden" name="carsInitiationId" value="<%=carsIni.getCARSInitiationId()%>">
               		 				<input type="hidden" name="carsSocId" value="<%=carsSoC.getCARSSoCId()%>">
               						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
               						<div class="row">
               			    			<div class="col-md-12 mlr-60">
               			    				<!-- First row of SoC Details  -->
               			    				<div class="row details">
               			    					<div class="column b column-b">
               			    						<label class="control-label">Introduction</label><span class="mandatory">*</span>
               			    					</div>
               			    				</div>
               			     				<div class="row details mt-minus-1p">
                       							
                       								<div class="column b w-94-5" >
														<div id="dpcIntroductionnote" > </div>
														<textarea id="dpcIntroductionhidden" class="dis-none" ><%if(carsSoC!=null && carsSoC.getDPCIntroduction()!=null){ %><%=StringEscapeUtils.escapeHtml4(carsSoC.getDPCIntroduction())%><%} %></textarea>
														<textarea name="dpcIntroduction" class="dis-none" ></textarea>
                       							</div>
                        					</div>
               			    				<!-- Second row of SoC Details  -->
               			     				<div class="row details">
                       							<div class="column b div-det">
                           							<label class="control-label">Expenditure Head</label><span class="mandatory">*</span>
                             						<textarea  class="form-control form-control input-font" name="dpcExpenditure" id="dpcExpenditure" rows="4" cols="65" maxlength="2000"
                             		 				 placeholder="Enter Expenditure Head" required><%if(carsSoC!=null && carsSoC.getDPCExpenditure()!=null){ %><%=StringEscapeUtils.escapeHtml4(carsSoC.getDPCExpenditure())%><%} %></textarea>
                       							</div>
                       							<div class="column b div-det" >
                           							<label class="control-label">Additional Points</label>
                             						<textarea  class="form-control form-control input-font" name="dpcAdditional" id="dpcAdditional" rows="4" cols="65" maxlength="1000"
                             		 				 placeholder="Enter Additional Points ( if any )" ><%if(carsSoC!=null && carsSoC.getDPCAdditional()!=null){ %><%=StringEscapeUtils.escapeHtml4(carsSoC.getDPCAdditional())%><%} %></textarea>
                       							</div>
                        					</div>
               			    			</div>
               			    		</div>
               			    		<br>
              						<div align="center">
										<%if(carsSoC!=null && carsSoC.getDPCIntroduction()!=null){ %>
											<button type="submit" class="btn btn-sm btn-warning edit btn-soc" name="Action" value="Edit" onclick="return confirm('Are you sure to update?')" >UPDATE</button>
										<%}else{ %>
											<button type="submit" class="btn btn-sm btn-success submit btn-soc" name="Action" value="Add" onclick="return confirm('Are you sure to submit?')" >SUBMIT</button>
										<%} %>
									</div>
               					</form>
               				
               					<div class="navigation_btn text-right">
            						<a class="btn btn-info btn-sm  shadow-nohover back text-white" href="CARSRSQRApprovedList.htm?AllListTabId=2">Back</a>
									<button class="btn btn-info btn-sm next">Next</button>
								</div>
               			<%if(dpcTabId!=null && dpcTabId.equalsIgnoreCase("1")){ %> 
         					</div>
         				<%}else{ %>
              				</div>
               			<%} %>
               			
               			<!-- *********** SoC Forward *********** --> 
               			<%if(dpcTabId!=null && dpcTabId.equalsIgnoreCase("2")){ %> 
         					<div class="tab-pane active" id="socforward" role="tabpanel">
         				<%}else{ %>
              				<div class="tab-pane " id="socforward" role="tabpanel">
		               	<%} %>
		               			<%if(carsSoC!=null && carsSoC.getDPCIntroduction()!=null) {%>
		               				<div class="col-md-8 mt-1">
               							<div class="card card-bor" >
               								<div class="card-body mt-2 ml-4">
               									<form action="#">
               										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			               		   					<input type="hidden" name="carsInitiationId" value="<%=carsIni.getCARSInitiationId()%>">
			               		   					<input type="hidden" name="carsSocId" value="<%=carsSoC.getCARSSoCId()%>">
			               		   					<div class="mt-2" align="center">
               											<h5 class="fw-bold mt-4" >Statement of Case for availing CARS
               											&emsp;<button type="submit" class="btn btn-sm" formaction="CARSDPCSoCDownload.htm" name="carsInitiationId" value="<%=carsIni.getCARSInitiationId() %>" formtarget="blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="Download">
								  	 							<i class="fa fa-download" aria-hidden="true"></i>
															  </button>
               											</h5>
               										</div>
			               		   					<div class="soccontainer">
			               		   						<div class="width-97">
			               		   							<h5 class="socheading"><span>1.</span> <span class="text-ul">Introduction</span></h5>
				               		   						<div class="soccontent">
				               		   							<p class="text-in input-font" ><%=carsSoC.getDPCIntroduction()!=null?carsSoC.getDPCIntroduction(): " - " %></p>
				               		   						</div>
			               		   						</div>
			               		   						<div>
			               		   							<h5 class="socheading"><span>2.</span> <span class="text-ul">The Summary of the CARS is as under</span></h5>
			               		   							<div class="soccontent">
			               		   								<table id="socforwardtable">
						               		   						<tr>
						               		   							<th class="width-5">SN</th>
						               		   							<th class="width-23">Subject</th>
						               		   							<th class="width-70">Details</th>
						               		   						</tr>
						               		   						<tr>
						               		   							<td>1.</td>
						               		   							<td>CARS Title</td>
						               		   							<td><%=carsIni.getInitiationTitle()!=null?carsIni.getInitiationTitle(): " - " %></td>
						               		   						</tr>
						               		   						<tr>
						               		   							<td>2.</td>
						               		   							<td>File No</td>
						               		   							<td><%=carsIni.getCARSNo()!=null?carsIni.getCARSNo(): " - " %></td>
						               		   						</tr>
						               		   						<!-- <tr>
						               		   							<td>3.</td>
						               		   							<td>Deliverables</td>
						               		   							<td>-do-</td>
						               		   						</tr> -->
						               		   						<tr>
						               		   							<td>3.</td>
						               		   							<td>Service Type</td>
						               		   							<td>General Revenue</td>
						               		   						</tr>
						               		   						<tr>
						               		   							<td>4.</td>
						               		   							<td>Estimated cost of service (&#8377;)</td>
						               		   							<td><%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(amount)) %></td>
						               		   						</tr>
						               		   						<tr>
						               		   							<td>5.</td>
						               		   							<td>CARS PDC</td>
						               		   							<td><%=carsSoC.getSoCDuration()!=null?carsSoC.getSoCDuration(): " - " %></td>
						               		   						</tr>
						               		   						<tr>
						               		   							<td>6.</td>
						               		   							<td>Expenditure Head</td>
						               		   							<td><%=expenditure!=null?expenditure: " - " %></td>
						               		   						</tr>
						               		   						<tr>
						               		   							<td>7.</td>
						               		   							<td>CFA approval as per DFP</td>
						               		   							<td>Under Sl. No: 2.4 of DFP dated 18 Dec 2019</td>
						               		   						</tr>
						               		   						<tr>
						               		   							<td>8.</td>
						               		   							<td>Additional Points</td>
						               		   							<td><%if(carsSoC.getDPCAdditional()!=null && !carsSoC.getDPCAdditional().isEmpty()) {%><%=carsSoC.getDPCAdditional() %><%} else{%>-<%} %></td>
						               		   						</tr>
			               		   								</table>
			               		   							</div>
			               		   						</div>
			               		   						
			               		   						<div>
			               		   							<h5 class="socheading"><span>3.</span> <span class="text-ul">Description</span></h5>
				               		   						<div class="soccontent">
				               		   							<p class="input-font">
				               		   								<%=carsIni.getRSPInstitute()!=null?carsIni.getRSPInstitute(): " - "%>, <%=carsIni.getRSPCity()!=null?carsIni.getRSPCity(): " - " %> has submitted the &#39;Summary of Offer&#39; for Rs <span class="textunderline"><%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(amount)) %></span>
				               		   								(inclusive of GST) for duration of <span class="textunderline"><%=carsSoC.getSoCDuration()!=null?carsSoC.getSoCDuration(): " - " %></span> months. Required schedule of payments is given below.
				               		   							</p>
				               		   							<table id="milestonestable">
				               		   								<tr>
				               		   								  <th class="width-10">Milestone No.</th>
				               		   								  <th class="width-28">Task Description</th>
				               		   								  <th class="width-5">Months</th>
				               		   								  <th class="width-25">Deliverables</th>
				               		   								  <th class="width-5">Payment <br>( In % )</th>
				               		   								  <th class="width-10">Amount (&#8377;)</th>
				               		   								  <th class="width-15">Remarks</th>
				               		   								</tr>
				               		   								<%if(milestones!=null && milestones.size()>0) {
				               		   									for(CARSSoCMilestones mil : milestones){
				               		   						
				               		   								%>
					               		   								<tr>
					               		   									<td class="width-10 text-center" ><%=mil.getMilestoneNo()!=null?mil.getMilestoneNo(): " - " %></td>
					               		   									<td class="width-28"><%=mil.getTaskDesc()!=null?mil.getTaskDesc(): " - " %></td>
					               		   									<td class="width-5 text-center" ><%="T0 + "+(mil.getMonths()!=null?mil.getMonths(): " - ") %></td>
					               		   									<td class="width-25" ><%=mil.getDeliverables()!=null?mil.getDeliverables(): " - " %></td>
					               		   									<td class="width-5 text-center" ><%=mil.getPaymentPercentage()!=null?mil.getPaymentPercentage(): " - " %></td>
					               		   									<td class="width-10 text-right"><%if(mil.getActualAmount()!=null) {%><%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(mil.getActualAmount())) %><%} else{%>-<%} %></td>
					               		   									<td class="width-15" ><%if(mil.getPaymentTerms()!=null) {%><%=mil.getPaymentTerms() %><%} else{%>-<%} %></td>
					               		   								</tr>
				               		   								<%}} %>
				               		   								
				               		   							</table>
				               		   							<br>
				               		   							<p class="input-font">
				               		   								The Contract for Acquisition of Professional Services to be placed on <%=carsIni.getRSPInstitute()!=null?carsIni.getRSPInstitute(): " - "+", "+carsIni.getRSPCity()!=null?carsIni.getRSPCity(): " - " %> (CARS) file is submitted with the following documents.
				               		   							</p>
				               		   							<table id="desctable">
						               		   						<tr>
						               		   							<th class="width-5" >SN</th>
						               		   							<th class="width-70" >Description</th>
						               		   							<th class="width-23" >Reference</th>
						               		   						</tr>
						               		   						<tr>
						               		   							<td class="text-center">1.</td>
						               		   							<td>Statement of Case for availing CARS, Research Service Qualitative Requirement</td>
						               		   							<td>Annexure A</td>
						               		   						</tr>
						               		   						<tr>
						               		   							<td>2.</td>
						               		   							<td>Recommendation of RSQR by CARS Scrutinising Committee</td>
						               		   							<td>Annexure B</td>
						               		   						</tr>
						               		   						<tr>
						               		   							<td>3.</td>
						               		   							<td>CARS proposal and Summary of Offer from RSP</td>
						               		   							<td>Annexure C</td>
						               		   						</tr>
						               		   						<tr>
						               		   							<td>4.</td>
						               		   							<td>Recommendation by Group/ Project Director on the response of the academic institution on RSQR</td>
						               		   							<td>Annexure D</td>
						               		   						</tr>
						               		   						<tr>
						               		   							<td>5.</td>
						               		   							<td>Draft Contract Copy</td>
						               		   							<td>Annexure E</td>
						               		   						</tr>
						               		   					</table>
				               		   						</div>
				               		   						
			               		   						</div>
			               		   						
			               		   						<div class="width-97">
			               		   							<h5 class="socheading"><span>4.</span> <span class="text-ul">Approval Sought</span></h5>
				               		   						<div class="soccontent">
				               		   							<%if(carsSoC!=null && carsSoC.getDPCApprovalSought()!=null && !carsSoC.getDPCApprovalSought().isEmpty() && ( GHDPandC!=null && EmpId.equalsIgnoreCase(GHDPandC[0].toString()) ) ) {%>
				               		   								<textarea class="form-control" name="approvalSought" rows="4" required><%=carsSoC.getDPCApprovalSought() %></textarea>
				               		   							<%} else if(carsSoC!=null && carsSoC.getDPCApprovalSought()!=null && !carsSoC.getDPCApprovalSought().isEmpty() && ( GHDPandC!=null && !EmpId.equalsIgnoreCase(GHDPandC[0].toString()) ) ){%>
					               		   							<p class="text-in input-font">
																		<%=carsSoC.getDPCApprovalSought().replaceAll("\n", "<br>") %>
																	</p>
				               		   							<%} else{%>
				               		   								<textarea class="form-control" name="approvalSought" rows="4" maxlength="3000" required>The case is being submitted along with the above-mentioned documents for obtaining the Concurrence cum Financial sanction and approval from Competent Financial Authority (CFA) for placement of Contract for Acquisition of Research Services (CARS) on <%=carsIni.getRSPInstitute()!=null?carsIni.getRSPInstitute(): " - "%>, <%=carsIni.getRSPCity()!=null?carsIni.getRSPCity(): " - " %> at a cost of Rs. <%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(amount)) %> please.</textarea>
				               		   							<%} %>
				               		   						</div>
			               		   						</div>
			               		   						
			               		   					</div>
			               		   					<br>
			               		   					
			               		   					<!-- Signatures and timestamps -->
			               		   					
													<div class="div-tab">
		               								 	<div class="input-font"> Signature of GH-DP&C</div>
						               					<%for(Object[] apprInfo : dpcSoCApprovalEmpData){ %>
						   			   					<%if(apprInfo[8].toString().equalsIgnoreCase("SFD")){ %>
						   								<label class="text-uppercase mt-3"><%=apprInfo[2]!=null?apprInfo[2].toString(): " - "%></label>,<!-- <br> -->
						   								<label class="text-uppercase"><%=apprInfo[3]!=null?apprInfo[3].toString(): " - "%></label><br>
						   								<label class="fs-12">[Forwarded On:&nbsp; <%= apprInfo[4]!=null?fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19): " - " %>]</label>
						   			    				<%break;}} %>  
							            			 </div>
							            			 
							            			 <%for(Object[] apprInfo : dpcSoCApprovalEmpData) {%>
							            			 	<div class="tab-div">
							            			 		
							            			 		<%if(apprInfo[8].toString().equalsIgnoreCase("SGD")){ %>
							            			 			<div class="input-font" > Signature of GD-DP&C</div>
								   								<label class="text-uppercase mt-3" ><%=apprInfo[2]!=null?apprInfo[2].toString(): " - "%></label>,<!-- <br> -->
								   								<label class="text-uppercase "><%=apprInfo[3]!=null?apprInfo[3].toString(): " - "%></label><br>
								   								<label class="fs-12" >[Recommended On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10)) +" "+apprInfo[4].toString().substring(11,19): " - "  %>]</label>
							   			    				<%} else if(apprInfo[8].toString().equalsIgnoreCase("SPD")) {%> 
							   			    					<div class="input-font" > Signature of PD</div>
							   			    					<label class="text-uppercase mt-3" ><%=apprInfo[2]!=null?apprInfo[2].toString(): " - "%></label>,<!-- <br> -->
								   								<label class="text-uppercase " ><%=apprInfo[3]!=null?apprInfo[3].toString(): " - "%></label><br>
								   								<label class="fs-12" >[Recommended On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19): " - " %>]</label>
							   			    				<%} else if(apprInfo[8].toString().equalsIgnoreCase("SCR")) {%> 
							   			    					<div class="input-font" > Signature of Chairman RPB</div>
							   			    					<label class="text-uppercase mt-3" ><%=apprInfo[2]!=null?apprInfo[2].toString(): " - "%></label>,<!-- <br> -->
								   								<label class="text-uppercase" ><%=apprInfo[3]!=null?apprInfo[3].toString(): " - "%></label><br>
								   								<label class="fs-12" >[Recommended On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19): " - "  %>]</label>
							   			    				<%} else if(apprInfo[8].toString().equalsIgnoreCase("SMA")) {%> 
							   			    					<div class="input-font" > Signature of MMFD AG</div>
							   			    					<label class="text-uppercase mt-3" ><%=apprInfo[2]!=null?apprInfo[2].toString(): " - "%></label>,<!-- <br> -->
								   								<label class="text-uppercase" ><%=apprInfo[3]!=null?apprInfo[3].toString(): " - "%></label><br>
								   								<label class="fs-12" >[Recommended On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19): " - " %>]</label>
							   			    				<%} else if(apprInfo[8].toString().equalsIgnoreCase("SDF")) {%> 
							   			    					<div class="input-font" > Signature of GD DF&MM</div>
							   			    					<label class="text-uppercase mt-3" ><%=apprInfo[2]!=null?apprInfo[2].toString(): " - "%></label>,<!-- <br> -->
								   								<label class="text-uppercase" ><%=apprInfo[3]!=null?apprInfo[3].toString(): " - "%></label><br>
								   								<label class="fs-12" >[Recommended On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19): " - "  %>]</label>
							   			    					
							   			    				<%} %>
							   			    				<%if(amount!=null && Double.parseDouble(amount)<=1000000) {%>
							   			    					<% if(apprInfo[8].toString().equalsIgnoreCase("SAD")) {%> 
							   			    						<div class="input-font" > Signature of Director</div>
							   			    						<label class="text-uppercase mt-3" ><%=apprInfo[2]!=null?apprInfo[2].toString(): " - "%></label>,<!-- <br> -->
								   									<label class="text-uppercase" ><%=apprInfo[3]!=null?apprInfo[3].toString(): " - "%></label><br>
								   									<label class="fs-12" >[Approved On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19): " - "  %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("SDD")) {%> 
							   			    						<div class="input-font" > Signature of Director</div>
							   			    						<label class="text-uppercase mt-3" ><%=apprInfo[2]!=null?apprInfo[2].toString(): " - "%></label>,<!-- <br> -->
								   									<label class="text-uppercase" ><%=apprInfo[3]!=null?apprInfo[3].toString(): " - "%></label><br>
								   									<label class="fs-12" >[Disapproved On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19): " - "  %>]</label>
							   			    					<%} %>
							   			    				<%} else if(amount!=null && (Double.parseDouble(amount)>1000000 && Double.parseDouble(amount)<=5000000) ) {%>
							   			    					<% if(apprInfo[8].toString().equalsIgnoreCase("SAI")) {%>
							   			    						<div class="input-font" > Signature of IFA, O/o DG (ECS)</div>
							   			    						<label class="text-uppercase mt-3" ><%if(apprInfo[2]!=null) {%> <%=apprInfo[2].toString()%> <%} else{%><%=apprInfo[10]!=null?apprInfo[10].toString(): " - " %> <%} %></label>,<!-- <br> -->
								   									<label class="text-uppercase" ><%if(apprInfo[3]!=null) {%> <%=apprInfo[3].toString()%> <%} else{%>IFA, O/o DG (ECS) <%} %></label><br>
								   									<label class="fs-12" >[Approved On:&nbsp; <%=  apprInfo[4]!=null?fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10)) : " - "  %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("SDI")) {%> 
							   			    						<div class="input-font" > Signature of IFA, O/o DG (ECS)</div>
							   			    						<label class="text-uppercase mt-3" ><%if(apprInfo[2]!=null) {%> <%=apprInfo[2].toString()%> <%} else{%><%=apprInfo[10]!=null?apprInfo[10].toString(): " - " %> <%} %></label>,<!-- <br> -->
								   									<label class="text-uppercase" ><%if(apprInfo[3]!=null) {%> <%=apprInfo[3].toString()%> <%} else{%>IFA, O/o DG (ECS) <%} %></label><br>
								   									<label class="fs-12" >[Disapproved On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10)) : " - "   %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("SAD")) {%> 
							   			    						<div class="input-font"  > Signature of Director</div>
							   			    						<label class="text-uppercase mt-3" ><%=apprInfo[2]!=null?apprInfo[2].toString(): " - "%></label>,<!-- <br> -->
								   									<label class="text-uppercase" ><%=apprInfo[3]!=null?apprInfo[3].toString(): " - "%></label><br>
								   									<label class="fs-12" >[Approved On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19): " - "  %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("SDD")) {%> 
							   			    						<div class="input-font" > Signature of Director</div>
							   			    						<label class="text-uppercase mt-3" ><%=apprInfo[2]!=null?apprInfo[2].toString(): " - "%></label>,<!-- <br> -->
								   									<label class="text-uppercase" ><%=apprInfo[3]!=null?apprInfo[3].toString(): " - "%></label><br>
								   									<label class="fs-12" >[Disapproved On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19): " - " %>]</label>
							   			    					<%} %>
							   			    				<%} else if(amount!=null && (Double.parseDouble(amount)>5000000 && Double.parseDouble(amount)<=30000000)) {%>
							   			    					<% if(apprInfo[8].toString().equalsIgnoreCase("SAD")) {%> 
							   			    						<div class="input-font" > Signature of Director</div>
							   			    						<label class="text-uppercase mt-3" ><%=apprInfo[2]!=null?apprInfo[2].toString(): " - "%></label>,<!-- <br> -->
								   									<label class="text-uppercase" ><%=apprInfo[3]!=null?apprInfo[3].toString(): " - "%></label><br>
								   									<label class="fs-12" >[Approved On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19): " - "  %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("SDD")) {%> 
							   			    						<div class="input-font" > Signature of Director</div>
							   			    						<label class="text-uppercase mt-3" ><%=apprInfo[2]!=null?apprInfo[2].toString(): " - "%></label>,<!-- <br> -->
								   									<label class="text-uppercase" ><%=apprInfo[3]!=null?apprInfo[3].toString(): " - "%></label><br>
								   									<label class="fs-12" >[Disapproved On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19): " - " %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("SAI")) {%>
							   			    						<div class="input-font" > Signature of IFA, O/o DG (ECS)</div>
							   			    						<label class="text-uppercase mt-3" ><%if(apprInfo[2]!=null) {%> <%=apprInfo[2].toString()%> <%} else{%><%=apprInfo[10]!=null?apprInfo[10].toString(): " - " %> <%} %></label>,<!-- <br> -->
								   									<label class="text-uppercase" ><%if(apprInfo[3]!=null) {%> <%=apprInfo[3].toString()%> <%} else{%>IFA, O/o DG (ECS) <%} %></label><br>
								   									<label class="fs-12" >[Approved On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10)) : " - "   %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("SDI")) {%> 
							   			    						<div class="input-font" > Signature of IFA, O/o DG (ECS)</div>
							   			    						<label class="text-uppercase mt-3" ><%if(apprInfo[2]!=null) {%> <%=apprInfo[2].toString()%> <%} else{%><%=apprInfo[10]!=null?apprInfo[10].toString(): " - "  %> <%} %></label>,<!-- <br> -->
								   									<label class="text-uppercase" ><%if(apprInfo[3]!=null) {%> <%=apprInfo[3].toString()%> <%} else{%>IFA, O/o DG (ECS) <%} %></label><br>
								   									<label class="fs-12" >[Disapproved On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10)) : " - "  %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("ADG")) {%>
							   			    						<div class="input-font" > Signature of DG (ECS)</div>
							   			    						<label class="text-uppercase mt-3" ><%if(apprInfo[2]!=null) {%> <%=apprInfo[2].toString()%> <%} else{%><%=apprInfo[10]!=null?apprInfo[10].toString(): " - "  %> <%} %></label>,<!-- <br> -->
								   									<label class="text-uppercase" ><%if(apprInfo[3]!=null) {%> <%=apprInfo[3].toString()%> <%} else{%>DG (ECS) <%} %></label><br>
								   									<label class="fs-12" >[Approved On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10)) : " - "  %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("DDG")) {%> 
							   			    						<div class="input-font" > Signature of DG (ECS)</div>
							   			    						<label class="text-uppercase mt-3" ><%if(apprInfo[2]!=null) {%> <%=apprInfo[2].toString()%> <%} else{%><%=apprInfo[10]!=null?apprInfo[10].toString(): " - "  %> <%} %></label>,<!-- <br> -->
								   									<label class="text-uppercase" ><%if(apprInfo[3]!=null) {%> <%=apprInfo[3].toString()%> <%} else{%>DG (ECS) <%} %></label><br>
								   									<label class="fs-12" >[Disapproved On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10)) : " - "   %>]</label>
							   			    					<%} %>
							   			    				<%} else if(amount!=null && (Double.parseDouble(amount)>30000000)) {%>	
							   			    					<% if(apprInfo[8].toString().equalsIgnoreCase("SAD")) {%> 
							   			    						<div class="input-font" > Signature of Director</div>
							   			    						<label class="text-uppercase mt-3" ><%=apprInfo[2]!=null?apprInfo[2].toString(): " - "%></label>,<!-- <br> -->
								   									<label class="text-uppercase" ><%=apprInfo[3]!=null?apprInfo[3].toString(): " - "%></label><br>
								   									<label class="fs-12" >[Approved On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10))  +" "+apprInfo[4].toString().substring(11,19): " - " %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("SDD")) {%> 
							   			    						<div class="input-font" > Signature of Director</div>
							   			    						<label class="text-uppercase mt-3" ><%=apprInfo[2]!=null?apprInfo[2].toString(): " - "%></label>,<!-- <br> -->
								   									<label class="text-uppercase" ><%=apprInfo[3]!=null?apprInfo[3].toString(): " - "%></label><br>
								   									<label class="fs-12" >[Disapproved On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10)) +" "+apprInfo[4].toString().substring(11,19): " - "  %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("SAJ")) {%>
							   			    						<div class="input-font" > Signature of JSA</div>
							   			    						<label class="text-uppercase mt-3" ><%if(apprInfo[2]!=null) {%> <%=apprInfo[2].toString()%> <%} else{%><%=apprInfo[10] !=null?apprInfo[10].toString(): " - " %> <%} %></label>,<!-- <br> -->
								   									<label class="text-uppercase" ><%if(apprInfo[3]!=null) {%> <%=apprInfo[3].toString()%> <%} else{%>JSA <%} %></label><br>
								   									<label class="fs-12" >[Approved On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10)) : " - "   %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("SDJ")) {%> 
							   			    						<div class="input-font" > Signature of JSA</div>
							   			    						<label class="text-uppercase mt-3" ><%if(apprInfo[2]!=null) {%> <%=apprInfo[2].toString()%> <%} else{%><%=apprInfo[10] !=null?apprInfo[10].toString(): " - " %> <%} %></label>,<!-- <br> -->
								   									<label class="text-uppercase" ><%if(apprInfo[3]!=null) {%> <%=apprInfo[3].toString()%> <%} else{%>JSA <%} %></label><br>
								   									<label class="fs-12" >[Disapproved On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10)) : " - "   %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("SAS")) {%>
							   			    						<div class="input-font" > Signature of SECY</div>
							   			    						<label class="text-uppercase mt-3" ><%if(apprInfo[2]!=null) {%> <%=apprInfo[2].toString()%> <%} else{%><%=apprInfo[10]!=null?apprInfo[10].toString(): " - "  %> <%} %></label>,<!-- <br> -->
								   									<label class="text-uppercase" ><%if(apprInfo[3]!=null) {%> <%=apprInfo[3].toString()%> <%} else{%>SECY <%} %></label><br>
								   									<label class="fs-12" >[Approved On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10)) : " - "   %>]</label>
							   			    					<%} else if(apprInfo[8].toString().equalsIgnoreCase("SDS")) {%> 
							   			    						<div class="input-font" > Signature of SECY</div>
							   			    						<label class="text-uppercase mt-3" ><%if(apprInfo[2]!=null) {%> <%=apprInfo[2].toString()%> <%} else{%><%=apprInfo[10]!=null?apprInfo[10].toString(): " - "  %> <%} %></label>,<!-- <br> -->
								   									<label class="text-uppercase" ><%if(apprInfo[3]!=null) {%> <%=apprInfo[3].toString()%> <%} else{%>SECY <%} %></label><br>
								   									<label class="fs-12" >[Disapproved On:&nbsp; <%=apprInfo[4]!=null?fc.SqlToRegularDate(apprInfo[4].toString().substring(0, 10)) : " - "   %>]</label>
							   			    					<%} %>
							   			    				<%} %>
							            			 	</div>	
							            			 <%} %>
													
			               		   					<!-- Remarks -->
			               		   					<div class="row mt-2">
														<%if(dpcSoCRemarksHistory.size()>0){ %>
															<div class="col-md-8 remarks-div" align="left" >
																<%if(dpcSoCRemarksHistory.size()>0){ %>
																	<table class="m-1 p-0">
																		<tr>
																			<td class="bor-none p-0">
																			<h6 class="text-ul">Remarks :</h6> 
																			</td>											
																		</tr>
																		<%for(Object[] obj : dpcSoCRemarksHistory){%>
																		<tr>
																			<td class="rem-soc">
																				<%if(obj[3]!=null) {%> <%=obj[3].toString()%> <%} else{%><%=obj[5]!=null?obj[5].toString(): " - " %> <%} %> &nbsp; :
																				<span class="bor-none col-blue"><%=obj[1]!=null?obj[1].toString(): " - " %></span>
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
															<%if(statuscode!=null && dpcsocforwardstatus.contains(statuscode) && ( GHDPandC!=null && EmpId.equalsIgnoreCase(GHDPandC[0].toString()) ) ) {%>
																<div class="ml-2" align="left">
									   								<b >Remarks :</b><br>
									   								<textarea rows="3" cols="65" name="remarks" id="remarksarea" maxlength="1000" ></textarea>
								         						</div>
																<button type="submit" class="btn btn-sm submit" id="" name="Action" formaction="DPCSoCApprovalSubmit.htm" formnovalidate="formnovalidate" value="A" onclick="return confirm('Are you Sure to Submit ?');" >Forward</button>
															<%} %>
															<%if(isApproval!=null && isApproval.equalsIgnoreCase("P")) {%>
																<%if(dpcsocexternalapprovestatus.contains(statuscodeNext) ) {%>
																	<div class="row externalapproval" >
																		<div class="col-md-3">
																			<label class="control-label">Lab</label><span class="mandatory">*</span>
																			<select class="form-control selectdee" id="LabCode" name="LabCode" onchange="LabcodeSubmit()" data-live-search="true"  required="required">
		        																<option disabled="disabled" value="" selected="selected"> Select</option>
																					<%if (labList != null && labList.size() > 0) {
																						for (Object[] obj : labList) {
																					%>
																						<option value=<%=obj[2].toString()%>><%=obj[2]!=null?obj[2].toString(): " - "%></option>
																					<%}}%>
																					<option value="@EXP">Expert</option>
																			</select>
																		</div>
																		<div class="col-md-5">
																			<label class="control-label">Approval Officer</label><span class="mandatory">*</span>
				  															<select class="form-control selectdee" id="approverEmpId" name="approverEmpId" data-live-search="true" required>
				  																<option disabled="disabled" value="" selected="selected"> Select</option>
				  															</select>
																		</div>
																		<div class="col-md-4">
																			<label class="control-label" >Approval Date</label><span class="mandatory">*</span>
			          														<input type="text" class="form-control" id="approvalDate" name="approvalDate">
																		</div>
																		
																	</div>
																<%} %>
																<div class="ml-2" align="left">
									   								<b >Remarks :</b><br>
									   								<textarea rows="3" cols="65" name="remarks" id="remarksarea" maxlength="1000"></textarea>
								         						</div>
								         						<%if(carsIni!=null && dpcsocapprovestatus.contains(statuscode)) {%>
								         						<button type="submit" class="btn btn-sm btn-success fw-600" id="finalSubmission" formaction="DPCSoCApprovalSubmit.htm" name="Action" value="A" onclick="return confirm('Are You Sure To Approve?');" >
										    						Approve	
									      						</button>
									      						<button type="submit" class="btn btn-sm btn-danger fw-600 btn-bg-ret" id="finalSubmission" formaction="DPCSoCApprovalSubmit.htm" name="Action" value="R" onclick="return validateTextBox();" >
										 							Return
																</button>
								         						<%} else{%>
																<button type="submit" class="btn btn-sm btn-success fw-600" id="finalSubmission" formaction="DPCSoCApprovalSubmit.htm" name="Action" value="A" onclick="return confirm('Are You Sure To Recommend?');" >
										    						Recommend	
									      						</button>
									      						
									      						<button type="submit" class="btn btn-sm btn-danger fw-600 btn-bg-ret" id="finalSubmission" formaction="DPCSoCApprovalSubmit.htm" name="Action" value="R" onclick="return validateTextBox();">
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
               						<div class="mt-4 dis-cen" >
               							<h4 class="fw-bold mandatory">Please fill the SoC Details..!</h4>
               						</div>
               					<%} %>
               					
               					<div class="js-c">
               						<div></div>
		               				<div>
		               					<%if(carsIni!=null && isApproval==null) {%>
		               					<div class="row"  >
				 		  					<div class="col-md-12 text-center"><b>Approval Flow For DP&C SoC Forward</b></div>
				 	    				</div>
				 	    				<div class="row pt-2 pb-3 text-center"   >
			              					<table align="center"  >
			               						<tr>
			               							<td class="trup trup-bg-1" >
			                							GH-DP&C - <%if(GHDPandC!=null) {%><%=GHDPandC[1].toString() %> <%} else{%>GH-DP&C<%} %>
			                						</td>
			                		
		                        					<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						
			                						<td class="trup trup-bg-2">
			                							GD-DP&C - <%if(GDDPandC!=null) {%><%=GDDPandC[1].toString() %> <%} else{%>GD-DP&C<%} %>
			                	    				</td>
			                	    				
		                        					<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						
			                						<td class="trup trup-bg-3">
			                							<%if(carsIni.getFundsFrom().equalsIgnoreCase("0")) {%>
	                										Chairman RPB - <%if(ChairmanRPB!=null) {%><%=ChairmanRPB[1].toString() %> <%} else{%>Chairman RPB<%} %>
	                									<%} else{%>
	                										PD - <%if(PDs!=null) {%><%=PDs[2].toString() %><%} else{%>PD<%} %>
	                									<%} %>
			                	    				</td>
			                	    				
		                        					<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						
			                						<td class="trup trup-bg-4" >
			                							MMFD AG - <%if(MMFDAG!=null) {%><%=MMFDAG[1].toString() %> <%} else{%>MMFD AG<%} %>
			                	    				</td>
			                	    				
		                        					<td rowspan="2">
			                							<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                						</td>
			                						
			                						<td class="trup trup-bg-5">
			                							GD DF&MM - <%if(GDDFandMM!=null) {%><%=GDDFandMM[1].toString() %> <%} else{%>GD DF&MM<%} %>
			                	    				</td>
			                	    				
			                	    				<%if(amount!=null && Double.parseDouble(amount)<=1000000) {%>
			                	    					<td rowspan="2">
			                								<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                							</td>
			                						
				                						<td class="trup trup-bg-6">
				                							DIRECTOR - <%if(Director!=null) {%><%=Director[1].toString() %> <%} else{%>DIRECTOR<%} %>
				                	    				</td>
			                	    					
			                	    				<%} %>
			                	    				
			                	    				<%if(amount!=null && (Double.parseDouble(amount)>1000000 && Double.parseDouble(amount)<=5000000) ) {%>
			                	    					<td rowspan="2">
			                								<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                							</td>
			                						
				                						<td class="trup trup-bg-7" >
				                							IFA, O/o DG (ECS) - IFA, O/o DG (ECS)
				                	    				</td>
				                	    				
				                	    				<td rowspan="2">
			                								<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                							</td>
			                						
				                						<td class="trup trup-bg-8" >
				                							DIRECTOR - <%if(Director!=null) {%><%=Director[1].toString() %> <%} else{%>DIRECTOR<%} %>
				                	    				</td>
			                	    				<%} %>
			                	    				
			                	    				<%if(amount!=null && (Double.parseDouble(amount)>5000000 && Double.parseDouble(amount)<=30000000)) {%>
				                	    				
				                	    				<td rowspan="2">
			                								<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                							</td>
			                						
				                						<td class="trup trup-bg-9" >
				                							DIRECTOR - <%if(Director!=null) {%><%=Director[1].toString() %> <%} else{%>DIRECTOR<%} %>
				                	    				</td>
				                	    				
				                	    				<td rowspan="2">
			                								<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                							</td>
			                						
				                						<td class="trup trup-bg-10" >
				                							IFA, O/o DG (ECS) - IFA, O/o DG (ECS)
				                	    				</td>
				                	    				
				                	    				<td rowspan="2">
			                								<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                							</td>
			                						
				                						<td class="trup trup-bg-11" >
				                							DG (ECS) - DG (ECS)
				                	    				</td>
			                	    				<%} %>
			                	    				
			                	    				<%if(amount!=null && (Double.parseDouble(amount)>30000000)) {%>
				                	    				
				                	    				<td rowspan="2">
			                								<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                							</td>
			                						
				                						<td class="trup trup-bg-12" >
				                							DIRECTOR - <%if(Director!=null) {%><%=Director[1].toString() %> <%} else{%>DIRECTOR<%} %>
				                	    				</td>
				                	    				
				                	    				<td rowspan="2">
			                								<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                							</td>
			                						
				                						<td class="trup trup-bg-13" >
				                							JSA - JSA
				                	    				</td>
				                	    				
				                	    				<td rowspan="2">
			                								<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
			                							</td>
			                						
				                						<td class="trup trup-bg-14" >
				                							SECY - SECY
				                	    				</td>
			                	    				<%} %>
			               						</tr> 	
			               	    			</table>			             
					 					</div>
					 					<%} %>
		               				</div>
		               				<div class="navigation_btn text-right" >
		            					<a class="btn btn-info btn-sm  shadow-nohover previous" >Previous</a>
										<button class="btn btn-info btn-sm next">Next</button>
									</div>
               					</div>
               					
		               	<%if(dpcTabId!=null && dpcTabId.equalsIgnoreCase("2")){ %> 
		         			</div>
		         		<%}else{ %>
		              		</div>
		               	<%} %>
		               	
		               	<!-- *********** All Documents ***********      --> 
		               	<%if(dpcTabId!=null && dpcTabId.equalsIgnoreCase("3")){ %> 
		         			<div class="tab-pane active" id="alldocs" role="tabpanel">
		         		<%}else{ %>
		              		<div class="tab-pane " id="alldocs" role="tabpanel">
		               	<%} %>
		               			<%if(carsIni!=null) {%>
		               				<div class="col-md-8 mt-4">
		               					<div class="card card-head-bg">
		               						<div class="card-body mt-2 ml-4">
			               						<form action="#">
			               							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			               							<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId%>">
			               							<input type="hidden" name="carsSocId" value="<%=carsSoCId%>">
			               							<table id="alldocstable">
			               								<thead>
			               									<tr>
			               										<th class="width-10">SN</th>
			               										<th>Subject</th>
			               										<th class="width-10">Action</th>
			               									</tr>
			               								</thead>
			               								<tbody>
			               									<%int docsslno=0; %>
			               									<tr>
			               										<td><%=++docsslno %></td>
			               										<td>RSQR</td>
			               										<td>
				               											<button type="submit" class="btn btn-sm" <%if(carsIni.getInitiationApprDate()!=null) {%>formaction="CARSRSQRDownload.htm"<%} else {%>formaction="CARSRSQRDownloadBeforeFreeze.htm"<%} %>  formtarget="_blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="RSQR Download" >
																			<i class="fa fa-download fa-lg" aria-hidden="true"></i>
																		</button>
			               										</td>
			               									</tr>
			               									<tr>
			               										<td><%=++docsslno %></td>
			               										<td>RSQR Approval Download</td>
			               										<td>
				               											<button type="submit" class="btn btn-sm" formaction="CARSRSQRApprovalDownload.htm" formmethod="post" formnovalidate="formnovalidate" 
				               											 formtarget="blank" formmethod="post" data-toggle="tooltip" data-placement="top" title="RSQR Approval Download">
											  	 							<i class="fa fa-download fa-lg" aria-hidden="true"></i>
																		</button>
			               										</td>
			               									</tr>
			               									<tr>
			               										<td><%=++docsslno %></td>
			               										<td>Invitation for Summary of Offer</td>
			               										<td>
			               											<%if(carsIni!=null && carsIni.getInitiationApprDate()!=null) {%>
			               												<button type="submit" class="btn btn-sm" formaction="CARSInvForSoODownload.htm" formmethod="post" formnovalidate="formnovalidate"
			               												 formtarget="blank" data-toggle="tooltip" data-placement="top" title="Inv for SoO Download">
																			<i class="fa fa-download fa-lg" aria-hidden="true"></i>
																		</button>
			               											<%} else {%>
		                            					 				-
		                            					 			<%} %>
			               										</td>
			               									</tr>
			               									<tr>
			               										<td><%=++docsslno %></td>
			               										<td>Summary of Offer</td>
			               										<td>
			               											<%if(carsSoC!=null && carsSoC.getSoOUpload()!=null) {%>
				                            					 		<button type="submit" class="btn btn-sm" name="filename" formaction="CARSSoCFileDownload.htm" formmethod="post" formnovalidate="formnovalidate"
				                            					 		  value="soofile" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="SoO Download">
				                            					 			<i class="fa fa-download fa-lg"></i>
				                            					 		</button>
		                            					 			<%} else {%>
		                            					 				-
		                            					 			<%} %>
			               										</td>
			               									</tr>
			               									<tr>
			               										<td><%=++docsslno %></td>
			               										<td>Feasibility Report</td>
			               										<td>
			               											<%if(carsSoC!=null && carsSoC.getFRUpload()!=null) {%>
				                            					 		<button type="submit" class="btn btn-sm" name="filename" formaction="CARSSoCFileDownload.htm" formmethod="post" formnovalidate="formnovalidate"
				                            					 		  value="frfile" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Feasibility Report Download">
				                            					 			<i class="fa fa-download fa-lg"></i>
				                            					 		</button>
		                            					 			<%} else {%>
		                            					 				-
		                            					 			<%} %>
			               										</td>
			               									</tr>
			               									<tr>
			               										<td><%=++docsslno %></td>
			               										<td>Final RSQR ( Annexure-I )</td>
			               										<td>
			               											<%if(carsIni!=null && carsIni.getInitiationApprDate()!=null) {%>
		               													<button type="submit" class="btn btn-sm" formaction="CARSFinalRSQRDownload.htm" formnovalidate="formnovalidate" 
		               													formtarget="_blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="Final RSQR Download" >
		               														<i class="fa fa-download fa-lg"></i>
		               													</button>
		               												<%} else {%>
		                            					 				-
		                            					 			<%} %>
			               										</td>
			               									</tr>
			               									<tr>
			               										<td><%=++docsslno %></td>
			               										<td>Milestones & Deliverables ( Annexure-II )</td>
			               										<td>
			               											<%if(milestones!=null && milestones.size()>0) {%>
		               													<button type="submit" class="btn btn-sm" formaction="CARSSoCMilestonesDownload.htm" formnovalidate="formnovalidate" 
		               													formtarget="_blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="Milestones Download">
		               														<i class="fa fa-download fa-lg"></i>
		               													</button>
		               												<%} else {%>
		                            					 				-
		                            					 			<%} %>
			               										</td>
			               									</tr>
			               									<tr>
			               										<td><%=++docsslno %></td>
			               										<td>Execution Plan ( Annexure-IV )</td>
			               										<td>
			               											<%if(carsSoC!=null && carsSoC.getExecutionPlan()!=null) {%>
				                            					 		<button type="submit" class="btn btn-sm" name="filename" formaction="CARSSoCFileDownload.htm" formnovalidate="formnovalidate" formmethod="post"
				                            					 		  value="exeplanfile" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Execution Plan Download">
				                            					 			<i class="fa fa-download fa-lg"></i>
				                            					 		</button>
		                            					 			<%} else {%>
		                            					 				-
		                            					 			<%} %>
			               										</td>
			               									</tr>
			               									<tr>
			               										<td><%=++docsslno %></td>
			               										<td>Statement of Case ( SoC )</td>
			               										<td>
			               											<%if(carsSoC!=null && milestones!=null && milestones.size()>0) {%>
			               												<button type="submit" class="btn btn-sm" formaction="CARSSoCDownload.htm" formnovalidate="formnovalidate" formmethod="post"
			               												  formtarget="blank" data-toggle="tooltip" data-placement="top" title="SoC Download">
										  	 								<i class="fa fa-download fa-lg" aria-hidden="true"></i>
																		</button>
			               											<%} else {%>
		                            					 				-
		                            					 			<%} %>
			               										</td>
			               									</tr>
			               									<tr>
			               										<td><%=++docsslno %></td>
			               										<td>Minutes of Meeting ( MoM )</td>
			               										<td>
			               											<%if(carsSoC!=null && carsSoC.getMoMUpload()!=null) {%>
		                            					 				<button type="submit" class="btn btn-sm" name="filename" formaction="CARSSoCFileDownload.htm" formmethod="post" formnovalidate="formnovalidate"
		                            					 				value="momfile" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="MoM Download">
		                            					 					<i class="fa fa-download fa-lg"></i>
		                            					 				</button>
		                            					 			<%} else {%>
		                            					 				-
		                            					 			<%} %>
			               										</td>
			               									</tr>
			               									<tr>
			               										<td><%=++docsslno %></td>
			               										<td>D-P&C SoC</td>
			               										<td>
			               											<%if(carsSoC!=null && carsSoC.getDPCIntroduction()!=null) {%>
			               												<button type="submit" class="btn btn-sm" formaction="CARSDPCSoCDownload.htm" formmethod="GET" formnovalidate="formnovalidate" 
			               												formtarget="blank" data-toggle="tooltip" data-placement="top" title="D-P&C SoC Download">
								  	 										<i class="fa fa-download fa-lg" aria-hidden="true"></i>
															  			</button>
			               											<%} else {%>
		                            					 				-
		                            					 			<%} %>
			               										</td>
			               									</tr>
			               									
			               								</tbody>
			               							</table>
			               							<br>
			               						</form>
		               						</div>
		               					</div>
		               				</div>
		               			<%} %>
		               			<div class="navigation_btn text-right">
		            				<a class="btn btn-info btn-sm  shadow-nohover previous" >Previous</a>
									<button class="btn btn-info btn-sm next">Next</button>
								</div>
		               	<%if(dpcTabId!=null && dpcTabId.equalsIgnoreCase("9")){ %> 
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
/* button disabling for SoC Approval */
<%if((dpcsocforwardstatus.contains(carsIni.getCARSStatusCode()))) {%>
$('.btn-soc').prop('disabled',false);
<%} else{%>
$('.btn-soc').prop('disabled',true);
<%} %>

/* tabs hiding for SoC approval */
<%if(isApproval!=null && (isApproval.equalsIgnoreCase("P") || isApproval.equalsIgnoreCase("Q") )) {%>
   $('.navigation_btn').hide();
   $('#nav-socdetails').hide();
   $('#nav-alldocs').hide();
<%} %>
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
	                $('#approverEmpId').selectpicker('refresh');
	                }else{
	                	for (var i = 0; i < result.length; i++) {
	                        var data = result[i];
	                        var optionValue = data[0];
	                        var optionText = data[1].trim() + ", " + data[3]; 
	                        var option = $("<option></option>").attr("value", optionValue).text(optionText);
	                        $('#approverEmpId').append(option); 
	                    }
	                    $('#approverEmpId').selectpicker('refresh');
	                }
	               /* 	for (var i = 0; i < result.length; i++) {
	                       var data = result[i];
	                       var optionValue = data[0];
	                       var optionText = data[1].trim() + ", " + data[3]; 
	                       var option = $("<option></option>").attr("value", optionValue).text(optionText);
	                       $('#approverEmpId').append(option); 
	                   }
	                   $('#approverEmpId').selectpicker('refresh'); */
	               
	           }
	   });
	}

$('#approvalDate').daterangepicker({
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

/* ----------------- CKEDITOR Configuration ------------------------------------ */
/* var editor_config = {
		toolbar : [
				{
					name : 'clipboard',
					items : [ 'PasteFromWord', '-', 'Undo', 'Redo' ]
				},
				{
					name : 'basicstyles',
					items : [ 'Bold', 'Italic', 'Underline', 'Strike',
							'RemoveFormat', 'Subscript', 'Superscript' ]
				},
				{
					name : 'links',
					items : [ 'Link', 'Unlink' ]
				},
				{
					name : 'paragraph',
					items : [ 'NumberedList', 'BulletedList', '-',
							'Outdent', 'Indent', '-', 'Blockquote' ]
				},
				{
					name : 'insert',
					items : [ 'Image', 'Table' ]
				},
				{
					name : 'editing',
					items : [ 'Scayt' ]
				},
				'/',

				{
					name : 'styles',
					items : [ 'Format', 'Font', 'FontSize' ]
				},
				{
					name : 'colors',
					items : [ 'TextColor', 'BGColor', 'CopyFormatting' ]
				},
				{
					name : 'align',
					items : [ 'JustifyLeft', 'JustifyCenter',
							'JustifyRight', 'JustifyBlock' ]
				}, {
					name : 'document',
					items : [ 'Print', 'PageBreak', 'Source' ]
				} ],

		removeButtons : 'Underline,Strike,Subscript,Superscript,Anchor,Styles,Specialchar',

		customConfig : '',

		disallowedContent : 'img{width,height,float}',
		extraAllowedContent : 'img[width,height,align]',

		height : 300,

		contentsCss : [ CKEDITOR.basePath + 'mystyles.css' ],

		bodyClass : 'document-editor',

		format_tags : 'p;h1;h2;h3;pre',

		removeDialogTabs : 'image:advanced;link:advanced',

		stylesSet : [

		{
			name : 'Marker',
			element : 'span',
			attributes : {
				'class' : 'marker'
			}
		}, {
			name : 'Cited Work',
			element : 'cite'
		}, {
			name : 'Inline Quotation',
			element : 'q'
		},

		{
			name : 'Special Container',
			element : 'div',
			styles : {
				padding : '5px 10px',
				background : '#eee',
				border : '1px solid #ccc'
			}
		}, {
			name : 'Compact table',
			element : 'table',
			attributes : {
				cellpadding : '6',
				cellspacing : '0',
				border : '1',
				bordercolor : '#ccc'
			},
			styles : {
				'border-collapse' : 'collapse'
			}
		}, {
			name : 'Borderless Table',
			element : 'table',
			styles : {
				'border-style' : 'hidden',
				'background-color' : '#E6E6FA'
			}
		}, {
			name : 'Square Bulleted List',
			element : 'ul',
			styles : {
				'list-style-type' : 'square'
			}
		}, {
			filebrowserUploadUrl : '/path/to/upload-handler'
		}, ]
	}; */
	
	/* -------------------------- Define a common Summernote configuration -------------------------------------------- */
	var summernoteConfig = {
	    width: 900,
	    toolbar: [
	        ['style', ['bold', 'italic', 'underline', 'clear']],
	        ['font', ['fontsize', 'fontname', 'color', 'superscript', 'subscript']],
	        ['insert', ['picture', 'table']],
	        ['para', ['ul', 'ol', 'paragraph']],
	        ['height', ['height']]
	    ],
	    fontSizes: ['8', '9', '10', '11', '12', '14', '16', '18', '24', '36', '48', '64', '82', '150'],
	    fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', 'Helvetica', 'Impact', 'Tahoma', 'Times New Roman', 'Verdana','Segoe UI','Segoe UI Emoji','Segoe UI Symbol'],
	    buttons: {
	        superscript: function() {
	            return $.summernote.ui.button({
	                contents: '<sup>S</sup>',
	                tooltip: 'Superscript',
	                click: function() {
	                    document.execCommand('superscript');
	                }
	            }).render();
	        },
	        subscript: function() {
	            return $.summernote.ui.button({
	                contents: '<sub>S</sub>',
	                tooltip: 'Subscript',
	                click: function() {
	                    document.execCommand('subscript');
	                }
	            }).render();
	        }
	    },
	    height: 300
	};
	
/* -------------------------- Form Submission with CKEDITOR Data -------------------------------------------- */

$('#inieditform').submit(function() {

	  /* var data =CKEDITOR.instances['dpcIntroductionnote'].getData(); */
	  
	  var data = $('#dpcIntroductionnote').summernote('code');
	  $('textarea[name=dpcIntroduction]').val(data);

});

/* ------------------------ Using CKEDITOR Configuration ------------------------ */
/* CKEDITOR.replace('dpcIntroductionnote', editor_config); */

/* ------------------------ Using Summernote Configuration ------------------------ */
$('#dpcIntroductionnote').summernote(summernoteConfig);


$( document ).ready(function() {
	
	/* ----------------------- Aim & Objectives ------------------------ */ 
	<%if(carsSoC!=null && carsSoC.getDPCIntroduction()!=null) {%>

		 var html=$('#dpcIntroductionhidden').val();
		
		/* CKEDITOR.instances['dpcIntroductionnote'].setData(html); */
		$('#dpcIntroductionnote').summernote('code', html);
	<%} %>
});	
</script>
</body>
</html>
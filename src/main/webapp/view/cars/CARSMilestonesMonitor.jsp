<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.vts.pfms.IndianRupeeFormat"%>
<%@page import="com.vts.pfms.cars.model.CARSSoC"%>
<%@page import="com.vts.pfms.cars.model.CARSSoCMilestones"%>
<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.cars.model.CARSContract"%>
<%@page import="com.vts.pfms.cars.model.CARSInitiation"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/cars/CARSMilestonesMonitor.css" var="carsMilestonesMonitor" />
<link href="${carsMilestonesMonitor}" rel="stylesheet" />
<spring:url value="/resources/css/cars/carscommon.css" var="carscommon7" />
<link href="${carscommon7}" rel="stylesheet" />



</head>
<body>
<%
CARSInitiation carsIni = (CARSInitiation)request.getAttribute("carsInitiationData"); 
CARSSoC carsSoC = (CARSSoC)request.getAttribute("carsSoCData"); 
CARSContract carsContract = (CARSContract)request.getAttribute("carsContractData"); 
List<CARSSoCMilestones> milestones = (List<CARSSoCMilestones>)request.getAttribute("carsSoCMilestones");
List<Object[]> milestoneProgressList = (List<Object[]>)request.getAttribute("milestoneProgressList");


Object[] PDs = (Object[])request.getAttribute("PDEmpIds");

FormatConverter fc = new FormatConverter();

long carsInitiationId = carsIni.getCARSInitiationId();
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
				<div class="row card-header bg-none">
			   		<div class="col-md-6">
						<h4>CARS Milestones Monitor
							<button type="button" id="carsInfo" value="1" class="btn btn-info btn-sm p-0-5 bor-none"><i class="fa fa-info-circle" aria-hidden="true"></i></button>
						</h4>
						
					</div>
				
					<div class="col-md-6 justify-content-end f-right mt-minus-25"  >
						<div class="form-inline js-e"> 
							<a class="btn btn-info btn-sm  shadow-nohover back text-white f-right" href="CARSInitiationList.htm">Back</a>  
						</div>
					</div>
					
				</div>
				<br>
				<div class="row ml-5rem" id="carsInfoHeading">
					<div class="col-md-11">
						<div class="card shadow-nohover cars-det" >
							<div class="card-header card-head-bg">
								<b class="text-white" >CARS Details: </b>
							</div> 
						</div>
					</div>
				</div>
				<div class="row ml-5rem"id="carsInfoContent">
					<div class="col-md-11 ml-20" align="left">
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
				
				<div class="row ml-5rem">
					<div class="col-md-11 ml-20" align="left">
						<div class="table-responsive">
							<table class="table table-bordered table-hover table-striped table-condensed"  id="">
								<thead>
						        	<tr>
						            	<th class="col-55 width-30" >Description</th>
						            	<th class="col-55 width-10" >Months</th>
						            	<th class="col-55 width-10" >EDP</th>
						            	<th class="col-55 width-10" >Amount (&#8377;)</th>
						            	<th class="col-55 width-20" >Action</th>
						            </tr>
					            </thead>
					            <tbody>
					            	
					               	<%if(milestones!=null && milestones.size()>0) { char a='a'; Object[] progressData = null;%>
							    		<tr>
							    			<td class="init">&nbsp;(a) Initial Advance &nbsp;&nbsp;(<%=milestones.get(0).getPaymentPercentage()!=null?StringEscapeUtils.escapeHtml4(milestones.get(0).getPaymentPercentage()): " - " %>%) </td>
							    			<td class="v-top text-center" >T0*</td>
							    			<td class="v-top text-center">
							    				<%if(carsContract.getT0Date()!=null) {%><%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(carsContract.getT0Date())) %><%} %> 
							    			</td>
							    			<td class="v-top text-right">
							    				<%if(milestones.get(0).getActualAmount()!=null) {%>
							    					<%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(StringEscapeUtils.escapeHtml4(milestones.get(0).getActualAmount()))) %>
							    				<%} else{%>
							    					-
							    				<%} %>
							    				&nbsp;&nbsp;
							    			</td>
							    			
							    			<td>
							    				<form action="#" method="POST" name="myfrm" >
							    					<div class="d-flex justify-content-center">
							    						<button  class="editable-click" name="Action" value="Actions" formaction="CARSMilestonesMonitorDetails.htm">
															<div class="cc-rockmenu">
														 		<div class="rolling">	
									                        		<figure class="rolling_icon"><img src="view/images/preview3.png" ></figure>
									                        		<span>Actions</span>
									                      		</div>
									                     	</div>
											        	</button> 
											        	<button  class="editable-click w-50" name="Action" value="MilestoneProgress" formaction="CARSMilestonesProgressDetails.htm">
													        <%
													        progressData = milestoneProgressList!=null && milestoneProgressList.size()>0?milestoneProgressList.stream().filter(e -> e[5].toString().equalsIgnoreCase(milestones.get(0).getMilestoneNo())).findFirst().orElse(null): null;
													        %>
													        <%if(progressData[2]!=null) {%>
																<div class="progress progress-bg" >
																	<div class="progress-bar progress-bar-striped width-<%=progressData[2].toString().trim() %>" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
																		<%=StringEscapeUtils.escapeHtml4(progressData[2].toString()) %>
																	</div> 
																</div>	
															<%}else{ %>
																<div class="progress progress-bg" >
																	<div class="progress-bar progress-bg-2" role="progressbar"  >
																		0
																	</div>
																</div>
															<%} %>
														</button>
							    					</div>
												        
													<input type="hidden" name="carsSoCMilestoneId" value="<%=milestones.get(0).getCARSSoCMilestoneId()%>"/>
													<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId%>"/>
													<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
														
												</form>
							    			</td>
							    		</tr>
							    		<% for(int i=1;i<milestones.size()-1;i++) { 
							    			String milestoneNo = milestones.get(i).getMilestoneNo();
							    		%>
							    		<tr>
							    			<td class="text-left v-top" >&nbsp;(<%=++a %>) Performance Milestone-<%=(i) %> of RSQR &nbsp;&nbsp;(<%=milestones.get(i).getPaymentPercentage() %>%) </td>
							    			<td class="text-center v-top" >T0+<%=milestones.get((i)).getMonths() %> </td>
							    			<td class="text-center v-top">
							    				<%if(carsContract.getT0Date()!=null) {
							    					LocalDate sqldate = LocalDate.parse(carsContract.getT0Date()).plusMonths(Long.parseLong(milestones.get((i)).getMonths()));
							    				%>
							    					<%=fc.SqlToRegularDate(sqldate.toString()) %> 
							    				<%} %>	
							    			</td>
							    			<td class="text-right v-top">
							    				<%if(milestones.get(i).getActualAmount()!=null) {%>
							    					<%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(StringEscapeUtils.escapeHtml4(milestones.get(i).getActualAmount()))) %>
							    				<%} else{%>
							    					-
							    				<%} %>
							    				&nbsp;&nbsp;
							    			</td>
							    			<td>
							    				<form action="#" method="POST" name="myfrm"  class="d-inline">
													<div class="d-flex justify-content-center">	
														<button  class="editable-click" name="Action" value="Actions" formaction="CARSMilestonesMonitorDetails.htm">
															<div class="cc-rockmenu">
														 		<div class="rolling">	
									                        		<figure class="rolling_icon"><img src="view/images/preview3.png" ></figure>
									                        		<span>Actions</span>
									                      		</div>
									                     	</div>
												        </button>   
													
														<button  class="editable-click w-50" name="Action" value="MilestoneProgress" formaction="CARSMilestonesProgressDetails.htm" >
													        <%
													        progressData = milestoneProgressList!=null && milestoneProgressList.size()>0?milestoneProgressList.stream().filter(e -> e[5].toString().equalsIgnoreCase(milestoneNo)).findFirst().orElse(null): null;
													        %>
													        <%if(progressData[2]!=null) {%>
																<div class="progress progress-bg" >
																	<div class="progress-bar progress-bar-striped  width-<%=progressData[2] %>" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
																		<%=StringEscapeUtils.escapeHtml4(progressData[2].toString()) %>
																	</div> 
																</div>	
															<%}else{ %>
																<div class="progress progress-bg" >
																	<div class="progress-bar progress-bg-2" role="progressbar"  >
																		0
																	</div>
																</div>
															<%} %>
														</button>   
											        </div>		
													<input type="hidden" name="carsSoCMilestoneId" value="<%=milestones.get(i).getCARSSoCMilestoneId()%>"/>
													<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId%>"/>
													<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
														
												</form>
							    			</td>
							    		</tr>
							    		<%}%>
							    		<%if(milestones.size()>1) {%>
							    		<tr>
							    			<td class="init">&nbsp;(<%=++a %>) on submission of final report &nbsp;&nbsp;(<%=milestones.get(milestones.size()-1).getPaymentPercentage() %>%) </td>
							    			<td class="text-center v-top">T0+<%=milestones.get(milestones.size()-1).getMonths() %> </td>
							    			<td class="text-center v-top">
							    				<%if(carsContract.getT0Date()!=null) {
							    					LocalDate sqldate = LocalDate.parse(carsContract.getT0Date()).plusMonths(Long.parseLong(milestones.get((milestones.size()-1)).getMonths()));
							    				%>
							    					<%=fc.SqlToRegularDate(sqldate.toString()) %> 
							    				<%} %>	
							    			</td>
							    			<td class="text-right v-top" >
							    				<%if(milestones.get(milestones.size()-1).getActualAmount()!=null) {%>
							    					<%=IndianRupeeFormat.getRupeeFormat(Double.parseDouble(StringEscapeUtils.escapeHtml4(milestones.get(milestones.size()-1).getActualAmount()))) %>
							    				<%} else{%>
							    					-
							    				<%} %>
							    				&nbsp;&nbsp;
							    			</td>
							    			<td class="text-center">
							    				<form action="#" method="POST" name="myfrm"  class="d-inline">
													<div class="d-flex justify-content-center">		
														<button  class="editable-click" name="Action" value="Actions" formaction="CARSMilestonesMonitorDetails.htm">
															<div class="cc-rockmenu">
														 		<div class="rolling">	
									                        		<figure class="rolling_icon"><img src="view/images/preview3.png" ></figure>
									                        		<span>Actions</span>
									                      		</div>
									                     	</div>
												        </button>   
													
														<button  class="editable-click w-50" name="Action" value="MilestoneProgress" formaction="CARSMilestonesProgressDetails.htm">
													        <%
													        progressData = milestoneProgressList!=null && milestoneProgressList.size()>0?milestoneProgressList.stream().filter(e -> e[5].toString().equalsIgnoreCase(milestones.get(milestones.size()-1).getMilestoneNo())).findFirst().orElse(null): null;
													        %>
													        <%if(progressData[2]!=null) {%>
																<div class="progress progress-bg" >
																	<div class="progress-bar progress-bar-striped  width-<%=progressData[2] %>" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
																		<%=StringEscapeUtils.escapeHtml4(progressData[2].toString()) %>
																	</div> 
																</div>	
															<%}else{ %>
																<div class="progress progress-bg" >
																	<div class="progress-bar progress-bg-2" role="progressbar"  >
																		0
																	</div>
																</div>
															<%} %>
														</button>     
											        </div>		
													<input type="hidden" name="carsSoCMilestoneId" value="<%=milestones.get(milestones.size()-1).getCARSSoCMilestoneId()%>"/>
													<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId%>"/>
													<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
														
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
				<div class="row ml-5rem" >
					<div class="col-md-11 ml-20" align="left" >
						<label class="fs-17">*EDP</label> - <span>Expected Date of Payment</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>	
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
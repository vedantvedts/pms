<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Arrays"%>
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
<spring:url value="/resources/css/roadMapModule/roadMapASPList.css" var="roadMapASPList" />
<link href="${roadMapASPList}" rel="stylesheet" />

</head>
<body>
<%

List<Object[]> roadMapASPList = (List<Object[]>)request.getAttribute("roadMapASPList");

Object[] Director = (Object[])request.getAttribute("Director");
Object[] emp = (Object[])request.getAttribute("EmpData");

List<String> roadmapforward = Arrays.asList("RIN","RRD","RRA","RRV");

FormatConverter fc = new FormatConverter();
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
				<div class="row card-header">
			   		<div class="col-md-6">
						<h4>ASP List</h4>
					</div>
				</div>
				<br>
					<div align="center">
	                	<form action="#" id="myform" method="post">
	                    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	                 		<%if(roadMapASPList!=null && roadMapASPList.size()>0) {%>
	                 		<button type="submit" class="btn btn-sm cs-moveback" formaction="RoadMapDetailsMoveBackToRoadMap.htm" data-toggle="tooltip" data-placement="top" title="Move Back to Road Map" onclick="moveBackToRoadMapCheck()">
	                 			<i class="fa fa-arrow-circle-left p-0" aria-hidden="true"></i>
	                 			MOVE BACK TO ROAD MAP 
	                 		</button>
	                 		<%} %>
	                 	</form>
	              	</div>
	            <br>  	
				<%if(roadMapASPList!=null && roadMapASPList.size()>0) {%>
				<!-- search box -->
					<form method="get" class="form-inline my-2 my-lg-0 cs-search">
						<div >
							<input name="search" id="search" required class="form-control mr-sm-2" placeholder="Search" aria-label="Search" type="Search" />
							<input type="submit" class="btn btn-outline-success my-2 my-sm-0" name="clicked" value="Search" />
							<a href="RoadMapASPList.htm"><button type="submit" class="btn btn-outline-danger my-2 my-sm-0" formnovalidate="formnovalidate" >Reset</button></a>
							
						</div>
					</form>
				<!-- search ends -->
					
					<!-- card project visualizations -->
					<div class="cs-project">
						<div class="card-deck position-relative">
							<%
							for(Object[] obj: roadMapASPList){ %>
							
								<div class="card cs-card">
									<div class="card-body">
										<div class="container">
				  							<div class="row">
				  								<div class="col- mt-3">
													<input form="myform" type="checkbox" class="form-control" name="roadMapId" value="<%=obj[0] %>">
				  								</div>
					  							<div class="col-lg">
													<h4 class="card-title" ><%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()): " - "  %></h4>
												</div>
												<div class="col-">
													<p> 
														<%if(obj[2]!=null){
															if(obj[2].toString().equalsIgnoreCase("E")){%>
																Existing Project
															<%}else if(obj[2].toString().equalsIgnoreCase("P")){ %>
																Pre-Project
															<%}else{ %>
																New Project
															<%} %>
														<%}else{ %> - <%} %>
													</p>
												</div>
											</div>
										</div>										
										<div class="container">
					  						<div class="row">
					  							<div class="col-xl text-left">
													Duration : <%if(obj[10]!=null) {%><%=StringEscapeUtils.escapeHtml4(obj[10].toString())%><%} else {%>0<%} %> Months
												</div>
												<div class="col-">
													Ref : <%if(obj[11]!=null) {%><%=StringEscapeUtils.escapeHtml4(obj[11].toString()) %><%} else {%>-<%} %>
												</div>
												
											</div>
										</div>
										<div class="container">
					  						<div class="row">
					  							<div class="col-xl text-left">
													From : <%if(obj[8]!=null) {%><%=fc.SqlToRegularDate(obj[8].toString()) %><%} else {%>-<%} %>
												</div>
												<div class="col-">
													To : <%if(obj[9]!=null) {%><%=fc.SqlToRegularDate(obj[9].toString()) %><%} else {%>-<%} %>
												</div>
												
											</div>
										</div>
										
										<div class="container cs-container">
											<div>Status :</div>
					  						<div class="row cs-row">
												<div class="col-xl">
													 <%if(obj[15]!=null) {%>
														<form action="#">
				                                        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				                                        	<%-- <input type="hidden" name="roadMapId" value="<%=obj[0] %>"> --%>
				                                       	  	<%
															   String colorCode = (String) obj[16];
															   String className = "C" + colorCode.replace("#", "").toUpperCase();
															%>
										    				<button type="submit" class="btn btn-sm btn-link w-100 btn-status fw-600 <%=className%>" formaction=RoadMapTransStatus.htm value="<%=obj[0] %>" name="roadMapId"  data-toggle="tooltip" data-placement="top" title="Transaction History" formtarget="_blank">
										    					<%=obj[15]!=null?StringEscapeUtils.escapeHtml4(obj[15].toString()): " - " %> <i class="fa fa-telegram" aria-hidden="true"></i>
										    				</button>
											    			
	                                        			</form>
	                                        		<%} %>
													<br/>
												</div>
											</div>
										</div> 
										
										<div class="cs-div">
											<div class="container">
						  						<div class="row">
													<div class="col-xl">
														<form action="#" method="post">
		                                        			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		                                        			<input type="hidden" name="aspFlag" value="Y">
		                                        			<button class="editable-clicko" name="roadMapId" value="<%=obj[0] %>" formaction="RoadMapDetailsPreview.htm" data-toggle="tooltip" data-placement="top" title="Preview">
																<div class="cc-rockmenu">
																	<div class="rolling">
																		<figure class="rolling_icon">
																			<i class="fa fa-eye cs-preview" aria-hidden="true"></i>
																		</figure>
																		<span>Preview</span>
																	</div>
																</div>
													    	</button>
		                                        			<%if(obj[14]!=null && obj[14].toString().equalsIgnoreCase("Y")) {%>
			                                        				<button class="editable-clicko" name="roadMapId" value="<%=obj[0] %>" formaction="RoadMapDetails.htm" data-toggle="tooltip" data-placement="top" title="Edit">
																		<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<i class="fa fa-lg fa-edit cs-edit" aria-hidden="true"></i>
																				</figure>
																				<span>Edit</span>
																			</div>
																		</div>
													    			</button>
											    			<%} %>
		                                        		</form>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							
							<% }%>
							</div>
							<br/><br/>						
					</div>
					<!-- card project visualizations FINISH -->
					
					<div class="pagin cs-pagein">
						<nav aria-label="Page navigation example" >
							<div class="pagination" >
								<% int pagin = Integer.parseInt(request.getAttribute("pagination").toString()) ; %>
							
									<div class="page-item">
										<form method="get" action="RoadMapASPList.htm" onsubmit="return verify()">
											<input class="page-link" type="submit" <%if(pagin==0){ %>disabled<%} %> value="Previous" />
											<% if (request.getAttribute("searchFactor")!=null){ %>
												<input type="hidden" value="<%= request.getAttribute("searchFactor").toString() %>" name="search" />
											<%} %>
											<input type="hidden" id="pagination" name="pagination" value=<%=pagin-1 %> />
										</form>
									</div>
									<div class="page-item">
										<input class="page-link" type="button" value="<%=pagin+1 %>" disabled/>
									</div>
									<div class="page-item">
										<form method="get" action="RoadMapASPList.htm" >
											<% int last=pagin+2;if(Integer.parseInt(request.getAttribute("maxpagin").toString())<last)
												last=0; %>
												<input class="page-link" type="submit" value="Next" <%if(last==0){ %><%="disabled"%><%} %> />
												<input type="hidden" name="pagination" value=<%=pagin+1 %> />
										</form>
									</div>
							</div>
						</nav>
					</div>
				<%} else{%>	
					<div class="card mb-4">
						<div class="card-body">
							<div class="row">
								<div class="col-md-12">
									<div align="center">
										<span class="span-warn">No Data Available..!</span>
									</div>
								</div>
							</div>
						</div>
					</div>
				<%} %>
				
				<form action="">
	                <div class="container">
						
						<!-- The Modal -->
						<div class="modal mt-10p" id="myModal">
					 		<div class="modal-dialog">
					 			<div class="modal-dialog modal-dialog-jump modal-lg modal-dialog-centered">
						    		<div class="modal-content">
						     
						        		<!-- Modal Header -->
						        		<div class="modal-header">
						          			<h4 class="modal-title">Choose Period</h4>
						          			<button type="button" class="close" data-dismiss="modal">&times;</button>
						        		</div>
						        		<!-- Modal body -->
						        		<div class="modal-body">
						        			<div class="form-inline">
						        				<div class="form-group w-50">
						               				<label>Start Year : &nbsp;&nbsp;&nbsp;</label> 
						              	 			<input class="form-control date" data-date-format="yyyy-mm-dd" id="datepicker1" name="startYear" value="<%=LocalDate.now().getYear() %>" required="required" onchange="changedatepicker2()">
						      					</div>
						        				<div class="form-group w-50">
						               				<label>End Year : &nbsp;&nbsp;&nbsp;</label> 
						              	 			<input class="form-control date cs-enddate" data-date-format="yyyy-mm-dd" id="datepicker2" name="endYear" required="required" readonly>
						      					</div>
						      				</div>
						      			</div>
						      
						        		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
						        		<!-- Modal footer -->
						        		<div class="modal-footer cs-modal-footer">
						        			<button type="submit" class="btn btn-sm cs-generate" formaction="RoadMapReportDownload.htm" formtarget="_blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="Road Map Report Download">
				            					GENERATE REPORT
				            				</button> 
						       			</div>
						      		</div>
					    		</div>
					  		</div>
					  	</div>
					</div>
				</form>
										
			</div>
		</div>
	</div>
</div>	

<script type="text/javascript">

$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [  5,10,25, 50, 75, 100 ],
	 "pagingType": "simple"
	
	});
	  
	  
});

function verify(){
	const ele = document.getElementById("pagination").value;
	if(ele<0)
	{
		return false;
	}
	return true;
}

</script>
<script type="text/javascript">
function openModal(){
	$('#myModal').modal('show');
}

$(function () {
	$('[data-toggle="tooltip"]').tooltip()
});	

$(document).ready(function() {
  
$("#datepicker1").datepicker({
	
	autoclose: true,
	format: 'yyyy',
	viewMode: "years", 
	minViewMode: "years",
	minDate : new Date()
});

changedatepicker2();
} );

function changedatepicker2(){
	 var startDate = document.getElementById("datepicker1").value;
	 var year1=Number(startDate);
	 
	 document.getElementById("datepicker2").value = year1+4;
}
</script>

<script type="text/javascript">
function moveBackToRoadMapCheck(){
	var roadMapId = $("input[name='roadMapId']").serializeArray();
	 
	if (roadMapId.length === 0) {
		alert("Please Select Atleast One ASP..!");

		event.preventDefault();
		return false;
	}else {
		if(confirm('Are You Sure to Move Back to Road Map?')){
			return true;
		}else{
			event.preventDefault();
			return false;
		}
		
	}
	return true;
}
</script>
</body>
</html>
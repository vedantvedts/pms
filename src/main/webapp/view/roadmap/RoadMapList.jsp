<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.ArrayList"%>
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
<spring:url value="/resources/css/roadMapModule/roadMapList.css" var="roadMapList" />
<link href="${roadMapList}" rel="stylesheet" />
</head>
<body>
<%

List<Object[]> roadMapList = (List<Object[]>)request.getAttribute("roadMapList");
List<Object[]> existingProjectList = (List<Object[]>)request.getAttribute("existingProjectList");
List<Object[]> preProjectList = (List<Object[]>)request.getAttribute("preProjectList");

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
						<h4>Road Map List</h4>
					</div>
				</div>
			
				<div class="mt-3" align="center">
                	<form action="#" id="myform" method="post">
                    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        <button  class="btn btn-sm add border-0" type="submit" name="Action" value="Add" formaction="RoadMapDetails.htm" formnovalidate="formnovalidate">Add</button>
                 		<button type="button" class="btn btn-sm custom-report" data-toggle="tooltip" data-placement="top" title="Road Map Report Download" onclick="openModal()">
                 			GENERATE REPORT
                 		</button>
                 		<%if(roadMapList!=null && roadMapList.size()>0) {%>
                 		<button type="submit" class="btn btn-sm custom-asp" formaction="RoadMapDetailsMoveToASP.htm" data-toggle="tooltip" data-placement="top" title="Move to ASP" onclick="moveToASPCheck()">
                 			MOVE TO ASP 
								<i class="fa fa-arrow-circle-right p-0" aria-hidden="true"></i>
                 		</button>
                 		<%} %>
                 	</form>
              	</div>
	            	
				<%if(roadMapList!=null && roadMapList.size()>0) {%>
				<!-- search box -->
					<form method="get" class="form-inline my-2 my-lg-0 mt-2 cs-map-form">
						<div class="mt-3">
							<input name="search" id="search" required class="form-control mr-sm-2" placeholder="Search" aria-label="Search" type="Search" />
							<input type="submit" class="btn btn-outline-success my-2 my-sm-0" name="clicked" value="Search" />
							<a href="RoadMapList.htm"><button type="submit" class="btn btn-outline-danger my-2 my-sm-0" formnovalidate="formnovalidate" >Reset</button></a>
							
						</div>
					</form>
				<!-- search ends -->
					
					<!-- card project visualizations -->
					<div class="custom-project">
						<div class="card-deck position-relative">
							<%
							for(Object[] obj: roadMapList){ %>
							
								<div class="card cs-maplist-card">
									<div class="card-body">
										<div class="container">
				  							<div class="row">
				  								<div class="col- mt-2">
				  									<%if(obj[17]!=null && (obj[17].toString().equalsIgnoreCase("RAD") )) {%>
														<input form="myform" type="checkbox" class="form-control scale-15" name="roadMapId" value="<%=obj[0] %>">
													<%} %>
				  								</div>
					  							<div class="col-lg">
													<h4 class="card-title" >
														<%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()): " - " %>
													</h4>
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
													Duration : <%if(obj[10]!=null) {%><%=StringEscapeUtils.escapeHtml4(obj[10].toString()) %><%} else {%>0<%} %> Months
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
										
										<div class="container custom-container">
											<div>Status :</div>
					  						<div class="row custom-row">
												<div class="col-xl">
													 <%if(obj[15]!=null) {%>
														<form action="#">
				                                        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
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
										
										<div class="cs-div-mb-pt">
											<div class="container">
						  						<div class="row">
													<div class="col-xl">
														<form action="#" method="post">
		                                        			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		                                        			<button class="editable-clicko" name="roadMapId" value="<%=obj[0] %>" formaction="RoadMapDetailsPreview.htm" data-toggle="tooltip" data-placement="top" title="Preview">
																<div class="cc-rockmenu">
																	<div class="rolling">
																		<figure class="rolling_icon">
																			<i class="fa fa-eye custom-view" aria-hidden="true"></i>
																		</figure>
																		<span>Preview</span>
																	</div>
																</div>
													    	</button>
		                                        			<%if(obj[14]!=null && obj[14].toString().equalsIgnoreCase("N")) {%>
		                                        				<%if(obj[17]!=null && roadmapforward.contains(obj[17].toString())) {%>
			                                        				<button class="editable-clicko" name="roadMapId" value="<%=obj[0] %>" formaction="RoadMapDetails.htm" data-toggle="tooltip" data-placement="top" title="Edit">
																		<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<i class="fa fa-lg fa-edit custom-edit" aria-hidden="true"></i>
																				</figure>
																				<span>Edit</span>
																			</div>
																		</div>
													    			</button>
			                                        				<button class="editable-clicko" name="roadMapId" value="<%=obj[0] %>" formaction="RoadMapDetailsDelete.htm" onclick="return confirm('Are You Sure to Delete?')" data-toggle="tooltip" data-placement="top" title="Delete">
																		<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<i class="fa fa-lg fa-trash custom-trash" aria-hidden="true"></i>
																				</figure>
																				<span>Delete</span>
																			</div>
																		</div>
													    			</button>
		                                        				
												    			<%} %>
												    			<%if(obj[17]!=null && obj[17].toString().equalsIgnoreCase("RFW")) {%>
			                                        				<button class="editable-clicko" name="roadMapId" value="<%=obj[0] %>" formaction="RoadMapDetailsRevoke.htm" onclick="return confirm('Are You Sure to Revoke?')" data-toggle="tooltip" data-placement="top" title="Revoke">
																		<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<i class="fa fa-undo custom-undo" aria-hidden="true"></i>
																				</figure>
																				<span>Revoke</span>
																			</div>
																		</div>
													    			</button>
												    			<%} %>
												    			
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
					
					<div class="pagin custom-pagein">
						<nav aria-label="Page navigation example" >
							<div class="pagination" >
								<% int pagin = Integer.parseInt(request.getAttribute("pagination").toString()) ; %>
							
									<div class="page-item">
										<form method="get" action="RoadMapList.htm" onsubmit="return verify()">
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
										<form method="get" action="RoadMapList.htm" >
											<% int last=pagin+2;if(Integer.parseInt(request.getAttribute("maxpagin").toString())<last)
												last=0; %>
												<input class="page-link" type="submit" value="Next" <%if(last==0){ %><%="disabled"%><%} %> />
												<input type="hidden" name="pagination" value=<%=pagin+1 %> />
										</form>
									</div>
							</div>
						</nav>
					</div>
				<%} %>	
				<div class="row">
		 			<div class="col-md-12 text-center"><b>Approval Flow For Road Map</b></div>
		 	    </div>
    			<div class="row cs-pt-pb">
           			<table align="center"  >
        				<tr>
        					<td class="trup custom-trup">
         						Initiator - <%=emp[1]!=null?StringEscapeUtils.escapeHtml4(emp[1].toString()): " - " %> 
         					</td>
             		
                    		<td rowspan="2">
             					<i class="fa fa-long-arrow-right fs-20" aria-hidden="true"></i>
             				</td>
             						
        					<td class="trup custom-trup1">
        						Director - <%if(Director!=null) {%><%=StringEscapeUtils.escapeHtml4(Director[1].toString()) %> <%} else{%>DIRECTOR<%} %>
        	    			</td>
            			</tr> 	
            	    </table>			             
				</div>
				
				<form action="RoadMapReportExcelPreview.htm" method="post">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
					<div class="modal fade bd-example-modal-xl" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
	  					<div class="modal-dialog modal-lg modal-dialog modal-dialog-jump modal-dialog-centered modal cs-excel-modal" role="document">
	  
	    					<div class="modal-content">
	      						<div class="modal-header">
	      							<div class="mb-4">
	      								<div class="form-group">
		      								<div class="row">
		      									<div class="col-md-12">
		      										<h4 class="modal-title cs-excel-title" id="exampleModalLabel">
		        										Select Projects for Road Map
		        									</h4>
		      									</div>
		      								</div>
		      							</div>
		      							<div class="form-group">
		      								<div class="row">
		      									<div class="col-md-5">
								        			<h5 class="text-left">
								        			&emsp;Select All 
								        			&emsp;<input type="checkbox" id="selectallprojects" class="scale-15">
								        			</h5>
								        		</div>
								        		<div class="col-md-7"></div>
		      								</div>
	      								</div>
	      							</div>
	       							
	       							<div class="row">
	       								<div class="col-md-12"></div>
	       							</div>
	       							<div class="row mt-4">
	       								<div class="col-md-4"></div>
      									<div class="col-md-4">
						        			<h5>
						        				Start Year : <input class="form-control date custom-calender" id="startYear" name="startYear" required="required" readonly>
						        			</h5>
						      			</div>
				        				<div class="col-md-4">
				        					<h5>
				        						End Year : <input class="form-control date custom-calender" id="endYear" name="endYear" required="required" readonly>
				        					</h5>
				      					</div>		
	       							</div>
	       							
							        <button type="button" class="close w-p2 p-0 m-0" data-dismiss="modal" aria-label="Close">
							       		<span aria-hidden="true">&times;</span>
							        </button>
	      						</div>
	      
	      						<div class="modal-body" >
	      							<div class="container-fluid">
							        	<div class="row">
						    				<div class="col-md-12">
										    	<div align="left">
										        	<h5>
										        		Sanctioned Projects&emsp;<input type="checkbox" id="selectexistingprojects" class="scale-15"> 
										        	</h5> 
										        </div>
						       	 				<hr>
						        				<%int   c = 0;
						           					if (existingProjectList != null && existingProjectList.size() > 0) {
						               					for (Object[] obj : existingProjectList) { %>
										                   <% if (c == 4 || c == 0) { c=0;%>
								                       <div class="row">
										                   <% } %>
									                       <div class="col-3">
									                           <div class="text-left">
									                               <input checked class="existingprojectlist custom-check" name="projectId" value="<%=obj[0]%>" type='checkbox'/>
									                               <label for="<%=obj[0]%>">
									                                   <span class="tableprojectname cs-tablprj"> 
									                                       <% if (obj[2] != null) { %><%=StringEscapeUtils.escapeHtml4(obj[2].toString()) %><% } else { %>-<% } %>
									                                       (<% if (obj[1] != null) { %><%=StringEscapeUtils.escapeHtml4(obj[1].toString())%><% } else { %>-<% } %>)
									                                   </span> 	
									                               </label>
									                           </div>
									                       </div>
										                   <% if (c == 3) { %>
										               </div>
										        <% } %>
								                <% c++; } } %>
						                   	<% if (c <4 && c>0 ) { %>
											</div>
											<% } %>
						    			</div>
									</div>

	        	
							        <div class="row mt-4">
							        	<div class="col-md-12">
						        			<div align="left">
						        				<h5>
						        					Initiation Projects&emsp;<input type="checkbox" id="selectpreprojects" class="scale-15">
						        				</h5>
						        			</div>
							        		<hr>
									        <%int  c1=0;
									        	if(preProjectList!=null && preProjectList.size()>0) { 
									        	for(Object[] obj : preProjectList){%>
									        		<%if(c1==4||c1==0) {c1=0; %>
									        			<div class="row">
									        		<%} %>
															<div class="col-3" >
																<div class="text-left">
																	<input checked class="preprojectlist custom-check" name="initiationId" value="<%=obj[0]%>" type='checkbox'/>
																	<label for="<%=obj[0]%>">
																		<span class="tableprojectname cs-tablprj"> 
																		  	<% if (obj[2] != null) { %><%= StringEscapeUtils.escapeHtml4(obj[2].toString()) %><% } else { %>-<% } %>
																	  	</span> 	
																	</label>
																</div>
															</div>
													<%if(c1 == 3 ) { %>
														</div><%}%>
													<%c1++;} }%>
										<% if (c1 <4 && c1>0 ) { %>
											</div>
										<% } %>
							        </div>
	        					</div>
	      					</div>
	      				</div>
						<div class="modal-footer ">
				      		<div class="row w-100">
				      			<div class="col">
						      		<div class="d-flex justify-content-start" >
						      			<p class="text-left"><span class="text-danger">Note</span>: Road Map (New) Projects are by default selected</p>
						      		</div>
				      			</div>
				      			<div class="col d-flex justify-content-end" >
						        	<button type="button" class="btn btn-secondary" data-dismiss="modal">CLOSE</button>
						        	<button type="submit" class="btn btn-primary mx-1" formtarget="blank">PREVIEW</button>
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

/* $(document).ready(function() {
  
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
} */
</script>

<script>
  $(document).ready(function() {
    // Initialize datepickers
    $("#startYear").datepicker({
      autoclose: true,
      format: 'yyyy',
      viewMode: "years",
      minViewMode: "years",
      <%-- startDate: '<%=LocalDate.now().getYear() %>', // Set default start year --%>
      endDate: '+10y' // Allow selection up to 10 years from start year
    }).on('changeDate', function(selected) {
      var minDate = new Date(selected.date.valueOf());
      $('#endYear').datepicker('setStartDate', minDate);
      var startYear = $('#startYear').val();
      $('#endYear').val(startYear);
      $('#startYear').val(selected.date.getFullYear()); // Update start year input value
    });

    $("#endYear").datepicker({
      autoclose: true,
      format: 'yyyy',
      viewMode: "years",
      minViewMode: "years",
      startDate: '<%=LocalDate.now().getYear() %>', // Set default start year
      endDate: '+10y' // Allow selection up to 10 years from start year
    });
    
    $('#startYear').val('<%=LocalDate.now().getYear() %>');
    $('#endYear').val('<%=LocalDate.now().getYear() %>');
  });
</script>

<script type="text/javascript">
function moveToASPCheck(){
	var roadMapId = $("input[name='roadMapId']").serializeArray();
	 
	if (roadMapId.length === 0) {
		alert("Please Select Recommended Road Maps..!");

		event.preventDefault();
		return false;
	}else {
		if(confirm('Are You Sure to Move to ASP?')){
			return true;
		}else{
			event.preventDefault();
			return false;
		}
		
	}
	return true;
}
</script>

<script type="text/javascript">
$(document).ready(function(){
    // Default: All checkboxes are checked
    $('#selectallprojects, #selectexistingprojects, #selectpreprojects').prop('checked', true);

    // Handling click event for Select All checkbox
    $("#selectallprojects").click(function(){
        var isChecked = $(this).prop('checked');
        $('.existingprojectlist, .preprojectlist, #selectexistingprojects, #selectpreprojects').prop('checked', isChecked);
    });
    
    // Handling click event for Main Projects checkbox
    $("#selectexistingprojects").click(function(){
        var isChecked = $(this).prop('checked');
        $('.existingprojectlist').prop('checked', isChecked);
        // Check if both Main Projects and Sub Projects are checked
        if ($('#selectexistingprojects').prop('checked') && $('#selectpreprojects').prop('checked')) {
            $('#selectallprojects').prop('checked', true);
        } else {
            $('#selectallprojects').prop('checked', false);
        }
    });
    
    // Handling click event for Sub Projects checkbox
    $("#selectpreprojects").click(function(){
        var isChecked = $(this).prop('checked');
        $('.preprojectlist').prop('checked', isChecked);
        // Check if both Main Projects and Sub Projects are checked
        if ($('#selectexistingprojects').prop('checked') && $('#selectpreprojects').prop('checked')) {
            $('#selectallprojects').prop('checked', true);
        } else {
            $('#selectallprojects').prop('checked', false);
        }
    });

    // Handling click event for individual Main Project checkboxes
    $(".existingprojectlist").click(function() {
    	if (!$(this).prop('checked')) {
            $('#selectexistingprojects').prop('checked', false);
            $('#selectallprojects').prop('checked', false);
        } 
        else {
           var allMainChecked = true;
           $('.existingprojectlist').each(function() {
               if (!$(this).prop('checked')) {
                   allMainChecked = false;
               }
           });
           if (allMainChecked) {
               $('#selectexistingprojects').prop('checked', true);
               if ($('#selectpreprojects').prop('checked')) {
                   $('#selectallprojects').prop('checked', true);
               }
           }
        }
        var mainProjectsChecked = $('.existingprojectlist:checked').length;
        var mainProjectsTotal = $('.existingprojectlist').length;
        $('#selectexistingprojects').prop('checked', mainProjectsChecked === mainProjectsTotal);
        // Check if all Main Projects are checked
        if ($('#selectexistingprojects').prop('checked') && $('#selectpreprojects').prop('checked')) $('#selectallprojects').prop('checked', true);
		else $('#selectallprojects').prop('checked', false);
    });

    // Handling click event for individual Sub Project checkboxes
    $(".preprojectlist").click(function() {
        if (!$(this).prop('checked')) {
            $('#selectpreprojects').prop('checked', false);
            $('#selectallprojects').prop('checked', false);
        } else {
            var allSubChecked = true;
            $('.preprojectlist').each(function() {
                if (!$(this).prop('checked')) {
                    allSubChecked = false;
                }
            });
            var subProjectsChecked = $('.preprojectlist:checked').length;
	        var subProjectsTotal = $('.preprojectlist').length;
	        $('#selectpreprojects').prop('checked', subProjectsChecked === subProjectsTotal);
            if (allSubChecked && $('#selectexistingprojects').prop('checked')) $('#selectallprojects').prop('checked', true);
            else $('#selectallprojects').prop('checked', false);
        }
        // Check if all Sub Projects are checked
        if ($('#selectexistingprojects').prop('checked') && $('#selectpreprojects').prop('checked')) {
            $('#selectallprojects').prop('checked', true);
        } else {
            $('#selectallprojects').prop('checked', false);
        }
    });
    
    
    
    
    //--------------------This is for Favourite Project Edit---------------------
    
    
    
    $('#selectallproject, #selectmainproject, #selectsubproject').prop('checked', true);
    
    // Handling click event for Main Projects checkbox
    $("#selectmainproject").click(function(){
        var isChecked = $(this).prop('checked');
        $('.mainprojectlis').prop('checked', isChecked);
        // Check if both Main Projects and Sub Projects are checked
        if ($('#selectmainproject').prop('checked') && $('#selectsubproject').prop('checked')) {
            $('#selectallproject').prop('checked', true);
        } else {
            $('#selectallproject').prop('checked', false);
        }
    });
    
    // Handling click event for Sub Projects checkbox
    $("#selectsubproject").click(function(){
        var isChecked = $(this).prop('checked');
        $('.subprojectlis').prop('checked', isChecked);
        // Check if both Main Projects and Sub Projects are checked
        if ($('#selectmainproject').prop('checked') && $('#selectsubproject').prop('checked')) {
            $('#selectallproject').prop('checked', true);
        } else {
            $('#selectallproject').prop('checked', false);
        }
    });

    // Handling click event for individual Main Project checkboxes
    $(".mainprojectlis").click(function() {
        if (!$(this).prop('checked')) $('#selectmainproject').prop('checked', false);
        else {
           var allMainChecked = true;
           $('.mainprojectlis').each(function() {
               if (!$(this).prop('checked')) allMainChecked = false;
           });
           if (allMainChecked) {
               $('#selectmainproject').prop('checked', true);
           }
        }
        var mainProjectsChecked = $('.mainprojectlis:checked').length;
        var mainProjectsTotal = $('.mainprojectlis').length;
        $('#selectmainproject').prop('checked', mainProjectsChecked === mainProjectsTotal);
    });

    // Handling click event for individual Sub Project checkboxes
    $(".preprojectlist").click(function() {
        if (!$(this).prop('checked'))  $('#selectsubproject').prop('checked', false);
        else {
            var allSubChecked = true;
            $('.subprojectlis').each(function() {
                if (!$(this).prop('checked'))  allSubChecked = false;
            });
            if (allSubChecked) {
                $('#selectsubproject').prop('checked', true);
            }
        }
        var subProjectsChecked = $('.subprojectlis:checked').length;
        var subProjectsTotal = $('.subprojectlis').length;
        $('#selectsubproject').prop('checked', subProjectsChecked === subProjectsTotal);
    });

});

function checkSelectSubProject()
{
	var subProjectsChecked = $('.subprojectlis:checked').length;
    var subProjectsTotal = $('.subprojectlis').length;
    $('#selectsubproject').prop('checked', subProjectsChecked === subProjectsTotal);
    if ($('#selectexistingprojects').prop('checked') && $('#selectpreprojects').prop('checked')) {
        $('#selectallprojects').prop('checked', true);
    } else {
        $('#selectallprojects').prop('checked', false);
    }
}
function checkSelectMainProject()
{
	var mainProjectsChecked = $('.mainprojectlis:checked').length;
	var mainProjectsTotal = $('.existingprojectlist').length;
	$('#selectmainproject').prop('checked', mainProjectsChecked === mainProjectsTotal);
	if ($('#selectexistingprojects').prop('checked') && $('#selectpreprojects').prop('checked')) {
        $('#selectallprojects').prop('checked', true);
    } else {
        $('#selectallprojects').prop('checked', false);
    }
}

</script>
</body>
</html>
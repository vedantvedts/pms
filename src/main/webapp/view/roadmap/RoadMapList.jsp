<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Arrays"%>
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
label {
	font-weight: bold;
	font-size: 13px;
}

.table .font {
	font-family: 'Muli', sans-serif !important;
	font-style: normal;
	font-size: 13px;
	font-weight: 400 !important;
}

.card{

box-shadow: rgba(0, 0, 0, 0.25) 0px 4px 14px;
border-radius: 10px;
border: 0px;
}

.table button {
	background-color: Transparent !important;
	background-repeat: no-repeat;
	border: none;
	cursor: pointer;
	overflow: hidden;
	outline: none;
	text-align: left !important;
}

.table td {
	padding: 5px !important;
}

.resubmitted {
	color: green;
}

.fa-long-arrow-right {
	font-size: 2.20rem;
	padding: 0px 5px;
}

.datatable-dashv1-list table tbody tr td {
	padding: 8px 10px !important;
}

.card-deck{
display: grid;
  grid-template-columns: 1fr 1fr 1fr;
}

.pagin{
display: grid;
float:left;
  grid-template-columns: 1fr 1fr 1fr;
}

.table-project-n {
	color: #005086;
}

#table thead tr th {
	padding: 0px 0px !important;
}

#table tbody tr td {
	padding: 2px 3px !important;
}

/* icon styles */
.cc-rockmenu {
	color: fff;
	padding: 0px 5px;
	font-family: 'Lato', sans-serif;
	height: 28px;
}

.col-xl{
height: 28px;
}

.cc-rockmenu .rolling {
	display: inline-block;
	cursor: pointer;
	width: 34px;
	height: 28px;
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
	height: 28px;
	box-sizing: border-box;
	margin: 0 5px 0 0;
}

.sameline{
display: inline-block;
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

.editable-click{
float: left;
z-index: 9;
white-space: nowrap;
height: 28px;
margin: 0 5px 0 0;
box-sizing: border-box;
display: inline-block;
/* border: none;
background: none; */
}

.editable-clicko{
z-index: 9;
white-space: nowrap;
height: 28px;
margin: 0 5px 0 0;
box-sizing: border-box;
display: inline-block;
background: none;border-style: none;
}

.cc-rockmenu .rolling p {
	margin: 0;
}

.width {
	width: 270px !important;
}

.label {
	border-radius: 3px;
	color: white;
	padding: 1px 2px;
}

.label-primary {
	background-color: #D62AD0; /* D62AD0 */
}

.label-warning {
	background-color: #5C33F6;
}

.label-info {
	background-color: #006400;
}

.label-success {
	background-color: #4B0082;
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

.trup{
	padding:6px 10px 6px 10px ;			
	border-radius: 5px;
	font-size: 14px;
	font-weight: 600;
}
.trdown{
	padding:0px 10px 5px 10px ;			
	border-bottom-left-radius : 5px; 
	border-bottom-right-radius: 5px;
	font-size: 14px;
	font-weight: 600;
}

.modal-dialog-jump {
  animation: jumpIn 1.5s ease;
}

@keyframes jumpIn {
  0% {
    transform: scale(0.1);
    opacity: 0;
  }
  70% {
    transform: scale(1);
  }
  100% {
    transform: scale(1);
    opacity: 1;
  }
}
</style>
</head>
<body>
<%

List<Object[]> roadMapList = (List<Object[]>)request.getAttribute("roadMapList");

Object[] Director = (Object[])request.getAttribute("Director");
Object[] emp = (Object[])request.getAttribute("EmpData");

List<String> roadmapforward = Arrays.asList("RIN","RRD","RRA","RRV");

FormatConverter fc = new FormatConverter();
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
				<br>
					<div align="center">
	                	<form action="#" id="myform" method="post">
	                    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	                        <button  class="btn btn-sm add" type="submit" name="Action" value="Add" formaction="RoadMapDetails.htm" formnovalidate="formnovalidate" style="border: none;">Add</button>
	                 		<%if(roadMapList!=null && roadMapList.size()>0) {%>
	                 		<button type="button" class="btn btn-sm" data-toggle="tooltip" data-placement="top" title="Road Map Report Download" style="background-color: purple;border: none;color: white;font-weight: 600;" onclick="openModal()">
	                 			GENERATE REPORT
	                 		</button>
	                 		<%} %>
	                 	</form>
	              	</div>
	            <br>  	
				<%if(roadMapList!=null && roadMapList.size()>0) {%>
				<!-- search box -->
					<form method="get" class="form-inline my-2 my-lg-0" style="display: flex; justify-content: center; padding-bottom:10px;">
						<div >
							<input name="search" id="search" required class="form-control mr-sm-2" placeholder="Search" aria-label="Search" type="Search" />
							<input type="submit" class="btn btn-outline-success my-2 my-sm-0" name="clicked" value="Search" />
							<a href="RoadMapList.htm"><button type="submit" class="btn btn-outline-danger my-2 my-sm-0" formnovalidate="formnovalidate" >Reset</button></a>
							
						</div>
					</form>
				<!-- search ends -->
					
					<!-- card project visualizations -->
					<div style="display: flex; justify-content: center;padding-bottom:10px;position: relative;">
						<div class="card-deck" style="position: relative;">
							<%
							for(Object[] obj: roadMapList){ %>
							
								<div class="card" style="margin:10px; margin-left: 20px;margin-right: 20px;min-width:450px;">
									<div class="card-body">
									
										<div class="container">
				  							<div class="row">
					  							<div class="col-lg">
													<h4 class="card-title" ><%=obj[6] %></h4>
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
					  							<div class="col-xl" style="text-align: left;">
													Duration : <%if(obj[10]!=null) {%><%=obj[10] %><%} else {%>0<%} %> Months
												</div>
												<div class="col-">
													Ref : <%if(obj[11]!=null) {%><%=obj[11] %><%} else {%>-<%} %>
												</div>
												
											</div>
										</div>
										<div class="container">
					  						<div class="row">
					  							<div class="col-xl" style="text-align: left;">
													From : <%if(obj[8]!=null) {%><%=fc.SqlToRegularDate(obj[8].toString()) %><%} else {%>-<%} %>
												</div>
												<div class="col-">
													To : <%if(obj[9]!=null) {%><%=fc.SqlToRegularDate(obj[9].toString()) %><%} else {%>-<%} %>
												</div>
												
											</div>
										</div>
										
										<div class="container" style="display: inline-flex;margin-top: 1%;">
											<div>Status :</div>
					  						<div class="row" style="margin-top: -1%;margin-left: 1%;">
												<div class="col-xl">
													 <%if(obj[15]!=null) {%>
														<form action="#">
				                                        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				                                        	<%-- <input type="hidden" name="roadMapId" value="<%=obj[0] %>"> --%>
				                                       	  	
										    				<button type="submit" class="btn btn-sm btn-link w-100 btn-status" formaction=RoadMapTransStatus.htm value="<%=obj[0] %>" name="roadMapId"  data-toggle="tooltip" data-placement="top" title="Transaction History" style=" color: <%=obj[16] %>; font-weight: 600;" formtarget="_blank">
										    					<%=obj[15] %> <i class="fa fa-telegram" aria-hidden="true" style="margin-top: 0.3rem;"></i>
										    				</button>
											    			
	                                        			</form>
	                                        		<%} %>
													<br/>
												</div>
											</div>
										</div> 
										
										<div style="bottom: 0px;margin-bottom: 15px;padding-top: 10px;">
											<div class="container">
						  						<div class="row" style="">
													<div class="col-xl">
														<form action="#" method="post">
		                                        			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		                                        			<button class="editable-clicko" name="roadMapId" value="<%=obj[0] %>" formaction="RoadMapDetailsPreview.htm" data-toggle="tooltip" data-placement="top" title="Preview">
																<div class="cc-rockmenu">
																	<div class="rolling">
																		<figure class="rolling_icon">
																			<i class="fa fa-eye" style="padding: 0px;color: #67349e;font-size: 25px;" aria-hidden="true"></i>
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
																					<i class="fa fa-lg fa-edit" style="padding: 0px;color: darkorange;font-size: 25px;" aria-hidden="true"></i>
																				</figure>
																				<span>Edit</span>
																			</div>
																		</div>
													    			</button>
			                                        				<button class="editable-clicko" name="roadMapId" value="<%=obj[0] %>" formaction="RoadMapDetailsDelete.htm" onclick="return confirm('Are You Sure to Delete?')" data-toggle="tooltip" data-placement="top" title="Delete">
																		<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<i class="fa fa-lg fa-trash" style="padding: 0px;color: red;font-size: 25px;" aria-hidden="true"></i>
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
																					<i class="fa fa-undo" style="padding: 0px;color: #f00404;font-size: 25px;" aria-hidden="true"></i>
																				</figure>
																				<span>Revoke</span>
																			</div>
																		</div>
													    			</button>
												    			<%} %>
												    			<%if(obj[17]!=null && (obj[17].toString().equalsIgnoreCase("RAD") )) {%>
			                                        				<button class="editable-clicko" name="roadMapId" value="<%=obj[0] %>" formaction="RoadMapDetailsMoveToASP.htm" onclick="return confirm('Are You Sure to Move to ASP?')" data-toggle="tooltip" data-placement="top" title="Move to ASP">
																		<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<i class="fa fa-arrow-circle-right" style="padding: 0px;color: #157ecd;font-size: 25px;" aria-hidden="true"></i>
																				</figure>
																				<span>To ASP</span>
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
					
					<div class="pagin" style="display: flex; justify-content: center;padding-bottom:10px;">
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
		 			<div class="col-md-12" style="text-align: center;"><b>Approval Flow For Road Map</b></div>
		 	    </div>
    			<div class="row"  style="text-align: center; padding-top: 10px; padding-bottom: 15px; " >
           			<table align="center"  >
        				<tr>
        					<td class="trup" style="background: linear-gradient(to top, #3c96f7 10%, transparent 115%);">
         						Initiator - <%=emp[1] %> 
         					</td>
             		
                    		<td rowspan="2">
             					<i class="fa fa-long-arrow-right " aria-hidden="true" style="font-size: 20px;"></i>
             				</td>
             						
        					<td class="trup" style="background: linear-gradient(to top, #eb76c3 10%, transparent 115%);">
        						Director - <%if(Director!=null) {%><%=Director[1] %> <%} else{%>DIRECTOR<%} %>
        	    			</td>
             	    				
                    		<!-- <td rowspan="2">
             					<i class="fa fa-long-arrow-right " aria-hidden="true" style="font-size: 20px;"></i>
             				</td>
             						
             				<td class="trup" style="background: linear-gradient(to top, #9b999a 10%, transparent 115%);">
             					DG (ECS) - DG (ECS)
             	    		</td> -->
            			</tr> 	
            	    </table>			             
				</div>
				
				<form action="">
	                <div class="container">
						
						<!-- The Modal -->
						<div class="modal" id="myModal" style="margin-top: 10%;">
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
						              	 			<input class="form-control date" data-date-format="yyyy-mm-dd" id="datepicker2" name="endYear" required="required" readonly style="background: #fff;">
						      					</div>
						      				</div>
						      			</div>
						      
						        		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
						        		<!-- Modal footer -->
						        		<div class="modal-footer" style="justify-content: center;">
						        			<button type="submit" class="btn btn-sm" formaction="RoadMapReportDownload.htm" formtarget="_blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="Road Map Report Pdf Download" style="background-color: purple;border: none;color: white;font-weight: 600;">
				            					GENERATE PDF
				            				</button> 
						        			<button type="submit" class="btn btn-sm" formaction="RoadMapReportExcelDownload.htm" formtarget="_blank" formmethod="GET" data-toggle="tooltip" data-placement="top" title="Road Map Report Excel Download" style="background-color: purple;border: none;color: white;font-weight: 600;">
				            					GENERATE EXCEL
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
</body>
</html>
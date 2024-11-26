<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
 	<link href="${sweetalertCss}" rel="stylesheet" />

<style type="text/css">
label {
	font-weight: bold;
	font-size: 14px;
}

.table thead tr, tbody tr {
	font-size: 14px;
}

body {
	background-color: #f2edfa;
	overflow-x: hidden !important;
}

h6 {
	text-decoration: none !important;
}

.multiselect-container>li>a>label {
	padding: 4px 20px 3px 20px;
}

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
	width: 120px;
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

.width {
	width: 210px !important;
}

.bootstrap-select {
	width: 400px !important;
}

input[type=checkbox] {
	accent-color: green;
}
</style>

</head>
<body>
	<%
List<Object[]> ProjectList=(List<Object[]>)request.getAttribute("ProjectList");
List<Object[]> mstaskList=(List<Object[]>)request.getAttribute("mstaskList");
String ProjectId=(String)request.getAttribute("ProjectId");

FormatConverter fc = new FormatConverter();
%>
	<div class="row">
		<div class="col-md-7"></div>
		<div class="col-md-2">
			<label class="control-label" style="float: right">Project
				Name :</label>
		</div>
		<div class="col-md-2" style="margin-top: -7px;">
			<form class="form-inline" method="POST"
				action="MSProjectMilestone.htm">
				<select class="form-control selectdee" id="ProjectId"
					required="required" name="ProjectId">
					<option disabled="true" selected value="">Choose...</option>
					<% for (Object[] obj : ProjectList) {
    										String projectshortName=(obj[17]!=null)?" ( "+obj[17].toString()+" ) ":"";
    										%>
					<option value="<%=obj[0]%>"
						<%if(obj[0].toString().equalsIgnoreCase(ProjectId)){ %>
						selected="selected" <%} %>>
						<%=obj[4]+projectshortName%>
					</option>
					<%} %>
				</select> <input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" /> <input id="submit" type="submit"
					name="submit" value="Submit" hidden="hidden">
			</form>
		</div>
	</div>

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover" style="margin-top: -0px;">
					<div class="row card-header" style="background: transparent;">
						<div class="col-md-6">
							<h5>
								<%if(ProjectId!=null){
						Object[] ProjectDetail=(Object[])request.getAttribute("ProjectDetails");
						%>
								<%=ProjectDetail[2] %>
								(
								<%=ProjectDetail[1] %>
								)
								<%} %>
							</h5>
						</div>
						<div class="col-md-6">
							<form action="#" style="margin-top: -0.3rem;">
								<div class="d-flex justify-content-around">
									<button type="submit" class="btn btn-sm btn-outline-info" formaction="MSprojectGanttChart.htm" >Gantt Chart</button>
									<button type="submit" class="btn btn-sm btn-outline-info" formaction="MSprojectCriticalPath.htm" >Critical Paths</button>
									<button type="submit" class="btn btn-sm btn-outline-info" formaction="MSprojectProcurementList.htm" >Procurement List</button>
									<button type="submit" class="btn btn-sm btn-outline-info" formaction="MSprojectProcurementStatus.htm" >Procurement Status</button>
									<button type="submit" class="btn btn-sm btn-outline-info" formaction="MSprojectProcurementGanttChart.htm" >Procurement Gantt Chart</button>
								</div>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								<input type="hidden" name="ProjectId" value="<%=ProjectId%>">
							</form>
						</div>
					</div>
				</div>
				<div class="card-body" style="background: white">
					<div class="table-responsive">
						<table class="table  table-hover table-bordered">
							<thead>

								<tr>
									<th style="text-align: left; max-width: 80px;">Expand</th>
									<th style="text-align: left; max-width: 100px;">Task No.</th>
									<th style="text-align: left; max-width: 270px;">Task Name</th>
									<th style="text-align: left; max-width: 200px;">Assignee</th>
									<th style="text-align: left; max-width: 60px;">Start Date</th>
									<th style="text-align: left; max-width: 60px;">Finish Date</th>
									<th style="text-align: center; max-width: 80px;">Progress</th>


								</tr>
							</thead>
							<tbody>
								<%if(mstaskList!=null && mstaskList.size()>0) {
                       				int count =0;
                       				for(Object[] level1 : mstaskList) {
                       					if(level1[8].toString().equalsIgnoreCase("1")){
                       			%>
                      				<tr>
										<td style="width:2% !important;" class="center"><span class="clickable" data-toggle="collapse" id="row<%=count %>" data-target=".row<%=count %>"><button class="btn btn-sm btn-success" id="btn<%=count %>"  onclick="ChangeButton('<%=count %>')"><i class="fa fa-plus"  id="fa<%=count%>"></i> </button></span></td> 
										<td><%=level1[9]!=null?level1[9]:"-" %></td>
										<td><%=level1[10]!=null?level1[10]:"-" %></td>
										<td><%=level1[4]!=null?level1[4]:"-" %>, <%=level1[5]!=null?level1[5]:"-" %></td>
										<td class="center"><%=level1[11]!=null?fc.sdfTordf(level1[11].toString()):"-" %></td>
										<td class="center"><%=level1[12]!=null?fc.sdfTordf(level1[12].toString()):"-" %></td>
						 				<td>
						 
						 					<%if(Integer.parseInt(level1[15].toString())>0){ %>
												<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
													<div class="progress-bar progress-bar-striped
														<%if(Integer.parseInt(level1[15].toString())<=100 && Integer.parseInt(level1[15].toString())>75){ %>
															bg-success
														<%} else if(Integer.parseInt(level1[15].toString())<=75 && Integer.parseInt(level1[15].toString())>50){ %>
															bg-info
														<%} else if(Integer.parseInt(level1[15].toString())<=50 && Integer.parseInt(level1[15].toString())>25){ %>
															bg-warning 
														<%} else if(Integer.parseInt(level1[15].toString())<=25 && Integer.parseInt(level1[15].toString())>0){ %>
															bg-danger
														<%}  %>
														" role="progressbar" style=" width: <%=level1[15].toString() %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
														<%=level1[15].toString() %>
													</div> 
												</div> 
											<%}else{ %>
												<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
													<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
														Not Started
													</div>
												</div> 
											<%} %>
										</td>
									</tr>
										
									<tr class="collapse row<%=count %>"  id="rowcollapse<%=count%>">
                                       	<td></td>
                                      	<th class="center">Task sub-level No</th>
                                       	<th class="center">Task</th>
					  					<th class="center">Assignee</th>
					  					<th class="center">Start Date</th>
					  					<th class="center">End Date</th>
					  					<th class="center">Progress</th>
                                   	</tr>
                                    	
                                   	<!-- ----------------------------------- Sub-Level-1 -----------------------------------------  -->
                                   	<%
										int countA=0;
										for(Object []level2 : mstaskList){
											if(level2[8].toString().equalsIgnoreCase("2") && level2[7].toString().equalsIgnoreCase(level1[6].toString())){
									%>
										<tr class="collapse row<%=count %>"  id="rowcollapse<%=count%>">
											<td></td>
											<td><%=level2[9]!=null?level2[9]:"-" %></td>
											<td><%=level2[10]!=null?level2[10]:"-" %></td>
											<td><%=level2[4]!=null?level2[4]:"-" %>, <%=level2[5]!=null?level2[5]:"-" %></td>
											<td class="center"><%=level2[11]!=null?fc.sdfTordf(level2[11].toString()):"-" %></td>
											<td class="center"><%=level2[12]!=null?fc.sdfTordf(level2[12].toString()):"-" %></td>
						 					<td>
						 
						 						<%if(Integer.parseInt(level2[15].toString())>0){ %>
													<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
														<div class="progress-bar progress-bar-striped
															<%if(Integer.parseInt(level2[15].toString())<=100 && Integer.parseInt(level2[15].toString())>75){ %>
																bg-success
															<%} else if(Integer.parseInt(level2[15].toString())<=75 && Integer.parseInt(level2[15].toString())>50){ %>
																bg-info
															<%} else if(Integer.parseInt(level2[15].toString())<=50 && Integer.parseInt(level2[15].toString())>25){ %>
																bg-warning 
															<%} else if(Integer.parseInt(level2[15].toString())<=25 && Integer.parseInt(level2[15].toString())>0){ %>
																bg-danger
															<%}  %>
															" role="progressbar" style=" width: <%=level2[15].toString() %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
															<%=level2[15].toString() %>
														</div> 
													</div> 
												<%}else{ %>
													<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
														<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Not Started
														</div>
													</div> 
												<%} %>
											</td>
										</tr>
											
										<!-- ----------------------------------- Sub-Level-2 -----------------------------------------  -->
										<%
											int countB=0;
											for(Object[]level3 : mstaskList){
												if(level3[8].toString().equalsIgnoreCase("3")  && level3[7].toString().equalsIgnoreCase(level2[6].toString())){
										%>
										
											<tr class="collapse row<%=count %>"  id="rowcollapse<%=count%>">
												<td></td>
												<td><%=level3[9]!=null?level3[9]:"-" %></td>
												<td><%=level3[10]!=null?level3[10]:"-" %></td>
												<td><%=level3[4]!=null?level3[4]:"-" %>, <%=level3[5]!=null?level3[5]:"-" %></td>
												<td class="center"><%=level3[11]!=null?fc.sdfTordf(level3[11].toString()):"-" %></td>
												<td class="center"><%=level3[12]!=null?fc.sdfTordf(level3[12].toString()):"-" %></td>
						 						<td>
						 
						 							<%if(Integer.parseInt(level3[15].toString())>0){ %>
														<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar progress-bar-striped
																<%if(Integer.parseInt(level3[15].toString())<=100 && Integer.parseInt(level3[15].toString())>75){ %>
																	bg-success
																<%} else if(Integer.parseInt(level3[15].toString())<=75 && Integer.parseInt(level3[15].toString())>50){ %>
																	bg-info
																<%} else if(Integer.parseInt(level3[15].toString())<=50 && Integer.parseInt(level3[15].toString())>25){ %>
																	bg-warning
																<%} else if(Integer.parseInt(level3[15].toString())<=25 && Integer.parseInt(level3[15].toString())>0){ %>
																	bg-danger 
																<%}  %>
																" role="progressbar" style=" width: <%=level3[15].toString() %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
																<%=level3[15].toString() %>
															</div> 
														</div> 
													<%}else{ %>
														<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
																Not Started
															</div>
														</div> 
													<%} %>
												</td>
											</tr>
												
											<!-- ----------------------------------- Sub-Level-3 -----------------------------------------  -->
											<%
												int countC=0;
												for(Object[]level4 : mstaskList){
													if(level4[8].toString().equalsIgnoreCase("4")  && level4[7].toString().equalsIgnoreCase(level3[6].toString())){
											%>
												<tr class="collapse row<%=count %>"  id="rowcollapse<%=count%>">
													<td></td>
													<td><%=level4[9]!=null?level4[9]:"-" %></td>
													<td><%=level4[10]!=null?level4[10]:"-" %></td>
													<td><%=level4[4]!=null?level4[4]:"-" %>, <%=level4[5]!=null?level4[5]:"-" %></td>
													<td class="center"><%=level4[11]!=null?fc.sdfTordf(level4[11].toString()):"-" %></td>
													<td class="center"><%=level4[12]!=null?fc.sdfTordf(level4[12].toString()):"-" %></td>
						 							<td>
						 
						 								<%if(Integer.parseInt(level4[15].toString())>0){ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
																<div class="progress-bar progress-bar-striped
																	<%if(Integer.parseInt(level4[15].toString())<=100 && Integer.parseInt(level4[15].toString())>75){ %>
																		bg-success
																	<%} else if(Integer.parseInt(level4[15].toString())<=75 && Integer.parseInt(level4[15].toString())>50){ %>
																		bg-info
																	<%} else if(Integer.parseInt(level4[15].toString())<=50 && Integer.parseInt(level4[15].toString())>25){ %>
																		bg-warning
																	<%} else if(Integer.parseInt(level4[15].toString())<=25 && Integer.parseInt(level4[15].toString())>0){ %>
																		bg-danger 
																	<%}  %>
																	" role="progressbar" style=" width: <%=level4[15].toString() %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
																	<%=level4[15].toString() %>
																</div> 
															</div> 
														<%}else{ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
																<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
																	Not Started
																</div>
															</div> 
														<%} %>
													</td>
												</tr>
													
												<!-- ----------------------------------- Sub-Level-4 -----------------------------------------  -->
												<%
													int countD=0;
													for(Object[]level5 : mstaskList){
												 		if(level5[8].toString().equalsIgnoreCase("5")  && level5[7].toString().equalsIgnoreCase(level4[6].toString())){
												%>	
												
													<tr class="collapse row<%=count %>"  id="rowcollapse<%=count%>">
														<td></td>
														<td><%=level5[9]!=null?level5[9]:"-" %></td>
														<td><%=level5[10]!=null?level5[10]:"-" %></td>
														<td><%=level5[4]!=null?level5[4]:"-" %>, <%=level5[5]!=null?level5[5]:"-" %></td>
														<td class="center"><%=level5[11]!=null?fc.sdfTordf(level5[11].toString()):"-" %></td>
														<td class="center"><%=level5[12]!=null?fc.sdfTordf(level5[12].toString()):"-" %></td>
						 								<td>
												 			<%if(Integer.parseInt(level5[15].toString())>0){ %>
																<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
																	<div class="progress-bar progress-bar-striped
																		<%if(Integer.parseInt(level5[15].toString())<=100 && Integer.parseInt(level5[15].toString())>75){ %>
																			bg-success
																		<%} else if(Integer.parseInt(level5[15].toString())<=75 && Integer.parseInt(level5[15].toString())>50){ %>
																			bg-info
																		<%} else if(Integer.parseInt(level5[15].toString())<=50 && Integer.parseInt(level5[15].toString())>25){ %>
																			bg-warning
																		<%} else if(Integer.parseInt(level5[15].toString())<=25 && Integer.parseInt(level5[15].toString())>0){ %>
																			bg-danger 
																		<%}  %>
																		" role="progressbar" style=" width: <%=level5[15].toString() %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
																		<%=level5[15].toString() %>
																	</div> 
																</div> 
															<%}else{ %>
																<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
																	<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
																		Not Started
																	</div>
																</div> 
															<%} %>
														</td>
													</tr>
													
													<!-- ----------------------------------- Sub-Level-5 -----------------------------------------  -->
													<%
														int countE=0;
														for(Object[]level6 : mstaskList){
													 		if(level6[8].toString().equalsIgnoreCase("6")  && level6[7].toString().equalsIgnoreCase(level5[6].toString())){
													%>
												
														<tr class="collapse row<%=count %>"  id="rowcollapse<%=count%>">
															<td></td>
															<td><%=level6[9]!=null?level6[9]:"-" %></td>
															<td><%=level6[10]!=null?level6[10]:"-" %></td>
															<td><%=level6[4]!=null?level6[4]:"-" %>, <%=level6[5]!=null?level6[5]:"-" %></td>
															<td class="center"><%=level6[11]!=null?fc.sdfTordf(level6[11].toString()):"-" %></td>
															<td class="center"><%=level6[12]!=null?fc.sdfTordf(level6[12].toString()):"-" %></td>
							 								<td>
											 					<%if(Integer.parseInt(level6[15].toString())>0){ %>
																	<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
																		<div class="progress-bar progress-bar-striped
																			<%if(Integer.parseInt(level6[15].toString())<=100 && Integer.parseInt(level6[15].toString())>75){ %>
																				bg-success
																			<%} else if(Integer.parseInt(level6[15].toString())<=75 && Integer.parseInt(level6[15].toString())>50){ %>
																				bg-info
																			<%} else if(Integer.parseInt(level6[15].toString())<=50 && Integer.parseInt(level6[15].toString())>25){ %>
																				bg-warning
																			<%} else if(Integer.parseInt(level6[15].toString())<=25 && Integer.parseInt(level6[15].toString())>0){ %>
																				bg-danger 
																			<%}  %>
																			" role="progressbar" style=" width: <%=level6[15].toString() %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
																			<%=level6[15].toString() %>
																		</div> 
																	</div> 
																<%}else{ %>
																	<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
																		<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
																			Not Started
																		</div>
																	</div> 
																<%} %>
															</td>
														</tr>	
													<%countE++;}} %>
												<%countD++;}} %>
											<%countC++;}} %> 
										<%countB++;}} %>
									<% countA++;}}%>
									<%if(countA==0){ %>
										<tr class="collapse row<%=count %>"  id="rowcollapse<%=count%>">
											<td colspan="8" style="text-align: center" class="center">No sub level Found</td>
										</tr>
									<%} %>			 
                    			<%count++;}} }else {%>
                    				<tr><td colspan="8" class="center">No Data Available</td></tr>
                    			<%}%>
							</tbody>
						</table>

					</div>

				</div>
			</div>
		</div>
	</div>	
</body>

<script type="text/javascript">
$(document).ready(function() {
	   $('#ProjectId').on('change', function() {
	     $('#submit').click();

	   });
	});
	
function ChangeButton(id) {
	  
	//console.log($( "#btn"+id ).hasClass( "btn btn-sm btn-success" ).toString());
	if($( "#btn"+id ).hasClass( "btn btn-sm btn-success" ).toString()=='true'){
	$( "#btn"+id ).removeClass( "btn btn-sm btn-success" ).addClass( "btn btn-sm btn-danger" );
	$( "#fa"+id ).removeClass( "fa fa-plus" ).addClass( "fa fa-minus" );
	$( ".row"+id).show();
    }else{
	$( "#btn"+id ).removeClass( "btn btn-sm btn-danger" ).addClass( "btn btn-sm btn-success" );
	$( "#fa"+id ).removeClass( "fa fa-minus" ).addClass( "fa fa-plus" );
	$( ".row"+id).hide();
    }
}

</script>
</html>
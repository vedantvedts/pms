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
.left {
	text-align: left;
}

.center {
	text-align: center;
}

.right {
	text-align: right;
}
</style>
</head>
<body>
	<%
		List<Object[]> msDemandList = (List<Object[]>)request.getAttribute("msDemandList");
		Object[] projectDetails = (Object[])request.getAttribute("projectDetails");
		String projectId = (String)request.getParameter("ProjectId");
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
	
	<div class="container-fluid mb-3">
		<div class="card shadow-nohover">
		
			<div class="card-header" style="background-color: transparent;height: 3rem;">
 				<div class="row">
 					<div class="col-md-7">
 						<h3 class="text-dark" style="font-weight: bold;">Procurement List - <%=projectDetails!=null?(projectDetails[3]+" ("+projectDetails[1]+")"):"" %> </h3>
 					</div>
 					<div class="col-md-3"></div>
 					<div class="col-md-2 right">
	 					<a class="btn btn-sm btn-info" href="MSprojectProcurementStatus.htm?ProjectId=<%=projectId%>">Procurement Status</a>
	 					<a class="btn btn-sm btn-info" href="MSProjectMilestone.htm?ProjectId=<%=projectId%>">Back</a>
 					</div>
 					
 				</div>
       		</div>
       		
			<!-- <div class="row" style="margin: 1rem;">
				<div class="col-12">
         			<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist" style="background-color: #E1E5E8;padding:0px;">
		  				<li class="nav-item" style="width: 50%;"  >
		    				<div class="nav-link active" style="text-align: center;" id="pills-tab-1" data-toggle="pill" data-target="#tab-1" role="tab" aria-controls="tab-1" aria-selected="true">
			   					<span>Demand List</span> 
		    				</div>
		  				</li>
		  				<li class="nav-item"  style="width: 50%;">
		    				<div class="nav-link" style="text-align: center;" id="pills-tab-2" data-toggle="pill" data-target="#tab-2" role="tab" aria-controls="tab-2" aria-selected="false">
		    	 				<span>Procurement Chart</span> 
		    				</div>
		  				</li>
					</ul>
	   			</div>
			</div> -->
	
       		<div class="card-body">
       			<div class="tab-content" id="pills-tabContent">
       			
            		<div class="tab-pane fade show active" id="tab-1" role="tabpanel" aria-labelledby="pills-tab-1">
             			<div class="table-responsive">
              				<table class="table table-hover  table-striped table-condensed table-bordered table-fixed" id="myTable">
								<thead class="center">
									<tr>
					  					<th style="">Expand</th>
										<th style="">Task No.</th>
					  					<th style="">Task</th>
					  					<th style="">Assignee</th>
					  					<th style="">Start Date</th>
					  					<th style="">End Date</th>
					  					<th style="">Demand No</th>
					  					<th style="">Progress</th>
                  					</tr>
								</thead>
                 				<tbody>
                       				<%if(msDemandList!=null && msDemandList.size()>0) {
                       					int count =0;
                       					for(Object[] level1 : msDemandList) {
                       						if(level1[8].toString().equalsIgnoreCase("1")){
                       				%>
                       					<tr>
											<td style="width:2% !important;" class="center"><span class="clickable" data-toggle="collapse" id="row<%=count %>" data-target=".row<%=count %>"><button class="btn btn-sm btn-success" id="btn<%=count %>"  onclick="ChangeButton('<%=count %>')"><i class="fa fa-plus"  id="fa<%=count%>"></i> </button></span></td> 
											<td><%=level1[9]!=null?level1[9]:"-" %></td>
											<td><%=level1[10]!=null?level1[10]:"-" %></td>
											<td><%=level1[4]!=null?level1[4]:"-" %>, <%=level1[5]!=null?level1[5]:"-" %></td>
											<td class="center"><%=level1[11]!=null?fc.sdfTordf(level1[11].toString()):"-" %></td>
											<td class="center"><%=level1[12]!=null?fc.sdfTordf(level1[12].toString()):"-" %></td>
											<td><%=level1[19]!=null?level1[19]:"-" %></td>
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
						  					<th class="center">Demand No</th>
						  					<th class="center">Progress</th>
                                    	</tr>
                                    	
                                    	<!-- ----------------------------------- Sub-Level-1 -----------------------------------------  -->
                                    	<%
											int countA=0;
											for(Object []level2 : msDemandList){
												if(level2[8].toString().equalsIgnoreCase("2") && level2[7].toString().equalsIgnoreCase(level1[6].toString())){
										%>
											<tr class="collapse row<%=count %>"  id="rowcollapse<%=count%>">
												<td></td>
												<td><%=level2[9]!=null?level2[9]:"-" %></td>
												<td><%=level2[10]!=null?level2[10]:"-" %></td>
												<td><%=level2[4]!=null?level2[4]:"-" %>, <%=level2[5]!=null?level2[5]:"-" %></td>
												<td class="center"><%=level2[11]!=null?fc.sdfTordf(level2[11].toString()):"-" %></td>
												<td class="center"><%=level2[12]!=null?fc.sdfTordf(level2[12].toString()):"-" %></td>
												<td><%=level2[19]!=null?level2[19]:"-" %></td>
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
												for(Object[]level3 : msDemandList){
													if(level3[8].toString().equalsIgnoreCase("3")  && level3[7].toString().equalsIgnoreCase(level2[6].toString())){
											%>
											
												<tr class="collapse row<%=count %>"  id="rowcollapse<%=count%>">
													<td></td>
													<td><%=level3[9]!=null?level3[9]:"-" %></td>
													<td><%=level3[10]!=null?level3[10]:"-" %></td>
													<td><%=level3[4]!=null?level3[4]:"-" %>, <%=level3[5]!=null?level3[5]:"-" %></td>
													<td class="center"><%=level3[11]!=null?fc.sdfTordf(level3[11].toString()):"-" %></td>
													<td class="center"><%=level3[12]!=null?fc.sdfTordf(level3[12].toString()):"-" %></td>
													<td><%=level3[19]!=null?level3[19]:"-" %></td>
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
													for(Object[]level4 : msDemandList){
														if(level4[8].toString().equalsIgnoreCase("4")  && level4[7].toString().equalsIgnoreCase(level3[6].toString())){
												%>
													<tr class="collapse row<%=count %>"  id="rowcollapse<%=count%>">
														<td></td>
														<td><%=level4[9]!=null?level4[9]:"-" %></td>
														<td><%=level4[10]!=null?level4[10]:"-" %></td>
														<td><%=level4[4]!=null?level4[4]:"-" %>, <%=level4[5]!=null?level4[5]:"-" %></td>
														<td class="center"><%=level4[11]!=null?fc.sdfTordf(level4[11].toString()):"-" %></td>
														<td class="center"><%=level4[12]!=null?fc.sdfTordf(level4[12].toString()):"-" %></td>
														<td><%=level4[19]!=null?level4[19]:"-" %></td>
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
														for(Object[]level5 : msDemandList){
													 		if(level5[8].toString().equalsIgnoreCase("5")  && level5[7].toString().equalsIgnoreCase(level4[6].toString())){
													%>	
													
														<tr class="collapse row<%=count %>"  id="rowcollapse<%=count%>">
															<td></td>
															<td><%=level5[9]!=null?level5[9]:"-" %></td>
															<td><%=level5[10]!=null?level5[10]:"-" %></td>
															<td><%=level5[4]!=null?level5[4]:"-" %>, <%=level5[5]!=null?level5[5]:"-" %></td>
															<td class="center"><%=level5[11]!=null?fc.sdfTordf(level5[11].toString()):"-" %></td>
															<td class="center"><%=level5[12]!=null?fc.sdfTordf(level5[12].toString()):"-" %></td>
															<td><%=level5[19]!=null?level5[19]:"-" %></td>
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
															for(Object[]level6 : msDemandList){
														 		if(level6[8].toString().equalsIgnoreCase("6")  && level6[7].toString().equalsIgnoreCase(level5[6].toString())){
														%>
													
															<tr class="collapse row<%=count %>"  id="rowcollapse<%=count%>">
																<td></td>
																<td><%=level6[9]!=null?level6[9]:"-" %></td>
																<td><%=level6[10]!=null?level6[10]:"-" %></td>
																<td><%=level6[4]!=null?level6[4]:"-" %>, <%=level6[5]!=null?level6[5]:"-" %></td>
																<td class="center"><%=level6[11]!=null?fc.sdfTordf(level6[11].toString()):"-" %></td>
																<td class="center"><%=level6[12]!=null?fc.sdfTordf(level6[12].toString()):"-" %></td>
																<td><%=level6[19]!=null?level6[19]:"-" %></td>
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
			  		
			  		<!-- <div class="tab-pane fade" id="tab-2" role="tabpanel" aria-labelledby="pills-tab-2">
			  			<div class="table-responsive">
              				
						</div>	
			  		</div> -->
			  
				</div>
       		</div>
		</div>
	</div>
<script type="text/javascript">
$("#myTable1").DataTable({
    "lengthMenu": [ 50, 75, 100],
    "pagingType": "simple"

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
	<%-- <%if(tab!=null && tab.equals("closed")){%>
	
		$('#pills-tab-2').click();
	
	<%}%>
	<% String val = request.getParameter("val");
	if(val!=null && val.equalsIgnoreCase("app")){%>
		$('#pills-tab-2').click();
	<%}%> --%>
</script>			
</body>
</html>
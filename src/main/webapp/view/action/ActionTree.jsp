<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List , java.util.stream.Collectors"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Action Tree</title>
<jsp:include page="../static/dependancy.jsp"></jsp:include>
<spring:url value="/resources/css/action/actionTree.css" var="actionTree" />
<link href="${actionTree}" rel="stylesheet" />
<spring:url value="/resources/css/action/actionCommon.css" var="actionCommon" />
<link href="${actionCommon}" rel="stylesheet" />
 







</head>

<%
	List<Object[]> actionslist = (List<Object[]>)request.getAttribute("actionslist");
	SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
	SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
	  
	int startLevel = 0;
	
	if(actionslist.size()>0){
		startLevel = Integer.parseInt(actionslist.get(0)[3].toString());
	} 

%>

<body class="body genealogy-body genealogy-scroll gbody">

	<div>
		<h3>Action Tree</h3>
	</div>
	<div align="right">
		<div class="">
			<div class="font-weight-bold ">
				<span class="span1">0 - 25 % :&ensp; 	<span class="Q1 span1-in" ></span></span>
				<span class="span2">26 - 50 % :&ensp; 	<span class="Q2 span1-in" ></span></span>
				<span class="span2">51 - 75 % :&ensp; 	<span class="Q3 span1-in" ></span></span>
				<span class="span2">76 - 100 % :&ensp; <span class="Q4 span1-in"></span></span>
				<span class="span2">Closed:&ensp; <span class="Q5 span1-in" ></span></span>
			</div>
		</div>
	</div>
	<div>
	    <div class="genealogy-tree" >
	        
	  		<ul>
				<li>      
						<%for(Object[] action : actionslist){ %>
							<% if(Integer.parseInt(action[3].toString()) == startLevel){ %>
								
			                    <div class="member-view-box action-view-box">
			                        <div class=" action-box" >
			                          	<div 			                          		
			                          		<% int progress = action[25]!=null ? Integer.parseInt(action[25].toString()) : 0 ; %>
			                          		
			                          		<% if( action[9]!=null && "C".equalsIgnoreCase(action[20]+"") ){ %>
			                          			class="action-box-header Q5"
			                          		<%}else if( progress >= 0 && progress <= 25  ){ %>
			                          			class="action-box-header Q1"
			                          		<%}else if( progress >= 26 && progress <= 50  ){ %>
			                          			class=" action-box-header Q2"
			                          		<%}else if( progress >= 51 && progress <= 75  ){ %>
			                          			class=" action-box-header Q3"
			                          		<%}else if(  progress >= 76 && progress <= 100 ){ %>
			                          			class="action-box-header Q4"
			                          		<%} %>
			                          		
			                          	  >
			                          		
			                          		<span class="cursor-pointer" 
			                          			onclick="ActionDetails(	'<%=action[10] %>' );" >
			                          				&nbsp;&nbsp;&nbsp;&nbsp; <%=action[11]!=null?StringEscapeUtils.escapeHtml4(action[11].toString()):" - "%> &nbsp;&nbsp;&nbsp;&nbsp; <i class="fa fa-plus-circle fa-lg" id="<%=action[11]%>" aria-hidden="true"></i></span>
			                          	</div>
			                          	<%List<Object[]> level0 =actionslist.stream().filter(e->  Long.parseLong(action[19].toString()) == Long.parseLong(e[17].toString())).collect(Collectors.toList());
			                          	System.out.println("level0  "+ level0.size());
			                          	%>
										<div <%if(level0!=null && level0.size()>0){%>class="action-box-body cursor-pointer-copy" <%}else{%> class="action-box-body1 cursor-pointer-copy"<%}%>  align="center" >
											<table class="card-body-table">
			                          			<tr>
			                          				<th class="width-40">Assignee :</th>
			                          				<td  >&emsp;<%=action[23]!=null?StringEscapeUtils.escapeHtml4(action[23].toString()):" - " %></td>
			                          			</tr>
			                          			<tr>
			                          				<th >PDC :</th>
			                          				<td >&emsp;<%=action[24]!=null?sdf.format(action[24]):" - " %></td>
			                          			</tr>
			                          			<tr>
			                          				<th >Progress (%) :</th>
			                          				<td class="padding-left10px">
			                          					
			                          					<%if(action[25]!=null && Integer.parseInt(action[25].toString())>0){ %>
					                          				<div class="progress div-progress" >
																<div class="progress-bar progress-bar-striped width-<%=action[25]%>" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
																	<%=StringEscapeUtils.escapeHtml4(action[25].toString())%>
																</div> 
															</div> 
														<%}else{ %>
															<div class="progress div-progress" >
																<div class="progress-bar progressbar" role="progressbar" >
																	Not Yet Started
																</div>
															</div> 
														<%} %>
			                          					
			                          				</td>
			                          			</tr>
			                          		</table>  
			                          		<%if(level0!=null && level0.size()>0){ %>
											<div class="marging-btnN" ><i class="fa fa-caret-down icon-styl" aria-hidden="true" ></i></div>
											<%}else{%><div class="margin-top12px" ></div><%}%>
			                          	</div>
			                        </div>
			                    </div>
			               
			        <!-- --------------------------------------------------------   LEVEL 1 ---------------------------------------------------- -->
			                <ul class="active">	                
			                <%for(Object[] action_L1 : actionslist){ %>
								<% if(Integer.parseInt(action_L1[3].toString()) == startLevel+1 && Long.parseLong(action[0].toString()) == Long.parseLong(action_L1[1].toString())  
								&&  action[18].toString().trim().equalsIgnoreCase(action_L1[16].toString().trim()) 
								&& Long.parseLong(action[19].toString()) == Long.parseLong(action_L1[17].toString()) ){ %>
									<li>			    
									           
											<div class="member-view-box action-view-box">
												<div class=" action-box" >
													<div 			                          		
						                          		<% int progress_L1 = action_L1[25]!=null ? Integer.parseInt(action_L1[25].toString()) : 0 ; %>
						                          		<% if( action[9]!=null && "C".equalsIgnoreCase(action_L1[20]+"")){ %>
						                          			class="action-box-header Q5"
						                          		<%}else if( progress_L1 >= 0 && progress_L1 <= 25  ){ %>
									                        class="action-box-header Q1"
						                          		<%}else if( progress_L1 >= 26 && progress_L1 <= 50  ){ %>
						                          			class=" action-box-header Q2"
						                          		<%}else if( progress_L1 >= 51 && progress_L1 <= 75  ){ %>
						                          			class=" action-box-header Q3"
						                          		<%}else if(  progress_L1 >= 76 && progress_L1 <= 100 ){ %>
						                          			class="action-box-header Q4"
						                          		<%} %>
						                          	  >
													    <span class="cursor-pointer" 
							                          			onclick="ActionDetails('<%=action_L1[10] %>' );" >                      		
														
														 &nbsp;&nbsp;&nbsp;&nbsp;<%=action_L1[11]!=null?StringEscapeUtils.escapeHtml4(action_L1[11].toString()):" - " %>  &nbsp;&nbsp;&nbsp;&nbsp; <i class="fa fa-plus-circle fa-lg" id="<%=action_L1[11]%>" aria-hidden="true"></i></span >    
														       
													</div>
													<%List<Object[]> level1 =actionslist.stream().filter(e->  Long.parseLong(action_L1[19].toString()) == Long.parseLong(e[17].toString())).collect(Collectors.toList());%>
													<div <%if(level1!=null && level1.size()>0){%>class="action-box-body cursor-pointer-copy" <%}else{%> class="action-box-body1 cursor-pointer-copy"<%}%>  align="center">
														<table class="card-body-table">
															<tr>
						                          				<th class="width-40">Assignee :</th>
						                          				<td  >&emsp;<%=action_L1[23]!=null?StringEscapeUtils.escapeHtml4(action_L1[23].toString()):" - " %></td>
						                          			</tr>
						                          			<tr>
						                          				<th >PDC :</th>
						                          				<td >&emsp;<%=action_L1[24]!=null?sdf.format(action_L1[24]):" - " %></td>
						                          			</tr>
						                          			<tr>
						                          				<th >Progress (%) :</th>
						                          				<td class="padding-left10px">
						                          					
						                          					<%if(action_L1[25]!=null && Integer.parseInt(action_L1[25].toString())>0){ %>
								                          				<div class="progress div-progress ">
																			<div class="progress-bar progress-bar-striped width-<%=action_L1[25]%>" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
																				<%=StringEscapeUtils.escapeHtml4(action_L1[25].toString())%>
																			</div> 
																		</div> 
																	<%}else{ %>
																		<div class="progress div-progress">
																			<div class="progress-bar progressbar" role="progressbar" >
																				Not Yet Started
																			</div>
																		</div> 
																	<%} %>
						                          					
						                          				</td>
						                          			</tr>
														</table>
														<%if(level1!=null && level1.size()>0){ %>
														 <div class="marging-btnN"><i class="fa fa-caret-up icon-styl" aria-hidden="true" ></i></div>
														<%}else{%><div class="margin-top12px" ></div><%}%>
													</div>
												</div>
											</div>
	
									    
								<!-- --------------------------------------------------------   LEVEL 2 ---------------------------------------------------- -->
						                <ul class="">	
						                
							                <%for(Object[] action_L2 : actionslist){ %>
							                
												<% if(Integer.parseInt(action_L2[3].toString()) == startLevel+2 && Long.parseLong(action_L1[0].toString())== Long.parseLong(action_L2[1].toString())  
												&& action_L1[18].toString().trim().equalsIgnoreCase(action_L2[16].toString().trim()) 
												&& Long.parseLong(action_L1[19].toString()) == Long.parseLong(action_L2[17].toString()) ){ %>
												<li>			    
												           
													<div class="member-view-box action-view-box">
															<div class=" action-box" >
																<div 			                          		
									                          		<% int progress_L2 = action_L2[25]!=null ? Integer.parseInt(action_L2[25].toString()) : 0 ; %>
									                          		<% if( action[9]!=null && "C".equalsIgnoreCase(action_L2[20]+"")){ %>
								                          				class="action-box-header Q5"
								                          			<%}else if( progress_L2 >= 0 && progress_L2 <= 25  ){ %>
									                          			class="action-box-header Q1"
									                          		<%}else if( progress_L2 >= 26 && progress_L2 <= 50  ){ %>
									                          			class=" action-box-header Q2"
									                          		<%}else if( progress_L2 >= 51 && progress_L2 <= 75  ){ %>
									                          			class=" action-box-header Q3"
									                          		<%}else if(  progress_L2 >= 76 && progress_L2 <= 100  ){ %>
									                          			class="action-box-header Q4"
									                          		<%} %>
									                          		
									                          	  >
																	
																	<span class="cursor-pointer" 
									                          			onclick="ActionDetails('<%=action_L2[10] %>');" > 
																	 &nbsp;&nbsp;&nbsp;&nbsp;<%=action_L2[11]!=null?StringEscapeUtils.escapeHtml4(action_L2[11].toString()):" - " %>  &nbsp;&nbsp;&nbsp;&nbsp; <i class="fa fa-plus-circle fa-lg" id="<%=action_L2[11]%>" aria-hidden="true"></i></span >           
																</div>
																<%List<Object[]> level2 =actionslist.stream().filter(e->  Long.parseLong(action_L2[19].toString()) == Long.parseLong(e[17].toString())).collect(Collectors.toList());%>
																	<div <%if(level2!=null && level2.size()>0){%>class="action-box-body cursor-pointer-copy" <%}else{%> class="action-box-body1 cursor-pointer-copy"<%}%> align="center" >
																	<table class="card-body-table">
																		<tr>
									                          				<th class="width-40">Assignee :</th>
									                          				<td  >&emsp;<%=action_L2[23]!=null?StringEscapeUtils.escapeHtml4(action_L2[23].toString()):" - " %></td>
									                          			</tr>
									                          			<tr>
									                          				<th>PDC :</th>
									                          				<td >&emsp;<%=action_L2[24]!=null?sdf.format(action_L2[24]):"" %></td>
									                          			</tr>
									                          			<tr>
									                          				<th >Progress (%) :</th>
									                          				<td class="padding-left10px">
									                          					
									                          					<%if(action_L2[25]!=null && Integer.parseInt(action_L2[25].toString())>0){ %>
											                          				<div class="progress div-progress" >
																						<div class="progress-bar progress-bar-striped width-<%=action_L2[25]%>" role="progressbar"  aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
																							<%=StringEscapeUtils.escapeHtml4(action_L2[25].toString())%>
																						</div> 
																					</div> 
																				<%}else{ %>
																					<div class="progress div-progress" >
																						<div class="progress-bar progressbar" role="progressbar" >
																							Not Yet Started
																						</div>
																					</div> 
																				<%} %>
									                          					
									                          				</td>
									                          			</tr>
																	</table>
																 <%if(level2!=null && level2.size()>0){ %>
																 <div class="marging-btnN"><i class="fa fa-caret-up icon-styl" aria-hidden="true" ></i></div>
																 <%}else{%><div class="margin-top12px" ></div><%}%>
																</div>
															</div>
														</div>
												    
												    <!-- --------------------------------------------------------   LEVEL 3 ---------------------------------------------------- -->
										                <ul class="">	                
										                <%for(Object[] action_L3 : actionslist){ %>
															<% if(Integer.parseInt(action_L3[3].toString()) == startLevel+3 && Long.parseLong(action_L2[0].toString())== Long.parseLong(action_L3[1].toString()) 
															&&  action_L2[18].toString().trim().equalsIgnoreCase(action_L3[16].toString().trim()) 
															&& Long.parseLong(action_L2[19].toString()) == Long.parseLong(action_L3[17].toString()) ){ %>
																<li>			    
																           
																	<div class="member-view-box action-view-box">
																		<div class=" action-box" >
																				<div 			                          		
													                          		<% int progress_L3 = action_L3[25]!=null ? Integer.parseInt(action_L3[25].toString()) : 0 ; %>
													                          		<% if( action[9]!=null && "C".equalsIgnoreCase(action_L3[20]+"")){ %>
								                          								class="action-box-header Q5"
								                          							<%}else  if( progress_L3 >= 0 && progress_L3 <= 25  ){ %>
													                          			class="action-box-header Q1"
													                          		<%}else if( progress_L3 >= 26 && progress_L3 <= 50  ){ %>
													                          			class=" action-box-header Q2"
													                          		<%}else if( progress_L3 >= 51 && progress_L3 <= 75  ){ %>
													                          			class=" action-box-header Q3"
													                          		<%}else if(  progress_L3 >= 76 && progress_L3 <= 100  ){ %>
													                          			class="action-box-header Q4"
													                          		<%} %>
													                          		
													                          	  >
																				                          		
																					<span class="cursor-pointer" 
													                          			onclick="ActionDetails('<%=action_L3[10] %>');" >      
																									&nbsp;&nbsp;&nbsp;&nbsp;<%=action_L3[11]!=null?StringEscapeUtils.escapeHtml4(action_L3[11].toString()):" - " %>  &nbsp;&nbsp;&nbsp;&nbsp; <i class="fa fa-plus-circle fa-lg" id="<%=action_L3[11]%>" aria-hidden="true"></i></span >     
																				</div>
																					<%List<Object[]> level3 =actionslist.stream().filter(e->  Long.parseLong(action_L3[19].toString()) == Long.parseLong(e[17].toString())).collect(Collectors.toList());%>
																				<div <%if(level3!=null && level3.size()>0){%>class="action-box-body cursor-pointer-copy" <%}else{%> class="action-box-body1 cursor-pointer-copy"<%}%> align="center" >
																					<table class="card-body-table">
																						<tr>
													                          				<th class="width-40">Assignee :</th>
													                          				<td  >&emsp;<%=action_L3[23]!=null?StringEscapeUtils.escapeHtml4(action_L3[23].toString()):" - " %></td>
													                          			</tr>
													                          			<tr>
													                          				<th >PDC :</th>
													                          				<td >&emsp;<%=action_L3[24]!=null?sdf.format(action_L3[24]):"" %></td>
													                          			</tr>
													                          			<tr>
													                          				<th >Progress (%) :</th>
													                          				<td class="padding-left10px">
													                          					
													                          					<%if(action_L3[25]!=null && Integer.parseInt(action_L3[25].toString())>0){ %>
															                          				<div class="progress div-progress" >
																										<div class="progress-bar progress-bar-striped width-<%=action_L3[25]%>" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
																											<%=StringEscapeUtils.escapeHtml4(action_L3[25].toString()) %>
																										</div> 
																									</div> 
																								<%}else{ %>
																									<div class="progress div-progress" >
																										<div class="progress-bar progressbar" role="progressbar" >
																											Not Yet Started
																										</div>
																									</div> 
																								<%} %>
													                          					
													                          				</td>
													                          			</tr>
																					</table>
																				<%if(level3!=null && level3.size()>0){ %>
																				 <div class="marging-btnN"><i class="fa fa-caret-up icon-styl" aria-hidden="true"></i></div>
																				 <%}else{%><div class="margin-top12px" ></div><%}%>
																				</div>
																			</div>
																		</div>
																    														    
																    
																    <!-- --------------------------------------------------------   LEVEL 4 ---------------------------------------------------- -->
															                <ul class="">	                
															                <%for(Object[] action_L4 : actionslist){ %>
																				<% if(Integer.parseInt(action_L4[3].toString()) == startLevel+4 && Long.parseLong(action_L3[0].toString())== Long.parseLong(action_L4[1].toString())  
																				&& action_L3[18].toString().trim().equalsIgnoreCase(action_L4[16].toString().trim()) 
																				&& Long.parseLong(action_L3[19].toString()) == Long.parseLong(action_L4[17].toString()) ){ %>
																					<li>			    
																					           
																						<div class="member-view-box action-view-box">
																								<div class=" action-box" >
																									<div 			                          		
																		                          		<% int progress_L4 = action_L4[25]!=null ? Integer.parseInt(action_L4[25].toString()) : 0 ; %>
																		                          		<% if( action[9]!=null && "C".equalsIgnoreCase(action_L4[20]+"")){ %>
								                          													class="action-box-header Q5"
								                          												<%}else if( progress_L4 >= 0 && progress_L4 <= 25  ){ %>
																		                          			class="action-box-header Q1"
																		                          		<%}else if( progress_L4 >= 26 && progress_L4 <= 50  ){ %>
																		                          			class=" action-box-header Q2"
																		                          		<%}else if( progress_L4 >= 51 && progress_L4 <= 75  ){ %>
																		                          			class=" action-box-header Q3"
																		                          		<%}else if(  progress_L4 >= 76 && progress_L4 <= 100  ){ %>
																		                          			class="action-box-header Q4"
																		                          		<%} %>
													                          						>
																									                          		
																										<span class="cursor-pointer" 
																		                          			onclick="ActionDetails('<%=action_L4[10] %>');" >
																										&nbsp;&nbsp;&nbsp;&nbsp;<%=action_L4[11] %>  &nbsp;&nbsp;&nbsp;&nbsp; <i class="fa fa-plus-circle fa-lg" id="<%=action_L4[11]%>" aria-hidden="true"></i></span > 
																									</div>
																								<%List<Object[]> level4 =actionslist.stream().filter(e->  Long.parseLong(action_L4[19].toString()) == Long.parseLong(e[17].toString())).collect(Collectors.toList());%>
																									<div <%if(level4!=null && level4.size()>0){%>class="action-box-body cursor-pointer-copy" <%}else{%> class="action-box-body1 cursor-pointer-copy"<%}%> align="center" >																			
																										<table class="card-body-table">
																											<tr>
																		                          				<th class="width-40">Assignee :</th>
																		                          				<td  >&emsp;<%=action_L4[23]!=null?StringEscapeUtils.escapeHtml4(action_L4[23].toString()):" - " %></td>
																		                          			</tr>
																		                          			<tr>
																		                          				<th >PDC :</th>
																		                          				<td >&emsp;<%=action_L4[24]!=null?sdf.format(action_L4[24]):" - " %></td>
																		                          			</tr>
																		                          			<tr>
																		                          				<th >Progress (%) :</th>
																		                          				<td class="padding-left10px">
																		                          					
																		                          					<%if(action_L4[25]!=null && Integer.parseInt(action_L4[25].toString())>0) { %>
																				                          				<div class="progress div-progress" >
																															<div class="progress-bar progress-bar-striped width-<%=action_L4[25]%>" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
																																<%=StringEscapeUtils.escapeHtml4(action_L4[25].toString())%>
																															</div> 
																														</div> 
																													<%}else{ %>
																														<div class="progress div-progress" >
																															<div class="progress-bar progressbar" role="progressbar">
																																Not Yet Started
																															</div>
																														</div> 
																													<%} %>
																		                          					
																		                          				</td>
																		                          			</tr>
																										</table>
																									<%if(level4!=null && level4.size()>0){ %>
																									 <div class="marging-btnN"><i class="fa fa-caret-up icon-styl" aria-hidden="true"></i></div>
																									 <%}else{%><div class="margin-top12px" ></div><%}%>
																									</div>
																								</div>
																							</div>
															                		</li>
																				<% } %>
																			<%} %>
															                </ul>
															                
															        <!-- --------------------------------------------------------   LEVEL 4 ---------------------------------------------------- --> 
																    
																    
																    
										                		</li>
															<% } %>
														<%} %>
										                </ul>
										                
										        <!-- --------------------------------------------------------   LEVEL 3 ---------------------------------------------------- -->  
												    
												    
						                		</li>
											<% } %>
										<%} %>
						                </ul>
						                
						        <!-- --------------------------------------------------------   LEVEL 2 ---------------------------------------------------- -->    
									    
									    
									    
									    
			                		</li>
								<% } %>
							<% } %>
			                </ul>
			                
			        <!-- --------------------------------------------------------   LEVEL 1 ---------------------------------------------------- -->        
			           			 
							<% 
							
							} %>
						<% } %>
	        		</li>
		        </ul>
	
	    </div>
	</div>

    

<!-- -------------------------------------------------------------- action modal ----------------------------------------------------- -->

	<div class=" modal bd-example-modal-lg" tabindex="-1" role="dialog" id="action_modal">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header modal-bg" >
					<div class="row w-100"  >
						<div class="col-md-12" >
							<h5 class="modal-title h5-title" id="modal_action_no" ></h5>
						</div>
					</div>
					
					 <button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" align="center">
					<form action="#" method="post" autocomplete="off"  >
						<table class="width-100">
							<tr>
								<th class="width-10 padding5px"> Action Item :</th>
								<td class="tabledata modal-action-item"  colspan="3" id="modal_action_item"></td>
							</tr>
							<tr>
								<th class="padding5px" >Assign Date :</th>
								<td class="padding5px" id="modal_action_date"></td>
								<th class="padding5px" >PDC :</th>
								<td class="padding5px" id="modal_action_PDC"></td>
							</tr>
							<tr>
								<th class="padding5px" >Assignor :</th>
								<td class="tabledata padding5px" id="modal_action_assignor"></td>
								<th class="padding5px" >Assignee :</th>
								<td class="tabledata padding5px" id="modal_action_assignee"></td>
							</tr>
							<tr>
								<th class="padding5px" >Final Progress :</th>
								<td class="padding5px" id="modal_action_progress"></td>
								<th class="padding5px" > Type :</th>
								<td class="modal-action-type" id="modal_action_type"></td>
							</tr>
							
						</table>
						</form>
						<hr>
						<form action="#" method="get">
						
						<table class="table table-bordered table-hover table-striped table-condensed  width-100" id="">
							<thead> 
								<tr class="tr-styl">
									<th class="th-sn">SN</th>
									<th class="th-progress-date">Progress Date</th>
									<th class="th-progress"> Progress</th>
									<th class="th-remarks">Remarks</th>
									<th class="th-download">Download</th>
								</tr>
							</thead>
							<tbody id="modal_progress_table_body">
								
							</tbody>
						</table>
						</form>
					
				</div>
				
			</div>
		</div>
	</div>

<!-- -------------------------------------------------------------- action modal ----------------------------------------------------- -->


<!-- ------------------------------- tree script ------------------------------- -->
<script type="text/javascript">

$(function () {
    $('.genealogy-tree ul').hide();
    $('.genealogy-tree>ul').show();
    $('.genealogy-tree ul.active').show();
    $('.genealogy-tree li .action-box-body').on('click', function (e) {
		
        var children = $(this).parent().parent().parent().find('> ul');
        if (children.is(":visible")) {
        	children.hide('fast').removeClass('active');
        	$(this).find('i').removeClass('fa fa-caret-down');
        	$(this).find('i').addClass('fa fa-caret-up');
        } else {
        	children.show('fast').addClass('active');
        	$(this).find('i').removeClass('fa fa-caret-up');
        	$(this).find('i').addClass('fa fa-caret-down');
    	}
        e.stopPropagation();
    });
});


</script>
<!-- ------------------------------- tree script ------------------------------- -->


<script type="text/javascript">

function ActionDetails(InAssignId)
{
		$("#modal_progress_table").DataTable().destroy();
		
		$.ajax({		
			type : "GET",
			url : "ActionAssignDataAjax.htm",
			data : {
				ActionAssignid : InAssignId
			},
			datatype : 'json',
			success : function(result) {
				var result = JSON.parse(result);
				
				$('#modal_action_item').html(result[1]);
				$('#modal_action_no').html(result[2]);
				$('#modal_action_date').html(moment(new Date(result[5]) ).format('DD-MM-YYYY'));
				$('#modal_action_PDC').html(moment(new Date(result[6]) ).format('DD-MM-YYYY'));
				$('#modal_action_assignor').html(result[8]);
				$('#modal_action_assignee').html(result[9]);
				
				var InActionType = result[9];
				var ActionType = 'Action';
				
				if(InActionType==='A')
				{
					ActionType = 'Action';
				}
				else if(InActionType==='I')
				{
					ActionType = 'Issue';
				}
				else if(InActionType==='D')
				{
					ActionType = 'Decision';
				}
				else if(InActionType==='R')
				{
					ActionType = 'Recommendation';
				}
				else if(InActionType==='C')
				{
					ActionType = 'Comment';
				}
				else if(InActionType==='K')
				{
					ActionType = 'Risk';
				}
				
				$('#modal_action_type').html(ActionType);
				
				var InProgress = '0'
				if(result[4]!=null){
					InProgress=result[4]+'';
				}
				
				
				if(InProgress.trim() === '0')
				{
					var progressBar ='<div class="progress script-progress">'; 
					progressBar += 		'<div class="progress-bar script-progressbar" role="progressbar"  >';
					progressBar +=		'Not Started'
					progressBar +=		'</div>'; 
					progressBar += '</div>'; 
				}
				else
				{
					var progressBar ='<div class="progress script-progress" >'; 
					progressBar += 		'<div class="progress-bar progress-bar-striped width-'+InProgress+'" role="progressbar" aria-valuemin="0" aria-valuemax="100" >';
					progressBar +=		InProgress
					progressBar +=		'</div>'; 
					progressBar += '</div>'; 
				}
				$('#modal_action_progress').html(progressBar);
			}
		});
		
		
		
		
		
		$.ajax({		
			type : "GET",
			url : "ActionSubListAjax.htm",
			data : {
				ActionAssignid : InAssignId
			},
			datatype : 'json',
			success : function(result) {
				var result = JSON.parse(result);
				
				
				var htmlStr='';
				if(result.length> 0){
					for(var v=0;v<result.length;v++)
					{	
						htmlStr += '<tr>';
						
						htmlStr += '<td class="tabledata text-center"  >'+ (v+1) + '</td>';
						htmlStr += '<td class="tabledata text-center" >'+ moment(new Date(result[v][3]) ).format('DD-MM-YYYY') + '</td>';
						htmlStr += '<td class="tabledata text-center" >'+ result[v][2] + ' %</td>';
						htmlStr += '<td class="tabledata" >'+ result[v][4] + '</td>';
						
						if(result[v][5]=== null)
						{
							htmlStr += '<td class="tabledata text-center" >-</td>';
						}
						else
						{
							htmlStr += '<td class="tabledata text-center"><button type="submit" class="btn btn-sm" name="ActionSubId" value="'+ result[v][5] + '" target="blank" formaction="ActionDataAttachDownload.htm" ><i class="fa fa-download"></i></button></td>';
						}
						htmlStr += '</tr>';
					}
				}
				else
				{
					htmlStr += '<tr>';
					
					htmlStr += '<td colspan="5" class="text-center"> Progress Not Updated </td>';
					
					htmlStr += '</tr>';
				}
				setModalDataTable();
				$('#modal_progress_table_body').html(htmlStr);
				
				
				$('#action_modal').modal('toggle');
			}
		});
		
		
	}
	setModalDataTable();
	function setModalDataTable()
	{
		$("#modal_progress_table").DataTable({
			"lengthMenu": [ 5, 10,25, 50, 75, 100 ],
			"pagingType": "simple",
			"pageLength": 5
		});
	}
</script>

</body>
</html>
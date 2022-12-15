<%@page import="java.util.ArrayList"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Action Tree</title>
<jsp:include page="../static/dependancy.jsp"></jsp:include>
<spring:url value="/resources/plugins/HTree/HTree.css" var="HTreecss" />
<link href="${HTreecss}" rel="stylesheet" />
<spring:url value="/resources/plugins/HTree/HTree.js" var="HTreejs" />
<script src="${HTreejs}"></script>

<style type="text/css">
.action-box
{
    width: fit-content ;
    height: fit-content;
    min-width:220px;
    
    border: 1px solid black;
    border-radius: 10px;
}

.action-box-header
{
	border-top-right-radius : 10px;
	border-top-left-radius: 10px;
 	
	display: block;
    flex-wrap: wrap;
    justify-content: center;
	background: #BBC0FF;
	padding:5px;

    -ms-word-break: break-word;
    -ms-hyphens: auto;
    -moz-hyphens: auto;
    -webkit-hyphens: auto;
    
  	text-align: center;
}

.action-box-body
{
	padding:5px;
	text-align: center;
	background-color: #ffffff;
	display: block;
    flex-wrap: wrap;
    border-bottom-right-radius : 10px;
	border-bottom-left-radius: 10px;
}

.card-body-table
{
	width:100%;
}

.card-body-table  td
{
	border:0px;
	text-align: left;
}	
	
.card-body-table th
{
	border:0px;
}



</style>

</head>
<body style="background-color: #FDFFCF69;overflow-y:auto " class="body genealogy-body genealogy-scroll">
<%
	List<Object[]> actionslist = (List<Object[]>)request.getAttribute("actionslist");
	SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
	SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
	  
	int startLevel = 0;
	
	/* List<Long> ActionAddedList = new ArrayList<Long>(); */
	
	if(actionslist.size()>0){
		startLevel = Integer.parseInt(actionslist.get(0)[3].toString());
	} 

%>

<div  >
    <div class="genealogy-tree" ">
        
  		<ul>
			<li>      
				<%if(startLevel >= 0){ %> 
					<%for(Object[] action : actionslist){ %>
						<% if(Integer.parseInt(action[3].toString()) == startLevel){ %>
							
		                    <div class="member-view-box action-view-box">
		                        <div class=" action-box" >
		                          	<div class="action-box-header">
		                          		
		                          		<span style="cursor:pointer;font-weight: 600;" 
		                          			onclick="ActionDetails('<%=action[10] %>',   <!-- assignid -->
		                          									'<%=action[5] %>',   <!-- action item -->
		                          									'<%=action[11] %>',   <!-- action No -->
		                          									'<%if(action[25]!=null){ %> <%=action[25] %> % <%}else{ %> Not Started <%} %>', <!-- progress -->
		                          									'<%=sdf.format(action[4]) %>', <!-- action date -->
		                          									'<%=sdf.format(action[24]) %>', <!-- enddate -->
		                          									'<%=sdf.format(action[12]) %>', <!-- orgpdc -->
		                          									'<%=action[22]%>', <!-- assignor -->
		                          									'<%=action[23]%>' <!-- assignee -->
		                          									);" >
		                          				<%=action[11] %>
		                          		</span >           
		                          		
		                          	</div>
		                          	<div class="action-box-body" align="center">
		                          		<table class="card-body-table">
		                          			<tr>
		                          				<th style="text-align: right;">Assignee :</th>
		                          				<td>&emsp;<%=action[23] %></td>
		                          			</tr>
		                          			<tr>
		                          				<th style="text-align: right;">PDC :</th>
		                          				<td>&emsp;<%=sdf.format(action[24]) %></td>
		                          			</tr>
		                          			<tr>
		                          				<th style="text-align: right;">Progress :</th>
		                          				<td>
		                          					&emsp;<%if(action[25]!=null){ %>
		                          						<%=action[25] %> %
		                          					<%}else{ %>
		                          						Not Started
		                          					<%} %>
		                          				</td>
		                          			</tr>
		                          		</table>  
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
												<div class="action-box-header">
												                          		
													<span style="cursor:pointer;font-weight: 600;" ><%=action_L1[11] %></span >    
													       
												</div>
												<div class="action-box-body" align="center">
													<table class="card-body-table">
														<tr>
															<th style="text-align: right;">Assignee :</th>
															<td>&emsp;<%=action_L1[23] %></td>
														</tr>
														<tr>
															<th style="text-align: right;">PDC : </th>
															<td>&emsp;<%=sdf.format(action_L1[24]) %></td>
														</tr>
														<tr>
					                          				<th style="text-align: right;">Progress :</th>
					                          				<td>
					                          					&emsp;<%if(action_L1[25]!=null){ %>
					                          						<%=action_L1[25] %> %
					                          					<%}else{ %>
					                          						Not Started
					                          					<%} %>
					                          				</td>
					                          			</tr>
													</table>
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
															<div class="action-box-header">
															                          		
																<span style="cursor:pointer;font-weight: 600;" ><%=action_L2[11] %></span >           
															      
															</div>
															<div class="action-box-body" align="center">
																<table class="card-body-table">
																	<tr>
																		<th style="text-align: right;">Assignee :</th>
																		<td>&emsp;<%=action_L2[23] %></td>
																	</tr>
																	<tr>
																		<th style="text-align: right;">PDC :</th>
																		<td>&emsp;<%=sdf.format(action_L2[24]) %></td>
																	</tr>
																	<tr>
								                          				<th style="text-align: right;">Progress :</th>
								                          				<td>
								                          					&emsp;<%if(action_L2[25]!=null){ %>
								                          						<%=action_L2[25] %> %
								                          					<%}else{ %>
								                          						Not Started
								                          					<%} %>
								                          				</td>
								                          			</tr>
																</table>
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
																			<div class="action-box-header">
																			                          		
																				<span style="cursor:pointer;font-weight: 600;" ><%=action_L3[11] %></span >           
																			      
																			</div>
																			<div class="action-box-body" align="center">
																				<table class="card-body-table">
																					<tr>
																						<th style="text-align: right;">Assignee :</th>
																						<td>&emsp;<%=action_L3[23] %></td>
																					</tr>
																					<tr>
																						<th style="text-align: right;">PDC :</th>
																						<td>&emsp;<%=sdf.format(action_L3[24]) %></td>
																					</tr>
																					<tr>
												                          				<th style="text-align: right;">Progress :</th>
												                          				<td>
												                          					&emsp;<%if(action_L3[25]!=null){ %>
												                          						<%=action_L3[25] %> %
												                          					<%}else{ %>
												                          						Not Started
												                          					<%} %>
												                          				</td>
												                          			</tr>
																				</table>
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
																								<div class="action-box-header">
																								                          		
																									<span style="cursor:pointer;font-weight: 600;" ><%=action_L4[11] %></span >           
																								     
																								</div>
																								<div class="action-box-body" align="center">
																									<table class="card-body-table">
																										<tr>
																											<th style="text-align: right;">Assignee :</th>
																											<td>&emsp;<%=action_L4[23] %></td>
																										</tr>
																										<tr>
																											<th style="text-align: right;">PDC :</th>
																											<td>&emsp;<%=sdf.format(action_L4[24]) %></td>
																										</tr>
																										<tr>
																	                          				<th style="text-align: right;">Progress :</th>
																	                          				<td>
																	                          					&emsp;<%if(action_L4[25]!=null){ %>
																	                          						<%=action_L4[25] %> %
																	                          					<%}else{ %>
																	                          						Not Started
																	                          					<%} %>
																	                          				</td>
																	                          			</tr>
																									</table>
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
				<%} %>        
        		</li>
	        </ul>

    </div>
</div>


<script type="text/javascript">

	function ActionDetails(InAssignId,InActionItem,InActionNo,InProgress,InActionDate,InEndDate,InPDCOrg,
							InAssignor,InAssignee	)
	{
		$('#modal_action_no').html(InActionNo);
		$('#modal_action_item').html(InActionItem);
		$('#modal_action_date').html(InActionDate);
		$('#modal_action_PDC').html(InEndDate);
		$('#modal_action_assignor').html(InAssignor);
		$('#modal_action_assignee').html(InAssignee);
		
		
		
		
		$('#action_modal').modal('toggle');
		
	}

</script>
    
    


<!-- -------------------------------------------------------------- action modal ----------------------------------------------------- -->



	<div class=" modal bd-example-modal-lg" tabindex="-1" role="dialog" id="action_modal">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header" align="center">
					<h5 class="modal-title" id="modal_action_no" style="font-weight:700; color: #A30808;"></h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" align="center">
					<form action="#" method="post" autocomplete="off"  >
						<table style="width: 100%;">
							<tr>
								<th style="width:10%;padding: 5px;"> Action Item :</th>
								<td style="width:90%;padding: 5px;" colspan="3" id="modal_action_item"></td>
							</tr>
							<tr>
								<th style="text-align: right;padding: 5px;" >Assign Date :</th>
								<td style="padding: 5px;" id="modal_action_date"></td>
								<th style="text-align: right;padding: 5px;" >PDC :</th>
								<td style="padding: 5px;" id="modal_action_PDC"></td>
							</tr>
							<tr>
								<th style="text-align: right;padding: 5px;" >Assignor :</th>
								<td style="padding: 5px;" id="modal_action_assignor"></td>
								<th style="text-align: right;padding: 5px;" >Assignee :</th>
								<td style="padding: 5px;" id="modal_action_assignee"></td>
							</tr>
							
						</table>
					</form>
				</div>
				
			</div>
		</div>
	</div>

	





<!-- -------------------------------------------------------------- action modal ----------------------------------------------------- -->


</body>
</html>
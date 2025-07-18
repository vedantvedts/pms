<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/sweetalert2.min.css" var="sweetalertCss" />
<spring:url value="/resources/js/sweetalert2.min.js" var="sweetalertJs" />
	<link href="${sweetalertCss}" rel="stylesheet" />
	<script src="${sweetalertJs}"></script>
 

<title>Milestone List</title>
<style type="text/css">
label{
font-weight: bold;
  font-size: 14px;
}
.table thead tr,tbody tr{
    font-size: 14px;
}
body{
background-color: #f2edfa;
overflow-x:hidden !important; 
}
h6{
	text-decoration: none !important;
}
.multiselect-container>li>a>label {
  padding: 4px 20px 3px 20px;
}
.cc-rockmenu {
	color:fff;
	padding:0px 5px;
	font-family: 'Lato',sans-serif;
}

/*  #swal2-title , #swal2-html-container{
display:none !important;
}

.swal2-popup{
background: none !important;
}  */
.cc-rockmenu .rolling {
  display: inline-block;
  cursor:pointer;
  width: 34px;
  height: 30px;
  text-align:left;
  overflow: hidden;
  transition: all 0.3s ease-out;
  white-space: nowrap;
  
}
.cc-rockmenu .rolling:hover {
  width: 120px;
}
.cc-rockmenu .rolling .rolling_icon {
  float:left;
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
    font-family: 'Muli',sans-serif;
}

.cc-rockmenu .rolling p {
	margin:0;
}

.width{
	width:210px !important;
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
  
  String projectshortName="";
  
  List<Object[]> EmployeeList=(List<Object[]>)request.getAttribute("EmployeeList");
  List<Object[]> MilestoneList=(List<Object[]>)request.getAttribute("MilestoneActivityList");
  List<Object[]> ProjectList=(List<Object[]>)request.getAttribute("ProjectList");
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
  String ProjectId=(String)request.getAttribute("ProjectId");
  String LoginType = (String)session.getAttribute("LoginType");
  List<String> actionAllowedFor =  Arrays.asList("A", "P");
  Long projectDirector = 0L;
  
  Long empId = (Long)session.getAttribute("EmpId");
 %>


    <form class="form-inline"  method="POST" action="MilestoneActivityList.htm">
  <div class="row W-100" style="width: 100%;">

  <div class="col-md-7">
  <h6 style="color: #145374;" >&nbsp; &nbsp; Project <i class="fa fa-long-arrow-right " aria-hidden="true"></i> Add Milestone <i class="fa fa-long-arrow-right " aria-hidden="true"></i> 
  							Add SubActivity <i class="fa fa-long-arrow-right " aria-hidden="true"></i> SubActivity <i class="fa fa-long-arrow-right " aria-hidden="true"></i> Weightage <i class="fa fa-long-arrow-right " aria-hidden="true"></i> Assignee</h6>
  </div>
	
                                    <div class="col-md-2">
                            		<label class="control-label">Project Name :</label>
                            		</div>
                            		<div class="col-md-2" style="margin-top: -7px;">
                              		<select class="form-control selectdee" id="ProjectId" required="required" name="ProjectId">
    									<option disabled="true"  selected value="">Choose...</option>
    										<% for (Object[] obj : ProjectList) {
    										 projectshortName=(obj[17]!=null)?" ( "+obj[17].toString()+" ) ":"";
    										%>
											<option value="<%=obj[0]%>" <%if(obj[0].toString().equalsIgnoreCase(ProjectId)){ %>selected="selected" <%projectDirector = Long.parseLong(obj[23].toString()); %> <%} %>> <%=obj[4]+projectshortName%>  </option>
											<%} %>
  									</select>
  									</div>
<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
 <input id="submit" type="submit" name="submit" value="Submit" hidden="hidden">
 </div>
</form>


<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
if(ses1!=null){	%>
	<div align="center">
		<div class="alert alert-danger" role="alert" >
	    <%=ses1 %>
	     <br />
	    </div>
	</div>
	<%}if(ses!=null){ %>
	<div align="center">
		<div class="alert alert-success" role="alert"  >
	    	<%=ses %>
	    	 <br />
	    </div>
	</div>
<%} %>

   
  

   
   
   
   <div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover" style="margin-top: -0px;">
				<div class="row card-header">
			     <div class="col-md-10">
					<h5 ><%if(ProjectId!=null){
						Object[] ProjectDetail=(Object[])request.getAttribute("ProjectDetails");
						%>
						<%=ProjectDetail[2] %> ( <%=ProjectDetail[1] %> ) 
					<%} %>
					 Milestone List</h5>
					</div>
					<div class="col-md-2 justify-content-end" style="float: right;">
					<%if(ProjectId!=null){ %>                              

						 <%if(LoginType.equalsIgnoreCase("A") || projectDirector.toString().equalsIgnoreCase(empId+"") ){ %>								
																
					  <form class="  justify-content-end"  method="POST" action="MilestoneActivityAdd.htm">
					  		<%if(MilestoneList.size()>0){ %>
                               	<button  style="color: green;font: green;border : 1px solid #7F7C82" class="btn btn-sm" type="submit" name="sub" value="Accept" formaction="MilestoneExcelFile.htm"  formtarget="_blank">
									<i class="fa fa-file-excel-o" aria-hidden="true"></i>
				                </button> 
							<%} %>
                            	<input type="hidden" name="ProjectId"	value="<%=ProjectId %>" /> 
                             <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
                              <input type="hidden" name="projectDirector" value="<%=projectDirector%>">  
                               <input type="submit"  value="Add Activity" class="btn btn-sm add" style="float: right;">
                          
                     </form>
                          <%} %>
					 <%} %>
					 </div>
					 </div>
					
					<div class="card-body">
                        <div class="table-responsive"> 
									<table class="table  table-hover table-bordered">
													<thead class="center">

														<tr>
															<th>Expand</th>
															<th>SN</th>
															<th>Mil-No</th>
														<!-- 	<th style="text-align: left;">Project Name</th> -->
															<th>Milestone Activity</th>
															<th >Start Date</th>
															<th >End Date</th>	
															<th style="padding: 0px !important">
															<div style="border-bottom: 1px solid #dee2e6;">First OIC </div>
															 Second OIC</th>
															<th>Status</th>
															<th>Weightage</th>	
															<th>Progress</th>			
															<%-- <%if(actionAllowedFor.contains(LoginType) || projectDirector.equals(empId) || oicEmpId.equals(empId)) {%>	 --%>								
														 		<th>Action</th>
														 	<%-- <%} %> --%>	
														 	
														</tr>
													</thead>
													<tbody>
														<%int  count=1;
															
														 	if(MilestoneList!=null&&MilestoneList.size()>0){
															for(Object[] obj: MilestoneList){ %>
														<tr>
															<td style="width:2% !important; " class="center">
																<span class="clickable" data-toggle="collapse" id="row<%=obj[0] %>" data-target=".row<%=obj[0]  %>">
																	<button class="btn btn-sm btn-success" id="btn<%=obj[0]  %>"  onclick="ChangeButton('<%=obj[0]  %>')">
																		<i class="fa fa-plus"  id="fa<%=obj[0] %>"></i> 
																	</button>
																</span>
																<input type="hidden" id="financialOutlay_<%=obj[0]%>" value="<%=obj[18]!=null?obj[18]:"-"%>">
																<input type="hidden" id="statusRemarks_<%=obj[0]%>" value="<%=obj[11]!=null?obj[11].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", ""):"-"%>">
															</td>
															<td style="text-align: left;width: 5% !important;">
																<input class="form-control" form="slnoupdateform" type="number" name="newslno" value="<%=obj[5]%>" min="1" max="<%=MilestoneList.size()%>">
																<input type="hidden" form="slnoupdateform" name="milestoneActivityId" value="<%=obj[0]%>"/>
															</td>
															<td style="text-align: left;width: 5%;"> Mil-<%=obj[5]%></td>
															<%-- <td class="width-30px"><%=obj[1]%></td> --%>
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;cursor: pointer;" 
															onclick="showMilestoneStatusProgress('<%=obj[0]%>')">
															<%=obj[4] %>
															</td>
															
															<td style="width:8% !important; "><%=sdf.format(obj[2])%></td>
															<td style="width:8% !important; "><%=sdf.format(obj[3])%></td>
															<td  style="width:15% !important; "><%=obj[6]%> <br> <%=obj[7]%> </td>
															<td  style="width: 8% !important; ">-</td>
															<td  style="width:7% !important; " align="center"><%=obj[13]%></td>	
															<td>
																<%if(!obj[12].toString().equalsIgnoreCase("0")){ %>
																<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
																<div class="progress-bar progress-bar-striped
																<%if(obj[14].toString().equalsIgnoreCase("2")){ %>
																 bg-success
																<%} else if(obj[14].toString().equalsIgnoreCase("3")){ %>
																  bg-info
																<%} else if(obj[14].toString().equalsIgnoreCase("4")){ %>
																  bg-danger
																<%} else if(obj[14].toString().equalsIgnoreCase("5")){ %>
																  bg-warning
																<%}  %>
																" role="progressbar" style=" width: <%=obj[12] %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
																<%=obj[12] %>
																</div> 
																</div> <%}else{ %>
																<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
																<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
																Not Started
																</div>
																</div> <%} %>
															</td>
																<td  style="width:20% !important; text-align: center;">		
																	<form action="MilestoneActivityDetails.htm" method="POST" name="myfrm"  style="display: inline">
																		<%if(Integer.parseInt(obj[12].toString())<100){ %>
																			<button  class="editable-click" name="sub" value="B" id="detailsAddbtn<%=obj[0].toString() %>">  
																				<div class="cc-rockmenu">
															                      <div class="rolling">
															                        <figure class="rolling_icon"><img src="view/images/preview3.png"  ></figure>
															                        <span>Details</span>
															                      </div>
															                     </div> 
																			</button>
																		<%}else if(Integer.parseInt(obj[12].toString())==100){ %>
																			<button  class="editable-click" type="button" onclick="MainDOCEditModal(<%=obj[0]%>,'<%=obj[16]%>')" id="docbtn<%=obj[0]%>">  
																				<div class="cc-rockmenu">
															                      <div class="rolling">
															                        <figure class="rolling_icon"><i class="fa fa-calendar-o" aria-hidden="true"></i></figure>
															                        <span>Date of Completion</span>
															                      </div>
															                     </div> 
																			</button>
																		<%} %>
																		  <%if("N".equalsIgnoreCase(obj[10].toString())){ %>
																		  	<%if("A".equalsIgnoreCase(LoginType) || projectDirector.equals(empId) || Long.parseLong(obj[17].toString())==(empId)) { %>
																		  
			                                                              <button  class="editable-click" name="sub" value="C"  id="EditWeightage<%=obj[0].toString()%>">
																			<div class="cc-rockmenu">
																			 <div class="rolling">	
														                        <figure class="rolling_icon"><img src="view/images/edit.png" ></figure>
														                        <span>Edit/Weightage</span>
														                      </div>
														                     </div>
														                  </button> 
			                                                             <button type="submit" id="assignBtn<%=obj[0].toString() %>"  class="editable-click" name="sub" value="Assign"  formaction="M-A-Assign-OIC.htm" onclick="if('0'=='<%=obj[13].toString() %>'){alert('Please add Weightage first then you able to assign.');return false; }else{ return confirm('Are You Sure To Assign ?') }"   >
																			<div class="cc-rockmenu">
																			 <div class="rolling">	
														                        <figure class="rolling_icon"><img src="view/images/assign.jpg" ></figure>
														                        <span>Assign</span>
														                      </div>
														                     </div>
														                  </button>
														                  <br>
														                 <%--     <button type="button" id="deleteBtn<%=obj[0].toString() %>"  class="editable-click deleteBtn" name="sub" value="<%=obj[0].toString() %>"    >
																			<div class="cc-rockmenu">
																			 <div class="rolling">	
														                        <figure class="rolling_icon"><img src="view/images/delete.png" ></figure>
														                        <span>Delete</span>
														                      </div>
														                     </div>
														                  </button> --%>  
														                  <%} %>
			                                                              <%}else if("Y".equalsIgnoreCase(obj[10].toString())){ %>
<%-- 			                                                              <%if("A".equalsIgnoreCase(LoginType) || projectDirector.equals(empId) || Long.parseLong(obj[17].toString())==(empId)) { %>
 --%>			                                                               <button  class="editable-click" name="sub" value="C" id="basLineBtn<%=obj[0].toString() %>" >
																			<div class="cc-rockmenu">
																			 <div class="rolling">	
														                        <figure class="rolling_icon"><img src="view/images/clipboard.png" ></figure>
														                        <span>Base Line </span>
														                      </div>
														                     </div>
														                  </button>    
														                 <%--  <%} %> --%>
			                                                               <%} %>
			                                                            <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
																	    <input type="hidden" name="MilestoneActivityId" value="<%=obj[0]%>"/>
																	    <input type="hidden" name="projectid" value="<%=ProjectId%>"/>
																	    <input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
																	    <input type="hidden" name="projectDirector" value="<%=projectDirector %>" >
																 </form> 
																 
																 	<form action="MilestoneActivityDetails.htm" method="POST" name="myfrm"  style="display: inline">
															 
		                                                            <%if("B".equalsIgnoreCase(obj[10].toString())){ %>
		                                                              
		                                                             <button type="button"  class="editable-click" name="sub" value="Back"   data-toggle="modal" data-target="#exampleModal<%=obj[0]%>" data-whatever="@mdo" >
																		<div class="cc-rockmenu">
																		 <div class="rolling">	
													                        <figure class="rolling_icon"><img src="view/images/message.png" ></figure>
													                        <span>Message</span>
													                      </div>
													                     </div>
													                 </button>
																	 
																	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
																    <input type="hidden" name="MilestoneActivityId" value="<%=obj[0]%>"/>
																	 <div class="modal fade" id="exampleModal<%=obj[0]%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
							                                              <div class="modal-dialog">
							                                          <div class="modal-content">
							                                             <div class="modal-header">
							                                            <h5 class="modal-title" id="exampleModalLabel">Send Back Remarks</h5>
									                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
									                                     <span aria-hidden="true">&times;</span>
									                                       </button>
							                                        </div>
							                                         <div class="modal-body">
							          	                                  <div class="row">
							                       				 
										                                     <div class="col-md-12">
																				<div class="form-group">
																					<label class="control-label">Remark</label> 
																				    <textarea class="form-control" readonly="readonly" name="Remarks" style="height: 9rem;" maxlength="255" required="required" placeholder="Enter Send Back Remark here with max 255 characters"> <%=obj[11] %>  </textarea>
																				</div>
																			</div>       
																
								                                         	</div>
								                                     		<div class="modal-footer">
								        
										                                         <button  class="btn btn-sm btn-success" name="sub" value="Assign"  formaction="M-A-Assign-OIC.htm" onclick="return confirm('Are You Sure To Assign ?')" >Assign Again</button>
										        								 <input type="hidden" name="projectid" value="<%=ProjectId%>"/>
								   
								                                           	</div>
							                                            </div>
							                                            </div>
							                                            </div>
																		</div> 
																		<%} %>	
																	 </form> 
																	 
																	 <span class="btn btn-sm btn-info" id="spanMessage<%=obj[0].toString()%>" style="display: none;">Access Denied</span>
																</td>
															<%-- <%} else {%>
																<td class="center"> <span class="btn btn-sm btn-info">Access Denied</span> </td>
															<%} %> --%>	
														</tr>
														 <tr class="collapse row<%=obj[0]%> trclass<%=obj[0]%>" style="font-weight: bold;" >
                                                         <td></td>
                                                         <td></td>
                                                         <td>Sub</td>
                                                         <td>Activity</td>
                                                         <td>Start Date</td>
                                                         <td>End Date</td>
                                                         	<th style="padding: 0px !important;text-align: center;">
															<div style="border-bottom: 1px solid #dee2e6;">First OIC </div>
															 Second OIC</th>
                                                         <td>Date Of Completion</td>
                                                         <td>Sub Weightage</td>
                                                         <td>Sub Progress</td>
                                                         <%if(actionAllowedFor.contains(LoginType)) {%>
                                                         	<td>Shown in display of Briefing Paper and MOM</td>
                                                         <%} %>
                                                         </tr>
                                                         <%
                                                         List<String>empList = new ArrayList<>();
                                                         int countA=1;
                                                            List<Object[]> MilestoneA=(List<Object[]>)request.getAttribute(count+"MilestoneActivityA");
														 	if(MilestoneA!=null&&MilestoneA.size()>0){
															for(Object[] objA: MilestoneA){
																//check if empList contains first OIC of A level 
																if(!empList.contains(objA[13].toString() )){
																empList.add(objA[13].toString());
																}
																//check if empList contains first 2ndIC of A level 
																if(!empList.contains(objA[15].toString() )){
																	empList.add(objA[15].toString());
																	}
	                                                            List<Object[]> MilestoneB=(List<Object[]>)request.getAttribute(count+"MilestoneActivityB"+countA);
	
																%>
																		
														<tr class="collapse row<%=obj[0]  %> trclass<%=obj[0]%>"  >
														
															<td style="width:2% !important; " class="center">
															</td>
															<td class="center"> 
															<%if(MilestoneB!=null && MilestoneB.size()>0) {%>
															<span class="clickable" data-toggle="collapse" id="row_<%=objA[0] %>" data-target=".row_<%=objA[0]  %>">
																	<button class="btn btn-sm btn-success" id="btn<%=objA[0]  %>"  onclick="ChangeButton('<%=objA[0]  %>')">
																		<i class="fa fa-plus"  id="fa<%=objA[0] %>"></i> 
																	</button>
																</span>
																<%}else{ %>
<%-- 																<button type="button"  class="btn" onclick="supersedingMilestone('<%=objA[0] %>','<%=objA[4] %>', 'M<%=obj[5]%>-A<%=countA%>'  )"> <i class="fa fa-info" aria-hidden="true" style="color: #055C9D"></i></button>
 --%>																<%} %>
															</td>
															<td style="text-align: left;width: 5%;"> A-<%=countA%></td>
															<%-- <td class="width-30px"><%=obj[1]%></td> --%>
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;cursor: pointer;"
															 onclick="showMilestoneProgress('<%=obj[0]%>', '<%=objA[0]%>', '<%=ProjectId%>', 'A')">
															<%=objA[4] %>
															</td>
															
															<td class="width-30px"><%=sdf.format(objA[2])%></td>
															<td style="width:8% !important; "><%=sdf.format(objA[3])%></td>
															<td><%=objA[14]%>
															<br>
																
															<%= EmployeeList.stream()
															.filter(e->e[0].toString().equalsIgnoreCase(objA[15].toString()))
															.map(e -> (e[4]!=null?e[4].toString():e[3]!=null?e[3].toString():" " )+   e[1].toString() + ", " + e[2].toString())
															.findFirst()
														    .orElse("-")
															%>	
															
															
															</td>
															
															<td class="width-30px"><%if(objA[9].toString().equalsIgnoreCase("3")||objA[9].toString().equalsIgnoreCase("5")){ %>
														     <%if(objA[7]!=null){ %>   <%=sdf.format(objA[7]) %> <%}else{ %><%=objA[8] %> <%} %>
														         <%}else{ %>
														         <%=objA[8] %>
															 <%} %>
															 </td>
															 <td align="center"><%=objA[6] %></td>
															<td>
															<%if(!objA[5].toString().equalsIgnoreCase("0")){ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar progress-bar-striped
															<%if(objA[9].toString().equalsIgnoreCase("2")){ %>
															 bg-success
															<%} else if(objA[9].toString().equalsIgnoreCase("3")){ %>
															  bg-info
															<%} else if(objA[9].toString().equalsIgnoreCase("4")){ %>
															  bg-danger
															<%} else if(objA[9].toString().equalsIgnoreCase("5")){ %>
															  bg-warning
															<%}  %>
															" role="progressbar" style=" width: <%=objA[5] %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
															<%=objA[5] %>
															</div> 
															</div> <%}else{ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Not Started
															</div>
															</div> <%} %>
															</td>
															
															<td>						
							              <%if("A".equalsIgnoreCase(LoginType) || projectDirector.equals(empId) || Long.parseLong(objA[13].toString())==(empId)) { %>
		                                                         
			                                                         <div style="display: flex; justify-content: center;">
			                                                         <div style="display: flex;width:80%">
			                                                		5<input type="checkbox" <%if(objA[19].toString().equalsIgnoreCase("Y")){ %>checked<%} %> class="form-control point5"  value="<%=objA[0].toString()+"/"+objA[19].toString()+"/point5"%>" onchange="updateBpPoints(this)">
			                                                        6.a<input type="checkbox" <%if(objA[20].toString().equalsIgnoreCase("Y")){ %>checked<%} %> class="form-control point6"  value="<%=objA[0].toString()+"/"+objA[20].toString()+"/point6"%>" onchange="updateBpPoints(this)">
			                                                        9<input type="checkbox" <%if(objA[21].toString().equalsIgnoreCase("Y")){ %>checked<%} %> class="form-control point9"  value="<%=objA[0].toString()+"/"+objA[21].toString()+"/point9"%>" onchange="updateBpPoints(this)">
			                                                         </div>
			                                                         </div>
		                                                         
	                                                         <%} %></td>
                                                         </tr>
                                                  
                                                         <% int countB=1;
														 	if(MilestoneB!=null&&MilestoneB.size()>0){
															for(Object[] objB: MilestoneB){
																
																//check if empList contains first OIC of B level 
																if(!empList.contains(objB[13].toString() )){
																empList.add(objB[13].toString());
																}
																//check if empList contains first 2ndIC of B level 
																if(!empList.contains(objB[15].toString() )){
																	empList.add(objB[15].toString());
																	}
	                                                            List<Object[]> MilestoneC=(List<Object[]>)request.getAttribute(count+"MilestoneActivityC"+countA+countB);
	
																%>
														<tr class="collapse row_<%=objA[0]  %> trclass<%=obj[0]%> trclass<%=objA[0]%>"  >
															<td style="width:2% !important; " class="center"> </td>
																<td class="center"> 
															<%if(MilestoneC!=null && MilestoneC.size()>0) {%>
															<span class="clickable" data-toggle="collapse" id="row_<%=objB[0] %>" data-target=".row_<%=objB[0]  %>">
																	<button class="btn btn-sm btn-success" id="btn<%=objB[0]  %>"  onclick="ChangeButton('<%=objB[0]  %>')">
																		<i class="fa fa-plus"  id="fa<%=objB[0] %>"></i> 
																	</button>
																</span>
																<%}else{ %>
<%-- 																<button type="button"  class="btn" onclick="supersedingMilestone('<%=objB[0] %>','<%=objB[4] %>', 'M<%=obj[5]%>-A<%=countA%>-B<%=countB%>'  )"> <i class="fa fa-info" aria-hidden="true" style="color: #055C9D"></i></button>
 --%>																<%} %>
															</td>
															<td style="text-align: left;width: 5%;"> &nbsp;&nbsp;&nbsp;B-<%=countB%></td>
															<%-- <td class="width-30px"><%=obj[1]%></td> --%>
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;cursor: pointer;"
															 onclick="showMilestoneProgress('<%=obj[0]%>', '<%=objB[0]%>', '<%=ProjectId%>', 'B')">
																<%=objB[4] %>
															</td>
															
															<td class="width-30px"><%=sdf.format(objB[2])%></td>
															<td style="width:8% !important; "><%=sdf.format(objB[3])%></td>
															<td><%=objB[14]%>
															<br>
															<%= EmployeeList.stream()
															.filter(e->e[0].toString().equalsIgnoreCase(objB[15].toString()))
															.map(e -> (e[4]!=null?e[4].toString():e[3]!=null?e[3].toString():" " )+   e[1].toString() + ", " + e[2].toString())
															.findFirst()
														    .orElse("-")
															%>
															</td>
															<td class="width-30px"><%if(objB[9].toString().equalsIgnoreCase("3")||objB[9].toString().equalsIgnoreCase("5")){ %>
														      <%if(objB[7]!=null){ %>   <%=sdf.format(objB[7]) %> <%}else{ %><%=objB[8] %> <%} %>
														         <%}else{ %>
														         <%=objB[8] %>
															 <%} %></td>
															  <td align="center"><%=objB[6] %></td>
															<td>
															<%if(!objB[5].toString().equalsIgnoreCase("0")){ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar progress-bar-striped
															<%if(objB[9].toString().equalsIgnoreCase("2")){ %>
															 bg-success
															<%} else if(objB[9].toString().equalsIgnoreCase("3")){ %>
															  bg-info
															<%} else if(objB[9].toString().equalsIgnoreCase("4")){ %>
															  bg-danger
															<%} else if(objB[9].toString().equalsIgnoreCase("5")){ %>
															  bg-warning
															<%}  %>
															" role="progressbar" style=" width: <%=objB[5] %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
															<%=objB[5] %>
															</div> 
															</div> <%}else{ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Not Started
															</div>
															</div> <%} %>
															</td>
															<td>
														 	                                                   <%if("A".equalsIgnoreCase(LoginType) || projectDirector.equals(empId) || Long.parseLong(objB[13].toString())==(empId)) { %>
	                                                         	
	                                                         
			                                                        <div style="display: flex; justify-content: center;">
			                                                         <div style="display: flex;width:80%">
			                                                        5 <input  type="checkbox" <%if(objB[19].toString().equalsIgnoreCase("Y")){ %>checked<%} %> class="form-control" value="<%=objB[0].toString()+"/"+objB[19].toString()+"/point5"%>" onchange="updateBpPoints(this)">
			                                                        6.a <input type="checkbox" <%if(objB[20].toString().equalsIgnoreCase("Y")){ %>checked<%} %> class="form-control" value="<%=objB[0].toString()+"/"+objB[20].toString()+"/point6"%>" onchange="updateBpPoints(this)">
			                                                         9<input type="checkbox" <%if(objB[21].toString().equalsIgnoreCase("Y")){ %>checked<%} %> class="form-control" value="<%=objB[0].toString()+"/"+objB[21].toString()+"/point9"%>" onchange="updateBpPoints(this)">
			                                                         </div>
			                                                         </div>
			                                                         
	                                                         
	                                                         <%}%>	</td>
                                                         </tr>
                                                         <% int countC=1;
														 	if(MilestoneC!=null&&MilestoneC.size()>0){
															for(Object[] objC: MilestoneC){
																
																//check if empList contains first OIC of C level 
																if(!empList.contains(objC[13].toString() )){
																empList.add(objC[13].toString());
																}
																//check if empList contains first 2ndIC of C level 
																if(!empList.contains(objC[15].toString() )){
																	empList.add(objC[15].toString());
																	}
													         List<Object[]> MilestoneD=(List<Object[]>)request.getAttribute(count+"MilestoneActivityD"+countA+countB+countC);
																%>
														<tr class="collapse row_<%=objB[0] %> trclass<%=obj[0]%> trclass<%=objA[0]%> trclass<%=objB[0]%>" >
															<td style="width:2% !important; " class="center"> </td>
															<td class="center">
															<%if(MilestoneD!=null && MilestoneD.size()>0) {%>
															<span class="clickable" data-toggle="collapse" id="row_<%=objC[0] %>" data-target=".row_<%=objC[0]  %>">
																	<button class="btn btn-sm btn-success" id="btn<%=objC[0]  %>"  onclick="ChangeButton('<%=objC[0]  %>')">
																		<i class="fa fa-plus"  id="fa<%=objC[0] %>"></i> 
																	</button>
																</span>
																<%}else{ %>
<%-- 																<button type="button"  class="btn" onclick="supersedingMilestone('<%=objC[0] %>','<%=objC[4] %>', 'M<%=obj[5]%>-A<%=countA%>-B<%=countB%>-C<%=countC%>'  )"> <i class="fa fa-info" aria-hidden="true" style="color: #055C9D"></i></button>
 --%>																<%} %>
															</td>
															<td style="text-align: left;width: 5%;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C-<%=countC%></td>
															<%-- <td class="width-30px"><%=obj[1]%></td> --%>
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;cursor: pointer;"
															 onclick="showMilestoneProgress('<%=obj[0]%>', '<%=objC[0]%>', '<%=ProjectId%>', 'C')">
															<%=objC[4] %>
															</td>
															
															<td class="width-30px"><%=sdf.format(objC[2])%></td>
															<td style="width:8% !important; "><%=sdf.format(objC[3])%></td>
															<td><%=objC[14]%>
															<br>
															
															<%= EmployeeList.stream()
															.filter(e->e[0].toString().equalsIgnoreCase(objC[15].toString()))
															.map(e -> (e[4]!=null?e[4].toString():e[3]!=null?e[3].toString():" " )+   e[1].toString() + ", " + e[2].toString())
															.findFirst()
														    .orElse("-")
															%>
															</td>
															<td class="width-30px"><%if(objC[9].toString().equalsIgnoreCase("3")||objC[9].toString().equalsIgnoreCase("5")){ %>
														     <%if(objC[7]!=null){ %>   <%=sdf.format(objC[7]) %> <%}else{ %><%=objC[8] %> <%} %>
														         <%}else{ %>
														         <%=objC[8] %>
															 <%} %></td>	
															  <td align="center"><%=objC[6] %></td>
															<td>
															<%if(!objC[5].toString().equalsIgnoreCase("0")){ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
																<div class="progress-bar progress-bar-striped
																	<%if(objC[9].toString().equalsIgnoreCase("2")){ %>
																	 bg-success
																	<%} else if(objC[9].toString().equalsIgnoreCase("3")){ %>
																	  bg-info
																	<%} else if(objC[9].toString().equalsIgnoreCase("4")){ %>
																	  bg-danger
																	<%} else if(objC[9].toString().equalsIgnoreCase("5")){ %>
																	  bg-warning
																	<%}  %>
																	" role="progressbar" style=" width: <%=objC[5] %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
																	<%=objC[5] %>
																</div> 
															</div> <%}else{ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Not Started
															</div>
															</div> <%} %>
															</td>
															<td>
														                                                   <%if("A".equalsIgnoreCase(LoginType) || projectDirector.equals(empId) || Long.parseLong(objC[13].toString())==(empId)) { %>
                                                         		
                                                         
			                                                    	<div style="display: flex; justify-content: center;">
			                                                         <div style="display: flex;width:80%">
			                                                       5.  <input type="checkbox" <%if(objC[19].toString().equalsIgnoreCase("Y")){ %>checked<%} %> class="form-control" value="<%=objC[0].toString()+"/"+objC[19].toString()+"/point5"%>" onchange="updateBpPoints(this)">
			                                                       6.a  <input type="checkbox" <%if(objC[20].toString().equalsIgnoreCase("Y")){ %>checked<%} %> class="form-control" value="<%=objC[0].toString()+"/"+objC[20].toString()+"/point6"%>" onchange="updateBpPoints(this)">
			                                                        9. <input type="checkbox" <%if(objC[21].toString().equalsIgnoreCase("Y")){ %>checked<%} %> class="form-control" value="<%=objC[0].toString()+"/"+objC[21].toString()+"/point9"%>" onchange="updateBpPoints(this)">
			                                                        </div> </div>
                                                         
                                                         
                                                         		
                                                         	<%} %></td>
                                                         </tr>
                                                         <% int countD=1;
														 	if(MilestoneD!=null&&MilestoneD.size()>0){
															for(Object[] objD: MilestoneD){
																
																//check if empList contains first OIC of D level 
																if(!empList.contains(objD[13].toString() )){
																empList.add(objD[13].toString());
																}
																//check if empList contains first 2ndIC of D level 
																if(!empList.contains(objD[15].toString() )){
																	empList.add(objD[15].toString());
																	}
	                                                            List<Object[]> MilestoneE=(List<Object[]>)request.getAttribute(count+"MilestoneActivityE"+countA+countB+countC+countD);
	
																%>
														<tr class="collapse row_<%=objC[0] %> trclass<%=obj[0]%> trclass<%=objA[0]%> trclass<%=objB[0]%> trclass<%=objC[0]%>" >
															<td style="width:2% !important; " class="center"> </td>
															<td class="center">
																<%if(MilestoneE!=null && MilestoneE.size()>0) {%>
															<span class="clickable" data-toggle="collapse" id="row_<%=objD[0] %>" data-target=".row_<%=objD[0]  %>">
																	<button class="btn btn-sm btn-success" id="btn<%=objD[0]  %>"  onclick="ChangeButton('<%=objD[0]  %>')">
																		<i class="fa fa-plus"  id="fa<%=objD[0] %>"></i> 
																	</button>
																</span>
																<%}else{ %>
<%-- 																<button type="button"  class="btn" onclick="supersedingMilestone('<%=objD[0] %>','<%=objD[4] %>', 'M<%=obj[5]%>-A<%=countA%>-B<%=countB%>-C<%=countC%>-D<%=countD%>'  )"> <i class="fa fa-info" aria-hidden="true" style="color: #055C9D"></i></button>
 --%>																<%} %>
															
															</td>
															<td style="text-align: left;width: 5%;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D-<%=countD%></td>
															<%-- <td class="width-30px"><%=obj[1]%></td> --%>
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;cursor: pointer;"
															 onclick="showMilestoneProgress('<%=obj[0]%>', '<%=objD[0]%>', '<%=ProjectId%>', 'D')">
															 <%=objD[4] %>
															 </td>
															
															<td class="width-30px"><%=sdf.format(objB[2])%></td>
															<td style="width:8% !important; "><%=sdf.format(objB[3])%></td>
															<td><%=objD[14]%>
															<br>
															<%= EmployeeList.stream()
															.filter(e->e[0].toString().equalsIgnoreCase(objD[15].toString()))
															.map(e -> (e[4]!=null?e[4].toString():e[3]!=null?e[3].toString():" " )+   e[1].toString() + ", " + e[2].toString())
															.findFirst()
														    .orElse("-")
															%>
															
															</td>
															<td class="width-30px"><%if(objD[9].toString().equalsIgnoreCase("3")||objD[9].toString().equalsIgnoreCase("5")){ %>
														      <%if(objD[7]!=null){ %>   <%=sdf.format(objD[7]) %> <%}else{ %><%=objD[8] %> <%} %>
														         <%}else{ %>
														         <%=objD[8] %>
															 <%} %></td>
															  <td align="center"><%=objD[6] %></td>
															<td>
															<%if(!objD[5].toString().equalsIgnoreCase("0")){ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar progress-bar-striped
															<%if(objD[9].toString().equalsIgnoreCase("2")){ %>
															 bg-success
															<%} else if(objD[9].toString().equalsIgnoreCase("3")){ %>
															  bg-info
															<%} else if(objD[9].toString().equalsIgnoreCase("4")){ %>
															  bg-danger
															<%} else if(objD[9].toString().equalsIgnoreCase("5")){ %>
															  bg-warning
															<%}  %>
															" role="progressbar" style=" width: <%=objD[5] %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
															<%=objD[5] %>
															</div> 
															</div> <%}else{ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Not Started
															</div>
															</div> <%} %>
															</td>
															<td>
													                                                   <%if("A".equalsIgnoreCase(LoginType) || projectDirector.equals(empId) || Long.parseLong(objD[13].toString())==(empId)) { %>											
                                                         		
			                                                     <div style="display: flex; justify-content: center;">
			                                                         <div style="display: flex;width:80%">
			                                                        5. <input type="checkbox" <%if(objD[19].toString().equalsIgnoreCase("Y")){ %>checked<%} %> class="form-control" value="<%=objD[0].toString()+"/"+objD[19].toString()+"/point5"%>" onchange="updateBpPoints(this)">
			                                                        6.a <input type="checkbox" <%if(objD[20].toString().equalsIgnoreCase("Y")){ %>checked<%} %> class="form-control" value="<%=objD[0].toString()+"/"+objD[20].toString()+"/point6"%>" onchange="updateBpPoints(this)">
			                                                        9. <input type="checkbox" <%if(objD[21].toString().equalsIgnoreCase("Y")){ %>checked<%} %> class="form-control" value="<%=objD[0].toString()+"/"+objD[21].toString()+"/point9"%>" onchange="updateBpPoints(this)">
			                                                      </div>   </div>
                                                         
                                                         
                                                         		
                                                         	<%} %></td>	
                                                         </tr>
                                                         <% int countE=1;
														 	if(MilestoneE!=null&&MilestoneE.size()>0){
															for(Object[] objE: MilestoneE){
																//check if empList contains first OIC of E level 
																if(!empList.contains(objE[13].toString() )){
																empList.add(objE[13].toString());
																}
																//check if empList contains first 2ndIC of A level 
																if(!empList.contains(objE[15].toString() )){
																	empList.add(objE[15].toString());
																	}
																
																%>
														<tr class="collapse row_<%=objD[0] %> trclass<%=obj[0]%> trclass<%=objA[0]%> trclass<%=objB[0]%> trclass<%=objC[0]%> trclass<%=objD[0]%>"  style="" >
															<td style="width:2% !important; " class="center"> </td>
															<td class="center">
<%-- 									         				<button type="button"  class="btn" onclick="supersedingMilestone('<%=objE[0] %>','<%=objE[4] %>', 'M<%=obj[5]%>-A<%=countA%>-B<%=countB%>-C<%=countC%>-D<%=countD%>-E<%=countE%>'  )"> <i class="fa fa-info" aria-hidden="true" style="color: #055C9D"></i></button>
 --%>															</td>
															<td style="text-align: left;width: 5%;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;E-<%=countE%></td>
															<%-- <td class="width-30px"><%=obj[1]%></td> --%>
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;cursor: pointer;"
															onclick="showMilestoneProgress('<%=obj[0]%>', '<%=objE[0]%>', '<%=ProjectId%>', 'E')">
															<%=objE[4] %>
															</td>
															
															<td class="width-30px"><%=sdf.format(objE[2])%></td>
															<td style="width:8% !important; "><%=sdf.format(objE[3])%></td>
															<td><%=objE[14]%>
															<br>
															<%= EmployeeList.stream()
															.filter(e->e[0].toString().equalsIgnoreCase(objE[15].toString()))
															.map(e -> (e[4]!=null?e[4].toString():e[3]!=null?e[3].toString():" " )+   e[1].toString() + ", " + e[2].toString())
															.findFirst()
														    .orElse("-")
															%>
															
															</td>
															<td class="width-30px"><%if(objE[9].toString().equalsIgnoreCase("3")||objE[9].toString().equalsIgnoreCase("5")){ %>
														     <%if(objE[7]!=null){ %>   <%=sdf.format(objE[7]) %> <%}else{ %><%=objE[8] %> <%} %>
														         <%}else{ %>
														         <%=objE[8] %>
															 <%} %></td>	
															  <td align="center"><%=objE[6] %></td>
															<td>
															<%if(!objE[5].toString().equalsIgnoreCase("0")){ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar progress-bar-striped
															<%if(objC[9].toString().equalsIgnoreCase("2")){ %>
															 bg-success
															<%} else if(objE[9].toString().equalsIgnoreCase("3")){ %>
															  bg-info
															<%} else if(objE[9].toString().equalsIgnoreCase("4")){ %>
															  bg-danger
															<%} else if(objE[9].toString().equalsIgnoreCase("5")){ %>
															  bg-warning
															<%}  %>
															" role="progressbar" style=" width: <%=objE[5] %>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
															<%=objE[5] %>
															</div> 
															</div> <%}else{ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Not Started
															</div>
															</div> <%} %>
															</td>
															
															      <td>                                             <%if("A".equalsIgnoreCase(LoginType) || projectDirector.equals(empId) || Long.parseLong(objE[13].toString())==(empId)) { %>
                                                         		
			                                                         <div style="display: flex;justify-content: center;">
			                                                         <div style="display: flex;width:80%;">
			                                                        5. <input type="checkbox" <%if(objE[19].toString().equalsIgnoreCase("Y")){ %>checked<%} %> class="form-control" value="<%=objE[0].toString()+"/"+objE[19].toString()+"/point5"%>" onchange="updateBpPoints(this)">
			                                                        6.a <input type="checkbox" <%if(objE[20].toString().equalsIgnoreCase("Y")){ %>checked<%} %> class="form-control" value="<%=objE[0].toString()+"/"+objE[20].toString()+"/point6"%>" onchange="updateBpPoints(this)">
			                                                        9 <input type="checkbox" <%if(objE[21].toString().equalsIgnoreCase("Y")){ %>checked<%} %> class="form-control" value="<%=objE[0].toString()+"/"+objE[21].toString()+"/point9"%>" onchange="updateBpPoints(this)">
			                                                       </div>
			                                                         </div>
                                                         
                           
                                                         	<%} %>  
                                                                                    		</td>
                                                         </tr>
                                                      
												<% countE++;} }%>
												<% countD++;} }%>
												<% countC++;} }%>
												<% countB++;} }%>
												<% countA++;} }else{%>
												<tr class="collapse row<%=count %>">
													<td colspan="11" style="text-align: center" class="center">No Sub List Found</td>
												</tr>
										       
												<%} %>
												<%
												if(!Arrays.asList(obj[obj.length-1].toString(),obj[obj.length-3].toString()).contains(empId+"")){
												%>
												<script>
												 var empListJs = [<%= empList.stream().map(e -> "\"" + e + "\"").collect(java.util.stream.Collectors.joining(",")) %>];
												 var empId = '<%=empId %>';
												 var loginType = '<%=LoginType %>';
												 var projectDirector = '<%=projectDirector %>';
												 var mileId = '<%=obj[0].toString() %>';
												 
												<%--  var progress = '<%=obj[12]%>'; --%>
												    console.log(empListJs+ "---");
												    console.log(empId+ "---"+typeof empId);
												    console.log(empListJs.includes(empId))
												    console.log(empId===projectDirector)
												    console.log(loginType==='A')
												    console.log(mileId)
												    
												    
												   if( empListJs.includes(empId) || empId===projectDirector || loginType==='A') {
													   console.log("Any of the codition satisfied")
												   }else{
													     
													   console.log("No codition satisfied")
													   $('#detailsAddbtn'+mileId).hide();
													   $('#EditWeightage'+mileId).hide();
													   $('#basLineBtn'+mileId).hide();
													   $('#assignBtn'+mileId).hide();
													   $('#docbtn'+mileId).hide();
													   $('#spanMessage'+mileId).show();
													
												   }
												</script>
												<%} %>
												<% count++; } %>
												
												
													<tr>
														<td></td>
														<td colspan=1 style="display: flex;justify-content: center;align-items: center">
															<form action="MilestoneActivityMilNoUpdate.htm" method="POST" name="slnoupdateform" id="slnoupdateform">
							              						<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
							              						<input type="hidden" name="projectId" value="<%=ProjectId%>">
							              						<button class="btn btn-sm edit" onclick="return slnocheck();">UPDATE</button>
						              						</form>
					              						</td>
														<td colspan="9"></td>
													</tr>
												<% }else{%>
												<tr >
													<td colspan="11" style="text-align: center" class="center">No List Found</td>
												</tr>
												<%} %>
												</tbody>
												</table>
												</div>
							


											</div>
							
						</div>

					</div>
		
				</div>

	
			</div>


		<br>

	<div class="row m-2">
		<div class="col-md-12"
			style="text-align: center; width: 140px; height: 30px;">
			<b>Milestone Flow </b>
		</div>
	</div>
	
	<div class="row m-2"
		style="text-align: center; padding-top: 10px; padding-bottom: 15px;">

		<table align="center" style="border-spacing: 0 20px;">
			<tr>
				
				
				<td class="trup" style="background:#c4ced3; width: 230px; height: 20px;">
					<b class="text-primary">Add Milestone Activity </b>
				</td>
				<td class="trup" style="width: 10px; height: 20px;"></td>
				<td ><i class="fa fa-long-arrow-right "aria-hidden="true"></i></td>
				<td rowspan="2" class="trup" style="width: 30px; height: 20px;"></td>
				
				<td class="trup" style="background:#c4ced3; width: 230px; height: 20px;">
					<b class="text-primary">Add Sub Milestone Activity </b>
				</td>
				<td class="trup" style="width: 10px; height: 20px;"></td>
				<td ><i class="fa fa-long-arrow-right "aria-hidden="true"></i></td>
				<td rowspan="2" class="trup" style="width: 30px; height: 20px;"></td>
				
				<td class="trup" style="background:#c4ced3; width: 230px; height: 20px;">
					<b class="text-primary">Assign Weightage </b>
				</td>
				<td class="trup" style="width: 10px; height: 20px;"></td>
				<td ><i class="fa fa-long-arrow-right "aria-hidden="true"></i></td>
				<td rowspan="2" class="trup" style="width: 30px; height: 20px;"></td>
				
				<td class="trup" style="background:#c4ced3; width: 230px; height: 20px;">
					<b class="text-primary">Assign Milestone Activity </b>
				</td>
				<td class="trup" style="width: 10px; height: 20px;"></td>
				<td ><i class="fa fa-long-arrow-right "aria-hidden="true"></i></td>
				<td rowspan="2" class="trup" style="width: 30px; height: 20px;"></td>
				
				<td class="trup" style="background:#c4ced3; width: 230px; height: 20px;">
					<b class="text-primary">Set Baseline </b>
				</td>
				<td class="trup" style="width: 10px; height: 20px;"></td>
				<td ><i class="fa fa-long-arrow-right "aria-hidden="true"></i></td>
				<td rowspan="2" class="trup" style="width: 30px; height: 20px;"></td>
				
				<td class="trup" style="background:#c4ced3; width: 230px; height: 20px;">
					<b class="text-primary">Assignee</b>
				</td>
				<td class="trup" style="width: 10px; height: 20px;"></td>
				<td ><i class="fa fa-long-arrow-right "aria-hidden="true"></i></td>
				<td rowspan="2" class="trup" style="width: 30px; height: 20px;"></td>
				
				<td class="trup" style="background:#c4ced3; width: 230px; height: 20px;">
					<b class="text-primary"> Acknowledge Milestone Activity </b>
				</td>
				<td class="trup" style="width: 10px; height: 20px;"></td>
				<td ><i class="fa fa-long-arrow-right "aria-hidden="true"></i></td>
				<td rowspan="2" class="trup" style="width: 30px; height: 20px;"></td>
				
				<td class="trup" style="background:#c4ced3; width: 230px; height: 20px;">
					<b class="text-primary">Update progress</b>
				</td>
				
				
			

			</tr>
			
		</table>



	</div>
	<br> 
	<br>
	<br>

<div class="modal" id="MainDOCEditModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Edit Date of Completion</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" align="center">
        <form action="MainMilestoneDOCUpdate.htm" method="post">
        	<table style="width: 80%;">
        		<tr>
        			<th style="width: 40%;">Date of Completion : &nbsp; </th>
        			<td style="width: 60%;"><input type="text" class="form-control" name="DateOfCompletion" id="MainDOCDate" value="" readonly="readonly"></td>
        		</tr>
        		<tr>
        			<td colspan="2" style="text-align: center;">
        				<br>
        				<button type="button" class="btn btn-sm btn-danger" data-dismiss="modal"><b>Close</b></button>
        				<button class="btn btn-sm submit" onclick="return confirm('Are You Sure to Edit?');">SUBMIT</button>
        			</td>
        		</tr>
        	</table>
        	
        	<input type="hidden" id="MSMainid" name="MSMainid" value="" >
        	<input type="hidden" name="projectid" value="<%=ProjectId %>" >
        	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
        </form>
      </div>
     
    </div>
  </div>
</div>




	<!-- -------------------------------------------- Milestone Progess Modal -------------------------------------------- -->
	<div class="modal fade" id="milestoneProgressModal" tabindex="-1" role="dialog" aria-labelledby="milestoneProgressModal" aria-hidden="true">
  		<div class="modal-dialog modal-lg modal-dialog-jump" role="document">
    		<div class="modal-content" style="width:135%;margin-left:-20%;">
      			<div class="modal-header" id="ModalHeader" style="background: #055C9D ;color: white;">
			        <h5 class="modal-title" >Activity Updated Details</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true" class="text-light">&times;</span>
			        </button>
      			</div>
      			
      			<div class="modal-body">
     				<div class="row mb-2">
						<div class="col-md-12">
							<table class="table table-bordered" id="myTables" style="width: 100%;">
								<thead class="center" style="background: #055C9D ;color: white;">
									<tr>
										<th width="5%">SN</th>
										<th width="15%">As On Date</th>
										<th width="15%">Progress</th>
										<th width="25%">Remarks</th>
										<th width="5%">Action</th>
										<th width="30%">Progress By</th>
									</tr>
								</thead>
								<tbody id="milestoneprogesstbody">
								</tbody>
							</table>
						</div>      
     				</div>
      				
      			</div>
    		</div>
  		</div>
	</div>
	<!-- -------------------------------------------- Milestone Progress Modal End -------------------------------------------- -->


	<!-- -------------------------------------------- Milestone Status Remarks Modal -------------------------------------------- -->
	<div class="modal fade" id="milestoneStatusRemarksModal" tabindex="-1" role="dialog" aria-labelledby="milestoneStatusRemarksModal" aria-hidden="true">
  		<div class="modal-dialog modal-lg modal-dialog-jump" role="document">
    		<div class="modal-content" style="width:135%;margin-left:-20%;">
      			<div class="modal-header" id="ModalHeader" style="background: #055C9D ;color: white;">
			        <h5 class="modal-title" >Status Remarks</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true" class="text-light">&times;</span>
			        </button>
      			</div>
      			
      			<div class="modal-body">
      				<div class="row">
      					<div class="col-md-12">
      						<label class="form-label">Financial Outlay :</label> 
      						<span id="financialOutlay"></span>
						</div>  
      				</div>
     				<div class="row mb-2">
						<div class="col-md-12">
							<label class="form-label">Remarks : </label>  
							<div id="statusRemarks"></div>
						</div>      
     				</div>
      				
      			</div>
    		</div>
  		</div>
	</div>
	<!-- -------------------------------------------- Milestone Status Remarks Modal End -------------------------------------------- -->

<div class="modal fade" id="largeModal" tabindex="-1" role="dialog" aria-labelledby="largeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document"> <!-- Use modal-lg here -->
    <div class="modal-content" style=" width: 150%;margin-left: -22%;">
      <div class="modal-header">
        <h5 class="modal-title" id="modalheader">Choose Milestone for Linking & Superseding</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
					<div class="row">
						<div class="col-md-3">
							<label class="control-label">Project Name :</label>
						</div>
						<div class="col-md-5" style="">
							<select class="form-control selectdee" id="projectIds"
								required="required" style="width: 100%" onchange="getProjectMilestones()">
								<option  selected value="0">Choose...</option>
								<%
								for (Object[] obj : ProjectList) {
								if(!ProjectId.equalsIgnoreCase(obj[0].toString())){
									//String projectshortName = (obj[17] != null) ? " ( " + obj[17].toString() + " ) " : "";
								%>
								<option value="<%=obj[0]%>"><%=obj[4] %></option>
								<%
								}}
								%>
							</select>
						</div>
					</div>
					
						<div class="row mt-4">
						<div class="col-md-3">
							<label class="control-label">Milestone List:</label>
						</div>
						<div class="col-md-8" style="">
							<select class="form-control selectdee" id="mileIdLink"
								required="required" style="width: 100%" >
								
							
								
							</select>
						</div>
					</div>
					
						<div class="row mt-4" id="IsMasterDiv" style="display: none;">
						<div class="col-md-6">
							<label class="control-label" id="masterDataLabel">Is Master Data:</label>
						</div>
						<div class="col-md-1" id="IsMasterDivDetails" style="">
							<input type="radio"  name="IsMaster" value="Y" checked="checked">&nbsp;&nbsp;YES
						</div>
						<div class="col-md-1" id="IsMasterDivDetails" style="">
							<input type="radio"  name="IsMaster" value="N"> &nbsp;&nbsp;NO
						</div>
					</div>
					
				<div align="center" class="mt-4">
				        <button class="btn btn-sm submit" onclick="saveData()">SUBMIT</button>
				        <input type="hidden" id="milesMainId"> 
				      </div>
				</div>
     
    </div>
  </div>
</div>
	
<script type="text/javascript">
function MainDOCEditModal(mainid, DOC)
{
	$('#MSMainid').val(mainid);			
	$('#MainDOCDate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		"startDate" : new Date(DOC),
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
	$('#MainDOCEditModal').modal('toggle');
	
}
															 
</script>  

  
<script>


$(document).ready(function() {
	   $('#ProjectId').on('change', function() {
	     $('#submit').click();

	   });
	});
	
	 
function ChangeButton(id) {
    // Show loading using SweetAlert2
    Swal.fire({
       
        allowOutsideClick: false,
        allowEscapeKey: false,
        didOpen: () => {
            Swal.showLoading();
        }
    });

    // Give DOM time to update (for smoother animation), then process logic
    setTimeout(() => {
        if ($("#btn" + id).hasClass("btn btn-sm btn-success").toString() == 'true') {
            $("#btn" + id).removeClass("btn btn-sm btn-success").addClass("btn btn-sm btn-danger");
            $("#fa" + id).removeClass("fa fa-plus").addClass("fa fa-minus");
        } else {
            var targetRow = $(".trclass" + id);
            targetRow.collapse("hide");
            $("#btn" + id).removeClass("btn btn-sm btn-danger").addClass("btn btn-sm btn-success");
            $("#fa" + id).removeClass("fa fa-minus").addClass("fa fa-plus");
       
            if (targetRow && targetRow.length > 0) {
                targetRow.find("button.btn.btn-sm.btn-danger").each(function () {
                    $(this)
                        .removeClass("btn btn-sm btn-danger")
                        .addClass("btn btn-sm btn-success");

                    $(this).find("i.fa.fa-minus")
                        .removeClass("fa fa-minus")
                        .addClass("fa fa-plus");
                });
            }
        
        }

     

    
        Swal.close();  
    }, 300); // Small timeout to allow loading to render
}



</script>




<script>
	$('#DateCompletion').daterangepicker({
			"singleDatePicker" : true,
			"linkedCalendars" : false,
			"showCustomRangeLabel" : true,
			"minDate" : new Date(),
			"cancelClass" : "btn-default",
			showDropdowns : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});

	$('#DateCompletion2').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		"minDate" : new Date(),
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
	
	
	function updateBpPoints(ele){
		var a=ele.value;
		var value1=a.split("/")[0];
		var value2=a.split("/")[1];
		var value3=a.split("/")[2]
		
		$.ajax({
			type:'GET',
			url:'BriefingPointsUpdate.htm',
			datatype:'json',
			data:{
				ActivityId:value1,
				point:value3,
				status:value2,
			}
		});
		
		
		if(value2==="Y"){
		ele.value=value1+"/N/"+value3
		}else{
			ele.value=value1+"/Y/"+value3
		}
	}
	
	// Milestone No Check
	function slnocheck() {
		
		 var arr = document.getElementsByName("newslno");

		var arr1 = [];
		for (var i=0;i<arr.length;i++){
			arr1.push(arr[i].value);
		}		 
		 
	    let result = false;
	  
	    const s = new Set(arr1);
	    
	    if(arr.length !== s.size){
	       result = true;
	    }
	    if(result) {
	   		event.preventDefault();
	       	alert('Serial No contains duplicate Values');
	       	return false;
	    } else {
	   	 return confirm('Are You Sure to Update?');
	    }
	  }
	
	function showMilestoneProgress(MilestoneActivityId, ActivityId, ProjectId, ActivityType) {
		$('#milestoneProgressModal').modal('show');
		
		$.ajax({
			type : "GET",
			url : "MilestoneActivityProgressDetails.htm",	
			datatype : 'json',
			data : {
				MilestoneActivityId : MilestoneActivityId,				
				ActivityId : ActivityId,				
				ProjectId : ProjectId,				
				ActivityType : ActivityType,				
			},
			success : function(result) {
				var values = JSON.parse(result);
				
				var x ='';
				
				if(values.length>0){
					
					for(var i=0; i<values.length; i++) {
						x+= '<tr>';
						x+= '<td class="center">'+(i+1)+'.</td>';
						x+= '<td class="center">'+formatDate(values[i][2])+'</td>';
						x += '<td>';
					    x += '<div class="progress" style="background-color: #cdd0cb !important">';
					    x += '<div class="progress-bar progress-bar-striped" role="progressbar" style="width: ' + values[i][1] + '%;"';
					    x += ' aria-valuenow="' + values[i][1] + '" aria-valuemin="0" aria-valuemax="100">' + values[i][1] + '</div>';
					    x += '</div>';
					    x += '</td>';
						x+= '<td>'+values[i][3]+'</td>';
						x += '<td class="center">';
						if (values[i][4] && values[i][4].toString().length !== 0) {
					        x += '<div align="center">';
					        x += '<a href="ActivityAttachDownload.htm?ActivitySubId=' + values[i][0] + '" target="_blank">';
					        x += '<i class="fa fa-download"></i></a>';
					        x += '</div>';
					    } else {
					        x += '<div align="center">-</div>';
					    }
						x += '</td>';
						x+='<td>'+ values[i][5] +'</td>'
						x+= '</tr>';
					}
				}else{
					x = '<tr><td colspan="5" class="center">No Data Available</td></tr>';
				}
				
				$('#milestoneprogesstbody').html(x);
			}
		});
	}
	
	function formatDate(sqlDate) {
	    if (!sqlDate) {
	        return ""; // Handle null or undefined dates
	    }

	    let date = new Date(sqlDate);
	    let day = String(date.getDate()).padStart(2, '0');
	    let month = String(date.getMonth() + 1).padStart(2, '0'); // Months are 0-indexed
	    let year = date.getFullYear();

	    return day + '-' + month + '-' + year;
	}
	
	function showMilestoneStatusProgress(rowId) {
		$('#financialOutlay').text($('#financialOutlay_'+rowId).val());
		$('#statusRemarks').html($('#statusRemarks_'+rowId).val());
		$('#milestoneStatusRemarksModal').modal('show');
	}
	
	$(".deleteBtn").click(function(){
		
		var id = this.value;
		if(confirm('Kindly Note if you remove a milestone sub-milestones will also get removed.Are you sure to delete this Milestone?')){
			
			$.ajax({
				type:'GET',
				url:'MilestoneIsActive.htm',
				datatype:'json',
				data:{
					id:id,
				},
				success:function(result){
					var ajaxresult = JSON.parse(result);
					
					if(ajaxresult=='1'){
						alert('Milestone Deleted successfully!')
						window.location.reload()
					}else{
						alert('Milestone Delete unsuccessful!')
					}
				}
			})
		}else{
			
		}
		
		
		});
	
	
	
	function supersedingMilestone(a,b ,c){
		
		$('#largeModal').modal('show');
		$("#mileIdLink").html("<option disabled selected value=''>Choose...</option>");
		$("#modalheader").html(" Linking & Superseding for "+b+ " ( "+ c + " )" +    "<%=projectshortName %>"    );
		$('#projectIds').val('0').trigger('change');
		$('#IsMasterDiv').hide();
		$('#milesMainId').val(a);
	}
	
	
	function getProjectMilestones(){
		
		var projectid = $('#projectIds').val();
		
		
	
			$.ajax({
			type:'GET',
			url:'getProjectMilestones.htm',
			datatype:'json',
			data:{
				projectid:projectid,
			},
			success:function (result){
				var data = JSON.parse(result);
			
				var html = "<option disabled selected value=''>Choose...</option>";	
				for (var key in data) {
					  if (data.hasOwnProperty(key)) {
					    var val = data[key]; 
					/*  console.log(val[22]+"---"+val[24]+"---"+val[5]) */
					  if((val[22]+"")==="0" && (val[24]+"")==="0"){
						  if((val[5]+"")==="0"){
						html += "<option value='" + val[0] + "'>" + val[4] +"(" +key.split("/")[0] + ")"+ "</option>";
					  }}
					  }
					}
				$("#mileIdLink").html(html);
			
				
			}
		})
	}
	
	
	$('#mileIdLink').on('change', function () {
	    var selectedValue = $(this).val();                // Gets the value
	    var selectedText = $(this).find("option:selected").text(); // Gets the displayed text
	    console.log("Selected Value:", selectedValue);
	    console.log("Selected Text:", selectedText);
	    
	    $('#IsMasterDiv').show();
	    $('#masterDataLabel').html('Is '+selectedText +" master Data ?");
	});
	
	function saveData(){
		
		var mileIdLink = $('#mileIdLink').val();
		var milesMainId = $('#milesMainId').val();
		
		var selectedValue = $('input[name="IsMaster"]:checked').val();
		
		
		
			  if (!mileIdLink || mileIdLink.trim() === "") {
				  console.log("mileIdLink--"+mileIdLink)
    			Swal.fire({
       			 icon: 'error',
       			 title: 'Milestone Required',
       			 text: 'You need to choose a milestone to link. If no milestones are visible, it may be because all milestones for the selected project have already started progressing.',
   			 });
				  return;
}
       Swal.fire({
            title: 'Are you sure to upload?',
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: 'green',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes'
        }).then((result) => {
            if (result.isConfirmed) {
		$.ajax({
			
			type:'GET',
			url:'updateMilestonSuperSeding.htm',
			datatype:'json',
			data:{
				mileIdLink:mileIdLink,
				milesMainId:milesMainId,
				isMasterData:selectedValue
			},
			   success: function(response) {
	            	
	            	  Swal.fire({
			    	       	title: "Success",
			                text: "Milestone Linked Successfully",
			                icon: "success",
			                allowOutsideClick :false
			         		});
	            	 
	            	  $('.swal2-confirm').click(function (){
	      	                location.reload();
	      	        	})
	            },
	            error: function(xhr, status, error) {
	            	  Swal.fire({
	                      icon: 'error',
	                      title: 'Error',
	                      text: 'An error occurred while uploading the file'
	                  });
	                  console.log(xhr.responseText);
	             }
			
		})
            }
        });
		
	}
</script>  


</body>
</html>
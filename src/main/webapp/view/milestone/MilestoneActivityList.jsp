<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

 

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
    										String projectshortName=(obj[17]!=null)?" ( "+obj[17].toString()+" ) ":"";
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

														
																
					  <form class="  justify-content-end"  method="POST" action="MilestoneActivityAdd.htm">
					  		<%if(MilestoneList.size()>0){ %>
                               	<button  style="color: green;font: green;border : 1px solid #7F7C82" class="btn btn-sm" type="submit" name="sub" value="Accept" formaction="MilestoneExcelFile.htm"  formtarget="_blank">
									<i class="fa fa-file-excel-o" aria-hidden="true"></i>
				                </button> 
							<%} %>
                            	<input type="hidden" name="ProjectId"	value="<%=ProjectId %>" /> 
                             <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
                               <input type="submit"  value="Add Activity" class="btn btn-sm add" style="float: right;">
                     </form>
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
															<th>First OIC </th>
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
																<span class="clickable" data-toggle="collapse" id="row<%=count %>" data-target=".row<%=count %>">
																	<button class="btn btn-sm btn-success" id="btn<%=count %>"  onclick="ChangeButton('<%=count %>')">
																		<i class="fa fa-plus"  id="fa<%=count%>"></i> 
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
															<td  style="width:15% !important; "><%=obj[6]%></td>
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
															<%if("A".equalsIgnoreCase(LoginType) || projectDirector.equals(empId) || Long.parseLong(obj[17].toString())==(empId)) { %>
																<td  style="width:20% !important; text-align: center;">		
																	<form action="MilestoneActivityDetails.htm" method="POST" name="myfrm"  style="display: inline">
																		<%if(Integer.parseInt(obj[12].toString())<100){ %>
																			<button  class="editable-click" name="sub" value="B">  
																				<div class="cc-rockmenu">
															                      <div class="rolling">
															                        <figure class="rolling_icon"><img src="view/images/preview3.png"  ></figure>
															                        <span>Details</span>
															                      </div>
															                     </div> 
																			</button>
																		<%}else if(Integer.parseInt(obj[12].toString())==100){ %>
																			<button  class="editable-click" type="button" onclick="MainDOCEditModal(<%=obj[0]%>,'<%=obj[16]%>')">  
																				<div class="cc-rockmenu">
															                      <div class="rolling">
															                        <figure class="rolling_icon"><i class="fa fa-calendar-o" aria-hidden="true"></i></figure>
															                        <span>Date of Completion</span>
															                      </div>
															                     </div> 
																			</button>
																		<%} %>
																		  <%if("N".equalsIgnoreCase(obj[10].toString())){ %>
			                                                              <button  class="editable-click" name="sub" value="C" >
																			<div class="cc-rockmenu">
																			 <div class="rolling">	
														                        <figure class="rolling_icon"><img src="view/images/edit.png" ></figure>
														                        <span>Edit/Weightage</span>
														                      </div>
														                     </div>
														                  </button> 
			                                                             <button type="submit"  class="editable-click" name="sub" value="Assign"  formaction="M-A-Assign-OIC.htm" onclick="if('0'=='<%=obj[13].toString() %>'){alert('Please add Weightage first then you able to assign.');return false; }else{ return confirm('Are You Sure To Assign ?') }"   >
																			<div class="cc-rockmenu">
																			 <div class="rolling">	
														                        <figure class="rolling_icon"><img src="view/images/assign.jpg" ></figure>
														                        <span>Assign</span>
														                      </div>
														                     </div>
														                  </button>  
														                  
			                                                              <%}else if("Y".equalsIgnoreCase(obj[10].toString())){ %>
			                                                               <button  class="editable-click" name="sub" value="C" >
																			<div class="cc-rockmenu">
																			 <div class="rolling">	
														                        <figure class="rolling_icon"><img src="view/images/clipboard.png" ></figure>
														                        <span>Base Line </span>
														                      </div>
														                     </div>
														                  </button>    
			                                                               <%} %>
			                                                            <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
																	    <input type="hidden" name="MilestoneActivityId" value="<%=obj[0]%>"/>
																	    <input type="hidden" name="projectid" value="<%=ProjectId%>"/>
																	    <input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
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
																</td>
															<%} else {%>
																<td class="center"> <span class="btn btn-sm btn-info">Access Denied</span> </td>
															<%} %>	
														</tr>
														 <tr class="collapse row<%=count %>" style="font-weight: bold;">
                                                         <td></td>
                                                         <td></td>
                                                         <td>Sub</td>
                                                         <td>Activity</td>
                                                         <td>Start Date</td>
                                                         <td>End Date</td>
                                                         <td>First IOC</td>
                                                         <td>Date Of Completion</td>
                                                         <td>Sub Weightage</td>
                                                         <td>Sub Progress</td>
                                                         <%if(actionAllowedFor.contains(LoginType)) {%>
                                                         	<td>Shown in display of Briefing Paper and MOM</td>
                                                         <%} %>
                                                         </tr>
                                                         <% int countA=1;
                                                            List<Object[]> MilestoneA=(List<Object[]>)request.getAttribute(count+"MilestoneActivityA");
														 	if(MilestoneA!=null&&MilestoneA.size()>0){
															for(Object[] objA: MilestoneA){
	                                                            List<Object[]> MilestoneB=(List<Object[]>)request.getAttribute(count+"MilestoneActivityB"+countA);
	
																%>
														<tr class="collapse row<%=count %>" >
															<td style="width:2% !important; " class="center"> </td>
															<td></td>
															<td style="text-align: left;width: 5%;"> A-<%=countA%></td>
															<%-- <td class="width-30px"><%=obj[1]%></td> --%>
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;cursor: pointer;"
															 onclick="showMilestoneProgress('<%=obj[0]%>', '<%=objA[0]%>', '<%=ProjectId%>', 'A')">
															<%=objA[4] %>
															</td>
															
															<td class="width-30px"><%=sdf.format(objA[2])%></td>
															<td style="width:8% !important; "><%=sdf.format(objA[3])%></td>
															<td><%=objA[14]%></td>
															
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
															<%if(actionAllowedFor.contains(LoginType)) {%>
		                                                         <td>
			                                                         <div style="display: flex; justify-content: center;">
			                                                         <div style="display: flex;width:80%">
			                                                		5<input type="checkbox" <%if(objA[19].toString().equalsIgnoreCase("Y")){ %>checked<%} %> class="form-control point5"  value="<%=objA[0].toString()+"/"+objA[19].toString()+"/point5"%>" onchange="updateBpPoints(this)">
			                                                        6.a<input type="checkbox" <%if(objA[20].toString().equalsIgnoreCase("Y")){ %>checked<%} %> class="form-control point6"  value="<%=objA[0].toString()+"/"+objA[20].toString()+"/point6"%>" onchange="updateBpPoints(this)">
			                                                        9<input type="checkbox" <%if(objA[21].toString().equalsIgnoreCase("Y")){ %>checked<%} %> class="form-control point9"  value="<%=objA[0].toString()+"/"+objA[21].toString()+"/point9"%>" onchange="updateBpPoints(this)">
			                                                         </div>
			                                                         </div>
		                                                         </td>
	                                                         <%} %>
                                                         </tr>
                                                         <% int countB=1;
														 	if(MilestoneB!=null&&MilestoneB.size()>0){
															for(Object[] objB: MilestoneB){
	                                                            List<Object[]> MilestoneC=(List<Object[]>)request.getAttribute(count+"MilestoneActivityC"+countA+countB);
	
																%>
														<tr class="collapse row<%=count %>" >
															<td style="width:2% !important; " class="center"> </td>
															<td></td>
															<td style="text-align: left;width: 5%;"> &nbsp;&nbsp;&nbsp;B-<%=countB%></td>
															<%-- <td class="width-30px"><%=obj[1]%></td> --%>
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;cursor: pointer;"
															 onclick="showMilestoneProgress('<%=obj[0]%>', '<%=objB[0]%>', '<%=ProjectId%>', 'B')">
																<%=objB[4] %>
															</td>
															
															<td class="width-30px"><%=sdf.format(objB[2])%></td>
															<td style="width:8% !important; "><%=sdf.format(objB[3])%></td>
															<td><%=objB[14]%></td>
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
															
														 	<%if(actionAllowedFor.contains(LoginType)) {%>												
	                                                         	<td>
	                                                         
			                                                        <div style="display: flex; justify-content: center;">
			                                                         <div style="display: flex;width:80%">
			                                                        5 <input  type="checkbox" <%if(objB[19].toString().equalsIgnoreCase("Y")){ %>checked<%} %> class="form-control" value="<%=objB[0].toString()+"/"+objB[19].toString()+"/point5"%>" onchange="updateBpPoints(this)">
			                                                        6.a <input type="checkbox" <%if(objB[20].toString().equalsIgnoreCase("Y")){ %>checked<%} %> class="form-control" value="<%=objB[0].toString()+"/"+objB[20].toString()+"/point6"%>" onchange="updateBpPoints(this)">
			                                                         9<input type="checkbox" <%if(objB[21].toString().equalsIgnoreCase("Y")){ %>checked<%} %> class="form-control" value="<%=objB[0].toString()+"/"+objB[21].toString()+"/point9"%>" onchange="updateBpPoints(this)">
			                                                         </div>
			                                                         </div>
			                                                         
	                                                         	</td>
	                                                         <%}%>
                                                         </tr>
                                                         <% int countC=1;
														 	if(MilestoneC!=null&&MilestoneC.size()>0){
															for(Object[] objC: MilestoneC){
													         List<Object[]> MilestoneD=(List<Object[]>)request.getAttribute(count+"MilestoneActivityD"+countA+countB+countC);
																%>
														<tr class="collapse row<%=count %>">
															<td style="width:2% !important; " class="center"> </td>
															<td></td>
															<td style="text-align: left;width: 5%;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C-<%=countC%></td>
															<%-- <td class="width-30px"><%=obj[1]%></td> --%>
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;cursor: pointer;"
															 onclick="showMilestoneProgress('<%=obj[0]%>', '<%=objC[0]%>', '<%=ProjectId%>', 'C')">
															<%=objC[4] %>
															</td>
															
															<td class="width-30px"><%=sdf.format(objC[2])%></td>
															<td style="width:8% !important; "><%=sdf.format(objC[3])%></td>
															<td><%=objC[14]%></td>
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
															
															<%if(actionAllowedFor.contains(LoginType)) {%>
                                                         		<td>
                                                         
			                                                    	<div style="display: flex; justify-content: center;">
			                                                         <div style="display: flex;width:80%">
			                                                       5.  <input type="checkbox" <%if(objC[19].toString().equalsIgnoreCase("Y")){ %>checked<%} %> class="form-control" value="<%=objC[0].toString()+"/"+objC[19].toString()+"/point5"%>" onchange="updateBpPoints(this)">
			                                                       6.a  <input type="checkbox" <%if(objC[20].toString().equalsIgnoreCase("Y")){ %>checked<%} %> class="form-control" value="<%=objC[0].toString()+"/"+objC[20].toString()+"/point6"%>" onchange="updateBpPoints(this)">
			                                                        9. <input type="checkbox" <%if(objC[21].toString().equalsIgnoreCase("Y")){ %>checked<%} %> class="form-control" value="<%=objC[0].toString()+"/"+objC[21].toString()+"/point9"%>" onchange="updateBpPoints(this)">
			                                                        </div> </div>
                                                         
                                                         
                                                         		</td>
                                                         	<%} %>
                                                         </tr>
                                                         <% int countD=1;
														 	if(MilestoneD!=null&&MilestoneD.size()>0){
															for(Object[] objD: MilestoneD){
	                                                            List<Object[]> MilestoneE=(List<Object[]>)request.getAttribute(count+"MilestoneActivityE"+countA+countB+countC+countD);
	
																%>
														<tr class="collapse row<%=count %>" >
															<td style="width:2% !important; " class="center"> </td>
															<td></td>
															<td style="text-align: left;width: 5%;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D-<%=countD%></td>
															<%-- <td class="width-30px"><%=obj[1]%></td> --%>
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;cursor: pointer;"
															 onclick="showMilestoneProgress('<%=obj[0]%>', '<%=objD[0]%>', '<%=ProjectId%>', 'D')">
															 <%=objD[4] %>
															 </td>
															
															<td class="width-30px"><%=sdf.format(objB[2])%></td>
															<td style="width:8% !important; "><%=sdf.format(objB[3])%></td>
															<td><%=objD[14]%></td>
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
															
														 	<%if(actionAllowedFor.contains(LoginType)) {%>												
                                                         		<td>
			                                                     <div style="display: flex; justify-content: center;">
			                                                         <div style="display: flex;width:80%">
			                                                        5. <input type="checkbox" <%if(objD[19].toString().equalsIgnoreCase("Y")){ %>checked<%} %> class="form-control" value="<%=objD[0].toString()+"/"+objD[19].toString()+"/point5"%>" onchange="updateBpPoints(this)">
			                                                        6.a <input type="checkbox" <%if(objD[20].toString().equalsIgnoreCase("Y")){ %>checked<%} %> class="form-control" value="<%=objD[0].toString()+"/"+objD[20].toString()+"/point6"%>" onchange="updateBpPoints(this)">
			                                                        9. <input type="checkbox" <%if(objD[21].toString().equalsIgnoreCase("Y")){ %>checked<%} %> class="form-control" value="<%=objD[0].toString()+"/"+objD[21].toString()+"/point9"%>" onchange="updateBpPoints(this)">
			                                                      </div>   </div>
                                                         
                                                         
                                                         		</td>
                                                         	<%} %>	
                                                         </tr>
                                                         <% int countE=1;
														 	if(MilestoneE!=null&&MilestoneE.size()>0){
															for(Object[] objE: MilestoneE){ %>
														<tr class="collapse row<%=count %>"  style="">
															<td style="width:2% !important; " class="center"> </td>
															<td></td>
															<td style="text-align: left;width: 5%;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;E-<%=countE%></td>
															<%-- <td class="width-30px"><%=obj[1]%></td> --%>
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;cursor: pointer;"
															onclick="showMilestoneProgress('<%=obj[0]%>', '<%=objE[0]%>', '<%=ProjectId%>', 'E')">
															<%=objE[4] %>
															</td>
															
															<td class="width-30px"><%=sdf.format(objE[2])%></td>
															<td style="width:8% !important; "><%=sdf.format(objE[3])%></td>
															<td><%=objE[14]%></td>
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
															
															<%if(actionAllowedFor.contains(LoginType)) {%>
                                                         		<td>
			                                                         <div style="display: flex;justify-content: center;">
			                                                         <div style="display: flex;width:80%;">
			                                                        5. <input type="checkbox" <%if(objE[19].toString().equalsIgnoreCase("Y")){ %>checked<%} %> class="form-control" value="<%=objE[0].toString()+"/"+objE[19].toString()+"/point5"%>" onchange="updateBpPoints(this)">
			                                                        6.a <input type="checkbox" <%if(objE[20].toString().equalsIgnoreCase("Y")){ %>checked<%} %> class="form-control" value="<%=objE[0].toString()+"/"+objE[20].toString()+"/point6"%>" onchange="updateBpPoints(this)">
			                                                        9 <input type="checkbox" <%if(objE[21].toString().equalsIgnoreCase("Y")){ %>checked<%} %> class="form-control" value="<%=objE[0].toString()+"/"+objE[21].toString()+"/point9"%>" onchange="updateBpPoints(this)">
			                                                       </div>
			                                                         </div>
                                                         
                                                         		</td>
                                                         	<%} %>
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
										<th width="10%">SN</th>
										<th width="20%">As On Date</th>
										<th width="20%">Progress</th>
										<th width="30%">Remarks</th>
										<th width="20%">Action</th>
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
	console.log($( "#btn"+id ).hasClass( "btn btn-sm btn-success" ).toString());
	if($( "#btn"+id ).hasClass( "btn btn-sm btn-success" ).toString()=='true'){
	$( "#btn"+id ).removeClass( "btn btn-sm btn-success" ).addClass( "btn btn-sm btn-danger" );
	$( "#fa"+id ).removeClass( "fa fa-plus" ).addClass( "fa fa-minus" );
    }else{
	$( "#btn"+id ).removeClass( "btn btn-sm btn-danger" ).addClass( "btn btn-sm btn-success" );
	$( "#fa"+id ).removeClass( "fa fa-minus" ).addClass( "fa fa-plus" );
    }
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
		console.log(value1+"-"+value2+"-"+value3);
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
						x+= '<td class="center">'+(i+1)+'</td>';
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
</script>  


</body>
</html>
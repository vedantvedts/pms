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
</style>
</head>
 
<body>
  <%
  

  
  List<Object[]> MilestoneList=(List<Object[]>)request.getAttribute("MilestoneActivityList");
  List<Object[]> ProjectList=(List<Object[]>)request.getAttribute("ProjectList");
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
  String ProjectId=(String)request.getAttribute("ProjectId");
  
  
 %>


    <form class="form-inline"  method="POST" action="MilestoneActivityList.htm">
  <div class="row W-100" style="width: 100%;">

  <div class="col-md-8">
  <h6 style="color: #145374;" >&nbsp; &nbsp; Project <i class="fa fa-long-arrow-right " aria-hidden="true"></i> Add Milestone <i class="fa fa-long-arrow-right " aria-hidden="true"></i> 
  							Add SubActivity <i class="fa fa-long-arrow-right " aria-hidden="true"></i> SubActivity <i class="fa fa-long-arrow-right " aria-hidden="true"></i> Weightage <i class="fa fa-long-arrow-right " aria-hidden="true"></i> Assignee</h6>
  </div>
	
                                    <div class="col-md-2">
                            		<label class="control-label">Project Name :</label>
                            		</div>
                            		<div class="col-md-2" style="margin-top: -7px;">
                              		<select class="form-control selectdee" id="ProjectId" required="required" name="ProjectId">
    									<option disabled="true"  selected value="">Choose...</option>
    										<% for (Object[] obj : ProjectList) {%>
											<option value="<%=obj[0]%>" <%if(obj[0].toString().equalsIgnoreCase(ProjectId)){ %>selected="selected" <%} %>> <%=obj[4]%>  </option>
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
													<thead>

														<tr>
															<th>Expand</th>
															<th style="text-align: left;max-width: 10px;">Mil-No</th>
														<!-- 	<th style="text-align: left;">Project Name</th> -->
															<th style="text-align: left;max-width: 200px;">Milestone Activity</th>
															<th >Start Date</th>
															<th >End Date</th>	
															<th  style="text-align: left;max-width: 200px;">First OIC </th>
															<th  style="text-align: center;max-width: 40px;">Weightage</th>	
															<th  style="text-align: center;max-width: 80px;">Progress</th>												
														 	<th style="max-width: 200px;" >Action</th>
														 		
														 	
														</tr>
													</thead>
													<tbody>
														<%int  count=1;
															
														 	if(MilestoneList!=null&&MilestoneList.size()>0){
															for(Object[] obj: MilestoneList){ %>
														<tr>
															<td style="width:2% !important; " class="center"><span class="clickable" data-toggle="collapse" id="row<%=count %>" data-target=".row<%=count %>"><button class="btn btn-sm btn-success" id="btn<%=count %>"  onclick="ChangeButton('<%=count %>')"><i class="fa fa-plus"  id="fa<%=count%>"></i> </button></span></td>
															<td style="text-align: left;width: 5%;"> Mil-<%=obj[5]%></td>
															<%-- <td class="width-30px"><%=obj[1]%></td> --%>
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=obj[4] %></td>
															
															<td  style="width:8% !important; "><%=sdf.format(obj[2])%></td>
															<td style="width:8% !important; "><%=sdf.format(obj[3])%></td>
															<td  style="width:15% !important; "><%=obj[6]%></td>
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
																<button  class="editable-click" name="sub" value="B">  
																	<div class="cc-rockmenu">
												                      <div class="rolling">
												                        <figure class="rolling_icon"><img src="view/images/preview3.png"  ></figure>
												                        <span>Details</span>
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
		
														</tr>
														 <tr class="collapse row<%=count %>" style="font-weight: bold;">
                                                         <td></td>
                                                         <td>Sub</td>
                                                         <td>Activity</td>
                                                         <td>Start Date</td>
                                                         <td>End Date</td>
                                                         <td>Date Of Completion</td>
                                                         <td>Sub Weightage</td>
                                                         <td>Sub Progress</td>
                                                         <td></td>
                                                         </tr>
                                                         <% int countA=1;
                                                            List<Object[]> MilestoneA=(List<Object[]>)request.getAttribute(count+"MilestoneActivityA");
														 	if(MilestoneA!=null&&MilestoneA.size()>0){
															for(Object[] objA: MilestoneA){
	                                                            List<Object[]> MilestoneB=(List<Object[]>)request.getAttribute(count+"MilestoneActivityB"+countA);
	
																%>
														<tr class="collapse row<%=count %>">
															<td style="width:2% !important; " class="center"> </td>
															<td style="text-align: left;width: 5%;"> A-<%=countA%></td>
															<%-- <td class="width-30px"><%=obj[1]%></td> --%>
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=objA[4] %></td>
															
															<td class="width-30px"><%=sdf.format(objA[2])%></td>
															<td style="width:8% !important; "><%=sdf.format(objA[3])%></td>
															
															
															<td class="width-30px"><%if(objA[9].toString().equalsIgnoreCase("3")||objA[9].toString().equalsIgnoreCase("5")){ %>
														     <%if(objA[7]!=null){ %>   <%=sdf.format(objA[7]) %> <%}else{ %><%=objA[8] %> <%} %>
														         <%}else{ %>
														         <%=objA[8] %>
															 <%} %></td>
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
													
                                                         <td></td>
                                                         </tr>
                                                         <% int countB=1;
														 	if(MilestoneB!=null&&MilestoneB.size()>0){
															for(Object[] objB: MilestoneB){
	                                                            List<Object[]> MilestoneC=(List<Object[]>)request.getAttribute(count+"MilestoneActivityC"+countA+countB);
	
																%>
														<tr class="collapse row<%=count %>">
															<td style="width:2% !important; " class="center"> </td>
															<td style="text-align: left;width: 5%;"> &nbsp;&nbsp;&nbsp;B-<%=countB%></td>
															<%-- <td class="width-30px"><%=obj[1]%></td> --%>
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=objB[4] %></td>
															
															<td class="width-30px"><%=sdf.format(objB[2])%></td>
															<td style="width:8% !important; "><%=sdf.format(objB[3])%></td>
															
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
															
														 													
                                                         <td></td>
                                                         </tr>
                                                         <% int countC=1;
														 	if(MilestoneC!=null&&MilestoneC.size()>0){
															for(Object[] objC: MilestoneC){
													         List<Object[]> MilestoneD=(List<Object[]>)request.getAttribute(count+"MilestoneActivityD"+countA+countB+countC);
																%>
														<tr class="collapse row<%=count %>">
															<td style="width:2% !important; " class="center"> </td>
															<td style="text-align: left;width: 5%;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C-<%=countC%></td>
															<%-- <td class="width-30px"><%=obj[1]%></td> --%>
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=objC[4] %></td>
															
															<td class="width-30px"><%=sdf.format(objC[2])%></td>
															<td style="width:8% !important; "><%=sdf.format(objC[3])%></td>
															
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
															
														
                                                         <td></td>
                                                         </tr>
                                                         <% int countD=1;
														 	if(MilestoneD!=null&&MilestoneD.size()>0){
															for(Object[] objD: MilestoneD){
	                                                            List<Object[]> MilestoneE=(List<Object[]>)request.getAttribute(count+"MilestoneActivityE"+countA+countB+countC+countD);
	
																%>
														<tr class="collapse row<%=count %>">
															<td style="width:2% !important; " class="center"> </td>
															<td style="text-align: left;width: 5%;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D-<%=countD%></td>
															<%-- <td class="width-30px"><%=obj[1]%></td> --%>
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=objD[4] %></td>
															
															<td class="width-30px"><%=sdf.format(objB[2])%></td>
															<td style="width:8% !important; "><%=sdf.format(objB[3])%></td>
															
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
															
														 													
                                                         <td></td>
                                                         </tr>
                                                         <% int countE=1;
														 	if(MilestoneE!=null&&MilestoneE.size()>0){
															for(Object[] objE: MilestoneE){ %>
														<tr class="collapse row<%=count %>">
															<td style="width:2% !important; " class="center"> </td>
															<td style="text-align: left;width: 5%;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;E-<%=countE%></td>
															<%-- <td class="width-30px"><%=obj[1]%></td> --%>
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=objE[4] %></td>
															
															<td class="width-30px"><%=sdf.format(objE[2])%></td>
															<td style="width:8% !important; "><%=sdf.format(objE[3])%></td>
															
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
															
														
                                                         <td></td>
                                                         </tr>
												<% countE++;} }%>
												<% countD++;} }%>
												<% countC++;} }%>
												<% countB++;} }%>
												<% countA++;} }else{%>
												<tr class="collapse row<%=count %>">
													<td colspan="9" style="text-align: center" class="center">No Sub List Found</td>
												</tr>
												<%} %>
												<% count++; } }else{%>
												<tr >
													<td colspan="9" style="text-align: center" class="center">No List Found</td>
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
	
	
	
	
	</script>  


</body>
</html>
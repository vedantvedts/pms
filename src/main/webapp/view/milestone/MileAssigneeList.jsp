<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

 

<title>Milestone Assignee List</title>
<style type="text/css">
label{
font-weight: bold;
  font-size: 13px;
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

  <form class="form-inline"  method="POST" action="M-A-AssigneeList.htm">
  <div class="row W-100" style="width: 100%;">

  <div class="col-md-8">
   
	  <p><b style="color: #145374;"><span class="label label-primary"> &nbsp;&nbsp;&nbsp;&nbsp; Project &nbsp; </span> </b><i class="fa fa-long-arrow-right " aria-hidden="true"></i>
	<b style="color: #145374;"><span class="label label-warning">&nbsp;Accept&nbsp;</span></b><i class="fa fa-long-arrow-right " aria-hidden="true"></i><b style="color: #145374;"><span class="label label-success">&nbsp;&nbsp;Update Progress&nbsp;&nbsp;</span></b>
      </p>
	                     
  </div>
  <div class="col-md-2" style="text-align: right;">
     <label class="control-label" >Project Name :  </label>
  </div>
  <div class="col-md-2" style="margin-top: -5px;">
     <select   class="form-control selectdee" id="ProjectId" required="required" name="ProjectId">
     <option disabled="disabled"  selected value="">Choose...</option>
     <% for (Object[] obj : ProjectList) {%>
	 <option value="<%=obj[0]%>" <%if(obj[0].toString().equalsIgnoreCase(ProjectId)){ %>selected="selected" <%} %>><%=obj[4]%>  </option>
	 <%} %>
     </select>
  </div>
 <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
 <input id="submit" type="submit" name="submit" value="Submit" hidden="hidden">
 </div>
</form>


<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<div align="center">
	<div class="alert alert-danger" role="alert" >
                     <%=ses1 %>
                    </div></div>
	<%}if(ses!=null){ %>
	<div align="center">
	<div class="alert alert-success" role="alert"  >
                     <%=ses %>
                   </div></div>
                    <%} %>

    <br />
   <div class="container-fluid" >
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover" style="margin-top: -20px;">
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
				
					 </div>
					 </div>
					<div class="card-body">
                                              <div class="table-responsive"> 
												<table class="table  table-hover table-bordered">
													<thead>
														<tr>
															<th>Expand</th>
															<th style="text-align: left;">Mil-No</th>
														<!-- 	<th style="text-align: left;">Project Name</th> -->
															<th style="text-align: left;">Milestone Activity</th>
															<th class="width-110px">Start Date</th>
															<th class="width-110px">End Date</th>	
															<th style="text-align: left;">First OIC </th>
															<th style="text-align: center;">Weightage</th>	
															<th style="text-align: center;">Progress</th>												
														 	<th style="text-align: center;">Action</th>
														</tr>
													</thead>
													<tbody>
														<%int  count=1;
															
														 	if(MilestoneList!=null&&MilestoneList.size()>0){
															for(Object[] obj: MilestoneList){
																
																List<Object[]> MilestoneA=(List<Object[]>)request.getAttribute(count+"MilestoneActivityA");%>
														<tr>
															<td style="width:2% !important; " class="center"><span class="clickable" data-toggle="collapse" id="row<%=count %>" data-target=".row<%=count %>"><button class="btn btn-sm btn-success" id="btn<%=count %>"  onclick="ChangeButton('<%=count %>')"><i class="fa fa-plus"  id="fa<%=count%>"></i> </button></span></td>
															<td style="text-align: left;width: 5%;"> Mil-<%=obj[5]%></td>
															<%-- <td class="width-30px"><%=obj[1]%></td> --%>
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=obj[4] %></td>
															
															<td class="width-30px"><%=sdf.format(obj[2])%></td>
															<td style="width:8% !important; "><%=sdf.format(obj[3])%></td>
															<td class="width-30px"><%=obj[6]%></td>
															<td class="width-30px" align="center"><%=obj[13]%></td>	
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
																<td  style="width:15% !important; ">		
																
														 
																
																	
															<%if(obj[8]!=null&&"Y".equalsIgnoreCase(obj[10].toString())&&MilestoneA!=null&&MilestoneA.size()>0){ %>

                        	                                  <button type="button" class="btn btn-sm edit" title="Comment" onclick="getCommentBox('<%=obj[0] %>','<%=obj[5] %>','<%=obj[15] %>','<%=obj[16] %>')"> <i class="fa fa-comment" aria-hidden="true" ></i> </button>
                        
                          
															<%} %>
															  <%if("A".equalsIgnoreCase(obj[10].toString())&&((Long) session.getAttribute("EmpId")).toString().equals(obj[11].toString())){ %>
                                                              														 <form action="MilestoneActivityUpdate.htm" method="POST" name="myfrm"  style="display: inline">
                                                              
                                                             <button  class="editable-click" name="sub" value="Accept"  formaction="M-A-Assign-OIC.htm" onclick="return confirm('Are You Sure To Accept?')" >
																<div class="cc-rockmenu">
																 <div class="rolling">	
											                        <figure class="rolling_icon"><img src="view/images/accept.jpg" ></figure>
											                        <span>Accept</span>
											                      </div>
											                     </div>
											                  </button> 
											                  	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
														    <input type="hidden" name="MilestoneActivityId" value="<%=obj[0]%>"/>
															<input type="hidden" name="RevId" value="<%=obj[8]%>"/>
															<input type="hidden" name="projectid" value="<%=ProjectId%>"/>
															
													       </form> 
											                  	<form action="MilestoneActivityUpdate.htm" method="POST" name="myfrm"  style="display: inline">
											                     <button type="button"  class="editable-click" name="sub" value="Back"   data-toggle="modal" data-target="#exampleModal<%=obj[0]%>" data-whatever="@mdo" >
																<div class="cc-rockmenu">
																 <div class="rolling">	
											                        <figure class="rolling_icon"><img src="view/images/sendback.jpg" ></figure>
											                        <span>Send Back</span>
											                      </div>
											                     </div>
											                  </button> 
											                  <input type="hidden" name="projectid" value="<%=ProjectId%>"/>
											                  <div class="modal fade" id="exampleModal<%=obj[0]%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                              <div class="modal-dialog">
                                          <div class="modal-content">
                                             <div class="modal-header">
                                            <h5 class="modal-title" id="exampleModalLabel">Add Remarks</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                     <span aria-hidden="true">&times;</span>
                                       </button>
                                        </div>
                                         <div class="modal-body">
          	                                  <div class="row">
                       				 
                                     <div class="col-md-12">
										<div class="form-group">
											<label class="control-label">Remark</label> 
										    <textarea class="form-control" name="Remarks" style="height: 9rem;" maxlength="255" required="required" placeholder="Enter Send Back Remark here with max 255 characters"></textarea>
										</div>
									</div>       

									
                                         </div>
                                       <div class="modal-footer">
        
                                         <button class="btn btn-sm btn-danger"   name="sub" value="Back"  formaction="M-A-Assign-OIC.htm" onclick="return confirm('Are You Sure To Send Back ?')">SendBack</button>
        
   
                                                </div>
                                                 </div>
                                                   </div>
                                                  </div>
											           </div>       
											                  	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
														    <input type="hidden" name="MilestoneActivityId" value="<%=obj[0]%>"/>
															
															
													 </form> 
																<%} %>
																		
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
                                                          <td>Progress</td>
                                                         <td></td>
                                                         </tr>
                                                         <% int countA=1;
                                                            
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
															<td>
															
															<%if(MilestoneB!=null && MilestoneB.size()==0)
															{
																if(Integer.parseInt(objA[5].toString())<100)
																{ 
																	
																	if(!objA[10].toString().equalsIgnoreCase("0") )
																	{
																
																		if(Integer.parseInt(objA[6].toString())>0)
																		{ %>
	                                                         	  			<form class="form-inline"  method="POST" action="M-A-Update.htm">
		                        	                                  			<button class="btn btn-sm edit"> <i class="fa fa-wrench" aria-hidden="true"></i> </button>
		                                                                 		<input type="hidden" name="MilestoneActivityId"	value="<%=obj[0] %>" /> 
		                                                                  		<input type="hidden" name="ActivityId"	value="<%=objA[0] %>" /> 
		                                                                  		<input type="hidden" name="ActivityType"	value="A" /> 
		                                                                   		<input type="hidden" name="ProjectId"	value="<%=ProjectId %>" /> 
		                                                                   		<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
	                                                                   		</form>
                                                                   		<%}else{ %>
                                                                   			Weightage Not Set 
                                                                   		<%}%>
                                                                   
                                                           			<%}else{ %>
		                                                                Base Line Not Set
                                                                   <%} %>
                                                                   
                                                        	<%}else{ %> 
																Completed                                                                   	
		                                                    <%} %>
										               <%}%>
                                                         </td>	
																										
                                                         
                                                         </tr>
                                                         <% int countB=1;
														 	if(MilestoneB!=null&&MilestoneB.size()>0){
															for(Object[] objB: MilestoneB)
															{
																List<Object[]> MilestoneC = (List<Object[]>)request.getAttribute(count+"MilestoneActivityC"+countA+countB);	
																%>
														<tr class="collapse row<%=count %>">
															<td style="width:2% !important; " class="center"> </td>
															<td style="text-align: left;width: 5%;"> &nbsp;&nbsp;B-<%=countB%></td>
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
                                                      
															<td>
															<%if(MilestoneC!=null&&MilestoneC.size()==0){
																
																if(Integer.parseInt(objB[5].toString())<100)
																{ 
																
															if(!objB[10].toString().equalsIgnoreCase("0")){
																if(Integer.parseInt(objB[6].toString())>0 && Integer.parseInt(objB[5].toString())<100){	%>
                                                         	  <form class="form-inline"  method="POST" action="M-A-Update.htm">
                        	                                  <button class="btn btn-sm edit" 
                        	                                  
                        	                                  > <i class="fa fa-wrench"  aria-hidden="true"></i> </button>
                                                                 <input type="hidden" name="MilestoneActivityId"	value="<%=obj[0] %>" /> 
                                                                  <input type="hidden" name="ActivityId"	value="<%=objB[0] %>" /> 
                                                                  <input type="hidden" name="ActivityType"	value="B" /> 
                                                                  <input type="hidden" name="ProjectId"	value="<%=ProjectId %>" /> 
                                                                    <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
                                                                   </form>
                                                                   <%}else{%>
                                                                   	Weightage Not Set 
                                                                   
                                                                   <%}
                                                                   }else{ %>
                                                                   Base Line Not Set
                                                                   <%} %>
                                                                  
                                                                  <%}else{%>
                                                                   		Completed
                                                                   <%} %>
                                                                  <%} %>
                                                         </td>	
														 
														
                                                         
                                                         </tr>
                                                         <% int countC=1;
                                                            
														 	if(MilestoneC!=null&&MilestoneC.size()>0){
															for(Object[] objC: MilestoneC){
															List<Object[]> MilestoneD=(List<Object[]>)request.getAttribute(count+"MilestoneActivityD"+countA+countB+countC);	
																%>
														<tr class="collapse row<%=count %>">
															<td style="width:2% !important; " class="center"> </td>
															<td style="text-align: left;width: 5%;"> &nbsp;&nbsp;&nbsp;&nbsp;C-<%=countC%></td>
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
															<td>
															<%if(MilestoneD!=null&&MilestoneD.size()==0){
																
																if(Integer.parseInt(objC[5].toString())<100)
																{ 
																
																
															if(!objC[10].toString().equalsIgnoreCase("0")){ 
																if(Integer.parseInt(objC[6].toString())>0){	%>
                                                         	  <form class="form-inline"  method="POST" action="M-A-Update.htm">
                        	                                  <button class="btn btn-sm edit"> <i class="fa fa-wrench" aria-hidden="true"></i> </button>
                                                                 <input type="hidden" name="MilestoneActivityId"	value="<%=obj[0] %>" /> 
                                                                  <input type="hidden" name="ActivityId"	value="<%=objC[0] %>" /> 
                                                                  <input type="hidden" name="ActivityType"	value="C" /> 
                                                                  <input type="hidden" name="ProjectId"	value="<%=ProjectId %>" /> 
                                                                    <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
                                                                   </form> 
                                                                   <%}else{ %>
                                                                   	Weightage Not Set 
                                                                   
                                                                   <%}
																	}else{ %>
                                                                   Base Line Not Set
                                                                   <%} %>
                                                                   
                                                                   <%}else{ %> Completed <%} %>
                                                               <%} %>
                                                         </td>	
													
                                                         </tr>
                                                <% int countD=1;
														 	if(MilestoneD!=null&&MilestoneD.size()>0){
															for(Object[] objD: MilestoneD){
																List<Object[]> MilestoneE=(List<Object[]>)request.getAttribute(count+"MilestoneActivityE"+countA+countB+countC+countD);	
																%>
														<tr class="collapse row<%=count %>">
															<td style="width:2% !important; " class="center"> </td>
															<td style="text-align: left;width: 5%;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D-<%=countD%></td>
															<%-- <td class="width-30px"><%=obj[1]%></td> --%>
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=objD[4] %></td>
															
															<td class="width-30px"><%=sdf.format(objD[2])%></td>
															<td style="width:8% !important; "><%=sdf.format(objD[3])%></td>
													      
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
															<%if(MilestoneE!=null&&MilestoneE.size()==0){
																
																if(Integer.parseInt(objD[5].toString())<100)
																{ 
																	
																
															if(!objD[10].toString().equalsIgnoreCase("0")){ 
																if(Integer.parseInt(objD[6].toString())>0){	%>
                                                         	  <form class="form-inline"  method="POST" action="M-A-Update.htm">
                        	                                  <button class="btn btn-sm edit" 
                        	                                  
                        	                                  > <i class="fa fa-wrench"  aria-hidden="true"></i> </button>
                                                                 <input type="hidden" name="MilestoneActivityId"	value="<%=obj[0] %>" /> 
                                                                  <input type="hidden" name="ActivityId"	value="<%=objD[0] %>" /> 
                                                                  <input type="hidden" name="ProjectId"	value="<%=ProjectId %>" /> 
                                                                  <input type="hidden" name="ActivityType"	value="D" /> 
                                                                    <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
                                                                   </form>
                                                                   <%}else{ %>
                                                                   	Weightage Not Set 
                                                                   
                                                                   <%}
																}else{ %>
                                                                   Base Line Not Set
                                                                   <%} %>
                                                                   
                                                                   <%}else{ %> Completed <%} %>
                                                               <%} %>
                                                         </td>	
														 
														
                                                         
                                                         </tr>
                                                         <% int countE=1;
                                                            
														 	if(MilestoneE!=null&&MilestoneE.size()>0){
															for(Object[] objE: MilestoneE){ %>
														<tr class="collapse row<%=count %>">
															<td style="width:2% !important; " class="center"> </td>
															<td style="text-align: left;width: 5%;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;E-<%=countE%></td>
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
															<%if(objE[9].toString().equalsIgnoreCase("2")){ %>
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
															<td>
															
															
															<%
															if(Integer.parseInt(objE[5].toString())<100)
															{ 
															if(!objE[10].toString().equalsIgnoreCase("0")){
																
																
																if(Integer.parseInt(objD[6].toString())>0){	%>
                                                         	  <form class="form-inline"  method="POST" action="M-A-Update.htm">
                        	                                  <button class="btn btn-sm edit"> <i class="fa fa-wrench" aria-hidden="true"></i> </button>
                                                                 <input type="hidden" name="MilestoneActivityId"	value="<%=obj[0] %>" /> 
                                                                  <input type="hidden" name="ActivityId"	value="<%=objE[0] %>" /> 
                                                                  <input type="hidden" name="ProjectId"	value="<%=ProjectId %>" /> 
                                                                  <input type="hidden" name="ActivityType"	value="E" /> 
                                                                    <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
                                                                   </form> 
                                                                   <%}else{ %>
                                                                   	Weightage Not Set 
                                                                   
                                                                   <%}
																}else{ %>
                                                                   Base Line Not Set
                                                                   <%} %>
                                                                <%}else{ %> Completed <%} %>
                                                         </td>	
													
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

	
   <div class="modal fade my-modal" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
 	  <div class="modal-dialog modal-dialog-centered" role="document">
 	    <div class="modal-content">
 	      <div class="modal-header">
 	        <h5 class="modal-title" id="exampleModalLongTitle"></h5>
  	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
  	          <span aria-hidden="true">&times;</span>
  	        </button>
  	      </div>
  	      <div class="modal-body">
  	      
  	      	<form action="MileRemarkUpdate.htm" method="POST" autocomplete="off">
  	      		<div class="row">
  	      		    
					<div class="col-md-12">Financial Outlay : <br>
							<input class="form-control" title="Enter Number" name="financialoutlay" id="financialoutlay" type="text"   maxlength="9">
					</div>
					 <br>
					<div class="col-md-12"> Remarks :<br>
  	      		    		<textarea class="form-control"  name="Remarks" id="remarks"   required="required"  maxlength="255"> </textarea>
  	      		    </div>
  	      			</div>
  	      		<br>
  	      		<div align="center">
  	      			<input type="submit" class="btn btn-primary btn-sm submit " id="sub" value="Submit" name="sub"  onclick="return confirm('Are You Sure To Submit ?')" > 
  	      		</div>
  	      		<br>

                <input type="hidden" name="projectid" value="<%=ProjectId%>"/>
  	      		<input type="hidden" name="MileId" value="" id="milId"/>
  	      		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  	      	</form>
  	      		
  	      		
  	      </div>
  	      <div class="modal-footer">
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
	
	
	
	function getCommentBox(id,mile,remarks,financeoutlay){

		$('#exampleModalCenter').modal('toggle');
		$("#milId").val(id);
		$("#financialoutlay").val("");
		$("#remarks").val("");
		if(remarks!="null" && financeoutlay!="null"){
			$("#financialoutlay").val(financeoutlay);
			$("#remarks").val(remarks);
		}
		$("#exampleModalLongTitle").html('Milestone '+mile);
	}
	
	
	
	setPatternFilter($("#financialoutlay"), /^-?\d*$/);
	function setPatternFilter(obj, pattern) {
		  setInputFilter(obj, function(value) { return pattern.test(value); });
		}

	function setInputFilter(obj, inputFilter) {
		  obj.on("input keydown keyup mousedown mouseup select contextmenu drop", function() {
		    if (inputFilter(this.value)) {
		      this.oldValue = this.value;
		      this.oldSelectionStart = this.selectionStart;
		      this.oldSelectionEnd = this.selectionEnd;
		    } else if (this.hasOwnProperty("oldValue")) {
		      this.value = this.oldValue;
		      this.setSelectionRange(this.oldSelectionStart, this.oldSelectionEnd);
		    }
		  });
		}
	</script>  


</body>
</html>
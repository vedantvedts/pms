<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>PMS</title>
<link rel="shortcut icon" type="image/png" href="view/images/drdologo.png">
<jsp:include page="../static/dependancy.jsp"></jsp:include>
 <style type="text/css">
 
 p{
  text-align: justify;
  text-justify: inter-word;
}
                           
 th
 {
 	border: 1px solid black;
 	text-align: center;
 	padding: 5px;
	overflow-wrap: break-word;
 }
 
 td
 {
 	border: 1px solid black;
 	text-align: left;
 	padding: 5px;
 	overflow-wrap: break-word;
 }
 
  }
 .textcenter{
 	
 	text-align: center;
 }
 .border
 {
 	border: 1px solid black;
 }
 .textleft{
 	text-align: left;
 }
 
 .containers {
    width: 100%;
    height: 100%;
    margin: 0;
    padding: 0;
}

.anychart-credits {
   display: none;
}

.flex-container {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

summary[role=button] {
  background-color: white;
  color: black;
  border: 1px solid black ;
  border-radius:5px;
  padding: 0.5rem;
  cursor: pointer;
  
}
summary[role=button]:hover
 {
color: white;
border-radius:15px;
background-color: #4a47a3;

}
 summary[role=button]:focus
{
color: white;
border-radius:5px;
background-color: #4a47a3;
border: 0px ;

}
summary::marker{
	
}
details { 
  margin-bottom: 5px;  
}
details  .content {
background-color:white;
padding: 0 1rem ;
align: center;
border: 1px solid black;
}

}

.anchorlink{
	cursor: pointer;
	color: #C84B31;
}
.anchorlink:hover {
    text-decoration: underline;
}

</style>


<!-- --------------  tree   ------------------- -->
<style>
ul, #myUL {
  list-style-type: none;
}

#myUL {
  margin: 0;
  padding: 0;
}

.caret {
  cursor: pointer;
  -webkit-user-select: none; /* Safari 3.1+ */
  -moz-user-select: none; /* Firefox 2+ */
  -ms-user-select: none; /* IE 10+ */
  user-select: none;
}

.caret::before {
  content: "  \25B7";
  color: black;
  display: inline-block;
  margin-right: 6px;
}

.caret-down::before {
  content: "\25B6  ";
  -ms-transform: rotate(90deg); /* IE 9 */
  -webkit-transform: rotate(90deg); /* Safari */'
  transform: rotate(90deg);  
}

.caret-last {
  cursor: pointer;
  -webkit-user-select: none; /* Safari 3.1+ */
  -moz-user-select: none; /* Firefox 2+ */
  -ms-user-select: none; /* IE 10+ */
  user-select: none;
}


.caret-last::before {
  content: "\25B7";
  color: black;
  display: inline-block;
  margin-right: 6px;
}


.nested {
  display: none;
}

.active {
  display: block;
}
</style>

<!-- ---------------- tree ----------------- -->
<!-- -------------- model  tree   ------------------- -->
<style>

.caret-1 {
  cursor: pointer;
  -webkit-user-select: none; /* Safari 3.1+ */
  -moz-user-select: none; /* Firefox 2+ */
  -ms-user-select: none; /* IE 10+ */
  user-select: none;
}

.caret-last-1 {
  cursor: pointer;
  -webkit-user-select: none; /* Safari 3.1+ */
  -moz-user-select: none; /* Firefox 2+ */
  -ms-user-select: none; /* IE 10+ */
  user-select: none;
}


.caret-last-1::before {
  content: "\25B7" ;
  color: black;
  display: inline-block;
  margin-right: 6px;
}

.caret-1::before {
  content: "\25B7" ;
  color: black;
  display: inline-block;
  margin-right: 6px;
}

.caret-down-1::before {
  content: "\25B6";
  -ms-transform: rotate(90deg); /* IE 9 */
  -webkit-transform: rotate(90deg); /* Safari */'
  transform: rotate(90deg);  
}

.nested-1 {
  display: none;
}

.active-1 {
  display: block;
}

 .completed{
	color: green;
	font-weight: 700;
}

.briefactive{
	color: blue;
	font-weight: 700;
}

.inprogress{
	color: #F66B0E;
	font-weight: 700;
}

.assigned{
	color: brown;
	font-weight: 700;
}

.notyet{
	color: purple;
	font-weight: 700;
}
.notassign{
	color:#AB0072;
	font-weight: 700;
}
.ongoing{
	color: #F66B0E;
	font-weight: 700;
}

.completed{
	color: green;
	font-weight: 700;
}

.delay{
	color: maroon;
	font-weight: 700;
}

.completeddelay{
	color:#BABD42;
	font-weight: 700;
}

.inactive{
	color: red;
	font-weight: 700;
}

.select2-container{
	float:right !important;
	margin-top: 5px;
	
}

.modal-xl{
	max-width: 1400px;
}
</style>



</head>
<body>
<%
FormatConverter fc=new FormatConverter(); 
SimpleDateFormat sdf=fc.getRegularDateFormat();
SimpleDateFormat sdf1=fc.getSqlDateFormat();


List<List<Object[]>> projectidlist = (List<List<Object[]>>)request.getAttribute("milestonefilterlist");
List<Object[]> milestoneactivitystatus =(List<Object[]>)request.getAttribute("milestoneactivitystatus");
String levelid = (String)request.getAttribute("levelid");
String ProjectId = (String)request.getAttribute("ProjectId");
String committeeId = (String)request.getAttribute("CommitteeId");
String MilestoneActivity = (String)request.getAttribute("MilestoneActivity");
%>

<div class="container-fluid">
<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover" style="margin-top: -0px;">
				<div class="row card-header">
			     <div class="col-md-9">
					 <h5><%if(ProjectId!=null){
						Object[] ProjectDetail123=(Object[])request.getAttribute("ProjectDetailsMil");
						%>
						<%=ProjectDetail123[2] %> ( <%=ProjectDetail123[1] %> ) 
					<%} %>
					</h5> 
					</div>
					<div class="col-md-3">
					<form method="post" action="FilterMilestone.htm" id="projectchange">
											<select class="form-control items" name="milestoneactivity"  required="required" style="width:300px;" data-live-search="true" data-container="body" onchange="this.form.submit()">
												<option selected value="A" <%if(MilestoneActivity!=null && "A".equalsIgnoreCase(MilestoneActivity)){%> selected="selected" <%}%>>All</option>
												<%if(milestoneactivitystatus!=null && milestoneactivitystatus.size()>0){ for(Object[] obj : milestoneactivitystatus){%>
													<option value=<%=obj[0]%> <%if(MilestoneActivity!=null && obj[0].toString().equalsIgnoreCase(MilestoneActivity)){%> selected="selected" <%}%>><%=obj[1] %> (<%=obj[2] %>)</option>
												<%}}%>
											</select>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<input type="hidden" name="projectidvalue" <%if(ProjectId!=null){%> value="<%=ProjectId%>" <%}%>>
						<input type="hidden" name="committeidvalue" <%if(committeeId!=null){%> value="<%=committeeId%>" <%}%>>
					</form>
					
					 </div>
					 </div>
					<div class="card-body">
					
                                              <div class="table-responsive"> 
												<table class="table  table-hover table-bordered">
													<thead>

														<tr>
															<th>Expand</th>
															<th style="text-align: left;max-width: 15px;">Mil-No</th>
														<!-- 	<th style="text-align: left;">Project Name</th> -->
															<th style="text-align: left;max-width: 200px;">Milestone Activity</th>
															<th >Start Date</th>
															<th >End Date</th>	
															<th  style="text-align: left;max-width: 200px;">First OIC </th>
															<th  style="text-align: center;max-width: 50px;">Weightage</th>	
															<th  style="text-align: center;max-width: 80px;">Progress</th>												

														</tr>
													</thead>
													<tbody>
													
														<%int  count=1;
														List<Object[]> MilestoneList=(List<Object[]>)request.getAttribute("MilestoneActivityList");
														
														if(MilestoneList!=null&&MilestoneList.size()>0){
											
															for(Object[] obj: MilestoneList){ 
																 %>
														<tr class="milestonemodalwhole" id="milestonemodal<%=obj[5] %>"  >
															<td style="width:2% !important; " class="center">
																<span class="clickable collapsed" data-toggle="collapse" id="row<%=count %>" data-target=".row<%=count %>" onclick="ChangeButton('<%=count %>')">
																	<button class="btn btn-sm btn-danger" id="btn<%=count %>"  >
																		<i class="fa fa-minus"  id="fa<%=count%>"></i>
																	 </button>
																</span>
															</td>
															<td style="text-align: left;width: 7%;"> Mil-<%=obj[5]%></td>
															<%-- <td class="width-30px"><%=obj[1]%></td> --%>
															<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=obj[4] %></td>
															
															<td  style="width:8% !important; "><%=sdf.format(obj[2])%></td>
															<td style="width:8% !important; "><%=sdf.format(obj[3])%></td>
															<td  style="width:15% !important; "><%=obj[6]%></td>
															<td  style="width:9% !important; " align="center"><%=obj[13]%></td>	
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
																
		
														</tr>
														 <tr class=" collapse  row<%=count %> show" style="font-weight: bold;">
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
	                                                            if(MilestoneActivity==null || "A".equalsIgnoreCase(MilestoneActivity) || objA[9].toString().equalsIgnoreCase(MilestoneActivity)) {
																%>
														<tr class="  collapse row<%=count %> show">
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
                                                         <%} int countB=1;
														 	if(MilestoneB!=null&&MilestoneB.size()>0){
															for(Object[] objB: MilestoneB){
	                                                            List<Object[]> MilestoneC=(List<Object[]>)request.getAttribute(count+"MilestoneActivityC"+countA+countB);
	                                                            if(MilestoneActivity==null || "A".equalsIgnoreCase(MilestoneActivity) || objB[9].toString().equalsIgnoreCase(MilestoneActivity)) {
																%>
														<tr class=" collapse row<%=count %> show">
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
                                                         <%} int countC=1;
														 	if(MilestoneC!=null&&MilestoneC.size()>0){
															for(Object[] objC: MilestoneC){
													         List<Object[]> MilestoneD=(List<Object[]>)request.getAttribute(count+"MilestoneActivityD"+countA+countB+countC);
																
													         if(MilestoneActivity==null || "A".equalsIgnoreCase(MilestoneActivity) || objC[9].toString().equalsIgnoreCase(MilestoneActivity)) {
																%>
														<tr class=" collapse  row<%=count %> show">
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
                                                         <%} int countD=1;
														 	if(MilestoneD!=null&&MilestoneD.size()>0){
															for(Object[] objD: MilestoneD){
	                                                            List<Object[]> MilestoneE=(List<Object[]>)request.getAttribute(count+"MilestoneActivityE"+countA+countB+countC+countD);
	                                                            if(MilestoneActivity==null || "A".equalsIgnoreCase(MilestoneActivity) || objD[9].toString().equalsIgnoreCase(MilestoneActivity)) {
																%>
														<tr class=" collapse row<%=count %> show">
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
                                                         <%} int countE=1;
														 	if(MilestoneE!=null&&MilestoneE.size()>0){
															for(Object[] objE: MilestoneE){
																 if(MilestoneActivity==null || "A".equalsIgnoreCase(MilestoneActivity) || objE[9].toString().equalsIgnoreCase(MilestoneActivity)) {
																%>
														<tr class=" collapse row<%=count %> show">
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
												<% countE++;} } }%>
												<% countD++;} }%>
												<% countC++;} }%>
												<% countB++;} }%>
												<% countA++;} }else{%>
												<tr class="collapse row<%=count %>">
													<td colspan="9" style="text-align: center" class="center">No Sub List Found</td>
												</tr>
												<%} %>
												<% count++; }  }else{%>
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
</body>
<script type="text/javascript">



$( document).on("click", ".milestonemodal", function () {
    
	var milId = $(this).data('id');
    $('.milestonemodalwhole').hide();
    $('.collapse').removeClass('show'); 
    $('#row'+milId.charAt(milId.length-1)).click();
 	$('#'+milId).show();

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
</html>
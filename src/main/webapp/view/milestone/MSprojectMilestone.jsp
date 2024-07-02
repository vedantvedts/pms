<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
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
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
String ProjectId=(String)request.getAttribute("ProjectId");
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
					<div class="row card-header">
						<div class="col-md-9">
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
						<div class="col-md-1 ">
						<form action="MSprojectGanttChart.htm">
						<button class="btn btn-sm btn-info" style="margin-top:-6px;">Gantt Chart</button>
						
						 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						 <input type="hidden" name="ProjectId" value="<%=ProjectId%>">
						</form>
						</div>
						
						<div class="col-md-1 ">
						<form action="MSprojectCriticalPath.htm">
						<button class="btn btn-sm btn-info" style="margin-top:-6px;">Critical Paths</button>
						
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
									<th style="text-align: left; max-width: 100px;">Task no.</th>
									<th style="text-align: center; max-width: 120px;">TaskId</th>
									<th style="text-align: left; max-width: 270px;">Task Name</th>
									<th style="text-align: left; max-width: 200px;">Assignee</th>
									<th style="text-align: left; max-width: 60px;">Start Date</th>
									<th style="text-align: left; max-width: 60px;">Finish Date</th>
									<th style="text-align: center; max-width: 80px;">Progress</th>


								</tr>
							</thead>
							<tbody>
							<%  int count =0;
								
							if(mstaskList!=null && mstaskList.size()>0){
							for(Object[] level1: mstaskList){
								if(level1[8].toString().equalsIgnoreCase("1")){
							%>
							<tr>
							<td style="width:2% !important;" class="center"><span class="clickable" data-toggle="collapse" id="row<%=count %>" data-target=".row<%=count %>"><button class="btn btn-sm btn-success" id="btn<%=count %>"  onclick="ChangeButton('<%=count %>')"><i class="fa fa-plus"  id="fa<%=count%>"></i> </button></span></td> 
							 <td style=""><%if(level1[9]!=null) {%><%=level1[9].toString() %>  <%}else{ %>- <%} %></td>
							 <td style=""><%if(level1[6]!=null) {%><%=level1[6].toString() %>  <%}else{ %>- <%} %></td>
							 <td style=""><%if(level1[10]!=null) {%><%=level1[10].toString() %>  <%}else{ %>- <%} %></td>
							 <td style=""><%if(level1[4]!=null) {%><%=level1[4].toString() %>  <%}else{ %>- <%} %>, <%if(level1[5]!=null ) {%> <%=level1[5].toString() %> <%}else{ %><%} %></td>
							 <td style="">
							 <%if(level1[13]!=null) {%><%=level1[13].toString() %>  <%}else{ %><%=level1[11].toString() %><%} %>
							 
							 </td>
							 <td style="">
							 <%if(level1[14]!=null) {%><%=level1[14].toString() %>  <%}else{ %> <%=level1[12].toString() %><%} %>
							 
							 </td>
							 <td style="">
							 
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
															</div> <%}else{ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Not Started
															</div>
															</div> <%} %>
															</td>
														</tr>
														
														
							 							 <tr class="collapse row<%=count %>"  id="rowcollapse<%=count%>" style="font-weight: bold;">
                                                         <td></td>
                                                         <td>Task sub-level No</td>
                                                         <td>Task Id</td>
                                                         <td>Task Name</td>	
														 <td >Assignee</td>	
                                                         <td>Start Date</td>
                                                         <td>End Date</td>
                                                         <td>Progress</td>
                                                         </tr>
														<%
														int countA=0;
														if(mstaskList!=null && mstaskList.size()>0){
														for(Object []level2 : mstaskList){
															if(level2[8].toString().equalsIgnoreCase("2") && level2[7].toString().equalsIgnoreCase(level1[6].toString())){
														%>
															<tr class="collapse row<%=count %>"  id="rowcollapse<%=count%>">
														<td></td>
							<td style=""><%if(level2[9]!=null) {%> &nbsp;<%=level2[9].toString() %>  <%}else{ %>- <%} %></td>
							 <td style=""><%if(level2[6]!=null) {%><%=level2[6].toString() %>  <%}else{ %>- <%} %></td>
							 <td style=""><%if(level2[10]!=null) {%><%=level2[10].toString() %>  <%}else{ %>- <%} %></td>
							 <td style=""><%if(level2[4]!=null) {%><%=level2[4].toString() %>  <%}else{ %>- <%} %>, <%if(level2[5]!=null ) {%> <%=level2[5].toString() %> <%}else{ %><%} %></td>
							 <td style="">
							 <%if(level2[13]!=null) {%><%=level2[13].toString() %>  <%}else{ %><%=level2[11].toString() %><%} %>
							 
							 </td>
							 <td style="">
							 <%if(level2[14]!=null) {%><%=level2[14].toString() %>  <%}else{ %> <%=level2[12].toString() %><%} %>
							 
							 </td>
							 <td style="">
							 
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
															</div> <%}else{ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Not Started
															</div>
															</div> <%} %>
															</td>
														</tr>
														<%
														int countB=0;
														if(mstaskList!=null && mstaskList.size()>0){
														 for(Object[]level3 : mstaskList){
															if(level3[8].toString().equalsIgnoreCase("3")  && level3[7].toString().equalsIgnoreCase(level2[6].toString())){
															 %>
														
														
																					<tr class="collapse row<%=count %>"  id="rowcollapse<%=count%>">
														<td></td>
							<td style=""><%if(level3[9]!=null) {%> &nbsp; &nbsp; <%=level3[9].toString() %>  <%}else{ %>- <%} %></td>
							 <td style=""><%if(level3[6]!=null) {%><%=level3[6].toString() %>  <%}else{ %>- <%} %></td>
							 <td style=""><%if(level3[10]!=null) {%><%=level3[10].toString() %>  <%}else{ %>- <%} %></td>
							 <td style=""><%if(level3[4]!=null) {%><%=level3[4].toString() %>  <%}else{ %>- <%} %>, <%if(level3[5]!=null ) {%> <%=level3[5].toString() %> <%}else{ %><%} %></td>
							 <td style="">
							 <%if(level3[13]!=null) {%><%=level3[13].toString() %>  <%}else{ %><%=level3[11].toString() %><%} %>
							 
							 </td>
							 <td style="">
							 <%if(level3[14]!=null) {%><%=level3[14].toString() %>  <%}else{ %> <%=level3[12].toString() %><%} %>
							 
							 </td>
							 <td style="">
							 
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
															</div> <%}else{ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Not Started
															</div>
															</div> <%} %>
															</td>
														</tr>	
													
													<!--  3rd level -->
													
														<%
														int countC=0;
														if(mstaskList!=null && mstaskList.size()>0){
														for(Object[]level4 : mstaskList){
														 if(level4[8].toString().equalsIgnoreCase("4")  && level4[7].toString().equalsIgnoreCase(level3[6].toString())){
														%>
															
																																	<tr class="collapse row<%=count %>"  id="rowcollapse<%=count%>">
							<td></td>
							<td style=""><%if(level4[9]!=null) {%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=level4[9].toString() %>  <%}else{ %>- <%} %></td>
							 <td style=""><%if(level4[6]!=null) {%><%=level4[6].toString() %>  <%}else{ %>- <%} %></td>
							 <td style=""><%if(level4[10]!=null) {%><%=level4[10].toString() %>  <%}else{ %>- <%} %></td>
							 <td style=""><%if(level4[4]!=null) {%><%=level4[4].toString() %>  <%}else{ %>- <%} %>, <%if(level4[5]!=null ) {%> <%=level4[5].toString() %> <%}else{ %><%} %></td>
							 <td style="">
							 <%if(level4[13]!=null) {%><%=level4[13].toString() %>  <%}else{ %><%=level4[11].toString() %><%} %>
							 
							 </td>
							 <td style="">
							 <%if(level4[14]!=null) {%><%=level4[14].toString() %>  <%}else{ %> <%=level4[12].toString() %><%} %>
							 
							 </td>
							 <td style="">
							 
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
															</div> <%}else{ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Not Started
															</div>
															</div> <%} %>
															</td>
														</tr>			
															 
															 
										<!--  4th level -->
										
														<%
														int countD=0;
														if(mstaskList!=null && mstaskList.size()>0){
														for(Object[]level5 : mstaskList){
														 if(level5[8].toString().equalsIgnoreCase("5")  && level5[7].toString().equalsIgnoreCase(level4[6].toString())){
														%>
															
																																	<tr class="collapse row<%=count %>"  id="rowcollapse<%=count%>">
							<td></td>
							<td style=""><%if(level5[9]!=null) {%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;<%=level5[9].toString() %>  <%}else{ %>- <%} %></td>
							 <td style=""><%if(level5[6]!=null) {%><%=level5[6].toString() %>  <%}else{ %>- <%} %></td>
							 <td style=""><%if(level5[10]!=null) {%><%=level5[10].toString() %>  <%}else{ %>- <%} %></td>
							 <td style=""><%if(level5[4]!=null) {%><%=level5[4].toString() %>  <%}else{ %>- <%} %>, <%if(level5[5]!=null ) {%> <%=level5[5].toString() %> <%}else{ %><%} %></td>
							 <td style="">
							 <%if(level5[13]!=null) {%><%=level5[13].toString() %>  <%}else{ %><%=level5[11].toString() %><%} %>
							 
							 </td>
							 <td style="">
							 <%if(level5[14]!=null) {%><%=level5[14].toString() %>  <%}else{ %> <%=level5[12].toString() %><%} %>
							 
							 </td>
							 <td style="">
							 
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
															</div> <%}else{ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Not Started
															</div>
															</div> <%} %>
															</td>
														</tr>	
													
													<!--  5th level -->
													
																			<%
														int countE=0;
														if(mstaskList!=null && mstaskList.size()>0){
															for(Object[]level6 : mstaskList){
														 if(level6[8].toString().equalsIgnoreCase("5")  && level6[7].toString().equalsIgnoreCase(level5[6].toString())){
														%>
															
																																	<tr class="collapse row<%=count %>"  id="rowcollapse<%=count%>">
							<td></td>
							<td style=""><%if(level6[9]!=null) {%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;<%=level6[9].toString() %>  <%}else{ %>- <%} %></td>
							 <td style=""><%if(level6[6]!=null) {%><%=level6[6].toString() %>  <%}else{ %>- <%} %></td>
							 <td style=""><%if(level6[10]!=null) {%><%=level6[10].toString() %>  <%}else{ %>- <%} %></td>
							 <td style=""><%if(level6[4]!=null) {%><%=level6[4].toString() %>  <%}else{ %>- <%} %>, <%if(level6[5]!=null ) {%> <%=level6[5].toString() %> <%}else{ %><%} %></td>
							 <td style="">
							 <%if(level6[13]!=null) {%><%=level6[13].toString() %>  <%}else{ %><%=level6[11].toString() %><%} %>
							 
							 </td>
							 <td style="">
							 <%if(level6[14]!=null) {%><%=level6[14].toString() %>  <%}else{ %> <%=level6[12].toString() %><%} %>
							 
							 </td>
							 <td style="">
							 
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
															</div> <%}else{ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Not Started
															</div>
															</div> <%} %>
															</td>
														</tr>
													
													
													
													
														<%countE++;}}} %>
														<%countD++;}}} %>
														<%countC++;}}} %> 
														<%countB++;}}} %>
														<% countA++;}}}%>
														<%if(countA==0){ %>
														<tr class="collapse row<%=count %>"  id="rowcollapse<%=count%>">
														<td colspan="8" style="text-align: center" class="center">No sub level Found</td>
														</tr>
														<%} %>
													<% count++; }}}else{%>
												<tr >
													<td colspan="8" style="text-align: center" class="center">No List Found</td>
												</tr>
												<%} %>
							</tbody>
						</table>

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
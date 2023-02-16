<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<script src="./resources/js/multiselect.js"></script>
<link href="./resources/css/multiselect.css" rel="stylesheet"/>
 

<title>FRACAS List</title>

<title> ADD COMMITTEE</title>
<style type="text/css">
label {
	font-weight: bold;
	font-size: 13px;
}

body {
	background-color: #f2edfa;
}

.table .font {
	font-family: 'Muli', sans-serif !important;
	font-style: normal;
	font-size: 13px;
	font-weight: 400 !important;
}

.table button {
	background-color: Transparent !important;
	background-repeat: no-repeat;
	border: none;
	cursor: pointer;
	overflow: hidden;
	outline: none;
	text-align: left !important;
}

.table td {
	padding: 5px !important;
}

.resubmitted {
	color: green;
}

.fa {
	font-size: 1.20rem;
}

.datatable-dashv1-list table tbody tr td {
	padding: 8px 10px !important;
}

.fa-exclamation-triangle {
	font-size: 2.5rem !important;
}

.table-project-n {
	color: #005086;
}

.right {
	text-align: right;
} 
 
.center {
	text-align: center;
}

#table thead tr th {
	padding: 0px 0px !important;
	text-align:center;
}

#table tbody tr td {
	padding: 2px 3px !important;
	text-align:center;
}

/* icon styles */
.cc-rockmenu {
	color: fff;
	padding: 0px 5px;
	font-family: 'Lato', sans-serif;
}

.cc-rockmenu .rolling {
	display: inline-block;
	cursor: pointer;
	width: 33px;
	height: 30px;
	text-align: left;
	overflow: hidden;
	transition: all 0.3s ease-out;
	white-space: nowrap;
}

.cc-rockmenu .rolling:hover {
	width: 120px;
}

.cc-rockmenu .viewcommittees:hover {
	width: 157px;
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
	width: 270px !important;
}

a:hover {
	color: white;
}



</style>
</head>
 
<body>
<% 
 	FormatConverter fc=new FormatConverter(); 
	SimpleDateFormat sdf=fc.getRegularDateFormat();
	SimpleDateFormat sdf1=fc.getSqlDateFormat();

	
  List<Object[]>  projectslist=(List<Object[]>)request.getAttribute("projectlist");
  List<Object[]>  projectmainitemslist=(List<Object[]>)request.getAttribute("projectmainitemslist");
  String projectid=(String)request.getAttribute("projectid");
  String LabCode=(String)request.getAttribute("LabCode");
  
%>



<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<center>
	<div class="alert alert-danger" role="alert" >
                     <%=ses1 %>
                    </div></center>
	<%}if(ses!=null){ %>
	<center>
	<div class="alert alert-success" role="alert"  >
                     <%=ses %>
                   </div></center>
                    <%} %>
  
    
    
<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			<div class="card shadow-nohover">
				<div class="card-header">
					<div class="row">
						<div class="col-md-9">
							<h4 class="text-blue">Failure Reporting, Analysis, and Corrective Action System (FRACAS)  List</h4>
						</div>
						<div class="col-md-3" style="margin-top: -8px;">
							<form action="FracasMainItemsList.htm" method="post" id="projectchange">
								<table style="float: right;">
									<tr>
										<td> <label class="control-label">Project : </label></td>
										<td>
											<select class="form-control selectdee" id="projectid" name="projectid" required onchange="$('#projectchange').submit();">
												<%-- <option <%if(projectid.equals("0")){ %>selected <%} %>	value="0">General</option> --%>
												<%for(Object[] obj:projectslist){ %>
													<option <%if(projectid.equals(obj[0].toString())){ %>selected <%} %> value="<%=obj[0]%>"><%=obj[4]%></option>	
												<%} %>
											</select>
										</td>
									</tr>
								</table>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							</form>
						</div>
					</div>
				</div>
				<div class="card-body">
										
										<div class="table-responsive">
						   					<table class="table table-bordered table-hover table-striped table-condensed "  id="myTable" > 
						   						<thead>
														<tr>
															<th>SN.</th>
															<th>Project</th>
															<th>Type</th>
															<th>Item</th>
															<th>FRACAS Date</th>
															<th>Attachment</th>
															<th>Actions</th>
														</tr>
													</thead>   
													<%if(projectmainitemslist.size()>0){ %>
														<%for(int i=0;i<projectmainitemslist.size();i++){ %>
															<tr>
																<td><%=i+1 %></td>
																<td><%=projectmainitemslist.get(i)[6] %></td>
																<td><%=projectmainitemslist.get(i)[5] %></td>
																<td><%= projectmainitemslist.get(i)[2] %></td>
																<td><%= sdf.format(sdf1.parse( projectmainitemslist.get(i)[3].toString() ))%></td>
																<td>
																	<%if(projectmainitemslist.get(i)[7]!=null){ %>
																		<form action="FracasAttachDownload.htm" method="post" target="_blank" >
																			<button class="btn" style="align: center;"><i class="fa fa-download"></i></button>
																			<input type="hidden" name="fracasattachid" value="<%= projectmainitemslist.get(i)[7] %>">
																			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
																		</form>
																	<%}else{ %>
																		-
																	<%} %>
																</td>
																<td style="width:14rem" >
																
																	<form action="FracasMainItemEdit.htm" method="post" style="display: inline">
																		<button class="editable-click" name="sub"
																			value="Modify">
																			<div class="cc-rockmenu">
																				<div class="rolling">
																					<figure class="rolling_icon">
																						<img src="view/images/edit.png">
																					</figure>
																					<span>Edit</span>
																				</div>
																			</div>
																		</button>
																		
																		<input type="hidden" name="fracasmainid"	value="<%=projectmainitemslist.get(i)[0] %>" /> 
																		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
																	</form>
																	<form action="FracasAssign.htm" method="post" style="display: inline">
																		<button class="editable-click" name="sub"
																			value="Modify">
																			<div class="cc-rockmenu">
																				<div class="rolling">
																					<figure class="rolling_icon">
																						<i class="fa fa-plus-square-o fa-3x" style="color: green; font-weight: 300;" aria-hidden="true"></i>
																					</figure>
																					<span>Assign</span>
																				</div>
																			</div>
																		</button>
																		<input type="hidden" name="LabCode"	value="<%=LabCode %>" /> 
																		<input type="hidden" name="fracasmainid"	value="<%=projectmainitemslist.get(i)[0] %>" /> 
																		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
																	</form>
																		
																	<%-- <form action="FracasMainDelete.htm" method="post" style="display: inline">
																		<button class="editable-click" name="sub"
																			value="Modify">
																			<div class="cc-rockmenu">
																				<div class="rolling">
																					<figure class="rolling_icon">
																						<i class="fa fa-window-close fa-lg" style="color: red;" aria-hidden="true"></i>
																					</figure>
																					<span>Close</span>
																				</div>
																			</div>
																		</button>
																		<input type="hidden" name="projectid"	value="<%=projectid %>" />
																		<input type="hidden" name="fracasmainid"	value="<%=projectmainitemslist.get(i)[0] %>" /> 
																		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
																	</form>	 --%>
																</td>
															</tr>
														<%} %>
													<%}else { %>
														<tr>
															<td colspan="7" align="center">No Records Found</td>
														</tr>													
													<%} %>
												</table>
											</div>
											
										
						<br>
						<div class="row">
							<div class="col-md-5"></div>
							<div class="col-md-2">
								<table  align="center">
									<tr>
										<td>
											<form action="FracasMainAdd.htm" method="post" >
												<button type="submit" class="btn btn-sm add">ADD</button>
												<input type="hidden" name="projectid" value="<%=projectid%>">
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
											</form>
										</td>
										<td>										
											<a  class="btn btn-sm back" href="MainDashBoard.htm">BACK</a>
										</td>
									</tr>
								</table>
							</div>							
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>		
						
						
				<div class="card-footer"><br>
				</div>
			

 <script type="text/javascript">

$(document).ready(function(){

		  $("#myTable").DataTable({
		 "lengthMenu": [10,25, 50, 75, 100 ],
		 "pagingType": "simple",
			 "pageLength": 10
	});
});
	  
</script>  
 
</body>
</html>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>PROJECT INT LIST</title>
<style type="text/css">
label {
	font-weight: bold;
	font-size: 13px;
}

.table .font {
	font-family: 'Muli', sans-serif !important;
	font-style: normal;
	font-size: 13px;
	font-weight: 400 !important;
}

.card{
box-shadow: rgba(0, 0, 0, 0.25) 0px 4px 14px;
border-radius: 10px;
border: 0px;
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

.fa-long-arrow-right {
	font-size: 2.20rem;
	padding: 0px 5px;
}

.datatable-dashv1-list table tbody tr td {
	padding: 8px 10px !important;
}

.card-deck{
display: grid;
  grid-template-columns: 1fr 1fr 1fr;
}

.pagin{
display: grid;
float:left;
  grid-template-columns: 1fr 1fr 1fr;
}

.table-project-n {
	color: #005086;
}

#table thead tr th {
	padding: 0px 0px !important;
}

#table tbody tr td {
	padding: 2px 3px !important;
}

/* icon styles */
.cc-rockmenu {
	color: fff;
	padding: 0px 5px;
	font-family: 'Lato', sans-serif;
	height: 28px;
}

.col-xl{
height: 28px;
}

.cc-rockmenu .rolling {
	display: inline-block;
	cursor: pointer;
	width: 34px;
	height: 28px;
	text-align: left;
	overflow: hidden;
	transition: all 0.3s ease-out;
	white-space: nowrap;
}

.cc-rockmenu .rolling:hover {
	width: 108px;
}

.cc-rockmenu .rolling .rolling_icon {
	float: left;
	z-index: 9;
	display: inline-block;
	width: 28px;
	height: 28px;
	box-sizing: border-box;
	margin: 0 5px 0 0;
}

.sameline{
display: inline-block;
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

.editable-click{
float: left;
z-index: 9;
white-space: nowrap;
height: 28px;
margin: 0 5px 0 0;
box-sizing: border-box;
display: inline-block;
}

.editable-clicko{
z-index: 9;
white-space: nowrap;
height: 28px;
margin: 0 5px 0 0;
box-sizing: border-box;
display: inline-block;
background: none;border-style: none;
}

.cc-rockmenu .rolling p {
	margin: 0;
}

.width {
	width: 270px !important;
}

.label {
	border-radius: 3px;
	color: white;
	padding: 1px 2px;
}

.label-primary {
	background-color: #D62AD0; /* D62AD0 */
}

.label-warning {
	background-color: #5C33F6;
}

.label-info {
	background-color: #006400;
}

.label-success {
	background-color: #4B0082;
}

.trup {
	padding: 5px 10px 0px 10px;
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
	font-size: 14px;
	font-weight: 600;
}

.trdown {
	padding: 0px 10px 5px 10px;
	border-bottom-left-radius: 5px;
	border-bottom-right-radius: 5px;
	font-size: 14px;
	font-weight: 600;
}
.custom-style {
    background-color: #fff3ab; 
    color: #333; 
    border: 1px solid #ddc67b;
    pointer-events: none; 
    user-select: none; 
}

.custom-sn-style {
    background-color: #5d7cf4; 
    color: white; 
    border: 1px solid #497bd9;
    pointer-events: none; 
    user-select: none; 
}


</style>
</head>
<body>
	
	<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
List<Object[]> ProjectIntiationList=(List<Object[]>) request.getAttribute("ProjectIntiationList");
List<Object[]> projectapprovalflowempdata=(List<Object[]>) request.getAttribute("projectapprovalflowempdata");

DecimalFormat df=new DecimalFormat("0.00");
NFormatConvertion nfc=new NFormatConvertion();

List<Object[]> milelist = new ArrayList<>();
milelist.add(new Object[]{1, "PDR/PRC"});
milelist.add(new Object[]{2, "TIEC"});
milelist.add(new Object[]{3, "CEC"});
milelist.add(new Object[]{4, "CCM"});
milelist.add(new Object[]{5, "DMC"});
milelist.add(new Object[]{6, "Sanction"});

String labcode= (String) session.getAttribute("labcode");
%>



	<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getAttribute("resultfail");
	if(ses1!=null){
	%>


	<div align="center">

		<div class="alert alert-danger" role="alert">
			<%=ses1 %>
		</div>
	</div>
	<%}if(ses!=null){ %>
	<div align="center">
		<div class="alert alert-success" role="alert">
			<%=ses %>
		</div>

	</div>
	<%} %>


	<br>

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">

				<div class="card shadow-nohover" >

					<h4 class="card-header">Initiation List</h4>

					<div class="card-body">

<%-- 

						<table
							class="table table-bordered table-hover table-striped table-condensed "
							id="table1">
							<thead>

								<tr>
									<th>IsMain</th>
									<th>Category</th>
									<th>Title</th>
									<th>Code</th>
									<th>Security Classification</th>
									<th>Cost</th>
									<th>Duration</th>
									<th style="width: 25%">Preview, Forward and Details</th>
								</tr>
							</thead>
							<tbody>
								<%for(Object[] 	obj:ProjectIntiationList){ %>

								<tr>
									<td class="center">
										<%if(obj[8]!=null){%><%=obj[8] %>
										<%}else{ %>-<%} %>
									</td>
									<td class="center">
										<%if(obj[2]!=null){%><%=obj[2] %>
										<%}else{ %>-<%} %>
									</td>
									<td class="wrap"><%=obj[5] %></td>
									<td><%=obj[4] %></td>
									<td class="wrap">
										<%if(obj[3]!=null){%><%=obj[3] %>
										<%}else{ %>-<%} %>
									</td>
									<td class="right">
										<%if(obj[6]!=null){%><%=nfc.convert(Double.parseDouble(obj[6].toString())/100000) %>
										<%}else{ %>-<%} %> <%if(obj[6]!=null){%><%=obj[6]%><%}else{ %>-<%} %>

									</td>
									<td class="center">
										<%if(obj[7]!=null){%><%=obj[7] %>
										<%}else{ %>-<%} %>
									</td>

									<td class="left width">
										href="PreviewPage.htm?InitiationId=<%=obj[0]%>"


										<form action="PreviewPage.htm" method="POST" name="myfrm"
											style="display: inline">
											<button class="editable-click" name="InitiationId"
												value="<%=obj[0] %>" formtarget="_blank">
												<div class="cc-rockmenu">
													<div class="rolling">
														<figure class="rolling_icon">
															<img src="view/images/preview3.png">
														</figure>
														<span>Preview</span>
													</div>
												</div>
											</button>
											<input type="hidden" name="${_csrf.parameterName}"
												value="${_csrf.token}" />
										</form>


										<form action="ProjectIntiationForward.htm" method="POST"
											name="myfrm" style="display: inline">
											<button class="editable-click" name="InitiationId"
												value="<%=obj[0]%>"
												onclick="return confirm('Are You Sure To Forward this Project?');">
												<div class="cc-rockmenu">
													<div class="rolling">
														<figure class="rolling_icon">
															<img src="view/images/forward1.png">
														</figure>
														<span>Forward</span>
													</div>
												</div>
											</button>
											<input type="hidden" name="${_csrf.parameterName}"
											value="${_csrf.token}" /> 
											<input type="hidden" name="projectcode" value="<%=obj[4] %>" /> 
											<input type="hidden" name="pdd" value="<%=obj[9] %>" /> 
											<input type="hidden" name="labcode" value="<%=obj[10] %>">
										</form>


										<form action="ProjectIntiationListSubmit.htm" method="POST"
											name="myfrm" style="display: inline">
											<button class="editable-click" name="sub" value="Details">
												<div class="cc-rockmenu">
													<div class="rolling">
														<figure class="rolling_icon">
															<img src="view/images/clipboard.png">
														</figure>
														<span>Details</span>
													</div>
												</div>
											</button>

											<input type="hidden" name="btSelectItem" value="<%=obj[0] %>" />
											<input type="hidden" name="${_csrf.parameterName}"
												value="${_csrf.token}" />

										</form>

										<form action="IntiationChecklist.htm" method="POST"
											name="myfrm" style="display: inline">
											<button class="editable-click" name="InitiationId"
												value="<%=obj[0]%>">
												<div class="cc-rockmenu">
													<div class="rolling">
														<figure class="rolling_icon">
															<img src="view/images/checklist.png">
														</figure>
														<span>Checklist</span>
													</div>
												</div>
											</button>
											<input type="hidden" name="${_csrf.parameterName}"
												value="${_csrf.token}" /> <input type="hidden"
												name="initiationid" value="<%=obj[0] %>" />
										</form>


									</td>

								</tr>
								<%} %>
							</tbody>
							<tfoot>
								<tr>

									<td colspan="8" align="right"><b>Cost In Lakhs,
											Duration In Months.</b></td>
											
								</tr>

							</tfoot>

						</table>


 --%>

					</div>
					
					<!-- search box -->
					<form method="get" class="form-inline my-2 my-lg-0" style="display: flex; justify-content: center; padding-bottom:10px;">
						<div >
							<input name="search" required class="form-control mr-sm-2" placeholder="Search" aria-label="Search" type="Search" />
							<input type="submit" class="btn btn-outline-success my-2 my-sm-0" name="clicked" value="Search" />
						</div>
					</form>
					<!-- search ends -->
					
					
					<!-- card project visualizations -->
					<div style="display: flex; justify-content: center;padding-bottom:10px;position: relative;">
						<div class="card-deck" style="position: relative;">
							<%for(Object[] 	obj:ProjectIntiationList){ %>
							
							<div class="card" style="margin:10px;min-width:447px; margin-left: 20px;margin-right: 20px;max-width:450px;">
								<div class="card-body">
									<div class="container">
				  						<div class="row">
					  						<div class="col-lg">
												<h4 class="card-title" ><%=obj[5] %></h4></div>
											<div class="col-">
												<p> <%if(obj[8]!=null){if(obj[8].equals('Y')){%><%="MAIN" %>
													<%}else{ %><%="SUB" %> <% }}else{ %> - <%} %>
												</p>
											</div>
										</div>
									</div>
									
									<div class="container">
				  						<div class="row">
					  						<div class="col-lg">
												<h6> <%if(obj[2]!=null){%><%=obj[2] %></h6>
											</div>
											<div class="col-" style="text-align: right;">
												<h6><%if(obj[6]!=null){%><%=obj[6] %> lakhs
												<%}else{ %>-<%} %>
												</h6> 
											</div>
										</div>
									</div>
									
									
									<div class="container">
				  						<div class="row">
											<div class="col-xl">
											code: <%if(obj[4]!=null){%><%=obj[4] %>
											<%}else{ %>-<%} %>
											<br/></div>
										</div>
									</div>
									
									<div class="container">
				  						<div class="row">
											<div class="col-xl">
											security classification: <%if(obj[3]!=null){%><%=obj[3] %>
											<%}else{ %>-<%} %>
											<br/>
											</div>
										</div>
									</div>
									
									<div class="container" style="height: 50px;">
				  						<div class="row">
											<div class="col-xl">
												duration: <%if(obj[7]!=null){%><%=obj[7] %> months
												<%}else{ %>-<%} %>
												<br/>
											</div>
										</div>
									</div>
												
									<div style="position: absolute ;bottom: 0px;margin-bottom: 15px;padding-top: 10px;">
										<div class="container">
					  						<div class="row">
												<div class="col-xl">
												
												
													<form action="PreviewPage.htm" method="POST" name="myfrm"
														style="display: inline">
														<button class="editable-clicko" name="InitiationId"
															value="<%=obj[0] %>" formtarget="_blank">
															<div class="cc-rockmenu">
																<div class="rolling">
																	<figure class="rolling_icon">
																		<img src="view/images/preview3.png">
																	</figure>
																	<span>Preview</span>
																</div>
															</div>
														</button>
														<input type="hidden" name="${_csrf.parameterName}"
															value="${_csrf.token}" />
													</form>
											
											<%if(!labcode.equalsIgnoreCase("ADE")){ %>
													<form action="ProjectIntiationForward.htm" method="POST"
														name="myfrm" style="display: inline">
														<button class="editable-clicko" name="InitiationId"
															value="<%=obj[0]%>"
															onclick="return confirm('Are You Sure To Forward this Project?');">
															<div class="cc-rockmenu">
																<div class="rolling">
																	<figure class="rolling_icon">
																		<img src="view/images/forward1.png">
																	</figure>
																	<span>Forward</span>
																</div>
															</div>
														</button>
														<input type="hidden" name="${_csrf.parameterName}"
															value="${_csrf.token}" /> <input type="hidden"
															name="projectcode" value="<%=obj[4] %>" /> <input
															type="hidden" name="pdd" value="<%=obj[9] %>" /> <input
															type="hidden" name="labcode" value="<%=obj[10] %>">
													</form>
													<%} %>
							
													<form action="ProjectIntiationListSubmit.htm" method="POST"
														name="myfrm" style="display: inline">
														<button class="editable-clicko" name="sub" value="Details">
															<div class="cc-rockmenu">
																<div class="rolling">
																	<figure class="rolling_icon">
																		<img src="view/images/clipboard.png">
																	</figure>
																	<span>Details</span>
																</div>
															</div>
														</button>
							
														<input type="hidden" name="btSelectItem" value="<%=obj[0] %>" />
														<input type="hidden" name="${_csrf.parameterName}"
															value="${_csrf.token}" />
							
													</form>
							
													<form action="IntiationChecklist.htm" method="POST"
														name="myfrm" style="display: inline">
														<button class="editable-clicko" name="InitiationId"
															value="<%=obj[0]%>">
															<div class="cc-rockmenu">
																<div class="rolling">
																	<figure class="rolling_icon">
																		<img src="view/images/checklist.png">
																	</figure>
																	<span>Checklist</span>
																</div>
															</div>
														</button>
														<input type="hidden" name="${_csrf.parameterName}"
															value="${_csrf.token}" /> <input type="hidden"
															name="initiationid" value="<%=obj[0] %>" />
													 </form>
													 
													 <%if(labcode.equalsIgnoreCase("ADE")){ %>
														<button class="editable-clicko" type="button" name="InitiationId" onclick="openMilestone('<%=obj[0]%>','<%=obj[5] %>')"
															value="<%=obj[0]%>">
															<div class="cc-rockmenu">
																<div class="rolling">
																	<figure class="rolling_icon">
																		<img src="view/images/document.png">
																	</figure>
																	<span>Milestone</span>
																</div>
															</div>
														</button>
														
														<%} %>
														<input type="hidden" name="${_csrf.parameterName}"
															value="${_csrf.token}" /> <input type="hidden"
															name="initiationid" value="<%=obj[0] %>" />
												
												
										<form action="IntiationFlow.htm" method="POST"
														name="myfrm" style="display: inline">
														<button class="editable-clicko" name="InitiationId"
															value="<%=obj[0]%>">
															<div class="cc-rockmenu">
																<div class="rolling">
																	<figure class="rolling_icon">
																		<img src="view/images/assign.jpg">
																	</figure>
																	<span>Approval Flow</span>
																</div>
															</div>
														</button>
														<input type="hidden" name="${_csrf.parameterName}"
															value="${_csrf.token}" /> <input type="hidden"
															name="initiationid" value="<%=obj[0] %>" />
													 </form>
												
												</div>
											</div>
										</div>
									</div>
							</div>
							</div>
								
							
							<%}} %></div>
							<br/><br/>						
						
					</div>
					<!-- card project visualizations FINISH -->
					
					<div class="pagin" style="display: flex; justify-content: center;padding-bottom:10px;">
					<nav aria-label="Page navigation example" >
						<div class="pagination" >
							<% int pagin = Integer.parseInt(request.getAttribute("pagination").toString()) ; %>
							
							<div class="page-item">
								<form method="get" action="ProjectIntiationList.htm" onsubmit="return verify()">
									<input class="page-link" type="submit" <%if(pagin==0){ %>disabled<%} %> value="prev" />
									<% if (request.getAttribute("searchFactor")!=null){ %><input type="hidden" value="<%= request.getAttribute("searchFactor").toString() %>" name="search" /><%} %>
									<input type="hidden" id="pagination" name="pagination" value=<%=pagin-1 %> />
								</form>
							</div>
							<div class="page-item">
							<input class="page-link" type="button" value="<%=pagin+1 %>" disabled/>
							</div>
							<div class="page-item">
								<form method="get" action="ProjectIntiationList.htm" >
								<% int last=pagin+2;if(Integer.parseInt(request.getAttribute("maxpagin").toString())<last)
										last=0; %>
									<input class="page-link" type="submit" value="next" <%if(last==0){ %><%="disabled"%><%} %> />
									
									<input type="hidden" name="pagination" value=<%=pagin+1 %> />
								</form>
							</div>
						</div>
					</nav>
					</div>

					<hr>


<%-- 					<div class="row">
						<div class="col-md-12" style="text-align: center;">
							<b>Approval Flow</b>
						</div>
					</div>
					<div class="row"
						style="text-align: center; padding-top: 10px; padding-bottom: 15px;">
						<table align="center">
							<tr>
								<td class="trup" style="background: #B5EAEA;">Division Head
								</td>
								<td rowspan="2"><i class="fa fa-long-arrow-right "
									aria-hidden="true"></i></td>

								<td class="trup" style="background: #C6B4CE;">DO-P&C <!-- P&C DO -->

								</td>
								<td rowspan="2"><i class="fa fa-long-arrow-right "
									aria-hidden="true"></i></td>

								<td class="trup" style="background: #E8E46E;">AD</td>
								<td rowspan="2"><i class="fa fa-long-arrow-right "
									aria-hidden="true"></i></td>

								<td class="trup" style="background: #FBC7F7;">TCM</td>
								<!-- 		<td rowspan="2">
				                			<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
				                		</td> -->
								<!-- 	<td class="trup" style="background: #FBC7F7;" >
				                			CCM
				                		</td> -->

							</tr>

							<tr>
								<td class="trdown" style="background: #B5EAEA;">
									  <%if(projectapprovalflowempdata.size()>0){ %>
							                     <%for(Object[] obj : projectapprovalflowempdata){ %>
							                     	<%if(obj[3].toString().equals("Division Head") ){ %>
							                     		<%=obj[1] %>,<%=obj[2] %>
							                     	<%} %>
							                     <%} %>
							               <%} %>      

								</td>
								<td class="trdown" style="background: #C6B4CE;">
									<%if(projectapprovalflowempdata.size()>0){ %> <%for(Object[] obj : projectapprovalflowempdata){ %>
									<%if(obj[3].toString().equals("DO-RTMD") ){ %> <%=obj[1] %>,<%=obj[2] %>
									<%} %> <%} %> <%} %>
								</td>
								<td class="trdown" style="background: #E8E46E;">
									<%if(projectapprovalflowempdata.size()>0){ %> <%for(Object[] obj : projectapprovalflowempdata){ %>
									<%if(obj[3].toString().equals("AD") ){ %> <%=obj[1] %>,<%=obj[2] %>
									<%} %> <%} %> <%} %>
								</td>
								<td class="trdown" style="background: #FBC7F7;">
									<%if(projectapprovalflowempdata.size()>0){ %> 
										<%for(Object[] ob : projectapprovalflowempdata){ %>
											<%if(ob[3].toString().equals("TCM") ){ %>
												<%=ob[1] %>,<br><%=ob[2] %>
											<%} %> 
										<%} %> 
									<%} %>
								</td>
								<!-- <td class="trdown" style="background: #FBC7F7;" >	
				                			
				                		</td> -->
							</tr>
						</table>
					</div> --%>
					
					
				</div>
			</div>
		</div>
	</div>
	
	   <div class="modal fade bd-example-modal-lg" id="milestoneModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-lg" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="milestoneModalLabel">
		        <span style="color: #FF3D00;font-weight: 600"></span>
		        </h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
				 <div class="container">
				   <div id="data1">
				     <form id="milestoneForm" action="ProjectMilestoneSubmit.htm" method="post" autocomplete="off">
					    <div class="form-row">
					        <div class="form-group col-md-1" align="center">
					            <label for="sn" style="font-size: medium;">SN</label>
					        </div>
					        <div class="form-group col-md-5" align="center">
					            <label for="name" style="font-size: medium;">Status Name</label>
					        </div>
					        <div class="form-group col-md-6 probable-date-header" align="center">
					            <label for="date" style="font-size: medium;">Probable Date</label>
					        </div>
					        <div class="form-group col-md-3 actual-date-header" align="center">
					            <label for="date" style="font-size: medium;">Actual Date</label>
					        </div>
					    </div>
					
					    <div id="milestoneContainer" class="form-row">
					    
					    </div>
					    <div align="center">
						   <button type="button" id="submitButton"  name="action" value="add" class="btn btn-success" onclick="addSubmit('add')" style="font-weight: 500">ADD</button>
						   <input type="hidden" name="action" value="" id="actiontype">
						   <button type="button" name="action" value="edit" class="btn btn-warning" onclick="addSubmit('edit')" style="font-weight: 500; display:none;">EDIT</button>
						   <button type="button" name="action" value="baseline" class="btn btn-primary" onclick="addSubmit('baseline')" style="font-weight: 500; display:none;">SET BASELINE</button>
						   <button type="button" name="action" value="revise" class="btn btn-primary" onclick="addSubmit('revise')" style="font-weight: 500; display:none;">REVISE</button>
						   <button type="button" name="action" value="setactualdate" class="btn btn-secondary" onclick="openActualDate()" style="font-weight: 500; display:none;">UPDATE ACTUALDATE</button>
					       <input type="hidden" name="initiationid" id="projectIniId" value="" />
					       <input type="hidden" name="project" id="project" value="" />
					       <input type="hidden" name="remarks" id="remarksField" />
					       <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
					    </div>
					</form>
				  </div>
			       <div id="data2">
					    <div class="row">
					        <div class="col-md-6">
					             <label for="milestone">Select Milestone:</label>
					            <select id="mileDropdown" name="mileDropdown" class="form-control selectdee" style="width: 100%;">
					               
					            </select>
					        </div>
					        <div class="col-md-6">
				                <label for="dateInput">Select Date:</label>
				                  <div class="input-group">
				                   <input type="text" name="actualNameDate" id="actualdateId" class="form-control date-picker1"/>
			                         <div class="input-group-append">
			                             <span class="input-group-text"><i class="fa fa-calendar" aria-hidden="true"></i></span>
			                         </div>
			                     </div>
					        </div>
					    </div>
					   <div align="center">
					    <button type="button" id="actualSubmit" class="btn btn-success mt-3" onclick="actualSubmit()" style="font-weight: 500">SUBMIT</button>
					    <button type="button" class="btn btn-info mt-3" onclick="actualBack()" style="font-weight: 500">BACK</button>
					     <input type="hidden" name="milestonepkId" id="milestonepkId" value="">
					   </div>
					</div>
				  </div>
				</div>  
		      </div>
		    </div>
		  </div>
		  
		  <!-- Modal for Revision Remarks -->
		<div class="modal fade" id="remarksModal" tabindex="-1" role="dialog" aria-labelledby="remarksModalLabel" aria-hidden="true">
		    <div class="modal-dialog" role="document">
		        <div class="modal-content">
		            <div class="modal-header">
		                <h5 class="modal-title" id="remarksModalLabel">Remark for Revise</h5>
		                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		                    <span aria-hidden="true">&times;</span>
		                </button>
		            </div>
		            <div class="modal-body">
		                <textarea id="remarksInput" class="form-control" placeholder="Enter your remarks here..." rows="4"></textarea>
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-secondary" data-dismiss="modal">CANCEL</button>
		                <button type="button" class="btn btn-primary" id="saveRemarksButton">SUBMIT</button>
		            </div>
		        </div>
		    </div>
		</div>
		  
		  
	
<script type="text/javascript">

$(function () {
	  $('[data-toggle="tooltip"]').tooltip()
	})


function Prints(myfrm){
	
	 var fields = $("input[name='btSelectItem']").serializeArray();
	  if (fields.length === 0){
		  myalert();
	 event.preventDefault();
	return false;
	}
		  return true;
	}


$(document).ready(function(){
	
	$("#table1").DataTable({
		"pageLength": 5
	})
})



function update(){
	$.ajax({		
		type : "GET",
		url : "ProjectInitList.htm",
		datatype : 'json',
		success: function(result){
			var result0 = result[0];
			console.log(result[0]);
						}
		});
} 

function verify(){
const ele = document.getElementById("pagination").value;
if(ele<0)
{
	console.log(ele);
	return false;
}
return true;
}

function openMilestone(initiationid, projectname) {
    var milelist = <%= new Gson().toJson(milelist) %>;
    $('#milestoneModal').modal('show');
    
    // Initially hide buttons and reset headers
    $('button[name="action"][value="add"]').hide();
    $('button[name="action"][value="edit"]').hide();
    $('button[name="action"][value="revise"]').hide();
    $('button[name="action"][value="baseline"]').hide();
    $('button[name="action"][value="setactualdate"]').hide();
    $('.actual-date-header').hide();
    $('#data1').show();
    $('#data2').hide();
    $('.probable-date-header').removeClass('col-md-3').addClass('col-md-6');
    
    milelist.forEach(function(mile) {
        var statusid = mile[0];   
        var statusname = mile[1];
        milestoneBody(initiationid,statusid,statusname);
    });
    
    $('#milestoneModal .modal-title').html('<span style="color: #FF3D00;">Project : ' + projectname + '</span>');
    $('#projectIniId').val(initiationid);
    $('#project').val(projectname);
}


function milestoneBody(initiationid,statusid,statusname){
	
    var milestoneContainer = $('#milestoneContainer');
    $('.mileContainer').remove();
    milestoneContainer.append('<div class="mileContainer row"></div>');
	
	 $.ajax({
         type: "GET",
         url: "InitiatedMilestoneDetails.htm",
         data: { initiationid: initiationid },
         datatype: 'json',
         success: function(result) {
             var cleanedResult = result.replace(/^"|"$/g, '').replace(/\\/g, '');

             if (cleanedResult === "-1" || cleanedResult === "") {
                 // No data, show Add button and create empty fields
                 $('button[name="action"][value="add"]').show();

                 var rowHtml = 
                     '<div class="form-group col-md-1">' +
                         '<input class="form-control custom-sn-style" type="text" value="' + statusid + '" style="font-size: 16px;font-weight: 500; text-align: center;">' +
                         '<input type="hidden" name="statusId" value="' + statusid + '">'+
                     '</div>' +
                     '<div class="form-group col-md-6">' +
                         '<input type="text" class="form-control custom-style" id="statusname_' + initiationid + '" name="statusName" value="' + statusname + '" style="font-size: 16px;font-weight: 500;">' +
                     '</div>' +
                     '<div class="form-group col-md-5">' +
                     '<div class="input-group">' +
                         '<input type="text" class="form-control probableDateField date-picker" id="probdate_' + initiationid + '" name="probableDate" ' +
                         'placeholder="Select Date">' +
                         '<div class="input-group-append">' +
                             '<span class="input-group-text"><i class="fa fa-calendar" aria-hidden="true"></i></span>' +
                         '</div>' +
                      '</div>' +
                     '</div>';

                     $('.mileContainer').append(rowHtml);
                 initializeDatePickers(); 
             } else {
            	 if(result!=null && result!=''){
                 var values = JSON.parse(result);

                 if (values.length > 0) {
                     $('button[name="action"][value="edit"]').show();
                     $('button[name="action"][value="baseline"]').show();

                     values.forEach(function(item) {
                         const probDateFormat = formatDate(item[3]);
                         var initiationId = item[1];
                         var milestoneId = item[0];
                         var PDRActualDate = item[3];
                         var showActualDate = item[14] === 'Y';

                         $('#milestonepkId').val(milestoneId);
          				
          				if(PDRActualDate!=null){
          					showActualDate=false;
          				}

                             var rowHtml = 
                                 '<div class="form-group col-md-1 ">' +
                                     '<input class="form-control custom-sn-style" type="text" value="' + statusid + '" style="font-size: 16px;font-weight: 500; text-align: center;">' +
                                     '<input type="hidden" name="initiationMilestoneId" value="' + milestoneId + '">'+
                                     '<input type="hidden" name="statusId" value="' + statusid + '">'+
                                 '</div>' +
                                 '<div class="form-group col-md-5">' +
                                     '<input type="text" class="form-control custom-style" id="statusname_' + initiationid + '" name="statusName" value="' + statusname + '" style="font-size: 16px;font-weight: 500;">' +
                                 '</div>';

                          if (showActualDate) {
                                 if(statusid==1){
                                 	  rowHtml +=
                                          '<div class="form-group col-md-6">' +
                                           '<div class="input-group">' +  
                                               '<input type="text" class="form-control date-picker" id="probdate_' + initiationid + '" name="probableDate" value="' + formatDate(item[2]) + '">' +
                                               '<div class="input-group-append">' + 
                                               '<span class="input-group-text"><i class="fa fa-calendar" aria-hidden="true"></i></span>' +
                                             '</div>' +
                                           '</div>' + 
                                          '</div>' ;
                             	}else if(statusid==2){
                             		 rowHtml +=
                                          '<div class="form-group col-md-6">' +
                                           '<div class="input-group">' +  
                                               '<input type="text" class="form-control date-picker" id="probdate_' + initiationid + '" name="probableDate" value="' + formatDate(item[4]) + '">' +
                                               '<div class="input-group-append">' + 
                                               '<span class="input-group-text"><i class="fa fa-calendar" aria-hidden="true"></i></span>' +
                                             '</div>' +
                                           '</div>' + 
                                          '</div>' ;
                             	}else if(statusid==3){
                             		 rowHtml +=
                                          '<div class="form-group col-md-6">' +
                                           '<div class="input-group">' +  
                                               '<input type="text" class="form-control date-picker" id="probdate_' + initiationid + '" name="probableDate" value="' + formatDate(item[6]) + '">' +
                                               '<div class="input-group-append">' + 
                                               '<span class="input-group-text"><i class="fa fa-calendar" aria-hidden="true"></i></span>' +
                                             '</div>' +
                                           '</div>' + 
                                          '</div>' ;
                             	}else if(statusid==4){
                             		 rowHtml +=
                                          '<div class="form-group col-md-6">' +
                                           '<div class="input-group">' +  
                                               '<input type="text" class="form-control date-picker" id="probdate_' + initiationid + '" name="probableDate" value="' + formatDate(item[8]) + '">' +
                                               '<div class="input-group-append">' + 
                                               '<span class="input-group-text"><i class="fa fa-calendar" aria-hidden="true"></i></span>' +
                                             '</div>' +
                                           '</div>' + 
                                          '</div>' ;
                             	}else if(statusid==5){
                             		 rowHtml +=
                                          '<div class="form-group col-md-6">' +
                                           '<div class="input-group">' +  
                                               '<input type="text" class="form-control date-picker" id="probdate_' + initiationid + '" name="probableDate" value="' + formatDate(item[10]) + '">' +
                                               '<div class="input-group-append">' + 
                                               '<span class="input-group-text"><i class="fa fa-calendar" aria-hidden="true"></i></span>' +
                                             '</div>' +
                                           '</div>' + 
                                          '</div>' ;
                             	}else if(statusid==6){
                             		 rowHtml +=
                                          '<div class="form-group col-md-6">' +
                                           '<div class="input-group">' +  
                                               '<input type="text" class="form-control date-picker" id="probdate_' + initiationid + '" name="probableDate" value="' + formatDate(item[12]) + '">' +
                                               '<div class="input-group-append">' + 
                                               '<span class="input-group-text"><i class="fa fa-calendar" aria-hidden="true"></i></span>' +
                                             '</div>' +
                                           '</div>' + 
                                          '</div>' ;
                             	}
                                 
                                 $('button[name="action"][value="edit"]').hide();
                                 $('button[name="action"][value="baseline"]').hide();
                                 $('button[name="action"][value="revise"]').show();
                                 $('button[name="action"][value="setactualdate"]').show();
                             } else if(PDRActualDate){
                            	  if(statusid==1){
                                 	  rowHtml +=
                                 		 '<div class="form-group col-md-3">' +
                                         '<div class="input-group">' +  
                                         '<input type="text" class="form-control ' + (item[3] != null ? '' : 'date-picker') + '" id="probdate_' + initiationid + '" name="probableDate" value="' + formatDate(item[2]) + '" ' + (item[3] != null ? 'readonly' : '') + '>' +
                                             '<div class="input-group-append">' + 
                                             '<span class="input-group-text"><i class="fa fa-calendar" aria-hidden="true"></i></span>' +
                                           '</div>' +
                                         '</div>' + 
                                        '</div>'+
                                          '<div class="form-group col-md-3">' +
                                           '<div class="input-group">' +  
                                           '<input type="text" class="form-control " id="actualdate_' + initiationid + '" name="actualDate" value="' + formatDate(item[3]) + '" readonly>' +
                                               '<div class="input-group-append">' + 
                                               '<span class="input-group-text"><i class="fa fa-calendar" aria-hidden="true"></i></span>' +
                                             '</div>' +
                                           '</div>' + 
                                          '</div>' ;
                             	}else if(statusid==2){
                             		 rowHtml +=
                             			 '<div class="form-group col-md-3">' +
                                         '<div class="input-group">' +  
                                             '<input type="text" class="form-control ' + (item[5] != null ? '' : 'date-picker') + '" id="probdate_' + initiationid + '" name="probableDate" value="' + formatDate(item[4]) + '" ' + (item[5] != null ? 'readonly' : '') + '>' +
                                             '<div class="input-group-append">' + 
                                             '<span class="input-group-text"><i class="fa fa-calendar" aria-hidden="true"></i></span>' +
                                           '</div>' +
                                         '</div>' + 
                                        '</div>'+
                                          '<div class="form-group col-md-3">' +
                                           '<div class="input-group">' +  
                                           '<input type="text" class="form-control" id="actualdate_' + initiationid + '" name="actualDate" value="' + formatDate(item[5]) + '" readonly>' +
                                               '<div class="input-group-append">' + 
                                               '<span class="input-group-text"><i class="fa fa-calendar" aria-hidden="true"></i></span>' +
                                             '</div>' +
                                           '</div>' + 
                                          '</div>' ;
                             	}else if(statusid==3){
                             		 rowHtml +=
                             			 '<div class="form-group col-md-3">' +
                                         '<div class="input-group">' +  
                                             '<input type="text" class="form-control ' + (item[7] != null ? '' : 'date-picker') + '" id="probdate_' + initiationid + '" name="probableDate" value="' + formatDate(item[6]) + '" ' + (item[7] != null ? 'readonly' : '') + '>' +
                                             '<div class="input-group-append">' + 
                                             '<span class="input-group-text"><i class="fa fa-calendar" aria-hidden="true"></i></span>' +
                                           '</div>' +
                                         '</div>' + 
                                        '</div>'+
                                          '<div class="form-group col-md-3">' +
                                           '<div class="input-group">' +  
                                           '<input type="text" class="form-control" id="actualdate_' + initiationid + '" name="actualDate" value="' + formatDate(item[7]) + '" readonly>' +
                                               '<div class="input-group-append">' + 
                                               '<span class="input-group-text"><i class="fa fa-calendar" aria-hidden="true"></i></span>' +
                                             '</div>' +
                                           '</div>' + 
                                          '</div>' ;
                             	}else if(statusid==4){
                             		 rowHtml +=
                             			 '<div class="form-group col-md-3">' +
                                         '<div class="input-group">' +  
                                             '<input type="text" class="form-control ' + (item[9] != null ? '' : 'date-picker') + '" id="probdate_' + initiationid + '" name="probableDate" value="' + formatDate(item[8]) + '" ' + (item[9] != null ? 'readonly' : '') + '>' +
                                             '<div class="input-group-append">' + 
                                             '<span class="input-group-text"><i class="fa fa-calendar" aria-hidden="true"></i></span>' +
                                           '</div>' +
                                         '</div>' + 
                                        '</div>'+
                                          '<div class="form-group col-md-3">' +
                                           '<div class="input-group">' +  
                                           '<input type="text" class="form-control" id="actualdate_' + initiationid + '" name="actualDate" value="' + formatDate(item[9]) + '" readonly>' +
                                               '<div class="input-group-append">' + 
                                               '<span class="input-group-text"><i class="fa fa-calendar" aria-hidden="true"></i></span>' +
                                             '</div>' +
                                           '</div>' + 
                                          '</div>' ;
                             	}else if(statusid==5){
                             		 rowHtml +=
                             			 '<div class="form-group col-md-3">' +
                                         '<div class="input-group">' +  
                                             '<input type="text" class="form-control ' + (item[11] != null ? '' : 'date-picker') + '" id="probdate_' + initiationid + '" name="probableDate" value="' + formatDate(item[10]) + '" ' + (item[11] != null ? 'readonly' : '') + '>' +
                                             '<div class="input-group-append">' + 
                                             '<span class="input-group-text"><i class="fa fa-calendar" aria-hidden="true"></i></span>' +
                                           '</div>' +
                                         '</div>' + 
                                        '</div>'+
                                          '<div class="form-group col-md-3">' +
                                           '<div class="input-group">' +  
                                           '<input type="text" class="form-control" id="actualdate_' + initiationid + '" name="actualDate" value="' + formatDate(item[11]) + '" readonly>' +
                                               '<div class="input-group-append">' + 
                                               '<span class="input-group-text"><i class="fa fa-calendar" aria-hidden="true"></i></span>' +
                                             '</div>' +
                                           '</div>' + 
                                          '</div>' ;
                             	}else if(statusid==6){
                             		 rowHtml +=
                             			 '<div class="form-group col-md-3">' +
                                         '<div class="input-group">' +  
                                             '<input type="text" class="form-control ' + (item[13] != null ? '' : 'date-picker') + '" id="probdate_' + initiationid + '" name="probableDate" value="' + formatDate(item[12]) + '" ' + (item[13] != null ? 'readonly' : '') + '>' +
                                             '<div class="input-group-append">' + 
                                             '<span class="input-group-text"><i class="fa fa-calendar" aria-hidden="true"></i></span>' +
                                           '</div>' +
                                         '</div>' + 
                                        '</div>'+
                                          '<div class="form-group col-md-3">' +
                                           '<div class="input-group">' +  
                                           '<input type="text" class="form-control" id="actualdate_' + initiationid + '" name="actualDate" value="' + formatDate(item[13]) + '" readonly>' +
                                               '<div class="input-group-append">' + 
                                               '<span class="input-group-text"><i class="fa fa-calendar" aria-hidden="true"></i></span>' +
                                             '</div>' +
                                           '</div>' + 
                                          '</div>' ;
                             	}
                            	  $('.actual-date-header').show();
                                  $('.probable-date-header').removeClass('col-md-6').addClass('col-md-3');
                                  $('button[name="action"][value="edit"]').hide();
                                  $('button[name="action"][value="baseline"]').hide();
                                  $('button[name="action"][value="revise"]').show();
                                  $('button[name="action"][value="setactualdate"]').show();
                            	 
                             } else {
                             	if(statusid==1){
                             		 rowHtml +=
                                          '<div class="form-group col-md-6">' +
                                           '<div class="input-group">' +  
                                               '<input type="text" class="form-control date-picker" id="probdate_' + initiationid + '" name="probableDate" value="' + formatDate(item[2]) + '" placeholder="Select Date">' +
                                               '<div class="input-group-append">' + 
                                               '<span class="input-group-text"><i class="fa fa-calendar" aria-hidden="true"></i></span>' +
                                             '</div>' +
                                           '</div>' + 
                                          '</div>' ;
                             	}else if(statusid==2){
                             		 rowHtml +=
                                          '<div class="form-group col-md-6">' +
                                           '<div class="input-group">' +  
                                               '<input type="text" class="form-control date-picker" id="probdate_' + initiationid + '" name="probableDate" value="' + formatDate(item[4]) + '" placeholder="Select Date">' +
                                               '<div class="input-group-append">' + 
                                               '<span class="input-group-text"><i class="fa fa-calendar" aria-hidden="true"></i></span>' +
                                             '</div>' +
                                           '</div>' + 
                                          '</div>' ;
                             	}else if(statusid==3){
                             		 rowHtml +=
                                          '<div class="form-group col-md-6">' +
                                           '<div class="input-group">' +  
                                               '<input type="text" class="form-control date-picker" id="probdate_' + initiationid + '" name="probableDate" value="' + formatDate(item[6]) + '" placeholder="Select Date">' +
                                               '<div class="input-group-append">' + 
                                               '<span class="input-group-text"><i class="fa fa-calendar" aria-hidden="true"></i></span>' +
                                             '</div>' +
                                           '</div>' + 
                                          '</div>' ;
                             	}else if(statusid==4){
                             		 rowHtml +=
                                          '<div class="form-group col-md-6">' +
                                           '<div class="input-group">' +  
                                               '<input type="text" class="form-control date-picker" id="probdate_' + initiationid + '" name="probableDate" value="' + formatDate(item[8]) + '" placeholder="Select Date">' +
                                               '<div class="input-group-append">' + 
                                               '<span class="input-group-text"><i class="fa fa-calendar" aria-hidden="true"></i></span>' +
                                             '</div>' +
                                           '</div>' + 
                                          '</div>' ;
                             	}else if(statusid==5){
                             		 rowHtml +=
                                          '<div class="form-group col-md-6">' +
                                           '<div class="input-group">' +  
                                               '<input type="text" class="form-control date-picker" id="probdate_' + initiationid + '" name="probableDate" value="' + formatDate(item[10]) + '" placeholder="Select Date">' +
                                               '<div class="input-group-append">' + 
                                               '<span class="input-group-text"><i class="fa fa-calendar" aria-hidden="true"></i></span>' +
                                             '</div>' +
                                           '</div>' + 
                                          '</div>' ;
                             	}else if(statusid==6){
                             		 rowHtml +=
                                          '<div class="form-group col-md-6">' +
                                           '<div class="input-group">' +  
                                               '<input type="text" class="form-control date-picker" id="probdate_' + initiationid + '" name="probableDate" value="' + formatDate(item[12]) + '" placeholder="Select Date">' +
                                               '<div class="input-group-append">' + 
                                               '<span class="input-group-text"><i class="fa fa-calendar" aria-hidden="true"></i></span>' +
                                             '</div>' +
                                           '</div>' + 
                                          '</div>' ;
                             	}
                             	
                                 $('.actual-date-header').hide();
                                 $('.probable-date-header').removeClass('col-md-3').addClass('col-md-6');
                             }

                             $('.mileContainer').append(rowHtml);
                     });

                     initializeDatePickers();  
                 } else {
                     $('button[name="action"][value="add"]').show();
                 }
             }
         }
         },
         error: function(xhr, status, error) {
             console.error('AJAX Error:', error);
             $('button[name="action"][value="add"]').show();
         }
     });
}

function formatDate(dateString) {
    if (!dateString) return ''; 
    const date = new Date(dateString);
    return date.toLocaleDateString('en-GB', {
        day: '2-digit',
        month: '2-digit',
        year: 'numeric',
    }).replace(/\//g, '-');
}

function initializeDatePickers() {
 	  var selectedDates = []; 
 	  $('.date-picker').each(function(index) {
          var $input = $(this);
          var preFilledDate = $input.val(); // Get the pre-filled value, if any

          if (preFilledDate) {
              var parsedDate = moment(preFilledDate, 'DD-MM-YYYY');
              selectedDates[index] = parsedDate; // Store the date in moment format
          }

          // Initialize only the active date pickers (non-readonly)
          if (!$input.prop('readonly')) {
              $input.daterangepicker({
                  singleDatePicker: true,
                  showDropdowns: true,
                  autoUpdateInput: false,
                  locale: { format: 'DD-MM-YYYY' },
                  minDate: getMinDateForIndex(index) // Get the minDate based on previous dates
              }).on('apply.daterangepicker', function(ev, picker) {
                  var selectedDate = picker.startDate.format('DD-MM-YYYY');
                  $(this).val(selectedDate); // Set the selected date in the input field

                  // Update the selectedDates array for the current index
                  selectedDates[index] = picker.startDate;

                  // Update the minDate for the next date picker, if any
                  updateMinDateForNext(index);
              }).on('show.daterangepicker', function(ev, picker) {
                  var pickerTop = $(this).offset().top;
                  var modalTop = $('#milestoneModal').offset().top;
                  var modalHeight = $('#milestoneModal').outerHeight();

                  if ((pickerTop - modalTop) > (modalHeight / 2)) {
                      picker.drops = 'up';
                  } else {
                      picker.drops = 'down';
                  }
                  picker.move();
              });
          }
      });
 	  
 	 function getMinDateForIndex(index) {
 	    for (var i = index - 1; i >= 0; i--) {
 	        if (selectedDates[i]) return selectedDates[i]; // Return the first valid previous date
 	    }
 	    return false; // No restrictions if no previous dates found
 	}

 	function updateMinDateForNext(currentIndex) {
 	    for (var i = currentIndex + 1; i < $('.date-picker').length; i++) {
 	        var nextInput = $('.date-picker').eq(i);

 	        if (!nextInput.prop('readonly')) {
 	            // If the next input is not read-only, update its minDate
 	            nextInput.data('daterangepicker').minDate = selectedDates[currentIndex];
 	            break; // Only update the immediate next active date picker
 	        }
 	    }
 	}
}


$('.input-group-text').on('click', function() {
    $(this).prev('input').focus(); 
});

function addSubmit(value){
	$('#actiontype').val(value);
    var isValid = false;
    
    if(value === 'add'){
    $('.probableDateField').each(function() {
        if ($(this).val() !== '') {
            isValid = true;  
            return false;  
        }
    });
    if (!isValid) {
        alert('Please fill at least one date field.');
        return false; 
      }
    }
    
    if (value === 'revise') {
        $('#remarksModal').modal('show');
        $('#saveRemarksButton').off('click').on('click', function() {
            var remarks = $('#remarksInput').val().trim();

            if (remarks === '') {
                alert('Remarks are required for revision.');
                return false;
            }

            $('#remarksField').val(remarks);
            $('#remarksModal').modal('hide'); 

            if (confirm('Are you sure to submit?')) {
            	$('#milestoneModal').modal('hide');
                $('#milestoneForm').submit();
            }
        });
        
        return false; 
    }
    
    if (confirm('Are you sure to submit?')) {
    	 $('#milestoneForm').submit();
    }
};

function openActualDate(){
	$('#data1').hide();
	$('#data2').show();

   $('#mileDropdown').val('');

   $('#mileDropdown').empty().append('<option value="">Select an option</option>');
   <% for (Object[] item : milelist) { %>
       $('#mileDropdown').append('<option value="<%= item[0] %>"><%= item[1] %></option>');
   <%}%>
   
   $('.date-picker1').each(function() {
	    $(this).daterangepicker({
	        "singleDatePicker": true,
	        "linkedCalendars": false,
	        "showCustomRangeLabel": true,
	        "autoUpdateInput": true, 
	        "cancelClass": "btn-default",
	        "showDropdowns": true,
	        "drops": "down", 
	        "locale": {
	            "format": 'DD-MM-YYYY'
	        }
	    });

	});
	
}

function actualSubmit(){
	
	var initiation = $('#projectIniId').val();
	var project = $('#project').val();
	var milestonepkId = $('#milestonepkId').val();
	var mileDropdown = $('#mileDropdown').val();
	var actualdate = $('#actualdateId').val();
	
   if (mileDropdown === '' || actualdate === '') {
        alert('Please select one record!');
        if (mileDropdown === '') {
            $('#mileDropdown').css('border', '1px solid red');
        } else {
            $('#mileDropdown').css('border', ''); 
        }

        if (actualdate === '') {
            $('#actualdateId').css('border', '1px solid red');
        } else {
            $('#actualdateId').css('border', ''); 
        }
    } else {
    	
        $('#mileDropdown').css('border', '');
        $('#actualdateId').css('border', '');

	  var confirmSubmission = window.confirm("Are you sure you want to submit this form?");
	     
	     if (confirmSubmission) {
	         $.ajax({
	             type: "GET",
	             url: "addActualDate.htm", 
	             data: {milestonepkId : milestonepkId, mileDropdown : mileDropdown,
	           	  actualdate : actualdate },
	             success: function(response) {
	           	  $('#data1').show();
	           	  openMilestone(initiation, project);
	           	 alert('Actual date updated successfully!');
	             },
	             error: function(xhr, status, error) {
	                 console.log("Form submission failed: " + error);
	             }
	       });
	    }
    }
}

function actualBack(){
	$('#data2').hide();
	$('#data1').show();
}


</script>
</body>
</html>
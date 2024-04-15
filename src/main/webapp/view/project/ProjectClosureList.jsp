<%@page import="java.util.Arrays"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<!-- <style type="text/css">
/* icon styles */
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
	width: 108px;
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

th
 {
 	border: 1px solid black;
 	text-align: center;
 	padding: 5px;
 }
 
 td
 {
 	border: 1px solid black;
 	text-align: left;
 	padding: 5px;
 }
 
.btn-status {
  position: relative;
  z-index: 1; 
}

.btn-status:hover {
  transform: scale(1.05);
  z-index: 5;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
}
</style> -->

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
/* border: none;
background: none; */
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

.btn-status {
  position: relative;
  z-index: 1; 
}

.btn-status:hover {
  transform: scale(1.05);
  z-index: 5;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
}
</style>
</head>
<body>
<%
FormatConverter fc = new FormatConverter();
List<Object[]> closureList = (List<Object[]>)request.getAttribute("ClosureList");
List<String> closurecategory = Arrays.asList("Completed Successfully","Partial Success","Stage Closure","Cancellation");
%>

<% String ses=(String)request.getParameter("result");
 	String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<div align="center">
		<div class="alert alert-danger" role="alert">
	    <%=ses1 %>
	    </div>
	</div>
	<%}if(ses!=null){ %>
	<div align="center">
		<div class="alert alert-success" role="alert" >
	    	<%=ses %>
		</div>
	</div>
<%} %>
	
<br>
<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			<div class="card shadow-nohover">
				<div class="row card-header">
			   		<div class="col-md-6">
						<h4>Closure List</h4>
					</div>
				</div>
				<br>
				<%if(closureList!=null && closureList.size()>0) {%>
				<!-- search box -->
					<form method="get" class="form-inline my-2 my-lg-0" style="display: flex; justify-content: center; padding-bottom:10px;">
						<div>
						
							<input name="search" id="search" required class="form-control mr-sm-2" placeholder="Search" aria-label="Search" type="Search" />
							<input type="submit" class="btn btn-outline-success my-2 my-sm-0" name="clicked" value="Search" />
							<a href="ProjectClosureList.htm"><button type="submit" class="btn btn-outline-danger my-2 my-sm-0" formnovalidate="formnovalidate" >Reset</button></a>
							
						</div>
					</form>
				<!-- search ends -->
					
					<!-- card project visualizations -->
					<div style="display: flex; justify-content: center;padding-bottom:10px;position: relative;">
						<div class="card-deck" style="position: relative;">
							<%
							for(Object[] obj: closureList){ %>
							
								<div class="card" style="margin:10px; margin-left: 20px;margin-right: 20px;min-width:450px;">
									<div class="card-body">
									
										<div class="container">
					  						<div class="row">
						  						<div class="col-lg">
													<h4 class="card-title" ><%=obj[4] %></h4></div>
												<div class="col-">
													<p> <%if(obj[6]!=null){if(obj[6].toString().equalsIgnoreCase("1")){%><%="MAIN" %>
														<%}else{ %><%="SUB" %> <% }}else{ %> - <%} %>
													</p>
												</div>
											</div>
										</div>
										
										<div class="container">
					  						<div class="row">
						  						<div class="col-lg">
													<h6> <%if(obj[2]!=null && obj[3]!=null){%><%=obj[2]+" ("+obj[3]+")" %><%} %></h6>
												</div>
												<div class="col-" style="text-align: right;">
													<h6><%if(obj[5]!=null){ %>
													<%=String.format("%.2f", Double.parseDouble(obj[5].toString()) / 100000) %> lakhs
													<%}else{ %>-<%} %>
													</h6> 
												</div>
											</div>
										</div>
										
										<div class="container">
					  						<div class="row">
												<div class="col-xl">
												Sanctioned on : <%if(obj[7]!=null){%><%=fc.SqlToRegularDate(obj[7].toString()) %>
												<%}else{ %>-<%} %>
												<br/>
												</div>
											</div>
										</div>
										
										<div class="container">
					  						<div class="row">
												<div class="col-xl">
												PDC : <%if(obj[8]!=null){%><%=fc.SqlToRegularDate(obj[8].toString()) %>
												<%}else{ %>-<%} %>
												<br/>
												</div>
											</div>
										</div>
										
										<div class="container" style="display: inline-flex;">
											<div>Closure Category : </div>
					  						<div class="row" style="margin-top: -1%;margin-left: 1%;">
												<div class="col-xl">
												
													<form action="ProjectClosureSubmit.htm" method="post" id="closureform<%=obj[0]%>">
														<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
														<input type="hidden" name="projectId" value="<%=obj[0]%>">
														<input type="hidden" name="closureId" value="<%if(obj[14]!=null) {%><%=obj[14] %><%}else{%>0<%}%>">
														<select name="closureCategory" id="closureCategory<%=obj[0]%>" class="form-control  form-control" data-width="70%" data-live-search="true" required>
			                								<option value="-1" disabled="disabled" selected="selected">--Select--</option>
												        		<%
												                	for(String category: closurecategory ){
												               %>
																	<option value="<%=category%>" <%if(obj[16]!=null){ if(category.equalsIgnoreCase(obj[16].toString())){%>selected="selected" <%}} %>  style="text-align: left;"><%=category %></option>
																<%} %>
														</select>
													</form>
												<br/>
												</div>
											</div>
											<div>
												<button class="btn bg-transparent buttuonEd1" type="button" form="closureform<%=obj[0]%>" onclick="return checkClosureType('<%=obj[0]%>')" ><i class="fa fa-pencil-square-o fa-lg" aria-hidden="true"></i></button>
											</div>
										</div>
										
										<div class="container" style="display: inline-flex;margin-top: 1%;">
											<div>Status :</div>
					  						<div class="row" style="margin-top: -1%;margin-left: 1%;">
												<div class="col-xl">
													 <%if(obj[11]!=null) {%>
														<form action="#">
				                                        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				                                        	<input type="hidden" name="closureId" value="<%=obj[14] %>">
				                                       	  	<%if(obj[15]!=null && obj[15].toString().equalsIgnoreCase("SoC")) {%>
					                                       	  	<button type="submit" class="btn btn-sm btn-link w-100 btn-status" formaction=ProjectClosureSoCTransStatus.htm value="<%=obj[14] %>" name="closureId"  data-toggle="tooltip" data-placement="top" title="Transaction History" style=" color: <%=obj[13] %>; font-weight: 600;" formtarget="_blank">
												    				<%=obj[12] %> <i class="fa fa-telegram" aria-hidden="true" style="margin-top: 0.3rem;"></i>
												    			</button>
											    			<%} else if(obj[15]!=null && obj[15].toString().equalsIgnoreCase("ACR")) {%>
											    				<button type="submit" class="btn btn-sm btn-link w-100 btn-status" formaction=ProjectClosureACPTransStatus.htm value="<%=obj[14] %>" name="closureId"  data-toggle="tooltip" data-placement="top" title="Transaction History" style=" color: <%=obj[13] %>; font-weight: 600;" formtarget="_blank">
											    					<%=obj[12] %> <i class="fa fa-telegram" aria-hidden="true" style="margin-top: 0.3rem;"></i>
											    				</button>
											    			<%} %>
											    			
											    			
	                                        			</form>
	                                        		<%} else{%>
	                                        			<button type="button" class="btn btn-sm btn-link w-100 btn-status" data-toggle="tooltip" data-placement="top" title="Transaction History" style=" color: violet; font-weight: 600;" formtarget="_blank">
											    			Not Initiated <i class="fa fa-telegram" aria-hidden="true" style="margin-top: 0.3rem;"></i>
											    		</button>
	                                        		<%} %>
													<br/>
												</div>
											</div>
										</div>  
										
										<%-- <div class="container" style="display: inline-flex;">
											<div>ACR Status :</div>
					  						<div class="row" style="margin-top: -1%;margin-left: 1%;">
												<div class="col-xl">
													 <%if(obj[14]!=null) {%>
														<form action="#">
				                                        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				                                        	<input type="hidden" name="projectId" value="<%=obj[14] %>">
				                                       	  	
				                                       	  	<button type="submit" class="btn btn-sm btn-link w-100 btn-status" formaction=ProjectClosureACPTransStatus.htm value="<%=obj[14] %>" name="projectId"  data-toggle="tooltip" data-placement="top" title="Transaction History" style=" color: <%=obj[16] %>; font-weight: 600;" formtarget="_blank">
											    				<%=obj[15] %> <i class="fa fa-telegram" aria-hidden="true" style="margin-top: 0.3rem;"></i>
											    			</button>
	                                        			</form>
	                                        		<%} else{%>
	                                        			<button type="button" class="btn btn-sm btn-link w-100 btn-status" data-toggle="tooltip" data-placement="top" title="Transaction History" style=" color: violet; font-weight: 600;" formtarget="_blank">
											    			Not Initiated <i class="fa fa-telegram" aria-hidden="true" style="margin-top: 0.3rem;"></i>
											    		</button>
	                                        		<%} %>
													<br/>
												</div>
											</div>
										</div>  --%> 
										
										<%-- <div style="bottom: 0px;margin-bottom: 15px;">
											<div class="container">
						  						<div class="row">
													<div class="col-xl">
														<form action="#">
				                                        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				                                        	<input type="hidden" name="carsInitiationId" value="<%=obj[14] %>">
				                                       	  	<button type="submit" class="btn btn-sm btn-link w-50 btn-status" formaction=CARSTransStatus.htm value="<%=obj[14] %>" name="carsInitiationId"  data-toggle="tooltip" data-placement="top" title="Transaction History" style=" color: <%=obj[11] %>; font-weight: 600;" formtarget="_blank">
											    			<%=obj[10] %> <i class="fa fa-telegram" aria-hidden="true" style="float: right;margin-top: 0.3rem;"></i>
											    			</button>
	                                        			</form>
													</div>
												</div>
											</div>
										</div> --%>
										
										<%if(obj[14]!=null) {%>		
										<div style="bottom: 0px;margin-bottom: 15px;padding-top: 10px;">
											<div class="container">
						  						<div class="row" style="">
													<div class="col-xl">
													
														<form action="#" method="post">
		                                        			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		                                        				
		                                        				<%if(obj[15]!=null && obj[15].toString().equalsIgnoreCase("SoC")) {%>
		                                       	 				<button class="editable-clicko" name="closureId" value="<%=obj[14] %>" formaction="ProjectClosureSoCDetails.htm" data-toggle="tooltip" data-placement="top" title="Details of Statement of Case">
																	<div class="cc-rockmenu">
																		<div class="rolling">
																			<figure class="rolling_icon">
																				<img src="view/images/handbook.png">
																			</figure>
																			<span>SoC</span>
																		</div>
																	</div>
												    			</button>
												    			<%if(obj[11]!=null && (obj[11].toString().equalsIgnoreCase("SFW"))) {%>
												    			<button class="editable-clicko" name="closureId" value="<%=obj[14] %>" formaction="ProjectClosureSoCRevoke.htm" formmethod="post" onclick="return confirm('Are you sure to Revoke?')">
																	<div class="cc-rockmenu">
																		<div class="rolling">
																			<figure class="rolling_icon">
																				<img src="view/images/userrevoke.png" style="width: 22px !important;">
																			</figure>
																			<span>SoC Revoke</span>
																		</div>
																	</div>
												    			</button>
												    			<%} %>
												    			<%} else if(obj[15]!=null && obj[15].toString().equalsIgnoreCase("ACR")) {%>
												    			
		                                       	 				<button class="editable-clicko" name="closureId" value="<%=obj[14] %>" formaction="ProjectClosureACPDetails.htm" formmethod="post" data-toggle="tooltip" data-placement="top" title="Details of Administrative Closure of Project">
																	<div class="cc-rockmenu">
																		<div class="rolling">
																			<figure class="rolling_icon">
																				<img src="view/images/docpaper.png">
																			</figure>
																			<span>ACR</span>
																		</div>
																	</div>
												    			</button>
												    			
												    			
												    			<%if(obj[11]!=null && (obj[11].toString().equalsIgnoreCase("AFW"))) { %>
												    			<button class="editable-clicko" name="closureId" value="<%=obj[14] %>" formaction="ProjectClosureACPRevoke.htm" formmethod="post" onclick="return confirm('Are you sure to Revoke?')">
																	<div class="cc-rockmenu">
																		<div class="rolling">
																			<figure class="rolling_icon">
																				<img src="view/images/userrevoke.png" style="width: 22px !important;">
																			</figure>
																			<span>ACR Revoke</span>
																		</div>
																	</div>
												    			</button>
												    			<%} %>
												    			
												    				<button class="editable-clicko" name="closureId" value="<%=obj[14] %>" formaction="ProjectClosureCheckList.htm" formmethod="post" >
																	<div class="cc-rockmenu">
																		<div class="rolling">
																			<figure class="rolling_icon">
																				<img src="view/images/checklist.png" style="width: 22px !important;">
																			</figure>
																			<span>Check List</span>
																		</div>
																	</div>
												    			</button>
												    			
												    			<%} %>
												    			
												    			
												    		
		                                        		</form>
													</div>
												</div>
											</div>
										</div>
										<%} %>
									</div>
								</div>
							
							<% }%>
							</div>
							<br/><br/>						
					</div>
					<!-- card project visualizations FINISH -->
					
					<div class="pagin" style="display: flex; justify-content: center;padding-bottom:10px;">
						<nav aria-label="Page navigation example" >
							<div class="pagination" >
								<% int pagin = Integer.parseInt(request.getAttribute("pagination").toString()) ; %>
							
									<div class="page-item">
										<form method="get" action="ProjectClosureList.htm" onsubmit="return verify()">
											<input class="page-link" type="submit" <%if(pagin==0){ %>disabled<%} %> value="Previous" />
											<% if (request.getAttribute("searchFactor")!=null){ %>
												<input type="hidden" value="<%= request.getAttribute("searchFactor").toString() %>" name="search" />
											<%} %>
											<input type="hidden" id="pagination" name="pagination" value=<%=pagin-1 %> />
										</form>
									</div>
									<div class="page-item">
										<input class="page-link" type="button" value="<%=pagin+1 %>" disabled/>
									</div>
									<div class="page-item">
										<form method="get" action="ProjectClosureList.htm" >
											<% int last=pagin+2;if(Integer.parseInt(request.getAttribute("maxpagin").toString())<last)
												last=0; %>
												<input class="page-link" type="submit" value="Next" <%if(last==0){ %><%="disabled"%><%} %> />
												<input type="hidden" name="pagination" value=<%=pagin+1 %> />
										</form>
									</div>
							</div>
						</nav>
					</div>
				<%} %>	
			</div>
		</div>
	</div>
</div>	

<script type="text/javascript">

$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [  5,10,25, 50, 75, 100 ],
	 "pagingType": "simple"
	
	});
	  
	  
});

function verify(){
	const ele = document.getElementById("pagination").value;
	if(ele<0)
	{
		return false;
	}
	return true;
}

function checkClosureType(projectId){

	var category = $('#closureCategory'+projectId).val();

	if(category=="-1" || category==null || category=="" || category=="NULL"){
		alert('Please Select Closure Category..!');
		return false;
	}else{
		if(confirm('Are you sure to Submit?')){
			$('#closureform'+projectId).submit();
			return true;
		}else{
			return false;
		}
	}
}

</script>
</body>
</html>
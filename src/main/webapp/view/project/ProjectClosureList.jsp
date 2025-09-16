<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<spring:url value="/resources/css/projectModule/closureList.css" var="closureListCss"/>
<link rel="stylesheet" type="text/css" href="${closureListCss}">

</head>
<body>
<%
FormatConverter fc = new FormatConverter();
List<Object[]> closureList = (List<Object[]>)request.getAttribute("ClosureList");
List<String> closurecategory = Arrays.asList("Completed Successfully","Partial Success","Stage Closure","Cancellation");
%>

<% 
    String ses = (String) request.getParameter("result");
    String ses1 = (String) request.getParameter("resultfail");
    if (ses1 != null) { %>
    <div align="center">
        <div class="alert alert-danger" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses1) %>
        </div>
    </div>
<% }if (ses != null) { %>
    <div align="center">
        <div class="alert alert-success" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses) %>
        </div>
    </div>
<% } %>
	
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
					<form method="get" class="form-inline my-2 my-lg-0 search-box">
						<div>
						
							<input name="search" id="search" required class="form-control mr-sm-2" placeholder="Search" aria-label="Search" type="Search" />
							<input type="submit" class="btn btn-outline-success my-2 my-sm-0" name="clicked" value="Search" />
							<a href="ProjectClosureList.htm"><button type="submit" class="btn btn-outline-danger my-2 my-sm-0" formnovalidate="formnovalidate" >Reset</button></a>
							
						</div>
					</form>
				<!-- search ends -->
					
					<!-- card project visualizations -->
					<div class="project-card">
						<div class="card-deck position-relative">
							<%
							for(Object[] obj: closureList){ %>
							
								<div class="card margin10px">
									<div class="card-body">
									
										<div class="container">
					  						<div class="row">
						  						<div class="col-lg">
													<h4 class="card-title" ><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %></h4></div>
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
													<h6> <%if(obj[2]!=null && obj[3]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[2].toString())+" ("+StringEscapeUtils.escapeHtml4(obj[3].toString())+")" %><%} %></h6>
												</div>
												<div class="col- text-right">
													<h6><%if(obj[5]!=null){ %>
													<%=String.format("%.2f", Double.parseDouble(StringEscapeUtils.escapeHtml4(obj[5].toString())) / 100000) %> lakhs
													<%}else{ %>-<%} %>
													</h6> 
												</div>
											</div>
										</div>
										
										<div class="container">
					  						<div class="row">
												<div class="col-xl">
												Sanctioned on : <%if(obj[7]!=null){%><%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(obj[7].toString())) %>
												<%}else{ %>-<%} %>
												<br/>
												</div>
											</div>
										</div>
										
										<div class="container">
					  						<div class="row">
												<div class="col-xl">
												PDC : <%if(obj[8]!=null){%><%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(obj[8].toString())) %>
												<%}else{ %>-<%} %>
												<br/>
												</div>
											</div>
										</div>
										
										<div class="container display-inlineflex">
											<div>Closure Category : </div>
					  						<div class="row mt01-ml01">
												<div class="col-xl">
												
													<form action="ProjectClosureSubmit.htm" method="post" id="closureform<%=obj[0]%>">
														<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
														<input type="hidden" name="projectId" value="<%=obj[0]%>">
														<input type="hidden" name="closureId" value="<%if(obj[14]!=null) {%><%=StringEscapeUtils.escapeHtml4(obj[14].toString()) %><%}else{%>0<%}%>">
														<select name="closureCategory" id="closureCategory<%=obj[0]%>" class="form-control  form-control" data-width="70%" data-live-search="true" required>
			                								<option value="-1" disabled="disabled" selected="selected">--Select--</option>
												        		<%
												                	for(String category: closurecategory ){
												               %>
																	<option value="<%=category%>" <%if(obj[16]!=null){ if(category.equalsIgnoreCase(obj[16].toString())){%>selected="selected" <%}} %>  class="text-left "><%=category %></option>
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
										
										<div class="container display-inlineflex-mt01">
											<div>Status :</div>
					  						<div class="row mt01-ml01">
												<div class="col-xl">
													 <%if(obj[11]!=null) {%>
														<form action="#">
				                                        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				                                        	<input type="hidden" name="closureId" value="<%=obj[14] %>">
				                                        	<%
															   String colorCode = (String) obj[13];
															   String className = "C" + colorCode.replace("#", "").toUpperCase();
															%>
				                                       	  	<%if(obj[15]!=null && obj[15].toString().equalsIgnoreCase("SoC")) {%>
					                                       	  	<button type="submit" class="btn btn-sm btn-link w-100 btn-status fw-600 <%=className%>" formaction=ProjectClosureSoCTransStatus.htm value="<%=obj[14] %>" name="closureId"  data-toggle="tooltip" data-placement="top" title="Transaction History" formtarget="_blank">
												    				<%=obj[12]!=null?StringEscapeUtils.escapeHtml4(obj[12].toString()): " - " %> <i class="fa fa-telegram mt03rem" aria-hidden="true"></i>
												    			</button>
											    			<%} else if(obj[15]!=null && obj[15].toString().equalsIgnoreCase("ACR")) {%>
											    				<button type="submit" class="btn btn-sm btn-link w-100 btn-status fw-600 <%=className%>" formaction=ProjectClosureACPTransStatus.htm value="<%=obj[14] %>" name="closureId"  data-toggle="tooltip" data-placement="top" title="Transaction History" formtarget="_blank">
											    					<%=obj[12]!=null?StringEscapeUtils.escapeHtml4(obj[12].toString()): " - " %> <i class="fa fa-telegram mt03rem" aria-hidden="true"></i>
											    				</button>
											    			<%} %>
											    			
											    			
	                                        			</form>
	                                        		<%} else{%>
	                                        			<button type="button" class="btn btn-sm btn-link w-100 btn-status transaction-history" data-toggle="tooltip" data-placement="top" title="Transaction History" formtarget="_blank">
											    			Not Initiated <i class="fa fa-telegram mt03rem" aria-hidden="true"></i>
											    		</button>
	                                        		<%} %>
													<br/>
												</div>
											</div>
										</div>  
										
										<%if(obj[14]!=null) {%>		
										<div class="mb15-pt10">
											<div class="container">
						  						<div class="row">
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
																				<img src="view/images/userrevoke.png" class="width-22px">
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
																				<img src="view/images/userrevoke.png" class="width-22px">
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
																				<img src="view/images/checklist.png" class="width-22px">
																			</figure>
																			<span>Check List</span>
																		</div>
																	</div>
												    			</button>
												    			
												    			
												    			<button class="editable-clicko" name="closureId" value="<%=obj[14] %>" formaction="TechClosureList.htm" formmethod="post"  data-toggle="tooltip" data-placement="top" title="Technical Project Closure Report">
																	<div class="cc-rockmenu">
																		<div class="rolling">
																			<figure class="rolling_icon">
																				<img src="view/images/bookpen.png" class="width-22px">
																			</figure>
																			<span>TPCR</span>
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
					
					<div class="pagin pagination-justify-content">
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
<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
 <jsp:include page="../static/header.jsp"></jsp:include>
	<title>Issue</title>
   <spring:url value="/resources/css/issue/issuelist.css" var="issuelist" />     
<link href="${issuelist}" rel="stylesheet" />


<meta charset="ISO-8859-1">

</head>
<body >
<%

 int addcount=0; 
List<Object[]> projectslist=(List<Object[]>)request.getAttribute("projectlist");
String projectid=(String)request.getAttribute("projectid");
List<Object[]> issuedatalist=(List<Object[]>)request.getAttribute("issuedatalist");
String action = (String)request.getAttribute("action");
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

<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
					<div class="col-md-12">
						<div class="row card-header issueListHeader" >
				   			<div class="col-md-6">
								<h4>Issue List</h4>
							</div>
							<!-- <div class="col-md-2"></div>		 -->				
							<div class="col-md-6 justify-content-end issuelistDropDiv " >
								
								<table  class="dropDownTable" >
									<tr>
										<td>
											<form method="post" action="ActionIssue.htm" id="projectchange">
												<select class="form-control items actionDrop" name="Action"  required="required"  data-live-search="true" data-container="body" onchange="submitForm('projectchange');">
													<option disabled  selected value="">Choose...</option>
													<option value="All" <%if(action!=null && "All".equalsIgnoreCase(action)){%> selected<%}%>>All</option>
													<option value="TA" <%if(action!=null && "TA".equalsIgnoreCase(action)){%> selected<%}%>>Assigned To</option>
													<option value="FA" <%if(action!=null && "FA".equalsIgnoreCase(action)){%> selected<%}%>>Assigned From</option>
													<option value="F" <%if(action!=null && "F".equalsIgnoreCase(action)){%> selected <%}%>>Forwarded</option>
												</select>
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
											</form>
										</td>
									</tr>
								</table>							
							</div>
						 </div>
					 </div>
				
					<div class="card-body">	
					
						<table class="table table-bordered table-hover table-striped table-condensed "  id="myTable" >
							<thead>
								<tr>
									<th  class="Sn" data-field="0" tabindex="0" >SN</th>
									<th  class="IssueDesc"> Issue Description </th>
									<th  class="Status"> Status </th>
									<th   class="Progress"> Progress </th>
									<th  class="Action"> Action </th>
								</tr>
							</thead>
							<tbody>
					<% 
					if(issuedatalist.size()>0){ 
					for(int i=0;i<issuedatalist.size();i++){	
					%>
							<tr>
								<td class="center"><%=i+1 %></td>
								<td  class="issueDescData"><%=issuedatalist.get(i)[1]!=null?StringEscapeUtils.escapeHtml4(issuedatalist.get(i)[1].toString()):" - " %></td>
								<td class="center">
									<%if(issuedatalist.get(i)[3].toString().equals("I")){ %>
										In Progress
									<%}else if(issuedatalist.get(i)[3].toString().equals("A")){  %>
										Assigned
									<%}else if(issuedatalist.get(i)[3].toString().equals("C")){  %>
										Closed
								<%}else if(issuedatalist.get(i)[3].toString().equals("F")){  %>
									Forwarded
										<%} %>
								</td>
								<td><%if(issuedatalist!=null && issuedatalist.size()>0 && issuedatalist.get(i)[8]!=null){ %>
															<div class="progress progress-div" >
															<div class="progress-bar progress-bar-striped width<%=issuedatalist.get(i)[8]%>" role="progressbar"  aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
															<%=StringEscapeUtils.escapeHtml4(issuedatalist.get(i)[8].toString())%>
															</div> 
															</div> <%}else{ %>
															<div class="progress progressZeroDiv" >
															<div class="progress-bar progresszeroBarDiv" role="progressbar"   >
															Not Yet Started .
															</div>
															</div> <%} %></td>
								<td class="center">
								<%if(action!=null && !"F".equalsIgnoreCase(action)){%>
									<form action="ActionSubLaunch.htm" method="post">
										<button class="editable-click" name="sub" value="Details" 	>
													<div class="cc-rockmenu">
																<div class="rolling">
																		<figure class="rolling_icon">
																			<img src="view/images/preview3.png">
																		</figure>
																	<span>Details</span>
																</div>
													</div>
										</button>
										<input type="hidden" name="ActionMainId" value="<%=issuedatalist.get(i)[0]%>">
										<input type="hidden" name="ActionAssignid" value="<%=issuedatalist.get(i)[6]%>">
										<input type="hidden" name="ActionNo" value="<%=issuedatalist.get(i)[7]%>">
										<input type="hidden" name="ActionPath" value="I">
										<input type="hidden" name="ActionAssignId" value="<%=issuedatalist.get(i)[6]%>"/>
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									</form>
									
								<%}else{%>
									<form name="myForm1" id="myForm1" action="ForwardSub.htm" method="POST" 
																	>

																	<button class="editable-click" name="sub" value="Details" 	>
																		<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<img src="view/images/preview3.png">
																				</figure>
																				<span>Details</span>
																			</div>
																		</div>
																	</button>
																	<input type="hidden" name="ActionMainId" value="<%=issuedatalist.get(i)[0]%>"/>
																	<input type="hidden" name="ActionAssignId" value="<%=issuedatalist.get(i)[6]%>"/> 
 																	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									</form> 
								<%}%>					
								</td>	
							</tr>														
						<%}
					}%>
						</tbody>
					</table>
											
					</div>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">

function submitForm(frmid)
{ 
  document.getElementById(frmid).submit(); 
} 
</script>


<script type="text/javascript">

$('.items').select2();


$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [  10,25, 50, 75, 100 ],
	 "pagingType": "simple"
	
});
  });
  

</script>


</body>
</html>
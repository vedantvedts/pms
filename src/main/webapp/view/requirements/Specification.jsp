<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/Overall.css" var="StyleCSS" />
<link href="${StyleCSS}" rel="stylesheet" />
<spring:url value="/resources/js/excel.js" var="excel" />
<script src="${excel}"></script>
</head>
<body>
	<%
String projectType=(String)request.getAttribute("projectType");
String projectId = (String)request.getAttribute("projectId");
String initiationId=(String)request.getAttribute("initiationId");

List<Object[]>MainProjectList=(List<Object[]>)request.getAttribute("MainProjectList");
List<Object[]>InitiationProjectList=(List<Object[]>)request.getAttribute("InitiationProjectList");
%>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover" style="margin-top: -0.6pc">

					<div class="row card-header"
						style="background: #C4DDFF; box-shadow: 2px 2px 2px grey;">
						<div class="col-md-4" id="projecthead" align="left">
							<h5 id="text" style="margin-left: 1%; font-weight: 600">System
								Segment Specification</h5>
						</div>
						<div class="col-md-2">
							<div class="form-group">
								<label class="control-label"
									style="font-weight: bolder; font-size: 15px; margin-left: 39px">Project
									Type</label>
							</div>
						</div>
						<div class="col-md-2">
							<form method="POST" action="ProjectSpecifications.htm">
								<select class="form-control custom-select" id="projectType"
									name="projectType"
									style="margin-left: -85px; margin-top: -9px;">
									<option disabled="disabled" value="">Choose...</option>
									<option value="M" <%if(projectType.equalsIgnoreCase("M")){ %>
										selected="selected" <% }%>>Main Project</option>
									<option value="I" <%if(projectType.equalsIgnoreCase("I")){ %>
										selected="selected" <% }%>>Initiation Project</option>
								</select> <input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" /> <input id="submit" type="submit"
									name="submit" value="Submit" hidden="hidden">
							</form>
						</div>

						<%if(projectType.equalsIgnoreCase("M")){ %>
						<div class="col-md-2" style="margin-left: 6%;">
							<form class="form-inline" method="POST"
								action="ProjectSpecifications.htm">
								<div class="row W-100" style="width: 100%; margin-top: -3.5%;">
									<div class="col-md-4" id="div1">
										<label class="control-label"
											style="font-size: 15px; color: #07689f;"><b>Project:</b></label>
									</div>
									<div class="col-md-4" style="" id="projectname">
										<select class="form-control selectdee" id="project"
											required="required" name="projectId">
											<%
										if(MainProjectList!=null && MainProjectList.size()>0){
										for (Object[] obj : MainProjectList) {
										 String projectshortName1 = (obj[17] != null) ? " ( " + obj[17].toString() + " ) " : ""; %>
											<option value="<%=obj[0]%>"
												<%if(projectId.equalsIgnoreCase(obj[0].toString())){ %>
												selected <%} %>>
												<%=obj[4]+projectshortName1 %>
											</option>
											<%} }%>
										</select>
									</div>
								</div>
								<input type="hidden" name="initiationId" value="0"> <input
									type="hidden" name="projectType" value="<%=projectType%>">
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" /> <input id="submit1" type="submit"
									name="submit" value="Submit" hidden="hidden">
							</form>
						</div>
						<%}else{ %>
						<div class="col-md-2" style="margin-left: 9%;">
							<form class="form-inline" method="POST"
								action="ProjectSpecifications.htm">
								<div class="row W-100" style="width: 100%; margin-top: -3.5%;">
									<div class="col-md-4" id="div1">
										<label class="control-label"
											style="font-size: 15px; color: #07689f;"><b>Project:</b></label>
									</div>
									<div class="col-md-3" style="" id="projectname">
										<select class="form-control selectdee" id="project"
											required="required" name="initiationId">
											<%
								if(InitiationProjectList!=null && InitiationProjectList.size()>0){
								for (Object[] obj : InitiationProjectList) {
								  %>
											<option value="<%=obj[0]%>"
												<%if(initiationId.equalsIgnoreCase(obj[0].toString())){ %>
												selected <%} %>>
												<%=obj[4] %>
											</option>
											<%} }%>
										</select>
									</div>
									<input type="hidden" name="projectId" value="0"> <input
										type="hidden" name="projectType" value="<%=projectType%>">
									<input type="hidden" name="${_csrf.parameterName}"
										value="${_csrf.token}" /> <input id="submit1" type="submit"
										name="submit" value="Submit" hidden="hidden">
								</div>
							</form>
						</div>
						<%} %>


					</div>
				</div>
			</div>
		</div>
	</div>


<Script>
$(document).ready(function() {
	$('#projectType').on('change', function() {
		var temp = $(this).children("option:selected").val();
		$('#submit').click();
	});
	});
$(document).ready(function() {
	$('#project').on('change', function() {
		var temp = $(this).children("option:selected").val();
		$('#submit1').click();
	});
	});
</Script>
</body>
</html>
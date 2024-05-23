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
String productTreeMainId=(String)request.getAttribute("productTreeMainId");
String SpecsInitiationId=(String)request.getAttribute("SpecsInitiationId");


%>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover" style="margin-top: -0.6pc">
					<div class="row card-header"
						style="background: #C4DDFF; box-shadow: 2px 2px 2px grey;">
						<div class="col-md-10" id="projecthead" align="left">
							<h5 id="text" style="margin-left: 1%; font-weight: 600">System
								Segment Specification</h5>
						</div>
						
							<div class="col-md-2" align="right">
							<form action="ProjectSpecification.htm" method="post">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								 <input type="hidden" name="projectType" value="<%=projectType%>">
								 <input type="hidden" name="projectId" value="<%=projectId%>">
								<input type="hidden" name="initiationId" value="<%=initiationId%>">
								<input type="hidden" name="SpecsInitiationId" value="<%=SpecsInitiationId%>"> 
								<button type="submit" class="btn btn-primary btn-sm back">Back</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="container" id="container" style="height: 80%;">
		<div class="row" style="display: inline;height: 90%;">
			<div class="requirementid mt-2 ml-2" style="height: 90%;">
				<span class="badge badge-light mt-2 sidebar pt-2 pb-2" onclick="DownloadDoc()"><img alt="" src="view/images/worddoc.png" >&nbsp;Specification Document</span> 
				<span class="badge badge-light mt-2 sidebar pt-2 pb-2" onclick="DownloadDocPDF()"><img alt="" src="view/images/pdf.png" >&nbsp;Specification Document</span> 
		        <span class="badge badge-light mt-2 sidebar pt-2 pb-2 btn-req" onclick="showSummaryModal()"><img alt="" src="view/images/requirements.png" >&nbsp;&nbsp;Document Summary</span>
		        <span class="badge badge-light mt-2 sidebar pt-2 pb-2 btn-req" onclick="showAbbreviations()"><img alt="" src="view/images/requirements.png" >&nbsp;&nbsp;Abbreviations</span>
		        <span class="badge badge-light mt-2 sidebar pt-2 pb-2 btn-req" onclick="showSentModal()"><img alt="" src="view/images/requirements.png" >&nbsp;&nbsp;Document Distribution</span>
				<span class="badge badge-light mt-2 sidebar pt-2 pb-2 btn-req" onclick="showIntroudction()"><img alt="" src="view/images/requirements.png" >&nbsp;&nbsp;Scope</span>
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
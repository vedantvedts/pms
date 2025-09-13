<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*"%>
<%@ page import="java.time.LocalDate"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CARS UserGuide</title>
<link rel="shortcut icon" type="image/png"
	href="view/images/drdologo.png">

<spring:url value="/resources/css/dashboard.css" var="dashboardCss" />
<link href="${dashboardCss}" rel="stylesheet" />

<spring:url value="/resources/css/newfont.css" var="NewFontCss" />
<link href="${NewFontCss}" rel="stylesheet" />

<spring:url value="/resources/css/master.css" var="masterCss" />
<link href="${masterCss}" rel="stylesheet" />

<jsp:include page="../static/dependancy.jsp"></jsp:include>

<spring:url value="/resources/css/help/CARSUserGuide.css" var="CARSUserGuide" />
<link href="${CARSUserGuide}" rel="stylesheet" />



</head>
<body>
	<div class="container py-5">
		<h1 class="text-center mb-4 text-primary">CARS User Guide</h1>
		<div class="alert-notification alert-danger text-center mb-4">
			<strong class="text-danger mb-4"> NOTE: ANY QUERIES PLEASE
				CONTACT ADMIN . </strong>
		</div>
		<div class="card border-primary  mb-4 w-75">
			<div class="card-header bg-primary text-white">
				<h5>RSQR(Research Service Qualitative Requirement ) Flow</h5>
			</div>
			<div class="card-body">
				<ul class="list-group list-group-numbered ">
					<li class="list-group-item">Click <strong>CARS</strong>&gt; <strong>Initiated
							List</strong>&gt; <strong>Add CARS</strong>
					</li>
					<li class="list-group-item">Enter: <em>CARS Title,Funds
							From, Amount, Duration, Aim, Justification </em>
						<h6>RSP Details</h6>
						<ul class="list-group list-group-numbered">
							<li class="list-group-item"><strong>Name of the
									Institute</strong></li>
							<li class="list-group-item"><strong>Address</strong></li>
							<li class="list-group-item"><strong>City</strong></li>
							<li class="list-group-item"><strong>Pin code</strong></li>
							<li class="list-group-item"><strong>State</strong></li>
						</ul>
						<h6>Principal Investigator Details</h6>
						<ul class="list-group list-group-numbered">
							<li class="list-group-item"><strong>Title</strong></li>
							<li class="list-group-item"><strong>Name</strong></li>
							<li class="list-group-item"><strong>Designation</strong></li>
							<li class="list-group-item"><strong>Department</strong></li>
							<li class="list-group-item"><strong>Mobile Number</strong></li>
							<li class="list-group-item"><strong>Email</strong></li>
							<li class="list-group-item"><strong>Fax No</strong></li>
						</ul>
					</li>
					<li class="list-group-item">Click <strong>Update</strong>
						:Update any details
					</li>
					<li class="list-group-item">Click <strong>Next</strong> Enter:
						<em>Introduction, Research Overview, Objectives ,</em>
						<h6>Major Requirements</h6>
						<ul class="list-group">
							<li class="list-group-item"><em>Req Description</em></li>
							<li class="list-group-item"><em>Relevant Specification</em>
							</li>
							<li class="list-group-item"><em>Validation</em></li>
							<li class="list-group-item"><em>Relevant Specification</em>
							</li>
							<li class="list-group-item"><em> Validation Method</em></li>
							<li class="list-group-item"><em>Remarks</em></li>
						</ul>,<em></em> Deliverables, ,
						<h6>Milestone & Timelines</h6>
						<ul class="list-group list-group-numbered">
							<li class="list-group-item">Task Description</li>
							<li class="list-group-item">T0+Months</li>
							<li class="list-group-item">Deliverables</li>
						</ul>, Scope of RSP, Scope of LRDE, Success Criterion, Literature
						Reference(if any).
					</li>
					 <li class="list-group-item">Click <strong>Forward</strong></li>
					
					
					
				</ul>
			</div>
		</div>
	</div>


</body>
</html>
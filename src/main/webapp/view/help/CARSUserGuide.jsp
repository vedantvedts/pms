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

<style type="text/css">
/* * {
	margin: 0, padding:0, box-sizing: border-box;
} */
body {
	font-family: Roboto, sans-serif;
	/* A more modern, readable font stack */
}

.container {
	width: 100%;
	padding-right: 15px;
	padding-left: 15px;
	margin-right: auto;
	margin-left: auto;
}

.py-5 {
	padding: 3rem 0;
}

.text-center {
	text-align: center !important;
}

.text-primary {
	color: #007bff !important;
}

.mb-4, .my-4 {
	margin-bottom: 1.5rem !important;
}

h1 {
	font-size: 2.5rem;
}

.alert-danger {
	color: #721c24;
	background-color: #f8d7da;
	border-color: #f5c6cb;
}

.alert-notification {
	position: relative;
	padding: .75rem 1.25rem;
	margin-bottom: 1rem;
	border: 1px solid transparent;
	border-radius: .25rem;
	margin: auto;
}

.text-danger {
	color: #dc3545 !important;
}

b, strong {
	font-weight: bolder;
}

.w-75 {
	width: 75% !important;
}

.border-primary {
	border-color: #007bff !important;
}

.card {
	position: relative;
	display: -ms-flexbox;
	display: flex;
	-ms-flex-direction: column;
	flex-direction: column;
	min-width: 0;
	word-wrap: break-word;
	background-color: #fff;
	background-clip: border-box;
	border: 1px solid rgba(0, 0, 0, .125);
	border-radius: .25rem;
}

.text-white {
	color: #fff !important;
}

.bg-primary {
	background-color: #007bff !important;
}

h5 {
	margin-top: 10px;
}

h6 {
	font-size: 1rem;
}

.card-body {
	-ms-flex: 1 1 auto;
	flex: 1 1 auto;
	min-height: 1px;
	padding: 1.25rem;
}

.list-group {
	display: -ms-flexbox;
	display: flex;
	-ms-flex-direction: column;
	flex-direction: column;
	padding-left: 0;
	margin-bottom: 0;
	border-radius: .25rem;
	-ms-flex-direction: column;
}

.list-group-item:first-child {
	border-top-left-radius: inherit;
	border-top-right-radius: inherit;
}

.list-group-item {
	position: relative;
	display: block;
	padding: .75rem 1.25rem;
	background-color: #fff;
	border: 1px solid rgba(0, 0, 0, .125);
}

.list-group-numbered {
	counter-reset: section;
	padding-left: 0;
	list-style: none;
}

.list-group-numbered>.list-group-item::before {
	counter-increment: section;
	content: counter(section) ". ";
	font-weight: bold;
	margin-right: 10px;
}
</style>



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
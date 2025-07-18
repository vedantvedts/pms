<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*"%>
<%@ page import="java.time.LocalDate"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>

<!DOCTYPE html>
<html>

<head>
<%
String loginPage = (String) session.getAttribute("loginPage");
%>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title><%=loginPage.equalsIgnoreCase("login") ? "PMS" : "WR"%> -
	Committee User Guide</title>

<link rel="shortcut icon" type="image/png"
	href="view/images/drdologo.png">

<spring:url value="/resources/css/dashboard.css" var="dashboardCss" />
<link href="${dashboardCss}" rel="stylesheet" />

<spring:url value="/resources/css/newfont.css" var="NewFontCss" />
<link href="${NewFontCss}" rel="stylesheet" />

<spring:url value="/resources/css/master.css" var="masterCss" />
<link href="${masterCss}" rel="stylesheet" />

<%-- Include Bootstrap 4 and Font Awesome 4 from dependancy.jsp --%>
<jsp:include page="../static/dependancy.jsp"></jsp:include>
<style type="text/css">
.guide-header {
	background: linear-gradient(to right, #28a745, #1d7b34);
	/* Green gradient for Committee guide */
	color: white;
	padding: 5px 5px; /* More padding */
	border-radius: 12px; /* Slightly more rounded corners */
	box-shadow: 0 6px 18px rgba(0, 0, 0, 0.2); /* Enhanced shadow */
	margin-bottom: 1rem; /* More space below header */
	text-align: center;
}

.guide-header h1 {
	font-size: 1.5rem; /* Larger heading */
	font-weight: 700;
	margin-bottom: 0.5rem;
}

.guide-header p.lead {
	font-size: 1rem;
	opacity: 0.9;
}

.guide-note {
	font-size: 1.2rem;
	font-weight: 600;
	background-color: #f8d7da; /* Light red for danger alert */
	color: #721c24; /* Dark red text */
	border-left: 6px solid #dc3545; /* Prominent border */
	padding: 1.5rem;
	border-radius: 8px;
	margin-bottom: 3rem;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.guide-note strong {
	color: #dc3545; /* Ensure strong text in note is danger red */
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

.alert-notification {
	position: relative;
	padding: .75rem 1.25rem;
	margin-bottom: 1rem;
	border: 1px solid transparent;
	border-radius: .25rem;
}

.card:hover {
	transform: translateY(-5px); /* Subtle hover effect */
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
}
</style>
</head>
<body>
	<div class="container py-5">
		<div class="guide-header">
			<h1 class="display-4">Committee User Guide</h1>
			<p class="lead">Step-by-step instructions for managing committees
				and members</p>
		</div>
		<div
			class="alert-notification alert-danger text-center guide-note mb-5"
			role="alert">
			<i class="fa fa-exclamation-triangle mr-2"></i> <strong>NOTE:
				ANY QUERIES PLEASE CONTACT ADMIN.</strong>
		</div>
		<!-- Section:Creating a new committee -->
		<div class="card border-primary mb-4 w-75">
			<div class="card-header bg-primary text-white">
				<i class="fa fa-plus-circle me-2"></i> Create a Committee
			</div>
			<div class="card-body ">
				<ul class="list-group list-group-numbered">
					<li class="list-group-item">Click on <strong>Committee
							> New Committee</strong>.
					</li>
					<li class="list-group-item">Select Type: <strong>Project</strong>or
						<strong>Non-Project</strong>
					</li>
					<li class="list-group-item">Click on <strong>Add
							Committee</strong>.
					</li>
					<li class="list-group-item">Enter: <em>Committee Code,
							Committee Name, Guidelines, Purpose and Terms of Reference.</em></li>
					<li class="list-group-item">Select: <em>Committee Type,
							Project Applicable for, Technical/Non-Technical
							,Periodic/Non-Periodic</em></li>
					<li class="list-group-item">Click <strong>Submit.</strong></li>
				</ul>
			</div>
		</div>
		<!-- Section:Edit  committee -->
		<div class="card border-info mb-4 w-75">
			<div class="card-header bg-info text-white">
				<i class="fa fa-edit me-2"></i> Edit a Committee
			</div>
			<div class="card-body ">
				<h6 class="fw-bold">Non Project:</h6>
				<ul class="list-group list-group-numbered">
					<li class="list-group-item">Click <strong>Committee >
							Non-Project</strong></li>
					<li class="list-group-item">Click <strong> Edit</strong>
						button -> Edit details -> Click <strong>Submit.</strong>
					</li>
				</ul>
				<h6 class="fw-bold">Project:</h6>
				<ul class="list-group list-group-numbered">
					<li class="list-group-item">Click <strong>Committee >
							New Committee </strong> -> Select Type as <strong>Project.</strong>
					</li>
					<li class="list-group-item">Click <strong> Edit</strong>
						button -> Edit details -> Click <strong>Submit.</strong>
					</li>
				</ul>
			</div>
		</div>
		<!-- Section:Constitute  committee  Non Project-->
		<div class="card border-success mb-4 w-75">
			<div class="card-header bg-success text-white">
				<i class="fa fa-users me-2"></i> Constitute Members - Non Project
			</div>
			<div class="card-body ">
				<ul class="list-group list-group-numbered">
					<li class="list-group-item">Click <strong>Committee >
							Non-Project </strong> -> <strong>Eye Button.</strong>
					</li>
					<li class="list-group-item">Assign Lab and Employee to each
						role:Chairperson, Member Secretary, Co-Chairperson, Proxy Member
						Secretary.</li>
					<li class="list-group-item">Select whether committee is <strong>pre-approved</strong></li>
					<li class="list-group-item">Add Members -> Select -> Click <strong>Submit</strong></li>
					<li class="list-group-item">Update <strong>Serial No
							List.</strong></li>
					<h6 class="fw-bold">If Committee is Not Pre-Approved Follow
						these Additional Steps</h6>
					<li class="list-group-item">Click <strong>Preview</strong> ->
						Select <strong>Recommending Officer</strong> and <strong>Approving
							Officer.</strong>
						<h6 class="text-danger">Note: One Approving Officer and
							Recommending Officer Mandatory.</h6>
					</li>
					<li class="list-group-item">Click <strong>Update</strong> -> <strong>Forward</strong>
						to Recommending Officer.
					</li>
					<li class="list-group-item">Can <strong>Revoke</strong> the
						request.
					</li>
					<li class="list-group-item"><strong>Recommending
							Officer </strong> can <strong>Recommend</strong> or <strong>Return.</strong>
					</li>
					<li class="list-group-item"><strong>Approving Officer
					</strong> can <strong>Approve</strong> or <strong>Return.</strong></li>
					<li class="list-group-item">Once approved,the committee will
						be constituted.</li>
				</ul>
			</div>
		</div>
		<!-- Section:Constitute  committee Project-->
		<div class="card border-warning mb-4 w-75">
			<div class="card-header bg-warning text-dark">
				<i class="fa fa-users me-2"></i> Constitute Members - Project
			</div>
			<div class="card-body ">
				<ul class="list-group list-group-numbered">
					<li class="list-group-item">Click <strong>Committee >
							Project </strong></li>
					<li class="list-group-item">Select and <strong>Add
							Committees.</strong> Delete from right panel if needed.
					</li>
					<li class="list-group-item text-danger"><strong>PRMC</strong>
						and <strong>EB</strong> committees are default pre-approved and
						mandatory.</li>
					<li class="list-group-item">Click <strong>Eye Button</strong></li>
					<li class="list-group-item">Assign Lab and Employee to roles
						as in non-project.</li>
					<li class="list-group-item">Follow same workflow for
						pre-approval, member addition, preview, update, forward, recommend
						, approve.</li>

				</ul>
			</div>
		</div>
		<!-- Section:Auto Schedule-->
		<div class="card border-secondary mb-4 w-75">
			<div class="card-header bg-secondary text-white">
				<i class="fa fa-calendar me-2"></i> Auto-Schedule Meeting
				(Non-Project)
			</div>
			<div class="card-body ">
				<ul class="list-group list-group-numbered">
					<li class="list-group-item">Click <strong>Committee >
							Non-Project </strong></li>
					<li class="list-group-item">Click <strong>Calendar
							Button. </strong></li>
					<li class="list-group-item">Select <em>From Date,To
							Date,Time</em> -> Click <strong> Submit </strong></li>
					<li class="list-group-item">Meeting will be auto-scheduled.</li>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>
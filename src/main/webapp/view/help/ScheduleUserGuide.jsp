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
	User Guide</title>

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
<style>
.guide-header {
	background: linear-gradient(to right, #007bff, #0056b3);
	/* Stronger primary blue */
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
			<h1 class="display-4">Schedule User Guide</h1>
			<p class="lead">Step-by-step instructions for managing meetings
				and actions</p>
		</div>

		<div
			class="alert-notification alert-danger text-center guide-note mb-5"
			role="alert">
			<i class="fa fa-exclamation-triangle mr-2"></i> NOTE: ANY QUERIES
			PLEASE CONTACT ADMIN.
		</div>

		<!-- Section Schedule Meeting -->
		<div class="card border-primary mb-4 w-75">
			<div class="card-header bg-primary text-white">
				<i class="fa fa-calendar me-2"></i> Schedule Meeting
			</div>
			<div class="card-body">
				<ul class="list-group list-group-numbered">
					<li class="list-group-item">Click <strong>Schedule >
							Non-Project</strong>or <strong>Project</strong>
					</li>
					<li class="list-group-item">If <strong>Non-Project</strong>:
						Select Committee (top-right dropdown)
					</li>
					<li class="list-group-item">If <strong>Project</strong>:
						Select Project and Committee (top-right dropdown)
					</li>
					<li class="list-group-item">Select <strong>Date and
							Time</strong>, then click <strong>Add Schedule</strong></li>
					<li class="list-group-item">Right-side panel displays list of
						scheduled meetings for the committee.</li>
				</ul>
			</div>
		</div>
		<!-- Section Agenda Approval -->
		<div class="card border-info mb-4 w-75">
			<div class="card-header bg-info text-white">
				<i class="fa fa-pencil-square-o me-2"></i> Agenda Approval
			</div>
			<div class="card-body">
				<ul class="list-group list-group-numbered">
					<li class="list-group-item">Fill Agenda form: <em>Agenda
							Items, References, Remarks, Lab,Presenter, Duration,Attachment</em> ->
						Click <strong>Submit.</strong>
					</li>
					<li class="list-group-item">Enter <em>Venue,
							Decisions/Recommendations, References</em> -> Click <strong>Update.</strong>
					</li>
					<li class="list-group-item">Click <strong>Invite</strong> ->
						Select Members -> Click <strong>Submit</strong></li>
					<li class="list-group-item">Click <strong>Send
							Invitation</strong> to notify members via email
					</li>
					<li class="list-group-item">Add additional members or
						representatives using respective options.</li>
					<li class="list-group-item">Click <strong>Agenda
							Approval </strong> -> Notification sent to Chairperson and Member
						Secretary
					</li>
					<li class="list-group-item">If returned,view <strong>Reason
							for Returning</strong>update, and click <strong>Re-submit Agenda
							Approval</strong></li>

				</ul>
			</div>
		</div>
		<!-- Section Kickoff Meeting-->
		<div class="card border-success mb-4 w-75">
			<div class="card-header bg-success text-white">
				<i class="fa fa-play-circle me-2"></i> Kickoff Meeting
			</div>
			<div class="card-body">
				<ul class="list-group list-group-numbered">
					<li class="list-group-item">Click <strong>Kickoff
							Meeting</strong></li>
					<li class="list-group-item"><strong>OTP</strong>will be sent
						to Chairperson or Member Secretary(Only for same-day meeting)</li>
					<li class="list-group-item">Enter OTP -> Click <strong>Validate</strong>
						or <strong>Resend OTP.</strong></li>
				</ul>
			</div>
		</div>
		<!-- Section Attendance-->
		<div class="card border-warning mb-4 w-75">
			<div class="card-header bg-warning text-dark">
				<i class="fa fa-user me-2"></i><i class="fa fa-check-circle me-2"></i>
				Attendance
			</div>
			<div class="card-body">
				<ul class="list-group list-group-numbered">
					<li class="list-group-item">Click <strong>Attendance</strong></li>
					<li class="list-group-item">Toggle attendance button for each
						member -> Click <strong>Back</strong>
					</li>

				</ul>
			</div>
		</div>
		<!-- Section Minutes-->
		<div class="card border-secondary mb-4 w-75">
			<div class="card-header bg-secondary text-white">
				<i class="fa fa-file-text me-2"></i> Minutes of Meeting
			</div>
			<div class="card-body">
				<ul class="list-group list-group-numbered">
					<li class="list-group-item">Click <strong>Minutes</strong></li>
					<li class="list-group-item">Fill fields : <em>Introduction,Opening
							Remarks, Agenda , Other Discussion , Other Outcomes , Conclusion
					</em> -> Click <strong>Submit</strong></li>
					<li class="list-group-item">Top-right buttons:
						<ul class="list-group list-group-numbered">
							<li class="list-group-item"><strong>Email</strong>:Send
								Minutes Copy</li>
							<li class="list-group-item"><strong>Minutes</strong>: View
								PDF</li>
							<li class="list-group-item"><strong>Tabular Meeting</strong>:
								View in table format</li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
		<!-- Section Assign Actions-->
		<div class="card border-danger mb-4 w-75">
			<div class="card-header bg-danger text-white">
				<i class="fa fa-tasks me-2"></i> Assign Actions
			</div>
			<div class="card-body">
				<ul class="list-group list-group-numbered">
					<li class="list-group-item">Click <strong>Assign
							Action</strong></li>
					<li class="list-group-item">Enter <em>PDC,Priority,
							Category ,Lab, Assignee(s) </em> -> Click <strong>Submit</strong></li>
					<li class="list-group-item">Edit or Delete using buttons in
						the action list.</li>
					<li class="list-group-item">Notification sent to the
						authorized person.</li>
					<li class="list-group-item">Click <strong>Tree</strong> to
						view action tree.
					</li>
					<li class="list-group-item">Admin can close the action after
						completion.</li>
				</ul>
			</div>
		</div>
		<!-- Section Minutes of Approval-->
		<div class="card border-dark mb-4 w-75">
			<div class="card-header bg-dark text-white">
				<i class="fa fa-check-circle me-2"></i> Minutes of Approval
			</div>
			<div class="card-body">
				<ul class="list-group list-group-numbered">
					<li class="list-group-item">If minutes of meeting is <strong>pre-approved</strong>,
						you can directly print minutes.
					</li>
					<li class="list-group-item">If not,select <strong>Recommending
							Officer</strong> and <strong>Approving Officer</strong></li>
					<li class="list-group-item">Recommending Officer -> <strong>Recommend</strong>
						or <strong>Return</strong></li>
					<li class="list-group-item">Approving Officer -> <strong>Approve</strong>
						or <strong>Return</strong></li>
					<li class="list-group-item">Once approved,minutes can be
						printed.</li>
				</ul>
			</div>
		</div>
	</div>

</body>
</html>
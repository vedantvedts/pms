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
<title><%=loginPage.equalsIgnoreCase("login") ? "PMS" : "WR"%></title>

<link rel="shortcut icon" type="image/png"
	href="view/images/drdologo.png">

<spring:url value="/resources/css/dashboard.css" var="dashboardCss" />
<link href="${dashboardCss}" rel="stylesheet" />

<spring:url value="/resources/css/newfont.css" var="NewFontCss" />
<link href="${NewFontCss}" rel="stylesheet" />

<spring:url value="/resources/css/master.css" var="masterCss" />
<link href="${masterCss}" rel="stylesheet" />

<jsp:include page="../static/dependancy.jsp"></jsp:include>
<style>
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

.guide-header {
	background: linear-gradient(to right, #007bff, #0056b3);
	/* Stronger blue gradient */
	color: white;
	padding: 5px 5px; /* Increased padding */
	border-radius: 12px; /* Slightly more rounded */
	box-shadow: 0 6px 18px rgba(0, 0, 0, 0.2); /* Enhanced shadow */
	margin-bottom: 3rem; /* More space below the header */
}

.guide-header h1 {
	font-size: 1.5rem; /* Larger heading */
	font-weight: 700; /* Bolder */
}

.guide-header p.lead {
	font-size: 1rem; /* Larger lead text */
	opacity: 0.9;
}

.guide-note {
	font-size: 1.2rem; /* Slightly larger font */
	font-weight: bold;
	background: #fff3cd; /* Muted warning yellow */
	color: #856404; /* Darker text for contrast */
	border-left: 6px solid #ffc107; /* Orange border for warning */
	padding: 1rem 1.5rem; /* Comfortable padding */
	border-radius: 8px; /* Rounded corners */
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
	margin-bottom: 3rem;
}

.text-white {
	font-size: 1.2rem
}
</style>

</head>

<body>
	<div class="container py-5">
		<div class="text-center mb-3 guide-header">
			<h1 class="display-4">Action User Guide</h1>
			<p class="lead">Clear instructions for managing action workflows</p>
		</div>

		<div class="alert-notification text-center guide-note mb-5"
			role="alert">
			<i class="fa fa-exclamation-triangle mr-2"></i> NOTE: For any queries
			or assistance, please contact the **Admin**.
		</div>

		<!-- Section-1:Creating a new action item -->
		<div class="card mb-4 border-primary w-75">
			<div class="card-header bg-primary text-white">
				<i class="fa fa-plus-circle mr-2"></i> Creating a New Action Item
			</div>
			<div class="card-body">
				<ul class="list-group list-group-numbered ">
					<li class="list-group-item">Click <strong>Action
							Items > New Action</strong></li>
					<li class="list-group-item">Enter <strong>Action
							Item, PDC, Project, Action Type, Priority</strong>and <strong>Category.</strong>
					</li>
					<li class="list-group-item">Click <strong>Submit.</strong></li>
					<li class="list-group-item">Select <strong>Lab,Assignee</strong>
						and upload <strong>attachment</strong>(if any).
					</li>
				</ul>
			</div>
		</div>

		<!-- Section-2:Update Work Progress -->
		<div class="card mb-4 border-success w-75">
			<div class="card-header bg-success text-white">
				<i class="fa fa-tasks me-2"></i> Update Work Progress
			</div>
			<div class="card-body">
				<ul class="list-group list-group-numbered ">
					<li class="list-group-item">A notification will be sent to the
						authorized person.</li>
					<li class="list-group-item">Navigate to <strong>notifications.</strong></li>
					<li class="list-group-item">Click <strong>Distribute</strong>
						to share action items with other employees.
					</li>
					<li class="list-group-item">Click <strong>Tree</strong> to
						view the action tree.
					</li>
				</ul>
			</div>
		</div>

		<!-- Section-1:Action Forward -->
		<div class="card mb-4 border-warning w-75">
			<div class="card-header bg-warning text-dark">
				<i class="fa fa-share-square me-2"></i> Action Forward
			</div>
			<div class="card-body">
				<ul class="list-group list-group-numbered ">
					<li class="list-group-item">Click <strong>Action
							Forward. </strong>Notification is sent to Admin.
					</li>
					<li class="list-group-item">Navigate to <strong>Notification.
					</strong> and Enter Remark.
					</li>
					<li class="list-group-item">Click <strong>Send Back </strong>if
						changes are needed.
					</li>
					<li class="list-group-item">Click <strong>Update </strong>to
						extend the PDC.
					</li>
					<li class="list-group-item">Click <strong>Close </strong>to
						complete and close the action.
					</li>
				</ul>
			</div>
		</div>
	</div>

	</div>
</body>
</html>
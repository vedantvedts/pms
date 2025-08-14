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
<title>Overall User Guide</title>
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
.navbar {
	background-color: #fff !important;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
	height: 90px;
}

.navbar-nav .nav-link {
	color: #00796b !important;
	font-weight: 600;
	padding: 1rem 1rem;
}

html {
	scroll-behavior: smooth;
}

.scrollable {
	height: 250px;
	/* or any height you want */
	overflow-y: auto;
	/* scrolls vertically */
}

.card-heading {
	display: flex;
	justify-content: space-between;
	align-items: center;
	user-select: none;
	font-size: 18px;
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

#topBtn {
	position: fixed;
	bottom: 30px;
	right: 30px;
	z-index: 999;
	background-color: #28a745;
	color: white;
	border: none;
	padding: 10px 15px;
	border-radius: 50%;
	font-size: 16px;
	cursor: pointer;
	display: none;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
}

#topBtn:hover {
	background-color: #1d7b34;
}
</style>

</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light fixed-top">
		<a class="navbar-brand" href="#"><i class="fa fa-book"></i> PMS
			User Guide</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarNav">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item"><a class="nav-link" href="#committee"><i
						class="fa fa-users"></i> Committee </a></li>
				<li class="nav-item"><a class="nav-link" href="#schedule"><i
						class="fa fa-calendar"></i> Schedule </a></li>
				<li class="nav-item"><a class="nav-link" href="#action"><i
						class="fa fa-tasks"></i> Action </a></li>
				<li class="nav-item"><a class="nav-link" href="#milestone"><i
						class="fa fa-flag-checkered"></i> Milestone </a></li>
						
							<li class="nav-item"><a class="nav-link" href="#CARS"><i
						class="fa fa-book"></i> CARS </a></li>
			</ul>
		</div>
	</nav>
	<!-- Page Content -->
	<div class="container mt-5 pt-5">
		<!-- Committee UserGuide -->
		<div id="committee">
			<div class="card border-success mb-3 mt-5">
				<div class="card-header bg-success text-white">
					<h5 class="ml-3">
						<i class="fa fa-users"></i> Committee User Guide
					</h5>
				</div>
				<div class="card-body">
					<div class="row">
						<div class="col col-md-9">
							<div id="userGuide">
								<!-- Section:Creating a committee -->
								<div class="card border-primary mb-4">
									<div class="card-header card-heading bg-primary text-white"
										data-toggle="collapse" data-target="#creating-committee"
										aria-expanded="true" aria-controls="creating-committee">
										<span> <i class="fa fa-plus-circle me-2"></i> Create a
											Committee
										</span> <i class="fa fa-chevron-down"></i>
									</div>
									<div id="creating-committee" class="collapse show">
										<div class="card-body ">
											<ul class="list-group list-group-numbered">
												<li class="list-group-item">Click on <strong
													class="text-success">Committee <i
														class="fa fa-chevron-right"></i> New Committee
												</strong>.
												</li>
												<li class="list-group-item">Select Type: <strong
													class="text-primary">Project</strong> or <strong
													class="text-primary">Non-Project</strong> <i
													class="fa fa-chevron-right"></i> Click on <strong
													class="text-info">Add Committee</strong>.
												</li>
												<li class="list-group-item"><strong class="text-info">Fill
														the Details:</strong> <em> Committee Code, Committee Name,
														Guidelines, Purpose and Terms of Reference, Committee
														Type, Technical/Non-Technical ,Periodic/Non-Periodic. </em> <i
													class="fa fa-chevron-right"></i> Click <strong
													class="text-success">Submit.</strong></li>
											</ul>
										</div>
									</div>
								</div>
								<!-- Section:Editing a committee -->
								<div class="card border-info mb-4">
									<div class="card-header card-heading bg-info text-white"
										data-toggle="collapse" data-target="#edit-committee"
										aria-expanded="false" aria-controls="edit-committee">
										<span> <i class="fa fa-edit me-2"></i> Edit a Committee
										</span> <i class="fa fa-chevron-down toggle-arrow"></i>
									</div>
									<div id="edit-committee" class="collapse">
										<div class="card-body ">
											<h6 class="font-weight-bold text-primary">Non Project:</h6>
											<ul class="list-group list-group-numbered">
												<li class="list-group-item">Click <strong
													class="text-primary">Committee <i
														class="fa fa-chevron-right"></i> Non-Project.
												</strong></li>
												<li class="list-group-item">Click <strong
													class="text-primary">Edit</strong> button <i
													class="fa fa-chevron-right"></i> <strong>Edit the
														required fields</strong> <i class="fa fa-chevron-right"></i> Click
													<strong class="text-success">Submit</strong>.
												</li>

											</ul>
											<h6 class="font-weight-bold text-success">Project:</h6>
											<ul class="list-group list-group-numbered">
												<li class="list-group-item">Click <strong
													class="text-success">Committee <i
														class="fa fa-chevron-right"></i> New Committee
												</strong> <i class="fa fa-chevron-right"></i> Select Type as <strong
													class="text-success"> Project.</strong>
												</li>
												<li class="list-group-item">Click <strong
													class="text-success"> Edit</strong> button <i
													class="fa fa-chevron-right"></i> <strong>Edit the
														required fields</strong> <i class="fa fa-chevron-right"></i> Click
													<strong class="text-success">Submit.</strong>
												</li>
											</ul>
										</div>
									</div>
								</div>
								<!-- Section:Constitute Members -->
								<div class="card border-success mb-4">
									<div class="card-header card-heading bg-success text-white"
										data-toggle="collapse" data-target="#constitute-members"
										aria-expanded="false" aria-controls="constitute-members">
										<span> <i class="fa fa-users me-2"></i> Constitute
											Committee - Non Project/ Division/ Initiation Project
										</span> <i class="fa fa-chevron-down"></i>
									</div>
									<div class="collapse" id="constitute-members">
										<div class="card-body">
											<h6 class="text-danger">Note:You can select
												project/division/pre-project at the top left corner that you
												want to constitute.</h6>
											<ul class="list-group list-group-numbered">
												<li class="list-group-item">Click <strong
													class="text-primary">Committee <i
														class="fa fa-chevron-right"></i> Non-Project/ Division/
														Initiation/ Project
												</strong> <i class="fa fa-chevron-right"></i> <strong
													class="text-primary"><i class="fa fa-eye"></i>
														Constitution.</strong>
												</li>
												<h6 class="text-danger mt-2 lh-lg">
													<strong>Note: While constituting committee for
														Division/ Initiation/ Project, Select and <strong
														class="text-success">Add Committees.</strong>
													</strong>
												</h6>
												<li class="list-group-item">Assign Lab and Employee to
													each role: Chairperson, Member Secretary, Co-Chairperson,
													Proxy Member Secretary.</li>
												<li class="list-group-item">Select whether committee is
													<strong class="text-success">pre-approved or not.</strong>
												</li>
												<li class="list-group-item">Add Members <i
													class="fa fa-chevron-right"></i> Select Employees <i
													class="fa fa-chevron-right"></i> Click <strong
													class="text-success">Submit.</strong>
												</li>
												<li class="list-group-item">Update <strong
													class="text-warning">Serial No List.</strong></li>
												<h6 class="text-danger font-weight-bold">Note: Kindly
													update the serial number list to ensure that the employee
													order is accurately reflected in the reports.</h6>
												<h6 class="font-weight-bold text-danger">If Committee
													is Not Pre-Approved Follow these Additional Steps</h6>
												<li class="list-group-item">Click <strong
													class="text-primary">Preview</strong> <i
													class="fa fa-chevron-right"></i> Select <strong
													class="text-success">Recommending Officer</strong> and <strong
													class="text-success">Approving Officer.</strong>
													<h6 class="text-danger">Note: One Approving Officer
														and Recommending Officer Mandatory.</h6>
												</li>
												<li class="list-group-item">Click <strong
													class="text-warning">Update</strong> <i
													class="fa fa-chevron-right"></i> <strong
													class="text-success">Forward</strong> to Recommending
													Officer.
												</li>
												<h6 class="text-danger">Note: If Recommending Officer
													has not recommended ,the user can revoke the request.</h6>
												<li class="list-group-item">Recommending Officer or
													Approving Officer will navigate to notification or Click <strong
													class="text-success"> Approvals <i
														class="fa fa-chevron-right"></i> Committee Approvals <i
														class="fa fa-chevron-right"></i> <i class="fa fa-eye"></i>
														Constitution <i class="fa fa-chevron-right"></i> Enter
														Remark <i class="fa fa-chevron-right"></i> Click
														Recommend/Approve or <strong class="text-danger">Return</strong>.
												</strong>
												</li>
											</ul>
										</div>
									</div>
								</div>
								<!-- Section:AutoScheduling meeting for non-project -->
								<div class="card border-secondary mb-4">
									<div class="card-header card-heading bg-secondary text-white"
										data-toggle="collapse" data-target="#auto-schedule"
										aria-expanded="false" aria-controls="auto-schedule">
										<span> <i class="fa fa-calendar me-2"></i>
											Auto-Schedule Meeting (Periodic Type)- Non-Project/ Project/
											Initiation/ Division
										</span> <i class="fa fa-chevron-down"></i>
									</div>
									<div id="auto-schedule" class="collapse">
										<div class="card-body ">
											<ul class="list-group list-group-numbered">
												<li class="list-group-item">Click <strong
													class="text-success"> Committee <i
														class="fa fa-chevron-right"></i> Non-Project/ Division/
														Initiation/ Project.
												</strong>
												</li>
												<li class="list-group-item">Click <strong
													class="text-success"> <i
														class="fa fa-calendar me-2"></i> Calendar Button/ Meeting
														Schedule.
												</strong></li>
												<li class="list-group-item">Select <em>From
														Date,To Date,Time</em> <i class="fa fa-chevron-right"></i>
													Click <strong class="text-success"> Submit </strong></li>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col col-md-3">
							<!-- DOs and DON'Ts -->
							<div class="card scrollable">
								<div class="card-header bg-success text-white">
									<strong> Do's</strong>
								</div>
								<ul class="list-group list-group-numbered">
									<li class="list-group-item"><strong>Member
											secretary and Chair person </strong>is mandatory when constituting a
										committee.</li>
									<li class="list-group-item"><strong>PMRC</strong> and <strong>EB</strong>
										committees are default pre-approved.</li>
									<li class="list-group-item">While constituting the
										committee, if you select <strong>"Is Pre-Approved" =
											No</strong>, you must assign one <strong> Recommending
											Officer</strong> and one <strong> Approving Officer</strong> before
										forwarding for approval.
									</li>

									<li class="list-group-item">Always double-check committee
										details before submission.</li>
									<li class="list-group-item">Update serial number list
										after member addition.</li>
									<li class="list-group-item">Preview committee before
										sending for approval.</li>
								</ul>
							</div>

							<div class="card mt-3 scrollable">
								<div class="card-header bg-danger text-white">
									<strong> Don't Do's</strong>
								</div>

								<ul class="list-group list-group-numbered">
									<li class="list-group-item">The project code must be no
										more than six characters long.</li>
									<li class="list-group-item">You can't assign one person to
										multiple member type.</li>
									<li class="list-group-item">Don't skip the recommendation
										step if the committee is not pre-approved.</li>
									<li class="list-group-item">Don't forward the committee
										for approval unless all roles and responsibilities are
										correctly assigned.</li>
								</ul>


							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
		<!-- Schedule UserGuide -->
		<div id="schedule">
			<div class="card border-primary mb-3 mt-5">
				<div class="card-header bg-primary text-white">
					<h5 class="ml-3">
						<i class="fa fa-calendar"></i> Schedule User Guide
					</h5>
				</div>
				<div class="card-body card-body-main">
					<div class="userguide">
						<!-- Section: Scheduling Meeting  -->
						<div class="card border-primary mb-4 ">
							<div class="card-header card-heading bg-primary text-white"
								data-toggle="collapse" data-target="#schedule-meeting"
								aria-expanded="true" aria-controls="schedule-meeting">
								<span> <i class="fa fa-calendar me-2"></i> Schedule
									Meeting
								</span> <i class="fa fa-chevron-down"></i>
							</div>

							<div id="schedule-meeting" class="collapse show">
								<div class="card-body">
									<ul class="list-group list-group-numbered">
										<li class="list-group-item">Click <strong
											class="text-primary">Schedule</strong>, then choose either <strong
											class="text-success">Non-Project</strong>, <strong
											class="text-success">Project</strong>, <strong
											class="text-success">Division</strong>, <strong
											class="text-success">Pre-Project</strong> , <strong
											class="text-success">Record of Discussion</strong>, <strong
											class="text-success">CARS</strong>, or <strong
											class="text-success">Programme</strong> based on the type of
											meeting you want to create.
										</li>
										<li class="list-group-item">
											<ul class="list-group list-group-numbered">
												<li class="list-group-item">If you have selected <strong
													class="text-success">Non-Project</strong>, choose a
													committee from the dropdown in the top-right corner.
												</li>
												<li class="list-group-item">If you have selected <strong
													class="text-success">Project / Pre-Project /
														Division / Programme / CARS:</strong> Choose project/initiated
													project/division/programme/CARS and committee from the
													dropdown in the top-left corner.
												</li>
												<li class="list-group-item">If you have selected <strong
													class="text-success">Record of Discussion</strong>: Choose
													Project Type, Project and ROD name from the dropdown in the
													top left-corner.
												</li>
											</ul>
										</li>
										<li class="list-group-item">Select <strong
											class="text-danger">Date and Time</strong>, then click <strong
											class="text-info">Add Schedule.</strong></li>
										<h6 class="text-danger">Note: Right-side panel displays
											list of scheduled meetings for the committee.</h6>
										<li class="list-group-item">You can delete the meeting by
											clicking above <strong class="text-danger"><i
												class="fa fa-trash"></i> Delete.</strong>
										</li>
										<li class="list-group-item">You can reschedule the
											meeting by changing <strong class="text-primary">
												Meeting Date and Meeting Time </strong>.
										</li>
										<h6 class="text-danger">Note: Once Agenda Approved, can't
											delete the meeting.</h6>
									</ul>
								</div>
							</div>
						</div>
						<!-- Section Schedule Detail -->
						<div class="card border-success mb-4">
							<div class="card-header bg-success text-white card-heading"
								data-toggle="collapse" data-target="#schedule-detail"
								aria-expanded="false" aria-controls="schedule-detail">
								<span><i class="fa fa-info-circle me-2"></i> Schedule
									Details</span> <i class="fa fa-chevron-down"></i>
							</div>
							<div class="collapse" id="schedule-detail">
								<div class="card-body">
									<h6 class="text-danger">Note: Member Secretary and
										Chairperson can only approve agenda. Notification will be sent
										to both.</h6>
									<ul class="list-group list-group-numbered">
										<li class="list-group-item">Fill Agenda form: <em>Agenda
												Items, References, Remarks, Lab,Presenter, Duration,
												Attachment(if any)</em> <i class="fa fa-chevron-right"></i> Click
											<strong class="text-success">Submit.</strong>
										</li>
										<li class="list-group-item">Enter <em>Venue,
												Briefing of the meeting, References</em> <i
											class="fa fa-chevron-right"></i> Click <strong
											class="text-warning font-weight-bold">Update.</strong>
										</li>
										<h6 class="text-danger">
											Note: You can edit agenda by clicking on <strong
												class="text-primary font-weight-bold">Edit Button.</strong>
										</h6>
										<li class="list-group-item">Click <strong
											class="text-success">Invite</strong> <i
											class="fa fa-chevron-right"></i> Select Members <i
											class="fa fa-chevron-right"></i> Click <strong
											class="text-success">Submit.</strong>
										</li>
										<li class="list-group-item">Click <strong
											class="text-success">Send Invitation</strong> to notify
											members via email.
										</li>
										<li class="list-group-item">Add additional members or
											representatives using respective options.</li>
									</ul>
								</div>
							</div>
						</div>
						<!-- Section Agenda Approval -->
						<div class="card border-info  mb-4">
							<div class="card-header bg-info text-white card-heading "
								data-toggle="collapse" data-target="#agenda-approval"
								aria-expanded="false" aria-controls="agenda-approval">
								<span><i class="fa fa-pencil-square-o me-2"></i> Agenda
									Approval</span> <i class="fa fa-chevron-down toggle-arrow"></i>
							</div>
							<div id="agenda-approval" class="collapse">
								<div class="card-body">
									<ul class="list-group list-group-numbered">
										<li class="list-group-item">Click <strong
											class="text-success">Agenda Approval </strong> <i
											class="fa fa-chevron-right"></i> Notification will be sent to
											Chairperson and Member Secretary.
										</li>
										<li class="list-group-item">Member Secretary or
											Chairperson can navigate to notification or Click <strong
											class="text-primary"> Approvals <i
												class="fa fa-chevron-right"></i> Meetings <i
												class="fa fa-chevron-right"></i> <i class="fa fa-eye"></i>
												Details.
										</strong>
										</li>
										<li class="list-group-item">Enter <strong
											class="text-success">Remark</strong>. They can <strong
											class="text-success">Approve</strong> or <strong
											class="text-danger">Return.</strong>
										</li>
										<li class="list-group-item">If returned,view <strong
											class="text-success">Reason for Returning</strong> update,
											and click <strong class="text-primary">Re-submit
												Agenda Approval.</strong>
										</li>
									</ul>
								</div>
							</div>
						</div>
						<!-- Section Kickoff Meeting-->
						<div class="card border-success mb-4">
							<div class="card-header bg-success text-white card-heading"
								data-toggle="collapse" data-target="#kickoff-meeting"
								aria-expanded="false" aria-controls="kickoff-meeting">
								<span><i class="fa fa-play-circle me-2"></i> Kickoff
									Meeting</span> <i class="fa fa-chevron-down"></i>
							</div>
							<div id="kickoff-meeting" class="collapse">
								<div class="card-body">
									<ul class="list-group list-group-numbered">
										<li class="list-group-item">Click <strong
											class="text-success">Kickoff Meeting.</strong>
										</li>
										<li class="list-group-item text-danger"><strong>OTP
										</strong>will be sent to Chairperson or Member Secretary(Only for
											same-day meeting).</li>
										<li class="list-group-item">Enter OTP <i
											class="fa fa-chevron-right"></i> Click <strong
											class="text-primary">Validate</strong> or <strong
											class="text-success">Resend OTP.</strong>
										</li>
									</ul>
								</div>
							</div>
						</div>
						<!-- Section Attendance-->
						<div class="card border-warning mb-4">
							<div class="card-header bg-warning text-dark card-heading"
								data-toggle="collapse" data-target="#attendance"
								aria-expanded="false" aria-controls="attendance">
								<span><i class="fa fa-user me-2"></i><i
									class="fa fa-check-circle me-2"></i> Attendance</span> <i
									class="fa fa-chevron-down"></i>
							</div>
							<div id="attendance" class="collapse">
								<div class="card-body">
									<ul class="list-group list-group-numbered">
										<li class="list-group-item">Click <strong
											class="text-success">Attendance.</strong></li>
										<li class="list-group-item">Mark attendance for each
											member (Present/Absent).</li>
										<h6 class="text-danger font-weight-bold">Note: Kindly
											update the serial number list to ensure that the employee
											order is accurately reflected in the reports.</h6>
										<li class="list-group-item">Click <strong
											class="text-warning">Update.</strong> <i
											class="fa fa-chevron-right"></i> Click <strong
											class="text-success">Back.</strong>
										</li>
									</ul>
								</div>
							</div>
						</div>
						<!-- Section Minutes-->
						<div class="card border-secondary mb-4">
							<div class="card-header bg-secondary text-white card-heading"
								data-toggle="collapse" data-target="#mom" aria-expanded="false"
								aria-controls="mom">
								<span><i class="fa fa-file-text me-2"></i> Minutes of
									Meeting</span> <i class="fa fa-chevron-down"></i>
							</div>
							<div id="mom" class="collapse">
								<div class="card-body">
									<ul class="list-group list-group-numbered">
										<li class="list-group-item">Click <strong
											class="text-primary">Minutes.</strong>
										</li>
										<li class="list-group-item">Fill fields: <em>Introduction,
												Opening Remarks,</em><br> <em class="text-success">Agenda
												<ul class="list-group list-group-numbered">
													<li class="list-group-item">Presentation and
														Discussion : Click Add button <i
														class="fa fa-chevron-right"></i>Enter Action Name, Remark
														(if any). Click Submit. </i>
													</li>
													<h6 class="text-danger">Note: Outcome is classified
														into six types: Action, Comment, Decision, Issue,
														Recommendation, and Risk.</h6>
													<li class="list-group-item">Outcomes: Select the
														outcome type from the dropdown menu <i
														class="fa fa-chevron-right"></i> Click Add <i
														class="fa fa-chevron-right"></i> Enter Action Name, Remark
														(if any). Click Submit.
													</li>
												</ul>
										</em>, <em> Other Discussion, Other Outcomes: Similar to the
												agenda outcomes section, Conclusion <i
												class="fa fa-chevron-right"></i>Click <strong
												class="text-success">Submit.</strong>
										</em>
										</li>
									</ul>
								</div>
							</div>
						</div>
						<!-- Section action assignment -->
						<div class="card border-danger mb-4">
							<div class="card-header bg-danger text-white card-heading"
								data-toggle="collapse" data-target="#action-assignment"
								aria-expanded="false" aria-controls="action-assignment">
								<span><i class="fa fa-tasks me-2"></i> Action Assignment</span>
								<i class="fa fa-chevron-down"></i>
							</div>
							<div id="action-assignment" class="collapse">
								<div class="card-body">
									<ul class="list-group list-group-numbered">
										<li class="list-group-item">Click <strong
											class="text-primary">Assign Action <i
												class="fa fa-thumbs-up"></i>.
										</strong></li>
										<h6 class="text-danger font-weight-bold">Note: On the
											left-hand side, you can choose the action you want to assign
											by clicking on it.</h6>
										<li class="list-group-item">Enter <em>PDC,Priority,
												Category ,Lab, Assignee(s) </em> <i class="fa fa-chevron-right"></i>
											Click <strong class="text-success">Submit.</strong></li>
										<h6 class="text-danger font-weight-bold">Note: Actions
											can be assigned to multiple employees and to another lab as
											well.</h6>

										<li class="list-group-item"><strong class="text-primary">Edit
										</strong>or <strong class="text-danger">Delete </strong>actions using
											buttons in the action list.</li>
									</ul>
								</div>
							</div>
						</div>
						<!-- Section MOM Approvals-->
						<div class="card border-dark mb-4">
							<div class="card-header bg-dark text-white card-heading"
								data-toggle="collapse" data-target="#mom-approval"
								aria-expanded="false" aria-controls="mom-approval">
								<span><i class="fa fa-check-circle me-2"></i> Minutes of
									Approval</span> <i class="fa fa-chevron-down"></i>
							</div>
							<div id="mom-approval" class="collapse">
								<div class="card-body">
									<ul class="list-group list-group-numbered">
										<h6 class="text-danger">Note: Once the MOM is approved,
											no further changes can be made.</h6>
										<li class="list-group-item"><strong class="text-primary">Click
												<i class="fa fa-chevron-right"></i> Minutes Approval.
										</strong></li>
										<h6 class="text-danger">Note: One Recommending Officer
											and Approving Officer is Mandatory</h6>
										<li class="list-group-item">Enter Officer role and select
											<strong class="text-success"> Recommending Officers
												and Approving Officers . </strong>
										</li>
										<li class="list-group-item">Click <strong
											class="text-warning">Update</strong> <i
											class="fa fa-chevron-right"></i> <strong class="text-success">Forward.</strong>
											Can Revoke the request also, by clicking <strong
											class="text-danger">Revoke.</strong>
										</li>
										<h6 class="text-danger">Note: Recommending Officer will
											get Notification</h6>
										<li class="list-group-item">Recommending Officer will
											navigate to notification or Click <strong
											class="text-success">Approvals <i
												class="fa fa-chevron-right"></i> Mom Approvals <i
												class="fa fa-chevron-right"></i> <i class="fa fa-eye"></i></strong>
										</li>
										<li class="list-group-item">Enter Remark.Recommending
											Officer can <strong class="text-success">Recommend</strong>
											or <strong class="text-danger">Return.</strong>
										</li>
										<li class="list-group-item">Once Recommended,
											Notification will be sent to Approving Officer. Approving
											Officer can navigate to notification or Click <strong
											class="text-success">Approvals <i
												class="fa fa-chevron-right"></i> Mom Approvals <i
												class="fa fa-chevron-right"></i> <i class="fa fa-eye"></i></strong>.
											Enter Remark, Approving Officer can <strong
											class="text-success">Approve</strong> or <strong
											class="text-danger">Return.</strong>
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- Action UserGuide -->
		<div id="action">
			<div class="card border-info mb-3 mt-5">
				<div class="card-header bg-info text-white">
					<h5 class="ml-3">
						<i class="fa fa-tasks"></i> Action User Guide
					</h5>
				</div>
				<div class="card-body">
					<!-- Section-1:Creating a new action item -->
					<div class="card border-primary mb-4">
						<div class="card-header card-heading bg-primary text-white"
							data-toggle="collapse" data-target="#create-action-item"
							aria-expanded="true" aria-controls="create-action-item">
							<span><i class="fa fa-plus-circle me-2"></i> Creating a
								New Action/ Issue/ Risk Item</span> <i
								class="fa fa-chevron-down toggle-arrow"></i>
						</div>
						<div id="create-action-item" class="collapse show">
							<div class="card-body">
								<h6 class="text-danger font-weight-bold">Note: Only users
									with higher-level roles can assign action items.</h6>
								<ul class="list-group list-group-numbered ">
									<li class="list-group-item">Click <strong
										class="text-primary">Action Items <i
											class="fa fa-chevron-right"></i> New Action.
									</strong></li>
									<li class="list-group-item">Enter <strong
										class="text-success">Action Item, PDC, Project,
											Action Type (Issue,Risk,Action), Priority and Category.</strong>

									</li>
									<li class="list-group-item">Click <strong
										class="text-success">Submit.</strong></li>
									<h6 class="text-danger font-weight-bold">Note: Actions can
										be assigned to multiple employees and to another lab as well.</h6>
									<li class="list-group-item">Select <strong
										class="text-success">Lab, Assignee</strong> and upload <strong
										class="text-success">attachment</strong> (if any).
									</li>
									<h6 class="text-primary">To Edit Action Item</h6>
									<li class="list-group-item">Scroll down to the <strong
										class="text-primary">Action Assigned list</strong>, locate the
										action item, and click <strong class="text-primary"><i
											class="fa fa-edit"></i> Edit </strong> (editing is allowed only until
										the assignee has viewed it), a new window will appear where
										you can make your changes.
									</li>
									<h6 class="text-primary">To perform additional operations
										(Re-assign, Extend PDC,Update Progress)</h6>
									<li class="list-group-item">Scroll down to the <strong
										class="text-primary">Action Assigned list</strong>, locate the
										action item, and click <strong class="text-primary"><i
											class="fa fa-eye"></i> Actions </strong> <i
										class="fa fa-chevron-right"></i> Select Assignee/Select PDC/ <em>Select
											Progress Date, Enter progress, Attachment and Remarks</em> and
										Click <strong class="text-warning"> Reassign</strong>/ <strong
										class="text-success">Extend PDC</strong> / <strong
										class="text-success">Submit</strong>.
									</li>
								</ul>
							</div>
						</div>
					</div>
					<!-- Section-1:Update Work Progress -->
					<div class="card border-success mb-4">
						<div class="card-header card-heading bg-success text-white"
							data-toggle="collapse" data-target="#update-work-progress"
							aria-expanded="true" aria-controls="update-work-progress">
							<span><i class="fa fa-tasks me-2"></i> Update Work
								Progress (Action/Issue/Risk)</span> <i
								class="fa fa-chevron-down toggle-arrow"></i>
						</div>
						<div id="update-work-progress" class="collapse">
							<div class="card-body">
								<ul class="list-group list-group-numbered ">
									<h6 class="text-danger font-weight-bold">Note: Action item
										can be from Meetings also.</h6>
									<li class="list-group-item">Click <strong
										class="text-primary">Action items <i
											class="fa fa-chevron-right"></i> To Act <i
											class="fa fa-chevron-right"></i> <i class="fa fa-eye"></i>
											Details.
									</strong></li>
									<li class="list-group-item">Fill the details <em>As
											on date, Remarks, Progress, Attachment(if any).</em> <i
										class="fa fa-chevron-right"></i> Click <strong
										class="text-success">Submit.</strong> <i
										class="fa fa-chevron-right"></i> Click <strong
										class="text-success">Action Forward.</strong>
									</li>
									<h6 class="text-danger">Note: Higher Official can send
										back also.</h6>
									<li class="list-group-item">Click <strong
										class="text-primary"><i class="fa fa-refresh"></i>
											Distribute </strong> to distribute action items with other employees.
									</li>
									<li class="list-group-item">Click <strong
										class="text-success"><i class="fa fa-sitemap"></i>
											Tree</strong> to view the action tree.
									</li>
								</ul>
							</div>
						</div>
					</div>
					<!-- Section-3:Review and Close Action Item -->
					<div class="card border-info mb-4">
						<div class="card-header card-heading bg-info text-white"
							data-toggle="collapse" data-target="#review-close"
							aria-expanded="true" aria-controls="review-close">
							<span><i class="fa fa-eye me-2"></i> Review and Close
								(Action/Issue/Risk)</span> <i class="fa fa-chevron-down toggle-arrow"></i>
						</div>
						<div id="review-close" class="collapse">
							<div class="card-body">
								<ul class="list-group list-group-numbered ">
									<li class="list-group-item">Click <strong
										class="text-primary">Action items <i
											class="fa fa-chevron-right"></i> To Review <i
											class="fa fa-chevron-right"></i> <i class="fa fa-eye"></i>
											Details.
									</strong></li>
									<li class="list-group-item">Enter <em> Remarks </em> <i
										class="fa fa-chevron-right"></i> Click <strong
										class="text-danger">Close Action Item </strong> / <strong
										class="text-warning">Send Back </strong> to close action item
										or to return back.
									</li>
									<h6 class="text-primary">To Extend PDC</h6>
									<li class="list-group-item">Select PDC <i
										class="fa fa-chevron-right"></i> Click <strong
										class="text-success">Update.</strong>
									</li>
									<h6 class="text-primary">To view Action Tree</h6>
									<li class="list-group-item">Click <strong
										class="text-success"><i class="fa fa-sitemap"></i>
											Action Tree</strong> to view Action Tree.
									</li>
								</ul>
							</div>
						</div>
					</div>
					<!-- Section-4:Reports -->
					<div class="card border-secondary mb-4">
						<div class="card-header card-heading bg-secondary text-white"
							data-toggle="collapse" data-target="#action-report"
							aria-expanded="true" aria-controls="action-report">
							<span><i class="fa fa-bar-chart me-2"></i> Reports</span> <i
								class="fa fa-chevron-down toggle-arrow"></i>
						</div>
						<div id="action-report" class="collapse">
							<div class="card-body">
								<h6 class="text-danger font-weight-bold">Note: You can view
									all the action report according to status
									(ex:In-Progress,All,Not-started etc)</h6>
								<ul class="list-group list-group-numbered ">
									<li class="list-group-item">Click <strong
										class="text-primary">Reports <i
											class="fa fa-chevron-right"></i> Action Report.
									</strong></li>
									<h6 class="text-danger">Note: Based on the user's login
										role, the project list and assigned employees will be
										displayed accordingly.</h6>
									<li class="list-group-item">At the top of the screen,
										Filter based on <em class="text-success">Project,
											Assignee, Type (Action,Milestone,Meeting), Status
											(Inprogress,Not-Started,Closed) </em> <i
										class="fa fa-chevron-right"></i> Click <i
										class="fa fa-download text-danger"></i> button.
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
		<div id="milestone">
			<div class="card border-danger mb-3 mt-5">
				<div class="card-header bg-danger text-white">
					<h5 class="ml-3">
						<i class="fa fa-flag-checkered"></i> Milestone User Guide
					</h5>
				</div>
				<div class="card-body">
					<!-- Creating a Milestone -->
					<div class="card border-danger mb-4">
						<div class="card-header card-heading bg-danger text-white"
							data-toggle="collapse" data-target="#creating-milestone"
							aria-expanded="true" aria-controls=creating-milestone">
							<span> <i class="fa fa-flag-checkered me-2"></i> Creating
								a milestone
							</span> <i class="fa fa-chevron-down"></i>
						</div>
						<div id="creating-milestone" class="collapse show">
							<div class="card-body">
								<h6 class="text-danger">Note: Only Project Director or
									Admin can add Milestone activity.</h6>
								<ul class="list-group list-group-numbered">
									<li class="list-group-item">Click <i
										class="fa fa-chevron-right"></i> <strong class="text-primary">Milestone</strong>
										<i class="fa fa-chevron-right"></i> <strong
										class="text-primary">New Activity</strong> <i
										class="fa fa-chevron-right"></i> <strong class="text-primary">Select
											Project</strong> <i class="fa fa-chevron-right"></i> <strong
										class="text-primary"> Add Activity. </strong>
									</li>
									<h6 class="text-danger">Note: Check 'All' to load all
										employees.</h6>
									<li class="list-group-item"><strong class="text-info">Enter
											the details:</strong> <em> Activity name, Type, From, To, First
											OIC, Second OIC </em> <i class="fa fa-chevron-right"></i> Click <strong
										class="text-success">Submit.</strong></li>
									<li class="list-group-item">Fill out the sub-activities
										section as well. Click <strong class="text-success">
											Submit </strong> after completing each sub-activity details.
									</li>
									<h6 class="text-danger font-weight-bold">Note: Project
										Director, the Admin, and the OICs of the Parent Milestone are
										authorized to add, edit and assigning weights to milestones.</h6>
								</ul>
							</div>
						</div>
					</div>
					<!-- Assigning weights to  a Milestone -->
					<div class="card border-primary mb-4">
						<div class="card-header card-heading bg-primary text-white"
							data-toggle="collapse" data-target="#assigning-weights"
							aria-expanded="true" aria-controls="assigning-weights">
							<span><i class="fa fa-balance-scale me-2"></i> Assigning
								weightage to milestone</span> <i class="fa fa-chevron-down"></i>
						</div>
						<div id="assigning-weights" class="collapse">
							<div class="card-body">
								<ul class="list-group list-group-numbered">
									<h6 class="text-danger">Note: Ensure that the total
										weightage for each of milestones, activities, and
										sub-activities is 100.</h6>
									<li class="list-group-item">Click <i
										class="fa fa-chevron-right"></i> <strong class="text-success">Milestone</strong>
										<i class="fa fa-chevron-right"></i> <strong
										class="text-success">New Activity</strong> <i
										class="fa fa-chevron-right"></i> <strong class="text-success">Select
											Project</strong> <i class="fa fa-chevron-right"></i> <strong
										class="text-success"> Edit weightage. </strong>
									</li>
									<li class="list-group-item"><strong class="text-info">Enter
											the weightage for each activity and sub-activity.</strong></li>
									<li class="list-group-item">Click <strong
										class="text-success">Edit Button.</strong>
									</li>
								</ul>
							</div>
						</div>
					</div>
					<!-- Assigning milestone to employees -->
					<div class="card border-success mb-4">
						<div class="card-header card-heading bg-success text-white"
							data-toggle="collapse" data-target="#assigning-employees"
							aria-expanded="true" aria-controls="assigning-employees">
							<span> <i class="fa fa-user-plus me-2"></i> Assigning
								milestone to employees
							</span> <i class="fa fa-chevron-down"></i>
						</div>
						<div id="assigning-employees" class="collapse">
							<div class="card-body">
								<ul class="list-group list-group-numbered">
									<li class="list-group-item">Click <i
										class="fa fa-chevron-right"></i> <strong class="text-danger">Milestone</strong>
										<i class="fa fa-chevron-right"></i> <strong
										class="text-danger">New Activity</strong> <i
										class="fa fa-chevron-right"></i> <strong class="text-danger">Select
											Project</strong> <i class="fa fa-chevron-right"></i> <strong
										class="text-danger"> Assign </strong>.
									</li>
									<li class="list-group-item"><strong class="text-info">Respected
											OIC's will navigate to Milestone <i
											class="fa fa-chevron-right"></i> Assignee <i
											class="fa fa-chevron-right"></i>
									</strong> <strong class="text-success">Accept</strong> or <strong
										class="text-danger">Send Back.</strong></li>
								</ul>
							</div>
						</div>
					</div>
					<!-- Update Milestone Activity -->
					<div class="card border-warning mb-4">
						<div class="card-header card-heading bg-warning text-dark"
							data-toggle="collapse" data-target="#update-activity"
							aria-expanded="true" aria-controls="update-activity">
							<span> <i class="fa fa-wrench me-2"></i> Update Activity
								items
							</span> <i class="fa fa-chevron-down"></i>
						</div>
						<div id="update-activity" class="collapse">
							<div class="card-body">
								<ul class="list-group list-group-numbered">
									<li class="list-group-item">Employees can navigate to
										notification or Click <strong class="text-danger">Milestone
											<i class="fa fa-chevron-right"></i> Assignee <i
											class="fa fa-chevron-right"></i> Click Settings icon(Update).
									</strong>
									</li>
									<li class="list-group-item"><strong class="text-primary">Enter
											the Details:</strong> <br> <em> Progress, Progress Date,
											Attach file (if any) and Remarks. Click <strong
											class="text-success">Submit.</strong>
									</em></li>
									<h6 class="text-danger">Note: Select an employee from the
										right side to reassign the activity to another person.</h6>
								</ul>
							</div>
						</div>
					</div>
					<!-- Set and Compare Baseline -->
					<div class="card border-info mb-4">
						<div class="card-header card-heading bg-info text-white"
							data-toggle="collapse" data-target="#set-and-compare"
							aria-expanded="true" aria-controls="set-and-compare">
							<span><i class="fa fa-bar-chart me-2"></i> Set Baseline</span> <i
								class="fa fa-chevron-down"></i>
						</div>
						<div id="set-and-compare" class="collapse">
							<div class="card-body">
								<ul class="list-group list-group-numbered">

									<li class="list-group-item">Respected OIC's of the parent
										milestone, Project director and Admin can set baseline and
										will navigate to <strong class="text-danger">
											Milestone <i class="fa fa-chevron-right"></i> New Activity <i
											class="fa fa-chevron-right"></i>
									</strong> <strong class="text-info">Baseline</strong>.
									</li>
									<li class="list-group-item">Make changes specific to that
										particular milestone.</li>
									<li class="list-group-item">Click <strong
										class="text-warning font-weight-bold">Update Icon,</strong>
										and then Click <strong class="text-success">Set
											Baseline </strong> Button.
									</li>
									<h6 class="text-danger">After any change in milestone,
										baseline should be set to get it displayed latest data.</h6>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
		<!-- CARS UserGuide -->
		<div id="CARS">
			<div class="card border-warning mb-3 mt-5">
				<div class="card-header bg-warning text-dark">
					<h5 class="ml-3">
						<i class="fa fa-book"></i> CARS User Guide
					</h5>
				</div>
				<div class="card-body">
					<!-- RSQR FLow -->
					<div class="card border-primary mb-4">
						<div class="card-header card-heading bg-primary text-white"
							data-toggle="collapse" data-target="#rsqr-flow"
							aria-expanded="true" aria-controls="rsqr-flow">
							<span> <i class="fa fa-tasks me-2"></i> RSQR(Research
								Service Qualitative Requirement ) Flow
							</span> <i class="fa fa-chevron-down"></i>
						</div>
						<div id="rsqr-flow" class="collapse show">
							<div class="card-body">
								<ol class="list-group list-group-numbered">
									<li class="list-group-item">Click <strong
										class="text-primary">CARS</strong> <i
										class="fa fa-chevron-right"></i> <strong>Initiated
											List</strong> <i class="fa fa-chevron-right"></i> <strong
										class="text-primary">Add CARS</strong>.
									</li>
									<li class="list-group-item"><strong class="text-info">Enter:</strong>
										<em>CARS Title,Funds From, Amount, Duration, Aim,
											Justification,RSP Details and Principal Investigator Details
									</em></li>
									<h6 class="text-primary">To Update any details</h6>
									<li class="list-group-item">Click <strong
										style="color: orange;">Update</strong> : Update any details
									</li>
									<li class="list-group-item">Click <strong
										class="text-success">Next</strong> <i
										class="fa fa-chevron-right text-success"></i> <br> <strong
										class="text-info">Enter:</strong> <em>Introduction,
											Research Overview, Objectives,Major
											Requirements,Deliverables,Milestone & Timelines ,Major
											Requirements Scope of RSP, Scope of LRDE, Success Criterion,
											Literature Reference(if any). <i class="fa fa-chevron-right"></i>
											Click <strong class="text-success">Submit </strong>after
											entering each detail
									</em> <i class="fa fa-chevron-right"></i> Click <strong
										class="text-success">Next</strong> <i
										class="fa fa-chevron-right"></i>Enter <strong
										class="text-dark">Remarks</strong> <i
										class="fa fa-chevron-right"></i> Click <strong
										class="text-success">Forward.</strong>
									</li>
									<h6 class="text-danger">
										Note: User can revoke the CARS by navigating to CARS <i
											class="fa fa-chevron-right"></i> Initiated List <i
											class="fa fa-chevron-right"></i> Click <strong
											class="text-danger"><i class="fa fa-undo"></i>
											Revoke.</strong>
									</h6>
									<h6 class="text-danger">Note: A notification will be sent
										to the Project Director/GD.</h6>
									<h6 class="text-danger">Approver will get the CARS RSQR
										PDF to view before approval and RSQR approval form to download
									</h6>
									<li class="list-group-item">Project Director/GD will
										navigate to notification or Click <strong class="text-danger">CARS</strong>
										<i class="fa fa-chevron-right"></i> <strong
										class="text-danger">Approvals.</strong>
									</li>
									<li class="list-group-item">Click <strong
										class="text-info"><i class="fa fa-file-text"></i>
											RSQR </strong>: To Download <strong class="text-info">RSQR</strong>
										document.
									</li>
									<li class="list-group-item">Click <strong
										class="text-success"><i class="fa fa-file-text"></i>
											RSQR Approval Download </strong>: To Download <strong
										class="text-success">RSQR</strong> approval document.
									</li>
									<li class="list-group-item">Click <strong
										class="text-primary"><i class="fa fa-eye"></i>
											Preview</strong> <i class="fa fa-chevron-right"></i> <strong
										class="text-danger">Recommending Officer </strong> can <strong
										class="text-success">Recommend</strong> or <strong
										class="text-danger">Return.</strong>
									</li>
									<h6 class="text-danger font-weight-bold">
										Once <strong>RSQR Pre-Approved </strong>.A notification will
										be sent to <strong class="text-danger">DP&C.</strong>
									</h6>
									<li class="list-group-item">DP&C will navigate to <strong
										class="text-primary">CARS</strong> <i
										class="fa fa-chevron-right"></i> <strong class="text-primary">All
											CARS.</strong>
									</li>
									<li class="list-group-item">Click <strong
										class="text-primary"><i class="fa fa-eye"></i>
											Preview</strong>: Preview RSQR Approval Details
									</li>
									<li class="list-group-item">Click <strong
										class="text-success"><i class="fa fa-file-text"></i>
											RSQR</strong>:Download RSQR Details
									</li>
									<li class="list-group-item">Click <strong
										class="text-info"><i class="fa fa-calendar"></i>
											Summary Of Offer Inv</strong>: Select the Date on which the SoO
										Invitation should be sent.
									</li>
									<li class="list-group-item">Click <strong
										class="text-success"><i class="fa fa-folder-open"></i>
											Inv for SoO</strong>: Download Summary of Offer
									</li>
									<li class="list-group-item">Click <strong
										class="text-danger"><i class="fa fa-file-text"></i>
											Pro form</strong>: Download Summary Offer of Provision of Research
										Services
									</li>
									<h6 class="text-danger">DP&C will download the RSQR
										file,SoO Invitation,Pro form documents, and send them to the
										respective institution for completion.</h6>
									<li class="list-group-item">Initiated person will Navigate
										to <strong class="text-primary">CARS</strong> <i
										class="fa fa-chevron-right"></i> <strong class="text-primary">Initiated
											List</strong> <i class="fa fa-chevron-right"></i> <strong
										class="text-primary">Details</strong> <i
										class="fa fa-chevron-right"></i> <strong class="text-primary">SOC</strong>

									</li>
									<li class="list-group-item"><strong class="text-info">Fill
											the details:</strong> <em>Upload Summary,Upload Feasibility
											Report, Execution Plan,Amount,Alignment with, Justification
											for time reasonability,Justification for Cost
											reasonability,Justification for Selection of RSP,
											Success/Acceptance Criterion,RSP's offer Ref,RSP's offer
											Date,Key Professional-1 Details, Key Professional-2
											Details,Research Consultants,DRDO-Owned Equipment,Expenditure
											on items. <i class="fa fa-chevron-right"></i> Click <strong
											class="text-success">Submit.</strong> <i
											class="fa fa-chevron-right"></i> Click <strong
											class="text-success">Next.</strong>
									</em></li>
									<h6 class="text-danger">In Final RSQR, you can update any
										detail, but Milestone and Timelines section is mandatory to
										update.</h6>
									<li class="list-group-item">Navigate to <strong
										class="text-danger">Final RSQR </strong>,Update Milestone and
										Timelines Enter: <em>Percentage and amount each Milestone
											requires.</em> <i class="fa fa-chevron-right"></i> SOC Forward <i
										class="fa fa-chevron-right"></i> Enter <strong>Remark</strong>
										<i class="fa fa-chevron-right"></i> Click <strong
										class="text-success">Forward.</strong>
									</li>

									<h6 class="text-danger">Notification will be sent to
										Project Director/GD.</h6>
									<li class="list-group-item">Project Director/GD will
										navigate to notification or Click <strong class="text-primary">CARS
											<i class="fa fa-chevron-right"></i> Approvals.
									</strong>
									</li>
									<li class="list-group-item">Click <strong
										class="text-primary"><i class="fa fa-file-text"></i>
											RSQR download </strong>: To Download <strong class="text-primary">RSQR</strong>
										document.
									</li>
									<li class="list-group-item">Click <strong
										class="text-success"><i class="fa fa-file-text"></i>
											Download </strong>: Download <strong class="text-success">RSQR</strong>
										SOC document.
									</li>
									<li class="list-group-item">Click <strong
										class="text-info"><i class="fa fa-eye"></i> Preview</strong> <i
										class="fa fa-chevron-right"></i> <strong class="text-danger">Approving
											Officer </strong> can <strong class="text-success">Approve</strong> or
										<strong class="text-danger">Return.</strong>

									</li>
								</ol>
							</div>
						</div>
					</div>
					<!-- Constitute Committee for CARS -->
					<div class="card border-warning mb-4 ">
						<div class="card-header card-heading bg-warning text-dark"
							data-toggle="collapse" data-target="#constitute-committee-cars"
							aria-expanded="true" aria-controls="constitute-committee-cars">
							<span> <i class="fa fa-users me-2"></i> Constitute
								Committee for CARS
							</span> <i class="fa fa-chevron-down"></i>
						</div>
						<div id="constitute-committee-cars" class="collapse">
							<div class="card-body ">
								<ul class="list-group list-group-numbered">
									<li class="list-group-item">Click <strong
										class="text-success">CARS</strong> <i
										class="fa fa-chevron-right"></i> <strong class="text-success">Initiated
											List</strong> <i class="fa fa-chevron-right"></i><strong
										class="text-success">Click Constitute Members</strong>
									</li>
									<li class="list-group-item">Add Members -> Select -> Click
										<strong class="text-success">Submit</strong>
									</li>
									<li class="list-group-item">Update <strong
										style="color: orange;">Serial No List.</strong></li>
									<h6 class="text-danger font-weight-bold">Note: Kindly
										update the serial number list to ensure that the employee
										order is accurately reflected in the reports.</h6>
									<h6 class="font-weight-bold text-danger">If Committee is
										Not Pre-Approved Follow these Additional Steps</h6>
									<li class="list-group-item">Click <strong
										class="text-primary">Preview</strong> -> Select <strong
										class="text-success">Recommending Officer</strong> and <strong
										class="text-success">Approving Officer.</strong>
										<h6 class="text-danger">Note: One Approving Officer and
											Recommending Officer Mandatory.</h6>
									</li>
									<li class="list-group-item">Click <strong
										class="text-danger">Update</strong> <i
										class="fa fa-chevron-right"></i> <strong class="text-success">Forward</strong>
										to Recommending Officer.
									</li>
									<li class="list-group-item">Can <strong
										class="text-danger">Revoke</strong> the request.
									</li>
									<li class="list-group-item"><strong class="text-danger">Recommending
											Officer </strong> can <strong class="text-success">Recommend</strong>
										or <strong class="text-danger">Return.</strong></li>
									<li class="list-group-item"><strong class="text-primary">Approving
											Officer </strong> can <strong class="text-success">Approve</strong> or
										<strong class="text-danger">Return.</strong></li>

								</ul>
							</div>
						</div>
					</div>
					<!-- MOM Upload -->
					<div class="card border-success mb-4 ">
						<div class="card-header card-heading bg-success text-white"
							data-toggle="collapse" data-target="#mom-upload-cars"
							aria-expanded="true" aria-controls="mom-upload-cars">
							<span> <i class="fa fa-upload me-2"></i> MOM Upload
							</span> <i class="fa fa-chevron-down"></i>
						</div>
						<div id="mom-upload-cars" class="collapse">
							<div class="card-body ">
								<ul class="list-group list-group-numbered">
									<h6 class="text-danger">Once the meeting is completed,the
										Minutes of Meeting will be uploaded to the designated
										location.</h6>

									<li class="list-group-item">Navigate to <strong
										class="text-success">CARS</strong> <i
										class="fa fa-chevron-right"></i> <strong class="text-success">
											Details</strong> <i class="fa fa-chevron-right"></i><strong
										class="text-success">Mom Upload</strong>.
									</li>
								</ul>
							</div>
						</div>

					</div>
					<!-- SOC Flow -->
					<div class="card border-warning mb-4">
						<div class="card-header card-heading bg-warning text-dark"
							data-toggle="collapse" data-target="#soc-flow"
							aria-expanded="true" aria-controls="soc-flow">
							<span> <i class="fa fa-pencil-square-o"> SOC(Statement
									of Case) Flow</i></span> <i class="fa fa-chevron-down"></i>
						</div>
						<div class="collapse" id="soc-flow">

							<div class="card-body ">
								<ul class="list-group list-group-numbered">
									<li class="list-group-item">DP&C will navigate to <strong
										class="text-primary">CARS</strong> <i
										class="fa fa-chevron-right"></i> <strong class="text-primary">All
											CARS</strong> <i class="fa fa-chevron-right"></i> <strong
										class="text-primary">SOC.</strong>
									</li>
									<li class="list-group-item">Click on <strong
										class="text-success">Details of any SOC record</strong> <i
										class="fa fa-chevron-right"></i> <strong class="text-success">
											Enter SOC details</strong> <br> <em> Introduction,
											Expenditure Head, Additional Points (if any). </em> <i
										class="fa fa-chevron-right"></i> Click <strong
										class="text-success">Submit</strong>.
									</li>

									<li class="list-group-item">Go to next Tab <i
										class="fa fa-chevron-right"></i> <strong class="text-success">SOC
											Forward.</strong>
									</li>
									<li class="list-group-item"><strong class="text-danger">Approval
											Flow For DP&C SoC Forward</strong></li>
									<li class="list-group-item"><strong class="text-success">GH-DP&C
											<i class="fa fa-chevron-right"></i> GD-DP&C <i
											class="fa fa-chevron-right"></i> PD/GD <i
											class="fa fa-chevron-right"></i> MMFD AG <i
											class="fa fa-chevron-right"></i> GD DF&M <i
											class="fa fa-chevron-right"></i>
									</strong></li>
									<li class="list-group-item"><strong class="text-danger">
											If Amount is </strong>
										<ul class="list-group list-group-numbered">
											<li class="list-group-item"><= 10,00,000 <i
												class="fa fa-chevron-right"></i> <strong class="text-danger">Director</strong>.
											</li>
											<li class="list-group-item">>10,00,000 and Amount <
												50,00,000 <i class="fa fa-chevron-right"> </i> <strong
												class="text-danger">IFA O/o DG(ECS)</strong> <i
												class="fa fa-chevron-right"></i> <strong class="text-danger">Director</strong>.
											</li>
											<li class="list-group-item">> 50,00,000 and Amount <=
												3,00,00,000 <i class="fa fa-chevron-right"></i> <strong
												class="text-danger">Director</strong> <i
												class="fa fa-chevron-right"></i> <strong class="text-danger">IFA</strong>
												<i class="fa fa-chevron-right"></i> <strong
												class="text-danger">DG</strong>.
											</li>
											<li class="list-group-item">> 3,00,00,000 <i
												class="fa fa-chevron-right"></i><strong class="text-danger">Director</strong>
												<i class="fa fa-chevron-right"></i> <strong
												class="text-danger">JSA</strong> <i
												class="fa fa-chevron-right"></i> <strong class="text-danger">SECY</strong>.
											</li>
										</ul></li>

									<h6 class="text-danger">Note:In flow if there is IFA and
										JSA those officers are external officers. Hence on behalf of
										them, DP & C officers himself will approve on obtaining manual
										approval from them.</h6>

									<li class="list-group-item">After approval flow is
										completed All the docs are available to download in <strong
										class="text-success">All Docs</strong> tab.
									</li>

								</ul>
							</div>
						</div>
					</div>
					<!-- CARS Flow -->
					<div class="card border-danger mb-4 ">
						<div class="card-header card-heading bg-danger text-white"
							data-toggle="collapse" data-target="#cars-flow"
							aria-expanded="true" aria-controls="cars-flow">
							<span> <i class="fa fa-file-text"></i> CARS (Contract for
								Acquiring Research Services) Flow
							</span> <i class="fa fa-chevron-down"></i>
						</div>
						<div class="collapse" id="cars-flow">
							<div class="card-body ">
								<ul class="list-group list-group-numbered">
									<li class="list-group-item">DP&C will navigate to <strong
										class="text-danger">CARS</strong> <i
										class="fa fa-chevron-right"></i> <strong class="text-danger">All
											CARS</strong> <i class="fa fa-chevron-right"></i> <strong
										class="text-danger">CARS-03.</strong>
									</li>
									<li class="list-group-item">Click on <strong
										class="text-danger">Details</strong> under action of any CARS
										record <br> <strong class="text-info">Enter the
											details:</strong> <br> <em> Contract Date, T0 Date, T0
											Remarks </em>
									</li>
									<h6 class="text-danger">DP&C will download the CARS-03
										word and pdf, and send them to the respective institution.</h6>
									<li class="list-group-item ">Click on <strong
										class="text-success">other Doc</strong> after updating
										contract details.
									</li>
									<li class="list-group-item">Click on <strong
										class="text-primary">CONTRACT SIGNATURE BUTTON</strong> <br>
										<strong class="text-primary">Fill the details such as
											Date,Flag-A,Flag-B and Flag-C.</strong>
									</li>
									<li class="list-group-item">Get the contract signed and
										approved and upload related documents in <strong
										class="text-success"> Doc Upload tab. </strong>
										<h6 class="text-danger">Note: Approval flow is
											auto-generated and shown below.</h6>
									</li>
									<li class="list-group-item">Click on details action of any
										payment record <br> <strong class="text-primary">Fill
											the details such as Date,Flag-A,Flag-B and Flag-C,Invoice No
											and Invoice Date.</strong>
									</li>
									<li class="list-group-item">Navigate to payment approval
										page. Revert option also available if forwarded record is not
										yet approved by the next approver
										<h6 class="text-danger">Note: only GD DP & C is able to
											forward the payment for approval.</h6>
									</li>
									<li class="list-group-item">Upload related documents in <strong
										class="text-success"> Doc Upload tab. </strong>
									</li>
									<li class="list-group-item">Now in action list one more
										button added that is <strong class="text-success">Date</strong>.
										Click on it and update the Payment Date.
									</li>
									<li class="list-group-item">After updating the payment
										date payment letter can be downloaded.</li>
								</ul>
							</div>
						</div>
					</div>

				</div>
			</div>

		</div>
	</div>
	<!-- Back to Top Button -->
	<button onclick="scrollToTop()" id="topBtn" title="Go to top">
		<i class="fa fa-arrow-up"></i>
	</button>

	<script>
		// Show the button after scrolling down 100px
		window.onscroll = function() {
			const topBtn = document.getElementById("topBtn");
			if (document.body.scrollTop > 100
					|| document.documentElement.scrollTop > 100) {
				topBtn.style.display = "block";
			} else {
				topBtn.style.display = "none";
			}
		};

		// Smooth scroll to top
		function scrollToTop() {
			window.scrollTo({
				top : 0,
				behavior : 'smooth'
			});
		}
	</script>
</body>
</html>
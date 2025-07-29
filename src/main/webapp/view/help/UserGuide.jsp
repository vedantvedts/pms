<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User Guide</title>
<jsp:include page="../static/header.jsp"></jsp:include>
</head>
<style>
 .custom-card {
    border-radius: 16px;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    color: #fff;
    overflow: hidden;
    cursor: pointer;
  }

  .custom-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 12px 24px rgba(0, 0, 0, 0.2);
  }

  .custom-icon {
    font-size: 2.5rem;
    margin-bottom: 12px;
    text-shadow: 0 1px 3px rgba(0,0,0,0.2);
  }

  .card-body {
    padding: 1.8rem;
  }

  .card-title {
    font-weight: 600;
    font-size: 1.1rem;
    margin-bottom: 0;
  }

  /* Custom color themes */
  .bg-blue { background: linear-gradient(135deg, #007bff, #0056b3); }
  .bg-green { background: linear-gradient(135deg, #28a745, #1e7e34); }
  .bg-orange { background: linear-gradient(135deg, #fd7e14, #e8590c); }
  .bg-purple { background: linear-gradient(135deg, #6f42c1, #5a32a3); }
  .bg-pink { background: linear-gradient(135deg, #e83e8c, #b52d6d); }
  .bg-teal { background: linear-gradient(135deg, #20c997, #198754); }
  .bg-gray { background: linear-gradient(135deg, #6c757d, #495057); }
</style>
<body>
	<div class="container my-5">
		<div class="row justify-content-center">

		<!-- 	<div class="col-md-4 mb-4">
				<a href="RoadmapUserGuide.htm" target="_blank"
					class="text-white text-decoration-none">
					<div class="card custom-card bg-blue text-center">
						<div class="card-body">
							<div class="custom-icon">
								<i class="fa fa-road"></i>
							</div>
							<h5 class="card-title">Roadmap User Guide</h5>
						</div>
					</div>
				</a>
			</div> -->

			<!-- <div class="col-md-4 mb-4">
				<a href="MilestoneUserGuide.htm" target="_blank"
					class="text-white text-decoration-none">
					<div class="card custom-card bg-green text-center">
						<div class="card-body">
							<div class="custom-icon">
								<i class="fa fa-flag-checkered"></i>
							</div>
							<h5 class="card-title">Milestone User Guide</h5>
						</div>
					</div>
				</a>
			</div> -->

			<!-- <div class="col-md-4 mb-4">
				<a href="ClosureUserGuide.htm" target="_blank"
					class="text-white text-decoration-none">
					<div class="card custom-card bg-orange text-center">
						<div class="card-body">
							<div class="custom-icon">
								<i class="fa fa-times-circle"></i>
							</div>
							<h5 class="card-title">Closure User Guide</h5>
						</div>
					</div>
				</a>
			</div> -->

			<div class="col-md-4 mb-4">
				<a href="CommitteeUserGuide.htm" target="_blank"
					class="text-white text-decoration-none">
					<div class="card custom-card bg-purple text-center">
						<div class="card-body">
							<div class="custom-icon">
								<i class="fa fa-users"></i>
							</div>
							<h5 class="card-title">Committee User Guide</h5>
						</div>
					</div>
				</a>
			</div>

			<div class="col-md-4 mb-4">
				<a href="ScheduleUserGuide.htm" target="_blank"
					class="text-white text-decoration-none">
					<div class="card custom-card bg-pink text-center">
						<div class="card-body">
							<div class="custom-icon">
								<i class="fa fa-calendar"></i>
							</div>
							<h5 class="card-title">Schedule User Guide</h5>
						</div>
					</div>
				</a>
			</div>

			<div class="col-md-4 mb-4">
				<a href="ActionUserGuide.htm" target="_blank"
					class="text-white text-decoration-none">
					<div class="card custom-card bg-teal text-center">
						<div class="card-body">
							<div class="custom-icon">
								<i class="fa fa-tasks"></i>
							</div>
							<h5 class="card-title">Action User Guide</h5>
						</div>
					</div>
				</a>
			</div>

<!-- 			<div class="col-md-4 mb-4">
				<a href="ProcurementUserGuide.htm" target="_blank"
					class="text-white text-decoration-none">
					<div class="card custom-card bg-orange text-center">
						<div class="card-body">
							<div class="custom-icon">
								<i class="fa fa-shopping-cart"></i>
							</div>
							<h5 class="card-title">Procurement User Guide</h5>
						</div>
					</div>
				</a>
			</div>

			<div class="col-md-4 mb-4">
				<a href="FRACASUserGuide.htm" target="_blank"
					class="text-white text-decoration-none">
					<div class="card custom-card bg-gray text-center">
						<div class="card-body">
							<div class="custom-icon">
								<i class="fa fa-bug"></i>
							</div>
							<h5 class="card-title">FRACAS User Guide</h5>
						</div>
					</div>
				</a>
			</div>

			<div class="col-md-4 mb-4">
				<a href="CARSUserGuide.htm" target="_blank"
					class="text-white text-decoration-none">
					<div class="card custom-card bg-blue text-center">
						<div class="card-body">
							<div class="custom-icon">
								<i class="fa fa-book"></i>
							</div>
							<h5 class="card-title">CARS User Guide</h5>
						</div>
					</div>
				</a>
			</div> -->

		</div>
	</div>

</body>
</html>
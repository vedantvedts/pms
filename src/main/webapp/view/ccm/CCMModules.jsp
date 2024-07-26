<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<style type="text/css">
 .module{
 	max-width: 350px;
 	min-width: 350px;
 	max-height: 150px;
 	min-height: 150px;
 	overflow: hidden;
 	cursor: pointer;
 	border-top-color: #007bff;
    border-top-width: 0.2rem;
    border-radius: 0.75rem;
    box-shadow: 0px 30px 40px -20px #a3a5ae;
 }
 
 .emptymodule{
 	max-width: 100px;
 	min-width: 100px;
 	max-height: 150px;
 	min-height: 150px;
 	overflow: hidden;
 }
 
 .module>div>img{
 	float: right;
 	width: 100px;
 }
 
 .module>div>h5{
 	font-weight: bold;
 }
 
 .shadow-nohover{
 	padding-bottom: 2rem;
	box-shadow: 0px 30px 40px -20px #a3a5ae;
 }
 
</style>
</head>
<body>
	<% String ses=(String)request.getParameter("result");
	 	String ses1=(String)request.getParameter("resultfail");
		if(ses1!=null){
		%>
		<div align="center">
			<div class="alert alert-danger" role="alert">
		    <%=ses1 %>
		    </div>
		</div>
		<%}if(ses!=null){ %>
		<div align="center">
			<div class="alert alert-success" role="alert" >
		    	<%=ses %>
			</div>
		</div>
	<%} %>
	
	<div class="container-fluid mb-3">
		<div class="card shadow-nohover">
 			<div class="card-header" style="background-color: transparent;">
            	<h3 class="text-dark">CCM</h3>
       		</div>
	     
			<div class="d-flex justify-content-sm-between mt-3 mb-3">
				<div class="emptymodule"></div>
				
				<div class="card module" data-url="CCMCommitteeConstitution.htm">
					<div class="card-body">
						<h5>Committee Constitution</h5>
						<img alt="committee" src="view/images/committee.jpeg" >
					</div>
				</div>
				
				<div class="card module" data-url="CCMSchedule.htm">
					<div class="card-body">
						<h5>Schedule Meeting</h5>
						<img alt="schedule" src="view/images/meeting-schedule.png" >
					</div>
				</div>
				
				<div class="card module" data-url="CCMReport.htm">
					<div class="card-body">
						<h5>CCM Report</h5>
						<img alt="report" src="view/images/doc-report.png" >
					</div>
				</div>
				
				<div class="card module" data-url="#">
					<div class="card-body">
						<h5>Others</h5>
					</div>
				</div>
				
				<div class="emptymodule"></div>
			</div>
		</div> 
	</div>
<script>
	$(document).ready(function() {
		 $('.module').click(function() {
             var url = $(this).data('url');
             window.open(url, '_blank');
         });
	});
</script>	
</body>
</html>
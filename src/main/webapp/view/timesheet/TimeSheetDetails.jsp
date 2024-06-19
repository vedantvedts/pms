<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<style type="text/css">

.input-group-text{
font-weight: bold;
}

label{
	font-weight: 800;
	font-size: 16px;
	color:#07689f;
} 

hr{
	margin-top: -2px;
	margin-bottom: 12px;
}

b{
	font-family: 'Lato',sans-serif;
}

.select2-container {
	width: 300px !important;
}

.left {
	text-align: left;
}
.center{
	text-align: center;
}
.right{
	text-align: right;
}
.mandatory{
	color: red;
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
	<div class="container-fluid">
		<div class="row">
			<!-- <div class="col-md-2"></div> -->
			<div class="col-md-12">
				<div class="card shadow-nohover">
	  				<div class="card-header" style=" background-color: #055C9D;margin-top: ">
	                    <h3 class="text-white">Time Sheet Details</h3>
	        		</div>
	
					<div class="card-body">
						<form action="TimeSheetDetailsSubmit.htm" method="post">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<div class="form-group">
								<div class="row">
									<div class="col-md-1">
										<label class="form-label">Status<span class="mandatory">*</span></label>
									</div>
									<div class="col-md-2 left" style="margin-left: -3rem;">
										<select class="form-control" name="empStatus" style="width: 80%;" >
											<option value="" disabled="disabled" selected>--select--</option>
											<option>Present</option>
											<option>Leave</option>
											<option>TD</option>
											<option>General Holiday</option>
										</select>
									</div>
									<div class="col-md-1">
										<label class="form-label">Punch In<span class="mandatory">*</span></label>
									</div>
									<div class="col-md-2 left" style="margin-left: -3rem;">
										<input type="text" class="form-control punchInTime" name="punchInTime" id="punchInTime" style="width: fit-content;" >
									</div>
									<div class="col-md-1"><label class="form-label">Punch Out<span class="mandatory">*</span></label></div>
									<div class="col-md-2 left" style="margin-left: -3rem;">
										<input type="text" class="form-control punchOutTime" name="punchOutTime" id="punchOutTime" style="width: fit-content;" >
									</div>
								</div>	
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

<script type="text/javascript">
	$('#punchInTime').daterangepicker({
		singleDatePicker: true,
	    showDropdowns: true,
	    timePicker: true,
	    timePicker24Hour: true,
	    timePickerIncrement: 1,
	    autoUpdateInput: true,
	    locale: {
	      format: 'DD-MM-YYYY HH:mm:ss'
	    }
	});
	$('#punchOutTime').daterangepicker({
		singleDatePicker: true,
	    showDropdowns: true,
	    timePicker: true,
	    timePicker24Hour: true,
	    timePickerIncrement: 1,
	    autoUpdateInput: true,
	    minDate: $('#punchInTime').val(),
	    maxDate: $('#punchInTime').val(),
	    locale: {
	      format: 'DD-MM-YYYY HH:mm:ss'
	    }
	});
	
	$( "#punchInTime" ).change(function() {
		
		$('#punchOutTime').daterangepicker({
			singleDatePicker: true,
		    showDropdowns: true,
		    timePicker: true,
		    timePicker24Hour: true,
		    timePickerIncrement: 1,
		    autoUpdateInput: true,
		    minDate: $('#punchInTime').val(),
		    startDate: $('#punchInTime').val(),
		    maxDate: $('#punchInTime').val(),
		    locale: {
		      format: 'DD-MM-YYYY HH:mm:ss'
		    }
		});
		
	});
</script>	
</body>
</html>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>OFFICER MASTER EDIT</title>

</head>
<body>


	<%
	String ses = (String) request.getParameter("result");
	String ses1 = (String) request.getParameter("resultfail");
	if (ses1 != null) {
	%>


	<center>

		<div class="alert alert-danger" role="alert">
			<%=ses1%>
		</div>
	</center>
	<%
	}
	if (ses != null) {
	%>
	<center>
		<div class="alert alert-success" role="alert">
			<%=ses%>
		</div>

	</center>


	<%
	}
	%>



	<br>

	<div class="container-fluid">
		<div class="row">

			<div class="col-sm-12" style="top: 10px;">
				<div class="card shadow-nohover">
					<div class="card-header"
						style="background-color: #055C9D; margin-top:">
						<b class="text-white">Designation Add </b>
					</div>
					<div class="card-body">


						<form name="myfrm" action="DesignationAddSubmit.htm" id="addfrm"
							method="POST" autocomplete="off">

							<div class="row">
								<div class="col-sm-2"></div>
								<div class="col-md-3">
									<div class="form-group">
										<label>Designation Code: <span class="mandatory"
											style="color: red;">*</span></label> <input
											class="form-control form-control" type="text"
											name="desigcode" id="desigcode" required="required"
											maxlength="10" style="font-size: 15px;">
									</div>
								</div>

								<div class="col-md-3">
									<div class="form-group">
										<label>Designation :<span class="mandatory"
											style="color: red;">*</span>
										</label> <input class="form-control" type="text" name="designation"
											id="designation" required="required" maxlength="100"
											style="font-size: 15px; width: 80%;">
									</div>
								</div>

								<div class="col-md-3">
									<div class="form-group">
										<label>Limit :<span class="mandatory"
											style="color: red;">*</span></label> <input
											class="form-control form-control" type="number" name="limit"
											required="required" style="font-size: 15px; width: 80%;">
									</div>
								</div>
							</div>
							<div align="center">
								<button type="button" class="btn btn-sm submit"
									style="align-self: center;"
									onclick="Designationcheck('addfrm');">SUBMIT</button>
								<a class="btn  btn-sm  back" href="DesignationMaster.htm">BACK</a>
							</div>

							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>


</body>



<script type="text/javascript">
	function Designationcheck(frmid) {

		var desigcode = $('#desigcode').val();
		var designation = $('#designation').val();
		$.ajax({

			type : "GET",
			url : "DesignationAddCheck.htm",
			data : {

				dcode : desigcode.trim(),
				dname : designation.trim(),

			},
			datatype : 'json',
			success : function(result) {
				var ajaxresult = JSON.parse(result);
				var count = 0;
				if (ajaxresult[0] == 1) {
					alert('Designation Code Already Exists');
					count++;
				}
				if (ajaxresult[1] == 1) {
					alert('Designation Name Already Exists');
					count++;
				}

				if (count == 0) {

					var ret = confirm('Are you Sure To Submit ?');
					if (ret) {
						$('#' + frmid).submit();
					}
				}
			}
		});
	}
</script>


</html>
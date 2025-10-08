<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<spring:url value="/resources/css/admin/DesignationAdd.css" var="designationAdd" />
<link href="${designationAdd}" rel="stylesheet" />

<title>OFFICER MASTER EDIT</title>


</head>
<body>


	<% 
    String ses = (String) request.getParameter("result");
    String ses1 = (String) request.getParameter("resultfail");
    if (ses1 != null) { %>
    <div align="center">
        <div class="alert alert-danger" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses1) %>
        </div>
    </div>
<% }if (ses != null) { %>
    <div align="center">
        <div class="alert alert-success" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses) %>
        </div>
    </div>
<% } %>



	<br>

	<div class="container-fluid">
		<div class="row">

			<div class="col-sm-12 mt-3" >
				<div class="card shadow-nohover">
					<div class="card-header bg-header">
						<b class="text-white style1">Designation Add </b>
					</div>
					<div class="card-body">


						<form name="myfrm" action="DesignationAddSubmit.htm" id="addfrm"
							method="POST" autocomplete="off">

							<div class="row">
								<div class="col-md-2"></div>
								<div class="col-md-2">
									<div class="form-group">
										<label>Designation Code: <span class="mandatory">*</span></label> <input
											class="form-control form-control field-w80 description-input" type="text"
											name="desigcode" id="desigcode" required="required"
											maxlength="10" >
									</div>
								</div>

								<div class="col-md-2">
									<div class="form-group">
										<label>Designation :<span class="mandatory">*</span>
										</label> <input class="form-control field-w80 description-input" type="text" name="designation"
											id="designation" required="required" maxlength="100"
											>
									</div>
								</div>

								<div class="col-md-2">
									<div class="form-group">
										<label>Limit :<span class="mandatory">*</span></label> <input
											class="form-control field-w100 form-control numeric-only" type="number" name="limit"
											id="limit" required="required" >
									</div>
								</div>

								<div class="col-md-2">
									<div class="form-group">
										<label>Desig Cadre :<span class="mandatory">*</span></label> 
										<select class="form-control" name="desigCadre" id="desigCadre">
											<option value="DRDS">DRDS</option>
											<option value="DRTC">DRTC</option>
											<option value="Others">Others</option>
										</select>
									</div>
								</div>
								
								<div class="col-md-2"></div>
							</div>
							<div align="center">
								<button type="button" class="btn btn-sm submit" onclick="Designationcheck('addfrm');">SUBMIT</button>
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

		 var desigcode = $('#desigcode').val().trim();
		 var designation = $('#designation').val().trim();
		 var limit = $('#limit').val().trim();
		 var desigCadre = $('#desigCadre').val().trim();
		 
		   if (!desigcode) {
		        alert('Designation Code is required.');
		        return;
		    }

		    if (!designation) {
		        alert('Designation Name is required.');
		        return;
		    }
		    
		    if(!limit){
		    	alert('Limit is required');
		    	return;
		    }
		    
		    if(!desigCadre){
		    	alert('Desig Cadre is required');
		    	return;
		    }
		$.ajax({

			type : "GET",
			url : "DesignationAddCheck.htm",
			data : {

				dcode : desigcode,
				dname : designation,

			},
			datatype : 'json',
			success : function(result) {
				var ajaxresult = JSON.parse(result);
				 var messages = [];
				if (ajaxresult[0] == 1) {	
				   messages.push('Designation Code Already Exists');
				}
				if (ajaxresult[1] == 1) {
				   messages.push('Designation Name Already Exists');
				}

			    if (messages.length > 0) {
	                alert(messages.join('\n'));
	            } else {
	                var ret = confirm('Are you sure you want to submit?');
	                if (ret) {
	                    $('#' + frmid).submit();
	                }
	            }
			}
		});
	}
</script>


</html>